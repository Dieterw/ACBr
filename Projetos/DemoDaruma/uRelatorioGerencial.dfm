inherited frmRelatorioGerencial: TfrmRelatorioGerencial
  Left = 313
  Top = 231
  Caption = 'Relat'#243'rio Gerencial'
  ClientHeight = 249
  ClientWidth = 419
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 419
    Height = 219
    object Label1: TLabel
      Left = 10
      Top = 9
      Width = 43
      Height = 13
      Caption = 'Relat'#243'rio'
    end
    object Label3: TLabel
      Left = 10
      Top = 52
      Width = 20
      Height = 13
      Caption = 'BMP'
    end
    object Label4: TLabel
      Left = 59
      Top = 52
      Width = 68
      Height = 13
      Caption = 'Texto da linha'
    end
    object cbxIdxRelatorio: TComboBox
      Left = 10
      Top = 25
      Width = 396
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object edtTexto1: TEdit
      Left = 59
      Top = 68
      Width = 347
      Height = 21
      TabOrder = 2
      Text = 'Linha do relat'#243'rio'
    end
    object cbxIdxBMP1: TComboBox
      Left = 10
      Top = 68
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object cbxIdxBMP2: TComboBox
      Left = 10
      Top = 95
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object edtTexto2: TEdit
      Left = 59
      Top = 95
      Width = 347
      Height = 21
      TabOrder = 4
      Text = 'Linha do relat'#243'rio'
    end
    object cbxIdxBMP3: TComboBox
      Left = 10
      Top = 122
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 5
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object edtTexto3: TEdit
      Left = 59
      Top = 122
      Width = 347
      Height = 21
      TabOrder = 6
      Text = 'Linha do relat'#243'rio'
    end
    object cbxIdxBMP4: TComboBox
      Left = 10
      Top = 149
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object edtTexto4: TEdit
      Left = 59
      Top = 149
      Width = 347
      Height = 21
      TabOrder = 8
      Text = 'Linha do relat'#243'rio'
    end
    object cbxIdxBMP5: TComboBox
      Left = 10
      Top = 176
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 9
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object edtTexto5: TEdit
      Left = 59
      Top = 176
      Width = 347
      Height = 21
      TabOrder = 10
      Text = 'Linha do relat'#243'rio'
    end
  end
  inherited pnlRodape: TPanel
    Top = 219
    Width = 419
    inherited btnExecutar: TButton
      Left = 209
    end
    inherited btnCancelar: TButton
      Left = 315
    end
  end
end
