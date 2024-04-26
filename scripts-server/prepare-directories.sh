#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <folder_path> <server_identifier>"
    exit 1
fi
FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"

if [ ! -d "$FOLDER_PATH/output-certs" ]; then
    mkdir -p "$FOLDER_PATH/output-certs"
fi

cd $FOLDER_PATH/output-certs
if [ ! -d "$FOLDER_PATH/output-certs/server" ]; then
  mkdir server
fi

cd $FOLDER_PATH/output-certs/server
if [ ! -d "$FOLDER_PATH/output-certs/server/$SERVER_IDENTIFIER" ]; then
  mkdir $SERVER_IDENTIFIER
  chmod 700 $SERVER_IDENTIFIER
fi