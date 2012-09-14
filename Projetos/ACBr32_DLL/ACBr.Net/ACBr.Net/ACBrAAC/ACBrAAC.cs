using System;

namespace ACBr.Net
{
	public class ACBrAAC : ACBrComponent, IDisposable
	{
		#region Constructor

		public ACBrAAC()
		{
			Create(ACBrDll.AAC_Create);
			IdentPaf = new ACBrECFIdenticacaoPaf(this);
		}

		#endregion Constructor

		#region Properties

		public string NomeArquivoAuxiliar
		{
			get
			{
				return GetString(ACBrDll.AAC_GetNomeArquivoAux);
			}
			set
			{
				SetString(ACBrDll.AAC_SetNomeArquivoAux, value);
			}
		}

		public string Chave
		{
			get
			{
				return GetString(ACBrDll.AAC_GetChave);
			}
			set
			{
				SetString(ACBrDll.AAC_SetChave, value);
			}
		}

		public string NomeArquivoLog
		{
			get
			{
				return GetString(ACBrDll.AAC_GetArqLOG);
			}
			set
			{
				SetString(ACBrDll.AAC_SetArqLOG, value);
			}
		}

		public string Parametros
		{
			get
			{
				return GetString(ACBrDll.AAC_GetParams);
			}
			set
			{
				SetString(ACBrDll.AAC_SetParams, value);
			}
		}

		public ACBrECFIdenticacaoPaf IdentPaf { get; private set; }

		#endregion Properties

		#region Methods

		public void AbrirArquivo()
		{
			int ret = ACBrDll.AAC_AbrirArquivo(this.Handle);
			CheckResult(ret);
		}

		public void SalvarArquivo()
		{
			int ret = ACBrDll.AAC_SalvarArquivo(this.Handle);
			CheckResult(ret);
		}

		public int VerificarGrandeTotal(string numSerie, double grandTotal)
		{
			int ret = ACBrDll.AAC_VerificarGTECF(this.Handle, numSerie, ref grandTotal);

			return ret;
		}

		public int ECFsAutorizadosCount
		{
			get
			{
				int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_Count(this.Handle);

				CheckResult(ret);

				return ret;
			}
		}

		#region Overrides Methods

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				this.IdentPaf.Dispose();
				Destroy(ACBrDll.AAC_Destroy);
			}
		}

		protected internal override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					string error = GetString(ACBrDll.AAC_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr AAC não inicializado.");
			}
		}

		#endregion Overrides Methods

		#endregion Methods
	}
}