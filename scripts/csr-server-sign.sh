#!/bin/bash
# URL=$1

# openssl ca -config ca/intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 \
#   -in ca/intermediate/csr/$URL.csr.pem \
#   -out ca/intermediate/certs/$URL.cert.pem

# chmod 444 ca/intermediate/certs/$URL.cert.pem

#ASSINAR CSR UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <URL> <senha>"
    exit 1
fi

URL="$1"
SENHA="$2"

openssl ca -config ca/intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 \
  -passin pass:"$SENHA" \
  -in "ca/intermediate/server/$URL/csr/$URL.csr.pem" \
  -out "ca/intermediate/server/$URL/certs/$URL.cert.pem"

chmod 444 "ca/intermediate/server/$URL/certs/$URL.cert.pem"