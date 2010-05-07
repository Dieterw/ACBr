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
  i, j, i01: integer;
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

  // CTe.infCTe.ID := copy(Leitor.Arquivo, I + 4, J - I - 4);
  CTe.infCTe.ID := copy(Leitor.Arquivo, I + 1, J - I -1);

  (* Grupo da TAG <ide> *******************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    (*B02*)CTe.Ide.cUF    := Leitor.rCampo(tcInt, 'cUF');
    (*B03*)CTe.Ide.cCT    := Leitor.rCampo(tcStr, 'cCT');
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

  (* Grupo da TAG <ide><toma03> ***********************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma03') <> '' then
    begin
      (*B29*)CTe.Ide.Toma03.Toma := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
    end;
  end;

  (* Grupo da TAG <ide><toma4> ************************************************)
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
          (*B37*)CTe.Ide.Toma4.EnderToma.xNum  := Leitor.rCampo(tcStr, 'nro');
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

  (* Grupo da TAG <compl> *****************************************************)
  if Leitor.rExtrai(1, 'compl') <> '' then
  begin
      CTe.Compl.xCaracAd := Leitor.rCampo(tcstr,'xCaracAd');
      CTe.Compl.xCaracSer:= Leitor.rCampo(tcstr,'xCaracSer');
      CTe.Compl.xEmi     := Leitor.rCampo(tcstr,'xEmi');

      if Leitor.rExtrai(2, 'fluxo') <> '' then
       begin
        CTe.Compl.fluxo.xOrig     := Leitor.rCampo(tcstr,'xOrig');
        i01 := 0;
        while Leitor.rExtrai(3, 'pass', '', i01 + 1) <> '' do
        begin
          CTe.Compl.fluxo.pass.Add;
          CTe.Compl.fluxo.pass[i01].xPass  := Leitor.rCampo(tcStr, 'xPass');
          inc(i01);
        end;
        CTe.Compl.fluxo.xDest     := Leitor.rCampo(tcstr,'xDest');
        CTe.Compl.fluxo.xRota     := Leitor.rCampo(tcstr,'xRota');
       end;

      if Leitor.rExtrai(2, 'Entrega') <> '' then
       begin
        if Leitor.rExtrai(3, 'semData') <> '' then
         begin
          CTe.Compl.Entrega.semData.tpPer := Leitor.rCampo(tcInt, 'tpPer');
         end;
        if Leitor.rExtrai(3, 'comData') <> '' then
         begin
          CTe.Compl.Entrega.comData.tpPer := Leitor.rCampo(tcInt, 'tpPer');
          CTe.Compl.Entrega.comData.dProg := Leitor.rCampo(tcDat, 'dProg');
         end;
        if Leitor.rExtrai(3, 'noPeriodo') <> '' then
         begin
          CTe.Compl.Entrega.noPeriodo.tpPer := Leitor.rCampo(tcInt, 'tpPer');
          CTe.Compl.Entrega.noPeriodo.dIni  := Leitor.rCampo(tcDat, 'dIni');
          CTe.Compl.Entrega.noPeriodo.dFim  := Leitor.rCampo(tcDat, 'dFim');
         end;
        if Leitor.rExtrai(3, 'semHora') <> '' then
         begin
          CTe.Compl.Entrega.semHora.tpHor := Leitor.rCampo(tcInt, 'tpHor');
         end;
        if Leitor.rExtrai(3, 'comHora') <> '' then
         begin
          CTe.Compl.Entrega.comHora.tpHor := Leitor.rCampo(tcInt, 'tpHor');
          CTe.Compl.Entrega.comHora.hProg := StrToTime(Leitor.rCampo(tcStr, 'hProg'));
         end;
        if Leitor.rExtrai(3, 'noInter') <> '' then
         begin
          CTe.Compl.Entrega.noInter.tpHor := Leitor.rCampo(tcInt, 'tpHor');
          CTe.Compl.Entrega.noInter.hIni  := StrToTime(Leitor.rCampo(tcStr, 'hIni'));
          CTe.Compl.Entrega.noInter.hFim  := StrToTime(Leitor.rCampo(tcStr, 'hFim'));
         end;
       end;

      CTe.Compl.origCalc := Leitor.rCampo(tcstr,'origCalc');
      CTe.Compl.destCalc := Leitor.rCampo(tcstr,'destCalc');
      CTe.Compl.xObs     := Leitor.rCampo(tcstr,'xObs');

      i01 := 0;
      while Leitor.rExtrai(2, 'ObsCont', '', i01 + 1) <> '' do
      begin
       I := 0;
       I := RetornarPosEx('ObsCont xCampo=', Leitor.Arquivo, I + 15);
       J := RetornarPosEx('"', Leitor.Arquivo, I + 1);
       CTe.Compl.ObsCont.Add;
       CTe.Compl.ObsCont[i01].xCampo := copy(Leitor.Arquivo, I + 1, J - I -1);
       CTe.Compl.ObsCont[i01].xTexto := Leitor.rCampo(tcstr,'xTexto');
       inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(2, 'ObsFisco', '', i01 + 1) <> '' do
      begin
       I := 0;
       I := RetornarPosEx('ObsFisco xCampo=', Leitor.Arquivo, I + 15);
       J := RetornarPosEx('"', Leitor.Arquivo, I + 1);
       CTe.Compl.ObsFisco.Add;
       CTe.Compl.ObsFisco[i01].xCampo := copy(Leitor.Arquivo, I + 1, J - I -1);
       CTe.Compl.ObsFisco[i01].xTexto := Leitor.rCampo(tcstr,'xTexto');
       inc(i01);
      end;
  end;

  (* Grupo da TAG <emit> ******************************************************)
  if Leitor.rExtrai(1, 'emit') <> '' then
  begin
      CTe.emit.CNPJ := Leitor.rCampo(tcstr,'CNPJ');
      CTe.emit.IE    := Leitor.rCampo(tcStr, 'IE');
      CTe.emit.xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.emit.xFant := Leitor.rCampo(tcStr, 'xFant');
       if Leitor.rExtrai(2, 'enderEmit') <> '' then
        begin
          CTe.emit.enderemit.xLgr  := Leitor.rCampo(tcStr, 'xLgr');
          CTe.emit.enderemit.Nro  := Leitor.rCampo(tcStr, 'nro');
          CTe.emit.enderemit.xCpl  := Leitor.rCampo(tcStr, 'xCpl');
          CTe.emit.enderemit.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.emit.enderemit.cMun  := Leitor.rCampo(tcInt, 'cMun');
          CTe.emit.enderemit.xMun  := Leitor.rCampo(tcStr, 'xMun');
          CTe.emit.enderemit.CEP   := Leitor.rCampo(tcInt, 'CEP');
          CTe.emit.enderemit.UF    := Leitor.rCampo(tcStr, 'UF');
          CTe.emit.enderemit.cPais := Leitor.rCampo(tcInt, 'cPais');
          CTe.emit.enderemit.xPais := Leitor.rCampo(tcStr, 'xPais');
          CTe.emit.enderemit.fone  := Leitor.rCampo(tcStr, 'fone');
        end;
  end;

  (* Grupo da TAG <rem> *******************************************************)
  if Leitor.rExtrai(1, 'rem') <> '' then
  begin
      CTe.Rem.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.Rem.IE    := Leitor.rCampo(tcStr, 'IE');
      CTe.Rem.xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.Rem.xFant := Leitor.rCampo(tcStr, 'xFant');
      CTe.Rem.fone  := Leitor.rCampo(tcStr, 'fone');
       if Leitor.rExtrai(2, 'enderReme') <> '' then
       begin
          CTe.Rem.enderReme.xLgr  := Leitor.rCampo(tcStr, 'xLgr');
          CTe.Rem.enderReme.Nro  := Leitor.rCampo(tcStr, 'nro');
          CTe.Rem.enderReme.xCpl  := Leitor.rCampo(tcStr, 'xCpl');
          CTe.Rem.enderReme.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.Rem.enderReme.cMun  := Leitor.rCampo(tcInt, 'cMun');
          CTe.Rem.enderReme.xMun  := Leitor.rCampo(tcStr, 'xMun');
          CTe.Rem.enderReme.CEP   := Leitor.rCampo(tcInt, 'CEP');
          CTe.Rem.enderReme.UF    := Leitor.rCampo(tcStr, 'UF');
          CTe.Rem.enderReme.cPais := Leitor.rCampo(tcInt, 'cPais');
          CTe.Rem.enderReme.xPais := Leitor.rCampo(tcStr, 'xPais');
       end;

       i01 := 0;
       while Leitor.rExtrai(2, 'infNF', '', i01 + 1) <> '' do
       begin
          CTe.Rem.InfNF.Add;
          CTe.Rem.InfNF[i01].nRoma  := Leitor.rCampo(tcStr, 'nRoma');
          CTe.Rem.InfNF[i01].nPed   := Leitor.rCampo(tcStr, 'nPed');
          CTe.Rem.InfNF[i01].serie  := Leitor.rCampo(tcStr, 'serie');
          CTe.Rem.InfNF[i01].nDoc   := Leitor.rCampo(tcEsp, 'nDoc');
          CTe.Rem.InfNF[i01].dEmi   := Leitor.rCampo(tcDat, 'dEmi');
          CTe.Rem.InfNF[i01].vBC    := Leitor.rCampo(tcDe2, 'vBC');
          CTe.Rem.InfNF[i01].vICMS  := Leitor.rCampo(tcDe2, 'vICMS');
          CTe.Rem.InfNF[i01].vBCST  := Leitor.rCampo(tcDe2, 'vBCST');
          CTe.Rem.InfNF[i01].vST    := Leitor.rCampo(tcDe2, 'vST');
          CTe.Rem.InfNF[i01].vProd  := Leitor.rCampo(tcDe2, 'vProd');
          CTe.Rem.InfNF[i01].vNF    := Leitor.rCampo(tcDe2, 'vNF');
          CTe.Rem.InfNF[i01].nCFOP  := Leitor.rCampo(tcInt, 'nCFOP');
          CTe.Rem.InfNF[i01].nPeso  := Leitor.rCampo(tcDe3, 'nPeso');
          CTe.Rem.InfNF[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');
          if Leitor.rExtrai(3, 'locRet') <> '' then
           begin
            CTe.Rem.InfNF[i01].locRet.CNPJCPF := Leitor.rCampoCNPJCPF;
            CTe.Rem.InfNF[i01].locRet.xNome   := Leitor.rCampo(tcStr, 'xNome');
            CTe.Rem.InfNF[i01].locRet.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
            CTe.Rem.InfNF[i01].locRet.Nro     := Leitor.rCampo(tcStr, 'nro');
            CTe.Rem.InfNF[i01].locRet.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
            CTe.Rem.InfNF[i01].locRet.xBairro := Leitor.rCampo(tcStr, 'xBairro');
            CTe.Rem.InfNF[i01].locRet.cMun    := Leitor.rCampo(tcInt, 'cMun');
            CTe.Rem.InfNF[i01].locRet.xMun    := Leitor.rCampo(tcStr, 'xMun');
            CTe.Rem.InfNF[i01].locRet.UF      := Leitor.rCampo(tcStr, 'UF');
           end;
          inc(i01);
       end;

       i01 := 0;
       while Leitor.rExtrai(2, 'infNFe', '', i01 + 1) <> '' do
       begin
          CTe.Rem.InfNFE.Add;
          CTe.Rem.InfNFE[i01].chave := Leitor.rCampo(tcStr, 'chave');
          CTe.Rem.InfNFE[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');
          inc(i01);
       end;

       i01 := 0;
       while Leitor.rExtrai(2, 'infOutros', '', i01 + 1) <> '' do
       begin
          CTe.Rem.InfOutros.Add;
          CTe.Rem.InfOutros[i01].tpDoc      := Leitor.rCampo(tcStr, 'tpDoc');
          CTe.Rem.InfOutros[i01].descOutros := Leitor.rCampo(tcStr, 'descOutros');
          CTe.Rem.InfOutros[i01].nDoc       := Leitor.rCampo(tcStr, 'nDoc');
          CTe.Rem.InfOutros[i01].dEmi       := Leitor.rCampo(tcDat, 'dEmi');
          CTe.Rem.InfOutros[i01].vDocFisc   := Leitor.rCampo(tcDe2, 'vDocFisc');
          inc(i01);
       end;
  end;

  (* Grupo da TAG <exped> *****************************************************)
  if Leitor.rExtrai(1, 'exped') <> '' then
  begin
      CTe.Exped.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.Exped.IE    := Leitor.rCampo(tcStr, 'IE');
      CTe.Exped.xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.Exped.fone  := Leitor.rCampo(tcStr, 'fone');
       if Leitor.rExtrai(2, 'enderExped') <> '' then
        begin
          CTe.Exped.EnderExped.xLgr  := Leitor.rCampo(tcStr, 'xLgr');
          CTe.Exped.EnderExped.Nro  := Leitor.rCampo(tcStr, 'nro');
          CTe.Exped.EnderExped.xCpl  := Leitor.rCampo(tcStr, 'xCpl');
          CTe.Exped.EnderExped.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.Exped.EnderExped.cMun  := Leitor.rCampo(tcInt, 'cMun');
          CTe.Exped.EnderExped.xMun  := Leitor.rCampo(tcStr, 'xMun');
          CTe.Exped.EnderExped.CEP   := Leitor.rCampo(tcInt, 'CEP');
          CTe.Exped.EnderExped.UF    := Leitor.rCampo(tcStr, 'UF');
          CTe.Exped.EnderExped.cPais := Leitor.rCampo(tcInt, 'cPais');
          CTe.Exped.EnderExped.xPais := Leitor.rCampo(tcStr, 'xPais');
        end;
  end;

  (* Grupo da TAG <receb> *****************************************************)
  if Leitor.rExtrai(1, 'receb') <> '' then
  begin
      CTe.receb.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.receb.IE    := Leitor.rCampo(tcStr, 'IE');
      CTe.receb.xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.receb.fone  := Leitor.rCampo(tcStr, 'fone');
       if Leitor.rExtrai(2, 'enderReceb') <> '' then
        begin
          CTe.receb.Enderreceb.xLgr  := Leitor.rCampo(tcStr, 'xLgr');
          CTe.receb.Enderreceb.Nro  := Leitor.rCampo(tcStr, 'nro');
          CTe.receb.Enderreceb.xCpl  := Leitor.rCampo(tcStr, 'xCpl');
          CTe.receb.Enderreceb.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.receb.Enderreceb.cMun  := Leitor.rCampo(tcInt, 'cMun');
          CTe.receb.Enderreceb.xMun  := Leitor.rCampo(tcStr, 'xMun');
          CTe.receb.Enderreceb.CEP   := Leitor.rCampo(tcInt, 'CEP');
          CTe.receb.Enderreceb.UF    := Leitor.rCampo(tcStr, 'UF');
          CTe.receb.Enderreceb.cPais := Leitor.rCampo(tcInt, 'cPais');
          CTe.receb.Enderreceb.xPais := Leitor.rCampo(tcStr, 'xPais');
        end;
  end;

  (* Grupo da TAG <dest> ******************************************************)
  if Leitor.rExtrai(1, 'dest') <> '' then
  begin
      CTe.Dest.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.Dest.IE    := Leitor.rCampo(tcStr, 'IE');
      CTe.Dest.xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.Dest.fone  := Leitor.rCampo(tcStr, 'fone');
       if Leitor.rExtrai(2, 'enderDest') <> '' then
        begin
          CTe.Dest.EnderDest.xLgr  := Leitor.rCampo(tcStr, 'xLgr');
          CTe.Dest.EnderDest.Nro  := Leitor.rCampo(tcStr, 'nro');
          CTe.Dest.EnderDest.xCpl  := Leitor.rCampo(tcStr, 'xCpl');
          CTe.Dest.EnderDest.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.Dest.EnderDest.cMun  := Leitor.rCampo(tcInt, 'cMun');
          CTe.Dest.EnderDest.xMun  := Leitor.rCampo(tcStr, 'xMun');
          CTe.Dest.EnderDest.CEP   := Leitor.rCampo(tcInt, 'CEP');
          CTe.Dest.EnderDest.UF    := Leitor.rCampo(tcStr, 'UF');
          CTe.Dest.EnderDest.cPais := Leitor.rCampo(tcInt, 'cPais');
          CTe.Dest.EnderDest.xPais := Leitor.rCampo(tcStr, 'xPais');
        end;
       if Leitor.rExtrai(2, 'locEnt') <> '' then
        begin
          CTe.Dest.locEnt.CNPJCPF := Leitor.rCampoCNPJCPF;
          CTe.Dest.locEnt.xNome   := Leitor.rCampo(tcStr, 'xNome');
          CTe.Dest.locEnt.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
          CTe.Dest.locEnt.Nro     := Leitor.rCampo(tcStr, 'nro');
          CTe.Dest.locEnt.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
          CTe.Dest.locEnt.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.Dest.locEnt.cMun    := Leitor.rCampo(tcInt, 'cMun');
          CTe.Dest.locEnt.xMun    := Leitor.rCampo(tcStr, 'xMun');
          CTe.Dest.locEnt.UF      := Leitor.rCampo(tcStr, 'UF');
        end;
  end;

  (* Grupo da TAG <vPrest> ****************************************************)
  if Leitor.rExtrai(1, 'vPrest') <> '' then
  begin
    CTe.vPrest.vTPrest := Leitor.rCampo(tcDe2,'vTPrest');
    CTe.vPrest.vRec := Leitor.rCampo(tcDe2,'vRec');

    i01 := 0;
    while Leitor.rExtrai(2, 'Comp', '', i01 + 1) <> '' do
    begin
      CTe.vPrest.Comp.Add;
      CTe.vPrest.Comp[i01].xNome  := Leitor.rCampo(tcStr, 'xNome');
      CTe.vPrest.Comp[i01].vComp  := Leitor.rCampo(tcDe2, 'vComp');
      inc(i01);
    end;
  end;

  (* Grupo da TAG <imp> *******************************************************)
  if Leitor.rExtrai(1, 'imp') <> '' then
  begin
    if Leitor.rCampo(tcStr,'CST')='00'
     then begin
      CTe.Imp.ICMS.CST00.CST   := Leitor.rCampo(tcStr,'CST');
      CTe.Imp.ICMS.CST00.vBC   := Leitor.rCampo(tcDe2,'vBC');
      CTe.Imp.ICMS.CST00.pICMS := Leitor.rCampo(tcDe2,'pICMS');
      CTe.Imp.ICMS.CST00.vICMS := Leitor.rCampo(tcDe2,'vICMS');
     end;

    if Leitor.rCampo(tcStr,'CST')='20'
     then begin
      CTe.Imp.ICMS.CST20.CST    := Leitor.rCampo(tcStr,'CST');
      CTe.Imp.ICMS.CST20.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
      CTe.Imp.ICMS.CST20.vBC    := Leitor.rCampo(tcDe2,'vBC');
      CTe.Imp.ICMS.CST20.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
      CTe.Imp.ICMS.CST20.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
     end;

    if (Leitor.rCampo(tcStr,'CST')='40') or
       (Leitor.rCampo(tcStr,'CST')='41') or
       (Leitor.rCampo(tcStr,'CST')='51')
     then CTe.Imp.ICMS.CST45.CST    := Leitor.rCampo(tcStr,'CST');

    if Leitor.rCampo(tcStr,'CST')='90'
     then begin
      // como detectar quando usa o 80 ou 81 ??????

      // Responsabilidade do recolhimento do ICMS atribuído ao tomador ou 3o por ST
      CTe.Imp.ICMS.CST80.CST   := Leitor.rCampo(tcStr,'CST');
      CTe.Imp.ICMS.CST80.vBC   := Leitor.rCampo(tcDe2,'vBC');
      CTe.Imp.ICMS.CST80.pICMS := Leitor.rCampo(tcDe2,'pICMS');
      CTe.Imp.ICMS.CST80.vICMS := Leitor.rCampo(tcDe2,'vICMS');
      CTe.Imp.ICMS.CST80.vCred := Leitor.rCampo(tcDe2,'vCred');

      // ICMS devido à Outra UF
      {
      CTe.Imp.ICMS.CST81.CST    := Leitor.rCampo(tcStr,'CST');
      CTe.Imp.ICMS.CST81.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
      CTe.Imp.ICMS.CST81.vBC    := Leitor.rCampo(tcDe2,'vBC');
      CTe.Imp.ICMS.CST81.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
      CTe.Imp.ICMS.CST81.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
      }
     end;

    if Leitor.rCampo(tcStr,'CST')='90'
     then begin
      CTe.Imp.ICMS.CST90.CST    := Leitor.rCampo(tcStr,'CST');
      CTe.Imp.ICMS.CST90.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
      CTe.Imp.ICMS.CST90.vBC    := Leitor.rCampo(tcDe2,'vBC');
      CTe.Imp.ICMS.CST90.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
      CTe.Imp.ICMS.CST90.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
      CTe.Imp.ICMS.CST90.vCred  := Leitor.rCampo(tcDe2,'vCred');
     end;
  end;

  (* Grupo da TAG <infctenorm> ************************************************)
  if Leitor.rExtrai(1, 'infCTeNorm') <> '' then
  begin
    if Leitor.rExtrai(2, 'infCarga') <> ''
     then begin
      CTe.InfCarga.vMerc   := Leitor.rCampo(tcDe2,'vMerc');
      CTe.InfCarga.proPred := Leitor.rCampo(tcStr,'proPred');
      CTe.InfCarga.xOutCat := Leitor.rCampo(tcStr,'xOutCat');
     end;

    i01 := 0;
    while Leitor.rExtrai(3, 'infQ', '', i01 + 1) <> '' do
    begin
      CTe.InfCarga.infQ.Add;
      CTe.InfCarga.infQ[i01].cUnid  := Leitor.rCampo(tcStr, 'cUnid');
      CTe.InfCarga.infQ[i01].tpMed  := Leitor.rCampo(tcStr, 'tpMed');
      CTe.InfCarga.infQ[i01].qCarga := Leitor.rCampo(tcDe4, 'qCarga');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'seg', '', i01 + 1) <> '' do
    begin
      CTe.infSeg.Add;
      CTe.InfSeg[i01].respSeg  := StrToTpRspSeguro(ok, Leitor.rCampo(tcStr, 'respSeg'));
      CTe.InfSeg[i01].xSeg     := Leitor.rCampo(tcStr, 'xSeg');
      CTe.InfSeg[i01].nApol    := Leitor.rCampo(tcStr, 'nApol');
      CTe.InfSeg[i01].nAver    := Leitor.rCampo(tcStr, 'nAver');
      CTe.InfSeg[i01].vMerc    := Leitor.rCampo(tcDe3, 'vMerc');
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'rodo') <> '' then
    begin
      CTe.Rodo.RNTRC := Leitor.rCampo(tcStr,'RNTRC');
      CTe.Rodo.dPrev := Leitor.rCampo(tcDat,'dPrev');
      CTe.Rodo.lota  := Leitor.rCampo(tcStr,'lota');
    end;
  end;

  (* Grupo da TAG <signature> *************************************************)

  Leitor.Grupo := Leitor.Arquivo;

  CTe.signature.URI := Leitor.rAtributo('Reference URI=');
  CTe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
  CTe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
  CTe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
  Result := true;

end;

end.

