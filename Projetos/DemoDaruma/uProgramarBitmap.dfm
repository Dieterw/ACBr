inherited frmProgramarBitmap: TfrmProgramarBitmap
  Left = 289
  Top = 243
  Caption = 'Bitmap promocional'
  ClientHeight = 158
  ClientWidth = 481
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 481
    Height = 128
    object Label1: TLabel
      Left = 22
      Top = 60
      Width = 95
      Height = 13
      Caption = 'Caminho do arquivo'
    end
    object Label2: TLabel
      Left = 22
      Top = 17
      Width = 29
      Height = 13
      Caption = 'Indice'
    end
    object Label3: TLabel
      Left = 77
      Top = 17
      Width = 36
      Height = 13
      Caption = 'Posi'#231#227'o'
    end
    object edtPathArquivo: TEdit
      Left = 22
      Top = 76
      Width = 408
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object btnProcurarArquivo: TButton
      Left = 436
      Top = 74
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 3
      OnClick = btnProcurarArquivoClick
    end
    object cbxIndice: TComboBox
      Left = 22
      Top = 33
      Width = 49
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5')
    end
    object cbxPosicao: TComboBox
      Left = 77
      Top = 33
      Width = 119
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'Esquerda'
        'Centro')
    end
  end
  inherited pnlRodape: TPanel
    Top = 128
    Width = 481
    inherited btnExecutar: TButton
      Left = 271
    end
    inherited btnCancelar: TButton
      Left = 377
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.bmp'
    Filter = 'Arquivos de imagem bitmap|*.bmp'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Procurar imagem'
    Left = 170
    Top = 70
  end
end
