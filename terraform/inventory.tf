resource "local_file" "inventory" {
  content = templatefile("inventory.tftpl",
    {
      tf_workspace    = "${terraform.workspace}"
      ssh_login_user  = "${var.login_name}"
      ssh_ansible_key = "${var.ssh_privkey_path}"
      fqdn_proxy      = "${yandex_compute_instance.proxy.fqdn}",
      ip_proxy        = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}",
      fqdn_db         = "${yandex_compute_instance.db.*.fqdn}",
      ip_db           = "${yandex_compute_instance.db.*.network_interface.0.ip_address}",
    }
  )
  filename = "../ansible/inventory"

  depends_on = [
    yandex_compute_instance.proxy,
    yandex_compute_instance.db.0
  ]
}