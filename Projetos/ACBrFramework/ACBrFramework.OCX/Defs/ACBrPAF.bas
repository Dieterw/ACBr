Attribute VB_Name = "ACBrPAFModule"
''
'' ACBrFramework DefExporter
'' Este arquivo foi gerado automaticamente
''


'' Tipos de dados

Public Type RegistroB2Rec
	BOMBA As String * 4
	BICO As String * 4
	DATA As Double
	HORA As Double
	MOTIVO As String * 51
	CNPJ_EMPRESA As String * 15
	CPF_TECNICO As String * 12
	NRO_LACRE_ANTES As String * 16
	NRO_LACRE_APOS As String * 16
	ENCERRANTE_ANTES As Double
	ENCERRANTE_APOS As Double
	RegistroValido As Boolean
End Type

Public Type RegistroC2Rec
	ID_ABASTECIMENTO As String * 16
	TANQUE As String * 4
	BOMBA As String * 4
	BICO As String * 4
	COMBUSTIVEL As String * 21
	DATA_ABASTECIMENTO As Double
	HORA_ABASTECIMENTO As Double
	ENCERRANTE_INICIAL As Double
	ENCERRANTE_FINAL As Double
	STATUS_ABASTECIMENTO As String * 11
	NRO_SERIE_ECF As String * 15
	DATA As Double
	HORA As Double
	COO As Long
	NRO_NOTA_FISCAL As Long
	VOLUME As Double
	RegistroValido As Boolean
End Type

Public Type RegistroD2Rec
	QTD_D3 As Long
	NUM_FAB As String * 21
	MF_ADICIONAL As String * 2
	TIPO_ECF As String * 8
	MARCA_ECF As String * 21
	MODELO_ECF As String * 21
	COO As String * 7
	NUM_DAV As String * 14
	DT_DAV As Double
	TIT_DAV As String * 31
	VLT_DAV As Double
	COO_DFV As String * 7
	NUMERO_ECF As String * 4
	NOME_CLIENTE As String * 41
	CPF_CNPJ As String * 15
	RegistroValido As Boolean
End Type

Public Type RegistroD3Rec
	DT_INCLUSAO As Double
	NUM_ITEM As Long
	COD_ITEM As String * 15
	DESC_ITEM As String * 101
	QTDE_ITEM As Double
	UNI_ITEM As String * 4
	VL_UNIT As Double
	VL_DESCTO As Double
	VL_ACRES As Double
	VL_TOTAL As Double
	DEC_VL_UNIT As Long
	DEC_QTDE_ITEM As Long
	SIT_TRIB As String * 2
	ALIQ As Double
	IND_CANC As String * 2
	RegistroValido As Boolean
End Type

Public Type RegistroE2Rec
	COD_MERC As String * 15
	DESC_MERC As String * 51
	UN_MED As String * 7
	QTDE_EST As Double
	RegistroValido As Boolean
End Type

Public Type RegistroH2Rec
	CNPJ_CRED_CARTAO As String * 15
	COO As Long
	CCF As Long
	VLR_TROCO As Double
	DT_TROCO As Double
	CPF As String * 15
	Titulo As String * 8
	RegistroValido As Boolean
End Type

Public Type RegistroHD1Rec
	RAZAOSOCIAL As String * 51
	UF As String * 3
	CNPJ As String * 15
	IE As String * 15
	IM As String * 15
End Type

Public Type RegistroHD2Rec
	RAZAOSOCIAL As String * 51
	UF As String * 3
	CNPJ As String * 15
	IE As String * 15
	IM As String * 15
	NUM_FAB As String * 21
	MF_ADICIONAL As String * 2
	TIPO_ECF As String * 8
	MARCA_ECF As String * 21
	MODELO_ECF As String * 21
	DT_EST As Double
	RegistroValido As Boolean
	InclusaoExclusao As Boolean
End Type

Public Type RegistroN2Rec
	QTD_N3 As Long
	LAUDO As String * 11
	NOME As String * 51
	VERSAO As String * 11
End Type

Public Type RegistroN3Rec
	NOME_ARQUIVO As String * 51
	MD5 As String * 33
End Type

Public Type RegistroP2Rec
	COD_MERC_SERV As String * 15
	DESC_MERC_SERV As String * 51
	UN_MED As String * 7
	IAT As String * 2
	IPPT As String * 2
	ST As String * 2
	ALIQ As Double
	VL_UNIT As Double
	RegistroValido As Boolean
End Type

Public Type RegistroR1Rec
	NUM_FAB As String * 21
	MF_ADICIONAL As String * 2
	TIPO_ECF As String * 8
	MARCA_ECF As String * 16
	MODELO_ECF As String * 21
	VERSAO_SB As String * 11
	DT_INST_SB As Double
	HR_INST_SB As Double
	NUM_SEQ_ECF As Long
	CNPJ As String * 15
	IE As String * 15
	CNPJ_SH As String * 15
	IE_SH As String * 15
	IM_SH As String * 15
	NOME_SH As String * 41
	NOME_PAF As String * 41
	VER_PAF As String * 11
	COD_MD5 As String * 33
	DT_INI As Double
	DT_FIN As Double
	ER_PAF_ECF As String * 5
	InclusaoExclusao As Boolean
	RegistroValido As Boolean
End Type

Public Type RegistroR2Rec
	QTD_R3 As Long
	NUM_USU As Long
	CRZ As Long
	COO As Long
	CRO As Long
	DT_MOV As Double
	DT_EMI As Double
	HR_EMI As Double
	VL_VBD As Double
	PAR_ECF As String * 2
	DT_FIN As Double
	RegistroValido As Boolean
End Type

Public Type RegistroR3Rec
	TOT_PARCIAL As String * 8
	VL_ACUM As Double
	RegistroValido As Boolean
End Type

Public Type RegistroR4Rec
	QTD_R5 As Long
	QTD_R7 As Long
	NUM_USU As Long
	NUM_CONT As Long
	COO As Long
	DT_INI As Double
	SUB_DOCTO As Double
	SUB_DESCTO As Double
	TP_DESCTO As String * 2
	SUB_ACRES As Double
	TP_ACRES As String * 2
	VL_TOT As Double
	CANC As String * 2
	VL_CA As Double
	ORDEM_DA As String * 2
	NOME_CLI As String * 41
	CNPJ_CPF As String * 15
	RegistroValido As Boolean
End Type

Public Type RegistroR5Rec
	NUM_ITEM As Long
	COD_ITEM As String * 15
	DESC_ITEM As String * 101
	QTDE_ITEM As Double
	UN_MED As String * 4
	VL_UNIT As Double
	DESCTO_ITEM As Double
	ACRES_ITEM As Double
	VL_TOT_ITEM As Double
	COD_TOT_PARC As String * 8
	IND_CANC As String * 2
	QTDE_CANC As Double
	VL_CANC As Double
	VL_CANC_ACRES As Double
	IAT As String * 2
	IPPT As String * 2
	QTDE_DECIMAL As Long
	VL_DECIMAL As Long
	RegistroValido As Boolean
End Type

Public Type RegistroR6Rec
	QTD_R7 As Long
	NUM_USU As Long
	COO As Long
	GNF As Long
	GRG As Long
	CDC As Long
	DENOM As String * 3
	DT_FIN As Double
	HR_FIN As Double
	RegistroValido As Boolean
End Type

Public Type RegistroR7Rec
	CCF As Long
	GNF As Long
	MP As String * 16
	VL_PAGTO As Double
	IND_EST As String * 2
	VL_EST As Double
	RegistroValido As Boolean
End Type


'' Funções

Public Declare Function PAF_AssinarArquivoComEAD Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Arquivo As String) As Long
Public Declare Function PAF_Create Lib "ACBrFramework32.DLL" (ByRef pafHandle As Long) As Long
Public Declare Function PAF_Destroy Lib "ACBrFramework32.DLL" (ByRef pafHandle As Long) As Long
Public Declare Function PAF_GetAssinarArquivo Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long) As Long
Public Declare Function PAF_GetChaveRSA Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function PAF_GetCurMascara Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function PAF_GetDelimitador Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function PAF_GetPath Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function PAF_GetTrimString Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long) As Long
Public Declare Function PAF_GetUltimoErro Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function PAF_SaveFileTXT_B Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegistroB1 As RegistroHD1Rec, ByRef RegistroB2() As RegistroB2Rec, ByVal CountB2 As Long, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_C Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegistroC1 As RegistroHD1Rec, ByRef RegistroC2() As RegistroC2Rec, ByVal CountC2 As Long, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_D Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegsitroD1Rec As RegistroHD1Rec, ByRef RegsitroD2Rec() As RegistroD2Rec, ByVal CountD2 As Long, ByRef RegsitroD3Rec() As RegistroD3Rec, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_E Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegsitroE1Rec As RegistroHD2Rec, ByRef RegsitroE2Rec() As RegistroE2Rec, ByVal CountE2 As Long, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_H Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegsitroH1Rec As RegistroHD2Rec, ByRef RegsitroH2Rec() As RegistroH2Rec, ByVal CountH2 As Long, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_N Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegsitroN1Rec As RegistroHD1Rec, ByVal RegsitroN2Rec As RegistroN2Rec, ByRef RegsitroN3Rec() As RegistroN3Rec, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_P Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegsitroP1Rec As RegistroHD1Rec, ByRef RegsitroP2Rec() As RegistroP2Rec, ByVal CountP2 As Long, ByVal Arquivo As String) As Long
Public Declare Function PAF_SaveFileTXT_R Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal RegsitroR1Rec As RegistroR1Rec, ByRef RegsitroR2Rec() As RegistroR2Rec, ByVal CountR2 As Long, ByRef RegsitroR3Rec() As RegistroR3Rec, ByRef RegsitroR4Rec() As RegistroR4Rec, ByVal CountR4 As Long, ByRef RegsitroP5Rec() As RegistroR5Rec, ByRef RegsitroR6Rec() As RegistroR6Rec, ByVal CountR6 As Long, ByRef RegsitroR7Rec() As RegistroR7Rec, ByVal Arquivo As String) As Long
Public Declare Function PAF_SetAAC Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal aacHandle As Long) As Long
Public Declare Function PAF_SetAssinarArquivo Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal Assinar As Boolean) As Long
Public Declare Function PAF_SetChaveRSA Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal chave As String) As Long
Public Declare Function PAF_SetCurMascara Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal CurMascara As String) As Long
Public Declare Function PAF_SetDelimitador Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal Delimitador As String) As Long
Public Declare Function PAF_SetEAD Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal eadHandle As Long) As Long
Public Declare Function PAF_SetPath Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal porta As String) As Long
Public Declare Function PAF_SetTrimString Lib "ACBrFramework32.DLL" (ByVal pafHandle As Long, ByVal TrimString As Boolean) As Long
