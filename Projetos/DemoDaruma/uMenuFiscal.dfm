inherited frmMenuFiscal: TfrmMenuFiscal
  Caption = 'Menu Fiscal'
  ClientHeight = 450
  ClientWidth = 467
  OnCreate = FormCreate
  ExplicitWidth = 473
  ExplicitHeight = 482
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 467
    Height = 415
    object grpMenuFiscalOpcoes: TGroupBox
      Left = 1
      Top = 1
      Width = 465
      Height = 329
      Align = alClient
      Caption = 'Op'#231#245'es do Menu fiscal'
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 0
      ExplicitHeight = 345
      object Label31: TLabel
        Left = 59
        Top = 280
        Width = 348
        Height = 26
        AutoSize = False
        Caption = 
          'Para a gera'#231#227'o de arquivos que n'#227'o dependem da impressora fiscal' +
          ' verifique o DemoPAF disponibilizado na pasta exemplos do ACBr'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object btnMenuFiscalLX: TButton
        Left = 59
        Top = 55
        Width = 171
        Height = 25
        Caption = 'LX'
        TabOrder = 0
        OnClick = btnMenuFiscalLXClick
      end
      object btnMenuFiscalLMFC: TButton
        Left = 59
        Top = 86
        Width = 171
        Height = 25
        Caption = 'LMFC'
        TabOrder = 2
        OnClick = btnMenuFiscalLMFCClick
      end
      object btnMenuFiscalLMFS: TButton
        Left = 59
        Top = 117
        Width = 171
        Height = 25
        Caption = 'LMFS'
        TabOrder = 4
        OnClick = btnMenuFiscalLMFSClick
      end
      object btnMenuFiscalMFDEspelho: TButton
        Left = 59
        Top = 148
        Width = 171
        Height = 25
        Caption = 'Espelho MFD'
        TabOrder = 6
        OnClick = btnMenuFiscalMFDEspelhoClick
      end
      object btnMenuFiscalMFDArq: TButton
        Left = 236
        Top = 55
        Width = 171
        Height = 25
        Caption = 'Arq. MFD'
        TabOrder = 1
        OnClick = btnMenuFiscalMFDArqClick
      end
      object btnMenuFiscalRelMeiosPagto: TButton
        Left = 236
        Top = 86
        Width = 171
        Height = 25
        Caption = 'Meios Pagto.'
        TabOrder = 3
        OnClick = btnMenuFiscalRelMeiosPagtoClick
      end
      object btnMenuFiscalRelDAVEmitidos: TButton
        Left = 236
        Top = 117
        Width = 171
        Height = 25
        Caption = 'DAV Emitidos'
        TabOrder = 5
        OnClick = btnMenuFiscalRelDAVEmitidosClick
      end
      object btnMenuFiscalRelIdentPAFECF: TButton
        Left = 236
        Top = 148
        Width = 171
        Height = 25
        Caption = 'Identifica'#231#227'o PAF-ECF'
        TabOrder = 7
        OnClick = btnMenuFiscalRelIdentPAFECFClick
      end
      object chkMenuFiscalGerarArquivo: TCheckBox
        Left = 64
        Top = 194
        Width = 162
        Height = 17
        Caption = 'Efetuar a gera'#231#227'o de arquivo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object chkMenuFiscalCotepe1704: TCheckBox
        Left = 81
        Top = 217
        Width = 290
        Height = 37
        Caption = 
          'Gerar o arquivo no formato do ato Cotepe 17/04 (Somente para os ' +
          'menus: LMFC, Arq.MFD)'
        TabOrder = 9
        WordWrap = True
      end
    end
    object pgcMenuFiscalTipo: TPageControl
      Left = 1
      Top = 330
      Width = 465
      Height = 84
      ActivePage = tbsMenuFiscalTipoData
      Align = alBottom
      TabOrder = 1
      object tbsMenuFiscalTipoData: TTabSheet
        Caption = 'Por data'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label24: TLabel
          Left = 15
          Top = 20
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'de :'
        end
        object Label25: TLabel
          Left = 142
          Top = 20
          Width = 16
          Height = 13
          Caption = 'at'#233
        end
        object edtDtInicial: TDateTimePicker
          Left = 40
          Top = 15
          Width = 96
          Height = 21
          Date = 40620.448168067130000000
          Time = 40620.448168067130000000
          TabOrder = 0
        end
        object edtDtFinal: TDateTimePicker
          Left = 163
          Top = 15
          Width = 96
          Height = 21
          Date = 40620.448168067130000000
          Time = 40620.448168067130000000
          TabOrder = 1
        end
      end
      object tbsMenuFiscalTipoCOO: TTabSheet
        Caption = 'Por n'#250'mero'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 23
        ExplicitWidth = 318
        ExplicitHeight = 40
        object Label26: TLabel
          Left = 15
          Top = 20
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Caption = 'de :'
        end
        object Label30: TLabel
          Left = 142
          Top = 20
          Width = 16
          Height = 13
          Caption = 'at'#233
        end
        object edtNumInicial: TSpinEdit
          Left = 40
          Top = 15
          Width = 96
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 1
        end
        object edtNumFinal: TSpinEdit
          Left = 163
          Top = 15
          Width = 96
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 1
        end
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 415
    Width = 467
    inherited btnExecutar: TButton
      Left = 257
    end
    inherited btnCancelar: TButton
      Left = 363
    end
  end
  object dlgDialogoSalvar: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'Arquivos texto|*.txt'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Salvar arquivo texto'
    Left = 380
    Top = 205
  end
end
