# MySQL is a built-in NSX system service (like the default DFW sections we
# intentionally don't manage here) - looked up rather than recreated.
data "nsxt_policy_service" "mysql" {
  display_name = "MySQL"
}

# The Antrea/Kubernetes cluster the 3tierapp ACNP is bound to. Looked up by ID
# rather than display_name since the export only gives us NSX's internal path.
data "nsxt_policy_container_cluster" "tierapp" {
  id = var.antrea_cluster_id
}
