#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <path_client>"
    exit 1
fi

PATH_SERVER="$1"

# Verifica se o diretório ca/intermediate/server existe
if [ ! -d "ca/intermediate/server" ]; then
    mkdir -p "ca/intermediate/server"
fi

cd ca/intermediate/server || exit
mkdir $PATH_SERVER
cd $PATH_SERVER
mkdir certs csr private
chmod 700 private