inherited frmGeracaoArquivos: TfrmGeracaoArquivos
  Left = 329
  Top = 207
  Caption = 'Gera'#231#227'o de arquivos com DLL'
  ClientHeight = 316
  ClientWidth = 282
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 282
    Height = 286
    object Label4: TLabel
      Left = 53
      Top = 122
      Width = 48
      Height = 13
      Caption = 'Finalidade'
    end
    object Label5: TLabel
      Left = 53
      Top = 165
      Width = 74
      Height = 13
      Caption = 'Tipo de sele'#231#227'o'
    end
    object Label6: TLabel
      Left = 68
      Top = 208
      Width = 27
      Height = 13
      Caption = 'Inicial'
    end
    object Label7: TLabel
      Left = 145
      Top = 208
      Width = 22
      Height = 13
      Caption = 'Final'
    end
    object cbxArqMFDFinalidade: TComboBox
      Left = 53
      Top = 138
      Width = 178
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'MF'
        'MFD'
        'TDM'
        'NFP'
        'NFP TDM'
        'SINTEGRA'
        'SPED')
    end
    object cbxTipoParametro: TComboBox
      Left = 53
      Top = 181
      Width = 178
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cbxTipoParametroChange
      Items.Strings = (
        'DATA'
        'COO'
        'CRZ')
    end
    object rgbTipoArquivo: TRadioGroup
      Left = 53
      Top = 28
      Width = 178
      Height = 73
      Caption = 'Tipo de arquivo gerado'
      Items.Strings = (
        'Espelho MFD'
        'Arquivo MFD')
      TabOrder = 0
      OnClick = rgbTipoArquivoClick
    end
    object edtDataInicial: TDateTimePicker
      Left = 53
      Top = 225
      Width = 86
      Height = 21
      Date = 40722.593622337960000000
      Time = 40722.593622337960000000
      TabOrder = 4
    end
    object edtDataFinal: TDateTimePicker
      Left = 145
      Top = 224
      Width = 86
      Height = 21
      Date = 40722.593622337960000000
      Time = 40722.593622337960000000
      TabOrder = 5
    end
    object edtContInicial: TSpinEdit
      Left = 53
      Top = 224
      Width = 86
      Height = 22
      MaxLength = 6
      MaxValue = 999999
      MinValue = 1
      TabOrder = 3
      Value = 1
    end
    object edtContFinal: TSpinEdit
      Left = 145
      Top = 224
      Width = 86
      Height = 22
      MaxLength = 6
      MaxValue = 999999
      MinValue = 1
      TabOrder = 6
      Value = 1
    end
  end
  inherited pnlRodape: TPanel
    Top = 286
    Width = 282
    inherited btnExecutar: TButton
      Left = 72
    end
    inherited btnCancelar: TButton
      Left = 178
    end
  end
end
