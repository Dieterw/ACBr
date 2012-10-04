using System;

namespace ACBrFramework
{
	public sealed class ACBrAACECF
	{
		#region Properties

		public double ValorGT { get; set; }

		public string NumeroSerie { get; set; }

		public int CRO { get; set; }

		public int CNI { get; set; }

		public DateTime DtHrAtualizado { get; internal set; }

		#endregion Properties
	}
}