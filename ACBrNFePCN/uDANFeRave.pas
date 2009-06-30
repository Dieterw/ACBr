unit uDANFeRave;

interface

uses Graphics, Forms, Windows, SysUtils, Classes,
     Variants, DBClient, Math, StdCtrls, DB,
     Controls, ExtCtrls, Mask, jpeg,
     RpDefine, RpBase, RpSystem, RpBars, RpMemo,
     RpRenderText, RpRenderRTF, RpRenderHTML, RpRender, RpRenderPDF,
     ACBrNFe, ACBrNFeNotasFiscais,
     ACBrNFeXML, ACBrNFeEndereco, MaskUtils, ACBrNFe_nfe,
     ACBrNFeConst;

const FontTitle='Courier New';
      FontText='Courier New';

type
  TTipoSaida=(tsPrint,tsPreview,tsPDF,tsText,tsHTML,tsRTF);

  TDANFeRave = class(TRvSystem)
     procedure RaveBeforePrint(Sender: TObject);
     procedure RaveDecodeImage(Sender: TObject; ImageStream: TStream;
                  ImageType: String; Bitmap: Graphics.TBitmap);
     procedure RavePrint(Sender: TObject);
  private
     FACBrNFe:TACBrNFe;
     FEmail:String;
     FFax:String;
     FFone:String;
     FSistema:String;
     FUsuario:String;
     FNFIndex:Integer;
     FLogoMarca:TJPEGImage;
     FImpressora:String;
     FPag,FTotPag:Integer;
     procedure ImprimirRetrato;
     procedure ImprimirPaisagem;
     procedure SetFontTitle;
     procedure SetFontText;
     procedure Box(aX,aY:Double; aWith,aHeight:Double;aTitle:String='';aText:String='';aAlignment:TAlignment=taLeftJustify;PositionNewLine:Boolean=False;Zebrado:Boolean=False);
  public
     constructor Create(AOwner:TComponent); override;
     destructor Destroy; override;
     property ACBrNFe:TACBrNFe read FACBrNFe write FACBrNFe;
     property EmailDoEmitente:String read FEmail write FEmail;
     property FaxDoEmitente:String read FFax write FFax;
     property TelefoneDoEmitente:String read FFone write FFone;
     property NomeDoERP:String read FSistema write FSistema;
     property NomeDoUsuario:String read FUsuario write FUsuario;
     property LogoMarca:TJPEGImage read FLogoMarca write FLogoMarca;
     property NomeDaImpressora:String read FImpressora write FImpressora;
  end;

procedure ImprimirDANFeRave(aACBrNFe:TACBrNFe;
                            aEmail,
                            aFax,
                            aTelefone,
                            aNomeDoERP,
                            aNomeDoUsuario:String;
                            aLogoMarca:TJPEGImage;
                            aOpcaoDeSaida:TTipoSaida=tsPreview;
                            aNumeroDeCopias:Integer=1;
                            aNomeImpressora:string='';
                            aArquivoSaida:String='');

implementation

uses uDANFeRaveAux, XMLIntf;

procedure ImprimirDANFeRave(aACBrNFe:TACBrNFe;
                            aEmail,
                            aFax,
                            aTelefone,
                            aNomeDoERP,
                            aNomeDoUsuario:String;
                            aLogoMarca:TJPEGImage;
                            aOpcaoDeSaida:TTipoSaida=tsPreview;
                            aNumeroDeCopias:Integer=1;
                            aNomeImpressora:string='';
                            aArquivoSaida:String='');
var DANFeRave:TDANFeRave;
    rvPDF:TRvRenderPDF;
    rvTXT:TRvRenderText;
    rvHTML:TRvRenderHTML;
    rvRTF:TRvRenderRTF;
begin
  DANFeRave:=TDANFeRave.Create(nil);
  rvPDF:=TRvRenderPDF.Create(DANFeRave);
  rvTXT:=TRvRenderText.Create(DANFeRave);
  rvHTML:=TRvRenderHTML.Create(DANFeRave);
  rvRTF:=TRvRenderRTF.Create(DANFeRave);
  try
    rvPDF.EmbedFonts:=False;
    rvPDF.ImageQuality:=90;
    rvPDF.MetafileDPI:=300;
    rvPDF.UseCompression:=False;
    rvPDF.Active:=True;
    DANFeRave.ACBrNFe:=aACBrNFe;
    DANFeRave.EmailDoEmitente:=aEmail;
    DANFeRave.FaxDoEmitente:=aFax;
    DANFeRave.TelefoneDoEmitente:=aTelefone;
    DANFeRave.NomeDoERP:=aNomeDoERP;
    DANFeRave.NomeDoUsuario:=aNomeDoUsuario;
    DANFeRave.LogoMarca.Assign(aLogoMarca);
    DANFeRave.NomeDaImpressora:=aNomeImpressora;
    DANFeRave.TitlePreview:='Visualizar DANFE';
    DANFeRave.TitleSetup:='Configurações';
    DANFeRave.TitleStatus:='Status da Impressão';
    DANFeRave.SystemFiler.StatusFormat:='Gerando página %p';
    DANFeRave.SystemFiler.StreamMode:=smTempFile;
    DANFeRave.SystemOptions:=[soShowStatus,soAllowPrintFromPreview,soAllowSaveFromPreview,soPreviewModal];
    DANFeRave.SystemPreview.FormState:=wsMaximized;
    DANFeRave.SystemPreview.ZoomFactor:=100;
    DANFeRave.SystemPrinter.Copies:=aNumeroDeCopias;
    DANFeRave.SystemPrinter.LinesPerInch:=8;
    DANFeRave.SystemPrinter.StatusFormat:='Imprimindo página %p';
    DANFeRave.SystemPrinter.Title:='NFe - Impressão do DANFE';
    DANFeRave.SystemPrinter.Units:=unMM;
    DANFeRave.SystemPrinter.UnitsFactor:=25.4;
    DANFeRave.SystemSetups:=[ssAllowCopies,ssAllowCollate,ssAllowDuplex,ssAllowDestPreview,ssAllowDestPrinter,ssAllowDestFile,ssAllowPrinterSetup,ssAllowPreviewSetup];
    case aOpcaoDeSaida of
       tsPrint: DANFeRave.DefaultDest:=rdPrinter;
       tsPreview: DANFeRave.DefaultDest:=rdPreview;
      else begin
       DANFeRave.DefaultDest:=rdFile;
       DANFeRave.DoNativeOutput:= False;
       DANFeRave.OutputFileName:= aArquivoSaida;
       case aOpcaoDeSaida of
          tsPDF: DANFeRave.RenderObject:=rvPDF;
          tsText: DANFeRave.RenderObject:=rvTXT;
          tsHTML: DANFeRave.RenderObject:=rvHTML;
          tsRTF: DANFeRave.RenderObject:=rvRTF;
       end;
      end
    end;
    DANFeRave.Execute;
  finally
    FreeAndNil(rvPDF);
    FreeAndNil(rvTXT);
    FreeAndNil(rvHTML);
    FreeAndNil(rvRTF);
    FreeAndNil(DANFeRave);
  end;
end;

{ TDANFeRave }

procedure TDANFeRave.Box(aX, aY, aWith, aHeight: Double; aTitle,
  aText: String; aAlignment: TAlignment; PositionNewLine,
  Zebrado: Boolean);
var XX,YY:Double;
    printAlingment:TPrintJustify;
begin
  with BaseReport do begin
    XX:=aX; YY:=aY;
    Rectangle(XX,YY,XX+aWith+0.1,YY+aHeight);
    if Trim(aTitle)>'' then begin
       SetFontTitle;
       GotoXY(XX,YY);
       NewLine;
       PrintXY(XX+1,YPos,aTitle);
       SetFontText;
       case aAlignment of
         taRightJustify : printAlingment:=pjRight;
         taCenter       : printAlingment:=pjCenter;
        else
         printAlingment:=pjLeft;
       end;
       ClearAllTabs;
       SetTab(XX+1,printAlingment,aWith-2,0,0,se(Zebrado,15,0));
       NewLine;
       aText:=Trim(aText);
       PrintTab(aText);
       Bold:=False;
    end;
    if PositionNewLine then
       GotoXY(aX+aWith,aY+aHeight-0.1)
      else
       GotoXY(aX+aWith,aY);
  end;
end;

constructor TDANFeRave.Create(AOwner: TComponent);
begin
  inherited;
  FLogoMarca:=TJPEGImage.Create;
  OnPrint:=RavePrint;
  OnBeforePrint:=RaveBeforePrint;
  OnDecodeImage:=RaveDecodeImage;
end;

destructor TDANFeRave.Destroy;
begin
  FLogoMarca.Free;
  inherited;
end;

procedure TDANFeRave.RaveBeforePrint(Sender: TObject);
begin
  with BaseReport do begin
    if Trim(FImpressora)<>'' then
       SelectPrinter(FImpressora);
    SelectPaper('A4');
    if FACBrNFe.Configuracoes.Geral.DANFECodigo=1 then
       Orientation:=poPortrait
      else
       Orientation:=poLandScape;
  end;
end;

procedure TDANFeRave.RaveDecodeImage(Sender: TObject; ImageStream: TStream;
  ImageType: String; Bitmap: Graphics.TBitmap);
var Image: TJPEGImage;
begin
  If ImageType = 'JPG' then begin
    Image := TJPEGImage.Create; // Create a TJPEGImage class
    try
      Image.LoadFromStream(ImageStream); // Load up JPEG image from ImageStream
      Image.DIBNeeded; // Convert JPEG to bitmap format
      Bitmap.Assign(Image);
    finally
      Image.Free;
    end;
  end;
end;

procedure TDANFeRave.RavePrint(Sender: TObject);
begin
  with BaseReport, FACBrNFe.NotasFiscais do begin
    FNFIndex:=0;
    while FNFIndex<Count do begin
      if FNFIndex>0 then
         NewPage;
      if Orientation=poPortrait then
         ImprimirRetrato
        else
         ImprimirPaisagem;
      Inc(FNFIndex);
    end;
  end;
end;

procedure TDANFeRave.SetFontText;
begin
  with BaseReport do begin
    if Orientation=poLandScape then
       SetFont(FontText,7)
      else
       SetFont(FontText,6);
    Bold:=True;
  end;
end;

procedure TDANFeRave.SetFontTitle;
begin
  with BaseReport do begin
    if Orientation=poLandScape then
       SetFont(FontTitle,5)
      else
       SetFont(FontTitle,4);
  end;
end;
                                        
procedure TDANFeRave.ImprimirPaisagem;
const ColsWidth:array[1..14] of Double=(17,83,15,6,7,8,15,15,18,16,13,13,7,7);
      ColsTitle:array[1..14] of String=('CÓDIGO','DESCRIÇÃO DO PRODUTO / SERVIÇO','NCM/SH','CST','CFOP','UNID','QUANTIDADE','VALOR','VALOR','BASE CÁLC.','VALOR','VALOR','ALÍQ.','ALÍQ.');
      ColsTitleAux:array[1..14] of String=('','','','','','','','UNITÁRIO','TOTAL','DO ICMS','ICMS','IPI','ICMS','IPI');
      ColsAlingment:array[1..14] of TPrintJustify=(pjCenter,pjLeft,pjCenter,pjCenter,pjCenter,pjCenter,pjRight,pjRight,pjRight,pjRight,pjRight,pjRight,pjCenter,pjCenter);
      Itens1aPagina:Integer=15;
      ItensOutrasPagina:Integer=50;
var BC_ICMS, ValICMS, ValIPI, AliqICMS, AliqIPI:String;
    CenterX,XX,YY,X,Y:Double;
    q,f,i:Integer;
    ChaveNFe, cCST, nNF, vEnd:String;
    Memo:TMemoBuf;
    stLogo:TMemoryStream;
    bEspelho:Boolean;
begin
  with FACBrNFe.NotasFiscais.Items[FNFIndex].XML.NFe.InfNFe, BaseReport do begin
    X:=8;
    Y:=8;
    FPag:=1;
    FTotPag:=1;
    if Det.Count>Itens1aPagina then begin
       FTotPag:=FTotPag+Trunc((Det.Count-Itens1aPagina)/ItensOutrasPagina);
       if ((Det.Count-Itens1aPagina) mod ItensOutrasPagina)>0 then
          Inc(FTotPag);
    end;

    nNF:=FormatFloat('000000000',StrToInt(Ide.NNF));
    nNF:=Copy(nNF,1,3)+'.'+Copy(nNF,4,3)+'.'+Copy(nNF,7,3);
    with FACBrNFe.NotasFiscais.Items[FNFIndex].XML do begin
      bEspelho:= not Confirmada;
      ChaveNFe:=GetNFeChave;
    end;

    //COMPROVANTE DE ENTREGA
      Box(X,Y,16,35); //numero e serie da nfe
      Box(X,Y+35,6,153); //Informações sobre a nota no recebemos
      Box(X+6,Y+035,10,122); //identificação e assinatura
      Box(X+6,Y+157,10,031); //data recebimento
      SetPen(clBlack,psDot,5,pmCopy);
      MoveTo(X+19,Y);
      LineTo(X+19,Y+186);
      SetPen(clBlack,psSolid,5,pmCopy);

      SetFont(FontText,8);
      Bold:=True;
      GotoXY(X,Y);
      NewLine;
      PrintCenter('NOTA',X+8);
      NewLine;
      PrintCenter('FISCAL',X+8);
      NewLine;
      PrintCenter('Nº',X+8);
      FontRotation:=90;
      PrintXY(X+1.5+((16-LineHeight)/2),Y+33,nNF);

      SetFont(FontText,6);
      FontRotation:=90;
      Bold:=True;
      GotoXY(X+LineHeight,Y+186);
      Print('Recebemos de '+Emit.XNome+' os produtos constantes da Nota Fiscal indicada ao lado');
      GotoXY(X+LineHeight+LineHeight,Y+186);
      Print('Emissão: '+Formatar_Data(Ide.DEmi)+'  Destinatário/Remetente: '+Dest.XNome+'  Valor Total: '+Formatar_Valor(Total.ICMSTot.VNF));

      SetFontTitle;
      FontRotation:=90;
      GotoXY(X+6+LineHeight,Y+155);
      Print('Identificação e Assinatura do Recebedor');
      GotoXY(XPos,Y+186);
      Print('Data de Recebimento');
      FontRotation:=00;
      X:=X+22;

    //CABECALHO
      //MENSAGENS NO FUNDO DA NOTA
      if bEspelho then begin
         SetFont(FontText,33);
         FontColor:=clSilver;
         Bold:=True;
         Underline:=True;
         GotoXY(X+5,Y+180);
         FontRotation:=35;
         Print('SEM VALOR FISCAL (PARA CONFERÊNCIA)');
        end
        else begin
         if Ide.TpAmb='2' then begin //homologação
            SetFont(FontText,28);
            FontColor:=clSilver;
            Bold:=True;
            Underline:=True;
            GotoXY(X+5,Y+180);
            FontRotation:=33;
            Print('AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL');
         end;
      end;
      FontRotation:=0;


      ///DADOS DA EMRPESA
        stLogo:=TMemoryStream.Create;
        try
          FLogoMarca.SaveToStream(stLogo);
          stLogo.Position:=0;
          Box(X,Y,100,21);
          PrintImageRect(X+1,Y+1,X+30,Y+20,stLogo,'JPG');
        finally
          FreeAndNil(stLogo);
        end;
        SetFontTitle;
        GotoXY(X,Y);
        NewLine;
        CenterX:=X+65;
        PrintCenter('IDENTIFICAÇÃO DO EMITENTE',CenterX);
        SetFont(FontText,8);
        Bold:=True;
        Underline:=True;
        NewLine;
        PrintCenter(Emit.XNome,CenterX);
        Underline:=False;
        SetFont('Arial Narrow',8);
        Bold:=True;
        NewLine;
        with Emit.EnderEmit do begin
          vEnd:=XLgr;
          if (Trim(Nro)>'') and (Nro<>'SN') then
             vEnd:=vEnd+' '+Nro;
          if Trim(XCpl)>'' then
             vEnd:=vEnd+', '+XCpl;
          if Trim(XBairro)>'' then
             vEnd:=vEnd+' - '+XBairro;
          PrintCenter(vEnd,CenterX);
          NewLine;
          vEnd:=Formatar_Cep(CEP)+' '+XMun+' - '+UF;
          PrintCenter(vEnd,CenterX);
          NewLine;
          vEnd:='Fone: '+FFone+' / Fax: '+FFax;
          PrintCenter(vEnd,CenterX);
          NewLine;
          vEnd:='Email: '+FEmail;
          PrintCenter(vEnd,CenterX);
      end;

      ///TITULO DA NOTA
        CenterX:=X+125;
        GotoXY(X,Y);
        SetFont(FontTitle,10);
        Bold:=True;
        NewLine;
        GotoXY(X,YPos-0.2);
        PrintCenter('DANFE',CenterX);
        SetFont(FontText,6);
        NewLine;
        PrintCenter('Documento Auxiliar da',CenterX);
        NewLine;
        PrintCenter('Nota Fiscal Eletrônica',CenterX);
        SetFont(FontText,6);
        NewLine;
        PrintXY(X+114,YPos+0.5,'0 - ENTRADA');
        NewLine;
        PrintXY(X+114,YPos+0.5,'1 - SAÍDA');
        Box(X+130,Y+10.5,4,4);
        SetFontText;
        PrintXY(X+131.5,y+13.5,Ide.TpNF);
        GotoXY(X,Y+15.4);
        NewLine;
        PrintCenter('N.º '+nNF+' - FL 1/1',CenterX);
        NewLine;
        PrintCenter('SÉRIE '+Ide.Serie,CenterX);

      ///CODIGO DE BARRAS
        if not bEspelho then begin
           with TRPBarsCode128.Create(Self.BaseReport) do begin
             BaseReport:=Self.BaseReport;
             CodePage:=cpCodeC;
             BarCodeJustify:=pjLeft;
             UseChecksum:=false;
             BarWidth:=0.29;
             BarHeight:=15;
             WideFactor:=BarWidth;
             PrintReadable:=False;
             Text:=Limpar(ChaveNFe);
             PrintXY(X+156,Y+7);
             Free;
           end;
          end
          else begin
           SetFont('ARIAL',24);
           Bold:=True;
           Underline:=True;
           GotoXY(X+151,Y);
           NewLine;
           NewLine;
           GotoXY(X+153,YPos+1);
           FontRotation:=10;
           Print('SEM VALOR FISCAL');
           FontRotation:=0;
        end;
        Box(X+151,Y,89,25,'CONTROLE DO FISCO');

      ///DADOS DA NOTA NO CABECALHO
        GotoXY(X,YPos+22);
        Box(X,YPos,147,6,'Naureza da Operação',Ide.NatOp,taLeftJustify,True);
        Box(X,YPos,49,6,'Inscrição Estadual',Emit.IE,taCenter);
        Box(XPos,YPos,49,6,'Inscr. Estadual do Substituto Tributário','');
        Box(XPos,YPos,49,6,'C.N.P.J.',Formatar_CnpjCpf(Emit.CNPJ),taCenter);
        if bEspelho then
           ChaveNFe:='SEM VALOR FISCAL (SOMENTE CONFERENCIA)'
          else
           ChaveNFe:=Formatar_ChaveAcessoNFe(ChaveNFe);
        Box(X+151,YPos,89,6,'Chave de Acesso da NF-e para consulta de autenticidade no site www.nfe.fazenda.gov.br',ChaveNFe,taCenter,True);

    //DESTINATÁRIO / REMETENTE
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'DESTINATÁRIO / REMETENTE');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      Box(X,YPos,184,6,'Nome / Razão Social',Dest.XNome);
      Box(XPos,YPos,32,6,'CNPJ / CPF',Formatar_CnpjCpf(se(Dest.CNPJ<>'',Dest.CNPJ,Dest.CPF)),taCenter);
      Box(X+219,YPos,21,6,'Data de Emissão',Formatar_Data(Ide.DEmi),taCenter,True);
      with Dest.EnderDest do begin
        vEnd:=XLgr;
        if (Trim(Nro)>'') and (Nro<>'SN') and (Pos(Nro,vEnd)=0) then
           vEnd:=vEnd+' '+Nro;
        if Trim(XCpl)>'' then
           vEnd:=vEnd+', '+XCpl;
        Box(X,YPos,132,6,'Endereço',vEnd);
        Box(XPos,YPos,52,6,'Bairro',XBairro);
        Box(XPos,YPos,32,6,'CEP',Formatar_Cep(CEP),taCenter);
        Box(X+219,YPos,21,6,'Data da Saída',Formatar_Data(Ide.DSaiEnt),taCenter,True);
        Box(X,YPos,132,6,'Município',XMun);
        Box(XPos,YPos,39,6,'Fone / Fax',Formatar_Telefone(Fone),taCenter);
        Box(XPos,YPos,13,6,'Estado',UF,taCenter);
        Box(XPos,YPos,32,6,'Inscrição Estadual',Dest.IE,taCenter);
        Box(X+219,YPos,21,6,'Hora da Saída','',taCenter,True);
      end;

    //FATURAS
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'FATURA');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      YY:=YPos;
      XX:=X; f:=0;
      for i:=1 to 4 do begin
         ClearAllTabs;
         SetTab(XX+1,pjLeft,22,0,0,0);
         SetTab(XX+23,pjCenter,13,0,0,0);
         SetTab(XX+36,pjRight,23,0,0,0);
         SetFontTitle;
         Underline:=True;
         GotoXY(XX,YY);
         NewLine;
         PrintTab('Fatura');
         PrintTab('Vencimento');
         PrintTab('Valor');
         SetFontText;
         NewLine;
         q:=1;
         while (f<=Cobr.Dup.Count-1) and (q<=3) do begin
           with Cobr.Dup.Items[f] do begin
             PrintTab(NDup);
             PrintTab(Formatar_Data(DVenc));
             PrintTab(Formatar_Valor(VDup));
             NewLine;
             Inc(q);
           end;
           Inc(f);
         end;
         XX:=XX+60;
      end;
      Box(X,YY,60,12);
      Box(XPos,YY,60,12);
      Box(XPos,YY,60,12);
      Box(XPos,YY,60,12,'','',taLeftJustify,True);

    //CÁLCULO DO IMPOSTO
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'CÁLCULO DO IMPOSTO');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      Box(XPos,YPos,48,6,'Base de Cálculo do ICMS',Formatar_Valor(Total.ICMSTot.VBC),taRightJustify);
      Box(XPos,YPos,48,6,'Valor do ICMS',Formatar_Valor(Total.ICMSTot.VICMS),taRightJustify);
      Box(XPos,YPos,48,6,'Base de Cálculo do ICMS Substituição',Formatar_Valor('0'),taRightJustify);
      Box(XPos,YPos,48,6,'Valor do ICMS Substituição',Formatar_Valor('0'),taRightJustify);
      Box(XPos,YPos,48,6,'Valor Total dos Produtos',Formatar_Valor(Total.ICMSTot.VProd),taRightJustify,True);

      Box(X,YPos,40,6,'Valor do Frete',Formatar_Valor(Total.ICMSTot.VFrete),taRightJustify);
      Box(XPos,YPos,40,6,'Valor do Seguro',Formatar_Valor(Total.ICMSTot.VSeg),taRightJustify);
      Box(XPos,YPos,40,6,'Desconto',Formatar_Valor(Total.ICMSTot.VDesc),taRightJustify);
      Box(XPos,YPos,40,6,'Outras Despesas Acessórias',Formatar_Valor(Total.ICMSTot.VOutro),taRightJustify);
      Box(XPos,YPos,40,6,'Valor do IPI',Formatar_Valor(Total.ICMSTot.VIPI),taRightJustify);
      Box(XPos,YPos,40,6,'VALOR TOTAL DA NOTA FISCAL',Formatar_Valor(Total.ICMSTot.VNF),taRightJustify,True,True);

    //TRANSPORTADOR / VOLUMES TRANSPORTADOS
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'TRANSPORTADOR / VOLUMES TRANSPORTADOS');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      Box(XPos,YPos,132,6,'Nome / Razão Social',Transp.Transporta.XNome);
      Box(XPos,YPos,21,6,'Frete Por Conta',se(Transp.ModFrete='0','0-EMITENTE','1-DESTINATÁRIO'),taCenter);
      Box(XPos,YPos,18,6,'Código ANTT',Transp.VeicTransp.RNTC,taCenter);
      Box(XPos,YPos,20,6,'Placa do Veículo',Transp.VeicTransp.Placa,taCenter);
      Box(XPos,YPos,11,6,'Estado',Transp.VeicTransp.UF,taCenter);
      Box(XPos,YPos,38,6,'CNPJ / CPF',Formatar_CnpjCpf(se(Transp.Transporta.CNPJ<>'',Transp.Transporta.CNPJ,Transp.Transporta.CPF)),taCenter,True);

      Box(X,YPos,132,6,'Endereço',Transp.Transporta.XEnder);
      Box(XPos,YPos,59,6,'Município',Transp.Transporta.XMun,taCenter);
      Box(XPos,YPos,11,6,'Estado',Transp.Transporta.UF,taCenter);
      Box(XPos,YPos,38,6,'Inscrição Estadual',Transp.Transporta.IE,taCenter,True);

    //PRODUTOS E SERVIÇOS
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'DADOS DOS PROTUDOS / SERVIÇOS');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      YY:=YPos;
      Box(X,YPos,240,45);
      ClearAllTabs;
      XX:=X;
      for i:=Low(colsWidth) to High(colsWidth) do begin
         SetTab(XX+0.5,pjCenter,ColsWidth[i]-1,0,0,0);
         XX:=XX+ColsWidth[i];
         if (i<High(colsWidth)) then begin
            MoveTo(XX,YY);
            LineTo(XX,YY+45);
         end;
      end;
      GotoXY(X,YY);
      SetFont(FontText,6);
      NewLine;
      for i:=Low(ColsTitle) to High(ColsTitle) do
          PrintTab(ColsTitle[i]);
      NewLine;
      for i:=Low(ColsTitleAux) to High(ColsTitleAux) do
          PrintTab(ColsTitleAux[i]);
      NewLine;
      MoveTo(X,YPos-(LineHeight/1.2));
      LineTo(X+240,YPos-(LineHeight/1.2));
      ClearAllTabs;
      XX:=X;
      for i:=Low(colsWidth) to High(colsWidth) do begin
         SetTab(XX+0.5,ColsAlingment[i],ColsWidth[i]-1,0,0,0);
         XX:=XX+ColsWidth[i];
      end;
      for i:=0 to Det.Count-1 do begin
         with Det.Items[i] do begin
           PrintTab(Prod.CProd);
           PrintTab('');
           vEnd:=Prod.NCM;
           if Trim(Prod.EXTIPI)>'' then
              vEnd:=vEnd+'/'+Prod.EXTIPI;
           PrintTab(vEnd);
           GetICMS(Imposto.ICMS,cCST,BC_ICMS,AliqICMS,ValICMS);
           GetIPI(Imposto.IPI,AliqIPI,ValIPI);
           PrintTab(cCST);
           PrintTab(Prod.CFOP);
           PrintTab(Prod.UCom);
           PrintTab(Formatar_Valor(Prod.QCom));
           PrintTab(Formatar_Valor(Prod.VUnCom));
           PrintTab(Formatar_Valor(Prod.VProd));
           PrintTab(Formatar_Valor(BC_ICMS));
           PrintTab(Formatar_Valor(ValICMS));
           PrintTab(Formatar_Valor(ValIPI));
           PrintTab(Formatar_Valor(AliqICMS));
           PrintTab(Formatar_Valor(AliqIPI));
           Memo:=TMemoBuf.Create;
           try
             Memo.PrintStart:=X+ColsWidth[1]+0.5;
             Memo.PrintEnd:=Memo.PrintStart+ColsWidth[2]-0.5;
             Memo.NoNewLine:=true;
             memo.Text:=Prod.XProd;
             PrintMemo(Memo,0,false);
           finally
             Memo.Free;
           end;
           NewLine;
         end;
      end;

    //CÁLCULO DO ISSQN
      GotoXY(X,YY+45);
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'CÁLCULO DO ISSQN');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      Box(XPos,YPos,60,6,'Inscrição Municipal','');
      Box(XPos,YPos,60,6,'Valor Total dos Serviços','');
      Box(XPos,YPos,60,6,'Base de Cálculo do ISSQN','');
      Box(XPos,YPos,60,6,'Valor do ISSQN','',taLeftJustify,True);

    //DADOS ADICIONAIS
      SetFontTitle;
      NewLine;
      PrintXY(X+0.2,YPos,'DADOS ADICIONAIS');
      NewLine;
      GotoXY(X,YPos-(LineHeight/1.4));
      YY:=YPos;
      Box(XPos,YPos,160,29,'Informações Complementares');
      Box(XPos,YPos,80,29,'Reservado ao Fisco');
      SetFontText;
      GotoXY(X,YY);
      NewLine;
      NewLine;
      Bold:=False;
      Memo:=TMemoBuf.Create;
      try
        Memo.PrintStart:=X+1;
        Memo.PrintEnd:=X+158;
        Memo.NoNewLine:=true;
        memo.Text:=InfAdic.InfCpl;
        PrintMemo(Memo,0,false);
      finally
        Memo.Free;
      end;

    //RODAPÉ
      SetFontTitle;
      GotoXY(X,YY+29);
      NewLine;
      PrintXY(X,YPos,FSistema);
      vEnd:='Emitido ';
      if Trim(FUsuario)>'' then
         vEnd:=vEnd+' por '+FUsuario;
      vEnd:=vEnd+' as '+FormatDateTime('dd/mm/yyyy hh:mm:ss',Now);
      PrintRight(vEnd,X+240);

  end;
end;

procedure TDANFeRave.ImprimirRetrato;
begin
  //desenvolvimento futuro
end;

end.
