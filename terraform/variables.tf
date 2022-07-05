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

# IP внутреннего DNS в облаке.
# Подобран методом тыка, документации не обнаружено
variable "ip_dns" {
  description = "Network internal DNS IP address"
  type        = string
  default     = "172.16.1.2"
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

# Squid port on proxy
variable "proxy_port" {
  description = "Squid port on proxy"
  type        = string
  default     = "3128"
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
  default     = "gitlab-int"
}

# GitLab Runner nodename prefix
variable "runner_name_prefix" {
  description = "GitLab Runner host name prefix"
  type        = string
  default     = "runner0"
}

# Number of GitLab runner nodes
variable "runner_count"  {
  description = "Number of GitLab Runner nodes"
  type        = number
  default     = 1
}

# Monitoring nodename
variable "monitoring_name" {
  description = "Monitoring host name"
  type        = string
  default     = "monitoring"
}
