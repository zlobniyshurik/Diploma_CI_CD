#!/usr/bin/env bash
# set proxy config via profie.d - should apply for all users
# 
PROXY_URL="{{ setup_proxy_protocol }}{{ setup_proxy_fqdn }}:{{ setup_proxy_port }}"

export http_proxy="$PROXY_URL"
export https_proxy="$PROXY_URL"
export ftp_proxy="$PROXY_URL"
export no_proxy="127.0.0.1,localhost"

# For curl
export HTTP_PROXY="$PROXY_URL"
export HTTPS_PROXY="$PROXY_URL"
export FTP_PROXY="$PROXY_URL"
export NO_PROXY="127.0.0.1,localhost"
