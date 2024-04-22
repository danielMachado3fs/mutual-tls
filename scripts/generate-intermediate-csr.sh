#!/bin/bash

# openssl req -config ca/intermediate/openssl.cnf -new -sha256 \
#   -key ca/intermediate/private/intermediate.key.pem \
#   -out ca/intermediate/csr/intermediate.csr.pem 

# Verifica se o número de argumentos está correto
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <senha>"
    exit 1
fi

SENHA="$1"

openssl req -config ca/intermediate/openssl.cnf -new -sha256 \
  -passin pass:"$SENHA" \
  -key "ca/intermediate/private/intermediate.key.pem" \
  -out "ca/intermediate/csr/intermediate.csr.pem"