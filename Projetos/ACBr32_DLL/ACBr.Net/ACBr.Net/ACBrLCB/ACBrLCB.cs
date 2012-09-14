using System;

namespace ACBr.Net
{
	public sealed class ACBrLCB : ACBrComponent, IDisposable
	{
		public static void OnLeCodigo(IntPtr v)
		{
		}

		#region Constructor

		public ACBrLCB()
		{
			Create(ACBrDll.LCB_Create);

			int ret = ACBrDll.LCB_SetOnLeCodigo(this.Handle, OnLeCodigo);
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
			int ret = ACBrDll.LCB_Ativar(this.Handle);
			CheckResult(ret);
		}

		public void Desativar()
		{
			int ret = ACBrDll.LCB_Desativar(this.Handle);
			CheckResult(ret);
		}

		#region Override Methods

		protected internal override void CheckResult(int ret)
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
			if (this.Handle != IntPtr.Zero)
			{
				Destroy(ACBrDll.LCB_Destroy);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}