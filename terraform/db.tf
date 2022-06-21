resource "yandex_compute_instance" "db" {
  name                      = "${var.db_name}${count.index+1}"
  count                     = var.db_count
  zone                      = var.geo_zone
  hostname                  = "${var.db_name}${count.index+1}.${var.my_domain_tld}"
  allow_stopping_for_update = true

  # В режиме 'stage' создаём виртуалку с 2ядрами, 2Gb RAM и производительностью ядер 20%,
  # В противном случае выделяем 4ядра, 4Gb RAM и производительностью 50%
  resources {
    cores  = (terraform.workspace == "stage") ? 2 : 4
    memory = (terraform.workspace == "stage") ? 2 : 4
    core_fraction = (terraform.workspace == "stage") ? 20 : 50
  }

  boot_disk {
    initialize_params {
      image_id    = var.boot_disk_image_id
      name        = "root-${var.db_name}${count.index+1}"
      type        = "network-hdd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet1.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.login_name}:${file(var.ssh_pubkey_path)}"
  }


}
