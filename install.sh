#!/bin/bash
# =========================================================
# INTISARI AUTOCUT - AUTO INSTALLER VIP
# =========================================================

export DEBIAN_FRONTEND=noninteractive

echo "[*] Mengatur Mirror Termux otomatis..."
mkdir -p ~/.termux
echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > ~/.termux/apt-sources.list

echo "[*] Mengoptimalkan sistem Termux..."
apt update -y
apt upgrade -y -o Dpkg::Options::="--force-confold"

echo "[*] Mengunduh paket aplikasi..."
apt install wget -y --no-install-recommends

echo "[*] Download deb installer..."
if ! wget -q -O intisari-latest.deb https://autocutdeb.intisariapps.com/intisari-autocut-latest.deb; then
    echo "[!] ERROR: Download gagal! Periksa koneksi internet Anda."
    exit 1
fi

if [ ! -f intisari-latest.deb ] || [ ! -s intisari-latest.deb ]; then
    echo "[!] ERROR: File deb tidak valid atau kosong!"
    exit 1
fi

echo "[V] Download berhasil"

echo "[*] Melakukan instalasi mesin..."
apt install ./intisari-latest.deb -y
rm -f intisari-latest.deb

echo "[*] Mengonfigurasi Auto-Run..."
if ! grep -q "intisari" ~/.bashrc; then
    echo "intisari" >> ~/.bashrc
    echo "[V] Auto-Run berhasil diaktifkan."
else
    echo "[!] Auto-Run sudah terkonfigurasi sebelumnya."
fi

echo "========================================================="
echo "✅ INSTALASI SELESAI!"
echo "Silakan restart Termux atau ketik 'intisari menu'."
echo "========================================================="

intisari menu
