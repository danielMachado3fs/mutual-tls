#!/bin/bash
#GERAR KEY UTILIZANDO A SENHA PASSADA COMO PARAMETRO
# Verifica se o número de argumentos está correto
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <folder_path> <server_identifier> <senha>"
    exit 1
fi

FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"
SENHA="$3"

openssl genpkey \
  -out "$FOLDER_PATH/output-certs/server/$SERVER_IDENTIFIER/mtls-server.key" \
  -algorithm RSA \
  -pkeyopt rsa_keygen_bits:2048 \
  -aes256 
  # -pass pass:"$SENHA" \

chmod 400 "$FOLDER_PATH/output-certs/server/$SERVER_IDENTIFIER/mtls-server.key"