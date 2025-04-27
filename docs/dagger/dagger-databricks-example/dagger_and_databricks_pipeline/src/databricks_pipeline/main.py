import dagger
from dagger import dag, function, object_type


@object_type
class DatabricksPipeline:
    @function
    def databricks_cli_container(self) -> dagger.Container:
        """Creates an Alpine container with Databricks CLI installed via curl installer"""
        return (
            dag.container()
            .from_("alpine:latest")
            .with_exec(["apk", "add", "--no-cache", "bash", "curl"])
            .with_exec([
                "sh", "-c",
                "curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh"
            ])
        )