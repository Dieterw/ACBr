using System;

namespace ACBr.Net
{
	public sealed class ACBrECFDadosRZ
	{
		public int COO { get; internal set; }

		public int CFD { get; internal set; }

		public decimal CancelamentoISSQN { get; internal set; }

		public int GNFC { get; internal set; }

		public int CRO { get; internal set; }

		public decimal ValorVendaBruta { get; internal set; }

		public ACBrECFComprovanteNaoFiscal[] TotalizadoresNaoFiscais { get; internal set; }

		public ACBrECFAliquota[] ICMS { get; internal set; }

		public decimal AcrescimoICMS { get; internal set; }

		public decimal DescontoICMS { get; internal set; }

		public decimal NaoTributadoICMS { get; internal set; }

		public ACBrECFRelatorioGerencial[] RelatorioGerencial { get; internal set; }

		public int CRZ { get; internal set; }

		public ACBrECFAliquota[] ISSQN { get; internal set; }

		public int GRG { get; internal set; }

		public decimal ValorGrandeTotal { get; internal set; }

		public decimal AcrescimoISSQN { get; internal set; }

		public decimal NaoTributadoISSQN { get; internal set; }

		public decimal IsentoICMS { get; internal set; }

		public decimal SubstituicaoTributariaICMS { get; internal set; }

		public DateTime DataDaImpressora { get; internal set; }

		public decimal TotalOperacaoNaoFiscal { get; internal set; }

		public decimal DescontoISSQN { get; internal set; }

		public decimal CancelamentoOPNF { get; internal set; }

		public decimal AcrescimoOPNF { get; internal set; }

		public decimal DescontoOPNF { get; internal set; }

		public decimal CancelamentoICMS { get; internal set; }

		public int GNF { get; internal set; }

		public decimal IsentoISSQN { get; internal set; }

		public decimal SubstituicaoTributariaISSQN { get; internal set; }

		public decimal VendaLiquida { get; internal set; }

		public int CFC { get; internal set; }

		public int CCF { get; internal set; }

		public decimal TotalISSQN { get; internal set; }

		public decimal TotalICMS { get; internal set; }

		public int CDC { get; internal set; }

		public int CCDC { get; internal set; }

		public int NCN { get; internal set; }

		public DateTime DataDoMovimento { get; internal set; }

		public ACBrECFFormaPagamento[] MeiosDePagamento { get; internal set; }

		public string NumeroCOOInicial { get; internal set; }

		public string NumeroDoECF { get; internal set; }

		public string NumeroDeSerie { get; internal set; }

		public string NumeroDeSerieMFD { get; internal set; }

		public string NumeroDaLoja { get; internal set; }

		public decimal TotalTroco { get; internal set; }
	}
}