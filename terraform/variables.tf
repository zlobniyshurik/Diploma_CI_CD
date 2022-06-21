####################
# General settings #
####################

# My domain TLD
variable "my_domain_tld" {
  description = "My domain TLD"
  type        = string
  default     = "diplomshurika.ru"
}

# Login name for my hosts
# (depends from boot image)
variable "login_name" {
  description = "Login name for my hosts"
  type        = string
  default     = "cloud-user"
}

# Path to SSH public key
variable "ssh_pubkey_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/ansible_ed25519.pub"
}

# Path to SSH private key
variable "ssh_privkey_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/ansible_ed25519"
}

# AlmaLinux8 boot disk image
variable "boot_disk_image_id" {
  description = "Boot disk image ID"
  type        = string
  default     = "fd8p3li8lr7i25kkhd6n"
}

# Yandex geozone
variable "geo_zone" {
  description = "Yandex geozone: 'ru-central1-a' | 'ru-central1-b' | 'ru-central1-c'"
  type        = string
  default     = "ru-central1-a"
}

##################
# Hosts settings #
##################

# Proxy name
variable "proxy_name" {
  description = "Reverse proxy host name"
  type        = string
  default     = "proxy"
}

# DB name
variable "db_name"  {
  description = "Database host name"
  type        = string
  default     = "db0"
}

# Number of DB-nodes
variable "db_count"  {
  description = "Number of DB-nodes"
  type        = number
  default     = 2
}
