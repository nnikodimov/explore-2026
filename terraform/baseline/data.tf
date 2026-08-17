# The Antrea/Kubernetes cluster the alpha ACNP is bound to. Looked up by ID
# rather than display_name since the export only gives us NSX's internal path.
data "nsxt_policy_container_cluster" "tierapp" {
  id = var.antrea_cluster_id
}
