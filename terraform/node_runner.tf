# Создаём ноду для GitLab'овского раннера
resource "yandex_compute_instance" "runner" {
  name                      = "${var.runner_name_prefix}${count.index+1}"
  zone                      = var.geo_zone
  hostname                  = "${var.runner_name_prefix}${count.index+1}.${var.my_domain_tld}"
  count                     = var.runner_count
  allow_stopping_for_update = true

  # Увеличиваем тайм-ауты на создание виртуалки - в ЯОблаке она
  # иногда создаётся крайне медленно, вплоть до вылета.
  timeouts {
    create = "5m"
    update = "7m"
    delete = "5m"
  }

  # В режиме 'stage' создаём виртуалку с 2ядрами, 2 Gb RAM и производительностью ядер 20%,
  # В противном случае выделяем 4ядра, 4Gb RAM и производительностью 50%
  resources {
    cores  = (terraform.workspace == "stage") ? 2 : 4
    memory = (terraform.workspace == "stage") ? 2 : 4
    core_fraction = (terraform.workspace == "stage") ? 20 : 50
  }

  boot_disk {
    initialize_params {
      image_id    = var.boot_disk_image_id
      name        = "root-${var.runner_name_prefix}${count.index+1}"
      type        = "network-hdd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet1.id}"
    nat       = false
  }

  metadata = {
    ssh-keys = "${var.login_name}:${file(var.ssh_pubkey_path)}"
  }
}
