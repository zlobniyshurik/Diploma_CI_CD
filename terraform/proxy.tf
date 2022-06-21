resource "yandex_compute_instance" "proxy" {
  name                      = var.proxy_name
  zone                      = var.geo_zone
  hostname                  = "${var.proxy_name}.${var.my_domain_tld}"
  allow_stopping_for_update = true
  labels                    = {
    ansible_group = "proxy"
  }

  # В режиме 'stage' создаём виртуалку с 1Gb RAM и производительностью ядер 20%,
  # В противном случае выделяем 2Gb RAM и производительностью 50%
  resources {
    cores  = 2
    memory = (terraform.workspace == "stage") ? 1 : 2
    core_fraction = (terraform.workspace == "stage") ? 20 : 50
  }

  boot_disk {
    initialize_params {
      image_id    = var.boot_disk_image_id
      name        = "root-${var.proxy_name}"
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

  # Криво, но с передачей секретных параметров в конкретную машину в ансибл
  # костылей получается ещё больше
  connection {
    type     = "ssh"
    host     = "${yandex_compute_instance.proxy.network_interface.0.nat_ip_address}"
    user     = "${var.login_name}"
    private_key = "${file(var.ssh_privkey_path)}"
    timeout = "2m"
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

  # Копируем в /tmp скрипт, что передаст параметры из TF
  # в настраиваемую машину
  provisioner "file" {
    content     = <<-EOF
    #!/usr/bin/env bash
    # variables from Terraform
    # generates automatically
    HE_Username="${var.he_net_login}"
    HE_Password="${var.he_net_pass}"
    CERT_ADMIN_MAIL="${var.cert_admin_mail}"
    STAGE_MODE="${(terraform.workspace == "stage") ? "true" : "false"}"
    EOF
    destination = "/tmp/tf_vars.sh"
  }

  # Копируем в /tmp конфиг для nginx'а,
  # который обеспечит балансировку MySQL-трафика
  provisioner "file" {
    source = "balancer.conf"
    destination = "/tmp/mysql.conf"
  }

  # Раскладываем файлы по местам, задаём права/владельцев
  # и, собственно, запускаем сам сервис обновления A-записей
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /opt/Arecord",
      "sudo mv /tmp/dnsupdate.sh /opt/Arecord",
      "sudo mv /tmp/dns_update.service /etc/systemd/system",
      "sudo chmod 755 /opt/Arecord/*.sh",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable dns_update.service --now",
      "sudo mkdir -p /opt/LEscript",
      "sudo chown -R ${var.login_name}:${var.login_name} /opt/LEscript",
      "mv /tmp/tf_vars.sh /opt/LEscript",
      "chmod 755 /opt/LEscript/*.sh",
      "sudo mkdir -p /etc/nginx",
      "sudo mv /tmp/mysql.conf /etc/nginx",
      "sudo chown -R root:root /etc/nginx"
    ]
  }
  depends_on = [
    local_file.balancer
  ]
}
