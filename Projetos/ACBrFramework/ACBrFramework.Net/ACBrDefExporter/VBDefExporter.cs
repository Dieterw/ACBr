using System;
using System.IO;
using System.Text;
using System.Reflection;
using System.Runtime.InteropServices;

namespace ACBrDefExporter
{
	internal class VBDefExporter : DefExporter
	{
		#region Properties

		public override Language Language
		{
			get
			{
				return Language.VB6;
			}
		}

		#endregion Properties

		#region Constructor

		public VBDefExporter(string path)
			: base(path)
		{
		}

		#endregion Constructor

		#region Methods

		protected override void InitializeTypeNames()
		{
			TypeNames[typeof(IntPtr)] = "Long";
			TypeNames[typeof(Int16)] = "Int";
			TypeNames[typeof(Int32)] = "Long";
			TypeNames[typeof(Boolean)] = "Boolean";
			TypeNames[typeof(Double)] = "Double";
			TypeNames[typeof(String)] = "String";
			TypeNames[typeof(Char)] = "String";
			TypeNames[typeof(StringBuilder)] = "String";
		}

		protected override void BeginHeader(StreamWriter writer, Type interopType)
		{
			writer.WriteLine("Attribute VB_Name = \"{0}Module\"", GetComponentName(interopType));
			writer.WriteLine("''");
			writer.WriteLine("'' ACBrFramework DefExporter");
			writer.WriteLine("'' Este arquivo foi gerado automaticamente");
			writer.WriteLine("''");
			writer.WriteLine();
			writer.WriteLine();
		}

		protected override void BeginDefines(StreamWriter writer, Type interopType)
		{
		}

		protected override void ExportTypes(StreamWriter writer, Type interopType)
		{
			writer.WriteLine("'' Tipos de dados");
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
			writer.WriteLine("'' Funções");
			writer.WriteLine();

			foreach (var method in GetMethods(InteropType))
			{
				ExportMethod(writer, method);
			}
		}

		protected override void EndDefines(StreamWriter writer, Type InteropType)
		{
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

			const string METHOD_DECLARATION = @"Public Declare Function {0} Lib ""ACBrFramework32.DLL"" ({1}) As Long";
			string methodDeclaration = string.Format(METHOD_DECLARATION, methodInfo.Name, parameters);

			writer.WriteLine(methodDeclaration);
		}

		private string GetMethodParamDeclaration(ParameterInfo param)
		{
			Type type = param.ParameterType.IsArray ? param.ParameterType.GetElementType() : param.ParameterType;
			bool isByRef = type.IsByRef || param.IsRetval || param.IsOut || param.ParameterType.IsArray;

			if (type.IsByRef) type = type.GetElementType();
			if (type.IsSubclassOf(typeof(Enum))) type = typeof(int);

			StringBuilder declaration = new StringBuilder();

			string typeName;

			if (!TypeNames.TryGetValue(type, out typeName))
			{
				typeName = type.Name;
			}

			if (isByRef)
			{
				declaration.AppendFormat("ByRef {0}", param.Name);
			}
			else
			{
				declaration.AppendFormat("ByVal {0}", param.Name);
			}

			if (param.ParameterType.IsArray)
			{
				declaration.Append("()");
			}

			declaration.AppendFormat(" As {0}", typeName);

			return declaration.ToString();
		}

		private void ExportStruct(StreamWriter writer, Type type)
		{
			writer.WriteLine("Public Type {0}", type.Name);

			BindingFlags bindingFlags = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;
			FieldInfo[] fields = type.GetFields(bindingFlags);

			foreach (FieldInfo field in fields)
			{
				StringBuilder declaration = new StringBuilder();

				Type fieldType;
				string typeName;

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
					if (typeName == "String")
					{
						writer.WriteLine("\t{0} As {1} * {2}", field.Name, typeName, marshalAs.SizeConst);
					}
					else
					{
						writer.WriteLine("\t{0}({1}) As {2}", field.Name, marshalAs.SizeConst, typeName);
					}
				}
				else
				{
					writer.WriteLine("\t{0} As {1}", field.Name, typeName);
				}
			}

			writer.WriteLine("End Type");
		}

		#endregion Methods
	}
}