/*
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 \ Projeto..: Rotinas xBase para o Monitor ACBr (Automacao Comercial Brasil).
 \ Programa.: ACBr.CH
 \ Descricao: Inicializa constantes das rotinas do ACBr xBase.
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
 \ Nota/Obs.: 
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*/


#include "Fileio.ch"   // Funcoes de Leitura/Gravacao de arquivos do Clipper.

/*
   Define variaveis a serem usadas na Criacao de Arquivos.
   CR + LF = Final de Linha
*/
#define ETX chr(3)
#define CR  chr(13)
#define LF  chr(10)

/*
   Define variaveis a serem usadas na Manipulacao de Arquivos.
   Pode-se desabilitar esta definicao e incluir em seu ERP as variaveis
   abaixo, que estao referenciadas em "ACBr_NFe.PRG" e "ACBr_ECF.PRG".
   Ex.: ACBrNFe_ENT := M->dir_nfeent   // Base de Dados "parametros" do Terminal.
*/
#define ACBrNFe_ENT "N:\ACBr_NFe\Monitor\ENTNFE.TXT"
#define ACBrNFe_SAI "N:\ACBr_NFe\Monitor\SAINFE.TXT"
#define ACBrNFe_TMP "N:\ACBr_NFe\Monitor\ARQTMP.TXT"
#define ACBrECF_ENT "N:\ACBr_ECF\Monitor\ENTECF.TXT"
#define ACBrECF_SAI "N:\ACBr_ECF\Monitor\SAIECF.TXT"
#define ACBrECF_TMP "N:\ACBr_ECF\Monitor\ARQTMP.TXT"

* \\ Final de ACBr.CH
