using System;
using System.Text;

namespace ACBr.Net
{
	public class ACBrEAD : ACBrComponent, IDisposable
	{

		#region Constructor

		public ACBrEAD()
		{
			Create(ACBrDll.EAD_Create);
		}

		#endregion Constructor

		#region Methods
		
		#region Funções
		public void GerarChaves(out string ChavePublica, out string ChavePrivada)
		{
			const int BUFFER_LEN = 1024;
			StringBuilder ChavePUB = new StringBuilder(BUFFER_LEN);
			StringBuilder ChavePRI = new StringBuilder(BUFFER_LEN);

			int ret = ACBrDll.EAD_GerarChaves(this.Handle, ChavePUB, ChavePRI, BUFFER_LEN);
			CheckResult(ret);

			ChavePublica = FromUTF8(ChavePUB);
			ChavePrivada = FromUTF8(ChavePRI);
		}
		#endregion

		#region Override Methods

		protected internal override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					string error = GetString(ACBrDll.EAD_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr EAD não inicializado.");
			}
		}

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				Destroy(ACBrDll.EAD_Destroy);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}
