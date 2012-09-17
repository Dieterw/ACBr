using System;
using System.Collections.Generic;

namespace ACBr.Net
{
	public class ACBrPAFRegistroR2
	{
		public List<ACBrPAFRegistroR3> RegistroR3 { get; set; }
		public int NUM_USU { get; set; }
		public int CRZ { get; set; }
		public int COO { get; set; }
		public int CRO { get; set; }
		public DateTime DT_MOV { get; set; }
		public DateTime DT_EMI { get; set; }
		public double HR_EMI { get; set; }
		public double VL_VBD { get; set; }
		public string PAR_ECF { get; set; }
		public DateTime DT_FIN { get; set; }
		public bool RegistroValido { get; set; }
	}
}