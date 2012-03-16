object Form1: TForm1
  Left = 373
  Top = 244
  Width = 766
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
  DesignSize = (
    750
    450)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 208
    Width = 750
    Height = 192
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    OnChange = Memo1Change
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 750
    Height = 208
    ActivePage = tsOperacao
    Align = alTop
    TabOrder = 2
    object tsConfig: TTabSheet
      Caption = 'Configura'#231#227'o'
      object gbConfigECF: TGroupBox
        Left = 0
        Top = 0
        Width = 308
        Height = 180
        Align = alLeft
        Caption = 'ECF'
        TabOrder = 0
        object Label2: TLabel
          Left = 10
          Top = 25
          Width = 38
          Height = 13
          Caption = 'Modelo:'
          Color = clBtnFace
          ParentColor = False
        end
        object Label4: TLabel
          Left = 10
          Top = 68
          Width = 25
          Height = 13
          Caption = 'Porta'
          Color = clBtnFace
          ParentColor = False
        end
        object btSerial: TSpeedButton
          Left = 146
          Top = 83
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
          Top = 25
          Width = 86
          Height = 13
          Caption = 'Indice "CARTAO"'
          Color = clBtnFace
          ParentColor = False
        end
        object Label7: TLabel
          Left = 186
          Top = 68
          Width = 87
          Height = 13
          Caption = 'Indice "CHEQUE"'
          Color = clBtnFace
          ParentColor = False
        end
        object cbxModelo: TComboBox
          Left = 10
          Top = 41
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
          Top = 84
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
          Top = 120
          Width = 73
          Height = 25
          Caption = 'Ativar'
          TabOrder = 2
          OnClick = bAtivarClick
        end
        object edFPGCartao: TEdit
          Left = 210
          Top = 41
          Width = 43
          Height = 21
          TabOrder = 3
          Text = '02'
        end
        object edFPGCheque: TEdit
          Left = 210
          Top = 84
          Width = 43
          Height = 21
          TabOrder = 4
          Text = '03'
        end
        object bFPG: TButton
          Left = 194
          Top = 120
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
        Width = 434
        Height = 180
        Align = alClient
        TabOrder = 1
        object gbConfigTEF: TGroupBox
          Left = 1
          Top = 1
          Width = 432
          Height = 178
          Align = alClient
          Caption = 'TEF'
          TabOrder = 0
          object Label1: TLabel
            Left = 34
            Top = 24
            Width = 83
            Height = 13
            Caption = 'Selecionar o G.P.'
            Color = clBtnFace
            ParentColor = False
          end
          object Label8: TLabel
            Left = 309
            Top = 23
            Width = 60
            Height = 13
            Caption = 'EsperaSleep'
            Color = clBtnFace
            ParentColor = False
          end
          object Label9: TLabel
            Left = 309
            Top = 79
            Width = 54
            Height = 13
            Caption = 'EsperaSTS'
            Color = clBtnFace
            ParentColor = False
          end
          object bInicializar: TButton
            Left = 45
            Top = 79
            Width = 75
            Height = 25
            Caption = 'Inicializar'
            TabOrder = 1
            OnClick = bInicializarClick
          end
          object ckAutoAtivar: TCheckBox
            Left = 161
            Top = 34
            Width = 104
            Height = 19
            Caption = 'Auto Ativar G.P.'
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnClick = ckAutoAtivarChange
          end
          object cbxGP: TComboBox
            Left = 13
            Top = 44
            Width = 133
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 0
            OnChange = cbxGPChange
          end
          object bAtivarGP: TButton
            Left = 45
            Top = 111
            Width = 75
            Height = 25
            Caption = 'Ativar GP'
            TabOrder = 2
            OnClick = bAtivarGPClick
          end
          object ckMultiplosCartoes: TCheckBox
            Left = 161
            Top = 62
            Width = 113
            Height = 19
            Caption = 'Multiplos Cart'#245'es'
            TabOrder = 4
            OnClick = ckMultiplosCartoesChange
          end
          object ckAutoFinalizarCupom: TCheckBox
            Left = 161
            Top = 113
            Width = 129
            Height = 19
            Caption = 'AutoFinalizarCupom'
            Checked = True
            State = cbChecked
            TabOrder = 6
            OnClick = ckAutoFinalizarCupomChange
          end
          object ckAutoEfetuarPagamento: TCheckBox
            Left = 161
            Top = 88
            Width = 144
            Height = 19
            Caption = 'AutoEfetuarPagamento'
            TabOrder = 5
            OnClick = ckAutoEfetuarPagamentoChange
          end
          object edEsperaSleep: TEdit
            Left = 309
            Top = 39
            Width = 56
            Height = 21
            TabOrder = 7
            Text = '250'
            OnChange = edEsperaSleepChange
          end
          object edEsperaSTS: TEdit
            Left = 309
            Top = 95
            Width = 56
            Height = 21
            TabOrder = 8
            Text = '7'
            OnChange = edEsperaSTSChange
          end
        end
      end
    end
    object tsOperacao: TTabSheet
      Caption = 'Opera'#231#227'o'
      object gbCupomECF: TGroupBox
        Left = 0
        Top = 0
        Width = 292
        Height = 180
        Align = alLeft
        Caption = 'ECF'
        Enabled = False
        TabOrder = 0
        object Label5: TLabel
          Left = 258
          Top = 53
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
          TabOrder = 8
          OnClick = bCancelarClick
        end
        object bAbreCupom: TButton
          Left = 6
          Top = 16
          Width = 93
          Height = 25
          Caption = 'Abrir'
          TabOrder = 3
          OnClick = bAbreCupomClick
        end
        object bVendeItem: TButton
          Left = 108
          Top = 16
          Width = 93
          Height = 25
          Caption = 'Vende Item'
          TabOrder = 4
          OnClick = bVendeItemClick
        end
        object bSubTotaliza: TButton
          Left = 6
          Top = 48
          Width = 93
          Height = 25
          Caption = 'SubTotalizar'
          TabOrder = 5
          OnClick = bSubTotalizaClick
        end
        object bFechar: TButton
          Left = 6
          Top = 80
          Width = 93
          Height = 25
          Caption = 'Fechar'
          TabOrder = 7
          OnClick = bFecharClick
        end
        object bPagamento: TButton
          Left = 108
          Top = 48
          Width = 93
          Height = 25
          Caption = 'Pagamento'
          TabOrder = 6
          OnClick = bPagamentoClick
        end
        object bAbreVendeSubTotaliza: TButton
          Left = 6
          Top = 110
          Width = 195
          Height = 27
          Caption = 'AbreVendeSubtotaliza'
          TabOrder = 2
          OnClick = bAbreVendeSubTotalizaClick
        end
        object edValorECF: TEdit
          Left = 210
          Top = 69
          Width = 72
          Height = 25
          AutoSize = False
          TabOrder = 1
          Text = '1,00'
        end
        object bEstado: TButton
          Left = 210
          Top = 16
          Width = 72
          Height = 25
          Caption = 'Estado'
          TabOrder = 0
          OnClick = bEstadoClick
        end
        object bReducaoZ: TButton
          Left = 210
          Top = 144
          Width = 72
          Height = 27
          Caption = 'Redu'#231#227'o Z'
          TabOrder = 11
          OnClick = bReducaoZClick
        end
        object bLeituraX: TButton
          Left = 210
          Top = 110
          Width = 72
          Height = 27
          Caption = 'Leitura X'
          TabOrder = 10
          OnClick = bLeituraXClick
        end
        object bFechaRelatorio: TButton
          Left = 6
          Top = 144
          Width = 195
          Height = 27
          Caption = 'Fechar Gerencial/Vinculado'
          TabOrder = 9
          OnClick = bFechaRelatorioClick
        end
      end
      object gbComandosTEF: TGroupBox
        Left = 292
        Top = 0
        Width = 450
        Height = 180
        Align = alClient
        Caption = 'TEF'
        TabOrder = 1
        object Label3: TLabel
          Left = 10
          Top = 124
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'Valor'
          Color = clBtnFace
          ParentColor = False
        end
        object bADM: TButton
          Left = 6
          Top = 56
          Width = 68
          Height = 25
          Caption = 'ADM'
          TabOrder = 2
          OnClick = bADMClick
        end
        object bATV: TButton
          Left = 153
          Top = 16
          Width = 68
          Height = 25
          Caption = 'ATV'
          TabOrder = 1
          OnClick = bATVClick
        end
        object bCNC: TButton
          Left = 153
          Top = 95
          Width = 68
          Height = 25
          Caption = 'CNC'
          TabOrder = 7
          OnClick = bCNCClick
        end
        object bCNF: TButton
          Left = 79
          Top = 56
          Width = 68
          Height = 25
          Caption = 'CNF'
          TabOrder = 3
          OnClick = bCNFClick
        end
        object bNCN: TButton
          Left = 153
          Top = 56
          Width = 68
          Height = 25
          Caption = 'NCN'
          TabOrder = 4
          OnClick = bNCNClick
        end
        object bCRT: TButton
          Left = 6
          Top = 95
          Width = 68
          Height = 25
          Caption = 'CRT'
          TabOrder = 5
          OnClick = bCRTClick
        end
        object bCHQ: TButton
          Left = 79
          Top = 95
          Width = 68
          Height = 25
          Caption = 'CHQ'
          TabOrder = 6
          OnClick = bCHQClick
        end
        object edValorTEF: TEdit
          Left = 6
          Top = 144
          Width = 72
          Height = 25
          AutoSize = False
          TabOrder = 8
          Text = '1,00'
        end
        object ckMultiplosCartoes1: TCheckBox
          Left = 102
          Top = 144
          Width = 113
          Height = 19
          Caption = 'Multiplos Cart'#245'es'
          TabOrder = 9
          OnClick = ckMultiplosCartoesChange
        end
        object cbxGP1: TComboBox
          Left = 6
          Top = 18
          Width = 142
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cbxGPChange
        end
        object bAbreVendeSubTotaliza1: TButton
          Left = 230
          Top = 16
          Width = 187
          Height = 27
          Caption = 'CancelarTransacoesPendentes'
          TabOrder = 10
          OnClick = bAbreVendeSubTotaliza1Click
        end
        object bAbreVendeSubTotaliza2: TButton
          Left = 230
          Top = 44
          Width = 187
          Height = 27
          Caption = 'ConfirmarTransacoesPendentes'
          TabOrder = 11
          OnClick = bAbreVendeSubTotaliza2Click
        end
        object bAbreVendeSubTotaliza3: TButton
          Left = 230
          Top = 73
          Width = 187
          Height = 27
          Caption = 'ImprimirTransacoesPendentes'
          TabOrder = 12
          OnClick = bAbreVendeSubTotaliza3Click
        end
        object bAbreVendeSubTotaliza4: TButton
          Left = 230
          Top = 102
          Width = 187
          Height = 27
          Caption = 'FinalizarCupom'
          TabOrder = 13
          OnClick = bAbreVendeSubTotaliza4Click
        end
        object GroupBox1: TGroupBox
          Left = 232
          Top = 131
          Width = 185
          Height = 45
          Caption = 'TEF Dire'#231#227'o'
          TabOrder = 14
          object ComboBox1: TComboBox
            Left = 9
            Top = 17
            Width = 166
            Height = 21
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'Nenhuma Transa'#231#227'o'
            Items.Strings = (
              'Nenhuma Transa'#231#227'o'
              'Cart'#227'o de Cr'#233'dito'
              'Cart'#227'o de D'#233'bito'
              'Cart'#227'o Voucher'
              'Cart'#227'o Private Label'
              'Cheque'
              'Controle de Frota')
          end
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 427
    Width = 750
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
    Top = 400
    Width = 750
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
      Left = 32
      Top = 6
      Width = 50
      Height = 13
      Caption = 'lECFName'
      Color = clBtnFace
      ParentColor = False
    end
    object sTEFDial: TShape
      Left = 96
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sTEFDisc: TShape
      Left = 197
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sHiperTEF: TShape
      Left = 297
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sCliSiTef: TShape
      Left = 403
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sVSPague: TShape
      Left = 492
      Top = 6
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object sAuttar: TShape
      Left = 594
      Top = 5
      Width = 17
      Height = 16
      Brush.Color = clRed
      Shape = stCircle
    end
    object ckTEFDIAL: TCheckBox
      Left = 120
      Top = 5
      Width = 69
      Height = 19
      Caption = 'TEF_DIAL'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = ckTEFDIALChange
    end
    object ckTEFDISC: TCheckBox
      Left = 217
      Top = 5
      Width = 69
      Height = 19
      Caption = 'TEF_DISC'
      TabOrder = 1
      OnClick = ckTEFDISCChange
    end
    object ckHIPERTEF: TCheckBox
      Left = 317
      Top = 6
      Width = 76
      Height = 19
      Caption = 'HIPER_TEF'
      TabOrder = 2
      OnClick = ckHIPERTEFChange
    end
    object ckCliSiTef: TCheckBox
      Left = 426
      Top = 5
      Width = 60
      Height = 19
      Caption = 'CliSiTef'
      TabOrder = 3
      OnClick = ckCliSiTefChange
    end
    object bCancelarResp: TButton
      Left = 680
      Top = 3
      Width = 75
      Height = 23
      Caption = 'CancelarResp'
      TabOrder = 4
      Visible = False
      OnClick = bCancelarRespClick
    end
    object ckVSPague: TCheckBox
      Left = 516
      Top = 5
      Width = 72
      Height = 19
      Caption = 'VeSPague'
      TabOrder = 5
      OnClick = ckVSPagueChange
    end
    object ckAuttar: TCheckBox
      Left = 618
      Top = 5
      Width = 53
      Height = 20
      Caption = 'Auttar'
      TabOrder = 6
      OnClick = ckAuttarChange
    end
  end
  object pMensagem: TPanel
    Left = 182
    Top = 240
    Width = 440
    Height = 136
    Anchors = []
    BevelInner = bvLowered
    BevelWidth = 2
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnResize = pMensagemResize
    object pMensagemOperador: TPanel
      Left = 4
      Top = 4
      Width = 428
      Height = 62
      Align = alClient
      TabOrder = 0
      Visible = False
      OnClick = pMensagemOperadorClick
      object Label10: TLabel
        Left = 0
        Top = 0
        Width = 99
        Height = 13
        Caption = 'Mensagem Operador'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lMensagemOperador: TLabel
        Left = 1
        Top = 1
        Width = 426
        Height = 60
        Align = alClient
        Alignment = taCenter
        Caption = 'lMensagemOperador'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
        WordWrap = True
        OnClick = pMensagemOperadorClick
      end
    end
    object pMensagemCliente: TPanel
      Left = 4
      Top = 66
      Width = 428
      Height = 62
      Align = alBottom
      TabOrder = 1
      Visible = False
      OnClick = pMensagemOperadorClick
      object Label11: TLabel
        Left = 0
        Top = 0
        Width = 87
        Height = 13
        Caption = 'Mensagem Cliente'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lMensagemCliente: TLabel
        Left = 1
        Top = 1
        Width = 426
        Height = 60
        Align = alClient
        Alignment = taCenter
        Caption = 'lMensagemCliente'
        Color = clBtnFace
        ParentColor = False
        Layout = tlCenter
        WordWrap = True
        OnClick = pMensagemOperadorClick
      end
    end
  end
  object ACBrECF1: TACBrECF
    Modelo = ecfBematech
    Porta = 'COM1'
    ReTentar = False
    TimeOut = 6
    IntervaloAposComando = 0
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    ExibeMensagem = False
    TempoInicioMsg = 6
    BloqueiaMouseTeclado = False
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    MaxLinhasBuffer = 3
    PaginaDeCodigo = 850
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
    ConfigBarras.MostrarCodigo = True
    ConfigBarras.LarguraLinha = 3
    ConfigBarras.Altura = 10
    Left = 16
    Top = 296
  end
  object ACBrTEFD1: TACBrTEFD
    EsperaSTS = 7
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
    TEFCliSiTef.ArqLOG = 'CliSiTef.log'
    TEFCliSiTef.EnderecoIP = 'localhost'
    TEFCliSiTef.CodigoLoja = '00000000'
    TEFCliSiTef.NumeroTerminal = 'SE000001'
    TEFCliSiTef.OnExibeMenu = ACBrTEFD1CliSiTefExibeMenu
    TEFCliSiTef.OnObtemCampo = ACBrTEFD1CliSiTefObtemCampo
    TEFVeSPague.ArqLOG = 'VeSPague.log'
    TEFVeSPague.Aplicacao = 'ACBr_TEFDDemo'
    TEFVeSPague.AplicacaoVersao = '1.0'
    TEFVeSPague.EnderecoIP = 'localhost'
    TEFVeSPague.Porta = '60906'
    TEFVeSPague.TemPendencias = False
    TEFVeSPague.TransacaoADM = 'Administracao Consultar'
    TEFVeSPague.TransacaoCRT = 'Cartao Vender'
    TEFVeSPague.TransacaoCHQ = 'Cheque Consultar'
    TEFVeSPague.TransacaoCNC = 'Administracao Cancelar'
    TEFVeSPague.TransacaoReImpressao = 'Administracao Reimprimir'
    TEFVeSPague.TransacaoPendente = 'Administracao Pendente'
    TEFVeSPague.OnExibeMenu = ACBrTEFD1VeSPagueExibeMenu
    TEFVeSPague.OnObtemCampo = ACBrTEFD1VeSPagueObtemCampo
    TEFGPU.ArqTemp = 'C:\TEF_GPU\req\intpos.tmp'
    TEFGPU.ArqReq = 'C:\TEF_GPU\req\intpos.001'
    TEFGPU.ArqSTS = 'C:\TEF_GPU\resp\intpos.sts'
    TEFGPU.ArqResp = 'C:\TEF_GPU\resp\intpos.001'
    TEFGPU.GPExeName = 'C:\TEF_GPU\GPU.exe'
    TEFBanese.ArqTemp = 'C:\bcard\req\pergunta.tmp'
    TEFBanese.ArqReq = 'C:\bcard\req\pergunta.txt'
    TEFBanese.ArqSTS = 'C:\bcard\resp\status.txt'
    TEFBanese.ArqResp = 'C:\bcard\resp\resposta.txt'
    TEFBanese.ArqRespBkp = 'C:\bcard\resposta.txt'
    TEFBanese.ArqRespMovBkp = 'C:\bcard\copiamovimento.txt'
    TEFBanese.OnObtemInformacao = ACBrTEFD1BaneseObtemInformacao
    TEFAuttar.ArqTemp = 'C:\Auttar_TefIP\req\intpos.tmp'
    TEFAuttar.ArqReq = 'C:\Auttar_TefIP\req\intpos.001'
    TEFAuttar.ArqSTS = 'C:\Auttar_TefIP\resp\intpos.sts'
    TEFAuttar.ArqResp = 'C:\Auttar_TefIP\resp\intpos.001'
    TEFAuttar.GPExeName = 'C:\Program Files (x86)\Auttar\IntegradorTEF-IP.exe'
    TEFGood.ArqTemp = 'C:\good\gettemp.dat'
    TEFGood.ArqReq = 'C:\good\getreq.dat'
    TEFGood.ArqSTS = 'C:\good\getstat.dat'
    TEFGood.ArqResp = 'C:\good\getresp.dat'
    TEFGood.GPExeName = 'C:\good\GETGoodMed.exe'
    TEFFoxWin.ArqTemp = 'C:\FwTEF\req\intpos.tmp'
    TEFFoxWin.ArqReq = 'C:\FwTEF\req\intpos.001'
    TEFFoxWin.ArqSTS = 'C:\FwTEF\rsp\intpos.sts'
    TEFFoxWin.ArqResp = 'C:\FwTEF\rsp\intpos.001'
    TEFFoxWin.GPExeName = 'C:\FwTEF\bin\FwTEF.exe'
    TEFPetrocard.ArqTemp = 'C:\CardTech\req\intpos.tmp'
    TEFPetrocard.ArqReq = 'C:\CardTech\req\intpos.001'
    TEFPetrocard.ArqSTS = 'C:\CardTech\resp\intpos.sts'
    TEFPetrocard.ArqResp = 'C:\CardTech\resp\intpos.001'
    TEFPetrocard.GPExeName = 'C:\CardTech\sac.exe'
    TEFCrediShop.ArqTemp = 'C:\tef_cshp\req\intpos.tmp'
    TEFCrediShop.ArqReq = 'C:\tef_cshp\req\intpos.001'
    TEFCrediShop.ArqSTS = 'C:\tef_cshp\resp\intpos.sts'
    TEFCrediShop.ArqResp = 'C:\tef_cshp\resp\intpos.001'
    TEFCrediShop.GPExeName = 'C:\tef_cshp\vpos_tef.exe'
    TEFTicketCar.ArqTemp = 'C:\TCS\TX\INTTCS.tmp'
    TEFTicketCar.ArqReq = 'C:\TCS\TX\INTTCS.001'
    TEFTicketCar.ArqSTS = 'C:\TCS\RX\INTTCS.RET'
    TEFTicketCar.ArqResp = 'C:\TCS\RX\INTTCS.001'
    TEFTicketCar.GPExeName = 'C:\TCS\tcs.exe'
    TEFTicketCar.NumLoja = 0
    TEFTicketCar.NumCaixa = 0
    TEFTicketCar.AtualizaPrecos = False
    OnAguardaResp = ACBrTEFD1AguardaResp
    OnExibeMsg = ACBrTEFD1ExibeMsg
    OnBloqueiaMouseTeclado = ACBrTEFD1BloqueiaMouseTeclado
    OnRestauraFocoAplicacao = ACBrTEFD1RestauraFocoAplicacao
    OnComandaECF = ACBrTEFD1ComandaECF
    OnComandaECFPagamento = ACBrTEFD1ComandaECFPagamento
    OnComandaECFAbreVinculado = ACBrTEFD1ComandaECFAbreVinculado
    OnComandaECFImprimeVia = ACBrTEFD1ComandaECFImprimeVia
    OnInfoECF = ACBrTEFD1InfoECF
    OnAntesFinalizarRequisicao = ACBrTEFD1AntesFinalizarRequisicao
    OnDepoisConfirmarTransacoes = ACBrTEFD1DepoisConfirmarTransacoes
    OnAntesCancelarTransacao = ACBrTEFD1AntesCancelarTransacao
    OnMudaEstadoReq = ACBrTEFD1MudaEstadoReq
    OnMudaEstadoResp = ACBrTEFD1MudaEstadoResp
    Left = 48
    Top = 296
  end
end
