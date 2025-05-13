#!/bin/bash
source "$1"
log() { echo "$(date +'%F %T') [FAIL2BAN] $1"; }

apt-get install -y fail2ban

cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

cat <<EOF > /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
EOF

systemctl enable fail2ban
systemctl restart fail2ban

log "Fail2Ban installed and configured."
