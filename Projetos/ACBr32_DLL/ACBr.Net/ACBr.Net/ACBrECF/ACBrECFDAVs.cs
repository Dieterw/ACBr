using System;

namespace ACBr.Net
{
    public sealed class ACBrECFDAVs
    {
        public string Numero { get; set; }
        public int COO_Cupom { get; set; }
        public int COO_Dav { get; set; }
        public string Titulo { get; set; }
        public double Valor { get; set; }
        public DateTime DtEmissao { get; set; }
    }
}
