#!/usr/bin/env bash
#ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./tf_emulate.yml
#ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./1_proxy.yml
#ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./2_monitoring.yml
#ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./3_web.yml
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./4_gitlab.yml
