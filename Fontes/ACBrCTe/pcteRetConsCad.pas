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


unit pcteRetConsCad;

interface uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor;

type

  //////////////////////////////////////////////////////////////////////////////
  //                                                                          //
  //    E M   D E S E N V O L V I M E N T O   -   N Ã O   T E S T A D O       //
  //                                                                          //
  //////////////////////////////////////////////////////////////////////////////

  TRetConsCad = class;
  TInfCadCollection = class;
  TInfCadCollectionItem = class;

  TRetConsCad = class(TPersistent)
  private
    FLeitor: TLeitor;
    FverAplic: string;
    FcStat: integer;
    FxMotivo: string;
    FUF: string;
    FIE: string;
    FCNPJ: string;
    FCPF: string;
    FdhCons: TDateTime;
    FcUF: integer;
    FInfCad: TInfCadCollection;
    procedure SetInfCad(const Value: TInfCadCollection);
  public
    constructor Create;
    destructor Destroy; override;
    function LerXML: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property verAplic: string read FverAplic write FverAplic;
    property cStat: integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property UF: string read FUF write FUF;
    property IE: string read FIE write FIE;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
    property dhCons: TDateTime read FdhCons write FdhCons;
    property cUF: integer read FcUF write FcUF;
    property InfCad: TInfCadCollection read FInfCad write SetInfCad;
  end;

  TInfCadCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfCadCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfCadCollectionItem);
  public
    constructor Create(AOwner: TRetConsCad); reintroduce;
    function Add: TInfCadCollectionItem;
    property Items[Index: Integer]: TInfCadCollectionItem read GetItem write SetItem; default;
  end;

  TInfCadCollectionItem = class(TCollectionItem)
  private
    FIE: string;
    FCNPJ: string;
    FCPF: string;
    FUF: string;
    FcSit: integer;
    FxNome: string;
  published
    property IE: string read FIE write FIE;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
    property UF: string read FUF write FUF;
    property cSit: integer read FcSit write FcSit;
    property xNome: string read FxNome write FxNome;
  end;

implementation

{ RetConsCad }

constructor TRetConsCad.Create;
begin
  FLeitor := TLeitor.Create;
  FInfCad := TInfCadCollection.Create(Self);
end;

destructor TRetConsCad.Destroy;
begin
  FLeitor.Free;
  FInfCad.Free;
  inherited;
end;

procedure TRetConsCad.SetInfCad(const Value: TInfCadCollection);
begin
  FInfCad.Assign(Value);
end;

{ TInfCadCollection }

constructor TInfCadCollection.Create(AOwner: TRetConsCad);
begin
  inherited Create(TInfCadCollectionItem);
end;

function TInfCadCollection.Add: TInfCadCollectionItem;
begin
  Result := TInfCadCollectionItem(inherited Add);
end;

function TInfCadCollection.GetItem(Index: Integer): TInfCadCollectionItem;
begin
  Result := TInfCadCollectionItem(inherited GetItem(Index));
end;

procedure TInfCadCollection.SetItem(Index: Integer; Value: TInfCadCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

////////////////////////////////////////////////////////////////////////////////

function TRetConsCad.LerXML: boolean;
var
  i: integer;
begin
  i := 0; 
  Result := False;
  try
    if Leitor.rExtrai(1, 'infCons') <> '' then
    begin
      (*GR04 *)FverAplic := Leitor.rCampo(tcStr, 'verAplic');
      (*GR05 *)FcStat := Leitor.rCampo(tcInt, 'cStat');
      (*GR06 *)FxMotivo := Leitor.rCampo(tcStr, 'xMotivo');
      (*GR06a*)FUF := Leitor.rCampo(tcStr, 'UF');
      (*GR06b*)FIE := Leitor.rCampo(tcStr, 'IE');
      (*GR06c*)FCNPJ := Leitor.rCampo(tcStr, 'CNPJ');
      (*GR06d*)FCPF := Leitor.rCampo(tcStr, 'CPF');
      (*GR06e*)FdhCons := Leitor.rCampo(tcDatHor, 'dhCons');
      (*GR06f*)FcUF := Leitor.rCampo(tcInt, 'cUF');
      if Leitor.rExtrai(2, 'infCad', '', i + 1) = ''  then
         InfCad.Add;
      i := 0;
      while Leitor.rExtrai(2, 'infCad', '', i + 1) <> '' do
      begin
        InfCad.Add;
        (*GR08*)InfCad[i].FIE := Leitor.rCampo(tcStr, 'IE');
        (*GR09*)InfCad[i].FCNPJ := Leitor.rCampo(tcStr, 'CNPJ');
        (*GR10*)InfCad[i].FCPF := Leitor.rCampo(tcStr, 'CPF');
        (*GR11*)InfCad[i].FUF := Leitor.rCampo(tcStr, 'UF');
        (*GR12*)InfCad[i].FcSit := Leitor.rCampo(tcInt, 'cSit');
        (*GR13*)InfCad[i].FxNome := Leitor.rCampo(tcStr, 'xNome');
        inc(i);
      end;
      Result := True;
    end;
  except
    Result := False;
  end;
end;
end.

