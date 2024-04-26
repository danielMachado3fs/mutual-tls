#!/bin/bash
# Fonte: https://jamielinux.com/docs/openssl-certificate-authority/appendix/root-configuration-file.html
# Solicitando dados ao usuário
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <folder_path> <server_identifier> <client_identifier>"
    exit 1
fi
FOLDER_PATH="$1"
SERVER_IDENTIFIER="$2"
CLIENT_IDENTIFIER="$3"

read -p "Informe o código do país [BR]: " countryName_default
countryName_default=${countryName_default:-BR}

read -p "Informe o estado ou província [Minas Gerais]: " stateOrProvinceName_default
stateOrProvinceName_default=${stateOrProvinceName_default:-Minas Gerais}

read -p "Informe a cidade [Timoteo]: " localityName_default
localityName_default=${localityName_default:-Timoteo}

read -p "Informe o nome da empresa [Minha Empresa]: " organizationName_default
organizationName_default=${organizationName_default:-Minha Empresa}

read -p "Informe o nome da unidade organizacional [Departamento de TI]: " organizationalUnitName_default
organizationalUnitName_default=${organizationalUnitName_default:-Departamento de TI}

read -p "Informe o domínio (Common Name (CN)) [minhaempresa.com.br]: " commonName_default
commonName_default=${commonName_default:-minhaempresa.com.br}

read -p "Informe o endereço de Email [suporte@minhaempresa.com.br]: " emailAddress_default
emailAddress_default=${emailAddress_default:-suporte@minhaempresa.com.br}

read -p "Informe o IP [10.0.0.1]: " commonIP
commonIP=${commonIP:-10.0.0.1}

read -p "Tem algum outro domínio que pode ser validade pelo certificado? [$commonName_default]: " alternative_dns
alternative_dns=${alternative_dns:-$commonName_default}

# Definindo o conteúdo do arquivo openssl.cnf
openssl_config="

[ req ]
prompt              = no
distinguished_name  = req_distinguished_name
req_extensions      = ext

[ req_distinguished_name ]
# See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
# countryName (C)                 = Country Name (2 letter code)
# stateOrProvinceName (ST)        = State or Province Name
# localityName (L)                = Locality Name
# organizationName (O)            = Organization Name
# organizationalUnitName (OU)     = Organizational Unit Name
# commonName (CN)                 = Common Name
# emailAddress (emailAddress)     = Email Address
C                                 = $countryName_default
ST                                = $stateOrProvinceName_default
L                                 = $localityName_default
O                                 = $organizationName_default
OU                                = $organizationalUnitName_default
CN                                = $commonName_default
emailAddress                      = $emailAddress_default

[ ext ]
subjectAltName         = DNS:$alternative_dns,DNS:localhost,IP:$commonIP,IP:127.0.0.1
"

# Escrevendo o conteúdo do arquivo openssl.cnf
echo "$openssl_config" > $FOLDER_PATH/output-certs/clients/$SERVER_IDENTIFIER/$CLIENT_IDENTIFIER/ssl.cnf