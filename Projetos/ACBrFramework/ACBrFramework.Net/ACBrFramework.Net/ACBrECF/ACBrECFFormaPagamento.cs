using System;
namespace ACBrFramework
{
	public sealed class ACBrECFFormaPagamento
	{
		public string Indice { get; set; }

		public string Descricao { get; set; }

		public bool PermiteVinculado { get; set; }

		public decimal Total { get; set; }

		public DateTime Data { get; set; }

		public string TipoDoc { get; set; }
	}
}