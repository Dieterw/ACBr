using System;

namespace ACBr.Net
{
	public class ACBrSintegra : ACBrComponent, IDisposable
	{
		#region Fields

		#endregion Fields

		#region Constructor

		public ACBrSintegra()
		{
			Create(ACBrSintegraInterop.SIN_Create);
		}

		#endregion Constructor

		#region Properties

		public string FileName
		{
			get
			{
				return GetString(ACBrSintegraInterop.SIN_GetFileName);
			}
			set
			{
				SetString(ACBrSintegraInterop.SIN_SetFileName, value);
			}
		}

		public VersaoValidador VersaoValidador
		{
			get
			{
				return (VersaoValidador)GetInt32(ACBrSintegraInterop.SIN_GetVersaoValidador);
			}
			set
			{
				SetInt32(ACBrSintegraInterop.SIN_SetVersaoValidador, (int)value);
			}
		}

		public bool Ativo
		{
			get
			{
				return GetBool(ACBrSintegraInterop.SIN_GetAtivo);
			}
		}

		#endregion Properties

		#region Methods

		#region Override Methods

		protected internal override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					string error = GetString(ACBrSintegraInterop.SIN_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr Sintegra não inicializado.");
			}
		}

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				Destroy(ACBrSintegraInterop.SIN_Destroy);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}