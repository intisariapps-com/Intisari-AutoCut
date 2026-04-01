#!/bin/bash
# ==============================================================================
# ⚙️ VERSI: 1.3 - INTISARI BOOTSTRAPPER (AUTO-STORAGE & HEALING)
# ==============================================================================

TARGET_DIR="$HOME/Intisari-AutoCut"
REPO_URL="https://github.com/intisariapps/Intisari-AutoCut.git"

# --- PROTOKOL FORENSIC LOGGING BASH ---
log_term() {
    local tag="$1"
    local msg="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$tag] - $msg"
}

clear
echo -e "\e[1;36m================================================\e[0m"
echo -e "\e[1;37m      INTISARI AUTO-CUT ENTERPRISE INSTALLER    \e[0m"
echo -e "\e[1;36m================================================\e[0m\n"

log_term "INFO" "=== MEMULAI SIKLUS INSTALASI INTISARI-AUTOCUT ==="

# 0. SETUP STORAGE PERMISSION (IZIN PENYIMPANAN PINTAR)
log_term "INFO" "Memeriksa izin penyimpanan..."
# Termux akan membuat folder ~/storage jika izin sudah diberikan.
if [ ! -d "$HOME/storage" ]; then
    echo -e "\e[1;33m[!] PERHATIAN: Sistem membutuhkan izin akses Galeri/Penyimpanan.\e[0m"
    echo -e "Sebentar lagi akan muncul pop-up peringatan dari Android di layar Anda.\n"
    echo -e "👉 Mohon klik \e[1;32m'IZINKAN' (ALLOW)\e[0m pada pop-up tersebut."
    sleep 3
    
    # Memanggil API Android
    termux-setup-storage
    
    echo -e "\n\e[1;36m[*] Jika Anda SUDAH menekan IZINKAN, tekan tombol ENTER di keyboard untuk melanjutkan...\e[0m"
    read -p ""
    log_term "SUCCESS" "Izin penyimpanan telah diminta dan dikonfirmasi pengguna."
else
    log_term "OK" "Izin penyimpanan sudah ada. Melanjutkan..."
fi

# 1. AUTO-HEALING & UPGRADE SISTEM TERMUX
log_term "INFO" "Menyelaraskan pustaka inti Termux (Update & Upgrade)..."
echo -e "\n\e[1;33m[*] Menyelaraskan sistem Termux Anda (Ini mungkin memakan waktu beberapa menit)...\e[0m"

pkg clean > /dev/null 2>&1
dpkg --configure -a > /dev/null 2>&1
apt --fix-broken install -y > /dev/null 2>&1
pkg update -y > /dev/null 2>&1
yes | pkg upgrade -y > /dev/null 2>&1

# 2. CEK DEPENDENSI DASAR (TERMASUK FFMPEG)
log_term "INFO" "Memeriksa dependensi engine dasar (git, python, ffmpeg)..."
if ! command -v git &> /dev/null || ! command -v python &> /dev/null || ! command -v ffmpeg &> /dev/null; then
    log_term "INSTALL" "Dependensi tidak lengkap. Mengunduh via pkg..."
    echo -e "\e[1;33m[*] Mengunduh mesin dasar (git, python, ffmpeg)...\e[0m"
    pkg install git python ffmpeg -y > /dev/null 2>&1
    log_term "SUCCESS" "Semua dependensi terpasang."
else
    log_term "OK" "Dependensi utama sudah siap."
fi

# 3. MEKANISME UNIQUE BACKUP JIKA FOLDER SUDAH ADA
if [ -d "$TARGET_DIR" ]; then
    BACKUP_NAME="${TARGET_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    log_term "WARNING" "Direktori $TARGET_DIR sudah ada di sistem."
    log_term "BACKUP" "Memindahkan folder lama ke cadangan unik: $BACKUP_NAME"
    mv "$TARGET_DIR" "$BACKUP_NAME"
fi

# 4. MENGUNDUH REPOSITORI TERENKRIPSI
log_term "FETCH" "Mengkloning repositori terenkripsi dari GitHub..."
echo -e "\e[1;34m[*] Mengunduh data dari server Intisari...\e[0m"
if git clone "$REPO_URL" "$TARGET_DIR" > /dev/null 2>&1; then
    log_term "SUCCESS" "Repositori berhasil dikloning ke $TARGET_DIR"
else
    log_term "ERROR" "Gagal mengkloning repositori. Periksa koneksi internet Anda."
    echo -e "\e[1;31m[!] Gagal mengunduh data. Pastikan internet stabil.\e[0m"
    exit 1
fi

# 5. INJEKSI PYTHON DECRYPTOR ENGINE (ON-THE-FLY)
DECRYPTOR_SCRIPT="$TARGET_DIR/.temp_decryptor.py"
log_term "INFO" "Menyuntikkan Python Decryptor Engine ke dalam memori kerja..."

cat << 'EOF' > "$DECRYPTOR_SCRIPT"
import os, sys, base64, zlib, logging

TARGET_DIR = sys.argv[1]

logging.basicConfig(
    level=logging.DEBUG,
    format='[%(asctime)s] [%(levelname)s] - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
    handlers=[logging.StreamHandler(sys.stdout)]
)

def decrypt_file(filepath):
    try:
        with open(filepath, 'rb') as f:
            header = f.readline()
            if b'# INTISARI-ENCRYPTED-V1' not in header:
                return # Skip file yang tidak terenkripsi
            encrypted_data = f.read()
        
        decompressed = zlib.decompress(base64.b64decode(encrypted_data))
        
        with open(filepath, 'wb') as f:
            f.write(decompressed)
    except Exception as e:
        pass

def main():
    for root, dirs, files in os.walk(TARGET_DIR):
        if '.git' in dirs:
            dirs.remove('.git')
        for file in files:
            if file == ".temp_decryptor.py":
                continue
            decrypt_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
EOF

# 6. EKSEKUSI DEKRIPSI LOKAL
log_term "INFO" "Menjalankan proses dekripsi secara sekuensial..."
echo -e "\e[1;36m[*] Membangun ulang struktur kode (Dekripsi)...\e[0m"
python "$DECRYPTOR_SCRIPT" "$TARGET_DIR" > /dev/null 2>&1

# 7. POST-INSTALL CLEANUP & SETUP PERMISSION
log_term "INFO" "Membersihkan jejak Decryptor Engine (Self-Destruct)..."
rm -f "$DECRYPTOR_SCRIPT"

log_term "INFO" "Mengatur izin eksekusi (+x) pada modul utama bash..."
find "$TARGET_DIR" -type f -name "*.sh" -exec chmod +x {} \;

log_term "SUCCESS" "=== INSTALASI INTISARI-AUTOCUT BERHASIL ==="
echo ""
echo -e "\e[1;32m[V] Sistem telah berhasil didekripsi dan siap digunakan!\e[0m"
echo -e "Silakan ketik perintah di bawah ini untuk memulai:"
echo -e "\e[1;36mcd ~/Intisari-AutoCut && bash main.sh\e[0m"
echo ""
