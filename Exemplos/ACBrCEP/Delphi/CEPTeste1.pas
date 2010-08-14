unit CEPTeste1 ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ACBrCEP, ACBrSocket, ACBrBase ;

type

  { TForm1 }

  TForm1 = class(TForm)
    ACBrCEP1 : TACBrCEP ;
    bBuscarCEP : TButton ;
    bBuscarLogradouro : TButton ;
    cbxWS : TComboBox ;
    edCEP : TEdit ;
    edLogradouro : TEdit ;
    edCidade : TEdit ;
    edTipo_Logradouro : TEdit ;
    edUF : TEdit ;
    edBairro : TEdit ;
    edChaveBuscarCEP : TEdit ;
    edProxyHost : TEdit ;
    edProxyPass : TEdit ;
    edProxyPort : TEdit ;
    edProxyUser : TEdit ;
    GroupBox1 : TGroupBox ;
    GroupBox2 : TGroupBox ;
    GroupBox3 : TGroupBox ;
    GroupBox4 : TGroupBox ;
    Label1 : TLabel ;
    Label10 : TLabel ;
    Label2 : TLabel ;
    Label3 : TLabel ;
    Label4 : TLabel ;
    Label5 : TLabel ;
    Label6 : TLabel ;
    Label7 : TLabel ;
    Label8 : TLabel ;
    Label9 : TLabel ;
    Memo1 : TMemo ;
    PageControl1 : TPageControl ;
    TabSheet1 : TTabSheet ;
    TabSheet2 : TTabSheet ;
    procedure ACBrCEP1BuscaEfetuada(Sender : TObject) ;
    procedure bBuscarCEPClick(Sender : TObject) ;
    procedure bBuscarLogradouroClick(Sender : TObject) ;
    procedure cbxWSChange(Sender : TObject) ;
  private
    procedure AjustaProxy ;
    { private declarations }
  public
    { public declarations }
  end ; 

var
  Form1 : TForm1 ; 

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.cbxWSChange(Sender : TObject) ;
begin
  ACBrCEP1.WebService := TACBrCEPWebService( cbxWS.ItemIndex ) ;
  edChaveBuscarCEP.Enabled := (ACBrCEP1.WebService = wsBuscarCep) ;
end;

procedure TForm1.AjustaProxy ;
begin
  ACBrCEP1.ProxyHost := edProxyHost.Text ;
  ACBrCEP1.ProxyPort := edProxyPort.Text ;
  ACBrCEP1.ProxyUser := edProxyUser.Text ;
  ACBrCEP1.ProxyPass := edProxyPass.Text ;
end ;

procedure TForm1.ACBrCEP1BuscaEfetuada(Sender : TObject) ;
var
  I : Integer ;
begin
  Memo1.Lines.Clear;

  if ACBrCEP1.Enderecos.Count < 1 then
     Memo1.Lines.Add( 'Nenhum Endereço encontrado' )
  else
   begin
     Memo1.Lines.Add( IntToStr(ACBrCEP1.Enderecos.Count) + ' Endereço(s) encontrado(s)');
     Memo1.Lines.Add('');

     For I := 0 to ACBrCEP1.Enderecos.Count-1 do
     begin
       with ACBrCEP1.Enderecos[I] do
       begin
          Memo1.Lines.Add('CEP: '+CEP );
          Memo1.Lines.Add('Logradouro: '+Tipo_Logradouro+ ' ' +Logradouro );
          Memo1.Lines.Add('Complemento: '+Complemento );
          Memo1.Lines.Add('Bairro: '+Bairro );
          Memo1.Lines.Add('Municipio: '+Municipio + ' - IBGE: '+IBGE_Municio);
          Memo1.Lines.Add('UF: '+UF + ' - IBGE: '+IBGE_UF);
          Memo1.Lines.Add( StringOfChar('-',20) );
       end ;
     end ;
   end ;

  Memo1.Lines.Add('');
  Memo1.Lines.Add('Resposta HTTP:');
  Memo1.Lines.AddStrings( ACBrCEP1.RespHTTP );
end;

procedure TForm1.bBuscarCEPClick(Sender : TObject) ;
begin
  AjustaProxy ;

  try
     ACBrCEP1.BuscarPorCEP(edCEP.Text);
  except
     On E : Exception do
     begin
        Memo1.Lines.Clear;
        Memo1.Lines.Add(E.Message);
     end ;
  end ;
end;

procedure TForm1.bBuscarLogradouroClick(Sender : TObject) ;
begin
  AjustaProxy ;

  try
     ACBrCEP1.BuscarPorLogradouro( edCidade.Text, edTipo_Logradouro.Text,
                                   edLogradouro.Text, edUF.Text, edBairro.Text);
  except
     On E : Exception do
     begin
        Memo1.Lines.Clear;
        Memo1.Lines.Add(E.Message);
     end ;
  end ;
end;

end.

