object Form1: TForm1
  Left = 441
  Top = 262
  Caption = 'ACBr Download (HTTP/FTP)'
  ClientHeight = 431
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    446
    431)
  PixelsPerInch = 96
  TextHeight = 13
  object lConnectionInfo: TLabel
    Left = 345
    Top = 383
    Width = 77
    Height = 13
    Alignment = taRightJustify
    Caption = 'Connection Info'
    Color = clBtnFace
    ParentColor = False
  end
  object lFile: TLabel
    Left = 24
    Top = 280
    Width = 61
    Height = 13
    Caption = 'Pasta Detino'
    Color = clBtnFace
    ParentColor = False
  end
  object Label1: TLabel
    Left = 264
    Top = 409
    Width = 49
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 'BufferSize'
    Color = clBtnFace
    ParentColor = False
    ExplicitTop = 305
  end
  object Label2: TLabel
    Left = 24
    Top = 240
    Width = 69
    Height = 13
    Caption = 'URL Download'
    Color = clBtnFace
    ParentColor = False
  end
  object edURL: TComboBox
    Left = 24
    Top = 255
    Width = 398
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object bDownload: TBitBtn
    Left = 24
    Top = 322
    Width = 99
    Height = 26
    Caption = 'Download'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
      00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
      70E337F3333F333337F3E0F33303333370E337F3337FF33337F3E0F333003333
      70E337F33377FF3337F3E0F33300033370E337F333777FF337F3E0F333000033
      70E337F33377773337F3E0F33300033370E337F33377733337F3E0F333003333
      70E337F33377333337F3E0F33303333370E337F33373333337F3E0F333333333
      70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
      00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
    NumGlyphs = 2
    TabOrder = 1
    OnClick = bDownloadClick
  end
  object bStop: TBitBtn
    Left = 353
    Top = 322
    Width = 69
    Height = 26
    Anchors = [akTop, akRight]
    Caption = 'Stop'
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
      00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
      70E337F33333333337F3E0F33333333370E337F333FFFFF337F3E0F330000033
      70E337F3377777F337F3E0F33000003370E337F3377777F337F3E0F330000033
      70E337F3377777F337F3E0F33000003370E337F3377777F337F3E0F330000033
      70E337F33777773337F3E0F33333333370E337F33333333337F3E0F333333333
      70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
      00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
    NumGlyphs = 2
    TabOrder = 2
    OnClick = bStopClick
  end
  object bPause: TBitBtn
    Left = 195
    Top = 322
    Width = 76
    Height = 26
    Anchors = [akTop]
    Caption = 'Pause'
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
      00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
      70E337F33333333337F3E0F33333333370E337F333FF3FF337F3E0F330030033
      70E337F3377F77F337F3E0F33003003370E337F3377F77F337F3E0F330030033
      70E337F3377F77F337F3E0F33003003370E337F3377F77F337F3E0F330030033
      70E337F33773773337F3E0F33333333370E337F33333333337F3E0F333333333
      70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
      00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = bPauseClick
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 355
    Width = 398
    Height = 20
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object edFile: TEdit
    Left = 24
    Top = 296
    Width = 398
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
    Text = '.\'
  end
  object Button1: TButton
    Left = 24
    Top = 402
    Width = 47
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'TXT'
    TabOrder = 6
    OnClick = Button1Click
  end
  object cbxBufferSize: TComboBox
    Left = 322
    Top = 404
    Width = 100
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    ItemIndex = 6
    TabOrder = 7
    Text = '65536'
    OnChange = cbxBufferSizeChange
    Items.Strings = (
      '1024'
      '2048'
      '4096'
      '8192'
      '16384'
      '32768'
      '65536')
  end
  object edtProt: TComboBox
    Left = 24
    Top = 5
    Width = 100
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemIndex = 0
    TabOrder = 8
    Text = 'HTTP'
    OnChange = edtProtChange
    Items.Strings = (
      'HTTP'
      'FTP')
  end
  object GroupBox1: TGroupBox
    Left = 23
    Top = 34
    Width = 399
    Height = 98
    Caption = 'FTP '
    Enabled = False
    TabOrder = 9
    DesignSize = (
      399
      98)
    object Label3: TLabel
      Left = 12
      Top = 16
      Width = 22
      Height = 13
      Caption = 'Host'
      Color = clBtnFace
      ParentColor = False
    end
    object Label4: TLabel
      Left = 203
      Top = 16
      Width = 26
      Height = 13
      Caption = 'Porta'
      Color = clBtnFace
      ParentColor = False
    end
    object Label5: TLabel
      Left = 12
      Top = 52
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
      Color = clBtnFace
      ParentColor = False
    end
    object Label6: TLabel
      Left = 203
      Top = 52
      Width = 30
      Height = 13
      Caption = 'Senha'
      Color = clBtnFace
      ParentColor = False
    end
    object edtHost: TEdit
      Left = 12
      Top = 32
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtPort: TEdit
      Left = 201
      Top = 32
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object edtUser: TEdit
      Left = 12
      Top = 68
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object edtPass: TEdit
      Left = 201
      Top = 68
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 23
    Top = 138
    Width = 399
    Height = 98
    Caption = 'Proxy'
    TabOrder = 10
    DesignSize = (
      399
      98)
    object Label7: TLabel
      Left = 12
      Top = 16
      Width = 22
      Height = 13
      Caption = 'Host'
      Color = clBtnFace
      ParentColor = False
    end
    object Label8: TLabel
      Left = 203
      Top = 16
      Width = 26
      Height = 13
      Caption = 'Porta'
      Color = clBtnFace
      ParentColor = False
    end
    object Label9: TLabel
      Left = 12
      Top = 52
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
      Color = clBtnFace
      ParentColor = False
    end
    object Label10: TLabel
      Left = 203
      Top = 52
      Width = 30
      Height = 13
      Caption = 'Senha'
      Color = clBtnFace
      ParentColor = False
    end
    object edtProxyHost: TEdit
      Left = 12
      Top = 32
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edtProxyPort: TEdit
      Left = 201
      Top = 32
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object edtProxyUser: TEdit
      Left = 12
      Top = 68
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object edtProxyPass: TEdit
      Left = 201
      Top = 68
      Width = 187
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
  end
  object CheckBox1: TCheckBox
    Left = 23
    Top = 381
    Width = 132
    Height = 17
    Caption = 'Fechar ap'#243's download'
    TabOrder = 11
  end
  object fACBrDownload: TACBrDownload
    SizeRecvBuffer = 0
    OnAfterDownload = fACBrDownloadAfterDownload
    OnHookStatus = HookStatus
    OnHookMonitor = HookMonitor
    Left = 358
    Top = 14
  end
end
