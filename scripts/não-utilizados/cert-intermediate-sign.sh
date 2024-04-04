#!/bin/bash

openssl ca -config ca/intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 \
  -in ca/intermediate/csr/gateway.appmarketing.com.br.csr.pem \
  -out ca/intermediate/certs/gateway.appmarketing.com.br.cert.pem

chmod 444 ca/intermediate/certs/gateway.appmarketing.com.br.cert.pem