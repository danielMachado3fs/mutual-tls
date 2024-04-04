#!/bin/bash

openssl req -config ca/intermediate/openssl.cnf -new -sha256 \
  -key ca/intermediate/private/intermediate.key.pem \
  -out ca/intermediate/csr/intermediate.csr.pem 