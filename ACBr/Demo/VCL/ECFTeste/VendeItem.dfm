object frVendeItem: TfrVendeItem
  Left = 400
  Top = 215
  Width = 383
  Height = 289
  HorzScrollBar.Range = 329
  VertScrollBar.Range = 225
  BorderStyle = bsSingle
  Caption = 'Vende Item'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 184
    Top = 107
    Width = 185
    Height = 108
  end
  object Label1: TLabel
    Left = 30
    Top = 24
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = '&C'#243'digo'
    FocusControl = edCodigo
  end
  object Label2: TLabel
    Left = 17
    Top = 56
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = '&Descri'#231#227'o'
    FocusControl = edDescricao
  end
  object Label3: TLabel
    Left = 43
    Top = 88
    Width = 17
    Height = 13
    Alignment = taRightJustify
    Caption = '&Qtd'
  end
  object Label4: TLabel
    Left = 201
    Top = 88
    Width = 67
    Height = 13
    Alignment = taRightJustify
    Caption = '&Pre'#231'o Unit'#225'rio'
    FocusControl = edPrecoUnita
  end
  object Label5: TLabel
    Left = 191
    Top = 120
    Width = 76
    Height = 13
    Alignment = taRightJustify
    Caption = '&Valor Aliq. ICMS'
    FocusControl = edICMS
  end
  object Label6: TLabel
    Left = 19
    Top = 152
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = '&Desconto'
    FocusControl = edDesconto
  end
  object Label7: TLabel
    Left = 22
    Top = 120
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = '&Unidade'
    FocusControl = edUN
  end
  object Label8: TLabel
    Left = 205
    Top = 151
    Width = 47
    Height = 13
    Caption = 'II = Isento'
  end
  object Label9: TLabel
    Left = 205
    Top = 167
    Width = 100
    Height = 13
    Caption = 'NN = Nao Incidencia'
  end
  object Label10: TLabel
    Left = 205
    Top = 183
    Width = 129
    Height = 13
    Caption = 'FF = Substitui'#231'ao Tribut'#225'ria'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 139
    Width = 169
    Height = 76
  end
  object edCodigo: TEdit
    Left = 72
    Top = 16
    Width = 101
    Height = 21
    Cursor = crIBeam
    TabOrder = 0
    Text = '111222333'
  end
  object edDescricao: TEdit
    Left = 72
    Top = 48
    Width = 289
    Height = 21
    Cursor = crIBeam
    TabOrder = 1
    Text = 'TESTE DE PRODUTO'
  end
  object edPrecoUnita: TEdit
    Left = 272
    Top = 80
    Width = 89
    Height = 21
    Cursor = crIBeam
    TabOrder = 2
    Text = '1'
    OnKeyPress = edQtdKeyPress
  end
  object edICMS: TEdit
    Left = 272
    Top = 112
    Width = 89
    Height = 21
    Cursor = crIBeam
    TabOrder = 3
    Text = 'NN'
    OnKeyPress = edQtdKeyPress
  end
  object edDesconto: TEdit
    Left = 72
    Top = 144
    Width = 81
    Height = 21
    Cursor = crIBeam
    TabOrder = 4
    Text = '0'
    OnKeyPress = edQtdKeyPress
  end
  object edUN: TEdit
    Left = 72
    Top = 112
    Width = 81
    Height = 21
    Cursor = crIBeam
    TabOrder = 5
    Text = 'UN'
  end
  object Button1: TButton
    Left = 79
    Top = 223
    Width = 75
    Height = 25
    Caption = '&Imprimir'
    Default = True
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 218
    Top = 223
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Fechar'
    ModalResult = 2
    TabOrder = 7
    OnClick = Button2Click
  end
  object edQtd: TEdit
    Left = 72
    Top = 80
    Width = 81
    Height = 21
    Cursor = crIBeam
    TabOrder = 8
    Text = '1'
    OnKeyPress = edQtdKeyPress
  end
  object rbPercentagem: TRadioButton
    Left = 48
    Top = 176
    Width = 105
    Height = 17
    Caption = 'Percentagem'
    Checked = True
    TabOrder = 9
    TabStop = True
  end
  object rbValor: TRadioButton
    Left = 48
    Top = 194
    Width = 105
    Height = 17
    Caption = 'Valor'
    TabOrder = 10
  end
end
