inherited frmTesteModoPreVenda: TfrmTesteModoPreVenda
  Caption = 'Comparativo de modo Pr'#233'-venda'
  ClientHeight = 206
  ClientWidth = 294
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 294
    Height = 176
    object Label1: TLabel
      Left = 25
      Top = 24
      Width = 97
      Height = 13
      Caption = 'Quantidade de itens'
    end
    object Label2: TLabel
      Left = 25
      Top = 123
      Width = 244
      Height = 26
      Caption = 
        'Modo pr'#233'-venda funciona somente em impressoras'#13#10'Daruma modelos M' +
        'ACH 1, 2 ou 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object rbtNormal: TRadioButton
      Left = 25
      Top = 75
      Width = 91
      Height = 17
      Caption = 'Modo Normal'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
    end
    object rbtModoPreVenda: TRadioButton
      Left = 147
      Top = 75
      Width = 109
      Height = 17
      Caption = 'Modo Pr'#233'-venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtQuantItens: TEdit
      Left = 25
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '100'
    end
  end
  inherited pnlRodape: TPanel
    Top = 176
    Width = 294
    inherited btnExecutar: TButton
      Left = 93
    end
    inherited btnCancelar: TButton
      Left = 193
    end
  end
end
