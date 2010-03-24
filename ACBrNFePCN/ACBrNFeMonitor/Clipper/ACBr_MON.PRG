/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: ACBr_MON.PRG
 \ Descricao: Funcoes de Comunicacao do Monitor ACBrNFe/ACBrECF.
 \ Criacao..: 20/07/2009 - Direitos Autorais Reservados (c)
 \ Analista.: Riberto de Miranda Braz (RibertoBraz)
 \ Contactos: ribertobraz@hotmail.com (Email / MSN) ( +55 35 9922-0075 )
 \ Licenca..: Esta biblioteca e software livre; voce pode redistribui-la e/ou
 \            modifica-la sob os termos da Licenca Publica Geral Menor do GNU
 \            GNU conforme publicada pela Free Software Foundation;  tanto  a
 \            versao 2.1 da Licenca, ou  (a  seu  criterio)  qualquer  versao
 \            posterior.
 \
 \            Esta biblioteca e distribuida na expectativa de que seja  util,
 \            porem, SEM NENHUMA GARANTIA; nem mesmo a garantia implicita  de
 \            COMERCIABILIDADE OU ADEQUACAO A UMA FINALIDADE ESPECIFICA.
 \
 \            Consulte a  Licenca  Publica  Geral  Menor  do  GNU  para  mais
 \            detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)
 \
 \            Voce deve ter recebido uma copia da Licenca Publica Geral Menor
 \            do GNU junto com esta biblioteca; se nao, escreva para  a  Free
 \            Software Foundation, Inc., no endereco 59 Temple Street,  Suite
 \            330, Boston, MA 02111-1307 USA.
 \
 \            Voce tambem pode obter uma copia da licenca em:
 \            http://www.opensource.org/licenses/gpl-license.php
 \
 \            Voce pode obter a ultima versao  desse  arquivo  na  pagina  do
 \            Projeto ACBr Componentes localizado em:
 \            http://www.sourceforge.net/projects/acbr
 \
 \ Nota/Obs.: Todos os comandos internos retornam "OK:" ou "ERRO:".
 \            Todos os comandos de apoio retornam .t./.f. (true/false);
 \            ou retornam dados expecificos.
 \ Funcoes..: MON_INI() := Inicia Monitor.
 \            MON_ENC() := Encerra Monitor.
 \            MON_ENV() := Envia Comando ao Monitor.
 \            MON_RET() := Verifica Retorno do Monitor.
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Historico de Modificacoes:
 \
 \ 20/07/2009 - Codigo original por Riberto de Miranda Braz.
 \            * Programado manualmente pelo analista com base em exemplos.
 \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "ACBr.ch"   // inicializa constantes manifestas do sistema/ACBr.

// Function INI_MON := Inicia Monitor.
// Function ENC_MON := Encerra Monitor.

/*
   Sintaxe: MON_ENV(<ExpC1> <,ExpC2> <,ExpC3> <,ExpC4> <,ExpC5>)
   Funcao.: Envia Comando ao Monitor.
              ExpC1 = Indice do Comando.
              ExpC2 = Dados do Comando.
              ExpC3 = Arquivo de Entrada dos Comandos.
              ExpC4 = Arquivo de Saida/Retorno dos Comandos.
              ExpC5 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cBuf = Buffer do Comando.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function MON_ENV( cInd, cDad, cENT, cSAI, cTMP)
   LOCAL cBuf, cRet := ""

   // Verificando informacoes passadas.
   if ! ('.' $ left(cInd,5))   // Nao informou o Objeto no Inicio ?
      cInd := 'ECF.'+cInd      // Entao assume ECF como Padrao.
   endif
   cDad := iif( ValType(cDad) # "C", "", cDad)
   *
   cBuf := cInd + iif( len( cDad )=0,"()","(" + cDad + ")") + CR+LF
   *
   cENT := iif( ValType(cENT) # "C", "C:\ACBR\ENT.TXT", cENT)
   cSAI := iif( ValType(cSAI) # "C", "C:\ACBR\SAI.TXT", cSAI)
   cTMP := iif( ValType(cTMP) # "C", "C:\ACBR\TMP.TXT", cTMP)

   // Verifica se existe os arquivos textos, entao apaga em ate 3 Segundos.
   if !ARQ_EXC( cTMP, 5 )
      cRet := "ERRO: Nao foi possivel APAGAR o arquivo: ("+cTMP+"). FError: "+str(FError())+"."
   endif
   if empty( cRet )
      if !ARQ_EXC( cENT, 5 )
         cRet += "ERRO: Nao foi possivel APAGAR o arquivo: ("+cENT+"). FError: "+str(FError())+"."
      endif
   endif
   if empty( cRet )
      if !ARQ_EXC( cSAI, 5 )
         cRet += "ERRO: Nao foi possivel APAGAR o arquivo: ("+cSAI+"). FError: "+str(FError())+"."
      endif
   endif

   // Cria Arquivo Temporario.
   if empty( cRet )
      if !ARQ_NEW( cTMP, cBuf, 1 )
         cRet := "ERRO: Nao foi possivel CRIAR o arquivo: ("+cTMP+"). FError: "+str(FError())+"."
      endif
   endif

   // Renomeia Temporario para Arquivo de Entrada dos Comandos.
   if empty( cRet )
      FRename( cTMP, cENT )
      if FError() != 0
         cRet := "ERRO: Nao foi possivel RENOMEAR o arquivo: ("+cTMP+") para ("+cENT+"). FError: "+str(FError())+"."
      endif
   endif

   // Formatando a Resposta se "OK:" para validacao posterior, ou seja,
   // tem que retornar algo para informar se "OK" ou "ERRO" na mensagem.
   if substr(cRet, 1, 5) != 'ERRO:' .OR. empty( cRet )
      cRet := 'OK:'
   endif

return cRet


/*
   Sintaxe: MON_RET(<ExpC1> <,ExpN1>)
   Funcao.: Verifica Retorno do Monitor.
              ExpC1 = Arquivo de Saida/Retorno dos Comandos.
              ExpN1 = Tempo para Tentar LER o Arquivo.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
              nSec = Tempo em Segundos (seconds) para tentativa de ACESSO aos Arquivos.
   Retorna: String da Mensagem.
*/
Function MON_RET( cArq, nTmp)
   LOCAL nSec, cRet:=""

   // Formata os Dados passados.
   if cArq = NIL    // Nao veio Arquivo para LER?
      cArq := ""    // Nao vai LER nenhum Arquivo...
   endif
   if nTmp = NIL   // Nao veio o Tempo para tentar Gravar?
      nTmp := 10   // Entao definimos 10 Segundos como Padrao.
   endif

   // Verifica se existe o arquivo texto de resposta.
   // Tenta LER o Arquivo em ate n segundos.
   nSec := seconds() + nTmp   // Tenta achar o Arquivo em ate "nTmp" segundos.
   do while .t.
      if File( cArq )   // Achou o Arquivo de Resposta?
         cRet := memoread( cArq )   // Entao vamos Ler o conte£do para a variavel.
         if cRet == ""   // Erro na Leitura do Arquivo?
            cRet := "ERRO: Leitura invalida do Arquivo de Resposta do Monitor."
         endif
         exit   // prossegue saindo do LOOP.
      else
         if (seconds() > nSec )
            cRet := "ERRO: Nao encontrado Arquivo de Resposta do Monitor."
            exit   // entao prossegue saindo do LOOP com o Erro de Resposta.
         endif
      endif
   enddo

return cRet

* \\ Final de ACBr_MON.PRG
