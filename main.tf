# Both modules inherit the single nsxt provider instance configured in
# provider.tf - neither declares its own provider block.

module "antrea_policy" {
  source = "./antrea-policy"

  antrea_cluster_id = var.antrea_cluster_id
}

module "database_policy" {
  source = "./database-policy"
}
