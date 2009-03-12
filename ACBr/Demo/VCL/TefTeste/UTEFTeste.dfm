object Form1: TForm1
  Left = 219
  Top = 128
  Width = 372
  Height = 194
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnAtivar: TButton
    Left = 8
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Ativar TEF'
    TabOrder = 0
    OnClick = BtnAtivarClick
  end
  object BtnADM: TButton
    Left = 144
    Top = 40
    Width = 75
    Height = 25
    Caption = 'ADM'
    TabOrder = 1
    OnClick = BtnADMClick
  end
  object BtnGPAtivo: TButton
    Left = 256
    Top = 40
    Width = 75
    Height = 25
    Caption = 'GP Ativo ?'
    TabOrder = 2
    OnClick = BtnGPAtivoClick
  end
  object Button1: TButton
    Left = 144
    Top = 80
    Width = 177
    Height = 25
    Caption = 'Efetua o Pagamento com TEF'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 80
    Width = 121
    Height = 25
    Caption = 'Efetua Venda Completa'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 120
    Width = 137
    Height = 25
    Caption = 'Canela Ultimo Cupom'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 168
    Top = 120
    Width = 137
    Height = 25
    Caption = 'Canela Ultimo Cupom TEF'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 120
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Leitura X'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 208
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Redu'#231#227'o Z'
    TabOrder = 8
    OnClick = Button6Click
  end
  object ACBrTEF1: TACBrTEF
    ECF = ACBrECF1
    Tipo = tefDial
    BaseDir = 'C:\TEF_DIAL\'
    ReqTempFileName = 'C:\TEF_DIAL\REQ\IntPos.tmp'
    ReqFileName = 'C:\TEF_DIAL\REQ\IntPos.001'
    RespDataFileName = 'C:\TEF_DIAL\RESP\IntPos.001'
    RespFileName = 'C:\TEF_DIAL\RESP\IntPos.Sts'
    RespTempDataFileName = 'C:\ACBrTEFResp.tmp'
    NumVias = 2
    TimeOUT = 7
    ConsultarCheques = False
    AtivarGP = False
    AcionarGuilhotina = False
    IgnoraECFDesativado = False
    Left = 64
    Top = 8
  end
  object ACBrECF1: TACBrECF
    Modelo = ecfEpson
    Porta = 'COM4'
    MsgAguarde = 'Aguardando a resposta da Impressora: %d segundos'
    MsgTrabalhando = 'Impressora est'#225' trabalhando'
    MsgRelatorio = 'Imprimindo %s  %d'#170' Via '
    MsgPausaRelatorio = 'Destaque a %d'#170' via, <ENTER> proxima, %d seg.'
    FormMsgFonte.Color = clText
    FormMsgFonte.Height = 11
    FormMsgFonte.Name = 'MS Sans Serif'
    FormMsgFonte.Pitch = fpVariable
    FormMsgFonte.Style = []
    FormMsgFonte.Weight = 40
    FormMsgColor = clHighlight
    DecimaisPreco = 2
    MemoParams.Strings = (
      '[Cabecalho]'
      'LIN000=<center><b>Nome da Empresa</b></center>'
      'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>'
      'LIN002=<center>Cidade  -  UF  -  99999-999</center>'
      
        'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</c' +
        'enter>'
      
        'LIN004=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>COO: <b><code>NumCupom</code' +
        '></b></td></tr></table>'
      'LIN005=<hr>'
      ' '
      '[Cabecalho_Item]'
      'LIN000=ITEM   CODIGO     DESCRICAO'
      'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)'
      'LIN002=<hr>'
      
        'MascaraItem=III CCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDQQQQ' +
        'QQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT'
      ' '
      '[Rodape]'
      'LIN000=<hr>'
      
        'LIN001=<table width=100%><tr><td align=left><code>Data</code> <c' +
        'ode>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR<' +
        '/code></b></td></tr></table>'
      'LIN002=<center>Obrigado Volte Sempre</center>'
      'LIN003=<hr>'
      ' '
      '[Formato]'
      'Colunas=48'
      'HTML=1'
      'HTML_Title_Size=2'
      'HTML_Font=<font size="2" face="Lucida Console">')
    Device.Baud = 38400
    Device.HandShake = hsDTR_DSR
    Left = 24
    Top = 8
  end
end
