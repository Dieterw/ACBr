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

		public void CalcularModuloeExpoente(out string Modulo, out string Expoente)
		{
			const int BUFFER_LEN = 1024;
			StringBuilder Mod = new StringBuilder(BUFFER_LEN);
			StringBuilder Expo = new StringBuilder(BUFFER_LEN);

			int ret = ACBrDll.EAD_CalcularModuloeExpoente(this.Handle, Mod, Expo, BUFFER_LEN);
			CheckResult(ret);

			Modulo = FromUTF8(Mod);
			Expoente = FromUTF8(Expo);
		}

		public void GerarXMLeECFc(string NomeSH, string CaminhoArquivo)
		{
			int ret = ACBrDll.EAD_GerarXMLeECFc(this.Handle, NomeSH, CaminhoArquivo);
			CheckResult(ret);
		}

		public void GerarXMLeECFc(string NomeSH)
		{
			int ret = ACBrDll.EAD_GerarXMLeECFc_NP(this.Handle, NomeSH);
			CheckResult(ret);
		}

		public void ConverteXMLeECFcParaOpenSSL(string Arquivo)
		{
			int ret = ACBrDll.EAD_ConverteXMLeECFcParaOpenSSL(this.Handle, Arquivo);
			CheckResult(ret);
		}

		public void CalcularHashArquivo(string Arquivo, EADDigest Hash)
		{
			int ret = ACBrDll.EAD_CalcularHashArquivo(this.Handle, Arquivo, (int)Hash);
			CheckResult(ret);
		}

		public void CalcularEADArquivo(string Arquivo)
		{
			int ret = ACBrDll.EAD_CalcularEADArquivo(this.Handle, Arquivo);
			CheckResult(ret);
		}

		public void AssinarArquivoComEAD(string Arquivo, bool Remover)
		{
			int ret = ACBrDll.EAD_AssinarArquivoComEAD(this.Handle, Arquivo, Remover);
			CheckResult(ret);
		}

		public bool VerificarEADArquivo(string Arquivo)
		{
			int ret = ACBrDll.EAD_VerificarEADArquivo(this.Handle, Arquivo);
			CheckResult(ret);

			return Convert.ToBoolean(ret);
		}

		#endregion Funções

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