using System;

namespace ACBr.Net
{
    public class ACBrPAFRegistroC2
    {
        public string ID_ABASTECIMENTO { get; set; }
        public string TANQUE { get; set; }
        public string BOMBA { get; set; }
        public string BICO { get; set; }
        public string COMBUSTIVEL { get; set; }
        public DateTime DATA_ABASTECIMENTO { get; set; }
        public DateTime HORA_ABASTECIMENTO { get; set; }
        public double ENCERRANTE_INICIAL { get; set; }
        public double ENCERRANTE_FINAL { get; set; }
        public string STATUS_ABASTECIMENTO { get; set; }
        public string NRO_SERIE_ECF { get; set; }
        public DateTime DATA { get; set; }
        public DateTime HORA { get; set; }
        public int COO { get; set; }
        public int NRO_NOTA_FISCAL { get; set; }
        public Double VOLUME { get; set; }
        public bool RegistroValido { get; set; }
    }
}