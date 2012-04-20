package jACBr;

import java.lang.String;
import java.util.Date;

/**
 * Classe que encapsula as funções de comunicação com o ECF;
 * Esta classe utiliza chamadas nativas ao componente ACBr32
 * @see http://acbr.sourceforge.net/drupal
 * @author Rafael Batiati
 */
public final class ACBrECF
{
	/**
	 * Handle para o componente nativo criado pelo ACBr32
	 * Este campo é utilizado apenas pela interface JNI.
	 */
	@SuppressWarnings("unused")
	private int handle;
	
	private Aliquota[] aliquotas;
	private FormaPagamento[] formasPagamento;
	private ComprovanteNaoFiscal[] comprovantesNaoFiscais;
		
	static
	{
		//Carrega a biblioteca de chamadas nativas JNI
		System.loadLibrary("ACBr32_JNI");
	}

	public ACBrECF() throws ACBrException
	{
		this.create();
	}
	
	@Override
 	protected void finalize() throws Throwable
	{
		this.destroy();
		this.handle = 0;
		super.finalize();
	}
	
	/**
	 * Aloca memória para o componente ACBr nativo e retorna handle do objeto criado
	 * para o campo "handle" da classe.
	 * Método chamado apenas pelo construtor da classe.
	 */
	private native void create() throws ACBrException;
	
	/**
	 * Libera a memória utilizada pelo componente nativo do ACBr.
	 */
	private native void destroy() throws ACBrException;
	
	/**
	 * Ativa o componente, abrindo a porta de comunicação com o ECF.
	 * @throws ACBrException
	 */
	public native void ativar() throws ACBrException;
	
	/**
	 * Desativa o componente, fechando a porta de comunicação com o ECF.
	 * @throws ACBrException
	 */
	public native void desativar() throws ACBrException;
	
	/**
	 * Retorna o modelo do ECF.
	 * @see jACBr.ModeloECF
	 * @return Modelo do ECF
	 * @throws ACBrException
	 */
	public native int getModelo() throws ACBrException;	
	
	/**
	 * Define o modelo do ECF.
	 * @see jACBr.ModeloECF
	 * @param modelo 
	 * @throws ACBrException
	 */
	public native void setModelo(int modelo) throws ACBrException;

	/**
	 * Retorna a porta de comunicação com o ECF.
	 * @return Porta de comunicação. Ex.: COM1, LPT1 
	 * @throws ACBrException
	 */
	public native String getPorta() throws ACBrException;
	
	/**
	 * Define a porta de comunicação com o ECF.
	 * @param porta Porta de comunicação. Ex.: COM1, LPT1
	 * @throws ACBrException
	 */
	public native void setPorta(String porta) throws ACBrException;
	
	/**
	 * Verifica se o componente está ativo.
	 * @see jACBr.ACBrECF.ativar
	 * @return True caso o componente esteja ativo; False caso contrátio.
	 * @throws ACBrException
	 */
	public native boolean getAtivo() throws ACBrException;
	
	/**
	 * Retorna o número de colunas do ECF.
	 * @return Número de colunas do ECF.
	 * @throws ACBrException
	 */
	public native int getColunas() throws ACBrException;
	
	/**
	 * Retorna o timeout de comunicação com o ECF.
	 * @return Tempo de timeout em milissegundos.
	 * @throws ACBrException
	 */
	public native int getTimeOut() throws ACBrException;
	
	/**
	 * Define o timeout de comunicação com o ECF.  
	 * @param timeout Tempo de timeout em milissegundos.
	 * @throws ACBrException
	 */
	public native void setTimeOut(int timeout) throws ACBrException;
	
	/**
	 * Verifica se o componente está aguardando resposta do ECF.
	 * @return True caso esteja aguardando resposta; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getAguardandoResposta() throws ACBrException; 

	/**
	 * Retorna último comando enviado ao ECF.
	 * @return Array de bytes contendo o último comando enviado ao ECF.
	 * @throws ACBrException
	 */
	public native byte[] getComandoEnviado() throws ACBrException;
	
	/**
	 * Retorna a ultima resposta recebida do ECF.
	 * @return Array de bytes contendo a última resposta recebida do ECF.
	 * @throws ACBrException
	 */
	public native byte[] getRespostaComando() throws ACBrException;

	/**
	 * Retorna o caminho do arquivo de logs dos comandos enviados e recebidos pelo ECF.
	 * @return Caminho do arquivo de log.
	 * @throws ACBrException
	 */
	public native String getComandoLOG() throws ACBrException;
	
	/**
	 * Define o caminho do arquivo de logs dos comandos enviados e recebidos pelo ECF.
	 * @param comandoLog Caminho do arquivo de log
	 * @throws ACBrException
	 */
	public native void setComandoLOG(String comandoLog) throws ACBrException;
	
	/**
	 * Verifica se o componente deve aguardar até o fim da impressão.
	 * @return True caso o componente deva aguardar; False caso contrátio.
	 * @throws ACBrException
	 */
	public native boolean getAguardaImpressao() throws ACBrException;
	
	/**
	 * Define se o componente deve aguardar até o fim da impressão.
	 * @param aguardaImpressao True caso o componente deva aguardar; False caso contrário.
	 * @throws ACBrException
	 */
	public native void setAguardaImpressao(boolean aguardaImpressao) throws ACBrException;

	/**
	 * Retorna o nome do modelo do ECF. 
	 * @return String com o nome do modelo do ECF.
	 * @throws ACBrException
	 */
	public native String getModeloStr() throws ACBrException;
	
	/**
	 * Retorna o RFDID
	 * @return String contendo o RFDID
	 * @throws ACBrException
	 */
	public native String getRFDID() throws ACBrException; 

	/**
	 * Retorna a Data/Hora atual do ECF.
	 * @return Data/Hora atual do ECF.
	 * @throws ACBrException
	 */
	public native Date getDataHora() throws ACBrException;
	
	/**
	 * Retorna o número do cupom atual.
	 * @return String contendo o número do cupom atual.
	 * @throws ACBrException
	 */
	public native String getNumCupom() throws ACBrException; 
	
	/**
	 * Retorna o COO do cupom atual.
	 * @return String contendo o COO do cupom atual.
	 * @throws ACBrException
	 */
	public native String getNumCOO() throws ACBrException;
	
	/**
	 * Retorna o número da loja
	 * @return String contendo o número da loja.
	 * @throws ACBrException
	 */
	public native String getNumLoja() throws ACBrException;
	
	/**
	 * Retorna o número do ECF.
	 * @return String contendo o número do ECF.
	 * @throws ACBrException
	 */
	public native String getNumECF() throws ACBrException;
	
	/**
	 * Retorna o número de série do ECF.
	 * @return String contendo o número de série do ECF.
	 * @throws ACBrException
	 */
	public native String getNumSerie() throws ACBrException;
	
	/**
	 * Retorna o número da versão do ECF.
	 * @return String contendo o número da versão.
	 * @throws ACBrException
	 */
	public native String getNumVersao() throws ACBrException;
	
	/**
	 * Retorna a Data/Hora do movimento.
	 * @return Date/Hora do movimento.
	 * @throws ACBrException
	 */
	public native Date getDataMovimento() throws ACBrException;
	
	/**
	 * Retorna a Data/Hora de instalação do SB (Software Básico do ECF).
	 * @return Data/Hora do SB.
	 * @throws ACBrException
	 */
	public native Date getDataHoraSB() throws ACBrException;
	
	/**
	 * Retorna o CNPJ do proprietário do ECF.
	 * @return String contendo o CNPJ do proprietário do ECF.
	 * @throws ACBrException
	 */
	public native String getCNPJ() throws ACBrException;
	
	/**
	 * Retorna a IE (Inscrição Estadual) do proprietário do ECF.
	 * @return String contendo a IE do proprietário do ECF.
	 * @throws ACBrException
	 */
	public native String getIE() throws ACBrException;
	
	/**
	 * Retorna a IM (Inscrição Municipal) do proprietário do ECF.
	 * @return String contendo a IM do proprietário do ECF.
	 * @throws ACBrException
	 */
	public native String getIM() throws ACBrException;
	
	/**
	 * Retorna o texto do Clichê do proprietário do ECF.
	 * @return String contendo o texto do clichê.
	 * @throws ACBrException
	 */
	public native String getCliche() throws ACBrException;
	
	/**
	 * Retorna o usuário atual.
	 * @return String contendo o usuário atual.
	 * @throws ACBrException
	 */
	public native String getUsuarioAtual() throws ACBrException;
	
	/**
	 * Retorna o modelo detalhado do ECF.
	 * @return String contendo o modelo detalhado do ECF.
	 * @throws ACBrException
	 */
	public native String getSubModeloECF() throws ACBrException;
	
	/**
	 * Retorna o nome do PAF (Programa Aplicativo Fiscal)
	 * @return String contendo o nome do PAF.
	 * @throws ACBrException
	 */
	public native String getPAF() throws ACBrException;
	
	/**
	 * Retorna o número do CRZ (Contador de Reduções Z).
	 * @return String contendo o número do CRZ.
	 * @throws ACBrException
	 */
	public native String getNumCRZ() throws ACBrException;
	
	/**
	 * Retorna o número do CRO (Contador de Reinício de Operações).
	 * @return String contendo o número do CRO.
	 * @throws ACBrException
	 */
	public native String getNumCRO() throws ACBrException;
	
	/**
	 * Retorna o número do CCF (Código do Cupom Fiscal).
	 * @return String contendo o CCF.
	 * @throws ACBrException
	 */
	public native String getNumCCF() throws ACBrException;
	
	/**
	 * Retorna o número do GNF (Gerador Não Fiscal).
	 * @return String contendo o número do GNF.
	 * @throws ACBrException
	 */
	public native String getNumGNF() throws ACBrException;
	
	/**
	 * Retorna o número do GRG (Gerador de Relatório Gerencial).
	 * @return String contendo o GRG.
	 * @throws ACBrException
	 */
	public native String getNumGRG() throws ACBrException;
	
	/**
	 * Retorna o número do CDC (Comprovante de Crédito e Débito).
	 * @return String contendo o número do CDC.
	 * @throws ACBrException
	 */
	public native String getNumCDC() throws ACBrException;
	
	/**
	 * Retorna o número do COO Inicial. (Contador de Ordem de Operações) 
	 * @return String contendo o COO Inicial.
	 * @throws ACBrException
	 */
	public native String getNumCOOInicial() throws ACBrException;
	
	/**
	 * Retorna o valor de venda bruta registrado no ECF.
	 * @return Double contendo o valor de venda bruta.
	 * @throws ACBrException
	 */
	public native double getVendaBruta() throws ACBrException;
	
	/**
	 * Retorna o Grande Total registrado no ECF.
	 * @return Double contendo o valor do grande total.
	 * @throws ACBrException
	 */
	public native double getGrandeTotal() throws ACBrException;
	
	/**
	 * Retorna o total de cancelamentos registrados no ECF.
	 * @return Double contendo o total de cancelamentos.
	 * @throws ACBrException
	 */
	public native double getTotalCancelamentos() throws ACBrException;
	
	/**
	 * Retorna o total de descontos registrados no ECF.
	 * @return Double contendo o total de descontos.
	 * @throws ACBrException
	 */
	public native double getTotalDescontos() throws ACBrException;
	
	/**
	 * Retorna o total de acréscimos registrados no ECF.
	 * @return Double contendo o total de acréscimos.
	 * @throws ACBrException
	 */
	public native double getTotalAcrescimos() throws ACBrException;
	
	/**
	 * Retorna o total de troco registrado no ECF.
	 * @return Double contendo o total de troco.
	 * @throws ACBrException
	 */
	public native double getTotalTroco() throws ACBrException;
	
	/**
	 * Retorna o total de substituição tributária registrado no ECF.
	 * @return Double contendo o total de substituição tributária.
	 * @throws ACBrException
	 */
	public native double getTotalSubstituicaoTributaria() throws ACBrException;
	
	/**
	 * Retorna o total não tributado registrado no ECF.
	 * @return Double contendo o total não tributado.
	 * @throws ACBrException
	 */
	public native double getTotalNaoTributado() throws ACBrException;
	
	/**
	 * Retorna o total de isenção registrado no ECF.
	 * @return Double contendo o total de isenção.
	 * @throws ACBrException
	 */
	public native double getTotalIsencao() throws ACBrException;
	
	/**
	 * Retorna o total de cancelamentos sobre ISSQN (Imposto Sobre Serviços de Qualquer Natureza) registrado no ECF.
	 * @return Double contendo o total do ISSQN.
	 * @throws ACBrException
	 */
	public native double getTotalCancelamentosISSQN() throws ACBrException;
	
	/**
	 * Retorna o total de descontos sobre ISSQN (Imposto Sobre Serviços de Qualquer Natureza) registrado no ECF.
	 * @return Double contendo o total de descontos de ISSQN.
	 * @throws ACBrException
	 */
	public native double getTotalDescontosISSQN() throws ACBrException;
	
	/**
	 * Retorna o total de acréscimos sobre ISSQN (Imposto Sobre Serviços de Qualquer Natureza) registrado no ECF.
	 * @return Double contendo o total de acréscimos de ISSQN.
	 * @throws ACBrException
	 */
	public native double getTotalAcrescimosISSQN() throws ACBrException;
	
	/**
	 * Retorna o total de substituição tributária sobre ISSQN (Imposto Sobre Serviços de Qualquer Natureza) registrado no ECF.
	 * @return Double contendo o total de substituição tributária sobre ISSQN.
	 * @throws ACBrException
	 */
	public native double getTotalSubstituicaoTributariaISSQN() throws ACBrException;
	
	/**
	 * Retorna o total não tributado sobre ISSQN (Imposto Sobre Serviços de Qualquer Natureza) registrado no ECF.
	 * @return Double contendo o total não tributado sobre ISSQN.
	 * @throws ACBrException
	 */
	public native double getTotalNaoTributadoISSQN() throws ACBrException;
	
	/**
	 * Retorna o total de isenção sobre ISSQN (Imposto Sobre Serviços de Qualquer Natureza) registrado no ECF.
	 * @return Double contendo o total de isenção sobre ISSQN.
	 * @throws ACBrException
	 */
	public native double getTotalIsencaoISSQN() throws ACBrException;
	
	/**
	 * Retorna o total não fiscal registrado no ECF.
	 * @return Double contendo o total não fiscal.
	 * @throws ACBrException
	 */
	public native double getTotalNaoFiscal() throws ACBrException;
	
	/**
	 * Retorna o número do último item vendido no ECF.
	 * @return Número do ultimo item vendido.
	 * @throws ACBrException
	 */
	public native int getNumUltItem() throws ACBrException;

	/**
	 * Verifica se o ECF está em linha.
	 * @return True caso ECF esteja em linha; False caso contrário.
	 * @throws ACBrException
	 */
	public boolean getEmLinha() throws ACBrException
	{
		final int DEFAULT_TIMEOUT = 3000;
		return getEmLinha(DEFAULT_TIMEOUT);
	}
	
	/**
	 * Verifica se o ECF está em linha.
	 * @param timeOut Tempo em milissegundos para obter a resposta.
	 * @return True caso ECF esteja em linha; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getEmLinha(int timeOut) throws ACBrException;
	
	/**
	 * Verifica se o ECF está com pouco papel.
	 * @return True caso o ECF esteja com pouco papel; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getPoucoPapel() throws ACBrException;
	
	/**
	 * Retorna o estado do ECF.
	 * @see jACBr.EstadoECF
	 * @return Int representando o estado do ECF.
	 * @throws ACBrException
	 */
	public native int getEstado() throws ACBrException;

	/**
	 * Verifica se o ECF está em horário de verão.
	 * @return True caso o ECF esteja em horário de verão; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getHorarioVerao() throws ACBrException;
	
	/**
	 * Verifica se o ECF deve arredondar.
	 * @return True caso deva arredondar; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getArredonda() throws ACBrException;

	/**
	 * Verifica se o ECF é uma impressora térmica.
	 * @return True caso seja uma impressora térmica; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getTermica() throws ACBrException;
	
	/**
	 * Verifica se o ECF possui MFD (Memória Fita Detalhe).
	 * @return True caso o ECF possua MFD; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getMFD() throws ACBrException;
	
	/**
	 * Verifica se o ECF é capaz de identificar o consumidor no rodapé do ECF.
	 * @return True caso o ECF possua a função; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getIdentificaConsumidorRodape() throws ACBrException;
	
	/**
	 * Retorna o subtotal do cupom atual.
	 * @return Double contendo o valor do subtotal.
	 * @throws ACBrException
	 */
	public native double getSubTotal() throws ACBrException;
	
	/**
	 * Retorna o total pago no cupom atual.
	 * @return Double contendo o total pago.
	 * @throws ACBrException
	 */
	public native double getTotalPago() throws ACBrException;
	
	/**
	 * Verifica se a gaveta está aberta.
	 * @return True caso a gaveta esteja aberta; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getGavetaAberta() throws ACBrException;
	
	/**
	 * Verifica se o ECF possui a função ChequePronto.
	 * @return True caso o ECF possua a função; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getChequePronto() throws ACBrException;
	
	/**
	 * Retorna o intervalo a agurardar após o envio de um comando ao ECF (em milissegundos).
	 * @return Intervalo
	 * @throws ACBrException
	 */
	public native int getIntervaloAposComando() throws ACBrException;
	
	/**
	 * Define o intervalo a aguardar após o envio de um comando ao ECF (em milissegundos).
	 * @param intervalo
	 * @throws ACBrException
	 */
	public native void setIntervaloAposComando(int intervalo) throws ACBrException;
	
	/**
	 * Verifica se o ECF deve usar descrição grande nos itens.
	 * @return True caso use descrição grande; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getDescricaoGrande() throws ACBrException;
	
	/**
	 * Define se o ECF deve usar descrição grande nos itens.
	 * @param descricaoGrande
	 * @throws ACBrException
	 */
	public native void setDescricaoGrande(boolean descricaoGrande) throws ACBrException;
	
	/**
	 * Verifica se o sinal da gaveta deve ser interpretado invertido. 
	 * @return True caso deva inverter o sinal; False caso contrário.
	 * @throws ACBrException
	 */
	public native boolean getGavetaSinalInvertido() throws ACBrException;
	
	/**
	 * Define se o sinal da gaveta deve ser interpretado invertido.
	 * @param gavetaSinalInvertido
	 * @throws ACBrException
	 */
	public native void setGavetaSinalInvertido(boolean gavetaSinalInvertido) throws ACBrException;
	
	/**
	 * Retorna o operador.
	 * @return String contendo o operador.
	 * @throws ACBrException
	 */
	public native String getOperador() throws ACBrException;
	
	/**
	 * Define o operador
	 * @param operador
	 * @throws ACBrException
	 */
	public native void setOperador(String operador) throws ACBrException; 
	
	/**
	 * Retorna o número de linhas entre os cupons emitidos.
	 * @return Número de linhas
	 * @throws ACBrException
	 */
	public native int getLinhasEntreCupons() throws ACBrException;
	
	/**
	 * Define o número de linhas entre os cupons emitidos.
	 * @param linhasEntreCupons
	 * @throws ACBrException
	 */
	public native void setLinhasEntreCupons(int linhasEntreCupons) throws ACBrException;
	
	/**
	 * Retorna a quantidade de casas decimais utilizadas no preço.
	 * @return Quantidade de casas decimais utilizadas no preço.
	 * @throws ACBrException
	 */
	public native int getDecimaisPreco() throws ACBrException;
	
	/**
	 * Define a quantidade de casas decimais utilizadas no preço.
	 * @param decimaisPreco
	 * @throws ACBrException
	 */
	public native void setDecimaisPreco(int decimaisPreco) throws ACBrException;
	
	/**
	 * Retorna a quantidade de casas decimais utilizadas na quantidade.
	 * @return Quantidade de casas decimais utilizadas na quantidade.
	 * @throws ACBrException
	 */
	public native int getDecimaisQtd() throws ACBrException;
	
	/**
	 * Define a quantidade de casas decimais utilizadas na quantidade.
	 * @param decimaisQtd
	 * @throws ACBrException
	 */
	public native void setDecimaisQtd(int decimaisQtd) throws ACBrException;
	
	/**
	 * Identifica o consumidor para o Cupom atual.<br/>
	 * Utilize a propriedade getIdentificaConsumidorRodape para verificar se este método deve ser chamado antes ou depois de abrir um novo cupom.
	 * @see getIdentificaConsumidorRodape
	 * @param cpfCnpj CPF ou CNPJ do consumidor.
	 * @param nome Nome do consumidor.
	 * @param endereco Endereço do consumidor.
	 * @throws ACBrException
	 */
	public native void identificaConsumidor(String cpfCnpj, String nome, String endereco) throws ACBrException;
	
	/**
	 * Abre um cupom fiscal.
	 * @throws ACBrException
	 */
	public void abreCupom() throws ACBrException
	{
		abreCupom("","","");
	}
	
	/**
	 * Abre um cupom fiscal.
	 * @param cpfCnpj CPF ou CNPJ do consumidor.
	 * @param nome Nome do consumidor
	 * @param endereco Endereço do consumidor.
	 * @throws ACBrException
	 */
	public native void abreCupom(String cpfCnpj, String nome, String endereco) throws ACBrException; 
	
	public native void legendaInmetroProximoItem() throws ACBrException; 
	
	/**
	 * Registra a venda de um item no cupom fiscal
	 * @param codigo Código do item.
	 * @param descricao Descrição do item.
	 * @param aliquotaICMS Índice da alíquota.
	 * @param qtd Quantidade
	 * @param valorUnitario Valor unitário
	 * @param descontoPorc Desconto
	 * @param unidade Unidade
	 * @param tipoDescontoAcrescimo Tipo de desconto: "$" para valor ou "%" para percentual.
	 * @param descontoAcrescimo Desconto ou acréscimo: "D" para desconto ou "A" para acréscimo. 
	 * @throws ACBrException
	 */
	public native void vendeItem(String codigo, String descricao, String aliquotaICMS, double qtd, double valorUnitario, double descontoPorc, String unidade, String tipoDescontoAcrescimo, String descontoAcrescimo) throws ACBrException;
	
	/**
	 * Registra desconto ou acréscimo para o item vendido anterior.
	 * @param valorDescontoAcrescimo Valor do desconto ou acréscimo
	 * @param descontoAcrescimo Desconto ou Acréscimo: "D" para desconto ou "A" para acréscimo.
	 * @throws ACBrException
	 */
	public native void descontoAcrescimoItemAnterior(double valorDescontoAcrescimo, String descontoAcrescimo) throws ACBrException;
	
	/**
	 * Subtotaliza o cupom fiscal.
	 * @param descontoAcrescimo Desconto ou acréscimo no total da venda.
	 * @param mensagemRodape Mensagem no rodapé do cupom.
	 * @throws ACBrException
	 */
	public native void subtotalizaCupom(double descontoAcrescimo, String mensagemRodape) throws ACBrException;
	
	/**
	 * Efetua pagamento da compra.
	 * @param codFormaPagto Índice da forma de pagamento.
	 * @param valor Valor pago.
	 * @param observacao Observação sobre o pagamento.
	 * @param imprimeVinculado Flag indicando se haverá impressão de comprovante vinculado para este pagamento.
	 * @throws ACBrException
	 */
	public native void efetuaPagamento(String codFormaPagto, double valor, String observacao, boolean imprimeVinculado) throws ACBrException;	
	
	/**
	 * Estorna o pagamento efetuado.
	 * @param codFormaPagtoEstornar Índice da forma de pagamento a estornar
	 * @param codFormaPagtoEfetivar Índice da forma de pagamento a efetivar.
	 * @param valor Valor o pagamento
	 * @param observacao Observações.
	 * @throws ACBrException
	 */
	public native void estornaPagamento(String codFormaPagtoEstornar, String codFormaPagtoEfetivar, double valor, String observacao) throws ACBrException;
	
	/**
	 * Fecha o cupom fiscal.
	 * @param observacao Observações
	 * @throws ACBrException
	 */
	public native void fechaCupom(String observacao) throws ACBrException;
	
	/**
	 * Cancela o cupom fiscal atualmente aberto ou o último cupom emitido.
	 * @throws ACBrException
	 */
	public native void cancelaCupom() throws ACBrException;
	
	/**
	 * Cancela o item vendido.
	 * @param numItem Número do item vendido.
	 * @throws ACBrException
	 */
	public native void cancelaItemVendido(int numItem) throws ACBrException;
	
	/**
	 * Cancela o item vendido parcial.
	 * @param numItem Número do item
	 * @param quantidade Quantidade
	 * @throws ACBrException
	 */
	public native void cancelaItemVendidoParcial(int numItem, double quantidade) throws ACBrException;
	
	/**
	 * Cancela o desconto ou acréscimo de um item vendido.
	 * @param numItem Número do item.
	 * @throws ACBrException
	 */
	public native void cancelaDescontoAcrescimoItem(int numItem) throws ACBrException;
	
	/**
	 * Cancela o desconto ou acréscimo do subtotal da venda.
	 * @param tipoAcrescimoDesconto Desconto ou acréscimo: "D" para desconto ou "A" para acréscimo.
	 * @throws ACBrException
	 */
	public native void cancelaDescontoAcrescimoSubTotal(char tipoAcrescimoDesconto) throws ACBrException; 	
	
	/**
	 * Emite um relatório de leitura X.
	 * @throws ACBrException
	 */
	public native void leituraX() throws ACBrException;
	
	/**
	 * Emite uma redução Z.
	 * @throws ACBrExceptionf
	 */
	public native void reducaoZ() throws ACBrException;
	
	/**
	 * Abre um relatório gerencial 
	 * @param indice Índice do relatório
	 * @throws ACBrException
	 */
	public native void abreRelatorioGerencial(int indice) throws ACBrException;	
	
	/**
	 * Imprime uma linha no relatório gerencial.
	 * @param linha
	 * @param indiceBMP
	 * @throws ACBrException
	 */
	public native void linhaRelatorioGerencial(String linha, int indiceBMP) throws ACBrException; 	
	
	/**
	 * Abre um cupom vinculado ao cupom fiscal
	 * @param coo String contendo o COO do cupom fiscal.
	 * @param codFormaPagto Código da forma de pagamento.
	 * @param valor Valor do pagamento.
	 * @throws ACBrException
	 */
	public native void abreCupomVinculado(String coo, String codFormaPagto, double valor) throws ACBrException; 	

	/**
	 * Abre um cupom vinculado ao cupom fiscal.
	 * @param coo String contendo o COO do cupom fiscal.
	 * @param codFormaPagto Índice da forma de pagamento
	 * @param codComprovanteNaoFiscal Código do comprovante não fiscal.
	 * @param valor Valor do pagamento.
	 * @throws ACBrException
	 */
	public native void abreCupomVinculadoCNF(String coo, String codFormaPagto, String codComprovanteNaoFiscal, double valor) throws ACBrException; 	
	
	/**
	 * Imprime uma linha no cupom vinculado.
	 * @param linha String contendo o texto a ser impresso
	 * @throws ACBrException
	 */
	public native void linhaCupomVinculado(String linha) throws ACBrException;	
	
	/**
	 * Fecha o relatório gerencial.
	 * @throws ACBrException
	 */
	public native void fechaRelatorio() throws ACBrException;	
	
	/**
	 * Pula um número de linhas nos relatórios
	 * @param numLinhas Número de linhas a pular
	 * @throws ACBrException
	 */
	public native void pulaLinhas(int numLinhas) throws ACBrException; 	
	
	/**
	 * Aciona a guilhotina para cortar o papel.
	 * @param corteParcial Flag que indica se o corte é parcial ou total.
	 * @throws ACBrException
	 */
	public native void cortaPapel(boolean corteParcial) throws ACBrException; 
		
	/**
	 * Retorna as alíquotas programadas no ECF.
	 * @return Array contendo as alíquotas
	 * @throws ACBrException
	 */
	public Aliquota[] getAliquotas() throws ACBrException 
	{
		if (aliquotas == null) carregaAliquotas();
		return aliquotas.clone();
	}

	/**
	 * Carrega as alíquotas programadas no ECF.
	 * @see getAliquotas
	 * @throws ACBrException
	 */
	public void carregaAliquotas() throws ACBrException 
	{
		int count = carregaAliquotasN();
		
		this.aliquotas = new Aliquota[count];
		for (int i=0; i<count; i++)
		{
			Aliquota aliquota = new Aliquota();
			getAliquotaN(aliquota, i);
			
			aliquotas[i] = aliquota;
		}
	}
	
	/**
	 * Programa uma nova alíquota na memória do ECF.<br>
	 * Cuidado, um alíquota uma vez programada não pode ser removida da memória do ECF.
	 * @param aliquota Valor percentual da alíquota.
	 * @param tipo Tipo da alíquota: "T" para ICMS ou "S" para ISS
	 * @throws ACBrException
	 */
	public native void programaAliquota(double aliquota, char tipo) throws ACBrException; 
	
	private native void getAliquotaN(Aliquota aliquota, int index);	
	private native int carregaAliquotasN();
	
	/**
	 * Retorna as formas de pagamento programadas na memória do ECF.
	 * @return Array contendo as formas de pagamento.
	 * @throws ACBrException
	 */
	public FormaPagamento[] getFormasPagamento() throws ACBrException
	{
		if (formasPagamento == null) carregaFormasPagamento();
		return formasPagamento.clone();
	}

	/**
	 * Carrega as formas de pagamento programadas no ECF.
	 * @see gerFormasPagamento
	 * @throws ACBrException
	 */
	public void carregaFormasPagamento() throws ACBrException 
	{
		int count = carregaFormasPagamentoN();
		
		formasPagamento = new FormaPagamento[count];
		for (int i=0; i<count; i++)
		{
			FormaPagamento formaPagamento = new FormaPagamento();
			getFormaPagamentoN(formaPagamento, i);

			formasPagamento[i] = formaPagamento;
		}
	}
	
	/**
	 * Programa uma nova forma de pagamento na memória do ECF.<br/>
	 * Cuidado, um forma de pagamento uma vez programada não pode ser removida da memória do ECF.
	 * @param descricao Descrição da forma de pagamento.
	 * @param permiteVinculado Flag indicando se a forma de pagamento permite impressão de cupom vinculado.
	 * @throws ACBrException
	 */
	public native void programaFormaPagamento(String descricao, boolean permiteVinculado) throws ACBrException; 
	
	private native int carregaFormasPagamentoN();
	private native void getFormaPagamentoN(FormaPagamento formaPagamento, int index);
	
	/**
	 * Retorna os comprovantes não fiscais programados no ECF.
	 * @return Array contendo os comprovantes não fiscais.
	 * @throws ACBrException
	 */
	public ComprovanteNaoFiscal[] getComprovantesNaoFiscais() throws ACBrException
	{
		if (comprovantesNaoFiscais == null) carregaComprovantesNaoFiscais();
		return comprovantesNaoFiscais.clone();
	}
	
	/**
	 * Carrega os comprovantes não fiscais programados no ECF.
	 * @throws ACBrException
	 */
	public void carregaComprovantesNaoFiscais() throws ACBrException
	{
		int count = carregaComprovantesNaoFiscaisN();
		comprovantesNaoFiscais = new ComprovanteNaoFiscal[count];
		for (int i=0; i<count; i++)
		{
			ComprovanteNaoFiscal comprovanteNaoFiscal = new ComprovanteNaoFiscal();
			getComprovanteNaoFiscalN(comprovanteNaoFiscal, i);
			
			comprovantesNaoFiscais[i] = comprovanteNaoFiscal;
		}
	}
	
	public native void getComprovanteNaoFiscalN(Object comprovanteNaoFiscal, int index) throws ACBrException ;	
	public native int carregaComprovantesNaoFiscaisN() throws ACBrException;
	
	/**
	 * Programa um novo comprovante não fiscal na memória do ECF.<br/>
	 * Cuidado, um comprovante não fiscal uma vez programada não pode ser removida da memória do ECF.
	 * @param descricao
	 * @param tipo
	 * @throws ACBrException
	 */
	public native void programaComprovanteNaoFiscal(String descricao, String tipo) throws ACBrException;
	
	/**
	 * Efetua uma retirada de valor em caixa.
	 * @param valor Valor a ser retirado.
	 * @param obs Observações.
	 * @throws ACBrException
	 */
	public native void sangria(double valor, String obs) throws ACBrException;
	
	/**
	 * Efetua um suprimento de valor em caixa.
	 * @param valor Valor a ser suprido.
	 * @param obs Observações.
	 * @throws ACBrException
	 */
	public native void suprimento(double valor, String obs) throws ACBrException;
	
	/**
	 * Abre a gaveta.
	 * @throws ACBrException
	 */
	public native void abreGaveta() throws ACBrException; 

}
