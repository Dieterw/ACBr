using System;
using System.Reflection;
using System.Windows.Forms;

using ACBr.Net;

namespace ACBrDefExporter
{
	internal static class Program
	{
		private static void Main()
		{
			//Tem como objetivo gerar um arquivo com as definições das funções, métodos e tipos
			//utilizados para o Interop com a ACBr.DLL
			//
			//No exemplo exporta em linguagem C/C++
			//Mas será possível exportar em C/C++, VB6 e xBase (Clipper, Harbour, FoxPro, etc)

			string filePath = @"C:\ACBrECF.h";
			Type ecfInterop = typeof(ACBrECFInterop);

			var exporter = new C.DefExporter(filePath, typeof(ACBrECFInterop));
			exporter.Export();
		}
	}
}