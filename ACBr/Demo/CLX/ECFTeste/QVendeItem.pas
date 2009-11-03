unit QVendeItem;

interface

uses
  SysUtils, Classes, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QMask, QExtCtrls;

type
  TfrVendeItem = class(TForm)
    Label1: TLabel;
    edCodigo: TEdit;
    Label2: TLabel;
    edDescricao: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edICMS: TEdit;
    Label7: TLabel;
    edUN: TEdit;
    Button1: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edPrecoUnita: TEdit;
    Button2: TButton;
    edQtd: TEdit;
    rbPercentagem: TRadioButton;
    rbValor: TRadioButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Panel1: TPanel;
    rbAcrescimo: TRadioButton;
    rbDesconto: TRadioButton;
    edDescAcres: TEdit;
    Label6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure edQtdKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frVendeItem: TfrVendeItem;

implementation

uses QECFTeste1;

{$R *.xfm}

procedure TfrVendeItem.edQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [',','.'] then
     Key := DecimalSeparator ;
end;

procedure TfrVendeItem.Button1Click(Sender: TObject);
Var Desc, Tipo : Char ;
begin
//  if Form1.ACBrECF1.AguardandoResposta then
//     raise Exception.Create('Aguarde imprimindo Item anterior...') ;

  Button1.Enabled := False ;
  Tipo := '%' ;
  if rbValor.Checked then
     Tipo := '$' ;
  Desc := 'D' ;
  if rbAcrescimo.Checked then
     Desc := 'A' ;

  try
     Form1.ACBrECF1.VendeItem( edCodigo.Text, edDescricao.Text,
                               edICMS.Text, StrToFloatDef( edQtd.Text, 0 ),
                               StrToFloatDef( edPrecoUnita.Text,0 ),
                               StrToFloatDef( edDescAcres.Text,0 ), edUN.Text,
                               Tipo, Desc );
     Form1.mResp.Lines.Add( 'Vende Item: Cod:'+ edCodigo.Text+
                            ' Desc'+ edDescricao.Text+
                            ' Aliq:'+edICMS.Text +
                            ' Qtd:'+edQtd.Text +
                            ' Preço:'+edPrecoUnita.Text +
                            ' Desc:'+edDescAcres.Text +
                            ' Un:'+edUN.Text +
                            ' Tipo:'+Tipo +
                            ' Desc:'+Desc);
     Form1.AtualizaMemos ;
  finally
     Button1.Enabled := True ;
  end ;
end;

procedure TfrVendeItem.Button2Click(Sender: TObject);
begin
  close ;
end;

end.
