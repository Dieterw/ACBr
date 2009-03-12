unit principal;

interface

uses
  SysUtils, Classes, QForms, QDialogs, QMask, QComCtrls, QStdCtrls, QButtons,
  QControls;

type
  TForm1 = class(TForm)
    btnGerar: TBitBtn;
    btnFechar: TBitBtn;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    edtDirTrabalho: TEdit;
    btnDirTrab: TBitBtn;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbxSerial: TComboBox;
    cbxVelocidade: TComboBox;
    btnAtivar: TBitBtn;
    Label3: TLabel;
    edNumSerie: TEdit;
    Label4: TLabel;
    edECF: TEdit;
    Label5: TLabel;
    edLoja: TEdit;
    mLog: TMemo;
    lDia: TLabel;
    ProgressBar1: TProgressBar;
    btnExplorar: TBitBtn;
    medDtIni: TMaskEdit;
    medDtFim: TMaskEdit;
    Label6: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure btnDirTrabClick(Sender: TObject);
    procedure btnExplorarClick(Sender: TObject);
  private
    { Private declarations }
    function NomeArqRFD(DtMov: TDatetime): String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation
Uses UnitDeclaracoesEpson, DateUtils, Math, StrUtils, ACBrUtil
     {$IFDEF MSWINDOWS}
      ,Windows ,Registry ,ShellAPI
     {$ENDIF} ;

{$R *.xfm}

function TForm1.NomeArqRFD( DtMov : TDatetime ): String;
  function IntToLetra(AInt : Integer): Char ;
  begin
     if AInt < 10 then
        Result := IntToStr(AInt)[1]
     else
        Result := Chr( 55 + Min(AInt,35) ) ; // 55+10=chr(65)=>'A' ; 55+35 => Máximo Z
  end ;

  Var DtStr : String ;
begin
   DtStr  := FormatDateTime('ddmmyy', DtMov) ;
   Result := 'EP0'+
             RightStr(edNumSerie.Text,5)+'.'+
             IntToLetra(StrToInt(copy(DtStr,1,2)))+
             IntToLetra(StrToInt(copy(DtStr,3,2)))+
             IntToLetra(StrToInt(copy(DtStr,5,2))) ;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  MessageDlg('Ato Cotepe 17/04',
             '<B>Contribuição do Projeto ACBr.</b><br><br>'+
             'Desenvolvido por Daniel Simões de Almeida<br><br>'+
             'Conheça o Projeto ACBR - <b><font color=blue>http://acbr.sf.net</b></font>',
             mtInformation,[mbOk],0) ;
end;

procedure TForm1.FormCreate(Sender: TObject);
{$IFDEF MSWINDOWS}
 var
   Reg: TRegistry;
{$ENDIF}   
begin
{$IFDEF MSWINDOWS}
 Reg := TRegistry.Create;
 try
   Reg.RootKey := HKEY_LOCAL_MACHINE;
   if Reg.KeyExists('SOFTWARE\EPSON\InterfaceEpson') then
    begin
      Reg.OpenKey('SOFTWARE\EPSON\InterfaceEpson', false);

      if Reg.ValueExists('Path') then
      begin
         edtDirTrabalho.Text := Reg.ReadString('Path');
      end;

      if Reg.ValueExists('Port') then
      begin
         cbxSerial.Text := 'COM' + IntToStr( Reg.ReadInteger('Port') );
      end;

      if Reg.ValueExists('Speed') then
      begin
         cbxVelocidade.Text := IntToStr( Reg.ReadInteger('Speed') );
      end;
    end;
 finally
   Reg.Free;
 end;
{$ENDIF}

 medDtIni.Text := FormatDateTime('DD/MM/YYYY', Date );
 medDtFim.Text := medDtIni.Text ;
end;

procedure TForm1.btnFecharClick(Sender: TObject);
begin
  close ;
end;

procedure TForm1.btnGerarClick(Sender: TObject);
var
  {$IFDEF MSWINDOWS}
   Reg : TRegistry;
  {$ENDIF}
  DtIni, DtFim, Dia : TDateTime ;
  ArqTmp, ArqRFD, DiaStr : String;
  Resp : TModalResult;
begin

  ShortDateFormat := 'DD/MM/YYYY' ;
  try
     DtIni := StrToDate(medDtIni.Text) ;
  except
     medDtIni.SetFocus ;
     raise Exception.Create('Data Inicial inválida.') ;
  end ;

  try
     DtFim := StrToDate(medDtFim.Text) ;
  except
     medDtFim.SetFocus ;
     raise Exception.Create('Data Final inválida.') ;
  end ;

  if DtFim < DtIni then
  begin
     medDtFim.SetFocus ;
     raise Exception.create('Data Final deve ser Igual ou superior a Data Inicial') ;
  end ;

  Resp := MessageDlg('Ato Cotepe 17/04',
                     'Este Procedimento levará varios minutos.<br><br>'+
                     'Deseja continuar?', mtConfirmation,mbYesNo,0) ;

  if Resp <> mrYes then  
  begin
     MessageDlg('Ato Cotepe 17/04', 'Operação Cancelada', mtInformation,[mbOk],0) ;
     exit ;
  end ;

  {$IFDEF MSWINDOWS}
   Reg := TRegistry.Create;
   try
     Reg.RootKey := HKEY_LOCAL_MACHINE;
     Reg.OpenKey('SOFTWARE\EPSON\InterfaceEpson', true);
     Reg.WriteString('Path',edtDirTrabalho.Text);
   finally
     Reg.Free;
   end;
  {$ENDIF}

  ProgressBar1.Max := DaysBetween(DtIni,DtFim)+1 ;
  ArqTmp := Trim(edtDirTrabalho.Text) ;
  if RightStr(ArqTmp,1) <> PathDelim then   { Tem delimitador no final ? }
        ArqTmp := ArqTmp + PathDelim ;
  ArqTmp := ArqTmp + 'ACBR' ;

  mLog.Lines.Add('') ;
  mLog.Lines.Add('** Iniciado em: '+FormatDateTime('hh:nn:ss',Now) ) ;

  Dia := DtIni ;
  lDia.Visible := True ;
  while Dia <= DtFim do
  begin
     lDia.Caption := FormatDateTime('dd/mm/yyyy',Dia) ;
     DiaStr       := FormatDateTime('ddmmyyyy',Dia) ;
     Application.ProcessMessages ;

     mLog.Lines.Add('- Processando Dia: '+lDia.Caption ) ;
     Resp := EPSON_Obter_Dados_MF_MFD(  PChar(DiaStr),    // Dt.Ini
                                        PChar(DiaStr),    // Dt.Final
                                        0,                // Periodo em Datas
                                        0,                // Nenhum Espelho //65535, // Todos Documentos
                                        3,                // TDM
                                        0,                // Nao Sintegra
                                        PChar( ArqTmp ) );

     if (Resp = 0) and FileExists( ArqTmp + '_CTP.txt' ) then
      begin
        ArqRFD := NomeArqRFD( Dia ) ;
        SysUtils.DeleteFile( ExtractFilePath( ArqTmp ) + ArqRFD ) ;
        RenameFile( ArqTmp + '_CTP.txt', ExtractFilePath( ArqTmp ) + ArqRFD ) ;
        mLog.Lines.Add('   Gerado Arquivo: '+ArqRFD ) ;
      end
     else
        mLog.Lines.Add('   Não gerado ('+FormatDateTime('dddd',Dia )+')' ) ;

     ProgressBar1.Position := ProgressBar1.Max - DaysBetween(Dia,DtFim) ;
     Dia := IncDay( Dia, 1) ;
  end ;
  mLog.Lines.Add('') ;
  mLog.Lines.Add('** Finalizado em: '+FormatDateTime('hh:nn:ss',Now)) ;
  lDia.Visible := False ;
end;


procedure TForm1.btnAtivarClick(Sender: TObject);
 Var iRetorno : Integer ;
     iConta:Integer;
     szDadosImpressora:String;
begin
  if btnAtivar.Caption = 'Desativar' then
   begin
     iRetorno := EPSON_Serial_Fechar_Porta() ;
     if iRetorno <> 0 then
        raise Exception.Create('Erro ao fechar Porta Serial') ;

     edECF.Text      := '' ;
     edLoja.Text     := '' ;
     edNumSerie.Text := '' ;

     btnAtivar.Caption := 'Ativar' ;
     btnGerar.Enabled  := False ;

     mLog.Lines.Add('') ;
     mLog.Lines.Add('ECF DESativado') ;
     mLog.Lines.Add('') ;
   end
  else
   begin
     iRetorno := EPSON_Serial_Abrir_PortaEx();
     if iRetorno <> 0 then
     begin
          iRetorno := EPSON_Serial_Abrir_Porta( StrToIntDef( cbxVelocidade.Text, 38400) ,
                                           StrToIntDef( copy(cbxSerial.Text,4,1), 1 ) );
        if iRetorno <> 0 then
           raise Exception.Create( 'Erro ao abrir a porta Serial:  '+cbxSerial.Text) ;
     end ;

     For iConta := 1 To 110 Do
       szDadosImpressora := szDadosImpressora + ' ';

     iRetorno := EPSON_Obter_Dados_Impressora(PChar(szDadosImpressora));
     edNumSerie.Text := copy( szDadosImpressora,1,20) ;

     try
        StrToInt(RightStr(edNumSerie.Text,5)) ;
     except
        raise Exception.Create('Erro na leitura do Numero de série');
     end ;

     iRetorno    := EPSON_Obter_Numero_ECF_Loja(PChar(szDadosImpressora));
     edECF.Text  := copy( szDadosImpressora,1,3) ;
     edLoja.Text := copy( szDadosImpressora,4,4) ;

     btnAtivar.Caption := 'Desativar' ;
     btnGerar.Enabled  := True ;
     mLog.Lines.Add('') ;
     mLog.Lines.Add('ECF ATIVADO') ;
     mLog.Lines.Add('') ;
   end ;
end;

procedure TForm1.btnDirTrabClick(Sender: TObject);
 Var Dir : WideString ;
begin
  Dir := edtDirTrabalho.Text ;
  if SelectDirectory('Selecione um Diretório',Dir, Dir) then
     edtDirTrabalho.Text := Dir ;
end;

procedure TForm1.btnExplorarClick(Sender: TObject);
begin
  OpenURL(edtDirTrabalho.Text);
end;

end.
