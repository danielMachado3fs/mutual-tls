#!/bin/bash

cat ca/intermediate/certs/intermediate.cert.pem \
  ca/certs/ca.cert.pem > ca/intermediate/certs/ca-chain.cert.pem
chmod 444 ca/intermediate/certs/ca-chain.cert.pem