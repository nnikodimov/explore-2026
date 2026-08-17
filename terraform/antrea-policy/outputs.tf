output "allow_alpha_frontend_path" {
  description = "NSX policy path of the allow_alpha_frontend rule"
  value       = nsxt_policy_security_policy_rule.allow_alpha_frontend.path
}

output "allow_alpha_frontend_to_backend_path" {
  description = "NSX policy path of the allow_alpha_frontend_to_backend rule"
  value       = nsxt_policy_security_policy_rule.allow_alpha_frontend_to_backend.path
}
