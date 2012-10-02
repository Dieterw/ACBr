using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ACBrFramework.Net
{
	public static class ACBrAACInterop
	{
		#region DLL

#if x86
		private const string ACBr = "ACBrFramework32.dll";
#elif x64
				private const string ACBr = "ACBrFramework64.dll";
#endif

		#endregion DLL

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

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_Create(ref IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_Destroy(ref IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetUltimoErro(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Métodos do Componente

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_AbrirArquivo(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SalvarArquivo(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_VerificarGTECF(IntPtr aacHandle, string numSerie, ref double grandTotal);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_AtualizarValorGT(IntPtr aacHandle, string numSerie, ref double grandTotal);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetNomeArquivoAux(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetNomeArquivoAux(IntPtr aacHandle, string caminho);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetChave(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetChave(IntPtr aacHandle, string chave);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetArqLOG(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetArqLOG(IntPtr aacHandle, string caminho);

		#region ECFs Autorizadas

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_Clear(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_New(IntPtr aacHandle, TECFAutorizado ecfAutorizado);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_Get(IntPtr aacHandle, ref TECFAutorizado retAutorizado, int index);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_ECFsAutorizados_Count(IntPtr aacHandle);

		#endregion ECFs Autorizadas

		#endregion Métodos do Componente

		#region Propriedades do Componente

		#region Identificação do PAF

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_GetNumeroLaudo(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_SetNumeroLaudo(IntPtr aacHandle, string razaoSocial);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_GetVersaoER(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_SetVersaoER(IntPtr aacHandle, string razaoSocial);

		#endregion Identificação do PAF

		#region Dados da SoftwareHouse

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetRazaoSocial(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetRazaoSocial(IntPtr aacHandle, string razaoSocial);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetCNPJ(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetCNPJ(IntPtr aacHandle, string cnpj);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetIE(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetIE(IntPtr aacHandle, string ie);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_GetIM(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Empresa_SetIM(IntPtr aacHandle, string im);

		#endregion Dados da SoftwareHouse

		#region Dados do Aplicativo

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetNome(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetNome(IntPtr aacHandle, string nome);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetLinguagem(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetLinguagem(IntPtr aacHandle, string linguagem);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBancoDados(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBancoDados(IntPtr aacHandle, string banco);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetSistemaOperacional(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetSistemaOperacional(IntPtr aacHandle, string sistema);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetVersao(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetVersao(IntPtr aacHandle, string versao);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_GetNome(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_SetNome(IntPtr aacHandle, string exePrincipal);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_GetMD5(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_PrincipalExe_SetMD5(IntPtr aacHandle, string md5Exe);

		#endregion Dados do Aplicativo

		#region Dados de Funcionalidade

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTipoFuncionamento(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTipoFuncionamento(IntPtr aacHandle, int tipo);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTipoDesenvolvimento(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTipoDesenvolvimento(IntPtr aacHandle, int tipo);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetIntegracaoPafECF(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetIntegracaoPafECF(IntPtr aacHandle, int tipo);

		#endregion Dados de Funcionalidade

		#region Dados de Nao Concomitancia

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaPreVenda(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaPreVenda(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaDAVECF(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaDAVECF(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaDAVNaoFiscal(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaDAVNaoFiscal(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaDAVOS(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaDAVOS(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetDAVConfAnexoII(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetDAVConfAnexoII(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRealizaLancamentoMesa(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRealizaLancamentoMesa(IntPtr aacHandle, bool check);

		#endregion Dados de Nao Concomitancia

		#region Dados Aplicações Especiais

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetIndiceTecnicoProd(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetIndiceTecnicoProd(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBarSimilarECFRestaurante(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBarSimilarECFRestaurante(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBarSimilarECFComum(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBarSimilarECFComum(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetBarSimilarBalanca(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetBarSimilarBalanca(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetUsaImpressoraNaoFiscal(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetUsaImpressoraNaoFiscal(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetDAVDiscrFormula(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetDAVDiscrFormula(IntPtr aacHandle, bool check);

		#endregion Dados Aplicações Especiais

		#region Dados Criterios UF

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTotalizaValoresLista(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTotalizaValoresLista(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTransfPreVenda(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTransfPreVenda(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetTransfDAV(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetTransfDAV(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetRecompoeGT(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetRecompoeGT(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetEmitePED(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetEmitePED(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetCupomMania(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetCupomMania(IntPtr aacHandle, bool check);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_GetMinasLegal(IntPtr aacHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_IdentPaf_Paf_SetMinasLegal(IntPtr aacHandle, bool check);

		#endregion Dados Criterios UF

		#region Dados Parametros

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_GetParams(IntPtr aacHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int AAC_SetParams(IntPtr aacHandle, string parametros);

		#endregion Dados Parametros

		#endregion Propriedades do Componente

		#endregion ACBrACC
	}
}