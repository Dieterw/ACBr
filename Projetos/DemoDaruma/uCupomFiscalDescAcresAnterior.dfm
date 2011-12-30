inherited frmCupomFiscalDescAcresAnterior: TfrmCupomFiscalDescAcresAnterior
  Left = 329
  Top = 229
  Caption = 'Desconto/Acr'#233'scimo item anterior'
  ClientHeight = 159
  ClientWidth = 349
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 349
    Height = 129
    object Label25: TLabel
      Left = 112
      Top = 60
      Width = 20
      Height = 13
      Caption = 'Tipo'
    end
    object Label26: TLabel
      Left = 18
      Top = 60
      Width = 32
      Height = 13
      Caption = 'Aplicar'
    end
    object Label27: TLabel
      Left = 209
      Top = 60
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label1: TLabel
      Left = 18
      Top = 17
      Width = 22
      Height = 13
      Caption = 'Item'
    end
    object edtItemDescAcresTipo: TComboBox
      Left = 112
      Top = 76
      Width = 91
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'Percentual'
      Items.Strings = (
        'Percentual'
        'Valor')
    end
    object edtItemDescAcreModo: TComboBox
      Left = 18
      Top = 76
      Width = 88
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Desconto'
      Items.Strings = (
        'Desconto'
        'Acr'#233'scimo')
    end
    object edtItemDescAcreValor: TEdit
      Left = 209
      Top = 76
      Width = 114
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
      Text = '0,00'
    end
    object edtItemNumero: TEdit
      Left = 18
      Top = 33
      Width = 88
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 0
      Text = '1'
    end
  end
  inherited pnlRodape: TPanel
    Top = 129
    Width = 349
    inherited btnExecutar: TButton
      Left = 139
    end
    inherited btnCancelar: TButton
      Left = 245
    end
  end
end
