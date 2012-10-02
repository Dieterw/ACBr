using System;

namespace ACBrFramework.Net
{
	public class ACBrPAFRegistroE1
	{
		public string RazaoSocial { get; set; }

		public string UF { get; set; }

		public string CNPJ { get; set; }

		public string IE { get; set; }

		public string IM { get; set; }

		public string NUM_FAB { get; set; }

		public string MF_ADICIONAL { get; set; }

		public string TIPO_ECF { get; set; }

		public string MARCA_ECF { get; set; }

		public string MODELO_ECF { get; set; }

		public DateTime DT_EST { get; set; }

		public bool RegistroValido { get; set; }

		public bool InclusaoExclusao { get; set; }
	}
}