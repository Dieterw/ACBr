object Form1: TForm1
  Left = 203
  Top = 124
  Width = 324
  Height = 270
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnGerar: TButton
    Left = 24
    Top = 192
    Width = 75
    Height = 25
    Caption = 'GerarXML'
    TabOrder = 0
    OnClick = btnGerarClick
  end
  object btnValida: TButton
    Left = 120
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Valida'
    TabOrder = 1
    OnClick = btnValidaClick
  end
  object btnEnvia: TButton
    Left = 216
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Envia'
    TabOrder = 2
    OnClick = btnEnviaClick
  end
  object rgPadrao: TRadioGroup
    Left = 8
    Top = 8
    Width = 97
    Height = 105
    Caption = ' Padr'#227'o '
    ItemIndex = 0
    Items.Strings = (
      'ABRASF'
      'GINFES')
    TabOrder = 3
  end
  object ACBrNFSe1: TACBrNFSe
    Configuracoes.Geral.PathSalvar = 'C:\Arquivos de programas\Borland\Delphi7\Bin\'
    Configuracoes.WebServices.PadraoLayout = plABRASF
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.IntervaloTentativas = 0
    Configuracoes.WebServices.AjustaAguardaConsultaRet = False
    Left = 264
    Top = 24
  end
  object OpenDialog1: TOpenDialog
    Left = 264
    Top = 56
  end
end
