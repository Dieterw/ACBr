inherited frmLeituraXArquivo: TfrmLeituraXArquivo
  Left = 347
  Top = 224
  Caption = 'Gravar leitura X para arquivo'
  ClientHeight = 103
  ClientWidth = 458
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 458
    Height = 73
    object Label1: TLabel
      Left = 20
      Top = 14
      Width = 166
      Height = 13
      Caption = 'Local onde deseja salvar o arquivo'
    end
    object edtPathArquivo: TEdit
      Left = 20
      Top = 30
      Width = 381
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 407
      Top = 28
      Width = 29
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  inherited pnlRodape: TPanel
    Top = 73
    Width = 458
    inherited btnExecutar: TButton
      Left = 248
    end
    inherited btnCancelar: TButton
      Left = 354
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.TXT'
    FileName = 'LeituraX'
    Filter = 'Arquivos texto|*.txt'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Salvar leitura X para arquivo'
    Left = 55
    Top = 55
  end
end
