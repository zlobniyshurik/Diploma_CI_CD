#!/usr/bin/env bash
# Script that installs 'acme.sh' from the distribution
source "/opt/LEscript/tf_vars.sh"
cd "/opt/LEscript/acme.sh-master"
./acme.sh --install  \
--home "/opt/LEscript/acme.sh" \
--config-home "/opt/LEscript/acme.config" \
--cert-home  "/opt/LEscript/certs" \
--accountemail  $CERT_ADMIN_MAIL \
--accountkey  "/opt/LEscript/acme.config/myaccount.key" \
--accountconf "/opt/LEscript/acme.config/myaccount.conf" \
--useragent  "this is my client."