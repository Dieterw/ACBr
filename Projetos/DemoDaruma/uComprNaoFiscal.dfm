inherited frmComprNaoFiscal: TfrmComprNaoFiscal
  Left = 327
  Top = 215
  Caption = 'Comprovante N'#227'o Fiscal'
  ClientHeight = 500
  ClientWidth = 790
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 790
    Height = 470
    object PageControl1: TPageControl
      Left = 1
      Top = 72
      Width = 344
      Height = 397
      ActivePage = TabSheet4
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = '1. Abertura'
        object btnAbrirComprovante: TButton
          Left = 17
          Top = 18
          Width = 125
          Height = 27
          Caption = 'Abrir comprovante'
          TabOrder = 0
          OnClick = btnAbrirComprovanteClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = '2. Itens'
        ImageIndex = 1
        object Label4: TLabel
          Left = 10
          Top = 10
          Width = 53
          Height = 13
          Caption = 'Totalizador'
        end
        object Label5: TLabel
          Left = 219
          Top = 10
          Width = 40
          Height = 13
          Caption = 'Valor R$'
        end
        object cbxTotalizador: TComboBox
          Left = 10
          Top = 26
          Width = 203
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
        end
        object edtItemVlr: TEdit
          Left = 219
          Top = 26
          Width = 100
          Height = 21
          TabOrder = 1
          Text = '0,00'
        end
        object btnItemRegistrar: TButton
          Left = 219
          Top = 63
          Width = 100
          Height = 27
          Caption = 'Registrar item'
          TabOrder = 2
          OnClick = btnItemRegistrarClick
        end
        object btnItemCancelar: TButton
          Left = 219
          Top = 96
          Width = 100
          Height = 27
          Caption = 'Cancelar item'
          TabOrder = 3
          OnClick = btnItemCancelarClick
        end
      end
      object TabSheet3: TTabSheet
        Caption = '3. Sub-Total'
        ImageIndex = 2
        object Label9: TLabel
          Left = 10
          Top = 12
          Width = 103
          Height = 13
          Caption = 'Desconto / Acr'#233'scimo'
        end
        object Label10: TLabel
          Left = 10
          Top = 55
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object Label20: TLabel
          Left = 129
          Top = 23
          Width = 128
          Height = 26
          Caption = 'Valor negativo = Desconto'#13#10'Valor positivo = Acr'#233'scimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtSubtotalDescAcrescVlr: TEdit
          Left = 10
          Top = 28
          Width = 103
          Height = 21
          TabOrder = 0
          Text = '0,00'
        end
        object btnSubtotalizar: TButton
          Left = 221
          Top = 98
          Width = 100
          Height = 27
          Caption = 'Subtotalizar'
          TabOrder = 2
          OnClick = btnSubtotalizarClick
        end
        object edtSubtotalObs: TEdit
          Left = 11
          Top = 71
          Width = 310
          Height = 21
          TabOrder = 1
        end
      end
      object TabSheet4: TTabSheet
        Caption = '4. Pagto.'
        ImageIndex = 3
        object Label13: TLabel
          Left = 12
          Top = 7
          Width = 79
          Height = 13
          Caption = 'Meio pagamento'
        end
        object Label14: TLabel
          Left = 212
          Top = 7
          Width = 40
          Height = 13
          Caption = 'Valor R$'
        end
        object Label15: TLabel
          Left = 12
          Top = 50
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object cbxMeioPagto: TComboBox
          Left = 12
          Top = 23
          Width = 194
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
        end
        object edtPagtoVlr: TEdit
          Left = 212
          Top = 23
          Width = 114
          Height = 21
          TabOrder = 1
          Text = '0,00'
        end
        object btnRegistrarPagto: TButton
          Left = 180
          Top = 93
          Width = 146
          Height = 27
          Caption = 'Registrar pagamento'
          TabOrder = 3
          OnClick = btnRegistrarPagtoClick
        end
        object edtPagtoObs: TEdit
          Left = 11
          Top = 66
          Width = 315
          Height = 21
          TabOrder = 2
        end
      end
      object TabSheet5: TTabSheet
        Caption = '5. Fecham.'
        ImageIndex = 4
        object Label16: TLabel
          Left = 10
          Top = 51
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object Label17: TLabel
          Left = 10
          Top = 8
          Width = 52
          Height = 13
          Caption = 'Indice BMP'
        end
        object cbxIndiceBMP: TComboBox
          Left = 10
          Top = 24
          Width = 52
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5')
        end
        object btnFechamento: TButton
          Left = 171
          Top = 148
          Width = 150
          Height = 27
          Caption = 'Fechar comprovante'
          TabOrder = 4
          OnClick = btnFechamentoClick
        end
        object edtFechamentoObs1: TEdit
          Left = 11
          Top = 67
          Width = 310
          Height = 21
          TabOrder = 1
          Text = '<e>ACBrECF</e>'
        end
        object edtFechamentoObs2: TEdit
          Left = 11
          Top = 94
          Width = 310
          Height = 21
          TabOrder = 2
          Text = '<n>Demonstra'#231#227'o ACBr com Daruma</n>'
        end
        object edtFechamentoObs3: TEdit
          Left = 11
          Top = 121
          Width = 310
          Height = 21
          TabOrder = 3
          Text = '<ean13>123456789012</ean13>'
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 788
      Height = 71
      Align = alTop
      Caption = 
        'Identifica'#231#227'o do Cliente (pode ser utilizado ao abrir o cupom ou' +
        ' no fechamento)'
      TabOrder = 0
      object Label1: TLabel
        Left = 152
        Top = 19
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label2: TLabel
        Left = 15
        Top = 19
        Width = 54
        Height = 13
        Caption = 'CPF / CNPJ'
      end
      object Label3: TLabel
        Left = 412
        Top = 19
        Width = 45
        Height = 13
        Caption = 'Endere'#231'o'
      end
      object edtClienteNome: TEdit
        Left = 152
        Top = 35
        Width = 254
        Height = 21
        TabOrder = 2
      end
      object edtClienteCpfCnpj: TEdit
        Left = 15
        Top = 35
        Width = 131
        Height = 21
        TabOrder = 1
      end
      object edtClienteEndereco: TEdit
        Left = 412
        Top = 35
        Width = 254
        Height = 21
        TabOrder = 3
      end
      object btnIdentificaCliente: TButton
        Left = 672
        Top = 32
        Width = 105
        Height = 27
        Caption = 'Identificar Cliente'
        TabOrder = 0
      end
    end
    object gbxBobina: TGroupBox
      Left = 345
      Top = 72
      Width = 444
      Height = 397
      Align = alRight
      Caption = 'Bobina'
      Enabled = False
      TabOrder = 2
      object GroupBox4: TGroupBox
        Left = 2
        Top = 331
        Width = 440
        Height = 64
        Align = alBottom
        Caption = 'TOTAIS'
        TabOrder = 0
        object Label8: TLabel
          Left = 12
          Top = 19
          Width = 55
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sub-Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 196
          Top = 19
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Valor pago'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 315
          Top = 19
          Width = 38
          Height = 13
          Alignment = taRightJustify
          Caption = 'TROCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSubtotal: TEdit
          Left = 12
          Top = 35
          Width = 113
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = 'edtSubtotal'
        end
        object edtValorPago: TEdit
          Left = 196
          Top = 35
          Width = 113
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = 'Edit1'
        end
        object edtValorTroco: TEdit
          Left = 315
          Top = 35
          Width = 113
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = 'Edit1'
        end
      end
      object WebBrowser1: TWebBrowser
        Left = 2
        Top = 15
        Width = 440
        Height = 316
        Align = alClient
        TabOrder = 1
        OnDocumentComplete = WebBrowser1DocumentComplete
        ControlData = {
          4C0000007A2D0000A92000000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 470
    Width = 790
    inherited btnExecutar: TButton
      Left = 580
      Visible = False
    end
    inherited btnCancelar: TButton
      Left = 686
    end
  end
end
