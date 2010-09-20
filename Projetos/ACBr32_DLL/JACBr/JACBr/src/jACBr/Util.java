package jACBr;

import java.util.Date;
import java.util.TimeZone;

public class Util 
{
	/**
	 * Converte o formato OLE de data representado por um Double para o tipo java.util.Date
	 */
	public static Date doubleToDate(double value) throws Exception
	{
	    if ((value >= 2958466.0) || (value <= -657435.0))
	    {
	        throw new Exception("Arg_OleAutDateInvalid");
	    }
	    
	    long num = (long) ((value * 86400000.0) + ((value >= 0.0) ? 0.5 : -0.5));
	    if (num < 0L)
	    {
	        num -= (num % 0x5265c00L) * 2L;
	    }
	    
	    num += 0x3680b5e1fc00L;
	    if ((num < 0L) || (num >= 0x11efae44cb400L))
	    {
	        throw new Exception("Arg_OleAutDateScale");
	    }
	    
	    long ticks = (num * 0x2710L);
	    
	    final long DIFF_IN_MILLIS = 11644473600000L;
	    long javaTime = ( ticks / 10000 ) - DIFF_IN_MILLIS;
	 
		TimeZone timeZone = TimeZone.getDefault();
		javaTime -= timeZone.getOffset(javaTime);
	    
	    Date date = new Date(javaTime);
	    return date;
	}

}
