#!/bin/bash

# openssl genrsa -aes256 \
#   -out ca/intermediate/private/intermediate.key.pem 4096

# chmod 400 ca/intermediate/private/intermediate.key.pem

# Verifica se o número de argumentos está correto
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <senha>"
    exit 1
fi

SENHA="$1"

openssl genrsa -aes256 \
  -passout pass:"$SENHA" \
  -out "ca/intermediate/private/intermediate.key.pem" 4096

chmod 400 "ca/intermediate/private/intermediate.key.pem"