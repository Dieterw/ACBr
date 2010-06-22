object ACBRBoletoFCFortesFr: TACBRBoletoFCFortesFr
  Left = 77
  Top = 19
  Width = 970
  Height = 780
  VertScrollBar.Position = 538
  Caption = 'ACBRBoletoFCFortesFr'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LayoutBoleto: TRLReport
    Left = 24
    Top = 8
    Width = 794
    Height = 1123
    Margins.LeftMargin = 3.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    Margins.BottomMargin = 5.000000000000000000
    ParentFont = True
    PreviewOptions.ShowModal = True
    ShowProgress = False
    BeforePrint = LayoutBoletoBeforePrint
    OnDataCount = LayoutBoletoDataCount
    OnDataRecord = LayoutBoletoDataRecord
    object RLBand1: TRLBand
      Left = 11
      Top = 19
      Width = 764
      Height = 408
      BeforePrint = RLBand1BeforePrint
      object RLDraw29: TRLDraw
        Left = 0
        Top = 388
        Width = 756
        Height = 16
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object RLDraw39: TRLDraw
        Left = 2
        Top = 323
        Width = 754
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw38: TRLDraw
        Left = 2
        Top = 260
        Width = 754
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw37: TRLDraw
        Left = 571
        Top = 228
        Width = 185
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw34: TRLDraw
        Left = 571
        Top = 196
        Width = 185
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw28: TRLDraw
        Left = 562
        Top = 43
        Width = 17
        Height = 226
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw27: TRLDraw
        Left = 312
        Top = 108
        Width = 17
        Height = 33
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw26: TRLDraw
        Left = 179
        Top = 140
        Width = 17
        Height = 33
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw25: TRLDraw
        Left = 387
        Top = 108
        Width = 17
        Height = 65
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw24: TRLDraw
        Left = 241
        Top = 108
        Width = 17
        Height = 65
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw21: TRLDraw
        Left = 117
        Top = 108
        Width = 17
        Height = 65
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw23: TRLDraw
        Left = -2
        Top = 164
        Width = 759
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw22: TRLDraw
        Left = -2
        Top = 132
        Width = 757
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw20: TRLDraw
        Left = -3
        Top = 69
        Width = 757
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw19: TRLDraw
        Left = -5
        Top = 101
        Width = 757
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw18: TRLDraw
        Left = 0
        Top = 36
        Width = 756
        Height = 16
        DrawKind = dkLine
      end
      object RLDraw17: TRLDraw
        Left = 278
        Top = 3
        Width = 17
        Height = 41
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw16: TRLDraw
        Left = 173
        Top = 3
        Width = 17
        Height = 41
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object imgBanco2: TRLImage
        Left = 0
        Top = -1
        Width = 179
        Height = 42
      end
      object txtNumeroBanco2: TRLLabel
        Left = 184
        Top = 12
        Width = 102
        Height = 27
        Alignment = taCenter
        AutoSize = False
        Caption = '000-0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel67: TRLLabel
        Left = 289
        Top = 21
        Width = 465
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Recibo do Sacado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel68: TRLLabel
        Left = 0
        Top = 45
        Width = 70
        Height = 10
        Caption = 'Local de Pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblLocalPagto: TRLLabel
        Left = 0
        Top = 57
        Width = 529
        Height = 17
        AutoSize = False
        Caption = 'Local de Pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel69: TRLLabel
        Left = 0
        Top = 78
        Width = 30
        Height = 10
        Caption = 'Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNomeCedente2: TRLLabel
        Left = 0
        Top = 91
        Width = 529
        Height = 17
        AutoSize = False
        Caption = 'Nome do Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel70: TRLLabel
        Left = 0
        Top = 110
        Width = 68
        Height = 10
        Caption = 'Data do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataDocumento2: TRLLabel
        Left = 0
        Top = 122
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Data do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel71: TRLLabel
        Left = 127
        Top = 110
        Width = 79
        Height = 10
        Caption = 'N'#250'mero do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNumeroDocumento2: TRLLabel
        Left = 127
        Top = 122
        Width = 122
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'N'#250'mero do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel72: TRLLabel
        Left = 252
        Top = 110
        Width = 47
        Height = 10
        Caption = 'Esp'#233'cie Doc.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEspecieDoc2: TRLLabel
        Left = 252
        Top = 122
        Width = 68
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'Esp'#233'cie Doc.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel73: TRLLabel
        Left = 322
        Top = 110
        Width = 23
        Height = 10
        Caption = 'Aceite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtAceite2: TRLLabel
        Left = 322
        Top = 122
        Width = 66
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Aceite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel74: TRLLabel
        Left = 399
        Top = 110
        Width = 82
        Height = 10
        Caption = 'Data do Processamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataProcessamento2: TRLLabel
        Left = 399
        Top = 122
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Data do Processamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtUsoBanco2: TRLLabel
        Left = 0
        Top = 154
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Uso do Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RLLabel75: TRLLabel
        Left = 0
        Top = 142
        Width = 49
        Height = 10
        Caption = 'Uso do Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCarteira2: TRLLabel
        Left = 127
        Top = 154
        Width = 58
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Carteira'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel76: TRLLabel
        Left = 127
        Top = 142
        Width = 30
        Height = 10
        Caption = 'Carteira'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel77: TRLLabel
        Left = 190
        Top = 142
        Width = 29
        Height = 10
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEspecie2: TRLLabel
        Left = 190
        Top = 154
        Width = 58
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel78: TRLLabel
        Left = 252
        Top = 142
        Width = 40
        Height = 10
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtQuantidade2: TRLLabel
        Left = 252
        Top = 154
        Width = 140
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel79: TRLLabel
        Left = 399
        Top = 142
        Width = 20
        Height = 10
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorMoeda2: TRLLabel
        Left = 399
        Top = 154
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel80: TRLLabel
        Left = 0
        Top = 173
        Width = 325
        Height = 10
        Caption = 
          'Instru'#231#245'es (Todas as informa'#231#245'es deste bloqueto s'#227'o de exclusiva' +
          ' responsabilidade do cedente.)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtInstrucoes2: TRLMemo
        Left = 4
        Top = 184
        Width = 529
        Height = 83
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Linha 1'
          'Linha 2'
          'Linha 3'
          'Linha 4'
          'Linha 5'
          'Linha 6')
        ParentFont = False
      end
      object RLLabel81: TRLLabel
        Left = 574
        Top = 45
        Width = 41
        Height = 10
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataVencimento2: TRLLabel
        Left = 574
        Top = 57
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel82: TRLLabel
        Left = 574
        Top = 78
        Width = 91
        Height = 10
        Caption = 'Ag'#234'ncia / C'#243'digo Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCodigoCedente2: TRLLabel
        Left = 573
        Top = 91
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Ag'#234'ncia / C'#243'digo Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel83: TRLLabel
        Left = 574
        Top = 110
        Width = 53
        Height = 10
        Caption = 'Nosso N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNossoNumero2: TRLLabel
        Left = 574
        Top = 122
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Nosso N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel84: TRLLabel
        Left = 574
        Top = 142
        Width = 87
        Height = 10
        Caption = '( = ) Valor do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorDocumento2: TRLLabel
        Left = 574
        Top = 154
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel85: TRLLabel
        Left = 574
        Top = 174
        Width = 92
        Height = 10
        Caption = '( - ) Desconto / Abatimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDesconto2: TRLLabel
        Left = 574
        Top = 186
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel86: TRLLabel
        Left = 574
        Top = 206
        Width = 62
        Height = 10
        Caption = '( + ) Mora / Multa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtMoraMulta2: TRLLabel
        Left = 574
        Top = 218
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel87: TRLLabel
        Left = 574
        Top = 238
        Width = 68
        Height = 10
        Caption = '( = ) Valor Cobrado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorCobrado2: TRLLabel
        Left = 574
        Top = 250
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel88: TRLLabel
        Left = 4
        Top = 270
        Width = 43
        Height = 14
        Caption = 'Sacado:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNomeSacado2: TRLLabel
        Left = 53
        Top = 269
        Width = 512
        Height = 14
        AutoSize = False
        Caption = 'Nome do Sacado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEnderecoSacado2: TRLLabel
        Left = 53
        Top = 285
        Width = 512
        Height = 14
        AutoSize = False
        Caption = 'Rua / Numero / Complemento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCidadeSacado2: TRLLabel
        Left = 53
        Top = 301
        Width = 512
        Height = 14
        AutoSize = False
        Caption = 'Cep / Bairro / Cidade / Estado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel89: TRLLabel
        Left = 574
        Top = 270
        Width = 45
        Height = 10
        Caption = 'CPF / CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCpfCnpjSacado2: TRLLabel
        Left = 574
        Top = 281
        Width = 181
        Height = 16
        AutoSize = False
        Caption = 'CPF / CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel90: TRLLabel
        Left = 574
        Top = 299
        Width = 57
        Height = 10
        Caption = 'C'#243'digo de Baixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCodigoBaixa2: TRLLabel
        Left = 574
        Top = 313
        Width = 181
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLMemo2: TRLMemo
        Left = 2
        Top = 334
        Width = 321
        Height = 39
        Alignment = taJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          
            'Recebimento atrav'#233's do cheque n'#250'mero                         do ' +
            'banco'
          'Esta quita'#231#227'o s'#243' ter'#225' validade ap'#243's o pagamento do cheque pelo'
          'banco sacado.')
        ParentFont = False
      end
      object RLLabel91: TRLLabel
        Left = 499
        Top = 334
        Width = 80
        Height = 10
        Caption = 'Autentica'#231#227'o Mec'#226'nica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel93: TRLLabel
        Left = 392
        Top = 153
        Width = 5
        Height = 10
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel98: TRLLabel
        Left = 0
        Top = 388
        Width = 26
        Height = 14
        Caption = '"'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel102: TRLLabel
        Left = 4
        Top = 316
        Width = 89
        Height = 14
        Caption = 'Sacador/Avalista:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtSacadorAvalista2: TRLLabel
        Left = 105
        Top = 316
        Width = 460
        Height = 14
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtReferencia2: TRLLabel
        Left = 638
        Top = 297
        Width = 181
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
    end
    object RLBand2: TRLBand
      Left = 11
      Top = 427
      Width = 764
      Height = 419
      BeforePrint = RLBand2BeforePrint
      object RLDraw50: TRLDraw
        Left = -2
        Top = 337
        Width = 754
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw49: TRLDraw
        Left = 6
        Top = 274
        Width = 754
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw48: TRLDraw
        Left = 540
        Top = 242
        Width = 220
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw47: TRLDraw
        Left = 540
        Top = 210
        Width = 220
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw46: TRLDraw
        Left = 1
        Top = 178
        Width = 759
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw45: TRLDraw
        Left = 183
        Top = 154
        Width = 17
        Height = 33
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw44: TRLDraw
        Left = 3
        Top = 146
        Width = 757
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw43: TRLDraw
        Left = 391
        Top = 122
        Width = 17
        Height = 65
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw42: TRLDraw
        Left = 316
        Top = 121
        Width = 17
        Height = 35
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw41: TRLDraw
        Left = 245
        Top = 122
        Width = 17
        Height = 65
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw40: TRLDraw
        Left = 121
        Top = 122
        Width = 17
        Height = 65
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw36: TRLDraw
        Left = 3
        Top = 114
        Width = 757
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw35: TRLDraw
        Left = 4
        Top = 50
        Width = 756
        Height = 16
        DrawKind = dkLine
      end
      object RLDraw33: TRLDraw
        Left = 3
        Top = 82
        Width = 757
        Height = 17
        DrawKind = dkLine
      end
      object imgBanco3: TRLImage
        Left = 4
        Top = 15
        Width = 179
        Height = 42
      end
      object RLDraw81: TRLDraw
        Left = 177
        Top = 17
        Width = 17
        Height = 41
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object txtLinhaDigitavel: TRLLabel
        Left = 294
        Top = 35
        Width = 466
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = '00000.0000 00000.000000 00000.000000 0 00000000000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw82: TRLDraw
        Left = 282
        Top = 17
        Width = 17
        Height = 41
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object txtNumeroBanco3: TRLLabel
        Left = 188
        Top = 26
        Width = 102
        Height = 27
        Alignment = taCenter
        AutoSize = False
        Caption = '000-0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel145: TRLLabel
        Left = 4
        Top = 59
        Width = 70
        Height = 10
        Caption = 'Local de Pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtLocalPagamento3: TRLLabel
        Left = 4
        Top = 72
        Width = 529
        Height = 17
        AutoSize = False
        Caption = 'Local de Pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataVencimento3: TRLLabel
        Left = 552
        Top = 72
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel146: TRLLabel
        Left = 552
        Top = 59
        Width = 41
        Height = 10
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw83: TRLDraw
        Left = 530
        Top = 57
        Width = 17
        Height = 226
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLLabel147: TRLLabel
        Left = 4
        Top = 92
        Width = 30
        Height = 10
        Caption = 'Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNomeCedente3: TRLLabel
        Left = 4
        Top = 105
        Width = 529
        Height = 16
        AutoSize = False
        Caption = 'Nome do Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel148: TRLLabel
        Left = 552
        Top = 92
        Width = 91
        Height = 10
        Caption = 'Ag'#234'ncia / C'#243'digo Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCodigoCedente3: TRLLabel
        Left = 552
        Top = 105
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Ag'#234'ncia / C'#243'digo Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel149: TRLLabel
        Left = 4
        Top = 124
        Width = 68
        Height = 10
        Caption = 'Data do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataDocumento3: TRLLabel
        Left = 4
        Top = 137
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Data do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel150: TRLLabel
        Left = 131
        Top = 124
        Width = 79
        Height = 10
        Caption = 'N'#250'mero do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNumeroDocumento3: TRLLabel
        Left = 131
        Top = 137
        Width = 122
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'N'#250'mero do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel151: TRLLabel
        Left = 256
        Top = 124
        Width = 47
        Height = 10
        Caption = 'Esp'#233'cie Doc.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEspecieDoc3: TRLLabel
        Left = 256
        Top = 137
        Width = 68
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'Esp'#233'cie Doc.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel152: TRLLabel
        Left = 326
        Top = 124
        Width = 23
        Height = 10
        Caption = 'Aceite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtAceite3: TRLLabel
        Left = 326
        Top = 137
        Width = 66
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Aceite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel153: TRLLabel
        Left = 403
        Top = 124
        Width = 82
        Height = 10
        Caption = 'Data do Processamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataProcessamento3: TRLLabel
        Left = 403
        Top = 137
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Data do Processamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel154: TRLLabel
        Left = 552
        Top = 124
        Width = 53
        Height = 10
        Caption = 'Nosso N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNossoNumero3: TRLLabel
        Left = 552
        Top = 137
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Nosso N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel155: TRLLabel
        Left = 4
        Top = 156
        Width = 49
        Height = 10
        Caption = 'Uso do Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtUsoBanco3: TRLLabel
        Left = 4
        Top = 169
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Uso do Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RLLabel156: TRLLabel
        Left = 131
        Top = 156
        Width = 30
        Height = 10
        Caption = 'Carteira'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCarteira3: TRLLabel
        Left = 131
        Top = 169
        Width = 58
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Carteira'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel157: TRLLabel
        Left = 194
        Top = 156
        Width = 29
        Height = 10
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEspecie3: TRLLabel
        Left = 194
        Top = 169
        Width = 58
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel158: TRLLabel
        Left = 256
        Top = 156
        Width = 40
        Height = 10
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtQuantidade3: TRLLabel
        Left = 256
        Top = 169
        Width = 140
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel159: TRLLabel
        Left = 403
        Top = 156
        Width = 20
        Height = 10
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorMoeda3: TRLLabel
        Left = 403
        Top = 169
        Width = 124
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel160: TRLLabel
        Left = 552
        Top = 156
        Width = 87
        Height = 10
        Caption = '( = ) Valor do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorDocumento3: TRLLabel
        Left = 552
        Top = 169
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel161: TRLLabel
        Left = 4
        Top = 187
        Width = 325
        Height = 10
        Caption = 
          'Instru'#231#245'es (Todas as informa'#231#245'es deste bloqueto s'#227'o de exclusiva' +
          ' responsabilidade do cedente.)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtInstrucoes3: TRLMemo
        Left = 5
        Top = 201
        Width = 529
        Height = 82
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Linha 1'
          'Linha 2'
          'Linha 3'
          'Linha 4'
          'Linha 5'
          'Linha 6')
        ParentFont = False
      end
      object RLLabel162: TRLLabel
        Left = 552
        Top = 188
        Width = 92
        Height = 10
        Caption = '( - ) Desconto / Abatimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDesconto3: TRLLabel
        Left = 552
        Top = 200
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel163: TRLLabel
        Left = 552
        Top = 220
        Width = 62
        Height = 10
        Caption = '( + ) Mora / Multa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtMoraMulta3: TRLLabel
        Left = 552
        Top = 232
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel164: TRLLabel
        Left = 552
        Top = 252
        Width = 68
        Height = 10
        Caption = '( = ) Valor Cobrado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorCobrado3: TRLLabel
        Left = 552
        Top = 264
        Width = 172
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel165: TRLLabel
        Left = 4
        Top = 284
        Width = 43
        Height = 14
        Caption = 'Sacado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNomeSacado3: TRLLabel
        Left = 53
        Top = 284
        Width = 488
        Height = 14
        AutoSize = False
        Caption = 'Nome do Sacado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel166: TRLLabel
        Left = 551
        Top = 284
        Width = 45
        Height = 10
        Caption = 'CPF / CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCpfCnpjSacado3: TRLLabel
        Left = 550
        Top = 295
        Width = 204
        Height = 16
        AutoSize = False
        Caption = 'CPF / CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEnderecoSacado3: TRLLabel
        Left = 53
        Top = 300
        Width = 488
        Height = 14
        AutoSize = False
        Caption = 'Rua / Numero / Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel167: TRLLabel
        Left = 551
        Top = 315
        Width = 57
        Height = 10
        Caption = 'C'#243'digo de Baixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCidadeSacado3: TRLLabel
        Left = 53
        Top = 316
        Width = 488
        Height = 14
        AutoSize = False
        Caption = 'Cep / Bairro / Cidade / Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCodigoBaixa3: TRLLabel
        Left = 550
        Top = 327
        Width = 204
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel168: TRLLabel
        Left = 503
        Top = 349
        Width = 166
        Height = 10
        Caption = 'Autentica'#231#227'o Mec'#226'nica - Ficha de Compensa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel170: TRLLabel
        Left = 396
        Top = 167
        Width = 5
        Height = 10
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel175: TRLLabel
        Left = 4
        Top = 330
        Width = 89
        Height = 14
        Caption = 'Sacador/Avalista:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtSacadorAvalista3: TRLLabel
        Left = 105
        Top = 330
        Width = 436
        Height = 14
        AutoSize = False
        Caption = 'Sacador/Avalista'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtReferencia3: TRLLabel
        Left = 615
        Top = 311
        Width = 204
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object imgCodigoBarra: TRLBarcode
        Left = 4
        Top = 350
        Width = 465
        Height = 66
        AutoSize = False
        Caption = '23790-3571000000100120'
        CheckSumMethod = cmNone
        InvalidCode = icDrawAnyway
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
        Ratio = 3.000000000000000000
      end
    end
    object txtSwHouse: TRLAngleLabel
      Left = 3
      Top = 653
      Width = 12
      Height = 53
      Alignment = taCenter
      Angle = 90.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpFixed
      Font.Style = []
      Layout = tlCenter
      ParentFont = False
    end
  end
  object BoletoCarne: TRLReport
    Left = 136
    Top = 240
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Margins.LeftMargin = 8.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    Margins.BottomMargin = 5.000000000000000000
    PreviewOptions.ShowModal = True
    BeforePrint = BoletoCarneBeforePrint
    OnDataCount = BoletoCarneDataCount
    OnDataRecord = BoletoCarneDataRecord
    object RLBand3: TRLBand
      Left = 30
      Top = 19
      Width = 745
      Height = 360
      BeforePrint = RLBand3BeforePrint
      object RLDraw30: TRLDraw
        Left = 150
        Top = 274
        Width = 599
        Height = 17
        DrawKind = dkLine
      end
      object RLDraw31: TRLDraw
        Left = 2
        Top = 228
        Width = 754
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw32: TRLDraw
        Left = 567
        Top = 199
        Width = 220
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw51: TRLDraw
        Left = 567
        Top = 172
        Width = 220
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw52: TRLDraw
        Left = -3
        Top = 145
        Width = 759
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw53: TRLDraw
        Left = 296
        Top = 120
        Width = 1
        Height = 26
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw54: TRLDraw
        Left = -1
        Top = 120
        Width = 757
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw55: TRLDraw
        Left = 476
        Top = 94
        Width = 1
        Height = 52
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw56: TRLDraw
        Left = 415
        Top = 94
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw57: TRLDraw
        Left = 344
        Top = 94
        Width = 1
        Height = 52
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw58: TRLDraw
        Left = 245
        Top = 94
        Width = 1
        Height = 52
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw59: TRLDraw
        Left = -1
        Top = 94
        Width = 757
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw60: TRLDraw
        Left = 0
        Top = 34
        Width = 756
        Height = 16
        DrawKind = dkLine
      end
      object RLDraw61: TRLDraw
        Left = -1
        Top = 70
        Width = 757
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw62: TRLDraw
        Left = 0
        Top = 349
        Width = 756
        Height = 16
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object imgBancoCarne: TRLImage
        Left = 152
        Top = 0
        Width = 101
        Height = 41
        Center = True
        Scaled = True
      end
      object RLDraw63: TRLDraw
        Left = 253
        Top = 1
        Width = 1
        Height = 41
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLDraw64: TRLDraw
        Left = 325
        Top = 1
        Width = 1
        Height = 41
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLLabel1: TRLLabel
        Left = 154
        Top = 43
        Width = 70
        Height = 10
        Caption = 'Local de Pagamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel94: TRLLabel
        Left = 572
        Top = 43
        Width = 41
        Height = 10
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw65: TRLDraw
        Left = 567
        Top = 41
        Width = 1
        Height = 188
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLLabel95: TRLLabel
        Left = 154
        Top = 71
        Width = 30
        Height = 10
        Caption = 'Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel97: TRLLabel
        Left = 572
        Top = 71
        Width = 91
        Height = 10
        Caption = 'Ag'#234'ncia / C'#243'digo Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel99: TRLLabel
        Left = 152
        Top = 96
        Width = 68
        Height = 10
        Caption = 'Data do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel101: TRLLabel
        Left = 247
        Top = 96
        Width = 79
        Height = 10
        Caption = 'N'#250'mero do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel103: TRLLabel
        Left = 347
        Top = 96
        Width = 47
        Height = 10
        Caption = 'Esp'#233'cie Doc.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel105: TRLLabel
        Left = 418
        Top = 96
        Width = 23
        Height = 10
        Caption = 'Aceite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel107: TRLLabel
        Left = 479
        Top = 96
        Width = 82
        Height = 10
        Caption = 'Data do Processamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel109: TRLLabel
        Left = 572
        Top = 96
        Width = 53
        Height = 10
        Caption = 'Nosso N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel111: TRLLabel
        Left = 152
        Top = 121
        Width = 49
        Height = 10
        Caption = 'Uso do Banco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel113: TRLLabel
        Left = 247
        Top = 121
        Width = 30
        Height = 10
        Caption = 'Carteira'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel115: TRLLabel
        Left = 298
        Top = 121
        Width = 29
        Height = 10
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 298
        Top = 131
        Width = 44
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel117: TRLLabel
        Left = 348
        Top = 121
        Width = 40
        Height = 10
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel119: TRLLabel
        Left = 479
        Top = 121
        Width = 20
        Height = 10
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel121: TRLLabel
        Left = 572
        Top = 121
        Width = 87
        Height = 10
        Caption = '( = ) Valor do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel123: TRLLabel
        Left = 152
        Top = 146
        Width = 325
        Height = 10
        Caption = 
          'Instru'#231#245'es (Todas as informa'#231#245'es deste bloqueto s'#227'o de exclusiva' +
          ' responsabilidade do cedente.)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel124: TRLLabel
        Left = 572
        Top = 146
        Width = 92
        Height = 10
        Caption = '( - ) Desconto / Abatimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel126: TRLLabel
        Left = 572
        Top = 173
        Width = 62
        Height = 10
        Caption = '( + ) Mora / Multa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel128: TRLLabel
        Left = 572
        Top = 200
        Width = 68
        Height = 10
        Caption = '( = ) Valor Cobrado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel130: TRLLabel
        Left = 152
        Top = 229
        Width = 27
        Height = 10
        Caption = 'Sacado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel132: TRLLabel
        Left = 571
        Top = 229
        Width = 82
        Height = 10
        Caption = 'CPF / CNPJ do Sacado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel135: TRLLabel
        Left = 571
        Top = 255
        Width = 57
        Height = 10
        Caption = 'C'#243'digo de Baixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel138: TRLLabel
        Left = 643
        Top = 284
        Width = 80
        Height = 10
        Caption = 'Autentica'#231#227'o Mec'#226'nica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 474
        Top = 132
        Width = 5
        Height = 10
        Caption = 'x'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 0
        Top = 345
        Width = 26
        Height = 14
        Caption = '"'
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = 150
        Top = 268
        Width = 89
        Height = 14
        Caption = 'Sacador/Avalista:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText17: TRLDBText
        Left = 239
        Top = 268
        Width = 326
        Height = 13
        AutoSize = False
        DataField = 'SacadorAvalista'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText18: TRLDBText
        Left = 570
        Top = 268
        Width = 204
        Height = 13
        AutoSize = False
        DataField = 'NossoNumero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 644
        Top = 310
        Width = 81
        Height = 10
        Caption = 'Ficha de Compensa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel19: TRLLabel
        Left = 0
        Top = 43
        Width = 28
        Height = 10
        Caption = 'Parcela'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel36: TRLLabel
        Left = 66
        Top = 43
        Width = 41
        Height = 10
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw66: TRLDraw
        Left = 55
        Top = 41
        Width = 1
        Height = 30
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLLabel38: TRLLabel
        Left = 0
        Top = 71
        Width = 91
        Height = 10
        Caption = 'Ag'#234'ncia / C'#243'digo Cedente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel39: TRLLabel
        Left = 0
        Top = 95
        Width = 29
        Height = 10
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel40: TRLLabel
        Left = 0
        Top = 105
        Width = 42
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel41: TRLLabel
        Left = 58
        Top = 95
        Width = 40
        Height = 10
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw67: TRLDraw
        Left = 55
        Top = 94
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
      end
      object RLLabel42: TRLLabel
        Left = 0
        Top = 121
        Width = 87
        Height = 10
        Caption = '( = ) Valor do Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel43: TRLLabel
        Left = 0
        Top = 146
        Width = 92
        Height = 10
        Caption = '( - ) Desconto / Abatimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel44: TRLLabel
        Left = 0
        Top = 173
        Width = 62
        Height = 10
        Caption = '( + ) Mora / Multa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel45: TRLLabel
        Left = 0
        Top = 200
        Width = 68
        Height = 10
        Caption = '( = ) Valor Cobrado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw68: TRLDraw
        Left = 0
        Top = 172
        Width = 141
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw69: TRLDraw
        Left = 0
        Top = 199
        Width = 141
        Height = 1
        DrawKind = dkLine
      end
      object RLLabel46: TRLLabel
        Left = 0
        Top = 229
        Width = 53
        Height = 10
        Caption = 'Nosso N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw70: TRLDraw
        Left = 0
        Top = 254
        Width = 141
        Height = 1
        DrawKind = dkLine
      end
      object RLLabel47: TRLLabel
        Left = 0
        Top = 256
        Width = 27
        Height = 10
        Caption = 'Sacado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel48: TRLLabel
        Left = 0
        Top = 318
        Width = 63
        Height = 10
        Caption = 'Recibo do Sacado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel49: TRLLabel
        Left = 0
        Top = 329
        Width = 68
        Height = 10
        Caption = 'Autenticar no Verso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw71: TRLDraw
        Left = 140
        Top = 0
        Width = 11
        Height = 353
        Angle = 90.000000000000000000
        DrawKind = dkLine
        Pen.Style = psDot
        Transparent = False
      end
      object ImgLoja: TRLImage
        Left = 0
        Top = 0
        Width = 143
        Height = 41
        Center = True
        Scaled = True
      end
      object txtTotPar: TRLLabel
        Left = 29
        Top = 55
        Width = 13
        Height = 14
        Caption = '/X'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object mIntrucoes: TRLMemo
        Left = 152
        Top = 156
        Width = 410
        Height = 64
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtLinhaDigitavelCarne: TRLLabel
        Left = 326
        Top = 19
        Width = 418
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtVencCanhoto: TRLLabel
        Left = 56
        Top = 55
        Width = 82
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtCodCedenteCarne: TRLLabel
        Left = 5
        Top = 79
        Width = 129
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorCarne: TRLLabel
        Left = 0
        Top = 131
        Width = 137
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtNossoNumeroCarne: TRLLabel
        Left = 0
        Top = 239
        Width = 137
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCPF: TRLLabel
        Left = 0
        Top = 303
        Width = 142
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtLocal: TRLLabel
        Left = 154
        Top = 53
        Width = 412
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNomeCedente: TRLLabel
        Left = 154
        Top = 80
        Width = 412
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataDocto: TRLLabel
        Left = 152
        Top = 106
        Width = 84
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNumeroDocto: TRLLabel
        Left = 247
        Top = 106
        Width = 94
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEspecieDoc: TRLLabel
        Left = 347
        Top = 106
        Width = 68
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtAceite: TRLLabel
        Left = 418
        Top = 106
        Width = 56
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtDataProces: TRLLabel
        Left = 479
        Top = 106
        Width = 86
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCarteira: TRLLabel
        Left = 247
        Top = 131
        Width = 50
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNomeSacado: TRLLabel
        Left = 180
        Top = 229
        Width = 386
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtEndSacado: TRLLabel
        Left = 180
        Top = 242
        Width = 386
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCidadeSacado: TRLLabel
        Left = 180
        Top = 255
        Width = 386
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtVencCarne2: TRLLabel
        Left = 572
        Top = 55
        Width = 172
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtNossoNumCan: TRLLabel
        Left = 572
        Top = 106
        Width = 172
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorCar: TRLLabel
        Left = 572
        Top = 131
        Width = 172
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtNomeSacadoCarne: TRLLabel
        Left = 0
        Top = 269
        Width = 144
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCodCedenteCarne2: TRLLabel
        Left = 572
        Top = 80
        Width = 172
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCPFCarne2: TRLLabel
        Left = 570
        Top = 239
        Width = 204
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtParcela: TRLLabel
        Left = -26
        Top = 55
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object imgBarrasCarne: TRLBarcode
        Left = 154
        Top = 287
        Width = 465
        Height = 66
        AutoSize = False
        Caption = '23790-3571000000100120'
        CheckSumMethod = cmNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        InvalidCode = icDrawAnyway
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
        ParentFont = False
        Ratio = 3.000000000000000000
      end
      object txtNumeroBanco: TRLLabel
        Left = 254
        Top = 12
        Width = 72
        Height = 27
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'ACBrBoleto - http://acbr.sf.net'
    Left = 822
    Top = 624
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport (Open Source) v3.24(B14)  \251 Copyright '#169' 1999-200' +
      '8 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'ACBrBoleto - http://acbr.sf.net'
    ShowProgress = False
    Left = 824
    Top = 568
  end
  object RLPrintDialogSetup1: TRLPrintDialogSetup
    Copies = 0
    Left = 823
    Top = 752
  end
end
