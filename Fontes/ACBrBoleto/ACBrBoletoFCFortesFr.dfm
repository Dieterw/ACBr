object ACBRBoletoFCFortesFr: TACBRBoletoFCFortesFr
  Left = 376
  Top = 79
  Width = 950
  Height = 879
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
    Left = 8
    Top = 2
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
        Top = 16
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
        Top = 59
        Width = 529
        Height = 16
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
        Left = -3
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
        Top = 59
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
        Top = 187
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
        Top = 219
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
        Top = 251
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
        Left = 0
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
        Left = 41
        Top = 269
        Width = 530
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
        Left = 41
        Top = 285
        Width = 530
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
        Left = 41
        Top = 301
        Width = 530
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
        Left = 0
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
        Left = 89
        Top = 316
        Width = 482
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
      Height = 420
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
        Top = 37
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
        Top = 30
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
        Top = 73
        Width = 529
        Height = 16
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
        Top = 73
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
        Left = 4
        Top = 198
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
        Top = 201
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
        Top = 233
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
        Top = 265
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
        Left = 45
        Top = 284
        Width = 476
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
        Left = 45
        Top = 300
        Width = 476
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
        Left = 45
        Top = 316
        Width = 476
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
        Left = 93
        Top = 330
        Width = 451
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
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'ACBrBoleto - http://acbr.sf.net'
    Left = 854
    Top = 82
  end
  object RLRichFilter1: TRLRichFilter
    DisplayName = 'RichText Format'
    Left = 856
    Top = 146
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport (Open Source) v3.24(B14)  \251 Copyright '#169' 1999-200' +
      '8 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'ACBrBoleto - http://acbr.sf.net'
    Left = 856
    Top = 26
  end
  object RLPrintDialogSetup1: TRLPrintDialogSetup
    Copies = 0
    Left = 855
    Top = 210
  end
end
