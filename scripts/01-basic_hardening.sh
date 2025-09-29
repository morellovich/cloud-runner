#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [BASIC] $1"; }

log "Creating non-root user '$username'..."
id -u "$username" &>/dev/null || {
    adduser --disabled-password --gecos "" "$username"
    usermod -aG sudo "$username"
    log "User '$username' created and added to sudo."
}

log "Hardening SSH config..."
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh
log "SSH config hardened."