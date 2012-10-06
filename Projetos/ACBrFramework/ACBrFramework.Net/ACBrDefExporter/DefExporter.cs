using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;

namespace ACBrDefExporter
{
	internal abstract class DefExporter
	{
		#region Fields

		private static readonly Dictionary<Type, string> typeNames = new Dictionary<Type, string>();

		#endregion Fields

		#region Properties

		public string Path { get; private set; }

		public abstract Language Language { get; }

		protected Dictionary<Type, string> TypeNames
		{
			get
			{
				return typeNames;
			}
		}

		#endregion Properties

		#region Constructor

		public DefExporter(string path)
		{
			this.Path = path;

			InitializeTypeNames();
		}

		#endregion Constructor

		#region Methods

		protected abstract void InitializeTypeNames();

		public void Export(Type interopType)
		{
			string filePath = System.IO.Path.Combine(Path, GetFileName(interopType));

			using (StreamWriter writer = new StreamWriter(filePath))
			{
				BeginHeader(writer, interopType);
				BeginDefines(writer, interopType);
				ExportTypes(writer, interopType);
				ExportMethods(writer, interopType);
				EndDefines(writer, interopType);

				writer.Flush();
			}
		}

		protected abstract void BeginHeader(StreamWriter writer, Type interopType);

		protected abstract void BeginDefines(StreamWriter writer, Type interopType);

		protected abstract void ExportTypes(StreamWriter writer, Type interopType);

		protected abstract void ExportMethods(StreamWriter writer, Type InteropType);

		protected abstract void EndDefines(StreamWriter writer, Type InteropType);

		protected virtual MethodInfo[] GetMethods(Type interopType)
		{
			var methods = interopType.GetMethods(BindingFlags.Static | BindingFlags.Public);
			return methods.OrderBy(x => x.Name).ToArray();
		}

		protected virtual Type[] GetTypes(Type interopType)
		{
			var types = interopType.GetNestedTypes(BindingFlags.Public | BindingFlags.NonPublic);
			return types.OrderBy(x => x.Name).ToArray();
		}

		protected string GetComponentName(Type interopType)
		{
			return interopType.Name.Replace("Interop", string.Empty);
		}

		protected string GetFileName(Type interopType)
		{
			string componentName = GetComponentName(interopType);

			switch (Language)
			{
				case Language.C: return string.Format("{0}.h", componentName);
				case Language.VB6: return string.Format("{0}.bas", componentName);
				case Language.xBase: return string.Format("{0}.prg", componentName);
				default: throw new NotImplementedException();
			}
		}

		protected Type GetUnmanagedType(UnmanagedType type)
		{
			switch (type)
			{
				case UnmanagedType.I1: return typeof(bool);
				case UnmanagedType.U1: return typeof(bool);
				case UnmanagedType.I2: return typeof(short);
				case UnmanagedType.I4: return typeof(int);
				case UnmanagedType.I8: return typeof(long);
				case UnmanagedType.R4: return typeof(float);
				case UnmanagedType.R8: return typeof(double);
				case UnmanagedType.ByValTStr: return typeof(char);
				default: throw new NotImplementedException();
			}
		}

		#endregion Methods
	}
}