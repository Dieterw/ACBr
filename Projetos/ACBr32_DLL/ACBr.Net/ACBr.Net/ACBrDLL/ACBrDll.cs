using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ACBr.Net
{
	internal static class ACBrDll
	{
		private const string ACBr32 = "ACBr32.dll";

		#region ACBrECF

		#region Interop Types

		[StructLayout(LayoutKind.Sequential)]
		public struct AliquotaRec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string Indice;

			[MarshalAs(UnmanagedType.R8)]
			public double Aliquota;

			[MarshalAs(UnmanagedType.U1)]
			public char Tipo;

			[MarshalAs(UnmanagedType.R8)]
			public double Total;

			[MarshalAs(UnmanagedType.U1)]
			public byte Sequencia;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct DAVsRec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 14)]
			public string Numero;

			[MarshalAs(UnmanagedType.I4)]
			public int COO_Cupom;

			[MarshalAs(UnmanagedType.I4)]
			public int COO_Dav;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 31)]
			public string Titulo;

			[MarshalAs(UnmanagedType.R8)]
			public double Valor;

			[MarshalAs(UnmanagedType.R8)]
			public double DtEmissao;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct FormaPagamentoRec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string Indice;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string Descricao;

			[MarshalAs(UnmanagedType.U1)]
			public bool PermiteVinculado;

			[MarshalAs(UnmanagedType.R8)]
			public double Total;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct ComprovanteNaoFiscalRec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string Indice;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string Descricao;

			[MarshalAs(UnmanagedType.U1)]
			public bool PermiteVinculado;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string FormaPagamento;

			[MarshalAs(UnmanagedType.R8)]
			public double Total;

			[MarshalAs(UnmanagedType.I4)]
			public int Contador;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RelatorioGerencialRec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string Indice;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string Descricao;

			[MarshalAs(UnmanagedType.I4)]
			public int Contador;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct DadosRZRec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int COO;

			[MarshalAs(UnmanagedType.I4)]
			public int CFD;

			[MarshalAs(UnmanagedType.R8)]
			public double CancelamentoISSQN;

			[MarshalAs(UnmanagedType.I4)]
			public int GNFC;

			[MarshalAs(UnmanagedType.I4)]
			public int CRO;

			[MarshalAs(UnmanagedType.R8)]
			public double ValorVendaBruta;

			public IntPtr TotalizadoresNaoFiscais;

			[MarshalAs(UnmanagedType.I4)]
			public int TotalizadoresNaoFiscaisLen;

			public IntPtr ICMS;

			[MarshalAs(UnmanagedType.I4)]
			public int ICMSLen;

			[MarshalAs(UnmanagedType.R8)]
			public double AcrescimoICMS;

			[MarshalAs(UnmanagedType.R8)]
			public double DescontoICMS;

			[MarshalAs(UnmanagedType.R8)]
			public double NaoTributadoICMS;

			public IntPtr RelatorioGerencial;

			[MarshalAs(UnmanagedType.I4)]
			public int RelatorioGerencialLen;

			[MarshalAs(UnmanagedType.I4)]
			public int CRZ;

			public IntPtr ISSQN;

			[MarshalAs(UnmanagedType.I4)]
			public int ISSQNLen;

			[MarshalAs(UnmanagedType.I4)]
			public int GRG;

			[MarshalAs(UnmanagedType.R8)]
			public double ValorGrandeTotal;

			[MarshalAs(UnmanagedType.R8)]
			public double AcrescimoISSQN;

			[MarshalAs(UnmanagedType.R8)]
			public double NaoTributadoISSQN;

			[MarshalAs(UnmanagedType.R8)]
			public double IsentoICMS;

			[MarshalAs(UnmanagedType.R8)]
			public double SubstituicaoTributariaICMS;

			[MarshalAs(UnmanagedType.R8)]
			public double DataDaImpressora;

			[MarshalAs(UnmanagedType.R8)]
			public double TotalOperacaoNaoFiscal;

			[MarshalAs(UnmanagedType.R8)]
			public double DescontoISSQN;

			[MarshalAs(UnmanagedType.R8)]
			public double CancelamentoOPNF;

			[MarshalAs(UnmanagedType.R8)]
			public double AcrescimoOPNF;

			[MarshalAs(UnmanagedType.R8)]
			public double DescontoOPNF;

			[MarshalAs(UnmanagedType.R8)]
			public double CancelamentoICMS;

			[MarshalAs(UnmanagedType.I4)]
			public int GNF;

			[MarshalAs(UnmanagedType.R8)]
			public double IsentoISSQN;

			[MarshalAs(UnmanagedType.R8)]
			public double SubstituicaoTributariaISSQN;

			[MarshalAs(UnmanagedType.R8)]
			public double VendaLiquida;

			[MarshalAs(UnmanagedType.I4)]
			public int CFC;

			[MarshalAs(UnmanagedType.I4)]
			public int CCF;

			[MarshalAs(UnmanagedType.R8)]
			public double TotalISSQN;

			[MarshalAs(UnmanagedType.R8)]
			public double TotalICMS;

			[MarshalAs(UnmanagedType.I4)]
			public int CDC;

			[MarshalAs(UnmanagedType.I4)]
			public int CCDC;

			[MarshalAs(UnmanagedType.I4)]
			public int NCN;

			[MarshalAs(UnmanagedType.R8)]
			public double DataDoMovimento;

			public IntPtr MeiosDePagamento;

			[MarshalAs(UnmanagedType.I4)]
			public int MeiosDePagamentoLen;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string NumeroCOOInicial;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string NumeroDoECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string NumeroDeSerie;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string NumeroDeSerieMFD;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string NumeroDaLoja;

			[MarshalAs(UnmanagedType.R8)]
			public double TotalTroco;
		}

		#endregion Interop Types

		#region Constructors/Erro Handler

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_Create(ref IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_Destroy(ref IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetUltimoErro(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Ativar/Desativar

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_Ativar(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_Desativar(IntPtr ecfHandle);

		#endregion Ativar/Desativar

		#region Métodos ECF
		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AcharECF(IntPtr ecfHandle, Boolean Modelo, Boolean Porta, int TimeOut);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AcharPorta(IntPtr ecfHandle, int TimeOut);
		#endregion

		#region Propriedades do Componente

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetModelo(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetModelo(IntPtr ecfHandle, int modelo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetPorta(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetPorta(IntPtr ecfHandle, string porta);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetBaud(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetBaud(IntPtr ecfHandle, int baud);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDataBits(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetDataBits(IntPtr ecfHandle, int dataBits);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetParity(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetParity(IntPtr ecfHandle, int parity);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetStopBits(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetStopBits(IntPtr ecfHandle, int stopBits);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetHandShake(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetHandShake(IntPtr ecfHandle, int handShake);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetHardFlow(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetHardFlow(IntPtr ecfHandle, bool hardFlow);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetSoftFlow(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetSoftFlow(IntPtr ecfHandle, bool softFlow);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTimeOut(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetTimeOut(IntPtr ecfHandle, int timeOut);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetAtivo(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetColunas(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetAguardandoResposta(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetComandoEnviado(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetRespostaComando(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetComandoLOG(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetComandoLOG(IntPtr ecfHandle, string comandoLog);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetAguardaImpressao(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetAguardaImpressao(IntPtr ecfHandle, bool aguardaImpressao);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetModeloStr(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetRFDID(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDataHora(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCupom(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCOO(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumLoja(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumECF(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumSerie(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumVersao(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDataMovimento(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDataHoraSB(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetCNPJ(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetIE(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetIM(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetCliche(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetUsuarioAtual(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetSubModeloECF(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetPAF(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCRZ(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCRO(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCCF(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumGNF(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumGRG(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCDC(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumCOOInicial(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetVendaBruta(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetGrandeTotal(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalCancelamentos(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalDescontos(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalAcrescimos(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalTroco(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalSubstituicaoTributaria(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalNaoTributado(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalIsencao(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalCancelamentosISSQN(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalDescontosISSQN(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalAcrescimosISSQN(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalSubstituicaoTributariaISSQN(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalNaoTributadoISSQN(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalIsencaoISSQN(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalNaoFiscal(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetNumUltItem(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetEmLinha(IntPtr ecfHandle, int timeOut);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetPoucoPapel(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetEstado(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetHorarioVerao(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetArredonda(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTermica(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetMFD(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetIdentificaConsumidorRodape(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetSubTotal(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetTotalPago(IntPtr ecfHandle, ref double value);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetGavetaAberta(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetChequePronto(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetIntervaloAposComando(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetIntervaloAposComando(IntPtr ecfHandle, int intervalo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDescricaoGrande(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetDescricaoGrande(IntPtr ecfHandle, bool descricaoGrande);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetGavetaSinalInvertido(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetGavetaSinalInvertido(IntPtr ecfHandle, bool gavetaSinalInvertido);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetOperador(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetOperador(IntPtr ecfHandle, string operador);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetLinhasEntreCupons(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetLinhasEntreCupons(IntPtr ecfHandle, int linhasEntreCupons);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDecimaisPreco(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetDecimaisPreco(IntPtr ecfHandle, int decimaisPreco);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDecimaisQtd(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetDecimaisQtd(IntPtr ecfHandle, int decimaisQtd);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDadosReducaoZ(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDadosUltimaReducaoZ(IntPtr ecfHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetDadosReducaoZClass(IntPtr ecfHandle, out IntPtr dadosRZ);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_DestroyDadosReducaoZClass(IntPtr ecfHandle, ref IntPtr dadosRZ);

		#endregion Propriedades do Componente

		#region Cupom Fiscal

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_IdentificaConsumidor(IntPtr ecfHandle, string cpfCnpj, string nome, string endereco);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AbreCupom(IntPtr ecfHandle, string cpfCnpj, string nome, string endereco);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LegendaInmetroProximoItem(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_VendeItem(IntPtr ecfHandle, string codigo, string descricao, string aliquotaICMS, double qtd, double valorUnitario, double descontoPorc, string unidade, string tipoDescontoAcrescimo, string descontoAcrescimo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_DescontoAcrescimoItemAnterior(IntPtr ecfHandle, double valorDescontoAcrescimo, string descontoAcrescimo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SubtotalizaCupom(IntPtr ecfHandle, double descontoAcrescimo, string mensagemRodape);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_EfetuaPagamento(IntPtr ecfHandle, string codFormaPagto, double valor, string observacao, bool imprimeVinculado);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_EstornaPagamento(IntPtr ecfHandle, string codFormaPagtoEstornar, string codFormaPagtoEfetivar, double valor, string observacao);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_FechaCupom(IntPtr ecfHandle, string observacao);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CancelaCupom(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CancelaItemVendido(IntPtr ecfHandle, int numItem);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CancelaItemVendidoParcial(IntPtr ecfHandle, int numItem, double quantidade);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CancelaDescontoAcrescimoItem(IntPtr ecfHandle, int numItem);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CancelaDescontoAcrescimoSubTotal(IntPtr ecfHandle, char tipoAcrescimoDesconto);

		#endregion Cupom Fiscal

		#region DAV

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_DAV_Abrir(IntPtr ecfHandle, double emissao, string decrdocumento, string numero, string situacao, string vendedor, string observacao, string cpfCnpj, string nome, string endereco);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_DAV_Fechar(IntPtr ecfHandle, string observacao);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_DAV_RegistrarItem(IntPtr ecfHandle, string codigo, string descricao, string unidade, double quantidade, double vlrunitario, double desconto, double acrescimo, bool cancelado);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_RelDAVEmitidos(IntPtr ecfHandle, DAVsRec[] DAVs, int index, string TituloRelatorio, string IndiceRelatorio);

		#endregion DAV

		#region PAF

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_RelMeiosPagamento(IntPtr ecfHandle, FormaPagamentoRec[] formasPagamento, int count, string TituloRelatorio, int IndiceRelatorio);

		#endregion PAF

		#region PAF

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_GerarCAT52(IntPtr ecfHandle, double DataInicial, double DataFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LX_Impressao(IntPtr ecfHandle);

		#endregion PAF

		#region PAF LMFC

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFC_Cotepe1704(IntPtr ecfHandle, double DataInicial, double DataFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFC_Cotepe1704_CRZ(IntPtr ecfHandle, int CRZInicial, int CRZFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFC_Espelho(IntPtr ecfHandle, double DataInicial, double DataFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFC_Espelho_CRZ(IntPtr ecfHandle, int CRZInicial, int CRZFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFC_Impressao(IntPtr ecfHandle, double DataInicial, double DataFinal);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFC_Impressao_CRZ(IntPtr ecfHandle, int CRZInicial, int CRZFinal);

		#endregion PAF LMFC

		#region PAF LMFS

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFS_Espelho(IntPtr ecfHandle, double DataInicial, double DataFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFS_Espelho_CRZ(IntPtr ecfHandle, int CRZInicial, int CRZFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFS_Impressao(IntPtr ecfHandle, double DataInicial, double DataFinal);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_LMFS_Impressao_CRZ(IntPtr ecfHandle, int CRZInicial, int CRZFinal);

		#endregion PAF LMFS

		#region PAF Espelho MFD

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_MFD_Cotepe1704(IntPtr ecfHandle, double DataInicial, double DataFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_MFD_Cotepe1704_COO(IntPtr ecfHandle, int COOInicial, int COOFinal, string CaminhoArquivo);

		#endregion PAF Espelho MFD

		#region PAF Arq. MFD

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_MFD_Espelho(IntPtr ecfHandle, double DataInicial, double DataFinal, string CaminhoArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PafMF_MFD_Espelho_COO(IntPtr ecfHandle, int COOInicial, int COOFinal, string CaminhoArquivo);

		#endregion PAF Arq. MFD

		#region Relatórios

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraX(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_ReducaoZ(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AbreRelatorioGerencial(IntPtr ecfHandle, int indice);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LinhaRelatorioGerencial(IntPtr ecfHandle, string linha, int indiceBMP);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AbreCupomVinculado(IntPtr ecfHandle, string coo, string codFormaPagto, double valor);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AbreCupomVinculadoCNF(IntPtr ecfHandle, string coo, string codFormaPagto, string codComprovanteNaoFiscal, double valor);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LinhaCupomVinculado(IntPtr ecfHandle, string linha);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_FechaRelatorio(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_PulaLinhas(IntPtr ecfHandle, int numLinhas);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CortaPapel(IntPtr ecfHandle, bool corteParcial);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_IdentificaPAF(IntPtr ecfHandle, string nomeVersao, string md5);

		#endregion Relatórios

		#region Cupom Não Fiscal

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AbreNaoFiscal(IntPtr ecfHandle, string cpfCnpj);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_RegistraItemNaoFiscal(IntPtr ecfHandle, string codCNF, double value, string obs);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SubtotalizaNaoFiscal(IntPtr ecfHandle, double descontoAcrescimo, string mensagemRodape);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_EfetuaPagamentoNaoFiscal(IntPtr ecfHandle, string codFormaPagto, double valor, string observacao, bool imprimeVinculado);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_FechaNaoFiscal(IntPtr ecfHandle, string observacao);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CancelaNaoFiscal(IntPtr ecfHandle);

		#endregion Cupom Não Fiscal

		#region Alíquotas

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetAliquota(IntPtr ecfHandle, ref AliquotaRec aliquota, int index);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CarregaAliquotas(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LerTotaisAliquota(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_ProgramaAliquota(IntPtr ecfHandle, double aliquota, char tipo, string posicao);

		#endregion Alíquotas

		#region Formas de Pagto

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetFormaPagamento(IntPtr ecfHandle, ref FormaPagamentoRec formaPagamento, int index);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CarregaFormasPagamento(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LerTotaisFormaPagamento(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_ProgramaFormaPagamento(IntPtr ecfHandle, string descricao, bool permiteVinculado, string posicao);

		#endregion Formas de Pagto

		#region Comprovante não fiscal

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_GetComprovanteNaoFiscal(IntPtr ecfHandle, ref ComprovanteNaoFiscalRec comprovanteNaoFiscal, int index);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CarregaComprovantesNaoFiscais(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LerTotaisComprovanteNaoFiscal(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_ProgramaComprovanteNaoFiscal(IntPtr ecfHandle, string descricao, string tipo, string posicao);

		#endregion Comprovante não fiscal

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_Sangria(IntPtr ecfHandle, double valor, string obs);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_Suprimento(IntPtr ecfHandle, double valor, string obs);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_AbreGaveta(IntPtr ecfHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_CorrigeEstadoErro(IntPtr ecfHandle, bool reducaoZ);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraMemoriaFiscalReducao(IntPtr ecfHandle, int reducaoInicial, int reducaoFinal, bool simplificada);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraMemoriaFiscalData(IntPtr ecfHandle, double dataInicial, double dataFinal, bool simplificada);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraMemoriaFiscalSerialReducao(IntPtr ecfHandle, int reducaoInicial, int reducaoFinal, bool simplificada, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraMemoriaFiscalSerialData(IntPtr ecfHandle, double dataInicial, double dataFinal, bool simplificada, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraMemoriaFiscalArquivoReducao(IntPtr ecfHandle, int reducaoInicial, int reducaoFinal, string nomeArquivo, bool simplificada);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_LeituraMemoriaFiscalArquivoData(IntPtr ecfHandle, double dataInicial, double dataFinal, string nomeArquivo, bool simplificada);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int ECF_SetAAC(IntPtr ecfHandle, IntPtr aacHandle);

		#endregion ACBrECF

		#region ACBrEAD

		#region Constructors/Erro Handler

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_Create(ref IntPtr eadHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_Destroy(ref IntPtr eadHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_GetUltimoErro(IntPtr eadHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Methods

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_GerarChaves(IntPtr eadHandle, StringBuilder ChavePUB, StringBuilder ChavePRI, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_CalcularModuloeExpoente(IntPtr eadHandle, StringBuilder Modulo, StringBuilder Expoente, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_GerarXMLeECFc(IntPtr eadHandle, String NomeSH, String PathArquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_GerarXMLeECFc_NP(IntPtr eadHandle, String NomeSH);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_ConverteXMLeECFcParaOpenSSL(IntPtr eadHandle, String Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_CalcularHashArquivo(IntPtr eadHandle, String ChavePUB, int Hash);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_CalcularEADArquivo(IntPtr eadHandle, String Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_AssinarArquivoComEAD(IntPtr eadHandle, String Arquivo, bool Remove);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int EAD_VerificarEADArquivo(IntPtr eadHandle, String Arquivo);

		#endregion Methods

		#endregion ACBrEAD

		#region ACBrPAF

		#region Interop Types

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroHD1Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 51)]
			public string RAZAOSOCIAL;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string UF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IE;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IM;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroHD2Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 51)]
			public string RAZAOSOCIAL;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string UF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IE;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string NUM_FAB;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string MF_ADICIONAL;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
			public string TIPO_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string MARCA_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string MODELO_ECF;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_EST;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;

			[MarshalAs(UnmanagedType.U1)]
			public bool InclusaoExclusao;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroC2Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
			public string ID_ABASTECIMENTO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string TANQUE;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string BOMBA;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string BICO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string COMBUSTIVEL;

			[MarshalAs(UnmanagedType.R8)]
			public double DATA_ABASTECIMENTO;

			[MarshalAs(UnmanagedType.R8)]
			public double HORA_ABASTECIMENTO;

			[MarshalAs(UnmanagedType.R8)]
			public double ENCERRANTE_INICIAL;

			[MarshalAs(UnmanagedType.R8)]
			public double ENCERRANTE_FINAL;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 11)]
			public string STATUS_ABASTECIMENTO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string NRO_SERIE_ECF;

			[MarshalAs(UnmanagedType.R8)]
			public double DATA;

			[MarshalAs(UnmanagedType.R8)]
			public double HORA;

			[MarshalAs(UnmanagedType.I4)]
			public int COO;

			[MarshalAs(UnmanagedType.I4)]
			public int NRO_NOTA_FISCAL;

			[MarshalAs(UnmanagedType.R8)]
			public double VOLUME;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroD2Rec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int QTD_D3;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string NUM_FAB;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string MF_ADICIONAL;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
			public string TIPO_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string MARCA_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string MODELO_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 7)]
			public string COO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 14)]
			public string NUM_DAV;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_DAV;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 31)]
			public string TIT_DAV;

			[MarshalAs(UnmanagedType.R8)]
			public double VLT_DAV;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 7)]
			public string COO_DFV;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string NUMERO_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 41)]
			public string NOME_CLIENTE;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CPF_CNPJ;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroD3Rec
		{
			[MarshalAs(UnmanagedType.R8)]
			public double DT_INCLUSAO;

			[MarshalAs(UnmanagedType.I4)]
			public int NUM_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string COD_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 101)]
			public string DESC_ITEM;

			[MarshalAs(UnmanagedType.R8)]
			public double QTDE_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string UNI_ITEM;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_UNIT;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_DESCTO;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_ACRES;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_TOTAL;

			[MarshalAs(UnmanagedType.I4)]
			public int DEC_VL_UNIT;

			[MarshalAs(UnmanagedType.I4)]
			public int DEC_QTDE_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string SIT_TRIB;

			[MarshalAs(UnmanagedType.R8)]
			public double ALIQ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IND_CANC;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroE2Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string COD_MERC;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 51)]
			public string DESC_MERC;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 7)]
			public string UN_MED;

			[MarshalAs(UnmanagedType.R8)]
			public double QTDE_EST;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroH2Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ_CRED_CARTAO;

			[MarshalAs(UnmanagedType.I4)]
			public int COO;

			[MarshalAs(UnmanagedType.I4)]
			public int CCF;

			[MarshalAs(UnmanagedType.R8)]
			public double VLR_TROCO;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_TROCO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CPF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
			public string Titulo;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroP2Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string COD_MERC_SERV;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 51)]
			public string DESC_MERC_SERV;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 7)]
			public string UN_MED;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IAT;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IPPT;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string ST;

			[MarshalAs(UnmanagedType.R8)]
			public double ALIQ;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_UNIT;

			[MarshalAs(UnmanagedType.U1)]
			public bool RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR1Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string NUM_FAB;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string MF_ADICIONAL;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
			public string TIPO_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
			public string MARCA_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
			public string MODELO_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 11)]
			public string VERSAO_SB;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_INST_SB;

			[MarshalAs(UnmanagedType.R8)]
			public double HR_INST_SB;

			[MarshalAs(UnmanagedType.I4)]
			public int NUM_SEQ_ECF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IE;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ_SH;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IE_SH;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string IM_SH;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 41)]
			public string NOME_SH;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 41)]
			public string NOME_PAF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 11)]
			public string VER_PAF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 33)]
			public string COD_MD5;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_INI;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_FIN;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 5)]
			public string ER_PAF_ECF;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean InclusaoExclusao;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR2Rec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int QTD_R3;

			[MarshalAs(UnmanagedType.I4)]
			public int NUM_USU;

			[MarshalAs(UnmanagedType.I4)]
			public int CRZ;

			[MarshalAs(UnmanagedType.I4)]
			public int COO;

			[MarshalAs(UnmanagedType.I4)]
			public int CRO;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_MOV;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_EMI;

			[MarshalAs(UnmanagedType.R8)]
			public double HR_EMI;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_VBD;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string PAR_ECF;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_FIN;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR3Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
			public string TOT_PARCIAL;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_ACUM;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR4Rec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int QTD_R5;

			[MarshalAs(UnmanagedType.I4)]
			public int QTD_R7;

			[MarshalAs(UnmanagedType.I4)]
			public int NUM_USU;

			[MarshalAs(UnmanagedType.I4)]
			public int NUM_CONT;

			[MarshalAs(UnmanagedType.I4)]
			public int COO;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_INI;

			[MarshalAs(UnmanagedType.R8)]
			public double SUB_DOCTO;

			[MarshalAs(UnmanagedType.R8)]
			public double SUB_DESCTO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string TP_DESCTO;

			[MarshalAs(UnmanagedType.R8)]
			public double SUB_ACRES;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string TP_ACRES;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_TOT;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string CANC;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_CA;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string ORDEM_DA;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 41)]
			public string NOME_CLI;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ_CPF;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR5Rec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int NUM_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string COD_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 101)]
			public string DESC_ITEM;

			[MarshalAs(UnmanagedType.R8)]
			public double QTDE_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string UN_MED;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_UNIT;

			[MarshalAs(UnmanagedType.R8)]
			public double DESCTO_ITEM;

			[MarshalAs(UnmanagedType.R8)]
			public double ACRES_ITEM;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_TOT_ITEM;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
			public string COD_TOT_PARC;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IND_CANC;

			[MarshalAs(UnmanagedType.R8)]
			public double QTDE_CANC;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_CANC;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_CANC_ACRES;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IAT;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IPPT;

			[MarshalAs(UnmanagedType.I4)]
			public int QTDE_DECIMAL;

			[MarshalAs(UnmanagedType.I4)]
			public int VL_DECIMAL;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR6Rec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int QTD_R7;

			[MarshalAs(UnmanagedType.I4)]
			public int NUM_USU;

			[MarshalAs(UnmanagedType.I4)]
			public int COO;

			[MarshalAs(UnmanagedType.I4)]
			public int GNF;

			[MarshalAs(UnmanagedType.I4)]
			public int GRG;

			[MarshalAs(UnmanagedType.I4)]
			public int CDC;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string DENOM;

			[MarshalAs(UnmanagedType.R8)]
			public double DT_FIN;

			[MarshalAs(UnmanagedType.R8)]
			public double HR_FIN;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct RegistroR7Rec
		{
			[MarshalAs(UnmanagedType.I4)]
			public int CCF;

			[MarshalAs(UnmanagedType.I4)]
			public int GNF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
			public string MP;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_PAGTO;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string IND_EST;

			[MarshalAs(UnmanagedType.R8)]
			public double VL_EST;

			[MarshalAs(UnmanagedType.U1)]
			public Boolean RegistroValido;
		}

		#endregion Interop Types

		#region Constructors/Erro Handler

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_Create(ref IntPtr pafHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_Destroy(ref IntPtr pafHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_GetUltimoErro(IntPtr pafHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Propriedades do Componente

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_GetPath(IntPtr pafHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SetPath(IntPtr pafHandle, string porta);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_GetDelimitador(IntPtr pafHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SetDelimitador(IntPtr pafHandle, string Delimitador);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_GetCurMascara(IntPtr pafHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SetCurMascara(IntPtr pafHandle, string CurMascara);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_GetTrimString(IntPtr pafHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SetTrimString(IntPtr pafHandle, Boolean TrimString);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_GetAssinarArquivo(IntPtr pafHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SetAssinarArquivo(IntPtr pafHandle, Boolean Assinar);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SetAAC(IntPtr pafHandle, IntPtr aacHandle);

		#endregion Propriedades do Componente

		#region SaveFile

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SaveFileTXT_C(IntPtr pafHandle, RegistroHD1Rec RegistroC1, RegistroC2Rec[] RegistroC2, int CountC2, string Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SaveFileTXT_D(IntPtr pafHandle, RegistroHD1Rec RegsitroD1Rec, RegistroD2Rec[] RegsitroD2Rec, int CountD2, RegistroD3Rec[] RegsitroD3Rec, string Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SaveFileTXT_E(IntPtr pafHandle, RegistroHD2Rec RegsitroE1Rec, RegistroE2Rec[] RegsitroE2Rec, int CountE2, string Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SaveFileTXT_H(IntPtr pafHandle, RegistroHD2Rec RegsitroH1Rec, RegistroH2Rec[] RegsitroH2Rec, int CountH2, string Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SaveFileTXT_P(IntPtr pafHandle, RegistroHD1Rec RegsitroP1Rec, RegistroP2Rec[] RegsitroP2Rec, int CountP2, string Arquivo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int PAF_SaveFileTXT_R(IntPtr pafHandle, RegistroR1Rec RegsitroR1Rec, RegistroR2Rec[] RegsitroR2Rec, int CountR2, RegistroR3Rec[] RegsitroR3Rec, RegistroR4Rec[] RegsitroR4Rec, int CountR4, RegistroR5Rec[] RegsitroP5Rec, RegistroR6Rec[] RegsitroR6Rec, int CountR6, RegistroR7Rec[] RegsitroR7Rec, string Arquivo);

		#endregion SaveFile

		#endregion ACBrPAF

		#region ACBrACC

		#region Interop Types

		[StructLayout(LayoutKind.Sequential)]
		public struct TECFAutorizado
		{
			[MarshalAs(UnmanagedType.R8)]
			public double ValorGT;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
			public string NumeroSerie;

			[MarshalAs(UnmanagedType.I4)]
			public int CRO;

			[MarshalAs(UnmanagedType.I4)]
			public int CNI;

			[MarshalAs(UnmanagedType.R8)]
			public double DtHrAtualizado;
		}

		#endregion Interop Types

		#region Constructors/Erro Handler

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_Create(ref IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_Destroy(ref IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetUltimoErro(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Métodos do Componente

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_AbrirArquivo(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SalvarArquivo(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_VerificarGTECF(IntPtr aacHandle, string numSerie, ref double grandTotal);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_AtualizarValorGT(IntPtr aacHandle, string numSerie, ref double grandTotal);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetNomeArquivoAux(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetNomeArquivoAux(IntPtr aacHandle, string caminho);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetChave(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetChave(IntPtr aacHandle, string chave);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetArqLOG(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetArqLOG(IntPtr aacHandle, string caminho);

		#region ECFs Autorizadas

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_Clear(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_New(IntPtr aacHandle, TECFAutorizado ecfAutorizado);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_Get(IntPtr aacHandle, ref TECFAutorizado retAutorizado, int index);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_Count(IntPtr aacHandle);

		#endregion ECFs Autorizadas

		#endregion Métodos do Componente

		#region Propriedades do Componente

		#region Identificação do PAF

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_GetNumeroLaudo(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_SetNumeroLaudo(IntPtr aacHandle, string razaoSocial);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_GetVersaoER(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_SetVersaoER(IntPtr aacHandle, string razaoSocial);

		#endregion Identificação do PAF

		#region Dados da SoftwareHouse

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetRazaoSocial(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetRazaoSocial(IntPtr aacHandle, string razaoSocial);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetCNPJ(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetCNPJ(IntPtr aacHandle, string cnpj);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetIE(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetIE(IntPtr aacHandle, string ie);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetIM(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetIM(IntPtr aacHandle, string im);

		#endregion Dados da SoftwareHouse

		#region Dados do Aplicativo

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetNome(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetNome(IntPtr aacHandle, string nome);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetLinguagem(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetLinguagem(IntPtr aacHandle, string linguagem);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBancoDados(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBancoDados(IntPtr aacHandle, string banco);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetSistemaOperacional(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetSistemaOperacional(IntPtr aacHandle, string sistema);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetVersao(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetVersao(IntPtr aacHandle, string versao);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_GetNome(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_SetNome(IntPtr aacHandle, string exePrincipal);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_GetMD5(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_SetMD5(IntPtr aacHandle, string md5Exe);

		#endregion Dados do Aplicativo

		#region Dados de Funcionalidade

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTipoFuncionamento(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTipoFuncionamento(IntPtr aacHandle, int tipo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTipoDesenvolvimento(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTipoDesenvolvimento(IntPtr aacHandle, int tipo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetIntegracaoPafECF(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetIntegracaoPafECF(IntPtr aacHandle, int tipo);

		#endregion Dados de Funcionalidade

		#region Dados de Nao Concomitancia

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaPreVenda(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaPreVenda(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaDAVECF(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaDAVECF(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaDAVNaoFiscal(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaDAVNaoFiscal(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaDAVOS(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaDAVOS(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetDAVConfAnexoII(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetDAVConfAnexoII(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaLancamentoMesa(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaLancamentoMesa(IntPtr aacHandle, bool check);

		#endregion Dados de Nao Concomitancia

		#region Dados Aplicações Especiais

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetIndiceTecnicoProd(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetIndiceTecnicoProd(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBarSimilarECFRestaurante(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBarSimilarECFRestaurante(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBarSimilarECFComum(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBarSimilarECFComum(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBarSimilarBalanca(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBarSimilarBalanca(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetUsaImpressoraNaoFiscal(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetUsaImpressoraNaoFiscal(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetDAVDiscrFormula(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetDAVDiscrFormula(IntPtr aacHandle, bool check);

		#endregion Dados Aplicações Especiais

		#region Dados Criterios UF

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTotalizaValoresLista(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTotalizaValoresLista(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTransfPreVenda(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTransfPreVenda(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTransfDAV(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTransfDAV(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRecompoeGT(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRecompoeGT(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetEmitePED(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetEmitePED(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetCupomMania(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetCupomMania(IntPtr aacHandle, bool check);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetMinasLegal(IntPtr aacHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetMinasLegal(IntPtr aacHandle, bool check);

		#endregion Dados Criterios UF

		#region Dados Parametros

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetParams(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetParams(IntPtr aacHandle, string parametros);

		#endregion Dados Parametros

		#endregion Propriedades do Componente

		#endregion ACBrACC

		#region ACBrBal

		#region Constructors/Erro Handler

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_Create(ref IntPtr balHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_Destroy(ref IntPtr balHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetUltimoErro(IntPtr balHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Ativar/Desativar

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_Ativar(IntPtr balHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_Desativar(IntPtr balHandle);

		#endregion Ativar/Desativar

		#region Propriedades do Componente

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetModelo(IntPtr balHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_SetModelo(IntPtr balHandle, int modelo);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetModeloStr(IntPtr balHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetPorta(IntPtr balHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_SetPorta(IntPtr balHandle, string porta);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetAtivo(IntPtr balHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetUltimoPesoLido(IntPtr balHandle, ref double peso);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_GetUltimaResposta(IntPtr balHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int BAL_LePeso(IntPtr balHandle, int timeout, ref double peso);

		#endregion Propriedades do Componente

		#endregion ACBrBal

		#region ACBrLCB

		#region Constructors/Erro Handler

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_Create(ref IntPtr lcbHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_Destroy(ref IntPtr lcbHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_GetUltimoErro(IntPtr lcbHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Ativar/Desativar

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_Ativar(IntPtr lcbHandle);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_Desativar(IntPtr lcbHandle);

		#endregion Ativar/Desativar

		#region Propriedades do Componente

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_GetPorta(IntPtr lcbHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_SetPorta(IntPtr lcbHandle, string porta);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_GetAtivo(IntPtr lcbHandle);

		public delegate void TNotifyEvent(IntPtr p);

		[DllImport(ACBr32, CallingConvention = CallingConvention.Cdecl)]
		public static extern int LCB_SetOnLeCodigo(IntPtr lcbHandle, [MarshalAs(UnmanagedType.FunctionPtr)]TNotifyEvent method);

		#endregion Propriedades do Componente

		#endregion ACBrLCB
	}
}