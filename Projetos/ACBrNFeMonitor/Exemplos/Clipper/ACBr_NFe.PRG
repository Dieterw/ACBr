/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: ACBr_NFe.PRG
 \ Descricao: Funcoes da NFe - Nota Fiscal Eletronica.
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
 \ Nota/Obs.: Todos os comandos internos retornam "OK:" ou "ERRO:";
 \            ou retornam dados expecificos.
 \ Funcoes..: * Nao precisa de Certificado do seu Cliente:
 \            NFe_ATV() := Verifica se o Monitor da NFe esta Ativo.
 \            NFe_XML() := Cria XML da NFe baseado em um arquivo Texto/INI.
 \            NFe_VAL() := Valida arquivo assinado da NFe (Schema).
 \            NFe_IMP() := Imprime DANFE do arquivo XML de NFe.
 \            NFe_EMA() := Transmite/Envia uma NFe/DANFE por EMAIL.
 \            * Precisa de Certificado do seu Cliente:
 \            NFe_SWS() := Status do Servico dos Web Services da Receita.
 \            NFe_ASS() := Assina uma NFe. (Pode ser com: Associacao.pfx)
 \            NFe_ENV() := Envia uma NFe.
 \            NFe_ADI() := Adiciona uma NFe ao Lote.
 \            NFe_LOT() := Envia um Lote de NFe.
 \            NFe_CON() := Consulta uma NFe.
 \            NFe_CAN() := Cancela uma NFe ja autorizada.
 \            NFe_INU() := Inutiliza Faixa de numeracao de NFe.
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Historico de Modificacoes:
 \
 \ 20/07/2009 - Codigo original por Riberto de Miranda Braz.
 \            * Programado manualmente pelo analista com base em exemplos.
 \ 02/08/2009 19:27 - Ribertode Miranda Braz. - (ribertobraz@hotmail.com)
 \            * Algumas pequenas melhorias na utilizacao de ACBr_ARQ.PRG.
 \ 28/08/2009 13:20 - Ribertode Miranda Braz. - (ribertobraz@hotmail.com)
 \            * Acrescentado as funcoes: NFe_ATV(); NFe_ADI() e NFe_LOT().
 \ 17/09/2009 10:38 - Ribertode Miranda Braz. - (ribertobraz@hotmail.com)
 \            * Colocado nos Comandos variaveis opcionais: cENT, cSAI, cTMP.
 \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "ACBr.ch"   // inicializa constantes manifestas do sistema/ACBr.


/*
   Sintaxe: NFe_ATV(<ExpC1> <,ExpC2> <,ExpC3>)
   Funcao.: Verifica se o Monitor da NFe esta Ativo.
              ExpC1 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC2 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC3 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_ATV( cENT, cSAI, cTMP )
   LOCAL cRet := ""

   // Formatando os Parametros:
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Envia Comando.
   cRet := MON_ENV( "NFE.Ativo", [""], cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )           // Comando OK?
      MY_WAIT( 2 )              // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI )   // Verifica Retorno do Arquivo de Resposta.
   endif

   // Vamos formatar a Resposta do Comando corretamente.
   if cRet = "ERRO: Nao encontrado Arquivo de Resposta do Monitor."
      cRet := "ERRO: Monitor nao ATIVO."
   endif

return cRet


/*
   Sintaxe: NFe_XML(<ExpC1> <,ExpN1> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Cria XML da NFe baseado em um arquivo Texto/INI.
              ExpC1 = Dados do Texto/INI para Criar a NFe.
              ExpN1 = Parametro "Opcional" para retornar arquivo XML (1 - Retorna)
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Vari veis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_XML( cTXT, nXML, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cTXT = NIL    // Nao veio DADOS para CRIAR?
      cTXT := ""    // Nao vai CRIAR nenhum Arquivo...
   endif
   if nXML = NIL    // Nao veio Parametro "Opcional"?
      nXML := '0'   // Entao eh 0-Nao Retorna o XML.
   else
      nXML := iif( ValType( nXML ) = "N", str( nXML ), nXML )
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cTXT+[","]+nXML+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.CriarNFe", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )               // Comando OK?
      MY_WAIT( 2 )                  // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 60 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_VAL(<ExpC1> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Valida arquivo assinado da NFe.
              ExpC1 = Arquivo XML da NFe a Validar.
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_VAL( cXML, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cXML = NIL   // Nao veio Arquivo para VALIDAR?
      cXML := ""   // Nao vai VALIDAR nenhum Arquivo...
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cXML+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.ValidarNFe", cCmd, cENT, cSAI, cTMP )

   // Testa Retorno do Comando
   if MEN_OK_( cRet )           // Comando OK?
      MY_WAIT( 2 )              // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_IMP(<ExpC1> <,ExpN1> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Imprime DANFE do arquivo XML de NFe.
              ExpC1 = Arquivo XML da NFe a Imprimir.
              ExpN1 = N£mero de Copias do DANFE a Imprimir.
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_IMP( cXML, nCop, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cXML = NIL    // Nao veio Arquivo para IMPRIMIR?
      cXML := ""    // Nao vai IMPRIMIR nenhum Arquivo...
   endif
   if nCop = NIL    // Nao veio o o Numero de Copias?
      nCop := "1"   // Entao definimos UMA como Padrao.
   else
      nCop := iif( ValType( nCop ) = "N", str( nCop ), nCop )
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cXML+[","]+nCop+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.ImprimirDanfe", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )               // Comando OK?
      MY_WAIT( 2 )                  // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 60 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_EMA(<ExpC1> <,ExpC2> <,ExpN1> <,ExpC3> <,ExpC4> <,ExpC5>))
   Funcao.: Transmite/Envia uma NFe/DANFE por EMAIL.
              ExpC1 = Email do destinatario.
              ExpC2 = Arquivo a ser enviado por Email. Ex.: XML da NFe.
              ExpN1 = Parametro "Opcional" de Envio do DANFe em PDF (1 - Envia)
              ExpC3 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC4 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC5 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_EMA( cDes, cArq, nPDF, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cDes = NIL    // Nao veio email do Destinatario?
      cDes := ""    // Nao vai ENVIAR nenhum email...
   endif
   if cArq = NIL    // Nao veio Arquivo para ENVIAR?
      cArq := ""    // Nao vai ENVIAR nenhum Arquivo...
   endif
   if nPDF = NIL    // Nao veio Parametro "Opcional"?
      nPDF := '0'   // Entao eh 0-Nao Envia o PDF
   else
      nPDF := iif( ValType( nPDF ) = "N", str( nPDF ), nPDF )
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cDes+[","]+cArq+[","]+nPDF+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.EnviarEmail", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 180 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_SWS( <ExpC1> <,ExpC2> <,ExpC3>)
   Funcao.: Status do Servico dos Web Services da Receita.
              ExpC1 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC2 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC3 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_SWS( cENT, cSAI, cTMP )
   LOCAL cRet

   // Formatando os Parametros:
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Envia Comando.
   cRet := MON_ENV( "NFE.StatusServico", [""], cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 180 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_ASS(<ExpC1> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Assina uma NFe.
              ExpC1 = Arquivo XML da NFe a Assinar.
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_ASS( cXML, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cXML = NIL   // Nao veio Arquivo para ASSINAR?
      cXML := ""   // Nao vai ASSINAR nenhum Arquivo...
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cXML+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.AssinarNFe", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )               // Comando OK?
      MY_WAIT( 2 )                  // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 30 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_ENV(<ExpC1> <,ExpN1> <,ExpN2> <,ExpN3> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Envia NFe para o Web Service.
              ExpC1 = Arquivo XML da NFe a Enviar.
              ExpN1 = N£mero do Lote de Envio.
              ExpN2 = Parametro "Opcional" de Assinatura (0 - Nao Assina).
              ExpN3 = Parametro "Opcional" de Impressao (1 - Imprime DANFe).
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_ENV( cArq, nLot, nAss, nImp, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cArq = NIL   // Nao veio ARQUIVO para ENVIAR?
      cArq := ""   // Nao vai ENVIAR nenhum Arquivo...
   endif
   *
   if nLot = NIL   // Nao veio LOTE para ENVIAR?
      nLot := 0    // Nao vai ENVIAR nenhum Lote...
   endif
   nLot := iif( ValType( nLot ) = "N", str( nLot ), nLot )
   *
   if nAss = NIL    // Nao veio PARAMETRO para ASSINAR?
      nAss := 0    // Nao vai ASSINAR o Arquivo...
   endif
   nAss := iif( ValType( nAss ) = "N", str( nAss ), nAss )
   *
   if nImp = NIL    // Nao veio PARAMETRO para IMPRIMIR?
      nImp := 0    // Nao vai IMPRIMIR nenhum DANFE...
   endif
   nImp := iif( ValType( nImp ) = "N", str( nImp ), nImp )
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)
   
   // Formata o Comando
   cCmd := ["]+cArq+[",]+nLot+[,]+nAss+[,]+nImp

   // Envia Comando.
   cRet := MON_ENV( "NFE.EnviarNFe", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 300 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_ADI(<ExpC1> <,ExpN1> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Adiciona uma NFe ao Lote.
              ExpC1 = Arquivo XML da NFe a Adicionar.
              ExpN1 = N£mero do Lote de Envio.
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_ADI( cArq, nLot, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cArq = NIL   // Nao veio ARQUIVO para ADICIONAR?
      cArq := ""   // Nao vai ADICIONAR nenhum Arquivo...
   endif
   *
   if nLot = NIL   // Nao veio LOTE para ADICIONAR?
      nLot := 0    // Nao vai ADICIONAR nenhum Lote...
   endif
   nLot := iif( ValType( nLot ) = "N", str( nLot ), nLot )
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cArq+[",]+nLot

   // Envia Comando.
   cRet := MON_ENV( "NFE.AdicionarNFeSefaz", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )           // Comando OK?
      MY_WAIT( 2 )              // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_LOT(<ExpN1> <,ExpC1> <,ExpC2> <,ExpC3>)
   Funcao.: Envia um Lote de NFe para o Web Service.
              ExpN1 = N£mero do Lote de Envio.
              ExpC1 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC2 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC3 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_LOT( nLot, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if nLot = NIL   // Nao veio LOTE para ADICIONAR?
      nLot := 0    // Nao vai ADICIONAR nenhum Lote...
   endif
   nLot := iif( ValType( nLot ) = "N", str( nLot ), nLot )
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+nLot+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.EnviarLote", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 300 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_CON(<ExpC1> <,ExpC2> <,ExpC3> <,ExpC4>)
   Funcao.: Consulta uma NFe.
              ExpC1 = Chave da NFe a ser Consultada.
              ExpC2 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC3 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC4 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_CON( cNFe, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cNFe = NIL   // Nao veio CHAVE para CONSULTAR?
      cNFe := ""   // Nao vai CONSULTAR nenhuma NF-e...
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cNFe+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.ConsultarNFe", cCmd, cENT, cSAI, cTMP )

   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 300 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_CAN(<ExpC1> <,ExpC2> <,ExpC3> <,ExpC4> <,ExpC5>)
   Funcao.: Cancela uma NFe ja autorizada.
              ExpC1 = Chave da NFe a ser Cancelada.
              ExpC2 = Justificativa do Cancelamento.
              ExpC3 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC4 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC5 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_CAN( cNFe, cJus, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   if cNFe = NIL   // Nao veio CHAVE para CANCELAR?
      cNFe := ""   // Nao vai CANCELAR nenhuma NF-e...
   endif
   *
   if cJus = NIL   // Nao veio JUSTIFICATIVA para CANCELAR?
      cJus := "OPERACAO NAO CONCLETIZADA."   // Vamos colocar uma JUSTIFICATIVA padrao...
      // Obs.: Eh melhor Justificar corretamente atraves de seu aplicativo.
   endif
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cNFe+["]+[,"]+cJus+["]

   // Envia Comando.
   cRet := MON_ENV( "NFE.CancelarNFe", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 300 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet


/*
   Sintaxe: NFe_INU(<ExpC1> <,ExpC2> <,ExpN1> <,ExpN2> <,ExpN3> <,ExpN4> <,ExpN5> <,ExpC3> <,ExpC4> <,ExpC5>)
   Funcao.: Inutiliza Faixa de numeracao de NFe.
              ExpC1 = Documento do Contribuinte (CNPJ/CPF).
              ExpC2 = Justificativa para inutilizacao.
              ExpN1 = Ano que foi inutilizado a numeracao.
              ExpN2 = Modelo da Nota Fiscal.
              ExpN3 = S‚rie da Nota Fiscal.
              ExpN4 = N£mero Inicial a ser inutilizado.
              ExpN5 = N£mero Final a ser inutilizado.
              ExpC3 = Arquivo de Entrada dos Comandos. "Opcional"
              ExpC4 = Arquivo de Saida/Retorno dos Comandos. "Opcional"
              ExpC5 = Arquivo Temporario dos Comandos. "Opcional"
   Local..: Variaveis locais utilizadas.
              cCmd = Comando formatado para o Monitor.
              cRet = Variavel de Retorno da Mensagem de Leitura ou Erro.
   Retorna: String da Mensagem.
*/
Function NFe_INU( cDoc, cJus, nAno, nMod, nSer, nIni, nFin, cENT, cSAI, cTMP )
   LOCAL cCmd, cRet

   // Formatando os Parametros:
   cDoc := iif(cDoc=nil, "XXXXXXXXXXXXXX", cDoc)
   cJus := iif(cJus=nil, "NUMERACAO NAO UTILIZADA.", cJus)
   *
   if nAno = NIL           // Nao veio ANO?
      nAno := year(date)   // Entao consideraremos o Ano corrente...
   endif
   nAno := iif( ValType( nAno ) = "N", str( nAno ), nAno )
   *
   if nMod = NIL   // Nao veio MODELO?
      nMod := 55   // Entao consideraremos o MODELO padrao da NF-e...
   endif
   nMod := iif( ValType( nMod ) = "N", str( nMod ), nMod )
   *
   if nSer = NIL   // Nao veio a SERIE?
      nSer := 1    // Entao consideraremos a SERIE 1...
   endif
   nSer := iif( ValType( nSer ) = "N", str( nSer ), nSer )
   *
   if nIni = NIL   // Nao veio o numero INICIAL a ser INUTILIZADO?
      nIni := 0    // Nao vai INUTILIZAR nenhum numero...
   endif
   nIni := iif( ValType( nIni ) = "N", str( nIni ), nIni )
   *
   if nFin = NIL   // Nao veio o numero FINAL a ser INUTILIZADO?
      nFin := 0    // Nao vai INUTILIZAR nenhum numero...
   endif
   nFin := iif( ValType( nFin ) = "N", str( nFin ), nFin )
   *
   cENT := iif( ValType(cENT) # "C", ACBrNFe_ENT, cENT)
   cSAI := iif( ValType(cSAI) # "C", ACBrNFe_SAI, cSAI)
   cTMP := iif( ValType(cTMP) # "C", ACBrNFe_TMP, cTMP)

   // Formata o Comando
   cCmd := ["]+cDoc+[","]+cJus+[",]+nAno+[,]+nMod+[,]+nSer+[,]+nIni+[,]+nFin

   // Envia Comando.
   cRet := MON_ENV( "NFE.InutilizarNFe", cCmd, cENT, cSAI, cTMP )
   // Testa Retorno do Comando
   if MEN_OK_( cRet )                // Comando OK?
      MY_WAIT( 2 )                   // Aguarda 2 Segundos.
      cRet := MON_RET( cSAI, 300 )   // Verifica Retorno do Arquivo de Resposta.
   endif

return cRet

* \\ Final de ACBr_NFe.PRG
