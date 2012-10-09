unit pnfsCancNfseResposta;

interface

uses
  SysUtils, Classes, Forms,
  pcnAuxiliar, pcnConversao, pcnLeitor,
  pnfsConversao, pnfsNFSe, ACBrNFSeUtil;

type

 TMsgRetornoCancCollection = class;
 TMsgRetornoCancCollectionItem = class;

 TInfCanc = class(TPersistent)
  private
    FPedido: TPedidoCancelamento;
    FDataHora: TDateTime;
    FMsgRetorno : TMsgRetornoCancCollection;
    procedure SetMsgRetorno(Value: TMsgRetornoCancCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    property Pedido: TPedidocancelamento           read FPedido     write FPedido;
    property DataHora: TDateTime                   read FDataHora   write FDataHora;
    property MsgRetorno: TMsgRetornoCancCollection read FMsgRetorno write SetMsgRetorno;
  end;

 TMsgRetornoCancCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMsgRetornoCancCollectionItem;
    procedure SetItem(Index: Integer; Value: TMsgRetornoCancCollectionItem);
  public
    constructor Create(AOwner: TInfCanc);
    function Add: TMsgRetornoCancCollectionItem;
    property Items[Index: Integer]: TMsgRetornoCancCollectionItem read GetItem write SetItem; default;
  end;

 TMsgRetornoCancCollectionItem = class(TCollectionItem)
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

 TretCancNFSe = class(TPersistent)
  private
    FLeitor: TLeitor;
    FInfCanc: TInfCanc;
    FPrefixo2: String;
    FPrefixo3: String;
    FPrefixo4: String;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor   read FLeitor   write FLeitor;
    property InfCanc: TInfCanc read FInfCanc  write FInfCanc;
    property Prefixo2: String  read FPrefixo2 write FPrefixo2;
    property Prefixo3: String  read FPrefixo3 write FPrefixo3;
    property Prefixo4: String  read FPrefixo4 write FPrefixo4;
  end;

implementation

{ TInfCanc }

constructor TInfCanc.Create;
begin
  FPedido     := TPedidoCancelamento.Create;
  FMsgRetorno := TMsgRetornoCancCollection.Create(Self);
end;

destructor TInfCanc.Destroy;
begin
  FPedido.Free;
  FMsgRetorno.Free;

  inherited;
end;

procedure TInfCanc.SetMsgRetorno(Value: TMsgRetornoCancCollection);
begin
  FMsgRetorno.Assign(Value);
end;

{ TMsgRetornoCancCollection }

function TMsgRetornoCancCollection.Add: TMsgRetornoCancCollectionItem;
begin
  Result := TMsgRetornoCancCollectionItem(inherited Add);
  Result.create;
end;

constructor TMsgRetornoCancCollection.Create(AOwner: TInfCanc);
begin
  inherited Create(TMsgRetornoCancCollectionItem);
end;

function TMsgRetornoCancCollection.GetItem(
  Index: Integer): TMsgRetornoCancCollectionItem;
begin
  Result := TMsgRetornoCancCollectionItem(inherited GetItem(Index));
end;

procedure TMsgRetornoCancCollection.SetItem(Index: Integer;
  Value: TMsgRetornoCancCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TMsgRetornoCancCollectionItem }

constructor TMsgRetornoCancCollectionItem.Create;
begin

end;

destructor TMsgRetornoCancCollectionItem.Destroy;
begin

  inherited;
end;

{ TretCancNFSe }

constructor TretCancNFSe.Create;
begin
  FLeitor  := TLeitor.Create;
  FInfCanc := TInfCanc.Create;
end;

destructor TretCancNFSe.Destroy;
begin
  FLeitor.Free;
  FInfCanc.Free;
  inherited;
end;

function TretCancNFSe.LerXml: boolean;
var
  i: Integer;
begin
  result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;
    // Alterado por Rodrigo Cantelli
    if (leitor.rExtrai(1, Prefixo3 + 'CancelarNfseResposta') <> '') or (leitor.rExtrai(1, Prefixo3 + 'CancelarNfseReposta') <> '') then
    begin
      infCanc.DataHora                   := Leitor.rCampo(tcDatHor, Prefixo3 + 'DataHora');
      InfCanc.FPedido.InfID.ID           := Leitor.rAtributo('InfPedidoCancelamento Id=');
      InfCanc.FPedido.CodigoCancelamento := Leitor.rCampo(tcStr, prefixo3 + 'CodigoCancelamento');

      if Leitor.rExtrai(2, Prefixo3 + 'IdentificacaoNfse') <> ''
       then begin
        InfCanc.FPedido.IdentificacaoNfse.Numero             := Leitor.rCampo(tcStr, prefixo3 + 'Numero');
        InfCanc.FPedido.IdentificacaoNfse.Cnpj               := Leitor.rCampo(tcStr, prefixo3 + 'Cnpj');
        InfCanc.FPedido.IdentificacaoNfse.InscricaoMunicipal := Leitor.rCampo(tcStr, prefixo3 + 'InscricaoMunicipal');
        InfCanc.FPedido.IdentificacaoNfse.CodigoMunicipio    := Leitor.rCampo(tcStr, prefixo3 + 'CodigoMunicipio');
       end;

      Leitor.Grupo := Leitor.Arquivo;

      InfCanc.FPedido.signature.URI             := Leitor.rAtributo('Reference URI=');
      InfCanc.FPedido.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
      InfCanc.FPedido.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
      InfCanc.FPedido.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

      // Ler a Lista de Mensagens
      if leitor.rExtrai(2, 'ListaMensagemRetorno') <> '' then
      begin
        i := 0;
        while Leitor.rExtrai(3, prefixo2 + 'MensagemRetorno', '', i + 1) <> '' do
        begin
          InfCanc.FMsgRetorno.Add;
          InfCanc.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, prefixo2 + 'Codigo');
          InfCanc.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, prefixo2 + 'Mensagem');
          InfCanc.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, prefixo2 + 'Correcao');

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

