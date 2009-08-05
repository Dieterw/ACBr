{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 06/09/2004:  Daniel Simoes de Almeida
|*   Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
|* 19/03/2004:  Daniel Simoes de Almeida
|*   Corrigido BUG em FechaRelatorio quando um CV estava aberto.
|*   -  Bug reportado por Aurimenes Apolonio Silva
|* 26/10/2005:  Ederson Selvati
|*   Corrigido BUG na carga de Formas de Pagamento e CNF. A rotina anterior
|*   carregava todas as formas de pagamento... mesmo as que não haviam sido
|*   programadas
|* 08/12/2005:  Daniel Simoes de Almeida
|*  - VerificaFimImpressao poderia disparar excessão com ECF off-line
|*  - Diminuido tempo de alguns Sleeps de 100 para 10 a fim de agilizar a
|*    comunicaçao com o ECF (experimental)
|* 16/12/2005:  Daniel Simoes de Almeida
|*  - Corrigido Bug, métodos que usam o comando 229 (Ler configuração), retorna-
|*    vam dados errados (GetHorarioVerao, e GetArredonda)
|* 16/03/2006:  Daniel Simoes de Almeida
|*  - Corrigido Bug em CarregaFormasPagamento e CarregaComprovantesNaoFiscais.
|*    posiçoes livres (não programadas) eram lidas como válidas
|*  - Corrigido Bug em ProgramaFormaPagamento. Detecção automática do próximo
|*     indice livre falhava
|*  - ProgramaComprovanteNaoFiscal, modificada para não permitir cadastrar já
|*    existente
|* 26/04/2006:  Daniel Simoes de Almeida
|*  - Método "VerificaFimImpressao" otimizado para usar os flags da
|*     "Palavra de Status" , pois o método antigo falhava algumas vezes
|*  - Corrigido Bugs de TimeOut em vários comandos como VendeItem,
|*     RelatorioGerencial, etc
|*  - Corrigido Bug em ProgramaFormaPagamento. Programação de FPG com Vinculado
|*     não causava a programação de um Comprovante Nao Fiscal (equalização)
|* 03/05/2006:  Daniel Simoes de Almeida
|*  - Corrigido Bug em GetTotalPago, que retornava o Valor de SubTotal mesmo
|*    antes do cupom ser SubTotalizado   (bug reportado por Fabio Farias)
|* 24/05/2006:  Carlos do Nascimento Filho
|*  - Adicionada a compatibilidade com o ECF FS2000
|* 26/05/2006:  Daniel Simões de Almeida
|*  - Corrigido alguns bugs na compatibilidade com o modelo FS 2000 em:
|*    GetEstado, VerificaFimImpressao, FechaRelatorio, GetGavetaAberta,
|*    GetPoucoPapel, GetHorarioVerao e GetArredonda
|* 01/09/2006:  Daniel Simões de Almeida
|*  - ProgramaFormaPagamento, modificada para não permitir cadastrar já
|*    existente
|* 27/09/2006:  Daniel Simões de Almeida / Juliano Pereira dos Santos
|*  - Adicionada a compatibilidade com a Daruma FS600 MFD
|* 07/11/2006:  Daniel Simões de Almeida
|*  - Adicionada a Impressao de Cheques na FS2000.
|*  - Corrigido o método CarregaFormasPagamento na FS2000
|*  - Corrigido o retorno do conteúdo de ComprovantesNaoFiscais
|*  - Adicionada propriedade interna "ComprovantesNaoFiscaisVinculado"
|* 30/11/2006:  Daniel Simões de Almeida
|*  - Corrigido retorno da propriedade TotalPago na FS600
|* 15/12/2006:  Maicon da Silva e Daniel Simões de Almeida
|*  - Corrigido Venda de Item com Qtd de 3 decimais
|* 29/01/2007:  Daniel Simões de Almeida
|*  - Corrigido Carregamento de Formas de Pagamento na MFD
|*    (retornava posições não cadastradas)
|*  - Melhorada Verificação de Fim da Impressão na MFD
|*  - Corrigida Leitura da palavra de Status na MFD (GetEstado)
|*  - Corrigida detecção do estado estRequerX na MFD
|*  - Corrigido Retorno no Numero de Serie na MFD
|*  - Impressao de Relatório Gerencial e Vinculado na MFD, otimizada para enviar
|*    várias linhas simultaneamente (muito mais rápido)
|*  - Corrigido bug na leitura do CRO
|* 29/01/2007:  Jhony Alceu Pereira
|*  - Novas propriedades: GetNumCRZ, GetGrandeTotal, GetNumCOOInicial,
|*    GetVendaBruta
|* 26/03/2007: José Luís Schiavo
|*   - LeituraMFDSerial
|* 01/04/2007:  Daniel Simoes de Almeida
|*  - Implementados métodos de Cupom Não Fiscal
|* 07/04/2007:  Daniel Simoes de Almeida
|*  - Corrigido bugs em métodos de Cupom Não Fiscal no modelo MFD
|* 05/07/2007:  Daniel Simoes de Almeida
|*  - Metodo AbreCupopm modificado para suportar identificação do cliente na MFD
|* 06/07/2007:  Maicon da Silva Evangelista
|*  - Vários métodos e propriedades para a FS345
|*    TotalIsencao,  TotalNaoTributado, TotalSubstituicaoTributaria,
|*    TotalDescontos, TotalCancelamentos, CNPJ, LerTotaisAliquota, DataMovimento
|*    LerTotaisFormaPagamento
|* 23/10/2007: Daniel Simoes de Almeida
|*    ProgramaFormaPagamento e ProgramaComprovanteNaoFiscal modificados para
|*    usar os comandos nativos da FS600
|* 23/10/2007 Andre Bohn
|*   - Cancelamento de Cupom permite cancelar CCD se imediatemante apos o cupom
|*   - Corrigido Bug na Leitura dos Totais de Pagamentos na FS600
|*   - Implementado a Leitura dos Totais de CNFs para FS600
|* 28/03/2008: Daniel Simoes de Almeida
|*   - Implementado mecanismo para detecção de compactação da MFD Erro 35 ou 99
|* 30/03/2008: Daniel Simoes de Almeida
|*   - Comandos nativos FS600 [FS]. Adicionado #0 (null) após o CheckSum para
|*     evitar problemas de intererpretação do ECF
|*   - Melhorado a detecção de TIMEOUT em ECFs com MFD. Fazendo desnecessário
|*     TimeOuts muito grandes
|*   - Permitindo o uso de Identificação do Consumidor em ECFs MFD no final do
|*     Cupom usando comando compatível com a FS345 
|* 11/04/2008: Daniel Simoes de Almeida
|*   - Adicionado métodos Sangria, Suprimento e CortarPapel
|* 11/04/2008: Daniel Simoes de Almeida
|*   - FS600 - Impressao em 1 linha se "ACBrECF.DescricaoGrande = False"
|* 07/02/2009: Daniel Simoes de Almeida
|*   - FS600 - REdução Z verifica se ficou algum Cupom Aberto, e cancela-o
|* 03/06/2009: Maicon da Silva Evangelista
|*   - FS600/FS700 - Revisado todas as função de comunicação com o ECF, foi
|*     substituido todos os comandos que ainda utilizavam funções "ESC" para
|*     "FS", com isso houve uma melhora significativa na velocidade de
|*     comunicação com o ECF
|* 24/06/2009: José Nilton Pace
|*   - FS600/FS700 - Corrigido Retorna Data/Hora
|*   - FS600/FS700 - Corrigido Retorno Grande Total
|*   - FS600/FS700 - Corrigido Retorno Venda Bruta
|*   - FS600/FS700 - Corrigido Retorno Número do COO Inicial
|*   - FS600/FS700 - Ajustado Retorno do Estado da Impressora
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFDaruma ;

interface
uses ACBrECFClass, ACBrDevice, ACBrUtil, ACBrCHQClass,
     Classes ;

const  NUL = #00 ;
       ENQ = #05  ;
       ACK = #06  ;
       BELL= #07  ;
       BS  = #08  ;
       LF  = #10  ;
       CR  = #13  ;
       ESC = #27  ;
       FS  = #28  ;
       GS  = #29  ;
       FF  = #255 ;
type

{ Tipo enumerado para separar os modelos daruma }
TACBrModelosDaruma = (fs315, fs345, fs2000, fs600, fs2100T, fs600USB, fs700L, fs700H,
                      fs700M, MACH1, MACH2, MACH3, fsIndefinido);

{ Classe filha de TACBrECFClass com implementaçao para Daruma }
TACBrECFDaruma = class( TACBrECFClass )
 private
    fsNumVersao   : String ;
    fsNumECF      : String ;
    fsNumCupom    : String ; //COO
    fsArredonda   : Char ;
    fsTotalAPagar : Double ;
    fsEmPagamento : Boolean ;
    fsCNFVinc     : TACBrECFComprovantesNaoFiscais ;
    fsTipoRel     : Char ;
    fsEsperaFFCR  : Boolean ;

    fsModeloDaruma  : TACBrModelosDaruma;

    fsRet244: AnsiString ;
    fsNumCRO: String ;
    fsErro, fsErroSTD : Integer ;

    Function PreparaCmd( cmd : AnsiString ) : AnsiString ;
    function GetComprovantesNaoFiscaisVinculado: TACBrECFComprovantesNaoFiscais;
    function LimpaRetorno( Retorno : AnsiString ) : AnsiString ;

    function GetRet244: AnsiString;
    property Ret244 : AnsiString read GetRet244 ;
    function LimpaStr(AString: AnsiString): AnsiString;
    function EnviaComando_ECF_Daruma(cmd: AnsiString): AnsiString;
    Function DocumentosToStr(Documentos : TACBrECFTipoDocumentoSet) : String ;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumCCF: String; override ;
    function GetNumECF: String; override ;
    function GetNumCRO: String; override ;
    function GetNumGNF: String; override ;
    function GetNumGRG: String; override ;
    function GetNumCDC: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetArredonda : Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetPAF: String; override ;
    function GetDataMovimento: TDateTime; override ;

    function GetNumCRZ: String; override ;
    function GetGrandeTotal: Double; override ;
    function GetVendaBruta: Double; override ;

    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;
    function GetTotalNaoFiscal: Double; override ;

    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    Function VerificaFimLeitura(var Retorno: AnsiString;
       var TempoLimite: TDateTime) : Boolean ; override ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    Function EnviaComando_ECF( cmd : AnsiString ) : AnsiString ; override ;

    Procedure AbreCupom ; override ;
    procedure LegendaInmetroProximoItem ; override ; // Função implementada até o momento apenas para Daruma
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString  = '' ) ; override ;
    procedure CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto: Char) ;
       override ;//A -> Acrescimo D -> Desconto  // Função implementada até o momento apenas para Daruma
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    procedure EstornaPagamento(const CodFormaPagtoEstornar,
      CodFormaPagtoEfetivar : String; const Valor: Double;
      Observacao : AnsiString = '') ; override ;
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;
    procedure CancelaItemVendidoParcial( NumItem : Integer;
      Quantidade : Double) ; override ; // Função implementada até o momento apenas para Daruma
    procedure CancelaDescontoAcrescimoItem( NumItem : Integer) ;override ; // Função implementada até o momento apenas para Daruma
    Procedure LeituraX ; override ;
    Procedure LeituraXSerial( var Linhas : TStringList) ; override ;
    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;
    Procedure FechaRelatorio ; override ;
   //Cheque
    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;       

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; override ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ); override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList; Simplificada : Boolean = False  ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       var Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;
    Procedure IdentificaOperador ( Nome: String); override;
    Procedure IdentificaPAF( Linha1, Linha2 : String) ; override ;
    Function RetornaInfoECF( Registrador : String ) : AnsiString; override ;
    function DecodificaTexto(Operacao: Char; Texto: String; var Resposta: String): Boolean; override;

    { Procedimentos de Cupom Não Fiscal }
    procedure NaoFiscalCompleto(CodCNF: String; Valor: Double;
      CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer = 0); override ;
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: AnsiString = '') ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaNaoFiscal ; override ;

    procedure Sangria( const Valor: Double;  Obs: AnsiString; DescricaoCNF,
       DescricaoFPG: String ) ; override ;
    procedure Suprimento( const Valor: Double; Obs: AnsiString; DescricaoCNF,
       DescricaoFPG: String) ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  override;

    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaRelatoriosGerenciais ; override ;
    Procedure ProgramaRelatorioGerencial( var Descricao: String;
       Posicao : String = '') ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

    Property ComprovantesNaoFiscaisVinculado : TACBrECFComprovantesNaoFiscais
       read GetComprovantesNaoFiscaisVinculado ;
    function AchaCNFVincIndice(
      Indice: String): TACBrECFComprovanteNaoFiscal;
    function AchaCNFVincDescricao( Descricao : String ) :
       TACBrECFComprovanteNaoFiscal ;

    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;
    // Função para mudar inpressora para modo online automaticamente
    procedure ComutaOnLine;
 end ;

implementation
Uses SysUtils, ACBrECF,
    {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, Windows{$ENDIF},
    Math ;

{ ----------------------------- TACBrECFDaruma ------------------------------ }

constructor TACBrECFDaruma.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsRTS_CTS ;
  { Variaveis internas dessa classe }
  fsTotalAPagar := 0 ;
  fsEmPagamento := false ;
  fsNumVersao   := '' ;
  fsNumECF      := '' ;
  fsRet244      := '' ;
  fsNumCRO      := '' ;
  fsnumcupom    := '' ;
  fsArredonda   := ' ';
  fsCNFVinc     := nil ;
  fsTipoRel     := ' ' ;
  fsEsperaFFCR  := False ;
  fpIdentificaConsumidorRodape := True ;

  fpModeloStr := 'Daruma' ;
  fpRFDID     := 'DR' ;
end;

destructor TACBrECFDaruma.Destroy;
begin
  if Assigned( fsCNFVinc ) then
     fsCNFVinc.Free ;

  inherited Destroy ;
end;

procedure TACBrECFDaruma.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

//  fpDevice.HandShake := hsRTS_CTS ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsRet244    := '' ;
  fsNumCRO    := '' ;
  fsArredonda := ' ';
  fsnumcupom  := '';

  fpMFD       := False ;
  fpTermica   := False ;
  fsTipoRel   := ' ' ;
  fsEsperaFFCR    := False ;
  fsModeloDaruma  :=  fsIndefinido;

  try
     { Testando a comunicaçao com a porta e se é MFD }
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );

     // Função para comutar as impressoras termicas para OnLine
     ComutaOnLine;
  except
     Desativar ;
     raise ;
  end ;
end;

Function TACBrECFDaruma.EnviaComando_ECF( cmd : AnsiString ) : AnsiString ;
 Var Tentativas : Integer ;
begin
  {   Nas Darumas com MFD, em algumas situações o ECF pode ficar temporariamente
    inoperantente, enquanto a compactação da MFD está sendo efetuada. Nessa
    situação, o ECF retorna os seguintes códigos de erro:
     35 - Relogio Inoperante ou 99 (não documentado)

      Segundo o Suporte Técnico da Daruma, quando este problema ocorre, devemos
    aguardar até que ele consiga responder corretamente.

      Esta rotina irá tentar enviar o comando por 10 vezes. Caso ela recebe os
    erros 35 ou 99... ele aguarda 100 milisegundos e tenta um novo envio...   }

  Tentativas := 0 ;
  while (Tentativas < 10) do  // Tenta enviar o comando por 10 vezes
  begin
     try
        Result := EnviaComando_ECF_Daruma( cmd ) ; // Envia o comando
        Break ;                                    // Tudo OK, saindo..
     except
        if (fsErro = 35) or (fsErro = 99) then   // Está compactando MFD ?
         begin
           GravaLog('Daruma: Falha no Envio do CMD. Tentativa: '+IntToStr(Tentativas+1)+
                    ' - Erro: '+IntToStr(fsErro)+' - Estendido: '+IntToStr(fsErroSTD) );
           Sleep(100) ;
         end
        else
           raise ;
     end ;

     Inc( Tentativas ) ;
  end ;
end ;

Function TACBrECFDaruma.EnviaComando_ECF_Daruma( cmd : AnsiString ) : AnsiString ;
Var
  ErroMsg : String ;
begin
  result  := '' ;
  ErroMsg := '' ;
  fsErro    := 0 ;
  fsErroSTD := 0 ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;

  try
     { Codificando CMD de acordo com o protocolo da Daruma }
     cmd := PreparaCmd( cmd ) ;

     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }

     while fpComandoEnviado = '' do
     begin
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        if not TransmiteComando( cmd ) then
           continue ;

        fpComandoEnviado := cmd ;
     end ;

//   sleep(20) ;

     { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exceçao }
     LeResposta ;
     
     try
        fpDevice.Serial.Purge ;  { Limpa buffer de Entrada e Saida }
     except
     end ;

     { Retorno pode ter várias respostas... capturando apenas a última }
     Result := LimpaRetorno(fpRespostaComando) ;
     fpRespostaComando := Result ;

     { Verificando por erros }
     if (copy(Result,1,2) = ':E') then
        fsErro := StrToIntDef(copy(Result,3,2),0) ;

     if fsNumVersao = '2000' then
        if (copy(result,3,2) <>  '00') then
           fsErro := StrToIntDef(copy(result,3,2),0);
           
     if fpComandoEnviado[1] = FS then
     begin
        fsErro    := StrToIntDef(copy(Result,2,2),0) ;
        fsErroSTD := StrToIntDef(copy(Result,4,3),0) ;
     end ;
        
     if (copy(result,1,2) = ':'+#200 ) then
        fsNumCupom := copy(result,7,6)
     else if (copy(result,1,2) <> ':B') then
        fsNumCupom := '';

     if fsNumVersao = '2000' then
        if fsErro = 8 then
           fsErro := 0;

     if fsErro <> 0 then
     begin
        case fsErro of
           0 : ErroMsg := 'ECF em modo de Intervenção Técnica' ;
           1 : ErroMsg := 'Comando disponível somente em modo de Intervenção Técnica' ;
           2 : ErroMsg := 'Erro gravando memória fiscal' ;
           3 : ErroMsg := 'Memória fiscal esgotada' ;
           4 : ErroMsg := 'Erro no relógio interno' ;
           5 : ErroMsg := 'Falha mecânica' ;
           6 : ErroMsg := 'Erro lendo memória fiscal' ;
          10 : ErroMsg := 'Documento sendo emitido' ;
          11 : ErroMsg := 'Documento não foi aberto' ;
          12 : ErroMsg := 'Não existe documento a cancelar' ;
          13 : ErroMsg := 'Erro nos parâmetros: Não numérico' ;
          14 : ErroMsg := 'Não há memória disponível para esta operação' ;
          15 : ErroMsg := 'Item a cancelar não encontrado' ;
          16 : ErroMsg := 'Erro de sintaxe no comando' ;
          17 : ErroMsg := 'Numeric overflow' ;
          18 : ErroMsg := 'Totalizador Tributário selecionado não possui '+
                          'aliquota definida' ;
          19 : ErroMsg := 'Memória fiscal vazia' ;
          21 : ErroMsg := 'Detectado proximidade do final da bobina de papel' ;
          22 : ErroMsg := 'Redução Z já foi emitida. ECF Bloqueado ate 00:00' ;
          23 : ErroMsg := 'Redução Z do dia anterior ainda pendente '+
                          'Efetue uma Redução Z.' ;
          24 : ErroMsg := 'Valor de desconto ou acrescimo inválido' ;
          25 : ErroMsg := 'Caracter inválido nos Parâmetros' ;
          30 : ErroMsg := 'Comprovante NÃO Fiscal inválido ou não programado' ;
          38 : ErroMsg := 'Forma de pagamento selecionada não é‚ válida' ;
          39 : ErroMsg := 'Erro na sequência de fechamento do cupom fiscal' ;
          41 : ErroMsg := 'Data inválida. Data fornecida é inferior à última gravada na Memória Fiscal' ;
          42 : ErroMsg := 'Leitura X inicial ainda não foi emitida' ;
          43 : ErroMsg := 'Não pode mais emitir CNF Vinculado solicitado';
          50 : ErroMsg := 'Sem Papel' ;
          61 : ErroMsg := 'Queda de energia durante a emissão do Cupom Fiscal' ;
          84 : ErroMsg := 'Impressora não está respondendo' ;
        else
           ErroMsg := 'Erro retornado pelo ECF: '+IntToStrZero(fsErro,2) ;
        end ;

        if fsErro = 21 then       { Verifica se possui erro "Pouco Papel" }
        begin
           DoOnMsgPoucoPapel ;
           ErroMsg := '' ;   { Apaga Msg de Erro para nao gerar Exceção }
        end ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr + sLineBreak +
                   sLineBreak + ErroMsg ;
        if fsErroSTD <> 0 then
           ErroMsg := ErroMsg + sLineBreak + 'Erro estendido ('+IntToStrZero(fsErroSTD,3)+')' ;
            
        raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     fsEsperaFFCR := False ;
  end ;

end;

Function TACBrECFDaruma.PreparaCmd( cmd : AnsiString ) : AnsiString ;
Var I, chksum, LenCmd : Integer ;
begin
{ Recomendações da Daruma:
  - Você deve escrever na porta serial o Checksum mesmo que ele seja Nulo
  - E Mesmo após a escrita do Checksum sendo nulo ou não, qualquer que seja o
    Checksum, envie mais um Nulo para a porta serial, porque caso o Checksum
    seja ESC, FS, GS que é o começo de um comando então o envio do Nulo quebra
    a seqüência e faz com que o ECF entenda que aquilo é um Checksum e não o
    começo de um comando. }

  result := '' ;
  if cmd = '' then exit ;

  // É comando da FS600 ? //
  if (cmd[1] = FS) or (copy(cmd,1,2) = GS+ACK) then
   begin
     chksum := 0 ;
     LenCmd := Length( cmd ) ;

     For I := 1 to LenCmd do   { Aplicando XOR nos Bytes do comando }
        chksum := chksum xor ord( cmd[ I ] ) ;

     Result := cmd + AnsiChar( chr( chksum ) );

     if (cmd[1] = FS) and (Result[Length(Result)] in [ESC,FS,GS]) then
        Result := Result + #0 ;
   end
  else
     Result := cmd + CR ; { Adcionando Sufixo padrao }
end ;

function TACBrECFDaruma.LimpaRetorno(Retorno: AnsiString): AnsiString;
Var P1, P2 : Integer ;
begin
  Result := '' ;
  P1     := Pos(':',Retorno) ;
  if P1 > 0 then
  begin
     P2 := LastDelimiter(CR,Retorno) ;
     if P2 > P1 then
        Result := copy( Retorno, P1, Length( Retorno ) ) ;
  end ;
end;


Function TACBrECFDaruma.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
 Var LenRet : Integer ;
     EndStr : AnsiString ;
begin
  LenRet := Length(Retorno) ;
  Result := (fpDevice.Serial.WaitingDataEx <= 0) and (LenRet > 0) ;

  if Result then
  begin
     if not fsEsperaFFCR then
        Result := (LimpaRetorno(Retorno) <> '') 
     else
      begin
        // Na Leitura da Memoria Fiscal, aguarda até chegar FF+CR
        EndStr := RightStr(Retorno,5) ;
        Result := (pos( FF+CR, EndStr ) > 0) ;
      end ;
  end ;

  { Nota sobre o VerificaFimLeitura: A DARUMA responde muito antes da
    Impressao terminar, o que pode causar problemas com comandos enviados logo
    após impressoes demoradas como a Leitura X (por exemplo). Para esses casos,
    é necessário ativar a propriedade "AguardaImpressao := True" }
end;


function TACBrECFDaruma.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
Var Cmd , RetCmd : AnsiString ;
    I : Integer ;
    DT : TDateTime ;
begin
  { Essa função só é chamada se AguardaImpressao = True,
    Como essa função é executada dentro da "LeResposta", que por sua vez foi
    chamada por "EnviaComando", não podemos usar o método "EnviaComando" (ou
    teriamos uma chamada recursiva infinita), por isso o Loop abaixo envia o
    comando "Palavra Status" diretamente para a Serial, e aguarda por .5 segundo
    a resposta... Se a Daruma consegir responder, verifica se o Bit 0 de S8,
    está desligado, o que significa que a Impressão Terminou }
  Result := false ;
  DT     := 0 ;
  if not EmLinha() then
   begin
     Sleep(100) ;
//   GravaLog(DateTimeToStr(now)+ ' - Not EmLinha');
   end
  else
   begin
     RetCmd := '' ;
     I      := 0 ;
//   GravaLog(DateTimeToStr(now)+ ' - Solicitando Status');
     if fsNumVersao = '2000' then
        Cmd := PreparaCmd( GS + ENQ )    { Palavra de Status }
     else if fpMFD then
        Cmd := PreparaCmd( GS + ACK )
     else
        Cmd := PreparaCmd( GS + FF ) ;   { Palavra de Status }

     try
        Sleep(100) ;
        fpDevice.Serial.Purge ;  { Limpa buffer de Entrada e Saida }
        fpDevice.EnviaString( Cmd );
     except
     end ;

     repeat
        try
           RetCmd := RetCmd + fpDevice.Serial.RecvPacket(200) ;
        except
           if fpDevice.Serial.WaitingDataEx <= 0 then
           begin
              Inc( I ) ;   // Nao achou dados para ler, incrementa num falhas
              sleep(50) ;  // Aguarda um pouco, para ECF enviar os dados
//            GravaLog(DateTimeToStr(now)+ ' - Erro '+IntToStr(I)+': '+RetCmd, True);
           end ;
        end ;
     until (I > 5) or ( VerificaFimLeitura( RetCmd, DT ) )  ;

     RetCmd := LimpaRetorno( RetCmd ) ;
     Result := (RetCmd <> '') ;

     try
        fpDevice.Serial.Purge ;  { Limpa buffer de Entrada e Saida }
     except
     end ;

//   GravaLog(DateTimeToStr(now)+ ' - VerificaFimImpressao: '+RetCmd, True);
     if Result then
     begin
        // ECF Respondeu corretamente, portanto está trabalhando //
        TempoLimite := IncSecond(now, TimeOut);

        try
           if fsNumVersao = '2000' then
              Result := TestBit(StrToInt('$'+RetCmd[6]),0)        { Bit0 - S5 }
           else if fpMFD then
              Result := not TestBit(StrToInt('$'+RetCmd[7]),0)    { Bit0 - S6 }
           else
              Result := not TestBit(StrToInt('$'+RetCmd[9]),0) ;  { Bit0 - S8 }
        except
           Result := False ;
        end ;
//      GravaLog(DateTimeToStr(now)+ ' - VerificaFimImpressao '+IfThen(Result,'TRUE','FALSE')+' : '+RetCmd, True);
     end ;
   end ;
end;


function TACBrECFDaruma.GetDataHora: TDateTime;
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
begin
  OldShortDateFormat := ShortDateFormat ;
  try
    if fpMFD then
    begin
      RetCmd  :=  RetornaInfoECF('66') ;
      { Retorna a data/hora no formato: ddmmaaaahhnnss }

      ShortDateFormat := 'dd/mm/yyyy' ;
      result := StrToDate(copy(RetCmd,1,2)+ DateSeparator +
                          copy(RetCmd,3,2)+ DateSeparator +
                          copy(RetCmd,5,4)) ;

      Result := RecodeHour(  Result,StrToInt(copy(RetCmd, 9,2))) ;
      Result := RecodeMinute(Result,StrToInt(copy(RetCmd,11,2))) ;
      Result := RecodeSecond(Result,StrToInt(copy(RetCmd,13,2))) ;
    end
    else
    begin
      RetCmd := EnviaComando( ESC + #230 ) ;
      // MFD, 2000 -> :[230]EEWWddmmaahhMMss[CR]
      // fs345     -> :TddmmaahhMMss[CR]
      RetCmd := copy(RetCmd,Length(RetCmd)-12,12) ;  {Pega apenas a Data/Hora}

      ShortDateFormat := 'dd/mm/yy' ;
      result := StrToDate(copy(RetCmd,1,2)+ DateSeparator +
                          copy(RetCmd,3,2)+ DateSeparator +
                          copy(RetCmd,5,2)) ;

      Result := RecodeHour(  Result,StrToInt(copy(RetCmd, 7,2))) ;
      Result := RecodeMinute(Result,StrToInt(copy(RetCmd, 9,2))) ;
      Result := RecodeSecond(Result,StrToInt(copy(RetCmd,11,2))) ;
    end ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

end;

function TACBrECFDaruma.GetNumCupom: String;
Var RetCmd : AnsiString ;
    Num : Integer ;
begin
  Result := '' ;

  if fpMFD then
  begin
    RetCmd  :=  RetornaInfoECF('26');
    Result := RetCmd;
  end
  else if fsNumVersao='2000' then
  begin
    if fsNumCupom <> '' then
      Result := fsNumCupom
    else
    begin
      RetCmd := EnviaComando( ESC + #235 ) ;

      if LeftStr(RetCmd, 1) = ':' then
      begin
        Num    := StrToIntDef(copy(RetCmd,8,6),0) ;
        Result := IntToStrZero(Num,6) ;
      end ;
    end ;
  end
  else
  begin
    RetCmd := EnviaComando( ESC + #239 ) ;

    if LeftStr(RetCmd, 3) = ':' + ESC + #239 then
    begin
      Num := StrToIntDef(copy(RetCmd,9,6),0) ;

      if copy(RetCmd,8,1) = '2' then  { Nao ha cupom aberto, retorna o proximo }
        Num := Num - 1 ;

        Result := IntToStrZero(Num,6) ;
    end ;
  end ;
end;

function TACBrECFDaruma.GetNumCCF: String;
begin
  Result := '' ;
  if fpMFD then
    Result  :=  RetornaInfoECF('30')
  else
    Result := fsNumCupom;
end;


function TACBrECFDaruma.GetNumGNF: String;
 Var RetCmd : AnsiString ;
begin
  Result := '' ;

  if fpMFD then
    Result  :=  RetornaInfoECF('28')
  else if fsNumVersao='2000' then
  begin
    RetCmd := EnviaComando( ESC + #237 ) ;
    if LeftStr(RetCmd, 1) = ':' then
      Result := copy(RetCmd,19,6) ;
  end
  else
     Result := copy(Ret244,16,6) ;
end;

function TACBrECFDaruma.GetNumGRG: String;
begin
  Result := '0' ;
  if fpMFD then
    Result  :=  RetornaInfoECF('33');
end;

function TACBrECFDaruma.GetNumCDC: String;
begin
  Result := '0' ;
  if fpMFD then
    Result  :=  RetornaInfoECF('45');
end;

function TACBrECFDaruma.GetNumECF: String;
Var RetCmd : AnsiString ;
begin
  if Trim(fsNumECF) = '' then
  begin
    if fpMFD then
      fsNumECF  :=  RetornaInfoECF('107')
    else if fsNumVersao='2000' then
    begin
      RetCmd  := EnviaComando( ESC + #233);
      fsNumECF:=copy(RetCmd,29,4);
    end
    else
    begin
      RetCmd := EnviaComando( ESC + #239 ) ;
      if LeftStr(RetCmd, 3) = ':' + ESC + #239 then
        fsNumECF := copy(RetCmd,4,4) ;
    end;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFDaruma.GetNumCRO: String;
Var RetCmd : AnsiString ;
begin
  if fpMFD then
    fsNumCRO := RetornaInfoECF('23')
  else if fsNumVersao='2000' then
  begin
    if Trim(fsNumCRO) = '' then
    begin
      RetCmd := EnviaComando( ESC + #237 ) ;
      if LeftStr(RetCmd, 1) = ':' then
        fsNumCRO := copy(RetCmd,49,6) ;
    end ;
  end
  else
     fsNumCRO := copy(Ret244,38,4) ;

  Result := fsNumCRO ;
end;

function TACBrECFDaruma.GetNumSerie: String;
Var RetCmd : AnsiString ;
    Tam : Integer ;
begin
  Result := '' ;
  Tam    := 8 ;

  if fpMFD then
    Result := RetornaInfoECF('78')
  else if fsNumVersao='2000' then
  begin
    RetCmd := EnviaComando( ESC + #233);
    Result := copy(RetCmd,17,Tam);
  end
  else
  begin
    If StrToIntDef(NumVersao,0) < 345 then
      Tam := 6 ;

    RetCmd := EnviaComando(ESC + #236) ;
    if LeftStr(RetCmd, 2) = ':V' then
      Result := copy(RetCmd,3,Tam) ;
  end;
end;

function TACBrECFDaruma.GetNumVersao: String ;
Var RetCmd    : AnsiString ;
    wRetentar : Boolean ;
    wTimeOut  : Integer ;
begin
  if fsNumVersao = '' then
  begin
    try
      wRetentar := Retentar ;
      wTimeOut  := TimeOut ;
      try
        TimeOut  := 1 ;
        Retentar := false ;

        RetCmd := EnviaComando(FS + 'R' + #200 + '082') ;
        RetCmd := copy(RetCmd,6,6) ;

        if RetCmd = '010053' then
          fsModeloDaruma  :=  fs600
        else if RetCmd = '010054' then
          fsModeloDaruma  :=  fs2100T
        else if RetCmd = '010058' then
          fsModeloDaruma  :=  fs600USB
        else if RetCmd = '010059' then
          fsModeloDaruma  :=  fs700L
        else if RetCmd = '010060' then
          fsModeloDaruma  :=  fs700H
        else if RetCmd = '010061' then
          fsModeloDaruma  :=  fs700M
        else if RetCmd = '010063' then
          fsModeloDaruma  :=  MACH1
        else if RetCmd = '010064' then
          fsModeloDaruma  :=  MACH2
        else if RetCmd = '010062' then
          fsModeloDaruma  :=  MACH3;

        fpMFD       := True ;
        fpTermica   := True ;

        RetCmd  :=  RetornaInfoECF('83') ;

        fsNumVersao := RetCmd ;
      finally
        Retentar := wRetentar ;
        TimeOut  := wTimeOut ;
      end ;

      if fpMFD then
      begin
        fpDecimaisQtd   := 3 ;
        fpDecimaisPreco := 2 ;

        RetCmd  :=  RetornaInfoECF('139') ;

        fpDecimaisQtd   := StrToIntDef(copy(RetCmd,1,1),fpDecimaisQtd) ;
        fpDecimaisPreco := StrToIntDef(copy(RetCmd,2,1),fpDecimaisPreco) ;
      end ;
    except
      fpMFD     := False ;
      fpTermica := False ;
      wTimeOut  := TimeOut ;
      try
        TimeOut := 1 ;
        RetCmd  := copy(EnviaComando(ESC + #195), 1, 6) ;
      finally
        TimeOut := wTimeOut;
      end ;

        if RetCmd = ':10043' then
        begin
          fsNumVersao    :=  '345';
          fsModeloDaruma :=  fs345;
        end
        else if RetCmd = ':10033' then
        begin
          fsNumVersao    :=  '315';
          fsModeloDaruma :=  fs315;
        end
        else if retcmd=':10004' then
        begin
          fsNumVersao    :=  '2000';
          fsModeloDaruma :=  fs2000;
        end
        else
        begin
          fsNumVersao    :=  copy(RetCmd,2,length(RetCmd)-2) ;
          fsModeloDaruma :=  fsIndefinido;
        end;
    end ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFDaruma.GetTotalPago: Double;
Var RetCmd : AnsiString ;
begin
  if fpMFD then
  begin
    RetCmd  :=  RetornaInfoECF('48') ;
    Result  := RoundTo( StrToFloatDef(RetCmd,0) / 100,-2) ;
  end
  else
  begin
    Result := 0;
    if fsTotalAPagar <> 0 then
      Result := Subtotal - fsTotalAPagar ;
  end ;
end;

function TACBrECFDaruma.GetSubTotal: Double;
Var RetCmd : AnsiString ;
begin
  if fpMFD then
    RetCmd  :=  RetornaInfoECF('47')
  else if fsNumVersao = '2000' then
  begin
    RetCmd := EnviaComando(ESC + #235);
    if LeftStr(RetCmd, 1) <> ':' then
      RetCmd := '0'
    else
      RetCmd := copy(RetCmd,29,12) ;
  end
  else
  begin
    RetCmd := EnviaComando(ESC + #239) ;

    if LeftStr(RetCmd, 3) <> ':' + ESC + #239 then
      RetCmd := '0'
    else
      if StrToIntDef(NumVersao,0) >= 345 then
        RetCmd := copy(RetCmd,29,14)
      else
        RetCmd := copy(RetCmd,31,21) ;
  end;

  Result := RoundTo( StrToFloatDef(RetCmd,0) / 100,-2) ;
end;

{  Ordem de Retorno do Estado da Impressora
   estNaoInicializada - Não Inicializada (Nova)
   estDesconhecido    - Desconhecido
   estPagamento       - Cupom Venda Aberto em Pagamento
   estVenda           - Cupom Venda Aberto em Itens
   estNaoFiscal       - Cupom Não Fiscal Aberto
   estRelatorio       - Cupom Vinculado Aberto | Relatório Gerencial Aberto
   estBloqueada       - Impressora Bloqueada para venda
   estRequerZ         - Requer Emissão da Redução da Z
   estRequerX         - Requer Leitura X
   estLivre           - Livre para vender
}
function TACBrECFDaruma.GetEstado: TACBrECFEstado;
Var RetCmd1,RetCmd2 : AnsiString ;
    Flag1, Flag2 : Byte ; 
begin
  Result := fpEstado ;  // Suprimir Warning
  try
    fpEstado := estNaoInicializada ;
    if (not fpAtivo) then
      exit ;

    fpEstado := estDesconhecido ;

    if fsNumVersao = '2000' then
    begin
      if fsEmPagamento then
        fpEstado := estPagamento
      else
      begin
        RetCmd2 := EnviaComando( ESC + #235 ) ;
        case RetCmd2[7] of
          '0'             : fpEstado := estLivre ;
          '1'             : fpEstado := estVenda ;
          '2','3','4','5' : fpEstado := estRelatorio ;
          '7','8','9'     : fpEstado := estPagamento ;
        end ;
      end ;

      if fpEstado = estLivre then
      begin
        RetCmd1 := EnviaComando( GS + ENQ ) ;

        if TestBit(StrToInt('$'+RetCmd1[5]),2) then
          fpEstado := estBloqueada
        else if not TestBit(StrToInt('$'+RetCmd1[5]),1) then
          fpEstado := estRequerX
      end ;
    end

    else if fpMFD then
    begin
      RetCmd2 := RetornaInfoECF('56') ;

      Flag1 := StrToIntDef(RetCmd2,0) ;
      case Flag1 of
        1 :
        begin
          RetCmd2 := RetornaInfoECF('57') ;
          Flag2   := StrToIntDef(RetCmd2,0) ;
          case Flag2 of
            1     : fpEstado := estVenda ;
            2,3,4 : fpEstado := estPagamento ;
          end ;
        end ;

        2 : fpEstado := estNaoFiscal ;
        3 : fpEstado := estRelatorio ; { CCD }
        4 : fpEstado := estRelatorio ; { RG }
      else
        begin
           fpEstado := estLivre;

           RetCmd1 := EnviaComando( GS + ACK, 1) ;

           if TestBit(StrToInt('$'+RetCmd1[5]),3) then
             fpEstado := estBloqueada
           else if TestBit(StrToInt('$'+RetCmd1[5]),2) then
              fpEstado := estRequerZ ;
//  TODO: Daruma FS600 continua informando Bit Requer X mesmo apos emitir a LeituraX
//         else if not TestBit(StrToInt('$'+RetCmd1[4]),0) then
//            fpEstado := estRequerX

        end;
      end ;
    end
    else
    begin
      if fsEmPagamento then
        fpEstado := estPagamento
      else
      begin
        RetCmd2 := EnviaComando( ESC + #239 ) ;

        if (copy(RetCmd2,8,1) = '1') then
          fpEstado := estVenda
        else if pos(copy(RetCmd2,8,1),'03') > 0 then
          fpEstado := estRelatorio
        else
          fpEstado := estLivre ;
      end ;

      if fpEstado = estLivre then
      begin
        RetCmd1 := EnviaComando( GS + FF ) ;

        if TestBit(StrToInt('$'+RetCmd1[5]),2) then
          fpEstado := estVenda
        else if TestBit(StrToInt('$'+RetCmd1[7]),1) then
          fpEstado := estBloqueada
        else if TestBit(StrToInt('$'+RetCmd1[3]),1) then
          fpEstado := estRequerZ
        else if not TestBit(StrToInt('$'+RetCmd1[7]),2) then
          fpEstado := estRequerX
      end;
    end ;
  finally
    Result := fpEstado ;
  end ;
end;

function TACBrECFDaruma.GetGavetaAberta: Boolean;
Var RetCmd : AnsiString ;
begin
  if fsNumVersao = '2000' then
     RetCmd := EnviaComando( GS + ENQ ) 
  else
     RetCmd := EnviaComando( GS + FF ) ;
     
  Result := TestBit(StrToInt('$'+RetCmd[2]),3) ;
end;

function TACBrECFDaruma.GetPoucoPapel: Boolean;
Var RetCmd : AnsiString ;
begin
  if fsNumVersao = '2000' then
   begin
     RetCmd := EnviaComando( GS + ENQ ) ;
     Result := TestBit(StrToInt('$'+RetCmd[3]),0) or
               TestBit(StrToInt('$'+RetCmd[3]),1)  ;
   end
  else
   begin
     RetCmd := EnviaComando( GS + FF ) ;
     Result := TestBit(StrToInt('$'+RetCmd[3]),0) or
               TestBit(StrToInt('$'+RetCmd[2]),0)  ;
   end
end;

function TACBrECFDaruma.GetHorarioVerao: Boolean;
Var RetCmd : AnsiString ;
begin
  if fpMFD then
  begin
    RetCmd  :=  RetornaInfoECF('108');
    Result  :=  (RetCmd = '1');
  end
  else
  begin
    RetCmd := EnviaComando( ESC + #229 ) ;
    if fsNumVersao = '2000' then
       Result := (copy(RetCmd,9,1) = '1')
    else
       Result := (copy(RetCmd,7,1) = '1') ;
  end;
end;

function TACBrECFDaruma.GetArredonda: Boolean;
Var RetCmd : AnsiString ;
begin
  if fsArredonda = ' ' then
  begin
     if fpMFD or (fsNumVersao = '2000') then
        fsArredonda := 'N'
     else
      begin
        RetCmd := EnviaComando( ESC + #229 ) ;
        if (copy(RetCmd,6,1) = '1') then
           fsArredonda := 'S'
        else
           fsArredonda := 'N' ;
     end ;
  end ;

  Result := (fsArredonda = 'S') ;
end;

Procedure TACBrECFDaruma.LeituraX ;
begin
  AguardaImpressao := True ;

  if fpMFD then
     EnviaComando(FS + 'F' + #235 + '0')
  else if fsNumVersao = '2000' then
     EnviaComando(ESC + #250, 40 )
  else
     EnviaComando(ESC + #207, 40 ) ;
  fsRet244 := '' ;
end;

procedure TACBrECFDaruma.LeituraXSerial(var Linhas: TStringList);
 Var RetCmd : AnsiString ;
begin
  Linhas.Clear ;
  if fpMFD then
  begin
     fsEsperaFFCR := True ;
     RetCmd := EnviaComando(FS + 'F' + #235 + '1', 10) ;
     RetCmd := LimpaStr( RetCmd ) ;  { Troca #0 dentro da String por espaços }
     Linhas.Text := RetCmd ;
     fsRet244 := '' ;
  end ;
end;


Procedure TACBrECFDaruma.AbreGaveta ;
Var wRetentar : Boolean ;
begin
  wRetentar := Retentar ;
  Retentar  := false ;
  try
     try
        EnviaComando( ESC + 'p000') ;
     except
     { exceçao silenciosa pois AbreGaveta nao tem resposta, Sempre gera erro }
     end ;

     try
  { pede a Data somente para esperar a impressora entrar em linha. A DARUMA
   imprime uma linha na bobina (demora + ou - 4 seg), após a abertura da gaveta}
        EnviaComando( ESC + #230, 5) ;
     except
     end ;
  finally
     Retentar := wRetentar ;
  end ;
end;

Procedure TACBrECFDaruma.ReducaoZ(DataHora: TDateTime) ;
begin
  if DataHora = 0 then  { Aparentemente a DataHora é obrigatória na Daruma }
     DataHora := now ;

  AguardaImpressao := True ;
  if fpMFD then
   begin
     try
        EnviaComando(FS + 'F' + #234 + FormatDateTime('ddmmyyhhnnss', DataHora), 15)
     except
        on E : Exception do
        begin
           if (pos('078',E.Message) <> 0) then   // Comando inválido para o documento atual.
            begin                                //  Ficou algum Cupom aberto ?
              CancelaCupom ;
              ReducaoZ(DataHora);
            end
           else
              raise ;
        end ;
     end ;
   end
  else if fsNumVersao = '2000' then
     EnviaComando( ESC + #252 + FormatDateTime('ddmmyyhhnnss',DataHora), 180 )
  else
     EnviaComando( ESC + #208 + FormatDateTime('ddmmyyhhnnss',DataHora), 180 ) ;
  fsRet244 := '' ;
end;

Procedure TACBrECFDaruma.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao) ;
end;

procedure TACBrECFDaruma.MudaHorarioVerao(EHorarioVerao: Boolean);
 Var FlagVerao : String ;
begin
  If EHorarioVerao then FlagVerao := '1' else FlagVerao := '0' ;
  EnviaComando(ESC + #228 + 'XXXXX' + FlagVerao + StringOfChar('X',34) ) ;
end;

procedure TACBrECFDaruma.MudaArredondamento(Arredondar: Boolean);
 Var FlagArredondar : Char ; 
begin
  If Arredondar then FlagArredondar := '1' else FlagArredondar := '0' ;
  EnviaComando( ESC + #228 + 'XXXX' + FlagArredondar + StringOfChar('X',35) ) ;
  fsArredonda := ' ' ;
end;

procedure TACBrECFDaruma.AbreCupom ;
Var StrConsumidor : String ;
begin
  { Daruma não permite informar o CPF/CNPJ na Abertura do Cupom }
  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }
  AguardaImpressao := True ;

  if fpMFD then
   begin
     StrConsumidor := LeftStr(Consumidor.Documento,20) + FF +
                      LeftStr(Consumidor.Nome,30) + FF +
                      LeftStr(Consumidor.Endereco,79) + FF ;

     EnviaComando(FS + 'F' + #200 + StrConsumidor ) ;
     Consumidor.Enviado := ( StrConsumidor <> '' ) ;
   end
  else
     EnviaComando(ESC + #200, 8) ;

  fsEmPagamento := false ;
  fsTotalAPagar := 0 ;
  fsRet244      := '' ;
end;

procedure TACBrECFDaruma.CancelaCupom;
Var RetCmd : String ;
    NumCupCCD : String ;
begin
  AguardaImpressao := True ;

  if fpMFD then
  begin
    RetCmd := EnviaComando( FS + 'R' + #200 + '046');  // Verifica se precisa cancelar CCD; Autor: Andre Bohn
    if copy(RetCmd, 6, 1) <> '0' then
    begin
      try
        RetCmd := EnviaComando( FS + 'R' + #200 + '050');
        NumCupCCD := GetNumCupom;
        if copy(RetCmd, 6, 6) <> NumCupCCD then
        begin
          EnviaComando(FS + 'F' + #214 , 15); // Fecho o CCD caso ainda não esteja fechado
          EnviaComando(FS + 'F' + #218 + NumCupCCD +#255+#255+#255, 15); // Cancela Conprovante Não Fiscal
          EnviaComando(FS + 'F' + #214 , 15); // Fecha Comprovante de estorno Cancela Conprovante Não Fiscal
        end;
      except
      end;

      EnviaComando(FS + 'F' + #211, 15) ;  // Cancela Cupom
    end
    else
    raise EACBrECFCMDInvalido.Create( 'Não existe documento para cancelar.');
  end

  else if fsNumVersao = '2000' then
     EnviaComando(ESC + #211, 15)
  else
     EnviaComando(ESC + #206, 15) ;
     
  fsEmPagamento := false ;
  fsTotalAPagar := 0 ;
  fsRet244      := '' ;

  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
end;

procedure TACBrECFDaruma.CancelaItemVendido(NumItem: Integer);
begin
  if fpMFD then
    EnviaComando(FS + 'F' + #203 + IntToStrZero(NumItem ,3) )
  else if fsNumVersao = '2000' then
     EnviaComando(ESC + #204 + IntToStrZero( NumItem ,3) )
  else
     EnviaComando(ESC + #205 + IntToStrZero( NumItem ,3) ) ;
end;

procedure TACBrECFDaruma.CancelaItemVendidoParcial(NumItem: Integer;
  Quantidade: Double);
begin
  if fpMFD then
    EnviaComando(FS + 'F' + #204 +  IntToStrZero(NumItem,3) +
                  IntToStrZero(Round(Quantidade * power(10,fpDecimaisQtd)), 7));
end;

procedure TACBrECFDaruma.CancelaDescontoAcrescimoItem(NumItem: Integer);
begin
  if fpMFD then
    EnviaComando(FS + 'F' + #205 +  IntToStrZero(NumItem,3));
end;

procedure TACBrECFDaruma.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
Var RetCmd : AnsiString ;
begin
  if fpMFD then
   begin
     Observacao := LeftStr(Observacao,84) + FF ;
     RetCmd := EnviaComando( FS + 'F' + #209 + CodFormaPagto +
                 IntToStrZero( Round( Valor * 100),12) + Observacao, 2) ;
     fsTotalAPagar := RoundTo( StrToFloatDef( copy(RetCmd,10,13),0 ) / 100, -2) ;
   end
  else
   begin
     Observacao := LeftStr(Observacao,48) + FF ;

     if fsNumVersao = '2000' then
        RetCmd := EnviaComando( ESC + #207 + CodFormaPagto +
                    IntToStrZero( Round( Valor * 100),12) + Observacao, 2)
     else
        RetCmd := EnviaComando( ESC + #242 + CodFormaPagto +
                    IntToStrZero( Round( Valor * 100),12) + Observacao, 2) ;

     fsTotalAPagar := RoundTo( StrToFloatDef( copy(RetCmd,2,12),0 ) / 100, -2) ;
   end ;

  fsEmPagamento := true ;
  fsRet244      := '' ;
end;

procedure TACBrECFDaruma.EstornaPagamento(const CodFormaPagtoEstornar,
  CodFormaPagtoEfetivar : String; const Valor: Double;
  Observacao : AnsiString = '') ;
begin
  if fpMFD then
  begin
    EnviaComando(FS + 'F' + #228 +  CodFormaPagtoEstornar +
            CodFormaPagtoEfetivar + IntToStrZero( Round( Valor * 100),12) +
            LeftStr( Observacao, 619 ) + FF);
  end ;
end;

procedure TACBrECFDaruma.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
Var
  Obs, StrConsumidor : AnsiString ;
begin
  Obs := Observacao ;
  if (not Consumidor.Enviado) then
  begin
     { Removendo o Consumidor da Observação, pois vai usar comando próprio }
     Obs := StringReplace(Obs,#10+'CPF/CNPJ consumidor: '+Consumidor.Documento,'',[]) ;
     Obs := StringReplace(Obs,#10+'Nome: '+Consumidor.Nome,'',[]) ;
     Obs := StringReplace(Obs,#10+'Endereco: '+Consumidor.Endereco,'',[]) ;
     try
        AguardaImpressao := True ;
        if fsNumVersao = '2000' then
         begin
           StrConsumidor := PadL( PadL(Consumidor.Documento,27) +
                                  PadL(Consumidor.Nome,42)   +
                                  PadL(Consumidor.Endereco,42), 153) ;

           EnviaComando( ESC + #208 + StrConsumidor ) ;
         end 
        else
         begin
           StrConsumidor := PadL(Consumidor.Nome,84)     +
                            PadL(Consumidor.Endereco,84) +
                            PadL(Consumidor.Documento,84) ;

           EnviaComando( ESC + #201 + StrConsumidor ) ;
         end ;

        Consumidor.Enviado := True ;
     except
        Obs := Observacao ;
     end ;
  end ;

  Obs := StringReplace(Obs,#10,CR+LF,[rfReplaceAll]) + FF ;

  AguardaImpressao := True ;
  if fpMFD then
   begin
     { Verifico se tenho que mandar o indice de alguma imagem ou um código de barras }
     { e permitido apenas um BMP ou um Código de barras }
     if (IndiceBMP > 0) and (Not CodBarras.Adicionado) then
        Obs :=  ESC + 'B' + IntToStrZero(IndiceBMP,1) + Obs
     else if (CodBarras.Adicionado) then
      begin
       if CodBarras.ImpVertical then
        begin
         Obs :=  ESC + 'a' + IntToStrZero((Integer (CodBarras.Tipo) + 1), 2) +
                 IntToStrZero(CodBarras.Largura, 1) + IntToStrZero(CodBarras.Altura, 3) +
                 IfThen(CodBarras.ImpCodEmbaixo, '1', '0') + CodBarras.Codigo +
                 NUL + #022 + #018 + Obs;
        end
       else
        begin
         Obs :=  ESC + 'b' + IntToStrZero((Integer (CodBarras.Tipo) + 1), 2) +
                 IntToStrZero(CodBarras.Largura, 1) + IntToStrZero(CodBarras.Altura, 3) +
                 IfThen(CodBarras.ImpCodEmbaixo, '1', '0') + CodBarras.Codigo +
                 NUL + Obs;
        end;
      end;
      
     EnviaComando( FS + 'F' + #210 + '0' + Obs, 5 );
   end
  else if fsNumVersao = '2000' then
     EnviaComando( ESC + #209 + Obs, 10)
  else
     EnviaComando( ESC + #243 + Obs, 10) ;

  fsEmPagamento := false ;
  fsTotalAPagar := 0 ;
  fsRet244      := '' ;
end;

procedure TACBrECFDaruma.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString );
Var A_D : AnsiChar ;
    RetCmd : AnsiString ;
begin
  if DescontoAcrescimo > 0 then
     A_D := '3'
  else
     A_D := '1' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  if fpMFD then
     RetCmd := EnviaComando(FS + 'F' + #206 + A_D + IntToStrZero(Round(DescontoAcrescimo * 100), 12), 5)
  else if fsNumVersao = '2000' then
     RetCmd := EnviaComando(ESC + #206 + A_D + IntToStrZero(
                            Round( DescontoAcrescimo * 100 ), 12), 5)
  else
     RetCmd := EnviaComando(ESC + #241 + A_D + IntToStrZero(
                            Round( DescontoAcrescimo * 100 ), 12), 5) ;

  fsEmPagamento := true ;
  fsTotalAPagar := RoundTo( StrToFloatDef( copy(RetCmd,2,12),0 ) / 100, -2) ;
  fsRet244      := '' ;
end;

procedure TACBrECFDaruma.CancelaDescontoAcrescimoSubTotal(
  TipoAcrescimoDesconto: Char);
begin
  if fpMFD then
  begin
    if TipoAcrescimoDesconto = 'D' then
      TipoAcrescimoDesconto:= '0'
    else if TipoAcrescimoDesconto = 'A' then
      TipoAcrescimoDesconto:= '1';

    EnviaComando(FS + 'F' + #208 +  TipoAcrescimoDesconto);
  end;
end;

procedure TACBrECFDaruma.LegendaInmetroProximoItem;
begin
  if fpMFD then
    EnviaComando(FS + 'C' + #215 + '1');
end;

Procedure TACBrECFDaruma.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
Var QtdStr, ValorStr, DescontoStr, SepDec, FlagDesc : String;
    LenQtd : Integer ;
    Cmd : AnsiChar ;
begin
  if Qtd > 99999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 99999.');

  if fpMFD then
   begin
     Codigo    := padL(Codigo,14) ;
     Unidade   := padL(Unidade,3) ;
     Descricao := TrimRight(LeftStr(Descricao,233)) + FF ;
     if DescricaoGrande then
        FlagDesc := '00'
     else
        FlagDesc := '18' ;

     QtdStr      := IntToStrZero( Round(Qtd * power(10,fpDecimaisQtd)), 7) ;
     ValorStr    := IntToStrZero( Round( ValorUnitario * power(10,fpDecimaisPreco)),8 ) ;
     DescontoStr := StringOfChar('0',12) ;
     
     if ValorDescontoAcrescimo > 0 then
     begin
        if TipoDescontoAcrescimo = '%' then
         begin
           if DescontoAcrescimo = 'D' then
              DescontoStr := '0'
           else
              DescontoStr := '2' ;
           DescontoStr := DescontoStr +
                          IntToStrZero( Round(ValorDescontoAcrescimo * 100), 4) +
                          StringOfChar('0',7) ;
         end
        else
         begin
           if DescontoAcrescimo = 'D' then
              DescontoStr := '1'
           else
              DescontoStr := '3' ;
           DescontoStr := DescontoStr +
                          IntToStrZero( Round(ValorDescontoAcrescimo * 100), 11) ;
         end ;
     end ;

     EnviaComando(FS + 'F' + #201 + AliquotaECF + QtdStr + ValorStr +
                  DescontoStr + FlagDesc + Codigo + Unidade + Descricao ) ;
   end
  else if fsNumVersao = '2000' then
   begin
     Codigo      := padL(Codigo,18) ;    { Ajustando Tamanhos }
     Descricao   := TrimRight(LeftStr(Descricao,200)) + FF ;
     ValorStr    := IntToStrZero( Round(ValorUnitario * 1000), 10) ;
     QtdStr      := IntToStrZero( Round(Qtd * 1000), 8) ;
     Unidade     := padL(Unidade,2) ;
     DescontoStr := StringOfChar('0',10) ;

     if ValorDescontoAcrescimo > 0 then
     begin
        if TipoDescontoAcrescimo = '%' then
         begin
           if DescontoAcrescimo = 'D' then
              DescontoStr := '0'
           else
              DescontoStr := '2' ;
           DescontoStr := DescontoStr + '00000'+
                          IntToStrZero( Round(ValorDescontoAcrescimo * 100), 4) ;
         end
        else
         begin
           if DescontoAcrescimo = 'D' then
              DescontoStr := '1'
           else
              DescontoStr := '3' ;
           DescontoStr := DescontoStr +
                          IntToStrZero( Round(ValorDescontoAcrescimo * 100), 9) ;
         end ;
     end ;

     EnviaComando(ESC + #202 + AliquotaECF + Codigo + DescontoStr +
                  ValorStr + QtdStr + Unidade + Descricao ) ;
   end
  else
   begin
     Codigo  := padL(Codigo,13) ;    { Ajustando Tamanhos }
     Unidade := padL(Unidade,2) ;
     if TipoDescontoAcrescimo = '%' then
        DescontoStr := IntToStrZero( Round(ValorDescontoAcrescimo * 100), 4)
     else
        { FS345 não tem Desconto por Valor, calculando a Percentagem }
        DescontoStr := IntToStrZero( Round( ValorDescontoAcrescimo/(ValorUnitario*Qtd) * 100 * 100), 4) ;

     if DescontoAcrescimo = 'D' then   // Desconto ou Acrescimo ?
        DescontoStr := '0' + DescontoStr
     else
        DescontoStr := '1' + DescontoStr ;
        
     if StrToInt(NumVersao) >= 345 then
      begin
        Descricao := TrimRight(LeftStr(Descricao,174)) + FF ;

        if RoundTo(Qtd,-2) <> Qtd then {Tem mais de 2 casas dec na QTD ?}
         begin
           LenQtd   := 8 ;
           Cmd      := #223 ;
           Qtd      := RoundTo(Qtd,-3) ;   // Venda fixa com 3 decimais
           SepDec   := '';
           ValorStr := IntToStrZero( Round(ValorUnitario * 1000), 10);
         end
        else
         begin
           LenQtd   := 6 ;                 // Venda com Posicao decimal variavel
           Cmd      := #225 ;
           SepDec   := ',';
           ValorStr := IntToStrZero( Round(ValorUnitario * 1000), 9);
           Codigo   := Codigo + '000'  // Reserva, compatib. modelos anteriores
         end ;
      end
     else
      begin
        LenQtd    := 5 ;
        Cmd       := #215 ;
        Descricao := PadL(Descricao,30) ;
        ValorStr  := IntToStrZero( Round(ValorUnitario * 100), 9) ;
        Codigo    := Codigo + '000'  // Reserva, compatib. modelos anteriores
      end ;

     QtdStr := FloatToStr(Qtd) ;
     if Length(QtdStr) > LenQtd then
        QtdStr := FloatToStr(RoundTo(Qtd,-(LenQtd-pos(DecimalSeparator,QtdStr)))) ;

     QtdStr := PadR(StringReplace(QtdStr,DecimalSeparator,SepDec,[rfReplaceAll]), LenQtd,'0');

     EnviaComando( ESC + Cmd + AliquotaECF + Codigo + DescontoStr +
                   ValorStr + QtdStr + Unidade + Descricao) ;
   end ;

  fsTotalAPagar := 0 ;
  fsEmPagamento := false ;
  fsRet244      := '' ;
end;

procedure TACBrECFDaruma.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
Var ValStr, DataStr : String ;
begin
  Banco      := IntToStrZero( StrToInt(Banco), 3) ;
  Favorecido := LeftStr(Trim(Favorecido),65) ;
  Cidade     := LeftStr(Trim(Cidade),25) ;
  Observacao := LeftStr(Trim(Observacao),80) ;
  DataStr    := FormatDateTime('ddmmyyyy',Data) ;
  ValStr     := IntToStrZero( Round(abs(Valor)*100),12 ) ;

  EnviaComando(ESC + 'b' + Banco) ;
  EnviaComando(ESC + 'c' + Cidade + FF) ;
  EnviaComando(ESC + 'd' + DataStr ) ;
  EnviaComando(ESC + 'f' + Favorecido + FF ) ;
  AguardaImpressao := True ;
  EnviaComando(ESC + 'v' + ValStr ) ;

  AguardaImpressao := True ;
  EnviaComando(ESC + 't' + Observacao + FF ) ;
end;

procedure TACBrECFDaruma.CancelaImpressaoCheque;
begin
  EnviaComando( ESC+'mE' ) ; 
end;

procedure TACBrECFDaruma.CarregaAliquotas;
Var RetCmd    : AnsiString ;
    Aliquota  : TACBrECFAliquota ;
    ValAliq   : Double ;
    AliquotaStr:String;
    Cont      : Integer;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  if fpMFD then
  begin
    RetCmd :=  RetornaInfoECF('125');

    for Cont := 1 to 16 do
    begin
      AliquotaStr := Trim(copy(RetCmd, ((Cont-1) * 5) + 1, 5)) ;

      if (AliquotaStr <> '') and (AliquotaStr[2] <> #255) then
      begin
        ValAliq := RoundTo( StrToIntDef( copy(AliquotaStr,2,4) ,0) / 100, -2) ;

        Aliquota          := TACBrECFAliquota.create ;
        Aliquota.Indice   := IntToStrZero(fpAliquotas.Count+1,2);
        Aliquota.Aliquota := ValAliq ;
        if AliquotaStr[1] = '0' then // Isso pode não estar certo!!!!  verificar com Daruma
          Aliquota.Tipo     := 'T'
        else
          Aliquota.Tipo     := 'S';

        fpAliquotas.Add( Aliquota ) ;
      end ;
    end ;
  end
  else
  begin
    RetCmd := EnviaComando( ESC + #231 ) ;

    if fsNumVersao = '2000' then
       RetCmd := copy(RetCmd,3,Length(RetCmd)-5)   {Retira :% e CR }
    else
       RetCmd := copy(RetCmd,3,Length(RetCmd)-3) ;  {Retira :% e CR }

    while Length(RetCmd) > 0 do
    begin
      if fsNumVersao = '2000' then
         ValAliq := RoundTo( StrToIntDef( copy(RetCmd,1,4) ,0) / 100, -2)
      else
         ValAliq := RoundTo( StrToIntDef( copy(RetCmd,2,4) ,0) / 100, -2) ;

      if ValAliq >= 0 then
      begin
         Aliquota := TACBrECFAliquota.create ;

         if fpMFD then
            Aliquota.Indice := IntToStrZero(fpAliquotas.Count+1,2)
         else
            Aliquota.Indice := 'T'+UpCase(RetCmd[1]) ;

         Aliquota.Aliquota := ValAliq ;
         if UpCase(RetCmd[1]) <> RetCmd[1] then { é minuscula ? }
            Aliquota.Tipo := 'S' ;

         fpAliquotas.Add( Aliquota ) ;
      end ;

      RetCmd := copy(RetCmd,6,Length(RetCmd) ) ;
    end ;
  end;
end;

procedure TACBrECFDaruma.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String );
Var ValStr, TipoStr : String ;
    ProxIndice  : Integer;
begin
  { Esse comando na Daruma nao usa o parametro Posicao }
  ValStr  := IntToStrZero( Round(Aliquota * 100) ,4) ;
  TipoStr := UpperCase(Tipo) ;

  if fsNumVersao = '2000' then
     raise Exception.Create('ProgramaAliquota ainda não implemenado na FS2000')

  else if fpMFD then
  begin
    CarregaAliquotas ;

    if AchaICMSAliquota(Aliquota, TipoStr[1]) <> nil then
      raise Exception.Create('Aliquota (' + FormatFloat('###,##0.00', Aliquota) + ') já existe.') ;

    ProxIndice := StrToIntDef(Posicao,0) ;
    if (ProxIndice < 1) or (ProxIndice > 16) then { Indice passado é válido ? }
    begin
      For ProxIndice := 1 to 16 do  { Procurando Lacuna }
      begin
        if AchaICMSIndice(IntToStrZero(ProxIndice,2)) = nil then
          break ;
      end ;
    end ;

    if ProxIndice > 16 then
      raise Exception.create('Não há espaço para programar novas Aliquotas !');

    if TipoStr <> 'S' then
      TipoStr := '1' // Serviço
    else
      TipoStr := '0';// Produto

    EnviaComando( FS + 'C' + #201 + IntToStrZero(ProxIndice,2) + TipoStr + ValStr ) ;
  end
  else
  begin
    if TipoStr <> 'S' then
       TipoStr := '' ;
    EnviaComando( ESC + #220 + TipoStr + ValStr ) ;
  end;
  
  CarregaAliquotas ;  { Re-avalia as aliquotas }
end;

function TACBrECFDaruma.AchaICMSAliquota( var AliquotaICMS: String) :
  TACBrECFAliquota ;
  Var AliquotaStr : String ;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  { Por indice, permite: TA, TTA (em FS345 e 2000);    T01, TT01, T1 (em MFD)  }

  if copy(AliquotaICMS,1,2) = 'TT' then { Corrige Duplo T  }
     AliquotaICMS := copy(AliquotaICMS,2,5) ;

  case AliquotaICMS[1] of
    'I' : AliquotaStr := IfThen(fpMFD,'19', 'I ') ;
    'N' : AliquotaStr := IfThen(fpMFD,'21', 'N ') ;
    'F' : AliquotaStr := IfThen(fpMFD,'17', 'F ') ;
    'T' :
      begin
         if StrIsAlpha(copy(AliquotaICMS,2,1)) then
            AliquotaICMS := 'T'+copy(AliquotaICMS,1,2)       {Indice TA, TB, TC}
         else
            AliquotaICMS := 'T'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice T01, T1, T02}
      end ;
  end;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end ;


procedure TACBrECFDaruma.CarregaFormasPagamento;  { funçao Lenta +- 3 sec. }
Var RetCmd, StrFPG, StrCNF, StrCNFVinc, Token, Descricao : AnsiString ;
    Cont,Indice : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  inherited CarregaFormasPagamento ;       {Inicializa fpFormasPagamentos}
  inherited CarregaComprovantesNaoFiscais ;{Inicializa fpComprovantesNaoFiscais}

  { Inicializando a Tabela de CNF vinculados (de uso interno) }
  if Assigned( fsCNFVinc ) then
     fsCNFVinc.Free ;
  fsCNFVinc := TACBrECFComprovantesNaoFiscais.Create( true ) ;

  try
    if fsNumVersao = '2000' then
    begin
      RetCmd := EnviaComando( ESC + #234 ) ;

      StrCNF := copy(RetCmd, 33 , 352) ;
      StrFPG := copy(RetCmd, 721, 704) ;

      for Cont := 1 to 32 do
      begin
        { Adicionando as Formas de Pagamento }
        Token     := copy(StrFPG, ((Cont-1) * 22) + 1, 22) ;
        Descricao := Trim(copy(Token,2,17)) ;
        if (Descricao <> '') and (Token[2] <> #255) then
        begin
          FPagto := TACBrECFFormaPagamento.create ;

          Indice := Cont ;
          if Cont > 16 then
            Indice := Indice + 34 ;

          FPagto.Indice    := IntToStrZero(Indice,2) ;
          FPagto.Descricao := Descricao ;
          FPagto.PermiteVinculado := (Token[1] = 'V');

          fpFormasPagamentos.Add( FPagto ) ;
        end ;
      end ;

      for Cont := 1 to 16 do
      begin
        { Adicionando os Comprovantes Nao Fiscais NAO Vinculados }
        Token := copy(StrCNF, ((Cont-1) * 22) + 1, 22) ;
        if (Token <> '') and (Token[2] <> #255) then
        begin
          CNF := TACBrECFComprovanteNaoFiscal.create ;

          CNF.Indice := chr(64+Cont);
          CNF.Descricao := Trim(Token) ;

          fpComprovantesNaoFiscais.Add( CNF ) ;
        end ;
      end ;
    end
    else if fpMFD then
    begin // Para demais impressoras termicas com mfd
      StrFPG  :=  RetornaInfoECF('126');
      StrCNF  :=  RetornaInfoECF('127');

      for Cont := 1 to 20 do
      begin
        { Adicionando as Formas de Pagamento }
        Descricao  := Trim(Copy(StrFPG, ((Cont-1) * 15) + 1, 15)) ;

        if (Descricao <> '') and (Descricao[2] <> #255) then
        begin
          FPagto := TACBrECFFormaPagamento.create ;

          FPagto.Indice := IntToStrZero(Cont,2);
          FPagto.Descricao := Descricao ;
          FPagto.PermiteVinculado := (Cont <> 1);

          fpFormasPagamentos.Add( FPagto ) ;
        end ;

        { Adicionando os Comprovantes Nao Fiscais NAO Vinculados }
        Descricao := Trim(Copy(StrCNF, ((Cont-1) * 15) + 1, 15)) ;
        if (Descricao <> '') and (Descricao[2] <> #255) then
        begin
          CNF := TACBrECFComprovanteNaoFiscal.create ;

          CNF.Indice    := IntToStrZero(Cont,2);
          CNF.Descricao := Descricao ;
          CNF.PermiteVinculado  := False ;

          fpComprovantesNaoFiscais.Add( CNF ) ;
        end ;
      end ;
    end
    else
    begin
      RetCmd := EnviaComando( ESC + #238 ) ;

      StrCNF     := copy(RetCmd, 22, 352) ;
      StrCNFVinc := copy(RetCmd, 374, 336) ;
      StrFPG     := copy(RetCmd, 710, 288) ;

      for Cont := 1 to 16 do
      begin
        { Adicionando as Formas de Pagamento }
        Token     := copy(StrFPG, ((Cont-1) * 18) + 1, 18) ;
        Descricao := Trim(copy(Token,2,17)) ;
        if (Descricao <> '') and (Descricao[2] <> #255) and
          (UpperCase(Trim(Descricao)) <> 'PAGAMENTO TIPO '+chr(64+Cont)) then
        begin
          FPagto := TACBrECFFormaPagamento.create ;

          if fpMFD then
            FPagto.Indice := IntToStrZero(Cont,2)
          else
            FPagto.Indice := chr(64+Cont) ;
          FPagto.Descricao := Descricao ;
          FPagto.PermiteVinculado := (Token[1] = 'V');

          fpFormasPagamentos.Add( FPagto ) ;
        end ;

        { Adicionando os Comprovantes Nao Fiscais NAO Vinculados }
        Token := copy(StrCNF, ((Cont-1) * 22) + 1, 22) ;
        Descricao := Trim(copy(Token,2,21));
        if (Token <> '') and (Descricao[2] <> #255) then
        begin
          CNF := TACBrECFComprovanteNaoFiscal.create ;

          if fpMFD then
            CNF.Indice := IntToStrZero(Cont,2)
          else
            CNF.Indice := chr(64+Cont) ;
          CNF.Descricao := Descricao ;
          CNF.PermiteVinculado  := False ;

          fpComprovantesNaoFiscais.Add( CNF ) ;
        end ;

        { Adicionando os Comprovantes Nao Fiscais Vinculados (tabela interna) }
        Token := Copy(StrCNFVinc, ((Cont-1) * 21) + 1, 21) ;
        if (Token <> '') and (Token[2] <> #255) then
        begin
          CNF := TACBRECFComprovanteNaoFiscal.create ;

          if fpMFD then
            CNF.Indice := IntToStrZero(Cont,2)
          else
            CNF.Indice := chr(64+Cont) ;
          CNF.Descricao := Trim(Token);
          CNF.PermiteVinculado  := True ;

          fsCNFVinc.Add( CNF ) ;
        end ;
      end ;
    end
  except
    { Se falhou ao carregar, deve "nilzar" as variaveis para que as rotinas
    "Acha*" tentem carregar novamente }
    fpFormasPagamentos.Free ;
    fpFormasPagamentos := nil ;

    fpComprovantesNaoFiscais.Free ;
    fpComprovantesNaoFiscais := nil ;

    fsCNFVinc.Free ;
    fsCNFVinc := nil ;

    raise ;
  end ;
end;

procedure TACBrECFDaruma.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
Var ProxIndice : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    FlagVinculado : Char ;
begin
  { Força uma recarga para garantir que tem o dados atualizados }
  CarregaFormasPagamento ;

  { Daruma cadastra qualquer descrição mesmo repetida, por isso vamos ver se ja existe antes }
  FPagto:= AchaFPGDescricao(Trim(Descricao),True);
  if FPagto <> nil then
     raise Exception.Create('Forma de Pagamento já cadastrada');

  ProxIndice := StrToIntDef(Posicao,-1) ;

  if fsNumVersao = '2000' then
     raise Exception.Create('ProgramaFormaPagamento ainda não implemenado na FS2000')

  else if fpMFD then
  begin
    Descricao := padL(Descricao,15) ;

    if (ProxIndice < 2) or (ProxIndice > 15) then { Indice passado é válido ? }
    begin
      For ProxIndice := 2 to 20 do  { Procurando Lacuna }
      begin
        if AchaFPGIndice(IntToStrZero(ProxIndice,2)) = nil then
          break ;
      end ;
    end ;

    if ProxIndice > 20 then
      raise Exception.create('Não há espaço para programar novas Formas de '+
                               'Pagamento');

    EnviaComando( FS + 'C' + #203 + IntToStrZero(ProxIndice,2) + Descricao ) ;

    { Força uma recarga para garantir que tem o dados atualizados }
    CarregaFormasPagamento ;
  end
  else
  begin
    Descricao := padL(Descricao,17) ;

    if (ProxIndice < 0) or (ProxIndice > 15) then { Indice passado é válido ? }
    begin
      For ProxIndice := 0 to 16 do  { Procurando Lacuna }
      begin
        if AchaFPGIndice(chr(65+ProxIndice)) = nil then
          break ;
      end ;
    end ;

    if ProxIndice > 15 then
      raise Exception.create('Não há espaço para programar novas Formas de '+
                               'Pagamento');

    If PermiteVinculado then FlagVinculado := 'V' else FlagVinculado := 'X' ;
    EnviaComando( ESC + #218 + 'PG' + FlagVinculado + chr(65+ProxIndice) +
                    Descricao ) ;

    { Adcionanodo nova FPG no ObjectList }
    FPagto := TACBrECFFormaPagamento.create ;
    FPagto.Indice    := chr(65+ProxIndice) ;
    FPagto.Descricao := Descricao ;
    FPagto.PermiteVinculado := PermiteVinculado ;
    fpFormasPagamentos.Add( FPagto ) ;

    if PermiteVinculado then  { Equalizando Formas de Pagamento com CNFs }
      if AchaCNFVincDescricao(Descricao) = nil then
        ProgramaComprovanteNaoFiscal(Descricao,'V');
  end ;
end;

procedure TACBrECFDaruma.CarregaRelatoriosGerenciais;
Var
  Token1, Token2, Descricao,
  StrRG, StrCER : AnsiString ;
  Cont, CER : Integer ;
  RG  : TACBrECFRelatorioGerencial ;
begin
  inherited CarregaRelatoriosGerenciais ;   {Inicializa fpRelatoriosGerenciais}

  try
    if fsNumVersao = '2000' then
      raise Exception.Create('ProgramaRelatorioGerencial ainda não implemenado na FS2000')

    else if fpMFD then // Para daruma FS600 e FS700
    begin
      StrRG   := RetornaInfoECF('128') ;

      StrCER  := RetornaInfoECF('044') ;

      for Cont := 1 to 20 do
      begin
        { Adicionando os Relatorios Gerenciais }
        Token1    := copy(StrRG, ((Cont-1) * 15) + 1, 15) ;
        Descricao := Trim(Token1) ;

        Token2:= copy(StrCER, ((Cont-1) * 4) + 1, 4) ;
        CER   := StrToIntDef(Token2, 0) ;
        if (Descricao <> '') and (Descricao[2] <> #255) then
        begin
          RG := TACBrECFRelatorioGerencial.create ;

          RG.Indice     := IntToStrZero(Cont,2);

          RG.Descricao  := Descricao ;

          RG.Contador   :=  CER;

          fpRelatoriosGerenciais.Add( RG ) ;
        end ;
      end ;
    end
    else
      raise Exception.Create('ECF FS345 não suporta RelatorioGerencial');
  except
      { Se falhou ao carregar, deve "nilzar" as variaveis para que as rotinas
        "Acha*" tentem carregar novamente }
      fpRelatoriosGerenciais.Free ;
      fpRelatoriosGerenciais := nil ;

      raise ;
  end ;

end;

procedure TACBrECFDaruma.ProgramaRelatorioGerencial(var Descricao: String; Posicao: String);
Var
  ProxIndice : Integer ;
begin
  CarregaRelatoriosGerenciais ;

  Descricao := Trim(Descricao) ;
  ProxIndice := StrToIntDef(Posicao, -1) ;

  if fsNumVersao = '2000' then
     raise Exception.Create('ProgramaRelatorioGerencial ainda não implemenado na FS2000')

  else if fpMFD then
  begin
    if AchaRGDescricao(Descricao, True) <> nil then
      raise Exception.Create('Relatório Gerencial ('+Descricao+') já existe.') ;

    if (ProxIndice < 2) or (ProxIndice > 20) then { Indice passado é válido ? }
    begin
      For ProxIndice := 2 to 20 do  { Procurando Lacuna }
      begin
        if AchaRGIndice(IntToStrZero(ProxIndice,2)) = nil then
        break ;
      end ;
    end ;

    if ProxIndice > 20 then
      raise Exception.create('Não há espaço para programar novos RGs');

    EnviaComando( FS + 'C' + #205 + IntToStrZero(ProxIndice,2) + PadL(Descricao,15) ) ;
  end
  else
    raise Exception.Create('ECF FS345 não suporta RelatorioGerencial');

  CarregaRelatoriosGerenciais ;
end;

procedure TACBrECFDaruma.CarregaComprovantesNaoFiscais;
begin
  CarregaFormasPagamento ;
end;

procedure TACBrECFDaruma.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String );
Var ProxIndice : Integer ;
begin
  CarregaComprovantesNaoFiscais ;

  Descricao := Trim(Descricao) ;
  ProxIndice := StrToIntDef(Posicao,-1) ;

  if fsNumVersao = '2000' then
     raise Exception.Create('ProgramaComprovanteNaoFiscal ainda não implemenado na FS2000')

  else if fpMFD then
  begin
    if AchaCNFDescricao(Descricao, True) <> nil then
      raise Exception.Create('Comprovante não fiscal ('+Descricao+') já existe.') ;

    if (ProxIndice < 3) or (ProxIndice > 20) then { Indice passado é válido ? }
    begin
      For ProxIndice := 3 to 20 do  { Procurando Lacuna }
      begin
        if AchaCNFIndice(IntToStrZero(ProxIndice,2)) = nil then
          break ;
      end ;
    end ;

    if ProxIndice > 20 then
      raise Exception.create('Não há espaço para programar novas CNFs');

    EnviaComando( FS + 'C' + #204 + IntToStrZero(ProxIndice,2) + PadL(Descricao,15) ) ;

    CarregaComprovantesNaoFiscais ;
  end
  else
  begin
    { Esse comando na Daruma nao usa o parametro Posicao }
    Descricao := padL(Descricao,21) ;
    if Tipo = '' then
      Tipo := 'V'
    else
      Tipo := UpperCase(Tipo) ;

    if pos(Tipo,'V+-') = 0 then
      raise Exception.Create('Os Tipos válidos para Daruma são:'+sLineBreak+
                               'V  Comprovante Vinculado'+sLineBreak+
                               '+  Entrada de Recursos'+sLineBreak+
                               '-  Saida de Recursos') ;
    if Tipo = 'V' then
    begin
      if AchaCNFVincDescricao(Descricao) <> nil then
        raise Exception.Create('Comprovante não fiscal ('+Descricao+') já existe.') ;
    end
    else
      if AchaCNFDescricao(Descricao, True) <> nil then
        raise Exception.Create('Comprovante não fiscal ('+Descricao+') já existe.') ;

    EnviaComando( ESC + #226 + Tipo + Descricao ) ;
    CarregaComprovantesNaoFiscais ;
  end ;
end;


procedure TACBrECFDaruma.AbreRelatorioGerencial(Indice: Integer);
Var
  IndiceStr : String;
  RG  : TACBrECFRelatorioGerencial;
begin
  AguardaImpressao := True ;
  IndiceStr :=  IntToStrZero(Indice, 2);
  if fpMFD then
  begin
    if Indice > 0 then
    begin
      RG  := AchaRGIndice( IndiceStr ) ;
      if RG = nil then
        raise Exception.create( 'Relatório Gerencial: '+IndiceStr+
                                ' não foi cadastrado.' ) ;

      EnviaComando(FS + 'F' + #230 + IndiceStr, 5) ;
    end
    else
      EnviaComando(FS + 'F' + #230 + '01', 5) ;

    fsTipoRel := 'G' ;
  end
  else if fsNumVersao='2000' then
     EnviaComando(ESC + #214, 30)
  else
     EnviaComando(ESC + #211, 30) ;
end;

procedure TACBrECFDaruma.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
Var Linhas : TStringList ;
    P, Espera : Integer ;
    Buffer : AnsiString ;
    MaxChars : Integer ;
    RetCmd : AnsiString ;
begin
  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 619 ;     { Daruma MFD aceita no máximo 619 caract. por comando }

  if not fpMFD then
  begin
     Linhas := TStringList.Create ;
     try
        Linhas.Text := Linha ;

        for P := 0 to Linhas.Count-1  do
           if fsNumVersao = '2000' then
              EnviaComando( ESC + #215 + Linhas[P] + LF )
           else
              EnviaComando( ESC + #213 + Linhas[P] + LF ) ;
     finally
        Linhas.Free ;
     end ;
  end
  else
  begin
    if not (fsTipoRel in ['G','V']) then   // Achando o Tipo de Relatorio //
    begin
      RetCmd := RetornaInfoECF('056') ;

      if RetCmd = '4' then // RG
        fsTipoRel := 'G'
      else if RetCmd = '3' then // CCD
        fsTipoRel := 'V'
      else
        fsTipoRel := ' ' ;
    end ;

    while Length( Linha ) > 0 do
    begin
      P := Length( Linha ) ;
      if P > MaxChars then    { Acha o fim de Linha mais próximo do limite máximo }
        P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

      if P = 0 then
        P := Colunas ;

      Buffer := copy( Linha, 1, P)  ;
      Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

      if (IndiceBMP > 0) and (Not CodBarras.Adicionado) then
        Buffer  :=  ESC + 'B' + IntToStrZero(IndiceBMP, 1) + Buffer
      else if (CodBarras.Adicionado) then
      begin
        if CodBarras.ImpVertical then
        begin
          Buffer  :=  ESC + 'a' + IntToStrZero((Integer (CodBarras.Tipo) + 1), 2) +
                  IntToStrZero(CodBarras.Largura, 1) + IntToStrZero(CodBarras.Altura, 3) +
                  IfThen(CodBarras.ImpCodEmbaixo, '1', '0') + CodBarras.Codigo +
                  NUL + #022 + #018 + Buffer;
        end
        else
        begin
          Buffer  :=  ESC + 'b' + IntToStrZero((Integer (CodBarras.Tipo) + 1), 2) +
                  IntToStrZero(CodBarras.Largura, 1) + IntToStrZero(CodBarras.Altura, 3) +
                  IfThen(CodBarras.ImpCodEmbaixo, '1', '0') + CodBarras.Codigo + NUL;
        end;
      end;


      AguardaImpressao := (Espera > 3) ;
      if fsTipoRel = 'V' then
        EnviaComando( FS + 'F' + #213 + Buffer + FF, Espera )
      else
        EnviaComando( FS + 'F' + #231 + Buffer + FF, Espera ) ;

      { ficou apenas um LF sozinho ? }
      if (P = Colunas) and (RightStr( Buffer, 1) <> #10) and
        (copy( Linha, P+1, 1) = #10) then
        P := P + 1 ;

      Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
    end ;
  end ;
end;

procedure TACBrECFDaruma.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
Var FPG : TACBrECFFormaPagamento ;
    CNF : TACBrECFComprovanteNaoFiscal ;
    StrValor : String ;
begin
  COO      := Poem_Zeros( trim(COO) ,6) ;
  StrValor := IntToStrZero( Round(Valor * 100) ,12) ;

  AguardaImpressao := True ;

  if fpMFD then
  begin
    if StrIsAlpha( Trim(CodFormaPagto) ) then
    begin
      CodFormaPagto := RightStr(Trim(CodFormaPagto),1) ;
      CodFormaPagto := IntToStrZero(Ord(CodFormaPagto[1]) - 64,2) ;
    end ;

    EnviaComando(FS + 'F' + #212 + CodFormaPagto + '01' + COO + StrValor +
                   FF+FF+FF, 4) ;
    fsTipoRel := 'V'
  end
  else if fsNumVersao = '2000' then
    EnviaComando(ESC + #213 +CodFormaPagto+ COO + StrValor, 8)
  else
  begin
    FPG := AchaFPGIndice( CodFormaPagto ) ;
    if FPG = nil then
      raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                                ' não foi cadastrada.' ) ;

    if CodComprovanteNaoFiscal <> '' then
    begin
      CNF := AchaCNFVincIndice( CodComprovanteNaoFiscal ) ;
      if CNF = nil then
        raise Exception.create( 'Comprovante NÃO Fiscal Vinculado: '+
                            CodComprovanteNaoFiscal+' não cadastrado.' ) ;
    end
    else
    begin
      CNF := AchaCNFVincDescricao( FPG.Descricao ) ;
      if CNF = nil then
        raise Exception.create( 'Não existe nenhum Comprovante NÃO Fiscal Vinculado'+
                            ' com a Descrição: '+FPG.Descricao) ;
    end ;

    AguardaImpressao := True ;
    EnviaComando(ESC + #219 + CNF.Indice + FPG.Indice + COO + StrValor, 8);
  end ;
end;

procedure TACBrECFDaruma.LinhaCupomVinculado(Linha: AnsiString);
begin
  LinhaRelatorioGerencial( Linha )
end;

procedure TACBrECFDaruma.FechaRelatorio;
Var RetCmd : AnsiString ;
begin
  if fpMFD then
  begin
    // Busco o tipo de Documento a Fechar
    RetCmd  :=  Trim(RetornaInfoECF('056'));

    if RetCmd = '2' then // CNF
      EnviaComando(FS + 'F' + #226, 8 )
    else if RetCmd = '3' then  // CCD
      EnviaComando(FS + 'F' + #214, 8 )
    else if RetCmd = '4' then  // RG
      EnviaComando(FS + 'F' + #232, 8 ) ;

    fsTipoRel := ' '
  end
  else
  if fsNumVersao = '2000' then
  begin
    RetCmd := EnviaComando( ESC + #235 ) ;

    if pos(copy(RetCmd,7,1),'2345') > 0 then
    begin
      AguardaImpressao := True ;
      EnviaComando(ESC + #216, 8 ) ;
    end ;
  end
  else
  begin
    RetCmd := EnviaComando( ESC + #239 ) ;
    if pos(copy(RetCmd,8,1),'03') > 0 then
    begin
      AguardaImpressao := True ;
      EnviaComando(ESC + #212, 8 ) ;
    end ;
  end;
end;

procedure TACBrECFDaruma.ImpactoAgulhas( NivelForca : Integer = 2);
Var Cmd : AnsiString ;
begin
  if not fpMFD then // Somente se não for MFD
  begin
    if NivelForca > 2 then
       Cmd := '2'
    else
      Cmd := '0' ;

    EnviaComando(ESC + #228 + StringOfChar('X',13) + Cmd + StringOfChar('X',26) ) ;
  end;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer; Simplificada : Boolean);
 Var Espera : Integer ;
     Flag   : Char ;
begin
  Espera := 20 + (ReducaoFinal - ReducaoInicial) * 2 ;
  Flag   := 'x' ;
  if Simplificada then
     Flag := 'X' ;

  AguardaImpressao := True ;
  if fpMFD then
    EnviaComando( FS + 'F' + #233 + IfThen(Simplificada, '3', '2') + IntToStrZero(ReducaoInicial,6)+
                     IntToStrZero(ReducaoFinal  ,6), Espera )
  else if fsNumVersao = '2000' then
    EnviaComando( ESC + #251 + Flag + IntToStrZero(ReducaoInicial,6)+
                     IntToStrZero(ReducaoFinal  ,6), Espera )
  else
     EnviaComando( ESC + #209 + Flag + IntToStrZero(ReducaoInicial,6)+
                     IntToStrZero(ReducaoFinal  ,6), Espera ) ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada : Boolean);
 Var Espera : Integer ;
     Flag   : Char ;
begin
  Espera := 20 + DaysBetween(DataInicial,DataFinal) * 2 ;
  Flag   := 'x' ;
  if Simplificada then
     Flag := 'X' ;

  AguardaImpressao := True ;
  if fpMFD then
    EnviaComando( FS + 'F' + #233 + IfThen(Simplificada, '3', '2') + FormatDateTime('ddmmyy',DataInicial) +
                     FormatDateTime('ddmmyy',DataFinal), Espera )
  else if fsNumVersao = '2000' then
     EnviaComando(ESC + #251 + Flag + FormatDateTime('ddmmyy',DataInicial)+
                      FormatDateTime('ddmmyy',DataFinal), Espera )
  else
     EnviaComando( ESC + #209 + Flag + FormatDateTime('ddmmyy',DataInicial)+
                         FormatDateTime('ddmmyy',DataFinal), Espera ) ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas: TStringList; Simplificada : Boolean);
 Var Espera : Integer ;
     RetCmd : AnsiString ;
     Flag   : Char ;
begin
  Espera := 20 + (ReducaoFinal - ReducaoInicial) * 2  ;
  Flag   := 's' ;
  if Simplificada then
     Flag := 'S' ;

  fsEsperaFFCR := True ;
  if fpMFD then
    RetCmd :=  EnviaComando( FS + 'F' + #233 + IfThen(Simplificada, '0', '1') + IntToStrZero(ReducaoInicial,6)+
                     IntToStrZero(ReducaoFinal  ,6), Espera )
  else
    RetCmd := EnviaComando(ESC + #209 + Flag +
                            IntToStrZero(ReducaoInicial,6)+
                            IntToStrZero(ReducaoFinal  ,6), Espera ) ;
                            
  RetCmd := LimpaStr( RetCmd ) ;  { Troca #0 dentro da String por espaços }
  Linhas.Clear ;
  Linhas.Text := RetCmd ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas: TStringList; Simplificada : Boolean);
 Var Espera : Integer ;
     RetCmd : AnsiString ;
     Flag   : Char ;
begin
  Espera := 20 + DaysBetween(DataInicial,DataFinal) * 2;
  Flag   := 's' ;
  if Simplificada then
     Flag := 'S' ;

  fsEsperaFFCR := True;
  if fpMFD then
    RetCmd :=  EnviaComando( FS + 'F' + #233 + IfThen(Simplificada, '0', '1') + FormatDateTime('ddmmyy',DataInicial)+
                     FormatDateTime('ddmmyy',DataFinal), Espera )
  else
    RetCmd := EnviaComando(ESC + #209 + Flag +
                            FormatDateTime('ddmmyy',DataInicial)+
                            FormatDateTime('ddmmyy',DataFinal), Espera ) ;
  RetCmd := LimpaStr( RetCmd ) ;  { Troca #0 dentro da String por espaços }
  Linhas.Clear ;
  Linhas.Text := RetCmd ;
end;

Function TACBrECFDaruma.DocumentosToStr(Documentos : TACBrECFTipoDocumentoSet) : String ;
begin
  if (Documentos - [docTodos]) = [] then
     Result := StringOfChar('1',18)
  else
   begin
     Result := '' ;
     Result := Result + IfThen(docRZ              in Documentos, '1', '0');
     Result := Result + IfThen(docLX              in Documentos, '1', '0');
     Result := Result + IfThen(docCF              in Documentos, '1', '0');
     Result := Result + IfThen(docCFBP            in Documentos, '1', '0');
     Result := Result + IfThen(docCupomAdicional  in Documentos, '1', '0');
     Result := Result + IfThen(docCFCancelamento  in Documentos, '1', '0');
     Result := Result + IfThen(docCCD             in Documentos, '1', '0');
     Result := Result + IfThen(docAdicionalCCD    in Documentos, '1', '0');
     Result := Result + IfThen(docSegViaCCD       in Documentos, '1', '0');
     Result := Result + IfThen(docReimpressaoCCD  in Documentos, '1', '0');
     Result := Result + IfThen(docEstornoCCD      in Documentos, '1', '0');
     Result := Result + IfThen(docCNF             in Documentos, '1', '0');
     Result := Result + IfThen(docCNFCancelamento in Documentos, '1', '0');
     Result := Result + IfThen(docSangria         in Documentos, '1', '0');
     Result := Result + IfThen(docSuprimento      in Documentos, '1', '0');
     Result := Result + IfThen(docEstornoPagto    in Documentos, '1', '0');
     Result := Result + IfThen(docRG              in Documentos, '1', '0');
     Result := Result + IfThen(docLMF             in Documentos, '1', '0');
   end ;

  Result := PadL( Result, 31, '1') ;
end ;

procedure TACBrECFDaruma.LeituraMFDSerial(COOInicial, COOFinal: Integer;
  var Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet);
 Var Espera : Integer;
     RetCmd : AnsiString ;
begin
  { O download da MFD é um processo bastante demorado por isso forcei um TimeOut
    maior. Dependendo da Faixa de COO's a ser baixada pode ser necessário aumantar
    ainda mais o TimeOut. Cfe. testes realizados, faixas de 100 COOs ainda são
    grandes demais p/ um TimeOut de 300 seg., aconselha-se fazer a leitura por
    faixas de 50 em 50 COOs ( Aprox. 220 COOs em 8min em uma FS600 V.1.03) }

  Espera := 20 + (COOFinal - COOInicial) * 2 ;
  fsEsperaFFCR  :=  True ;

  RetCmd := EnviaComando( FS + 'R' + #201 + '024' +
                          IntToStrZero(COOInicial,6) +
                          IntToStrZero(COOFinal  ,6) + '12' +
                          DocumentosToStr(Documentos), Espera );

  RetCmd := LimpaStr( RetCmd ) ;  { Troca #0 dentro da String por espaços }
  Linhas.Clear ;
  Linhas.Text := RetCmd ;
end;

procedure TACBrECFDaruma.LeituraMFDSerial(DataInicial,
  DataFinal: TDateTime; var Linhas: TStringList;
  Documentos : TACBrECFTipoDocumentoSet);
 Var Espera : Integer;
     RetCmd : AnsiString ;
begin
  Espera := 20 + (DaysBetween(DataInicial,DataFinal)) * 2 ;
  fsEsperaFFCR := True ;
  
  RetCmd := EnviaComando( FS + 'R' + #201 + '024' +
                          FormatDateTime('ddmmyy',DataInicial)+
                          FormatDateTime('ddmmyy',DataFinal) + '11' +
                          DocumentosToStr(Documentos), Espera );

  RetCmd := LimpaStr( RetCmd ) ;  { Troca #0 dentro da String por espaços }
  Linhas.Clear ;
  Linhas.Text := RetCmd ;
end;

function TACBrECFDaruma.LimpaStr(AString: AnsiString): AnsiString;
Var A,Len : Integer ;
begin
  Result := '' ;
  Len    := Length( AString ) ;

  For A := 1 to Len do
  begin
     if AString[A] = #0 then
        Result := Result + ' '
     else
        Result := Result + AString[A] ;
  end ;
end;


function TACBrECFDaruma.GetComprovantesNaoFiscaisVinculado: TACBrECFComprovantesNaoFiscais;
begin
  if not Assigned( fsCNFVinc ) then
     CarregaComprovantesNaoFiscais ;

  Result := fsCNFVinc ;
end;

function TACBrECFDaruma.AchaCNFVincDescricao(
  Descricao: String): TACBrECFComprovanteNaoFiscal;
var A : Integer ;
begin
  if not Assigned( fsCNFVinc ) then
     CarregaComprovantesNaoFiscais ;

  Descricao := Trim(UpperCase( Descricao )) ;
  Result    := nil ;

  with fsCNFVinc do
  begin
    For A := 0 to Count -1 do
      if Trim(UpperCase( Objects[A].Descricao )) = Descricao then
      begin
        Result := Objects[A] ;
        Break ;
      end ;
  end ;
end;

function TACBrECFDaruma.AchaCNFVincIndice(
  Indice: String): TACBrECFComprovanteNaoFiscal;
var A : Integer ;
begin
  if not Assigned( fsCNFVinc ) then
     CarregaComprovantesNaoFiscais ;

  Result := nil ;
  with fsCNFVinc do
  begin
    For A := 0 to Count -1 do
      if Objects[A].Indice = Indice then
      begin
        Result := Objects[A] ;
        Break ;
      end ;
  end ;
end;

function TACBrECFDaruma.GetNumCRZ: String;
// Autor: Jhony Alceu Pereira
Var RetCmd : AnsiString ;
begin
  Result := '' ;

  if fpMFD then
    Result  :=  RetornaInfoECF('024')
  else if fsNumVersao = '2000' then
  begin
    RetCmd := EnviaComando( ESC + #237 ) ;
    if LeftStr(RetCmd, 1) = ':' then
      Result := copy(RetCmd,55,6) ;
  end
  else
    Result := copy(Ret244,42,4) ;
end;

function TACBrECFDaruma.GetGrandeTotal: Double;
// Autor: Jhony Alceu Pereira
Var RetCmd : AnsiString ;
begin
  Result:=0;

  if fpMFD then
    Result  :=  (StrToFloatDef(RetornaInfoECF('001'), 0)/100)
  else if fsNumVersao='2000' then
  begin
    RetCmd := EnviaComando( ESC + #235 ) ;
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd,41,18),0)/100 ;
  end
  else
  begin
    RetCmd := EnviaComando( ESC + #239 ) ;
    if LeftStr(RetCmd, 3) = ':' + ESC + #239 then
      Result := StrToFloatDef(copy(RetCmd,43,18),0)/100 ;
  end;

  Result := RoundTo( Result, -2);
end;

function TACBrECFDaruma.GetNumCOOInicial: String;
// Autor: Jhony Alceu Pereira
Var RetCmd : AnsiString ;
begin
  Result := '' ;

  if fpMFD then
    { a FS600 retorna o da Ultima Z, Pág 20 do Manual }    
    Result  :=  IntToStr(StrToInt(RetornaInfoECF('027')) + 1)
  else if fsNumVersao='2000' then
  begin
    RetCmd := EnviaComando( ESC + #237 ) ;
    if LeftStr(RetCmd, 1) = ':' then
      Result := copy(RetCmd,7,6) ;
  end
  else
    Result := copy(Ret244,4,6) ;
end;

function TACBrECFDaruma.GetVendaBruta: Double;
// Autor: Jhony Alceu Pereira
Var RetCmd : AnsiString ;
begin
  Result := 0 ;

  if fpMFD then
    Result  :=  (StrToFloatDef(RetornaInfoECF('002'),0)/100)
  else if fsNumVersao = '2000' then
  begin
    RetCmd := EnviaComando( ESC + #236 ) ;
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd,7,18),0)/100 ;
  end
  else
  begin
    RetCmd := EnviaComando( ESC + #240 ) ;
    if LeftStr(RetCmd, 3) = ':' + ESC + #240 then
      Result := StrToFloatDef(copy(RetCmd,4,18),0)/100 ;
  end;

  //Alterado por: Maicon da Silva Evangelista
  Result := RoundTo( ( GrandeTotal - Result), -2 );
end;

function TACBrECFDaruma.GetNumUltimoItem: Integer;
Var RetCmd : AnsiString ;
begin
  { Nota: não encontrado a leitura do ultimo item na FS345 }
  Result := 0 ;

  if fpMFD then
    Result := StrToIntDef(RetornaInfoECF('058'), 0)
  else if (fsNumVersao = '2000') then
  begin
    RetCmd := EnviaComando( ESC + #235 ) ;

    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToIntDef(copy(RetCmd,14,3),0) ;
  end ;
end;

procedure TACBrECFDaruma.AbreNaoFiscal(CPF_CNPJ: String);
begin
  if fpMFD then
     EnviaComando( FS + 'F' + #219 + Trim(CPF_CNPJ) + FF + FF + FF) ;
  fsRet244 := '' ;
end;

procedure TACBrECFDaruma.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString);
begin
  if fpMFD then
     EnviaComando( FS + 'F' + #220 + CodCNF +
                   IntToStrZero( Round(Valor*100),11) + StringOfchar('0',12) )
  else
     EnviaComando( ESC + #217 + CodCNF + StringOfChar('0',13) +
                   IntToStrZero( Round(Valor*100),12) +
                   LeftStr(Obs,40) + FF ) ;
  fsRet244 := '' ;
end;

procedure TACBrECFDaruma.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
  Var A_D : Char ;
begin
  if DescontoAcrescimo > 0 then
     A_D := '3'
  else
     A_D := '1' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  if fpMFD then
     EnviaComando( FS + 'F' + #223 + A_D +
                   IntToStrZero( Round(DescontoAcrescimo*100),12) ) ;
  fsRet244 := '' ;
end;

procedure TACBrECFDaruma.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  if fpMFD then
     EnviaComando( FS + 'F' + #225 + CodFormaPagto +
                 IntToStrZero( Round( Valor * 100),12) +
                 LeftStr(Observacao,84) + FF )
  else
     EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);
  fsRet244 := '' ;
end;

procedure TACBrECFDaruma.FechaNaoFiscal(Observacao: AnsiString; IndiceBMP : Integer);
Var
  Obs : String;
begin
  Obs :=  LeftStr(Observacao,619);

  Obs := StringReplace(Obs,#10,CR+LF,[rfReplaceAll]) + FF ;

  if fpMFD then
  begin
     if IndiceBMP > 0 then
        Obs :=  ESC + 'B' + IntToStrZero(IndiceBMP,1) + Obs;

     EnviaComando( FS + 'F' + #226 + Obs ) ;
  end;

  fsEmPagamento := false;   { Linha adicionada por Marciano Lizzoni }
  fsRet244      := '' ;
end;

procedure TACBrECFDaruma.CancelaNaoFiscal;
begin
  if fpMFD then
     EnviaComando( FS + 'F' + #229 )
  else
     CancelaCupom ;
  fsRet244 := '' ;
end;

function TACBrECFDaruma.GetTotalAcrescimos: Double;
var
   RetCmd: AnsiString;
begin
   Result := 0;

  if fpMFD then  // Autor: Ederson Selvati
    Result := (StrToFloatDef(RetornaInfoECF('012'),0)/100)
  else if fsNumVersao = '2000' then //Autor: Maicon da Silva Evangelista
  begin
     //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd, 316, 14), 0) /100;
  end;

  Result := RoundTo( Result, -2);
end;

function TACBrECFDaruma.GetTotalCancelamentos: Double;
 var
   RetCmd: AnsiString;
begin
  Result := 0;

  if fpMFD then   // Autor: Ederson Selvati
    Result := (StrToFloatDef(RetornaInfoECF('013'),0)/100)
  else if fsNumVersao = '2000' then  //Autor: Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd, 36, 14), 0) /100;
  end;

  Result := RoundTo( Result, -2);
end;

function TACBrECFDaruma.GetTotalDescontos: Double;
 var
   RetCmd: AnsiString;
begin
  Result := 0;

  if fpMFD then // Autor: Ederson Selvati
    Result := (StrToFloatDef(RetornaInfoECF('011'),0)/100)
  else if fsNumVersao = '2000' then //Autor: Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd, 22, 14), 0) /100;
  end;

  Result := RoundTo( Result, -2);
end;

function TACBrECFDaruma.GetTotalIsencao: Double;
var
  RetCmd: AnsiString;
begin
  Result := 0;

  if fpMFD then  // Autor: Ederson Selvati
    Result := (StrToFloatDef(Copy(RetornaInfoECF('003'), 235, 13),0)/100)
  else if fsNumVersao = '2000' then  //Autor: Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd, 50, 14), 0) /100;
  end;

  Result := RoundTo( Result, -2);
end;


function TACBrECFDaruma.GetTotalNaoTributado: Double;
 var
    RetCmd: AnsiString;
begin
  Result := 0;

  if fpMFD then   // Autor: Ederson Selvati
    Result := (StrToFloatDef(Copy(RetornaInfoECF('003'), 261, 13),0)/100)
  else if fsNumVersao = '2000' then //Autor: Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd, 64, 14), 0) /100;
  end;

  Result := RoundTo( Result, -2);
end;

function TACBrECFDaruma.GetTotalSubstituicaoTributaria: Double;
 var
    RetCmd: AnsiString;
begin
  Result := 0;

  if fpMFD then  // Autor: Ederson Selvati
    Result := (StrToFloatDef(Copy(RetornaInfoECF('003'), 209, 13),0)/100)
  else if fsNumVersao = '2000' then //Autor: Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    if LeftStr(RetCmd, 1) = ':' then
      Result := StrToFloatDef(copy(RetCmd, 78, 14), 0) /100;
  end;

  Result := RoundTo( Result, -2);
end;

function TACBrECFDaruma.GetCNPJ: String;
 var
   RetCmd: AnsiString;
begin
  Result := '';

  if fpMFD then   // Autor: Ederson Selvatin
    Result := Trim(RetornaInfoECF('090'))
  else if fsNumVersao = '2000' then  //Autor Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #251 + '00' );
    if LeftStr(RetCmd, 1) = ':' then
      Result := copy(RetCmd, 7, 18);
  end;
end;

function TACBrECFDaruma.GetIE: String;
var
   RetCmd: AnsiString;
begin
  Result := '';

  if fpMFD then
    Result := Trim(RetornaInfoECF('091'))
  else if fsNumVersao = '2000' then  //Autor: Maicon da Silva Evangelista
  begin
    //Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #251 + '00' );
    if LeftStr(RetCmd, 1) = ':' then
      Result := copy(RetCmd, 30, 15);
  end;
end;

function TACBrECFDaruma.GetDataMovimento: TDateTime;
 var
    RetCmd: AnsiString;
    OldShortDateFormat : String;
begin
  Result := 0;

  if fpMFD then  // Autor: Ederson Selvati
  begin
    RetCmd := RetornaInfoECF('070');
    OldShortDateFormat := ShortDateFormat;
    try
      ShortDateFormat := 'dd/mm/yyyy';
      Result := StrToDate( copy(RetCmd,1,2) + DateSeparator +
                             copy(RetCmd,3,2) + DateSeparator +
                             copy(RetCmd,5,4) );
    finally
      ShortDateFormat := OldShortDateFormat;
    end;
  end
  else if fsNumVersao = '2000' then //Autor Maicon da Silva Evangelista
  begin
    Result := Date; // Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #250 );
    if LeftStr(RetCmd, 1) = ':' then
    begin
      OldShortDateFormat := ShortDateFormat;
      Try
        ShortDateFormat := 'dd/mm/yyyy';
        Try(* Data do movimento *)
          Result := StrToDate( copy(RetCmd,2,2) + DateSeparator +
                                    copy(RetCmd,4,2) + DateSeparator +
                                    copy(RetCmd,6,2) );
        Except
          Result := Date;
        end;
      finally
        ShortDateFormat := OldShortDateFormat;
      end;
    end;
  end;
end;

procedure TACBrECFDaruma.LerTotaisAliquota;
 var
    A: Integer;
    RetCmd: AnsiString;
begin
  CarregaAliquotas;

  if fpMFD then  // Autor: Ederson Selvati
  begin
    RetCmd := RetornaInfoECF('003');
    for A := 0 to fpAliquotas.Count-1 do
    begin
      fpAliquotas[A].Total := RoundTo( StrToFloatDef(Copy(RetCmd,(A*13)+1,13),0)
                                         / 100, -2 );
    end;
  end
  else if fsNumVersao = '2000' then  //Autor Maicon da Silva Evangelista
  begin
      // Falta Implementar
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := EnviaComando( ESC + #240 );
    RetCmd := Copy(RetCmd, 92, Length(RetCmd));
    RetCmd := RetCmd;
    for A := 0 to fpAliquotas.Count-1 do
    begin
      fpAliquotas[A].Total := RoundTo( StrToFloatDef(Copy(RetCmd,(A*14)+1,14),0)
                                         / 100, -2 );
    end;
  end;
end;

procedure TACBrECFDaruma.LerTotaisFormaPagamento;
//Autor: Maicon da Silva Evangelista
var
   A: Integer;
   RetCmd, RetCmdAux,
   StrCNFVinc, StrCNF : AnsiString;
begin
  if not Assigned( fpFormasPagamentos ) then
    CarregaFormasPagamento;

  if not Assigned( fpComprovantesNaoFiscais ) then
    CarregaComprovantesNaoFiscais;

  fsRet244 := '' ;  { força a leitura do 244 }


  if fpMFD then
  begin
    for A := 0 to fpFormasPagamentos.Count-1 do
    begin
      RetCmd := EnviaComando( FS + 'R' + #201 + '009'+ IntToStrZero(A+1,2) + CR);
      RetCmd := Copy(RetCmd, 6, Length(RetCmd));

      fpFormasPagamentos[A].Total := RoundTo( StrToFloatDef(Copy(RetCmd,1,13),0)
                                          / 100, -2 );
    end;
  end
  else if fsNumVersao = '2000' then
  begin
    RetCmd := EnviaComando( ESC + #237 );
    RetCmd := Copy(RetCmd, 163, Length(RetCmd));
    for A := 0 to fpAliquotas.Count-1 do
    begin
      fpFormasPagamentos[A].Total := RoundTo( StrToFloatDef(Copy(RetCmd,(A*14)+1,14),0)
                                         / 100, -2 );
    end;
  end
  else if StrToInt(fsNumVersao) >= 345 then
  begin
    RetCmd := Ret244 ;
    RetCmd := Copy(RetCmd, 50, 224);
    for A := 0 to fpFormasPagamentos.Count-1 do
    begin
      fpFormasPagamentos[A].Total := RoundTo( StrToFloatDef(Copy(RetCmd,(A*14)+1,14),0)
                                         / 100, -2 );
    end;
  end;


  { ----- Calculando LerTotaisComprovanteNaoFiscal ----- }
   
  if fpMFD then
  begin
    // Autor: Andre Bohn
    for A := 0 to fpComprovantesNaoFiscais.Count -1 do
    begin
      RetCmd := EnviaComando( FS + 'R' + #201 + '010'+ IntToStrZero(A+1,2) + CR);
      RetCmd := Copy(RetCmd, 6, Length(RetCmd));

      fpComprovantesNaoFiscais[A].Total   := RoundTo( StrToFloatDef(Copy(RetCmd,1,13),0)
                                          / 100, -2 );
    end;
      
    // Autor: Maicon da Silva e Gustava Montagoli
    for A := 0 to fpComprovantesNaoFiscais.Count -1 do
    begin
      RetCmd := EnviaComando( FS + 'R' + #201 + '011'+ IntToStrZero(A+1,2) + CR);
      RetCmd := Copy(RetCmd, 6, Length(RetCmd));

      fpComprovantesNaoFiscais[A].Contador   := StrToIntDef(Copy(RetCmd,1,4),0);
    end;
  end
  else if fsNumVersao = '2000' then
  begin
    //Falta Implementar
  end
  else if (StrToInt(fsNumVersao) >= 345) then
  begin
    RetCmd := Ret244 ;

    (* Ler Comprovante não fiscal não vinculado *)
    StrCNF  := Copy(RetCmd, 288, 224);
    for A := 0 to fpComprovantesNaoFiscais.Count -1 do
    begin
      If Not fpComprovantesNaoFiscais[A].PermiteVinculado then
      begin
        RetCmdAux := Copy(StrCNF,(A*18)+1,18);

        fpComprovantesNaoFiscais[A].Contador:= StrToIntDef( Copy( RetCmdAux, 15, 4 ), 0);
        fpComprovantesNaoFiscais[A].Total   := RoundTo( StrToFloatDef( Copy( RetCmdAux, 1, 14 ), 0) / 100, -2 );
        end;
    end;

    (* Ler Comprovante não fiscal vinculado *)
    StrCNFVinc  := Copy(RetCmd, 618, 224);
    for A := 0 to fsCNFVinc.Count -1 do
    begin
      If fsCNFVinc[A].PermiteVinculado then
      begin
        RetCmdAux   := Copy(StrCNFVinc,(A*18)+1,18);

        fsCNFVinc[A].Contador:= StrToIntDef( Copy( RetCmdAux, 15, 4 ), 0);
        fsCNFVinc[A].Total   := RoundTo( StrToFloatDef( Copy( RetCmdAux, 1, 14 ), 0) / 100, -2 );
      end;
    end;
  end;
end;

procedure TACBrECFDaruma.LerTotaisComprovanteNaoFiscal;
begin
  LerTotaisFormaPagamento ;
end;

function TACBrECFDaruma.GetTotalNaoFiscal: Double;
//Autor: Maicon da Silva Evangelista
var
   Cont        :  Integer;
   TotalCNFVinc,
   TotalCNF    :  Double;
begin
  LerTotaisComprovanteNaoFiscal;

  TotalCNF := 0 ;
  for Cont := 0 to fpComprovantesNaoFiscais.Count -1 do
  begin
    If Not fpComprovantesNaoFiscais[Cont].PermiteVinculado then
      TotalCNF := TotalCNF + RoundTo( fpComprovantesNaoFiscais[Cont].Total, -2);
  end;

  TotalCNFVinc := 0 ;
  for Cont := 0 to fsCNFVinc.Count -1 do
  begin
    If fsCNFVinc[cont].PermiteVinculado then
         TotalCNFVinc:= TotalCNFVinc + RoundTo( fsCNFVinc[Cont].Total, -2);
  end;

   Result := RoundTo( ( TotalCNFVinc + TotalCNF ), -2);
end;

function TACBrECFDaruma.GetRet244: AnsiString;
begin
  if fsRet244 = '' then
  begin
     fsRet244 := EnviaComando( ESC + #244 ) ;
     if LeftStr(fsRet244, 3) <> ':' + ESC + #244 then
        fsRet244 := '' ;
  end ;

  Result := fsRet244 ;
end;

procedure TACBrECFDaruma.IdentificaOperador(Nome: String);
begin
  if fpMFD then
    EnviaComando( FS + 'C' + #209 + padL(Nome,20) )
  else
    EnviaComando( ESC + #218 + 'O' + padL(Nome,20) );
end;

function TACBrECFDaruma.GetPAF: String;
begin
  Result := '' ;
  if fpMFD then
     Result := RetornaInfoECF('131');
end;

procedure TACBrECFDaruma.IdentificaPAF(Linha1, Linha2: String);
begin
  if fpMFD then
    EnviaComando( FS + 'C' + #214 + PadL(Linha1,42) + PadL(Linha2,42) );
end;

Function TACBrECFDaruma.RetornaInfoECF( Registrador: String) : AnsiString;
 Var Indice : Integer ;
begin
  Result := '' ;
  
  if fpMFD then
  begin
    // Implementação pedida pela daruma apenas para facilitar a vida de alguns
    // desenvolvedores que necessitam de alguma informação que não esta
    // disponivel em propriedades do ACBrECF

    Indice := StrToIntDef(Registrador,0) ;
    if (Indice < 1) or (Indice > 578) then
      raise Exception.create( 'Não existe nenhum Informação com o Registrador: '+Registrador+'('+IntToStr(Indice)+')') ;

    Registrador := IntToStrZero(Indice, 3);
    Result := EnviaComando( FS + 'R' + #200 + Registrador);
    Result  :=  Trim(LimpaStr(Copy(Result, 6, Length(Result) - 6)));
  end;
end;

procedure TACBrECFDaruma.CortaPapel(const CorteParcial: Boolean);
  Var RetCmd : AnsiString ;
begin
  if not fpMFD then
     inherited CortaPapel
  else
   begin
     // Daruma TRAVA se enviarmos o comando de guilhotina e ela não existir //
     RetCmd := RetornaInfoECF('113');
   
     if (RetCmd = '1') and (fsModeloDaruma <> fs700L) then    // Tem Guilhotina ? // verifico se o modelo permite o acionamento da guilhotina
       EnviaComando( FS + 'N' + #202 )
     else
       inherited CortaPapel ;
   end ;
end;

procedure TACBrECFDaruma.Sangria(const Valor: Double; Obs: AnsiString;
  DescricaoCNF, DescricaoFPG: String);
begin
  if fpMFD then
     EnviaComando( FS + 'F' + #227 + IntToStrZero(Round(Valor * 100), 11) +
                   LeftStr(Obs,619) + FF )
  else
     Inherited Sangria(Valor, Obs, DescricaoCNF, DescricaoFPG);
end;

procedure TACBrECFDaruma.Suprimento(const Valor: Double; Obs: AnsiString;
  DescricaoCNF, DescricaoFPG: String);
begin
  if fpMFD then
     EnviaComando( FS + 'F' + #236 + IntToStrZero(Round(Valor * 100), 11) +
                   LeftStr(Obs,619) + FF )
  else
     Inherited Suprimento(Valor, Obs, DescricaoCNF, DescricaoFPG);
end;

procedure TACBrECFDaruma.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  with TACBrECF(fpOwner) do
  begin
     AbreNaoFiscal ;
     try
        RegistraItemNaoFiscal(CodCNF, Valor);
        try
           SubtotalizaNaoFiscal(0);
           EfetuaPagamentoNaoFiscal(CodFormaPagto, Valor );
        except
        end ;
        FechaNaoFiscal( Obs, IndiceBMP );
     except
        try
           CancelaNaoFiscal
        except
        end;

        raise ;
     end ;
  end ;
end;

procedure TACBrECFDaruma.ComutaOnLine;
begin
  if fpMFD then
     EnviaComando(GS + BS {+ BELL});
end;

function TACBrECFDaruma.DecodificaTexto(Operacao: Char; Texto: String;
  var Resposta: String): Boolean;
Var
  RetCmd : AnsiString ;
begin
   Result := False;
   if (fpMFD) then
   begin
      if ( (fsModeloDaruma in [fs600, fs600USB]) and (StrToInt(fsNumVersao) > 10400) ) or
         ( (fsModeloDaruma in [fs700L, fs700H, fs700M]) and (StrToInt(fsNumVersao) > 10000) ) then
       begin
         RetCmd   := EnviaComando(FS + 'F' + #244 + Operacao + Texto + FF, 10);
         Resposta := copy(RetCmd, 10, Length(RetCmd) - 12);
         Result   := True;
         if (Operacao = 'V') then
            if Resposta = '0' then
               Result := False;
       end
      else
         raise Exception.Create( 'Versão do Firmeware da Impressora não suporta este comando ! ' );
   end
   else
      raise Exception.Create( 'A  Impressora não suporta este comando ! ' );
end;


end.


