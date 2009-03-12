Function MAIN(P1)
Local num,VALIQ:={},A,WTXT:=''

#IFDEF __PLATFORM__Linux
   REQUEST HB_CODEPAGE_PLMAZ
//   REQUEST HB_CODEPAGE_PLISO
   REQUEST HB_CODEPAGE_HR437
   hb_settermcp("HR437","PLMAZ",.t.)
   set(_SET_FILECASE,"LOWER")
   set(_SET_DIRCASE,"LOWER")
   set(_SET_DIRSEPARATOR,"/")
   set(_SET_TRIMFILENAME,.t.)
   request hb_lang_pt
   umask(6)                            // -rw-rw----
#ENDIF
REQUEST DBFCDX                      // Causes DBFNTX RDD to be linked in
rddSetDefault( "DBFCDX" )           // Set up DBFNTX as default driver

#ifdef __XHARBOUR__
SET DBFLOCKSCHEME TO 1
#else
FreeTSlice(20)
#endif

set date french
set confirm ON
COR_ERRO := "W+/R,W+/GR,,,GR/W"
COR_GET  := "W+/N,W+/GR,,,GR/W"
COR_MENU := "W+/B,W+/BG,,,N/B"

For A := 1 to 10
    WTXT += pad('LINHA: '+str(A,2),40,'*')+'|'
next

cls

? 'Impressora ser  inicializada..'
wait

if empty(P1)
  P1 := 'localhost:3434'
endif

//// Inicializando a Impressora na porta ////
//? IMF_INIT('C:\DELPHI\ACBr\source\Monitor\CLX\',7)
? IMF_INIT(P1,7)
? IMF_OPEN()

*? ' VERSAO'
*?  IBE_VERSAO()
*RETURN

? 'GAVETA'
? IMF_GAVETA_ABERTA()

? 'ACBR',IBR_COMANDO('ACBR.RUN("www.djsystem.com.br")')

//// Exibindo flag de Cupom aberto ////
? 'Pode realizar vendas ? '
?? IMF_PODE_ABRIR()

? 'FIM_REL', IMF_FIM_REL()

// ? IMF_LEITURAX()

//// Exibindo o Numero do Caixa (Impressora) ////
? 'Numero do CAIXA (Impressora): '+IMF_NUM_CAIXA()
? 'Numero de Serie: '+IMF_NUM_SERIE()

//// Exibindo o Data da Impressora ////
? 'Data: '
?? IMF_DATA()

//// Exibindo a Hora da Impressora ////
? 'Hora: '
?? IMF_HORA()

? 'Subtotal do Cupom '
?? IMF_SUBTOTAL()

? 'Aliquotas: '
VALIQ := IMF_ALIQ()
For A := 1 to len(VALIQ)
   ? VALIQ[A,2],VALIQ[A,1]
next
WAIT

? 'Forma de Pagamento Dinheiro: '
?? IMF_ACHA_PG('DINHEIRO')

? 'Forma de Pagamento Cheque: '
?? IMF_ACHA_PG('CHEQUE')
WAIT

//// Exibindo o Numero do Ultimo cupom ////
? 'Ultimo Cupom: '
?? IMF_NUM_CUPOM()

//// Exibindo flag da Gaveta ////
? 'Gaveta aberta: '
?? IMF_GAVETA_ABERTA()
? 'Abrindo Gaveta: '
?? IMF_ABRE_GAVETA()
wait

//// Exibindo flag de Cupom aberto ////
? 'Pode realizar vendas ? '
?? IMF_PODE_ABRIR()

? 'Cupom Aberto ? '
?? IMF_CUPOM_ABERTO()
wait

IMF_END()
return



? 'Subtotal do Cupom '
?? IMF_SUBTOTAL()
? 'PROXIMO COMANDO TENTARA ABRIR UM CUPOM'
wait

//// Chamando Abertura de Cupom ////
? 'Abrindo Cupom Fiscal: '
?? IMF_ABRE_CUPOM()

//// Exibindo flag de Pouco Papel ////
? 'Pouco papel ? '
?? IMF_POUCO_PAPEL()

//// Exibindo o Numero do Ultimo cupom ////
? 'Ultimo Cupom: '
?? IMF_NUM_CUPOM()

//// Exibindo flag de Cupom aberto ////
? 'Cupom Aberto ? '
?? IMF_CUPOM_ABERTO()
wait

WCODIGO     := space(13)
WDESCRICAO  := space(29)
WQTD        := 1
WVALOR_UNIT := 1
WDESCONTO   := 0
WALIQ       := '18'

WVALOR := 0
do while .t.
   WALIQ := pad(WALIQ,5)
   CLS
   @ 06,10 say 'Codigo...:' get WCODIGO
   @ 07,10 say 'Descricao:' get WDESCRICAO
   @ 08,10 say 'Aliquota. Use (FF) para Subst.Tributaria:' get WALIQ picture '@K'
   @ 09,10 say 'Quantidade' get WQTD  picture '@E 9999.999'
   @ 10,10 say 'Valor....:' get WVALOR_UNIT picture '@E 999999.999'
   @ 11,10 say 'Desconto.:' get WDESCONTO  picture '@E 99.99'
   read

   if lastkey() = 27
      exit
   endif

   //// Se a aliquita for numerica, transforme para valor ////
   WALIQ := strtran(WALIQ,',','.')
   WALIQ := iif(empty(val(WALIQ)),WALIQ,val(WALIQ))

   //// Imprimindo o Item de venda ////
   if IMF_ITEM(WCODIGO, WDESCRICAO, WALIQ, ROUNDING(WQTD,3), ROUNDING(WVALOR_UNIT,3), WDESCONTO)
      WVALOR += WVALOR_UNIT
   endif
enddo

//// E possivel ter ate 496 caracteres de mensagem ////
//// Cada linha de mensagem tem 48 caracteres      ////
WMSG      := ''
WAD       := 'D'
WDESCONTO := 0

@ 13,10 SAY 'VALOR PAGO:' GET WVALOR    picture '@E 999,999,999.99'
@ 14,10 SAY 'DESCONTO..:' GET WDESCONTO picture '@E 999,999,999.99'
@ 15,10 SAY 'A/D.......:' GET WAD       picture '!'
read

@ 16,10 SAY 'Mensagem..:  ...Pressione CTRL-W para encerrar... '
@ 17,10 to 23,70
WMSG := memoedit(WMSG,18,11,22,69,.T.,,48)

WOBS := ''
TAM  := mlcount(WMSG,48)
for A := 1 to TAM
   WOBS := WOBS + '|' + memoline(WMSG,48,A)
next

WOBS := substr(WOBS,2)

? 'Subtotal do Cupom '
?? IMF_SUBTOTAL()
wait

//// Imprimindo o Fechamento do Cupom ////
IMF_FECHA_CUPOM(WVALOR, WDESCONTO, WOBS,, WAD)

//// Cancelando o Ultimo cupom Fiscal ////
IMF_CAN_CUPOM()

*IMF_RELATORIO('TESTE DE RELATORIO|LINHA2|LINHA3| |LIHA5|     LINHA 6',2)

//// Fechando a porta COM da Impressora ////
IMF_END()

RETURN NIL

