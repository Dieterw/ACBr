object FrmSPEDFiscal: TFrmSPEDFiscal
  Left = 335
  Top = 156
  Caption = 'ACBrSpedFiscal - Demo'
  ClientHeight = 440
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 57
    Width = 82
    Height = 13
    Caption = 'Nome do Arquivo'
  end
  object Label2: TLabel
    Left = 8
    Top = 97
    Width = 65
    Height = 13
    Caption = 'Lista de erros'
  end
  object Label3: TLabel
    Left = 8
    Top = 209
    Width = 75
    Height = 13
    Caption = 'Arquivo Gerado'
  end
  object Label4: TLabel
    Left = 0
    Top = 0
    Width = 625
    Height = 16
    Align = alTop
    Alignment = taCenter
    Caption = 'Clique em cada bot'#227'o dos Blocos e em seguida no bot'#227'o Gerar TXT'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 428
  end
  object btnB_0: TButton
    Left = 7
    Top = 22
    Width = 100
    Height = 25
    Caption = 'Registros Bloco 0'
    TabOrder = 0
    OnClick = btnB_0Click
  end
  object edtError: TMemo
    Left = 7
    Top = 112
    Width = 610
    Height = 91
    TabOrder = 1
  end
  object edtFile: TEdit
    Left = 7
    Top = 70
    Width = 406
    Height = 21
    TabOrder = 2
    Text = 'ACBrSpedFiscal.txt'
  end
  object btnTXT: TButton
    Left = 517
    Top = 68
    Width = 100
    Height = 25
    Caption = 'Gerar TXT'
    TabOrder = 3
    OnClick = btnTXTClick
  end
  object btnB_1: TButton
    Left = 109
    Top = 22
    Width = 100
    Height = 25
    Caption = 'Registros Bloco 1'
    TabOrder = 4
    OnClick = btnB_1Click
  end
  object btnB_C: TButton
    Left = 211
    Top = 22
    Width = 100
    Height = 25
    Caption = 'Registros Bloco C'
    TabOrder = 5
    OnClick = btnB_CClick
  end
  object btnB_D: TButton
    Left = 313
    Top = 22
    Width = 100
    Height = 25
    Caption = 'Registros Bloco D'
    TabOrder = 6
    OnClick = btnB_DClick
  end
  object btnB_E: TButton
    Left = 416
    Top = 22
    Width = 100
    Height = 25
    Caption = 'Registros Bloco E'
    TabOrder = 7
    OnClick = btnB_EClick
  end
  object btnB_H: TButton
    Left = 517
    Top = 22
    Width = 100
    Height = 25
    Caption = 'Registros Bloco H'
    TabOrder = 8
    OnClick = btnB_HClick
  end
  object edtTXT: TMemo
    Left = 7
    Top = 224
    Width = 610
    Height = 212
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 9
    WantReturns = False
    WordWrap = False
  end
  object btnError: TButton
    Left = 416
    Top = 68
    Width = 100
    Height = 25
    Caption = 'Gerar TXT Error'
    TabOrder = 10
    OnClick = btnErrorClick
  end
  object ACBrSPEDFiscal1: TACBrSPEDFiscal
    Path = '.\'
    Delimitador = '|'
    TrimString = True
    CurMascara = '#0.00'
    OnError = ACBrSPEDFiscal1Error
    Left = 272
    Top = 274
  end
end
