#!/bin/bash

echo "ASSINANDO CSR DO CLIENT ==================================="
read -p "Informe domínio do client ou o nome do arquivo csr: " dominio
dominio=${dominio:-minhaempresa.com.br}
read -p "Informe a senha da intermediate-key [pass@Intermediate!RootCA]: " passIntermediateKey
passIntermediateKey=${passIntermediateKey:-pass@Intermediate!RootCA}
read -p "Informe o path do diretório csr do cliente [mutual-tls/scripts-client/output]: " pathCSR
pathCSR=${pathCSR:-mutual-tls/scripts-client/output}
read -p "Informe o path do diretório arquivo de configuração openssl.cnf intermediário [ca/intermediate]: " pathIntermediate
pathIntermediate=${pathIntermediate:-ca/intermediate}
read -p "Informe o path do diretório da ca-chain [ca/intermediate/certs]: " pathcachain
pathcachain=${pathcachain:-ca/intermediate/certs}

# #ASSINANDO O CSR DO CLIENT PARA GERAR O .cert
echo "ASSINANDO O CSR DO CLIENT PARA GERAR O .cert =============================================================="
source scripts/csr-client-sign.sh $dominio $passIntermediateKey $pathCSR $pathIntermediate
echo "==========================================================================================================="

# #VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA
echo "VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert-client.sh $dominio $pathCSR $pathcachain
echo "==========================================================================================================="