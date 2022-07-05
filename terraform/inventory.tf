# Автогенерация inventory-файла для Ansible
resource "local_file" "inventory" {
  content = templatefile("inventory.tftpl",
    {
      tf_workspace        = "${terraform.workspace}"
      tf_my_domain_tld    = "${var.my_domain_tld}"
      tf_proxy_port       = "${var.proxy_port}"
      tf_gitlab_root_pass = "${var.gitlab_root_pass}"
      ssh_login_user      = "${var.login_name}"
      ssh_ansible_key     = "${var.ssh_privkey_path}"
      fqdn_proxy          = "${yandex_compute_instance.proxy.fqdn}"
      external_ip_proxy   = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
      internal_ip_proxy   = "${yandex_compute_instance.proxy.network_interface.0.ip_address}"
      fqdn_db             = "${yandex_compute_instance.db.*.fqdn}"
      ip_db               = "${yandex_compute_instance.db.*.network_interface.0.ip_address}"
      fqdn_app            = "${yandex_compute_instance.app.fqdn}"
      ip_app              = "${yandex_compute_instance.app.network_interface.0.ip_address}"
      fqdn_gitlab_int     = "${yandex_compute_instance.gitlab.fqdn}"
      ip_gitlab_int       = "${yandex_compute_instance.gitlab.network_interface.0.ip_address}"
      fqdn_runner         = "${yandex_compute_instance.runner.*.fqdn}"
      ip_runner           = "${yandex_compute_instance.runner.*.network_interface.0.ip_address}"
      ip_dns              = "${var.ip_dns}"
      fqdn_monitoring     = "unknown yet"
      ip_monitoring       = "unknown yet"
    }
  )
  filename = "../ansible/inventory"

  depends_on = [
    yandex_compute_instance.proxy,
    yandex_compute_instance.db.0,
    yandex_compute_instance.app,
    yandex_compute_instance.gitlab,
    yandex_compute_instance.runner.0
  ]
}