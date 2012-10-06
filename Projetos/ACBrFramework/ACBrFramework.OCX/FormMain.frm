VERSION 5.00
Object = "*\AACBrFramework.vbp"
Begin VB.Form FormMain 
   Caption         =   "Form1"
   ClientHeight    =   4680
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   7245
   LinkTopic       =   "Form1"
   ScaleHeight     =   4680
   ScaleWidth      =   7245
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox comboModelo 
      Height          =   315
      ItemData        =   "FormMain.frx":0000
      Left            =   2520
      List            =   "FormMain.frx":0034
      Style           =   2  'Dropdown List
      TabIndex        =   11
      Top             =   360
      Width           =   1935
   End
   Begin VB.ComboBox ComboPorta 
      Height          =   315
      ItemData        =   "FormMain.frx":00EC
      Left            =   2520
      List            =   "FormMain.frx":00FF
      Style           =   2  'Dropdown List
      TabIndex        =   9
      Top             =   960
      Width           =   1455
   End
   Begin VB.CommandButton CommandReducaZ 
      Caption         =   "Redução Z"
      Height          =   495
      Left            =   5040
      TabIndex        =   7
      Top             =   960
      Width           =   1575
   End
   Begin VB.CommandButton CommandEfetuaPagamento 
      Caption         =   "Efetua Pagamento"
      Height          =   495
      Left            =   960
      TabIndex        =   6
      Top             =   3120
      Width           =   1335
   End
   Begin VB.CommandButton CommandDestroi 
      Caption         =   "Destroi/Desativa"
      Height          =   495
      Left            =   5040
      TabIndex        =   5
      Top             =   240
      Width           =   1575
   End
   Begin VB.CommandButton CommandFechaCupom 
      Caption         =   "FechaCupom"
      Height          =   495
      Left            =   960
      TabIndex        =   4
      Top             =   3960
      Width           =   1335
   End
   Begin VB.CommandButton CommandSubTotaliza 
      Caption         =   "SubTotaliza"
      Height          =   495
      Left            =   960
      TabIndex        =   3
      Top             =   2400
      Width           =   1335
   End
   Begin VB.CommandButton CommandVendeItem 
      Caption         =   "VendeItem"
      Height          =   495
      Left            =   960
      TabIndex        =   2
      Top             =   1560
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Ativar"
      Height          =   495
      Left            =   960
      TabIndex        =   1
      Top             =   360
      Width           =   1335
   End
   Begin ACBrFramework.ACBrECF ACBrECF1 
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   661
   End
   Begin VB.Label Label2 
      Caption         =   "Porta Serial"
      Height          =   255
      Left            =   2520
      TabIndex        =   10
      Top             =   720
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Modelo ECF"
      Height          =   255
      Left            =   2520
      TabIndex        =   8
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "FormMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

On Error Resume Next


If Trim(comboModelo.Text) = "" Then
    MsgBox "Escolha uma Impressora !", vbExclamation
    Exit Sub
End If

If Trim(ComboPorta.Text) = "" Then
    MsgBox "Escoha um porta Serial !", vbExclamation
    Exit Sub
End If

ACBrECF1.Porta = ComboPorta.Text

'ACBrECF1.Modelo = ACBrModeloECF.FiscNET
ACBrECF1.Modelo = comboModelo.ListIndex

Debug.Print "Modelo: [" & ACBrECF1.Modelo & "]"

'Dim ModeloStr As String
'ModeloStr = ACBrECF1.ModeloStr

'Dim portaStr As String
'portaStr = ACBrECF1.Porta

ACBrECF1.Ativar

' nova
ACBrECF1.AbrirCupom



Exit Sub

ERRO:
MsgBox Err.Number & " - " & Err.Description


End Sub

Private Sub CommandDestroi_Click()

ACBrECF1.ACBr_Destroi

End Sub

Private Sub CommandEfetuaPagamento_Click()

Dim valor As String

valor = InputBox("Entre com a Valor a ser Pago." & Chr(13) & "Ex. Total: 2.25")

ACBrECF1.EfetuaPagamento "01", Val(valor), "Em teste hhe", False

End Sub

Private Sub CommandFechaCupom_Click()

ACBrECF1.FechaCupom "Obrigado e Volte Sempre!"

End Sub

Private Sub CommandReducaZ_Click()

ACBrECF1.ReducaoZ

End Sub

Private Sub CommandSubTotaliza_Click()

ACBrECF1.SubTotalizaCupom 0, "Sub total"

End Sub

Private Sub CommandVendeItem_Click()

ACBrECF1.VendeItemSimples "001", "Caneta Bic Azul", 2, 1.2


End Sub

Private Sub Form_Load()

ACBrECF1.Desativar

End Sub
