# How to run this using Dagger

## Prerequisites

- Databricks Workspace

1. Clone this repo
2. Configure a [service principal](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/auth/oauth-m2m#prerequisite-create-a-service-principal) in databricks
3. Generate a [secret](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/auth/oauth-m2m#step-2-create-an-oauth-secret-for-a-service-principal) for the service principal
4. Set the following environment variables:

```pwsh
$ENV:DATABRICKS_HOST = "https://databricks_url.net"
$ENV:DATABRICKS_CLIENT_SECRET = "databricks_service_principal_secret"
$ENV:DATABRICKS_CLIENT_ID = "databricks_client_id"
```

5. `cd` into this directory and run `dagger call databricks-asset-bundle-deploy --directory_arg=./databricks_asset_bundle --databricks-client-id "DATABRICKS_CLIENT_ID" --databricks-client-secret "DATABRICKS_CLIENT_SECRET" --databricks-workspace-url "DATABRICKS_HOST"`
