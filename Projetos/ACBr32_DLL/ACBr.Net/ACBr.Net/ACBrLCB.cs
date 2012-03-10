using System;

namespace ACBr.Net
{
	public sealed class ACBrLCB : ACBrDevice, IDisposable
	{
		public static void OnLeCodigo(IntPtr v)
		{
		}

		#region Constructor

		public ACBrLCB()
		{
			int ret = ACBrDll.LCB_Create(ref this.handle);
			CheckResult(ret);

			ret = ACBrDll.LCB_SetOnLeCodigo(this.handle, OnLeCodigo);
			CheckResult(ret);
		}

		#endregion Constructor

		#region Properties

		public bool Ativo
		{
			get
			{
				return GetBool(ACBrDll.LCB_GetAtivo);
			}
		}

		public string Porta
		{
			get
			{
				return GetString(ACBrDll.LCB_GetPorta);
			}
			set
			{
				SetString(ACBrDll.LCB_SetPorta, value);
			}
		}

		#endregion Properties

		#region Methods

		public void Ativar()
		{
			int ret = ACBrDll.LCB_Ativar(this.handle);
			CheckResult(ret);
		}

		public void Desativar()
		{
			int ret = ACBrDll.LCB_Desativar(this.handle);
			CheckResult(ret);
		}

		#region Override Methods

		protected override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					const int BUFFER_LEN = 1024;
					string error = GetString(ACBrDll.LCB_GetUltimoErro, BUFFER_LEN);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr LCB não inicializado.");
			}
		}

		protected override void OnDisposing()
		{
			if (this.handle != IntPtr.Zero)
			{
				int ret = ACBrDll.LCB_Destroy(ref this.handle);
				CheckResult(ret);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}