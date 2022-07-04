# Создаём ноду для GitLab'а
resource "yandex_compute_instance" "gitlab" {
  name                      = "${var.gitlab_name}"
  zone                      = var.geo_zone
  hostname                  = "${var.gitlab_name}.${var.my_domain_tld}"
  allow_stopping_for_update = true

  # Увеличиваем тайм-ауты на создание виртуалки - в ЯОблаке она
  # иногда создаётся крайне медленно, вплоть до вылета.
  timeouts {
    create = "10m"
    update = "7m"
    delete = "5m"
  }

  # В режиме 'stage' создаём виртуалку с 4 ядрами, 4 Gb RAM и производительностью ядер 100%,
  # В противном случае выделяем 4ядра, 4Gb RAM и производительностью 100%
  # тут сколько не давай - всё мало, особенно в тормозном облаке
  resources {
    cores  = (terraform.workspace == "stage") ? 4 : 4
    memory = (terraform.workspace == "stage") ? 4 : 4
    core_fraction = (terraform.workspace == "stage") ? 100 : 100
  }

  boot_disk {
    initialize_params {
      image_id    = var.boot_disk_image_id
      name        = "root-${var.gitlab_name}"
      type        = "network-ssd"
      size        = "15"
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
