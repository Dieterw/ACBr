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
    function MensagemRetorno(iRet:Integer):string;
    function NomeArqRFD( DtMov : TDatetime; ArqTmp: String ): String;
  public
    { Public declarations }
  end;

//------- D E C L A R A Ç Ã O   D A   F U N Ç Ã O   D A   D L L -------//

function Gera_AtoCotepe1704 (ComPortOrFileName: String;
                                        Modelo: String;
                                   RegFileName: String;
                                   DataReducao: String): Integer;
                             stdcall; external 'DLLG2_Gerador.dll' name 'Gera_AtoCotepe1704';

function Gera_Conversor1704 (PathOrigem : String;
                            FileDestino : String;
                                 Modelo : String): Integer;
                            stdcall; external 'DLLG2_Gerador.dll' name 'Gera_Conversor1704';

function Gera_ConversorFMT1704 (PathOrigem : String;
                               FileDestino : String;
                                    Modelo : String): Integer;
                            stdcall; external 'DLLG2_Gerador.dll' name 'Gera_ConversorFMT1704';

//------- M E N S A G E N S   D E   R E T O R N O -------//

CONST

  COMANDOEXECUTADO           : String = 'Arquivo ATO COTEPE 17/04 gerado com sucesso.';
  ERRO_EMITELEITURAX         : String = 'Erro ao executar comando EmiteLeituraX.';
  ERRO_EMITELEITURAMF        : String = 'Erro ao executar comando EmiteLeituraMF.';
  ERRO_EMITELEITURAMFD       : String = 'Erro ao executar comando EmiteLeituraFitaDetalhe.';
  ERRO_CMDINEXISTENTE        : String = 'Comando Inexistente.';
  ERRO_DADOSIMPRESSAO        : String = 'Erro ao obter dados de impressão.';
  ERRO_ACESSARARQUIVO        : String = 'Erro ao acessar o arquivo.';
  ERRO_DATAINVALIDA          : String = 'Erro ao executar comando.Data inválida.';
  ERRO_NAOEXISTEREDUCAO      : String = 'Não existe redução executada na data informada.';
  ERRO_MODELOINVALIDO        : String = 'Modelo não permitido.';
  ERRO_COMANDOINVALIDO       : String = 'Comando inválido.';
  ERRO_DLLNAOENCONTRADA      : String = 'Biblioteca não foi encontrada.';
  ERRO_SEMSINALCTS           : String = 'Sem Sinal de CTS.';
  ERRO_NOMEARQUIVOINVALIDO   : String = 'Nome do arquivo inválido';
  ERRO_INTERVALONAOPERMITIDO : String = 'Intervalo de data não permitido';
  ERRO_ORIGEMNAOPERMITIDO    : String = 'Caminho de origem não permitido.';
  ERRO_DESTINONAOPERMITIDO   : String = 'Caminho de destino não permitido.';
  ERRO_DEFAULT               : String = 'Erro Desconhecido.';

var
  Form1: TForm1;


implementation

Uses DateUtils, Math, StrUtils, ACBrUtil, IniFiles;

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
            fRFDID := 'TP0' ;

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
             'Desenvolvido por Daniel Simões de Almeida e Fábio Farias<br><br>'+
             'Conheça o Projeto ACBR - <b><font color=blue>http://acbr.sf.net</b></font>',
             mtInformation,[mbOk],0) ;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Ini:TIniFile;
begin
 fRFDID        := '' ;
 fNumSerie     := '' ;
 medDtFim.Text := FormatDateTime('DD/MM/YYYY', Date );
 medDtIni.Text := '01'+copy(medDtFim.Text,3,8) ;

 cbxSerial.Items.Add('Default') ;
 cbxSerial.Items.Add('COM1') ;
 cbxSerial.Items.Add('COM2') ;
 cbxSerial.Items.Add('COM3') ;
 cbxSerial.Items.Add('COM4') ;
 cbxSerial.Items.Add('COM5') ;
 cbxSerial.Items.Add('COM6') ;
 cbxSerial.ItemIndex := 0 ;

 cbxModelo.Items.Add('3202DT');
 cbxModelo.Items.Add('6000EP');
 cbxModelo.Items.Add('TPF1002');
 cbxModelo.Items.Add('TPF2001');
 cbxModelo.Items.Add('TPF2002');

 Ini := TIniFile.Create( ExtractFilePath( Application.ExeName )+'TermoPrinter.ini');
 try
   cbxSerial.Text      := Ini.ReadString('Sistema','Porta','' ) ;
   edtDirTrabalho.Text := Ini.ReadString('Sistema','Path','' ) ;
   medDtIni.Text       := Ini.ReadString('Sistema','DtIni','' );
   medDtFim.Text       := Ini.ReadString('Sistema','DtFim','' );
   cbxModelo.Text      := Ini.ReadString('Sistema','Modelo','' );
 finally
    Ini.Free ;
 end;
end;

procedure TForm1.btnFecharClick(Sender: TObject);
begin
  Close ;
end;

procedure TForm1.btnGerarClick(Sender: TObject);
var
  DtIni, DtFim, Dia : TDateTime ;
  PortaSerial, Modelo, Cmd, ArqTmp, ArqRFD, DiaStr, Proprietario, ArqDia : String;
  Resp : TModalResult;
  Ini : TIniFile ;
  iRet:Integer;
begin
  PortaSerial := cbxSerial.Text;
  Modelo      := cbxModelo.Text;
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
  mLog.Lines.Add('');

  mLog.Lines.Add('- Lendo MFD do periodo: '+DateToStr(DtIni)+' a '+DateToStr(DtFim)) ;
  Application.ProcessMessages ;

  Ini := TIniFile.Create( ExtractFilePath( Application.ExeName )+'TermoPrinter.ini');
  try
    Ini.WriteString('Sistema','Porta',PortaSerial);
    Ini.WriteString('Sistema','Path',edtDirTrabalho.Text);
    Ini.WriteString('Sistema','DtIni',medDtIni.Text);
    Ini.WriteString('Sistema','DtFim',medDtFim.Text);
    Ini.WriteString('Sistema','Modelo',Modelo);
  finally
    Ini.Free ;
  end ;

  Dia := DtIni ;
  lDia.Visible := True ;
  btnGerar.Enabled := False;
  while Dia <= DtFim do
  begin
      lDia.Caption := FormatDateTime('dd/mm/yyyy',Dia) ;
      Application.ProcessMessages ;

      mLog.Lines.Add('- Processando Dia: '+lDia.Caption ) ;

      DiaStr := DateToStr(Dia);
      SetLength( ArqDia, 513) ;
      try
      iRet := Gera_AtoCotepe1704(PortaSerial, Modelo, ArqDia, DiaStr);
      except
        on E: Exception do
        begin
         mLog.Lines.Add(e.Message);
        end
      end;

      if FileExists( ArqDia ) and (iRet = 0) then
       begin
         ArqRFD := NomeArqRFD( Dia, ArqDia ) ;
         SysUtils.DeleteFile( ExtractFilePath( ArqTmp ) + ArqRFD ) ;
         RenameFile( ArqDia, ExtractFilePath( ArqTmp ) + ArqRFD ) ;
         mLog.Lines.Add('   Gerado Arquivo: '+ArqRFD ) ;
       end
      else
        mLog.Lines.Add('   Não gerado ('+FormatDateTime('dddd',Dia )+') = '+MensagemRetorno(iRet) ) ;

      ProgressBar1.Position := ProgressBar1.Max - DaysBetween(Dia,DtFim) ;
      Dia := IncDay( Dia, 1) ;
   end ;
   mLog.Lines.Add('') ;
   mLog.Lines.Add('** Finalizado em: '+FormatDateTime('hh:nn:ss',Now)) ;
   lDia.Visible := False ;
   btnGerar.Enabled := True;
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

function TForm1.MensagemRetorno(iRet:Integer):string;
begin
  case iRet of
     0  : Result:=COMANDOEXECUTADO;
    -1  : Result:=ERRO_EMITELEITURAX;
    -2  : Result:=ERRO_EMITELEITURAMF;
    -3  : Result:=ERRO_EMITELEITURAMFD;
    -4  : Result:=ERRO_CMDINEXISTENTE;
    -5  : Result:=ERRO_DADOSIMPRESSAO;
    -6  : Result:=ERRO_ACESSARARQUIVO;
    -7  : Result:=ERRO_DATAINVALIDA;
    -8  : Result:=ERRO_NAOEXISTEREDUCAO;
    -9  : Result:=ERRO_MODELOINVALIDO;
    -10 : Result:=ERRO_COMANDOINVALIDO;
    -11 : Result:=ERRO_DLLNAOENCONTRADA;
    -12 : Result:=ERRO_SEMSINALCTS;
    -13 : Result:=ERRO_NOMEARQUIVOINVALIDO;
    -14 : Result:=ERRO_INTERVALONAOPERMITIDO;
    -15 : Result:=ERRO_ORIGEMNAOPERMITIDO;
    -16 : Result:=ERRO_DESTINONAOPERMITIDO;
   else
     Result:=ERRO_DEFAULT;
   end;
end;

end.


