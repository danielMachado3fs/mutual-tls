#!/bin/bash
#GERAR KEY UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 4 ]; then
    echo "Uso: $0 <folder_path> <server_identifier> <client_identifier> <senha>"
    exit 1
fi

FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"
CLIENT_IDENTIFIER="$3"
SENHA="$4"

openssl genpkey \
  -out "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER/mtls-client.key" \
  -algorithm RSA \
  -pkeyopt rsa_keygen_bits:2048 \
  -aes256 \
  # -pass pass:"$SENHA" \

chmod 400 "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER/mtls-client.key"