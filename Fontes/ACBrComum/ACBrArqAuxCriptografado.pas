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
    FDadosArquivo: TMemIniFile;
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

function TACBrArqAuxCriptografado.DeCryptTexto(const Texto: String): String;
var
  Chave: AnsiString;
begin
  Chave := GetChavePrivada;
  Result := String(StrCrypt(HexToAscii(AnsiString(Texto)), Chave));
end;

function TACBrArqAuxCriptografado.CryptTexto(const Texto: String): String;
var
  Chave: AnsiString;
begin
  Chave := GetChavePrivada;
  Result := String(AsciiToHex(StrCrypt(AnsiString(Texto), Chave)));
end;

constructor TACBrArqAuxCriptografado.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPAth            := EmptyStr;
  FArquivo         := EmptyStr;
  FACBrEAD         := TACBrEAD.Create(Self);
  FDadosArquivo    := TMemIniFile.Create(EmptyStr);
  FECFsAutorizados := TACBrImpressorasFiscais.Create;
end;

destructor TACBrArqAuxCriptografado.Destroy;
begin
  FACBrEAD.Free;
  FDadosArquivo.Free;
  FECFsAutorizados.Free;

  Inherited;
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

procedure TACBrArqAuxCriptografado.AbrirArquivo;
var
  I: Integer;
  Lista: TStringList;
  SerieECF: String;
  CRCArquivo: Integer;
  PathArquivo: String;
begin
  PathArquivo := GetCaminhoArquivo;
  if not FilesExists(PathArquivo) then
    raise EACBrArqAux_ArqNaoEncontrado.CreateFmt('Arquivo "%s" não encontrado.', [Arquivo]);

  Lista := TStringList.Create;
  try
    // abrir o arquivo e decriptar
    Lista.LoadFromFile(PathArquivo);
    Lista.Text := DeCryptTexto(Lista.Text);

    // limpar os dados contidos na memória
    Self.MD5 := EmptyStr;
    Self.ECFsAutorizados.Clear;

    // ler os dados para o meminifile
    FDadosArquivo.SetStrings(Lista);

    // Se o CRC do arquivo for igual a -1 então o arquivo pode estar corrompido
    CRCArquivo := FDadosArquivo.ReadInteger(SEC_CRC, ID_CRC, -1);
    if CRCArquivo = -1 then
    begin
      raise EACBrArqAux_CRC.Create(
        'Não foi possível ler o conteúdo do arquivo auxiliar.' + sLineBreak +
        'Arquivo provavelmente foi corrompido.'
      );
    end;

    // MD5 do arquivo texto da lista de arquivos autenticados
    Self.MD5   := FDadosArquivo.ReadString(SEC_MD5, ID_ARQ_AUTENTICADOS, '');

    // obter os numeros de série dos ecfs cadastrados
    // efetuar a leitura dos dados de GT e CRO cadastrados
    Lista.Clear;
    Self.ECFsAutorizados.Clear;
    FDadosArquivo.ReadSection(SEC_GRANDES_TOTAIS, Lista);
    for I := 0 to Lista.Count - 1 do
    begin
      SerieECF := Lista.Strings[I];
      with Self.ECFsAutorizados.New do
      begin
        NumeroSerie := SerieECF;
        ValorGT     := FDadosArquivo.ReadFloat(SEC_GRANDES_TOTAIS, SerieECF, 0.00);
        CRO         := FDadosArquivo.ReadInteger(SEC_CRO, SerieECF, 0);
      end;
    end;
  finally
    Lista.Free;
  end;
end;

procedure TACBrArqAuxCriptografado.SalvarArquivo;
var
  I: integer;
  F: TSTringList;
  PathArquivo: String;
begin
  PathArquivo := GetCaminhoArquivo;

  // MD5 do arquivo com a lista de arquivos autenticados
  FDadosArquivo.WriteString(SEC_MD5, ID_ARQ_AUTENTICADOS, Self.MD5);

  // lista de ecfs autorizados, duas seçoes,
  // uma para o grande total outra para o CRO
  for I := 0 to Self.ECFsAutorizados.Count - 1 do
  begin
    // grande total
    FDadosArquivo.WriteFloat(
      SEC_GRANDES_TOTAIS,
      Self.ECFsAutorizados[I].NumeroSerie,
      Self.ECFsAutorizados[I].ValorGT
    );
    // CRO
    FDadosArquivo.WriteInteger(
      SEC_CRO,
      Self.ECFsAutorizados[I].NumeroSerie,
      Self.ECFsAutorizados[I].CRO
    );
  end;

  FDadosArquivo.WriteInteger(SEC_CRC, ID_CRC, 9);

  // salvar o arquivo encriptado em disco
  F := TSTringList.Create;
  try
    F.Clear;
    FDadosArquivo.GetStrings(F);
    F.Text := CryptTexto(F.Text);

    WriteToTXT(AnsiString(PathArquivo), AnsiString(F.Text), False, False);
  finally
    F.Free;
  end;
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
