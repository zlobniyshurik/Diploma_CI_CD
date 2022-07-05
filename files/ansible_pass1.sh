#!/usr/bin/env bash
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ../ansible/inventory ../ansible/1_proxy.yml
#./ansible_pass2.sh
