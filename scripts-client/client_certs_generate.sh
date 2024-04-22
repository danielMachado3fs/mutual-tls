#!/bin/bash
echo "GERANDO KEY E CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ============================================="
read -p "Informe o path absoluto da sua pasta atual [/root]: " dirname
dirname=${dirname:-/root}
read -p "Informe o seu domínio que também será utilizado para nomear os arquivos [minhaempresa.com.br]: " dominio
dominio=${dominio:-minhaempresa.com.br}
read -p "Informe a senha da key [pass@key]: " pass
pass=${pass:-pass@key}

# PREPARAR OS DIRETÓRIOS
echo "CRIANDO DIRETÓRIOS ========================================================================================"
sh $dirname/scripts/prepare-directories-client.sh $dirname
echo "==========================================================================================================="

#GERANDO O ARQUIVO DE CONFIGURAÇÃO openssl.cnf
echo "GERANDO O ARQUIVO DE CONFIGURAÇÃO openssl.cnf =========================================================="
source $dirname/scripts/create-openssl-cnf.sh
echo "==========================================================================================================="

#GERANDO CHAVE
echo "GERANDO CHAVE PRIVADA ====================================================================================="
source $dirname/scripts/generate-key-system-client.sh $dirname $dominio $pass
echo "==========================================================================================================="

#GERANDO CERTIFICADO (CSR)
echo "GERANDO CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ===================================================="
source $dirname/scripts/generate-csr-system-client.sh $dirname $dominio $pass
echo "==========================================================================================================="