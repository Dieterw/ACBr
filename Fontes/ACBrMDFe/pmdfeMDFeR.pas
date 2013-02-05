{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}

{$I ACBr.inc}

unit pmdfeMDFeR;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor,
  pmdfeConversao, pmdfeMDFe;

type

  TMDFeR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FMDFe: TMDFe;
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property MDFe: TMDFe read FMDFe write FMDFe;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TMDFeR }

constructor TMDFeR.Create(AOwner: TMDFe);
begin
  FLeitor := TLeitor.Create;
  FMDFe := AOwner;
end;

destructor TMDFeR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TMDFeR.LerXml: boolean;
var
  ok: boolean;
  i, j, i01, i02: integer;
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

  // MDFe.infMDFe.ID := copy(Leitor.Arquivo, I + 4, J - I - 4);
  MDFe.infMDFe.ID := copy(Leitor.Arquivo, I + 1, J - I -1);

  (* Grupo da TAG <ide> *******************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    MDFe.Ide.cUF     := Leitor.rCampo(tcInt, 'cUF');
    MDFe.Ide.tpAmb   := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    MDFe.Ide.tpEmit  := StrToTpEmitente(ok, Leitor.rCampo(tcStr, 'tpEmit'));
    MDFe.Ide.modelo  := Leitor.rCampo(tcStr, 'mod');
    MDFe.Ide.serie   := Leitor.rCampo(tcInt, 'serie');
    MDFe.Ide.nMDF    := Leitor.rCampo(tcInt, 'nMDF');
    MDFe.Ide.cMDF    := Leitor.rCampo(tcStr, 'cMDF');
    MDFe.Ide.cDV     := Leitor.rCampo(tcInt, 'cDV');
    MDFe.Ide.modal   := StrToModal(ok, Leitor.rCampo(tcStr, 'modal'));
    MDFe.Ide.dhEmi   := Leitor.rCampo(tcDatHor, 'dhEmi');
    MDFe.Ide.tpEmis  := StrToTpEmis(ok, Leitor.rCampo(tcStr, 'tpEmis'));
    MDFe.Ide.procEmi := StrToprocEmi(ok, Leitor.rCampo(tcStr, 'procEmi'));
    MDFe.Ide.verProc := Leitor.rCampo(tcStr, 'verProc');
    MDFe.Ide.UFIni   := Leitor.rCampo(tcStr, 'UFIni');
    MDFe.Ide.UFFim   := Leitor.rCampo(tcStr, 'UFFim');

    i01 := 0;
    while Leitor.rExtrai(2, 'infMunCarrega', '', i01 + 1) <> '' do
    begin
      MDFe.Ide.infMunCarrega.Add;
      MDFe.Ide.infMunCarrega[i01].cMunCarrega := Leitor.rCampo(tcInt, 'cMunCarrega');
      MDFe.Ide.infMunCarrega[i01].xMunCarrega := Leitor.rCampo(tcStr, 'xMunCarrega');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'infPercurso', '', i01 + 1) <> '' do
    begin
      MDFe.Ide.infPercurso.Add;
      MDFe.Ide.infPercurso[i01].UFPer := Leitor.rCampo(tcStr, 'UFPer');
      inc(i01);
    end;

  end;

  (* Grupo da TAG <emit> ******************************************************)
  if Leitor.rExtrai(1, 'emit') <> '' then
  begin
    MDFe.emit.CNPJ  := Leitor.rCampo(tcStr,'CNPJ');
    MDFe.emit.IE    := Leitor.rCampo(tcStr, 'IE');
    MDFe.emit.xNome := Leitor.rCampo(tcStr, 'xNome');
    MDFe.emit.xFant := Leitor.rCampo(tcStr, 'xFant');

    if Leitor.rExtrai(2, 'enderEmit') <> '' then
    begin
      MDFe.emit.enderemit.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      MDFe.emit.enderemit.Nro     := Leitor.rCampo(tcStr, 'nro');
      MDFe.emit.enderemit.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      MDFe.emit.enderemit.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      MDFe.emit.enderemit.cMun    := Leitor.rCampo(tcInt, 'cMun');
      MDFe.emit.enderemit.xMun    := Leitor.rCampo(tcStr, 'xMun');
      MDFe.emit.enderemit.CEP     := Leitor.rCampo(tcInt, 'CEP');
      MDFe.emit.enderemit.UF      := Leitor.rCampo(tcStr, 'UF');
      MDFe.emit.enderemit.fone    := Leitor.rCampo(tcStr, 'fone');
      MDFe.emit.enderemit.email   := Leitor.rCampo(tcStr, 'email');
    end;
  end;

  (* Grupo da TAG <rodo> ******************************************************)
  if Leitor.rExtrai(1, 'infModal') <> '' then
  begin
    if Leitor.rExtrai(2, 'rodo') <> '' then
     begin
      MDFe.Rodo.RNTRC := Leitor.rCampo(tcStr,'RNTRC');
      MDFe.Rodo.CIOT  := Leitor.rCampo(tcStr, 'CIOT');

      if Leitor.rExtrai(3, 'veicPrincipal') <> '' then
       begin
        MDFe.Rodo.veicPrincipal.cInt  := Leitor.rCampo(tcStr, 'cInt');
        MDFe.Rodo.veicPrincipal.placa := Leitor.rCampo(tcStr, 'placa');
        MDFe.Rodo.veicPrincipal.tara  := Leitor.rCampo(tcInt, 'tara');
        MDFe.Rodo.veicPrincipal.capKG := Leitor.rCampo(tcInt, 'capKG');
        MDFe.Rodo.veicPrincipal.capM3 := Leitor.rCampo(tcInt, 'capM3');

        if Leitor.rExtrai(4, 'prop') <> ''
         then MDFe.Rodo.veicPrincipal.RNTRC := Leitor.rCampo(tcStr, 'RNTRC');

        i01 := 0;
        while Leitor.rExtrai(4, 'condutor', '', i01 + 1) <> '' do
        begin
          MDFe.rodo.veicPrincipal.condutor.Add;
          MDFe.rodo.veicPrincipal.condutor[i01].xNome := Leitor.rCampo(tcStr, 'xNome');
          MDFe.rodo.veicPrincipal.condutor[i01].CPF   := Leitor.rCampo(tcStr, 'CPF');
          inc(i01);
        end;
       end;

      i01 := 0;
      while Leitor.rExtrai(3, 'veicReboque', '', i01 + 1) <> '' do
      begin
        MDFe.rodo.veicReboque.Add;
        MDFe.rodo.veicReboque[i01].cInt  := Leitor.rCampo(tcStr, 'cInt');
        MDFe.Rodo.veicReboque[i01].placa := Leitor.rCampo(tcStr, 'placa');
        MDFe.Rodo.veicReboque[i01].tara  := Leitor.rCampo(tcInt, 'tara');
        MDFe.Rodo.veicReboque[i01].capKG := Leitor.rCampo(tcInt, 'capKG');
        MDFe.Rodo.veicReboque[i01].capM3 := Leitor.rCampo(tcInt, 'capM3');

        if Leitor.rExtrai(4, 'prop') <> ''
         then MDFe.Rodo.veicReboque[i01].RNTRC := Leitor.rCampo(tcStr, 'RNTRC');

        inc(i01);
      end;

      if Leitor.rExtrai(3, 'valePed') <> '' then
       begin
        i01 := 0;
        while Leitor.rExtrai(4, 'disp', '', i01 + 1) <> '' do
        begin
          MDFe.Rodo.valePed.disp.Add;
          MDFe.Rodo.valePed.disp[i01].CNPJForn := Leitor.rCampo(tcStr, 'CNPJForn');
          MDFe.Rodo.valePed.disp[i01].CNPJPg   := Leitor.rCampo(tcStr, 'CNPJPg');
          MDFe.Rodo.valePed.disp[i01].nCompra  := Leitor.rCampo(tcStr, 'nCompra');
          inc(i01);
        end;
       end;

     end; // fim das informações do modal Rodoviário

    (* Grupo da TAG <aereo> *****************************************************)
    if Leitor.rExtrai(2, 'aereo') <> '' then
     begin
       MDFe.Aereo.nac     := Leitor.rCampo(tcInt,'nac');
       MDFe.Aereo.matr    := Leitor.rCampo(tcInt,'matr');
       MDFe.Aereo.nVoo    := Leitor.rCampo(tcStr,'nVoo');
       MDFe.Aereo.cAerEmb := Leitor.rCampo(tcStr,'cAerEmb');
       MDFe.Aereo.cAerDes := Leitor.rCampo(tcStr,'cAerDes');
       MDFe.Aereo.dVoo    := Leitor.rCampo(tcDat,'dVoo');
     end; // fim das informações do modal Aéreo

    (* Grupo da TAG <aquav> *****************************************************)
    if Leitor.rExtrai(2, 'aquav') <> '' then
     begin
       MDFe.aquav.CNPJAgeNav := Leitor.rCampo(tcStr,'CNPJAgeNav');
       MDFe.aquav.tpEmb      := Leitor.rCampo(tcStr,'tpEmb');
       MDFe.aquav.cEmbar     := Leitor.rCampo(tcStr,'cEmbar');
       MDFe.aquav.nViagem    := Leitor.rCampo(tcStr,'nViagem');
       MDFe.aquav.cPrtEmb    := Leitor.rCampo(tcStr,'cPrtEmb');
       MDFe.aquav.cPrtDest   := Leitor.rCampo(tcStr,'cPrtDest');

       i01 := 0;
       while Leitor.rExtrai(3, 'infTermCarreg', '', i01 + 1) <> '' do
       begin
         MDFe.aquav.infTermCarreg.Add;
         MDFe.aquav.infTermCarreg[i01].cTermCarreg := Leitor.rCampo(tcStr, 'cTermCarreg');
         inc(i01);
       end;

       i01 := 0;
       while Leitor.rExtrai(3, 'infTermDescarreg', '', i01 + 1) <> '' do
       begin
         MDFe.aquav.infTermDescarreg.Add;
         MDFe.aquav.infTermDescarreg[i01].cTermDescarreg := Leitor.rCampo(tcStr, 'cTermDescarreg');
         inc(i01);
       end;

       i01 := 0;
       while Leitor.rExtrai(3, 'infEmbComb', '', i01 + 1) <> '' do
       begin
         MDFe.aquav.infEmbComb.Add;
         MDFe.aquav.infEmbComb[i01].cEmbComb := Leitor.rCampo(tcStr, 'cEmbComb');
         inc(i01);
       end;

     end; // fim das informações do modal Aquaviário

    (* Grupo da TAG <ferrov> ****************************************************)
    if Leitor.rExtrai(2, 'ferrov') <> '' then
     begin
       if Leitor.rExtrai(3, 'trem') <> '' then
        begin
         MDFe.ferrov.xPref  := Leitor.rCampo(tcStr,'xPref');
         MDFe.ferrov.dhTrem := Leitor.rCampo(tcDatHor, 'dhTrem');
         MDFe.ferrov.xOri   := Leitor.rCampo(tcStr,'xOri');
         MDFe.ferrov.xDest  := Leitor.rCampo(tcStr,'xDest');
         MDFe.ferrov.qVag   := Leitor.rCampo(tcInt,'qVag');
        end;

       i01 := 0;
       while Leitor.rExtrai(3, 'vag', '', i01 + 1) <> '' do
       begin
         MDFe.ferrov.vag.Add;
         MDFe.ferrov.vag[i01].serie := Leitor.rCampo(tcInt, 'serie');
         MDFe.ferrov.vag[i01].nVag  := Leitor.rCampo(tcInt, 'nVag');
         MDFe.ferrov.vag[i01].nSeq  := Leitor.rCampo(tcInt, 'nSeq');
         MDFe.ferrov.vag[i01].TU    := Leitor.rCampo(tcInt, 'TU');
         inc(i01);
       end;

     end; // fim das informações do modal Ferroviário
   end;

  (* Grupo da TAG <infDoc> ****************************************************)
  if Leitor.rExtrai(1, 'infDoc') <> '' then
  begin
    i01 := 0;
    while Leitor.rExtrai(2, 'infMunDescarga', '', i01 + 1) <> '' do
    begin
      MDFe.infDoc.infMunDescarga.Add;
      MDFe.infDoc.infMunDescarga[i01].cMunDescarga := Leitor.rCampo(tcInt, 'cMunDescarga');
      MDFe.infDoc.infMunDescarga[i01].xMunDescarga := Leitor.rCampo(tcStr, 'xMunDescarga');

      i02 := 0;
      while Leitor.rExtrai(3, 'infCTe', '', i02 + 1) <> '' do
      begin
        MDFe.infDoc.infMunDescarga[i01].infCTe.Add;
        MDFe.infDoc.infMunDescarga[i01].infCTe[i02].chCTe       := Leitor.rCampo(tcStr, 'chCTe');
        MDFe.infDoc.infMunDescarga[i01].infCTe[i02].SegCodBarra := Leitor.rCampo(tcStr, 'SegCodBarra');
        inc(i02);
      end;

      i02 := 0;
      while Leitor.rExtrai(3, 'infCT', '', i02 + 1) <> '' do
      begin
        MDFe.infDoc.infMunDescarga[i01].infCT.Add;
        MDFe.infDoc.infMunDescarga[i01].infCT[i02].nCT    := Leitor.rCampo(tcStr, 'nCT');
        MDFe.infDoc.infMunDescarga[i01].infCT[i02].serie  := Leitor.rCampo(tcInt, 'serie');
        MDFe.infDoc.infMunDescarga[i01].infCT[i02].subser := Leitor.rCampo(tcInt, 'subser');
        MDFe.infDoc.infMunDescarga[i01].infCT[i02].dEmi   := Leitor.rCampo(tcDat, 'dEmi');
        MDFe.infDoc.infMunDescarga[i01].infCT[i02].vCarga := Leitor.rCampo(tcDe2, 'vCarga');
        inc(i02);
      end;

      i02 := 0;
      while Leitor.rExtrai(3, 'infNFe', '', i02 + 1) <> '' do
      begin
        MDFe.infDoc.infMunDescarga[i01].infNFe.Add;
        MDFe.infDoc.infMunDescarga[i01].infNFe[i02].chNFe       := Leitor.rCampo(tcStr, 'chNFe');
        MDFe.infDoc.infMunDescarga[i01].infNFe[i02].SegCodBarra := Leitor.rCampo(tcStr, 'SegCodBarra');
        inc(i02);
      end;

      i02 := 0;
      while Leitor.rExtrai(3, 'infNF', '', i02 + 1) <> '' do
      begin
        MDFe.infDoc.infMunDescarga[i01].infNF.Add;
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].CNPJ  := Leitor.rCampo(tcStr, 'CNPJ');
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].UF    := Leitor.rCampo(tcStr, 'UF');
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].nNF   := Leitor.rCampo(tcStr, 'nNF');
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].serie := Leitor.rCampo(tcInt, 'serie');
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].dEmi  := Leitor.rCampo(tcDat, 'dEmi');
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].vNF   := Leitor.rCampo(tcDe2, 'vNF');
        MDFe.infDoc.infMunDescarga[i01].infNF[i02].PIN   := Leitor.rCampo(tcInt, 'PIN');
        inc(i02);
      end;

      inc(i01);
    end;
  end;

  (* Grupo da TAG <tot> *******************************************************)
  if Leitor.rExtrai(1, 'tot') <> '' then
  begin
   MDFe.tot.qCTe   := Leitor.rCampo(tcInt,'qCTe');
   MDFe.tot.qCT    := Leitor.rCampo(tcInt,'qCT');
   MDFe.tot.qNFe   := Leitor.rCampo(tcInt,'qNFe');
   MDFe.tot.qNF    := Leitor.rCampo(tcInt,'qNF');
   MDFe.tot.vCarga := Leitor.rCampo(tcDe2,'vCarga');
   MDFe.tot.cUnid  := StrToUnidMed(Ok, Leitor.rCampo(tcStr,'cUnid'));
   MDFe.tot.qCarga := Leitor.rCampo(tcDe4,'qCarga');
  end;

  (* Grupo da TAG <lacres> ****************************************************)
  i01 := 0;
  while Leitor.rExtrai(1, 'lacres', '', i01 + 1) <> '' do
  begin
    MDFe.lacres.Add;
    MDFe.lacres[i01].nLacre := Leitor.rCampo(tcStr, 'nLacre');
    inc(i01);
  end;

  (* Grupo da TAG <infAdic> ***************************************************)
  if Leitor.rExtrai(1, 'infAdic') <> '' then
  begin
   MDFe.infAdic.infAdFisco := Leitor.rCampo(tcStr,'infAdFisco');
   MDFe.infAdic.infCpl     := Leitor.rCampo(tcStr,'infCpl');
  end;

  (* Grupo da TAG <signature> *************************************************)

  Leitor.Grupo := Leitor.Arquivo;

  MDFe.signature.URI             := Leitor.rAtributo('Reference URI=');
  MDFe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
  MDFe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
  MDFe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

  (* Grupo da TAG <protMDFe> **************************************************)
  if Leitor.rExtrai(1, 'protMDFe') <> '' then
  begin
    MDFe.procMDFe.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    MDFe.procMDFe.verAplic := Leitor.rCampo(tcStr, 'verAplic');
    MDFe.procMDFe.chMDFe   := Leitor.rCampo(tcStr, 'chMDFe');
    MDFe.procMDFe.dhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
    MDFe.procMDFe.nProt    := Leitor.rCampo(tcStr, 'nProt');
    MDFe.procMDFe.digVal   := Leitor.rCampo(tcStr, 'digVal');
    MDFe.procMDFe.cStat    := Leitor.rCampo(tcInt, 'cStat');
    MDFe.procMDFe.xMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
  end;

  Result := true;
end;

end.

