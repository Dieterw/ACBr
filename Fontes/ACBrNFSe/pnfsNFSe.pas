unit pnfsNFSe;

interface

uses
  SysUtils, Classes,
  {$IFNDEF VER130}
    Variants,
  {$ENDIF}
  pnfsConversao, pnfsSignature;

type

 TInfID                             = class;
 TIdentificacaoRps                  = class;
 TIdentificacaoNfse                 = class;
 TValores                           = class;
 TItemServicoCollection             = class;
 TItemServicoCollectionItem         = class;
 TDadosServico                      = class;
 TIdentificacaoPrestador            = class;
 TEndereco                          = class;
 TContato                           = class;
 TDadosPrestador                    = class;
 TIdentificacaoTomador              = class;
 TDadosTomador                      = class;
 TIdentificacaoIntermediarioServico = class;
 TIdentificacaoOrgaoGerador         = class;
 TDadosConstrucaoCivil              = class;

 TNFSe                              = class;

 TLoteRps                           = class;

 TPedidoCancelamento                = class;
 TConfirmacaoCancelamento           = class;
 TSubstituicaoNfse                  = class;

 TInfID = class(TPersistent)
  private
    FID: string;
  published
    property ID: string read FID write FID;
  end;

 TIdentificacaoRps = class(TPersistent)
  private
    FNumero: string;
    FSerie: string;
    FTipo: TnfseTipoRps;
  published
    property Numero: string read FNumero write FNumero;
    property Serie: string read FSerie write FSerie;
    property Tipo: TnfseTipoRps read FTipo write FTipo;
  end;

 TIdentificacaoNfse = class(TPersistent)
  private
    FNumero: string;
    FCnpj: string;
    FInscricaoMunicipal: string;
    FCodigoMunicipio: string;
  published
    property Numero: string read FNumero write FNumero;
    property Cnpj: string read FCnpj write FCnpj;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
    property CodigoMunicipio: string read FCodigoMunicipio write FCodigoMunicipio;
  end;

 TValores = class(TPersistent)
  private
    FValorServicos: currency;
    FValorDeducoes: currency;
    FValorPis: currency;
    FValorCofins: currency;
    FValorInss: currency;
    FValorIr: currency;
    FValorCsll: currency;
    FIssRetido: TnfseSituacaoTributaria;
    FValorIss: currency;
    FOutrasRetencoes: currency;
    FBaseCalculo: currency;
    FAliquota: currency;
    FValorLiquidoNfse: currency;
    FValorIssRetido: currency;
    FDescontoCondicionado: currency;
    FDescontoIncondicionado: currency;
  published
    property ValorServicos: currency read FValorServicos write FValorServicos;
    property ValorDeducoes: currency read FValorDeducoes write FValorDeducoes;
    property ValorPis: currency read FValorPis write FValorPis;
    property ValorCofins: currency read FValorCofins write FValorCofins;
    property ValorInss: currency read FValorInss write FValorInss;
    property ValorIr: currency read FValorIr write FValorIr;
    property ValorCsll: currency read FValorCsll write FValorCsll;
    property IssRetido: TnfseSituacaoTributaria read FIssRetido write FIssRetido;
    property ValorIss: currency read FValorIss write FValorIss;
    property OutrasRetencoes: currency read FOutrasRetencoes write FOutrasRetencoes;
    property BaseCalculo: currency read FBaseCalculo write FBaseCalculo;
    property Aliquota: currency read FAliquota write FAliquota;
    property ValorLiquidoNfse: currency read FValorLiquidoNfse write FValorLiquidoNfse;
    property ValorIssRetido: currency read FValorIssRetido write FValorIssRetido;
    property DescontoCondicionado: currency read FDescontoCondicionado write FDescontoCondicionado;
    property DescontoIncondicionado: currency read FDescontoIncondicionado write FDescontoIncondicionado;
  end;

  TItemServicoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TItemServicoCollectionItem;
    procedure SetItem(Index: Integer; Value: TItemServicoCollectionItem);
  public
    constructor Create(AOwner: TDadosServico);
    function Add: TItemServicoCollectionItem;
    property Items[Index: Integer]: TItemServicoCollectionItem read GetItem write SetItem; default;
  end;

  TItemServicoCollectionItem = class(TCollectionItem)
  private
    FDescricao : String;
    FQuantidade : Integer;
    FValorUnitario : currency;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: currency read FValorUnitario write FValorUnitario;
  end;

 TDadosServico = class(TPersistent)
  private
    FValores: TValores;
    FItemListaServico: string;
    FCodigoCnae: string;
    FCodigoTributacaoMunicipio: string;
    FDiscriminacao: string;
    FCodigoMunicipio: string;
    FCodigoPais: Integer;
    FExigibilidadeISS: TnfseExigibilidadeISS;
    FMunicipioIncidencia: Integer;
    FNumeroProcesso: string;
    FxItemListaServico: ansistring;
    FItemServico: TItemServicoCollection;
    FResponsavelRetencao: TnfseResponsavelRetencao;

    procedure SetItemServico(Value: TItemServicoCollection);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Valores: TValores read FValores write FValores;
    property ItemListaServico: string read FItemListaServico write FItemListaServico;
    property CodigoCnae: string read FCodigoCnae write FCodigoCnae;
    property CodigoTributacaoMunicipio: string read FCodigoTributacaoMunicipio write FCodigoTributacaoMunicipio;
    property Discriminacao: string read FDiscriminacao write FDiscriminacao;
    property CodigoMunicipio: string read FCodigoMunicipio write FCodigoMunicipio;
    property CodigoPais: Integer read FCodigoPais write FCodigoPais;
    property ExigibilidadeISS: TnfseExigibilidadeISS read FExigibilidadeISS write FExigibilidadeISS;
    property MunicipioIncidencia: Integer read FMunicipioIncidencia write FMunicipioIncidencia;
    property NumeroProcesso: string read FNumeroProcesso write FNumeroProcesso;
    property xItemListaServico: ansistring read FxItemListaServico write FxItemListaServico;
    property ItemServico: TItemServicoCollection read FItemServico write SetItemServico;
    property ResponsavelRetencao: TnfseResponsavelRetencao read FResponsavelRetencao write FResponsavelRetencao;
  end;

 TIdentificacaoPrestador = class(TPersistent)
  private
    FCnpj: string;
    FInscricaoMunicipal: string;
  published
    property Cnpj: string read FCnpj write FCnpj;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
  end;

 TEndereco = class(TPersistent)
  private
    FEndereco: string;
    FNumero: string;
    FComplemento: string;
    FBairro: string;
    FCodigoMunicipio: string;
    FUF: string;
    FCEP: string;
    FxMunicipio: string;
    FCodigoPais: integer;
  published
    property Endereco: string read FEndereco write FEndereco;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property CodigoMunicipio: string read FCodigoMunicipio write FCodigoMunicipio;
    property UF: string read FUF write FUF;
    property CEP: string read FCEP write FCEP;
    property xMunicipio: string read FxMunicipio write FxMunicipio;
    property CodigoPais: integer read FCodigoPais write FCodigoPais; 
  end;

 TContato = class(TPersistent)
  private
    FTelefone: string;
    FEmail: string;
  published
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
  end;

 TDadosPrestador = class(TPersistent)
  private
    FIdentificacaoPrestador: TIdentificacaoPrestador;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FEndereco: TEndereco;
    FContato: TContato;
  public
    constructor Create(AOwner: TNFSe);
    destructor Destroy; override;
  published
    property IdentificacaoPrestador: TIdentificacaoPrestador read FIdentificacaoPrestador write FIdentificacaoPrestador;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property Endereco: TEndereco read FEndereco write FEndereco;
    property Contato: TContato read FContato write FContato;
  end;

  TIdentificacaoTomador = class(TPersistent)
  private
    FCpfCnpj: string;
    FInscricaoMunicipal: string;
  published
    property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
  end;

 TDadosTomador = class(TPersistent)
  private
    FIdentificacaoTomador: TIDentificacaoTomador;
    FRazaoSocial: string;
    FEndereco: TEndereco;
    FContato: TContato;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property IdentificacaoTomador: TIdentificacaoTomador read FIdentificacaoTomador write FIdentificacaoTomador;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Endereco: TEndereco read FEndereco write FEndereco;
    property Contato: TContato read FContato write FContato;
  end;

 TIdentificacaoIntermediarioServico = class(TPersistent)
  private
    FRazaoSocial: string;
    FCpfCnpj: string;
    FInscricaoMunicipal: string;
  published
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
  end;

 TIdentificacaoOrgaoGerador = class(TPersistent)
  private
    FCodigoMunicipio: string;
    FUf: string;
  published
    property CodigoMunicipio: string read FCodigoMunicipio write FCodigoMunicipio;
    property Uf: string read FUf write FUf;
  end;

 TDadosConstrucaoCivil = class(TPersistent)
  private
    FCodigoObra: string;
    FArt: string;
  published
    property CodigoObra: string read FCodigoObra write FCodigoObra;
    property Art: string read FArt write FArt;
  end;

 TNFSe = class(TPersistent)
  private
    // RPS e NFSe
    FInfID: TInfID;
    FIdentificacaoRps: TIdentificacaoRps;
    FDataEmissao: TDateTime;
    FDataEmissaoRps: TDateTime;
    FNaturezaOperacao: TnfseNaturezaOperacao;
    FRegimeEspecialTributacao: TnfseRegimeEspecialTributacao;
    FOptanteSimplesNacional: TnfseSimNao;
    FIncentivadorCultural: TnfseSimNao;
    FStatus: TnfseStatusRps;
    FRpsSubstituido: TIdentificacaoRps;
    FServico: TDadosServico;
    FPrestador: TIdentificacaoPrestador;
    FTomador: TDadosTomador;
    FIntermediarioServico: TIdentificacaoIntermediarioServico;
    FConstrucaoCivil: TDadosConstrucaoCivil;
    // NFSe
    FNumero: String;
    FCodigoVerificacao: String;
    FCompetencia: String;
    FNfseSubstituida: String;
    FOutrasInformacoes: String;
    FValorCredito: Currency;
    FPrestadorServico: TDadosPrestador;
    FOrgaoGerador: TIdentificacaoOrgaoGerador;
    // RPS e NFSe
    FSignature: TSignature;

    FProtocolo: String;
    FdhRecebimento: TDateTime;
    FSituacao: String;

    FXML: AnsiString;

    FNfseCancelamento: TConfirmacaoCancelamento;
    FNfseSubstituidora: String;
  public
    constructor Create;
    destructor Destroy; override;
  published
    // RPS e NFSe
    property InfID: TInfID read FInfID write FInfID;
    property IdentificacaoRps: TIdentificacaoRps read FIdentificacaoRps write FIdentificacaoRps;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property DataEmissaoRps: TDateTime read FDataEmissaoRps write FDataEmissaoRps;
    property NaturezaOperacao: TnfseNaturezaOperacao read FNaturezaOperacao write FNaturezaOperacao;
    property RegimeEspecialTributacao: TnfseRegimeEspecialTributacao read FRegimeEspecialTributacao write FRegimeEspecialTributacao;
    property OptanteSimplesNacional: TnfseSimNao read FOptanteSimplesNacional write FOptanteSimplesNacional;
    property IncentivadorCultural: TnfseSimNao read FIncentivadorCultural write FIncentivadorCultural;
    property Status: TnfseStatusRps read FStatus write FStatus;
    property RpsSubstituido: TIdentificacaoRps read FRpsSubstituido write FRpsSubstituido;
    property Servico: TDadosServico read FServico write FServico;
    property Prestador: TIdentificacaoPrestador read FPrestador write FPrestador;
    property Tomador: TDadosTomador read FTomador write FTomador;
    property IntermediarioServico: TIdentificacaoIntermediarioServico read FIntermediarioServico write FIntermediarioServico;
    property ConstrucaoCivil: TDadosConstrucaoCivil read FConstrucaoCivil write FConstrucaoCivil;
    // NFSe
    property Numero: String read FNumero write FNumero;
    property CodigoVerificacao: String read FCodigoVerificacao write FCodigoVerificacao;
    property Competencia: String read FCompetencia write FCompetencia;
    property NfseSubstituida: String read FNfseSubstituida write FNfseSubstituida;
    property OutrasInformacoes: String read FOutrasInformacoes write FOutrasInformacoes;
    property ValorCredito: Currency read FValorCredito write FValorCredito;
    property PrestadorServico: TDadosPrestador read FPrestadorServico write FPrestadorServico;
    property OrgaoGerador: TIdentificacaoOrgaoGerador read FOrgaoGerador write FOrgaoGerador;
    // RPS e NFSe
    property signature: Tsignature read Fsignature write Fsignature;

    property Protocolo: String read FProtocolo write FProtocolo;
    property dhRecebimento: TDateTime read FdhRecebimento write FdhRecebimento;
    property Situacao: String read FSituacao write FSituacao;
    property XML: AnsiString read FXML write FXML;
    property NfseCancelamento: TConfirmacaoCancelamento read FNfseCancelamento write FNfseCancelamento;
    property NfseSubstituidora: String read FNfseSubstituidora write FNfseSubstituidora;
  end;

 TLoteRps = class(TPersistent)
  private
    FInfID: TInfID;
    FNumeroLote: String;
    FCnpj: string;
    FInscricaoMunicipal: string;
    FQuantidadeRps: String;
    FSignature: TSignature;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property InfID: TInfID read FInfID write FInfID;
    property NumeroLote: String read FNumeroLote write FNumeroLote;
    property Cnpj: String read FCnpj write FCnpj;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
    property QuantidadeRps: String read FQuantidadeRps write FQuantidadeRps;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

 TPedidoCancelamento = class(TPersistent)
  private
    FInfID: TInfID;
    FIdentificacaoNfse: TIdentificacaoNfse;
    FCodigoCancelamento: String;
    FSignature: TSignature;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property InfID: TInfID read FInfID write FInfID;
    property IdentificacaoNfse: TIdentificacaoNfse read FIdentificacaoNfse write FIdentificacaoNfse;
    property CodigoCancelamento: String read FCodigoCancelamento write FCodigoCancelamento;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

 TConfirmacaoCancelamento = class(TPersistent)
  private
    FInfID: TInfID;
    FPedido: TPedidoCancelamento;
    FDataHora: TDateTime;
    FSignature: TSignature;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property InfID: TInfID read FInfID write FInfID;
    property Pedido: TPedidoCancelamento read FPedido write FPedido;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

 TSubstituicaoNfse = class(TPersistent)
  private
    FInfID: TInfID;
    FNfseSubstituidora: String;
    FSignature: TSignature;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property InfID: TInfID read FInfID write FInfID;
    property NfseSubstituidora: String read FNfseSubstituidora write FNfseSubstituidora;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

const
  CMUN_EXTERIOR: integer = 9999999;
  XMUN_EXTERIOR: string = 'EXTERIOR';
  UF_EXTERIOR: string = 'EX';

implementation

{ TDadosServicoRPS }

constructor TDadosServico.Create;
begin
 inherited Create;

 FValores := TValores.Create;

 with FValores do
  begin
   FValorServicos          := 0;
   FValorDeducoes          := 0;
   FValorPis               := 0;
   FValorCofins            := 0;
   FValorInss              := 0;
   FValorIr                := 0;
   FValorCsll              := 0;
   FIssRetido              := stNormal;
   FValorIss               := 0;
   FValorIssRetido         := 0;
   FOutrasRetencoes        := 0;
   FBaseCalculo            := 0;
   FAliquota               := 0;
   FValorLiquidoNfse       := 0;
   FDescontoIncondicionado := 0;
   FDescontoCondicionado   := 0;
  end;

 FItemServico := TItemServicoCollection.Create(Self);

end;

destructor TDadosServico.Destroy;
begin
 FValores.Free;
 FItemServico.Free;

 inherited destroy;
end;

procedure TDadosServico.SetItemServico(Value: TItemServicoCollection);
begin
 FItemServico.Assign(Value);
end;

{ TDadosPrestador }

constructor TDadosPrestador.Create(AOwner: TNFSe);
begin
 inherited Create;

 FIdentificacaoPrestador := TIdentificacaoPrestador.Create;
 FEndereco               := TEndereco.Create;
 FContato                := TContato.Create;

 with FIdentificacaoPrestador do
  begin
   Cnpj               := '';
   InscricaoMunicipal := '';
  end;
end;

destructor TDadosPrestador.Destroy;
begin
 FIdentificacaoPrestador.Free;
 FEndereco.Free;
 FContato.Free;

 inherited destroy;
end;

{ TDadosTomador }

constructor TDadosTomador.Create;
begin
 inherited Create;

 FIdentificacaoTomador := TIdentificacaoTomador.Create;
 FEndereco             := TEndereco.Create;
 FContato              := TContato.Create;
end;

destructor TDadosTomador.Destroy;
begin
 FIdentificacaoTomador.Free;
 FEndereco.Free;
 FContato.Free;

 inherited destroy;
end;

{ TNFSe }

constructor TNFSe.Create;
begin
 inherited create;
 // RPS e NFSe
 FInfID                        := TInfID.Create;
 FIdentificacaoRps             := TIdentificacaoRps.Create;
 FIdentificacaoRps.FTipo       := trRPS;
 FDataEmissao                  := 0;
 FNaturezaOperacao             := noTributacaoNoMunicipio;
 FRegimeEspecialTributacao     := retNenhum;
 FOptanteSimplesNacional       := snNao;
 FIncentivadorCultural         := snNao;
 FStatus                       := srNormal;
 FRpsSubstituido               := TIdentificacaoRps.Create;
 FRpsSubstituido.FTipo         := trRPS;
 FServico                      := TDadosServico.Create;
 FPrestador                    := TIdentificacaoPrestador.Create;
 FPrestador.Cnpj               := '';
 FPrestador.InscricaoMunicipal := '';
 FTomador                      := TDadosTomador.Create;
 FIntermediarioServico         := TIdentificacaoIntermediarioServico.Create;
 FConstrucaoCivil              := TDadosConstrucaoCivil.Create;
 // NFSe
 FNumero                       := '';
 FCodigoVerificacao            := '';
 FCompetencia                  := '';
 FNfseSubstituida              := '';
 FOutrasInformacoes            := '';
 FValorCredito                 := 0;
 FPrestadorServico             := TDadosPrestador.Create(self);
 FOrgaoGerador                 := TIdentificacaoOrgaoGerador.Create;
 // RPS e NFSe
 Fsignature                    := Tsignature.create;

 FNfseCancelamento             := TConfirmacaoCancelamento.Create;
 FNfseCancelamento.DataHora    := 0;
 FNfseSubstituidora            := '';
end;

destructor TNFSe.Destroy;
begin
 // RPS e NFSe
 FInfID.Free;
 FIdentificacaoRps.Free;
 FRpsSubstituido.Free;
 FServico.Free;
 FPrestador.Free;
 FTomador.Free;
 FIntermediarioServico.Free;
 FConstrucaoCivil.Free;
 // NFSe
 FPrestadorServico.Free;
 FOrgaoGerador.Free;
 // RPS e NFSe
 Fsignature.Free;
 FNfseCancelamento.Free;

 inherited Destroy;
end;

{ TLoteRps }

constructor TLoteRps.Create;
begin
 inherited create;
 FInfID              := TInfID.Create;
 FNumeroLote         := '';
 FCnpj               := '';
 FInscricaoMunicipal := '';
 FQuantidadeRps      := '';
 Fsignature          := Tsignature.create;
end;

destructor TLoteRps.Destroy;
begin
 FInfID.Free;
 Fsignature.Free;

 inherited Destroy;
end;

{ TPedidoCancelamento }

constructor TPedidoCancelamento.Create;
begin
 FInfID              := TInfID.Create;
 FIdentificacaoNfse  := TIdentificacaoNfse.Create;
 FCodigoCancelamento := '';
 Fsignature          := Tsignature.create;
end;

destructor TPedidoCancelamento.Destroy;
begin
 FInfID.Free;
 FIdentificacaoNfse.Free;
 Fsignature.Free;

  inherited;
end;

{ TConfirmacaoCancelamento }

constructor TConfirmacaoCancelamento.Create;
begin
 FInfID     := TInfID.Create;
 FPedido    := TPedidoCancelamento.Create;
 Fsignature := Tsignature.create;
end;

destructor TConfirmacaoCancelamento.Destroy;
begin
 FInfID.Free;
 FPedido.Free;
 Fsignature.Free;

  inherited;
end;

{ TSubstituicaoNfse }

constructor TSubstituicaoNfse.Create;
begin
 FInfID             := TInfID.Create;
 FNfseSubstituidora := '';
 Fsignature         := Tsignature.create;
end;

destructor TSubstituicaoNfse.Destroy;
begin
 FInfID.Free;
 Fsignature.Free;

  inherited;
end;

{ TItemServicoCollection }

function TItemServicoCollection.Add: TItemServicoCollectionItem;
begin
  Result := TItemServicoCollectionItem(inherited Add);
  Result.create;
end;

constructor TItemServicoCollection.Create(AOwner: TDadosServico);
begin
  inherited Create(TItemServicoCollectionItem);
end;

function TItemServicoCollection.GetItem(Index: Integer): TItemServicoCollectionItem;
begin
  Result := TItemServicoCollectionItem(inherited GetItem(Index));
end;

procedure TItemServicoCollection.SetItem(Index: Integer;
  Value: TItemServicoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TItemServicoCollectionItem }

constructor TItemServicoCollectionItem.Create;
begin

end;

destructor TItemServicoCollectionItem.Destroy;
begin

  inherited;
end;

end.

