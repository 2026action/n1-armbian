#!/usr/bin/env bash
# Runs INSIDE the image rootfs (chroot, as root) on the target architecture.
# Streamlined Minimal Edition for Phicomm N1 (s905d):
#   - Essential wireless & networking tools (NetworkManager, wpasupplicant, iw, rfkill)
#   - Common system utilities (curl, wget, nano, htop, ca-certificates)
#   - Stripped of all heavy dev tools, metasploit, pentest packages and v2rayA
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive
export LANG=C.UTF-8

echo "[*] Skip docs/man/locale for newly installed packages"
cat > /etc/dpkg/dpkg.cfg.d/01-tiny <<'EOF'
path-exclude=/usr/share/doc/*
path-exclude=/usr/share/man/*
path-exclude=/usr/share/locale/*
EOF

echo "[*] apt-get update"
apt-get update

echo "[*] Installing essential network and WiFi packages"
# Ensure wireless utilities and NetworkManager are fully installed
apt-get install -y --no-install-recommends \
  ca-certificates curl wget nano htop \
  iw wireless-tools wpasupplicant wireless-regdb rfkill \
  network-manager libnss-systemd

echo "[*] Enabling NetworkManager service"
systemctl enable NetworkManager 2>/dev/null || true

# Unmask hostapd/wpa_supplicant if needed
systemctl enable wpa_supplicant 2>/dev/null || true

echo "[*] Cleaning up apt caches and temporary files"
apt-get autoremove -y >/dev/null 2>&1 || true
apt-get clean
rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /tmp/* /var/tmp/* /root/.cache

echo "[+] Minimal WiFi rootfs customization complete!"
