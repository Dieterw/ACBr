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
    cbxSerial: TComboBox;
    mLog: TMemo;
    lDia: TLabel;
    ProgressBar1: TProgressBar;
    btnExplorar: TBitBtn;
    medDtIni: TMaskEdit;
    medDtFim: TMaskEdit;
    Label6: TLabel;
    cbxModelo: TComboBox;
    Label2: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnDirTrabClick(Sender: TObject);
    procedure btnExplorarClick(Sender: TObject);
  private
    { Private declarations }
    fRFDID, fNumSerie : String ;

    function NomeArqRFD(DtMov: TDatetime; ArqTmp: String): String;
  public
    { Public declarations }
  end;


{$IFDEF MSWINDOWS}
 function Bematech_FI_AbrePortaSerial: Integer; StdCall; External 'BEMAFI32.DLL';
 function Bematech_FI_FechaPortaSerial: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_FechaPortaSerial';

 function Bematech_FI_NumeroSubstituicoesProprietario( NumeroSubstituicoes: String ): Integer; StdCall; External 'BEMAFI32.DLL';
 function Bematech_FI_DownloadMFD( Arquivo: String; TipoDownload: String; ParametroInicial: String; ParametroFinal: String; UsuarioECF: String ): Integer; StdCall; External 'BEMAFI32.DLL';
 function Bematech_FI_GeraRegistrosCAT52MFDEx( cArquivo: String; cData: String; cArqDestino: String): Integer; StdCall; External 'BEMAFI32.DLL';
{$ENDIF}

var
  Form1: TForm1;


implementation
Uses DateUtils, Math, StrUtils, ACBrUtil
     {$IFDEF MSWINDOWS}
      ,IniFiles
     {$ENDIF} ;

{$R *.xfm}

function TForm1.NomeArqRFD( DtMov : TDatetime; ArqTmp: String ): String;
  function IntToLetra(AInt : Integer): Char ;
  begin
     if AInt < 10 then
        Result := IntToStr(AInt)[1]
     else
        Result := Chr( 55 + Min(AInt,35) ) ; // 55+10=chr(65)=>'A' ; 55+35 => Máximo Z
  end ;

  Var DtStr, Modelo : String ;
      SL    : TStringList ;
      I     : Integer ;
begin
   if fRFDID = '' then
   begin
      SL := TStringList.Create ;
      try
         SL.LoadFromFile(ArqTmp);
         if SL.Count > 0 then
         begin
            if copy(SL[0],1,3) = 'E01' then
            begin
               fNumSerie := Trim(copy(SL[0],4,20)) ; 
               Modelo    := Trim(copy(SL[0],52,20)) ;
               I         :=  0 ;

               while (fRFDID = '') and (I < cbxModelo.Items.Count) do
               begin
                  if pos(Modelo, cbxModelo.Items[I] ) > 0 then
                     fRFDID := copy(cbxModelo.Items[I],1,3) ;

                  Inc( I ) ;
               end ;
            end ;
         end ;

         if fRFDID = '' then
            fRFDID := 'BE0' ;

      finally
         SL.Free ;
      end ;
   end ;

   if (fNumSerie = '') or (fRFDID = '') then
      raise Exception.Create('Erro ao identificar o Numero de série ou RFDID');

   DtStr  := FormatDateTime('ddmmyy', DtMov) ;
   Result := fRFDID +
             RightStr(fNumSerie,5)+'.'+
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
begin
 fRFDID        := '' ;
 fNumSerie     := '' ;
 medDtFim.Text := FormatDateTime('DD/MM/YYYY', Date );
 medDtIni.Text := '01'+copy(medDtFim.Text,3,8) ;

 {$IFDEF LINUX}
  cbxSerial.Items.Add('/dev/ttyS0') ;
  cbxSerial.Items.Add('/dev/ttyS1') ;
  cbxSerial.Items.Add('/dev/ttyS2') ;
  cbxSerial.Items.Add('/dev/ttyUSB0') ;
  cbxSerial.Items.Add('/dev/ttyUSB1') ;
 {$ELSE}
  cbxSerial.Items.Add('Default') ;
  cbxSerial.Items.Add('COM1') ;
  cbxSerial.Items.Add('COM2') ;
  cbxSerial.Items.Add('COM3') ;
  cbxSerial.Items.Add('COM4') ;
  cbxSerial.Items.Add('COM5') ;
  cbxSerial.Items.Add('COM6') ;
 {$ENDIF}
 cbxSerial.ItemIndex := 0 ;
end;

procedure TForm1.btnFecharClick(Sender: TObject);
begin
  close ;
end;

procedure TForm1.btnGerarClick(Sender: TObject);
var
  DtIni, DtFim, Dia : TDateTime ;
  Cmd, ArqTmp, ArqRFD, DiaStr, Proprietario, ArqDia : String;
  Resp : TModalResult;
  {$IFDEF MSWINDOWS}
   Ini : TIniFile ;
  {$ENDIF}
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

  if not DirectoryExists( edtDirTrabalho.Text ) then
  begin
     edtDirTrabalho.SetFocus ;
     raise Exception.Create('Diretório destino não existe') ;
  end ;

  Resp := MessageDlg('Ato Cotepe 17/04',
                     'Este Procedimento levará varios minutos.<br><br>'+
                     'Deseja continuar?', mtConfirmation,mbYesNo,0) ;

  if Resp <> mrYes then  
  begin
     MessageDlg('Ato Cotepe 17/04', 'Operação Cancelada', mtInformation,[mbOk],0) ;
     exit ;
  end ;

  ProgressBar1.Max := DaysBetween(DtIni,DtFim)+1 ;
  ArqTmp := Trim(edtDirTrabalho.Text) ;
  if RightStr(ArqTmp,1) <> PathDelim then   { Tem delimitador no final ? }
        ArqTmp := ArqTmp + PathDelim ;
  ArqTmp := ArqTmp + 'ACBR' ;

  mLog.Lines.Add('') ;
  mLog.Lines.Add('** Iniciado em: '+FormatDateTime('hh:nn:ss',Now) ) ;

  mLog.Lines.Add('- Lendo MFD do periodo: '+DateToStr(DtIni)+' a '+DateToStr(DtFim)) ;
  Application.ProcessMessages ;

  {$IFDEF LINUX}
   SysUtils.DeleteFile(ArqTmp + '.MFD') ;
   Cmd := cbxSerial.Text + ' '+
          ArqTmp+'.MFD 1 '+
          FormatDateTime('ddmmyy',DtIni)+' '+
          FormatDateTime('ddmmyy',DtFim) ;

   RunCommand('./linuxmfd',Cmd,True) ;
  {$ELSE}
   Ini := TIniFile.Create( ExtractFilePath( Application.ExeName )+'BemaFI32.ini');
   try
      Ini.WriteString('Sistema','Porta',cbxSerial.Text ) ;
      Ini.WriteString('Sistema','Path',edtDirTrabalho.Text ) ;
   finally
      Ini.Free ;
   end ;

   if Bematech_FI_AbrePortaSerial <> 1 then
      raise Exception.Create('Erro ao abrir a Porta Serial');

   SetLength(Proprietario, 5) ;
   Resp := Bematech_FI_NumeroSubstituicoesProprietario( Proprietario ) ;
   Proprietario := Trim(Proprietario) ;
   if (Resp <> 1) or (Proprietario = '') then
      raise Exception.Create('Erro ao ler o Numero do proprietário atual');

   Resp := Bematech_FI_DownloadMFD( PChar(ArqTmp + '.MFD' ),
                                    '1',
                                    PChar(FormatDateTime('ddmmyy',DtIni)),
                                    PChar(FormatDateTime('ddmmyy',DtFim)),
                                    PChar(Proprietario) ) ;
   if Resp <> 1 then
      raise Exception.Create('Erro ao ler a MFD');
  {$ENDIF}

  if not FilesExists(ArqTmp + '.MFD') then
  begin
     mLog.Lines.Add('ERRO ao ler MFD ! ') ;
     exit ;
  end ;

  Dia := DtIni ;
  lDia.Visible := True ;
  while Dia <= DtFim do
  begin
     lDia.Caption := FormatDateTime('dd/mm/yyyy',Dia) ;
     Application.ProcessMessages ;

     mLog.Lines.Add('- Processando Dia: '+lDia.Caption ) ;

     {$IFDEF LINUX}
      DiaStr := FormatDateTime('ddmmyy',Dia) ;
      ArqDia := ArqTmp + '.TDM' ;
      SysUtils.DeleteFile( ArqDia ) ;
      Cmd := ArqTmp + '.TDM '+
             ArqTmp + '.MFD 10 '+
             DiaStr+' '+DiaStr ;

      RunCommand('./bemamfd2',Cmd,True) ;
     {$ELSE}
      DiaStr := FormatDateTime('dd/mm/yyyy',Dia) ;
      SetLength( ArqDia, 513) ;
      Bematech_FI_GeraRegistrosCAT52MFDEx(ArqTmp+'.MFD', Pchar(DiaStr), ArqDia ) ;
     {$ENDIF}

      if FileExists( ArqDia ) then
       begin
         ArqRFD := NomeArqRFD( Dia, ArqDia ) ;
         SysUtils.DeleteFile( ExtractFilePath( ArqTmp ) + ArqRFD ) ;
         RenameFile( ArqDia, ExtractFilePath( ArqTmp ) + ArqRFD ) ;
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


