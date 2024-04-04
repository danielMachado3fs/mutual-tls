#!/bin/bash
URL=$1

openssl ca -config ca/intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 \
  -in ca/intermediate/csr/$URL.csr.pem \
  -out ca/intermediate/certs/$URL.cert.pem

chmod 444 ca/intermediate/certs/$URL.cert.pem