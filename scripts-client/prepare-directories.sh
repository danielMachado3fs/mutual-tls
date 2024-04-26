#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <folder_path> <server_identifier> <client_identifier>"
    exit 1
fi
FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"
CLIENT_IDENTIFIER="$3"

if [ ! -d "$FOLDER_PATH/output-certs" ]; then
    mkdir -p "$FOLDER_PATH/output-certs"
fi

cd $FOLDER_PATH/output-certs
if [ ! -d "$FOLDER_PATH/output-certs/clients" ]; then
  mkdir clients
fi

cd $FOLDER_PATH/output-certs/clients
if [ ! -d "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER" ]; then
  mkdir $SERVER_IDENTIFIER
fi

cd $FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER
if [ ! -d "$FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER" ]; then
  mkdir $CLIENT_IDENTIFIER
  chmod 700 $CLIENT_IDENTIFIER
fi