unit QEmulaLCB1;

interface

uses
  synaser, ACBrUtil, 
  SysUtils, Types, Classes, QForms, QStdCtrls, QControls, QTypes, QExtCtrls,
  QComCtrls ;

type
  TfrEmulador = class(TForm)
    Label1: TLabel;
    edBarra: TEdit;
    Label4: TLabel;
    cbxPorta: TComboBox;
    Label2: TLabel;
    Label5: TLabel;
    edSufixo: TEdit;
    Button1: TButton;
    cbMudaCodigo: TCheckBox;
    Label3: TLabel;
    lEnviado: TLabel;
    lcliques: TLabel;
    Timer1: TTimer;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxPortaChange(Sender: TObject);
    procedure lcliquesClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpinEdit1Changed(Sender: TObject; NewValue: Integer);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    fSerial : TBlockSerial ;
    Function Converte( cmd : String) : String;
  public
    { Public declarations }
  end;

var
  frEmulador: TfrEmulador;

implementation
Uses ACBrLCB ;

{$R *.xfm}

function TfrEmulador.Converte(cmd: String): String;
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
     if not (cmd[A] in ['A'..'Z','a'..'z','0'..'9',
                        ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                        '\','|','=','+','-','_',')','(','*','&','^','%','$',
                        '#','@','!','~',']' ]) then
        Result := Result + '#' + IntToStr(ord( cmd[A] )) + ' '
     else
        Result := Result + cmd[A] + ' ';
  end ;
end;

procedure TfrEmulador.FormCreate(Sender: TObject);
begin
  fSerial := TBlockSerial.Create ;
  fSerial.RaiseExcept := true ;
end;

procedure TfrEmulador.Button1Click(Sender: TObject);
begin
  if not fSerial.InstanceActive then
  begin
     fSerial.Connect( cbxPorta.Text );
     fSerial.Config(9600,8,'N',0,false,false);
  end ;

  fSerial.DeadlockTimeout := 1000 ;
  fSerial.Purge ;                   { Limpa a Porta }

  fSerial.SendString( edBarra.Text + TraduzComando( edSufixo.Text ) );
  lcliques.Caption := IntToStrZero( StrToInt(lcliques.Caption) + 1 ,3) ;

  lEnviado.Caption := Converte( edBarra.Text + TraduzComando( edSufixo.Text ) ) ;
  if cbMudaCodigo.Checked then
  begin
     edBarra.Text := IntToStr( StrToInt64(copy(edBarra.Text,1,12))+1 ) ;
     edBarra.Text := edBarra.Text + EAN13_DV(edBarra.Text) ;
  end ;
end;

procedure TfrEmulador.cbxPortaChange(Sender: TObject);
begin
  if Assigned( fSerial ) then
     if fSerial.InstanceActive then
        fSerial.CloseSocket ;
end;

procedure TfrEmulador.lcliquesClick(Sender: TObject);
begin
  lcliques.Caption := '000' ;
end;

procedure TfrEmulador.Button2Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled ;
  if Timer1.Enabled then
     Button2.Caption := 'Parar'
  else
     Button2.Caption := 'Envia a cada '+IntToStr(SpinEdit1.Value)+' seg' ;
end;

procedure TfrEmulador.Timer1Timer(Sender: TObject);
begin
  Button1.Click ;
end;

procedure TfrEmulador.SpinEdit1Changed(Sender: TObject; NewValue: Integer);
begin
  Button2.Caption := 'Envia a cada '+IntToStr(NewValue)+' seg' ;
  Timer1.Interval := NewValue * 1000 ;
end;

procedure TfrEmulador.Button3Click(Sender: TObject);
Var Txt : String ;
begin
  Txt := Edit1.Text + TraduzComando( edSufixo.Text ) +
         Edit2.Text + TraduzComando( edSufixo.Text ) +
         Edit3.Text + TraduzComando( edSufixo.Text ) ;
  fSerial.SendString( Txt );
  lcliques.Caption := IntToStrZero( StrToInt(lcliques.Caption) + 3 ,3) ;

  lEnviado.Caption := Converte( Txt ) ;
end;

end.
