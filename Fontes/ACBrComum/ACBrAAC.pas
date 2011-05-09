{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2011 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Regys silveira                                  }
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
{       Rua Coronel Aureliano de Camargo, 973 - Tatuí - SP - 18270-170         }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrAAC;

interface

uses ACBrBase,
     SysUtils, Classes, Contnrs ;

type
  EACBrAAC                       = class(Exception);
  EACBrAAC_CRC                   = class(EACBrAAC);
  EACBrAAC_ArqNaoEncontrado      = class(EACBrAAC);
  EACBrAAC_SemNomeArquivo        = class(EACBrAAC);
  EACBrAAC_SemChave              = class(EACBrAAC);
  EACBrAAC_SemResposta           = class(EACBrAAC);
  EACBrAAC_ArquivoInvalido       = class(EACBrAAC);
  EACBrAAC_NumSerieNaoEncontrado = class(EACBrAAC);
  EACBrAAC_ValorGTInvalido       = class(EACBrAAC);

  TACBrAACOnCrypt   = procedure( ConteudoArquivo : AnsiString;
     var Resposta : AnsiString ) of object ;
  TACBrAACOnDeCrypt = procedure( ConteudoCriptografado : AnsiString;
     var Resposta : AnsiString ) of object ;
  TACBrAACGetChave = procedure(var Chave: AnsiString) of object ;
  TACBrAACAntesArquivo = procedure( var Continua: Boolean) of object ;

  { TACBrAACECF }

  TACBrAACECF = class
  private
    FCRO : Integer ;
    FDtHrAtualizado : TDateTime ;
    FValorGT: Double;
    FNumeroSerie: String;
    function GetLinhaDados : String ;
    procedure SetLinhaDados(const AValue : String) ;
    procedure SetValorGT(const AValue : Double) ;
  public
    property NumeroSerie    : String    read FNumeroSerie    write FNumeroSerie;
    property CRO            : Integer   read FCRO            write FCRO;
    property ValorGT        : Double    read FValorGT        write SetValorGT;
    property DtHrAtualizado : TDateTime read FDtHrAtualizado write FDtHrAtualizado;

    property LinhaDados : String read GetLinhaDados write SetLinhaDados ;
  end;

  { TACBrAACECFs }

  TACBrAACECFs = class(TObjectList)
  private
    procedure SetObject(Index: Integer; Item: TACBrAACECF);
    function GetObject(Index: Integer): TACBrAACECF;
    procedure Insert(Index: Integer; Obj: TACBrAACECF);
  public
    function New: TACBrAACECF;
    function Add(Obj: TACBrAACECF): Integer;
    property Objects[Index: Integer]: TACBrAACECF read GetObject write SetObject; default;
  end;

  TACBrAAC = class( TACBrComponent )
  private
     fsArqLOG : String ;
     fsCriarBAK : Boolean ;
     fsDtHrArquivo : TDateTime ;
     fsECFsAutorizados : TACBrAACECFs ;
     fsGravarDadosPAF : Boolean ;
     fsGravarDadosSH : Boolean ;
     fsGravarTodosECFs : Boolean ;
     fsNomeArquivoAux : String ;
     fsNomeCompleto : String ;
     fsOnAntesAbrirArquivo : TACBrAACAntesArquivo ;
     fsOnAntesGravarArquivo : TACBrAACAntesArquivo ;
     fsOnCrypt : TACBrAACOnCrypt ;
     fsOnDeCrypt : TACBrAACOnDeCrypt ;
     fsOnDepoisAbrirArquivo : TNotifyEvent ;
     fsOnDepoisGravarArquivo : TNotifyEvent ;
     fsOnGetChave : TACBrAACGetChave ;
     fsPAF_MD5 : String ;
     fsPAF_Nome : String ;
     fsPAF_Versao : String ;
     fsParams : TStringList ;
     fsSH_CNPJ : String ;
     fsSH_IE : String ;
     fsSH_IM : String ;
     fsSH_RazaoSocial : String ;
     function GetChave : AnsiString ;
     procedure SetNomeArquivoAux(const AValue : String) ;
     procedure SetPAF_MD5(const AValue : String) ;
     procedure SetPAF_Nome(const AValue : String) ;
     procedure SetPAF_Versao(const AValue : String) ;
     procedure SetParams(const AValue : TStringList) ;
     procedure SetSH_CNPJ(const AValue : String) ;
     procedure SetSH_IE(const AValue : String) ;
     procedure SetSH_IM(const AValue : String) ;
     procedure SetSH_RazaoSocial(const AValue : String) ;
  protected

     function Criptografar( const Dados: AnsiString ) : AnsiString ;
     function DesCriptografar( const Dados: AnsiString ) : AnsiString ;
     Procedure GravaLog( const AString: AnsiString );
     procedure VerificaReCarregarArquivo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ECFsAutorizados : TACBrAACECFs read fsECFsAutorizados
       write fsECFsAutorizados;
    function AchaECF( const NumSerie : String ) : TACBrAACECF ;
    function AchaIndiceECF(const NumeroSerie: String): Integer;

    property Chave : AnsiString read GetChave ;

    procedure AbrirArquivo;
    procedure SalvarArquivo;

    function VerificarGTECF(const NumeroSerie: String;
      const ValorGT: Double): Integer ;
    procedure AtualizarMD5(const AMD5: String);
    procedure AtualizarValorGT(const NumeroSerie: String;
      const ValorGT: Double);

    property DtHrArquivo : TDateTime read fsDtHrArquivo ;

  published
    property NomeArquivoAux : String  read fsNomeArquivoAux
       write SetNomeArquivoAux ;
    property CriarBAK : Boolean read fsCriarBAK write fsCriarBAK default True;
    property GravarDadosSH  : Boolean read fsGravarDadosSH
       write fsGravarDadosSH default True;
    property GravarDadosPAF : Boolean read fsGravarDadosPAF
       write fsGravarDadosPAF default True;
    property GravarTodosECFs : Boolean read fsGravarTodosECFs
       write fsGravarTodosECFs default True;
    property ArqLOG : String  read fsArqLOG write fsArqLOG ;

    { Dados da Sw.House }
    property SH_RazaoSocial : String read fsSH_RazaoSocial write SetSH_RazaoSocial ;
    property SH_CNPJ        : String read fsSH_CNPJ        write SetSH_CNPJ ;
    property SH_IE          : String read fsSH_IE          write SetSH_IE   ;
    property SH_IM          : String read fsSH_IM          write SetSH_IM   ;

    { Dados do Aplicativo }
    property PAF_Nome   : String read fsPAF_Nome   write SetPAF_Nome ;
    property PAF_Versao : String read fsPAF_Versao write SetPAF_Versao ;
    property PAF_MD5    : String read fsPAF_MD5    write SetPAF_MD5 ;

    property Params : TStringList read fsParams write SetParams ;

    { Eventos }
    property OnCrypt   : TACBrAACOnCrypt   read fsOnCrypt    write fsOnCrypt ;
    property OnDeCrypt : TACBrAACOnDeCrypt read fsOnDeCrypt  write fsOnDeCrypt ;
    property OnGetChave: TACBrAACGetChave  read fsOnGetChave write fsOnGetChave ;
    property OnAntesAbrirArquivo : TACBrAACAntesArquivo read fsOnAntesAbrirArquivo
      write fsOnAntesAbrirArquivo ;
    property OnDepoisAbrirArquivo : TNotifyEvent read fsOnDepoisAbrirArquivo
      write fsOnDepoisAbrirArquivo ;
    property OnAntesGravarArquivo : TACBrAACAntesArquivo read fsOnAntesGravarArquivo
      write fsOnAntesGravarArquivo ;
    property OnDepoisGravarArquivo : TNotifyEvent
      read fsOnDepoisGravarArquivo write fsOnDepoisGravarArquivo ;
  end;

implementation

Uses IniFiles, ACBrUtil, math, 
     {$IFDEF COMPILER6_UP} StrUtils {$ELSE} ACBrD5{$ENDIF} ;

{ TACBrAACECF }

function TACBrAACECF.GetLinhaDados : String ;
begin
  Result := NumeroSerie         + '|' +
            IntToStr(CRO)       + '|' +
            FloatToStr(ValorGT) + '|' +
            DTtoS(DtHrAtualizado) ;
end ;

procedure TACBrAACECF.SetLinhaDados(const AValue : String) ;
var
   SL : TStringList ;
begin
  SL := TStringList.Create;
  try
     SL.Text := StringReplace( AValue, '|', sLineBreak, [rfReplaceAll] ) ;

     if SL.Count < 4 then exit ;

     NumeroSerie    := SL[0] ;
     CRO            := StrToIntDef( SL[1], 0) ;
     ValorGT        := StrToFloatDef( SL[2], 0) ;
     DtHrAtualizado := StoD( SL[3] ) ;
  finally
     SL.Free;
  end ;
end ;

procedure TACBrAACECF.SetValorGT(const AValue : Double) ;
begin
   FValorGT := RoundTo( AValue, -2) ;
end ;

{ TACBrAACECFs }

function TACBrAACECFs.Add(Obj: TACBrAACECF): Integer;
begin
  Result := inherited Add(Obj);
end;

function TACBrAACECFs.GetObject( Index: Integer): TACBrAACECF;
begin
  Result := inherited GetItem(Index) as TACBrAACECF;
end;

procedure TACBrAACECFs.Insert(Index: Integer; Obj: TACBrAACECF);
begin
  inherited Insert(Index, Obj);
end;

function TACBrAACECFs.New : TACBrAACECF;
begin
  Result := TACBrAACECF.Create;
  Add(Result);
end;

procedure TACBrAACECFs.SetObject(Index: Integer; Item: TACBrAACECF);
begin
  inherited SetItem(Index, Item);
end;

{ TACBrAAC }

constructor TACBrAAC.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fsECFsAutorizados := TACBrAACECFs.create(True);
  fsParams          := TStringList.Create;

  fsOnCrypt    := nil ;
  fsOnDeCrypt  := nil ;
  fsOnGetChave := nil ;
  fsOnAntesAbrirArquivo   := nil ;
  fsOnDepoisAbrirArquivo  := nil ;
  fsOnAntesGravarArquivo  := nil ;
  fsOnDepoisGravarArquivo := nil ;

  fsNomeArquivoAux := '' ;
  fsCriarBAK       := True;
  fsGravarDadosSH  := True;
  fsGravarDadosPAF := True;
  fsGravarTodosECFs:= True;
  fsPAF_MD5        := '' ;
  fsPAF_Nome       := '' ;
  fsPAF_Versao     := '' ;
  fsSH_CNPJ        := '' ;
  fsSH_IE          := '' ;
  fsSH_IM          := '' ;
  fsSH_RazaoSocial := '' ;
  fsDtHrArquivo    := 0 ;
end ;

destructor TACBrAAC.Destroy ;
begin
  fsECFsAutorizados.Free;
  fsParams.Free;

  inherited Destroy ;
end ;

function TACBrAAC.AchaECF(const NumSerie : String) : TACBrAACECF ;
Var
  I : Integer ;
begin
  VerificaReCarregarArquivo;

  Result := nil;
  I      := 0 ;
  while (Result = nil) and (I < ECFsAutorizados.Count) do
  begin
    if NumSerie = ECFsAutorizados[I].NumeroSerie then
       Result := ECFsAutorizados[I]
    else
       Inc( I ) ;
  end ;
end ;

procedure TACBrAAC.AbrirArquivo ;
var
  Ini: TMemIniFile;
  SL : TStringList;
  MS : TMemoryStream ;
  I  : Integer ;
  S, R : AnsiString ;
  Linha, Ident : String ;
  AECF : TACBrAACECF ;
  Continua : Boolean ;
  CRC : Word ;
begin
  GravaLog( 'AbrirArquivo');

  Continua := True;
  if Assigned( fsOnAntesAbrirArquivo ) then
     fsOnAntesAbrirArquivo( Continua );

  if not Continua then
  begin
     GravaLog( 'AbrirArquivo abortado' );
     exit;
  end ;

  if NomeArquivoAux = '' then
     raise EACBrAAC_SemNomeArquivo.Create( ACBrStr('Nome do Arquivo não Informado em: ACBrAAC.NomeArquivoAux') ) ;

  if not FileExists( fsNomeCompleto ) then
     raise EACBrAAC_ArqNaoEncontrado.Create(
        ACBrStr( 'Arquivo Auxiliar Criptografado'+sLineBreak+
                 '"'+NomeArquivoAux+'"'+sLineBreak+
                 'não encontrado') );

  fsDtHrArquivo := FileDateToDateTime( FileAge( fsNomeCompleto ) );

  // Lê arquivo de modo binário e transfere para a AnsiString = S //
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile( fsNomeCompleto );
    MS.Position := 0;
    SetLength(S, MS.Size);
    MS.ReadBuffer(PChar(S)^, MS.Size);
  finally
    MS.Free;
  end;

  SL  := TStringList.Create ;
  Ini := TMemIniFile.Create('') ;
  try
     // DEBUG
     // GravaLog('Arquivo Lido: '+sLineBreak+ S );
     R := DesCriptografar( S ) ;
     // DEBUG
     //GravaLog('Arquivo Descriptografado: '+sLineBreak+ R );

     SL.Text := R;
     Ini.SetStrings( SL );

     if GravarDadosSH then
     begin
       SH_RazaoSocial := Ini.ReadString('SH','Nome','');
       SH_CNPJ        := Ini.ReadString('SH','CNPJ','');
       SH_IE          := Ini.ReadString('SH','IE','');
       SH_IM          := Ini.ReadString('SH','IM','');
     end ;

     if GravarDadosPAF then
     begin
       PAF_Nome   := Ini.ReadString('PAF','Nome','');
       PAF_Versao := Ini.ReadString('PAF','Versao','');
     end ;
     PAF_MD5 := Ini.ReadString('PAF','MD5','');

     if GravarDadosPAF and GravarDadosSH then
     begin
       // Verificando o Calculando do CRC //
       CRC := StringCrc16( SH_RazaoSocial + SH_CNPJ + SH_IE + SH_IM +
                           PAF_Nome + PAF_Versao + PAF_MD5 );
       if Ini.ReadInteger('CHK','CRC16',0) <> CRC then
          raise EACBrAAC_ArquivoInvalido.Create(
             ACBrStr('Arquivo: '+NomeArquivoAux+' inválido') );
     end ;

     ECFsAutorizados.Clear;
     I := 0 ;
     while True do
     begin
        Ident := 'ECF_'+IntToStrZero(I,4);
        Linha := Ini.ReadString( 'ECFs', Ident, '*FIM*' );

        if Linha = '*FIM*' then
           break ;

        AECF := TACBrAACECF.Create;
        try
           AECF.LinhaDados := Linha;
           ECFsAutorizados.Add( AECF );
        except
           AECF.Free;
        end ;

        Inc( I ) ;
     end ;

     Params.Clear;
     I := 0 ;
     while True do
     begin
        Ident := 'L_'+IntToStrZero(I,4);
        Linha := Ini.ReadString( 'Params', Ident, '*FIM*' );

        if Linha = '*FIM*' then
           break ;

        Params.Add( Linha );
        Inc( I ) ;
     end ;

     if Assigned( fsOnDepoisAbrirArquivo ) then
        fsOnDepoisAbrirArquivo( Self );

  finally
     Ini.Free ;
     SL.Free;
  end ;
end ;

procedure TACBrAAC.SalvarArquivo ;
var
  Ini: TMemIniFile;
  SL : TStringList;
  I  : Integer ;
  Ident  : String ;
  ArqBak : String ;
  R      : AnsiString ;
  Continua : Boolean ;
  CRC : Word ;
begin
  GravaLog( 'GravarArqRegistro' );

  Continua := True;
  if Assigned( fsOnAntesGravarArquivo ) then
    fsOnAntesGravarArquivo( Continua );

  if not Continua then
  begin
    GravaLog( 'GravarArqRegistro abortado' );
    exit;
  end ;

  if NomeArquivoAux = '' then
    raise EACBrAAC_SemNomeArquivo.Create( ACBrStr('Nome do Arquivo não Informado em: ACBrAAC.NomeArquivoAux') ) ;

  if GravarDadosSH then
  begin
    if (SH_RazaoSocial = '') or (SH_CNPJ = '') then
      raise EACBrAAC_ArquivoInvalido.Create(
         ACBrStr('SH_RazaoSocial e/ou SH_CNPJ não informados') );
  end ;

  if GravarDadosPAF then
  begin
    if (PAF_Nome = '') or (PAF_Versao = '')then
      raise EACBrAAC_ArquivoInvalido.Create(
         ACBrStr('PAF_Nome e/ou PAF_Versao não informados') );
  end ;

  SL  := TStringList.Create ;
  Ini := TMemIniFile.Create( '' ) ;
  try
     if GravarDadosSH then
     begin
       Ini.WriteString('SH','Nome',SH_RazaoSocial);
       Ini.WriteString('SH','CNPJ',SH_CNPJ);
       Ini.WriteString('SH','IE',SH_IE);
       Ini.WriteString('SH','IM',SH_IM);
     end ;

     if GravarDadosPAF then
     begin
       Ini.WriteString('PAF','Nome',PAF_Nome);
       Ini.WriteString('PAF','Versao',PAF_Versao);
     end ;
     Ini.WriteString('PAF','MD5',PAF_MD5);

     For I := 0 to ECFsAutorizados.Count-1 do
     begin
        Ident := 'ECF_'+IntToStrZero(I,4);
        Ini.WriteString( 'ECFs', Ident, ECFsAutorizados[I].LinhaDados );
     end ;

     For I := 0 to Params.Count-1 do
     begin
        Ident := 'L_'+IntToStrZero(I,4);
        Ini.WriteString( 'Params', Ident, Params[I] );
     end ;

     if GravarDadosPAF and GravarDadosSH then
     begin
       // Calculando o CRC //
       CRC := StringCrc16( SH_RazaoSocial + SH_CNPJ + SH_IE + SH_IM +
                           PAF_Nome + PAF_Versao + PAF_MD5 );
       Ini.WriteInteger('CHK','CRC16',CRC);
     end ;

     Ini.GetStrings( SL );

     // DEBUG
     //GravaLog('Arquivo em Memoria: '+sLineBreak+ SL.Text );
     R := Criptografar( SL.Text );
     // DEBUG
     //GravaLog('Arquivo Criptografado: '+sLineBreak+ R );

     if fsCriarBAK then
     begin
        ArqBak := ChangeFileExt( fsNomeCompleto, '.bak');
        DeleteFile( ArqBak );
        RenameFile( fsNomeCompleto, ArqBak );
     end ;

     WriteToTXT( fsNomeCompleto, R, False, False );
     fsDtHrArquivo := FileDateToDateTime( FileAge( fsNomeCompleto ) );

     if Assigned( fsOnDepoisGravarArquivo ) then
        fsOnDepoisGravarArquivo( Self );
  finally
     Ini.Free ;
     SL.Free;
  end ;
end ;

procedure TACBrAAC.VerificaReCarregarArquivo ;
var
   NewDtHrArquivo : TDateTime;
begin
  // Data/Hora do arquivo é diferente ?
  NewDtHrArquivo := FileDateToDateTime( FileAge( fsNomeCompleto ) ) ;

  if fsDtHrArquivo <> NewDtHrArquivo then
     AbrirArquivo ;
end ;

function TACBrAAC.AchaIndiceECF(const NumeroSerie : String ) : Integer ;
Var
  I : Integer ;
begin
  VerificaReCarregarArquivo;

  I := 0 ;
  while (I < ECFsAutorizados.Count) and
        (NumeroSerie <> ECFsAutorizados[I].NumeroSerie) do
    Inc( I ) ;

  if I = ECFsAutorizados.Count then
     Result := -1
  else
     Result := I ;
end ;

function TACBrAAC.VerificarGTECF(const NumeroSerie : String ;
   const ValorGT : Double) : Integer ;
// Retornos:
//   0 = Tudo OK
//  -1 = NumSerie não encontrado
//  -2 = GT não confere
var
   AECF : TACBrAACECF ;
begin
  Result := 0;
  VerificaReCarregarArquivo;

  AECF := AchaECF( NumeroSerie );
  if not Assigned( AECF ) then
     Result := -1
  else
    if AECF.ValorGT <> RoundTo( ValorGT, -2 ) then
       Result := -2;
end ;

procedure TACBrAAC.AtualizarMD5(const AMD5 : String) ;
begin
  GravaLog( 'AtualizarMD5 - De: '+PAF_MD5+' Para: '+AMD5 );

  if fsDtHrArquivo = 0 then
     AbrirArquivo;

  if AMD5 = PAF_MD5 then exit ;

  PAF_MD5 := AMD5;
  SalvarArquivo;
end ;

procedure TACBrAAC.AtualizarValorGT(const NumeroSerie : String ;
   const ValorGT : Double) ;
var
  AECF, NewECF : TACBrAACECF ;
  LogTXT: String;
begin
  LogTXT := 'AtualizarGTECF - NumSerie: '+NumeroSerie ;

  if fsDtHrArquivo = 0 then
     AbrirArquivo;

  AECF := AchaECF( NumeroSerie );
  if not Assigned( AECF ) then
  begin
     LogTXT := LogTXT +' - nao encontrado';
     GravaLog( LogTXT );
     raise EACBrAAC_NumSerieNaoEncontrado.Create( ACBrStr(
        'Erro ao atualivar Valor do G.T.'+sLineBreak+
        ' ECF: '+NumeroSerie+' não encontrado') );
  end ;

  LogTXT := LogTXT + ' - De:' +FormatFloat('###,###,##0.00',AECF.ValorGT)+
                     ' Para:'+FormatFloat('###,###,##0.00',ValorGT) ;
  GravaLog( LogTXT );

  if RoundTo( ValorGT, -2) = AECF.ValorGT then exit ;

  AECF.ValorGT        := ValorGT ;
  AECF.DtHrAtualizado := Now;

  if (not GravarTodosECFs) and (ECFsAutorizados.Count > 1) then
  begin
    NewECF := TACBrAACECF.Create;
    NewECF.NumeroSerie    := AECF.NumeroSerie;
    NewECF.CRO            := AECF.CRO;
    NewECF.DtHrAtualizado := AECF.DtHrAtualizado;

    ECFsAutorizados.Clear;
    ECFsAutorizados.Add( NewECF );
  end ;

  SalvarArquivo;
end ;

procedure TACBrAAC.GravaLog( const AString : AnsiString) ;
begin
  if fsArqLOG = '' then
     exit ;

  try
     WriteToTXT(fsArqLOG, FormatDateTime('dd/mm hh:nn',Now)+' - '+AString, True);
  except
  end ;
end ;

procedure TACBrAAC.SetPAF_MD5(const AValue : String) ;
begin
  fsPAF_MD5 := Trim(LeftStr( AValue, 32));
end ;

function TACBrAAC.GetChave : AnsiString ;
Var
  AChave : AnsiString ;
begin
  AChave := '';
  if Assigned( fsOnGetChave ) then
     fsOnGetChave( AChave );

  if AChave = '' then
     raise EACBrAAC_SemChave.Create(
        ACBrStr('Chave não informada ou Evento ACBrAAC.OnGetChave não programado' ) );

  Result := AChave;
end;

procedure TACBrAAC.SetNomeArquivoAux(const AValue : String) ;
begin
  if fsNomeArquivoAux = AValue then exit ;

  fsNomeArquivoAux := AValue ;

  fsNomeCompleto := fsNomeArquivoAux;
  // Tem Path no Nome do Arquivo ?
  if (fsNomeCompleto <> '') and (pos(PathDelim, fsNomeCompleto) = 0) then
     fsNomeCompleto := ExtractFilePath( ParamStr(0) ) + fsNomeCompleto;
end ;

procedure TACBrAAC.SetPAF_Nome(const AValue : String) ;
begin
  fsPAF_Nome := Trim(LeftStr( AValue, 40));
end ;

procedure TACBrAAC.SetPAF_Versao(const AValue : String) ;
begin
  fsPAF_Versao := Trim(LeftStr( AValue, 10));
end ;

procedure TACBrAAC.SetParams(const AValue : TStringList) ;
begin
   fsParams.Assign( AValue );
end ;

procedure TACBrAAC.SetSH_CNPJ(const AValue : String) ;
begin
  fsSH_CNPJ := Trim(LeftStr( OnlyNumber( AValue ), 14));
end ;

procedure TACBrAAC.SetSH_IE(const AValue : String) ;
begin
  fsSH_IE := Trim(LeftStr( OnlyNumber( AValue ), 14));
end ;

procedure TACBrAAC.SetSH_IM(const AValue : String) ;
begin
  fsSH_IM := Trim(LeftStr( OnlyNumber( AValue ), 14));
end ;

procedure TACBrAAC.SetSH_RazaoSocial(const AValue : String) ;
begin
  fsSH_RazaoSocial := Trim(LeftStr( AValue, 40));
end ;

function TACBrAAC.Criptografar( const Dados : AnsiString) : AnsiString ;
var
   R : AnsiString ;
begin
  R := '' ;
  if Assigned( fsOnCrypt ) then
   begin
     fsOnCrypt( Dados, R ) ;

     if R = '' then
        raise EACBrAAC_SemResposta.Create(
           ACBrStr('Evento ACBrACC.OnCrypt não informou a resposta') ) ;
   end
  else
     R := StrCrypt( Dados, Chave );

  Result := R ;
end ;

function TACBrAAC.DesCriptografar( const Dados : AnsiString) : AnsiString ;
var
   R : AnsiString ;
begin
  R := '' ;
  if Assigned( fsOnDeCrypt ) then
   begin
     fsOnDeCrypt( Dados, R ) ;

     if R = '' then
        raise EACBrAAC_SemResposta.Create(
           ACBrStr('Evento ACBrACC.OnDeCrypt não informou a resposta') ) ;
   end
  else
     R := StrCrypt( Dados, Chave );

  Result := R ;
end ;

end.

