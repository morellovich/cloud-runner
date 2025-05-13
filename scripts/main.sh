#!/bin/bash

CONF="$1"
source "$CONF"

log() { echo "$(date +'%Y-%m-%d %H:%M:%S') $1" | tee -a /var/log/vps-setup.log; }

for feature in $features; do
    feature_clean=$(echo "$feature" | tr -d '"')  # Remove quotes from whiptail
    SCRIPT="/opt/vps-setup/scripts/*$feature_clean*.sh"
    if [ -f $SCRIPT ]; then
        log "Running: $SCRIPT"
        bash $SCRIPT "$CONF"
    else
        log "Script for $feature_clean not found."
    fi
done
