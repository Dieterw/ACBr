object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'ACBrInStore'
  ClientHeight = 262
  ClientWidth = 470
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
    Left = 28
    Top = 58
    Width = 201
    Height = 13
    Caption = 'C'#243'digo na Etiqueta Impresso pela Balan'#231'a'
  end
  object Label2: TLabel
    Left = 28
    Top = 140
    Width = 40
    Height = 13
    Caption = 'C'#243'digo :'
  end
  object Label3: TLabel
    Left = 38
    Top = 166
    Width = 30
    Height = 13
    Caption = 'Peso :'
  end
  object Label4: TLabel
    Left = 37
    Top = 192
    Width = 31
    Height = 13
    Caption = 'Total :'
  end
  object Label5: TLabel
    Left = 27
    Top = 112
    Width = 41
    Height = 13
    Caption = 'Prefixo :'
  end
  object Label6: TLabel
    Left = 28
    Top = 7
    Width = 268
    Height = 13
    Caption = 'Estrutura da Codifica'#231#227'o EAN13 da Balan'#231'a de Trabalho'
  end
  object Label7: TLabel
    Left = 48
    Top = 218
    Width = 20
    Height = 13
    Caption = 'DV :'
  end
  object edtCodigoEtiqueta: TEdit
    Left = 28
    Top = 74
    Width = 350
    Height = 21
    TabOrder = 0
    Text = '2123400123459'
  end
  object Button1: TButton
    Left = 387
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Desmembrar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object edtPrefixo: TEdit
    Left = 70
    Top = 109
    Width = 121
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 2
  end
  object edtCodigo: TEdit
    Left = 70
    Top = 137
    Width = 121
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 3
  end
  object edtPeso: TEdit
    Left = 70
    Top = 163
    Width = 121
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 4
  end
  object edtTotal: TEdit
    Left = 70
    Top = 189
    Width = 121
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 5
  end
  object edtCodificacao: TEdit
    Left = 27
    Top = 21
    Width = 350
    Height = 21
    TabOrder = 6
    Text = '2CCCC0TTTTTTDV'
  end
  object edtDV: TEdit
    Left = 70
    Top = 215
    Width = 121
    Height = 19
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 7
  end
  object ACBrInStore1: TACBrInStore
    OnGetPrecoUnitario = ACBrInStore1GetPrecoUnitario
    Left = 272
    Top = 156
  end
end
