package jACBr;

public class FormaPagamento 
{
    private String indice;
    private String descricao;
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
    
    public boolean getPermiteVinculado()
    {
    	return permiteVinculado;
    }
    
    public double getTotal()
    {
    	return total;
    }
}
