#!/bin/bash

# Directorio de instalación
INSTALL_DIR="/usr/bin"
SCRIPT_NAME="twchk"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Verificar si el script ya está instalado
if [ -f "$SCRIPT_PATH" ]; then
    echo "✅ '$SCRIPT_NAME' ya está instalado en $INSTALL_DIR."
    read -p "¿Quieres reinstalarlo? (s/n): " REINSTALL
    if [[ "$REINSTALL" != "s" && "$REINSTALL" != "S" ]]; then
        echo "❌ Instalación cancelada."
        exit 0
    fi
fi

# Verificar si el script existe en el directorio actual
if [ -f "twitter_checker.sh" ]; then
    # Copiar el script al directorio de instalación
    sudo cp twitter_checker.sh "$SCRIPT_PATH"
    sudo chmod +x "$SCRIPT_PATH"

    # Agregar alias en .bashrc y .zshrc si no existe
    if ! grep -q "alias $SCRIPT_NAME=" ~/.bashrc; then
        echo "alias $SCRIPT_NAME='$SCRIPT_PATH'" | tee -a ~/.bashrc ~/.zshrc
    fi

    # Aplicar cambios sin reiniciar sesión
    source ~/.bashrc 2>/dev/null
    source ~/.zshrc 2>/dev/null

    echo "✅ Instalación completada. Puedes usar '$SCRIPT_NAME' en cualquier terminal."
else
    echo "❌ Error: El archivo 'twitter_checker.sh' no existe en el directorio actual."
fi
