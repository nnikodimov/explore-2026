# Regular DFW policy protecting the VM-based acme database tier. No container
# cluster association is needed here, so the combined resource (policy + inline
# rules) is used instead of the parent/rule split used for the ACNP.

resource "nsxt_policy_security_policy" "tierapp_db" {
  display_name = "acme-db_policy"
  description  = "acme-db policy"
  category     = "Application"
  stateful     = true
  tcp_strict   = true
  scope        = [nsxt_policy_group.tierapp_db.path]

  # Priority order matches the export's ascending sequenceNumber: the allow rule
  # (499999) is evaluated before the lockdown default-deny (749999).

  rule {
    display_name       = "allow_acme_egress_to_database"
    description        = "allow acme egress to database"
    action             = "ALLOW"
    direction          = "IN"
    source_groups      = [nsxt_policy_group.tierapp_egress.path]
    destination_groups = [nsxt_policy_group.tierapp_db.path]
    services           = [data.nsxt_policy_service.mysql.path]
  }

  rule {
    display_name = "lockdown_database"
    description  = "lockdown database"
    action       = "DROP"
    direction    = "IN"
  }

  lifecycle {
    create_before_destroy = true
  }
}
