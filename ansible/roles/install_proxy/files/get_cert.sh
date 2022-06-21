#!/usr/bin/env bash
# Script for obtaining certificates for the domain(s)
source "/opt/LEscript/tf_vars.sh"
cd "/opt/LEscript/acme.sh"
DOMAIN=$(hostname -d)
if STAGE_MODE; then
./acme.sh --config-home "/opt/LEscript/acme.config" --cert-home "/opt/LEscript/certs" --issue -d "$DOMAIN" -d "*.$DOMAIN" --keylength ec-384 --dns dns_he --server letsencrypt --staging
./acme.sh --config-home "/opt/LEscript/acme.config" --cert-home "/opt/LEscript/certs" --issue -d "$DOMAIN" -d "*.$DOMAIN" --keylength 4096 --dns dns_he --server letsencrypt --staging
else
./acme.sh --config-home "/opt/LEscript/acme.config" --cert-home "/opt/LEscript/certs" --issue -d "$DOMAIN" -d "*.$DOMAIN" --keylength ec-384 --dns dns_he --server letsencrypt
./acme.sh --config-home "/opt/LEscript/acme.config" --cert-home "/opt/LEscript/certs" --issue -d "$DOMAIN" -d "*.$DOMAIN" --keylength 4096 --dns dns_he --server letsencrypt
fi