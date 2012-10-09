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
//    FIdentificador: String;
    FVersaoXML: String;

    function ObterNomeMunicipio(xUF: string; const cMun: integer): string;
    function ObterDescricaoServico(cCodigo: string): string;
  public
    constructor Create(AOwner: TNFSe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property NFSe: TNFSe read FNFSe write FNFSe;
    property schema: TpcnSchema read Fschema write Fschema;
    property Opcoes: TLeitorOpcoes read FOpcoes write FOpcoes;
//    property Identificador: String read FIdentificador write FIdentificador;
    property VersaoXML: String read FVersaoXML write FVersaoXML;
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

function TNFSeR.LerXml: boolean;
var
 i, j, Item: integer;
 ok        : boolean;
begin
 // Grupo da TAG <Nfse> *************************************************
 // ou
 // Grupo da TAG <Rps> **************************************************
 if (Leitor.rExtrai(1, 'Nfse') <> '') or (Leitor.rExtrai(1, 'Rps') <> '')
  then begin
   // Grupo da TAG <InfRps> *****************************************************
   if Leitor.rExtrai(2, 'InfRps') <> ''
    then begin
     NFSe.DataEmissao              := Leitor.rCampo(tcDatHor, 'DataEmissao');
     NFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
     NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
     NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
     NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));
     NFSe.Status                   := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));
    end;

   // Grupo da TAG <InfNfse> *****************************************************
   if Leitor.rExtrai(2, 'InfNfse') <> ''
    then begin
     NFSe.Numero            := Leitor.rCampo(tcStr, 'Numero');
     NFSe.CodigoVerificacao := Leitor.rCampo(tcStr, 'CodigoVerificacao');
     NFSe.DataEmissao       := Leitor.rCampo(tcDatHor, 'DataEmissao');

     NFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
     NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
     NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
     NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));

     NFSe.Competencia       := Leitor.rCampo(tcStr, 'Competencia');
     NFSe.NfseSubstituida   := Leitor.rCampo(tcStr, 'NfseSubstituida');
     NFSe.OutrasInformacoes := Leitor.rCampo(tcStr, 'OutrasInformacoes');
     NFSe.ValorCredito      := Leitor.rCampo(tcDe2, 'ValorCredito');
    end;

   // Grupo da TAG <IdentificacaoRps> ********************************************
   if Leitor.rExtrai(3, 'IdentificacaoRps') <> ''
    then begin
     NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
     NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
     NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
     NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
    end;

   // Grupo da TAG <RpsSubstituido> **********************************************
   if Leitor.rExtrai(3, 'RpsSubstituido') <> ''
    then begin
     NFSe.RpsSubstituido.Numero := Leitor.rCampo(tcStr, 'Numero');
     NFSe.RpsSubstituido.Serie  := Leitor.rCampo(tcStr, 'Serie');
     NFSe.RpsSubstituido.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
    end;

   // Grupo da TAG <Servico> *****************************************************
   if Leitor.rExtrai(3, 'Servico') <> ''
    then begin
     NFSe.Servico.ItemListaServico          := NotaUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));
     NFSe.Servico.CodigoCnae                := Leitor.rCampo(tcStr, 'CodigoCnae');
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

     NFSe.Servico.xItemListaServico := ObterDescricaoServico(NFSe.Servico.ItemListaServico);

     if Leitor.rExtrai(4, 'Valores') <> ''
      then begin
       NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
       NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
       NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
       NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
       NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
       NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
       NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
       NFSe.Servico.Valores.IssRetido              := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IssRetido'));
       NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
       NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
       NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
       NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
       NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
       NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
       NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
       NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
      end;
    end;

   // Grupo da TAG <PrestadorServico> ********************************************
   if Leitor.rExtrai(3, 'PrestadorServico') <> ''
    then begin
     NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
     NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

     NFSe.PrestadorServico.Endereco.Endereco        := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);
     NFSe.PrestadorServico.Endereco.Numero          := Leitor.rCampo(tcStr, 'Numero');
     NFSe.PrestadorServico.Endereco.Complemento     := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.PrestadorServico.Endereco.Bairro          := Leitor.rCampo(tcStr, 'Bairro');
     if VersaoXML='1'
      then begin
       NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;
     NFSe.PrestadorServico.Endereco.CEP             := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
      then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
             FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

     NFSe.PrestadorServico.Endereco.xMunicipio := UpperCase(TiraAcentos(Utf8ToAnsi(ObterNomeMunicipio(NFSe.PrestadorServico.Endereco.UF,
                                                         StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0)))));

     if Leitor.rExtrai(4, 'IdentificacaoPrestador') <> ''
      then begin
       if VersaoXML='1'
        then begin
         if Leitor.rExtrai(5, 'CpfCnpj') <> ''
          then begin
            NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
            if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
             then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end
        else NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
       NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
      end;
     if Leitor.rExtrai(4, 'Contato') <> ''
      then begin
       NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;
    end;

   // Grupo da TAG <Prestador> ***************************************************
   if Leitor.rExtrai(3, 'Prestador') <> ''
    then begin
     NFSe.Prestador.Cnpj               := Leitor.rCampo(tcStr, 'Cnpj');
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    end;

   // Grupo da TAG <TomadorServico> **********************************************
   if Leitor.rExtrai(3, 'TomadorServico') <> ''
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

     NFSe.Tomador.Endereco.Endereco        := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);
     NFSe.Tomador.Endereco.Numero          := Leitor.rCampo(tcStr, 'Numero');
     NFSe.Tomador.Endereco.Complemento     := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.Tomador.Endereco.Bairro          := Leitor.rCampo(tcStr, 'Bairro');
     if VersaoXML='1'
      then begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;
     NFSe.Tomador.Endereco.CEP             := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
      then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
            FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

     if NFSe.Tomador.Endereco.UF = ''
      then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

     NFSe.Tomador.Endereco.xMunicipio := UpperCase(TiraAcentos(Utf8ToAnsi(ObterNomeMunicipio(NFSe.Tomador.Endereco.UF,
                                                           StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0)))));

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

   // Grupo da TAG <Tomador> *****************************************************
   if Leitor.rExtrai(3, 'Tomador') <> ''
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

     NFSe.Tomador.Endereco.Endereco        := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);
     NFSe.Tomador.Endereco.Numero          := Leitor.rCampo(tcStr, 'Numero');
     NFSe.Tomador.Endereco.Complemento     := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.Tomador.Endereco.Bairro          := Leitor.rCampo(tcStr, 'Bairro');
     if VersaoXML='1'
      then begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;
     NFSe.Tomador.Endereco.CEP             := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
      then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
            FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

     if NFSe.Tomador.Endereco.UF = ''
      then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

     NFSe.Tomador.Endereco.xMunicipio := UpperCase(TiraAcentos(Utf8ToAnsi(ObterNomeMunicipio(NFSe.Tomador.Endereco.UF,
                                                           StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0)))));

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

   // Grupo da TAG <IntermediarioServico> ****************************************
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

   // Grupo da TAG <OrgaoGerador> ************************************************
   if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
    then begin
     NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
    end;

   // Grupo da TAG <ConstrucaoCivil> *********************************************
   if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
    then begin
     NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
     NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
    end;

  end;

 // Grupo da TAG <NfseCancelamento***************************************
 if Leitor.rExtrai(1, 'NfseCancelamento') <> ''
  then begin
   NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHora');
   if NFSe.NfseCancelamento.DataHora = 0
    then NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHoraCancelamento');
  end;

 // Grupo da TAG <signature> ***************************************************

 Leitor.Grupo := Leitor.Arquivo;

 NFSe.signature.URI             := Leitor.rAtributo('Reference URI=');
 NFSe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
 NFSe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
 NFSe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

 Result := true;
end;

function TNFSeR.ObterNomeMunicipio(xUF: string; const cMun: integer): string;
var
 i                   : integer;
 PathArquivo, Codigo : string;
 List                : TstringList;
begin
 result := '';

 if FOpcoes.FPathArquivoMunicipios = ''
  then FOpcoes.FPathArquivoMunicipios := NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName)) + 'MunIBGE\';

 PathArquivo := FOpcoes.FPathArquivoMunicipios + 'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
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

function TNFSeR.ObterDescricaoServico(cCodigo: string): string;
var
 i           : integer;
 PathArquivo : string;
 List        : TstringList;
begin
 result := '';

 if FOpcoes.FPathArquivoTabServicos = ''
  then FOpcoes.FPathArquivoTabServicos := NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName)) + 'TabServicos\';

 PathArquivo := FOpcoes.FPathArquivoTabServicos + 'TabServicos.txt';
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

end.

