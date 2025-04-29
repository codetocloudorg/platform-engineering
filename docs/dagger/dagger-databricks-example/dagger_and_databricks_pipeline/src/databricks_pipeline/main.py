import dagger
from dagger import dag, function, object_type


@object_type
class DatabricksPipeline:
    @function
    def databricks_asset_bundle_deploy(
        self,
        directory_arg: dagger.Directory,
        databricks_workspace_url: dagger.Secret,
        databricks_client_secret: dagger.Secret,
        databricks_client_id: dagger.Secret,
    ) -> dagger.Container:
        """Creates an Alpine container with Databricks CLI configured for OAuth M2M authentication"""

        profile_name = "dagger_oauth_profile"
        config_path = "/root/.databrickscfg"

        return (
            dag.container()
            .from_("alpine:latest")
            .with_mounted_directory("/mnt", directory_arg)
            .with_workdir("/mnt")
            .with_exec(["apk", "add", "--no-cache", "bash", "curl"])
            .with_exec([
                "sh", "-c",
                "curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh"
            ])
            .with_secret_variable("DATABRICKS_HOST", databricks_workspace_url)
            .with_secret_variable("DATABRICKS_CLIENT_SECRET", databricks_client_secret)
            .with_secret_variable("DATABRICKS_CLIENT_ID", databricks_client_id)
            .with_exec([
                "sh", "-c",
                f"""
                echo '[{profile_name}]' > {config_path} && \
                echo "host = $DATABRICKS_HOST" >> {config_path} && \
                echo "client_id = $DATABRICKS_CLIENT_ID" >> {config_path} && \
                echo "client_secret = $DATABRICKS_CLIENT_SECRET" >> {config_path}
                """
            ])
            .with_exec(["databricks", "bundle", "deploy", "-t", "dev", "--profile", profile_name])
        )


