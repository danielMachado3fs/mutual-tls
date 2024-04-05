#!/bin/bash

openssl ca -config ca/openssl.cnf -extensions v3_intermediate_ca \
  -days 3650 -notext -md sha256 \
  -in ca/intermediate/csr/intermediate.csr.pem \
  -out ca/intermediate/certs/intermediate-ca.cert.pem

chmod 444 ca/intermediate/certs/intermediate-ca.cert.pem