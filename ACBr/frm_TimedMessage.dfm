object frmTimedMessage: TfrmTimedMessage
  Left = 361
  Top = 312
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Aten'#231#227'o'
  ClientHeight = 108
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblMessage: TLabel
    Left = 0
    Top = 0
    Width = 294
    Height = 65
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblMessage'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object btnOK: TButton
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object Timer: TTimer
    Interval = 500
    OnTimer = TimerTimer
    Left = 8
    Top = 8
  end
end
