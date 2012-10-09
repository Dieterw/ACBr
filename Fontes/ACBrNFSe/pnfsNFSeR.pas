unit pnfsNFSeR;

interface

uses
  SysUtils, Classes, Forms,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor, pnfsNFSe, pnfsConversao,
  ACBrUtil, ACBrNFSeUtil;

type

 TLeitorOpcoes   = class;

 TNFSeR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FNFSe: TNFSe;
    FSchema: TpcnSchema;
    FOpcoes: TLeitorOpcoes;
    FVersaoXML: String;
    FProvedor: TnfseProvedor;

    procedure Rps_ProvedorSaatri;
    procedure NFSe_ProvedorSaatri;

    procedure Rps_Demais;
    procedure NFSe_Demais;

    function LerRPS: Boolean;
    function LerNFSe: Boolean;
  public
    constructor Create(AOwner: TNFSe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property NFSe: TNFSe read FNFSe write FNFSe;
    property schema: TpcnSchema read Fschema write Fschema;
    property Opcoes: TLeitorOpcoes read FOpcoes write FOpcoes;
    property VersaoXML: String read FVersaoXML write FVersaoXML;
    property Provedor: TnfseProvedor read FProvedor write FProvedor;
  end;

 TLeitorOpcoes = class(TPersistent)
  private
    FPathArquivoMunicipios: string;
    FPathArquivoTabServicos: string;
  published
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property PathArquivoTabServicos: string read FPathArquivoTabServicos write FPathArquivoTabServicos;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TNFSeR }

constructor TNFSeR.Create(AOwner: TNFSe);
begin
 FLeitor := TLeitor.Create;
 FNFSe   := AOwner;
 FOpcoes := TLeitorOpcoes.Create;
 FOpcoes.FPathArquivoMunicipios  := '';
 FOpcoes.FPathArquivoTabServicos := '';
end;

destructor TNFSeR.Destroy;
begin
 FLeitor.Free;
 FOpcoes.Free;

 inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TNFSeR.Rps_ProvedorSaatri;
var
 item: Integer;
 ok  : Boolean;
begin
 if Leitor.rExtrai(2, 'InfDeclaracaoPrestacaoServico') <> ''
  then begin
   NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');
   NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
   NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
   NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivoFiscal'));

   if (Leitor.rExtrai(3, 'Rps') <> '')
    then begin
     NFSe.DataEmissao := Leitor.rCampo(tcDatHor, 'DataEmissao');
     NFSe.Status      := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

     if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
      then begin
       NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
       NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
       NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
       NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
      end;
    end;

   if (Leitor.rExtrai(3, 'Servico') <> '')
    then begin
     NFSe.Servico.Valores.IssRetido   := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
     NFSe.Servico.ItemListaServico    := NotaUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

     Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
     if Item<100 then Item:=Item*100+1;

     NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
     NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                      Copy(NFSe.Servico.ItemListaServico, 3, 2);

     NFSe.Servico.xItemListaServico   := CodigoToDesc(NFSe.Servico.ItemListaServico);
     NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
     NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
     NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
     NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

     if (Leitor.rExtrai(4, 'Valores') <> '')
      then begin
       NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
       NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
       NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
      end;

    end; // fim serviço

   if (Leitor.rExtrai(3, 'Prestador') <> '')
    then begin
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

    end; // fim Prestador

   if (Leitor.rExtrai(3, 'Tomador') <> '')
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

     if (Leitor.rExtrai(4, 'IdentificacaoTomador') <> '')
      then begin
       NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
         if Leitor.rCampo(tcStr, 'Cpf')<>''
          then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
          else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end;

     if (Leitor.rExtrai(4, 'Endereco') <> '')
      then begin
       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

      end;

     if (Leitor.rExtrai(4, 'Contato') <> '')
      then begin
       NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;

    end; // fim Tomador
  end; // fim InfDeclaracaoPrestacaoServico

end;

procedure TNFSeR.Rps_Demais;
var
 item: Integer;
 ok  : Boolean;
begin
 if Leitor.rExtrai(2, 'InfRps') <> ''
  then begin
   NFSe.DataEmissao              := Leitor.rCampo(tcDatHor, 'DataEmissao');
   NFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
   NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
   NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
   NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));
   NFSe.Status                   := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

   if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
    then begin
     NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
     NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
     NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
     NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
    end;

   if Leitor.rExtrai(3, 'RpsSubstituido') <> ''
    then begin
     NFSe.RpsSubstituido.Numero := Leitor.rCampo(tcStr, 'Numero');
     NFSe.RpsSubstituido.Serie  := Leitor.rCampo(tcStr, 'Serie');
     NFSe.RpsSubstituido.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
    end;

   if (Leitor.rExtrai(3, 'Servico') <> '')
    then begin
     NFSe.Servico.ItemListaServico          := NotaUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));
     NFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, 'CodigoTributacaoMunicipio');
     NFSe.Servico.Discriminacao             := Leitor.rCampo(tcStr, 'Discriminacao');

     if VersaoXML='1'
      then NFSe.Servico.CodigoMunicipio := Leitor.rCampo(tcStr, 'MunicipioPrestacaoServico')
      else NFSe.Servico.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');

     Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
     if Item<100 then Item:=Item*100+1;

     NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
     NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                      Copy(NFSe.Servico.ItemListaServico, 3, 2);

     if length(NFSe.Servico.CodigoMunicipio)<7
      then NFSe.Servico.CodigoMunicipio := Copy(NFSe.Servico.CodigoMunicipio, 1, 2) +
            FormatFloat('00000', StrToIntDef(Copy(NFSe.Servico.CodigoMunicipio, 3, 5), 0));

     NFSe.Servico.xItemListaServico := CodigoToDesc(NFSe.Servico.ItemListaServico);

     if Leitor.rExtrai(4, 'Valores') <> ''
      then begin
       NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
       NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
       NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
       NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
       NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
       NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
       NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
       NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
       NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
       NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
       NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
       NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
       NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
       NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
       NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
       NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
      end;

    end; // fim Servico

   if Leitor.rExtrai(3, 'Prestador') <> ''
    then begin
     NFSe.Prestador.Cnpj               := Leitor.rCampo(tcStr, 'Cnpj');
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    end; // fim Prestador

   if Leitor.rExtrai(3, 'Tomador') <> ''
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

     NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

     NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
     NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

     if VersaoXML='1'
      then begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;

     NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
      then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
            FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

     if NFSe.Tomador.Endereco.UF = ''
      then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

     NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

     if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
      then begin
       NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
         if Leitor.rCampo(tcStr, 'Cpf')<>''
          then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
          else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end;

     if Leitor.rExtrai(4, 'Contato') <> ''
      then begin
       NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;

    end; // fim Tomador

   if Leitor.rExtrai(3, 'IntermediarioServico') <> ''
    then begin
     NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
     NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     if Leitor.rExtrai(4, 'CpfCnpj') <> ''
      then begin
       if Leitor.rCampo(tcStr, 'Cpf')<>''
        then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
        else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

   if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
    then begin
     NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
     NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
    end;

  end; // fim InfRps
end;

function TNFSeR.LerRPS: Boolean;
begin
 FProvedor := proNenhum;

 if Pos('<InfDeclaracaoPrestacaoServico', Leitor.Arquivo) > 0
  then FProvedor := proSaatri;

 if (Leitor.rExtrai(1, 'Rps') <> '')
  then begin
   case FProvedor of
    proSaatri: Rps_ProvedorSaatri;
    else Rps_Demais;
   end;
  end; // fim do Rps

 Result := true;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TNFSeR.NFSe_ProvedorSaatri;
var
 item: Integer;
 ok  : Boolean;
begin
 if Leitor.rExtrai(3, 'ValoresNfse') <> ''
  then begin
   NFSe.Servico.Valores.BaseCalculo      := Leitor.rCampo(tcDe2, 'BaseCalculo');
   NFSe.Servico.Valores.Aliquota         := Leitor.rCampo(tcDe3, 'Aliquota');
   NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
   NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
  end; // fim ValoresNfse

 if Leitor.rExtrai(3, 'PrestadorServico') <> ''
  then begin
   NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

   if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '')
    then begin
     NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

   if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  end; // fim PrestadorServico

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 if Leitor.rExtrai(3, 'DeclaracaoPrestacaoServico') <> ''
  then begin

   if Leitor.rExtrai(4, 'InfDeclaracaoPrestacaoServico') <> ''
    then begin
     NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');
     NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
     NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
     NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivoFiscal'));

     if (Leitor.rExtrai(5, 'Rps') <> '')
      then begin
       NFSe.DataEmissao := Leitor.rCampo(tcDatHor, 'DataEmissao');
       NFSe.Status      := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

       if (Leitor.rExtrai(6, 'IdentificacaoRps') <> '')
        then begin
         NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
         NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
         NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
         NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
        end;
      end;

     if (Leitor.rExtrai(5, 'Servico') <> '')
      then begin
       NFSe.Servico.Valores.IssRetido   := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
       NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
       NFSe.Servico.ItemListaServico    := NotaUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

       Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
       if Item<100 then Item:=Item*100+1;

       NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
       NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                        Copy(NFSe.Servico.ItemListaServico, 3, 2);

       NFSe.Servico.xItemListaServico   := CodigoToDesc(NFSe.Servico.ItemListaServico);
       NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
       NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
       NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
       NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
       NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

       if StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0) = 0
        then begin
         NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSe.Servico.CodigoMunicipio;
         if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
          then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

         NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
        end;

       if (Leitor.rExtrai(6, 'Valores') <> '')
        then begin
         NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
         NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
         NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
         NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
         NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
         NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
         NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
         NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
         NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
         NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
         NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
         NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
        end;

       if NFSe.Servico.Valores.IssRetido = stRetencao
        then NFSe.Servico.Valores.ValorIssRetido := NFSe.Servico.Valores.ValorIss
        else NFSe.Servico.Valores.ValorIssRetido := 0.0;

      end; // fim serviço

     if (Leitor.rExtrai(5, 'Prestador') <> '')
      then begin
       NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if VersaoXML='1'
        then begin
         if Leitor.rExtrai(6, 'CpfCnpj') <> ''
          then begin
            NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
            if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
             then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end
        else begin
         NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;

      end; // fim Prestador

     if (Leitor.rExtrai(5, 'Tomador') <> '')
      then begin
       NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

       if (Leitor.rExtrai(6, 'IdentificacaoTomador') <> '')
        then begin
         NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

         if Leitor.rExtrai(7, 'CpfCnpj') <> ''
          then begin
           if Leitor.rCampo(tcStr, 'Cpf')<>''
            then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
            else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end;

       if (Leitor.rExtrai(6, 'Contato') <> '')
        then begin
         NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
         NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
        end;

      end; // fim Tomador

    end; // fim InfDeclaracaoPrestacaoServico

  end; // fim DeclaracaoPrestacaoServico

end;

procedure TNFSeR.NFSe_Demais;
var
 item: Integer;
 ok  : Boolean;
begin
 if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
  then begin
   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
   NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
  end;

 if (Leitor.rExtrai(3, 'Servico') <> '')
  then begin
   NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
   NFSe.Servico.ItemListaServico    := NotaUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

   Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
   if Item<100 then Item:=Item*100+1;

   NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
   NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                    Copy(NFSe.Servico.ItemListaServico, 3, 2);

   NFSe.Servico.xItemListaServico   := CodigoToDesc(NFSe.Servico.ItemListaServico);
   NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
   NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
   NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
   NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

   if (Leitor.rExtrai(4, 'Valores') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
     NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
     NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
     NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
     NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
     NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
     NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
     NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
     NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
     NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
     NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
     NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
     NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
    end;

  end; // fim serviço

 if Leitor.rExtrai(3, 'PrestadorServico') <> ''
  then begin
   NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

   if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '')
    then begin
     NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

   if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  end; // fim PrestadorServico

 if Leitor.rExtrai(3, 'TomadorServico') <> ''
  then begin
   NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

   NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

   NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
    then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

   if NFSe.Tomador.Endereco.UF = ''
    then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

   NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

   if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

   if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
    then begin
     NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     if Leitor.rExtrai(5, 'CpfCnpj') <> ''
      then begin
       if Leitor.rCampo(tcStr, 'Cpf')<>''
        then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
        else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;
  end;

 if Leitor.rExtrai(3, 'IntermediarioServico') <> ''
  then begin
   NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
   if Leitor.rExtrai(4, 'CpfCnpj') <> ''
    then begin
     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
    end;
  end;

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
  then begin
   NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
   NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
  end;

end;

function TNFSeR.LerNFSe: Boolean;
var
 ok  : Boolean;
begin
 FProvedor := proNenhum;

 if Pos('<DeclaracaoPrestacaoServico', Leitor.Arquivo) > 0
  then FProvedor := proSaatri;

 if (Leitor.rExtrai(1, 'Nfse') <> '')
  then begin
   if Leitor.rExtrai(2, 'InfNfse') <> ''
    then begin
     NFSe.Numero                   := Leitor.rCampo(tcStr, 'Numero');
     NFSe.CodigoVerificacao        := Leitor.rCampo(tcStr, 'CodigoVerificacao');
     NFSe.DataEmissao              := Leitor.rCampo(tcDatHor, 'DataEmissao');
     NFSe.DataEmissaoRps           := Leitor.rCampo(tcDat, 'DataEmissaoRps');
     NFSe.NfseSubstituida          := Leitor.rCampo(tcStr, 'NfseSubstituida');
     NFSe.OutrasInformacoes        := Leitor.rCampo(tcStr, 'OutrasInformacoes');
     NFSe.ValorCredito             := Leitor.rCampo(tcDe2, 'ValorCredito');
     NFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
     NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
     NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
     NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));
     NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');

     case FProvedor of
      proSaatri: NFSe_ProvedorSaatri;
      else NFSe_Demais;
     end;

    end; // fim do infNfse

  end; // fim da Nfse

 if Leitor.rExtrai(1, 'NfseCancelamento') <> ''
  then begin
   NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHora');
   if NFSe.NfseCancelamento.DataHora = 0
    then NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHoraCancelamento');
  end;

 Result := True;
end;

function TNFSeR.LerXml: boolean;
begin
 Result := False;

 if Pos('<Rps', Leitor.Arquivo) > 0
  then Result := LerRPS;

 if Pos('<Nfse', Leitor.Arquivo) > 0
  then Result := LerNFSe;

 // Grupo da TAG <signature> ***************************************************
 Leitor.Grupo := Leitor.Arquivo;

 NFSe.signature.URI             := Leitor.rAtributo('Reference URI=');
 NFSe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
 NFSe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
 NFSe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

end;

end.

