#!/bin/bash
URL=$1

openssl verify -CAfile ca/intermediate/certs/ca-chain.cert.pem ca/intermediate/server/$URL/certs/$URL.cert.pem