object frmBasicoModal: TfrmBasicoModal
  Left = 0
  Top = 0
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
    Height = 265
    Align = alClient
    TabOrder = 0
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 265
    Width = 564
    Height = 35
    Align = alBottom
    TabOrder = 1
    object btnExecutar: TButton
      Left = 354
      Top = 4
      Width = 100
      Height = 27
      Align = alRight
      Caption = 'Executar'
      TabOrder = 0
      OnClick = btnExecutarClick
    end
    object btnCancelar: TButton
      Left = 460
      Top = 4
      Width = 100
      Height = 27
      Align = alRight
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end
