* PRG......................: IMPACBR
* CLASSE...................: Impressora Fiscal com ACBrMonitor
* DESC.....................: Abre porta, envia comandos, fecha porta
* PREFIXO..................: IBR
* EXPORTADORA..............: IBR_*
* CONSTRUTORA..............: IBR_INIT()
* DESTRUTORA...............: IBR_END()
* USA......................:
* NOTAS....................: Deve ser compilada com /n uma vez que utiliza
*                            estatica externa. Nao ha construtora.
*                            Trapaceamos e inicializamos com uma estatica
*                            externa!

#include "commands.ch"
#define  ETX chr(3)
#define  CR  chr(13)
#define  LF  chr(10)

Static sENDER   := '',;
       SEM_ERRO := .F.

#ifdef __XHARBOUR__
Static sSOCKET
#endif

************************************************************************
Function IBR_INIT(ENDERECO)   // Abre a comunicação com o ACBrmonitor
************************************************************************
Local P, RET := .T., TFIM, IP, PORTA

if ! empty(sENDER)  // J  est  aberto...
   return .t.
endif

SEM_ERRO := .F.
sENDER   := ENDERECO
IP       := ''
PORTA    := 0

#ifdef __XHARBOUR__
if ! PATH_DEL $ sENDER   /// Abrir comunicacao TCP/IP
   P := at(':',sENDER)
   if P = 0
      P := len(sENDER)+1
   endif
   
   IP    := substr(sENDER,1,P-1)
   PORTA := val(substr(sENDER,P+1))
   if PORTA = 0
      PORTA := 3434
   endif
   
   inetinit()
   RET := .F.

   TFIM := Seconds() + 5             /// Tenta conectar durante 5 segundos ///
   do while Seconds() < TFIM .and. ! RET
      sSOCKET := inetconnect(IP,PORTA)
      RET     := (ineterrorcode(sSOCKET) = 0)
      
      millisec(200)
   enddo
   
   if RET
      InetSetTimeout( sSOCKET, 3000 )   // Timeout de Recepção 3 seg //
      RET := ('ACBrMonitor' $ InetRecvEndBlock( sSOCKET, ETX ) )   // Recebeu as boas vindas ?
   endif
endif
#endif

if ! RET
   sENDER := ''
endif

if RET
   RET := IBR_OK( IBR_COMANDO( 'Ativar' ))
endif

return RET

************************************************************************
Function IBR_END()   // Fecha a porta da Impressora
* Encerra a cominicacao com a impressora, nao precisa de parametros
************************************************************************

#ifdef __XHARBOUR__
if ! PATH_DEL $ sENDER   /// Fechar comunicacao TCP/IP
   if ! empty(sENDER)
      IBR_COMANDO('ACBR.bye')
   endif
   
   inetclose(sSOCKET)
   inetdestroy(sSOCKET)
   inetcleanup()
endif
#endif

sENDER := ''

return .t.

************************************************************************
Function IBR_ABERTA()   // Retorna .t. se a COM ja est  aberta
************************************************************************

return ! empty(sENDER)

************************************************************************
Function IBR_OK(RESP)   // Retorna .T. se a String inicia com OK:
************************************************************************
return (substr(RESP,1,3) == 'OK:')

************************************************************************
Function IBR_ZERA()   // Reseta Impressora em ERRO, Retorna .t. se OK
************************************************************************

return IBR_OK( IBR_COMANDO( 'CorrigeEstadoErro', 40 ))

************************************************************************
Function IBR_TEF_INIT()   // Carrega na mem¢ria vetores com Planos de
*                            Pagamento e CNF
************************************************************************

IBR_FIM_REL()
return IBR_OK( IBR_COMANDO( 'PreparaTEF', 8 ) )

************************************************************************
Function IBR_LEITURAX()   // Imprime relatorio de Leitura X, retorna .t. se ok
************************************************************************

return IBR_OK( IBR_COMANDO( 'LeituraX', 40 ) )

************************************************************************
Function IBR_REDUCAOZ()   // Imprime relatorio de Reducao Z, retorna .t. se ok
************************************************************************

return IBR_OK( IBR_COMANDO( 'ReducaoZ("'+dtoc(date())+' '+time()+'")', 40 ))

************************************************************************
Function IBR_DATA()   // Le a Data gravada na Impressora
* Retorna a data da impressora no tipo DATE
************************************************************************
Local RET

return ctod(substr(IBR_COMANDO( 'DataHora' ),5,8))

************************************************************************
Function IBR_HORA()   // Le a Hora gravada na Impressora
* Retorna uma string com a hora da impressora
************************************************************************

return substr(IBR_COMANDO( 'DataHora' ),14,8)

************************************************************************
Function IBR_VERAO()   // Entra ou Sai do Hor rio de Verao, retorna .T. se ok
************************************************************************

return IBR_OK( IBR_COMANDO( 'MudaHorarioVerao', 8 ) )

************************************************************************
Function IBR_NUM_CUPOM()   // Le o Numero do ultimo Cupom,
* Retorna string tamanho 6 com o numero do ultimo cupom
************************************************************************

return StrZero(val(substr(IBR_COMANDO( 'NumCupom' ),5)),6)

************************************************************************
Function IBR_SUBTOTAL()   // Retorna o Subtotal do cupom aberto
************************************************************************
Local WSTR

WSTR := substr(IBR_COMANDO( 'SubTotal' ),5)

return val(StrTran(WSTR,',','.'))

************************************************************************
Function IBR_TOTALPAG()   // Retorna o Total de Pagamentos efetuados
************************************************************************
Local WSTR

WSTR := substr(IBR_COMANDO( 'TotalPago' ),5)

return val(StrTran(WSTR,',','.'))

************************************************************************
Function IBR_NUM_CAIXA()   // Le o Numero do caixa
* Retorna string tamanho 4 com o numero do caixa da impressora,
* geralmente '0001' a nao ser que no estabelecimento existam 2 impressoras
************************************************************************

return StrZero(val(substr(IBR_COMANDO( 'NumECF' ),5)),4)

************************************************************************
Function IBR_NUM_SERIE()   // Retorna o Numero de S‚rie da Impressora
************************************************************************

return Alltrim(substr(IBR_COMANDO( 'NumSerie' ),5))

************************************************************************
Function IBR_VERSAO()   // Le o Numero de versao da impressora 4 dig.
************************************************************************

return Alltrim(substr(IBR_COMANDO( 'NumVersao' ),5))

************************************************************************
Function IBR_POUCO_PAPEL()  // Retorna .t. se for pouco papel
************************************************************************

return (upper(substr(IBR_COMANDO( 'PoucoPapel' ),5,5)) = 'TRUE')

************************************************************************
Function IBR_CUPOM_ABERTO()  // Retorna .t. se cupom estiver aberto
************************************************************************

return (upper(alltrim(substr(IBR_COMANDO( 'Estado' ),5))) = 'ESTVENDA')

************************************************************************
Function IBR_PODE_ABRIR()  // Retorna .t. se pode abrir novo cupom
************************************************************************

return IBR_OK( IBR_COMANDO( 'TestaPodeAbrirCupom' ) )

************************************************************************
Function IBR_CHEQUE(WBANCO,WVALOR,WFAVORECIDO,WCIDADE,WDATA,WOBS)
* Imprime cheque, necessita de BANCOS.TXT no mesmo diretorio do DRIVER,
* retorna .T. se ok
************************************************************************

return IBR_OK( IBR_COMANDO( 'ImprimeCheque( "'+WBANCO+'", '+str(WVALOR)+', "'+;
                WFAVORECIDO+'", "'+WCIDADE+'", '+dtoc(WDATA)+', "'+WOBS+'") ' ))

************************************************************************
Function IBR_COM_CHEQUE()  // Retorna .t. se sensor de COM PAPEL ok
************************************************************************

return (upper(substr(IBR_COMANDO( 'ChequePronto' ),5,5)) = 'TRUE')

************************************************************************
Function IBR_CAN_CHEQUE()  // Cancela Impressao de cheque, retorna .t. se conseguiu
************************************************************************

return IBR_OK( IBR_COMANDO( 'CancelaImpressaoCheque' ) )

************************************************************************
Function IBR_ABRE_CUPOM(WCGC)   // Abre Cupom Fiscal, Retorna .t. se ok
* WCGC, SE RECEBIDO imprime o CGC do cliente no cabecalho
************************************************************************

return IBR_OK( IBR_COMANDO( 'AbreCupom("'+WCGC+'")', 8 ) )

************************************************************************
Function IBR_ACHA_PG(WPAGAMENTO,WVINC)  // Retorna codigo do Totalizador (String 2)
* equivalente a Forma de Pagamento passada se nao encontrar tenta cadastrar
* se conseguir retorna o novo numero, se nao conseguir encontrar nem
* cadastrar retorna "  "
* WPAGAMENTO -> String de 16, com Pagamento a localizar/Cadastra.
* WVINC -> Passado por referencia, Informa.T. se a Forma de Pagamento pode
*          imprimir Cupom Fiscal Vinculado
************************************************************************
Static VET_PLA:={}
Local RET_IMP,P,S,RET

DEFAULT WPAGAMENTO to ''

if empty(VET_PLA)
   RET_IMP := IBR_COMANDO( 'CarregaFormasPagamento', 5 )
   if IBR_OK( RET_IMP )
      RET_IMP := substr(RET_IMP,5)

      do while ! empty(RET_IMP)
         P := at('|',RET_IMP)
         if P = 0
            P := len(RET_IMP)+1
         endif
      
         S := substr(RET_IMP,1,P-1)

         aadd(VET_PLA, {substr(S,1,4), (substr(S,5,1)='S'), Alltrim(substr(S,6))} )
         RET_IMP := substr(RET_IMP,P+1)
      enddo
   endif
endif

WPAGAMENTO := Alltrim(upper(WPAGAMENTO))
POS        := ascan(VET_PLA,{|x|upper(x[3])==WPAGAMENTO})
WVINC      := .F.
RET        := ''
if POS > 0
   RET   := VET_PLA[POS,1]
   WVINC := VET_PLA[POS,2]
endif

return RET

************************************************************************
Function IBR_FECHA_CUPOM(WVAL_VISTA,WVAL_DESC,WMSG,WDESC_PLA,WA_D,WCOLUNAS,WAVISTA)
* FECHA Cupom Fiscal, retorna .t. se ok
* WVAL_VISTA -> Numerico, Valor A VISTA ou ENTRADA pago pelo cliente
*               (usado para calcular o troco)
* WVAL_DESC -> Numerico, Desconto/Acrescimo em VALOR, concedido para o cliente
* WMSG -> String, Mensagem promocional, linhas separadas por '|'
* WA_D -> String, 'a' - acrescimo, 'd' - desconto (Assume 'd' se omitida)
* WDESC_PLA -> Descricao do Plano de Pagamento
* WCOLUNAS -> Numero de caracteres por linha permitidas no cupom
* WAVISTA -> Se for .t. Considera sempre a vista
************************************************************************
Local WMSG2,VET,A,WSUB_TOTAL, WCODAV, WCODAP, ESPERA, ;
      WVAL_PRAZO  // Calculado se WVAL_VISTA for menor que SUBTOTAL

if ! IBR_INI_FECHA( WVAL_DESC )
   return .f.
endif

WSUB_TOTAL := IBR_SUBTOTAL()

if ! WAVISTA
   if WSUB_TOTAL <= 0
      ALERTA('Subtotal retornado pela impressora ‚: '+transform(WSUB_TOTAL,'@E 999.99')+;
             '|Cupom ser  considerado A VISTA.',,,COR_ERRO)
      WAVISTA := .T.
   else
      WCODAP := IBR_ACHA_PG('A PRAZO')

      if empty(WCODAP)
         ALERTA('Forma de pagamento A PRAZO n†o encontrada.|'+;
                'Cupom ser  considerado A VISTA.',,,COR_ERRO)
         WAVISTA := .T.
      endif
   endif
endif

if WAVISTA
   WVAL_VISTA := max(WSUB_TOTAL,WVAL_VISTA)
   WVAL_PRAZO := 0
else
   WVAL_PRAZO := max(ROUNDING(WSUB_TOTAL - WVAL_VISTA,2),0)
endif

//// Efetua formas de pagamento A VISTA e A PRAZO ////
if ! empty(WVAL_VISTA)
   WCODAV := IBR_ACHA_PG('A VISTA')
   WCODAV := iif( empty(WCODAV), '01', WCODAV)

   RET := IBR_PAGTO( WVAL_VISTA , WCODAV )
endif

if RET .and. ! empty(WVAL_PRAZO)
   RET := IBR_PAGTO( WVAL_PRAZO , WCODAP )
endif

if RET
   RET := IBR_FIM_FECHA( WMSG )
endif

return RET

************************************************************************
Function IBR_FECHANDO()
* Retorna .t. se Iniciou o Fechamento do Cupom e estiver esperando
* Formas de Pagamento
************************************************************************

return (upper(alltrim(substr(IBR_COMANDO( 'Estado' ),5))) = 'ESTPAGAMENTO')

************************************************************************
Function IBR_INI_FECHA( WDESC_ACRES )
* Inicia FECHAMENTO de Cupom Fiscal com Formas de Pagto, retorna .t. se OK
* WDESC_ACRES -> Numerico, Desconto/Acrescimo em VALOR, concedido para o
*                cliente. Se positivo ACRESCIMO senao DESCONTO
************************************************************************

return IBR_OK( IBR_COMANDO( 'SubTotalizaCupom('+str(WDESC_ACRES)+')', 5 ))

************************************************************************
Function IBR_PAGTO( WVALOR, WCODFPG, WOBS, WVINC )
* Efetua Pagamento em Cupom. Deve ser executada apos IBR_INI_FECHA
* Retorna .t. se OK
* WVALOR -> Valor Numerico pago pela Forma de Pagamento
* WCODFPG -> Codigo da Forma de Pagamento, pode ser achado com IBR_ACHA_PG
* WOBS -> Texto de 80 caracteres para OBS
* WVINC -> Boleano, se .t. ter  Cupom NAO Fiscal vinculado a esta FPG
*          (nao ‚ necess rio na Bematech)
************************************************************************

return IBR_OK( IBR_COMANDO( 'EfetuaPagamento("'+WCODFPG+'", '+str(WVALOR)+', "'+WOBS+;
                    '", '+iif(WVINC,'TRUE','FALSE')+ ')' ) )

************************************************************************
Function IBR_FIM_FECHA( WMSG, WCOLUNAS )
* FECHA Cupom Fiscal, retorna .t. se OK
* WMSG -> String, Mensagem promocional, linhas separadas por '|'
*         checagem de colunas ‚ feita por IMF_FIM_FECHA
* WCOLUNAS -> ajustada por PAI IMF_FIM_FECHA
************************************************************************

return IBR_OK( IBR_COMANDO( 'FechaCupom( "'+WMSG+'")', 10 ) )

************************************************************************
Function IBR_ITEM(WCODIGO,WDESCRICAO,WALIQ,WQTD,WVALOR_UNIT,WDESCONTO,WUN)
* Efetua venda de itens no cupom Fiscal, retorna .t. se OK
* WCODIGO -> String, Codigo do produto 13 caracteres
* WDESCRICAO -> String, Descricao do produto 29 caracteres
* WALIQ -> % da aliquita a ser impressa, a rotina acha o totalizador
   * Se a aliquota for numerica, procura o totalizador, senao,
   * usa o propria aliquota que foi passada ('01','02','FF','NN',...)
   * FF - Totalizador de Substituicao Tributaria,
   * II - Totalizador parcial de Isen‡ao
   * NN - Totalizador parcial de NAO incidencia
* WQTD -> Numerico, Quantidade a ser impressa, a rotina ajusta a mascara
* WVALOR_UNIT -> Numerico, Valor Unitario do Produto, a rotina ajusta a mascara
* WDESCONTO -> Numerico, Desconto em % para aplicar, a rotina ajusta a mascara
* WUN - Descricao da unidade (se nulo assume 'UN')
************************************************************************

return IBR_OK( IBR_COMANDO( 'VendeItem("'+WCODIGO+'", "'+WDESCRICAO+'", "'+str(WALIQ)+'", '+;
                 str(WQTD)+', '+str(WVALOR_UNIT)+', '+str(WDESCONTO)+', '+WUN ) )

************************************************************************
Function IBR_ACHA_ALIQ(WALIQ)  // Retorna codigo do Totalizador (String 2)
* equivalente a WALIQ passada, se nao encontrar volta "  "
* WALIQ -> Numerico, % do ICMS a localizar o Totalizador.
************************************************************************
Static VET_ALIQ
Local POS:=0

if VET_ALIQ = NIL
   VET_ALIQ := IBR_ALIQ()
endif

POS := ascan(VET_ALIQ,{|x|x[1] = WALIQ})

return iif(empty(POS),"  ",VET_ALIQ[POS,2])

************************************************************************
Function IBR_ALIQ()  // Retorna vetor bi-dimensional com os codigos
* das aliquotas no formato {ALIQ(N 5,2),COD_ALIQ(C 2)}
* Fun‡ao de uso interno, pela funcao (IBR_ACHA_ALIQ())
************************************************************************
Local RET_IMP,VET_RET:={},P,S

RET_IMP := IBR_COMANDO( 'CarregaAliquotas', 5 )
if IBR_OK( RET_IMP)
   RET_IMP := substr(RET_IMP,5)
   
   do while ! empty(RET_IMP)
      P := at('|',RET_IMP)
      if P = 0
         P := len(RET_IMP)+1
      endif

      S := substr(RET_IMP,1,P-1)

      aadd(VET_RET, {val(strtran(substr(S,6,6),',','.')), substr(S,1,4)} )
      RET_IMP := substr(RET_IMP,P+1)
   enddo
endif

return VET_RET

***********************************************************************
Function IBR_CAN_CUPOM()  // Cancela Cupom fiscal, retorna .t. se ok
***********************************************************************

return IBR_OK( IBR_COMANDO( 'CancelaCupom' ), 14 )

************************************************************************
Function IBR_CAN_ITEM(WITEM)  // Cancela Item do Cupom fiscal, retona .t. se ok
* WITEM -> Numerico com Codigo sequencial do Item a cancaler
*  Ex.: 1 cancela o primeiro item vendido.
************************************************************************

return IBR_OK( IBR_COMANDO( 'CancelaItemVendido("'+WITEM+'")') )

************************************************************************
Function IBR_RELATORIO(WTXT,WVIAS,WCOLUNAS) // Imprime relatorio Gerencial
* Retorna .T. se imprimiu com sucesso
* WTXT  -> texto a Imprimir no relatorio, quebra de linhas = '|'
* WVIAS -> Numero de vias a imprimir 1 ou 2, padrao 1
* WCOLUNAS -> Numero m ximo de colunas da impressora, ajustada por IMF_RELATORIO
************************************************************************
Local VET,A,RET,WIMP

DEFAULT WVIAS to 1

VET  := SEPARA_STR(WTXT,'|')  // Separa as linhas de WTXT
WIMP := 0
RET  := .T.

IBR_FIM_REL()   // Fecha se ficou algum aberto

//// Imprime relatorio gerencial ////
MSG_SAVE('Aguarde Imprimindo Relat¢rio...')
RET := IBR_OK( IBR_COMANDO( 'AbreRelatorioGerencial', 40 ) )

do while RET
   A := 1
   do while RET .and. A <= len(VET)
      RET := IBR_OK( IBR_COMANDO( 'LinhaRelatorioGerencial("'+VET[A]+'")' ) )
      A++
   enddo

   WIMP++

   if ! RET .or. WIMP >= WVIAS
      exit
   endif

   IBR_COMANDO( 'LinhaRelatorioGerencial(" | | | | | | ")' )
   clear typeahead
   MSG('  **  DESTAQUE A '+trim(str(WIMP,2))+'¦ VIA **              ENTER - Imprime pr¢xima via',8)
enddo

if RET
   RET := IBR_FIM_REL()
endif

clear typeahead
MSG_REST()

return RET

************************************************************************
Function IBR_VINCULADO(WCOO,WCODFPG,WVALOR,WTXT,WVIAS,WCOLUNAS)
* Imprime Comprovante NAO fiscal VINCULADO, Retorna .T. se imprimiu ok
* WCOO -> Numero do Cupom para Vincular
* WCODFPG -> Forma de Pagamento executada no Cupom a vincular
* WVALOR -> Valor pago atraves da Forma de Pagamento
* WTXT  -> texto a Imprimir no relatorio, quebra de linhas = '|'
* WVIAS -> Numero de vias a imprimir 1 ou 2, padrao 1
* WCOLUNAS -> Numero m ximo de colunas da impressora, ajustada por IMF_RELATORIO
************************************************************************
Local VET,A,RET,WIMP,WDESFPG

DEFAULT WVIAS to 1

WCOO := strzero(val(WCOO),6)

//// Abrindo Comprovante NAO fiscal Vinculado ////
MSG_SAVE('Aguarde Imprimindo Cupom Vinculado... ('+WDESFPG+')')
RET := IBR_OK( IBR_COMANDO( 'AbreCupomVinculado("'+WCOO+'", "'+WCODFPG+'", '+str(WVALOR)+')', 10 ) )

VET  := SEPARA_STR(WTXT,'|')  // Separa as linhas de WTXT
WIMP := 0

//// Imprime relatorio gerencial ////
do while RET
   A := 1
   do while RET .and. A <= len(VET)
      RET := IBR_OK( IBR_COMANDO( 'LinhaCupomVinculado("'+VET[A]+'")' ) )
      A++
   enddo

   WIMP++

   if ! RET .or. WIMP >= WVIAS
      exit
   endif

   IBR_COMANDO( 'LinhaCupomVinculado(" | | | | | | ")' )
   clear typeahead
   MSG('  **  DESTAQUE A '+trim(str(WIMP,2))+'¦ VIA **              ENTER - Imprime pr¢xima via',8)
enddo

if ! IBR_FIM_REL()
   RET := .F.
endif

clear typeahead
MSG_REST()

return RET

************************************************************************
Function IBR_FIM_REL() // Encerra relatorio Gerencial e ou C.V.
************************************************************************
local RET

SEM_ERRO := .T.
RET := IBR_OK( IBR_COMANDO( 'FechaRelatorio', 10 ) )
SEM_ERRO := .F.

return RET

***********************************************************************
Function IBR_ABRE_GAVETA()  // Abre Gaveta da Impressora, retorna .t. se abriu
***********************************************************************

IBR_COMANDO( 'AbreGaveta' )

return IBR_GAVETA_ABERTA()


***********************************************************************
Function IBR_GAVETA_ABERTA()  // Retorna .t. se Gaveta est  aberta
***********************************************************************

return (upper(substr(IBR_COMANDO( 'GavetaAberta' ),5,5)) = 'TRUE')


************************************************************************
Function IBR_COMANDO(CMD,ESPERA,TENTA)
* Funcao de uso interno para enviar os comandos para a impressora e
* registrar os erros retornados pela mesma. Exibe os erros se existirem
************************************************************************
Local RET_IMP, REQ, RESP, TINI, TFIM, BLOCO, BYTES

if empty(sENDER)
   if ! SEM_ERRO
      ALERTA('Impressora ACBrMonitor|n†o foi inicializada.',,,COR_ERRO)
   endif

   return ''
endif

DEFAULT ESPERA      to 0  ,;
        TENTA       to .t.

///// Codificando CMD de acordo com o protocolo /////
RET_IMP  := ''

if ! ('.' $ left(CMD,5))   // Informou o Objeto no Inicio ?
   CMD := 'ECF.'+CMD       // Se nao informou assume ECF.
endif

CMD := CMD + CR+LF

if ! SEM_ERRO
   ESPERA := max(ESPERA,3)
else
   TENTA := .F.
endif

if PATH_DEL $ sENDER
   REQ  := sENDER+'ENT.TXT'
   RESP := sENDER+'SAI.TXT'

   //////// Transmitindo o comando /////////
   ferase( RESP )
   do while empty(RET_IMP)
      ferase( REQ )
      if ! memowrit(REQ, CMD)
         RET_IMP := 'ERRO: Nao foi possivel criar o arquivo: ('+REQ+') '+;
                    ErrorOsMessage(ferror())
      endif
      TFIM := seconds() + 7

      do while empty(RET_IMP) .and. (seconds() <= TFIM) .and. file(REQ)
         millisec(20)
      enddo

      if file(REQ)
         if ! TENTA
            RET_IMP := 'ERRO: ACBrMonitor nao esta ativo'
         else
            if ALERTA('O ACBrMonitor n†o est  ativo|'+;
                      'Deseja tentar novamente ?',{'SIM','NAO'},,COR_ERRO) # 1
               RET_IMP := 'ERRO: ACBrMonitor nao esta ativo'
            else
               if ! file(REQ)  // ACBrMonitor "acordou" enquanto perguntava
                  exit
               endif
            endif
         endif
      else
         exit
      endif
   enddo

   //////// Lendo a resposta ////////
   TINI   := Seconds()
   TELA   := savescreen(23,1,23,78)
   do while empty(RET_IMP)
      if file(RESP)
         RET_IMP := alltrim(memoread( RESP ))
      endif

      if Seconds() > (TINI + 5)
          @ 23, 2 say pad('Aguardando resposta do ACBrMonitor:  '+;
                      str(TINI + ESPERA - seconds(),2),77) color COR_MENU
      endif

      if Seconds() > (TINI + ESPERA)
         restscreen(23,1,23,78,TELA)

         if ! TENTA
            RET_IMP := 'ERRO: Sem resposta do ACBrMonitor em '+alltrim(str(ESPERA))+;
                       ' segundos (TimeOut)'
         else
            if ALERTA('O ACBrMonitor n†o est  respondendo|'+;
                      'Deseja tentar novamente ?',{'SIM','NAO'},,COR_ERRO) # 1
               RET_IMP := 'ERRO: Sem resposta do ACBrMonitor em '+alltrim(str(ESPERA))+;
                          ' segundos (TimeOut)'
            else
               TINI := Seconds()
            endif
         endif
      endif

      millisec(10)
   enddo
   restscreen(23,1,23,78,TELA)
   ferase( RESP )
#IFDEF __XHARBOUR__
else
   //////// Transmitindo o comando /////////
   InetSetTimeout( sSOCKET, 3000 )   // Timeout de Envio 3 seg //
   if inetsendall( sSocket, CMD ) <= 0
      RET_IMP := 'ERRO: Nao foi possivel transmitir dados para o ACBrMonitor|'+;
                 '('+AllTrim(Str(InetErrorCode( sSOCKET )))+') '+;
                 InetErrorDesc( sSOCKET ) + ETX
   endif

   //////// Lendo a resposta ////////
   InetSetTimeout( sSOCKET, 500 )
   TINI   := Seconds()
   TELA   := savescreen(23,1,23,78)
   do while (right(RET_IMP,1) <> ETX)
      BLOCO := space(64)

      BYTES   := inetrecv(sSOCKET, @BLOCO, 64)
      RET_IMP += left(BLOCO,BYTES)

      if Seconds() > (TINI + 5)
          @ 23, 2 say pad('Aguardando resposta do ACBrMonitor:  '+;
                      str(TINI + ESPERA - seconds(),2),77) color COR_MENU
      endif

      if Seconds() > (TINI + ESPERA)
         restscreen(23,1,23,78,TELA)

         if ! TENTA
            RET_IMP := 'ERRO: Sem resposta do ACBrMonitor em '+alltrim(str(ESPERA))+;
                       ' segundos (TimeOut)' + ETX
         else
            if ALERTA('O ACBrMonitor n†o est  respondendo|'+;
                      'Deseja tentar novamente ?',{'SIM','NAO'},,COR_ERRO) # 1
               RET_IMP := 'ERRO: Sem resposta do ACBrMonitor em '+alltrim(str(ESPERA))+;
                          ' segundos (TimeOut)' + ETX
            else
               TINI := Seconds()
            endif
         endif
      endif
   enddo
   restscreen(23,1,23,78,TELA)
#ENDIF
endif

do while right(RET_IMP,1) $ CR+LF+ETX   // Remove sinalizadores do final
   RET_IMP := left(RET_IMP,len(RET_IMP)-1)
enddo

if ! SEM_ERRO
   MSG_ERRO := ''
   if substr(RET_IMP,1,5) == 'ERRO:'
      MSG_ERRO := strtran(strtran( MUDA_ACENTOS(substr(RET_IMP,7)),CR,''),LF,'|')
   endif
   
   if ! empty(MSG_ERRO)
      ALERTA(MSG_ERRO,,,COR_ERRO)
      RET_IMP := ''
   endif
endif

return RET_IMP
