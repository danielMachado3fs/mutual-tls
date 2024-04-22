#!/bin/bash

echo "GERANDO E ASSINANDO CERTIFICADO E CHAVE PARA SEREM UTILIZADOS NO CLIENT ==================================="
read -p "Informe domínio do client ou o nome do arquivo csr: " dominio
dominio=${dominio:-minhaempresa.com.br}
read -p "Informe a senha da intermediate-key [pass@intermediateKey]: " passIntermediateKey
passIntermediateKey=${passIntermediateKey:-pass@intermediateKey}

# #ASSINANDO O CSR DO CLIENT PARA GERAR O .cert
echo "ASSINANDO O CSR DO CLIENT PARA GERAR O .cert =============================================================="
source scripts/csr-client-sign.sh $dominio $passIntermediateKey
echo "==========================================================================================================="

# #VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA
echo "VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert-client.sh $dominio
echo "==========================================================================================================="