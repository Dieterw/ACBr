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

Private Sub CheckResult(Result As Long)

Select Case Result

Case -1

    Dim Buffer As String
    Buffer = String(BUFFER_LEN, " ")
    ECF_GetUltimoErro cHandle, Buffer, BUFFER_LEN
    
    Err.Raise -1, "ACBr32.DLL", Buffer
    
Case -2

    Err.Raise -2, "ACBr32.DLL", "ACBr ECF não inicializado."

End Select

End Sub

