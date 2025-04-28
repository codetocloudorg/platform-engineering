import dagger
from dagger import dag, function, object_type

@object_type
class AgentExample:
    """
    Dagger object representing an example agent that can:
    - Comment on a GitHub pull request.
    - Execute a Terraform job in a containerized environment and analyze its output.
    """

    async def comment_on_pr(
        self,
        repo: str,
        comment_body: str,
        github_token: dagger.Secret,
    ) -> str:
        """
        Comments on the latest pull request authored by the authenticated user in the specified GitHub repository.

        Args:
            repo (str): The GitHub repository in the format 'owner/repo'.
            comment_body (str): The text content of the comment to post.
            github_token (dagger.Secret): GitHub personal access token with repo permissions.

        Returns:
            str: The standard output from the container after commenting.
        """
        container = (
            dag.container()
            .from_("alpine:latest")
            .with_secret_variable("GITHUB_TOKEN", github_token)
            # Install required tools
            .with_exec(["apk", "add", "--no-cache", "curl", "bash", "git", "openssl"])
            # Download and install GitHub CLI (gh)
            .with_exec([
                "sh", "-c",
                (
                    "curl -fsSL https://github.com/cli/cli/releases/download/v2.70.0/gh_2.70.0_linux_amd64.tar.gz "
                    "| tar -xz && mv gh_2.70.0_linux_amd64/bin/gh /usr/local/bin/"
                )
            ])
            # Clone the specified GitHub repository
            .with_exec(["git", "clone", f"https://github.com/{repo}.git"])
            # Set the working directory to the cloned repo
            .with_workdir(repo.split("/")[-1])
            # Create a temporary markdown file with the comment
            .with_new_file("/tmp/comment.md", contents=comment_body)
            # Post a comment on the latest PR authored by the user
            .with_exec([
                "sh", "-c",
                (
                    "PR_NUMBER=$(gh pr list --author \"@me\" --limit 1 --json number --jq '.[0].number') && "
                    f"gh pr comment $PR_NUMBER --body-file /tmp/comment.md --repo {repo}"
                )
            ])
        )

        # Return container output (e.g., result or logs)
        return await container.stdout()

    @function
    async def terraform_agent(
        self,
        assignment: str,
        directory_arg: dagger.Directory,
        client_id: dagger.Secret,
        client_secret: dagger.Secret,
        subscription_id: dagger.Secret,
        tenant_id: dagger.Secret,
        github_token: dagger.Secret
    ) -> str:
        """
        Executes a Terraform job using credentials and a directory of Terraform configurations,
        then comments the AI-analyzed result on a GitHub PR.

        Args:
            assignment (str): Description or title of the assignment.
            directory_arg (dagger.Directory): Directory containing the Terraform configuration.
            client_id (dagger.Secret): Azure client ID for Terraform.
            client_secret (dagger.Secret): Azure client secret for Terraform.
            subscription_id (dagger.Secret): Azure subscription ID for Terraform.
            tenant_id (dagger.Secret): Azure tenant ID for Terraform.
            github_token (dagger.Secret): GitHub token for posting the comment.

        Returns:
            str: The final analyzed result of the Terraform job.
        """
        # Set up the environment for Terraform execution
        environment = (
            dag.env()
            .with_string_input("assignment", assignment, "the assignment to complete")
            .with_container_input(
                "terraform_runner",
                dag.container()
                    .from_("hashicorp/terraform:1.11")
                    .with_mounted_directory("/mnt", directory_arg)
                    .with_workdir("/mnt")
                    .with_secret_variable("ARM_CLIENT_ID", client_id)
                    .with_secret_variable("ARM_CLIENT_SECRET", client_secret)
                    .with_secret_variable("ARM_SUBSCRIPTION_ID", subscription_id)
                    .with_secret_variable("ARM_TENANT_ID", tenant_id)
                    # Initialize and plan Terraform configuration
                    .with_exec(["terraform", "init"])
                    .with_exec(["terraform", "plan"]),
                "a container to use for running the terraform init & plan"
            )
            .with_container_output(
                "completed", "the completed assignment in the Terraform container"
            )
        )

        # Use an LLM to analyze the Terraform results
        analyze_results = (
            dag.llm()
            .with_env(environment)
            .with_prompt_file(dag.current_module().source().file("terraformer_prompt.txt"))
        )

        # Comment the LLM's last reply on a GitHub pull request
        await self.comment_on_pr("codetocloudorg/platform-engineering", await analyze_results.last_reply(), github_token)

        # Return the analyzed result
        return await analyze_results.last_reply()