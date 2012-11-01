inherited frmImpressaoCheque: TfrmImpressaoCheque
  Caption = 'Imprimir Cheque'
  ClientHeight = 247
  ClientWidth = 493
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCliente: TPanel
    Width = 493
    Height = 217
    object Label1: TLabel
      Left = 25
      Top = 18
      Width = 29
      Height = 13
      Caption = 'Banco'
    end
    object Label2: TLabel
      Left = 117
      Top = 18
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label3: TLabel
      Left = 25
      Top = 62
      Width = 53
      Height = 13
      Caption = 'Favorecido'
    end
    object Label4: TLabel
      Left = 25
      Top = 105
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label5: TLabel
      Left = 355
      Top = 105
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Label6: TLabel
      Left = 25
      Top = 148
      Width = 283
      Height = 13
      Caption = 'Observa'#231#245'es no verso (deixe em branco para n'#227'o imprimir)'
    end
    object edtBanco: TSpinEdit
      Left = 25
      Top = 34
      Width = 86
      Height = 22
      MaxValue = 999
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
    object edtValor: TEdit
      Left = 117
      Top = 34
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '1,00'
    end
    object edtFavorecido: TEdit
      Left = 25
      Top = 78
      Width = 439
      Height = 21
      TabOrder = 2
      Text = 'Projeto ACBr Teste de impress'#227'o de cheques'
    end
    object edtCidade: TEdit
      Left = 25
      Top = 121
      Width = 324
      Height = 21
      TabOrder = 3
      Text = 'Cidade'
    end
    object edtData: TDateTimePicker
      Left = 355
      Top = 121
      Width = 109
      Height = 21
      Date = 41207.034415416670000000
      Time = 41207.034415416670000000
      TabOrder = 4
    end
    object edtObservacao: TEdit
      Left = 25
      Top = 164
      Width = 439
      Height = 21
      TabOrder = 5
    end
  end
  inherited pnlRodape: TPanel
    Top = 217
    Width = 493
    DesignSize = (
      493
      30)
    inherited btnExecutar: TButton
      Left = 292
    end
    inherited btnCancelar: TButton
      Left = 392
    end
  end
end
