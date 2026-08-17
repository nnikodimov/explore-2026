# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these 5 groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how they're
# used in the rules (security_policy_3tierapp.tf / security_policy_3tierapp_db.tf).
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.

# Whole "3tierapp" Kubernetes namespace - used as the ANTREA policy's default-deny scope.
resource "nsxt_policy_group" "tierapp_ns" {
  display_name = "3tierapp-ns"
  description  = "PLACEHOLDER criteria - verify against real NSX group. All members of the 3tierapp Kubernetes namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "3tierapp"
    }
  }
}

# Frontend Kubernetes Service in the 3tierapp namespace.
resource "nsxt_policy_group" "tierapp_frontend_svc" {
  display_name = "3tierapp-frontend-svc"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp frontend Service."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Service"
      operator    = "EQUALS"
      value       = "frontend"
    }
  }
}

# Backend Kubernetes Service in the 3tierapp namespace.
resource "nsxt_policy_group" "tierapp_backend" {
  display_name = "3tierapp-backend"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp backend Service."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Service"
      operator    = "EQUALS"
      value       = "backend"
    }
  }
}

# Antrea Egress object used as the SNAT identity when 3tierapp pods leave the
# cluster to reach the VM-based database tier.
resource "nsxt_policy_group" "tierapp_egress" {
  display_name = "3tierapp-egress"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp Antrea Egress."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "AntreaEgress"
      operator    = "EQUALS"
      value       = "3tierapp-egress"
    }
  }
}

# VM-based database tier, matched by tag (scope "3tierapp", tag "db").
resource "nsxt_policy_group" "tierapp_db" {
  display_name = "3tierapp-db"
  description  = "PLACEHOLDER criteria - verify against real NSX group. 3tierapp database VMs."

  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "3tierapp|db"
    }
  }
}
