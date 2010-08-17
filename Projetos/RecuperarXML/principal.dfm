object frmPrincipal: TfrmPrincipal
  Left = 192
  Top = 122
  Width = 870
  Height = 500
  Caption = 'Recuperar XML NF-e'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    854
    464)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 88
    Top = 63
    Width = 249
    Height = 99
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Chave NF-e'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 163
    Height = 13
    Caption = 'Digite o c'#243'digo da imagem ao lado'
  end
  object lblStatus: TLabel
    Left = 118
    Top = 173
    Width = 110
    Height = 13
    Caption = 'Conectando ao SEFAZ'
    FocusControl = ProgressBar1
    Visible = False
  end
  object btnPegarHTML: TButton
    Left = 8
    Top = 96
    Width = 73
    Height = 25
    Caption = 'Pegar HTML'
    Enabled = False
    TabOrder = 3
    OnClick = btnPegarHTMLClick
  end
  object edtCaptcha: TEdit
    Left = 8
    Top = 63
    Width = 73
    Height = 21
    TabOrder = 2
  end
  object edtChaveNFe: TEdit
    Left = 8
    Top = 24
    Width = 329
    Height = 21
    TabOrder = 1
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 192
    Width = 335
    Height = 17
    TabOrder = 6
    Visible = False
  end
  object Memo2: TMemo
    Left = 8
    Top = 216
    Width = 337
    Height = 233
    Anchors = [akLeft, akTop, akBottom]
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object btnNovaConsulta: TButton
    Left = 8
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Nova Consulta'
    Enabled = False
    TabOrder = 4
    OnClick = btnNovaConsultaClick
  end
  object btnGerarXML: TButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Gerar XML'
    Enabled = False
    TabOrder = 7
    OnClick = btnGerarXMLClick
  end
  object WebBrowser1: TWebBrowser
    Left = 280
    Top = 8
    Width = 0
    Height = 0
    TabStop = False
    TabOrder = 0
    OnProgressChange = WebBrowser1ProgressChange
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C00000000000000000000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 352
    Top = 8
    Width = 497
    Height = 441
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 8
    object WBXML: TWebBrowser
      Left = 1
      Top = 1
      Width = 495
      Height = 439
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C000000293300005F2D00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
