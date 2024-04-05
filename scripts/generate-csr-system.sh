#!/bin/bash
URL=$1

openssl req -config ca/intermediate/openssl.cnf \
      -key ca/intermediate/private/$URL.key.pem \
      -new -sha256 -out ca/intermediate/csr/$URL.csr.pem