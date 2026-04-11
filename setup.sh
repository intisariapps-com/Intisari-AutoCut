#!/bin/bash
# ==============================================================================
# ⚙️ VERSI: 3.0 - INTISARI BOOTSTRAPPER (LIGHTWEIGHT & SECURE COMPILED)
# ==============================================================================

TARGET_DIR="$HOME/Intisari-AutoCut"
TEMP_DIR="$HOME/.temp_intisari_install"

# [AI: UBAH LINK INI DENGAN LINK RAW KE FILE version.json ANDA DI GITHUB]
URL_VERSION_JSON="https://raw.githubusercontent.com/intisariapps-com/intisari-AutoCut/main/version.json"

log_term() {
    local tag="$1"
    local msg="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$tag] - $msg"
}

clear
echo -e "\e[1;36m================================================\e[0m"
echo -e "\e[1;37m      INTISARI AUTO-CUT ENTERPRISE INSTALLER    \e[0m"
echo -e "\e[1;36m================================================\e[0m\n"

log_term "INFO" "Memulai Siklus Instalasi Berbasis Compiled Release."

# 1. SETUP STORAGE & DEPENDENSI
if [ ! -d "$HOME/storage" ]; then
    echo -e "\e[1;33m[!] PERHATIAN: Sistem membutuhkan izin penyimpanan.\e[0m"
    sleep 2
    termux-setup-storage
    read -p "👉 Jika sudah klik IZINKAN, tekan ENTER untuk lanjut..." dummy
fi

log_term "INFO" "Memeriksa dependensi dasar..."
pkg update -y > /dev/null 2>&1
if ! command -v python &> /dev/null || ! command -v unzip &> /dev/null || ! command -v curl &> /dev/null; then
    echo -e "\e[1;33m[*] Mengunduh utilitas sistem...\e[0m"
    pkg install python unzip curl -y > /dev/null 2>&1
fi

# 2. FETCH JSON & PARSING
echo -e "\e[1;34m[*] Menghubungkan ke Server Intisari...\e[0m"
JSON_DATA=$(curl -sL --max-time 10 "$URL_VERSION_JSON")

if [ -z "$JSON_DATA" ]; then
    echo -e "\e[1;31m[!] FATAL: Gagal menghubungi server. Periksa koneksi internet.\e[0m"
    exit 1
fi

TARGET_VERSION=$(python -c "import sys, json; data=json.loads(sys.argv[1]); print(data.get('latest_version', ''))" "$JSON_DATA" 2>/dev/null)
ZIP_URL=$(python -c "import sys, json; data=json.loads(sys.argv[1]); print(data.get('zip_url', ''))" "$JSON_DATA" 2>/dev/null)

if [ -z "$ZIP_URL" ]; then
    echo -e "\e[1;31m[!] FATAL: Format version.json rusak atau link ZIP tidak ditemukan.\e[0m"
    exit 1
fi

log_term "INFO" "Rilis target ditemukan: v$TARGET_VERSION"
echo -e "\e[1;32m[V] Ditemukan Rilis: v$TARGET_VERSION\e[0m"

# 3. MENGUNDUH & MENGEKSTRAK KE KARANTINA
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
ZIP_FILE="$TEMP_DIR/release.zip"

echo -e "\e[1;33m[*] Mengunduh paket sistem Enterprise...\e[0m"
if curl -L -o "$ZIP_FILE" "$ZIP_URL"; then
    log_term "SUCCESS" "File ZIP berhasil diunduh ke karantina."
else
    echo -e "\e[1;31m[!] Gagal mengunduh file rilis ZIP.\e[0m"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo -e "\e[1;36m[*] Mengekstrak arsip terkompilasi...\e[0m"
unzip -q "$ZIP_FILE" -d "$TEMP_DIR/extracted"
rm -f "$ZIP_FILE"

# 4. ATOMIC SWAP (TUKAR FOLDER) & CLEANUP
if [ -d "$TARGET_DIR" ]; then
    BACKUP_NAME="${TARGET_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    mv "$TARGET_DIR" "$BACKUP_NAME"
    log_term "INFO" "Sistem lama diamankan ke $BACKUP_NAME"
fi

# Logika Deteksi Root Folder ZIP (Versi 2.1 Fix)
ITEM_COUNT=$(ls -1A "$TEMP_DIR/extracted" | wc -l)
if [ "$ITEM_COUNT" -eq 1 ]; then
    ONLY_ITEM="$TEMP_DIR/extracted/$(ls -1A "$TEMP_DIR/extracted")"
    if [ -d "$ONLY_ITEM" ]; then
        EXTRACTED_ROOT="$ONLY_ITEM"
    else
        EXTRACTED_ROOT="$TEMP_DIR/extracted"
    fi
else
    EXTRACTED_ROOT="$TEMP_DIR/extracted"
fi

mv "$EXTRACTED_ROOT" "$TARGET_DIR"
rm -rf "$TEMP_DIR"

# 5. INTEGRASI PERMISSION (EXECUTE RIGHTS)
echo -e "\e[1;34m[*] Menginisialisasi Hak Akses (Executable)...\e[0m"
find "$TARGET_DIR" -type f -name "*.sh" -exec chmod +x {} \;

# Memastikan modul runtime Pyarmor dapat dieksekusi oleh Python di Termux
chmod -R 755 "$TARGET_DIR/pyarmor_runtime_009868" 2>/dev/null || true

log_term "SUCCESS" "Instalasi Enterprise ZIP selesai."
echo -e "\n\e[1;32m[V] INSTALASI BERHASIL! (Versi: $TARGET_VERSION)\e[0m"
echo -e "Copy Teks diBawah Paste Enter! Menjalakan Sistem:"
echo -e "\e[1;36mcd ~/Intisari-AutoCut && bash main.sh\e[0m\n"
