#!/bin/bash

# openssl genrsa -aes256 -out ca/private/ca.key.pem 4096

# chmod 400 ca/private/ca.key.pem

# Verifica se o número de argumentos está correto
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <senha>"
    exit 1
fi

SENHA="$1"

openssl genrsa -aes256 \
  -passout pass:"$SENHA" \
  -out "ca/private/ca.key.pem" 4096

chmod 400 "ca/private/ca.key.pem"