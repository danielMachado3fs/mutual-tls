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

echo "############################################ GERANDO UM ROOT CA ############################################"
######################################################
#GERANDO O ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf
echo "GERANDO O ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf =========================================================="
source scripts/create-root-openssl-cnf.sh
echo "==========================================================================================================="

######################################################
#GERANDO UM ROOT CA
read -p "Informe a senha para a key do rootCa [pass@RootCA]: " passRootCA
passRootCA=${passRootCA:-pass@RootCA},
#CRIA CHAVE PRIVADA ROOT
echo "GERANDO CHAVE PRIVADA ROOT ================================================================================"
source scripts/generate-root-private-key.sh $passRootCA
echo "==========================================================================================================="

#CRIA CERTIFICADO DO ROOT
echo "GERANDO CERTIFICADO DO ROOT ==============================================================================="
source scripts/generate-root-cert.sh $passRootCA
echo "==========================================================================================================="

echo ""
echo ""
echo "######################################## GERANDO UM INTERMEDIATE CA ########################################"
######################################################
#GERANDO O ARQUIVO ca/intermediate/openssl.cnf
echo "GERANDO O ARQUIVO ca/intermediate/openssl.cnf ============================================================="
source scripts/create-intermediate-openssl-cnf.sh
echo "==========================================================================================================="

######################################################
#GERANDO UM CERTIFICADO DE AUTORIDADE INTERMEDIÁRIO
read -p "Informe a senha para a key do intermediate-rootCa [pass@Intermediate!RootCA]: " passIntermediateRootCA
passIntermediateRootCA=${passIntermediateRootCA:-pass@Intermediate!RootCA}
#GERANDO UMA CHAVE INTERMEDIÁRIA
echo "GERANDO UMA CHAVE INTERMEDIÁRIA ==========================================================================="
source scripts/generate-intermediate-private-key.sh $passIntermediateRootCA
echo "==========================================================================================================="

#GERANDO UM CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR)
echo "GERANDO UM CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ================================================="
source scripts/generate-intermediate-csr.sh $passIntermediateRootCA
echo "==========================================================================================================="

#GERANDO UM CERTIFICADO INTERMEDIÁRIO
echo "GERANDO UM CERTIFICADO INTERMEDIÁRIO ======================================================================"
source scripts/generate-intermediate-cert.sh $passRootCA
echo "==========================================================================================================="

#VERIFICANDO SE O CERTIFICADO INTERMEDIÁRIO É VÁLIDO ATRAVÉS DO ROOT
echo "VERIFICANDO SE O CERTIFICADO INTERMEDIÁRIO É VÁLIDO ATRAVÉS DO ROOT ======================================="
source scripts/intermediate-check-valid.sh
echo "==========================================================================================================="

echo ""
echo ""
echo "################################## GERANDO A CADEIA DE CONFIANÇA CA-CHAIN ##################################"
######################################################
#GERANDO CADEIA DE CONFIANÇA ATRAVÉS DO ROOT E DO CA
echo "GERANDO CADEIA DE CONFIANÇA ATRAVÉS DO ROOT E DO CA ======================================================="
sh scripts/generate-ca-chain.sh
echo "==========================================================================================================="