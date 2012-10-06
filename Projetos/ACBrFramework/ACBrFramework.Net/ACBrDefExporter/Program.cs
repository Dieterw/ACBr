using System;
using System.Reflection;
using System.Windows.Forms;

using ACBrFramework;

namespace ACBrDefExporter
{
	internal static class Program
	{
		[STAThread]
		private static void Main()
		{
			Application.EnableVisualStyles();
			Application.SetCompatibleTextRenderingDefault(false);
			Application.Run(new MainForm());
		}
	}
}