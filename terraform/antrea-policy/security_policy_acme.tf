# ACNP ALLOW rules for the acme cluster, amended onto the parent policy
# created in ../baseline (which also owns the lockdown DROP rule and the
# Antrea cluster attachment).
#
# Priority order below matches the export's ascending sequenceNumber (lower =
# higher priority, evaluated first): allow_acme_frontend (249999),
# allow_acme_frontend_to_backend (374999). The lockdown_acme_namespace DROP
# rule (499999) lives in ../baseline.

resource "nsxt_policy_security_policy_rule" "allow_acme_frontend" {
  display_name    = "allow_acme_frontend"
  description     = "allow acme frontend"
  policy_path     = var.policy_path
  sequence_number = 1
  action          = "ALLOW"
  direction       = "IN"
  scope           = [nsxt_policy_group.tierapp_frontend_svc.path]

  service_entries {
    l4_port_set_entry {
      protocol          = "TCP"
      destination_ports = ["5000"]
    }
  }
}

resource "nsxt_policy_security_policy_rule" "allow_acme_frontend_to_backend" {
  display_name    = "allow_acme_frontend_to_backend"
  description     = "allow acme frontend to backend"
  policy_path     = var.policy_path
  sequence_number = 2
  action          = "ALLOW"
  direction       = "IN"
  source_groups   = [nsxt_policy_group.tierapp_frontend_svc.path]
  scope           = [nsxt_policy_group.tierapp_backend.path]

  service_entries {
    l4_port_set_entry {
      protocol          = "TCP"
      destination_ports = ["5000"]
    }
  }
}
