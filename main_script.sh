#!/bin/bash
#FONTE: https://rfsaraujobr.medium.com/mtls-de-uma-forma-amig%C3%A1vel-6506c84c1b7e

#******************************** ATENÇÃO ********************************#
# ANTES DE INICIAR, ENTRE NO ARQUIVO "create-intermediate-openssl-cnf.sh" e 
# "create-intermediate-openssl-cnf.sh" e configure os IPs que utilizarão os certificados.
#******************************** ATENÇÃO ********************************#

######################################################
# PREPARAR OS DIRETÓRIOS
echo "CRIANDO DIRETÓRIOS ========================================================================================"
sh scripts/prepare-directories.sh
echo "==========================================================================================================="

######################################################
#GERANDO O ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf
echo "GERANDO O ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf =========================================================="
source scripts/create-root-openssl-cnf.sh
echo "==========================================================================================================="

######################################################
#GERANDO UM ROOT CA
#CRIA CHAVE PRIVADA ROOT
echo "GERANDO CHAVE PRIVADA ROOT ================================================================================"
source scripts/generate-root-private-key.sh
echo "==========================================================================================================="

#CRIA CERTIFICADO DO ROOT
echo "GERANDO CERTIFICADO DO ROOT ==============================================================================="
source scripts/generate-root-cert.sh
echo "==========================================================================================================="

######################################################
#GERANDO O ARQUIVO ca/intermediate/openssl.cnf
echo "GERANDO O ARQUIVO ca/intermediate/openssl.cnf ============================================================="
source scripts/create-intermediate-openssl-cnf.sh
echo "==========================================================================================================="

######################################################
#GERANDO UM CERTIFICADO DE AUTORIDADE INTERMEDIÁRIO
#GERANDO UMA CHAVE INTERMEDIÁRIA
echo "GERANDO UMA CHAVE INTERMEDIÁRIA ==========================================================================="
source scripts/generate-intermediate-private-key.sh
echo "==========================================================================================================="

#GERANDO UM CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR)
echo "GERANDO UM CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ================================================="
source scripts/generate-intermediate-csr.sh
echo "==========================================================================================================="

#GERANDO UM CERTIFICADO INTERMEDIÁRIO
echo "GERANDO UM CERTIFICADO INTERMEDIÁRIO ======================================================================"
source scripts/generate-intermediate-cert.sh
echo "==========================================================================================================="

#VERIFICANDO SE O CERTIFICADO INTERMEDIÁRIO É VÁLIDO ATRAVÉS DO ROOT
echo "VERIFICANDO SE O CERTIFICADO INTERMEDIÁRIO É VÁLIDO ATRAVÉS DO ROOT ======================================="
source scripts/intermediate-check-valid.sh
echo "==========================================================================================================="

######################################################
#GERANDO CADEIA DE CONFIANÇA ATRAVÉS DO ROOT E DO CA
echo "GERANDO CADEIA DE CONFIANÇA ATRAVÉS DO ROOT E DO CA ======================================================="
sh scripts/generate-ca-chain.sh
echo "==========================================================================================================="

######################################################
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

#Após gerar o certificado do cervidor, é necessário rodar apenas o script client_certs_generate.sh para gerar
#os certificados para os clients sem a necessidade de rodar o main_script.sh novamente.