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

# Acessando a pasta do Programa onde ACBrMonitor foi instalado (geralmente /opt/ACBrMonitor)
# o parâmetro com o nome da pasta é informado pelo InstallBuilder
if [ -z $1 ]; then
  echo Diretorio de instalacao nao informado.... Saindo... ;
  exit 0 ;
fi 

cd $1

# Consegiu acessar a pasta onde o programa foi instalado ?
# Se NAO conseguiu... sai..
if [ ! -e ./ACBrMonitor ]; then
  echo Nao e o diretorio do ACBrMonitor.... Saindo...
  exit 0 ;
fi

# Ajustando Pasta do ACBrMonitor, para manter sempre o mesmo Grupo dos novos
# arquivos criados na Pasta para permitir criar os arquivos
# de configuração, alem de permitir a Troca de Arquivos entre o ACBrMonitor e a
# Aplicação Comercial
chown root:users $1 -R
chmod 777 $1
chmod g+s $1 -R

# Ajustando permissao de Execução apenas para os executaveis
chmod 644 *
chmod 755 ACBrMonitor
chmod 755 ACBrMonitorConsole
chmod 755 QECFTeste
chmod 755 *.sh
chmod 755 /usr/lib/libborqt-6.9.0-qt2.3.so

# Diretório /var/lock é usado pela classe "SynaSer" para detectar se a porta
# Serial está disponível... Necessita de Leitura / Escrita
chmod 777 /var/lock

# ACBrMonitor deve ser executado como SuperUsuário para que seja possível
# interagir com os dispositivos seriais (/dev/ttyS0, /dev/ttyUSB0 )
chmod u+sx ACBrMonitor
chmod u+sx ACBrMonitorConsole
chmod u+sx QECFTeste

# Copiando a lib do Kylix para  /usr/lib
cp libborqt-6.9.0-qt2.3.so /usr/lib

# Criando SoftLink com o nome correto
ln -s /usr/lib/libborqt-6.9.0-qt2.3.so /usr/lib/libborqt-6.9-qt2.3.so

# Copiando atalho para o Desktop do usuário
cp ACBrMonitor.desktop $DIRETORIO_HOME/Desktop

mkdir $DIRETORIO_HOME/Desktop/$PASTA
cp ACBrMonitor.desktop $DIRETORIO_HOME/Desktop/$PASTA
cp ECFTeste.desktop    $DIRETORIO_HOME/Desktop/$PASTA
cp leia-me.txt         $DIRETORIO_HOME/Desktop/$PASTA
cp ManualACBrMonitor.html $DIRETORIO_HOME/Desktop/$PASTA
cp "Remover ACBrMonitor.desktop" $DIRETORIO_HOME/Desktop/$PASTA

mkdir /usr/share/applnk/$PASTA
cp ACBrMonitor.desktop /usr/share/applnk/$PASTA
cp ECFTeste.desktop    /usr/share/applnk/$PASTA
cp leia-me.txt         /usr/share/applnk/$PASTA
cp ManualACBrMonitor.html /usr/share/applnk/$PASTA
cp "Remover ACBrMonitor.desktop" /usr/share/applnk/$PASTA

# Criando atalho na Auto-inicialização
cp ACBrMonitor.desktop $AUTOSTART_DIR ;
