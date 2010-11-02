object FrmSPEDFiscal: TFrmSPEDFiscal
  Left = 356
  Top = 153
  Caption = 'ACBrSpedFiscal - Demo'
  ClientHeight = 508
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    670
    508)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 128
    Width = 65
    Height = 13
    Caption = 'Lista de erros'
    Color = clBtnFace
    ParentColor = False
  end
  object Label3: TLabel
    Left = 8
    Top = 232
    Width = 75
    Height = 13
    Caption = 'Arquivo Gerado'
    Color = clBtnFace
    ParentColor = False
  end
  object Label7: TLabel
    Left = 24
    Top = 464
    Width = 63
    Height = 13
    Caption = 'Buffer Linhas'
    Color = clBtnFace
    ParentColor = False
  end
  object Label8: TLabel
    Left = 128
    Top = 464
    Width = 61
    Height = 13
    Caption = 'Buffer Notas'
    Color = clBtnFace
    ParentColor = False
  end
  object memoError: TMemo
    Left = 8
    Top = 145
    Width = 637
    Height = 83
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object memoTXT: TMemo
    Left = 8
    Top = 248
    Width = 637
    Height = 208
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    WantReturns = False
    WordWrap = False
  end
  object btnError: TButton
    Left = 395
    Top = 478
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gerar TXT Error'
    TabOrder = 2
    OnClick = btnErrorClick
  end
  object btnTXT: TButton
    Left = 521
    Top = 478
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gerar TXT'
    TabOrder = 3
    OnClick = btnTXTClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 58
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 4
    DesignSize = (
      666
      54)
    object Label1: TLabel
      Left = 22
      Top = 14
      Width = 82
      Height = 13
      Caption = 'Nome do Arquivo'
      Color = clBtnFace
      ParentColor = False
    end
    object Label5: TLabel
      Left = 0
      Top = 0
      Width = 666
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = '1 - Informe o Nome do Arquivo e m'#233'todo de Gera'#231#227'o'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 341
    end
    object Label6: TLabel
      Left = 526
      Top = 14
      Width = 71
      Height = 13
      Caption = 'Num.Notas (C)'
      Color = clBtnFace
      ParentColor = False
    end
    object edtFile: TEdit
      Left = 22
      Top = 28
      Width = 296
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'ACBrSpedFiscal.txt'
      OnChange = edtFileChange
    end
    object cbConcomitante: TCheckBox
      Left = 342
      Top = 30
      Width = 134
      Height = 19
      Hint = 
        'Grava os Registros a medida que s'#227'o alimentados'#13#10'Economizando me' +
        'm'#243'ria. '#13#10#218'til para evitar erros em arquivos Enormes'
      Anchors = [akTop, akRight]
      Caption = 'Gerar Concomitante'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = cbConcomitanteClick
    end
    object edNotas: TEdit
      Left = 526
      Top = 28
      Width = 80
      Height = 21
      TabOrder = 2
      Text = '10'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 58
    Width = 670
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    TabOrder = 5
    object Label4: TLabel
      Left = 1
      Top = 1
      Width = 664
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 
        '2 - Clique em cada bot'#227'o dos Blocos e em seguida no bot'#227'o Gerar ' +
        'TXT'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 450
    end
    object btnB_0: TButton
      Left = 16
      Top = 22
      Width = 100
      Height = 25
      Caption = 'Registros Bloco 0'
      TabOrder = 0
      OnClick = btnB_0Click
    end
    object btnB_1: TButton
      Left = 526
      Top = 22
      Width = 100
      Height = 25
      Caption = 'Registros Bloco 1'
      TabOrder = 1
      OnClick = btnB_1Click
    end
    object btnB_C: TButton
      Left = 118
      Top = 22
      Width = 100
      Height = 25
      Caption = 'Registros Bloco C'
      TabOrder = 2
      OnClick = btnB_CClick
    end
    object btnB_D: TButton
      Left = 220
      Top = 22
      Width = 100
      Height = 25
      Caption = 'Registros Bloco D'
      TabOrder = 3
      OnClick = btnB_DClick
    end
    object btnB_E: TButton
      Left = 323
      Top = 22
      Width = 100
      Height = 25
      Caption = 'Registros Bloco E'
      TabOrder = 4
      OnClick = btnB_EClick
    end
    object btnB_H: TButton
      Left = 424
      Top = 22
      Width = 100
      Height = 25
      Caption = 'Registros Bloco H'
      TabOrder = 5
      OnClick = btnB_HClick
    end
  end
  object btnB_9: TButton
    Left = 272
    Top = 478
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar Bloco 9'
    Enabled = False
    TabOrder = 6
    OnClick = btnB_9Click
  end
  object edBufLinhas: TEdit
    Left = 16
    Top = 478
    Width = 80
    Height = 21
    TabOrder = 7
    Text = '1000'
  end
  object edBufNotas: TEdit
    Left = 120
    Top = 478
    Width = 80
    Height = 21
    Enabled = False
    TabOrder = 8
    Text = '1000'
  end
  object ProgressBar1: TProgressBar
    Left = 200
    Top = 122
    Width = 348
    Height = 20
    TabOrder = 9
    Visible = False
  end
  object ACBrSPEDFiscal1: TACBrSPEDFiscal
    Path = '.\'
    Arquivo = 'ACBrSpedFiscal.txt'
    Delimitador = '|'
    TrimString = True
    CurMascara = '#0.00'
    OnError = ACBrSPEDFiscal1Error
    Left = 256
    Top = 278
  end
end
