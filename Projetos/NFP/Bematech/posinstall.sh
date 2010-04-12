#!/bin/bash

PASTA="Projeto_ACBr"
NOME=$USER

if [ ! -z $USERNAME ]; then
  NOME=$USERNAME ;
fi

if [ $NOME = 'root' ]; then
  NOME=$USER ;
fi
echo $NOME

DIRETORIO_HOME=/home/$NOME
if [ ! -e $DIRETORIO_HOME ]; then
  DIRETORIO_HOME=$HOME ;
fi
echo $DIRETORIO_HOME

# Acessando a pasta do Programa onde Bematech_NFP foi instalado (geralmente /opt/Bematech_NFP)
# o parƒmetro com o nome da pasta ‚ informado pelo InstallBuilder
if [ -z $1 ]; then
  echo Diretorio de instalacao nao informado.... Saindo... ;
  exit 0 ;
fi

cd $1

# Consegiu acessar a pasta onde o programa foi instalado ?
# Se NAO conseguiu... sai..
if [ ! -e ./Bematech_NFP ]; then
  echo Nao ‚ o diretorio do Bematech_NFP.... Saindo...
  exit 0 ;
fi

# Ajustando Pasta do Bematech_NFP, para manter sempre o mesmo Grupo dos novos
# arquivos criados na Pasta para permitir criar os arquivos tempor rios.
chown root:users $1 -R
chmod 777 $1
chmod g+s $1 -R

# Ajustando permissao de Execu‡Æo apenas para os executaveis
chmod 644 *
chmod 755 Bematech_NFP
chmod 755 linuxmfd
chmod 755 bemamfd2
chmod 755 *.sh
chmod 755 /usr/lib/libborqt-6.9.0-qt2.3.so

# Copiando a lib do Kylix para  /usr/lib
cp libborqt-6.9.0-qt2.3.so /usr/lib

# Criando SoftLink com o nome correto
ln -s /usr/lib/libborqt-6.9.0-qt2.3.so /usr/lib/libborqt-6.9-qt2.3.so

# Copiando atalho para o Desktop do usuário
cp Bematech_NFP.desktop $DIRETORIO_HOME/Desktop
