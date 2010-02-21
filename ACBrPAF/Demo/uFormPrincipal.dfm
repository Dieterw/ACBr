object Form6: TForm6
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Demo do ACBrPAF'
  ClientHeight = 313
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 417
    Height = 121
    Align = alTop
    Caption = 'Identifica'#231#227'o do Estabelecimento Usu'#225'rio do PAF-ECF'
    TabOrder = 0
    ExplicitLeft = 40
    ExplicitTop = 56
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label2: TLabel
      Left = 47
      Top = 24
      Width = 25
      Height = 13
      Caption = 'CNPJ'
    end
    object Label3: TLabel
      Left = 167
      Top = 24
      Width = 87
      Height = 13
      Caption = 'Inscri'#231#227'o Estadual'
    end
    object Label4: TLabel
      Left = 287
      Top = 24
      Width = 89
      Height = 13
      Caption = 'Inscri'#231#227'o Municipal'
    end
    object Label5: TLabel
      Left = 16
      Top = 64
      Width = 60
      Height = 13
      Caption = 'Raz'#227'o Social'
    end
    object edtUF: TEdit
      Left = 16
      Top = 39
      Width = 25
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object edtCNPJ: TEdit
      Left = 47
      Top = 39
      Width = 114
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object edtIE: TEdit
      Left = 167
      Top = 39
      Width = 114
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object edtIM: TEdit
      Left = 287
      Top = 39
      Width = 114
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object edtRAZAO: TEdit
      Left = 16
      Top = 79
      Width = 385
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 156
    Width = 417
    Height = 157
    Align = alBottom
    Caption = 'Log de erros'
    TabOrder = 1
    ExplicitTop = 232
    object logErros: TMemo
      Left = 2
      Top = 15
      Width = 413
      Height = 140
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitHeight = 88
    end
  end
  object btnD: TButton
    Left = 8
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Tipo D'
    TabOrder = 2
    OnClick = btnDClick
  end
  object btnE: TButton
    Left = 89
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Tipo E'
    TabOrder = 3
    OnClick = btnEClick
  end
  object btnP: TButton
    Left = 170
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Tipo P'
    TabOrder = 4
    OnClick = btnPClick
  end
  object btnR: TButton
    Left = 251
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Tipo R'
    TabOrder = 5
    OnClick = btnRClick
  end
  object btnT: TButton
    Left = 332
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Tipo T'
    TabOrder = 6
    OnClick = btnTClick
  end
  object ACBrPAF: TACBrPAF
    Path = '.\'
    Delimitador = '|'
    TrimString = True
    CurMascara = '#0.00'
    OnError = ACBrPAFError
    Left = 272
    Top = 184
  end
end
