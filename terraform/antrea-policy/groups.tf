# NOTE: The source DFW export only contains SecurityPolicy/Rule/ContainerCluster
# rows, not Group definitions - it references these groups by path only. The
# criteria below are BEST-EFFORT, inferred from the group names and how
# they're used in security_policy_alpha.tf.
# Verify each one against the real group definitions in NSX Manager before apply -
# wrong criteria here means the policy binds to the wrong workloads.

# Frontend Kubernetes Service in the alpha namespace. NSX requires a Service
# condition to always be paired with a Namespace condition in the same
# nested expression - a Service-only criteria is rejected.
resource "nsxt_policy_group" "tierapp_frontend_svc" {
  display_name = "alpha-frontend-svc"
  description  = "PLACEHOLDER criteria - verify against real NSX group. alpha frontend Service in the alpha namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "alpha"
    }
    condition {
      key         = "Name"
      member_type = "Service"
      operator    = "EQUALS"
      value       = "frontend-app-service"
    }
  }
}

# Backend Kubernetes Service in the alpha namespace. See note above on
# tierapp_frontend_svc - Service criteria must include a Namespace condition.
resource "nsxt_policy_group" "tierapp_backend" {
  display_name = "alpha-backend"
  description  = "PLACEHOLDER criteria - verify against real NSX group. alpha backend Service in the alpha namespace."
  group_type   = "ANTREA"

  criteria {
    condition {
      key         = "Name"
      member_type = "Namespace"
      operator    = "EQUALS"
      value       = "alpha"
    }
    condition {
      key         = "Name"
      member_type = "Service"
      operator    = "EQUALS"
      value       = "backend-app-service"
    }
  }
}
