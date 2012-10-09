unit pnfsConsSitLoteRpsResposta;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnLeitor,
  pnfsConversao, pnfsNFSe;

type

 TMsgRetornoSitCollection = class;
 TMsgRetornoSitCollectionItem = class;

 TInfSit = class(TPersistent)
  private
    FNumeroLote: string;
    FSituacao: string;
    FMsgRetorno : TMsgRetornoSitCollection;
    procedure SetMsgRetorno(Value: TMsgRetornoSitCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    property NumeroLote: string                   read FNumeroLote write FNumeroLote;
    property Situacao: string                     read FSituacao   write FSituacao;
    property MsgRetorno: TMsgRetornoSitCollection read FMsgRetorno write SetMsgRetorno;
  end;

 TMsgRetornoSitCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMsgRetornoSitCollectionItem;
    procedure SetItem(Index: Integer; Value: TMsgRetornoSitCollectionItem);
  public
    constructor Create(AOwner: TInfSit);
    function Add: TMsgRetornoSitCollectionItem;
    property Items[Index: Integer]: TMsgRetornoSitCollectionItem read GetItem write SetItem; default;
  end;

 TMsgRetornoSitCollectionItem = class(TCollectionItem)
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

 TretSitLote = class(TPersistent)
  private
    FLeitor: TLeitor;
    FInfSit: TInfSit;
    FPrefixo3: String;
    FPrefixo2: String;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor  read FLeitor   write FLeitor;
    property InfSit: TInfSit  read FInfSit   write FInfSit;
    property Prefixo2: String read FPrefixo2 write FPrefixo2;
    property Prefixo3: String read FPrefixo3 write FPrefixo3;
  end;

implementation

{ TInfSit }

constructor TInfSit.Create;
begin
  FMsgRetorno := TMsgRetornoSitCollection.Create(Self);
end;

destructor TInfSit.Destroy;
begin
  FMsgRetorno.Free;

  inherited;
end;

procedure TInfSit.SetMsgRetorno(Value: TMsgRetornoSitCollection);
begin
  FMsgRetorno.Assign(Value);
end;

{ TMsgRetornoSitCollection }

function TMsgRetornoSitCollection.Add: TMsgRetornoSitCollectionItem;
begin
  Result := TMsgRetornoSitCollectionItem(inherited Add);
  Result.create;
end;

constructor TMsgRetornoSitCollection.Create(AOwner: TInfSit);
begin
  inherited Create(TMsgRetornoSitCollectionItem);
end;

function TMsgRetornoSitCollection.GetItem(
  Index: Integer): TMsgRetornoSitCollectionItem;
begin
  Result := TMsgRetornoSitCollectionItem(inherited GetItem(Index));
end;

procedure TMsgRetornoSitCollection.SetItem(Index: Integer;
  Value: TMsgRetornoSitCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TMsgRetornoSitCollectionItem }

constructor TMsgRetornoSitCollectionItem.Create;
begin

end;

destructor TMsgRetornoSitCollectionItem.Destroy;
begin

  inherited;
end;

{ TretSitLote }

constructor TretSitLote.Create;
begin
  FLeitor := TLeitor.Create;
  FInfSit := TInfSit.Create;
end;

destructor TretSitLote.Destroy;
begin
  FLeitor.Free;
  FInfSit.Free;
  inherited;
end;

function TretSitLote.LerXml: boolean;
var
  i: Integer;
begin
  result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;
    if leitor.rExtrai(1, prefixo3 + 'ConsultarSituacaoLoteRpsResposta') <> '' then
    begin
      InfSit.FNumeroLote := Leitor.rCampo(tcStr, prefixo3 + 'NumeroLote');
      InfSit.FSituacao   := Leitor.rCampo(tcStr, prefixo3 + 'Situacao');

      // FSituacao: 1 = Não Recebido
      //            2 = Não Processado
      //            3 = Processado com Erro
      //            4 = Processado com Sucesso

      // Ler a Lista de Mensagens
      if leitor.rExtrai(2, 'ListaMensagemRetorno') <> '' then
      begin
        i := 0;
        while Leitor.rExtrai(3, prefixo2 + 'MensagemRetorno', '', i + 1) <> '' do
        begin
          InfSit.FMsgRetorno.Add;
          InfSit.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, prefixo2 + 'Codigo');
          InfSit.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, prefixo2 + 'Mensagem');
          InfSit.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, prefixo2 + 'Correcao');

          inc(i);
        end;
      end;

      result := True;
    end;
  except
    result := False;
  end;
end;

end.

