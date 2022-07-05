# Запуск скриптов Ansible
# Начинается после автогенерации файла inventory

# Ждём, пока стартанут все виртуалки
resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [
    local_file.inventory
  ]
}

# Запускаем первую фазу развертывания Ansible-скрипта:
# Заливаем ноду с прокси, через которую можно будет достучаться
# до остальных нод.
resource "null_resource" "run_ansible1" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ANSIBLE_LOG_PATH='../Logs/Phase1.log' ansible-playbook -T 30 -i ../ansible/inventory ../ansible/1_proxy.yml"
  }

  depends_on = [
    null_resource.wait
  ]
}

# Запускаем вторую фазу развёртывания Ansible-скрипта:
# Заливаем мониторинг - подымается быстро,
# настраивается относительно просто, глюки маловероятны
# Независим ни от кого
resource "null_resource" "run_ansible2" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ANSIBLE_LOG_PATH='../Logs/Phase2.log' ansible-playbook -T 30 -i ../ansible/inventory ../ansible/2_monitoring.yml"
  }

  depends_on = [
    null_resource.run_ansible1
  ]
}


# Запускаем третью фазу развёртывания Ansible-скрипта:
# Заливаем ноды базы данных и сервер приложений
resource "null_resource" "run_ansible3" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ANSIBLE_LOG_PATH='../Logs/Phase3.log' ansible-playbook -T 30 -i ../ansible/inventory ../ansible/3_web.yml"
  }

  depends_on = [
    null_resource.run_ansible2
  ]
}

# Запускаем четвёртую фазу развёртывания Ansible-скрипта:
# Заливаем GitLab и его раннеры
resource "null_resource" "run_ansible4" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ANSIBLE_LOG_PATH='../Logs/Phase4.log' ansible-playbook -T 30 -i ../ansible/inventory ../ansible/4_gitlab.yml"
  }

  depends_on = [
    null_resource.run_ansible3
  ]
}


