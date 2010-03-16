inherited frlDANFeRLRetrato: TfrlDANFeRLRetrato
  Left = 181
  Top = 107
  Width = 825
  Height = 653
  VertScrollBar.Position = 235
  Caption = 'frlDANFeRLRetrato'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLNFe: TRLReport
    Top = -235
    Background.Arrange = baDistributed
    Background.Height = 96
    Background.Width = 175
    DataSource = DataSource1
    InsideMargins.LeftMargin = -3.000000000000000000
    InsideMargins.TopMargin = -4.000000000000000000
    InsideMargins.RightMargin = -3.000000000000000000
    InsideMargins.BottomMargin = -10.000000000000000000
    Margins.LeftMargin = 8.000000000000000000
    Margins.TopMargin = 9.000000000000000000
    Margins.RightMargin = 8.000000000000000000
    Margins.BottomMargin = 9.000000000000000000
    PreviewOptions.FormStyle = fsStayOnTop
    PrintDialog = False
    Title = 'Danfe Retrato'
    AfterPrint = RLNFeAfterPrint
    BeforePrint = RLNFeBeforePrint
    object rliMarcaDagua1: TRLImage
      Left = 241
      Top = 670
      Width = 327
      Height = 234
      Center = True
      HoldStyle = hsHorizontally
      Scaled = True
    end
    object rlbContinuacaoInformacoesComplementares: TRLBand
      Left = 19
      Top = 830
      Width = 756
      Height = 41
      AutoSize = True
      BandType = btSummary
      object rlmContinuacaoDadosAdicionais: TRLMemo
        Left = 8
        Top = 24
        Width = 657
        Height = 12
        Borders.Style = bsClear
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 3
        Top = 13
        Width = 195
        Height = 7
        Caption = 'CONTINUA'#199#195'O DAS INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object LinhaDCSuperior: TRLDraw
        Left = 0
        Top = 10
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDCInferior: TRLDraw
        Left = 0
        Top = 40
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDCEsquerda: TRLDraw
        Left = 0
        Top = 10
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDCDireita: TRLDraw
        Left = 755
        Top = 10
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbCabecalhoItens: TRLBand
      Left = 19
      Top = 766
      Width = 756
      Height = 31
      AutoSize = True
      Background.Arrange = baDistributed
      Background.Height = 96
      Background.Width = 175
      BandType = btColumnHeader
      PageBreaking = pbBeforePrint
      object rlsRectProdutos: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 19
      end
      object RLLabel26: TRLLabel
        Left = 1
        Top = 13
        Width = 753
        Height = 16
        AutoSize = False
        Caption = '  '
        Color = 14540253
        ParentColor = False
        Transparent = False
      end
      object lblDadosDoProduto: TRLLabel
        Left = 0
        Top = 0
        Width = 132
        Height = 10
        Caption = 'DADOS DO PRODUTO / SERVI'#199'OS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = rlsRectProdutos
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLDraw54: TRLDraw
        Left = 702
        Top = 21
        Width = 54
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd1: TRLDraw
        Left = 54
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd2: TRLDraw
        Left = 279
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd3: TRLDraw
        Left = 320
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd4: TRLDraw
        Left = 338
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd5: TRLDraw
        Left = 362
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd6: TRLDraw
        Left = 384
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd7: TRLDraw
        Left = 440
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd8: TRLDraw
        Left = 497
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd9: TRLDraw
        Left = 560
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd10: TRLDraw
        Left = 621
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd11: TRLDraw
        Left = 662
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd12: TRLDraw
        Left = 702
        Top = 12
        Width = 1
        Height = 19
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlsDivProd13: TRLDraw
        Left = 729
        Top = 21
        Width = 1
        Height = 9
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel82: TRLLabel
        Left = 280
        Top = 18
        Width = 40
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'NCM / SH'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel83: TRLLabel
        Left = 321
        Top = 18
        Width = 16
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'CST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel84: TRLLabel
        Left = 339
        Top = 18
        Width = 22
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'CFOP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel85: TRLLabel
        Left = 363
        Top = 18
        Width = 22
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'UNID.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel91: TRLLabel
        Left = 385
        Top = 18
        Width = 54
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'QUANTIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel87: TRLLabel
        Left = 442
        Top = 14
        Width = 54
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel88: TRLLabel
        Left = 442
        Top = 21
        Width = 54
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'UNIT'#193'RIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel86: TRLLabel
        Left = 499
        Top = 18
        Width = 60
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'VALOR TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel89: TRLLabel
        Left = 562
        Top = 14
        Width = 58
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'BASE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel90: TRLLabel
        Left = 562
        Top = 21
        Width = 58
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'C'#193'LC. I.C.M.S.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel92: TRLLabel
        Left = 623
        Top = 14
        Width = 38
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel93: TRLLabel
        Left = 623
        Top = 21
        Width = 38
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'I.C.M.S.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel94: TRLLabel
        Left = 664
        Top = 14
        Width = 38
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel95: TRLLabel
        Left = 664
        Top = 21
        Width = 38
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'I.P.I.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel96: TRLLabel
        Left = 705
        Top = 13
        Width = 48
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'AL'#205'QUOTAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel97: TRLLabel
        Left = 703
        Top = 22
        Width = 26
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'I.C.M.S.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel98: TRLLabel
        Left = 732
        Top = 22
        Width = 20
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Caption = 'I.P.I.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rlmDescricaoProduto: TRLMemo
        Left = 56
        Top = 18
        Width = 222
        Height = 7
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'DESCRI'#199#195'O DO PRODUTO / SERVI'#199'O')
        ParentFont = False
      end
      object rlmCodProd: TRLMemo
        Left = 1
        Top = 14
        Width = 52
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'C'#211'DIGO DO PROD. / SERV.')
        ParentFont = False
      end
    end
    object rlbReciboHeader: TRLBand
      Left = 19
      Top = 19
      Width = 756
      Height = 74
      BandType = btHeader
      object rlCanhoto: TRLDraw
        Left = 0
        Top = 0
        Width = 756
        Height = 57
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 61
        Width = 764
        Height = 9
        DrawKind = dkLine
        HoldStyle = hsHorizontally
        Pen.Style = psDot
      end
      object rliCanhoto1: TRLDraw
        Left = 0
        Top = 25
        Width = 602
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object rliCanhoto2: TRLDraw
        Left = 102
        Top = 25
        Width = 1
        Height = 32
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rllRecebemosDe: TRLLabel
        Left = 6
        Top = 4
        Width = 337
        Height = 10
        Caption = 
          'RECEBEMOS DE %s OS PRODUTOS CONSTANTES DA NOTA FISCAL INDICADO A' +
          'O LADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllDataRecebimento: TRLLabel
        Left = 3
        Top = 28
        Width = 88
        Height = 7
        Caption = 'DATA DE RECEBIMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllIdentificacao: TRLLabel
        Left = 105
        Top = 28
        Width = 172
        Height = 7
        Caption = 'IDENTIFICA'#199#195'O E ASSINATURA DO RECEBEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw4: TRLDraw
        Left = 602
        Top = 0
        Width = 1
        Height = 57
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLLabel3: TRLLabel
        Left = 608
        Top = 2
        Width = 140
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'NF-e'
      end
      object RLLabel4: TRLLabel
        Left = 633
        Top = 20
        Width = 18
        Height = 16
        Caption = 'N'#186
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllNumNF0: TRLLabel
        Left = 654
        Top = 20
        Width = 75
        Height = 16
        Caption = '000.000.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 644
        Top = 37
        Width = 43
        Height = 16
        Caption = 'S'#201'RIE'
      end
      object rllSERIE0: TRLLabel
        Left = 692
        Top = 37
        Width = 25
        Height = 16
        Caption = '000'
      end
      object rllResumo: TRLLabel
        Left = 60
        Top = 14
        Width = 486
        Height = 10
        Alignment = taCenter
        Caption = 
          'DATA DE EMISS'#195'O: 00/00/0000  -  DEST./REM.: XXXXXXXXXXXXXXXXXXXX' +
          'XXXXXXXXXXXXXXXXXXXXX  -  VALOR TOTAL: R$ 0.000,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbEmitente: TRLBand
      Left = 19
      Top = 93
      Width = 756
      Height = 182
      AutoExpand = False
      BandType = btHeader
      BeforePrint = rlbEmitenteBeforePrint
      object RLDraw5: TRLDraw
        Left = 0
        Top = 0
        Width = 289
        Height = 117
      end
      object RLDraw6: TRLDraw
        Left = 0
        Top = 116
        Width = 756
        Height = 61
      end
      object RLDraw7: TRLDraw
        Left = 445
        Top = 0
        Width = 311
        Height = 117
      end
      object RLDraw8: TRLDraw
        Left = 0
        Top = 146
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object RLDraw9: TRLDraw
        Left = 445
        Top = 116
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLDraw10: TRLDraw
        Left = 252
        Top = 146
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLDraw11: TRLDraw
        Left = 504
        Top = 146
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLLabel7: TRLLabel
        Left = 292
        Top = 0
        Width = 150
        Height = 23
        Alignment = taCenter
        AutoSize = False
        Caption = 'DANFE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 292
        Top = 23
        Width = 150
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'DOCUMENTO AUXILIAR DA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 292
        Top = 35
        Width = 150
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'NOTA FISCAL ELETR'#212'NICA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 308
        Top = 51
        Width = 68
        Height = 14
        Caption = '0 - ENTRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 308
        Top = 63
        Width = 51
        Height = 14
        Caption = '1 - SA'#205'DA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw12: TRLDraw
        Left = 394
        Top = 51
        Width = 25
        Height = 25
      end
      object rllEntradaSaida: TRLLabel
        Left = 397
        Top = 54
        Width = 20
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 292
        Top = 81
        Width = 18
        Height = 16
        Caption = 'N'#186
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllNumNF1: TRLLabel
        Left = 310
        Top = 81
        Width = 75
        Height = 16
        Caption = '000.000.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = 330
        Top = 98
        Width = 43
        Height = 16
        Caption = 'S'#201'RIE'
      end
      object rllSERIE1: TRLLabel
        Left = 378
        Top = 98
        Width = 25
        Height = 16
        Caption = '000'
      end
      object RLDraw13: TRLDraw
        Left = 445
        Top = 48
        Width = 311
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object RLDraw14: TRLDraw
        Left = 445
        Top = 78
        Width = 311
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object rlbCodigoBarras: TRLBarcode
        Left = 536
        Top = 5
        Width = 132
        Height = 40
        Alignment = taCenter
        BarcodeType = bcCode128C
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
      end
      object RLLabel5: TRLLabel
        Left = 448
        Top = 51
        Width = 71
        Height = 7
        Caption = 'CHAVE DE ACESSO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDadosVariaveis1a: TRLLabel
        Left = 452
        Top = 80
        Width = 300
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Consulta de autenticidade no portal nacional da NF-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDadosVariaveis1b: TRLLabel
        Left = 452
        Top = 91
        Width = 300
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'www.nfe.fazenda.gov.br/portal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDadosVariaveis3_Descricao: TRLLabel
        Left = 448
        Top = 119
        Width = 140
        Height = 7
        Caption = 'PROTOCOLO DE AUTORIZA'#199#195'O DE USO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel28: TRLLabel
        Left = 3
        Top = 119
        Width = 95
        Height = 7
        Caption = 'NATUREZA DE OPERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw6
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel29: TRLLabel
        Left = 3
        Top = 149
        Width = 82
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw6
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel30: TRLLabel
        Left = 255
        Top = 149
        Width = 144
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL DO SUBST. TRIB.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel31: TRLLabel
        Left = 507
        Top = 149
        Width = 21
        Height = 7
        Caption = 'CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rlmEmitente: TRLMemo
        Left = 80
        Top = 18
        Width = 202
        Height = 31
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlmEndereco: TRLMemo
        Left = 80
        Top = 48
        Width = 202
        Height = 33
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllFone: TRLLabel
        Left = 80
        Top = 80
        Width = 202
        Height = 12
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rliLogo: TRLImage
        Left = 8
        Top = 40
        Width = 67
        Height = 48
        Center = True
        Scaled = True
      end
      object rllNatOperacao: TRLLabel
        Left = 7
        Top = 129
        Width = 434
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllDadosVariaveis3: TRLLabel
        Left = 452
        Top = 129
        Width = 300
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllInscricaoEstadual: TRLLabel
        Left = 7
        Top = 159
        Width = 242
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllInscrEstSubst: TRLLabel
        Left = 259
        Top = 159
        Width = 240
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllCNPJ: TRLLabel
        Left = 511
        Top = 159
        Width = 240
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllChave: TRLLabel
        Left = 452
        Top = 61
        Width = 298
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 3
        Top = 3
        Width = 108
        Height = 7
        Caption = 'IDENTIFICA'#199'AO DO EMITENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllXmotivo: TRLLabel
        Left = 551
        Top = 14
        Width = 100
        Height = 22
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllDadosVariaveis1c: TRLLabel
        Left = 452
        Top = 103
        Width = 300
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'ou no site da Sefaz Autorizadora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rlbCodigoBarrasFS: TRLBarcode
        Left = 528
        Top = 81
        Width = 144
        Height = 33
        Alignment = taCenter
        BarcodeType = bcCode128C
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
      end
      object rllPageNumber: TRLSystemInfo
        Left = 384
        Top = 81
        Width = 41
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Info = itPageNumber
        Text = 'FL. '
      end
      object rllLastPage: TRLSystemInfo
        Left = 420
        Top = 81
        Width = 24
        Height = 16
        AutoSize = False
        Info = itLastPageNumber
        Text = '/'
      end
      object rlmSiteEmail: TRLMemo
        Left = 80
        Top = 92
        Width = 202
        Height = 22
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbDadosAdicionais: TRLBand
      Left = 19
      Top = 929
      Width = 756
      Height = 184
      AutoExpand = False
      BandType = btFooter
      BeforePrint = rlbDadosAdicionaisBeforePrint
      object RLDraw50: TRLDraw
        Left = 0
        Top = 20
        Width = 756
        Height = 136
      end
      object RLLabel23: TRLLabel
        Left = 0
        Top = 8
        Width = 77
        Height = 10
        Caption = 'DADOS ADICIONAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLDraw50
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLDraw51: TRLDraw
        Left = 468
        Top = 20
        Width = 1
        Height = 136
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel77: TRLLabel
        Left = 3
        Top = 23
        Width = 124
        Height = 7
        Caption = 'INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw50
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel78: TRLLabel
        Left = 471
        Top = 23
        Width = 82
        Height = 7
        Caption = 'RESERVADO AO FISCO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rlmDadosAdicionais: TRLMemo
        Left = 8
        Top = 34
        Width = 402
        Height = 111
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        IntegralHeight = True
        ParentFont = False
      end
      object rllHomologacao: TRLLabel
        Left = 302
        Top = 81
        Width = 152
        Height = 22
        Align = faCenter
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllUsuario: TRLLabel
        Left = 0
        Top = 157
        Width = 212
        Height = 7
        Caption = 'DATA / HORA DA IMPRESS'#195'O: 00/00/0000 00:00:00 - USUARIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllSistema: TRLLabel
        Left = 578
        Top = 157
        Width = 176
        Height = 7
        Alignment = taRightJustify
        Caption = 'DESENVOLVIDO POR: EMPRESA RRRRRRRRRRRR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbDestinatario: TRLBand
      Left = 19
      Top = 275
      Width = 756
      Height = 108
      BandType = btTitle
      object RLDraw15: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 91
      end
      object RLLabel18: TRLLabel
        Left = 0
        Top = 1
        Width = 116
        Height = 10
        Caption = 'DESTINAT'#193'RIO / REMETENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLDraw15
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel32: TRLLabel
        Left = 3
        Top = 15
        Width = 80
        Height = 7
        Caption = 'NOME / RAZ'#195'O SOCIAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw15
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestNome: TRLLabel
        Left = 7
        Top = 25
        Width = 522
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel35: TRLLabel
        Left = 3
        Top = 45
        Width = 42
        Height = 7
        Caption = 'ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw15
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestEndereco: TRLLabel
        Left = 7
        Top = 55
        Width = 414
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel39: TRLLabel
        Left = 3
        Top = 75
        Width = 38
        Height = 7
        Caption = 'MUNIC'#205'PIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw15
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestCidade: TRLLabel
        Left = 7
        Top = 85
        Width = 298
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel40: TRLLabel
        Left = 319
        Top = 75
        Width = 41
        Height = 7
        Caption = 'FONE / FAX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestFone: TRLLabel
        Left = 323
        Top = 85
        Width = 146
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel36: TRLLabel
        Left = 429
        Top = 45
        Width = 69
        Height = 7
        Caption = 'BAIRRO / DISTRITO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestBairro: TRLLabel
        Left = 433
        Top = 55
        Width = 152
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel41: TRLLabel
        Left = 476
        Top = 75
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestUF: TRLLabel
        Left = 480
        Top = 85
        Width = 54
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel33: TRLLabel
        Left = 541
        Top = 15
        Width = 41
        Height = 7
        Caption = 'CNPJ / CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestCNPJ: TRLLabel
        Left = 545
        Top = 25
        Width = 112
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel37: TRLLabel
        Left = 593
        Top = 45
        Width = 17
        Height = 7
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestCEP: TRLLabel
        Left = 597
        Top = 55
        Width = 60
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel42: TRLLabel
        Left = 541
        Top = 75
        Width = 82
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestIE: TRLLabel
        Left = 545
        Top = 85
        Width = 112
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel34: TRLLabel
        Left = 666
        Top = 15
        Width = 68
        Height = 7
        Caption = 'DATA DA EMISS'#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEmissao: TRLLabel
        Left = 670
        Top = 25
        Width = 80
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel38: TRLLabel
        Left = 666
        Top = 45
        Width = 87
        Height = 7
        Caption = 'DATA SA'#205'DA / ENTRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllSaida: TRLLabel
        Left = 670
        Top = 55
        Width = 80
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel43: TRLLabel
        Left = 666
        Top = 75
        Width = 58
        Height = 7
        Caption = 'HORA DA SA'#205'DA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllHoraSaida: TRLLabel
        Left = 670
        Top = 85
        Width = 80
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw16: TRLDraw
        Left = 0
        Top = 42
        Width = 756
        Height = 1
        DrawKind = dkLine
        Holder = RLDraw15
        HoldStyle = hsRelatively
      end
      object RLDraw17: TRLDraw
        Left = 0
        Top = 72
        Width = 756
        Height = 1
        DrawKind = dkLine
        Holder = RLDraw15
        HoldStyle = hsRelatively
      end
      object RLDraw22: TRLDraw
        Left = 316
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw23: TRLDraw
        Left = 473
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw20: TRLDraw
        Left = 426
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw19: TRLDraw
        Left = 538
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw24: TRLDraw
        Left = 538
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw21: TRLDraw
        Left = 590
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw18: TRLDraw
        Left = 663
        Top = 12
        Width = 1
        Height = 90
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbFatura: TRLBand
      Left = 19
      Top = 483
      Width = 756
      Height = 68
      BandType = btTitle
      object RLDraw25: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 51
      end
      object RLLabel19: TRLLabel
        Left = 0
        Top = 1
        Width = 34
        Height = 10
        Caption = 'FATURA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllFatNum1: TRLLabel
        Left = 4
        Top = 25
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '01'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum2: TRLLabel
        Left = 4
        Top = 38
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '02'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum3: TRLLabel
        Left = 4
        Top = 51
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '03'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData1: TRLLabel
        Left = 68
        Top = 25
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData2: TRLLabel
        Left = 68
        Top = 38
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData3: TRLLabel
        Left = 68
        Top = 51
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor1: TRLLabel
        Left = 120
        Top = 25
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor2: TRLLabel
        Left = 120
        Top = 38
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor3: TRLLabel
        Left = 120
        Top = 51
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum4: TRLLabel
        Left = 193
        Top = 25
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '04'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum5: TRLLabel
        Left = 193
        Top = 38
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '05'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum6: TRLLabel
        Left = 193
        Top = 51
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '06'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData4: TRLLabel
        Left = 257
        Top = 25
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData5: TRLLabel
        Left = 257
        Top = 38
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData6: TRLLabel
        Left = 257
        Top = 51
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor4: TRLLabel
        Left = 309
        Top = 25
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor5: TRLLabel
        Left = 309
        Top = 38
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor6: TRLLabel
        Left = 309
        Top = 51
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum7: TRLLabel
        Left = 382
        Top = 25
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '07'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum8: TRLLabel
        Left = 382
        Top = 38
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '08'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum9: TRLLabel
        Left = 382
        Top = 51
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '09'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData7: TRLLabel
        Left = 446
        Top = 25
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData8: TRLLabel
        Left = 446
        Top = 38
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData9: TRLLabel
        Left = 446
        Top = 51
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor7: TRLLabel
        Left = 498
        Top = 25
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor8: TRLLabel
        Left = 498
        Top = 38
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor9: TRLLabel
        Left = 498
        Top = 51
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum10: TRLLabel
        Left = 571
        Top = 25
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum11: TRLLabel
        Left = 571
        Top = 38
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum12: TRLLabel
        Left = 571
        Top = 51
        Width = 65
        Height = 10
        AutoSize = False
        Caption = '12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData10: TRLLabel
        Left = 635
        Top = 25
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData11: TRLLabel
        Left = 635
        Top = 38
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData12: TRLLabel
        Left = 635
        Top = 51
        Width = 49
        Height = 12
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor10: TRLLabel
        Left = 687
        Top = 25
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor11: TRLLabel
        Left = 687
        Top = 38
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor12: TRLLabel
        Left = 687
        Top = 51
        Width = 66
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw26: TRLDraw
        Left = 189
        Top = 12
        Width = 1
        Height = 51
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLDraw27: TRLDraw
        Left = 378
        Top = 12
        Width = 1
        Height = 51
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLDraw28: TRLDraw
        Left = 567
        Top = 12
        Width = 1
        Height = 51
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rllTipoVenda: TRLLabel
        Left = 8
        Top = 36
        Width = 176
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllCabFatura1: TRLLabel
        Left = 20
        Top = 14
        Width = 32
        Height = 7
        Caption = 'N'#218'MERO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura2: TRLLabel
        Left = 80
        Top = 14
        Width = 24
        Height = 7
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura3: TRLLabel
        Left = 142
        Top = 14
        Width = 26
        Height = 7
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura4: TRLLabel
        Left = 209
        Top = 14
        Width = 32
        Height = 7
        Caption = 'N'#218'MERO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura5: TRLLabel
        Left = 273
        Top = 14
        Width = 24
        Height = 7
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura6: TRLLabel
        Left = 331
        Top = 14
        Width = 26
        Height = 7
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura7: TRLLabel
        Left = 398
        Top = 14
        Width = 32
        Height = 7
        Caption = 'N'#218'MERO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura8: TRLLabel
        Left = 458
        Top = 14
        Width = 24
        Height = 7
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura9: TRLLabel
        Left = 520
        Top = 14
        Width = 26
        Height = 7
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura10: TRLLabel
        Left = 587
        Top = 14
        Width = 32
        Height = 7
        Caption = 'N'#218'MERO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura11: TRLLabel
        Left = 647
        Top = 14
        Width = 24
        Height = 7
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura12: TRLLabel
        Left = 709
        Top = 14
        Width = 26
        Height = 7
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw69: TRLDraw
        Left = 0
        Top = 23
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbImposto: TRLBand
      Left = 19
      Top = 551
      Width = 756
      Height = 79
      BandType = btTitle
      object RLDraw29: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 61
      end
      object RLLabel25: TRLLabel
        Left = 590
        Top = 43
        Width = 164
        Height = 28
        AutoSize = False
        Caption = '  '
        Color = 14540253
        ParentColor = False
        Transparent = False
      end
      object RLLabel20: TRLLabel
        Left = 0
        Top = 1
        Width = 94
        Height = 10
        Caption = 'C'#193'LCULO DO IMPOSTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLDraw29
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel44: TRLLabel
        Left = 3
        Top = 15
        Width = 100
        Height = 7
        Caption = 'BASE DE C'#193'LCULO DO ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw29
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllBaseICMS: TRLLabel
        Left = 7
        Top = 25
        Width = 134
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel49: TRLLabel
        Left = 3
        Top = 45
        Width = 64
        Height = 7
        Caption = 'VALOR DO FRETE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw29
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorFrete: TRLLabel
        Left = 7
        Top = 55
        Width = 94
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel45: TRLLabel
        Left = 149
        Top = 15
        Width = 57
        Height = 7
        Caption = 'VALOR DO ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw29
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorICMS: TRLLabel
        Left = 152
        Top = 25
        Width = 127
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel50: TRLLabel
        Left = 109
        Top = 45
        Width = 70
        Height = 7
        Caption = 'VALOR DO SEGURO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw29
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorSeguro: TRLLabel
        Left = 113
        Top = 55
        Width = 96
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel51: TRLLabel
        Left = 218
        Top = 45
        Width = 42
        Height = 7
        Caption = 'DESCONTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw29
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDescontos: TRLLabel
        Left = 224
        Top = 55
        Width = 92
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel46: TRLLabel
        Left = 287
        Top = 15
        Width = 120
        Height = 7
        Caption = 'BASE C'#193'LC. ICMS SUBSTITUI'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllBaseICMST: TRLLabel
        Left = 291
        Top = 25
        Width = 132
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel52: TRLLabel
        Left = 325
        Top = 45
        Width = 90
        Height = 7
        Caption = 'OUTRAS DESP. ACCESS.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllAcessorias: TRLLabel
        Left = 329
        Top = 55
        Width = 94
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel47: TRLLabel
        Left = 431
        Top = 15
        Width = 113
        Height = 7
        Caption = 'VALOR DO ICMS SUBSTITUI'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorICMST: TRLLabel
        Left = 435
        Top = 25
        Width = 148
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel53: TRLLabel
        Left = 431
        Top = 45
        Width = 49
        Height = 7
        Caption = 'VALOR DO IPI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorIPI: TRLLabel
        Left = 433
        Top = 55
        Width = 150
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel48: TRLLabel
        Left = 592
        Top = 15
        Width = 111
        Height = 7
        Caption = 'VALOR TOTAL DOS PRODUTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTotalProdutos: TRLLabel
        Left = 596
        Top = 25
        Width = 154
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw30: TRLDraw
        Left = 0
        Top = 42
        Width = 756
        Height = 1
        DrawKind = dkLine
        Holder = RLDraw29
        HoldStyle = hsRelatively
      end
      object RLDraw32: TRLDraw
        Left = 146
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        Holder = RLDraw29
        HoldStyle = hsRelatively
      end
      object RLDraw33: TRLDraw
        Left = 106
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        Holder = RLDraw29
        HoldStyle = hsRelatively
      end
      object RLDraw34: TRLDraw
        Left = 215
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        Holder = RLDraw29
        HoldStyle = hsRelatively
      end
      object RLDraw35: TRLDraw
        Left = 322
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw36: TRLDraw
        Left = 428
        Top = 12
        Width = 1
        Height = 61
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw31: TRLDraw
        Left = 284
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw37: TRLDraw
        Left = 589
        Top = 12
        Width = 1
        Height = 61
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel54: TRLLabel
        Left = 592
        Top = 45
        Width = 86
        Height = 7
        Caption = 'VALOR TOTAL DA NOTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTotalNF: TRLLabel
        Left = 596
        Top = 55
        Width = 154
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlbTransportadora: TRLBand
      Left = 19
      Top = 630
      Width = 756
      Height = 110
      BandType = btTitle
      object RLDraw40: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 91
        HoldStyle = hsRelatively
      end
      object RLLabel21: TRLLabel
        Left = 0
        Top = 1
        Width = 192
        Height = 10
        Caption = 'TRANSPORTADOR / VOLUMES TRANSPORTADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLDraw40
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel55: TRLLabel
        Left = 3
        Top = 15
        Width = 54
        Height = 7
        Caption = 'RAZ'#195'O SOCIAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw40
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransNome: TRLLabel
        Left = 7
        Top = 25
        Width = 322
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel63: TRLLabel
        Left = 3
        Top = 45
        Width = 42
        Height = 7
        Caption = 'ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw40
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransEndereco: TRLLabel
        Left = 7
        Top = 55
        Width = 370
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel67: TRLLabel
        Left = 3
        Top = 75
        Width = 49
        Height = 7
        Caption = 'QUANTIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw40
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransQTDE: TRLLabel
        Left = 7
        Top = 85
        Width = 79
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel68: TRLLabel
        Left = 94
        Top = 75
        Width = 34
        Height = 7
        Caption = 'ESP'#201'CIE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw40
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransEspecie: TRLLabel
        Left = 98
        Top = 85
        Width = 124
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel69: TRLLabel
        Left = 229
        Top = 75
        Width = 27
        Height = 7
        Caption = 'MARCA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransMarca: TRLLabel
        Left = 233
        Top = 85
        Width = 120
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel56: TRLLabel
        Left = 335
        Top = 15
        Width = 70
        Height = 7
        Caption = 'FRETE POR CONTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel57: TRLLabel
        Left = 339
        Top = 24
        Width = 49
        Height = 7
        Caption = '0 - EMITENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel58: TRLLabel
        Left = 339
        Top = 32
        Width = 66
        Height = 7
        Caption = '1 - DESTINAT'#193'RIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel64: TRLLabel
        Left = 383
        Top = 45
        Width = 38
        Height = 7
        Caption = 'MUNIC'#205'PIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransCidade: TRLLabel
        Left = 387
        Top = 55
        Width = 206
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel70: TRLLabel
        Left = 359
        Top = 75
        Width = 47
        Height = 7
        Caption = 'NUMERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransNumeracao: TRLLabel
        Left = 363
        Top = 85
        Width = 136
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw55: TRLDraw
        Left = 415
        Top = 17
        Width = 22
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HoldStyle = hsRelatively
      end
      object RLLabel59: TRLLabel
        Left = 443
        Top = 15
        Width = 51
        Height = 7
        Caption = 'C'#211'DIGO ANTT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransCodigoANTT: TRLLabel
        Left = 447
        Top = 25
        Width = 66
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel60: TRLLabel
        Left = 520
        Top = 15
        Width = 71
        Height = 7
        Caption = 'PLACA DO VE'#205'CULO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransPlaca: TRLLabel
        Left = 524
        Top = 25
        Width = 66
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel71: TRLLabel
        Left = 506
        Top = 75
        Width = 49
        Height = 7
        Caption = 'PESO BRUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransPesoBruto: TRLLabel
        Left = 511
        Top = 85
        Width = 114
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel61: TRLLabel
        Left = 600
        Top = 15
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransUFPlaca: TRLLabel
        Left = 604
        Top = 25
        Width = 21
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel65: TRLLabel
        Left = 600
        Top = 45
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransUF: TRLLabel
        Left = 604
        Top = 55
        Width = 21
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel62: TRLLabel
        Left = 634
        Top = 15
        Width = 41
        Height = 7
        Caption = 'CNPJ / CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransCNPJ: TRLLabel
        Left = 637
        Top = 25
        Width = 116
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel66: TRLLabel
        Left = 634
        Top = 45
        Width = 82
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransIE: TRLLabel
        Left = 637
        Top = 55
        Width = 116
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw38: TRLDraw
        Left = 0
        Top = 42
        Width = 756
        Height = 1
        DrawKind = dkLine
        Holder = RLDraw40
        HoldStyle = hsRelatively
      end
      object RLDraw39: TRLDraw
        Left = 0
        Top = 72
        Width = 756
        Height = 1
        DrawKind = dkLine
        Holder = RLDraw40
        HoldStyle = hsRelatively
      end
      object RLDraw46: TRLDraw
        Left = 91
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        Holder = RLDraw40
        HoldStyle = hsRelatively
      end
      object RLDraw45: TRLDraw
        Left = 226
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw41: TRLDraw
        Left = 332
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw44: TRLDraw
        Left = 503
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw47: TRLDraw
        Left = 440
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw48: TRLDraw
        Left = 517
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw49: TRLDraw
        Left = 597
        Top = 12
        Width = 1
        Height = 61
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw42: TRLDraw
        Left = 630
        Top = 12
        Width = 1
        Height = 91
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rllTransModFrete: TRLLabel
        Left = 417
        Top = 22
        Width = 18
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel72: TRLLabel
        Left = 634
        Top = 75
        Width = 52
        Height = 7
        Caption = 'PESO L'#205'QUIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransPesoLiq: TRLLabel
        Left = 636
        Top = 85
        Width = 114
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw70: TRLDraw
        Left = 380
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw71: TRLDraw
        Left = 356
        Top = 72
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbEnderecoEntrega: TRLBand
      Left = 19
      Top = 433
      Width = 756
      Height = 50
      BandType = btTitle
      object RLDraw43: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 61
      end
      object RLLabel15: TRLLabel
        Left = 0
        Top = 1
        Width = 82
        Height = 10
        Caption = 'LOCAL DE ENTREGA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLDraw53: TRLDraw
        Left = 0
        Top = 42
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel17: TRLLabel
        Left = 139
        Top = 15
        Width = 42
        Height = 7
        Caption = 'ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEntregaEndereco: TRLLabel
        Left = 143
        Top = 25
        Width = 602
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel99: TRLLabel
        Left = 292
        Top = 45
        Width = 38
        Height = 7
        Caption = 'MUNIC'#205'PIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEntregaMunicipio: TRLLabel
        Left = 296
        Top = 55
        Width = 284
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel103: TRLLabel
        Left = 3
        Top = 45
        Width = 69
        Height = 7
        Caption = 'BAIRRO / DISTRITO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEntregaBairro: TRLLabel
        Left = 7
        Top = 55
        Width = 272
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel105: TRLLabel
        Left = 589
        Top = 45
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEntregaUF: TRLLabel
        Left = 593
        Top = 55
        Width = 54
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllEntregaCEP: TRLLabel
        Left = 661
        Top = 55
        Width = 84
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel111: TRLLabel
        Left = 3
        Top = 15
        Width = 41
        Height = 7
        Caption = 'CNPJ / CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEntregaCNPJ: TRLLabel
        Left = 7
        Top = 25
        Width = 122
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw60: TRLDraw
        Left = 289
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw61: TRLDraw
        Left = 586
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw63: TRLDraw
        Left = 654
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw65: TRLDraw
        Left = 136
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel109: TRLLabel
        Left = 657
        Top = 45
        Width = 17
        Height = 7
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
    end
    object rlbEnderecoRetirada: TRLBand
      Left = 19
      Top = 383
      Width = 756
      Height = 50
      BandType = btTitle
      object RLDraw59: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 61
      end
      object RLLabel27: TRLLabel
        Left = 0
        Top = 1
        Width = 84
        Height = 10
        Caption = 'LOCAL DE RETIRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLDraw62: TRLDraw
        Left = 0
        Top = 42
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel100: TRLLabel
        Left = 139
        Top = 15
        Width = 42
        Height = 7
        Caption = 'ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllRetiradaEndereco: TRLLabel
        Left = 143
        Top = 25
        Width = 602
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel102: TRLLabel
        Left = 292
        Top = 45
        Width = 38
        Height = 7
        Caption = 'MUNIC'#205'PIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllRetiradaMunicipio: TRLLabel
        Left = 296
        Top = 55
        Width = 284
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel106: TRLLabel
        Left = 3
        Top = 45
        Width = 69
        Height = 7
        Caption = 'BAIRRO / DISTRITO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllRetiradaBairro: TRLLabel
        Left = 7
        Top = 55
        Width = 272
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel108: TRLLabel
        Left = 589
        Top = 45
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllRetiradaUF: TRLLabel
        Left = 593
        Top = 55
        Width = 54
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllRetiradaCEP: TRLLabel
        Left = 661
        Top = 55
        Width = 84
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel113: TRLLabel
        Left = 3
        Top = 15
        Width = 41
        Height = 7
        Caption = 'CNPJ / CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllRetiradaCNPJ: TRLLabel
        Left = 7
        Top = 25
        Width = 122
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw64: TRLDraw
        Left = 289
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw66: TRLDraw
        Left = 586
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw67: TRLDraw
        Left = 654
        Top = 42
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw68: TRLDraw
        Left = 136
        Top = 12
        Width = 1
        Height = 31
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel115: TRLLabel
        Left = 657
        Top = 45
        Width = 17
        Height = 7
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
    end
    object rlbItens: TRLBand
      Left = 19
      Top = 797
      Width = 756
      Height = 13
      Background.Height = 487
      Background.Width = 865
      AfterPrint = rlbItensAfterPrint
      object txtCodigo: TRLDBText
        Left = 1
        Top = 1
        Width = 52
        Height = 11
        AutoSize = False
        DataField = 'CODIGO'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtNCM: TRLDBText
        Left = 280
        Top = 1
        Width = 39
        Height = 11
        AutoSize = False
        DataField = 'NCM'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCST: TRLDBText
        Left = 321
        Top = 1
        Width = 16
        Height = 11
        AutoSize = False
        DataField = 'CST'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtCFOP: TRLDBText
        Left = 340
        Top = 1
        Width = 21
        Height = 11
        AutoSize = False
        DataField = 'CFOP'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtUnidade: TRLDBText
        Left = 364
        Top = 1
        Width = 19
        Height = 11
        AutoSize = False
        DataField = 'UNIDADE'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtQuantidade: TRLDBText
        Left = 386
        Top = 1
        Width = 53
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QTDE'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorUnitario: TRLDBText
        Left = 442
        Top = 1
        Width = 54
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALOR'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorTotal: TRLDBText
        Left = 499
        Top = 1
        Width = 60
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'TOTAL'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtBaseICMS: TRLDBText
        Left = 562
        Top = 1
        Width = 58
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'BICMS'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorICMS: TRLDBText
        Left = 623
        Top = 1
        Width = 38
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALORICMS'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValorIPI: TRLDBText
        Left = 664
        Top = 1
        Width = 37
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALORIPI'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtAliqICMS: TRLDBText
        Left = 704
        Top = 1
        Width = 24
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'ALIQICMS'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtAliqIPI: TRLDBText
        Left = 731
        Top = 1
        Width = 23
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'ALIQIPI'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object LinhaCST: TRLDraw
        Left = 320
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaCFOP: TRLDraw
        Left = 338
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaUnidade: TRLDraw
        Left = 362
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaQuantidade: TRLDraw
        Left = 384
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaValorUnitario: TRLDraw
        Left = 440
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaValorTotal: TRLDraw
        Left = 497
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaBaseICMS: TRLDraw
        Left = 560
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaValorICMS: TRLDraw
        Left = 621
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaValorIPI: TRLDraw
        Left = 662
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaAliqICMS: TRLDraw
        Left = 702
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaAliqIPI: TRLDraw
        Left = 729
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaFinal: TRLDraw
        Left = 755
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaNCM: TRLDraw
        Left = 279
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDescricao: TRLDraw
        Left = 54
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaCodigo: TRLDraw
        Left = 0
        Top = 0
        Width = 1
        Height = 12
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlmDescricao: TRLDBMemo
        Left = 56
        Top = 1
        Width = 201
        Height = 10
        DataField = 'DESCRICAO'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel101: TRLLabel
        Left = 680
        Top = 16
        Width = 72
        Height = 16
      end
      object LinhaFimItens: TRLDraw
        Left = 0
        Top = 12
        Width = 756
        Height = 1
        Align = faBottom
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbISSQN: TRLBand
      Left = 19
      Top = 871
      Width = 756
      Height = 58
      BandType = btFooter
      object RLDraw52: TRLDraw
        Left = 0
        Top = 20
        Width = 756
        Height = 31
      end
      object RLLabel24: TRLLabel
        Left = 0
        Top = 8
        Width = 82
        Height = 10
        Caption = 'C'#193'LCULO DO ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLDraw52
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel73: TRLLabel
        Left = 3
        Top = 23
        Width = 81
        Height = 7
        Caption = 'INSCRI'#199#195'O MUNICIPAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = RLDraw52
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel74: TRLLabel
        Left = 192
        Top = 23
        Width = 108
        Height = 7
        Caption = 'VALOR TOTAL DOS SERVI'#199'OS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel75: TRLLabel
        Left = 381
        Top = 23
        Width = 105
        Height = 7
        Caption = 'BASE DE C'#193'LCULO DO ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel76: TRLLabel
        Left = 570
        Top = 23
        Width = 62
        Height = 7
        Caption = 'VALOR DO ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLDraw56: TRLDraw
        Left = 189
        Top = 20
        Width = 1
        Height = 30
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw57: TRLDraw
        Left = 378
        Top = 20
        Width = 1
        Height = 30
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw58: TRLDraw
        Left = 567
        Top = 20
        Width = 1
        Height = 30
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rllISSQNValorServicos: TRLLabel
        Left = 244
        Top = 33
        Width = 130
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllISSQNBaseCalculo: TRLLabel
        Left = 434
        Top = 33
        Width = 130
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllISSQNValorISSQN: TRLLabel
        Left = 620
        Top = 33
        Width = 130
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllISSQNInscricao: TRLLabel
        Left = 7
        Top = 33
        Width = 178
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlbAvisoContingencia: TRLBand
      Left = 19
      Top = 740
      Width = 756
      Height = 26
      BandType = btColumnHeader
      object rllAvisoContingencia: TRLLabel
        Left = 296
        Top = 3
        Width = 164
        Height = 19
        Align = faCenter
        Alignment = taCenter
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
    end
    object rlmDadosAdicionaisAuxiliar: TRLMemo
      Left = 128
      Top = 56
      Width = 457
      Height = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      IntegralHeight = True
      ParentFont = False
      Visible = False
    end
    object rlbObsItem: TRLBand
      Left = 19
      Top = 810
      Width = 756
      Height = 20
      object LinhaFimObsItem: TRLDraw
        Left = 0
        Top = 14
        Width = 756
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaInicioItem: TRLDraw
        Left = 0
        Top = 19
        Width = 756
        Height = 1
        Align = faBottom
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlmObsItem: TRLMemo
        Left = 1
        Top = 1
        Width = 664
        Height = 8
        Borders.Style = bsClear
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object LinhaObsItemEsquerda: TRLDraw
        Left = 0
        Top = 0
        Width = 1
        Height = 14
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaObsItemDireita: TRLDraw
        Left = 755
        Top = 0
        Width = 1
        Height = 14
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    ShowProgress = False
    Left = 531
    Top = 42
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 560
    Top = 42
    object cdsItensCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 60
    end
    object cdsItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 120
    end
    object cdsItensNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object cdsItensCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object cdsItensUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 6
    end
    object cdsItensQTDE: TStringField
      FieldName = 'QTDE'
      Size = 18
    end
    object cdsItensVALOR: TStringField
      FieldName = 'VALOR'
      Size = 18
    end
    object cdsItensTOTAL: TStringField
      FieldName = 'TOTAL'
      Size = 18
    end
    object cdsItensCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsItensBICMS: TStringField
      FieldName = 'BICMS'
      Size = 18
    end
    object cdsItensALIQICMS: TStringField
      FieldName = 'ALIQICMS'
      Size = 6
    end
    object cdsItensVALORICMS: TStringField
      FieldName = 'VALORICMS'
      Size = 18
    end
    object cdsItensALIQIPI: TStringField
      FieldName = 'ALIQIPI'
      Size = 6
    end
    object cdsItensVALORIPI: TStringField
      FieldName = 'VALORIPI'
      Size = 18
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsItens
    Left = 587
    Top = 41
  end
end
