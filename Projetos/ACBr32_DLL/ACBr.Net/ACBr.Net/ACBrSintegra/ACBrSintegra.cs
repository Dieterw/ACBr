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
			Create(ACBrDll.SIN_Create);
		}		

		#endregion Constructor

		#region Properties

		public string FileName
		{
			get
			{
				return GetString(ACBrDll.SIN_GetFileName);
			}
			set
			{
				SetString(ACBrDll.SIN_SetFileName, value);
			}
		}

		public VersaoValidador VersaoValidador
		{
			get
			{
				return (VersaoValidador)GetInt32(ACBrDll.SIN_GetVersaoValidador);
			}
			set
			{
				SetInt32(ACBrDll.SIN_SetVersaoValidador, (int)value);
			}
		}

		public bool Ativo
		{
			get
			{
				return GetBool(ACBrDll.SIN_GetAtivo);
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

					string error = GetString(ACBrDll.SIN_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr Sintegra não inicializado.");
			}
		}

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				Destroy(ACBrDll.SIN_Destroy);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}
