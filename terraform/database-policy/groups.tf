# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how they're
# used in security_policy_acme_db.tf.
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.

# Antrea Egress object used as the SNAT identity when acme pods leave the
# cluster to reach the VM-based database tier.
resource "nsxt_policy_group" "tierapp_egress" {
  display_name = "acme-egress"
  description  = "PLACEHOLDER criteria - verify against real NSX group. acme Antrea Egress."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "AntreaEgress"
      operator    = "EQUALS"
      value       = "acme-egress"
    }
  }
}

# VM-based database tier, matched by tag (scope "acme", tag "db").
resource "nsxt_policy_group" "tierapp_db" {
  display_name = "acme-db"
  description  = "PLACEHOLDER criteria - verify against real NSX group. acme database VMs."

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "acme|db"
    }
  }
}
