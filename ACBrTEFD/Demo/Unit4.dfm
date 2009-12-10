object Form4: TForm4
  Left = 511
  Top = 168
  Width = 349
  Height = 317
  Caption = 'Form4'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 24
  object ListBox1: TListBox
    Left = 0
    Top = 50
    Width = 333
    Height = 181
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 24
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 333
    Height = 50
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 231
    Width = 333
    Height = 50
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 58
      Top = 9
      Width = 70
      Height = 35
      Caption = '&OK'
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 185
      Top = 9
      Width = 102
      Height = 35
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
