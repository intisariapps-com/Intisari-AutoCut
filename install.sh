#!/bin/bash
# =========================================================
# INTISARI AUTOCUT - AUTO INSTALLER VIP
# =========================================================

# Minta izin penyimpanan terlebih dahulu agar pop-up Android muncul secara interaktif
if [ ! -d "$HOME/storage" ]; then
    echo "[*] Meminta izin akses penyimpanan Android..."
    echo "[!] Silakan PILIH 'ALLOW' / 'IZINKAN' pada layar HP Anda."
    termux-setup-storage
    sleep 3
fi

export DEBIAN_FRONTEND=noninteractive

echo "[*] Mengatur Mirror Termux otomatis..."
echo "deb https://packages-cf.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list

echo "[*] Membersihkan cache APT..."
apt clean
rm -rf /data/data/com.termux/cache/apt/archives/partial/* 2>/dev/null

echo "[*] Mengoptimalkan sistem Termux..."
apt update -y || apt update -y --fix-missing
apt upgrade -y -o Dpkg::Options::="--force-confold" || true

echo "[*] Memperbaiki library linking issues..."
apt install --reinstall libngtcp2 libnghttp3 libcurl -y --no-install-recommends || true

echo "[*] Mengunduh paket aplikasi..."
apt install wget -y --no-install-recommends

echo "[*] Verifikasi curl berfungsi..."
if ! curl --version > /dev/null 2>&1; then
    echo "[!] WARN: curl linking error detected, memperbaiki..."
    apt install --reinstall curl -y --no-install-recommends || true
    dpkg --configure -a
fi

echo "[*] Download deb installer..."
if ! wget -q -O intisari-latest.deb https://github.com/intisariapps-com/Intisari-AutoCut/releases/latest/download/intisari-autocut_latest.deb; then
    echo "[!] ERROR: Download gagal! Periksa koneksi internet Anda."
    exit 1
fi

if [ ! -f intisari-latest.deb ] || [ ! -s intisari-latest.deb ]; then
    echo "[!] ERROR: File deb tidak valid atau kosong!"
    exit 1
fi

echo "[V] Download berhasil"

echo "[*] Melakukan instalasi mesin..."
if ! apt install ./intisari-latest.deb -y --allow-downgrades; then
    echo "[!] ERROR: Instalasi deb gagal!"
    echo "[*] Attempting library fixes..."
    dpkg --configure -a
    apt install --fix-missing -y
    apt install --fix-broken -y
    if ! apt install ./intisari-latest.deb -y --allow-downgrades; then
        echo "[!] ERROR: Instalasi deb gagal setelah recovery!"
        exit 1
    fi
fi
rm -f intisari-latest.deb

echo "[*] Mengonfigurasi Auto-Run..."
mkdir -p ~
if [ -f ~/.bashrc ]; then
    if ! grep -q "intisari" ~/.bashrc; then
        echo "intisari" >> ~/.bashrc
        echo "[V] Auto-Run berhasil diaktifkan."
    else
        echo "[!] Auto-Run sudah terkonfigurasi sebelumnya."
    fi
else
    echo "intisari" > ~/.bashrc
    echo "[V] Auto-Run berhasil diaktifkan."
fi

echo "========================================================="
echo "✅ INSTALASI SELESAI!"
echo "Silakan restart Termux atau ketik 'intisari menu'."
echo "========================================================="

if command -v intisari &>/dev/null; then
    intisari menu
else
    echo "[!] WARN: Perintah 'intisari' belum tersedia. Silakan restart Termux."
fi
