namespace ACBr.Net
{
	public sealed class ACBrECFAliquota
	{
		public int Sequencia { get; internal set; }

		public string Indice { get; internal set; }

		public decimal Aliquota { get; internal set; }

		public string Tipo { get; internal set; }

		public decimal Total { get; internal set; }
	}
}