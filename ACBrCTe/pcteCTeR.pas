////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar CTe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da CTe          //
//                                                                            //
//        site: www.projetocooperar.org/CTe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_CTe/        //
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
//              "PCN  -  Projeto  Cooperar  CTe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

unit pcteCTeR;

interface uses

  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor, pcteCTe;

type

  TCTeR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FCTe: TCTe;
    FSchema: TpcnSchema;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property CTe: TCTe read FCTe write FCTe;
    property schema: TpcnSchema read Fschema write Fschema;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TCTeR }

constructor TCTeR.Create(AOwner: TCTe);
begin
  FLeitor := TLeitor.Create;
  FCTe := AOwner;
end;

destructor TCTeR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TCTeR.LerXml: boolean;
var
  ok: boolean;
  i, j, k: integer;
begin

  I := 0;
  I := RetornarPosEx('Id=', Leitor.Arquivo, I + 6);
  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: Id=');
  I := RetornarPosEx('"', Leitor.Arquivo, I + 2);
  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: aspas inicial');
  J := RetornarPosEx('"', Leitor.Arquivo, I + 1);
  if J = 0 then
    raise Exception.Create('Não encontrei inicio do URI: aspas final');

  CTe.infCTe.ID := copy(Leitor.Arquivo, I + 4, J - I - 4);

  (* Grupo da TAG <ide> *******************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    (*B02*)CTe.Ide.cUF    := Leitor.rCampo(tcInt, 'cUF');
    (*B03*)CTe.Ide.cCT    := Leitor.rCampo(tcStr, 'cNF');
    (*B04*)CTe.Ide.CFOP   := Leitor.rCampo(tcStr, 'CFOP');
    (*B05*)CTe.Ide.natOp  := Leitor.rCampo(tcStr, 'natOp');
    (*B06*)CTe.Ide.forPag := StrTotpforPag(ok, Leitor.rCampo(tcStr, 'forPag'));
    (*B07*)CTe.Ide.modelo := Leitor.rCampo(tcStr, 'mod');
    (*B08*)CTe.Ide.serie  := Leitor.rCampo(tcInt, 'serie');
    (*B09*)CTe.Ide.nCT    := Leitor.rCampo(tcInt, 'nCT');
    (*B10*)CTe.Ide.dhEmi  := Leitor.rCampo(tcDatHor, 'dhEmi');
    (*B11*)CTe.Ide.tpImp  := StrToTpImp(ok, Leitor.rCampo(tcStr, 'tpImp'));
    (*B12*)CTe.Ide.tpEmis := StrToTpEmis(ok, Leitor.rCampo(tcStr, 'tpEmis'));
    (*B13*)CTe.Ide.cDV    := Leitor.rCampo(tcInt, 'cDV');
    (*B14*)CTe.Ide.tpAmb  := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    (*B15*)CTe.Ide.tpCTe  := StrTotpCTe(ok, Leitor.rCampo(tcStr, 'tpCTe'));
    (*B15a*)CTe.Ide.procEmi := StrToprocEmi(ok, Leitor.rCampo(tcStr, 'procEmi'));
    (*B15b*)CTe.Ide.verProc := Leitor.rCampo(tcStr, 'verProc');
    (*B15c*)CTe.Ide.refCTE  := Leitor.rCampo(tcStr, 'refCTE');
    (*B16*)CTe.Ide.cMunEmi := Leitor.rCampo(tcInt, 'cMunEmi');
    (*B17*)CTe.Ide.xMunEmi := Leitor.rCampo(tcStr, 'xMunEmi');
    (*B18*)CTe.Ide.UFEmi   := Leitor.rCampo(tcStr, 'UFEmi');
    (*B19*)CTe.Ide.modal   := StrToTpModal(ok, Leitor.rCampo(tcStr, 'modal'));
    (*B20*)CTe.Ide.tpServ  := StrToTpServ(ok, Leitor.rCampo(tcStr, 'tpServ'));
    (*B21*)CTe.Ide.cMunIni := Leitor.rCampo(tcInt, 'cMunIni');
    (*B22*)CTe.Ide.xMunIni := Leitor.rCampo(tcStr, 'xMunIni');
    (*B23*)CTe.Ide.UFIni   := Leitor.rCampo(tcStr, 'UFIni');
    (*B24*)CTe.Ide.cMunFim := Leitor.rCampo(tcInt, 'cMunFim');
    (*B25*)CTe.Ide.xMunFim := Leitor.rCampo(tcStr, 'xMunFim');
    (*B26*)CTe.Ide.UFFim   := Leitor.rCampo(tcStr, 'UFFim');
    (*B27*)CTe.Ide.retira  := StrToTpRetira(ok, Leitor.rCampo(tcStr, 'retira'));
    (*B27a*)CTe.Ide.xdetretira := Leitor.rCampo(tcStr, 'xdetretira');
  end;

  (* Grupo da TAG <ide><toma03> *)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma03') <> '' then
    begin
      (*B29*)CTe.Ide.Toma03.Toma := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
    end;
  end;

  (* Grupo da TAG <ide><toma4> *)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma4') <> '' then
    begin
      (*B29*)CTe.Ide.Toma4.toma := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
      (*B31*)CTe.Ide.Toma4.CNPJCPF := Leitor.rCampoCNPJCPF;
      (*B33*)CTe.Ide.Toma4.IE    := Leitor.rCampo(tcStr, 'IE');
      (*B34*)CTe.Ide.Toma4.xNome := Leitor.rCampo(tcStr, 'xNome');
      (*B35*)CTe.Ide.Toma4.xFant := Leitor.rCampo(tcStr, 'xFant');
       if Leitor.rExtrai(3, 'enderToma') <> '' then
        begin
          (*B37*)CTe.Ide.Toma4.EnderToma.xLgr  := Leitor.rCampo(tcStr, 'xLgr');
          (*B37*)CTe.Ide.Toma4.EnderToma.xNum  := Leitor.rCampo(tcStr, 'xNum');
          (*B37*)CTe.Ide.Toma4.EnderToma.xCpl  := Leitor.rCampo(tcStr, 'xCpl');
          (*B37*)CTe.Ide.Toma4.EnderToma.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          (*B37*)CTe.Ide.Toma4.EnderToma.cMun  := Leitor.rCampo(tcInt, 'cMun');
          (*B37*)CTe.Ide.Toma4.EnderToma.xMun  := Leitor.rCampo(tcStr, 'xMun');
          (*B37*)CTe.Ide.Toma4.EnderToma.CEP   := Leitor.rCampo(tcInt, 'CEP');
          (*B37*)CTe.Ide.Toma4.EnderToma.UF    := Leitor.rCampo(tcStr, 'UF');
          (*B37*)CTe.Ide.Toma4.EnderToma.cPais := Leitor.rCampo(tcInt, 'cPais');
          (*B37*)CTe.Ide.Toma4.EnderToma.xPais := Leitor.rCampo(tcStr, 'xPais');
        end;
    end;
  end;


  (* Grupo da TAG <signature> *************************************************)

  leitor.Grupo := Leitor.Arquivo;

  CTe.signature.URI := Leitor.rAtributo('Reference URI=');
  CTe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
  CTe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
  CTe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
  Result := true;

end;
end.

