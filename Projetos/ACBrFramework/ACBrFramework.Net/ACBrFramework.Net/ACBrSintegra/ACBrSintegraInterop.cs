using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ACBrFramework
{
	public static class ACBrSintegraInterop
	{
		#region DLL

#if x86
		private const string ACBr = "ACBrFramework32.dll";
#elif x64
				private const string ACBr = "ACBrFramework64.dll";
#endif

		#endregion DLL

		#region ACBrSintegra

		#region Interop Types

		[StructLayout(LayoutKind.Sequential)]
		public struct Registro10Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CNPJ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string Inscricao;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 36)]
			public string RazaoSocial;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 31)]
			public string Cidade;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string Estado;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 11)]
			public string Telefone;

			[MarshalAs(UnmanagedType.R8)]
			public double DataInicial;

			[MarshalAs(UnmanagedType.R8)]
			public double DataFinal;

			[MarshalAs(UnmanagedType.I4)]
			public int CodigoConvenio;

			[MarshalAs(UnmanagedType.I4)]
			public int NaturezaInformacoes;

			[MarshalAs(UnmanagedType.I4)]
			public int FinalidadeArquivo;
		}

		#endregion Interop Types

		#region Propriedades do Componente

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_GetFileName(IntPtr sinHandle, StringBuilder buffer, int bufferLen);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_SetFileName(IntPtr sinHandle, string filename);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_GetVersaoValidador(IntPtr sinHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_SetVersaoValidador(IntPtr sinHandle, int Versao);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_GetAtivo(IntPtr sinHandle);

		#endregion Propriedades do Componente

		#region Constructors/Erro Handler

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_Create(ref IntPtr sinHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_Destroy(ref IntPtr sinHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_GetUltimoErro(IntPtr sinHandle, StringBuilder buffer, int bufferLen);

		#endregion Constructors/Erro Handler

		#region Methods

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_LimparRegistros(IntPtr sinHandle);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_Registro10(IntPtr sinHandle, Registro10Rec registro10);

		#endregion Methods

		#endregion ACBrSintegra
	}
}