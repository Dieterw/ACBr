object Form1: TForm1
  Left = 354
  Top = 105
  Width = 710
  Height = 488
  Caption = 'TEFDDemo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    694
    452)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 176
    Width = 694
    Height = 226
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    OnChange = Memo1Change
  end
  object pMensagem: TPanel
    Left = 177
    Top = 240
    Width = 318
    Height = 100
    Anchors = []
    BevelInner = bvLowered
    BevelWidth = 2
    BorderStyle = bsSingle
    Caption = 'Mensagem TEF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 694
    Height = 176
    ActivePage = tsConfig
    Align = alTop
    TabOrder = 2
    object tsConfig: TTabSheet
      Caption = 'Configura'#231#227'o'
      object gbConfigECF: TGroupBox
        Left = 0
        Top = 0
        Width = 308
        Height = 148
        Align = alLeft
        Caption = 'ECF'
        TabOrder = 0
        object Label2: TLabel
          Left = 10
          Top = 17
          Width = 38
          Height = 13
          Caption = 'Modelo:'
          Color = clBtnFace
          ParentColor = False
        end
        object Label4: TLabel
          Left = 10
          Top = 60
          Width = 25
          Height = 13
          Caption = 'Porta'
          Color = clBtnFace
          ParentColor = False
        end
        object btSerial: TSpeedButton
          Left = 146
          Top = 75
          Width = 25
          Height = 24
          Hint = 'Serial'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF323232
            3232323E3E3E565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF503200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            565656565656FFFFFFFFFFFF3232322626262626262626262626265032005032
            000000504873FFFFFFFFFFFFFFFFFFFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFF6E
            6E6E32323232323232323232323250320000005025AAFFFFFFFFFFFFFF565656
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5656563232323232326E6E6E5032005032
            008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFF50320050320056
            56564A4A4A5050003232325032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
            FFFFFF5656563E3E3E2626265032006262625656565050003232325032005032
            008FFF6B8ED4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5050005050006E
            6E6E5656565050003250005032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686865656565656563250005032005032
            008FFF6B48B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3232323E
            3E3EA4A0A08686866E6E6E565656503200C0C0C02557FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF5050004A4A4A3232323232323232323232325032
            00FFFFFF6B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          OnClick = btSerialClick
        end
        object Label6: TLabel
          Left = 186
          Top = 17
          Width = 86
          Height = 13
          Caption = 'Indice "CARTAO"'
          Color = clBtnFace
          ParentColor = False
        end
        object Label7: TLabel
          Left = 186
          Top = 60
          Width = 87
          Height = 13
          Caption = 'Indice "CHEQUE"'
          Color = clBtnFace
          ParentColor = False
        end
        object cbxModelo: TComboBox
          Left = 10
          Top = 33
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Procurar'
          OnChange = cbxModeloChange
          Items.Strings = (
            'Procurar'
            'ecfNaoFiscal'
            'ecfBematech'
            'ecfSweda'
            'ecfDaruma'
            'ecfSchalter'
            'ecfMecaf'
            'ecfYanco'
            'ecfDataRegis'
            'ecfUrano'
            'ecfICash'
            'ecfQuattro')
        end
        object cbxPorta: TComboBox
          Left = 10
          Top = 76
          Width = 131
          Height = 21
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = 'Procurar'
          OnChange = cbxPortaChange
          Items.Strings = (
            'Procurar'
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6'
            'LPT1'
            'LPT2'
            'LPT3'
            '/dev/ttyS0'
            '/dev/ttyS1'
            '/dev/ttyUSB0'
            '/dev/ttyUSB1'
            'c:\temp\ecf.txt'
            '/tmp/ecf.txt')
        end
        object bAtivar: TButton
          Left = 58
          Top = 112
          Width = 73
          Height = 25
          Caption = 'Ativar'
          TabOrder = 2
          OnClick = bAtivarClick
        end
        object edFPGCartao: TEdit
          Left = 210
          Top = 33
          Width = 43
          Height = 21
          TabOrder = 3
          Text = '02'
        end
        object edFPGCheque: TEdit
          Left = 210
          Top = 76
          Width = 43
          Height = 21
          TabOrder = 4
          Text = '03'
        end
        object bFPG: TButton
          Left = 194
          Top = 112
          Width = 73
          Height = 25
          Caption = 'FPG'
          TabOrder = 5
          OnClick = bFPGClick
        end
      end
      object Panel2: TPanel
        Left = 308
        Top = 0
        Width = 378
        Height = 148
        Align = alClient
        TabOrder = 1
        object gbConfigTEF: TGroupBox
          Left = 1
          Top = 1
          Width = 376
          Height = 146
          Align = alClient
          Caption = 'TEF'
          TabOrder = 0
          object Label1: TLabel
            Left = 26
            Top = 0
            Width = 83
            Height = 13
            Caption = 'Selecionar o G.P.'
            Color = clBtnFace
            ParentColor = False
          end
          object bInicializar: TButton
            Left = 37
            Top = 71
            Width = 75
            Height = 25
            Caption = 'Inicializar'
            TabOrder = 1
            OnClick = bInicializarClick
          end
          object ckAutoAtivar: TCheckBox
            Left = 153
            Top = 26
            Width = 104
            Height = 19
            Caption = 'Auto Ativar G.P.'
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnClick = ckAutoAtivarChange
          end
          object cbxGP: TComboBox
            Left = 5
            Top = 36
            Width = 133
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
          end
          object bAtivarGP: TButton
            Left = 37
            Top = 103
            Width = 75
            Height = 25
            Caption = 'Ativar GP'
            TabOrder = 2
            OnClick = bAtivarGPClick
          end
          object ckMultiplosCartoes: TCheckBox
            Left = 153
            Top = 54
            Width = 113
            Height = 19
            Caption = 'Multiplos Cart'#245'es'
            TabOrder = 4
            OnClick = ckMultiplosCartoesChange
          end
          object ckAutoFinalizarCupom: TCheckBox
            Left = 153
            Top = 105
            Width = 129
            Height = 19
            Caption = 'AutoFinalizarCupom'
            Checked = True
            State = cbChecked
            TabOrder = 6
            OnClick = ckAutoFinalizarCupomChange
          end
          object ckAutoEfetuarPagamento: TCheckBox
            Left = 153
            Top = 80
            Width = 144
            Height = 19
            Caption = 'AutoEfetuarPagamento'
            TabOrder = 5
            OnClick = ckAutoEfetuarPagamentoChange
          end
        end
      end
    end
    object tsOperacao: TTabSheet
      Caption = 'Opera'#231#227'o'
      object gbCupomECF: TGroupBox
        Left = 0
        Top = 0
        Width = 396
        Height = 148
        Align = alLeft
        Caption = 'ECF'
        Enabled = False
        TabOrder = 0
        object Label5: TLabel
          Left = 258
          Top = 96
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'Valor'
          Color = clBtnFace
          ParentColor = False
        end
        object bCancelar: TButton
          Left = 108
          Top = 80
          Width = 93
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 5
          OnClick = bCancelarClick
        end
        object bAbreCupom: TButton
          Left = 6
          Top = 16
          Width = 93
          Height = 25
          Caption = 'Abrir'
          TabOrder = 0
          OnClick = bAbreCupomClick
        end
        object bVendeItem: TButton
          Left = 108
          Top = 16
          Width = 93
          Height = 25
          Caption = 'Vende Item'
          TabOrder = 1
          OnClick = bVendeItemClick
        end
        object bSubTotaliza: TButton
          Left = 6
          Top = 48
          Width = 93
          Height = 25
          Caption = 'SubTotalizar'
          TabOrder = 2
          OnClick = bSubTotalizaClick
        end
        object bFechar: TButton
          Left = 6
          Top = 80
          Width = 93
          Height = 25
          Caption = 'Fechar'
          TabOrder = 4
          OnClick = bFecharClick
        end
        object bPagamento: TButton
          Left = 108
          Top = 48
          Width = 93
          Height = 25
          Caption = 'Pagamento'
          TabOrder = 3
          OnClick = bPagamentoClick
        end
        object bAbreVendeSubTotaliza: TButton
          Left = 6
          Top = 111
          Width = 195
          Height = 27
          Caption = 'AbreVendeSubtotaliza'
          TabOrder = 6
          OnClick = bAbreVendeSubTotalizaClick
        end
        object GroupBox1: TGroupBox
          Left = 292
          Top = 15
          Width = 102
          Height = 131
          Align = alRight
          Caption = 'Relat'#243'rios'
          TabOrder = 7
          object bFechaRelatorio: TButton
            Left = 8
            Top = 92
            Width = 82
            Height = 27
            Caption = 'Fechar'
            TabOrder = 0
            OnClick = bFechaRelatorioClick
          end
          object bLeituraX: TButton
            Left = 8
            Top = 56
            Width = 82
            Height = 27
            Caption = 'Leitura X'
            TabOrder = 1
            OnClick = bLeituraXClick
          end
          object bReducaoZ: TButton
            Left = 8
            Top = 22
            Width = 82
            Height = 27
            Caption = 'Redu'#231#227'o Z'
            TabOrder = 2
            OnClick = bReducaoZClick
          end
        end
        object edValorECF: TEdit
          Left = 210
          Top = 112
          Width = 72
          Height = 25
          AutoSize = False
          TabOrder = 8
          Text = '1,00'
        end
        object bEstado: TButton
          Left = 210
          Top = 16
          Width = 72
          Height = 25
          Caption = 'Estado'
          TabOrder = 9
          OnClick = bEstadoClick
        end
      end
      object gbComandosTEF: TGroupBox
        Left = 396
        Top = 0
        Width = 290
        Height = 148
        Align = alClient
        Caption = 'TEF'
        TabOrder = 1
        object Label3: TLabel
          Left = 178
          Top = 96
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'Valor'
          Color = clBtnFace
          ParentColor = False
        end
        object bADM: TButton
          Left = 126
          Top = 24
          Width = 75
          Height = 25
          Caption = 'ADM'
          TabOrder = 1
          OnClick = bADMClick
        end
        object bATV: TButton
          Left = 27
          Top = 56
          Width = 75
          Height = 25
          Caption = 'ATV'
          TabOrder = 0
          OnClick = bATVClick
        end
        object bCNC: TButton
          Left = 126
          Top = 56
          Width = 75
          Height = 25
          Caption = 'CNC'
          TabOrder = 2
          OnClick = bCNCClick
        end
        object bCNF: TButton
          Left = 206
          Top = 24
          Width = 75
          Height = 25
          Caption = 'CNF'
          TabOrder = 3
          OnClick = bCNFClick
        end
        object bNCN: TButton
          Left = 206
          Top = 56
          Width = 75
          Height = 25
          Caption = 'NCN'
          TabOrder = 4
          OnClick = bNCNClick
        end
        object bCRT: TButton
          Left = 6
          Top = 116
          Width = 75
          Height = 25
          Caption = 'CRT'
          TabOrder = 5
          OnClick = bCRTClick
        end
        object bCHQ: TButton
          Left = 89
          Top = 116
          Width = 75
          Height = 25
          Caption = 'CHQ'
          TabOrder = 6
          OnClick = bCHQClick
        end
        object edValorTEF: TEdit
          Left = 174
          Top = 116
          Width = 104
          Height = 25
          AutoSize = False
          TabOrder = 7
          Text = '1,00'
        end
        object ckMultiplosCartoes1: TCheckBox
          Left = 30
          Top = 93
          Width = 113
          Height = 19
          Caption = 'Multiplos Cart'#245'es'
          TabOrder = 8
          OnClick = ckMultiplosCartoesChange
        end
        object cbxGP1: TComboBox
          Left = 14
          Top = 25
          Width = 101
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 9
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 429
    Width = 694
    Height = 23
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 402
    Width = 694
    Height = 27
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 4
    object sECF: TShape
      Left = 8
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object lECFName: TLabel
      Left = 40
      Top = 6
      Width = 50
      Height = 13
      Caption = 'lECFName'
      Color = clBtnFace
      ParentColor = False
    end
    object sTEFDial: TShape
      Left = 136
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sTEFDisc: TShape
      Left = 248
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sHiperTEF: TShape
      Left = 360
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sCliSiTef: TShape
      Left = 488
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object ckTEFDIAL: TCheckBox
      Left = 160
      Top = 5
      Width = 87
      Height = 19
      Caption = 'TEF_DIAL'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = ckTEFDIALChange
    end
    object ckTEFDISC: TCheckBox
      Left = 272
      Top = 5
      Width = 86
      Height = 19
      Caption = 'TEF_DISC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = ckTEFDISCChange
    end
    object ckHIPERTEF: TCheckBox
      Left = 384
      Top = 5
      Width = 97
      Height = 19
      Caption = 'HIPER_TEF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = ckHIPERTEFChange
    end
    object ckCliSiTef: TCheckBox
      Left = 520
      Top = 5
      Width = 60
      Height = 19
      Caption = 'CliSiTef'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = ckCliSiTefChange
    end
  end
  object ACBrECF1: TACBrECF
    Modelo = ecfBematech
    Porta = 'COM1'
    ReTentar = False
    IntervaloAposComando = 0
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    BloqueiaMouseTeclado = False
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    MaxLinhasBuffer = 3
    FormMsgFonte.Charset = DEFAULT_CHARSET
    FormMsgFonte.Color = clBlack
    FormMsgFonte.Height = 11
    FormMsgFonte.Name = 'MS Shell Dlg'
    FormMsgFonte.Pitch = fpVariable
    FormMsgFonte.Style = []
    FormMsgColor = clHighlight
    MemoParams.Strings = (
      '[Cabecalho]'
      'LIN000=<center><b>Nome da Empresa</b></center>'
      'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>'
      'LIN002=<center>Cidade  -  UF  -  99999-999</center>'
      
        'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</c' +
        'enter>'
      
        'LIN004=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>COO: <b><code>NumCupom</code' +
        '></b></td></tr></table>'
      'LIN005=<hr>'
      ' '
      '[Cabecalho_Item]'
      'LIN000=ITEM   CODIGO     DESCRICAO'
      'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)'
      'LIN002=<hr>'
      
        'MascaraItem=III CCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDQQQQ' +
        'QQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT'
      ' '
      '[Rodape]'
      'LIN000=<hr>'
      
        'LIN001=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR<' +
        '/code></b></td></tr></table>'
      'LIN002=<center>Obrigado Volte Sempre</center>'
      'LIN003=<hr>'
      ' '
      '[Formato]'
      'Colunas=48'
      'HTML=1'
      'HTML_Title_Size=2'
      'HTML_Font=<font size="2" face="Lucida Console">')
    Device.HandShake = hsRTS_CTS
    Device.HardFlow = True
    Left = 16
    Top = 296
  end
  object ACBrTEFD1: TACBrTEFD
    EsperaSTS = 7
    EsperaSleep = 500
    TEFDial.ArqLOG = 'TEF_DIAL.log'
    TEFDial.Habilitado = True
    TEFDial.ArqTemp = 'C:\TEF_DIAL\req\intpos.tmp'
    TEFDial.ArqReq = 'C:\TEF_DIAL\req\intpos.001'
    TEFDial.ArqSTS = 'C:\TEF_DIAL\resp\intpos.sts'
    TEFDial.ArqResp = 'C:\TEF_DIAL\resp\intpos.001'
    TEFDial.GPExeName = 'C:\TEF_DIAL\tef_dial.exe'
    TEFDisc.ArqTemp = 'C:\TEF_Disc\req\intpos.tmp'
    TEFDisc.ArqReq = 'C:\TEF_Disc\req\intpos.001'
    TEFDisc.ArqSTS = 'C:\TEF_Disc\resp\intpos.sts'
    TEFDisc.ArqResp = 'C:\TEF_Disc\resp\intpos.001'
    TEFDisc.GPExeName = 'C:\TEF_Disc\tef_Disc.exe'
    TEFHiper.ArqTemp = 'c:\HiperTEF\req\IntPos.tmp'
    TEFHiper.ArqReq = 'C:\HiperTEF\req\IntPos.001'
    TEFHiper.ArqSTS = 'C:\HiperTEF\resp\IntPos.sts'
    TEFHiper.ArqResp = 'C:\HiperTEF\resp\IntPos.001'
    TEFHiper.GPExeName = 'C:\HiperTEF\HiperTEF.exe'
    OnAguardaResp = ACBrTEFD1AguardaResp
    OnExibeMsg = ACBrTEFD1ExibeMsg
    OnComandaECF = ACBrTEFD1ComandaECF
    OnComandaECFPagamento = ACBrTEFD1ComandaECFPagamento
    OnInfoECF = ACBrTEFD1InfoECF
    OnAntesFinalizarRequisicao = ACBrTEFD1AntesFinalizarRequisicao
    OnMudaEstadoReq = ACBrTEFD1MudaEstadoReq
    OnMudaEstadoResp = ACBrTEFD1MudaEstadoResp
    Left = 96
    Top = 296
  end
end
