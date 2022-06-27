#!/usr/bin/env bash
# Script registering an account on Let's Encrypt
source "/opt/LEscript/tf_vars.sh"
cd "/opt/LEscript/acme.sh"
./acme.sh --register-account --server letsencrypt --config-home "/opt/LEscript/acme.config"
