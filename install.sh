#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
pkg update -y
pkg upgrade -y -o Dpkg::Options::="--force-confold"
pkg install wget -y
wget -qO i.deb https://github.com/intisariapps-com/Intisari-AutoCut/raw/main/intisari-autocut_latest.deb
pkg install ./i.deb -y
rm -f i.deb
intisari
