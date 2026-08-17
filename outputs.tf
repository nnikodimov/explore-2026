output "tierapp_policy_path" {
  description = "NSX policy path of the 3tierapp ACNP (Antrea) security policy"
  value       = module.antrea_policy.tierapp_policy_path
}

output "tierapp_container_cluster_span_path" {
  description = "NSX policy path of the 3tierapp_policy <-> Antrea cluster association"
  value       = module.antrea_policy.tierapp_container_cluster_span_path
}

output "tierapp_db_policy_path" {
  description = "NSX policy path of the 3tierapp-db DFW security policy"
  value       = module.database_policy.tierapp_db_policy_path
}
