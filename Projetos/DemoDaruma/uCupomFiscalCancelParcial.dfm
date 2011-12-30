inherited frmCupomFiscalCancelParcial: TfrmCupomFiscalCancelParcial
  Left = 348
  Top = 220
  Caption = 'Cancelamento parcial'
  ClientHeight = 116
  ClientWidth = 217
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 217
    Height = 86
    object Label27: TLabel
      Left = 29
      Top = 20
      Width = 22
      Height = 13
      Caption = 'Item'
    end
    object Label1: TLabel
      Left = 102
      Top = 20
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object edtItemNumero: TEdit
      Left = 29
      Top = 36
      Width = 67
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      Text = '1'
    end
    object edtItemQuantidade: TEdit
      Left = 102
      Top = 36
      Width = 94
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Text = '1'
    end
  end
  inherited pnlRodape: TPanel
    Top = 86
    Width = 217
    inherited btnExecutar: TButton
      Left = 7
    end
    inherited btnCancelar: TButton
      Left = 113
    end
  end
end
