unit Unit1;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, QExtCtrls, QComCtrls, ACBrBase,
  ACBrValidador;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    tsLog: TTabSheet;
    TabSheet2: TTabSheet;
    mLog: TMemo;
    mKey: TMemo;
    Panel1: TPanel;
    bLerChave: TButton;
    OpenDialog1: TOpenDialog;
    ACBrValidador1: TACBrValidador;
    tbOpcoes: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edCNPJ: TEdit;
    Label3: TLabel;
    edIE: TEdit;
    cbEAD: TCheckBox;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    edDir: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bLerChaveClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edCNPJKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fsSeqAliq : Integer ;

    procedure VerificaArq( Arq : String ) ;
    procedure AddLog( Msg : String ) ;
    procedure VerificaE01( var LinhaE01, Erros : String ) ;
    procedure VerificaE02( var LinhaE02, Erros : String ) ;
    procedure VerificaE13( var LinhaE13, Erros : String ) ;
    procedure VerificaE14( var LinhaE14, Erros : String ) ;
    procedure VerificaE15( var LinhaE15, Erros : String ) ;
    procedure VerificaE16( var LinhaE16, Erros : String ) ;
    procedure VerificaTotalE14E15( var LinhaE14 : String; var SL : TStringList; var Erros : String ) ;
    procedure AbreCupom( LinhaE14 : String; var SL : TStringList; Diferenca : Double) ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
Uses ACBrUtil , StrUtils, Math, Unit2;

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0 ;
  edDir.Text := ExtractFilePath( Application.ExeName ) ;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
  Var Dir : WideString ;
begin
  Dir := edDir.Text ;
  if SelectDirectory('Selecione o diretório','',Dir ) then
     edDir.Text := Dir ;
end;

procedure TForm1.Button1Click(Sender: TObject);
 var SearchRec : TSearchRec ;
     RetFind   : Integer ;
     LastFile  : string ;
     Path      : String ;
begin
  if edCNPJ.Text <> '' then
  begin
     try
        ACBrValidador1.TipoDocto := docCNPJ ;
        ACBrValidador1.Documento := edCNPJ.Text ;
        ACBrValidador1.Validar ;
     except
        PageControl1.ActivePageIndex := 1 ;
        edCNPJ.SetFocus ;
     end ;
  end ;

  if edIE.Text <> '' then
  begin
     try
        ACBrValidador1.TipoDocto := docInscEst ;
        ACBrValidador1.Documento := edIE.Text ;
        ACBrValidador1.Complemento := 'SP' ;
        ACBrValidador1.Validar ;
     except
        PageControl1.ActivePageIndex := 1 ;
        edIE.SetFocus ;
     end ;
  end ;

  mLog.Clear ;
  PageControl1.ActivePageIndex := 0 ;

  if not DirectoryExists(edDir.Text) then
     raise Exception.Create('Diretório inválido');

  if mKey.Text = '' then
  begin
     PageControl1.ActivePageIndex := 1 ;
     raise Exception.Create('Você deve especificar uma chave RSA');
  end ;

  LastFile := '' ;
  Path     := PathWithDelim( edDir.Text ) ;
  AddLog('Iniciando verificação dos arquivos do diretório: '+Path);
  AddLog('');

  RetFind  := SysUtils.FindFirst(Path+'*.*', faAnyFile, SearchRec);
  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        { ignora . , .. , .bak,.ini,.tmp }
        if (pos(ExtractFileExt( LastFile ) , '.bak.ini.tmp') = 0) and
           (pos(LastFile, '..') = 0) then
           VerificaArq( Path + LastFile );

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;

  AddLog('');
  AddLog('Fim do processo');
end;

procedure TForm1.VerificaArq(Arq: String);
 Var SL, SL2 : TStringList ;
     I,J,LinhaEAD : Integer ;
     Dir, Linha, Tipo, Erros, cmd, EAD : String ;
     Alterou: Boolean ;

begin
  if not FileExists(Arq) then
     exit ;
     
  Alterou   := False ;
  fsSeqAliq := 0 ;

  AddLog('');
  AddLog('-----------------------------------------------');
  AddLog('Abrindo: '+Arq);
  SL  := TStringList.Create ;
  Dir := GetCurrentDir ;
  
  // Mudando para o diretório do arquivo
  ChDir( ExtractFilePath(Arq) ) ;

  try
     SL.LoadFromFile( Arq );

     if SL.Count = 0 then
     begin
        AddLog('Arquivo vazio');
        exit ;
     end ;

     // Verificando se é RFD
     if copy(SL[0],1,3) <> 'E00' then
     begin
        AddLog('Arquivo não é RFD');
        exit ;
     end ;

     For I := 0 to SL.Count-1 do
     begin
        Linha := SL[I] ;
        Tipo  := copy(Linha,1,3) ;
        Erros := '' ;

        if Tipo = 'E13' then
           VerificaE13(Linha, Erros)

        else if Tipo = 'E14' then
           VerificaE14(Linha, Erros)

        else if Tipo = 'E15' then
           VerificaE15(Linha, Erros)

        else if Tipo = 'E16' then
           VerificaE16(Linha, Erros)

        else if (Tipo = 'E01') and (edCNPJ.Text <> '') then
           VerificaE01(Linha, Erros)

        else if (Tipo = 'E02') and (edCNPJ.Text + edIE.Text <> '') then
           VerificaE02(Linha, Erros)

        else if (Tipo = 'EAD') and (Alterou or cbEAD.Checked) then
         begin
           Alterou := True ;
           SL.Delete(I);
           break ;
         end ;

       if (Linha <> SL[I]) or (Length(Erros)>0) then
        begin
           SL[I] := Linha ;
           AddLog('Corrigida linha: '+IntToStr(I)+' Tipo: '+Tipo +sLineBreak + Erros);
           Alterou := True ;
        end ;
     end ;

     // Em alguns casos o Total dos Itens não confere com o Total do Cupom...
     // Há tb o problema de Cancelamento de Item não registrado (quando cancelava o ultimo Item)
     For I := 0 to SL.Count-1 do
     begin
        Linha := SL[I] ;
        Tipo  := copy(Linha,1,3) ;
        Erros := '' ;

      //E14+Nº de fabricação do ECF+Letra indicativa de MF adicional+Modelo do ECF+Número do usuário+CCF+COO
        if Tipo = 'E14' then
        if copy(Linha,123,1)='N' then
              VerificaTotalE14E15(Linha, SL, Erros)

      //E15+Nº de fabricação do ECF+Letra indicativa de MF adicional+Modelo do ECF+Número do usuário+COO
        else if Tipo = 'E15' then
          break;

        if (Linha <> SL[I]) or (Length(Erros)>0) then
         begin
            SL[I] := Linha ;
            AddLog('Corrigida linha: '+IntToStr(I)+' Tipo: '+Tipo +sLineBreak + Erros);
            Alterou := True ;
         end ;

     end ;

     /// Arquivo foi Alterado ? Se SIM, realcule o EAD ///
     if not Alterou then
        AddLog('   OK')
     else
      begin
        SL2 := TStringList.Create ;
        try
           LinhaEAD := -1;
           SL.Find('EAD',LinhaEAD);
           if (LinhaEAD > 0) and (LinhaEAD < SL.Count) then
            begin
              if copy(SL[LinhaEAD],1,3) = 'EAD' then
              SL.Delete(LinhaEAD);
            end;

           SL.SaveToFile('rfd.tmp');  // Gravando Arquivo Temporário para calcular o EAD

           { Gravando a chave no arquivo id_rsa para usa-la com o "openssl" }
           mKey.Lines.SaveToFile( 'id.rsa' );

           { Executando o "openssl.exe" }
           cmd := 'dgst -md5 -sign id.rsa -out ead.txt -hex rfd.tmp' ;
           RunCommand('openssl', cmd, True, 0);

           J := 0 ;
           while (not FileExists('ead.txt')) and (J < 30) do
           begin
              sleep(100) ;
              Application.ProcessMessages ;
              Inc( J ) ;
           end ;

           { Lendo a resposta }
           try
              SL2.Clear ;
              SL2.LoadFromFile('ead.txt');
              EAD := SL2.Text ;
              EAD := UpperCase( Trim( copy(EAD, pos('=',EAD)+1, Length(EAD) ))) ;
           except
              raise Exception.Create( 'Erro ao calcular registro EAD usando o "openssl"' ) ;
           end ;

           SL.Add('EAD'+EAD) ;
        finally
           SL2.Free ;
           DeleteFile( 'id.rsa' ) ;  // Removendo a chave privada do disco ;
           DeleteFile( 'ead.txt' ) ;
           DeleteFile( 'rfd.tmp' ) ;
        end;

        AddLog('   Arquivo corrigido: '+Arq);
        AddLog('   Backup criado em '+Arq+'.bak');
        CopyFileTo(Arq, Arq+'.bak' ) ;

        SL.SaveToFile(Arq);
      end ;
  finally
     SL.Free ;
     ChDir( Dir );  { Voltando para o diretório anterior }
  end ;

  AddLog('');
end;

procedure TForm1.AddLog(Msg: String);
begin
  mLog.Lines.Add(Msg) ;
end;

procedure TForm1.VerificaE01(var LinhaE01, Erros: String);
  Var CNPJ : String ;
begin
  CNPJ := copy(LinhaE01,99,14) ;

  if CNPJ <> padR(edCNPJ.Text,14,'0') then
  begin
     LinhaE01 := StuffString( LinhaE01,99,14,padR(edCNPJ.Text,14,'0') ) ;
     Erros    := 'CNPJ corrigido.' ;
  end ;
end;

procedure TForm1.VerificaE02(var LinhaE02, Erros: String);
  Var CNPJ, IE : String ;
begin
  CNPJ := copy(LinhaE02,45,14) ;
  IE   := copy(LinhaE02,59,14) ;

  if CNPJ <> padR(edCNPJ.Text,14,'0') then
  begin
     LinhaE02 := StuffString( LinhaE02,45,14,padR(edCNPJ.Text,14,'0') ) ;
     Erros    := 'CNPJ corrigido.' ;
  end ;

  if IE <> padL(edIE.Text,14) then
  begin
     LinhaE02 := StuffString( LinhaE02,59,14,padL(edIE.Text,14) ) ;
     Erros    := Erros + '  IE corrigida.' ;
  end ;
end;

procedure TForm1.VerificaE13(var LinhaE13, Erros: String);
  Var Seq    : Integer ;
      SeqStr : String ;
begin
  { BUG: A numercao das aliquotas fica errada em ECFs que não usam numeros como
    Indice de Aliquota }

  // Verificando se é aliquota de ICMs ou ISS
  if pos(copy(LinhaE13,55,1), 'TS') > 0 then
  begin
     fsSeqAliq := fsSeqAliq + 1 ;
     SeqStr    :=  copy(LinhaE13,53,2) ;
     Seq       := StrToIntDef( SeqStr, 0) ;

     if Seq <> fsSeqAliq then
     begin
        LinhaE13 := StuffString(LinhaE13,53,2,IntToStrZero(fsSeqAliq,2)) ;
        Erros := 'Seq.Aliq. invalida: '+SeqStr ;
     end ;
  end ;
end;

procedure TForm1.VerificaE14(var LinhaE14, Erros: String);
  Var SubTotStr, DescStr, AcresStr, LiqStr : String ;
      SubTotal, ValDes, ValAcres, Liquido : Double ;
begin
  { BUG: Em algumas combinações de valores o Valor Liquido fica diferente do calculado (dizima decimal)}

  SubTotStr := copy( LinhaE14, 67, 14) ;
  DescStr   := copy( LinhaE14, 81, 13) ;
  AcresStr  := copy( LinhaE14, 95, 13) ;
  LiqStr    := copy( LinhaE14,109, 14) ;

  SubTotal  := RoundTo( StrToInt(SubTotStr) / 100 , -2) ;
  ValDes    := RoundTo( StrToInt(DescStr)   / 100 , -2) ;
  ValAcres  := RoundTo( StrToInt(AcresStr)  / 100 , -2) ;

  Liquido   := RoundTo( SubTotal - ValDes + ValAcres, -2) ;

  if LiqStr <> IntToStrZero( Round( Liquido * 100), 14 ) then
  begin
     LinhaE14 := StuffString(LinhaE14, 109, 14, IntToStrZero( Round( Liquido * 100), 14 )) ;
     Erros    := Erros + 'Total Liquido errado: '+LiqStr + sLineBreak ;
  end ;
end;

procedure TForm1.VerificaE15(var LinhaE15, Erros: String);

  Function NumDec( ADouble : Double) : Byte ;
    Var DblStr : String ;
        P : Integer ;
  begin
    Result := 0 ;
    DblStr := Trim(FloatToStr(ADouble)) ;
    P      := Pos(DecimalSeparator,DblStr) ;

    if P > 0 then
       Result := Length(DblStr) - P ;

    Result := max(min(Result,3),2) ;
  end ;

 Var QtdStr, Un, ValUnitStr, DescStr, TotalItemStr, DecQtdStr, DecValStr, FlagArr : String ;
     NovaLinha : String ;
     Qtd, ValUnit, Desc, TotalItem  : Double ;
     DecQtd, DecVal : Integer ;
begin
  QtdStr      := copy( LinhaE15, 176,  7) ;
  Un          := copy( LinhaE15, 183,  3) ;
  ValUnitStr  := copy( LinhaE15, 186,  8) ;
  DescStr     := copy( LinhaE15, 194,  8) ;
  TotalItemStr:= copy( LinhaE15, 210, 14) ;
  FlagArr     := copy( LinhaE15, 265,  1) ;
  DecQtdStr   := copy( LinhaE15, 266,  1) ;
  DecValStr   := copy( LinhaE15, 267,  1) ;

  DecQtd := StrToIntDef(DecQtdStr,0) ;
  DecVal := StrToIntDef(DecValStr,0) ;

  Qtd      := RoundTo( StrToInt(QtdStr)     / Power(10,DecQtd), -DecQtd) ;
  ValUnit  := RoundTo( StrToInt(ValUnitStr) / Power(10,DecVal), -DecVal) ;
  Desc     := RoundTo( StrToInt(DescStr)    / 100, -2) ;

  TotalItem := (Qtd * ValUnit) - Desc ;
  if FlagArr = 'A' then
     TotalItem := RoundTo(TotalItem,-2)
  else
     TotalItem := TruncFix( TotalItem * 100 ) / 100 ;

  if Trim(Un) = '' then
  begin
     Erros := Erros + ' Unidade vazia' + sLineBreak ;
     Un := 'UN' ;
  end ;

  DecQtd := NumDec( Qtd ) ;
  if IntToStr(DecQtd) <> DecQtdStr then
     Erros := Erros + 'N.Dec.Qtd invalida: '+DecQtdStr + sLineBreak ;

  DecVal := NumDec( ValUnit ) ;
  if IntToStr(DecVal) <> DecValStr then
     Erros := Erros + 'N.Dec.Val.Unit. invalida: '+DecValStr + sLineBreak ;

  if TotalItemStr <> IntToStrZero( Round( TotalItem * 100), 14 ) then
     Erros := Erros + 'Total do Item errado: '+TotalItemStr + sLineBreak ;

  NovaLinha := copy( LinhaE15, 1, 175) +
               IntToStrZero( Round( Qtd * Power(10,DecQtd) ), 7  ) +
               PadL( Un, 3) +
               IntToStrZero( Round( ValUnit * Power(10,DecVal) ), 8  ) +
               IntToStrZero( Round( Desc*100), 8 ) +
               StringOfChar('0',8) + // Acrescimo
               IntToStrZero( Round( TotalItem * 100), 14 ) +
               copy( LinhaE15, 224, 8) +  // Aliquota + FlagCancelado
               StringOfChar('0',33) +     // (Qtd + Valor cancelado) + Canc.Acrescimo
               FlagArr +
               IntToStr(DecQtd) +
               IntToStr(DecVal) ;

  if NovaLinha <> LinhaE15 then
     LinhaE15 := NovaLinha ;
end;

procedure TForm1.VerificaE16(var LinhaE16, Erros: String);
begin
  { BUG: O campo CDC estava com 6 casas e não com 4 }

  if Length( LinhaE16 ) > 90 then
  begin
     Erros    := 'Campo CDC com 6 casas'+sLineBreak ;
     LinhaE16 := StuffString(LinhaE16,65,2,'') ;
  end ;
end;

procedure TForm1.VerificaTotalE14E15( var LinhaE14: String; var SL : TStringList; Var Erros : String ) ;
var
  Chave, SubTotStr, LiqStr, TotalItemStr, Cupom : String ;
  SubTotal, Diferenca, SomaAnt, Soma, TotalItem : Double ;
  LinhaIni, I, cont : Integer ;
  Cancelou : Boolean;
  SLItens : TStringList;

  DescStr, AcresStr : String ;
  ValDes, ValAcres, Liquido : Double ;

begin
  SubTotStr := copy( LinhaE14, 67, 14) ;
  LiqStr    := copy( LinhaE14,109, 14) ;

  SubTotal  := RoundTo( StrToInt(SubTotStr) / 100 , -2) ;

  Chave := 'E15'+copy(LinhaE14,4,43)+copy(LinhaE14,53,6);
  Cupom := copy(LinhaE14,53,6);
  SL.Find(Chave,LinhaIni);

  I := LinhaIni;
  Soma := 0;

  while (copy(SL[I],1,52) = Chave) and (I < SL.Count) do
   begin
      if copy(SL[I],231,1) = 'N' then
       begin
         TotalItemStr:= copy( SL[I], 210, 14) ;
         TotalItem :=  StrToInt(TotalItemStr) / 100  ;
         Soma := Soma + TotalItem;
       end;  
      I := I + 1;
   end;

  Soma :=  RoundTo( Soma , -2) ;
  SomaAnt := Soma;

  if ((SubTotal <>  RoundTo(Soma+0.01, -2)) and (SubTotal <>  RoundTo(Soma-0.01,-2)) and (SubTotal <> Soma) and (Soma > 0)) then
   begin
     SLItens := TStringList.Create;
     Diferenca := RoundTo(Soma - SubTotal, -2);

     I := LinhaIni;
     Soma := 0;
     Cancelou := False;

     while (copy(SL[I],1,52) = Chave) and (I < SL.Count)  do
      begin
         if copy(SL[I],231,1) = 'N' then
          begin
            TotalItemStr:= copy( SL[I], 210, 14) ;
            TotalItem :=  RoundTo( StrToInt(TotalItemStr) / 100, -2) ;
            if ((TotalItem = RoundTo(Diferenca+0.01, -2)) or (TotalItem = RoundTo(Diferenca-0.01, -2)) or (TotalItem = Diferenca)) and (not Cancelou) then
             begin
               SL[I] := copy(SL[I],1,230)+'S'+copy(SL[I],232,36);
               Cancelou := True;
             end
            else
               Soma := Soma + TotalItem;
          end;
         SLItens.Add( SL[I] );
         I := I + 1;
      end;

     Soma :=  RoundTo( Soma , -2);

     if ((SubTotal =  RoundTo(Soma+0.01, -2)) or (SubTotal =  RoundTo(Soma-0.01, -2)) or (SubTotal = Soma)) then
        Erros := Erros + 'Total do Cupom '+Cupom +' corrigido. Cupom = '+FloatToStr(SubTotal)+' Soma Anterior ='+FloatToStr(SomaAnt) +' Soma Atual= '+FloatToStr(Soma)+ sLineBreak
     else
      begin
        AbreCupom(LinhaE14,SLItens,Diferenca);

        I := LinhaIni;
        cont := 0;
        Soma := 0;
        while (copy(SL[I],1,52) = Chave) and (I < SL.Count)  do
         begin
            SL[I] := SLItens[cont];
            if copy(SL[I],231,1) = 'N' then
             begin
               TotalItemStr:= copy( SL[I], 210, 14) ;
               TotalItem :=  RoundTo( StrToInt(TotalItemStr) / 100, -2) ;
               if ((TotalItem = RoundTo(Diferenca+0.01, -2)) or (TotalItem = RoundTo(Diferenca-0.01, -2)) or (TotalItem = Diferenca)) and (not Cancelou) then
                begin
                  SL[I] := copy(SL[I],1,230)+'S'+copy(SL[I],232,36);
                  Cancelou := True;
                end
               else
                  Soma := Soma + TotalItem;
             end;
            SLItens.Add( SL[I] );
            cont := cont + 1;
            I := I + 1;
         end;
        if ((SubTotal =  RoundTo(Soma+0.01, -2)) or (SubTotal =  RoundTo(Soma-0.01, -2)) or (SubTotal = Soma)) then
           Erros := Erros + 'Total do Cupom '+Cupom +' corrigido. Cupom = '+FloatToStr(SubTotal)+' Soma Anterior ='+FloatToStr(SomaAnt) +' Soma Atual= '+FloatToStr(Soma)+ sLineBreak
        else
           Erros := Erros + 'Total do Cupom '+Cupom +' não pode ser corrigido. Cupom = '+FloatToStr(SubTotal)+' Soma Anterior ='+FloatToStr(SomaAnt) +' Soma Atual= '+FloatToStr(Soma)+ sLineBreak;
      end;
   end;

  if ( (SubTotal =  RoundTo(Soma+0.01, -2)) or (SubTotal =  RoundTo(Soma-0.01, -2)) ) then
   begin
     SubTotStr := copy( LinhaE14, 67, 14) ;
     DescStr   := copy( LinhaE14, 81, 13) ;
     AcresStr  := copy( LinhaE14, 95, 13) ;
     LiqStr    := copy( LinhaE14,109, 14) ;

     ValDes    := RoundTo( StrToInt(DescStr)   / 100 , -2) ;
     ValAcres  := RoundTo( StrToInt(AcresStr)  / 100 , -2) ;

     if SubTotStr <> IntToStrZero( Round( Soma * 100), 14 ) then
      begin
        LinhaE14 := StuffString(LinhaE14, 67, 14, IntToStrZero( Round( Soma * 100), 14 )) ;
        Erros    := Erros + 'SubTotal errado: '+SubTotStr + sLineBreak ;
      end ;

     SubTotal := Soma;
     Liquido   := RoundTo( SubTotal - ValDes + ValAcres, -2) ;

     if LiqStr <> IntToStrZero( Round( Liquido * 100), 14 ) then
      begin
        LinhaE14 := StuffString(LinhaE14, 109, 14, IntToStrZero( Round( Liquido * 100), 14 )) ;
        Erros    := Erros + 'Total Liquido errado: '+LiqStr + sLineBreak ;
      end ;
   end;
end;

procedure TForm1.AbreCupom( LinhaE14 : String; var SL : TStringList; Diferenca : Double) ;
var
  frmCupom : TfrmCupom;
begin
  frmCupom := TfrmCupom.Create(Self);

  frmCupom.LinhaE14  := LinhaE14;
  frmCupom.Diferenca := Diferenca;
  frmCupom.SLItens   := SL;

  frmCupom.ShowModal;

  SL := frmCupom.SLItens;

  frmCupom.Free;
end;

procedure TForm1.bLerChaveClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Arquivos KEY|*.key|Todos Arquivos|*.*' ;

  if OpenDialog1.Execute then
     mKey.Lines.LoadFromFile( OpenDialog1.FileName );
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  mLog.Clear ;
  mLog.Lines.Add('Esse programa corrige alguns bugs das primeiras versões do ACBrRFD') ;
  mLog.Lines.Add('') ;
  mLog.Lines.Add('* Registro E13') ;
  mLog.Lines.Add('-- A numercao das aliquotas fica errada em ECFs que não usam numeros como Indice de Aliquota' ) ;
  mLog.Lines.Add('') ;
  mLog.Lines.Add('* Registro E14') ;
  mLog.Lines.Add('-- Em algumas combinações de valores o Valor Total Liquido fica diferente do calculado (bug em Trunc())') ;
  mLog.Lines.Add('') ;
  mLog.Lines.Add('* Registro E15') ;
  mLog.Lines.Add('-- O campo 12 - Unidade não pode ser vazio.. Se não for informado será usado "UN "' ) ;
  mLog.Lines.Add('-- O campo 16 - Total Liquido por Item estava errado (estava gravando o Total Liquido do Cupom)' ) ;
  mLog.Lines.Add('-- As decimais da Qtd e ValorUnitario deve ser sempre 2 ou 3... ') ;
  mLog.Lines.Add('   ( A CAT 52/60 não era muito clara sobre isso... e na época não soube como fazer...') ;
  mLog.Lines.Add('     Na versao anterior o ACBrRFD calculava as decimais informadas no Preço e Qtd,') ;
  mLog.Lines.Add('     podendo ser 0 a 3 mas o validador reclamou. )') ;
  mLog.Lines.Add('-- O campo 18 - Em alguns casos, o item não era marcado como cancelado.' ) ;
  mLog.Lines.Add('') ;
  mLog.Lines.Add('* Registro E16') ;
  mLog.Lines.Add('-- O campo CDC estava com 6 casas e não com 4 casas') ;
  mLog.Refresh ;
end;

procedure TForm1.edCNPJKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
     Key := #0 ;
end;

end.
