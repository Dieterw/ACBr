object FPrincipal: TFPrincipal
  Left = 309
  Top = 236
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Impressão de Etiquetas'
  ClientHeight = 163
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 11
    Width = 38
    Height = 13
    Caption = 'Modelo:'
  end
  object Label2: TLabel
    Left = 175
    Top = 11
    Width = 28
    Height = 13
    Caption = 'Porta:'
  end
  object Label3: TLabel
    Left = 15
    Top = 59
    Width = 47
    Height = 13
    Caption = 'Nº Copias'
  end
  object Label4: TLabel
    Left = 175
    Top = 59
    Width = 59
    Height = 13
    Caption = 'Avanço Etq:'
  end
  object cbModelo: TComboBox
    Left = 15
    Top = 28
    Width = 90
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'etqPpla'
    Items.Strings = (
      'etqNenhuma'
      'etqPpla'
      'etqPPlb')
  end
  object cbPorta: TComboBox
    Left = 175
    Top = 28
    Width = 90
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'LPT1'
    Items.Strings = (
      'LPT1'
      'LPT2'
      'LPT3'
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5')
  end
  object eCopias: TEdit
    Left = 15
    Top = 75
    Width = 70
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object eAvanco: TEdit
    Left = 175
    Top = 75
    Width = 70
    Height = 21
    TabOrder = 3
    Text = '600'
  end
  object bEtqSimples: TButton
    Left = 23
    Top = 115
    Width = 80
    Height = 25
    Caption = 'Etq Simples'
    TabOrder = 4
    OnClick = bEtqSimplesClick
  end
  object bEtqCarreiras: TButton
    Left = 174
    Top = 115
    Width = 80
    Height = 25
    Caption = 'Etq 3 Carreiras'
    TabOrder = 5
    OnClick = bEtqCarreirasClick
  end
  object ACBrETQ: TACBrETQ
    Porta = 'LPT1'
    Left = 127
    Top = 27
  end
end
