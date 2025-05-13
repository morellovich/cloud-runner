#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [AUDITD] $1"; }

apt-get install -y auditd
systemctl enable auditd
systemctl start auditd

log "Audit daemon installed and running."
