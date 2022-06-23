
resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "run_ansible1" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ../ansible/inventory ../ansible/ansible1.yml"
  }

  depends_on = [
    null_resource.wait
  ]
}

resource "null_resource" "run_ansible2" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ../ansible/inventory ../ansible/ansible2.yml --step"
  }

  depends_on = [
    null_resource.run_ansible1
  ]
}



