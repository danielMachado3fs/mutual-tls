#!/bin/bash
# Solicitando dados ao usuário
read -p "Informe o path absoluto da sua pasta atual [/root/scripts-server]: " dirname
dirname=${dirname:-/root/scripts-server}

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
# OpenSSL configuration file.

# SHA-1 is deprecated, so use SHA-2 instead.
default_md        = sha256

name_opt          = ca_default
cert_opt          = ca_default
default_days      = 375
preserve          = no
policy            = policy_loose

[ policy_strict ]
# The root CA should only sign intermediate certificates that match.
# See the POLICY FORMAT section of 'man ca'.
countryName             = match
stateOrProvinceName     = match
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ policy_loose ]
# Allow the intermediate CA to sign a more diverse range of certificates.
# See the POLICY FORMAT section of the 'ca' man page.
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ req ]
# Options for the 'req' tool ('man req').
default_bits        = 2048
distinguished_name  = req_distinguished_name
string_mask         = utf8only

# SHA-1 is deprecated, so use SHA-2 instead.
default_md          = sha256

# Extension to add when the -x509 option is used.
x509_extensions     = v3_ca

[ req_distinguished_name ]
# See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name
localityName                    = Locality Name
organizationName                = Organization Name
organizationalUnitName          = Organizational Unit Name
commonName                      = Common Name
emailAddress                    = Email Address

# Optionally, specify some defaults.
countryName_default             = $countryName_default
stateOrProvinceName_default     = $stateOrProvinceName_default
localityName_default            = $localityName_default
organizationName_default        = $organizationName_default
organizationalUnitName_default  = $organizationalUnitName_default
commonName_default              = $commonName_default
emailAddress_default            = $emailAddress_default

[ sans ]
DNS.1 = $alternative_dns
DNS.2 = localhost
IP.1 = $commonIP
IP.2 = 127.0.0.1
email.1 = $emailAddress_default

[ v3_ca ]
# Extensions for a typical CA ('man x509v3_config').
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints       = critical, CA:true
keyUsage               = critical, digitalSignature, cRLSign, keyCertSign
subjectAltName         = @sans

[ crl_ext ]
# Extension for CRLs ('man x509v3_config').
authorityKeyIdentifier=keyid:always

[ ocsp ]
# Extension for OCSP signing certificates ('man ocsp').
basicConstraints       = CA:FALSE
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid,issuer
keyUsage               = critical, digitalSignature
extendedKeyUsage       = critical, OCSPSigning
"

# Escrevendo o conteúdo do arquivo openssl.cnf
echo "$openssl_config" > $dirname/openssl.cnf