unit UTEFTeste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrECF, ACBrBase, ACBrTEF;

type
  TForm1 = class(TForm)
    BtnAtivar: TButton;
    ACBrTEF1: TACBrTEF;
    ACBrECF1: TACBrECF;
    BtnADM: TButton;
    BtnGPAtivo: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure BtnAtivarClick(Sender: TObject);
    procedure BtnADMClick(Sender: TObject);
    procedure BtnGPAtivoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math;

{$R *.dfm}

procedure TForm1.BtnAtivarClick(Sender: TObject);
begin
   ACBrECF1.Ativar;
   
   If ACBrTEF1.Ativo then
      ACBrTEF1.Desativar
   else
      ACBrTEF1.Ativar;

   If ACBrTEF1.Ativo then
      BtnAtivar.Caption := 'Desativar TEF'
   else
      BtnAtivar.Caption := 'Ativar TEF';
end;

procedure TForm1.BtnADMClick(Sender: TObject);
begin
   ACBrTEF1.ADM;
end;

procedure TForm1.BtnGPAtivoClick(Sender: TObject);
begin
   If ACBrTEF1.GPAtivo then
      ShowMessage('Ativo: SIM ! - Tipo -> ' + ACBrTEF1.TipoStr)
   else
      ShowMessage('Ativo: NÃO ! - Tipo -> ' + ACBrTEF1.TipoStr);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   ACBrTEF1.FechaVendaTEF('C', '', 2.30, Handle, 'Teste TEF!!!');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   If ACBrECF1.Ativo then
   begin
      ACBrECF1.AbreCupom();
      ACBrECF1.VendeItem('0123456789123','Teste TEF', 'FF', 1, 2.30, 0, 'Test', '%');
      ACBrECF1.SubtotalizaCupom();
   end
   else
      ShowMessage('ECF não esta ativo !'); 
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   ACBrECF1.CancelaCupom;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   ACBrTEF1.CancelaCupomTEF;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
   ACBrECF1.LeituraX;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
   ACBrECF1.ReducaoZ(Date);
end;

end.
