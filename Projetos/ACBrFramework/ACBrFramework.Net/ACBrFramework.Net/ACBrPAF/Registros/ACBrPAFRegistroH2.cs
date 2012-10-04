using System;

namespace ACBrFramework
{
	public class ACBrPAFRegistroH2
	{
		public string CNPJ_CRED_CARTAO { get; set; }

		public int COO { get; set; }

		public int CCF { get; set; }

		public double VLR_TROCO { get; set; }

		public DateTime DT_TROCO { get; set; }

		public string CPF { get; set; }

		public string Titulo { get; set; }

		public bool RegistroValido { get; set; }
	}
}