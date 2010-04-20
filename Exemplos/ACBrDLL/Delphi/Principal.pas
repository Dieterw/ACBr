unit Principal;

interface

uses
  {$IFDEF MSWINDOWS}
    Windows, Messages, Variants, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons, Spin,
  {$ELSE}
    QGraphics, QControls, QForms, QDialogs, QStdCtrls,
    QButtons,
  {$ENDIF}
  Classes, SysUtils, QComCtrls ;

type
  TfrPrincipal = class(TForm)
    Label1: TLabel;
    cbxModelo: TComboBox;
    Label4: TLabel;
    cbxPorta: TComboBox;
    seTimeOut: TSpinEdit;
    Label5: TLabel;
    bAtivar: TBitBtn;
    bAbreCupom: TBitBtn;
    bReducao: TBitBtn;
    bLeituraX: TBitBtn;
    bVendeItem: TBitBtn;
    bSubtotaliza: TBitBtn;
    bPagamento: TBitBtn;
    bFechaCupom: TBitBtn;
    bCancelaItem: TBitBtn;
    bCancelaCupom: TBitBtn;
    procedure bAtivarClick(Sender: TObject);
    procedure bAbreCupomClick(Sender: TObject);
    procedure bReducaoClick(Sender: TObject);
    procedure bLeituraXClick(Sender: TObject);
    procedure bFechaCupomClick(Sender: TObject);
    procedure bPagamentoClick(Sender: TObject);
    procedure bSubtotalizaClick(Sender: TObject);
    procedure bVendeItemClick(Sender: TObject);
    procedure bCancelaCupomClick(Sender: TObject);
    procedure bCancelaItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPrincipal: TfrPrincipal;

implementation

uses UnitDeclaracao;

{$R *.dfm}

procedure TfrPrincipal.bAtivarClick(Sender: TObject);
begin
 if DefineModelo(cbxModelo.Text , cbxPorta.Text, seTimeOut.Value ) then
    ShowMessage('Ativado com Sucesso')
 else
    ShowMessage('Não foi possível ativar o ECF');
end;

procedure TfrPrincipal.bAbreCupomClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := AbreCupom() ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bReducaoClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := ReducaoZ(Now) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bLeituraXClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := LeituraX ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bFechaCupomClick(Sender: TObject);
var Retorno : Integer ;
    Obs : String ;
begin
  Obs := InputBox('Fechamento','Digite a Observação Final:', '' );
  Retorno := FechaCupom( Obs ) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bPagamentoClick(Sender: TObject);
var Retorno : Integer ;
    CodForma, Obs : String ;
    Valor : Real ;
begin
  CodForma := InputBox('Pagamento','Digite o código da forma:', '' );
  Valor    := StrToFloatDef(InputBox('Pagamento','Digite o Valor:', '' ),0);
  Obs      := InputBox('Pagamento','Digite a Observação:', '' );
  Retorno := EfetuaPagamento( CodForma, Valor, Obs ) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bSubtotalizaClick(Sender: TObject);
var Retorno : Integer ;
    Obs : String ;
    Desconto : Real ;
begin
  Desconto := StrToFloatDef(InputBox('SubTotal','Digite o Desconto/Acréscimo:', '' ),0);
  Obs      := InputBox('SubTotal','Digite a Observação:', '' );
  Retorno := SubtotalizaCupom( Desconto, Obs ) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bVendeItemClick(Sender: TObject);
var Retorno  : Integer ;
    Codigo, Descricao, AliquotaICMS, Unidade, TipoDescontoAcrescimo : String;
    Qtd, ValorUnitario, DescontoPorc : Double ;
begin
  Codigo    := InputBox('Vende Item','Digite a Código do Produto:', '123456' );
  Descricao := InputBox('Vende Item','Digite a Descrição do Produto:', 'Teste de Produto' );
  AliquotaICMS    := InputBox('Vende Item','Digite a Alíquota do Produto:', 'II' );
  Unidade   := InputBox('Vende Item','Digite a Unidade do Produto:', 'UN' );
  TipoDescontoAcrescimo    := InputBox('Vende Item','Digite o Tipo de Desconto do Produto:', '%' );
  Qtd := StrToFloatDef(InputBox('Vende Item','Digite a Quantidade:', '1' ),0);
  ValorUnitario := StrToFloatDef(InputBox('Vende Item','Digite o Valor Unitário:', '1' ),0);
  DescontoPorc := StrToFloatDef(InputBox('Vende Item','Digite o Desconto:', '0' ),0);

  Retorno := VendeItem( Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, DescontoPorc, Unidade, TipoDescontoAcrescimo ) ;

  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bCancelaCupomClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := CancelaCupom ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bCancelaItemClick(Sender: TObject);
var Retorno : Integer ;
    Item    : Integer ;
begin
  Item := StrToInt(InputBox('Cancela Item','Digite a Número do Item:', '' ));
  Retorno := CancelaItemVendido( Item ) ;
  ShowMessage(IntToStr(Retorno));
end;

end.
