inherited frmComprNaoFiscalCompleto: TfrmComprNaoFiscalCompleto
  Left = 341
  Top = 208
  Caption = 'Comprovante N'#227'o Fiscal Completo'
  ClientHeight = 370
  ClientWidth = 387
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 387
    Height = 340
    object Label1: TLabel
      Left = 15
      Top = 15
      Width = 53
      Height = 13
      Caption = 'Totalizador'
    end
    object Label2: TLabel
      Left = 15
      Top = 58
      Width = 79
      Height = 13
      Caption = 'Meio pagamento'
    end
    object Label3: TLabel
      Left = 166
      Top = 58
      Width = 40
      Height = 13
      Caption = 'Valor R$'
    end
    object Label4: TLabel
      Left = 15
      Top = 187
      Width = 58
      Height = 13
      Caption = 'Observa'#231#227'o'
    end
    object Label5: TLabel
      Left = 15
      Top = 284
      Width = 52
      Height = 13
      Caption = 'Indice BMP'
    end
    object Label6: TLabel
      Left = 77
      Top = 294
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
    object cbxTotalizador: TComboBox
      Left = 15
      Top = 31
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object cbxMeioPagto: TComboBox
      Left = 15
      Top = 74
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object edtValor: TEdit
      Left = 166
      Top = 74
      Width = 90
      Height = 21
      TabOrder = 2
      Text = '1,00'
    end
    object cbxIndiceBMP: TComboBox
      Left = 15
      Top = 300
      Width = 52
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 8
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object edtFechamentoObs3: TEdit
      Left = 15
      Top = 257
      Width = 355
      Height = 21
      TabOrder = 7
      Text = '<ean13>123456789012</ean13>'
    end
    object edtFechamentoObs2: TEdit
      Left = 15
      Top = 230
      Width = 355
      Height = 21
      TabOrder = 6
      Text = '<n>Demonstra'#231#227'o ACBr com Daruma</n>'
    end
    object edtFechamentoObs1: TEdit
      Left = 15
      Top = 203
      Width = 355
      Height = 21
      TabOrder = 5
      Text = '<e>ACBrECF</e>'
    end
    object ckbImprimirExemploCCD: TCheckBox
      Left = 15
      Top = 101
      Width = 146
      Height = 17
      Caption = 'Imprimir exemplo de CCD'
      TabOrder = 3
      OnClick = ckbImprimirExemploCCDClick
    end
    object ckbImprimirSegViaCCD: TCheckBox
      Left = 30
      Top = 124
      Width = 166
      Height = 17
      Caption = 'Imprimir Segunda via do CCD'
      TabOrder = 4
    end
    object ckbReimprimirCCD: TCheckBox
      Left = 30
      Top = 147
      Width = 196
      Height = 17
      Caption = 'Enviar comando de reimpress'#227'o do CCD'
      TabOrder = 9
    end
  end
  inherited pnlRodape: TPanel
    Top = 340
    Width = 387
    inherited btnExecutar: TButton
      Left = 177
    end
    inherited btnCancelar: TButton
      Left = 283
    end
  end
end
