{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010   Isaque Pinheiro                      }
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
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 14/12/2010: Isaque Pinheiro e Paulo Junqueira
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_D_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEPCBloco_D, ACBrEPCBlocos,
     ACBrTXTClass;

type
  /// TBloco_D -

  { TBloco_D }

  TBloco_D = class(TACBrSPED)
  private
    FRegistroD001: TRegistroD001;      /// BLOCO D - RegistroD001
    FRegistroD990: TRegistroD990;      /// BLOCO D - RegistroD990

    FRegistroD010Count: integer;
    FRegistroD100Count: integer;
    FRegistroD101Count: integer;
    FRegistroD105Count: integer;
    FRegistroD111Count: integer;
    FRegistroD200Count: integer;
    FRegistroD201Count: integer;
    FRegistroD205Count: integer;
    FRegistroD209Count: integer;
    FRegistroD300Count: integer;
    FRegistroD309Count: integer;
    FRegistroD350Count: integer;
    FRegistroD359Count: integer;
    FRegistroD500Count: integer;
    FRegistroD501Count: integer;
    FRegistroD505Count: integer;
    FRegistroD509Count: integer;
    FRegistroD600Count: integer;
    FRegistroD601Count: integer;
    FRegistroD605Count: integer;
    FRegistroD609Count: integer;

    procedure WriteRegistroD010(RegD001: TRegistroD001);
    procedure WriteRegistroD100(RegD010: TRegistroD010);
    procedure WriteRegistroD101(RegD100: TRegistroD100);
    procedure WriteRegistroD105(RegD100: TRegistroD100);
    procedure WriteRegistroD111(RegD100: TRegistroD100);
    procedure WriteRegistroD200(RegD010: TRegistroD010);
    procedure WriteRegistroD201(RegD200: TRegistroD200);
    procedure WriteRegistroD205(RegD200: TRegistroD200);
    procedure WriteRegistroD209(RegD200: TRegistroD200);
    procedure WriteRegistroD300(RegD010: TRegistroD010);
    procedure WriteRegistroD309(RegD300: TRegistroD300);
    procedure WriteRegistroD350(RegD010: TRegistroD010);
    procedure WriteRegistroD359(RegD350: TRegistroD350);
    procedure WriteRegistroD500(RegD010: TRegistroD010);
    procedure WriteRegistroD501(RegD500: TRegistroD500);
    procedure WriteRegistroD505(RegD500: TRegistroD500);
    procedure WriteRegistroD509(RegD500: TRegistroD500);
    procedure WriteRegistroD600(RegD010: TRegistroD010);
    procedure WriteRegistroD601(RegD600: TRegistroD600);
    procedure WriteRegistroD605(RegD600: TRegistroD600);
    procedure WriteRegistroD609(RegD600: TRegistroD600);

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create ;          /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function RegistroD001New: TRegistroD001;
    function RegistroD010New: TRegistroD010;
    function RegistroD100New: TRegistroD100;
    function RegistroD101New: TRegistroD101;
    function RegistroD105New: TRegistroD105;
    function RegistroD111New: TRegistroD111;
    function RegistroD200New: TRegistroD200;
    function RegistroD201New: TRegistroD201;
    function RegistroD205New: TRegistroD205;
    function RegistroD209New: TRegistroD209;
    function RegistroD300New: TRegistroD300;
    function RegistroD309New: TRegistroD309;
    function RegistroD350New: TRegistroD350;
    function RegistroD359New: TRegistroD359;
    function RegistroD500New: TRegistroD500;
    function RegistroD501New: TRegistroD501;
    function RegistroD505New: TRegistroD505;
    function RegistroD509New: TRegistroD509;
    function RegistroD600New: TRegistroD600;
    function RegistroD601New: TRegistroD601;
    function RegistroD605New: TRegistroD605;
    function RegistroD609New: TRegistroD609;

    procedure WriteRegistroD001;
    procedure WriteRegistroD990;

    property RegistroD001: TRegistroD001 read FRegistroD001 write FRegistroD001;
    property RegistroD990: TRegistroD990 read FRegistroD990 write FRegistroD990;

    property RegistroD010Count: integer read FRegistroD010Count write FRegistroD010Count;
    property RegistroD100Count: integer read FRegistroD100Count write FRegistroD100Count;
    property RegistroD101Count: integer read FRegistroD101Count write FRegistroD101Count;
    property RegistroD105Count: integer read FRegistroD105Count write FRegistroD105Count;
    property RegistroD111Count: integer read FRegistroD111Count write FRegistroD111Count;
    property RegistroD200Count: integer read FRegistroD200Count write FRegistroD200Count;
    property RegistroD201Count: integer read FRegistroD201Count write FRegistroD201Count;
    property RegistroD205Count: integer read FRegistroD205Count write FRegistroD205Count;
    property RegistroD209Count: integer read FRegistroD209Count write FRegistroD209Count;
    property RegistroD300Count: integer read FRegistroD300Count write FRegistroD300Count;
    property RegistroD309Count: integer read FRegistroD309Count write FRegistroD309Count;
    property RegistroD350Count: integer read FRegistroD350Count write FRegistroD350Count;
    property RegistroD359Count: integer read FRegistroD359Count write FRegistroD359Count;
    property RegistroD500Count: integer read FRegistroD500Count write FRegistroD500Count;
    property RegistroD501Count: integer read FRegistroD501Count write FRegistroD501Count;
    property RegistroD505Count: integer read FRegistroD505Count write FRegistroD505Count;
    property RegistroD509Count: integer read FRegistroD509Count write FRegistroD509Count;
    property RegistroD600Count: integer read FRegistroD600Count write FRegistroD600Count;
    property RegistroD601Count: integer read FRegistroD601Count write FRegistroD601Count;
    property RegistroD605Count: integer read FRegistroD605Count write FRegistroD605Count;
    property RegistroD609Count: integer read FRegistroD609Count write FRegistroD609Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_D }

constructor TBloco_D.Create;
begin
  inherited ;
  CriaRegistros;
end;

destructor TBloco_D.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_D.CriaRegistros;
begin
  FRegistroD001 := TRegistroD001.Create;
  FRegistroD990 := TRegistroD990.Create;

  FRegistroD010Count := 0;
  FRegistroD100Count := 0;
  FRegistroD101Count := 0;
  FRegistroD105Count := 0;
  FRegistroD111Count := 0;
  FRegistroD200Count := 0;
  FRegistroD201Count := 0;
  FRegistroD205Count := 0;
  FRegistroD209Count := 0;
  FRegistroD300Count := 0;
  FRegistroD309Count := 0;
  FRegistroD350Count := 0;
  FRegistroD359Count := 0;
  FRegistroD500Count := 0;
  FRegistroD501Count := 0;
  FRegistroD505Count := 0;
  FRegistroD509Count := 0;
  FRegistroD600Count := 0;
  FRegistroD601Count := 0;
  FRegistroD605Count := 0;
  FRegistroD609Count := 0;

  FRegistroD990.QTD_LIN_D := 0;
end;

procedure TBloco_D.LiberaRegistros;
begin
  FRegistroD001.Free;
  FRegistroD990.Free;
end;

procedure TBloco_D.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  Conteudo.Clear;

  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_D.RegistroD001New: TRegistroD001;
begin
   Result := FRegistroD001;
end;

function TBloco_D.RegistroD010New: TRegistroD010;
begin
   Result := FRegistroD001.RegistroD010.New;
end;

function TBloco_D.RegistroD100New: TRegistroD100;
var
D010Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.New;
end;

function TBloco_D.RegistroD101New: TRegistroD101;
var
D010Count: integer;
D100Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D100Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.Items[D100Count].RegistroD101.New;
end;

function TBloco_D.RegistroD105New: TRegistroD105;
var
D010Count: integer;
D100Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D100Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.Items[D100Count].RegistroD105.New;
end;

function TBloco_D.RegistroD111New: TRegistroD111;
var
D010Count: integer;
D100Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D100Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD100.Items[D100Count].RegistroD111.New;
end;

function TBloco_D.RegistroD200New: TRegistroD200;
var
D010Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.New;
end;

function TBloco_D.RegistroD201New: TRegistroD201;
var
D010Count: integer;
D200Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D200Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.Items[D200Count].RegistroD201.New;
end;

function TBloco_D.RegistroD205New: TRegistroD205;
var
D010Count: integer;
D200Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D200Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.Items[D200Count].RegistroD205.New;
end;

function TBloco_D.RegistroD209New: TRegistroD209;
var
D010Count: integer;
D200Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D200Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD200.Items[D200Count].RegistroD209.New;
end;

function TBloco_D.RegistroD300New: TRegistroD300;
var
D010Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD300.New;
end;

function TBloco_D.RegistroD309New: TRegistroD309;
var
D010Count: integer;
D300Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D300Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD300.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD300.Items[D300Count].RegistroD309.New;
end;

function TBloco_D.RegistroD350New: TRegistroD350;
var
D010Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD350.New;
end;

function TBloco_D.RegistroD359New: TRegistroD359;
var
D010Count: integer;
D350Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D350Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD350.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD350.Items[D350Count].RegistroD359.New;
end;

function TBloco_D.RegistroD500New: TRegistroD500;
var
D010Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.New;
end;

function TBloco_D.RegistroD501New: TRegistroD501;
var
D010Count: integer;
D500Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D500Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.Items[D500Count].RegistroD501.New;
end;

function TBloco_D.RegistroD505New: TRegistroD505;
var
D010Count: integer;
D500Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D500Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.Items[D500Count].RegistroD505.New;
end;

function TBloco_D.RegistroD509New: TRegistroD509;
var
D010Count: integer;
D500Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D500Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD500.Items[D500Count].RegistroD509.New;
end;

function TBloco_D.RegistroD600New: TRegistroD600;
var
D010Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.New;
end;

function TBloco_D.RegistroD601New: TRegistroD601;
var
D010Count: integer;
D600Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D600Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.Items[D600Count].RegistroD601.New;
end;

function TBloco_D.RegistroD605New: TRegistroD605;
var
D010Count: integer;
D600Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D600Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.Items[D600Count].RegistroD605.New;
end;

function TBloco_D.RegistroD609New: TRegistroD609;
var
D010Count: integer;
D600Count: integer;
begin
   D010Count := FRegistroD001.RegistroD010.Count -1;
   D600Count := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.Count -1;
   //
   Result := FRegistroD001.RegistroD010.Items[D010Count].RegistroD600.Items[D600Count].RegistroD609.New;
end;

procedure TBloco_D.WriteRegistroD001 ;
begin
  if Assigned(FRegistroD001) then
  begin
     with FRegistroD001 do
     begin
        Add( LFill( 'D001' ) +
             LFill( Integer(IND_MOV), 0 ) ) ;

        if IND_MOV = imComDados then
        begin
          WriteRegistroD010(FRegistroD001) ;
        end;
     end;

     RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
  end;
end;

procedure TBloco_D.WriteRegistroD010(RegD001: TRegistroD001) ;
var
intFor: Integer;
begin
  if Assigned(RegD001.RegistroD010) then
  begin
    for intFor := 0 to RegD001.RegistroD010.Count - 1 do
    begin
      with RegD001.RegistroD010.Items[intFor] do
      begin
        Check(funChecaCNPJ(CNPJ), '(0-010) ESTABELECIMENTO: O CNPJ "%s" digitado é inválido!', [CNPJ]);

        Add( LFill('D010') +
             LFill(CNPJ, 14) ) ;
      end;

      // Registros FILHOS
      WriteRegistroD100( RegD001.RegistroD010.Items[intFor] );
      WriteRegistroD200( RegD001.RegistroD010.Items[intFor] );
      WriteRegistroD300( RegD001.RegistroD010.Items[intFor] );
      WriteRegistroD350( RegD001.RegistroD010.Items[intFor] );
      WriteRegistroD500( RegD001.RegistroD010.Items[intFor] );
      WriteRegistroD600( RegD001.RegistroD010.Items[intFor] );
      //
      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    // Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD010Count := FRegistroD010Count + RegD001.RegistroD010.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD100(RegD010: TRegistroD010) ;
var
intFor: integer;
strIND_OPER : AnsiString;
strIND_EMIT : AnsiString;
strCOD_SIT  : AnsiString;
strCOD_MOD  : AnsiString;
strIND_FRT  : AnsiString;
begin
  if Assigned(RegD010.RegistroD100) then
  begin
     for intFor := 0 to RegD010.RegistroD100.Count - 1 do
     begin
        with RegD010.RegistroD100.Items[intFor] do
        begin
          case IND_OPER of
            itoContratado : strIND_OPER := '0';
            itoPrestado   : strIND_OPER := '1';
          end;
          case IND_EMIT of
            iedfProprio  : strIND_EMIT := '0';
            iedfTerceiro : strIND_EMIT := '1';
          end;
          case COD_SIT of
            sdfRegular         : strCOD_SIT := '00';
            sdfExtRegular      : strCOD_SIT := '01';
            sdfCancelado       : strCOD_SIT := '02';
            sdfExtCancelado    : strCOD_SIT := '03';
            sdfComplementar    : strCOD_SIT := '06';
            sdfExtComplementar : strCOD_SIT := '07';
            sdfInutilizado     : strCOD_SIT := '08';
          end;
          case COD_MOD of
            dfiNFSTransporte           : strCOD_MOD := '07';
            dfiConhecimentoRodoviario  : strCOD_MOD := '08';
            dfiConhecimentoAvulso      : strCOD_MOD := '8B';
            dfiConhecimentoAquaviario  : strCOD_MOD := '09';
            dfiConhecimentoAereo       : strCOD_MOD := '10';
            dfiConhecimentoFerroviario : strCOD_MOD := '11';
            dfiConhecimentoMultimodal  : strCOD_MOD := '26';
            dfiNFTranspFerro           : strCOD_MOD := '27';
            dfiCTE                     : strCOD_MOD := '57';
          end;
          case IND_FRT of
            tfPorContaTerceiros : strIND_FRT := '0';
            tfPorContaEmitente : strIND_FRT := '1';
            tfPorContaDestinatario : strIND_FRT := '2';
            tfSemCobrancaFrete : strIND_FRT := '9';
            tfNenhum : strIND_FRT := '';
          end;

          Add( LFill('D100') +
               LFill( strIND_OPER ) +
               LFill( strIND_EMIT ) +
               LFill( COD_PART ) +
               LFill( strCOD_MOD ) +
               LFill( strCOD_SIT ) +
               LFill( SER ) +
               LFill( SUB ) +
               LFill( NUM_DOC ) +
               LFill( CHV_CTE ) +
               LFill( DT_DOC ) +
               LFill( DT_A_P ) +
               LFill( TP_CTe ) +
               LFill( CHV_CTE_REF ) +
               LFill( VL_DOC,0,2 ) +
               LFill( VL_DESC,0,2 ) +
               LFill( strIND_FRT ) +
               LFill( VL_SERV,0,2 ) +
               LFill( VL_BC_ICMS,0,2 ) +
               LFill( VL_ICMS,0,2 ) +
               LFill( VL_NT,0,2 ) +
               LFill( COD_INF ) +
               LFill( COD_CTA ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroD101( RegD010.RegistroD100.Items[intFor] );
        WriteRegistroD105( RegD010.RegistroD100.Items[intFor] );
        WriteRegistroD111( RegD010.RegistroD100.Items[intFor] );
        ///
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD100Count := FRegistroD100Count + RegD010.RegistroD100.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD101(RegD100: TRegistroD100) ;
var
intFor: integer;
strIND_NAT_FRT : AnsiString;
begin
  if Assigned(RegD010.RegistroD101) then
  begin
    for intFor := 0 to RegD010.RegistroD100.Count - 1 do
    begin
      with RegD100.RegistroD101.Items[intFor] do
      begin
        case IND_EMIT of
          nfNegociavel    : strIND_NAT_FRT := '0';
          nfNaoNegociavel : strIND_NAT_FRT := '1';
        end;
        Add( LFill('D101') +
             LFill( strIND_NAT_FRT ) + //Verificar se essa opção é a mesma que já existia no ACBrEPCBlocos e se devo completar
             LFill( VL_ITEM,0,2 ) +
             LFill( CST_PIS ) +
             LFill( NAT_BC_CRED ) + //Verificar criação da tabela no ACBrEPCBlocos
             LFill( VL_BC_PIS,0,2 ) +
             LFill( ALIQ_PIS,0,2 ) +
             LFill( VL_PIS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD101Count := FRegistroD101Count + RegD100.RegistroD101.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD105(RegD100: TRegistroD100) ;
var
intFor: integer;
strIND_NAT_FRT : AnsiString;
begin
  if Assigned(RegD010.RegistroD105) then
  begin
    for intFor := 0 to RegD010.RegistroD100.Count - 1 do
    begin
      with RegD100.RegistroD105.Items[intFor] do
      begin
        case IND_EMIT of
          nfNegociavel    : strIND_NAT_FRT := '0';
          nfNaoNegociavel : strIND_NAT_FRT := '1';
        end;
        Add( LFill('D105') +
             LFill( strIND_NAT_FRT ) + //Verificar se essa opção é a mesma que já existia no ACBrEPCBlocos e se devo completar
             LFill( VL_ITEM,0,2 ) +
             LFill( CST_COFINS ) +
             LFill( NAT_BC_CRED ) + //Verificar criação da tabela no ACBrEPCBlocos
             LFill( VL_BC_COFINS,0,2 ) +
             LFill( ALIQ_COFINS,0,2 ) +
             LFill( VL_COFINS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD105Count := FRegistroD105Count + RegD100.RegistroD105.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD111(RegD100: TRegistroD100) ;
var
intFor: integer;
strIND_PROC : AnsiString;
begin
  if Assigned(RegD100.RegistroD111) then
  begin
    for intFor := 0 to RegD100.RegistroD111.Count - 1 do
    begin
      with RegD100.RegistroD111.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('D111') +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD111Count := FRegistroD111Count + RegD100.RegistroD111.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD200(RegD010: TRegistroD010) ;
var
intFor: integer;
strCOD_MOD  : AnsiString;
strCOD_SIT  : AnsiString;
begin
  if Assigned(RegD010.RegistroD200) then
  begin
     for intFor := 0 to RegD010.RegistroD200.Count - 1 do
     begin
        with RegD010.RegistroD200.Items[intFor] do
        begin
          case COD_MOD of
            dfiNFSTransporte           : strCOD_MOD := '07';
            dfiConhecimentoRodoviario  : strCOD_MOD := '08';
            dfiConhecimentoAvulso      : strCOD_MOD := '8B';
            dfiConhecimentoAquaviario  : strCOD_MOD := '09';
            dfiConhecimentoAereo       : strCOD_MOD := '10';
            dfiConhecimentoFerroviario : strCOD_MOD := '11';
            dfiConhecimentoMultimodal  : strCOD_MOD := '26';
            dfiNFTranspFerro           : strCOD_MOD := '27';
            dfiCTE                     : strCOD_MOD := '57';
          end;
          case COD_SIT of
            sdfRegular         : strCOD_SIT := '00';
            sdfExtRegular      : strCOD_SIT := '01';
            sdfComplementar    : strCOD_SIT := '06';
            sdfExtComplementar : strCOD_SIT := '07';
            sdfInutilizado     : strCOD_SIT := '08';
          end;

          Add( LFill('D200') +
               LFill( strCOD_MOD ) +
               LFill( strCOD_SIT ) +
               LFill( SER ) +
               LFill( SUB ) +
               LFill( NUM_DOC_INI ) +
               LFill( NUM_DOC_FIN ) +
               LFill( CFOP ) +
               LFill( DT_REF ) +
               LFill( VL_DOC,0,2 ) +
               LFill( VL_DESC,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroD201( RegD010.RegistroD200.Items[intFor] );
        WriteRegistroD205( RegD010.RegistroD200.Items[intFor] );
        WriteRegistroD209( RegD010.RegistroD200.Items[intFor] );
        ///
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD200Count := FRegistroD200Count + RegD010.RegistroD200.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD201(RegD200: TRegistroD200) ;
var
intFor: integer;
begin
  if Assigned(RegD010.RegistroD201) then
  begin
    for intFor := 0 to RegD010.RegistroD200.Count - 1 do
    begin
      with RegD200.RegistroD201.Items[intFor] do
      begin
        Add( LFill('D201') +
             LFill( CST_PIS ) +
             LFill( VL_ITEM,0,2 ) +
             LFill( VL_BC_PIS,0,2 ) +
             LFill( ALIQ_PIS,0,2 ) +
             LFill( VL_PIS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD201Count := FRegistroD201Count + RegD200.RegistroD201.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD205(RegD200: TRegistroD200) ;
var
intFor: integer;
begin
  if Assigned(RegD010.RegistroD205) then
  begin
    for intFor := 0 to RegD010.RegistroD200.Count - 1 do
    begin
      with RegD200.RegistroD205.Items[intFor] do
      begin
        Add( LFill('D205') +
             LFill( CST_COFINS ) +
             LFill( VL_ITEM,0,2 ) +
             LFill( VL_BC_COFINS,0,2 ) +
             LFill( ALIQ_COFINS,0,2 ) +
             LFill( VL_COFINS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD205Count := FRegistroD205Count + RegD200.RegistroD205.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD209(RegD200: TRegistroD200) ;
var
intFor: integer;
strIND_PROC : AnsiString;
begin
  if Assigned(RegD200.RegistroD209) then
  begin
    for intFor := 0 to RegD200.RegistroD209.Count - 1 do
    begin
      with RegD200.RegistroD209.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('D209') +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD209Count := FRegistroD209Count + RegD200.RegistroD209.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD300(RegD010: TRegistroD010) ;
var
intFor: integer;
strCOD_MOD  : AnsiString;
begin
  if Assigned(RegD010.RegistroD300) then
  begin
     for intFor := 0 to RegD010.RegistroD300.Count - 1 do
     begin
        with RegD010.RegistroD300.Items[intFor] do
        begin
          case COD_MOD of
            dfiBilheteRedoviario       : strCOD_MOD := '13';
            dfiBilheteAquaviario       : strCOD_MOD := '14';
            dfiBilheteBagagem          : strCOD_MOD := '15';
            dfiBilheteFerroviario      : strCOD_MOD := '16';
            dfiResumoMovimento         : strCOD_MOD := '18';
          end;

          Add( LFill('D300') +
               LFill( strCOD_MOD ) +
               LFill( SER ) +
               LFill( SUB ) +
               LFill( NUM_DOC_INI ) +
               LFill( NUM_DOC_FIN ) +
               LFill( CFOP ) +
               LFill( DT_REF ) +
               LFill( VL_DOC,0,2 ) +
               LFill( VL_DESC,0,2 ) +
               LFill( CST_PIS ) +
               LFill( VL_BC_PIS,0,2 ) +
               LFill( ALIQ_PIS,0,2 ) +
               LFill( VL_PIS,0,2 ) +
               LFill( CST_COFINS ) +
               LFill( VL_BC_COFINS,0,2 ) +
               LFill( ALIQ_COFINS,0,2 ) +
               LFill( VL_COFINS,0,2 ) +
               LFill(COD_CTA) ) ;
        end;

        // Registros FILHOS
        WriteRegistroD309( RegD010.RegistroD300.Items[intFor] );
        ///
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD300Count := FRegistroD300Count + RegD010.RegistroD300.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD309(RegD300: TRegistroD300) ;
var
intFor: integer;
strIND_PROC : AnsiString;
begin
  if Assigned(RegD300.RegistroD309) then
  begin
    for intFor := 0 to RegD300.RegistroD309.Count - 1 do
    begin
      with RegD300.RegistroD309.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('D309') +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD309Count := FRegistroD309Count + RegD300.RegistroD309.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD350(RegD010: TRegistroD010) ;
var
intFor: integer;
strCOD_MOD  : AnsiString;
begin
  if Assigned(RegD010.RegistroD350) then
  begin
     for intFor := 0 to RegD010.RegistroD350.Count - 1 do
     begin
        with RegD010.RegistroD350.Items[intFor] do
        begin
          case COD_MOD of
            dfiCFBilhete               : strCOD_MOD := '2E';
            dfiBilheteRedoviario       : strCOD_MOD := '13';
            dfiBilheteAquaviario       : strCOD_MOD := '14';
            dfiBilheteBagagem          : strCOD_MOD := '15';
            dfiBilheteFerroviario      : strCOD_MOD := '16';
          end;

          Add( LFill('D350') +
               LFill( strCOD_MOD ) +
               LFill( ECF_MOD ) +
               LFill( ECF_FAB ) +
               LFill( DT_DOC ) +
               LFill( CRO ) +
               LFill( CRZ ) +
               LFill( NUM_COO_FIN ) +
               LFill( GT_FIN ) +
               LFill( VL_BRT,0,2 ) +
               LFill( CST_PIS ) +
               LFill( VL_BC_PIS,0,2 ) +
               LFill( ALIQ_PIS,0,4 ) +
               LFill( QUANT_BC_PIS,0,3 ) +
               LFill( ALIQ_PIS_QUANT,0,4 ) +
               LFill( VL_PIS,0,2 ) +
               LFill( CST_COFINS ) +
               LFill( VL_BC_COFINS,0,2 ) +
               LFill( ALIQ_COFINS,0,4 ) +
               LFill( QUANT_BC_COFINS,0,3 ) +
               LFill( ALIQ_COFINS_QUANT,0,4 ) +
               LFill( VL_COFINS,0,2 ) +
               LFill(COD_CTA) ) ;
        end;

        // Registros FILHOS
        WriteRegistroD359( RegD010.RegistroD350.Items[intFor] );
        ///
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD350Count := FRegistroD350Count + RegD010.RegistroD350.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD359(RegD350: TRegistroD350) ;
var
intFor: integer;
strIND_PROC : AnsiString;
begin
  if Assigned(RegD350.RegistroD359) then
  begin
    for intFor := 0 to RegD350.RegistroD359.Count - 1 do
    begin
      with RegD350.RegistroD359.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('D359') +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD359Count := FRegistroD359Count + RegD350.RegistroD359.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD500(RegD010: TRegistroD010) ;
var
intFor: integer;
strIND_OPER : AnsiString;
strIND_EMIT : AnsiString;
strCOD_MOD  : AnsiString;
strCOD_SIT  : AnsiString;
begin
  if Assigned(RegD010.RegistroD500) then
  begin
     for intFor := 0 to RegD010.RegistroD500.Count - 1 do
     begin
        with RegD010.RegistroD500.Items[intFor] do
        begin
          case IND_OPER of
            itoContratado : strIND_OPER := '0';
            itoPrestado   : strIND_OPER := '1';
          end;
          case IND_EMIT of
            iedfProprio  : strIND_EMIT := '0';
            iedfTerceiro : strIND_EMIT := '1';
          end;
          case COD_MOD of
            dfiNFSComunicacao          : strCOD_MOD := '21';
            dfiNFSTelecomunicacao      : strCOD_MOD := '22';
          end;
          case COD_SIT of
            sdfRegular         : strCOD_SIT := '00';
            sdfExtRegular      : strCOD_SIT := '01';
            sdfCancelado       : strCOD_SIT := '02';
            sdfExtCancelado    : strCOD_SIT := '03';
            sdfComplementar    : strCOD_SIT := '06';
            sdfExtComplementar : strCOD_SIT := '07';
            sdfInutilizado     : strCOD_SIT := '08';
          end;

          Add( LFill('D500') +
               LFill( strIND_OPER ) +
               LFill( strIND_EMIT ) +
               LFill( COD_PART ) +
               LFill( strCOD_MOD ) +
               LFill( strCOD_SIT ) +
               LFill( SER ) +
               LFill( SUB ) +
               LFill( NUM_DOC ) +
               LFill( DT_DOC ) +
               LFill( DT_A_P ) +
               LFill( VL_DOC,0,2 ) +
               LFill( VL_DESC,0,2 ) +
               LFill( VL_SERV,0,2 ) +
               LFill( VL_SERV_NT,0,2 ) +
               LFill( VL_TERC,0,2 ) +
               LFill( VL_DA,0,2 ) +
               LFill( VL_BC_ICMS,0,2 ) +
               LFill( VL_ICMS,0,2 ) +
               LFill( COD_INF ) +
               LFill( VL_PIS,0,2 ) +
               LFill( VL_COFINS,0,2 ) );
        end;

        // Registros FILHOS
        WriteRegistroD501( RegD010.RegistroD500.Items[intFor] );
        WriteRegistroD505( RegD010.RegistroD500.Items[intFor] );
        WriteRegistroD509( RegD010.RegistroD500.Items[intFor] );
        ///
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD500Count := FRegistroD500Count + RegD010.RegistroD500.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD501(RegD500: TRegistroD500) ;
var
intFor: integer;
strIND_NAT_FRT : AnsiString;
begin
  if Assigned(RegD010.RegistroD501) then
  begin
    for intFor := 0 to RegD010.RegistroD500.Count - 1 do
    begin
      with RegD500.RegistroD501.Items[intFor] do
      begin
        case IND_EMIT of
          nfNegociavel    : strIND_NAT_FRT := '0';
          nfNaoNegociavel : strIND_NAT_FRT := '1';
        end;
        Add( LFill('D501') +
             LFill( CST_PIS ) +
             LFill( VL_ITEM,0,2 ) +
             LFill( NAT_BC_CRED ) + //Verificar criação da tabela no ACBrEPCBlocos
             LFill( VL_BC_PIS,0,2 ) +
             LFill( ALIQ_PIS,0,2 ) +
             LFill( VL_PIS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD501Count := FRegistroD501Count + RegD500.RegistroD501.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD505(RegD500: TRegistroD500) ;
var
intFor: integer;
strIND_NAT_FRT : AnsiString;
begin
  if Assigned(RegD010.RegistroD505) then
  begin
    for intFor := 0 to RegD010.RegistroD500.Count - 1 do
    begin
      with RegD500.RegistroD505.Items[intFor] do
      begin
        case IND_EMIT of
          nfNegociavel    : strIND_NAT_FRT := '0';
          nfNaoNegociavel : strIND_NAT_FRT := '1';
        end;
        Add( LFill('D505') +
             LFill( CST_COFINS ) +
             LFill( VL_ITEM,0,2 ) +
             LFill( NAT_BC_CRED ) + //Verificar criação da tabela no ACBrEPCBlocos
             LFill( VL_BC_COFINS,0,2 ) +
             LFill( ALIQ_COFINS,0,2 ) +
             LFill( VL_COFINS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD505Count := FRegistroD505Count + RegD500.RegistroD505.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD509(RegD500: TRegistroD500) ;
var
intFor: integer;
strIND_PROC : AnsiString;
begin
  if Assigned(RegD500.RegistroD509) then
  begin
    for intFor := 0 to RegD500.RegistroD509.Count - 1 do
    begin
      with RegD500.RegistroD509.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('D509') +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD509Count := FRegistroD509Count + RegD500.RegistroD509.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD600(RegD010: TRegistroD010) ;
var
intFor: integer;
strCOD_MOD  : AnsiString;
begin
  if Assigned(RegD010.RegistroD600) then
  begin
     for intFor := 0 to RegD010.RegistroD600.Count - 1 do
     begin
        with RegD010.RegistroD600.Items[intFor] do
        begin
          case COD_MOD of
            dfiNFSComunicacao          : strCOD_MOD := '21';
            dfiNFSTelecomunicacao      : strCOD_MOD := '22';
          end;

          Add( LFill('D600') +
               LFill( strCOD_MOD ) + 
               LFill( COD_MUN ) +
               LFill( SER ) +
               LFill( SUB ) +
               LFill( IND_REC ) + //Verificar se cria tabela no ACBrEPCBlocos
               LFill( QTD_COFINS ) +
               LFill( DT_DOC_INI ) +
               LFill( DT_DOC_FIN ) +
               LFill( VL_DOC,0,2 ) +
               LFill( VL_DESC,0,2 ) +
               LFill( VL_SERV,0,2 ) +
               LFill( VL_SERV_NT,0,2 ) +
               LFill( VL_TERC,0,2 ) +
               LFill( VL_DA,0,2 ) +
               LFill( VL_BC_ICMS,0,2 ) +
               LFill( VL_ICMS,0,2 ) +
               LFill( VL_PIS,0,2 ) +
               LFill( VL_COFINS,0,2 ) );
        end;

        // Registros FILHOS
        WriteRegistroD601( RegD010.RegistroD600.Items[intFor] );
        WriteRegistroD605( RegD010.RegistroD600.Items[intFor] );
        WriteRegistroD609( RegD010.RegistroD600.Items[intFor] );
        ///
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD600Count := FRegistroD600Count + RegD010.RegistroD600.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD601(RegD600: TRegistroD600) ;
var
intFor: integer;
strIND_NAT_FRT : AnsiString;
begin
  if Assigned(RegD010.RegistroD601) then
  begin
    for intFor := 0 to RegD010.RegistroD600.Count - 1 do
    begin
      with RegD600.RegistroD601.Items[intFor] do
      begin
        case IND_EMIT of
          nfNegociavel    : strIND_NAT_FRT := '0';
          nfNaoNegociavel : strIND_NAT_FRT := '1';
        end;
        Add( LFill('D601') +
             LFill( COD_CLASS ) + //Verificar criação da tabela
             LFill( VL_ITEM,0,2 ) +
             LFill( VL_DESC,0,2 ) +
             LFill( CST_PIS ) +
             LFill( VL_BC_PIS,0,2 ) +
             LFill( ALIQ_PIS,0,2 ) +
             LFill( VL_PIS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD601Count := FRegistroD601Count + RegD600.RegistroD601.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD605(RegD600: TRegistroD600) ;
var
intFor: integer;
strIND_NAT_FRT : AnsiString;
begin
  if Assigned(RegD010.RegistroD605) then
  begin
    for intFor := 0 to RegD010.RegistroD600.Count - 1 do
    begin
      with RegD600.RegistroD605.Items[intFor] do
      begin
        case IND_EMIT of
          nfNegociavel    : strIND_NAT_FRT := '0';
          nfNaoNegociavel : strIND_NAT_FRT := '1';
        end;
        Add( LFill('D605') +
             LFill( COD_CLASS ) + //Verificar criação da tabela
             LFill( VL_ITEM,0,2 ) +
             LFill( VL_DESC,0,2 ) +
             LFill( CST_COFINS ) +
             LFill( VL_BC_COFINS,0,2 ) +
             LFill( ALIQ_COFINS,0,2 ) +
             LFill( VL_COFINS,0,2 ) +
             LFill(COD_CTA) ) ;
        //
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
      end;
   end;
   // Variavél para armazenar a quantidade de registro do tipo.
   FRegistroD605Count := FRegistroD605Count + RegD600.RegistroD605.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD609(RegD600: TRegistroD600) ;
var
intFor: integer;
strIND_PROC : AnsiString;
begin
  if Assigned(RegD600.RegistroD609) then
  begin
    for intFor := 0 to RegD600.RegistroD609.Count - 1 do
    begin
      with RegD600.RegistroD609.Items[intFor] do
      begin
        case IND_PROC of
          opJusticaFederal : strIND_PROC := '0';
          opSecexRFB       : strIND_PROC := '1';
          opOutros         : strIND_PROC := '9';
          opNenhum         : strIND_PROC := '';
        end;

        Add( LFill('D609') +
             LFill(NUM_PROC) +
             LFill(strIND_PROC) ) ;
      end;

      RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
    end;
    /// Variavél para armazenar a quantidade de registro do tipo.
    FRegistroD609Count := FRegistroD609Count + RegD600.RegistroD609.Count;
  end;
end;

procedure TBloco_D.WriteRegistroD990 ;
begin
  if Assigned(RegistroD990) then
  begin
     with RegistroD990 do
     begin
       QTD_LIN_D := QTD_LIN_D + 1;
       ///
       Add( LFill('D990') +
            LFill(QTD_LIN_D,0) );
     end;
  end;
end;

end.
