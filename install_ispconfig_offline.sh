#!/bin/bash
# ================================================================
# Script: install_ispconfig_offline.sh
# Descripción: Instala ISPConfig desde un paquete offline alojado en GitHub
# Autor: ChatGPT
# ================================================================
# --- CONFIGURACIÓN ---
WORKDIR="Bash_ispconfig_offline-main"
echo "=============================================="
echo "Instalación offline de ISPConfig iniciada..."
echo "=============================================="

# --- CLONA EL REPOSITORIO OFFLINE ---
echo "Descargando carpeta desde GitHub..."
wget https://github.com/JHONJCB/ispconfig_offline/archive/refs/heads/main.zip

#Extraer el directorio
unzip ispconfig_offline-main.zip
