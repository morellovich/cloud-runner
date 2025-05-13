#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [DEVTOOLS] $1"; }

apt-get install -y build-essential git curl vim htop

# Optional: install common languages
apt-get install -y python3-pip golang nodejs npm

log "Development tools and languages installed."
