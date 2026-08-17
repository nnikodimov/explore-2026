output "tierapp_policy_path" {
  description = "NSX policy path of the 3tierapp ACNP (Antrea) security policy"
  value       = nsxt_policy_parent_security_policy.tierapp.path
}

output "tierapp_container_cluster_span_path" {
  description = "NSX policy path of the 3tierapp_policy <-> Antrea cluster association"
  value       = nsxt_policy_security_policy_container_cluster.tierapp.path
}

output "tierapp_db_policy_path" {
  description = "NSX policy path of the 3tierapp-db DFW security policy"
  value       = nsxt_policy_security_policy.tierapp_db.path
}
