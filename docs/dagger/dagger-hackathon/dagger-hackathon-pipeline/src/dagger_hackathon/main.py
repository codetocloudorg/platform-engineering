import dagger
import json
from dagger import dag, field, function, object_type, DefaultPath
from typing import Annotated

@object_type
class UnitTestResults:
    result: str = field()
    success: str = field()

@object_type
class PrMetadataResult:
    pr_number: str = field()
    commit_id: str = field()

@object_type
class ProposedCodeChange:
    path: str = field()
    line: str = field()
    change: str = field()

# same comment as above
@object_type
class GitHubPrSuggestionResult:
    body: str = field()
    comment_url: str = field()
    
@object_type
class AgentResponse:
    pr_metadata: PrMetadataResult = field()
    pr_suggestions: GitHubPrSuggestionResult = field()

@object_type
class DaggerHackathon:
    source: dagger.Directory
    github_branch: str
    github_repo: str
    github_token: dagger.Secret
    azure_openai_api_key: dagger.Secret # use in azure_xxx in StructureLlmResponse with AzureOpenAI library
    azure_openai_endpoint: str
    azure_openai_model: str = "gpt-4o"
    @function
    async def GetPrMetadata(self) -> PrMetadataResult:
        """Get the PR number and commit ID
        Returns:
            PrMetadataResult
        """

        base_container = (
            dag.container()
            .from_("alpine:latest")
            .with_secret_variable("GITHUB_TOKEN", self.github_token)
            .with_exec(["apk", "add", "--no-cache", "curl", "bash", "git", "openssl"])
            .with_exec([
                "sh", "-c",
                (
                    "curl -fsSL https://github.com/cli/cli/releases/download/v2.70.0/gh_2.70.0_linux_amd64.tar.gz "
                    "| tar -xz && mv gh_2.70.0_linux_amd64/bin/gh /usr/local/bin/"
                )
            ])
        )

        pr_number = await (
            base_container
            .with_exec([
                "gh", "pr", "list",
                "--head", f"{self.github_branch}",
                "--limit", "1",
                "--json", "number",
                "--jq", ".[].number",
                "--repo", f"{self.github_repo}"
            ])
            .stdout()
        )

        commit_logs = await (
            base_container
            .with_exec([
                "gh", "pr", "view",
                pr_number.strip(),
                "--json", "commits",
                "--repo", f"{self.github_repo}"
            ])
            .stdout()
        )

        commit_logs_json = json.loads(commit_logs)

        head_commit_id = commit_logs_json["commits"][-1]["oid"]
        
        return PrMetadataResult(pr_number=pr_number.strip(), commit_id=head_commit_id.strip())

    @function
    async def RunUnitTests(self) -> UnitTestResults:
        """Run all unit tests and return the results
        Returns:
            UnitTestResults
        """

        container = (
            dag.container()
            .from_("python:3.11")
            .with_mounted_directory("/src", self.source)
            .with_workdir("/src")
            .with_exec(["sh", "-c", "python -m unittest discover tests -v || true"])
        )
        
        unit_test_results = await container.stderr()

        if "OK" in unit_test_results:
            success = "true"
        else:
            success = "false"
        
        return UnitTestResults(result=unit_test_results, success=success)

    @function
    async def StructureLlmResponse(
        self,
        response_to_structure: str
    ) -> ProposedCodeChange:
        """Structure LLM Response
        Args:
            response_to_structure: LLM response to structure
        Returns:
            ProposedCodeChange
        """

        command_to_execute = [
            "python", "dagger-hackathon-pipeline/src/dagger_hackathon/structure_llm_response.py",
            "--response", response_to_structure,
            "--endpoint", self.azure_openai_endpoint,
            "--model", self.azure_openai_model
        ]
        container = (
            dag.container()
            .from_("python:3.11")
            .with_mounted_directory("/app", self.source)
            .with_workdir("/app")
            .with_secret_variable("AZURE_OPENAI_API_KEY", self.azure_openai_api_key)
            .with_exec(["pip", "install", "--upgrade", "pip"])
            .with_exec(["pip", "install", "openai==1.82.0", "pydantic==2.11.5"])  
            .with_exec(["sh", "-c", "export $(grep -v '^#' .env | xargs)"])
            .with_exec(command_to_execute)
        )

        structured_results = await container.stdout()

        structured_results_json = json.loads(structured_results)
        
        return ProposedCodeChange(
            path=structured_results_json["path"],
            line=structured_results_json["line"],
            change=structured_results_json["change"]
        )

    @function
    async def CreatePrSuggestion(
        self, 
        pr_metadata: PrMetadataResult, 
        proposed_code_changes: ProposedCodeChange,
        ) -> GitHubPrSuggestionResult:
        """Create a code suggestion for a PR
        Args:
            pr_metadata: PR Metadata
            proposed_code_changes: Proposed Code Changes
        Returns:
            GitHubPrSuggestionResult
        """

        command_to_execute = [
            "gh", "api",
            "--method", "POST",
            "-H", "Accept: application/vnd.github+json",
            "-H", "X-GitHub-Api-Version: 2022-11-28",
            f"/repos/{self.github_repo}/pulls/{pr_metadata.pr_number}/comments",
            "-f", f"body=```suggestion\n{proposed_code_changes.change}\n```",
            "-f", f"commit_id={pr_metadata.commit_id}",
            "-f", f"path={proposed_code_changes.path}",
            "-F", f"line={proposed_code_changes.line}",
            "-f", "side=RIGHT"
            ]

        container = (
            dag.container()
            .from_("alpine:latest")
            .with_secret_variable("GITHUB_TOKEN", self.github_token)
            .with_exec(["apk", "add", "--no-cache", "curl", "bash", "git", "openssl"])
            .with_exec([
                "sh", "-c",
                (
                    "curl -fsSL https://github.com/cli/cli/releases/download/v2.70.0/gh_2.70.0_linux_amd64.tar.gz "
                    "| tar -xz && mv gh_2.70.0_linux_amd64/bin/gh /usr/local/bin/"
                )
            ])
            .with_exec(command_to_execute)
        )

        pr_comment_logs = await container.stdout()

        pr_comment_logs_json = json.loads(pr_comment_logs)

        return GitHubPrSuggestionResult(
            body=pr_comment_logs_json["body"],
            comment_url=pr_comment_logs_json["html_url"]
        )

    @function
    async def FixMyTestsAgent(
        self
        ) -> str:
        """Orchestrator Agent to Debug Unit Tests
        Returns:
            AgentResponse
        """

        pr_metadata = await self.GetPrMetadata()

        unit_test_results = await self.RunUnitTests()

        if unit_test_results.success == "true":
            return f"All unit tests passed - no code changes needed"
        
        environment = (
            dag.env()
            .with_string_input("unit_test_results", str(unit_test_results), "the unit test results to analyze")
            .with_container_input(
                "unit_test_runner",
                dag.container()
                .from_("python:3.11")
                .with_mounted_directory("/app", self.source)
                .with_workdir("/app"),
                "a container used to troubleshoot failing unit tests"
            )
            .with_container_output(
                "completed", "the completed assignment in the unit test container"
            )
        )

        analyze_results = (
            dag.llm()
            .with_env(environment)
            .with_prompt_file(dag.current_module().source().file("debug_unit_test_prompt.md"))
        )

        proposed_code_change = await self.StructureLlmResponse(
            await analyze_results.last_reply()
        )

        created_pr_suggestion = await self.CreatePrSuggestion(
            pr_metadata, 
            proposed_code_change
        )

        return str(AgentResponse(
            pr_metadata=pr_metadata,
            pr_suggestions=created_pr_suggestion
        ))
        
