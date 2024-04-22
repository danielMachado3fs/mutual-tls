#!/bin/bash
# URL=$1

# openssl req -config ca/intermediate/openssl.cnf \
#       -key ca/intermediate/private/$URL.key.pem \
#       -new -sha256 -out ca/intermediate/csr/$URL.csr.pem

#GERAR CSR UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <FOLDER_PATH> <URL> <senha>"
    exit 1
fi
# if [ "$#" -ne 2 ]; then
#     echo "Uso: $0 <URL> <senha>"
#     exit 1
# fi

FOLDER_PATH="$1"
URL="$2"
SENHA="$3"

openssl req -config $FOLDER_PATH/openssl.cnf \
      -passin pass:"$SENHA" \
      -key "$FOLDER_PATH/output/$URL.key.pem" \
      -new -sha256 -out "$FOLDER_PATH/output/$URL.csr.pem"

# openssl req -passin pass:"$SENHA" \
#       -key "$FOLDER_PATH/output/$URL.key.pem" \
#       -new -sha256 -out "$FOLDER_PATH/output/$URL.csr.pem"