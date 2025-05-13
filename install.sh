#!/bin/bash

LOG_FILE="/var/log/vps-setup.log"
mkdir -p /opt/vps-setup/logs
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Starting VPS setup at $(date)"

# 1. Ask for hostname
HOSTNAME=$(whiptail --inputbox "Enter a name for your server (hostname):" 10 60 --title "Server Setup" 3>&1 1>&2 2>&3)
sudo hostnamectl set-hostname "$HOSTNAME"

# 2. Ask for username
USERNAME=$(whiptail --inputbox "Enter the name of the non-root user to be created:" 10 60 "vpsadmin" 3>&1 1>&2 2>&3)

# 3. Select region/timezone
TIMEZONE=$(whiptail --title "Select Region/Timezone" --menu "Choose your region:" 15 60 5 \
"UTC" "Universal Time" \
"Europe/Berlin" "Germany" \
"America/New_York" "US Eastern" \
"Asia/Tokyo" "Japan" \
"Custom" "Enter manually" 3>&1 1>&2 2>&3)

if [[ "$TIMEZONE" == "Custom" ]]; then
    TIMEZONE=$(whiptail --inputbox "Enter your desired timezone (e.g., Europe/Lisbon):" 10 60 3>&1 1>&2 2>&3)
fi

timedatectl set-timezone "$TIMEZONE"

# 4. Keyboard layout
LAYOUT=$(whiptail --title "Keyboard Layout" --inputbox "Enter your keyboard layout code (e.g., de, us, fr):" 10 60 "us" 3>&1 1>&2 2>&3)

# 5. SSH key warning
whiptail --title "SSH Key Setup" --msgbox "We highly recommend creating a secure SSH keypair on your local machine FIRST.\n\nPlease follow the instructions at: https://yourdomain.com/docs/ssh\n\nThen paste your PUBLIC key (usually found at ~/.ssh/id_ed25519.pub)." 15 60

SSH_KEY=$(whiptail --inputbox "Paste your PUBLIC SSH key:" 10 80 3>&1 1>&2 2>&3)
echo "$SSH_KEY" > /tmp/public_key.pub

# 6. Feature selection
FEATURES=$(whiptail --title "VPS Setup Features" --checklist \
"Select the features you want to enable:" 22 70 15 \
"basic_hardening" "Disable root, password auth, SSH tweaks" ON \
"ufw" "Set up firewall (UFW)" ON \
"fail2ban" "Install and configure Fail2Ban" ON \
"sysctl" "Kernel/sysctl security tuning" ON \
"unattended_upgrades" "Enable automatic security updates" ON \
"auditd" "Install login/audit logs" ON \
"docker" "Install Docker + Compose" ON \
"wireguard" "Install WireGuard VPN" OFF \
"nginx" "Install Nginx" OFF \
"rkhunter" "Install rootkit hunter" OFF \
"ipv6_disable" "Disable IPv6" OFF \
"devtools" "Install dev tools (Node.js, Python, Go)" OFF \
3>&1 1>&2 2>&3)

# 7. Write config
mkdir -p /opt/vps-setup/
cat <<EOF > /opt/vps-setup/setup.conf
hostname=$HOSTNAME
username=$USERNAME
timezone=$TIMEZONE
keyboard=$LAYOUT
ssh_key_file=/tmp/public_key.pub
features=$FEATURES
EOF

# 7. Run main setup
bash /opt/vps-setup/scripts/main.sh /opt/vps-setup/setup.conf
