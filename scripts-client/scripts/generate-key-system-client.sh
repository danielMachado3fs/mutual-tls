#!/bin/bash
# URL=$1

# openssl genrsa -aes256 \
#   -out ca/intermediate/private/$URL.key.pem 2048

# chmod 400 ca/intermediate/private/$URL.key.pem

#GERAR KEY UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <FOLDER_PATH> <URL> <senha>"
    exit 1
fi

FOLDER_PATH="$1"
URL="$2"
SENHA="$3"

openssl genrsa -aes256 \
  -passout pass:"$SENHA" \
  -out "$FOLDER_PATH/output/$URL.key.pem" 2048

chmod 400 "$FOLDER_PATH/output/$URL.key.pem"