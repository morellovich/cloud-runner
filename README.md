# 🛡️ Cloud runner 🏃‍♂️‍➡️ Just another VPS Setup Tool

This project provides a **modular**, **interactive**, and **secure** way to set up and harden a fresh Linux VPS (Ubuntu/Debian-based). It guides you through critical configuration steps using a terminal-based wizard and then installs and configures essential packages and security practices.

## 🎯 Goals

- Provide a production-ready base setup for any VPS
- Harden the system security automatically
- Offer flexibility through modular, opt-in features
- Let you install everything via a single one-liner command

---

## 🚀 Quick Start (One-liner Install)

```bash
bash <(curl -sSL https://raw.githubusercontent.com/morellovich/cloud-runner/main/install.sh)
```

# 🧩 What's Installed and Configured
## 🔐 Security & Hardening ## 

| Feature                 | Description                                                             |
| ----------------------- | ----------------------------------------------------------------------- |
| **SSH Hardening**       | Disables root login, disables password auth, enforces key-based login   |
| **UFW Firewall**        | Enables and configures UFW with strict defaults (allow SSH, HTTP/HTTPS) |
| **Fail2Ban**            | Blocks brute-force SSH attacks automatically                            |
| **Auditd**              | Enables kernel-level audit logging for all system events                |
| **Sysctl Hardening**    | Tweaks kernel parameters to reduce attack surface                       |
| **Unattended Upgrades** | Automatically installs security updates                                 |


## 🧰 Optional Tools ##


| Tool                 | Description                                                                         |
| -------------------- | ----------------------------------------------------------------------------------- |
| **Docker + Compose** | Installs Docker Engine, CLI, Buildx, and Docker Compose                             |
| **WireGuard**        | Installs WireGuard VPN server                                                       |
| **Nginx**            | Installs and starts the Nginx web server                                            |
| **RKHunter**         | Scans for rootkits and suspicious binaries                                          |
| **IPv6 Disabling**   | Optionally disables IPv6 if you don’t use it                                        |
| **Dev Tools**        | Installs `git`, `vim`, `curl`, `htop`, `build-essential`, Python, Node.js, Go, etc. |

## 🧪 Tested On ##
Ubuntu 24.04 / 22.04
Default cloud-init VPS (Hetzner, DigitalOcean, Linode, etc.)

## ✍️ Customize ##
Want to add your own module?
Create scripts/13-my-feature.sh
Add it to the list in install.sh checklist
Source setup.conf inside your script and go wild

## 🤝contribution ##
Feel free to suggest changes, report [issues](https://github.com/morellovich/cloud-runner/issues) and send your [PRs](https://github.com/morellovich/cloud-runner/pulls).

**All scripts receive the config path as an argument and log their output.**

## 📝 License ## 
MIT ©
