using System;
using System.Collections.Generic;

namespace ACBr.Net
{
	public class ACBrPAFRegistroR4
	{
		public List<ACBrPAFRegistroR5> RegistroR5 { get; set; }
		public List<ACBrPAFRegistroR7> RegistroR7 { get; set; }
		public int NUM_USU { get; set; }
		public int NUM_CONT { get; set; }
		public int COO { get; set; }
		public DateTime DT_INI { get; set; }
		public double SUB_DOCTO { get; set; }
		public double SUB_DESCTO { get; set; }
		public string TP_DESCTO { get; set; }
		public double SUB_ACRES { get; set; }
		public string TP_ACRES { get; set; }
		public double VL_TOT { get; set; }
		public string CANC { get; set; }
		public double VL_CA { get; set; }
		public string ORDEM_DA { get; set; }
		public string NOME_CLI { get; set; }
		public string CNPJ_CPF { get; set; }
		public bool RegistroValido { get; set; }
	}
}
