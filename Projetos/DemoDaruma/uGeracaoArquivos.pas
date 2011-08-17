unit uGeracaoArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, Spin, ComCtrls, ExtCtrls;

type
  TfrmGeracaoArquivos = class(TfrmBasicoModal)
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cbxArqMFDFinalidade: TComboBox;
    cbxTipoParametro: TComboBox;
    rgbTipoArquivo: TRadioGroup;
    edtDataInicial: TDateTimePicker;
    edtDataFinal: TDateTimePicker;
    edtContInicial: TSpinEdit;
    edtContFinal: TSpinEdit;
    procedure btnExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgbTipoArquivoClick(Sender: TObject);
    procedure cbxTipoParametroChange(Sender: TObject);
  private
    procedure GerarArquivoMFD;
    procedure GerarEspelhoMFD;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeracaoArquivos: TfrmGeracaoArquivos;

implementation

uses
  uPrincipal, ACBrDevice, DateUtils;

{$R *.dfm}

procedure TfrmGeracaoArquivos.GerarEspelhoMFD;
var
  Inicial: TDateTime;
  TipoPar: Integer;
  NomeArquivo: String;
begin
  TipoPar := cbxTipoParametro.ItemIndex;

  // espelho MFD somente por Data e COO
  if TipoPar = 2 then
    raise Exception.Create('O espelho MFD é emitido somente por Data ou COO!');

  if TipoPar = 0 then
    NomeArquivo := frmPrincipal.GetDirArquivos + 'EspelhoMFD_COO.txt'
  else
    NomeArquivo := frmPrincipal.GetDirArquivos + 'EspelhoMFD_DATA.txt';

  Inicial := Now;
  if TipoPar = 0 then
    frmPrincipal.ACBrECF1.EspelhoMFD_DLL(edtDataInicial.Date, edtDataFinal.Date, NomeArquivo)
  else
    frmPrincipal.ACBrECF1.EspelhoMFD_DLL(edtContInicial.Value, edtContFinal.Value, NomeArquivo);

  ShowMessage(
    'Arquivo gerado com sucesso!' + sLineBreak +
    'Local: ' + NomeArquivo + sLineBreak +
    'Tempo de geração: ' + FormatDateTime('hh:mm:ss', Now - Inicial)
  );
end;

procedure TfrmGeracaoArquivos.GerarArquivoMFD;
var
  Inicial: TDateTime;
  TipoPar: Integer;
  NomeArquivo: String;
  Finalidade: TACBrECFFinalizaArqMFD;
  TipoCont: TACBrECFTipoContador;

  function GetDescrFinalidade(const AFinalidade: TACBrECFFinalizaArqMFD): String;
  begin
    case AFinalidade of
      finMF: Result := 'MF';
      finMFD: Result := 'MFD';
      finTDM: Result := 'TDM';
      finRZ: Result := 'RZ';
      finRFD: Result := 'RFD';
      finNFP: Result := 'NFP';
      finNFPTDM: Result := 'NFPTDM';
      finSintegra: Result := 'SINTEGRA';
      finSPED: Result := 'SPED';
    end;
  end;

  function GetTipoParametro(const ATipo: Integer): String;
  begin
    case ATipo of
      0: Result := 'DATA';
      1: Result := 'COO';
      2: Result := 'CRZ';
    end;
  end;

begin
  TipoPar := cbxTipoParametro.ItemIndex;

  case cbxArqMFDFinalidade.ItemIndex of
    0: Finalidade := finMF;
    1: Finalidade := finMFD;
    2: Finalidade := finTDM;
    3: Finalidade := finNFP;
    4: Finalidade := finNFPTDM;
    5: Finalidade := finSintegra;
    6: Finalidade := finSPED;
  else
    raise Exception.Create('Finalidade não implementada.');
  end;

  case TipoPar of
    0: ; //não fazer nada (por data)
    1: TipoCont := tpcCOO;
    2: TipoCont := tpcCRZ;
  else
    raise Exception.Create('Tipo de contador não implementado.');
  end;

  // para sintegra e sped somente por data
  if (Finalidade in [finSintegra, finSPED]) and (TipoPar > 0) then
    raise Exception.Create('Para as finalidades SINTEGRA e SPED a geração deve ser feita somente por DATA.');

  NomeArquivo := frmPrincipal.GetDirArquivos +
    Format('ArquivoMFD_%s_%s.txt', [GetTipoParametro(TipoPar), GetDescrFinalidade(Finalidade)]);

  Inicial := Now;
  if TipoPar = 0 then
    frmPrincipal.ACBrECF1.ArquivoMFD_DLL(edtDataInicial.Date, edtDataFinal.Date, NomeArquivo, [docTodos], Finalidade)
  else
    frmPrincipal.ACBrECF1.ArquivoMFD_DLL(edtContInicial.Value, edtContFinal.Value, NomeArquivo, [docTodos], Finalidade, TipoCont);

  ShowMessage(
    'Arquivo gerado com sucesso!' + sLineBreak +
    'Local: ' + NomeArquivo + sLineBreak +
    'Tempo de geração: ' + FormatDateTime('hh:mm:ss', Now - Inicial)
  );
end;

procedure TfrmGeracaoArquivos.FormCreate(Sender: TObject);
begin
  inherited;

  rgbTipoArquivo.ItemIndex      := 0;
  cbxArqMFDFinalidade.ItemIndex := 0;
  cbxTipoParametro.ItemIndex    := 0;
  edtContInicial.Value          := 1;
  edtContFinal.Value            := 10;
  edtDataInicial.Date           := IncDay(DATE, -5);
  edtDataFinal.Date             := DATE;

  rgbTipoArquivoClick(rgbTipoArquivo);
  cbxTipoParametroChange(cbxTipoParametro);
end;

procedure TfrmGeracaoArquivos.cbxTipoParametroChange(Sender: TObject);
begin
  edtDataInicial.Visible := cbxTipoParametro.ItemIndex = 0;
  edtDataFinal.Visible   := cbxTipoParametro.ItemIndex = 0;
  edtContInicial.Visible := cbxTipoParametro.ItemIndex > 0;
  edtContFinal.Visible   := cbxTipoParametro.ItemIndex > 0;
end;

procedure TfrmGeracaoArquivos.rgbTipoArquivoClick(Sender: TObject);
begin
  cbxArqMFDFinalidade.Enabled := rgbTipoArquivo.ItemIndex = 1;
end;

procedure TfrmGeracaoArquivos.btnExecutarClick(Sender: TObject);
begin
  inherited;

  if rgbTipoArquivo.ItemIndex = 0 then
    GerarEspelhoMFD
  else
    GerarArquivoMFD;
end;

end.
