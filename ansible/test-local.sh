#!/usr/bin/env bash
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./tf_emulate.yml
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./ansible1.yml
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./ansible2.yml
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ./local-inventory ./ansible3.yml