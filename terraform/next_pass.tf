resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = format("ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -u %s --key-file %s  -i ../ansible/inventory ../ansible/gigapack.yml --step", var.login_name, var.ssh_privkey_path)
  }

  depends_on = [
    null_resource.wait
  ]
}

