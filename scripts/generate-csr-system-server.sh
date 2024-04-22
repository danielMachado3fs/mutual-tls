#!/bin/bash
# URL=$1

# openssl req -config ca/intermediate/openssl.cnf \
#       -key ca/intermediate/private/$URL.key.pem \
#       -new -sha256 -out ca/intermediate/csr/$URL.csr.pem

#GERAR CSR UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <URL> <senha>"
    exit 1
fi

URL="$1"
SENHA="$2"

openssl req -config ca/intermediate/openssl.cnf \
      -passin pass:"$SENHA" \
      -key "ca/intermediate/server/$URL/private/$URL.key.pem" \
      -new -sha256 -out "ca/intermediate/server/$URL/csr/$URL.csr.pem"