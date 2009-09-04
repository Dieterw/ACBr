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
unit ACBrDANFeCBRavePaisagem;

interface

uses Graphics, Forms, Windows, SysUtils, Classes,
     Variants, DBClient, Math, StdCtrls, DB, Dialogs,
     Controls, ExtCtrls, Mask, jpeg, MaskUtils,
     RpDefine, RpBase, RpSystem, RpBars, RpMemo,
     RpRenderText, RpRenderRTF, RpRenderHTML, RpRender, RpRenderPDF,
     ACBrNFe, pcnConversao, ACBrDANFeCBRave;

const aWidthTituloBloco:Double=6;
      aDiferentHeigth:Double=0.08;
      aDiferentWidth:Double=0.08;
      FontSizeGroup:Integer=5;
      FontSizeTitle:Integer=6;
      FontSizeText:Integer=10;

var
   ColsWidth:array[1..17] of Double; //colunas dados dos produtos


procedure ImprimirPaisagem(aRaveSystem:TDANFeRave);

implementation

uses ACBrNFeUtil, StrUtils, pcnNFe;

function ImprimirCanhoto(PosX,PosY:Double):Double;
var aHeigthNumSerie, aHeigthIdent,
    aWidth, aWidthReceb: Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aHeigthNumSerie:=35;
     aHeigthIdent:=122;
     aWidth:=16;
     aWidthReceb:=6;
     if FPageNum=1 then
      begin
        Box([],PosX,PosY,aWidth,aHeigthNumSerie,'','',taLeftJustify,True,False,False); //numero e serie da nfe
        Box([fsTop],PosX,YPos,aWidthReceb,FLastY-YPos); //Informações sobre a nota no recebemos
        Box([fsTop,fsBottom],PosX+aWidthReceb,PosY+aHeigthNumSerie,aWidth-aWidthReceb,aHeigthIdent,'','',taLeftJustify,True,False,False); //identificação e assinatura
        Box([fsLeft],PosX+aWidthReceb,YPos,aWidth-aWidthReceb,FLastY-YPos); //data recebimento
        SetPen(clBlack,psDot,5,pmCopy);
        MoveTo(PosX+aWidth+3,FFirstY);
        LineTo(PosX+aWidth+3,FLastY);
        SetPen(clBlack,psSolid,5,pmCopy);

        SetFont(FontNameUsed,8);
        Bold:=True;
        GotoXY(PosX,PosY);
        NewLine;
        PrintCenter('NOTA',PosX+8);
        NewLine;
        PrintCenter('FISCAL',PosX+8);
        NewLine;
        PrintCenter('Nº',PosX+8);
        FontRotation:=90;
        PrintXY(PosX+1.5+((aWidth-LineHeight)/2),PosY+33,FNumeroNF);
        FontRotation:=90;
        PrintXY(PosX+LineHeight+1.5+((aWidth-LineHeight)/2),PosY+33,'Série: '+IntToStr(Ide.Serie));

        SetFontTitle;
        FontRotation:=90;
        Bold:=True;
        GotoXY(PosX+FontHeight+0.5,FLastY-2);
        //GotoXY(PosX+LineHeight,FLastY-2);
        Print('Recebemos de '+Emit.XNome+' os produtos constantes da Nota Fiscal indicada ao lado');
        GotoXY(PosX+FontHeight+FontHeight+0.5,FLastY-2);
        if ExibirResumoCanhoto then
           Print('Emissão: '+NotaUtil.FormatDate(DateToStr(Ide.DEmi))+'  Dest/Rem: '+Dest.XNome+'  Valor Total: '+NotaUtil.FormatFloat(Total.ICMSTot.VNF));

        Bold:=False;
        GotoXY(PosX+aWidthReceb+LineHeight,PosY+aHeigthNumSerie+aHeigthIdent-1);
        Print('Identificação e Assinatura do Recebedor');
        GotoXY(XPos,FLastY-2);
        Print('Data de Recebimento');
        FontRotation:=00;
     end;

     Result:=PosX+aWidth+6;
   end;
end;

procedure ImprimirMensagensDeFundo(PosX:Double);
var CenterX,YY:Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     YY:=FLastY-5;
     if FEspelho then
      begin
        SetFont(FontNameUsed,33);
        FontColor:=clSilver;
        Bold:=True;
        Underline:=True;
        GotoXY(PosX+5,YY);
        FontRotation:=35;
        Print('SEM VALOR FISCAL (PARA CONFERÊNCIA)');
      end
     else
      begin
        if Ide.TpAmb=taHomologacao then
         begin //homologação
           SetFont(FontNameUsed,28);
           FontColor:=clSilver;
           Bold:=True;
           Underline:=True;
           GotoXY(PosX+5,YY);
           FontRotation:=33;
           Print('AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL');
         end;
        SetFont(FontNameUsed,22);
        FontColor:=clSilver;
        Bold:=True;
        GotoXY(PosX+5,YY-10);
        CenterX:=XPos+((PageWidth-MarginRight-XPos)/2);
        case Ide.tpEmis of
           teDPEC: begin
                     PrintCenter('DANFE impresso em contingência - DPEC regularmente ',CenterX);
                     NewLine;
                     PrintCenter('recebida pela Receita Federal do Brasil',CenterX);
                   end;
           teFSDA,
           teContingencia:
                   begin
                     PrintCenter('DANFE em Contingência - impresso em',CenterX);
                     NewLine;
                     PrintCenter('decorrência de problemas técnicos',CenterX);
                   end;
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
       aWidth:=106;
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
         vEnd:='FONE: '+NotaUtil.FormatarFone(Fone);
         if trim(FaxDoEmitente)>'' then
            vEnd:=vEnd+' / FAX: '+NotaUtil.FormatarFone(FaxDoEmitente);
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
    i:Integer;
    VarNumPage:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     aWidth:=41;
     Result:=PosX+aWidth;
     Box([fsLeft],PosX,PosY,aWidth,30);
     CenterX:=PosX+20;
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

     for i:=FPageNum-1 downto 1 do begin
         VarNumPage:='PAGE'+FormatFloat('000000',FCurrentPage-(FPageNum-i));
         SetPIVar(VarNumPage,IntToStr(i)+'/'+IntToStr(FPageNum));
     end;
     VarNumPage:='PAGE'+FormatFloat('000000',FCurrentPage);
     SetPIVar(VarNumPage,IntToStr(FPageNum)+'/'+IntToStr(FPageNum));

     PrintCenter('SÉRIE '+IntToStr(Ide.Serie)+' - FOLHA '+PIVar(VarNumPage),CenterX);
     Bold:=False;
   end;
end;

function ImprimirCodigoBarras(PosX, PosY: Double):Double;
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
         aChaveAcesso:=NotaUtil.FormatarChaveAcesso(FChaveNFe);
      Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'CHAVE DE ACESSO',aChaveAcesso,taCenter,True);

      if ACBrNFe.NotasFiscais.Items[FNFIndex].NFe.Ide.tpEmis in [teContingencia,teFSDA] then
         aChaveContigencia:=NotaUtil.GerarChaveContingencia(ACBrNFe.NotasFiscais.Items[FNFIndex].NFe)
      else
         aChaveContigencia:='';

      PosYCodBarraContigencia:=YPos;
      Box([fsLeft,fsTop],PosX,YPos,aWidth,12.27,'','',taLeftJustify,True);
      Result:=YPos;
      if aChaveContigencia<>'' then
         Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'DADOS DA NFe',NotaUtil.FormatarChaveContigencia(aChaveContigencia),taCenter,True)
      else
      begin
         aProtocolo := ProtocoloNFe;
         if (ACBrNFe.NotasFiscais.Items[FNFIndex].NFe.Ide.tpEmis in [teNormal,teSCAN]) then
         begin
            if NotaUtil.EstaVazio(aProtocolo) then
               aProtocolo:=Trim(procNFe.nProt)+' '+DateTimeToStr(procNFe.dhRecbto);
            Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'PROTOCOLO DE AUTORIZAÇÃO DE USO',aProtocolo,taCenter,True);
         end
         else if (ACBrNFe.NotasFiscais.Items[FNFIndex].NFe.Ide.tpEmis in [teDPEC]) then
            Box([fsLeft,fsTop],PosX,YPos,aWidth,aHeigthPadrao,'NÚMERO DE REGISTRO DPEC',aProtocolo,taCenter,True);
      end;

      if not FEspelho then
      begin
         with TRPBarsCode128.Create(DANFeRave.BaseReport) do
         begin
            BaseReport:=DANFeRave.BaseReport;
            CodePage:=cpCodeC;
            BarCodeJustify:=pjCenter;
            UseChecksum:=false;
            BarWidth:=0.39;
            BarHeight:=10.0;
            WideFactor:=BarWidth;
            PrintReadable:=False;
            Text:=NotaUtil.LimpaNumero(FChaveNFe);
            PrintXY(PosX+(aWidth/2),PosY+1);
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
               BarHeight:=10.0;
               WideFactor:=BarWidth;
               PrintReadable:=False;
               Text:=NotaUtil.LimpaNumero(aChaveContigencia);
               PrintXY(PosX+(aWidth/2),PosYCodBarraContigencia+1);
               Free;
            end;
         end
         else
         begin
            SetFont(FontNameUsed,11);
            GotoXY(PosX,PosYCodBarraContigencia+5);
            CenterX:=PosX+(aWidth/2);
            PrintCenter('Consulta de autenticidade no portal nacional da NF-e',CenterX);
            NewLine;
            PrintCenter('www.nfe.fazenda.gov.br/portal ou no site da Sefaz Autorizadora',CenterX);
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
  PosY, WidthNaturezaOperacao: Double): Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     //PosX:=PosX+aWidthTituloBloco;
     Box([fsTop],PosX,PosY,WidthNaturezaOperacao,aHeigthPadrao,'NATUREZA DA OPERAÇÃO',ide.natOp,taLeftJustify,True,False,False);
     Box([fsTop],PosX,YPos,82,aHeigthPadrao,'INSCRIÇÃO ESTADUAL',Emit.IE,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,82,aHeigthPadrao,'INSCRIÇÃO ESTADUAL DO SUBST. TRIBUTÁRIO',Emit.IEST,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,87,aHeigthPadrao,'C.N.P.J.',NotaUtil.FormatarCNPJ(Emit.CNPJCPF),taCenter,True);
     Result:=YPos;
   end;
end;

procedure TituloDoBloco(FlagsHideLine:TFlagsShowLine; Y1, X2, Y2: Double;
  aDescricao: string;aDescricaoAux:string='');
var X1,CenterX,CenterY:Double;
begin
  with DANFeRave, DANFeRave.BaseReport do
   begin
    Y2:=Y2;
    X1:=X2-aWidthTituloBloco;
    Box(FlagsHideLine+[fsRigth],X1,Y1,X2-X1,Y2-Y1);
    SetFont(FontNameUsed,FontSizeGroup);
    Bold:=True;
    FontRotation:=90;
    FontColor:=clWhite;
    GotoXY(X1+2,Y1+2);
    Print('a'); //usado somente para pegar a altura da linha
    FontColor:=clBlack;
    CenterX:=X2-X1-FontHeight;
    if aDescricaoAux<>'' then
       CenterX:=CenterX-FontHeight;
    CenterX:=X1+CenterX;
    CenterY:=Y1+((Y2-Y1)/2);
    GotoXY(CenterX,CenterY);
    PrintCenter(aDescricao,CenterX);
    if aDescricaoAux<>'' then
     begin
       CenterX:=CenterX+FontHeight;
       GotoXY(CenterX,CenterY);
       PrintCenter(aDescricaoAux,CenterX);
     end;
   end;
end;

function ImprimirRemetenteDestinatario(PosX,
  PosY: Double): Double;
var vEnd:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     PosX:=PosX+aWidthTituloBloco;
     Box([fsTop],PosX,PosY,192,aWidthTituloBloco,'Nome / Razão Social',Dest.XNome);
     if Length(Dest.CNPJCPF) > 11 then
       Box([fsTop,fsLeft],XPos,YPos,38,aWidthTituloBloco,'CNPJ / CPF',NotaUtil.FormatarCNPJ(Dest.CNPJCPF),taCenter)
     else
       Box([fsTop,fsLeft],XPos,YPos,38,aWidthTituloBloco,'CNPJ / CPF',NotaUtil.FormatarCPF(Dest.CNPJCPF),taCenter);
     Box([fsTop,fsLeft],XPos,YPos,21,aWidthTituloBloco,'Data de Emissão',NotaUtil.FormatDate(DateToStr(Ide.DEmi)),taCenter,True);
     with Dest.EnderDest do
      begin
       vEnd:=XLgr;
       if (Trim(Nro)>'') and (Nro<>'SN') and (Pos(Nro,vEnd)=0) then
          vEnd:=vEnd+' '+Nro;
       if Trim(XCpl)>'' then
          vEnd:=vEnd+', '+XCpl;
       Box([fsTop],PosX,YPos,136,aWidthTituloBloco,'Endereço',vEnd);
       Box([fsTop,fsLeft],XPos,YPos,56,aWidthTituloBloco,'Bairro',XBairro);
       Box([fsTop,fsLeft],XPos,YPos,38,aWidthTituloBloco,'CEP',NotaUtil.FormatarCEP(NotaUtil.Poem_Zeros(CEP,8)),taCenter);
       Box([fsTop,fsLeft],XPos,YPos,21,aWidthTituloBloco,'Data da Saída',NotaUtil.FormatDate(DateToStr(Ide.DSaiEnt)),taCenter,True);
       Box([fsTop],PosX,YPos,136,aWidthTituloBloco,'Município',XMun);
       Box([fsTop,fsLeft],XPos,YPos,43,aWidthTituloBloco,'Fone / Fax',NotaUtil.FormatarFone(FONE),taCenter);
       Box([fsTop,fsLeft],XPos,YPos,13,aWidthTituloBloco,'Estado',UF,taCenter);
       Box([fsTop,fsLeft],XPos,YPos,38,aWidthTituloBloco,'Inscrição Estadual',Dest.IE,taCenter);
       if ImprimirHoraSaida then
          Box([fsTop,fsLeft],XPos,YPos,21,aWidthTituloBloco,'Hora da Saída',TimeToStr(now),taCenter,True)
       else
          Box([fsTop,fsLeft],XPos,YPos,21,aWidthTituloBloco,'Hora da Saída','',taCenter,True);
      end;
     Result:=YPos;
     TituloDoBloco([],PosY,PosX,YPos,'DESTINATÁRIO /','REMETENTE');
   end;
end;

function ImprimirLocalRetirada(PosX,
  PosY: Double): Double;
var vEnd:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     //Ocultar Local se não for informado CNPJ
     if NotaUtil.EstaVazio(Retirada.CNPJ) then
      begin
        Result:=PosY;
        exit;
      end;

     PosX:=PosX+aWidthTituloBloco;
     with Retirada do
     begin
       Box([fstop],PosX,PosY,50,aHeigthPadrao+1,'CNPJ',NotaUtil.FormatarCNPJ(CNPJ),taCenter);
       vEnd:=XLgr;
       if (Trim(Nro)>'') and (Nro<>'SN') and (Pos(Nro,vEnd)=0) then
          vEnd:=vEnd+' '+Nro;
       if Trim(XCpl)>'' then
          vEnd:=vEnd+', '+XCpl;
       vEnd:=vEnd+' - '+xBairro+' - '+xMun+' - '+UF;
       Box([fstop,fsLeft],XPos,YPos,21,aHeigthPadrao+1,'Endereço',vEnd,taLeftJustify,true);
     end;

     Result:=YPos;
     TituloDoBloco([fsTop],PosY,PosX,YPos,'RETI','RADA');
  end;
end;

function ImprimirLocalEntrega(PosX,
  PosY: Double): Double;
var vEnd:String;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     //Ocultar Local se não for informado CNPJ
     if NotaUtil.EstaVazio(Entrega.CNPJ) then
      begin
        Result:=PosY;
        exit;
      end;

     PosX:=PosX+aWidthTituloBloco;
     with Entrega do
     begin
       Box([fstop],PosX,PosY,50,aHeigthPadrao+1,'CNPJ',NotaUtil.FormatarCNPJ(CNPJ),taCenter);
       vEnd:=XLgr;
       if (Trim(Nro)>'') and (Nro<>'SN') and (Pos(Nro,vEnd)=0) then
          vEnd:=vEnd+' '+Nro;
       if Trim(XCpl)>'' then
          vEnd:=vEnd+', '+XCpl;
       vEnd:=vEnd+' - '+xBairro+' - '+xMun+' - '+UF;
       Box([fstop,fsLeft],XPos,YPos,21,aHeigthPadrao+1,'Endereço',vEnd,taLeftJustify,true);
     end;

     Result:=YPos;
     TituloDoBloco([fsTop],PosY,PosX,YPos,'ENTRE','GA');
  end;
end;

function ImprimirFaturas(PosX, PosY: Double): Double;
var i:Integer;
    aHeight, XX,YY,YY2: Double;
    q, f:integer;
    logica: boolean;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
      //Ocultar se não for informado nenhuma
      if (NotaUtil.EstaVazio(Cobr.Fat.nFat)) then
      begin
         if (Cobr.Dup.Count=0) then
         begin
            //exibir somemte informação se não for OUTRAS
            if Ide.indPag=ipOutras then
            begin
              Result:=PosY;
              exit;
            end
            else
            begin
               //exibir somemte informação se não for OUTRAS
               PosX:=PosX+aWidthTituloBloco;
               if (ide.indPag=ipVista) then
                  Box([fstop],PosX,PosY,50,aHeigthPadrao,' ','PAGAMENTO À VISTA',taLeftJustify,True)
               else if (ide.indPag=ipPrazo) then
                  Box([fstop],PosX,PosY,50,aHeigthPadrao,' ','PAGAMENTO A PRAZO',taLeftJustify,True);
              Result:=YPos;
              TituloDoBloco([fsTop],PosY,PosX,YPos,'FATU','RAS');
              exit;
            end;
         end;
      end;

     PosX:=PosX+aWidthTituloBloco;
     YY:=PosY;
     XX:=PosX;
     YY2:=0;
     if not (NotaUtil.EstaVazio(Cobr.Fat.nFat)) then
     begin
        Box([fstop,fsRigth],PosX,PosY,30,aHeigthPadrao,'Número da Fatura',Cobr.Fat.nFat,taLeftJustify);
        Box([fsLeft,fsRigth],XPos,YPos,30,aHeigthPadrao,'Valor Original',NotaUtil.FormatFloat(Cobr.Fat.vOrig),taLeftJustify);
        Box([fsLeft,fsRigth],XPos,YPos,30,aHeigthPadrao,'Valor do Desconto',NotaUtil.FormatFloat(Cobr.Fat.vDesc),taLeftJustify);
        Box([fsLeft],XPos,YPos,30,aHeigthPadrao,'Valor Líquido',NotaUtil.FormatFloat(Cobr.Fat.vLiq),taLeftJustify,true);
        YY2:=aHeigthPadrao;
     end;
     YY:=PosY+YY2;
     XX:=PosX;
     if not (Cobr.Dup.Count=0) then
     begin
        ClearAllTabs;
        for i:=1 to 4 do
         begin
           SetTab(XX+1,pjLeft,24,0,0,0);
           SetTab(XX+25,pjCenter,18,0,0,0);
           SetTab(XX+43,pjRight,19+NotaUtil.SeSenao(i=4,-1,0),0,0,0);
           XX:=XX+63;
         end;
        GotoXY(XX,YY);
        NewLine;
        SetFontTitle;
        Underline:=True;
        for i:=1 to 4 do
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
             if q>4 then
              begin
                NewLine;
                q:=1;
              end;
           end;
         end;

        //aHeight:=YPos-PosY-GetFontHeigh;
        aHeight:=YPos-PosY-YY2+1;

        Box([fsTop],PosX,YY,63,aHeight);
        Box([fsTop,fsLeft],XPos,YY,63,aHeight);
        Box([fsTop,fsLeft],XPos,YY,63,aHeight);
        Box([fsTop,fsLeft],XPos,YY,62,aHeight,'','',taLeftJustify,True);
     end;

     Result:=YPos;
     if ((aHeight+YY2) < 9) then
        TituloDoBloco([fsTop],PosY,PosX,YPos,'FATU','RAS')
     else if ((aHeight+YY2) < 11) then
        TituloDoBloco([fsTop],PosY,PosX,YPos,'FATURAS')
     else
        TituloDoBloco([fsTop],PosY,PosX,YPos,'FATURA /','DUPLICATAS');
   end;
end;

function ImprimirCalculoImposto(PosX, PosY: Double): Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     PosX:=PosX+aWidthTituloBloco;
     Box([fsTop],PosX,PosY,50,aHeigthPadrao,'Base de Cálculo do ICMS',NotaUtil.FormatFloat(Total.ICMSTot.VBC),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,50,aHeigthPadrao,'Valor do ICMS',NotaUtil.FormatFloat(Total.ICMSTot.VICMS),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,50,aHeigthPadrao,'Base de Cálculo do ICMS Substituição',NotaUtil.FormatFloat(Total.ICMSTot.vBCST),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,50,aHeigthPadrao,'Valor do ICMS Substituição',NotaUtil.FormatFloat(Total.ICMSTot.vST),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,51,aHeigthPadrao,'Valor Total dos Produtos',NotaUtil.FormatFloat(Total.ICMSTot.VProd),taRightJustify,True);

     Box([fsTop],PosX,YPos,40,aHeigthPadrao,'Valor do Frete',NotaUtil.FormatFloat(Total.ICMSTot.VFrete),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,40,aHeigthPadrao,'Valor do Seguro',NotaUtil.FormatFloat(Total.ICMSTot.VSeg),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,39,aHeigthPadrao,'Desconto',NotaUtil.FormatFloat(Total.ICMSTot.VDesc),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,40,aHeigthPadrao,'Outras Despesas Acessórias',NotaUtil.FormatFloat(Total.ICMSTot.VOutro),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao,'Valor do IPI',NotaUtil.FormatFloat(Total.ICMSTot.VIPI),taRightJustify);
     Box([fsTop,fsLeft],XPos,YPos,51,aHeigthPadrao,'VALOR TOTAL DA NOTA FISCAL',NotaUtil.FormatFloat(Total.ICMSTot.VNF),taRightJustify,True,false);

     Result:=YPos;
     TituloDoBloco([fsTop],PosY,PosX,YPos,'CALCULO','IMPOSTO');
   end;
end;

function ImprimirTransportadorVolumes(PosX,
  PosY: Double): Double;
const aIncHeigth:Double=0.5;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     PosX:=PosX+aWidthTituloBloco;
     Box([fsTop],PosX,PosY,120,aHeigthPadrao+aIncHeigth,'Nome / Razão Social',Transp.Transporta.XNome);
     Box([fsTop,fsLeft],XPos,YPos,29,aHeigthPadrao+aIncHeigth,'Frete Por Conta',NotaUtil.SeSenao(Transp.ModFrete=mfContaEmitente,'0-EMITENTE','1-DESTINATÁRIO'),taCenter);
     Box([fsTop,fsLeft],XPos,YPos,23,aHeigthPadrao+aIncHeigth,'Código ANTT',Transp.VeicTransp.RNTC,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,27,aHeigthPadrao+aIncHeigth,'Placa do Veículo',Transp.VeicTransp.Placa,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,14,aHeigthPadrao+aIncHeigth,'Estado',Transp.VeicTransp.UF,taCenter);
     if Length(Transp.Transporta.CNPJCPF) > 11 then
       Box([fsTop,fsLeft],XPos,YPos,38,aHeigthPadrao+aIncHeigth,'CNPJ / CPF',NotaUtil.FormatarCNPJ(Transp.Transporta.CNPJCPF),taCenter,True)
     else
       Box([fsTop,fsLeft],XPos,YPos,38,aHeigthPadrao+aIncHeigth,'CNPJ / CPF',NotaUtil.FormatarCPF(Transp.Transporta.CNPJCPF),taCenter,True);
     Box([fsTop],PosX,YPos,132,aHeigthPadrao+aIncHeigth,'Endereço',Transp.Transporta.XEnder);
     Box([fsTop,fsLeft],XPos,YPos,65,aHeigthPadrao+aIncHeigth,'Município',Transp.Transporta.XMun,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,14,aHeigthPadrao+aIncHeigth,'Estado',Transp.Transporta.UF,taCenter);
     Box([fsTop,fsLeft],XPos,YPos,40,aHeigthPadrao+aIncHeigth,'Inscrição Estadual',Transp.Transporta.IE,taCenter,True);

     if Transp.Vol.Count > 0 then
      begin
        Box([fsTop],PosX,YPos,41,aHeigthPadrao+aIncHeigth,'Quantidade',IntToStr(Transp.Vol.Items[0].qVol),taRightJustify);
        Box([fsTop,fsLeft],XPos,YPos,43,aHeigthPadrao+aIncHeigth,'Espécie',Transp.Vol.Items[0].esp,taCenter);
        Box([fsTop,fsLeft],XPos,YPos,44,aHeigthPadrao+aIncHeigth,'Marca',Transp.Vol.Items[0].marca,taCenter);
        Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao+aIncHeigth,'Numero',Transp.Vol.Items[0].nVol,taCenter);
        Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao+aIncHeigth,'Peso Bruto',NotaUtil.FormatFloat(Transp.Vol.Items[0].pesoB,NotaUtil.PreparaCasasDecimais(3)),taRightJustify);
        Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao+aIncHeigth,'Peso Líquido',NotaUtil.FormatFloat(Transp.Vol.Items[0].pesoL,NotaUtil.PreparaCasasDecimais(3)),taRightJustify,True);
      end
      else
      begin
        Box([fsTop],PosX,YPos,41,aHeigthPadrao+aIncHeigth,'Quantidade','',taRightJustify);
        Box([fsTop,fsLeft],XPos,YPos,43,aHeigthPadrao+aIncHeigth,'Espécie','',taCenter);
        Box([fsTop,fsLeft],XPos,YPos,44,aHeigthPadrao+aIncHeigth,'Marca','',taCenter);
        Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao+aIncHeigth,'Numero','',taCenter);
        Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao+aIncHeigth,'Peso Bruto','',taRightJustify);
        Box([fsTop,fsLeft],XPos,YPos,41,aHeigthPadrao+aIncHeigth,'Peso Líquido','',taRightJustify,True);
      end;

     Result:=YPos;
     TituloDoBloco([fsTop],PosY,PosX,YPos,'TRANSPORTADOR','VOLUMES TRANSP.');
   end;
end;

function ImprimirCalculoISSQN(PosX, PosY: Double): Double;
const aIncHeigth:Double=1;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     if Total.ISSQNtot.vServ>0 then
      begin
        PosX:=PosX+aWidthTituloBloco;
        Result:=PosY-aHeigthPadrao-aIncHeigth;
        Box([fsTop,fsBottom],PosX,Result,62,aHeigthPadrao+aIncHeigth,'Inscrição Municipal',Emit.IM);
        Box([fsTop,fsBottom,fsLeft],XPos,YPos,63,aHeigthPadrao+aIncHeigth,'Valor Total dos Serviços',NotaUtil.FormatFloat(Total.ISSQNtot.vServ),taRightJustify);
        Box([fsTop,fsBottom,fsLeft],XPos,YPos,63,aHeigthPadrao+aIncHeigth,'Base de Cálculo do ISSQN',NotaUtil.FormatFloat(Total.ISSQNtot.vBC),taRightJustify);
        Box([fsTop,fsBottom,fsLeft],XPos,YPos,63,aHeigthPadrao+aIncHeigth,'Valor do ISSQN',NotaUtil.FormatFloat(Total.ISSQNtot.vISS),taRightJustify,True);
        TituloDoBloco([fsTop],Result,PosX,YPos,'CALC.','ISSQN');
        Result:=PosY-aHeigthPadrao-aIncHeigth;
      end
     else
        Result := PosY;
   end;
end;

function ImprimirDadosAdicionais(PosX,PosY: Double): Double;
var aHeigth:Double;
    memo:TMemoBuf;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
     PosX:=PosX+aWidthTituloBloco;
     aHeigth:=29;
     PosY:=PosY-aHeigth;
     Box([],PosX,PosY,176,aHeigth,'Informações Complementares');
     Box([fsLeft],XPos,YPos,75,aHeigth,'Reservado ao Fisco','',taLeftJustify,
     True);
     SetFont(FontNameUsed,FontSizeInfComplementares);
     GotoXY(PosX,PosY);
     NewLine;
     NewLine;
     Memo:=TMemoBuf.Create;
     try
       Memo.PrintStart:=PosX+1;
       Memo.PrintEnd:=PosX+174;
       Memo.NoNewLine:=True;
       memo.Text:=StringReplace(InfAdic.InfCpl,';',#13,[rfReplaceAll]);
       PrintMemo(Memo,0,false);
     finally
       Memo.Free;
     end;
     Result:=PosY;
     TituloDoBloco([fsTop],PosY,PosX,PosY+aHeigth,'DADOS ADICIONAIS');
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
     if (SystemPrinter.MarginRight <> 5.1) then
        ColsWidth[2]:=ColsWidth[2]-(SystemPrinter.MarginRight-5.1);

     PosX:=PosX+aWidthTituloBloco;
     TituloDoBloco([],FirstY,PosX,LastY,'DADOS DOS PRODUTOS / SERVIÇOS');
     GotoXY(PosX,FirstY);
     YY:=YPos;
     XX:=XPos;
     Box([fsTop],XPos,YPos,FLastX-XPos,LastY-FirstY);
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
     SetFont(FontNameUsed,FontSizeGroup);
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
var aWidthNatOper,XX,YY:Double;
begin
  with DANFeRave, DANFeRave.ACBrNFe.NotasFiscais.Items[DANFeRave.FNFIndex].NFe, DANFeRave.BaseReport do
   begin
    SetPen(clBlack,psSolid,5,pmCopy);
    Inc(FPageNum);
    Inc(FCurrentPage);
    if FPageNum=1 then
     begin
       FNumeroNF:=FormatFloat('000000000',Ide.NNF);
       FNumeroNF:=Copy(FNumeroNF,1,3)+'.'+Copy(FNumeroNF,4,3)+'.'+Copy(FNumeroNF,7,3);
       //FEspelho:=Trim(procNFe.nProt)='';
       FEspelho:=false; //funcionalidade de espelho suspensa devido reclamações
       FChaveNFe:=RightStr(infNFe.ID,44);
     end;

    XX:=MarginLeft;YY:=MarginTop;
    XX:=ImprimirCanhoto(XX,YY);

    Result:=XX;

    ImprimirMensagensDeFundo(XX);
    XX:=ImprimirEmitente(XX,YY);
    XX:=ImprimirTituloDANFe(XX,YY);
    aWidthNatOper:=XX-Result;
    YY:=ImprimirCodigoBarras(XX,YY);
    YY:=ImprimirEmitenteOutrosDados(Result,YY,aWidthNatOper);

    //Imprime somente na primeira folha
    if FPageNum=1 then
     begin
       YY:=ImprimirRemetenteDestinatario(Result,YY);
       YY:=ImprimirLocalRetirada(Result,YY);
       YY:=ImprimirLocalEntrega(Result,YY);
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

    Result:=Result+aWidthTituloBloco;
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
           end
           else
            if i>0 then
             begin
               MoveTo(PosX,YPos+0.1-aFontHeigth);
               LineTo(FLastX,YPos+0.1-aFontHeigth);
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
          PrintTab(NotaUtil.FormatFloat(Prod.QCom,NotaUtil.PreparaCasasDecimais(CasasDecimais_qCom)));
          PrintTab(NotaUtil.FormatFloat(Prod.VUnCom,NotaUtil.PreparaCasasDecimais(CasasDecimais_vUnCom)));
          PrintTab(NotaUtil.FormatFloat(Prod.VProd));
          PrintTab(NotaUtil.FormatFloat(Prod.vDesc));
          PrintTab(NotaUtil.FormatFloat(Imposto.ICMS.vBC));
          PrintTab(NotaUtil.FormatFloat(Imposto.ICMS.vBCST));
          PrintTab(NotaUtil.FormatFloat(Imposto.ICMS.vICMSST));
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
          NewLine;
         end;
      end;
   end;
end;

procedure ImprimirPaisagem(aRaveSystem:TDANFeRave);
var XX:Double;
begin
  ColsWidth[1]:=17;
  ColsWidth[2]:=85;
  ColsWidth[3]:=15;
  ColsWidth[4]:=6;
  ColsWidth[5]:=7;
  ColsWidth[6]:=8;
  ColsWidth[7]:=15;
  ColsWidth[8]:=13;
  ColsWidth[9]:=13;
  ColsWidth[10]:=0;
  ColsWidth[11]:=15;
  ColsWidth[12]:=15;
  ColsWidth[13]:=11;
  ColsWidth[14]:=11;
  ColsWidth[15]:=11;
  ColsWidth[16]:=8;
  ColsWidth[17]:=8;

  DANFeRave:=aRaveSystem;
  XX:=MontarPagina;
  ImprimirItens(XX);
end;

end.
