#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <path_client>"
    exit 1
fi

FOLDER_PATH="$1"

# Verifica se o diretório ca/intermediate/clients existe
if [ ! -d "$FOLDER_PATH/output" ]; then
    mkdir -p "$FOLDER_PATH/output"
fi

chmod 700 $FOLDER_PATH/output