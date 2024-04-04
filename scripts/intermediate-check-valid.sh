#!/bin/bash

openssl verify -CAfile ca/certs/ca.cert.pem \
  ca/intermediate/certs/intermediate.cert.pem