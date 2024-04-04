#!/bin/bash
#FONTE: https://rfsaraujobr.medium.com/mtls-de-uma-forma-amig%C3%A1vel-6506c84c1b7e

#******************************** ATENÇÃO ********************************#
# ANTES DE INICIAR, ENTRE NO ARQUIVO "create-intermediate-openssl-cnf.sh" e 
# "create-intermediate-openssl-cnf.sh" e configure os IPs que utilizarão os certificados.
#******************************** ATENÇÃO ********************************#

######################################################
# PREPARAR OS DIRETÓRIOS
echo "CRIANDO DIRETÓRIOS ======================================================================="
sh scripts/prepare-directories.sh
echo "======================================================================= DIRETÓRIOS CRIADOS"

######################################################
#GERANDO O ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf
echo "GERANDO O ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf ========================================="
source scripts/create-root-openssl-cnf.sh
echo "================================ ARQUIVO DE CONFIGURAÇÃO ca/openssl.cnf CRIADO COM SUCESSO"

######################################################
#GERANDO UM ROOT CA
#CRIA CHAVE PRIVADA ROOT
echo "GERANDO CHAVE PRIVADA ROOT ==============================================================="
source scripts/generate-root-private-key.sh
echo "==================================================== CHAVE PRIVADA ROOT CRIADA COM SUCESSO"

#CRIA CERTIFICADO DO ROOT
echo "GERANDO CERTIFICADO DO ROOT =============================================================="
source scripts/generate-root-cert.sh
echo "=================================================== CERTIFICADO DO ROOT CRIADO COM SUCESSO"

######################################################
#GERANDO O ARQUIVO ca/intermediate/openssl.cnf
echo "GERANDO O ARQUIVO ca/intermediate/openssl.cnf ============================================"
source scripts/create-intermediate-openssl-cnf.sh
echo "=================================== ARQUIVO ca/intermediate/openssl.cnf CRIADO COM SUCESSO"

######################################################
#GERANDO UM CERTIFICADO DE AUTORIDADE INTERMEDIÁRIO
#GERANDO UMA CHAVE INTERMEDIÁRIA
echo "GERANDO UMA CHAVE INTERMEDIÁRIA =========================================================="
source scripts/generate-intermediate-private-key.sh
echo "=================================================== CHAVE INTERMEDIÁRIA CRIADA COM SUCESSO"

#GERANDO UM CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR)
echo "GERANDO UM CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ================================"
source scripts/generate-intermediate-csr.sh
echo "======================== CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) CRIADO COM SUCESSO"

#GERANDO UM CERTIFICADO INTERMEDIÁRIO
echo "GERANDO UM CERTIFICADO INTERMEDIÁRIO ====================================================="
source scripts/generate-intermediate-cert.sh
echo "============================================= CERTIFICADO INTERMEDIÁRIO CRIADO COM SUCESSO"

#VERIFICANDO SE O CERTIFICADO INTERMEDIÁRIO É VÁLIDO ATRAVÉS DO ROOT
echo "VERIFICANDO SE O CERTIFICADO INTERMEDIÁRIO É VÁLIDO ATRAVÉS DO ROOT ======================"
source scripts/intermediate-check-valid.sh
echo "========================================= CERTIFICADO INTERMEDIÁRIO VERIFICADO COM SUCESSO"

######################################################
#GERANDO CADEIA DE CONFIANÇA ATRAVÉS DO ROOT E DO CA
echo "GERANDO CADEIA DE CONFIANÇA ATRAVÉS DO ROOT E DO CA ======================================"
sh scripts/generate-ca-chain.sh
echo "=================================================== CADEIA DE CONFIANÇA CRIADA COM SUCESSO"