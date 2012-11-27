////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcteEnvEventoCTe;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnGerador, pcnLeitor, pcteEventoCTe;

type
  TInfEventoCollection  = class;
  TInfEventoCollectionItem = class;
  TEventoCTe = class;
  EventoException = class(Exception);

  TInfEventoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfEventoCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TInfEventoCollectionItem;
    property Items[Index: Integer]: TInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  TInfEventoCollectionItem = class(TCollectionItem)
  private
    FInfEvento: TInfEvento;
    FRetInfEvento: TRetInfEvento;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property InfEvento: TInfEvento read FInfEvento write FInfEvento;
    property RetInfEvento: TRetInfEvento read FRetInfEvento write FRetInfEvento;
  end;

  TEventoCTe = class(TPersistent)
  private
    FGerador: TGerador;
    FidLote: Integer;
    FEvento: TInfEventoCollection;
    procedure SetEvento(const Value: TInfEventoCollection);
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: boolean;
    function LerXML(CaminhoArquivo: string): boolean;
    function ObterNomeArquivo(tpEvento: TpcnTpEvento): string;
  published
    property Gerador: TGerador             read FGerador write FGerador;
    property idLote: Integer               read FidLote  write FidLote;
    property Evento: TInfEventoCollection  read FEvento  write SetEvento;
  end;

implementation

uses
 pcteRetEnvEventoCTe;

{ TEventoCTe }

constructor TEventoCTe.Create;
begin
  FGerador   := TGerador.Create;
  FEvento    := TInfEventoCollection.Create(Self);
end;

destructor TEventoCTe.Destroy;
begin
  FGerador.Free;
  FEvento.Free;
  inherited;
end;

function TEventoCTe.ObterNomeArquivo(tpEvento: TpcnTpEvento): string;
begin
 case tpEvento of
    teCancelamento : Result := Evento.Items[0].InfEvento.chCTe + '-can-eve.xml'; // Cancelamento da CTe como Evento
    teEncerramento : Result := Evento.Items[0].InfEvento.chCTe + '-ped-eve.xml'; // Encerramento
  else
    raise EventoException.Create('Obter nome do arquivo de Evento não Implementado!');
 end;
end;

function TEventoCTe.GerarXML: boolean;
var
  sDoc : String;
begin
  Gerador.ArquivoFormatoXML := '';
  Gerador.wGrupo('eventoCTe ' + NAME_SPACE_CTe + ' versao="' + CTeEventoCTe + '"');

  Evento.Items[0].InfEvento.id := 'ID'+ Evento.Items[0].InfEvento.TipoEvento +
                                        SomenteNumeros(Evento.Items[0].InfEvento.chCTe) +
                                        Format('%.2d', [Evento.Items[0].InfEvento.nSeqEvento]);

  Gerador.wGrupo('infEvento Id="' + Evento.Items[0].InfEvento.id + '"');
  if Length(Evento.Items[0].InfEvento.id) < 54
   then Gerador.wAlerta('EP04', 'ID', '', 'ID de Evento inválido');

  Gerador.wCampo(tcInt, 'EP05', 'cOrgao', 1, 2, 1, Evento.Items[0].InfEvento.cOrgao);
  Gerador.wCampo(tcStr, 'EP06', 'tpAmb ', 1, 1, 1, TpAmbToStr(Evento.Items[0].InfEvento.tpAmb), DSC_TPAMB);

  sDoc := SomenteNumeros( Evento.Items[0].InfEvento.CNPJ );

  case Length( sDoc ) of
    14 : begin
          Gerador.wCampo(tcStr, 'EP07', 'CNPJ', 14, 14, 1, sDoc , DSC_CNPJ);
          if not ValidarCNPJ( sDoc ) then Gerador.wAlerta('HP10', 'CNPJ', DSC_CNPJ, ERR_MSG_INVALIDO);
         end;
    11 : begin
          Gerador.wCampo(tcStr, 'EP07', 'CPF ', 11, 11, 1, sDoc, DSC_CPF);
          if not ValidarCPF( sDoc ) then Gerador.wAlerta('HP11', 'CPF', DSC_CPF, ERR_MSG_INVALIDO);
         end;
  end;

  Gerador.wCampo(tcStr, 'EP08', 'chCTe', 44, 44, 1, Evento.Items[0].InfEvento.chCTe, DSC_CHAVE);

  if not ValidarChave('NFe' + SomenteNumeros(Evento.Items[0].InfEvento.chCTe))
   then Gerador.wAlerta('EP08', 'chCTe', '', 'Chave de CTe inválida');

  // Segundo o manual a data deve conter o UTC mas no schema não contem
  Gerador.wCampo(tcStr, 'EP09', 'dhEvento', 01, 27,   1, FormatDateTime('yyyy-mm-dd"T"hh:nn:ss',Evento.Items[0].InfEvento.dhEvento)
                                                           {+ GetUTC( CodigoParaUF(Evento.Items[0].InfEvento.cOrgao),
                                                                     Evento.Items[0].InfEvento.dhEvento)} );

  Gerador.wCampo(tcInt, 'EP10', 'tpEvento  ', 6, 6, 1, Evento.Items[0].InfEvento.TipoEvento);
  Gerador.wCampo(tcInt, 'EP11', 'nSeqEvento', 1, 2, 1, Evento.Items[0].InfEvento.nSeqEvento);

  Gerador.wGrupo('detEvento versaoEvento="' + CTeEventoCTe + '"');
  case Evento.Items[0].InfEvento.tpEvento of
   teCancelamento:
     begin
       Gerador.wGrupo('evCancCTe');
       Gerador.wCampo(tcStr, 'EP02', 'descEvento', 005, 012, 1, Evento.Items[0].InfEvento.DescEvento);
       Gerador.wCampo(tcStr, 'EP03', 'nProt     ', 015, 015, 1, Evento.Items[0].InfEvento.detEvento.nProt);
       Gerador.wCampo(tcStr, 'EP04', 'xJust     ', 015, 255, 1, Evento.Items[0].InfEvento.detEvento.xJust);
       Gerador.wGrupo('/evCancCTe');
     end;
   teEncerramento:
     begin
       Gerador.wGrupo('evEncCTe');
       Gerador.wCampo(tcStr, 'EP02', 'descEvento', 05, 12, 1, Evento.Items[0].InfEvento.DescEvento);
       Gerador.wCampo(tcStr, 'EP03', 'nProt     ', 15, 15, 1, Evento.Items[0].InfEvento.detEvento.nProt);
       Gerador.wCampo(tcDat, 'EP04', 'dtEnc     ', 10, 10, 1, Evento.Items[0].InfEvento.detEvento.dtEnc);
       Gerador.wCampo(tcInt, 'EP05', 'cUF       ', 02, 02, 1, Evento.Items[0].InfEvento.detEvento.cUF);
       Gerador.wCampo(tcInt, 'EP06', 'cMun      ', 07, 07, 1, Evento.Items[0].InfEvento.detEvento.cMun);
       Gerador.wGrupo('/evEncCTe');
     end;
  end;
  Gerador.wGrupo('/detEvento');
  Gerador.wGrupo('/infEvento');
  Gerador.wGrupo('/eventoCTe');

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TEventoCTe.SetEvento(const Value: TInfEventoCollection);
begin
  FEvento.Assign(Value);
end;

function TEventoCTe.LerXML(CaminhoArquivo: string): boolean;
var
  ArqEvento    : TStringList;
  RetEventoCTe : TRetEventoCTe;
begin
  ArqEvento := TStringList.Create;
  RetEventoCTe := TRetEventoCTe.Create;
  Result := False;
  try
     ArqEvento.LoadFromFile(CaminhoArquivo);
     RetEventoCTe.Leitor.Arquivo := ArqEvento.Text;
     RetEventoCTe.LerXml;
     with FEvento.Add do
      begin
         infEvento.ID         := RetEventoCTe.InfEvento.id;
         InfEvento.cOrgao     := RetEventoCTe.InfEvento.cOrgao;
         infEvento.tpAmb      := RetEventoCTe.InfEvento.tpAmb;
         infEvento.CNPJ       := RetEventoCTe.InfEvento.CNPJ;
         infEvento.chCTe      := RetEventoCTe.InfEvento.chCTe;
         infEvento.dhEvento   := RetEventoCTe.InfEvento.dhEvento;
         infEvento.tpEvento   := RetEventoCTe.InfEvento.tpEvento;
         infEvento.nSeqEvento := RetEventoCTe.InfEvento.nSeqEvento;

         infEvento.VersaoEvento         := RetEventoCTe.InfEvento.VersaoEvento;
         infEvento.detEvento.descEvento := RetEventoCTe.InfEvento.detEvento.descEvento;
         infEvento.detEvento.nProt      := RetEventoCTe.InfEvento.detEvento.nProt;
         infEvento.detEvento.dtEnc      := RetEventoCTe.InfEvento.detEvento.dtEnc;
         infEvento.detEvento.cUF        := RetEventoCTe.InfEvento.detEvento.cUF;
         infEvento.detEvento.cMun       := RetEventoCTe.InfEvento.detEvento.cMun;
         infEvento.detEvento.xJust      := RetEventoCTe.InfEvento.DetEvento.xJust;

        if RetEventoCTe.retEvento.Count > 0 then
         begin
           FRetInfEvento.Id          := RetEventoCTe.retEvento.Items[0].RetInfEvento.Id;
           FRetInfEvento.tpAmb       := RetEventoCTe.retEvento.Items[0].RetInfEvento.tpAmb;
           FRetInfEvento.verAplic    := RetEventoCTe.retEvento.Items[0].RetInfEvento.verAplic;
           FRetInfEvento.cOrgao      := RetEventoCTe.retEvento.Items[0].RetInfEvento.cOrgao;
           FRetInfEvento.cStat       := RetEventoCTe.retEvento.Items[0].RetInfEvento.cStat;
           FRetInfEvento.xMotivo     := RetEventoCTe.retEvento.Items[0].RetInfEvento.xMotivo;
           FRetInfEvento.chCTe       := RetEventoCTe.retEvento.Items[0].RetInfEvento.chCTe;
           FRetInfEvento.tpEvento    := RetEventoCTe.retEvento.Items[0].RetInfEvento.tpEvento;
           FRetInfEvento.xEvento     := RetEventoCTe.retEvento.Items[0].RetInfEvento.xEvento;
           FRetInfEvento.nSeqEvento  := RetEventoCTe.retEvento.Items[0].RetInfEvento.nSeqEvento;
           FRetInfEvento.CNPJDest    := RetEventoCTe.retEvento.Items[0].RetInfEvento.CNPJDest;
           FRetInfEvento.emailDest   := RetEventoCTe.retEvento.Items[0].RetInfEvento.emailDest;
           FRetInfEvento.dhRegEvento := RetEventoCTe.retEvento.Items[0].RetInfEvento.dhRegEvento;
           FRetInfEvento.nProt       := RetEventoCTe.retEvento.Items[0].RetInfEvento.nProt;
         end;
      end;
     Result := True;
  finally
     ArqEvento.Free;
     RetEventoCTe.Free;
  end;
end;

{ TInfEventoCollection }

function TInfEventoCollection.Add: TInfEventoCollectionItem;
begin
  Result := TInfEventoCollectionItem(inherited Add);
  Result.create;
end;

constructor TInfEventoCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TInfEventoCollectionItem);
end;

function TInfEventoCollection.GetItem(
  Index: Integer): TInfEventoCollectionItem;
begin
  Result := TInfEventoCollectionItem(inherited GetItem(Index));
end;

procedure TInfEventoCollection.SetItem(Index: Integer;
  Value: TInfEventoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfEventoCollectionItem }

constructor TInfEventoCollectionItem.Create;
begin
  FInfEvento := TInfEvento.Create;
  FRetInfEvento := TRetInfEvento.Create;
end;

destructor TInfEventoCollectionItem.Destroy;
begin
  FInfEvento.Free;
  FRetInfEvento.Free;
  inherited;
end;

end.
