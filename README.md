## Databricks Multiple Workspace Repository Example

### Folder Structure - Modules:
- **Common Modules: Cloud Provider**: Reusable modules for underlying cloud resources related to a workspace.
    - Cloud Provider Credential: Module to create the underlying cross-account role
    - Cloud Provider Network: Module to create the underlying network (VPC, subnet, security groups, etc.)
    - Cloud Provider Storage: Module to create the underlying workspace root bucket
 &nbsp;

- **Common Modules: Account**: Reusable modules for account-level resources
    - Metastore Assignment: Module to assign the calling workspace to the metastore
    - Workspace Creation: Module to create the workspace based on the outputs of the previous modules
    - Identity assignment: Module to assign users and groups to the workspace
 &nbsp;

- **Common Modules: Workspace**: Reusable modules for workspace-level resources
    - Workspace Catalog: Module to create a catalog, and underlying cloud resources, isolated to the individual workspace
    - Cluster Policy: Module to create a parameterized cluster policy per environment
    - Workspace Confs: Module to create consistent workspace configurations across workspace
&nbsp;

### Folder Structure - Individual Pipelines:
- **Common Infrastructure/Unity Catalog**: 
    - Creation of the Unity Catalog metastore with no root storage, isolating it from other environments
&nbsp;

- **Common Infrastructure/Logging**: 
    - Creation of logging resources and underlying cloud resources.
&nbsp;

- **Environments:.**: 
    - Development: Creation of cloud and Databricks Resources for a development environment.
    - QA: Creation of cloud and Databricks Resources for a QA environment.
    - Production: Creation of cloud and Databricks Resources for a production environment.
&nbsp;

### How to set-up:
- Create a .tfvars file based on the examples found in the tfvars_example folder.
   - **Recommended**: Set environment variables for your AWS and Databricks credentials
- Perform the following steps in: **common_infrastructure/unity_catalog**, **common_infrastructure/logging**, **databricks_dev**, **databricks_qa**, and **databricks_qa**
   - *Add the required .tfvars file*
   - Terraform init
   - Terraform plan
   - Terraform apply

**Note**: Please raise a git issues with any problems or concerns about the repo.

### Architecture Diagrams:
- [Full Multi-Workspace Architecture](https://github.com/JDBraun/dbx_mws_example/blob/main/reference_images/full_arch_multi_workspace_mono_repo.png)
- [Multi-Workspace Architecture](https://github.com/JDBraun/dbx_mws_example/blob/main/reference_images/multi_workspace_mono_repo.png)
- [Simple Multi-Workspace Architecture](https://github.com/JDBraun/dbx_mws_example/blob/main/reference_images/simple_multi_workspace_mono_repo.png)

### FAQ:
- **"I get an Error: Please use a valid IAM role. What do I do?"**
    - This occurs after the networking configured is finalized. This is due to a race condition between the IAM role and the logging of it to the Databricks endpoint. Please re-plan and apply and it will go through. It can be mitigated with a sleep condition.

- **"What do I do with identities?"**. 
    - Identities should be integrated with SCIM. Once they are integrated with SCIM, reference them as data sources, similar to the identity assignment example. Then continue to assign permissions through the workspace provider.