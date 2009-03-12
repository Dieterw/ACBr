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

# Removendo Pasta com atalhos do Desktop do usuário
rm $DIRETORIO_HOME/Desktop/ACBrMonitor.desktop -f
