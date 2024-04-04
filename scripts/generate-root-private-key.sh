#!/bin/bash

openssl genrsa -aes256 -out ca/private/ca.key.pem 4096
#appmarketing
chmod 400 ca/private/ca.key.pem