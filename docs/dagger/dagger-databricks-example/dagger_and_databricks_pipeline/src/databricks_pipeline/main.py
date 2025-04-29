import dagger
from dagger import dag, function, object_type


@object_type
class DatabricksPipeline:
    @function
    def databricks_cli_container(
        self, 
        directory_arg: dagger.Directory, 
        databricks_workspace_url: dagger.Secret,
        ) -> dagger.Container:
        """Creates an Alpine container with Databricks CLI installed via curl installer"""
        return (
            dag.container()
            .from_("alpine:latest")
            .with_mounted_directory("/mnt", directory_arg)
            .with_workdir("/mnt")
            .with_secret_variable("DATABRICKS_HOST", databricks_workspace_url)
            .with_secret_variable("ARM_CLIENT_SECRET", client_secret)
            .with_exec(["apk", "add", "--no-cache", "bash", "curl"])
            .with_exec([
                "sh", "-c",
                "curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh"
            ])
            .with_exec(["databricks", "bundle", "deploy", "-t", "dev"])
        )