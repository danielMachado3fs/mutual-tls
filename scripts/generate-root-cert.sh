#!/bin/bash

# openssl req -config ca/openssl.cnf \
#       -key ca/private/ca.key.pem \
#       -new -x509 -days 7300 -sha256 -extensions v3_ca \
#       -out ca/certs/ca.cert.pem

# chmod 444 ca/certs/ca.cert.pem

# Verifica se o número de argumentos está correto
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <senha>"
    exit 1
fi

SENHA="$1"

openssl req -config ca/openssl.cnf \
      -passin pass:"$SENHA" \
      -key "ca/private/ca.key.pem" \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out "ca/certs/ca.cert.pem"

chmod 444 "ca/certs/ca.cert.pem"