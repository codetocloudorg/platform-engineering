import dagger
from dagger import dag, function, object_type
import os


@object_type
class DaggerHackathon:
    @function
    async def UnitTest(self, directory_arg: dagger.Directory) -> str:
        """Run unit tests and return results with detailed output"""
        try:
            container = (
                dag.container()
                .from_("python:3.11")
                .with_mounted_directory("/app", directory_arg)
                .with_workdir("/app")
                .with_exec(["sh", "-c", "python -m unittest discover tests -v || true"])
            )
            
            stdout = await container.stdout()
            stderr = await container.stderr()
            
            output = f"Test Output:\n{stdout}\n"
            if stderr:
                output += f"\nError Output:\n{stderr}\n"
            
            return output
            
        except Exception as e:
            return f"Error running tests: {str(e)}"

    @function
    async def DebugUnitTest(self, directory_arg: dagger.Directory, github_token: dagger.Secret) -> str:
        """Run unit tests and return code suggestions to fix failures"""
        # Get unit test results
        test_results = await self.UnitTest(directory_arg)
        
        # Check for test failures in the output
        if "FAILED" not in test_results and "ERROR" not in test_results:
            return "No code changes needed - all tests passed"
        
        # Create environment with test results and source code
        environment = (
            dag.env()
            .with_string_input("test_results", test_results, "the unit test results to analyze")
            .with_container_input(
                "test_runner",
                dag.container()
                .from_("python:3.11")
                .with_mounted_directory("/app", directory_arg)
                .with_workdir("/app"),
                "a container with the test environment and source code"
            )
            .with_container_output(
                "completed", "the suggested code changes to fix the failing tests"
            )
        )

        # Use LLM to analyze the test results and generate code suggestions
        analyze_results = (
            dag.llm()
            .with_env(environment)
            .with_prompt_file(dag.current_module().source().file("test_debug_prompt.txt"))
        )

        await self.AddSuggestionPr(directory_arg, github_token, await analyze_results.last_reply())
        
        return await analyze_results.last_reply()

    @function
    async def AddSuggestionPr(self, directory_arg: dagger.Directory, github_token: dagger.Secret, suggestion: str):
        """Run tests, get LLM suggestions, and add them to PR"""
        
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
                "sh", "-c",
                "echo 'Debug - GitHub CLI installed, about to authenticate'"
            ])
            .with_exec([
                "gh", "auth", "login", "--with-token"
            ])
            .with_exec([
                "sh", "-c",
                "echo 'Debug - Authenticated, about to make API call'"
            ])
            .with_exec([
                "gh", "api",
                "--method", "POST",
                "-H", "Accept: application/vnd.github+json",
                "-H", "X-GitHub-Api-Version: 2022-11-28",
                "/repos/codetocloudorg/platform-engineering/pulls/75/comments",
                "-f", f"body=```suggestion\n{suggestion}\n```",
                "-f", "commit_id=2e39001f118c95593ac90c1361b3dd770eaaeeaa",
                "-f", "path=docs/dagger/dagger-hackathon/src/addition.py",
                "-F", "line=2",
                "-f", "side=RIGHT"
            ])
        )

        # Get and log the API response
        response = await container.stdout()
        debug_container = (
            dag.container()
            .from_("alpine:latest")
            .with_exec(["sh", "-c", f'echo "Debug - GitHub API response: {response}"'])
        )
        await debug_container.stdout()
        
        return response
