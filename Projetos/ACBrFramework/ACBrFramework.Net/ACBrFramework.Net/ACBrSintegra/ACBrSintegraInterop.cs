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

		[StructLayout(LayoutKind.Sequential)]
		public struct Registro11Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 29)]
			public string Responsavel;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 14)]
			public string Bairro;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 9)]
			public string Cep;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 6)]
			public string Numero;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 23)]
			public string Complemento;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 35)]
			public string Endereco;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 13)]
			public string Telefone;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct Registro50Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CPFCNPJ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string Inscricao;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string UF;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string Situacao;
			
			[MarshalAs(UnmanagedType.R8)]
			public double Aliquota;
			
			[MarshalAs(UnmanagedType.R8)]
			public double Isentas;
			
			[MarshalAs(UnmanagedType.R8)]
			public double Icms;
			
			[MarshalAs(UnmanagedType.R8)]
			public double ValorContabil;
			
			[MarshalAs(UnmanagedType.R8)]
			public double BasedeCalculo;
			
			[MarshalAs(UnmanagedType.R8)]
			public double Outras;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string EmissorDocumento;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 5)]
			public string Cfop;			
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string Serie;			
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string Modelo;
			
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 7)]
			public string Numero;
			
			[MarshalAs(UnmanagedType.R8)]
			public double DataDocumento;
		}

		[StructLayout(LayoutKind.Sequential)]
		public struct Registro51Rec
		{
			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string CPFCNPJ;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 15)]
			public string Inscricao;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 3)]
			public string Estado;
	
			[MarshalAs(UnmanagedType.R8)]
			public double ValorIpi;
			
			[MarshalAs(UnmanagedType.R8)]
			public double ValorContabil;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
			public string Serie;

			[MarshalAs(UnmanagedType.R8)]
			public double DataDocumento;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 5)]
			public string Cfop;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 7)]
			public string Numero;

			[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 2)]
			public string Situacao;
			
			[MarshalAs(UnmanagedType.R8)]
			public double ValorIsentas ;

			[MarshalAs(UnmanagedType.R8)]
			public double ValorOutras;			
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

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_Registro11(IntPtr sinHandle, Registro11Rec registro11);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_Registro50(IntPtr sinHandle, Registro50Rec[] registro50, int count);

		[DllImport(ACBr, CallingConvention = CallingConvention.Cdecl)]
		public static extern int SIN_Registro51(IntPtr sinHandle, Registro51Rec[] registro51, int count);

		#endregion Methods

		#endregion ACBrSintegra
	}
}