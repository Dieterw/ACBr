/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: TESTES.PRG
 \ Descricao: Testes das Funcoes de Comunicacao do Monitor ACBr_NFe/ACBr_ECF.
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
 \ Nota/Obs.: Testes simples para melhor entendimento das funcoes e retornos.
 \            Para compilar no clipper 5.2 (em anexo): rmake testes
 \
 \            Para utilizar em Rede compartilhe um diretorio no seu servidor,
 \            seja Windows ou Linux (Samba). E na máquina cliente acesse este
 \            compartilhamento, "N:\" ou "/home/nfe/", de acordo com seu SO.
 \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

LOCAL cInf:=""   // Variavel de Resposta das Informacoes Geradas.
PUBLIC ACBrNFe_TMP := "N:\ACBr_NFe\Monitor\ARQTMP.TXT"
PUBLIC ACBrNFe_ENT := "N:\ACBr_NFe\Monitor\ENTNFE.TXT"
PUBLIC ACBrNFe_SAI := "N:\ACBr_NFe\Monitor\SAINFE.TXT"


// Funcoes para testar: 
* Nao precisa de Certificado do seu Cliente:
// NFe_XML() := Cria XML da NFe baseado em um arquivo Texto/INI.
// NFe_VAL() := Valida arquivo assinado da NFe.
// NFe_IMP() := Imprime DANFE do arquivo XML de NFe.
// NFe_EMA() := Transmite/Envia uma NFe/DANFE por EMAIL.
* Precisa de Certificado do seu Cliente:
// NFe_SWS() := Status do Servico dos Web Services da Receita.
// NFe_ASS() := Assina uma NFe. (Pode ser com: Associacao.pfx)
// NFe_ENV() := Envia NFe.
// NFe_CON() := Consulta uma NFe.
// NFe_CAN() := Cancela uma NFe ja autorizada.
// NFe_INU() := Inutiliza Faixa de numeracao de NFe.

* ? "Testando Funcoes do ACBr_FUN.PRG"
* ? "GER_RAN(): "+STR( GER_RAN() )
* ? "51080612345678901234550010000001041671821888-nfe.xml"

*@ 00, 00 say  "Exemplo Modulo 11: 5206043300991100250655012000000780026730161"
*@ 01, 00 say  "Sequ...: 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21"
*@ 02, 00 say  "A CHAVE:  5  2  0  6  0  4  3  3  0  0  9  9  1  1  0  0  2  5  0  6  5"
*@ 03, 00 say  "B PESOS:  4  3  2  9  8  7  6  5  4  3  2  9  8  7  6  5  4  3  2  9  8"
*@ 04, 00 say  "C (A*B): 20  6  0 54  0 28 18 15  0  0 18 81  8  7  0  0  8 15  0 54 40"

*@ 05, 00 say  "Sequ...: 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43"
*@ 06, 00 say  "A CHAVE:  5  0  1  2  0  0  0  0  0  0  7  8  0  0  2  6  7  3  0  1  6  1"
*@ 07, 00 say  "B PESOS:  7  6  5  4  3  2  9  8  7  6  5  4  3  2  9  8  7  6  5  4  3  2"
*@ 08, 00 say  "C (A*B): 35  0  5  8  0  0  0  0  0  0 35 32  0  0 18 48 49 18  0  4 18  2"

*@ 09, 00 say  "Soma das ponderacoes = 644; 644 / 11 = 58 restando 6;  DV: 11 - 6 = 5"

*? GER_M11("5206043300991100250655012000000780026730161")

inkey(0)
clear
? "31090800626625000163550010000142462259147997-nfe.xml"
? GER_M11(3109080062662500016355001000014246225914799)

inkey(0)
clear
? "35080599999090910270550010000000015180051273-nfe.xml"
? GER_M11("3508059999909091027055001000000001518005127")

*? "Consulta Web Service"
*cInf := NFe_SWS()   // Apenas com Certificado Digital
*? cInf

*? "Validando uma NF Ok. (nao Assinada)"
*cInf := NFe_VAL("N:\ACBr_NFe\Modelos\NFe.xml")
*? cInf

*? "Validando uma NF Ok. (Assinada)"
*cInf := NFe_VAL("N:\ACBr_NFe\Modelos\NFe_assinada.xml")
*? cInf

*? "Validando uma NF com Falha no Schema."
*cInf := NFe_VAL("N:\ACBr_NFe\Modelos\NFe_falhaSchema.xml")
*? cInf

*? "Validando uma NF do Modelo do site RS"
*cInf := NFe_VAL("N:\ACBr_NFe\Modelos\ModelosXMLenvio\51080612345678901234550010000001041671821888-nfe.xml")
*? cInf

*? "Assinar uma NF de testes."
*cInf := NFe_ASS("N:\ACBr_NFe\Modelos\NFe.xml")
*? cInf

*inkey(0)   // Pausa

*? "Testar Impressao de uma NF de Testes. (nao Assinada)"
*NFe_IMP("N:\ACBr_NFe\Modelos\NFe.xml")
*inkey(0)

*? "Testar Impressao de uma NF de Testes. (Assinada)"
*NFe_IMP("N:\ACBr_NFe\Modelos\NFe_assinada.xml")
*inkey(0)

*? "Testar Impressao de uma NF de Veiculos da Yamaha."
*NFe_IMP("N:\ACBr_NFe\Modelos\NFe_10_564_.xml")
*inkey(0)

*? "Testar Impressao de uma NF do Modelo do site RS"
*NFe_IMP("N:\ACBr_NFe\Modelos\ModelosXMLenvio\51080612345678901234550010000001041671821888-nfe.xml")
*inkey(0)

quit
