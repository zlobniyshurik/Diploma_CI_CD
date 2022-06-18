#!/usr/bin/env bash
source "/opt/LEscript/set_he_params.sh"
cd "/opt/LEscript/acme.sh"
DOMAIN=$(hostname -d)
./acme.sh --config-home "/opt/LEscript/acme.config" --cert-home "/opt/LEscript/certs" --issue -d "$DOMAIN" -d "*.$DOMAIN" --keylength ec-384 --dns dns_he --server letsencrypt
./acme.sh --config-home "/opt/LEscript/acme.config" --cert-home "/opt/LEscript/certs" --issue -d "$DOMAIN" -d "*.$DOMAIN" --keylength 4096 --dns dns_he --server letsencrypt