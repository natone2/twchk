#!/bin/bash

# Verifica si se pasaron argumentos
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 usuario fecha_inicio fecha_fin"
    echo "Ejemplo: $0 usuario 2023-01-01 2023-01-31"
    exit 1
fi

USER=$1
SINCE=$2
UNTIL=$3

# Construye la URL de búsqueda
QUERY="from:$USER since:$SINCE until:$UNTIL"
URL="https://nitter.net/search?f=tweets&q=${QUERY// /%20}"

echo "Buscando tweets de @$USER entre $SINCE y $UNTIL..."
echo "URL: $URL"

# Realiza la búsqueda con curl y extrae información básica
curl -s "$URL" | grep -Eo '/$USER/status/[0-9]+' | sort -u | while read -r tweet; do
    echo "https://nitter.net$tweet"
done
