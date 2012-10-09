unit pnfsEnvLoteRpsResposta;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnLeitor, pnfsConversao;

type

 TMsgRetornoEnvCollection = class;
 TMsgRetornoEnvCollectionItem = class;

  TInfRec = class
  private
    FNumeroLote: string;
    FDataRecebimento: TDateTime;
    FProtocolo: string;
    FMsgRetorno : TMsgRetornoEnvCollection;
    procedure SetMsgRetorno(Value: TMsgRetornoEnvCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    property NumeroLote: string                   read FNumeroLote      write FNumeroLote;
    property DataRecebimento: TDateTime           read FDataRecebimento write FDataRecebimento;
    property Protocolo: string                    read FProtocolo       write FProtocolo;
    property MsgRetorno: TMsgRetornoEnvCollection read FMsgRetorno      write SetMsgRetorno;
  end;

 TMsgRetornoEnvCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMsgRetornoEnvCollectionItem;
    procedure SetItem(Index: Integer; Value: TMsgRetornoEnvCollectionItem);
  public
    constructor Create(AOwner: TInfRec);
    function Add: TMsgRetornoEnvCollectionItem;
    property Items[Index: Integer]: TMsgRetornoEnvCollectionItem read GetItem write SetItem; default;
  end;

 TMsgRetornoEnvCollectionItem = class(TCollectionItem)
  private
    FCodigo : String;
    FMensagem : String;
    FCorrecao : String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Codigo: string   read FCodigo   write FCodigo;
    property Mensagem: string read FMensagem write FMensagem;
    property Correcao: string read FCorrecao write FCorrecao;
  end;

  TretEnvLote = class(TPersistent)
  private
    FLeitor: TLeitor;
    FInfRec: TInfRec;
    FPrefixo2: String;
    FPrefixo3: String;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor  read FLeitor   write FLeitor;
    property InfRec: TInfRec  read FInfRec   write FInfRec;
    property Prefixo2: String read FPrefixo2 write FPrefixo2;
    property Prefixo3: String read FPrefixo3 write FPrefixo3;
  end;

implementation

{ TInfRec }

constructor TInfRec.Create;
begin
  FMsgRetorno := TMsgRetornoEnvCollection.Create(Self);
end;

destructor TInfRec.Destroy;
begin
  FMsgRetorno.Free;

  inherited;
end;

procedure TInfRec.SetMsgRetorno(Value: TMsgRetornoEnvCollection);
begin
  FMsgRetorno.Assign(Value);
end;

{ TMsgRetornoEnvCollection }

function TMsgRetornoEnvCollection.Add: TMsgRetornoEnvCollectionItem;
begin
  Result := TMsgRetornoEnvCollectionItem(inherited Add);
  Result.create;
end;

constructor TMsgRetornoEnvCollection.Create(AOwner: TInfRec);
begin
  inherited Create(TMsgRetornoEnvCollectionItem);
end;

function TMsgRetornoEnvCollection.GetItem(
  Index: Integer): TMsgRetornoEnvCollectionItem;
begin
  Result := TMsgRetornoEnvCollectionItem(inherited GetItem(Index));
end;

procedure TMsgRetornoEnvCollection.SetItem(Index: Integer;
  Value: TMsgRetornoEnvCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TMsgRetornoEnvCollectionItem }

constructor TMsgRetornoEnvCollectionItem.Create;
begin

end;

destructor TMsgRetornoEnvCollectionItem.Destroy;
begin

  inherited;
end;

{ TretEnvLote }

constructor TretEnvLote.Create;
begin
  FLeitor := TLeitor.Create;
  FInfRec := TInfRec.Create
end;

destructor TretEnvLote.Destroy;
begin
  FLeitor.Free;
  FinfRec.Free;
  inherited;
end;

function TretEnvLote.LerXml: boolean;
var
  i: Integer;
begin
  result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;
    if leitor.rExtrai(1, Prefixo3 + 'EnviarLoteRpsResposta') <> '' then
    begin
      infRec.FNumeroLote      := Leitor.rCampo(tcStr, Prefixo3 + 'NumeroLote');
      infRec.FDataRecebimento := Leitor.rCampo(tcDatHor, Prefixo3 + 'DataRecebimento');
      infRec.FProtocolo       := Leitor.rCampo(tcStr, Prefixo3 + 'Protocolo');

      // Ler a Lista de Mensagens
      if leitor.rExtrai(2, 'ListaMensagemRetorno') <> '' then
      begin
        i := 0;
        while Leitor.rExtrai(3, prefixo2 + 'MensagemRetorno', '', i + 1) <> '' do
        begin
          InfRec.FMsgRetorno.Add;
          InfRec.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, prefixo2 + 'Codigo');
          InfRec.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, prefixo2 + 'Mensagem');
          InfRec.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, prefixo2 + 'Correcao');

          inc(i);
        end;
      end;

      Result := True;
    end;
  except
    result := False;
  end;
end;

end.

