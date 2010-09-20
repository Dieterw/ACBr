package jACBr;

public interface EstadoECF 
{
	/**
	 * Componente não inicializado.
	 */
    public final int NAO_INICIALIZADA = 0;
    
    /**
     * Estado desconhecido.
     */
    public final int DESCONHECIDO = 1;
    
    /**
     * ECF Livre
     */
    public final int LIVRE = 2;
    
    /**
     * Cupom fiscal aberto, vendendo itens.
     */
    public final int VENDA = 3;
    
    /**
     * Cupom fiscal totalizado, aguardando pagamentos.
     */
    public final int PAGAMENTO = 4;
    
    /**
     * Emitindo relatório
     */
    public final int RELATORIO = 5;
    
    /**
     * Bloqueada até o próximo movimento.
     */
    public final int BLOQUEADA = 6;
    
    /**
     * Requer leitura X.
     */
    public final int REQUER_Z = 7;
    
    /**
     * Requer redução Z.
     */
    public final int REQUER_X = 8;
    
    /**
     * Emitindo cupom não fiscal.
     */
    public final int NAO_FISCAL = 9;
}
