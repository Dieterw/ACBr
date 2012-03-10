using System;
using System.Text;

namespace ACBr.Net
{
	public abstract class ACBrDevice : IDisposable
	{
		#region Fields

		protected IntPtr handle;

		#endregion Fields

		#region Constructor

		protected ACBrDevice() { }

		~ACBrDevice()
		{
			this.Dispose(false);
		}

		#endregion Constructor

		#region Inner Types

		protected delegate int GetStringEntryPointDelegate(IntPtr handle, StringBuilder buffer, int bufferLen);
		protected delegate int GetDoubleEntryPointDelegate(IntPtr handle, ref double value);
		protected delegate int GetInt32EntryPointDelegate(IntPtr handle);

		protected delegate int SetStringEntryPointDelegate(IntPtr handle, string value);
		protected delegate int SetDoubleEntryPointDelegate(IntPtr handle, double value);
		protected delegate int SetInt32EntryPointDelegate(IntPtr handle, int value);
		protected delegate int SetBoolEntryPointDelegate(IntPtr handle, bool value);

		#endregion Inner Types

		#region P/Invoke Helpers

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

			int ret = entryPoint(handle, buffer, bufferLen);
			CheckResult(ret);

			return FromUTF8(buffer);
		}

		protected void SetString(SetStringEntryPointDelegate entryPoint, string value)
		{
			int ret = entryPoint(handle, ToUTF8(value));
			CheckResult(ret);
		}

		protected DateTime GetDateTime(GetDoubleEntryPointDelegate entryPoint)
		{
			double ticks = 0d;
			int ret = entryPoint(handle, ref ticks);
			CheckResult(ret);

			return DateTime.FromOADate(ticks);
		}

		protected void SetDateTime(SetDoubleEntryPointDelegate entryPoint, DateTime value)
		{
			double ticks = value.ToOADate();
			int ret = entryPoint(handle, ticks);
			CheckResult(ret);
		}

		protected decimal GetDecimal(GetDoubleEntryPointDelegate entryPoint)
		{
			double value = 0d;
			int ret = entryPoint(handle, ref value);
			CheckResult(ret);

			return Convert.ToDecimal(value);
		}

		protected void SetDecimal(SetDoubleEntryPointDelegate entryPoint, decimal value)
		{
			int ret = entryPoint(handle, Convert.ToDouble(value));
			CheckResult(ret);
		}

		protected int GetInt32(GetInt32EntryPointDelegate entryPoint)
		{
			int ret = entryPoint(handle);
			CheckResult(ret);

			return ret;
		}

		protected int SetInt32(SetInt32EntryPointDelegate entryPoint, int value)
		{
			int ret = entryPoint(handle, value);
			CheckResult(ret);

			return ret;
		}

		protected bool GetBool(GetInt32EntryPointDelegate entryPoint)
		{
			int ret = entryPoint(handle);
			CheckResult(ret);

			return ret == 1 ? true : false;
		}

		protected void SetBool(SetBoolEntryPointDelegate entryPoint, bool value)
		{
			int ret = entryPoint(handle, value);
			CheckResult(ret);
		}

		protected abstract void CheckResult(int result);

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