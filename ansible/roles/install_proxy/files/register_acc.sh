#!/usr/bin/env bash
source "/opt/LEscript/set_he_params.sh"
cd "/opt/LEscript/acme.sh"
./acme.sh --register-account --server letsencrypt --config-home "/opt/LEscript/acme.config"