#!/bin/bash
# URL=$1

# openssl genrsa -aes256 \
#   -out ca/intermediate/private/$URL.key.pem 2048

# chmod 400 ca/intermediate/private/$URL.key.pem

#GERAR KEY UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <URL> <senha>"
    exit 1
fi

URL="$1"
SENHA="$2"

openssl genrsa -aes256 \
  -passout pass:"$SENHA" \
  -out "ca/intermediate/server/$URL/private/$URL.key.pem" 2048

chmod 400 "ca/intermediate/server/$URL/private/$URL.key.pem"