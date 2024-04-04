#!/bin/bash

openssl req -config ca/openssl.cnf \
      -key ca/private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out ca/certs/ca.cert.pem

chmod 444 ca/certs/ca.cert.pem