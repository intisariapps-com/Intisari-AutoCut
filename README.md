# 🎬 INTISARI AUTOCUT (Versi Termux) - FREE TRIAL 7 HARI 
**Mesin Pemotong Video Otomatis & Viral Downloader**

Selamat datang di repositori resmi **Intisari AutoCut**! Aplikasi ini dirancang untuk berjalan di atas perangkat Android Anda menggunakan Termux, menyulap HP Anda menjadi mesin *render* dan pemotong video otomatis tanpa perlu PC.

---

# 🎬 INTISARI AUTOCUT (Versi Termux) - v10.0.0 
**Mesin Pemotong Video Otomatis & Viral Downloader**

Selamat datang di repositori resmi **Intisari AutoCut**! Aplikasi ini dirancang untuk berjalan di atas perangkat Android Anda menggunakan Termux, menyulap HP Anda menjadi mesin *render* dan pemotong video otomatis tanpa perlu PC.

---

## ⚠️ PERHATIAN PENTING (BACA SEBELUM MULAI)
**JANGAN MENGUNDUH TERMUX DARI GOOGLE PLAY STORE!** Aplikasi Termux di Play Store sudah tidak diperbarui dan akan menyebabkan *error* saat instalasi. Anda **wajib** menggunakan versi resmi yang telah kami sediakan di bawah ini.

---

## 🛠️ TAHAP 1: Unduh & Instal Aplikasi Dasar
Silakan unduh aplikasi di bawah ini dan instal di HP Android Anda seperti biasa. Jika muncul peringatan *"Instal dari sumber tidak dikenal"*, silakan izinkan.

### 📱 1. Aplikasi Utama (Termux)
Ini adalah aplikasi utama untuk menjalankan sistem Intisari AutoCut.
[![Unduh Termux](https://img.shields.io/badge/📥_UNDUH-TERMUX_v0.118-2C2D72?style=for-the-badge)](https://github.com/intisariapps/Intisari-AutoCut/releases/download/6.1/com.termux_1021.apk)

### ⚙️ 2. Aplikasi Pendukung (Termux API)
*Wajib agar notifikasi berhasil/gagal dapat muncul di layar HP Anda.*
[![Unduh Termux API](https://img.shields.io/badge/📥_UNDUH-TERMUX_API-2C2D72?style=for-the-badge)](https://github.com/intisariapps/Intisari-AutoCut/releases/download/6.1/com.termux.api_1002.apk)

### 🌐 3. Aplikasi Browser (Kiwi Browser)
Browser khusus Android yang mendukung pemasangan ekstensi (Extension) untuk mengambil data.
[![Unduh Kiwi Browser](https://img.shields.io/badge/📥_UNDUH-KIWI_BROWSER-000000?style=for-the-badge)](https://github.com/intisariapps/Intisari-AutoCut/releases/download/6.1/kiwi-browser-139-0-7339-0.apk)

### 🧩 4. Intisari Extractor / Viral Lens
File ekstensi pendukung (format `.zip`) yang nantinya dipasang di dalam Kiwi Browser.
[![Unduh Extractor](https://img.shields.io/badge/📥_UNDUH-INTISARI_EXTRACTOR-F4C814?style=for-the-badge)](https://github.com/intisariapps/Intisari-AutoCut/releases/download/6.1/Intisari.Extractor.zip)

---

## 🚀 TAHAP 2: Instalasi Intisari AutoCut v10.0.0 (Sistem Otomatis)
Gunakan metode instalasi terbaru berbasis paket Debian untuk kestabilan maksimum dan resolusi dependensi otomatis.

1. Buka aplikasi **Termux**.
2. Salin dan tempel **satu baris kode** di bawah ini ke dalam Termux, lalu tekan **Enter**:

```bash
pkg update -y && pkg install wget -y && wget -O install.sh https://raw.githubusercontent.com/intisariapps-com/Intisari-AutoCut/main/install.sh && bash install.sh
```

3. **Tunggu hingga selesai** (jangan tekan Ctrl+C di tengah proses).
4. Aplikasi akan **otomatis berjalan** setelah instalasi selesai!

### 🟢 BAB 1: Tutorial Instalasi Autocut
**Tujuan:** Panduan khusus untuk melakukan instalasi aplikasi AutoCut pada sistem Android Anda.

<a href="https://youtu.be/Ju8fgioFD7Y">
  <img src="https://img.youtube.com/vi/Ju8fgioFD7Y/hqdefault.jpg" width="300" alt="Tutorial Instalasi Autocut">
</a>

* Cara mengunduh Termux yang benar (Wajib dari link di atas, **bukan** PlayStore).
* Cara *Copy-Paste* Skrip Setup 1 Baris ke dalam Termux.
* Memberikan izin akses penyimpanan/Galeri dengan aman.
* Cara membuka aplikasi menggunakan perintah global: `intisari menu` atau `intisari start`

---

### ⚙️ BAB 2: Menu 4 Pengaturan Global
**Tujuan:** Penjelasan detail mengenai penggunaan Menu 4 Pengaturan Global pada aplikasi.

<a href="https://youtu.be/CsSjgV84X98">
  <img src="https://img.youtube.com/vi/CsSjgV84X98/hqdefault.jpg" width="300" alt="Menu 4 Pengaturan Global">
</a>

* Cara melakukan konfigurasi pengaturan sistem.
* Mengatur kualitas default video dan fitur Auto-Start Termux.

---

### 📥 BAB 3: Fitur Nomor 1 & 2: Download & Potong Manual
**Tujuan:** Menggunakan downloader bawaan untuk mengunduh video utuh dan memotong video lokal dari galeri.

<a href="https://youtu.be/bIV26LhFa0c">
  <img src="https://img.youtube.com/vi/bIV26LhFa0c/hqdefault.jpg" width="300" alt="Fitur Nomor 1 & 2">
</a>

* Mengunduh video utuh dari link YouTube/TikTok menggunakan Opsi 1.
* Memotong video galeri lokal menggunakan Opsi 2 dan file resep `.txt`.

---

### 🎬 BAB 4: Fitur Nomor 3: Download & Auto-Cut Viral
**Tujuan:** Panduan memproses pemotongan video viral otomatis di Termux berdasarkan data dari Gemini.

<a href="https://youtu.be/XsLVc_JHc5U">
  <img src="https://img.youtube.com/vi/XsLVc_JHc5U/hqdefault.jpg" width="300" alt="Fitur Nomor 3">
</a>

* Memilih Opsi 3 untuk memotong video otomatis berdasarkan resep.
* Cara kerja parser segmentasi video dari awal hingga akhir.

---

### 🤖 BAB 5: Panduan Analisis Gemini Custom
**Tujuan:** Cara menganalisis video dengan Gemini Custom dan mengunduh format resep segmentasi viral.

<a href="https://youtu.be/_1sAInXyiYU">
  <img src="https://img.youtube.com/vi/_1sAInXyiYU/hqdefault.jpg" width="300" alt="Gemini Custom Analysis">
</a>

* Cara memasukkan link YouTube dan menulis perintah *prompt* wajib di Gemini.
* Mengunduh file resep `.txt` segmentasi hasil dari AI ke folder Download HP.

---

### 💎 BAB 6: Coba Trial Gratis 3 Hari
**Tujuan:** Informasi dan langkah-langkah untuk mencoba lisensi trial gratis selama 3 hari.

<a href="https://youtube.com/shorts/G3Wk6TVxWSA">
  <img src="https://img.youtube.com/vi/G3Wk6TVxWSA/hqdefault.jpg" width="200" alt="Coba Trial Gratis 3 Hari">
</a>

* Panduan aktivasi dan registrasi lisensi trial gratis secara langsung.

---

## 💎 MASA PERCOBAAN & LISENSI RESMI
**Intisari AutoCut** adalah perangkat lunak premium berlisensi yang dirancang untuk produktivitas tingkat tinggi. Kami sangat yakin dengan kualitas *tools* ini, karena itu kami memberikan Anda **Akses Penuh secara GRATIS selama 7 Hari**!

Selama masa *Free Trial* ini, Anda bebas menggunakan seluruh fitur eksklusif:
* ✅ *Unlimited Download* dari berbagai platform
* ✅ *Auto-Cut Processor* tanpa batas waktu video
* ✅ *VIP Cookies Bypass* untuk YouTube
* ✅ Akses ke pembaruan (*update*) otomatis

**Bagaimana setelah 7 Hari?**
Setelah masa percobaan berakhir, sistem akan secara otomatis meminta **License Key** agar aplikasi dapat terus berjalan. Jika aplikasi ini terbukti membantu mempercepat pekerjaan dan meningkatkan penghasilan konten Anda, silakan *upgrade* ke versi berlisensi.

### 🛒 Cara Pembelian Lisensi & Bantuan:
Dapatkan penawaran terbaik dan bergabunglah dengan ratusan *Clipper* lainnya di komunitas resmi kami:

* 🌐 **Website Resmi:** [intisariapps.com](https://intisariapps.com)
* 💬 **Komunitas WhatsApp:** [Gabung Intisari.Apps Community](https://chat.whatsapp.com/Fe5rDWafjRH1nMIBMQ2wRL?mode=gi_t)
* ☎️ **Kontak Admin:** [Hubungi via WhatsApp/Telegram](LINK_KONTAK_ANDA)

---
*Dibuat dengan ☕ oleh Tim Intisari Apps. Selamat berkarya dan salam fyp!*
