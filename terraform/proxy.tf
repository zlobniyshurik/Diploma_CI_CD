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
    ssh-keys = format("%s:%s", var.login_name, file(var.ssh_pubkey_path))
  }

  # Криво, но с передачей параметров в ансибл ещё хуже
  connection {
    type     = "ssh"
    host     = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
    user     = "${var.login_name}"
    private_key = "${file(var.ssh_privkey_path)}"
    timeout = "2m"
  }

  # Создаём каталог для скрипта обновления A-записи
  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /opt/Arecord"]
  }

  # Копируем в /tmp прокси-машины скрипт обновления A-записи в DNS he.net
  provisioner "file" {

    content     = <<-EOF
    #!/bin/bash
    curl -4 "https://"${var.my_domain_tld}":"${var.he_net_key}"@dyn.dns.he.net/nic/update?hostname="${var.my_domain_tld}
    EOF
    destination = "/tmp/dnsupdate.sh"
  }

  # Копируем в /tmp прокси-машины systemd-unit, что запускает скрипт после старта прокси
  provisioner "file" {
    content     = <<-EOF
    [Unit]
    Description=Update A-record in DNS at system startup
    Requires=network.target
    After=network.target
    Before=nginx.service

    [Service]
    ExecStartPre=-/bin/sleep 10
    ExecStart=/bin/bash -c "/opt/Arecord/dnsupdate.sh"

    [Install]
    WantedBy=default.target
    EOF
    destination = "/tmp/dns_update.service"
  }

  # Раскладываем файлы по местам и, собственно, запускаем сам сервис
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/dnsupdate.sh /opt/Arecord",
      "sudo chmod 755 /opt/Arecord/dnsupdate.sh",
      "sudo mv /tmp/dns_update.service /etc/systemd/system",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable dns_update.service --now" ]
  }

}
