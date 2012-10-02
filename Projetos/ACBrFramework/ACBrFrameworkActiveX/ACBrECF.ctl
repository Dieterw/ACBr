VERSION 5.00
Begin VB.UserControl ACBrECF 
   ClientHeight    =   345
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   345
   Palette         =   "ACBrECF.ctx":0000
   Picture         =   "ACBrECF.ctx":01A2
   ScaleHeight     =   345
   ScaleWidth      =   345
End
Attribute VB_Name = "ACBrECF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True

Private Const BUFFER_LEN As Integer = 256
Private cHandle As Long

Private Declare Function ECF_Create Lib "ACBr32.DLL" (ByRef handle As Long) As Long

Private Declare Function ECF_Destroy Lib "ACBr32.DLL" (ByRef handle As Long) As Long

Private Declare Function ECF_GetUltimoErro Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_Ativar Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_Desativar Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_GetModelo Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetModelo Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Modelo As Long) As Long

Private Declare Function ECF_GetPorta Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_SetPorta Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Porta As String) As Long

Private Declare Function ECF_GetTimeOut Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetTimeOut Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Timeout As Long) As Long

Private Declare Function ECF_GetAtivo Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_GetColunas Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_GetAguardandoResposta Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_GetComandoEnviado Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_GetRespostaComando Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_GetComandoLOG Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_SetComandoLOG Lib "ACBr32.DLL" (ByVal handle As Long, ByVal ComandoLog As String) As Long

Private Declare Function ECF_GetAguardaImpressao Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetAguardaImpressao Lib "ACBr32.DLL" (ByVal handle As Long, ByVal AgurdaImpressao As Boolean) As Long

Private Declare Function ECF_GetModeloStr Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetRFDID Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetDataHora Lib "ACBr32.DLL" (ByVal handle As Long, ByRef DataHora As Double) As Long
    
Private Declare Function ECF_GetNumCupom Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetNumCOO Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetNumLoja Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetNumECF Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetNumSerie Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetNumVersao Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
    
Private Declare Function ECF_GetDataMovimento Lib "ACBr32.DLL" (ByVal handle As Long, ByRef DataMovimento As Double) As Long
 
Private Declare Function ECF_GetDataHoraSB Lib "ACBr32.DLL" (ByVal handle As Long, ByRef DataMovimento As Double) As Long
 
Private Declare Function ECF_GetCNPJ Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetIE Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetIM Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_GetCliche Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetUsuarioAtual Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetSubModeloECF Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetPAF Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetNumCRZ Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetNumCRO Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetNumCCF Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetNumGNF Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
  
Private Declare Function ECF_GetNumGRG Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
 
Private Declare Function ECF_GetNumCDC Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
 
Private Declare Function ECF_GetNumCOOInicial Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long
 
Private Declare Function ECF_GetVendaBruta Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetGrandeTotal Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalCancelamentos Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalDescontos Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalAcrescimos Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalTroco Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalSubstituicaoTributaria Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalNaoTributado Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalIsencao Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalCancelamentosISSQN Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalDescontosISSQN Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalAcrescimosISSQN Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalSubstituicaoTributariaISSQN Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalNaoTributadoISSQN Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalIsencaoISSQN Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalNaoFiscal Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetNumUltItem Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetEmLinha Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Timeout As Long) As Long
  
Private Declare Function ECF_GetPoucoPapel Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetEstado Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetHorarioVerao Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetArredonda Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetTermica Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetMFD Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetIdentificaConsumidorRodape Lib "ACBr32.DLL" (ByVal handle As Long) As Long
  
Private Declare Function ECF_GetSubTotal Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
 
Private Declare Function ECF_GetTotalPago Lib "ACBr32.DLL" (ByVal handle As Long, ByRef Valor As Double) As Long
  
Private Declare Function ECF_GetGavetaAberta Lib "ACBr32.DLL" (ByVal handle As Long) As Long
    
Private Declare Function ECF_GetChequePronto Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_GetIntervaloAposComando Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetIntervaloAposComando Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Intervalo As Long) As Long
  
Private Declare Function ECF_GetDescricaoGrande Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetDescricaoGrande Lib "ACBr32.DLL" (ByVal handle As Long, ByVal DescricaoGrande As Boolean) As Long
  
Private Declare Function ECF_GetGavetaSinalInvertido Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetGavetaSinalInvertido Lib "ACBr32.DLL" (ByVal handle As Long, ByVal GavetaSinalInvertido As Boolean) As Long

Private Declare Function ECF_GetOperador Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, ByVal BufferLen As Long) As Long

Private Declare Function ECF_SetOperador Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Operador As String) As Long

Private Declare Function ECF_GetLinhasEntreCupons Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetLinhasEntreCupons Lib "ACBr32.DLL" (ByVal handle As Long, ByVal LinhasEntreCupons As Long) As Long

Private Declare Function ECF_GetDecimaisPreco Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetDecimaisPreco Lib "ACBr32.DLL" (ByVal handle As Long, ByVal DecimaisPreco As Long) As Long

Private Declare Function ECF_GetDecimaisQtd Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_SetDecimaisQtd Lib "ACBr32.DLL" (ByVal handle As Long, ByVal DecimaisQtd As Long) As Long

' cupom
Private Declare Function ECF_AbreCupom Lib "ACBr32.DLL" (ByVal handle As Long, ByVal CPF_CNPJ As String, ByVal NOME As String, _
    ByVal ENDERECO As String) As Long

Private Declare Function ECF_VendeItem Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Codigo As String, ByVal Descricao As String, _
    ByVal AliquotaICMS As String, ByVal Qtd As Double, ByVal ValorUnitario As Double, ByVal DescontoPorc As Double, _
    ByVal Unidade As String, ByVal TipoDescontoAcrescimo As String, ByVal DescontoAcrescimo As String) As Long

Private Declare Function ECF_CancelaItemVendido Lib "ACBr32.DLL" (ByVal handle As Long, ByVal NumItem As Long) As Long

Private Declare Function ECF_SubtotalizaCupom Lib "ACBr32.DLL" (ByVal handle As Long, ByVal DescontoAcrescimo As Double, ByVal MensagemRodape As String) As Long

Private Declare Function ECF_EfetuaPagamento Lib "ACBr32.DLL" (ByVal handle As Long, ByVal CodformaPagto As String, _
    ByVal Valor As Double, ByVal Observacao As String, ByVal ImprimeVinculado As Boolean) As Long

Private Declare Function ECF_CancelaCupom Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_FechaCupom Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Observacao As String) As Long

Private Declare Function ECF_Sangria Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Valor As Double, ByVal Obs As String) As Long

Private Declare Function ECF_Suprimento Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Valor As Double, ByVal Obs As String) As Long

Private Declare Function ECF_LeituraX Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_ReducaoZ Lib "ACBr32.DLL" (ByVal handle As Long) As Long

Private Declare Function ECF_GetFormasPagamentoStr Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, _
    ByVal BufferLen As Long) As Long

Private Declare Function ECF_GetAliquotasStr Lib "ACBr32.DLL" (ByVal handle As Long, ByVal Buffer As String, _
    ByVal BufferLen As Long) As Long



Public Sub UserControl_Initialize()
Dim Result As Long
Result = ECF_Create(cHandle)
CheckResult Result
End Sub

Public Sub UserControl_Terminate()
Dim Result As Long
Result = ECF_Destroy(cHandle)
CheckResult Result
End Sub

Public Sub Ativar()
Dim Result As Long
Result = ECF_Ativar(cHandle)
CheckResult Result
End Sub

Public Sub Desativar()
Dim Result As Long
Result = ECF_Desativar(cHandle)
CheckResult Result
End Sub

Public Property Get Modelo() As ACBrModeloECF
Dim Result As Long
Result = ECF_GetModelo(cHandle)
CheckResult Result
Modelo = Result
End Property

Public Property Let Modelo(Value As ACBrModeloECF)
Dim Result As Long
Result = ECF_SetModelo(cHandle, Value)
CheckResult Result
End Property

Public Property Get Porta() As String
Dim Result As Long
Dim Buffer As String
Buffer = String(BUFFER_LEN, " ")
Result = ECF_GetPorta(cHandle, Buffer, BUFFER_LEN)
CheckResult Result
Porta = Left(Buffer, Result)
End Property

Public Property Let Porta(Value As String)
Dim Result As Long
Result = ECF_SetPorta(cHandle, Value)
CheckResult Result
End Property

Public Property Get Timeout() As Integer
Dim Result As Long
Result = ECF_GetTimeOut(cHandle)
CheckResult Result
Timeout = Result
End Property

Public Property Let Timeout(Value As Integer)
Dim Result As Long
Result = ECF_SetTimeOut(cHandle, Value)
CheckResult Result
End Property

Public Property Get Ativo() As Boolean
Dim Result As Long
Result = ECF_GetAtivo(cHandle)
CheckResult Result

If Result = 1 Then
    Ativo = True
Else
    Ativo = False
End If

End Property

Public Property Get Colunas() As Integer
Dim Result As Long
Result = ECF_GetColunas(cHandle)
CheckResult Result
Colunas = Result
End Property

Public Property Get AguardandoResposta() As Boolean
Dim Result As Long
Result = ECF_GetAguardandoResposta(cHandle)
CheckResult Result

If Result > 0 Then
AguardandoResposta = True
Else
AguardandoResposta = False
End If

End Property

Public Property Get ComandoLog() As String
Dim Result As Long
Dim Buffer As String
Buffer = String(BUFFER_LEN, " ")
Result = ECF_GetComandoLOG(cHandle, Buffer, BUFFER_LEN)
CheckResult Result
ComandoLog = Left(Buffer, Result)
End Property

Public Property Let ComandoLog(Valor As String)
Dim Result As Long
Result = ECF_SetComandoLOG(cHandle, Valor)
CheckResult Result
End Property

Public Property Get AguardaImpressao() As Boolean
Dim Result As Long
Result = ECF_GetAguardaImpressao(cHandle)
CheckResult Result

If Result > 0 Then
AguardaImpressao = True
Else
AguardaImpressao = False
End If

End Property

Public Property Let AguardaImpressao(Valor As Boolean)
Dim Result As Long
Result = ECF_SetAguardaImpressao(cHandle, Valor)
CheckResult Result
End Property

Public Property Get ModeloStr() As String
Dim Result As Long
Dim Buffer As String
Buffer = String(BUFFER_LEN, " ")
Result = ECF_GetModeloStr(cHandle, Buffer, BUFFER_LEN)
CheckResult Result
ModeloStr = Left(Buffer, Result)
End Property

Public Property Get RFDID() As String
Dim Result As Long
Dim Buffer As String
Buffer = String(BUFFER_LEN, " ")
Result = ECF_GetPorta(cHandle, Buffer, BUFFER_LEN)
CheckResult Result
RFDID = Left(Buffer, Result)
End Property

Public Property Get DataHora() As Date
Dim Result As Long
Dim Value As Double

Result = ECF_GetDataHora(cHandle, Value)
CheckResult Result

DataHora = CDate(Value)

End Property



' Fiscal e Cupom
Public Sub AbrirCupom(Optional CPF_CNPJ As String = "", Optional NOME As String = "", Optional ENDERECO As String = "")

Dim Result As Long
Result = ECF_AbreCupom(cHandle, CPF_CNPJ, NOME, ENDERECO)

CheckResult Result
End Sub

Public Sub VendeItem(Codigo As String, Descricao As String, ICMS As String, Qtde As Double, ValorUnit As Double, DescPorc As Double, Unidade As String, TipoDescAcresc As String, DescAcresc As String)

Dim Result As Long
Result = ECF_VendeItem(cHandle, Codigo, Descricao, ICMS, Qtde, ValorUnit, DescPorc, Unidade, TipoDescAcresc, DescAcresc)

CheckResult Result
End Sub

Public Sub VendeItemSimples(Codigo As String, Descricao As String, Qtde As Double, ValorUnit As Double)

Dim Result As Long
Result = ECF_VendeItem(cHandle, Codigo, Descricao, "II", Qtde, ValorUnit, 0, "I", "%", "00,00")

CheckResult Result
End Sub


Public Sub CancelaItemVendido(NumItem As Long)

Dim Result As Long
Result = ECF_CancelaItemVendido(cHandle, NumItem)

CheckResult Result
End Sub


Public Sub SubTotalizaCupom(DescontoAcrescimo As Double, MensagemRodape As String)

Dim Result As Long
Result = ECF_SubtotalizaCupom(cHandle, DescontoAcrescimo, MensagemRodape)

CheckResult Result
End Sub


Public Sub EfetuaPagamento(CodformaPagto As String, Valor As Double, Observacao As String, ImprimeVinculado As Boolean)

Dim Result As Long
Result = ECF_EfetuaPagamento(cHandle, CodformaPagto, Valor, Observacao, ImprimeVinculado)

CheckResult Result
End Sub


Public Sub FechaCupom(Observacao As String)

Dim Result As Long
Result = ECF_FechaCupom(cHandle, Observacao)

CheckResult Result
End Sub

' Redução Z
Public Sub ReducaoZ()

Dim Result As Long
Result = ECF_ReducaoZ(cHandle)

CheckResult Result
End Sub



'Detroi Componente EMERGENCIA ;
' e Desativa
Public Sub ACBr_Destroi()

Call ECF_Desativar(cHandle)
Call ECF_Destroy(cHandle)

End Sub


Private Sub CheckResult(Result As Long)

Select Case Result

Case -1

    Dim Buffer As String
    Buffer = String(BUFFER_LEN, " ")
    ECF_GetUltimoErro cHandle, Buffer, BUFFER_LEN
    
    'Err.Raise -1, "ACBr32.DLL", Buffer
    MsgBox Buffer, vbExclamation, App.FileDescription
   
    
Case -2

    'Err.Raise -2, "ACBr32.DLL", "ACBr ECF não inicializado."
    MsgBox "Componente ECF não foi inicializado.", vbInformation, App.FileDescription


End Select

End Sub

