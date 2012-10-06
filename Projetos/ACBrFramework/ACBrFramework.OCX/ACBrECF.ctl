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

Public Property Get modelo() As ACBrModeloECF
Dim Result As Long
Result = ECF_GetModelo(cHandle)
CheckResult Result
modelo = Result
End Property

Public Property Let modelo(value As ACBrModeloECF)
Dim Result As Long
Result = ECF_SetModelo(cHandle, value)
CheckResult Result
End Property

Public Property Get porta() As String
Dim Result As Long
Dim buffer As String
buffer = String(BUFFER_LEN, " ")
Result = ECF_GetPorta(cHandle, buffer, BUFFER_LEN)
CheckResult Result
porta = Left(buffer, Result)
End Property

Public Property Let porta(value As String)
Dim Result As Long
Result = ECF_SetPorta(cHandle, value)
CheckResult Result
End Property

Public Property Get timeout() As Integer
Dim Result As Long
Result = ECF_GetTimeOut(cHandle)
CheckResult Result
timeout = Result
End Property

Public Property Let timeout(value As Integer)
Dim Result As Long
Result = ECF_SetTimeOut(cHandle, value)
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

Public Property Get comandoLog() As String
Dim Result As Long
Dim buffer As String
buffer = String(BUFFER_LEN, " ")
Result = ECF_GetComandoLOG(cHandle, buffer, BUFFER_LEN)
CheckResult Result
comandoLog = Left(buffer, Result)
End Property

Public Property Let comandoLog(valor As String)
Dim Result As Long
Result = ECF_SetComandoLOG(cHandle, valor)
CheckResult Result
End Property

Public Property Get aguardaImpressao() As Boolean
Dim Result As Long
Result = ECF_GetAguardaImpressao(cHandle)
CheckResult Result

If Result > 0 Then
aguardaImpressao = True
Else
aguardaImpressao = False
End If

End Property

Public Property Let aguardaImpressao(valor As Boolean)
Dim Result As Long
Result = ECF_SetAguardaImpressao(cHandle, valor)
CheckResult Result
End Property

Public Property Get ModeloStr() As String
Dim Result As Long
Dim buffer As String
buffer = String(BUFFER_LEN, " ")
Result = ECF_GetModeloStr(cHandle, buffer, BUFFER_LEN)
CheckResult Result
ModeloStr = Left(buffer, Result)
End Property

Public Property Get RFDID() As String
Dim Result As Long
Dim buffer As String
buffer = String(BUFFER_LEN, " ")
Result = ECF_GetPorta(cHandle, buffer, BUFFER_LEN)
CheckResult Result
RFDID = Left(buffer, Result)
End Property

Public Property Get DataHora() As Date
Dim Result As Long
Dim value As Double

Result = ECF_GetDataHora(cHandle, value)
CheckResult Result

DataHora = CDate(value)

End Property



' Fiscal e Cupom
Public Sub AbrirCupom(Optional CPF_CNPJ As String = "", Optional NOME As String = "", Optional endereco As String = "")

Dim Result As Long
Result = ECF_AbreCupom(cHandle, CPF_CNPJ, NOME, endereco)

CheckResult Result
End Sub

Public Sub VendeItem(codigo As String, descricao As String, ICMS As String, Qtde As Double, ValorUnit As Double, DescPorc As Double, unidade As String, TipoDescAcresc As String, DescAcresc As String)

Dim Result As Long
Result = ECF_VendeItem(cHandle, codigo, descricao, ICMS, Qtde, ValorUnit, DescPorc, unidade, TipoDescAcresc, DescAcresc)

CheckResult Result
End Sub

Public Sub VendeItemSimples(codigo As String, descricao As String, Qtde As Double, ValorUnit As Double)

Dim Result As Long
Result = ECF_VendeItem(cHandle, codigo, descricao, "II", Qtde, ValorUnit, 0, "I", "%", "00,00")

CheckResult Result
End Sub


Public Sub CancelaItemVendido(numItem As Long)

Dim Result As Long
Result = ECF_CancelaItemVendido(cHandle, numItem)

CheckResult Result
End Sub


Public Sub SubTotalizaCupom(descontoAcrescimo As Double, mensagemRodape As String)

Dim Result As Long
Result = ECF_SubtotalizaCupom(cHandle, descontoAcrescimo, mensagemRodape)

CheckResult Result
End Sub


Public Sub EfetuaPagamento(codFormaPagto As String, valor As Double, observacao As String, imprimeVinculado As Boolean)

Dim Result As Long
Result = ECF_EfetuaPagamento(cHandle, codFormaPagto, valor, observacao, imprimeVinculado)

CheckResult Result
End Sub


Public Sub FechaCupom(observacao As String)

Dim Result As Long
Result = ECF_FechaCupom(cHandle, observacao)

CheckResult Result
End Sub

' Redução Z
Public Sub reducaoZ()

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

    Dim buffer As String
    buffer = String(BUFFER_LEN, " ")
    ECF_GetUltimoErro cHandle, buffer, BUFFER_LEN
    
    'Err.Raise -1, "ACBr32.DLL", Buffer
    MsgBox buffer, vbExclamation, App.FileDescription
   
    
Case -2

    'Err.Raise -2, "ACBr32.DLL", "ACBr ECF não inicializado."
    MsgBox "Componente ECF não foi inicializado.", vbInformation, App.FileDescription


End Select

End Sub

