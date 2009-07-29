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

AUTOSTART_DIR=/usr/share/autostart/
if [ ! -z $XDG_CONFIG_HOME ]; then
   AUTOSTART_DIR=$XDG_CONFIG_HOME/autostart/ ;
fi 
echo $AUTOSTART_DIR

# Removendo Pasta com atalhos do Desktop do usuário
rm $DIRETORIO_HOME/Desktop/ACBrMonitor.desktop -f
if [ -e $DIRETORIO_HOME/Desktop/$PASTA ]; then
  rm $DIRETORIO_HOME/Desktop/$PASTA -rf ;
fi

if [ -e /usr/share/applnk/$PASTA ]; then
  rm /usr/share/applnk/$PASTA -rf ;
fi

# Removendo atalho da pasta iniciar do KDE
rm $AUTOSTART_DIR/ACBrMonitor.desktop -f 
