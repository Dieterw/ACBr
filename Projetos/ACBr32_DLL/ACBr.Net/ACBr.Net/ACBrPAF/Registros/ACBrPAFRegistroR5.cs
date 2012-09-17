using System;

namespace ACBr.Net
{
	public class ACBrPAFRegistroR5
	{
		public int NUM_ITEM { get; set; }
		public string COD_ITEM { get; set; }
		public string DESC_ITEM { get; set; }
		public double QTDE_ITEM { get; set; }
		public string UN_MED { get; set; }
		public double VL_UNIT { get; set; }
		public double DESCTO_ITEM { get; set; }
		public double ACRES_ITEM { get; set; }
		public double VL_TOT_ITEM { get; set; }
		public string COD_TOT_PARC { get; set; }
		public string IND_CANC { get; set; }
		public double QTDE_CANC { get; set; }
		public double VL_CANC { get; set; }
		public double VL_CANC_ACRES { get; set; }
		public string IAT { get; set; }
		public string IPPT { get; set; }
		public int QTDE_DECIMAL { get; set; }
		public int VL_DECIMAL { get; set; }
		public bool RegistroValido { get; set; }
	}
}
