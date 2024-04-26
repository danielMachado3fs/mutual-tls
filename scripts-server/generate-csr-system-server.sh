#!/bin/bash
#GERAR CSR UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <folder_path> <server_identifier> <senha>"
    exit 1
fi

FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"
SENHA="$3"

openssl req -new \
    -config "$FOLDER_PATH/output-certs/server/$SERVER_IDENTIFIER/ssl.cnf" \
    -key "$FOLDER_PATH/output-certs/server/$SERVER_IDENTIFIER/mtls-server.key" \
    -out "$FOLDER_PATH/output-certs/server/$SERVER_IDENTIFIER/mtls-server.csr"
    # -passin pass:"$SENHA"