object Form1: TForm1
  Left = 441
  Top = 170
  Width = 604
  Height = 358
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 136
    Width = 588
    Height = 184
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 588
    Height = 136
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Configura'#231#227'o'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 180
        Height = 108
        Align = alLeft
        Caption = 'WebService'
        TabOrder = 0
        object Label9: TLabel
          Left = 12
          Top = 55
          Width = 35
          Height = 13
          Caption = 'Chave:'
          Color = clBtnFace
          ParentColor = False
        end
        object cbxWS: TComboBox
          Left = 12
          Top = 22
          Width = 156
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 0
          Text = 'BuscarCEP'
          OnChange = cbxWSChange
          Items.Strings = (
            'Nenhum'
            'BuscarCEP'
            'CEPLivre')
        end
        object edChaveBuscarCEP: TEdit
          Left = 12
          Top = 70
          Width = 156
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBox1: TGroupBox
        Left = 180
        Top = 0
        Width = 400
        Height = 108
        Align = alClient
        Caption = 'Proxy'
        TabOrder = 1
        object Label2: TLabel
          Left = 22
          Top = 17
          Width = 22
          Height = 13
          Caption = 'Host'
          Color = clBtnFace
          ParentColor = False
        end
        object Label3: TLabel
          Left = 191
          Top = 17
          Width = 26
          Height = 13
          Caption = 'Porta'
          Color = clBtnFace
          ParentColor = False
        end
        object Label4: TLabel
          Left = 22
          Top = 58
          Width = 40
          Height = 13
          Caption = 'Usu'#225#161'rio'
          Color = clBtnFace
          ParentColor = False
        end
        object Label5: TLabel
          Left = 142
          Top = 58
          Width = 30
          Height = 13
          Caption = 'Senha'
          Color = clBtnFace
          ParentColor = False
        end
        object edProxyHost: TEdit
          Left = 22
          Top = 33
          Width = 154
          Height = 21
          TabOrder = 0
        end
        object edProxyPort: TEdit
          Left = 191
          Top = 33
          Width = 56
          Height = 21
          TabOrder = 1
        end
        object edProxyUser: TEdit
          Left = 22
          Top = 73
          Width = 105
          Height = 21
          TabOrder = 2
        end
        object edProxyPass: TEdit
          Left = 142
          Top = 73
          Width = 105
          Height = 21
          TabOrder = 3
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Buscar'
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 164
        Height = 108
        Align = alLeft
        Caption = 'Por CEP'
        TabOrder = 0
        object edCEP: TEdit
          Left = 18
          Top = 33
          Width = 112
          Height = 21
          TabOrder = 0
          Text = '18270-170'
        end
        object bBuscarCEP: TButton
          Left = 18
          Top = 66
          Width = 112
          Height = 33
          Caption = 'Buscar'
          TabOrder = 1
          OnClick = bBuscarCEPClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 164
        Top = 0
        Width = 416
        Height = 108
        Align = alClient
        Caption = 'Por Endere'#231'o'
        TabOrder = 1
        object Label1: TLabel
          Left = 70
          Top = 17
          Width = 59
          Height = 13
          Caption = 'Logradouro:'
          Color = clBtnFace
          ParentColor = False
        end
        object Label6: TLabel
          Left = 14
          Top = 60
          Width = 37
          Height = 13
          Caption = 'Cidade:'
          Color = clBtnFace
          ParentColor = False
        end
        object Label7: TLabel
          Left = 159
          Top = 60
          Width = 17
          Height = 13
          Caption = 'UF:'
          Color = clBtnFace
          ParentColor = False
        end
        object Label8: TLabel
          Left = 198
          Top = 60
          Width = 78
          Height = 13
          Caption = 'Bairro (opcional)'
          Color = clBtnFace
          ParentColor = False
        end
        object Label10: TLabel
          Left = 14
          Top = 17
          Width = 24
          Height = 13
          Caption = 'Tipo:'
          Color = clBtnFace
          ParentColor = False
        end
        object edLogradouro: TEdit
          Left = 70
          Top = 33
          Width = 264
          Height = 21
          TabOrder = 1
          Text = 'Coronel Aureliano'
        end
        object bBuscarLogradouro: TButton
          Left = 347
          Top = 24
          Width = 56
          Height = 72
          Caption = 'Buscar'
          TabOrder = 5
          OnClick = bBuscarLogradouroClick
        end
        object edCidade: TEdit
          Left = 14
          Top = 76
          Width = 136
          Height = 21
          TabOrder = 2
          Text = 'Tatu'#237
        end
        object edUF: TEdit
          Left = 159
          Top = 76
          Width = 25
          Height = 21
          TabOrder = 3
          Text = 'SP'
        end
        object edBairro: TEdit
          Left = 198
          Top = 77
          Width = 136
          Height = 21
          TabOrder = 4
        end
        object edTipo_Logradouro: TEdit
          Left = 14
          Top = 33
          Width = 48
          Height = 21
          TabOrder = 0
          Text = 'Rua'
        end
      end
    end
  end
  object ACBrCEP1: TACBrCEP
    ProxyPort = '8080'
    WebService = wsBuscarCep
    OnBuscaEfetuada = ACBrCEP1BuscaEfetuada
    OnAntesEfetuarBusca = ACBrCEP1AntesEfetuarBusca
    Left = 248
    Top = 160
  end
end
