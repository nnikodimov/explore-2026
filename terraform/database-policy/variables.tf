variable "policy_path" {
  description = "NSX policy path of the alpha-db parent security policy (from ../baseline)"
  type        = string
}

variable "db_group_path" {
  description = "NSX policy path of the alpha database VM group (from ../baseline)"
  type        = string
}
