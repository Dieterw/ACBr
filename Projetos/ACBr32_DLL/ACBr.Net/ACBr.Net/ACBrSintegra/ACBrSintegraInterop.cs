using System;
using System.Runtime.InteropServices;
using System.Text;

namespace ACBr.Net
{
	public static class ACBrSintegraInterop
	{
		#region DLL

#if x86
		private const string ACBr = "ACBr32.dll";
#elif x64
				private const string ACBr = "ACBr64.dll";
#endif

		#endregion DLL

		#region ACBrSintegra

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

		#endregion Methods

		#endregion ACBrSintegra
	}
}