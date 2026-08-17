terraform {
  required_version = ">= 1.5.0"

  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      # nsxt_policy_parent_security_policy / nsxt_policy_security_policy_rule /
      # nsxt_policy_security_policy_container_cluster are Beta resources added in 3.11.0.
      version = ">= 3.11.0"
    }
  }
}
