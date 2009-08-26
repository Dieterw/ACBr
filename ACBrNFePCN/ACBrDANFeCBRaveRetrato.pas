{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: João Paulo
|*  - Doação units para geração do Danfe via código usando Rave
******************************************************************************}
{$I ACBr.inc}
unit ACBrDANFeCBRaveRetrato;

interface

uses Graphics, Forms, Windows, SysUtils, Classes,
     Variants, DBClient, Math, StdCtrls, DB, Dialogs,
     Controls, ExtCtrls, Mask, jpeg, MaskUtils,
     RpDefine, RpBase, RpSystem, RpBars, RpMemo,
     RpRenderText, RpRenderRTF, RpRenderHTML, RpRender, RpRenderPDF,
     ACBrNFe, pcnConversao, ACBrDANFeCBRave;

const
      FontSizeGroup:Integer=7;
      FontSizeTitle:Integer=6;
      FontSizeText:Integer=8;

      ColsWidth:array[1..17] of Double=(15,60,18,6,7,8,12,13,15,0,12,0,0,10,10,7,7);

procedure ImprimirRetrato(aRaveSystem:TDANFeRave);

implementation

uses ACBrNFeUtil, StrUtils, pcnNFe;

function ImprimirCanhoto(PosX,PosY:Double):Double;
var aWidthOutros,aWidthNFe,
    aWidthData,
    aHeigth,aHeigthReceb: Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aWidthNFe:=35;
     aHeigth:=18;
     aHeigthReceb:=8;
     aWidthOutros:=FLastX-FFirstX-aWidthNFe;
     aWidthData:=40;
     if FPageNum=1 then
      begin
        Box([],FLastX-aWidthNFe,PosY,aWidthNFe,aHeigth);
        Box([fsRigth],PosX,PosY,aWidthOutros,aHeigthReceb,'','',taLeftJustify,True,False,False);
        Box([fsTop],PosX,YPos,aWidthData,aHeigth-aHeigthReceb,'DATA DE RECEBIMENTO','');
        Box([fsTop,fsRigth],XPos,YPos,aWidthOutros-aWidthData,aHeigth-aHeigthReceb,'IDENTIFICAÇÃO E ASSINATURA DO RECEBEDOR','');

        SetFont(FontNameUsed,8);
        Bold:=True;
        GotoXY(0,PosY+GetFontHeigh);
        PrintCenter('Recebemos de '+Emit.XNome+' os produtos constantes da Nota Fiscal indicada ao lado',PosX+(aWidthOutros/2));
        NewLine;
        PrintCenter('Emissão: '+NotaUtil.FormatDate(DateToStr(Ide.DEmi))+'  Destinatário/Remetente: '+Dest.XNome+'  Valor Total: '+NotaUtil.FormatFloat(Total.ICMSTot.VNF),PosX+(aWidthOutros/2));

        GotoXY(0,PosY+GetFontHeigh);
        NewLine;
        PrintCenter('NF-e',FLastX-aWidthNFe+(aWidthNFe/2));
        NewLine;
        PrintCenter('Nº: '+FNumeroNF,FLastX-aWidthNFe+(aWidthNFe/2));
        NewLine;
        PrintCenter('SÉRIE: '+FSerie,FLastX-aWidthNFe+(aWidthNFe/2));

        SetPen(clBlack,psDot,2,pmCopy);
        MoveTo(PosX,PosY+aHeigth+3);
        LineTo(FLastX,PosY+aHeigth+3);
        SetPen(clBlack,psSolid,2,pmCopy);
      end;

     Result:=PosY+aHeigth+6;
  end;
end;

procedure ImprimirMensagensDeFundo;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     if FEspelho then
      begin
        SetFont(FontNameUsed,33);
        FontColor:=clSilver;
        Bold:=True;
        Underline:=True;
        GotoXY(FFirstX,FLastY);
        FontRotation:=47;
        Print('SEM VALOR FISCAL (PARA CONFERÊNCIA)');
      end
     else
      begin
        if Ide.TpAmb=taHomologacao then
         begin //homologação
           SetFont(FontNameUsed,25);
           FontColor:=clSilver;
           Bold:=True;
           Underline:=True;
           GotoXY(FFirstX+5,FLastY-5);
           FontRotation:=45;
           Print('AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL');
         end;
      end;
     FontRotation:=0;
  end;
end;

function ImprimirEmitente(PosX,PosY:Double):Double;
var aHeigthLogo, aWidthLogo, aWidth,CenterX:Double;
    stLogo:TMemoryStream;
    vEnd:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
    stLogo:=TMemoryStream.Create;
    try
       if LogoMarca<>nil then
          LogoMarca.SaveToStream(stLogo);
       stLogo.Position:=0;
       aWidth:=86;
       Result:=PosX+aWidth;

       Box([],PosX,PosY,aWidth,30,'IDENTIFICAÇÃO DO EMITENTE');

       GotoXY(PosX,PosY+2);
       CenterX:=PosX+(aWidth/2);
       SetFont(FontNameUsed,FontSizeEmit_Nome);
       NewLine;
       Bold:=True;
       PrintCenter(Emit.XNome,CenterX);
       GotoXY(PosX,YPos+2);

       aWidthLogo:=26;
       aHeigthLogo:=20;
       if Assigned(LogoMarca) then
          PrintImageRect(PosX+1,YPos,PosX+aWidthLogo,YPos+aHeigthLogo,stLogo,'JPG');

       GotoXY(PosX,YPos+1.5);
       CenterX:=PosX+aWidthLogo+((aWidth-aWidthLogo)/2);
       SetFont(FontNameUsed,FontSizeEmit_Outros);
       Bold:=True;
       with Emit.EnderEmit do
        begin
         vEnd:=XLgr;
         if (Trim(Nro)>'') and (Nro<>'SN') then
            vEnd:=vEnd+' '+Nro;
         if Trim(XCpl)>'' then
            vEnd:=vEnd+', '+XCpl;
         PrintCenter(vEnd,CenterX);
         NewLine;
         vEnd:=XBairro+' - '+NotaUtil.FormatarCEP(NotaUtil.Poem_Zeros(CEP,8));
         PrintCenter(vEnd,CenterX);
         NewLine;
         vEnd:=XMun+' - '+UF;
         PrintCenter(vEnd,CenterX);
         NewLine;
         vEnd:='FONE: '+NotaUtil.FormatarFone(Fone)+' / FAX: '+FaxDoEmitente;
         PrintCenter(vEnd,CenterX);
         NewLine;
         vEnd:=SiteDoEmitente;
         PrintCenter(vEnd,CenterX);
         NewLine;
         vEnd:=EmailDoEmitente;
         PrintCenter(vEnd,CenterX);
         Bold:=False;
        end;
    finally
      FreeAndNil(stLogo);
    end;
  end;
end;

function ImprimirTituloDANFe(PosX, PosY: Double):Double;
var aWidth, CenterX:Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aWidth:=36;
     Result:=PosX+aWidth;
     Box([fsLeft],PosX,PosY,aWidth,30);
     CenterX:=PosX+(aWidth/2);
     GotoXY(PosX,PosY);
     SetFont(FontNameUsed,FontSizeIdentDoc_DANFE);
     Bold:=True;
     NewLine;
     GotoXY(PosX,YPos-0.4);
     PrintCenter('DANFE',CenterX);
     SetFont(FontNameUsed,FontSizeIdentDoc_TipoOperacao);
     NewLine;
     PrintCenter('Documento Auxiliar da',CenterX);
     NewLine;
     PrintCenter('Nota Fiscal Eletrônica',CenterX);
     NewLine;
     PrintXY(PosX+10,YPos+0.5,'0 - ENTRADA');
     NewLine;
     PrintXY(PosX+10,YPos+0.5,'1 - SAÍDA');
     Box([],PosX+30,PosY+14.5,4,4);
     SetFont(FontNameUsed,FontSizeIdentDoc_Outros);
     Bold:=True;
     PrintXY(PosX+31,PosY+17.8,NotaUtil.SeSenao(Ide.TpNF=tnEntrada,'0','1'));
     GotoXY(PosX,PosY+20.4);
     NewLine;
     PrintCenter('N.º '+FNumeroNF,CenterX);
     NewLine;
     PrintCenter('SÉRIE '+IntToStr(Ide.Serie)+' - FOLHA '+Macro(midCurrentPage)+'/'+Macro(midTotalPages),CenterX);
     Bold:=False;
  end;
end;

function ImprimirCodigoBarras(PosX, PosY: Double):Double;
   function FormatarChave_DANFE(AValue: String): String;
   begin
     AValue := NotaUtil.LimpaNumero(AValue);
     Result := copy(AValue,1,4)  + ' ' + copy(AValue,5,4)  + ' ' +
               copy(AValue,9,4)  + ' ' + copy(AValue,13,4) + ' ' +
               copy(AValue,17,4) + ' ' + copy(AValue,21,4) + ' ' +
               copy(AValue,25,4) + ' ' + copy(AValue,29,4) + ' ' +
               copy(AValue,33,4) + ' ' + copy(AValue,37,4) + ' ' +
               copy(AValue,41,4) ;
   end;
var PosYCodBarraContigencia, aWidth, CenterX:Double;
    aChaveAcesso, aProtocolo, aChaveContigencia:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aWidth:=FLastX-PosX;
     Box([fsLeft],PosX,PosY,aWidth,12.27,'','',taLeftJustify,True);
     if FEspelho then
        aChaveAcesso:='SEM VALOR FISCAL (SOMENTE CONFERENCIA)'
       else
        aChaveAcesso:=FormatarChave_DANFE(FChaveNFe);
     Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'CHAVE DE ACESSO',aChaveAcesso,taCenter,True);

//     aChaveContigencia:=Gerar_ChaveContigencia(ACBrNFe.NotasFiscais.Items[FNFIndex].NFe);

     PosYCodBarraContigencia:=YPos;
     Box([fsLeft,fsTop],PosX,YPos,aWidth,12.27,'','',taLeftJustify,True);
     Result:=YPos;
     if aChaveContigencia<>'' then
        Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'DADOS DA NFe',aChaveContigencia,taCenter,True)
      else
       begin
        if NotaUtil.EstaVazio(ProtocoloNFe) then
           aProtocolo:=Trim(procNFe.nProt)+' '+DateTimeToStr(procNFe.dhRecbto)
        else
           aProtocolo := ProtocoloNFe;
        Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'PROTOCOLO DE AUTORIZAÇÃO DE USO',aProtocolo,taCenter,True);
      end;

     if not FEspelho then
      begin
        with TRPBarsCode128.Create(DANFeRave.BaseReport) do
         begin
          BaseReport:=DANFeRave.BaseReport;
          CodePage:=cpCodeC;
          BarCodeJustify:=pjCenter;
          UseChecksum:=false;
          BarWidth:=0.254;
          BarHeight:=10.0;
          WideFactor:=BarWidth;
          PrintReadable:=False;
          Text:=NotaUtil.LimpaNumero(FChaveNFe);
          PrintXY(PosX+(aWidth/2),PosY+0.5);
          Free;
         end;

        if aChaveContigencia<>'' then
         begin
           with TRPBarsCode128.Create(DANFeRave.BaseReport) do
            begin
             BaseReport:=DANFeRave.BaseReport;
             CodePage:=cpCodeC;
             BarCodeJustify:=pjCenter;
             UseChecksum:=false;
             BarWidth:=0.39;
             BarHeight:=11.2;
             WideFactor:=BarWidth;
             PrintReadable:=False;
             Text:=NotaUtil.LimpaNumero(aChaveContigencia);
             PrintXY(PosX+(aWidth/2),PosYCodBarraContigencia+0.5);
             Free;
            end;
         end
        else
         begin
          SetFont(FontNameUsed,9);
          GotoXY(PosX,PosYCodBarraContigencia+GetFontHeigh+0.5);
          CenterX:=PosX+(aWidth/2);
          PrintCenter('Consulta de autenticidade no portal nacional',CenterX);
          NewLine;
          PrintCenter('da NF-e www.nfe.fazenda.gov.br/portal ou',CenterX);
          NewLine;
          PrintCenter('no site da Sefaz Autorizadora',CenterX);
         end;
       end
      else
       begin
        SetFont(FontNameUsed,24);
        Bold:=True;
        Underline:=True;
        GotoXY(PosX+1,PosY);
        NewLine;
        PrintXY(PosX+5,YPos-1,'SEM VALOR FISCAL');
        Bold:=False;
        Underline:=False;
       end;
  end;
end;

function ImprimirEmitenteOutrosDados(PosX,
  PosY: Double): Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     Box([fsTop],PosX,PosY,127,aHeigthPadrao,'NATUREZA DA OPERAÇÃO',ide.natOp,taLeftJustify,True,False,False);
     Box([fsTop],PosX,YPos,82,aHeigthPadrao,'INSCRIÇÃO ESTADUAL',Emit.IE,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,82,aHeigthPadrao,'INSCRIÇÃO ESTADUAL DO SUBST. TRIBUTÁRIO',Emit.IEST,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,87,aHeigthPadrao,'C.N.P.J.',NotaUtil.FormatarCNPJ(Emit.CNPJCPF),taCenter,True);
     Result:=YPos;
  end;
end;

procedure TituloDoBloco(PosX,PosY:Double;aDescricao: string);
begin
  with DANFeRave, DANFeRave.BaseReport do begin
    SetFont(FontNameUsed,FontSizeGroup);
    Bold:=True;
    PrintXY(PosX,PosY+3,aDescricao);
    Bold:=False;
    GotoXY(PosX,YPos+0.5);
  end;
end;

function ImprimirRemetenteDestinatario(PosX,
  PosY: Double): Double;
var vEnd:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     TituloDoBloco(PosX,PosY,'DESTINATÁRIO / REMETENTE');
     Box([],PosX,YPos,135,aHeigthPadrao,'Nome / Razão Social',Dest.XNome);
     Box([fsLeft],XPos,YPos,38,aHeigthPadrao,'CNPJ / CPF',NotaUtil.FormatarCNPJ(Dest.CNPJCPF),taCenter);
     Box([fsLeft],XPos,YPos,21,aHeigthPadrao,'Data de Emissão',NotaUtil.FormatDate(DateToStr(Ide.DEmi)),taCenter,True);
     with Dest.EnderDest do
      begin
       vEnd:=XLgr;
       if (Trim(Nro)>'') and (Nro<>'SN') and (Pos(Nro,vEnd)=0) then
          vEnd:=vEnd+' '+Nro;
       if Trim(XCpl)>'' then
          vEnd:=vEnd+', '+XCpl;
       Box([fsTop],PosX,YPos,93,aHeigthPadrao,'Endereço',vEnd);
       Box([fsTop,fsLeft],XPos,YPos,50,aHeigthPadrao,'Bairro',XBairro);
       Box([fsTop,fsLeft],XPos,YPos,30,aHeigthPadrao,'CEP',NotaUtil.FormatarCEP(NotaUtil.Poem_Zeros(CEP,8)),taCenter);
       Box([fsTop,fsLeft],XPos,YPos,21,aHeigthPadrao,'Data da Saída',NotaUtil.FormatDate(DateToStr(Ide.DSaiEnt)),taCenter,True);
       Box([fsTop],PosX,YPos,85,aHeigthPadrao,'Município',XMun);
       Box([fsTop,fsLeft],XPos,YPos,40,aHeigthPadrao,'Fone / Fax',NotaUtil.FormatarFone(Fone),taCenter);
       Box([fsTop,fsLeft],XPos,YPos,10,aHeigthPadrao,'Estado',UF,taCenter);
       Box([fsTop,fsLeft],XPos,YPos,38,aHeigthPadrao,'Inscrição Estadual',Dest.IE,taCenter);
       Box([fsTop,fsLeft],XPos,YPos,21,aHeigthPadrao,'Hora da Saída','',taCenter,True);
     end;
     Result:=YPos;
  end;
end;

function ImprimirFaturas(PosX, PosY: Double): Double;
var i:Integer;
    aHeight, XX,YY:Double;
    q, f:integer;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     //Ocultar Faturas se não for informado nenhuma
     if Cobr.Dup.Count=0 then
      begin
        Result:=PosY;
        exit;
      end;

     TituloDoBloco(PosX,PosY,'FATURAS');

     YY:=YPos;
     XX:=PosX;
     ClearAllTabs;
     for i:=1 to 3 do
      begin
        SetTab(XX+1,pjLeft,25,0,0,0);
        SetTab(XX+26,pjCenter,19,0,0,0);
        SetTab(XX+45,pjRight,20,0,0,0);
        XX:=XX+67;
      end;
     GotoXY(XX,YY);
     NewLine;
     SetFontTitle;
     Underline:=True;
     for i:=1 to 3 do
      begin
        PrintTab('NÚMERO');
        PrintTab('VENCIMENTO');
        PrintTab('VALOR');
      end;
     SetFontText;
     NewLine;
     q:=1;
     for f:=0 to Cobr.Dup.Count-1 do
      begin
       with Cobr.Dup.Items[f] do
        begin
         PrintTab(NDup);
         PrintTab(NotaUtil.FormatDate(DateToStr(DVenc)));
         PrintTab(NotaUtil.FormatFloat(VDup));
         Inc(q);
         if q>3 then
          begin
            NewLine;
            q:=1;
          end;
        end;
      end;

     aHeight:=YPos-PosY-GetFontHeigh;

     Box([],PosX,YY,67,aHeight);
     Box([fsLeft],XPos,YY,67,aHeight);
     Box([fsLeft],XPos,YY,67,aHeight,'','',taLeftJustify,True);
     Result:=YPos;
  end;
end;

function ImprimirCalculoImposto(PosX, PosY: Double): Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     TituloDoBloco(PosX,PosY,'CÁLCULO DO IMPOSTO');
     Box([],PosX,YPos,38,aHeigthPadrao,'Base de Cálculo do ICMS',NotaUtil.FormatFloat(Total.ICMSTot.VBC),taRightJustify);
     Box([fsLeft],XPos,YPos,38,aHeigthPadrao,'Valor do ICMS',NotaUtil.FormatFloat(Total.ICMSTot.VICMS),taRightJustify);
     Box([fsLeft],XPos,YPos,38,aHeigthPadrao,'Base Cálculo do ICMS Subst.',NotaUtil.FormatFloat(Total.ICMSTot.vBCST),taRightJustify);
     Box([fsLeft],XPos,YPos,38,aHeigthPadrao,'Valor do ICMS Subst.',NotaUtil.FormatFloat(Total.ICMSTot.vST),taRightJustify);
     Box([fsLeft],XPos,YPos,42,aHeigthPadrao,'Valor Total dos Produtos',NotaUtil.FormatFloat(Total.ICMSTot.VProd),taRightJustify,True);

     Box([fsTop],PosX,YPos,30.4,aHeigthPadrao,'Valor do Frete',NotaUtil.FormatFloat(Total.ICMSTot.VFrete),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,30.4,aHeigthPadrao,'Valor do Seguro',NotaUtil.FormatFloat(Total.ICMSTot.VSeg),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,30.4,aHeigthPadrao,'Desconto',NotaUtil.FormatFloat(Total.ICMSTot.VDesc),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,30.4,aHeigthPadrao,'Outras Desp. Acessórias',NotaUtil.FormatFloat(Total.ICMSTot.VOutro),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,30.4,aHeigthPadrao,'Valor do IPI',NotaUtil.FormatFloat(Total.ICMSTot.VIPI),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,42,aHeigthPadrao,'VALOR TOTAL DA NOTA FISCAL',NotaUtil.FormatFloat(Total.ICMSTot.VNF),taRightJustify,True,True);

     Result:=YPos;
  end;
end;

function ImprimirTransportadorVolumes(PosX,
  PosY: Double): Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     TituloDoBloco(PosX,PosY,'TRANSPORTADOR / VOLUMES TRANSPORTADOS');

     Box([],PosX,YPos,90,aHeigthPadrao,'Nome / Razão Social',Transp.Transporta.XNome);
     Box([fsLeft],XPos,YPos,27,aHeigthPadrao,'Frete Por Conta',NotaUtil.SeSenao(Transp.ModFrete=mfContaEmitente,'0-EMITENTE','1-DESTINATÁRIO'),taCenter);
     Box([fsLeft],XPos,YPos,19,aHeigthPadrao,'Código ANTT',Transp.VeicTransp.RNTC,taCenter);
     Box([fsLeft],XPos,YPos,22,aHeigthPadrao,'Placa do Veículo',Transp.VeicTransp.Placa,taCenter);
     Box([fsLeft],XPos,YPos,6,aHeigthPadrao,'UF',Transp.VeicTransp.UF,taCenter);
     Box([fsLeft],XPos,YPos,30,aHeigthPadrao,'CNPJ / CPF',NotaUtil.FormatarCNPJ(Transp.Transporta.CNPJCPF),taCenter,True);

     Box([fsTop],PosX,YPos,90,aHeigthPadrao,'Endereço',Transp.Transporta.XEnder);
     Box([fsTop,fsLeft],XPos,YPos,68,aHeigthPadrao,'Município',Transp.Transporta.XMun,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,6,aHeigthPadrao,'UF',Transp.Transporta.UF,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,30,aHeigthPadrao,'Inscrição Estadual',Transp.Transporta.IE,taCenter,True);

     if Transp.Vol.Count > 0 then
      begin
        Box([fsTop],PosX,YPos,20,aHeigthPadrao,'Quantidade',IntToStr(Transp.Vol.Items[0].qVol),taRightJustify);
        Box([fsTop,fsLeft],XPos,YPos,34,aHeigthPadrao,'Espécie',Transp.Vol.Items[0].esp,taCenter);
        Box([fsTop,fsLeft],XPos,YPos,50,aHeigthPadrao,'Marca',Transp.Vol.Items[0].marca,taCenter);
        Box([fsTop,fsLeft],XPos,YPos,30,aHeigthPadrao,'Numero','',taCenter);
        Box([fsTop,fsLeft],XPos,YPos,30,aHeigthPadrao,'Peso Bruto',NotaUtil.FormatFloat(Transp.Vol.Items[0].pesoB),taRightJustify);
        Box([fsTop,fsLeft],XPos,YPos,30,aHeigthPadrao,'Peso Líquido',NotaUtil.FormatFloat(Transp.Vol.Items[0].pesoL),taRightJustify,True);
     end;
     
     Result:=YPos;
  end;
end;

function ImprimirCalculoISSQN(PosX, PosY: Double): Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     if Total.ISSQNtot.vServ>0 then
      begin
        Result:=PosY-aHeigthPadrao-4;
        TituloDoBloco(PosX,Result,'CÁLCULO DO ISSQN');
        Box([],PosX,YPos,50,aHeigthPadrao,'Inscrição Municipal',Emit.IM);
        Box([fsLeft],XPos,YPos,48,aHeigthPadrao,'Valor Total dos Serviços',NotaUtil.FormatFloat(Total.ISSQNtot.vServ),taRightJustify);
        Box([fsLeft],XPos,YPos,48,aHeigthPadrao,'Base de Cálculo do ISSQN',NotaUtil.FormatFloat(Total.ISSQNtot.vBC),taRightJustify);
        Box([fsLeft],XPos,YPos,48,aHeigthPadrao,'Valor do ISSQN',NotaUtil.FormatFloat(Total.ISSQNtot.vISS),taRightJustify,True);
      end
     else
        Result:=PosY;
  end;
end;

function ImprimirDadosAdicionais(PosX,PosY: Double): Double;
var aHeigth:Double;
    memo:TMemoBuf;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aHeigth:=32;
     PosY:=PosY-aHeigth-4;
     TituloDoBloco(PosX,PosY,'DADOS ADICIONAIS');
     Box([],PosX,YPos,124,aHeigth,'Informações Complementares');
     Box([fsLeft],XPos,YPos,70,aHeigth,'Reservado ao Fisco','',taLeftJustify,
     True);
     SetFont(FontNameUsed,FontSizeInfComplementares);
     GotoXY(PosX,PosY+4);
     NewLine;
     NewLine;
     Memo:=TMemoBuf.Create;
     try
       Memo.PrintStart:=PosX+1;
       Memo.PrintEnd:=PosX+122;
       Memo.NoNewLine:=True;
       memo.Text:=StringReplace(InfAdic.InfCpl,';',#13,[rfReplaceAll]);
       PrintMemo(Memo,0,false);
     finally
       Memo.Free;
     end;
     Result:=PosY;
  end;
end;

function ImprimirRodape(PosX: Double): Double;
var vEnd:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     SetFontTitle;
     Result:=FLastY-GetFontHeigh;
     GotoXY(PosX,Result);
     NewLine;
     vEnd:='DATA E HORA DA IMPRESSÃO: '+FormatDateTime('dd/mm/yyyy hh:mm:ss',Now);
     if Trim(NomeDoUsuario)>'' then
        vEnd:=vEnd+' - '+NomeDoUsuario;
     PrintXY(PosX,YPos,vEnd);

     if Trim(NomeDoERP)>'' then
     begin
        vEnd:='Desenvolvido por '+NomeDoERP;
        PrintRight(vEnd,FLastX);
     end;
  end;
end;

procedure PrepararItens(PosX, FirstY, LastY: Double);
var aIncWidht,XX,YY:Double;
    i:Integer;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     TituloDoBloco(PosX,FirstY,'DADOS DOS PRODUTOS / SERVIÇOS');
     FirstY:=YPos;
     YY:=YPos;
     XX:=XPos;
     Box([],XPos,YPos,FLastX-XPos,LastY-FirstY);
     ClearAllTabs;
     for i:=Low(ColsWidth) to High(ColsWidth) do
      begin
        if (i=High(ColsWidth)) then
           aIncWidht:=FLastX-(XX+0.5+ColsWidth[i])
        else
           aIncWidht:=0;
        SetTab(XX+0.5,pjCenter,ColsWidth[i]-1+aIncWidht,0,0,0);
        XX:=XX+ColsWidth[i];
        if (i<High(ColsWidth)) then
         begin
           MoveTo(XX,FirstY);
           LineTo(XX,LastY);
         end;
      end;
     GotoXY(PosX,YY);
     SetFont(FontNameUsed,FontSizeItens);
     Bold:=True;
     NewLine;
     for i:=Low(ColsTitle) to High(ColsTitle) do
         PrintTab(ColsTitle[i]);
     NewLine;
     for i:=Low(ColsTitleAux) to High(ColsTitleAux) do
         PrintTab(ColsTitleAux[i]);
     NewLine;
     SetFont(FontNameUsed,FontSizeItens);
     MoveTo(PosX,YPos-(LineHeight/1.2));
     LineTo(FLastX,YPos-(LineHeight/1.2));
     ClearAllTabs;
     XX:=PosX;
     for i:=Low(ColsWidth) to High(ColsWidth) do
      begin
        if (i=High(ColsWidth)) then
           aIncWidht:=FLastX-(XX+0.5+ColsWidth[i])
        else
           aIncWidht:=0;
        SetTab(XX+0.5,ColsAlingment[i],ColsWidth[i]-1+aIncWidht,0,0,0);
        XX:=XX+ColsWidth[i];
      end;
  end;
end;

function MontarPagina:Double;
var XX,YY:Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
    SetPen(clBlack,psSolid,5,pmCopy);
    Inc(FPageNum);
    if FPageNum=1 then
     begin
       FSerie:=IntToStr(Ide.serie);
       FNumeroNF:=FormatFloat('000000000',Ide.NNF);
       FNumeroNF:=Copy(FNumeroNF,1,3)+'.'+Copy(FNumeroNF,4,3)+'.'+Copy(FNumeroNF,7,3);
       FEspelho:=Trim(procNFe.nProt)='';
       FChaveNFe:=RightStr(infNFe.ID,44);
     end;

    XX:=MarginLeft;YY:=MarginTop;
    Result:=XX;
    YY:=ImprimirCanhoto(XX,YY);
    ImprimirMensagensDeFundo;
    XX:=ImprimirEmitente(XX,YY);
    XX:=ImprimirTituloDANFe(XX,YY);
    YY:=ImprimirCodigoBarras(XX,YY);
    YY:=ImprimirEmitenteOutrosDados(Result,YY);

    //Imprime somente na primeira folha
    if FPageNum=1 then
     begin
       YY:=ImprimirRemetenteDestinatario(Result,YY);
       YY:=ImprimirFaturas(Result,YY);
       YY:=ImprimirCalculoImposto(Result,YY);
       YY:=ImprimirTransportadorVolumes(Result,YY);
       FLastItens:=ImprimirRodape(Result);
       FLastItens:=ImprimirDadosAdicionais(Result,FLastItens);
       FLastItens:=ImprimirCalculoISSQN(Result,FLastItens);
     end
    else
       FLastItens:=ImprimirRodape(Result);

    PrepararItens(Result,YY,FLastItens);
  end;
end;

procedure ImprimirItens(PosX:Double);
var QtdeMin,i:Integer;
    aDescProduto, vEnd:String;
    Memo:TMemoBuf;
    aFontHeigth:Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aFontHeigth:=GetFontHeigh;
     for i:=0 to Det.Count-1 do
      begin
        with Det.Items[i] do
         begin
          aDescProduto:=Trim(Prod.XProd);

          QtdeMin:=0;
          if Prod.veicProd.chassi<>'' then
           begin
             with Prod.veicProd do
              begin
               aDescProduto:=aDescProduto+#13+
                             '  CHASSI: '+Prod.veicProd.chassi+#13+
                             '  COMBUSTÍVEL: '+tpComb+#13+
                             '  COR: '+xCor+#13+
                             '  FAB./MOD.: '+IntToStr(anoFab)+'/'+IntToStr(anoMod)+#13+
                             '  RENAVAM: '+RENAVAM+#13+
                             '  Nº DO MOTOR: '+nMotor;
              end;
             QtdeMin:=QtdeMin+6;
           end;

          if Trim(infAdProd)>'' then
           begin
             aDescProduto:=aDescProduto+#13+StringReplace(infAdProd,';',#13,[rfReplaceAll]);
             Inc(QtdeMin);
           end;

          //Testa se a quantidade de linhas a ser impressa
          //ultrapassará o final do quadro dos itens,
          //e caso aconteça, cria uma nova página
          if (YPos+(aFontHeigth*QtdeMin))>FLastItens then
           begin
             NewPage;
             MontarPagina;
           end;

          PrintTab(Prod.CProd);
          PrintTab('');
          vEnd:=Prod.NCM;
          if Trim(Prod.EXTIPI)>'' then
             vEnd:=vEnd+'/'+Prod.EXTIPI;
          PrintTab(vEnd);
          PrintTab(OrigToStr(Imposto.ICMS.orig)+CSTICMSToStr(Imposto.ICMS.CST));
          PrintTab(Prod.CFOP);
          PrintTab(Prod.UCom);
          PrintTab(NotaUtil.FormatFloat(Prod.QCom));
          PrintTab(NotaUtil.FormatFloat(Prod.VUnCom));
          PrintTab(NotaUtil.FormatFloat(Prod.VProd));
          PrintTab(NotaUtil.FormatFloat(Prod.vDesc));
          PrintTab(NotaUtil.FormatFloat(Imposto.ICMS.vBC));
          PrintTab(NotaUtil.FormatFloat(Imposto.ICMS.vICMS));
          PrintTab(NotaUtil.FormatFloat(Imposto.IPI.vIPI));
          PrintTab(NotaUtil.FormatFloat(Imposto.ICMS.pICMS));
          PrintTab(NotaUtil.FormatFloat(Imposto.IPI.pIPI));
          Memo:=TMemoBuf.Create;
          try
            Memo.PrintStart:=PosX+ColsWidth[1]+0.5;
            Memo.PrintEnd:=Memo.PrintStart+ColsWidth[2]-0.5;
            Memo.NoNewLine:=true;
            memo.text:=aDescProduto;
            PrintMemo(Memo,0,false);
          finally
            Memo.Free;
          end;
          MoveTo(PosX,YPos+0.3);
          LineTo(FLastX,YPos+0.3);
          NewLine;
        end;
     end;
  end;
end;

procedure ImprimirRetrato(aRaveSystem:TDANFeRave);
begin
  DANFeRave:=aRaveSystem;
  ImprimirItens(MontarPagina);
end;

end.
