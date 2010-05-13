/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: ACBr_XML.PRG
 \ Descricao: Funcoes de Manipulacao de TAG's XML.
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
 \ Funcoes..: TAG_ADI() := Adiciona uma TAG de XML, conforme parametros.
 \            TAG_LER() := Le uma TAG do XML, para recuperar informacoes.
 \            XML_NFe() := Realiza o "Parser" do XML de uma NFe.
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Historico de Modificacoes:
 \
 \ 20/07/2009 - Codigo original por Riberto de Miranda Braz.
 \            * Programado manualmente pelo analista com base em exemplos.
 \ 03/08/2009 - Ribertode Miranda Braz. - (ribertobraz@hotmail.com)
 \            * Arrumado funcao LER_TAG(); para LER Grupo de TAG's da NFe.
 \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

#include "ACBr.ch"   // inicializa constantes manifestas do sistema/ACBr.

/*
   Sintaxe: TAG_ADI(<ExpC1> <,ExpC2>)
   Funcao.: Formata uma TAG XML conforme parametros.
              ExpC1 = Indice da TAG.
              ExpC2 = Dados da TAG
   Local..: Variaveis locais utilizadas.
              cTAG = TAG formatada de retorno.
   Retorna: TAG XML ja formatada.
*/
Function TAG_ADI( cInd, cDad )
   LOCAL cTAG := ''

   // Formata os Dados passados.
   if cDad = NIL   // Nao veio Dados?
      cDad := ''   // Entao em Branco; nao pode ser Nulo
   endif
   if ValType( cDad ) == "C"   // Eh Caracter?
        cDad := AllTrim( cDad )
   elseif ValType( cDad ) == "D"   // Eh Data?
        cDad := DTos( cDad )
        cDad := Transform( cDad, "@R 9999-99-99" )
   // elseif cnpj/cpf/valores/etc.
   endif

   // Cria a TAG
   if Empt( cDad )   // Nao tem Dados?
      // Exemplo de TAG: <det nItem="1">
      cTAG := '<'+cInd+'>'
   else   // Tem Dados para formatar?
      // Exemplo de TAG: <UF>MG</UF>
      cTAG := '<'+cInd+'>'+cDad+'</'+cInd+'>'
   endi

Return cTAG


/*
   Sintaxe: TAG_LER(<ExpC1> <,ExpC2>)
   Funcao.: Formata uma TAG XML conforme parametros.
              ExpC1 = Indice da TAG.
              ExpC2 = Faixa de Dados para Ler.
   Local..: Variaveis locais utilizadas.
              cDad = Dados da TAG.
   Retorna: String com os Dados extraidos da TAG XML.
*/
Function TAG_LER( cInd, cDad )
   LOCAL cRet := ''

   // Formata os Dados passados.
   * if ('<' $ left(cInd,5))   //
   *   cInd := 'ECF.'+cInd     // Tirar Caracteres de TAG do Dado passado.
   * endif
   if cDad = NIL   // Nao veio Dados?
      cDad := ''   // Entao em Branco; nao pode ser Nulo
   endif

   // Vamos localizar o que queremos.
   // Exemplo de TAG simples.: <UF>MG</UF>
   // Exemplo de TAG de grupo: <det nItem="1">...</det>
   pIni := AT(cTAG, cRet)+2  // Pos.Inicial depois de ">" ou "=".
   pFin := RAT(cTAG, cRet)-3  // Posicao Final antes de "</".
   // Entao extraimos a Mensagem entre a posicao Inicial e Final.
   cRet := substr( cRet, pIni, pFin )

   // Formatando a Resposta se "OK:" para validacao posterior, ou seja,
   // tem que retornar algo para informar se "OK" ou "ERRO" na mensagem.
   if substr(cRet, 1, 5) != 'ERRO:' .OR. empty( cRet )
      cRet := 'OK: '+cRet   // Retorna "OK: " mais o dado da TAG.
   endif

return cRet



/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \
 \ PROXIMAS FUNCOES A SEREM CRIADAS:
 \ ---------------------------------
 \ (TAG'S ESPECIFICAS PARA A NFe)
 \
 \ * TAG'S NFe - CABECALHO
 \ XML_IDE := Cria Identificacao da NFe.
 \ XML_EMI := Cria Identiticacao do Emitente da NFe.
 \ XML_DES := Cria Identiticacao do Destinatario da NFe.
 \ XML_RET := Cria Identiticacao do Local de Retirada.
 \ XML_ENT := Cria Identiticacao do Local de Entrega.
 \ * TAG'S NFe - ITENS DE PRODUTOS/SERVIcOS
 \ XML_DET := Cria Detalhamento de Produtos e Servicos da NFe.
 \ XML_ITE := Cria Itens de Produtos/Servicos da NFe.
 \ XML_VEI := Cria Detalhamento Especifico de Veiculos Novos.
 \ XML_MED := Cria Detalhamento Especifico de Medicamentos.
 \ XML_ARM := Cria Detalhamento Especifico de Armamentos.
 \ XML_COM := Cria Detalhamento Especifico de Combustiveis.
 \ XML_TRI := Cria Tributos dos Itens (n-ICMS/o-IPI/p-II/qr-PIS/st-COFINS/u-ISSQN).
 \ XML_ADI := Cria Informacoes Adicionais dos Itens.
 \ * TAG'S NFe - RODAPE/DETALHES
 \ XML_TOT := Cria Valores Totais da NFe.
 \ XML_TRA := Cria Informacoes do Transporte da NFe.
 \ XML_COB := Cria Dados de Cobranca.
 \ XML_ADN := Cria Informacoes Adicionais da NFe.
 \ XML_EXT := Cria Informacoes de Comercio Exterior.
 \ XML_CPR := Cria Informacoes de Compras.
 \ XML_ASS := Informacoes da Assinatura Digital.
 \ 
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/

* \\ Final de ACBr_XML.PRG
