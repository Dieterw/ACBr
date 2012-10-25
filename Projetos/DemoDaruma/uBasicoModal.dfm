object frmBasicoModal: TfrmBasicoModal
  Left = 353
  Top = 206
  BorderStyle = bsDialog
  Caption = 'Demo ACBrDaruma'
  ClientHeight = 300
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCliente: TPanel
    Left = 0
    Top = 0
    Width = 564
    Height = 270
    Align = alClient
    TabOrder = 0
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 270
    Width = 564
    Height = 30
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      564
      30)
    object btnExecutar: TButton
      Left = 363
      Top = 1
      Width = 100
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Executar'
      TabOrder = 0
      OnClick = btnExecutarClick
    end
    object btnCancelar: TButton
      Left = 463
      Top = 1
      Width = 100
      Height = 28
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end
