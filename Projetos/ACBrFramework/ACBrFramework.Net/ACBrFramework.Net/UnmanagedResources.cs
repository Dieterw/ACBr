using System;
using System.IO;
using System.Reflection;

namespace ACBrFramework
{
	internal static class UnmanagedResources
	{
		internal static string BinPath { get; private set; }

		public static void Extract()
		{
			BinPath = GetTempPath("ACBrFramework");

			try
			{
#if x86

				File.WriteAllBytes(Path.Combine(BinPath, "ACBrFramework32.dll"), Properties.Framework32.ACBrFramework32);
#elif x64
			File.WriteAllBytes(Path.Combine(BinPath, "ACBrFramework64.dll"), Properties.Framework64.ACBrFramework64);
#endif
			}
			catch { }

			AppendPathVar(BinPath);
		}

		private static string GetTempPath(string folderName)
		{
			string tempPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
			string path = Path.Combine(tempPath, folderName);

			Assembly entryAssembly = Assembly.GetEntryAssembly();
			if (entryAssembly != null)
			{
				AssemblyName entryAssemblyName = entryAssembly.GetName();
				path = Path.Combine(path, entryAssemblyName.Name);
			}

			if (!Directory.Exists(path)) Directory.CreateDirectory(path);

			return path;
		}

		private static void AppendPathVar(string pathToAppend)
		{
			#region Comments

			//Adiciona o caminho ao PATH do Windows, para resolver as DLLs nativas

			#endregion Comments

			string pathVar = Environment.GetEnvironmentVariable("PATH", EnvironmentVariableTarget.Process) ?? string.Empty;
			pathVar = string.Format("{0};{1};", pathVar, pathToAppend);

			Environment.SetEnvironmentVariable("PATH", pathVar, EnvironmentVariableTarget.Process);
		}
	}
}