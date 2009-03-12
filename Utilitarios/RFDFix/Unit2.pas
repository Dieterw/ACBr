unit Unit2;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QExtCtrls, QGrids, QButtons, QImgList;

type
  TfrmCupom = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    edtCCF: TEdit;
    edtCOO: TEdit;
    edtEmissao: TEdit;
    edtSubTotal: TEdit;
    edtDesconto: TEdit;
    edtAcrescimo: TEdit;
    edtValLiquido: TEdit;
    Label8: TLabel;
    edtCancAcres: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtNomeCli: TEdit;
    edtTipoDesc: TEdit;
    edtTipoAcres: TEdit;
    edtCancelado: TEdit;
    edtOrdemDA: TEdit;
    stgItens: TStringGrid;
    Label12: TLabel;
    edtCPF: TEdit;
    btnGravar: TBitBtn;
    ImageList1: TImageList;
    GroupBox2: TGroupBox;
    lblTotItens: TLabel;
    GroupBox1: TGroupBox;
    lblTotCupom: TLabel;
    GroupBox3: TGroupBox;
    lblDiferenca: TLabel;
    procedure FormShow(Sender: TObject);
    procedure stgItensDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure stgItensSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    Gravou : Boolean;
  public
    { Public declarations }
    LinhaE14 : String;
    Diferenca : Double;
    SLItens  : TStringList;
  end;

var
  frmCupom: TfrmCupom;

implementation
Uses ACBrUtil ,Math;

{$R *.xfm}

procedure TfrmCupom.FormShow(Sender: TObject);
var
  I : Integer;
  TotItens : Double;
  DecQtd, DecPreco : Integer;
begin
 edtCCF.Text      := copy(LinhaE14,47,6);
 edtCOO.Text      := copy(LinhaE14,53,6);
 edtEmissao.Text  := copy(LinhaE14,59,8);
 edtSubTotal.Text := FloatToStr(RoundTo( StrToInt(copy(LinhaE14,67,14)) / 100 , -2)) ;
 edtDesconto.Text := FloatToStr(RoundTo( StrToInt(copy(LinhaE14,81,13)) / 100 , -2)) ;
 edtTipoDesc.Text := copy(LinhaE14,94,1);
 edtAcrescimo.Text  := FloatToStr(RoundTo( StrToInt(copy(LinhaE14,95,13)) / 100 , -2)) ;
 edtTipoAcres.Text  := copy(LinhaE14,108,1);
 edtValLiquido.Text := FloatToStr(RoundTo( StrToInt(copy(LinhaE14,109,14)) / 100 , -2)) ;
 edtCancelado.Text  := copy(LinhaE14,123,1);
 edtCancAcres.Text  := FloatToStr(RoundTo( StrToInt(copy(LinhaE14,124,13)) / 100 , -2)) ;
 edtOrdemDA.Text  := copy(LinhaE14,137,1);
 edtNomeCli.Text  := copy(LinhaE14,138,40);
 edtCPF.Text      := copy(LinhaE14,178,14);

 lblTotCupom.Caption  := Formatfloat('###,##0.00',RoundTo( StrToInt(copy(LinhaE14,67,14)) / 100 , -2)) ;
 lblDiferenca.Caption := Formatfloat('###,##0.00',Diferenca) ;

 stgItens.Cells[0,0] := 'Canc.';
 stgItens.ColWidths[0] := 30;
 stgItens.Cells[1,0] := 'Item';
 stgItens.ColWidths[1] := 30;
 stgItens.Cells[2,0] := 'Código';
 stgItens.ColWidths[2] := 90;
 stgItens.Cells[3,0] := 'Descrição';
 stgItens.ColWidths[3] := 320;
 stgItens.Cells[4,0] := 'Qtdade';
 stgItens.ColWidths[4] := 40;
 stgItens.Cells[5,0] := 'UN';
 stgItens.ColWidths[5] := 30;
 stgItens.Cells[6,0] := 'Valor Unit.';
 stgItens.ColWidths[6] := 60;
 stgItens.Cells[7,0] := 'Total Líquido';
 stgItens.ColWidths[7] := 70;
 stgItens.RowCount := SLItens.Count+1;

 I := 0;
 TotItens := 0;
 while I < SLItens.Count do
  begin
   if copy(SLItens[I],266,1) = '3' then
      DecQtd := 1000
   else
      DecQtd := 100;

   if copy(SLItens[I],267,1) = '3' then
      DecPreco := 1000
   else
      DecPreco := 100;

   stgItens.Cells[0,I+1] := copy(SLItens[I],231,1);
   stgItens.Cells[1,I+1] := copy(SLItens[I],59,3);
   stgItens.Cells[2,I+1] := copy(SLItens[I],62,14);
   stgItens.Cells[3,I+1] := copy(SLItens[I],76,100);
   if DecQtd = 100 then
      stgItens.Cells[4,I+1] := Formatfloat('###,##0.00',RoundTo( StrToInt(copy(SLItens[I],176,7)) / DecQtd , -2))
   else
      stgItens.Cells[4,I+1] := Formatfloat('###,##0.000',RoundTo( StrToInt(copy(SLItens[I],176,7)) / DecQtd , -2));
   stgItens.Cells[5,I+1] := copy(SLItens[I],183,3);
   if DecPreco = 100 then
      stgItens.Cells[6,I+1] := Formatfloat('###,##0.00',RoundTo( StrToInt(copy(SLItens[I],186,08)) / DecPreco , -2))
   else
      stgItens.Cells[6,I+1] := Formatfloat('###,##0.000',RoundTo( StrToInt(copy(SLItens[I],186,08)) / DecPreco , -2)) ;
   stgItens.Cells[7,I+1] := Formatfloat('###,##0.00',RoundTo( StrToInt(copy(SLItens[I],210,14)) / 100 , -2)) ;
   if copy(SLItens[I],231,1) = 'N' then
      TotItens := TotItens + RoundTo( StrToInt(copy(SLItens[I],210,14)) / 100 , -2);
   I := I + 1;
  end;

 lblTotItens.Caption := Formatfloat('###,##0.00',TotItens);


end;


procedure TfrmCupom.stgItensDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  {pinta checkbox}
  if (ACol = 0) and (ARow > 0) then
   begin
    stgItens.Canvas.FillRect(Rect);
    if stgItens.Cells[ACol,ARow] = 'S' then
      ImageList1.Draw(stgItens.Canvas, Rect.Left + 10, Rect.Top + 1, 1)
    else
      ImageList1.Draw(stgItens.Canvas, Rect.Left + 10, Rect.Top + 1, 0);
   end;
end;


procedure TfrmCupom.stgItensSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  I : Integer;
  TotItens : Double;
begin
  if (ACol = 0) and (ARow > 0) then
   begin
     if stgItens.Cells[ACol,ARow] = 'S' then
        stgItens.Cells[ACol,ARow] := 'N'
     else
        stgItens.Cells[ACol,ARow] := 'S';

     I := 1;
     TotItens := 0;
     while I < stgItens.RowCount do
      begin
       if stgItens.Cells[ACol,I] = 'N' then
          TotItens := TotItens +  StrToFloat(stgItens.Cells[7,I]);
       I := I + 1;
      end;

     lblTotItens.Caption  := Formatfloat('###,##0.00',TotItens);
     lblDiferenca.Caption := Formatfloat('###,##0.00',TotItens-StrToFloat(lblTotCupom.Caption)) ;

   end;
end;

procedure TfrmCupom.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := Gravou;
end;

procedure TfrmCupom.FormCreate(Sender: TObject);
begin
  Gravou := False;
end;

procedure TfrmCupom.btnGravarClick(Sender: TObject);
var
 I : Integer;
begin
 if (StrToFloat(lblDiferenca.Caption) < 0.01) and (StrToFloat(lblDiferenca.Caption) >= 0) then
  begin
    I := 1;
    while I < stgItens.RowCount do
     begin
      SLItens[I-1] := copy(SLItens[I-1],1,230)+stgItens.Cells[0,I]+copy(SLItens[I-1],232,36);
      I := I + 1;
     end;
     Gravou := True;
     Close;
  end
 else
  begin
     if MessageDlg('Cupom ainda continua com diferença. Deseja realmente sair?',
                 mtInformation,[mbYes,mbNo],0) = mrYes then
      begin
        Gravou := True;
        Close;
      end
     else
        Gravou := False;
  end;
end;

end.
