#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [UPDATES] $1"; }

apt-get install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

log "Automatic security updates enabled."
