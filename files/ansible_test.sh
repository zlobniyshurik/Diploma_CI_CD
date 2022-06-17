#!/usr/bin/env bash
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -u cloud-user --key-file ~/.ssh/ansible_ed25519  -i ../ansible/inventory ../ansible/gigapack.yml