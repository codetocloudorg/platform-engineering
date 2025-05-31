import dagger
from dagger import dag, field, function, object_type
import os
import json

@object_type
class UnitTestResult:
    result: str = field()
    success: str = field()

@object_type
class PrMetadataResult:
    pr_number: str = field()
    commit_id: str = field()

# needs to be list of ProposedCodeChanges - see https://docs.dagger.io/api/custom-types/
@object_type
class ProposedCodeChanges:
    path: str = field()
    line: str = field()
    change: str = field()

# same comment as above
@object_type
class GitHubPrSuggestionResults:
    body: str = field()
    comment_url: str = field()
    
@object_type
class AgentResponses:
    pr_metadata: PrMetadataResult = field()
    pr_suggestions: GitHubPrSuggestionResults = field()

@object_type
class DaggerHackathon:
    @function
    async def CreateStructuredResponse(
        self, 
        directory_arg: dagger.Directory, 
        response_to_structure: str,
        azure_api_key: dagger.Secret,
        azure_endpoint: str,
        azure_model: str
    ) -> ProposedCodeChanges:
        """Structure LLM Response"""

        command = [
            "python", "dagger-hackathon-pipeline/src/dagger_hackathon/structure_data.py",
            "--response", response_to_structure,
            "--endpoint", azure_endpoint,
            "--model", azure_model
        ]
        container = (
            dag.container()
            .from_("python:3.11")
            .with_mounted_directory("/app", directory_arg)
            .with_workdir("/app")
            .with_secret_variable("AZURE_OPENAI_API_KEY", azure_api_key)
            .with_exec(["pip", "install", "--upgrade", "pip"])
            .with_exec(["pip", "install", "openai==1.82.0", "pydantic==2.11.5"])  
            .with_exec(command)
        )

        output = await container.stdout()

        response_data = json.loads(output)

        output = ProposedCodeChanges(
            path=response_data["path"],
            line=response_data["line"],
            change=response_data["change"]
        )
        
        return output

    
    @function
    async def RunUnitTests(self, directory_arg: dagger.Directory) -> UnitTestResult:
        """Run all unit tests and return the results"""

        container = (
            dag.container()
            .from_("python:3.11")
            .with_mounted_directory("/app", directory_arg)
            .with_workdir("/app")
            .with_exec(["sh", "-c", "python -m unittest discover tests -v || true"])
        )
        
        result = await container.stderr()

        if "OK" in result:
            success = "true"
        else:
            success = "false"
        
        return UnitTestResult(result=result, success=success)
        
    @function
    async def GetPrMetadata(self, github_branch: str, github_repo: str, github_token: dagger.Secret) -> PrMetadataResult:
        """Get the PR number and commit ID"""

        base_container = (
            dag.container()
            .from_("alpine:latest")
            .with_secret_variable("GITHUB_TOKEN", github_token)
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
                "--head", f"{github_branch}",
                "--limit", "1",
                "--json", "number",
                "--jq", ".[0].number",
                "--repo", f"{github_repo}"
            ])
            .stdout()
        )

        commit_id = await (
            base_container
            .with_exec([
                "gh", "pr", "view",
                pr_number.strip(),
                "--json", "headRefOid",
                "-q", ".headRefOid",
                "--repo", f"{github_repo}"
            ])
            .stdout()
        )

        output = PrMetadataResult(pr_number=pr_number.strip(), commit_id=commit_id.strip())
        
        return output

    @function
    async def CreateCodeSuggestion(
        self, 
        directory_arg: dagger.Directory, 
        github_token: dagger.Secret, 
        pr_metadata: PrMetadataResult, 
        proposed_code_changes: ProposedCodeChanges,
        ) -> GitHubPrSuggestionResults:
        """Create a code suggestion for a PR"""

        container = (
            dag.container()
            .from_("alpine:latest")
            .with_secret_variable("GITHUB_TOKEN", github_token)
            .with_exec(["apk", "add", "--no-cache", "curl", "bash", "git", "openssl"])
            .with_exec([
                "sh", "-c",
                (
                    "curl -fsSL https://github.com/cli/cli/releases/download/v2.70.0/gh_2.70.0_linux_amd64.tar.gz "
                    "| tar -xz && mv gh_2.70.0_linux_amd64/bin/gh /usr/local/bin/"
                )
            ])
            .with_exec([
                "gh", "api",
                "--method", "POST",
                "-H", "Accept: application/vnd.github+json",
                "-H", "X-GitHub-Api-Version: 2022-11-28",
                f"/repos/codetocloudorg/platform-engineering/pulls/{pr_metadata.pr_number}/comments",
                "-f", f"body=```suggestion\n{proposed_code_changes.change}\n```",
                "-f", f"commit_id={pr_metadata.commit_id}",
                "-f", f"path={proposed_code_changes.path}",
                "-F", f"line={proposed_code_changes.line}",
                "-f", "side=RIGHT"
            ])
        )

        output = await container.stdout()

        response_data = json.loads(output)

        output = GitHubPrSuggestionResults(
            body=response_data["body"],
            comment_url=response_data["html_url"]
        )

        return output

    @function
    async def DebugUnitTestAgent(
        self, 
        directory_arg: dagger.Directory, 
        github_branch: str, 
        github_repo: str, 
        github_token: dagger.Secret,
        azure_api_key: dagger.Secret,
        azure_endpoint: str,
        azure_model: str
        ) -> str:
        """Debug the unit test agent"""

        pr_metadata = await self.GetPrMetadata(github_branch, github_repo, github_token)

        unit_test_results = await self.RunUnitTests(directory_arg)

        if unit_test_results.success == "true":
            return f"All unit tests passed - no code changes needed"
        
        environment = (
            dag.env()
            .with_string_input("unit_test_results", str(unit_test_results), "the unit test results to analyze")
            .with_container_input(
                "unit_test_runner",
                dag.container()
                .from_("python:3.11")
                .with_mounted_directory("/app", directory_arg)
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
            .with_prompt_file(dag.current_module().source().file("test_debug_prompt.txt"))
        )

        proposed_code_changes = await self.CreateStructuredResponse(directory_arg, await analyze_results.last_reply(), azure_api_key, azure_endpoint, azure_model)
                
        # proposed_code_changes = ProposedCodeChanges(
        #     path="docs/dagger/dagger-hackathon/src/addition.py",
        #     line="2",
        #     change="return a + b"
        # )

        created_pr_suggestions = await self.CreateCodeSuggestion(directory_arg, github_token, pr_metadata, proposed_code_changes)

        return str(created_pr_suggestions)
        