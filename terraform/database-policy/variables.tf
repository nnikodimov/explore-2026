variable "policy_path" {
  description = "NSX policy path of the acme-db parent security policy (from ../baseline)"
  type        = string
}

variable "db_group_path" {
  description = "NSX policy path of the acme database VM group (from ../baseline)"
  type        = string
}
