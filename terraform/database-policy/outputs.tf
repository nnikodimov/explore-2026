output "tierapp_db_policy_path" {
  description = "NSX policy path of the acme-db DFW security policy"
  value       = nsxt_policy_security_policy.tierapp_db.path
}
