#!/usr/bin/env bash
ANSIBLE_FORCE_COLOR=1 ansible-playbook -T 30 -i ../ansible/inventory ../ansible/4_gitlab.yml
