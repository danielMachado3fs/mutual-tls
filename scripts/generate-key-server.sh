#!/bin/bash
URL=$1

openssl genrsa -aes256 \
  -out ca/intermediate/private/$URL.key.pem 2048

chmod 400 ca/intermediate/private/$URL.key.pem