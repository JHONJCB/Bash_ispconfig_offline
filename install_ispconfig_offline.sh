#!/bin/bash
# ================================================================
# Script: install_ispconfig_offline.sh
# Descripción: Instala ISPConfig desde un paquete offline alojado en GitHub
# Autor: ChatGPT
# ================================================================

set -e

# --- CONFIGURACIÓN ---
REPO_URL="https://github.com/JHONJCB/ispconfig_offline"
WORKDIR="/tmp/ispconfig_offline"

echo "=============================================="
echo "Instalación offline de ISPConfig iniciada..."
echo "=============================================="
echo

# --- INSTALA DEPENDENCIAS BÁSICAS ---
echo "Instalando herramientas requeridas (git, unzip)..."
sudo apt update -y
sudo apt install -y git unzip || true

# --- CLONA EL REPOSITORIO OFFLINE ---
echo "Descargando carpeta desde GitHub..."
rm -rf "$WORKDIR"
git clone "$REPO_URL" "$WORKDIR"

# --- ENTRA AL DIRECTORIO ---
cd "$WORKDIR"

echo
echo "Directorio clonado: $WORKDIR"
echo "   Contenido:"
ls -1 | head -n 10
echo

# --- INSTALA TODOS LOS PAQUETES .DEB ---
if ls *.deb 1> /dev/null 2>&1; then
  echo "Instalando paquetes locales (.deb)..."
  sudo dpkg -i *.deb || sudo apt --fix-broken install -y
else
  echo "No se encontraron archivos .deb en el repositorio."
fi

# --- DESCOMPRIME EL INSTALADOR ISPConfig ---
if [ -f "ispconfig3-develop.tar.gz" ]; then
  echo "Descomprimiendo instalador ISPConfig..."
  tar -xzf ispconfig3-develop.tar.gz
  cd ispconfig3-develop/install
else
  echo "No se encontró el archivo ispconfig3-develop.tar.gz"
  exit 1
fi

# --- EJECUTA EL INSTALADOR ---
echo
echo "Iniciando instalación de ISPConfig..."
sudo php install.php

echo
echo "Instalación finalizada correctamente."
echo "Puedes acceder al panel en: https://TU_IP_SERVIDOR:8080"
echo
echo "Usuario: admin"
echo "Contraseña: admin"
echo
echo "=============================================="
echo "       FIN DEL PROCESO OFFLINE                "
echo "=============================================="
