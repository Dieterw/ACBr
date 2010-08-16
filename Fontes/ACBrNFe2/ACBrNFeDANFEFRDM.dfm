object dmACBrNFeFR: TdmACBrNFeFR
  OldCreateOrder = False
  Height = 341
  Width = 539
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Author = 'FastReport'
    Subject = 'Exportando DANFE para PDF'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 48
    Top = 92
  end
  object cdsIdentificacao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 36
  end
  object cdsEmitente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 92
  end
  object cdsDestinatario: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 148
  end
  object cdsDadosProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 204
  end
  object cdsParametros: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 260
  end
  object cdsInformacoesAdicionais: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 260
  end
  object cdsDuplicatas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 36
  end
  object cdsCalculoImposto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 92
  end
  object cdsTransportador: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 148
  end
  object cdsVeiculo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 204
  end
  object cdsVolumes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 260
  end
  object cdsISSQN: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 36
  end
  object cdsFatura: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 92
  end
  object cdsLocalRetirada: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 148
  end
  object cdsLocalEntrega: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 204
  end
  object frxIdentificacao: TfrxDBDataset
    UserName = 'Identificacao'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsIdentificacao
    BCDToCurrency = False
    Left = 172
    Top = 36
  end
  object frxEmitente: TfrxDBDataset
    UserName = 'Emitente'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsEmitente
    BCDToCurrency = False
    Left = 172
    Top = 92
  end
  object frxDestinatario: TfrxDBDataset
    UserName = 'Destinatario'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsDestinatario
    BCDToCurrency = False
    Left = 172
    Top = 148
  end
  object frxDadosProdutos: TfrxDBDataset
    UserName = 'DadosProdutos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsDadosProdutos
    BCDToCurrency = False
    Left = 172
    Top = 204
  end
  object frxParametros: TfrxDBDataset
    UserName = 'Parametros'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsParametros
    BCDToCurrency = False
    Left = 172
    Top = 260
  end
  object frxDuplicatas: TfrxDBDataset
    UserName = 'Duplicatas'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsDuplicatas
    BCDToCurrency = False
    Left = 304
    Top = 36
  end
  object frxCalculoImposto: TfrxDBDataset
    UserName = 'CalculoImposto'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsCalculoImposto
    BCDToCurrency = False
    Left = 304
    Top = 92
  end
  object frxTransportador: TfrxDBDataset
    UserName = 'Transportador'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsTransportador
    BCDToCurrency = False
    Left = 304
    Top = 148
  end
  object frxVeiculo: TfrxDBDataset
    UserName = 'Veiculo'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsVeiculo
    BCDToCurrency = False
    Left = 304
    Top = 204
  end
  object frxVolumes: TfrxDBDataset
    UserName = 'Volumes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsVolumes
    BCDToCurrency = False
    Left = 304
    Top = 260
  end
  object frxISSQN: TfrxDBDataset
    UserName = 'ISSQN'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsISSQN
    BCDToCurrency = False
    Left = 432
    Top = 36
  end
  object frxFatura: TfrxDBDataset
    UserName = 'Fatura'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsFatura
    BCDToCurrency = False
    Left = 432
    Top = 92
  end
  object frxLocalRetirada: TfrxDBDataset
    UserName = 'LocalRetirada'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsLocalRetirada
    BCDToCurrency = False
    Left = 432
    Top = 148
  end
  object frxLocalEntrega: TfrxDBDataset
    UserName = 'LocalEntrega'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsLocalEntrega
    BCDToCurrency = False
    Left = 432
    Top = 204
  end
  object frxInformacoesAdicionais: TfrxDBDataset
    UserName = 'InformacoesAdicionais'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsInformacoesAdicionais
    BCDToCurrency = False
    Left = 432
    Top = 260
  end
  object frxBarCodeObject: TfrxBarCodeObject
    Left = 48
    Top = 148
  end
  object frxReport: TfrxReport
    Version = '4.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40401.475989294000000000
    ReportOptions.LastChange = 40406.497712986110000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Footer1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  while Engine.FreeSpace > 10 do Engine.ShowBand(Child1);  '
      '  Engine.ShowBand(Child2);'
      'end;'
      ''
      'procedure Child3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Child3.Visible := (<Page> = 1) and (MasterData2.DataSet.Record' +
        'Count > 0);                                                     ' +
        '         '
      'end;'
      ''
      'procedure Header1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Header1.Visible := <Page> = 1;                                ' +
        '                              '
      'end;'
      ''
      'procedure Header2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  Header1.Visible := not Header2.Visible;                       ' +
        '                                       '
      'end;'
      ''
      'procedure ColumnHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ColumnHeader1.Visible := <Page> > 1;                          ' +
        '                    '
      'end;'
      ''
      'procedure ColumnFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  ColumnFooter1.Visible := Engine.FinalPass and (<Page> = 1);   ' +
        '                                                                ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 36
    Datasets = <
      item
        DataSet = frxCalculoImposto
        DataSetName = 'CalculoImposto'
      end
      item
        DataSet = frxDadosProdutos
        DataSetName = 'DadosProdutos'
      end
      item
        DataSet = frxDestinatario
        DataSetName = 'Destinatario'
      end
      item
        DataSet = frxDuplicatas
        DataSetName = 'Duplicatas'
      end
      item
        DataSet = frxEmitente
        DataSetName = 'Emitente'
      end
      item
        DataSet = frxFatura
        DataSetName = 'Fatura'
      end
      item
        DataSet = frxIdentificacao
        DataSetName = 'Identificacao'
      end
      item
        DataSet = frxInformacoesAdicionais
        DataSetName = 'InformacoesAdicionais'
      end
      item
        DataSet = frxISSQN
        DataSetName = 'ISSQN'
      end
      item
        DataSet = frxLocalEntrega
        DataSetName = 'LocalEntrega'
      end
      item
        DataSet = frxLocalRetirada
        DataSetName = 'LocalRetirada'
      end
      item
        DataSet = frxParametros
        DataSetName = 'Parametros'
      end
      item
        DataSet = frxTransportador
        DataSetName = 'Transportador'
      end
      item
        DataSet = frxVeiculo
        DataSetName = 'Veiculo'
      end
      item
        DataSet = frxVolumes
        DataSetName = 'Volumes'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object MasterData1: TfrxMasterData
        Height = 13.228346460000000000
        Top = 865.512370000000000000
        Width = 718.110700000000000000
        DataSet = frxDadosProdutos
        DataSetName = 'DadosProdutos'
        RowCount = 0
        Stretched = True
        object Memo131: TfrxMemoView
          Width = 64.252010000000000000
          Height = 13.228346456692900000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[DadosProdutos."CProd"]')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          Left = 64.252010000000000000
          Width = 177.637910000000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            '[DadosProdutos."XProd"]')
          ParentFont = False
        end
        object Memo133: TfrxMemoView
          Left = 241.889920000000000000
          Width = 37.795300000000000000
          Height = 13.228346456692900000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[DadosProdutos."NCM"]')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 279.685220000000000000
          Width = 18.897635350000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[DadosProdutos."CST"]0')
          ParentFont = False
        end
        object Memo135: TfrxMemoView
          Left = 298.582674720000000000
          Width = 24.566929130000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[DadosProdutos."CFOP"]')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 323.149603860000000000
          Width = 22.677180000000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."UCom"]')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 345.826769210000000000
          Width = 35.905514250000030000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."QCom"]')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          Left = 381.732530000000000000
          Width = 56.692950000000000000
          Height = 13.228346456692900000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."VUnTrib"]')
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          Left = 438.425480000000000000
          Width = 30.236240000000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."vDesc"]')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 468.661720000000000000
          Width = 56.692950000000000000
          Height = 13.228346456692900000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."VProd"]')
          ParentFont = False
        end
        object Memo141: TfrxMemoView
          Left = 525.354670000000000000
          Width = 56.692950000000000000
          Height = 13.228346456692900000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."VBC"]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          Left = 582.047620000000000000
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."VICMS"]')
          ParentFont = False
        end
        object Memo143: TfrxMemoView
          Left = 623.622450000000000000
          Width = 41.574829999999970000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."VIPI"]')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 665.197280000000000000
          Width = 26.456710000000020000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."PICMS"]')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 691.653990000000000000
          Width = 26.456710000000020000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[DadosProdutos."PIPI"]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          Width = 566.929500000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            
              'Recebemos de [Emitente."XNome"] os produtos e/ou servi'#195#167'os const' +
              'antes da Nota Fiscal Eletr'#195#180'nica indicada ao lado. Emiss'#195#163'o: [Id' +
              'entificacao."DEmi"]  Valor Total: R$ [CalculoImposto."VNF" #n%2,' +
              '2n]  Destinat'#195#161'rio: [Destinatario."Xnome"] - [Destinatario."XLgr' +
              '"], [Destinatario."Nro"] - [Destinatario."XBairro"] - [Destinata' +
              'rio."XMun"] - [Destinatario."UF"].')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 143.622140000000000000
          Top = 37.795300000000000000
          Width = 423.307360000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'IDENTIFICA'#195#8225#195#402'O E ASSINATURA DO RECEBEDOR')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 37.795300000000000000
          Width = 143.622140000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'DATA DO RECEBIMENTO')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 73.811070000000000000
          Width = 718.110700000000000000
          ShowHint = False
          Frame.Style = fsDash
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
        object Memo17: TfrxMemoView
          Left = 566.929500000000000000
          Width = 151.181102360000000000
          Height = 68.031540000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'NF-e')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 566.929500000000000000
          Top = 30.236240000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'N'#194#186' [Identificacao."NNF"]'
            'S'#195#169'rie [Identificacao."Serie" #n#000]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 173.858362910000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 396.850650000000000000
          Width = 321.260050000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 420.748300000000000000
          Top = 7.559060000000003000
          Width = 79.000000000000000000
          Height = 45.354360000000000000
          ShowHint = False
          BarType = bcCode128C
          Expression = '<Identificacao."ID">'
          Rotation = 0
          ShowText = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo5: TfrxMemoView
          Width = 264.567100000000000000
          Height = 120.944960000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'IDENTIFICA'#195#8225#195#402'O DO EMITENTE')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 396.850650000000000000
          Top = 60.472480000000000000
          Width = 321.260050000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'CHAVE DE ACESSO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 396.850650000000000000
          Top = 90.708720000000010000
          Width = 321.260050000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'Consulta de autenticidade no portal da NF-e'
            'www.nfe.fazenda.gov.br/portal ou no site da SEFAZ Autenticadora')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 396.850650000000000000
          Top = 71.811069999999960000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Identificacao."Chave"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 264.567100000000000000
          Width = 132.283464570000000000
          Height = 120.944960000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'DANFE')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 54.472480000000010000
          Width = 264.567100000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Emitente."XNome"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo11: TfrxMemoView
          Top = 84.370130000000000000
          Width = 264.567100000000000000
          Height = 35.905511811023600000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Emitente."XLgr"], [Emitente."Nro"]'
            '[Emitente."XBairro"] - [Emitente."CEP"]'
            
              '[Emitente."XMun"] - [Emitente."UF"] - Fone/Fax: [Emitente."Fone"' +
              ']')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 264.567100000000000000
          Top = 22.677180000000010000
          Width = 132.283550000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'Documento Auxiliar da '
            'Nota Fiscal Eletr'#195#180'nica')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 264.567100000000000000
          Top = 77.590599999999970000
          Width = 132.283550000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'N'#194#186' [Identificacao."NNF"]'
            'S'#195#169'rie [Identificacao."Serie" #n#000]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 264.567100000000000000
          Top = 106.606370000000000000
          Width = 132.283550000000000000
          Height = 13.228346460000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'Folha [Page]/[TotalPages]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 280.464750000000000000
          Top = 50.133889999999990000
          Width = 68.031540000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            '0 - ENTRADA'
            '1 - SA'#195#141'DA')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 359.055350000000000000
          Top = 51.133889999999990000
          Width = 18.897650000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Identificacao."TpNF"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Top = 120.944960000000000000
          Width = 396.850650000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'NATUREZA DA OPERA'#195#8225#195#402'O')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Top = 130.393700790000000000
          Width = 396.850650000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Identificacao."NatOp"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 396.850650000000000000
          Top = 120.944960000000000000
          Width = 321.260050000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            '[Parametros."Contingencia_Descricao"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 396.850650000000000000
          Top = 130.393700790000000000
          Width = 321.260050000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Parametros."Contingencia_Valor"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Top = 147.401670000000000000
          Width = 238.110390000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'INSCRI'#195#8225#195#402'O ESTADUAL')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 156.850410790000000000
          Width = 238.110390000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Emitente."IE"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 238.110390000000000000
          Top = 147.401670000000000000
          Width = 238.110390000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'INSCRI'#195#8225#195#402'O ESTADUAL DO SUBSTITUTO TRIBUT'#195#129'RIO')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 238.110390000000000000
          Top = 156.850410790000000000
          Width = 238.110390000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Emitente."IEST"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 476.220780000000000000
          Top = 147.401670000000000000
          Width = 241.889920000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'CNPJ')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 476.220780000000000000
          Top = 156.850410790000000000
          Width = 241.889920000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Emitente."CNPJ"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 13.228346460000000000
        Top = 1228.347250000000000000
        Width = 718.110700000000000000
        object Memo150: TfrxMemoView
          Width = 359.055350000000000000
          Height = 13.228346456692920000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            
              'DATA E HORA DA IMPRESS'#195#402'O: [Date #ddd/mm/yyyy] [Time #dhh:mm:ss]' +
              ' [Parametros."Usuario"]')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 359.055350000000000000
          Width = 359.055350000000000000
          Height = 13.228346456692920000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[Parametros."Sistema"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        Top = 903.307670000000000000
        Visible = False
        Width = 718.110700000000000000
        OnBeforePrint = 'Footer1OnBeforePrint'
        Child = frxReport.Child1
      end
      object Child1: TfrxChild
        Height = 3.779527560000000000
        Top = 925.984850000000000000
        Width = 718.110700000000000000
        object Memo161: TfrxMemoView
          Width = 64.252010000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo162: TfrxMemoView
          Left = 64.252010000000000000
          Width = 177.637910000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 241.889920000000000000
          Width = 37.795300000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo164: TfrxMemoView
          Left = 279.685220000000000000
          Width = 18.897635350000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo165: TfrxMemoView
          Left = 298.582674720000000000
          Width = 24.566929130000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 323.149603860000000000
          Width = 22.677180000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          HideZeros = True
          ParentFont = False
        end
        object Memo167: TfrxMemoView
          Left = 345.826769210000000000
          Width = 35.905514250000030000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo168: TfrxMemoView
          Left = 381.732530000000000000
          Width = 56.692950000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 438.425480000000000000
          Width = 30.236240000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          HideZeros = True
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 468.661720000000000000
          Width = 56.692950000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 525.354670000000000000
          Width = 56.692950000000000000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 582.047620000000000000
          Width = 41.574829999999970000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 623.622450000000000000
          Width = 41.574829999999970000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 665.197280000000000000
          Width = 26.456710000000020000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          Left = 691.653990000000000000
          Width = 26.456710000000020000
          Height = 3.779527559055118000
          ShowHint = False
          StretchMode = smActualHeight
          DisplayFormat.FormatStr = ',0.00##'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          HideZeros = True
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        Height = 35.795300000000000000
        Top = 536.693260000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child3OnBeforePrint'
        Stretched = True
        object Subreport1: TfrxSubreport
          Left = 0.779530000000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Page = frxReport.Page2
        end
        object Memo55: TfrxMemoView
          Top = 3.779530000000022000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'DUPLICATAS')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        Height = 96.267762910000000000
        Top = 415.748300000000000000
        Width = 718.110700000000000000
        Child = frxReport.Child3
        DataSet = frxIdentificacao
        DataSetName = 'Identificacao'
        RowCount = 0
        object Memo29: TfrxMemoView
          Top = 16.897650000000000000
          Width = 430.866420000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'NOME / RAZ'#195#402'O SOCIAL')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Top = 26.346390789999990000
          Width = 430.866420000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."XNome"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 593.386210000000000000
          Top = 16.897650000000000000
          Width = 124.724490000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'DATA DA EMISS'#195#402'O')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 593.386210000000000000
          Top = 26.346390789999990000
          Width = 124.724490000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Identificacao."DEmi"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 593.386210000000000000
          Top = 43.354359999999990000
          Width = 124.724490000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'DATA DA SA'#195#141'DA')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 593.386210000000000000
          Top = 52.803100789999970000
          Width = 124.724490000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Identificacao."DSaiEnt"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 593.386210000000000000
          Top = 69.811069999999970000
          Width = 124.724490000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'HORA DA SA'#195#141'DA')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 593.386210000000000000
          Top = 79.259810789999900000
          Width = 124.724490000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[Identificacao."HoraSaida"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 430.866420000000000000
          Top = 16.897650000000000000
          Width = 162.519790000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'CNPJ / CPF')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 430.866420000000000000
          Top = 26.346390789999990000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."CNPJCPF"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 517.795610000000000000
          Top = 43.354359999999990000
          Width = 75.590600000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'CEP')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 517.795610000000000000
          Top = 52.803100789999970000
          Width = 75.590600000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."CEP"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 347.716760000000000000
          Top = 43.354359999999990000
          Width = 170.078850000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'BAIRRO / DISTRITO')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 347.716760000000000000
          Top = 52.803100789999970000
          Width = 170.078850000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."XBairro"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Top = 43.354359999999990000
          Width = 347.716760000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'ENDERE'#195#8225'O')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Top = 52.803100789999970000
          Width = 347.716760000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            
              '[Destinatario."XLgr"], [Destinatario."Nro"]  [Destinatario."XCpl' +
              '"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Top = 69.811069999999970000
          Width = 317.480520000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'MUNIC'#195#141'PIO')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Top = 79.259810789999900000
          Width = 317.480520000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."XMun"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 317.480520000000000000
          Top = 69.811069999999970000
          Width = 30.236240000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'UF')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 317.480520000000000000
          Top = 79.259810789999900000
          Width = 30.236240000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."UF"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 347.716760000000000000
          Top = 69.811069999999970000
          Width = 113.385900000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'TELEFONE / FAX')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 347.716760000000000000
          Top = 79.259810789999900000
          Width = 113.385900000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."Fone"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 461.102660000000000000
          Top = 69.811069999999970000
          Width = 132.283550000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'INSCRI'#195#8225#195#402'O ESTADUAL')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 461.102660000000000000
          Top = 79.259810789999900000
          Width = 132.283550000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Destinatario."IE"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Top = 3.779530000000022000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'DESTINAT'#195#129'RIO / REMETENTE')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        Height = 162.519772910000000000
        Top = 597.165740000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Header1OnBeforePrint'
        object Memo58: TfrxMemoView
          Top = 2.779530000000022000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'C'#195#129'LCULO DO IMPOSTO')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Top = 15.118120000000090000
          Width = 143.622140000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'BASE DE C'#195#129'LCULO DO ICMS')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Top = 24.566860789999960000
          Width = 143.622140000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VBC"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 143.622140000000000000
          Top = 15.118120000000090000
          Width = 143.622140000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR DO ICMS')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 143.622140000000000000
          Top = 24.566860789999960000
          Width = 143.622140000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VICMS"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 287.244280000000000000
          Top = 15.118120000000090000
          Width = 143.622140000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'BASE DE C'#195#129'LCULO DO ICMS SUBSTIT')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 287.244280000000000000
          Top = 24.566860789999960000
          Width = 143.622140000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VBCST"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 430.866420000000000000
          Top = 15.118120000000090000
          Width = 143.622140000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR DO ICMS SUBST')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 430.866420000000000000
          Top = 24.566860789999960000
          Width = 143.622140000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VST"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 574.488560000000000000
          Top = 15.118120000000090000
          Width = 143.622140000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR TOTAL DOS PRODUTOS')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 574.488560000000000000
          Top = 24.566860789999960000
          Width = 143.622140000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VProd"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 459.590848000000000000
          Top = 41.574830000000020000
          Width = 114.897712000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR DO IPI')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 459.590848000000000000
          Top = 51.023570790000010000
          Width = 114.897712000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VIPI"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 344.693136000000000000
          Top = 41.574830000000020000
          Width = 114.897712000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'OUTRAS DESPESAS ACESS'#195#8220'RIAS')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 344.693136000000000000
          Top = 51.023570790000010000
          Width = 114.897712000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VOutro"]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 229.795424000000000000
          Top = 41.574830000000020000
          Width = 114.897712000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'DESCONTO')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 229.795424000000000000
          Top = 51.023570790000010000
          Width = 114.897712000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VDesc"]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 114.897712000000000000
          Top = 41.574830000000020000
          Width = 114.897712000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR DO SEGURO')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 114.897712000000000000
          Top = 51.023570790000010000
          Width = 114.897712000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VSeg"]')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Top = 41.574830000000020000
          Width = 114.897712000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR DO FRETE')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Top = 51.023570790000010000
          Width = 114.897712000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VFrete"]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 574.488560000000000000
          Top = 41.574830000000020000
          Width = 143.622140000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR TOTAL DA NOTA')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 574.488560000000000000
          Top = 51.023570790000010000
          Width = 143.622140000000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[CalculoImposto."VNF"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Top = 69.921259840000060000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'TRANSPORTADOR / VOLUMES TRANSPORTADOS')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 598.299212600000000000
          Top = 83.149660000000040000
          Width = 119.811023620000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'CNPJ / CPF')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 598.299212600000000000
          Top = 92.598400790000030000
          Width = 119.811023620000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."CNPJCPF"]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 566.929499999999900000
          Top = 83.149660000000040000
          Width = 31.370078740000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'UF')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 566.929499999999900000
          Top = 92.598400790000030000
          Width = 31.370078740000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Veiculo."UF"]')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 498.897960000000000000
          Top = 83.149660000000040000
          Width = 68.031540000000010000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'PLACA DO VE'#195#141'CULO')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 498.897960000000000000
          Top = 92.598400790000030000
          Width = 68.031540000000010000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Veiculo."PLACA"]')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 415.748300000000000000
          Top = 83.149660000000040000
          Width = 83.149660000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'C'#195#8220'DIGO ANTT')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 415.748300000000000000
          Top = 92.598400790000030000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Veiculo."RNTC"]')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 325.039580000000000000
          Top = 83.149660000000040000
          Width = 90.708720000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'FRETE POR CONTA')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 325.039580000000000000
          Top = 92.598400790000030000
          Width = 90.708720000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."ModFrete"]')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Top = 83.149660000000040000
          Width = 325.039580000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'NOME / RAZ'#195#402'O SOCIAL')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Top = 92.598400790000030000
          Width = 325.039580000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."XNome"]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 566.929499999999900000
          Top = 109.606370000000000000
          Width = 31.370078740000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'UF')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 566.929499999999900000
          Top = 119.055110790000100000
          Width = 31.370078740000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."UF"]')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 598.299212600000000000
          Top = 109.606370000000000000
          Width = 119.811023620000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'INSCRI'#195#8225#195#402'O ESTADUAL')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 598.299212600000000000
          Top = 119.055110790000100000
          Width = 119.811023620000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."IE"]')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 325.039580000000000000
          Top = 109.606370000000000000
          Width = 241.889920000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'MUNIC'#195#141'PIO')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 325.039580000000000000
          Top = 119.055110790000100000
          Width = 241.889920000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."XMun"]')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Top = 109.606370000000000000
          Width = 325.039580000000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'ENDERE'#195#8225'O')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Top = 119.055110790000100000
          Width = 325.039580000000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Transportador."XEnder"]')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Top = 136.063080000000000000
          Width = 51.653576670000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'QUANTIDADE')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Top = 145.511820790000000000
          Width = 51.653576670000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[Volumes."QVol"]')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 51.653576670000000000
          Top = 136.063080000000000000
          Width = 119.685116670000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'ESP'#195#8240'CIE')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 51.653576670000000000
          Top = 145.511820790000000000
          Width = 119.685116670000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Volumes."Esp"]')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 171.338693330000000000
          Top = 136.063080000000000000
          Width = 119.685116670000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'MARCA')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 171.338693330000000000
          Top = 145.511820790000000000
          Width = 119.685116670000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Volumes."Marca"]')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 291.023810000000000000
          Top = 136.063080000000000000
          Width = 187.716656670000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'NUMERA'#195#8225#195#402'O')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 291.023810000000000000
          Top = 145.511820790000000000
          Width = 187.716656670000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Volumes."NVol"]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 478.740466670000000000
          Top = 136.063080000000000000
          Width = 119.685116670000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'PESO BRUTO')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 478.740466670000000000
          Top = 145.511820790000000000
          Width = 119.685116670000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = ',0.00#'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[Volumes."PesoB"]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 598.425583330000000000
          Top = 136.063080000000000000
          Width = 119.685116670000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'PESO L'#195#141'QUIDO')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 598.425583330000000000
          Top = 145.511820790000000000
          Width = 119.685116670000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = ',0.00#'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[Volumes."PesoL"]')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        Height = 35.795282910000000000
        Top = 805.039890000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Header2OnBeforePrint'
        object Memo115: TfrxMemoView
          Top = 3.779530000000022000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'DADOS DOS PRODUTOS / SERVI'#195#8225'OS')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Top = 16.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'C'#195#8220'DIGO'
            'PRODUTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo117: TfrxMemoView
          Left = 64.252010000000000000
          Top = 16.897650000000000000
          Width = 177.637910000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'DESCRI'#195#8225#195#402'O DO PRODUTO / SERVI'#195#8225'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo118: TfrxMemoView
          Left = 241.889920000000000000
          Top = 16.897650000000000000
          Width = 37.795300000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'NCM/SH')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo119: TfrxMemoView
          Left = 279.685220000000000000
          Top = 16.897650000000000000
          Width = 18.897635349999980000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'CST')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo120: TfrxMemoView
          Left = 298.582674720000000000
          Top = 16.897650000000000000
          Width = 24.566929130000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'CFOP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo121: TfrxMemoView
          Left = 323.149603860000000000
          Top = 16.897650000000000000
          Width = 22.677180000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'UNID')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo122: TfrxMemoView
          Left = 345.826769210000000000
          Top = 16.897650000000000000
          Width = 35.905514250000030000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'QUANT')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo123: TfrxMemoView
          Left = 381.732530000000000000
          Top = 16.897650000000000000
          Width = 56.692950000000010000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'UNIT'#195#129'RIO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo124: TfrxMemoView
          Left = 438.425480000000000000
          Top = 16.897650000000000000
          Width = 30.236240000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'DESC %')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo125: TfrxMemoView
          Left = 468.661720000000000000
          Top = 16.897650000000000000
          Width = 56.692950000000010000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo126: TfrxMemoView
          Left = 525.354670000000100000
          Top = 16.897650000000000000
          Width = 56.692950000000010000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'BASE C'#195#129'LCULO'
            'ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo127: TfrxMemoView
          Left = 582.047620000000000000
          Top = 16.897650000000000000
          Width = 41.574830000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo128: TfrxMemoView
          Left = 623.622450000000000000
          Top = 16.897650000000000000
          Width = 41.574830000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo129: TfrxMemoView
          Left = 665.197280000000000000
          Top = 16.897650000000000000
          Width = 26.456710000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'AL'#195#141'Q'
            'ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo130: TfrxMemoView
          Left = 691.653990000000000000
          Top = 16.897650000000000000
          Width = 26.456710000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'AL'#195#141'Q'
            'IPI')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData4: TfrxMasterData
        Top = 782.362710000000000000
        Width = 718.110700000000000000
        RowCount = 1
      end
      object ColumnHeader1: TfrxColumnHeader
        Height = 35.795287800000000000
        Top = 317.480520000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ColumnHeader1OnBeforePrint'
        object Memo56: TfrxMemoView
          Top = 3.779529999999965000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'DADOS DOS PRODUTOS / SERVI'#195#8225'OS')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Top = 16.897650000000000000
          Width = 64.252010000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'C'#195#8220'DIGO'
            'PRODUTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo176: TfrxMemoView
          Left = 64.252010000000000000
          Top = 16.897650000000000000
          Width = 177.637910000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'DESCRI'#195#8225#195#402'O DO PRODUTO / SERVI'#195#8225'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo177: TfrxMemoView
          Left = 241.889920000000000000
          Top = 16.897650000000000000
          Width = 37.795300000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'NCM/SH')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo178: TfrxMemoView
          Left = 279.685220000000000000
          Top = 16.897650000000000000
          Width = 18.897635350000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'CST')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo179: TfrxMemoView
          Left = 298.582674720000000000
          Top = 16.897650000000000000
          Width = 24.566929130000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'CFOP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo180: TfrxMemoView
          Left = 323.149603860000000000
          Top = 16.897650000000000000
          Width = 22.677180000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'UNID')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo181: TfrxMemoView
          Left = 345.826769210000000000
          Top = 16.897650000000000000
          Width = 35.905514250000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'QUANT')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo182: TfrxMemoView
          Left = 381.732530000000000000
          Top = 16.897650000000000000
          Width = 56.692950000000010000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'UNIT'#195#129'RIO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo183: TfrxMemoView
          Left = 438.425480000000000000
          Top = 16.897650000000000000
          Width = 30.236240000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'DESC %')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo184: TfrxMemoView
          Left = 468.661720000000000000
          Top = 16.897650000000000000
          Width = 56.692950000000010000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo185: TfrxMemoView
          Left = 525.354670000000100000
          Top = 16.897650000000000000
          Width = 56.692950000000010000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'BASE C'#195#129'LCULO'
            'ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo186: TfrxMemoView
          Left = 582.047620000000000000
          Top = 16.897650000000000000
          Width = 41.574830000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo187: TfrxMemoView
          Left = 623.622450000000000000
          Top = 16.897650000000000000
          Width = 41.574830000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'VALOR'
            'IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo188: TfrxMemoView
          Left = 665.197280000000000000
          Top = 16.897650000000000000
          Width = 26.456710000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'AL'#195#141'Q'
            'ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo189: TfrxMemoView
          Left = 691.653990000000000000
          Top = 16.897650000000000000
          Width = 26.456710000000000000
          Height = 18.897632910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            'AL'#195#141'Q'
            'IPI')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Child2: TfrxChild
        Top = 952.441560000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          Width = 718.110700000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        Height = 190.756012910000000000
        Top = 1012.914040000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ColumnFooter1OnBeforePrint'
        object Memo152: TfrxMemoView
          Top = 3.779530000000022000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'C'#195#129'LCULO DO ISSQN')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Top = 16.897650000000000000
          Width = 179.527559060000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'INSCRI'#195#8225#195#402'O MUNICIPAL')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          Top = 26.346390790000100000
          Width = 179.527559060000000000
          Height = 17.007874020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            '[Emitente."IM"]')
          ParentFont = False
        end
        object Memo155: TfrxMemoView
          Left = 179.527559060000000000
          Top = 16.897650000000000000
          Width = 179.527559060000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR TOTAL DOS SERVI'#195#8225'OS')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          Left = 179.527559060000000000
          Top = 26.346390790000100000
          Width = 179.527559060000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[ISSQN."VServ"]')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 359.055118110000000000
          Top = 16.897650000000000000
          Width = 179.527559060000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'BASE DE C'#195#129'LCULO DO ISSQN')
          ParentFont = False
        end
        object Memo158: TfrxMemoView
          Left = 359.055118110000000000
          Top = 26.346390790000100000
          Width = 179.527559060000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[ISSQN."VBC"]')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 538.582677170000000000
          Top = 16.897650000000000000
          Width = 179.527559060000000000
          Height = 26.456692910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'VALOR TOTAL DO ISSQN')
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Left = 538.582677170000000000
          Top = 26.346390790000100000
          Width = 179.527559060000000000
          Height = 17.007874020000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[ISSQN."VISS"]')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 449.764070000000000000
          Top = 58.472480000000010000
          Width = 268.346456690000000000
          Height = 132.283532910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'RESERVADO AO FISCO')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Top = 45.354359999999930000
          Width = 430.866420000000000000
          Height = 13.228344020000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            'DADOS ADICIONAIS')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Top = 58.472480000000010000
          Width = 449.763779530000000000
          Height = 132.283532910000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            'INFORMA'#195#8225#195#8226'ES COMPLEMENTARES')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Top = 68.031540000000060000
          Width = 445.984540000000000000
          Height = 120.944960000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8 = (
            '[InformacoesAdicionais."OBS"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Width = 718.110700000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 0.500000000000000000
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        Height = 34.015770000000010000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Columns = 6
        ColumnWidth = 119.433070866141700000
        DataSet = frxDuplicatas
        DataSetName = 'Duplicatas'
        RowCount = 0
        object Memo81: TfrxMemoView
          Left = 45.354360000000000000
          Width = 74.078740157480310000
          Height = 34.015745590000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[Duplicatas."NDup"]'
            '[Duplicatas."DVenc"]'
            'R$ [Duplicatas."VDup" #n%2,2n]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Width = 45.354360000000000000
          Height = 34.015745590000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8 = (
            'N'#195#186'mero'
            'Vencto'
            'Valor')
          ParentFont = False
        end
      end
    end
  end
end
