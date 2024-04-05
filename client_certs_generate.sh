#!/bin/bash
#GERANDO E ASSINANDO CERTIFICADO PARA SER UTILIZADO NO CLIENT
echo "GERANDO E ASSINANDO CERTIFICADO E CHAVE PARA SEREM UTILIZADOS NO CLIENT ==================================="
read -p "Informe domínio do client. Será utilizado no nome dos arquivos gerados [minhaempresa.com.br]: " dominio
dominio=${dominio:-minhaempresa.com.br}

#GERANDO CHAVE
echo "GERANDO CHAVE PRIVADA ====================================================================================="
source scripts/generate-key-system.sh $dominio
echo "==========================================================================================================="

#GERANDO CERTIFICADO (CSR)
echo "GERANDO CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ===================================================="
source scripts/generate-csr-system.sh $dominio
echo "==========================================================================================================="

#ASSINANDO O CSR DO CLIENT PARA GERAR O .cert
echo "ASSINANDO O CSR DO CLIENT PARA GERAR O .cert >>>>>>> (INFORMAR SENHA DO INTERMEDIATE KEY) >>>>>>> ========="
source scripts/csr-client-sign.sh $dominio
echo "==========================================================================================================="

#VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA
echo "VERIFICANDO SE O CERTIFICADO DO CLIENT É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert.sh $dominio
echo "==========================================================================================================="