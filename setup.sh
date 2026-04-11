#!/bin/bash
# ==============================================================================
# ⚙️ VERSI: 2.0 - INTISARI BOOTSTRAPPER (ATOMIC ZIP RELEASE & JSON PARSER)
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

log_term "INFO" "Memulai Siklus Instalasi Berbasis Release ZIP."

# 1. SETUP STORAGE & DEPENDENSI (Sama seperti V1.3, sangat solid)
if [ ! -d "$HOME/storage" ]; then
    echo -e "\e[1;33m[!] PERHATIAN: Sistem membutuhkan izin penyimpanan.\e[0m"
    sleep 2
    termux-setup-storage
    read -p "👉 Jika sudah klik IZINKAN, tekan ENTER untuk lanjut..." dummy
fi

log_term "INFO" "Memeriksa dependensi dasar..."
pkg update -y > /dev/null 2>&1
if ! command -v python &> /dev/null || ! command -v unzip &> /dev/null || ! command -v curl &> /dev/null; then
    echo -e "\e[1;33m[*] Mengunduh utilitas ekstraksi (python, unzip, curl)...\e[0m"
    pkg install python unzip curl -y > /dev/null 2>&1
fi

# 2. FETCH JSON & PARSING (Menarik Data Rilis)
echo -e "\e[1;34m[*] Menghubungkan ke Server Intisari...\e[0m"
JSON_DATA=$(curl -sL --max-time 10 "$URL_VERSION_JSON")

if [ -z "$JSON_DATA" ]; then
    echo -e "\e[1;31m[!] FATAL: Gagal menghubungi server. Periksa koneksi internet.\e[0m"
    log_term "ERROR" "Gagal mengunduh version.json"
    exit 1
fi

# Parsing JSON menggunakan Python bawaan (Tanpa JQ agar lebih stabil)
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

echo -e "\e[1;33m[*] Mengunduh paket sistem utama...\e[0m"
if curl -L -o "$ZIP_FILE" "$ZIP_URL"; then
    log_term "SUCCESS" "File ZIP berhasil diunduh ke karantina."
else
    echo -e "\e[1;31m[!] Gagal mengunduh file rilis ZIP.\e[0m"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo -e "\e[1;36m[*] Mengekstrak arsip...\e[0m"
unzip -q "$ZIP_FILE" -d "$TEMP_DIR/extracted"
rm -f "$ZIP_FILE"

# 4. INJEKSI & EKSEKUSI PYTHON DECRYPTOR (DIPERKUAT)
DECRYPTOR_SCRIPT="$TEMP_DIR/decrypt_engine.py"
cat << 'EOF' > "$DECRYPTOR_SCRIPT"
import os, sys, base64, zlib, logging

TARGET_DIR = sys.argv[1]
logging.basicConfig(level=logging.INFO, format='[%(levelname)s] %(message)s')

def decrypt_file(filepath):
    try:
        with open(filepath, 'rb') as f:
            header = f.readline()
            if b'# INTISARI-ENCRYPTED-V1' not in header:
                return True
            encrypted_data = f.read()
        
        decompressed = zlib.decompress(base64.b64decode(encrypted_data))
        with open(filepath, 'wb') as f:
            f.write(decompressed)
        return True
    except Exception as e:
        logging.error("Gagal dekripsi pada: " + filepath + " | Error: " + str(e))
        return False

def main():
    success_all = True
    for root, dirs, files in os.walk(TARGET_DIR):
        for file in files:
            full_path = os.path.join(root, file)
            if not decrypt_file(full_path):
                success_all = False
    
    if not success_all:
        sys.exit(1)

if __name__ == "__main__":
    main()
EOF

echo -e "\e[1;34m[*] Membangun ulang struktur kode (Dekripsi Absolut)...\e[0m"
if python "$DECRYPTOR_SCRIPT" "$TEMP_DIR/extracted"; then
    log_term "SUCCESS" "Dekripsi berhasil 100%."
else
    echo -e "\e[1;31m[!] FATAL: File sistem corrupt saat dekripsi. Instalasi dibatalkan untuk melindungi sistem Anda.\e[0m"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# 5. ATOMIC SWAP (TUKAR FOLDER) & CLEANUP
if [ -d "$TARGET_DIR" ]; then
    BACKUP_NAME="${TARGET_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    mv "$TARGET_DIR" "$BACKUP_NAME"
    log_term "INFO" "Sistem lama diamankan ke $BACKUP_NAME"
fi

# Mencari folder utama di dalam hasil ekstrak (mengatasi jika zip dibungkus dengan parent folder)
EXTRACTED_ROOT=$(find "$TEMP_DIR/extracted" -mindepth 1 -maxdepth 1 -type d | head -n 1)
if [ -z "$EXTRACTED_ROOT" ]; then
    EXTRACTED_ROOT="$TEMP_DIR/extracted"
fi

mv "$EXTRACTED_ROOT" "$TARGET_DIR"
rm -rf "$TEMP_DIR"

find "$TARGET_DIR" -type f -name "*.sh" -exec chmod +x {} \;

log_term "SUCCESS" "Instalasi Atomic ZIP selesai."
echo -e "\n\e[1;32m[V] INSTALASI BERHASIL! (Versi: $TARGET_VERSION)\e[0m"
echo -e "Ketik perintah di bawah untuk memulai:"
echo -e "\e[1;36mcd ~/Intisari-AutoCut && bash main.sh\e[0m\n"
