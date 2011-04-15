object FrmSPEDPisCofins: TFrmSPEDPisCofins
  Left = 356
  Top = 153
  Caption = 'ACBrSpedPisCofins - Demo'
  ClientHeight = 506
  ClientWidth = 687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    687
    506)
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
    Width = 669
    Height = 83
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object memoTXT: TMemo
    Left = 8
    Top = 248
    Width = 671
    Height = 208
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
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
    Width = 687
    Height = 58
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 4
    DesignSize = (
      683
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
      Width = 683
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
      Width = 288
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'ACBrSpedFiscal.txt'
      OnChange = edtFileChange
    end
    object cbConcomitante: TCheckBox
      Left = 334
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
    Width = 687
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    TabOrder = 5
    object Label4: TLabel
      Left = 1
      Top = 1
      Width = 681
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
      Left = 43
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco 0'
      TabOrder = 0
      OnClick = btnB_0Click
    end
    object btnB_1: TButton
      Left = 559
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco 1'
      TabOrder = 1
      OnClick = btnB_1Click
    end
    object btnB_C: TButton
      Left = 215
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco C'
      TabOrder = 2
      OnClick = btnB_CClick
    end
    object btnB_D: TButton
      Left = 301
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco D'
      TabOrder = 3
      OnClick = btnB_DClick
    end
    object btnB_A: TButton
      Left = 129
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco A'
      TabOrder = 4
      OnClick = btnB_AClick
    end
    object btnB_F: TButton
      Left = 387
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco F'
      TabOrder = 5
      OnClick = btnB_FClick
    end
    object btnB_M: TButton
      Left = 473
      Top = 22
      Width = 80
      Height = 25
      Caption = 'Bloco M'
      TabOrder = 6
      OnClick = btnB_MClick
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
  object ACBrSPEDPisCofins1: TACBrSPEDPisCofins
    Path = 'C:\Program Files\Borland\Delphi7\Bin\'
    Delimitador = '|'
    TrimString = True
    CurMascara = '#0.00'
    Left = 352
    Top = 208
  end
end
