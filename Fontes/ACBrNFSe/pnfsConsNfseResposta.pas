unit pnfsConsNfseResposta;

interface

uses
  SysUtils, Classes, Forms,
  pcnAuxiliar, pcnConversao, pcnLeitor,
  pnfsConversao, pnfsNFSe, ACBrUtil, ACBrNFSeUtil;

type

 TCompNfseCollection = class;
 TCompNfseCollectionItem = class;
 TMsgRetornoNfseCollection = class;
 TMsgRetornoNfseCollectionItem = class;

 TListaNfse2 = class(TPersistent)
  private
    FCompNfse : TCompNfseCollection;
    FMsgRetorno : TMsgRetornoNfseCollection;
    procedure SetCompNfse(Value: TCompNfseCollection);
    procedure SetMsgRetorno(Value: TMsgRetornoNfseCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    property CompNfse: TCompNfseCollection         read FCompNfse   write SetCompNfse;
    property MsgRetorno: TMsgRetornoNfseCollection read FMsgRetorno write SetMsgRetorno;
  end;

 TCompNfseCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TCompNfseCollectionItem;
    procedure SetItem(Index: Integer; Value: TCompNfseCollectionItem);
  public
    constructor Create(AOwner: TListaNfse2);
    function Add: TCompNfseCollectionItem;
    property Items[Index: Integer]: TCompNfseCollectionItem read GetItem write SetItem; default;
  end;

 TCompNfseCollectionItem = class(TCollectionItem)
  private
    FNfse: TNFSe;
    FNfseCancelamento: TConfirmacaoCancelamento;
    FNfseSubstituicao: TSubstituicaoNfse;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nfse: TNFSe                                read FNfse             write FNfse;
    property NfseCancelamento: TConfirmacaoCancelamento read FNfseCancelamento write FNfseCancelamento;
    property NfseSubstituicao: TSubstituicaoNfse        read FNfseSubstituicao write FNfseSubstituicao;
  end;

 TMsgRetornoNfseCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMsgRetornoNfseCollectionItem;
    procedure SetItem(Index: Integer; Value: TMsgRetornoNfseCollectionItem);
  public
    constructor Create(AOwner: TListaNfse2);
    function Add: TMsgRetornoNfseCollectionItem;
    property Items[Index: Integer]: TMsgRetornoNfseCollectionItem read GetItem write SetItem; default;
  end;

 TMsgRetornoNfseCollectionItem = class(TCollectionItem)
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

 TretNfse = class(TPersistent)
  private
    FPathArquivoMunicipios: string;
    FPathArquivoTabServicos: string;
    FLeitor: TLeitor;
    FListaNfse: TListaNfse2;
    FPrefixo2: String;
    FPrefixo3: String;
    FPrefixo4: String;
//    function ObterNomeMunicipio(xUF: string; const cMun: integer): string;
//    function ObterDescricaoServico(cCodigo: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property PathArquivoMunicipios: string  read FPathArquivoMunicipios  write FPathArquivoMunicipios;
    property PathArquivoTabServicos: string read FPathArquivoTabServicos write FPathArquivoTabServicos;
    property Leitor: TLeitor                read FLeitor                 write FLeitor;
    property ListaNfse: TListaNfse2         read FListaNfse              write FListaNfse;
    property Prefixo2: String               read FPrefixo2               write FPrefixo2;
    property Prefixo3: String               read FPrefixo3               write FPrefixo3;
    property Prefixo4: String               read FPrefixo4               write FPrefixo4;
  end;

implementation

{ TListaNfse2 }

constructor TListaNfse2.Create;
begin
  FCompNfse   := TCompNfseCollection.Create(Self);
  FMsgRetorno := TMsgRetornoNfseCollection.Create(Self);
end;

destructor TListaNfse2.Destroy;
begin
  FCompNfse.Free;
  FMsgRetorno.Free;

  inherited;
end;

procedure TListaNfse2.SetCompNfse(Value: TCompNfseCollection);
begin
  FCompNfse.Assign(Value);
end;

procedure TListaNfse2.SetMsgRetorno(Value: TMsgRetornoNfseCollection);
begin
  FMsgRetorno.Assign(Value);
end;

{ TCompNfseCollection }

function TCompNfseCollection.Add: TCompNfseCollectionItem;
begin
  Result := TCompNfseCollectionItem(inherited Add);
  Result.create;
end;

constructor TCompNfseCollection.Create(AOwner: TListaNfse2);
begin
  inherited Create(TCompNfseCollectionItem);
end;

function TCompNfseCollection.GetItem(
  Index: Integer): TCompNfseCollectionItem;
begin
  Result := TCompNfseCollectionItem(inherited GetItem(Index));
end;

procedure TCompNfseCollection.SetItem(Index: Integer;
  Value: TCompNfseCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TCompNfseCollectionItem }

constructor TCompNfseCollectionItem.Create;
begin
  FNfse             := TNFSe.Create;
  FNfseCancelamento := TConfirmacaoCancelamento.Create;
  FNfseSubstituicao := TSubstituicaoNfse.Create;
end;

destructor TCompNfseCollectionItem.Destroy;
begin
  FNfse.Free;
  FNfseCancelamento.Free;
  FNfseSubstituicao.Free;

  inherited;
end;

{ TMsgRetornoNfseCollection }

function TMsgRetornoNfseCollection.Add: TMsgRetornoNfseCollectionItem;
begin
  Result := TMsgRetornoNfseCollectionItem(inherited Add);
  Result.create;
end;

constructor TMsgRetornoNfseCollection.Create(AOwner: TListaNfse2);
begin
  inherited Create(TMsgRetornoNfseCollectionItem);
end;

function TMsgRetornoNfseCollection.GetItem(
  Index: Integer): TMsgRetornoNfseCollectionItem;
begin
  Result := TMsgRetornoNfseCollectionItem(inherited GetItem(Index));
end;

procedure TMsgRetornoNfseCollection.SetItem(Index: Integer;
  Value: TMsgRetornoNfseCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TMsgRetornoNfseCollectionItem }

constructor TMsgRetornoNfseCollectionItem.Create;
begin

end;

destructor TMsgRetornoNfseCollectionItem.Destroy;
begin

  inherited;
end;

{ TretNfse }

constructor TretNfse.Create;
begin
  FLeitor                 := TLeitor.Create;
  FListaNfse              := TListaNfse2.Create;
  FPathArquivoMunicipios  := '';
  FPathArquivoTabServicos := '';
end;

destructor TretNfse.Destroy;
begin
  FLeitor.Free;
  FListaNfse.Free;
  inherited;
end;

function TretNfse.LerXml: boolean;
var
  ok: boolean;
  i, k, Item: Integer;
  VersaoXML: String;
begin
  result := False;
  try
    Leitor.Arquivo := NotaUtil.RetirarPrefixos(Leitor.Arquivo);
    VersaoXML := NotaUtil.VersaoXML(Leitor.Arquivo);

    k        := 0; //length(Prefixo4);
    Prefixo3 := '';
    Prefixo4 := '';

    Leitor.Grupo := Leitor.Arquivo;
    if (leitor.rExtrai(1, Prefixo3 + 'ConsultarNfseResposta') <> '') or
       (leitor.rExtrai(1, Prefixo3 + 'ConsultarNfseServicoPrestadoResposta') <> '') then
    begin
      // Ler a Lista de NFSe
      if leitor.rExtrai(2, Prefixo3 + 'ListaNfse') <> '' then
      begin
        i := 0;
        // Alterado por Rodrigo Cantelli
        while (Leitor.rExtrai(3, Prefixo3 + 'CompNfse', '', i + 1) <> '') or
              (Leitor.rExtrai(3, Prefixo3 + 'ComplNfse', '', i + 1) <> '') do
        begin
          ListaNfse.FCompNfse.Add;

          // Grupo da TAG <Nfse> *************************************************
          if Leitor.rExtrai(4, Prefixo4 + 'Nfse') <> ''
           then begin
            // Grupo da TAG <InfNfse> *****************************************************
            if Leitor.rExtrai(5, Prefixo4 + 'InfNfse') <> ''
             then begin
              ListaNfse.FCompNfse[i].FNfse.InfID.ID          := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
              ListaNfse.FCompNfse[i].FNFSe.Numero            := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
              ListaNfse.FCompNfse[i].FNFSe.CodigoVerificacao := Leitor.rCampo(tcStr, Prefixo4 + 'CodigoVerificacao');
              ListaNfse.FCompNfse[i].FNFSe.DataEmissao       := Leitor.rCampo(tcDatHor, Prefixo4 + 'DataEmissao');

              ListaNfse.FCompNfse[i].FNFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
              ListaNfse.FCompNfse[i].FNFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
              ListaNfse.FCompNfse[i].FNFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
              ListaNfse.FCompNfse[i].FNFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));

              ListaNfse.FCompNfse[i].FNFSe.Competencia       := Leitor.rCampo(tcStr, Prefixo4 + 'Competencia');
              ListaNfse.FCompNfse[i].FNFSe.NfseSubstituida   := Leitor.rCampo(tcStr, Prefixo4 + 'NfseSubstituida');
              ListaNfse.FCompNfse[i].FNFSe.OutrasInformacoes := Leitor.rCampo(tcStr, Prefixo4 + 'OutrasInformacoes');
              ListaNfse.FCompNfse[i].FNFSe.ValorCredito      := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorCredito');

              // Grupo da TAG <IdentificacaoRps> ********************************************
              if Leitor.rExtrai(6, Prefixo4 + 'IdentificacaoRps') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
                ListaNfse.FCompNfse[i].FNFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, Prefixo4 + 'Serie');
                ListaNfse.FCompNfse[i].FNFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, Prefixo4 + 'Tipo'));
               end;

              // Grupo da TAG <RpsSubstituido> **********************************************
              if Leitor.rExtrai(6, Prefixo4 + 'RpsSubstituido') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.RpsSubstituido.Numero := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
                ListaNfse.FCompNfse[i].FNFSe.RpsSubstituido.Serie  := Leitor.rCampo(tcStr, Prefixo4 + 'Serie');
                ListaNfse.FCompNfse[i].FNFSe.RpsSubstituido.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, Prefixo4 + 'Tipo'));
               end;

              // Grupo da TAG <Servico> *****************************************************
              if Leitor.rExtrai(6, Prefixo4 + 'Servico') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico          := NotaUtil.LimpaNumero(Leitor.rCampo(tcStr, Prefixo4 + 'ItemListaServico'));
                ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoCnae                := Leitor.rCampo(tcStr, Prefixo4 + 'CodigoCnae');
                ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, Prefixo4 + 'CodigoTributacaoMunicipio');
                ListaNfse.FCompNfse[i].FNFSe.Servico.Discriminacao             := Leitor.rCampo(tcStr, Prefixo4 + 'Discriminacao');

                if VersaoXML='1'
                 then ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoMunicipio := Leitor.rCampo(tcStr, Prefixo4 + 'MunicipioPrestacaoServico')
                 else ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoMunicipio := Leitor.rCampo(tcStr, Prefixo4 + 'CodigoMunicipio');

                Item := StrToInt(SomenteNumeros(ListaNfse.FCompNfse[i].FNfse.Servico.ItemListaServico));
                if Item<100 then Item:=Item*100+1;

                ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
                ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico :=
                    Copy(ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico, 1, 2) + '.' +
                    Copy(ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico, 3, 2);

                if length(ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoMunicipio)<7
                 then ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoMunicipio :=
                       Copy(ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoMunicipio, 1, 2) +
                       FormatFloat('00000', StrToIntDef(Copy(ListaNfse.FCompNfse[i].FNFSe.Servico.CodigoMunicipio, 3, 5), 0));

                ListaNfse.FCompNfse[i].FNFSe.Servico.xItemListaServico := CodigoToDesc(ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico);
//                ListaNfse.FCompNfse[i].FNFSe.Servico.xItemListaServico := ObterDescricaoServico(ListaNfse.FCompNfse[i].FNFSe.Servico.ItemListaServico);

                if Leitor.rExtrai(7, Prefixo4 + 'Valores') <> ''
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorServicos');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorDeducoes');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorPis');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorCofins');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorInss');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorIr');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorCsll');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, Prefixo4 + 'IssRetido'));
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorIss');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, Prefixo4 + 'OutrasRetencoes');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, Prefixo4 + 'BaseCalculo');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, Prefixo4 + 'Aliquota');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorLiquidoNfse');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, Prefixo4 + 'ValorIssRetido');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, Prefixo4 + 'DescontoCondicionado');
                  ListaNfse.FCompNfse[i].FNFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, Prefixo4 + 'DescontoIncondicionado');
                 end;
               end;

              // Grupo da TAG <PrestadorServico> ********************************************
              if Leitor.rExtrai(6, Prefixo4 + 'PrestadorServico') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, Prefixo4 + 'RazaoSocial');
                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, Prefixo4 + 'NomeFantasia');

                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, Prefixo4 + 'Endereco');
                if Copy(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Endereco, 1, 10 + k) = '<' + Prefixo4 + 'Endereco>'
                 then ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Endereco := Copy(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Endereco, 11, 125);

                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, Prefixo4 + 'Complemento');
                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, Prefixo4 + 'Bairro');

                if VersaoXML='1'
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
                 end
                 else begin
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
                 end;

                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CEP := Leitor.rCampo(tcStr, Prefixo4 + 'Cep');

                if length(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
                 then ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio :=
                       Copy(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
                       FormatFloat('00000', StrToIntDef(Copy(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
//                ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.xMunicipio := UpperCase(TiraAcentos(Utf8ToAnsi(ObterNomeMunicipio(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.UF,
//                                                         StrToIntDef(ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.CodigoMunicipio, 0)))));

                if Leitor.rExtrai(7, Prefixo4 + 'Contato') <> ''
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, Prefixo4 + 'Telefone');
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, Prefixo4 + 'Email');
                 end;

                if Leitor.rExtrai(7, Prefixo4 + 'IdentificacaoPrestador') <> ''
                 then begin
                  if VersaoXML='1'
                   then begin
                    if Leitor.rExtrai(8, 'CpfCnpj') <> ''
                     then begin
                      ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
                      if ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
                       then ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
                     end;
                   end
                   else ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
                  ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, Prefixo4 + 'InscricaoMunicipal');
                 end;

               end;

              // Grupo da TAG <Prestador> ***************************************************
              if Leitor.rExtrai(6, Prefixo4 + 'Prestador') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.Prestador.Cnpj               := Leitor.rCampo(tcStr, Prefixo4 + 'Cnpj');
                ListaNfse.FCompNfse[i].FNFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, Prefixo4 + 'InscricaoMunicipal');
               end;

              // Grupo da TAG <TomadorServico> **********************************************
              if Leitor.rExtrai(6, Prefixo4 + 'TomadorServico') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, Prefixo4 + 'RazaoSocial');

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, Prefixo4 + 'Endereco');
                if Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco, 1, 10 + k) = '<' + Prefixo4 + 'Endereco>'
                 then ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco := Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco, 11, 125);

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, Prefixo4 + 'Complemento');
                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, Prefixo4 + 'Bairro');

                if VersaoXML='1'
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
                 end
                 else begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
                 end;

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, Prefixo4 + 'Cep');

                if length(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio)<7
                 then ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio :=
                       Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
                       FormatFloat('00000', StrToIntDef(Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

                if ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF = ''
                 then ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF := ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.UF;

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 0));
//                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.xMunicipio := UpperCase(TiraAcentos(Utf8ToAnsi(ObterNomeMunicipio(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF,
//                                                         StrToIntDef(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 0)))));

                if Leitor.rExtrai(7, Prefixo4 + 'Contato') <> ''
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, Prefixo4 + 'Telefone');
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, Prefixo4 + 'Email');
                 end;

                if Leitor.rExtrai(7, Prefixo4 + 'IdentificacaoTomador') <> ''
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, Prefixo4 + 'InscricaoMunicipal');
                  if Leitor.rExtrai(8, Prefixo4 + 'CpfCnpj') <> ''
                   then begin
                    if Leitor.rCampo(tcStr, Prefixo4 + 'Cpf')<>''
                     then ListaNfse.FCompNfse[i].FNFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, Prefixo4 + 'Cpf')
                     else ListaNfse.FCompNfse[i].FNFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, Prefixo4 + 'Cnpj');
                   end;
                 end;

               end;

              // Grupo da TAG <Tomador> *****************************************************
              if Leitor.rExtrai(6, Prefixo4 + 'Tomador') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, Prefixo4 + 'RazaoSocial');

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, Prefixo4 + 'Endereco');
                if Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco, 1, 10 + k) = '<' + Prefixo4 + 'Endereco>'
                 then ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco := Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Endereco, 11, 125);

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, Prefixo4 + 'Numero');
                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, Prefixo4 + 'Complemento');
                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, Prefixo4 + 'Bairro');

                if VersaoXML='1'
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
                 end
                 else begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
                 end;

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, Prefixo4 + 'Cep');

                if length(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio)<7
                 then ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio :=
                       Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
                       FormatFloat('00000', StrToIntDef(Copy(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

                if ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF = ''
                 then ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF := ListaNfse.FCompNfse[i].FNFSe.PrestadorServico.Endereco.UF;

                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 0));
//                ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.xMunicipio := UpperCase(TiraAcentos(Utf8ToAnsi(ObterNomeMunicipio(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.UF,
//                                                         StrToIntDef(ListaNfse.FCompNfse[i].FNFSe.Tomador.Endereco.CodigoMunicipio, 0)))));

                if Leitor.rExtrai(7, Prefixo4 + 'Contato') <> ''
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, Prefixo4 + 'Telefone');
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, Prefixo4 + 'Email');
                 end;

                if Leitor.rExtrai(7, Prefixo4 + 'IdentificacaoTomador') <> ''
                 then begin
                  ListaNfse.FCompNfse[i].FNFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, Prefixo4 + 'InscricaoMunicipal');
                  if Leitor.rExtrai(8, Prefixo4 + 'CpfCnpj') <> ''
                   then begin
                    if Leitor.rCampo(tcStr, Prefixo4 + 'Cpf')<>''
                     then ListaNfse.FCompNfse[i].FNFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, Prefixo4 + 'Cpf')
                     else ListaNfse.FCompNfse[i].FNFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, Prefixo4 + 'Cnpj');
                   end;
                 end;

               end;

              // Grupo da TAG <IntermediarioServico> ****************************************
              if Leitor.rExtrai(6, Prefixo4 + 'IntermediarioServico') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, Prefixo4 + 'RazaoSocial');
                ListaNfse.FCompNfse[i].FNFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, Prefixo4 + 'InscricaoMunicipal');
                if Leitor.rExtrai(7, Prefixo4 + 'CpfCnpj') <> ''
                 then begin
                  if Leitor.rCampo(tcStr, Prefixo4 + 'Cpf')<>''
                   then ListaNfse.FCompNfse[i].FNFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, Prefixo4 + 'Cpf')
                   else ListaNfse.FCompNfse[i].FNFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, Prefixo4 + 'Cnpj');
                 end;
               end;

              // Grupo da TAG <OrgaoGerador> ************************************************
              if Leitor.rExtrai(6, Prefixo4 + 'OrgaoGerador') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, Prefixo4 + 'CodigoMunicipio');
                ListaNfse.FCompNfse[i].FNFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, Prefixo4 + 'Uf');
               end;

              // Grupo da TAG <ConstrucaoCivil> *********************************************
              if Leitor.rExtrai(6, Prefixo4 + 'ConstrucaoCivil') <> ''
               then begin
                ListaNfse.FCompNfse[i].FNFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, Prefixo4 + 'CodigoObra');
                ListaNfse.FCompNfse[i].FNFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, Prefixo4 + 'Art');
               end;

             end; // fim do InfNfse
           end; // fim do Nfse - Nivel 4


          // Grupo da TAG <NfseCancelamento> ********************************************
          if Leitor.rExtrai(4, 'NfseCancelamento') <> ''
           then begin
            ListaNfse.FCompNfse[i].NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHora');

            // Incluido por Mauro Gomes
            // se não encontrou o campo DataHora, deve procurar pelo DataHoraCancelamento
            if (ListaNfse.FCompNfse[i].NFSe.NfseCancelamento.DataHora = 0) then
               ListaNfse.FCompNfse[i].NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHoraCancelamento');
           end;

          // Grupo da TAG <NfseSubstituicao> ********************************************
          if Leitor.rExtrai(4, 'NfseSubstituicao') <> ''
           then begin
            ListaNfse.FCompNfse[i].FNfse.NfseSubstituidora := Leitor.rCampo(tcStr, 'NfseSubstituidora');
           end;

          inc(i);
        end; // fim do CompNfse - Nivel 3

      end; // fim do ListaNfse - Nivel 2

      // Ler a Lista de Mensagens
      if leitor.rExtrai(2, 'ListaMensagemRetorno') <> '' then
      begin
        i := 0;
        while Leitor.rExtrai(3, prefixo4 + 'MensagemRetorno', '', i + 1) <> '' do
        begin
          ListaNfse.FMsgRetorno.Add;
          ListaNfse.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, prefixo4 + 'Codigo');
          ListaNfse.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, prefixo4 + 'Mensagem');
          ListaNfse.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, prefixo4 + 'Correcao');

          inc(i);
        end;
      end;

      Result := True;
    end;
  except
    result := False;
  end;
end;

{
function TretNfse.ObterDescricaoServico(cCodigo: string): string;
var
 i           : integer;
 PathArquivo : string;
 List        : TstringList;
begin
 result := '';

 if FPathArquivoTabServicos = ''
  then FPathArquivoTabServicos := NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName)) + 'TabServicos\';

 PathArquivo := FPathArquivoTabServicos + 'TabServicos.txt';
 if (FileExists(PathArquivo)) and (cCodigo <> '')
  then begin
   List := TstringList.Create;
   List.LoadFromFile(PathArquivo);
   i      := 0;
   while (i < list.count) and (result = '') do
    begin
     if pos(cCodigo, List[i]) > 0
      then result := Trim(stringReplace(list[i], ccodigo, '', []));
     inc(i);
   end;
   List.free;
  end;
end;

function TretNfse.ObterNomeMunicipio(xUF: string;
  const cMun: integer): string;
var
 i                   : integer;
 PathArquivo, Codigo : string;
 List                : TstringList;
begin
 result := '';

 if FPathArquivoMunicipios = ''
  then FPathArquivoMunicipios := NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName)) + 'MunIBGE\';

 PathArquivo := FPathArquivoMunicipios + 'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
 if (FileExists(PathArquivo)) and (cMun <> 0)
  then begin
   List := TstringList.Create;
   List.LoadFromFile(PathArquivo);
   Codigo := IntToStr(cMun);
   i      := 0;
   while (i < list.count) and (result = '') do
    begin
     if pos(Codigo, List[i]) > 0
      then result := Trim(stringReplace(list[i], codigo, '', []));
     inc(i);
   end;
   List.free;
  end;
end;
}
end.

