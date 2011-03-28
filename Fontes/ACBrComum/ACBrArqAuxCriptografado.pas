unit ACBrArqAuxCriptografado;

interface

uses
  ACBrUtil, ACBrEAD,
  Classes, SysUtils, Contnrs, IniFiles;

type
  EACBrArqAux_CRC = class(Exception);
  EACBrArqAux_ArqNaoEncontrado = class(Exception);
  EACBrArqAux_NomeArquivo = class(Exception);
  EACBrArqAux_ChavePrivada = class(Exception);

  TACBrImpressoraFiscal = class
  private
    FCRO: Integer;
    FValorGT: Double;
    FNumeroSerie: String;
  public
    property NumeroSerie: String read FNumeroSerie write FNumeroSerie;
    property ValorGT: Double read FValorGT write FValorGT;
    property CRO: Integer read FCRO write FCRO;
  end;

  TACBrImpressorasFiscais = class(TObjectList)
  private
    procedure SetObject(Index: Integer; Item: TACBrImpressoraFiscal);
    function GetObject(Index: Integer): TACBrImpressoraFiscal;
    procedure Insert(Index: Integer; Obj: TACBrImpressoraFiscal);
  public
    function New: TACBrImpressoraFiscal;
    function Add(Obj: TACBrImpressoraFiscal): Integer;
    property Objects[Index: Integer]: TACBrImpressoraFiscal read GetObject write SetObject; default;
  end;

  TACBrArqAuxCriptografado = class(TComponent)
  private
    FACBrEAD: TACBrEAD;
    FMD5: String;
    FArquivo: String;
    FECFsAutorizados: TACBrImpressorasFiscais;
    FPAth: String;
    function CryptTexto(const Texto: String): String;
    function DeCryptTexto(const Texto: String): String;
    function GetChavePrivada: AnsiString;
    function GetCaminhoArquivo: String;
    function GetOnPAFGetKeyRSA: TACBrEADGetChave;
    procedure SetOnPAFGetKeyRSA(const Value: TACBrEADGetChave);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AbrirArquivo;
    procedure SalvarArquivo;

    function VerificarECFCadastrado(const NumeroSerie: String): Boolean;
    function VerificarGTECF(const NumeroSerie: String; const ValorGT: Double;
      const CRO: Integer): Boolean;
    procedure AtualizarMD5(const AMD5: String);
    procedure AtualizarGTECF(const NumeroSerie: String; const ValorGT: Double;
      const CRO: Integer);

  published
    property OnPAFGetKeyRSA: TACBrEADGetChave
      read GetOnPAFGetKeyRSA write SetOnPAFGetKeyRSA;

    property Path: String read FPAth write FPath;
    property Arquivo: String read FArquivo write FArquivo;
    property MD5: String read FMD5 write FMD5;
    property ECFsAutorizados: TACBrImpressorasFiscais read FECFsAutorizados write FECFsAutorizados;
  end;

  procedure Register;

implementation

const
  SEC_MD5             = 'MD5';
  SEC_CRC             = 'CRC';
  ID_CRC              = 'DigitoCRC';
  ID_ARQ_AUTENTICADOS = 'ArqListaAutenticados';
  SEC_GRANDES_TOTAIS  = 'GrandesTotais';
  SEC_CRO             = 'CRO';

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrArqAuxCriptografado]);
end;

{ TACBrECFImpressorasFiscais }

function TACBrImpressorasFiscais.Add(Obj: TACBrImpressoraFiscal): Integer;
begin
  Result := inherited Add(Obj);
end;

function TACBrImpressorasFiscais.GetObject(
  Index: Integer): TACBrImpressoraFiscal;
begin
  Result := inherited GetItem(Index) as TACBrImpressoraFiscal;
end;

procedure TACBrImpressorasFiscais.Insert(Index: Integer;
  Obj: TACBrImpressoraFiscal);
begin
  inherited Insert(Index, Obj);
end;

function TACBrImpressorasFiscais.New: TACBrImpressoraFiscal;
begin
  Result := TACBrImpressoraFiscal.Create;
  Add(Result);
end;

procedure TACBrImpressorasFiscais.SetObject(Index: Integer;
  Item: TACBrImpressoraFiscal);
begin
  inherited SetItem(Index, Item);
end;

{ TACBrArqAuxCriptografado }

function TACBrArqAuxCriptografado.GetOnPAFGetKeyRSA: TACBrEADGetChave;
begin
  Result := FACBrEAD.OnGetChavePrivada;
end;

procedure TACBrArqAuxCriptografado.SetOnPAFGetKeyRSA(
  const Value: TACBrEADGetChave);
begin
  FACBrEAD.OnGetChavePrivada := Value;
end;

function TACBrArqAuxCriptografado.GetChavePrivada: AnsiString;
begin
  Self.OnPAFGetKeyRSA(Result);
  if Trim(String(Result)) = EmptyStr then
    raise EACBrArqAux_ChavePrivada.Create('Chave privada não informada');
end;

function TACBrArqAuxCriptografado.GetCaminhoArquivo: String;
begin
  if Trim(FPAth) = EmptyStr then
    raise EACBrArqAux_NomeArquivo.Create('Pasta onde o arquivo auxiliar criptografado será gravado não foi informada.');

  if Trim(FArquivo) = EmptyStr then
    raise EACBrArqAux_NomeArquivo.Create('Nome do arquivo criptografado auxiliar não informado.');

  Result :=
    IncludeTrailingPathDelimiter(FPath) +
    ExtractFileName(FArquivo);
end;

function TACBrArqAuxCriptografado.DeCryptTexto(const Texto: String): String;
var
  Chave: AnsiString;
begin
  Chave  := GetChavePrivada;
  Result := String(StrCrypt(HexToAscii(AnsiString(Texto)), Chave));
end;

function TACBrArqAuxCriptografado.CryptTexto(const Texto: String): String;
var
  Chave: AnsiString;
begin
  Chave  := GetChavePrivada;
  Result := AsciiToHex(StrCrypt(AnsiString(Texto), Chave));
end;

constructor TACBrArqAuxCriptografado.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPAth            := EmptyStr;
  FArquivo         := EmptyStr;
  FACBrEAD         := TACBrEAD.Create(Self);
  FECFsAutorizados := TACBrImpressorasFiscais.Create;
end;

destructor TACBrArqAuxCriptografado.Destroy;
begin
  FACBrEAD.Free;
  FECFsAutorizados.Free;
  Inherited;
end;

procedure TACBrArqAuxCriptografado.AbrirArquivo;
var
  I: Integer;
  Arquivo: TStringList;
  DadosECF: TStringList;
  PathArquivo: String;
  sNumSerie, sValorGT, sCRO: String;
begin
  PathArquivo := GetCaminhoArquivo;
  if not FilesExists(PathArquivo) then
    raise EACBrArqAux_ArqNaoEncontrado.CreateFmt('Arquivo "%s" não encontrado.', [PathArquivo]);

  Arquivo  := TStringList.Create;
  DadosECF := TStringList.Create;
  try
    // ler o conteudo do arquivo
    Arquivo.LoadFromFile(PathArquivo);

    // configurar o stringlist que será utilizado para ler os dados do ECF
    DadosECF.Delimiter := '|';

    // md5 sempre na primeira linha
    Self.MD5 := DeCryptTexto(Arquivo.Strings[0]);

    // lista de ecfs apartir da segunda linha
    Self.ECFsAutorizados.Clear;
    for I := 1 to Arquivo.Count - 1 do
    begin
      DadosECF.DelimitedText := Arquivo.Strings[I];
      try
        sNumSerie := DeCryptTexto(Trim(DadosECF.Strings[0]));
        sCRO      := DeCryptTexto(Trim(DadosECF.Strings[1]));
        sValorGT  := DeCryptTexto(Trim(DadosECF.Strings[2]));
      except
        sNumSerie := '';
        sCRO      := '';
        sValorGT  := '';
      end;

      if sNumSerie <>EmptyStr then
      begin
        with Self.ECFsAutorizados.New do
        begin
          NumeroSerie := sNumSerie;
          CRO         := StrToIntDef(sCRO, 0);
          ValorGT     := StrToFloatDef(sValorGT, 0.00);
        end;
      end;
    end;
  finally
    DadosECF.Free;
    Arquivo.Free;
  end;
end;

procedure TACBrArqAuxCriptografado.SalvarArquivo;
var
  I: integer;
  Dados: String;
  PathArquivo: String;
  Ecf: TACBrImpressoraFiscal;
begin
  PathArquivo := GetCaminhoArquivo;

  // MD5 do arquivo com a lista de arquivos autenticados
  Dados := CryptTexto(Self.MD5) + sLineBreak;

  // linha com dados do ECF sendo NumeroSerie|CRO|Valor GT (Criptografados)
  for I := 0 to Self.ECFsAutorizados.Count - 1 do
  begin
    Ecf := Self.ECFsAutorizados[I];
    Dados := Dados +
      CryptTexto(Ecf.NumeroSerie) + '|' +
      CryptTexto(IntToStr(Ecf.CRO)) + '|' +
      CryptTexto(FormatFloat('#.##', Ecf.ValorGT)) + sLineBreak;
  end;

  WriteToTXT(AnsiString(PathArquivo), AnsiString(Dados), False, False);
end;

function TACBrArqAuxCriptografado.VerificarECFCadastrado(
  const NumeroSerie: String): Boolean;
var
  I: Integer;
begin
  Result := False;
  Self.AbrirArquivo;

  for I := 0 to Self.ECFsAutorizados.Count - 1 do
  begin
    if NumeroSerie = Self.ECFsAutorizados[I].NumeroSerie then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TACBrArqAuxCriptografado.VerificarGTECF(const NumeroSerie: String;
  const ValorGT: Double; const CRO: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;

  if Self.VerificarECFCadastrado(NumeroSerie) then
  begin
    for I := 0 to Self.ECFsAutorizados.Count - 1 do
    begin
      if NumeroSerie = Self.ECFsAutorizados[I].NumeroSerie then
      begin
        // atualizar o gt quando o CRO for menor conforme a lei permite
        if CRO > Self.ECFsAutorizados[I].CRO then
        begin
          Self.ECFsAutorizados[I].ValorGT := ValorGT;
          Self.SalvarArquivo;
        end;

        if ValorGT = Self.ECFsAutorizados[I].ValorGT then
        begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TACBrArqAuxCriptografado.AtualizarMD5(const AMD5: String);
begin
  Self.MD5 := AMD5;
  Self.SalvarArquivo;
end;

procedure TACBrArqAuxCriptografado.AtualizarGTECF(const NumeroSerie: String;
  const ValorGT: Double; const CRO: Integer);
var
  I: Integer;
begin
  if Self.VerificarECFCadastrado(NumeroSerie) then
  begin
    for I := 0 to Self.ECFsAutorizados.Count - 1 do
    begin
      if NumeroSerie = Self.ECFsAutorizados[I].NumeroSerie then
      begin
        Self.ECFsAutorizados[I].ValorGT := ValorGT;
        Self.ECFsAutorizados[I].CRO     := CRO;

        Self.SalvarArquivo;
        Exit;
      end;
    end;
  end;
end;

end.
