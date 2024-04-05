#!/bin/bash
#GERANDO E ASSINANDO CERTIFICADO PARA SER UTILIZADO NO SERVER
echo "GERANDO E ASSINANDO CERTIFICADO E CHAVE PARA SEREM UTILIZADOS NO SERVER =================================="
read -p "Informe domínio do server. Será utilizado no nome dos arquivos gerados [minhaempresa.com.br]: " dominio
dominio=${dominio:-minhaempresa.com.br}

#GERANDO CHAVE
echo "GERANDO CHAVE PRIVADA ====================================================================================="
source scripts/generate-key-system.sh $dominio
echo "==========================================================================================================="

#GERANDO CERTIFICADO
echo "GERANDO CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) >>>>>>> (INFORMAR SENHA DA KEY ANTERIOR) >>>>>>>===="
source scripts/generate-csr-system.sh $dominio
echo "==========================================================================================================="

#ASSINANDO O CSR DO SERVER PARA GERAR O .cert
echo "ASSINANDO O CSR DO SERVER PARA GERAR O .cert >>>>>>> (INFORMAR SENHA DO INTERMEDIATE KEY) >>>>>>> ========="
source scripts/csr-server-sign.sh $dominio
echo "==========================================================================================================="

#VERIFICANDO SE O CERTIFICADO DO SERVER É VÁLIDO ATRAVÉS DO ROOT
echo "VERIFICANDO SE O CERTIFICADO DO SERVER É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert.sh $dominio
echo "==========================================================================================================="