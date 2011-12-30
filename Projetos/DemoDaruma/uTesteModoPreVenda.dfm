inherited frmTesteModoPreVenda: TfrmTesteModoPreVenda
  Left = 534
  Top = 246
  Caption = 'Comparativo de modo Pr'#233'-venda'
  ClientHeight = 414
  ClientWidth = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 370
    Height = 384
    object Label1: TLabel
      Left = 25
      Top = 19
      Width = 97
      Height = 13
      Caption = 'Quantidade de itens'
    end
    object Label2: TLabel
      Left = 25
      Top = 333
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
    object Label3: TLabel
      Left = 25
      Top = 111
      Width = 38
      Height = 13
      Caption = 'Status :'
    end
    object rbtNormal: TRadioButton
      Left = 25
      Top = 62
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
      Left = 122
      Top = 62
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
      Top = 35
      Width = 97
      Height = 21
      TabOrder = 0
      Text = '50'
    end
    object memResposta: TMemo
      Left = 25
      Top = 127
      Width = 321
      Height = 200
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
  end
  inherited pnlRodape: TPanel
    Top = 384
    Width = 370
    inherited btnExecutar: TButton
      Left = 169
      Default = True
    end
    inherited btnCancelar: TButton
      Left = 269
    end
  end
end
