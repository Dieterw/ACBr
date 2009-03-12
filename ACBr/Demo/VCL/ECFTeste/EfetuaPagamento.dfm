object frPagamento: TfrPagamento
  Left = 418
  Top = 190
  Width = 352
  Height = 289
  HorzScrollBar.Range = 327
  VertScrollBar.Range = 245
  ActiveControl = edCod
  BorderStyle = bsSingle
  Caption = 'Efetuar Pagamento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 80
    Top = 75
    Width = 23
    Height = 22
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F8F3333333333333000333333333333F888333333333333
      000333333333333F888333333333333000333333333333F88833333333333300
      033333333FFF3F888333333000003B803333333F8883F8883333330EEEEE00B3
      3333338833388883333330EEEEEEE033333338F3333338F333330EEEEEEEEE03
      33333833F333383F33330EFEEEEEEE0333338F33F333338F33330EFEEEEEEE03
      33338F333F33338F33330EEFEEEEEE03333383F333FF338333330EEEFFEEEE03
      333338F3333338F3333330EEEEEEE0333333383FF333F8333333330EEEEE0333
      333333883FF88333333333300000333333333333888333333333}
    NumGlyphs = 2
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 8
    Top = 83
    Width = 22
    Height = 13
    Caption = '&Cod.'
    FocusControl = edCod
  end
  object Label2: TLabel
    Left = 8
    Top = 115
    Width = 24
    Height = 13
    Caption = '&Valor'
    FocusControl = edValor
  end
  object Label3: TLabel
    Left = 160
    Top = 54
    Width = 106
    Height = 13
    Caption = 'Formas de Pagamento'
  end
  object Label4: TLabel
    Left = 136
    Top = 211
    Width = 99
    Height = 13
    Caption = 'TOTAL DO CUPOM:'
  end
  object Label5: TLabel
    Left = 160
    Top = 235
    Width = 68
    Height = 13
    Caption = 'TOTAL PAGO'
  end
  object lTotalAPAGAR: TLabel
    Left = 272
    Top = 211
    Width = 47
    Height = 13
    Alignment = taRightJustify
    Caption = '1000.00'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lTotalPago: TLabel
    Left = 272
    Top = 235
    Width = 47
    Height = 13
    Alignment = taRightJustify
    Caption = '1000.00'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 7
    Width = 314
    Height = 13
    Caption = '- Entre com um ou v'#225'rios pagamentos at'#233' atingir o Total do Cupom'
    WordWrap = True
  end
  object Label7: TLabel
    Left = 8
    Top = 28
    Width = 313
    Height = 26
    AutoSize = False
    Caption = 
      '- Se o valor pago for superior ao Total do Cupom ser'#225' calculado ' +
      'o    TROCO'
    WordWrap = True
  end
  object Label8: TLabel
    Left = 8
    Top = 147
    Width = 22
    Height = 13
    Caption = '&Obs:'
    FocusControl = edObs
  end
  object mFormas: TMemo
    Left = 160
    Top = 69
    Width = 167
    Height = 128
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object edCod: TEdit
    Left = 40
    Top = 75
    Width = 33
    Height = 21
    Cursor = crIBeam
    TabOrder = 0
  end
  object edValor: TEdit
    Left = 40
    Top = 107
    Width = 101
    Height = 21
    Cursor = crIBeam
    TabOrder = 1
    OnKeyPress = edValorKeyPress
  end
  object btImprimir: TButton
    Left = 32
    Top = 219
    Width = 75
    Height = 25
    Caption = '&Imprimir'
    TabOrder = 4
    OnClick = btImprimirClick
  end
  object cbVinc: TCheckBox
    Left = 16
    Top = 163
    Width = 129
    Height = 31
    Caption = 'Cupom &Vinculado'
    TabOrder = 3
  end
  object edObs: TEdit
    Left = 40
    Top = 139
    Width = 101
    Height = 21
    Cursor = crIBeam
    TabOrder = 2
  end
end
