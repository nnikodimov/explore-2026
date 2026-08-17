provider "nsxt" {
  host                 = var.nsx_manager_host
  username             = var.nsx_username
  password             = var.nsx_password
  allow_unverified_ssl = var.allow_unverified_ssl
}
