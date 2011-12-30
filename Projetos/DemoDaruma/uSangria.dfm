inherited frmSangria: TfrmSangria
  Left = 377
  Top = 253
  Caption = 'Sangria'
  ClientHeight = 200
  ClientWidth = 410
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 410
    Height = 170
    object Label1: TLabel
      Left = 20
      Top = 19
      Width = 40
      Height = 13
      Caption = 'Valor R$'
    end
    object Label2: TLabel
      Left = 20
      Top = 62
      Width = 58
      Height = 13
      Caption = 'Observa'#231#227'o'
    end
    object Label3: TLabel
      Left = 20
      Top = 105
      Width = 52
      Height = 13
      Caption = 'Indice BMP'
    end
    object Label4: TLabel
      Left = 98
      Top = 115
      Width = 293
      Height = 27
      AutoSize = False
      Caption = 
        'Indice do Bitmap promocional cadastrado na impressora fiscal, ut' +
        'ilize o valor 0 para que n'#227'o seja impresso o Bitmap'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object edtValor: TEdit
      Left = 20
      Top = 35
      Width = 116
      Height = 21
      TabOrder = 0
      Text = '2,13'
    end
    object edtObservacao: TEdit
      Left = 20
      Top = 78
      Width = 371
      Height = 21
      TabOrder = 1
      Text = 'Sangria teste'
    end
    object cbxIndiceBMP: TComboBox
      Left = 20
      Top = 121
      Width = 52
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
  end
  inherited pnlRodape: TPanel
    Top = 170
    Width = 410
    inherited btnExecutar: TButton
      Left = 200
    end
    inherited btnCancelar: TButton
      Left = 306
    end
  end
end
