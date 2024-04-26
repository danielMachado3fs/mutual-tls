#!/bin/bash
#FONTE: https://rfsaraujobr.medium.com/mtls-de-uma-forma-amig%C3%A1vel-6506c84c1b7e
######################################################
read -p "Informe o path absoluto da sua pasta atual [/root]: " folder_path
folder_path=${folder_path:-/root}
read -p "Informe um identificador ou o domínio do server [server_ltda]: " server_identifier
server_identifier=${server_identifier:-server_ltda}

echo "CRIANDO DIRETÓRIOS ========================================================================================"
sh $folder_path/scripts-server/prepare-directories.sh $folder_path $server_identifier
echo "==========================================================================================================="
echo ""

echo "GERANDO O ARQUIVO DE CONFIGURAÇÃO ssl-server.cnf =========================================================="
source $folder_path/scripts-server/create-ssl-server.cnf.sh $folder_path $server_identifier
echo "==========================================================================================================="
echo ""

# read -p "Informe a senha para a key [pass@ServerKey]: " passServerKey
# passServerKey=${passServerKey:-pass@ServerKey},
passServerKey="pass@ServerKey"
#GERANDO CHAVE
echo "GERANDO CHAVE PRIVADA ====================================================================================="
source $folder_path/scripts-server/generate-key-system-server.sh $folder_path $server_identifier $passServerKey
echo "==========================================================================================================="

#GERANDO CERTIFICADO (CSR)
echo "GERANDO CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ===================================================="
source $folder_path/scripts-server/generate-csr-system-server.sh $folder_path $server_identifier $passServerKey
echo "==========================================================================================================="

#GERANDO CERTIFICADO (CRT)
echo "GERANDO CERTIFICADO (CRT) ================================================================================="
source $folder_path/scripts-server/generate-crt-system-server.sh $folder_path $server_identifier $passServerKey
echo "==========================================================================================================="