using System;
using System.Text;

namespace ACBr.Net
{
	public abstract class ACBrComponent : IDisposable
	{
		#region Inner Types

		protected delegate int CreateEntryPointDelegate(ref IntPtr handle);
		protected delegate int DestroyEntryPointDelegate(ref IntPtr handle);

		protected delegate int GetStringEntryPointDelegate(IntPtr handle, StringBuilder buffer, int bufferLen);
		protected delegate int GetdoubleEntryPointDelegate(IntPtr handle, ref double value);
		protected delegate int GetInt32EntryPointDelegate(IntPtr handle);

		protected delegate int SetStringEntryPointDelegate(IntPtr handle, string value);
		protected delegate int SetdoubleEntryPointDelegate(IntPtr handle, double value);
		protected delegate int SetInt32EntryPointDelegate(IntPtr handle, int value);
		protected delegate int SetBoolEntryPointDelegate(IntPtr handle, bool value);

		#endregion Inner Types

		#region Fields

		private IntPtr handle;

		#endregion Fields

		#region Properties

		public virtual IntPtr Handle
		{
			get
			{
				return handle;
			}
		}

		#endregion Properties

		#region Constructor

		protected ACBrComponent() { }

		~ACBrComponent()
		{
			this.Dispose(false);
		}

		#endregion Constructor

		#region P/Invoke Helpers

		protected void Create(CreateEntryPointDelegate entryPoint)
		{
			var ret = entryPoint(ref this.handle);
			CheckResult(ret);
		}

		protected void Destroy(DestroyEntryPointDelegate entryPoint)
		{
			var ret = entryPoint(ref this.handle);
			CheckResult(ret);
		}

		protected string ToUTF8(string value)
		{
			return Encoding.Default.GetString(Encoding.UTF8.GetBytes(value));
		}

		protected string FromUTF8(string value)
		{
			return Encoding.UTF8.GetString(Encoding.Default.GetBytes(value));
		}

		protected string FromUTF8(StringBuilder value)
		{
			return Encoding.UTF8.GetString(Encoding.Default.GetBytes(value.ToString()));
		}

		protected string GetString(GetStringEntryPointDelegate entryPoint)
		{
			const int BUFFER_LEN = 256;
			return GetString(entryPoint, BUFFER_LEN);
		}

		protected string GetString(GetStringEntryPointDelegate entryPoint, int bufferLen)
		{
			StringBuilder buffer = new StringBuilder(bufferLen);

			int ret = entryPoint(Handle, buffer, bufferLen);
			CheckResult(ret);

			return FromUTF8(buffer);
		}

		protected void SetString(SetStringEntryPointDelegate entryPoint, string value)
		{
			int ret = entryPoint(Handle, ToUTF8(value));
			CheckResult(ret);
		}

		protected DateTime GetDateTime(GetdoubleEntryPointDelegate entryPoint)
		{
			double ticks = 0d;
			int ret = entryPoint(Handle, ref ticks);
			CheckResult(ret);

			return DateTime.FromOADate(ticks);
		}

		protected void SetDateTime(SetdoubleEntryPointDelegate entryPoint, DateTime value)
		{
			double ticks = value.ToOADate();
			int ret = entryPoint(Handle, ticks);
			CheckResult(ret);
		}

		protected decimal GetDecimal(GetdoubleEntryPointDelegate entryPoint)
		{
			double value = 0d;
			int ret = entryPoint(Handle, ref value);
			CheckResult(ret);

			return Convert.ToDecimal(value);
		}

		protected void SetDecimal(SetdoubleEntryPointDelegate entryPoint, decimal value)
		{
			int ret = entryPoint(Handle, Convert.ToDouble(value));
			CheckResult(ret);
		}

		protected int GetInt32(GetInt32EntryPointDelegate entryPoint)
		{
			int ret = entryPoint(Handle);
			CheckResult(ret);

			return ret;
		}

		protected int SetInt32(SetInt32EntryPointDelegate entryPoint, int value)
		{
			int ret = entryPoint(Handle, value);
			CheckResult(ret);

			return ret;
		}

		protected bool GetBool(GetInt32EntryPointDelegate entryPoint)
		{
			int ret = entryPoint(Handle);
			CheckResult(ret);

			return ret == 1 ? true : false;
		}

		protected void SetBool(SetBoolEntryPointDelegate entryPoint, bool value)
		{
			int ret = entryPoint(Handle, value);
			CheckResult(ret);
		}

		internal protected abstract void CheckResult(int result);

		#endregion P/Invoke Helpers

		#region Dispose Methods

		protected abstract void OnDisposing();

		private void Dispose(bool disposing)
		{
			if (disposing)
			{
				GC.SuppressFinalize(this);
			}

			OnDisposing();
		}

		public void Dispose()
		{
			this.Dispose(true);
		}

		#endregion Dispose Methods
	}
}