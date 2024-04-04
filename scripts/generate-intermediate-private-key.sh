#!/bin/bash

openssl genrsa -aes256 \
  -out ca/intermediate/private/intermediate.key.pem 4096

chmod 400 ca/intermediate/private/intermediate.key.pem