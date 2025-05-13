#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [NGINX] $1"; }

apt-get install -y nginx
systemctl enable nginx
systemctl start nginx

log "Nginx installed and running."
