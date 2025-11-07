#!/bin/bash
# ===========================================================
# Script: install_ispconfig_offline.sh
# Propósito: instalar ISPConfig offline en Ubuntu Server
# Autor: JHONJCB / Adaptado por ChatGPT
# ===========================================================

set -e  # Detiene el script si ocurre un error

echo "======================================================="
echo "🔧 Preparando entorno para instalación offline de ISPConfig..."
echo "======================================================="

# Asegurar que se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Este script debe ejecutarse como root."
  echo "Usa: sudo bash $0"
  exit 1
fi

# Instalar unzip si no está instalado
echo "📦 Verificando unzip..."
if ! command -v unzip >/dev/null 2>&1; then
  echo "Instalando unzip..."
  apt update -y && apt install -y unzip
else
  echo "✅ unzip ya está instalado."
fi
echo "======================================================="

# Descargar el paquete desde GitHub
echo "⬇️ Descargando el paquete offline de ISPConfig..."
URL="https://github.com/JHONJCB/ispconfig_offline/archive/refs/heads/main.zip"
wget -q --show-progress "$URL" -O main.zip || { echo "❌ Error al descargar el archivo."; exit 1; }

echo "======================================================="
echo "📂 Descomprimiendo el archivo..."
unzip -qo main.zip || { echo "❌ Error al descomprimir."; exit 1; }

# Verificar que el directorio exista
if [ ! -d "ispconfig_offline-main/ispconfig_offline" ]; then
  echo "❌ No se encontró el directorio ispconfig_offline. Revisa la estructura del ZIP."
  exit 1
fi

echo "======================================================="
echo "📁 Entrando al directorio de paquetes..."
cd ispconfig_offline-main/ispconfig_offline || { echo "❌ No se pudo acceder al directorio."; exit 1; }

# Instalar todos los .deb
echo "======================================================="
echo "⚙️ Instalando paquetes locales..."
dpkg -i *.deb || true
apt --fix-broken install -y

echo "======================================================="
echo "✅ Paquetes base instalados correctamente."

# Verificar si existe el instalador de ISPConfig
if [ ! -d "ispconfig3-develop/install" ]; then
  echo "❌ No se encontró el instalador de ISPConfig (ispconfig3-develop/install)."
  echo "Verifica que esté incluido en el paquete offline."
  exit 1
fi

echo "======================================================="
echo "🚀 Iniciando instalación de ISPConfig..."
cd ispconfig3-develop/install
php install.php

echo "======================================================="
echo "✅ Instalación completada."
echo "Abre ISPConfig en tu navegador:"
echo "👉 https://<IP_DEL_SERVIDOR>:8080"
echo "Usuario: admin"
echo "La contraseña fue mostrada al final del proceso de instalación."
echo "======================================================="
