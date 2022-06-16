####################
# General settings #
####################

# My domain TLD
variable "my_domain_tld" {
  description = "My domain TLD"
  type        = string
  default     = "diplomshurika.ru"
}

# Path to SSH public key
variable "ssh_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/ansible_ed25519.pub"
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
