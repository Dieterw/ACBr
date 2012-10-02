using System;
using System.IO;
using System.Linq;
using System.Reflection;

namespace ACBrDefExporter.C
{
	internal class DefExporter
	{
		#region Properties

		public string FilePath { get; private set; }

		public Type InteropType { get; private set; }

		#endregion Properties

		#region Constructor

		public DefExporter(string filePath, Type interopType)
		{
			this.FilePath = filePath;
			this.InteropType = interopType;
		}

		#endregion Constructor

		#region Methods

		public void Export()
		{
			using (StreamWriter writer = new StreamWriter(FilePath))
			{
				BeginDefines(writer);
				ExportTypes(writer);
				ExportMethods(writer);
				EndDefines(writer);

				writer.Flush();
			}
		}

		private void ExportTypes(StreamWriter writer)
		{
		}

		private void ExportMethods(StreamWriter writer)
		{
			FunctionExporter functionExporter = new FunctionExporter(writer);

			foreach (var method in GetMethods())
			{
				functionExporter.ExportMethod(method);
			}
		}

		private void BeginDefines(StreamWriter writer)
		{
			writer.WriteLine(@"#ifndef _ACBR_API_H_");
			writer.WriteLine(@"#define _ACBR_API_H_");
			writer.WriteLine();
			writer.WriteLine(@"#ifdef __cplusplus");
			writer.WriteLine(@"#define DllImport extern ""C""");
			writer.WriteLine(@"#else");
			writer.WriteLine(@"#define DllImport extern");
			writer.WriteLine(@"#endif");
			writer.WriteLine();
			writer.WriteLine("typedef void* ACBR_HANDLE;");
			writer.WriteLine("typedef char* PCHAR;");
			writer.WriteLine("typedef char BOOL;");
		}

		private void EndDefines(StreamWriter writer)
		{
			writer.WriteLine();
			writer.WriteLine("#endif");
		}

		private MethodInfo[] GetMethods()
		{
			var methods = InteropType.GetMethods(BindingFlags.Static | BindingFlags.Public);
			return methods.OrderBy(x => x.Name).ToArray();
		}

		private Type[] GetTypes()
		{
			var types = InteropType.GetNestedTypes(BindingFlags.Public | BindingFlags.NonPublic);
			return types.OrderBy(x => x.Name).ToArray();
		}

		#endregion Methods
	}
}