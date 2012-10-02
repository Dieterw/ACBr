using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;

namespace ACBrDefExporter.C
{
	internal class FunctionExporter
	{
		#region Fields

		private static readonly Dictionary<Type, string> typeNames = new Dictionary<Type, string>();
		private StreamWriter writer;

		#endregion Fields

		#region Constructor

		static FunctionExporter()
		{
			typeNames[typeof(IntPtr)] = "ACBR_HANDLE";
			typeNames[typeof(Int16)] = "short";
			typeNames[typeof(Int32)] = "int";
			typeNames[typeof(Int64)] = "long";
			typeNames[typeof(Boolean)] = "BOOL";
			typeNames[typeof(Double)] = "double";
			typeNames[typeof(String)] = "PCHAR";
			typeNames[typeof(Char)] = "char";
			typeNames[typeof(StringBuilder)] = "PCHAR";
		}

		public FunctionExporter(StreamWriter writer)
		{
			this.writer = writer;
		}

		#endregion Constructor

		#region Methods

		public void ExportMethod(MethodInfo methodInfo)
		{
			StringBuilder parameters = new StringBuilder();
			foreach (var param in methodInfo.GetParameters())
			{
				if (parameters.Length > 0) parameters.Append(", ");

				string paramDeclaration = GetParamDeclaration(param);
				parameters.Append(paramDeclaration);
			}

			const string METHOD_DECLARATION = @"DllImport int {0}({1});";
			string methodDeclaration = string.Format(METHOD_DECLARATION, methodInfo.Name, parameters);

			writer.WriteLine(methodDeclaration);
		}

		private string GetParamDeclaration(ParameterInfo param)
		{
			Type type = param.ParameterType.IsArray ? param.ParameterType.GetElementType() : param.ParameterType;
			bool isByRef = type.IsByRef || param.IsRetval || param.IsOut;

			if (type.IsByRef) type = type.GetElementType();

			StringBuilder declaration = new StringBuilder();

			string typeName;

			if (type.IsEnum)
			{
				typeName = "int";
			}
			else if (!typeNames.TryGetValue(type, out typeName))
			{
				typeName = type.Name;
			}

			if (type == typeof(StringBuilder))
			{
				declaration.Append(typeName);
			}
			else if (isByRef)
			{
				declaration.AppendFormat("{0}*", typeName);
			}
			else
			{
				declaration.AppendFormat("const {0}", typeName);
			}

			if (param.ParameterType.IsArray)
			{
				declaration.Append("[]");
			}

			declaration.AppendFormat(" {0}", param.Name);

			return declaration.ToString();
		}

		#endregion Methods
	}
}