inherited frmIdentificacaoPafECF: TfrmIdentificacaoPafECF
  Caption = 'Identifica'#231#227'o do Paf-ECF'
  ClientHeight = 149
  ClientWidth = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 347
    Height = 114
    object edtLinha1: TEdit
      Left = 32
      Top = 34
      Width = 283
      Height = 21
      TabOrder = 0
      Text = 'MD5: AXAXAXAXAXAXAXAXAXAXAXAXAXAXAXTT'
    end
    object edtLinha2: TEdit
      Left = 32
      Top = 61
      Width = 283
      Height = 21
      TabOrder = 1
      Text = 'Demo ACBr DarumaFramework.dll'
    end
  end
  inherited pnlRodape: TPanel
    Top = 114
    Width = 347
    inherited btnExecutar: TButton
      Left = 137
    end
    inherited btnCancelar: TButton
      Left = 243
    end
  end
end
