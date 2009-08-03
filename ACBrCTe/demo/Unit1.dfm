object Form1: TForm1
  Left = 192
  Top = 122
  Width = 870
  Height = 500
  Caption = 'ACBrCTe'
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
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Status Servi'#231'o'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 40
    Width = 153
    Height = 25
    Caption = 'Consulta Cadastro'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 72
    Width = 153
    Height = 25
    Caption = 'Consulta CTe'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 176
    Top = 8
    Width = 329
    Height = 249
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object Button4: TButton
    Left = 8
    Top = 104
    Width = 153
    Height = 25
    Caption = 'Cancelar CTe'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 136
    Width = 153
    Height = 25
    Caption = 'Inutilizar Numera'#231#227'o'
    TabOrder = 5
    OnClick = Button5Click
  end
  object HTTPRIO1: THTTPRIO
    HTTPWebNode.Agent = 'Borland SOAP 1.2'
    HTTPWebNode.UseUTF8InHeader = False
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soNoSOAPActionHeader, soAutoCheckAccessPointViaUDDI]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 144
    Top = 104
  end
end
