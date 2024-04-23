#!/bin/bash

echo "ASSINANDO CSR DO SERVER ==================================="
read -p "Informe domínio do server ou o nome do arquivo csr: " dominio
dominio=${dominio:-minhaempresa.com.br}
read -p "Informe a senha da intermediate-key [pass@Intermediate!RootCA]: " passIntermediateKey
passIntermediateKey=${passIntermediateKey:-pass@Intermediate!RootCA}
read -p "Informe o path do diretório csr do server [/root/mutual-tls/scripts-server/output]: " pathCSR
pathCSR=${pathCSR:-/mutual-tls/scripts-server/output}
read -p "Informe o path do diretório arquivo de configuração openssl.cnf intermediário [ca/intermediate]: " pathIntermediate
pathIntermediate=${pathIntermediate:-ca/intermediate}
read -p "Informe o path do diretório da ca-chain [/root/mutual-tls/ca/intermediate/certs]: " pathcachain
pathcachain=${pathcachain:-/root/mutual-tls/ca/intermediate/certs}

# #ASSINANDO O CSR DO SERVER PARA GERAR O .cert
echo "ASSINANDO O CSR DO SERVER PARA GERAR O .cert =============================================================="
source scripts/csr-server-sign.sh $dominio $passIntermediateKey $pathCSR $pathIntermediate
echo "==========================================================================================================="

# #VERIFICANDO SE O CERTIFICADO DO SERVER É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA
echo "VERIFICANDO SE O CERTIFICADO DO SERVER É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert-server.sh $dominio $pathCSR $pathcachain
echo "==========================================================================================================="