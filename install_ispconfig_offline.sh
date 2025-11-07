#!/bin/bash
# ===========================================================
# Script: offline_prepare.sh
# Propósito: preparar todos los paquetes necesarios para
# instalar ISPConfig offline en Ubuntu Server 22.04 o 24.04
# ===========================================================

echo "Instalando unzip..."
apt install unzip
echo "======================================================="

echo "Descargando el directorio de paquetes..."
echo "Este proceso puede demorar un poco, espera..."
wget https://github.com/JHONJCB/ispconfig_offline/archive/refs/heads/main.zip
echo "======================================================="

echo "Descomprimiendo el archivo descargado..."
unzip main.zip
echo "======================================================="

echo "Entrando al directorio descomprimido..."
cd ispconfig_offline-main/ispconfig_offline
echo "======================================================="

echo "Ejecutando los paquetes e instalando dependencias..."
sudo dpkg -i *.deb
sudo apt --fix-broken install -y
echo "======================================================="

echo "Instalando ISPConfig..."
cd ispconfig3-develop/install
sudo php install.php
echo "======================================================="

echo "Intenta abrir ISPConfig ingresando a https://<IP_DEL_SERVIDOR>:8080"
echo "Recuerda que la contraseña de acceso fue mostrada al finalizar la instalación"
