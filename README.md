## Databricks Multiple Workspace Repository Example

### Folder Structure
The repository is broken out into **four or more** subsections.
- **Common Infrastructure**: Databricks infrastucture that is common across all workspaces
    - Logging: Creation of the billable usage and audit logs
    - Unity Catalog: Creation of the Unity Catalog
&nbsp;

- **Common Modules: Account**: Reusable assets for account-level resources
    - Cloud Provider Credential: Asset to create the underlying credential
    - Cloud Provider Network: Asset to create the underlying network
    - Cloud Provider Storage: Asset to create the underlying storage
    - Metastore Assignment: Asset to assign the calling workspace to the metastore
    - Workspace Creation: Asset to create the workspace based on the outputs of the previous modules
 &nbsp;

- **Common Modules: Workspace**: Reusable assets for workspace-level resources
    - Cluster: Asset to create a cluster
    - Cluster Policy: Asset to create a cluster policy
    - Secrets: Asset to create a workspace specific secret
&nbsp;

- **Databricks: Environment Example**: Databricks workspaces per environment or other logical group
    - Cloud Provider: Subsection for cloud related assets from modules and environment specifics (e.g. network peering)
    - Databricks Account: Subsection for account related assets from modules and environment specifics (e.g. identitiy assignment)
    - Databricks Workspace: Subsection for workspace related assets from modules and enviornment specifics (e.g. repos, notebooks, etc.)

### Architecture Diagrams:
- [Full Multi-Workspace Architecture](https://github.com/JDBraun/dbx_mws_example/blob/main/reference_images/full_arch_multi_workspace_mono_repo.png)
- [Multi-Workspace Architecture](https://github.com/JDBraun/dbx_mws_example/blob/main/reference_images/multi_workspace_mono_repo.png)
- [Simple Multi-Workspace Architecture](https://github.com/JDBraun/dbx_mws_example/blob/main/reference_images/simple_multi_workspace_mono_repo.png)


### How to use:
- Create a .tfvars file based on the examples found in the tvfvars_examples page
- Terraform init
- Terraform plan
- Terraform apply

**Note**: Please raise a git issues with any problems or concerns.

### FAQ:
- "I get an Error: Please use a valid IAM role. What do I do?"
    - This occurs after the networking configured is finalized. This is due to a race condition between the IAM role and the logging of it to the Databricks endpoint. Please re-plan and apply and it will go through. It can be mitigated with a sleep condition.
- "What do I do with identities?". 
    - Identities should be integrated with SCIM. Once they are integrated with SCIM, reference them as data sources, similar to the identity assignment example. Then continue to assign permissions through the workspace provider.