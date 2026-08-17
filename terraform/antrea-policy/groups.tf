# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how they're
# used in security_policy_acme.tf.
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.

# Whole "acme" Kubernetes namespace - used as the ANTREA policy's default-deny scope.
resource "nsxt_policy_group" "tierapp_ns" {
  display_name = "acme-ns"
  description  = "PLACEHOLDER criteria - verify against real NSX group. All members of the acme Kubernetes namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "acme"
    }
  }
}

# Frontend Kubernetes Service in the acme namespace.
resource "nsxt_policy_group" "tierapp_frontend_svc" {
  display_name = "acme-frontend-svc"
  description  = "PLACEHOLDER criteria - verify against real NSX group. acme frontend Service."
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

# Backend Kubernetes Service in the acme namespace.
resource "nsxt_policy_group" "tierapp_backend" {
  display_name = "acme-backend"
  description  = "PLACEHOLDER criteria - verify against real NSX group. acme backend Service."
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
