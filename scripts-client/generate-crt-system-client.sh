#!/bin/bash
#GERAR CSR UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 4 ]; then
    echo "Uso: $0 <folder_path> <server_identifier> <client_identifier> <senha>"
    exit 1
fi

FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"
CLIENT_IDENTIFIER="$3"
SENHA="$4"

openssl x509 \
    -req -days 365 \
    -in "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER/mtls-client.csr" \
    -signkey "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER/mtls-client.key" \
    -out "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER/mtls-client.crt"
    # -passin pass:"$SENHA"