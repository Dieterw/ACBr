using System;
using System.IO;
using System.Text;
using System.Reflection;
using System.Runtime.InteropServices;

namespace ACBrDefExporter
{
	internal class CDefExporter : DefExporter
	{
		#region Properties

		public override Language Language
		{
			get
			{
				return Language.C;
			}
		}

		#endregion Properties

		#region Constructor

		public CDefExporter(string path)
			: base(path)
		{
		}

		#endregion Constructor

		#region Methods

		protected override void InitializeTypeNames()
		{
			TypeNames[typeof(IntPtr)] = "INTPTR";
			TypeNames[typeof(Int16)] = "short";
			TypeNames[typeof(Int32)] = "int";
			TypeNames[typeof(Int64)] = "long";
			TypeNames[typeof(Boolean)] = "BOOL";
			TypeNames[typeof(Double)] = "double";
			TypeNames[typeof(String)] = "PCHAR";
			TypeNames[typeof(Char)] = "char";
			TypeNames[typeof(StringBuilder)] = "PCHAR";
		}

		protected override void BeginHeader(StreamWriter writer, Type interopType)
		{
			writer.WriteLine("/**");
			writer.WriteLine("* ACBrFramework DefExporter");
			writer.WriteLine("* Este arquivo foi gerado automaticamente");
			writer.WriteLine("**/");
			writer.WriteLine();
			writer.WriteLine();
		}

		protected override void BeginDefines(StreamWriter writer, Type interopType)
		{
			string defineName = string.Format("_{0}_H_", GetComponentName(interopType));

			writer.WriteLine();
			writer.WriteLine(@"#ifndef ACBr");
			writer.WriteLine(@"#define ACBr");
			writer.WriteLine();
			writer.WriteLine("typedef void* INTPTR;");
			writer.WriteLine("typedef char* PCHAR;");
			writer.WriteLine("typedef char BOOL;");
			writer.WriteLine();
			writer.WriteLine(@"#endif");
			writer.WriteLine();
			writer.WriteLine();
			writer.WriteLine(@"#ifndef {0}", defineName);
			writer.WriteLine(@"#define {0}", defineName);
			writer.WriteLine();
			writer.WriteLine(@"#ifdef __cplusplus");
			writer.WriteLine(@"#define DllImport extern ""C""");
			writer.WriteLine(@"#else");
			writer.WriteLine(@"#define DllImport extern");
			writer.WriteLine(@"#endif");
			writer.WriteLine();
			writer.WriteLine();
		}

		protected override void ExportTypes(StreamWriter writer, Type interopType)
		{
			writer.WriteLine("// Tipos de dados");
			writer.WriteLine();

			foreach (var type in GetTypes(interopType))
			{
				ExportStruct(writer, type);
				writer.WriteLine();
			}

			writer.WriteLine();
		}

		protected override void ExportMethods(StreamWriter writer, Type InteropType)
		{
			writer.WriteLine("// Funções");
			writer.WriteLine();

			foreach (var method in GetMethods(InteropType))
			{
				ExportMethod(writer, method);
			}
		}

		protected override void EndDefines(StreamWriter writer, Type InteropType)
		{
			writer.WriteLine();
			writer.WriteLine();
			writer.WriteLine("#endif");
		}

		private void ExportMethod(StreamWriter writer, MethodInfo methodInfo)
		{
			StringBuilder parameters = new StringBuilder();
			foreach (var param in methodInfo.GetParameters())
			{
				if (parameters.Length > 0) parameters.Append(", ");

				string paramDeclaration = GetMethodParamDeclaration(param);
				parameters.Append(paramDeclaration);
			}

			const string METHOD_DECLARATION = @"DllImport int {0}({1});";
			string methodDeclaration = string.Format(METHOD_DECLARATION, methodInfo.Name, parameters);

			writer.WriteLine(methodDeclaration);
		}

		private string GetMethodParamDeclaration(ParameterInfo param)
		{
			Type type = param.ParameterType.IsArray ? param.ParameterType.GetElementType() : param.ParameterType;
			bool isByRef = type.IsByRef || param.IsRetval || param.IsOut;

			if (type.IsByRef) type = type.GetElementType();
			if (type.IsSubclassOf(typeof(Enum))) type = typeof(int);

			StringBuilder declaration = new StringBuilder();

			string typeName;

			if (!TypeNames.TryGetValue(type, out typeName))
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

			declaration.AppendFormat(" {0}", param.Name);

			if (param.ParameterType.IsArray)
			{
				declaration.Append("[]");
			}

			return declaration.ToString();
		}

		private void ExportStruct(StreamWriter writer, Type type)
		{
			writer.WriteLine("typedef struct");
			writer.WriteLine("{");

			BindingFlags bindingFlags = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;
			FieldInfo[] fields = type.GetFields(bindingFlags);

			foreach (FieldInfo field in fields)
			{
				StringBuilder declaration = new StringBuilder();

				Type fieldType;
				string typeName;
				string arrayDeclaration;

				MarshalAsAttribute marshalAs = (MarshalAsAttribute)Attribute.GetCustomAttribute(field, typeof(MarshalAsAttribute), false);
				if (marshalAs != null)
				{
					fieldType = GetUnmanagedType(marshalAs.Value);
				}
				else
				{
					fieldType = field.FieldType;
				}

				if (!TypeNames.TryGetValue(fieldType, out typeName))
				{
					typeName = fieldType.Name;
				}

				if (marshalAs != null && marshalAs.SizeConst > 0)
				{
					arrayDeclaration = string.Format("[{0}]", marshalAs.SizeConst);
				}
				else
				{
					arrayDeclaration = null;
				}

				writer.WriteLine("\t{0} {1}{2};", typeName, field.Name, arrayDeclaration);
			}

			writer.WriteLine("}} {0};", type.Name);
		}

		#endregion Methods
	}
}