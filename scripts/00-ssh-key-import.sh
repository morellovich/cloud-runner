#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [SSH-KEY] $1"; }

# Ensure the public key exists
if [ ! -f /tmp/public_key.pub ]; then
  log "Public key not found at /tmp/public_key.pub"
  exit 1
fi

# Setup SSH for root
log "Configuring SSH key for root..."
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cat /tmp/public_key.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# Setup SSH for new user
log "Configuring SSH key for user: $username"
USER_HOME=$(eval echo "~$username")
mkdir -p "$USER_HOME/.ssh"
chmod 700 "$USER_HOME/.ssh"
cat /tmp/public_key.pub >> "$USER_HOME/.ssh/authorized_keys"
chmod 600 "$USER_HOME/.ssh/authorized_keys"
chown -R "$username:$username" "$USER_HOME/.ssh"

log "SSH key successfully added for both root and $username."
