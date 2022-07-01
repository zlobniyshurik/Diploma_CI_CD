#!/usr/bin/env bash
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ../ansible/inventory ../ansible/ansible2.yml
#./ansible_pass3.sh