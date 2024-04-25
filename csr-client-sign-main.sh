#!/bin/bash

echo ""
echo "******************************************************* ATENÇÃO *******************************************************"
echo ""
echo "LEMBRE-SE DE CONFIGURAR OS SANs REFERENTE A EXTENÇÃO [sans_user] NO ARQUIVO DE CONFIGURAÇÃO DA INTERMEDIATE CA (openssl.cnf)"
echo ""
echo "******************************************************* ATENÇÃO *******************************************************"
echo ""
echo "ASSINANDO CSR DO CLIENT ==================================================================================="
read -p "Informe domínio do client ou o nome do arquivo csr: " dominio
dominio=${dominio:-minhaempresa.com.br}
read -p "Informe a senha da intermediate-key [pass@Intermediate!RootCA]: " passIntermediateKey
passIntermediateKey=${passIntermediateKey:-pass@Intermediate!RootCA}
read -p "Informe o path do diretório csr do cliente [root/mutual-tls/scripts-client/output]: " pathCSR
pathCSR=${pathCSR:-/root/mutual-tls/scripts-client/output}
read -p "Informe o path do diretório arquivo de configuração openssl.cnf intermediário [ca/intermediate]: " pathIntermediate
pathIntermediate=${pathIntermediate:-ca/intermediate}
read -p "Informe o path do diretório da ca-chain [root/mutual-tls/ca/intermediate/certs]: " pathcachain
pathcachain=${pathcachain:-/root/mutual-tls/ca/intermediate/certs}

# #ASSINANDO O CSR DO CLIENT PARA GERAR O .cert
echo "ASSINANDO O CSR DO CLIENT PARA GERAR O .cert =============================================================="
source scripts/csr-client-sign.sh $dominio $passIntermediateKey $pathCSR $pathIntermediate
echo "==========================================================================================================="

# #VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA
echo "VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert-client.sh $dominio $pathCSR $pathcachain
echo "==========================================================================================================="