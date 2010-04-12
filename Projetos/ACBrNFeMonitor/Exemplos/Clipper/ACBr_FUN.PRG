/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: ACBr_FUN.PRG
 \ Descricao: Funcoes de Funcionalidades Gerais.
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
 \ Nota/Obs.: Todos os comandos de apoio retornam .t./.f. (true/false);
 \            ou retornam dados expecificos.
 \ Funcoes..: MY_WAIT() := Temporizador.
 \            MEN_RET() := Extrai Mensagem no Retorno do Monitor.
 \            MEN_OK_() := OK nas Mensagens de Retorno?
 \            GER_RAN() := Cria um valor randomico.
 \            GER_DV_() := Gera Digito Validador (Padrao Modulo 11).
 \            REM_ACE() := Remove Acentos da Mensagem passada.
 \            VAL_CGC() := Valida CGC/CNPJ (Pessoa Juridica).
 \            VAL_CPF() := Valida CPF (Pessoa Fisica).
 \            VAL_IE_() := Valida Inscricao Estadual (I.E.).
 \            VAL_PIS() := Valida numero do PIS.
 \            VAL_CHQ() := Valida numero do Cheque.
 \            LIM_DOC() := Limpa Documentos (CNPJ / CPF / I.E.).
 \            FOR_VLR() := Formata Valores.
 \            FOR_TXT() := Formata Texto com caracteres especiais.
 \            FOR_CGC() := Formata CGC/CNPJ (Pessoa Juridica).
 \            FOR_CPF() := Formata CPF (Pessoa Fisica).
 \            FOR_IE_() := Formata Inscricao Estadual (I.E.).
 \            FOR_PIS() := Formata numero do PIS.
 \            FOR_CHQ() := Formata numero do Cheque.
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Historico de Modificacoes:
 \
 \ 20/07/2009 - Codigo original por Riberto de Miranda Braz.
 \            * Programado manualmente pelo analista com base em exemplos.
 \ 06/11/2009 - Acrescentado mais funcoes da biblioteca "ACBrValidador.pas".
 \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "ACBr.ch"   // inicializa constantes manifestas do sistema/ACBr.


/*
   Sintaxe: MY_WAIT( <ExpC1> )
   Funcao.: Temporizador.
              ExpC1 = Tempo de Espera em Segundos (seconds).
   Retorna: .t. se Ok.
*/
Function MY_WAIT( nSec ) 

   nSec := seconds() + nSec   // (24h * 60m * 60s) = 0 a 86399.
   do while .t.
      if (seconds() > nSec )   // Ja Ultrapassou o Tempo?
         exit                  // Entao Saimos do LOOP.
      endif
   enddo

return .t.


/*
   Sintaxe: MEN_RET(<ExpC1> <,ExpC2>)
   Funcao.: Extrai um Dado na Mensagem de Retorno do Monitor.
              ExpC1 = Indice da Mensagem a Localizar.
              ExpC2 = Dados da Mensagem a Localizar.
   Local..: Variaveis locais utilizadas.
              cMen = Mensagem localizada.
              nLin = Quantidade de Linhas dos Dados da Mensagem a Verificar.
              iLin = Indice de Linhas do comando FOR/NEXT.
   Retorna: String com a Mensagem extraida.
*/
Function MEN_RET( cInd, cDad )
   LOCAL cMen, nLin, iLin

   // Conta a Quantidade de Linhas nos dados passados.
   nLin := mlcount(cDad, 52) 
   if nLin = 0     // Nenhuma linha? Entao...
      cMen := ""   // Nao tem nenhum dado a retornar.
   endif

   // Vamos percorrer toda a cadeia de caracteres e localizar o que queremos.
   for iLin := 1 to nLin
      // Extrai uma linha de texto de uma cadeia de caracteres ou campo memo.
      cMen := memoline(cDad, 52, iLin, .F.)

      if cInd $ cMen   // Nesta linha contem o Indice que queremos?
         // Entao extraimos a Mensagem na Linha apos o "Indice=".
         cMen := substr( cMen, len(cInd)+2, len(cMen) )
         exit   // E caimos fora...
      endif

      if iLin = nLin   // Chegou no final e nada de achar o que procurava?
         cMen := ""    // Entao, nao tem nenhum dado a retornar.
      endif
   next

return cMen


/*
   Sintaxe: MEN_OK_( <ExpC1> )
   Funcao.: Verifica se tudo OK nas Mensagens de Retorno.
              ExpC1 = Mensagem de Retorno para Verificar.
   Retorna: .t. se a String inicia com "OK:".
*/
Function MEN_OK_( cMen )
   // Testa se a Mensagem passada inicia com "OK:".
return ( substr(cMen, 1, 3) == 'OK:' )


/*
   Sintaxe: GER_RAN()
   Funcao.: Cria um valor randomico.
   Local..: Variaveis locais utilizadas.
              nDat = Valor Data da maquina.
              nHor = Valor Hora da maquina.
              nSec = Valor em Segundos decorridos da maquina.
              nRet = Valor randomico de Retorno. Valor Inteiro.
   Retorna: Numero Gerado.
*/
Function GER_RAN()
   Local nDat := 0   // Retorna Valor Data. Exemplo: "20090720" p/ Data = 20/07/2009
   Local nHor := 0   // Retorna Valor Hora. Exemplo: "103717" p/ Hora = 10:37:17
   Local nSec := 0   // Retorna segundos decorridos desde a meia noite = 0 a 86399.
   Local nRet := 0   // Este sera o numero randomico que retornaremos. Por enquanto eh zero.

   nDat := val( dtos( date() ) )   
   nHor := val( substr(time(),1,2) + substr(time(),4,2) + substr(time(),7,2) )
   nSec := seconds()      

   // Vamos gerar o numero agora. Multiplicamos os tres valores...
   nRet := nDat * nHor * nSec    // Esse ja eh um numero Randomico.
   // Vamos embaralhar ainda mais... 
   * nRet := nRet * sqrt( nRet )   // Multiplicamos o valor pela sua propria raiz quadrada.
   nRet := int( nRet )    // Tiramos os possiveis decimais. Retonamos somente valor inteiro.
   // Agora sim... temos um valor randomico inteiro.

return nRet



/*
   Sintaxe: GER_M11( <ExpC1> <,ExpN1> <,ExpN2> )
   Funcao.: Gera digito do Calculo Modulo 11 (com pesos no multiplicador).
              ExpC1 = Digitos para Gerar o Modulo 11.
              ExpN1 = Peso 1 do Multiplicador.
              ExpN2 = Peso 2 do Multiplicador.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno do Digito Verificador do Modulo 11.
              nTot = Variavel do Totalizador das Ponderacoes.
              nMul = Variavel do Multiplicador (Pesos).
   Retorna: String (Digito) do Numero Gerado.
*/
Function GER_M11( cDad, nIni, nFin )
   LOCAL cDig := []   // Digito. Por enquanto eh vazio.
   Local nSom := 0    // Soma (Totalizador) das Ponderacoes.
   Local nPes := 0    // Pesos (Multiplicador).
   Local i            // Variavel de interacao do FOR...NEXT.

   // Formata os Dados passados.
   if cDad = NIL   // Nao veio os Digitos para Gerar?
      cDad := ""   // Nao vai GERAR nenhum numero...
   endif
   if ValType( cDad ) = "N"   // Foi passado dados numericos? Nao aceitaremos.
      cDad := ""   // Nao vai GERAR nenhum numero...
      // Obs.: Valor numerico ALTO em Clipper vai Gerar erros...
      //       Tem limite de 17 caracteres. A NFe precisa de 43 digitos.
      //       Assim forcamos a transformar Numeros em Caracteres antes.
   endif
   *
   if nIni = NIL   // Nao veio o Peso 1 (inicial) ?
      nIni = 2     // Entao eh dois. (Padrao NFe)
   endif
   nIni := iif( ValType(nIni) # "N", val(nIni), nIni)
   if nFin = NIL   // Nao veio o Peso 2 (final) ?
      nFin = 9     // Entao eh nove. (Padrao NFe)
   endif
   nFin := iif( ValType(nFin) # "N", val(nFin), nFin)

   // Gerando a somatoria das Ponderacoes.
   nPes := nIni   // Comecamos com multiplicador nIni (Peso 1).
   for i := len( cDad ) to 1 step -1   // Da direita para a esquerda.
       nSom += val( substr( cDad, i, 1 ) ) * nPes   // Somatoria das Ponderacoes.
       *
       // O multiplicador sera reciclado e voltara para "Peso 1", quando o
       // limite "Peso 2" for atingido:
       nPes := if( nPes < nFin, nPes + 1, nIni)
   next

   // Dividindo a somatoria das Ponderacoes por 11, e comparando o resto da divisao.
   // Obs.: % = Modulo de dois numeros -- binario. (Retorna o resto da divisao)
   // Se o resto for "1" ou "0" entao o DV sera "0".
   if !empty( cDad )
      cDig := ( 11 - ( nSom % 11 ) )
      if cDig > 9 .OR. cDig < 2
         cDig = 0
      endif
      cDig := str( cDig, 1, 0)
   endif

return cDig



/*
   Sintaxe: REM_ACE( <ExpC1> )
   Funcao.: Remove Acentos da Mensagem passada.
              ExpC1 = Mensagem com os Acentos para realizar a Troca.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno da Mensagem sem os Acentos.
              cDOS = Variavel com os Acentos DOS.
              cWIN = Variavel com os Acentos do Windows.
              cLIN = Variavel com os Acentos do Linux.
   Retorna: String sem acentos.
*/
Function REM_ACE( cDad )
   Local cRet := ""   // String de Retorno. Por enquanto eh vazio.
   Local i            // Variavel de interacao do FOR...NEXT.
   Local cCom := " …Æƒ„‚Šˆ‰¡Œ‹¢•ä“”£—–µ·Ç¶ŽÔÒÓÖÞ×Øàãåâ™éëêš‡€¤¥"
   Local cSem := "aaaaaeeeeiiiiooooouuuuAAAAAEEEEIIIIOOOOOUUUUcCnN"

   * Local cISO := []
   * Local c850 := []
   * Local cUTF := []

   // Formata os Dados passados.
   if cDad = NIL   // Nao veio nenhuma Mensagem?
      cDad := ""   // Nao vai Remover nada...
   endif


*For x := 1 to Length(Str) do
*if Pos(Str[x],ComAcento)0 Then
*Str[x] := SemAcento[Pos(Str[x],ComAcento)];
*Result := Str;
*end;

*ComAcento = ‘àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ’;
*SemAcento = ‘aaeouaoaeioucuAAEOUAOAEIOUCU’;
*Var
*x : Integer;
*Begin
*For x := 1 to Length(Str) do
*if Pos(Str[x],ComAcento)0 Then
*Str[x] := SemAcento[Pos(Str[x],ComAcento)];
*Result := Str;
*end;

*   for i := 1 to len( cDad )
*       strtran()
*
*       if nPos := at( subs( cDad, i, 1), cCom) > 0
*          strtran
*       endif
*   next

return cRet


/*
   Sintaxe: VAL_IE_( <ExpC1> <,ExpC2> )
   Funcao.: Validacao de Inscricao Estadual
              ExpC1 = string,2 caracteres,maiusculo,unidade federal
              ExpC2 = string,tam.variavel,alfanumerico maiusculo,insc.estadual
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno da IE formatada ou Mensagem de Erro.
   Retorna: String da Inscricao Estadual FORMATADA ou Mensagem de Erro.
   *
   Notas/Obs.:

   -------------------------------------------------------------------
   Desenvolvedor Original: Machado, Paulo H.S. - phmach@terra.com.br
   -------------------------------------------------------------------
   24/06/2003 - toya
                toyasis@yahoo.com.br
                www.toyanet.com.br
              . Correcao do bug na consistencia da Inscricao Estadual do Estado
                do Mato Grosso
   -------------------------------------------------------------------
   * Adaptado por Riberto de Miranda Braz em 28/06/2006 e 28/08/2009.
   * Valida varios Estados:

   CD   UF DESCRICAO             QTDE DIG.           EXEMPLO             MASCARA
   --   -- -------------------   ---------           ------------------- --------------------
   01 - AC-ACRE                = 11+2        =    13 (01.004.823/001-12)
   02 - AL-ALAGOAS             = 2+1+5+1     =     9 (240123459)
   03 - AP-AMAPA               = 2+6+1       =     9 (030123459)
   04 - AM-AMAZONAS            = 8+1         =     9 (01.123.123-9)
   05 - BA-BAHIA               = 6+2         =     8 (123456-63)
   06 - CE-CEARA               = 8+1         =     9 (06000001-5)
   07 - DF-DISTRITO FEDERAL    = 11+2        =    13 (073.00001.001-09)
   08 - ES-ESPIRITO SANTO      = 8+1         =     9 (999999990)
   09 - GO-GOIAS               = 8+1         =     9 (10.987.654-7)
   10 - MA-MARANHAO            = 2+6+1       =     9 (120000385)
   11 - MT-MATO GROSSO         = 10+1        =    11 (0013000001-9)
   12 - MS-MATO GROSSO DO SUL  = 8+1         =     9 (280000010)
   13 - MG-MINAS GERAIS        = 3+6+2+2     =    13 (062.307.904/0081)
   14 - PA-PARA                = 2+6+1       =     9 (15999999-5)
   15 - PB-PARAIBA             = 8+1         =     9 (06000001-5)
   16 - PR-PARANA              = 8+2         =    10 (12345678-50)
   17 - PE-PERNAMBUCO          = 13+1        =    14 (18.1.001.0000004-9)
   18 - PI-PIAUI               = 8+1         =     9 (012345679)
   19 - RJ-RIO DE JANEIRO      = 7+1         =     8 (99.999.99-3)
   20 - RN-RIO GRANDE DO NORTE = 8+1         =     9 (20.040.040-1)
   21 - RS-RIO GRANDE DO SUL   = 3+6+1       =    10 (224/3658792)
   22 - RO-RONDONIA            = 13+1        =    14 (0000000062521-3) OBS.: ANTES DE 01/08/2000 => 3+5+1 = 9 (101.62521-3)
   23 - RR-RORAIMA             = 2+6+1       =     9 (240061536)
   24 - SC-SANTA CATARINA      = 8+1         =     9 (251.040.852)
   25 - SP-SAO PAULO           = (1+)8+1+2+1 = 12/13 (110.042.490.114 ou P-01100424.3/002 para Produtor Rural)
   26 - SE-SERGIPE             = 8+1         =     9 (27123456-3)
   27 - TO-TOCANTINS           = 2+2+6+1     =    11 (29.01.022783.6)
   -------------------------------------------------------------------

   * Parƒmetros:
     PIE  - Inscri‡„o Estadual
     PUF  - Unidade da Federa‡„o (Opcional)
   -------------------------------------------------------------------
*/
/*

// AQUI AQUI AQUI... arrumar variaveis das mensagens de retorno e parametros...
*Function MON_RET( cArq, nTmp)
*   LOCAL nSec, cRet:=""

Function VAL_IE_(pie, puf)

   local ok:=.f.,base,vpos,valg,vsom,vres,vdig1,vdig2,vpro,p,d,n,vbase2,origem
   vbase2:=base:=origem:=""

   if alltrim(pie)=="ISENTO"
      return alltrim(pie)
   endif

   *if AT(SUBS(PIE,1,1),"0123456789P")=0
   *   RETU .T.
   *endi

   for vpos:=1 to len(alltrim(pie))
      if substr(pie,vpos,1)$"0123456789P"
         origem+=substr(pie,vpos,1)
      endif
   next

tamanho = len(origem)

if tamanho < 8 .OR. tamanho > 14
   cRet := "ERRO: Leitura invalida do Arquivo de Resposta do Monitor."
   DBOX("Quantidade de d¡gitos incorreto, certifique-se.",,,,,"ATEN€ŽO! "+usuario,,,,)
   retu .f.
endi

masc_ie:="99999999999999"
if     puf=="AC"
   masc_ie:="99.999.999/999-99"
   base :=padr(origem,13,"0")
   if left(base,2)=="01"   // .and. substr(base,3,2)<>"00"
      vsom :=0
      vmul :={4,3,2,9,8,7,6,5,4,3,2}
      for vpos:=1 to 11
         valg:=val(substr(base,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,11)+vdig1
      vsom :=0
      vmul :={5,4,3,2,9,8,7,6,5,4,3,2}
      for vpos:=1 to 12
         valg:=val(substr(vbase2,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig2 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,11)+vdig1+vdig2
      ok :=(vbase2==origem)
   endif
elseif puf=="AL"
   masc_ie:="999999999"
   base :=padr(origem,9,"0")
   if left(base,2)=="24"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vpro :=vsom*10
      vres :=vpro%11
      vdig1 :=if(vres==10,"0",str(vres,1,0))
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="AM"
   masc_ie:="99.999.999-9"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   if vsom<11
      vdig1:=str(11-vsom,1,0)
   else
      vres :=vsom%11
      vdig1:=if(vres<2,"0",str(11-vres,1,0))
   endif
   vbase2:=left(base,8)+vdig1
   ok :=(vbase2==origem)
elseif puf=="AP"
   masc_ie:="999999999"
   base :=padr(origem,9,"0")
   if left(base,2)=="03"
      n:=val(left(base,8))
      if n>=3000001 .and. n<=3017000
         p:=5
         d:=0
      elseif n>=3017001 .and. n<=3019022
         p:=9
         d:=1
      elseif n>=3019023
         p:=0
         d:=0
      endif
      vsom:=p
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig1:=11-vres
      if vdig1==10
         vdig1:=0
      elseif vdig1==11
         vdig1:=d
      endif
      vdig1 :=str(vdig1,1,0)
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="BA"
   masc_ie:="999999-99"
   base :=padr(origem,8,"0")
   if left(base,1)$"0123458"
      vsom:=0
      for vpos:=1 to 6
         valg:=val(substr(base,vpos,1))
         valg:=valg*(8-vpos)
         vsom+=valg
      next
      vres :=vsom%10
      vdig2 :=str(if(vres==0,0,10-vres),1,0)
      vbase2:=left(base,6)+vdig2
      vsom :=0
      for vpos:=1 to 7
         valg:=val(substr(vbase2,vpos,1))
         valg:=valg*(9-vpos)
         vsom+=valg
      next
      vres :=vsom%10
      vdig1:=str(if(vres==0,0,10-vres),1,0)
   else
      vsom:=0
      for vpos:=1 to 6
         valg:=val(substr(base,vpos,1))
         valg:=valg*(8-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig2 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,6)+vdig2
      vsom :=0
      for vpos:=1 to 7
         valg:=val(substr(vbase2,vpos,1))
         valg:=valg*(9-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig1:=str(if(vres<2,0,11-vres),1,0)
   endif
   vbase2:=left(base,6)+vdig1+vdig2
   ok:=(vbase2==origem)
elseif puf=="CE"
   masc_ie:="99999999-9"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1:=11-vres
   if vdig1>9
      vdig1:=0
   endif
   vbase2:=left(base,8)+str(vdig1,1,0)
   ok :=(vbase2==origem)
elseif puf=="DF"
   masc_ie:="999.99999.999-99"
   base :=padr(origem,13,"0")
   * if left(base,3)=="073"
   vsom:=0
   vmul:={4,3,2,9,8,7,6,5,4,3,2}
   for vpos:=1 to 11
      valg:=val(substr(base,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=if(vres<2,0,11-vres)
   vbase2:=left(base,11)+str(vdig1,1,0)
   vsom :=0
   vmul :={5,4,3,2,9,8,7,6,5,4,3,2}
   for vpos:=1 to 12
      valg:=val(substr(vbase2,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig2 :=if(vres<2,0,11-vres)
   vbase2+=str(vdig2,1,0)
   ok :=(vbase2==origem)
   * endif
elseif puf=="ES"
   masc_ie:="999999999"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=str(if(vres<2,0,11-vres),1,0)
   vbase2:=left(base,8)+vdig1
   ok :=(vbase2==origem)
elseif puf=="GO"
   masc_ie:="99.999.999-9"
   base :=padr(origem,9,"0")
   if left(base,2)$"10,11,15"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vres:=vsom%11
      if vres==0
         vdig1:="0"
      elseif vres==1
         n :=val(left(base,8))
         vdig1:=if(n>=10103105 .and. n<=10119997,"1","0")
      else
         vdig1:=str(11-vres,1,0)
      endif
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="MA"
   masc_ie:="999999999"
   base :=padr(origem,9,"0")
   if left(base,2)=="12"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="MT"
   masc_ie:="9999999999-9"
   base :=padr(origem,11,"0")
   vmul :={3,2,9,8,7,6,5,4,3,2}
   vsom :=0
   for vpos:=1 to 10
      valg:=val(substr(base,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=if(vres<2,0,11-vres)
   vbase2:=left(base,10)+str(vdig1,1,0)
   ok :=(vbase2==origem)
elseif puf=="MS"
   masc_ie:="999999999"
   base :=padr(origem,9,"0")
   if left(base,2)=="28"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="MG"
   masc_ie:="999.999.999/9999"
   base :=padr(origem,13,"0")
   vbase2 :=left(base,3)+"0"+substr(base,4,8)
   n :=2
   vsom :=""
   for vpos:=1 to 12
      valg:=val(substr(vbase2,vpos,1))
      n :=if(n==2,1,2)
      valg:=alltrim(str(valg*n,2,0))
      vsom+=valg
   next
   n :=0
   for vpos:=1 to len(vsom)
      n+=val(substr(vsom,vpos,1))
   next
   vsom :=n
   do while right(str(n,3,0),1)<>"0"
      n++
   enddo
   vdig1 :=str(n-vsom,1,0)
   vbase2:=left(base,11)+vdig1
   vsom :=0
   vmul :={3,2,11,10,9,8,7,6,5,4,3,2}
   for vpos:=1 to 12
      valg:=val(substr(vbase2,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig2 :=if(vres<2,0,11-vres)
   vbase2+=str(vdig2,1,0)
   ok :=(vbase2==origem)
elseif puf=="PA"
   masc_ie:="99-999999-9"
   base :=padr(origem,9,"0")
   if left(base,2)=="15"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=str(if(vres<2,0,11-vres),1,0)
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="PB"
   masc_ie:="99.999.999-9"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=11-vres
   if vdig1>9
      vdig1:=0
   endif
   vbase2:=left(base,8)+str(vdig1,1,0)
   ok :=(vbase2==origem)
elseif puf=="PR"
   masc_ie:="99999999-99"
   base :=padr(origem,10,"0")
   vsom :=0
   vmul :={3,2,7,6,5,4,3,2}
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=str(if(vres<2,0,11-vres),1,0)
   vbase2:=left(base,8)+vdig1
   vsom :=0
   vmul :={4,3,2,7,6,5,4,3,2}
   for vpos:=1 to 9
      valg:=val(substr(vbase2,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig2 :=str(if(vres<2,0,11-vres),1,0)
   vbase2+=vdig2
   ok :=(vbase2==origem)
elseif puf=="PE"
   masc_ie:="99.9.999.9999999-9"
   base :=padr(origem,14,"0")
   vsom :=0
   vmul :={5,4,3,2,1,9,8,7,6,5,4,3,2}
   for vpos:=1 to 13
      valg:=val(substr(base,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=11-vres
   if(vdig1>9,vdig1-=10,)
   vbase2:=left(base,13)+str(vdig1,1,0)
   ok :=(vbase2==origem)
elseif puf=="PI"
   masc_ie:="999999999"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=str(if(vres<2,0,11-vres),1,0)
   vbase2:=left(base,8)+vdig1
   ok :=(vbase2==origem)
elseif puf=="RJ"
   masc_ie:="99.999.99-9"
   base :=padr(origem,8,"0")
   vsom :=0
   vmul :={2,7,6,5,4,3,2}
   for vpos:=1 to 7
      valg:=val(substr(base,vpos,1))
      valg:=valg*vmul[vpos]
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=str(if(vres<2,0,11-vres),1,0)
   vbase2:=left(base,7)+vdig1
   ok :=(vbase2==origem)
elseif puf=="RN"
   masc_ie:="99.999.999-9"
   base :=padr(origem,9,"0")
   if left(base,2)=="20"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*(10-vpos)
         vsom+=valg
      next
      vpro :=vsom*10
      vres :=vpro%11
      vdig1 :=str(if(vres>9,0,vres),1,0)
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="RS"
   masc_ie:="999/999999-9"
   base :=padr(origem,10,"0")
   n :=val(left(base,3))
   if n>0 .and. n<468
      vsom:=0
      vmul:={2,9,8,7,6,5,4,3,2}
      for vpos:=1 to 9
         valg:=val(substr(base,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=11-vres
      if vdig1>9
         vdig1:=0
      endif
      vbase2:=left(base,9)+str(vdig1,1,0)
      ok :=(vbase2==origem)
   endif
elseif puf=="RO"
   if tamanho=9
      masc_ie:="999.99999-9"
      base :=padr(origem,9,"0")
      vbase2 :=substr(base,4,5)
      vsom :=0
      for vpos:=1 to 5
         valg:=val(substr(vbase2,vpos,1))
         valg:=valg*(7-vpos)
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=11-vres

      if vdig1>9
         vdig1-=10
      endif

      vbase2:=left(base,8)+str(vdig1,1,0)
      ok :=(vbase2==origem)
   else
      masc_ie:="9999999999999-9"
      base :=padr(origem,14,"0")
      vmul :={6,5,4,3,2,9,8,7,6,5,4,3,2}
      vsom :=0
      for vpos:=1 to 13
         valg:=val(substr(base,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=11-vres

      if vdig1>9
         vdig1-=10
      endif

      vbase2:=left(base,13)+str(vdig1,1,0)
      ok :=(vbase2==origem)
   endif
elseif puf=="RR"
   masc_ie:="99999999-9"
   base :=padr(origem,9,"0")
   if left(base,2)=="24"
      vsom:=0
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*vpos
         vsom+=valg
      next
      vres :=vsom%9
      vdig1 :=str(vres,1,0)
      vbase2:=left(base,8)+vdig1
      ok :=(vbase2==origem)
   endif
elseif puf=="SC"
   masc_ie:="999.999.999"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=if(vres<2,"0",str(11-vres,1,0))
   vbase2:=left(base,8)+vdig1
   ok :=(vbase2==origem)
elseif puf=="SP"
   if left(base,1)=="P"
      masc_ie:="P-99999999.9/999"
      base :=padr(origem,13,"0")
      vbase2 :=substr(base,2,8)
      vsom :=0
      vmul :={1,3,4,5,6,7,8,10}
      for vpos:=1 to 8
         valg:=val(substr(vbase2,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=right(str(vres,2,0),1)
      vbase2:=left(base,9)+vdig1+substr(base,11,3)
   else
      masc_ie:="999.999.999.999"
      base :=padr(origem,12,"0")
      vsom :=0
      vmul :={1,3,4,5,6,7,8,10}
      for vpos:=1 to 8
         valg:=val(substr(base,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig1 :=right(str(vres,2,0),1)
      vbase2:=left(base,8)+vdig1+substr(base,10,2)
      vsom :=0
      vmul :={3,2,10,9,8,7,6,5,4,3,2}
      for vpos:=1 to 11
         valg:=val(substr(base,vpos,1))
         valg:=valg*vmul[vpos]
         vsom+=valg
      next
      vres :=vsom%11
      vdig2 :=right(str(vres,2,0),1)
      vbase2+=vdig2
   endif
   ok:=(vbase2==origem)
elseif puf=="SE"
   masc_ie:="99999999-9"
   base :=padr(origem,9,"0")
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(base,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=11-vres
   if vdig1>9
      vdig1:=0
   endif
   vbase2:=left(base,8)+str(vdig1,1,0)
   ok :=(vbase2==origem)
elseif puf=="TO"
     * masc_ie:="99.99.999999-9"
     * base :=padr(origem,11,"0")
   masc_ie:="99.999999-9"
   base :=padr(origem,09,"0")
     * if substr(base,3,2)$"01,02,03,99"
     * vbase2:=left(base,2)+substr(base,5,6)
   vbase2:=substr(base,1,8)
   vsom :=0
   for vpos:=1 to 8
      valg:=val(substr(vbase2,vpos,1))
      valg:=valg*(10-vpos)
      vsom+=valg
   next
   vres :=vsom%11
   vdig1 :=str(if(vres<2,0,11-vres),1,0)
   vbase2:=left(base,08)+vdig1
   ok :=(vbase2==origem)
     * endif
else
   DBOX("Unidade Federal Inv lida.",,,,,"ATEN€ŽO! "+usuario,,,,)
endif

if !ok
   if empty(vbase2)
      *f_esper("I.E.: "+Pie+" Estado : "+puf+chr(13)+chr(10)+"Os Digitos Identificadores de Cidade e/ou Estado Nao Conferem!")
      DBOX("Inscri‡„o Estadual: "+Pie+" - Estado: "+puf+"|Os D¡gitos Identificadores de Cidade e/ou Estado n„o conferem!",,,,,"ATEN€ŽO! "+usuario,,,,)
   else
      vbase2:=strtran(transform(val(vbase2),masc_ie)," ","0")
      vbase2:=strtran(vbase2,",",".")
      *f_esper("Inscri‡„o Inv lida, O Correto Seria : "+vbase2)
      DBOX("Inscri‡„o Estadual inv lida, o correto seria: "+vbase2,,,,,"ATEN€ŽO! "+usuario,,,,)
   endif
   retu .f.
endif

RETU .T.   // <- deve retornar um valor L¢GICO
*/




/*
   Sintaxe: VAL_CGC( <ExpC1> )
   Funcao.: Valida CNPJ (Pessoa Juridica).
              ExpC1 = Digitos do CNPJ para Validar.
   Local..: Variaveis locais utilizadas.
   Retorna: .t. se Ok.
*/
Function VAL_CGC( cDig )
   Local i   // Variavel de interacao do FOR...NEXT.

   // Formata os Dados passados.
   if cDig = NIL   // Nao veio os Digitos para Validar?
      cDig := ""   // Nao vai VALIDAR nenhum numero...
   endif

   // Terminar de Implementar.
return .t.


/*
   Sintaxe: VAL_CPF( <ExpC1> )
   Funcao.: Valida CPF (Pessoa Fisica).
              ExpC1 = Digitos do CPF para Validar.
   Local..: Variaveis locais utilizadas.
   Retorna: .t. se Ok.
*/
Function VAL_CPF( cDig )
   Local i   // Variavel de interacao do FOR...NEXT.

   // Formata os Dados passados.
   if cDig = NIL   // Nao veio os Digitos para Validar?
      cDig := ""   // Nao vai VALIDAR nenhum numero...
   endif

   // Terminar de Implementar.

return .t.



/*
   Sintaxe: LIM_DOC( <ExpC1> )
   Funcao.: Limpa Documentos (CNPJ / CPF / I.E.).
              ExpC1 = Digitos do Documento para Limpar.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno do Documento sem os Caracteres.
   Retorna: String do Documento Limpo.
*/
Function LIM_DOC( cDig )
   Local cRet := ""   // String de Retorno. Por enquanto eh vazio.

   // Formata os Dados passados.
   if cDig = NIL   // Nao veio os Digitos para Limpar?
      cDig := ""   // Nao vai LIMPAR nenhum Documento...
   endif

   // Vamos Limpar.
   if !empty( cDig )
      cRet := alltrim( cDig )        // Retira-se espacos em branco antes e apos.
      cRet := strtran( cRet, ' ' )   // Retira-se espacos em branco " " dentro.
      cRet := strtran( cRet, '.' )   // Retira-se pontos "." dentro.
      cRet := strtran( cRet, '/' )   // Retira-se barras "/" dentro.
      cRet := strtran( cRet, '-' )   // Retira-se tracos "-" dentro.
      cRet := alltrim( cRet )        // Retira-se espacos em branco antes e apos.
   endif

return cRet




/*
   Sintaxe: FOR_VLR( <ExpC1> )
   Funcao.: Formata Valores.
              ExpC1 = Digitos do Documento para Limpar.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno do Documento sem os Caracteres.
   Retorna: String do Valor Formatado.
*/
Function FOR_VLR( cDig )
   Local cRet := ""   // String de Retorno. Por enquanto eh vazio.

   // Formata os Dados passados.
   if cDig = NIL   // Nao veio o Valor para Formatar?
      cDig := ""   // Nao vai FORMATAR nenhum Valor...
   endif

   // Vamos Formatar.
   if !empty( cDig )
      // Terminar de Implementar.
   endif

return cRet


/*
function formataValorCurrencyNFe(cValor: string; Deci: Integer): string;
var
 valortmp: string;
begin
  Try
  valortmp := StrTran(FormataPrecoUnitario( StrToCurr(cValor), Deci ),'.','');
  except
  valortmp := '0,00';
  end;
  Result := StrTran(valortmp,',','.');
end;
 
Function formataPrecoUnitario(Valor : Currency; Decimais:Integer): string;
Begin
   Try
   Result := TRIM(Format( '%-14.'+IntToStr(Decimais)+'n', [valor]));
   Except
   Result := CurrToStr(valor);
   End;
End;
*/


/*

Function AjustaNum (vVal As Double, vDec As Integer) As String
Dim vMask As String
  'AjustaNum = LTrim(Str(Int(vVal)) & "." & RPad(Trim(Str(Int((vVal - Int(vVal)) * 10 ^ vDec))), vDec, "0"))
  Select Case vDec
        Case 0
            vMask = "##,##0"
        Case 1
            vMask = "##,##0.0"
        Case 2
            vMask = "##,##0.00"
        Case 3
            vMask = "##,##0.000"
        Case 4
            vMask = "##,##0.0000"
  End Select
  
  AjustaNum = Substitui(Retira(Format(vVal, vMask), ".", -1), ",", ".", -1)

End Function

*/



/*
   Sintaxe: FOR_TXT( <ExpC1> )
   Funcao.: Formata Texto com caracteres especiais.
              ExpC1 = Digitos do Texto para formatar.
   Local..: Variaveis locais utilizadas.
              cRet = Variavel de Retorno do Texto sem os Caracteres especiais.
   Retorna: String do Valor Formatado.
*/
Function FOR_TXT( cDig )
   Local cRet := ""   // String de Retorno. Por enquanto eh vazio.


return cRet


/*
caractere | seqüência de escape
-----------------------------
   <            &lt;
   >            &gt;
   &            &amp;
   "            &quot;
   '            &#39;
*/


* \\ Final de ACBr_FUN.PRG



/*
function TACBrValidador.FormatarCheque(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 7, '0') ; { Prenche zeros a esquerda }
  Result := copy(S,1,6) + '-' + copy(S,7,1) ;
end;

function TACBrValidador.FormatarCEP(AString: String): String;
Var S : String ;
begin
  S := padL( LimpaDocto(AString), 8, '0') ; { Prenche zeros a direita }
  Result := copy(S,1,5) + '-' + copy(S,6,3) ;
end;

Procedure TACBrValidador.ValidarCheque ;
begin
  if not StrIsNumber( fsDocto ) then
  begin
     fsMsgErro := 'Digite apenas os números do Cheque' ;
     exit ;
  end ;

  Modulo.CalculoPadrao ;
  Modulo.Documento := copy(fsDocto, 1, length(fsDocto)-1) ;
  Modulo.Calcular ;
  fsDigitoCalculado := IntToStr( Modulo.DigitoFinal ) ;

  if fsDigitoCalculado <> copy(fsDocto, length(fsDocto), 1) then
  begin
     fsMsgErro := 'Número de Cheque inválido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito correto: '+fsDigitoCalculado ;
  end ;
end;




function TACBrValidador.FormatarCNPJ(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 14, '0') ;
  Result := copy(S,1,2) + '.' + copy(S,3,3) + '.' +
            copy(S,6,3) + '/' + copy(S,9,4) + '-' + copy(S,13,2) ;
end;



Procedure TACBrValidador.ValidarCNPJ ;
Var DV1, DV2 : String ;
begin
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, 14, '0') ;

  if (Length( fsDocto ) <> 14) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'CNPJ deve ter 14 digitos. (Apenas numeros)' ;
     exit
  end ;

  if fsDocto = StringOfChar('0',14) then  // Prevenção contra 00000000000000
  begin
     fsMsgErro := 'CNPJ inválido.' ;
     exit ;
  end ;

  Modulo.CalculoPadrao ;
  Modulo.Documento := copy(fsDocto, 1, 12) ;
  Modulo.Calcular ;
  DV1 := IntToStr( Modulo.DigitoFinal ) ;

  Modulo.Documento := copy(fsDocto, 1, 12)+DV1 ;
  Modulo.Calcular ;
  DV2 := IntToStr( Modulo.DigitoFinal ) ;

  fsDigitoCalculado := DV1+DV2 ;

  if (DV1 <> fsDocto[13]) or (DV2 <> fsDocto[14]) then
  begin
     fsMsgErro := 'CNPJ inválido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro +  '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;





function TACBrValidador.FormatarCPF(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 11, '0') ;
  Result := copy(S,1,3) + '.' + copy(S,4 ,3) + '.' +
            copy(S,7,3) + '-' + copy(S,10,2) ;
end;

Procedure TACBrValidador.ValidarCPF ;
Var DV1, DV2 : String ;
begin
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, 11, '0') ;

  if (Length( fsDocto ) <> 11) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'CPF deve ter 11 digitos. (Apenas numeros)' ;
     exit
  end ;

  if pos(fsDocto,'11111111111.22222222222.33333333333.44444444444.55555555555.'+
         '66666666666.77777777777.88888888888.99999999999.00000000000') > 0 then
  begin
     fsMsgErro := 'CPF inválido !' ;
     exit ;
  end ;

  Modulo.MultiplicadorInicial := 2  ;
  Modulo.MultiplicadorFinal   := 11 ;
  Modulo.FormulaDigito        := frModulo11 ;
  Modulo.Documento := copy(fsDocto, 1, 9) ;
  Modulo.Calcular ;
  DV1 := IntToStr( Modulo.DigitoFinal ) ;

  Modulo.Documento := copy(fsDocto, 1, 9)+DV1 ;
  Modulo.Calcular ;
  DV2 := IntToStr( Modulo.DigitoFinal ) ;

  fsDigitoCalculado := DV1+DV2 ;

  if (DV1 <> fsDocto[10]) or (DV2 <> fsDocto[11]) then
  begin
     fsMsgErro := 'CPF inválido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;







Procedure TACBrValidador.ValidarIE ;
Const
   c0_9 : String = '0-9' ;
   cPesos : array[1..13] of array[1..14] of Integer =
      ((0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,2 ,3 ,4 ,5 ,6 ),
       (0 ,0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,2 ,3 ,4 ,5 ),
       (2 ,0 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,2 ,3 ,4 ,5 ,6 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ),
       (0 ,8 ,7 ,6 ,5 ,4 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,0 ,0 ,8 ,9 ,0 ,0 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,1 ,2 ,3 ,4 ,5 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ),
       (0 ,0 ,2 ,3 ,4 ,5 ,6 ,7 ,2 ,3 ,4 ,5 ,6 ,7 ),
       (0 ,0 ,2 ,1 ,2 ,1 ,2 ,1 ,2 ,1 ,1 ,2 ,1 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,11,2 ,3 ,0 ),
       (0 ,0 ,0 ,0 ,10,8 ,7 ,6 ,5 ,4 ,3 ,1 ,0 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,2 ,3 ,0, 0 ) ) ;

Var
   vDigitos : array of String ;
   xROT, yROT :  String ;
   Tamanho, FatorF, FatorG, I, xMD, xTP, yMD, yTP, DV, DVX, DVY : Integer ;
   SOMA, SOMAq, nD, M : Integer ;
   OK : Boolean ;
   Passo, D : Char ;

begin

  if fsComplemento = '' then
  begin
     fsMsgErro := 'Informe a UF no campo Complemento' ;
     exit ;
  end ;

  ValidarUF( fsComplemento ) ;
  if fsMsgErro <> '' then
     exit ;

  { Somente digitos ou letra P na primeira posicao }
  { P é usado pela Insc.Estadual de Produtor Rural de SP }
  if ( not StrIsNumber( copy(fsDocto,2,length(fsDocto) ))) or
     ( not CharIsNum(fsDocto[1]) and (fsDocto[1] <> 'P')) then
  begin
     fsMsgErro := 'Caracteres inválidos na Inscrição Estadual' ;
     exit
  end ;

  Tamanho := 0  ;
  xROT    := 'E';
  xMD     := 11 ;
  xTP     := 1  ;
  yROT    := '' ;
  yMD     := 0  ;
  yTP     := 0  ;
  FatorF  := 0  ;
  FatorG  := 0  ;

  SetLength( vDigitos, 13);
  vDigitos := VarArrayOf(['','','','','','','','','','','','','','']) ;

  if fsComplemento = 'AC' then
  begin
     if Length(fsDocto) = 9 then
      begin
        Tamanho := 9 ;
        vDigitos := VarArrayOf(
           ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1','0','','','','',''] ) ;
      end
     else
      if Length(fsDocto) = 13 then
      begin
        Tamanho := 13 ;
        xTP := 2   ;   yROT := 'E'   ;   yMD  := 11   ;   yTP  := 1 ;
        vDigitos := VarArrayOf(
          ['DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1','0','']);
      end ;
  end ;

  if fsComplemento = 'AL' then
  begin
     Tamanho := 9 ;
     xROT := 'BD' ;
     vDigitos   := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'4','2','','','','',''] ) ;
  end ;

  if fsComplemento = 'AP' then
  begin
     if Length(fsDocto) = 9 then
      begin
        Tamanho := 9 ;
        xROT := 'CE' ;
        vDigitos   := VarArrayOf(
           ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'3','0','','','','',''] ) ;

        if (fsDocto >= '030170010') and (fsDocto <= '030190229') then
           FatorF := 1
        else if fsDocto >= '030190230' then
           xROT := 'E' ;
      end ;
  end ;

  if fsComplemento = 'AM' then
  begin
     Tamanho := 9 ;
     vDigitos  := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'4,7','0','','','','',''] ) ;
  end ;

  if fsComplemento = 'BA' then
  begin
     Tamanho := 8 ;
     xTP := 2   ;   yTP  := 3   ;   yROT := 'E' ;
     vDigitos := VarArrayOf(
        ['DVX','DVY',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','','','',''] ) ;

     if pos(fsDocto[1],'0123458') > 0 then
      begin
        xMD := 10   ;   yMD := 10 ;
      end
     else
      begin
        xMD := 11   ;   yMD := 11 ;
      end ;
  end ;

  if fsComplemento = 'CE' then
  begin
     Tamanho := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0','','','','',''] ) ;
  end ;

  if fsComplemento = 'DF' then
  begin
     Tamanho := 13 ;
     xTP := 2   ;   yROT := 'E'  ;   yMD  := 11   ;   yTP  := 1 ;
     vDigitos  := VarArrayOf(
        ['DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'3,4','7','0','']);
  end ;

  if fsComplemento = 'ES' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0,8','0','','','','',''] ) ;
  end ;

  if fsComplemento = 'GO' then
  begin
     if Length(fsDocto) = 9 then
     begin
        Tamanho  := 9 ;
        vDigitos := VarArrayOf(
           [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0,1,5','1','','','','',''] ) ;

        if (fsDocto >= '101031050') and (fsDocto <= '101199979') then
           FatorG := 1 ;
     end ;
  end ;

  if fsComplemento = 'MA' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'2','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'MT' then
  begin
     Tamanho := 11 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','',''] ) ;
  end ;

  if fsComplemento = 'MS' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'8','2','','','','',''] ) ;
  end ;

  if fsComplemento = 'MG' then
  begin
     Tamanho  := 13 ;
     xROT := 'AE'    ;   xMD := 10   ;   xTP := 10 ;
     yROT := 'E'     ;   yMD := 11   ;   yTP := 11 ;
     vDigitos := VarArrayOf(
       ['DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'']);
  end ;

  if fsComplemento = 'PA' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'5','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'PB' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'6','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'PR' then
  begin
     Tamanho := 10 ;
     xTP := 9   ;   yROT := 'E'   ;   yMD := 11   ;   yTP := 8 ;
     vDigitos := VarArrayOf(
        [ 'DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','',''] ) ;
  end ;

  if fsComplemento = 'PE' then
  begin
     if Length(fsDocto) = 14 then
     begin
        Tamanho := 14;
        xTP := 7  ;   FatorF := 1;
        vDigitos := VarArrayOf(
          ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1-9','8','1']);
     end
     else
      if Length(fsDocto) = 9 then
      begin
        Tamanho := 9;
        xTP  :=  9   ;  xMD := 11;
        yROT := 'E'  ;  yMD := 11  ;   yTP := 7;
        vDigitos := VarArrayOf(
        [ 'DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','','',''] );
      end;
  end;

  if fsComplemento = 'PI' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'9','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'RJ' then
  begin
     Tamanho := 8 ;
     xTP := 8 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1,7,8,9','','','','','',''] ) ;
  end ;

  if fsComplemento = 'RN' then
  begin
     Tamanho := 9 ;
     xROT := 'BD' ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,'0-3','0','2','','','','',''] ) ;
  end ;

  if fsComplemento = 'RS' then
  begin
     Tamanho := 10 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0-4','','','',''] ) ;
  end ;

  if fsComplemento = 'RO' then
  begin
     FatorF := 1 ;
     if Length(fsDocto) = 9 then
     begin
        Tamanho := 9 ;
        xTP := 4 ;
        vDigitos := VarArrayOf(
          [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1-9','','','','',''] ) ;
     end ;

     if Length(fsDocto) = 14 then
     begin
        Tamanho  := 14 ;
        vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9]);
     end ;
  end ;
  
  if fsComplemento = 'RR' then
  begin
     Tamanho  := 9 ;
     xROT := 'D'   ;   xMD := 9   ;   xTP := 5 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'4','2','','','','',''] ) ;
  end ;

  if (fsComplemento = 'SC') or (fsComplemento = 'SE') then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','','',''] ) ;
  end;

  if fsComplemento = 'SP' then
  begin
     xROT := 'D'   ;   xTP := 12 ;
     if fsDocto[1] = 'P' then
      begin
        Tamanho  := 13 ;
        vDigitos := VarArrayOf(
         [c0_9,c0_9,c0_9,'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'P','']);
      end
     else
      begin
        Tamanho  := 12 ;
        yROT := 'D'   ;   yMD := 11   ;   yTP := 13 ;
        vDigitos := VarArrayOf(
         ['DVY',c0_9,c0_9,'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','']);
      end ;
  end ;

  if fsComplemento = 'TO' then
  begin
     if Length(fsDocto)=11 then
      begin
        Tamanho := 11 ;
        xTP := 6 ;
        vDigitos := VarArrayOf(
          ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1,2,3,9','0,9','9','2','','','']);
      end
     else
      begin
        Tamanho := 10 ;
        vDigitos := VarArrayOf(
          [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0-4','','','',''] ) ;
      end;
  end ;

  { Verificando se o tamanho Total está correto }
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, Tamanho, '0') ;

  OK := (Tamanho > 0) and (Length(fsDocto) = Tamanho) ;
  if not OK then
     fsMsgErro := 'Tamanho Inválido' ;

  { Verificando os digitos nas posicoes são permitidos }
  fsDocto := padR(fsDocto,14) ;
  DVX := 0  ;
  DVY := 0  ;
  I   := 13 ;
  while OK and (I >= 0) do
  begin
     D := fsDocto[14-I] ;

     if vDigitos[I] = '' then
        OK := (D = ' ')

     else if (vDigitos[I] = 'DVX') or (vDigitos[I] = 'DVY') or
             (vDigitos[I] = c0_9) then
      begin
        OK := CharIsNum( D ) ;

        if vDigitos[I] = 'DVX' then
           DVX := StrToIntDef( D, 0 )
        else
           if vDigitos[I] = 'DVY' then
              DVY := StrToIntDef( D, 0 ) ;
      end

     else if pos(',',vDigitos[I]) > 0 then   { Ex: '2,5,7,8' Apenas os da lista}
        OK := (pos( D, vDigitos[I] ) > 0)

     else if pos('-',vDigitos[I]) > 0 then
        OK := ( (D >= copy(vDigitos[I],1,1)) and (D <= copy(vDigitos[I],3,1)) )

     else
        OK := ( D = vDigitos[I] ) ;

     if not OK then
        fsMsgErro := Format('Digito %d deveria ser %s ',
         [14-I-(14-Tamanho), vDigitos[I]]) ;

     I := I - 1 ;
  end ;

  Passo := 'X' ;
  while OK and (xTP > 0) do
  begin
     SOMA := 0  ;
     SOMAq:= 0  ;
     I    := 14 ;

     while OK and (I > 0) do
     begin
        D := fsDocto[15-I] ;

        if CharIsNum(D) then
        begin
           nD := StrToIntDef(D,0) ;
           M  := nD * cPesos[xTP,I] ;
           SOMA := SOMA + M ;

           if pos('A',xROT) > 0 then
              SOMAq := SOMAq + Trunc(M / 10) ;
        end ;

        I := I - 1 ;
     end ;

     if pos('A',xROT) > 0 then
        SOMA := SOMA + SOMAq

     else if pos('B',xROT) > 0 then
        SOMA := SOMA * 10

     else if pos('C',xROT) > 0 then
        SOMA := SOMA + (5 + (4 * FatorF) ) ;

     { Calculando digito verificador }
     DV := Trunc(SOMA mod xMD) ;
     if pos('E',xROT) > 0 then
        DV := Trunc(xMD - DV) ;

     if DV = 10 then
        DV := FatorG   { Apenas GO modifica o FatorG para diferente de 0 }
     else if DV = 11 then
        DV := FatorF ;

     if Passo = 'X' then
        OK := (DVX = DV)
     else
        OK := (DVY = DV) ;

     fsDigitoCalculado := IntToStr(DV) ;
     if not OK then
     begin
        fsMsgErro := 'Digito verificador inválido.' ;

        if fsExibeDigitoCorreto then
           fsMsgErro := fsMsgErro + '.. Calculado: '+fsDigitoCalculado ;
     end ;

     if PASSO = 'X' then
      begin
        PASSO := 'Y'  ;
        xROT  := yROT ;
        xMD   := yMD  ;
        xTP   := yTP  ;
      end
     else
        break ;
  end ;

  fsDocto := Trim( fsDocto ) ;
  if (fsMsgErro <> '') then
     fsMsgErro := 'Insc.Estadual inválida para '+fsComplemento +' '+ fsMsgErro ;

end;







Procedure TACBrValidador.ValidarUF(UF: String) ;
begin
 if pos( ','+UF+',', ',AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,'+
                     'RJ,RN,RS,RO,RR,SC,SP,SE,TO,') = 0 then
    fsMsgErro := 'UF inválido: '+UF ;
end;

function TACBrValidador.FormatarPIS(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 11, '0') ;
  Result := copy(S,1,2) + '.' + copy(S,3,5) + '.' +
            copy(S,8,3) + '.' + copy(S,11,1)
end;

procedure TACBrValidador.ValidarPIS;
begin
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, 11, '0') ;

  if (Length( fsDocto ) <> 11) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'PIS deve ter 11 digitos. (Apenas numeros)' ;
     exit
  end ;

  Modulo.CalculoPadrao ;
  Modulo.FormulaDigito := frModulo10 ;
  Modulo.Documento     := copy(fsDocto, 1, 10) ;
  Modulo.Calcular ;
  fsDigitoCalculado := IntToStr( Modulo.DigitoFinal ) ;

  if (fsDigitoCalculado <> fsDocto[11]) then
  begin
     fsMsgErro := 'PIS inválido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;










//// {------------------------------ unit ACBrValidador ------------------------------}
type
{ Componente ACBrValidador }
TACBrValidador = class( TACBrComponent )
  private
    { Propriedades do Componente ACBrValidador }
    fsIgnorarChar: String;
    fsDocumento: String;
    fsComplemento: String;
    fsDocto    : String;
    fsMsgErro: String;
    fsRaiseExcept: Boolean;
    fsOnMsgErro: TACBrValidadorMsg;
    fsTipoDocto: TACBrValTipoDocto;
    fsPermiteVazio: Boolean;
    fsAjustarTamanho: Boolean;
    fsModulo: TACBrCalcDigito;
    fsExibeDigitoCorreto: Boolean;
    fsDigitoCalculado: String;

    procedure SetDocumento(const Value: String);
    procedure SetComplemento(const Value: String);
    Function LimpaDocto(const AString : String) : String ;

    Procedure ValidarCPF  ;
    Procedure ValidarCNPJ ;
    Procedure ValidarUF( UF : String) ;
    Procedure ValidarIE ;
    Procedure ValidarCheque ;
    Procedure ValidarPIS  ;
    Procedure ValidarCEP ;
    procedure ValidarCartaoCredito ;
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

    property DoctoValidado : String read fsDocto ;

    Property MsgErro : String read fsMsgErro ;
    Property Modulo  : TACBrCalcDigito read fsModulo write fsModulo ;
    Property DigitoCalculado : String read fsDigitoCalculado ;

    Function Validar  : Boolean;
    Function Formatar : String ;

    Function FormatarCPF( AString : String )    : String ;
    Function FormatarCNPJ( AString : String )   : String ;
    Function FormatarCheque( AString : String ) : String ;
    Function FormatarPIS( AString : String )    : String ;
    Function FormatarCEP( AString: String )     : String ;

//// {------------------------------ unit ACBrValidador ------------------------------}




{------------------------------ TACBrCalcDigito ------------------------------}
constructor TACBrCalcDigito.Create;
begin
  fsDocto         := '' ;
  fsDigitoFinal   := 0 ;
  fsSomaDigitos   := 0 ;
  fsMultIni       := 2 ;
  fsMultFim       := 9 ;
  fsFormulaDigito := frModulo11 ;
end;

procedure TACBrCalcDigito.Calcular;
Var A,N,Base,Tamanho : Integer ;
begin
  fsDocto       := Trim(fsDocto) ;
  fsSomaDigitos := 0 ;
  fsDigitoFinal := 0 ;
  Base          := fsMultIni ;
  Tamanho       := Length(fsDocto) ;

  { Calculando a Soma dos digitos de traz para diante, multiplicadas por BASE }
  For A := 1 to Tamanho do
  begin
     N := StrToIntDef( fsDocto[ Tamanho - A + 1 ], 0 ) ;
     fsSomaDigitos := fsSomaDigitos + (N * Base) ;

     Inc( Base ) ;
     if Base > fsMultFim then
        Base := fsMultIni ;
  end ;

  case fsFormulaDigito of
    frModulo11 :
      begin
        fsDigitoFinal := fsSomaDigitos mod 11 ;

        if fsDigitoFinal < 2 then
           fsDigitoFinal := 0
        else
           fsDigitoFinal := 11 - fsDigitoFinal ;
      end ;

    frModulo10 :
      begin
        fsDigitoFinal := 11 - (fsSomaDigitos mod 11);

        if (fsDigitoFinal >= 10) then
           fsDigitoFinal := 0;
      end ;
  end;
end;

procedure TACBrCalcDigito.CalculoPadrao;
begin
  fsMultIni       := 2 ;
  fsMultFim       := 9 ;
  fsFormulaDigito := frModulo11 ;
end;

end.

*/


