#!/bin/bash

mkdir ca
cd ca
mkdir intermediate
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

cd intermediate
mkdir certs crl csr newcerts private clients server
chmod 700 private
touch index.txt
echo 1000 > serial
echo 1000 > crlnumber