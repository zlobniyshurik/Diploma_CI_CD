resource "yandex_compute_instance" "proxy" {
  name                      = var.proxy_name
  zone                      = var.geo_zone
  hostname                  = format("%s.%s", var.proxy_name, var.my_domain_tld)
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = var.boot_disk_image_id
      name        = format("root-%s", var.proxy_name)
      type        = "network-hdd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet1.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "${file(format("%s", var.ssh_key_path))}"
  }
}
