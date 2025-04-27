# Continuous Integration / Continuous Deployment (CI/CD) for Infrastructure as Code (IaC)
The goal of this `README` and accompanying code is demonstrate how to automate Terraform (IaC tool) using GitHub Actions (CI/CD) to create an Azure Storage Account. 

**Note: You could easily modify the Terraform script to deploy infrastructure across any cloud provider. For the purpose of this example, I am using Azure.**

##### Future Items
- Example using OpenTofu as IaC-tool
- Use of security scanning tools overtop CI/CD
- Example of policy enforcement around IaC within CI/CD

### Requirements
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Azure Account](https://azure.microsoft.com/en-ca/pricing/purchase-options/azure-account/search?ef_id=_k_CjwKCAjw47i_BhBTEiwAaJfPpmzhysAnqrU8neEUB4CQmlW2VhNyXOQYkXixWUND6U0MUzjFoRyQ2xoCBOIQAvD_BwE_k_&OCID=AIDcmmqz3gd78m_SEM__k_CjwKCAjw47i_BhBTEiwAaJfPpmzhysAnqrU8neEUB4CQmlW2VhNyXOQYkXixWUND6U0MUzjFoRyQ2xoCBOIQAvD_BwE_k_&gad_source=1&gbraid=0AAAAADcJh_sW1lmt2nNCcqX29QvQ3xpes&gclid=CjwKCAjw47i_BhBTEiwAaJfPpmzhysAnqrU8neEUB4CQmlW2VhNyXOQYkXixWUND6U0MUzjFoRyQ2xoCBOIQAvD_BwE)
- Development environment, I am using VSCode as it has best in class extensions for GitHub and Azure
- GitHub - fork this repo (or clone and grab required files)

### Relevant Files/Paths
- `.github/workflows/terraform-orchestrator.yml`
- `docs/terraform`

### How to Run
1. Login to Azure with
   <br>
   `az login` - it will open a browser
2. Create a Resource Group
   <br>
   `az group create --name "<NAME>" --location "West US"`
3. Get SubscriptionId of Resource Group
   <br>
   `az account list --output table` 
4. Create a Service Principal
   <br>
   `az ad sp create-for-rbac --name "<NAME>" --role Contributor --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP_NAME>`
   <br>
   Make sure to save the credentials that are shown after the creation - DO NOT COMMIT TO VERSION CONTROL!
5. Create [GitHub Secrets](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions) for the following:
   <br>
   ```
   ARM_CLIENT_ID = appId in step4
   ARM_CLIENT_SECRET = password in step4
   ARM_SUBSCRIPTION_ID
   ARM_TENANT_ID = tenant in step4
   ```
6. Modify `resource` section of `docs/terraform/main.tf` - use the resource group name you created in step2 and give the storage account a name
7. Push code up to your repository
8. Since the `terraform-orchestrator.yml` is setup to be run as a workflow dispatch (i.e. gui) it needs to be merged to main to see the option under the Actions tab in the GitHub portal. Once this is done you will see something like below and can launch the job.
![image](https://github.com/user-attachments/assets/333004fd-c5af-4084-b34f-1a981e765879)
9. Navigate to the Azure Portal and confirm the Resource Group created in step2 contains the new storage account

### Some Details
- `main.tf`- this file defines the Terraform. In this case it says to create an Azure Storage Account. This could contain additional infrastructure to create or could call other `.tf` files to chain together a bunch of work. Refer to [hashicorp](https://developer.hashicorp.com/terraform/language/functions/templatefile) for templates and syntax
- `terraform-orchestrator.yml` - this is the GitHub action workflow to run our Terraform and create the Azure Storage Account. The key commands here are `terraform plan` and `terraform apply -auto-approve`. If the plan fails then apply does not go ahead. 



 
