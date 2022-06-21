resource "local_file" "inventory" {
  content = templatefile("inventory.tmpl",
    {
      hostname_proxy = "${yandex_compute_instance.proxy.hostname}",
      ip_proxy       = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}",
      hostname_db    = "${yandex_compute_instance.db.*.hostname}",
      ip_db          = "${yandex_compute_instance.db.*.network_interface.0.nat_ip_address}"
    }
  )
  filename = "../ansible/inventory"

  depends_on = [
    yandex_compute_instance.proxy,
    yandex_compute_instance.db.0
  ]
}