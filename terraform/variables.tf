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

# Path to SSH additional config
# (it will be autogenerated by Terraform)
# Don't forget to include string below to your ssh-config file
#
# Include <path/to/additional/config/file>
#variable "ssh_config_path" {
#  description = "Path to SSH additional config"
#  type        = string
#  default     = "~/.ssh/diplom.cfg"
#}

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

# Proxy nodename
variable "proxy_name" {
  description = "Reverse proxy host name"
  type        = string
  default     = "proxy"
}

# DB nodename prefix
variable "db_name_prefix"  {
  description = "Database host name prefix"
  type        = string
  default     = "db0"
}

# Number of DB-nodes
variable "db_count"  {
  description = "Number of DB-nodes"
  type        = number
  default     = 2
}

# Application nodename
variable "app_name" {
  description = "Application host name"
  type        = string
  default     = "app"
}

# GitLab nodename
variable "gitlab_name" {
  description = "GitLab host name"
  type        = string
  default     = "gitlab"
}

# GitLab Runner nodename prefix
variable "runner_name_prefix" {
  description = "GitLab Runner host name prefix"
  type        = string
  default     = "runner"
}

# Number of GitLab runner nodes
variable "runner_count"  {
  description = "Number of GitLab Runner nodes"
  type        = number
  default     = 1
}
