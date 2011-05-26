VERSION 5.00
Object = "*\AACBr_ActiveX.vbp"
Begin VB.Form FormMain 
   Caption         =   "Form1"
   ClientHeight    =   3030
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   3030
   ScaleWidth      =   4560
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   1680
      TabIndex        =   1
      Top             =   600
      Width           =   1455
   End
   Begin ACBr_ActiveX.ACBrECF ACBrECF1 
      Height          =   615
      Left            =   600
      TabIndex        =   0
      Top             =   720
      Width           =   495
      _extentx        =   873
      _extenty        =   1085
   End
End
Attribute VB_Name = "FormMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
ACBrECF1.Porta = "COM1"
ACBrECF1.Modelo = ACBrModeloECF.Bematech

Dim ModeloStr As String
ModeloStr = ACBrECF1.ModeloStr

Dim portaStr As String
portaStr = ACBrECF1.Porta

ACBrECF1.Ativar

End Sub
