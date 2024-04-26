#!/bin/bash
#FONTE: https://rfsaraujobr.medium.com/mtls-de-uma-forma-amig%C3%A1vel-6506c84c1b7e
######################################################
read -p "Informe o path absoluto da sua pasta atual [/root]: " folder_path
folder_path=${folder_path:-/root}
read -p "Este cliente irá se comunicar com qual servidor? [server.com]: " server_identifier
server_identifier=${server_identifier:-server.com}
read -p "Informe um identificador ou o domínio do client [client_ltda]: " client_identifier
client_identifier=${client_identifier:-client_ltda}

echo "CRIANDO DIRETÓRIOS ========================================================================================"
sh $folder_path/scripts-client/prepare-directories.sh $folder_path $server_identifier $client_identifier
echo "==========================================================================================================="
echo ""

echo "GERANDO O ARQUIVO DE CONFIGURAÇÃO ssl-client.cnf =========================================================="
source $folder_path/scripts-client/create-ssl-client.cnf.sh $folder_path $server_identifier $client_identifier
echo "==========================================================================================================="
echo ""

# read -p "Informe a senha para a key [pass@ClientKey]: " passClientKey
# passClientKey=${passClientKey:-pass@ClientKey},
passClientKey="pass@ClientKey",
#GERANDO CHAVE
echo "GERANDO CHAVE PRIVADA ====================================================================================="
source $folder_path/scripts-client/generate-key-system-client.sh $folder_path $server_identifier $client_identifier $passClientKey
echo "==========================================================================================================="

#GERANDO CERTIFICADO (CSR)
echo "GERANDO CERTIFICADO DE SOLICITAÇÃO DE ASSINATURA (CSR) ===================================================="
source $folder_path/scripts-client/generate-csr-system-client.sh $folder_path $server_identifier $client_identifier $passClientKey
echo "==========================================================================================================="

#GERANDO CERTIFICADO (CRT)
echo "GERANDO CERTIFICADO (CRT) ================================================================================="
source $folder_path/scripts-client/generate-crt-system-client.sh $folder_path $server_identifier $client_identifier $passClientKey
echo "==========================================================================================================="