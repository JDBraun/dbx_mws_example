module "uc_catalog" {
  source = "../../common_modules_workspace/uc_workspace_catalog"

  databricks_account_id   = var.databricks_account_id
  aws_account_id          = var.aws_account_id
  resource_prefix         = var.resource_prefix
  uc_catalog_name         = "${var.resource_prefix}-catalog-${var.workspace_id}"
  workspace_id            = var.workspace_id
  workspace_catalog_admin = var.workspace_catalog_admin
  
}

module "dev_compute_policy" {
  source = "../../common_modules_workspace/cluster_policy"
  team   = var.team
  policy_overrides = {
    "spark_conf.spark.databricks.io.cache.enabled" : {
      "type" : "fixed",
      "value" : "true"
    },
  }
}

module "workspace_config" {
  source = "../../common_modules_workspace/workspace_confs"
}