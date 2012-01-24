inherited frmCupomFiscal: TfrmCupomFiscal
  Left = 361
  Top = 181
  Caption = 'Cupom Fiscal'
  ClientHeight = 520
  ClientWidth = 790
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Top = 71
    Width = 790
    Height = 400
    TabOrder = 1
    object pgcInfo: TPageControl
      Left = 1
      Top = 1
      Width = 344
      Height = 398
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = '1. Abertura'
        object btnAbrirCupom: TButton
          Left = 10
          Top = 23
          Width = 139
          Height = 27
          Caption = 'Abrir cupom fiscal'
          TabOrder = 0
          OnClick = btnAbrirCupomClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = '2. Itens'
        ImageIndex = 1
        object Bevel1: TBevel
          Left = 5
          Top = 322
          Width = 321
          Height = 8
          Shape = bsTopLine
        end
        object btnItemRegistrar: TButton
          Left = 97
          Top = 241
          Width = 150
          Height = 27
          Caption = 'Registrar item'
          TabOrder = 2
          OnClick = btnItemRegistrarClick
        end
        object GroupBox3: TGroupBox
          Left = 0
          Top = 161
          Width = 336
          Height = 70
          Align = alTop
          Caption = 'Desconto / Acr'#233'scimo'
          TabOrder = 1
          object Label25: TLabel
            Left = 112
            Top = 20
            Width = 20
            Height = 13
            Caption = 'Tipo'
          end
          object Label26: TLabel
            Left = 18
            Top = 20
            Width = 32
            Height = 13
            Caption = 'Aplicar'
          end
          object Label27: TLabel
            Left = 209
            Top = 20
            Width = 24
            Height = 13
            Caption = 'Valor'
          end
          object edtItemDescAcresTipo: TComboBox
            Left = 112
            Top = 36
            Width = 91
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 1
            Text = 'Percentual'
            Items.Strings = (
              'Percentual'
              'Valor')
          end
          object edtItemDescAcreModo: TComboBox
            Left = 18
            Top = 36
            Width = 88
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = 'Desconto'
            Items.Strings = (
              'Desconto'
              'Acr'#233'scimo')
          end
          object edtItemDescAcreValor: TEdit
            Left = 209
            Top = 36
            Width = 102
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 2
            Text = 'EDIT1'
          end
        end
        object btnItemCancelarParcial: TButton
          Left = 6
          Top = 336
          Width = 126
          Height = 27
          Caption = 'Cancelar item parcial'
          TabOrder = 4
          TabStop = False
          OnClick = btnItemCancelarParcialClick
        end
        object btnItemCancelarTotal: TButton
          Left = 200
          Top = 336
          Width = 126
          Height = 27
          Caption = 'Cancelar item total'
          TabOrder = 5
          TabStop = False
          OnClick = btnItemCancelarTotalClick
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 336
          Height = 161
          Align = alTop
          Caption = 'Item'
          TabOrder = 0
          object Label6: TLabel
            Left = 18
            Top = 24
            Width = 33
            Height = 13
            Caption = 'C'#243'digo'
          end
          object Label7: TLabel
            Left = 18
            Top = 67
            Width = 46
            Height = 13
            Caption = 'Descri'#231#227'o'
          end
          object Label21: TLabel
            Left = 260
            Top = 110
            Width = 39
            Height = 13
            Caption = 'Al'#237'quota'
          end
          object Label22: TLabel
            Left = 70
            Top = 110
            Width = 56
            Height = 13
            Caption = 'Quantidade'
          end
          object Label23: TLabel
            Left = 161
            Top = 110
            Width = 53
            Height = 13
            Caption = 'Vlr.Unit'#225'rio'
          end
          object Label24: TLabel
            Left = 18
            Top = 110
            Width = 39
            Height = 13
            Caption = 'Unidade'
          end
          object ckbLegendaInmetro: TCheckBox
            Left = 155
            Top = 42
            Width = 147
            Height = 17
            Caption = 'Utilizar legenda INMETRO'
            TabOrder = 1
          end
          object edtItemCodigo: TEdit
            Left = 18
            Top = 40
            Width = 131
            Height = 21
            CharCase = ecUpperCase
            MaxLength = 13
            TabOrder = 0
            Text = 'EDTITEMCODIGO'
          end
          object edtItemDescricao: TEdit
            Left = 18
            Top = 83
            Width = 293
            Height = 21
            CharCase = ecUpperCase
            MaxLength = 100
            TabOrder = 2
            Text = 'EDIT1'
          end
          object edtItemQuantidade: TEdit
            Left = 70
            Top = 126
            Width = 85
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 4
            Text = 'EDIT1'
          end
          object edtItemVlUnitario: TEdit
            Left = 161
            Top = 126
            Width = 93
            Height = 21
            CharCase = ecUpperCase
            TabOrder = 5
            Text = 'EDIT1'
          end
          object edtItemUnidade: TEdit
            Left = 18
            Top = 126
            Width = 46
            Height = 21
            CharCase = ecUpperCase
            MaxLength = 3
            TabOrder = 3
            Text = 'EDIT1'
          end
          object edtItemAliquota: TComboBox
            Left = 260
            Top = 126
            Width = 51
            Height = 21
            Style = csDropDownList
            TabOrder = 6
            Items.Strings = (
              'FF'
              'II'
              'NN'
              '07T'
              '12T'
              '18T'
              '25T'
              'FS'
              'IS'
              'NS'
              '02S'
              'F1'
              'F2'
              'I1'
              'I2'
              'N1'
              'N2'
              'FS1'
              'IS1'
              'NS1'
              'FS2'
              'IS2'
              'NS2')
          end
        end
        object btnItemDescAcrescAnterior: TButton
          Left = 97
          Top = 274
          Width = 150
          Height = 27
          Caption = 'Desc./Acresc. Item Anterior'
          TabOrder = 3
          OnClick = btnItemDescAcrescAnteriorClick
        end
      end
      object TabSheet3: TTabSheet
        Caption = '3. SubTotal'
        ImageIndex = 2
        object Label9: TLabel
          Left = 23
          Top = 9
          Width = 103
          Height = 13
          Caption = 'Desconto / Acr'#233'scimo'
        end
        object Label10: TLabel
          Left = 23
          Top = 52
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object Label20: TLabel
          Left = 142
          Top = 20
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
          Left = 23
          Top = 25
          Width = 103
          Height = 21
          TabOrder = 0
          Text = '0,00'
        end
        object btnSubtotalizar: TButton
          Left = 154
          Top = 95
          Width = 150
          Height = 27
          Caption = 'Subtotalizar'
          TabOrder = 2
          OnClick = btnSubtotalizarClick
        end
        object edtSubtotalObs: TEdit
          Left = 23
          Top = 68
          Width = 281
          Height = 21
          TabOrder = 1
        end
      end
      object TabSheet4: TTabSheet
        Caption = '4. Pagto.'
        ImageIndex = 3
        object Label13: TLabel
          Left = 23
          Top = 9
          Width = 79
          Height = 13
          Caption = 'Meio pagamento'
        end
        object Label14: TLabel
          Left = 198
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Valor R$'
        end
        object Label15: TLabel
          Left = 23
          Top = 52
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object cbxMeioPagto: TComboBox
          Left = 23
          Top = 25
          Width = 169
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object edtPagtoVlr: TEdit
          Left = 198
          Top = 25
          Width = 118
          Height = 21
          TabOrder = 1
          Text = '0,00'
        end
        object btnRegistrarPagto: TButton
          Left = 166
          Top = 95
          Width = 150
          Height = 27
          Caption = 'Registrar pagamento'
          TabOrder = 3
          OnClick = btnRegistrarPagtoClick
        end
        object edtPagtoObs: TEdit
          Left = 23
          Top = 68
          Width = 293
          Height = 21
          TabOrder = 2
        end
      end
      object TabSheet5: TTabSheet
        Caption = '5. Fecham.'
        ImageIndex = 4
        object Label16: TLabel
          Left = 25
          Top = 52
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object Label17: TLabel
          Left = 25
          Top = 9
          Width = 52
          Height = 13
          Caption = 'Indice BMP'
        end
        object Label4: TLabel
          Left = 25
          Top = 187
          Width = 166
          Height = 13
          Caption = 'Informa'#231#245'es adicionais do Paf-ECF'
        end
        object Label5: TLabel
          Left = 81
          Top = 211
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Caption = 'MD5 :'
        end
        object Label11: TLabel
          Left = 82
          Top = 238
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'DAV :'
        end
        object Label12: TLabel
          Left = 64
          Top = 265
          Width = 45
          Height = 13
          Alignment = taRightJustify
          Caption = 'DAV-OS :'
        end
        object Label28: TLabel
          Left = 52
          Top = 292
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Pr'#233'-Venda :'
        end
        object edtFechamentoObs1: TEdit
          Left = 25
          Top = 68
          Width = 291
          Height = 21
          TabOrder = 1
          Text = '<e>ACBrECF</e>'
        end
        object cbxIndiceBMP: TComboBox
          Left = 25
          Top = 25
          Width = 52
          Height = 21
          Style = csDropDownList
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
          Left = 166
          Top = 149
          Width = 150
          Height = 27
          Caption = 'Fechar comprovante'
          TabOrder = 4
          OnClick = btnFechamentoClick
        end
        object edtFechamentoObs2: TEdit
          Left = 25
          Top = 95
          Width = 291
          Height = 21
          TabOrder = 2
          Text = '<n>Demonstra'#231#227'o ACBr com Daruma</n>'
        end
        object edtFechamentoObs3: TEdit
          Left = 25
          Top = 122
          Width = 291
          Height = 21
          TabOrder = 3
          Text = '<ean13>123456789012</ean13>'
        end
        object edtMD5App: TEdit
          Left = 115
          Top = 208
          Width = 201
          Height = 21
          TabOrder = 5
        end
        object edtIdDAV: TEdit
          Left = 115
          Top = 235
          Width = 201
          Height = 21
          TabOrder = 6
        end
        object edtIdDAVOS: TEdit
          Left = 115
          Top = 262
          Width = 201
          Height = 21
          TabOrder = 7
        end
        object edtIdPrevenda: TEdit
          Left = 115
          Top = 289
          Width = 201
          Height = 21
          TabOrder = 8
        end
        object ckbMinasLegal: TCheckBox
          Left = 115
          Top = 343
          Width = 97
          Height = 17
          Caption = 'Minas Legal'
          TabOrder = 10
        end
        object ckbCupomMania: TCheckBox
          Left = 115
          Top = 320
          Width = 97
          Height = 17
          Caption = 'Cupom Mania'
          TabOrder = 9
        end
      end
    end
    object gbxBobina: TGroupBox
      Left = 345
      Top = 1
      Width = 444
      Height = 398
      Align = alRight
      Caption = 'Bobina'
      Enabled = False
      TabOrder = 1
      object WebBrowser1: TWebBrowser
        Left = 2
        Top = 15
        Width = 440
        Height = 317
        Align = alClient
        TabOrder = 0
        OnDocumentComplete = WebBrowser1DocumentComplete
        ControlData = {
          4C0000007A2D0000C32000000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object GroupBox4: TGroupBox
        Left = 2
        Top = 332
        Width = 440
        Height = 64
        Align = alBottom
        Caption = 'TOTAIS'
        TabOrder = 1
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
    end
  end
  inherited pnlRodape: TPanel
    Top = 471
    Width = 790
    TabOrder = 2
    inherited btnExecutar: TButton
      Left = 589
      Visible = False
    end
    inherited btnCancelar: TButton
      Left = 689
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 790
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
      TabOrder = 1
    end
    object edtClienteCpfCnpj: TEdit
      Left = 15
      Top = 35
      Width = 131
      Height = 21
      TabOrder = 0
    end
    object edtClienteEndereco: TEdit
      Left = 412
      Top = 35
      Width = 254
      Height = 21
      TabOrder = 2
    end
    object btnIdentificaCliente: TButton
      Left = 672
      Top = 32
      Width = 105
      Height = 27
      Caption = 'Identificar Cliente'
      TabOrder = 3
      OnClick = btnIdentificaClienteClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 501
    Width = 790
    Height = 19
    Panels = <>
  end
end
