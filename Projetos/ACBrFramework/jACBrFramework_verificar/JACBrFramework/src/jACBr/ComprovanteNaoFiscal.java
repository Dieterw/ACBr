package jACBr;

public class ComprovanteNaoFiscal 
{
    private String indice;
    private String descricao;
    private String formaPagamento;
    private int contador;
    private boolean permiteVinculado;
    private double total;
    
    public String getIndice()
    {
    	return indice;
    }
    
    public String getDescricao()
    {
    	return descricao;
    }

    public String getFormaPagamento()
    {
    	return formaPagamento;
    }
    
    public int getContador()
    {
    	return contador;
    }
    
    public boolean getPermiteVinculado()
    {
    	return permiteVinculado;
    }
    
    public double getTotal()
    {
    	return total;
    }
}
