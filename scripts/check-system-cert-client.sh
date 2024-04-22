#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <URL> <pathcsr> <pathcachain>"
    exit 1
fi

URL="$1"
PATHCSR="$2"
PATHCACHAIN="$3"

openssl verify -CAfile $PATHCACHAIN/ca-chain.cert.pem $PATHCSR/$URL.cert.pem