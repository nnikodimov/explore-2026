# ACNP: Antrea/Kubernetes-targeted policy for the acme cluster.
# Split across nsxt_policy_parent_security_policy + nsxt_policy_security_policy_rule
# because nsxt_policy_security_policy_container_cluster can only attach to a
# "parent" policy, not the combined nsxt_policy_security_policy resource.

resource "nsxt_policy_parent_security_policy" "tierapp" {
  display_name = "acme_policy"
  description  = "acme K8s policy"
  category     = "Application"
  stateful     = true
  tcp_strict   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "nsxt_policy_security_policy_container_cluster" "tierapp" {
  display_name           = "acme-cluster-span"
  description            = "Antrea container cluster span for acme_policy"
  policy_path            = nsxt_policy_parent_security_policy.tierapp.path
  container_cluster_path = data.nsxt_policy_container_cluster.tierapp.path
}

# Priority order below matches the export's ascending sequenceNumber (lower =
# higher priority, evaluated first): allow_acme_frontend (249999),
# allow_acme_frontend_to_backend (374999), lockdown_acme_namespace (499999).

resource "nsxt_policy_security_policy_rule" "allow_acme_frontend" {
  display_name    = "allow_acme_frontend"
  description     = "allow acme frontend"
  policy_path     = nsxt_policy_parent_security_policy.tierapp.path
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
  policy_path     = nsxt_policy_parent_security_policy.tierapp.path
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

resource "nsxt_policy_security_policy_rule" "lockdown_acme_namespace" {
  display_name    = "lockdown_acme_namespace"
  description     = "lockdown acme namespace"
  policy_path     = nsxt_policy_parent_security_policy.tierapp.path
  sequence_number = 3
  action          = "DROP"
  direction       = "IN"
  scope           = [nsxt_policy_group.tierapp_ns.path]
}
