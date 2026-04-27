#!/bin/bash
# =========================================================
# INTISARI AUTOCUT - AUTO INSTALLER VIP
# =========================================================

export DEBIAN_FRONTEND=noninteractive

echo "[*] Mengoptimalkan sistem Termux..."
pkg update -y
pkg upgrade -y -o Dpkg::Options::="--force-confold"

echo "[*] Mengunduh paket aplikasi..."
pkg install wget -y
wget -qO i.deb https://github.com/intisariapps-com/Intisari-AutoCut/raw/main/intisari-autocut_latest.deb

echo "[*] Melakukan instalasi mesin..."
pkg install ./i.deb -y
rm -f i.deb

# --- BAGIAN AUTO-LOAD (Surgical Injection) ---
echo "[*] Mengonfigurasi Auto-Run..."
if ! grep -q "intisari" ~/.bashrc; then
    echo "intisari" >> ~/.bashrc
    echo "[V] Auto-Run berhasil diaktifkan."
else
    echo "[!] Auto-Run sudah terkonfigurasi sebelumnya."
fi

echo "========================================================="
echo "✅ INSTALASI SELESAI!"
echo "Silakan restart Termux atau ketik 'intisari' sekarang."
echo "========================================================="

# Langsung jalankan aplikasi pertama kali
intisari
