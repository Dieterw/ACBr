namespace ACBr.Net
{
	public enum EstadoECF
	{
		#region Documentation

		/// <summary>
		///  Porta Serial ainda nao foi aberta
		/// </summary>

		#endregion Documentation

		NaoInicializada,

		#region Documentation

		/// <summary>
		/// Porta aberta, mas ado ainda nao definido
		/// </summary>

		#endregion Documentation

		Desconhecido,

		#region Documentation

		/// <summary>
		///  Impressora Livre, sem nenhum cupom aberto, pronta para nova venda, Reducao Z e Leitura X ok, pode ou nao já ter ocorrido 1ª venda no dia...
		/// </summary>

		#endregion Documentation

		Livre,

		#region Documentation

		/// <summary>
		/// Cupom de Venda Aberto com ou sem venda do 1º Item
		/// </summary>

		#endregion Documentation

		Venda,

		#region Documentation

		/// <summary>
		/// Iniciado Fechamento de Cupom com Formas Pagto pode ou nao ter efetuado o 1º pagto. Nao pode mais vender itens, ou alterar Subtotal
		/// </summary>

		#endregion Documentation

		Pagamento,

		#region Documentation

		/// <summary>
		/// Imprimindo Cupom Fiscal Vinculado ou Relatorio Gerencial
		/// </summary>

		#endregion Documentation

		Relatorio,

		#region Documentation

		/// <summary>
		/// Reduçao Z já emitida, bloqueada até as 00:00
		/// </summary>

		#endregion Documentation

		Bloqueada,

		#region Documentation

		/// <summary>
		/// Reducao Z dia anterior nao emitida. Emita agora
		/// </summary>

		#endregion Documentation

		RequerZ,

		#region Documentation

		/// <summary>
		/// a impressora requer Leitura X todo inicio de dia. Imprima uma Leitura X para poder vender
		/// </summary>

		#endregion Documentation

		RequerX,

		#region Documentation

		/// <summary>
		/// Comprovante Nao Fiscal Aberto
		/// </summary>

		#endregion Documentation

		NaoFiscal
	}
}