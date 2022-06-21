#!/usr/bin/env bash
# Script registering an account on Let's Encrypt
source "/opt/LEscript/tf_vars.sh"
cd "/opt/LEscript/acme.sh"
if STAGE_MODE; then ./acme.sh --register-account --server letsencrypt --config-home "/opt/LEscript/acme.config" --staging
else ./acme.sh --register-account --server letsencrypt --config-home "/opt/LEscript/acme.config"
fi