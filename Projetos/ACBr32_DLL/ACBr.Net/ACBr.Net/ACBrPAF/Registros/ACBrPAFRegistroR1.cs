using System;

namespace ACBr.Net
{
	public class ACBrPAFRegistroR1
	{
		public string NUM_FAB { get; set; }
		public string MF_ADICIONAL { get; set; }
		public string TIPO_ECF { get; set; }
		public string MARCA_ECF { get; set; }
		public string MODELO_ECF { get; set; }
		public string VERSAO_SB { get; set; }
		public DateTime DT_INST_SB { get; set; }
		public DateTime HR_INST_SB { get; set; }
		public int NUM_SEQ_ECF { get; set; }
		public string CNPJ { get; set; }
		public string IE { get; set; }
		public string CNPJ_SH { get; set; }
		public string IE_SH { get; set; }
		public string IM_SH { get; set; }
		public string NOME_SH { get; set; }
		public string NOME_PAF { get; set; }
		public string VER_PAF { get; set; }
		public string COD_MD5 { get; set; }
		public DateTime DT_INI { get; set; }
		public DateTime DT_FIN { get; set; }
		public string ER_PAF_ECF { get; set; }
		public Boolean InclusaoExclusao { get; set; }
		public Boolean RegistroValido { get; set; }
	}
}
