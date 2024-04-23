#!/bin/bash
# URL=$1

# openssl ca -config ca/intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 \
#   -in ca/intermediate/csr/$URL.csr.pem \
#   -out ca/intermediate/certs/$URL.cert.pem

# chmod 444 ca/intermediate/certs/$URL.cert.pem

#ASSINAR CSR UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 4 ]; then
    echo "Uso: $0 <URL> <senha> <pathcsr> <pathsslconf>"
    exit 1
fi

URL="$1"
SENHA="$2"
PATHCSR="$3"
PATHSSLCONF="$4"

openssl ca -config $PATHSSLCONF/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 \
  -passin pass:"$SENHA" \
  -in "$PATHCSR/$URL.csr.pem" \
  -out "$PATHCSR/$URL.cert.pem"

chmod 444 "$PATHCSR/$URL.cert.pem"