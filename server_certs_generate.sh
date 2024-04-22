#!/bin/bash
#GERANDO E ASSINANDO CERTIFICADO PARA SER UTILIZADO NO SERVER
echo "###################################### GERANDO CERTIFICADO DO SERVER ######################################"
######################################################
#GERANDO E ASSINANDO CERTIFICADO PARA SER UTILIZADO NO SERVER
echo "GERANDO E ASSINANDO CERTIFICADO E CHAVE PARA SEREM UTILIZADOS NO SERVER =================================="
read -p "Informe domínio do server. Será utilizado no nome dos arquivos gerados [minhaempresa.com.br]: " dominio
dominio=${dominio:-minhaempresa.com.br}
read -p "Informe a senha da key [pass@key]: " pass
pass=${pass:-pass@key}
read -p "Informe a senha da intermediate-key [pass@intermediateKey]: " passIntermediateKey
passIntermediateKey=${passIntermediateKey:-pass@intermediateKey}

# PREPARAR OS DIRETÓRIOS
echo "CRIANDO DIRETÓRIOS ========================================================================================"
sh scripts/prepare-directories-server.sh $dominio
echo "==========================================================================================================="

#GERANDO CHAVE
echo "GERANDO CHAVE PRIVADA ====================================================================================="
source scripts/generate-key-system-server.sh $dominio $pass
echo "==========================================================================================================="

#GERANDO CERTIFICADO
echo "GERANDO CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ===================================================="
source scripts/generate-csr-system-server.sh $dominio $pass
echo "==========================================================================================================="

#ASSINANDO O CSR DO SERVER PARA GERAR O .cert
echo "ASSINANDO O CSR DO SERVER PARA GERAR O .cert =============================================================="
source scripts/csr-server-sign.sh $dominio $passIntermediateKey
echo "==========================================================================================================="

#VERIFICANDO SE O CERTIFICADO DO SERVER É VÁLIDO ATRAVÉS DO ROOT
echo "VERIFICANDO SE O CERTIFICADO DO SERVER É VÁLIDO ATRAVÉS DA CADEIA DE CONFIANÇA ROOT - CA =================="
source scripts/check-system-cert-server.sh $dominio
echo "==========================================================================================================="

# Script "main_script.sh" gerará a rootCA e a intermediateCA que será utilizada para assinar os CSR dos clientes.
# Após gerar o certificado do cervidor, é necessário rodar apenas o scripts-client/client_certs_generate.sh para gerar
# a key e o csr dos clients sem a necessidade de rodar o main_script.sh novamente.
# A pasta script-client é ideal para enviar para o cliente para que ele gere sua KEY e seu CSR. Posteriormente ele deve
# enviar o CSR para a empresa assinar com o rootCA gerar o certificado que o cliente usará nas requisições.
# O servidor deve gerar seu pŕoprio CSR apenas se desejar que o cliente tambem verifique o certificado do servidor
# nas requisições.