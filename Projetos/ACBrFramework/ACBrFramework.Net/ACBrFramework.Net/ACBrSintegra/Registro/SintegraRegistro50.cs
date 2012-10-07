using System;

namespace ACBrFramework
{
	public class SintegraRegistro50
	{
		public int CPFCNPJ { get; set; }
		public int Inscricao { get; set; }
		public string UF { get; set; }
		public string Situacao { get; set; }
		public double Aliquota { get; set; }
		public double Isentas { get; set; }
		public double Icms { get; set; }
		public double ValorContabil { get; set; }
		public double BasedeCalculo { get; set; }
		public double Outras { get; set; }
		public string EmissorDocumento { get; set; }
		public string Cfop { get; set; }
		public string Serie { get; set; }
		public string Modelo { get; set; }
		public int Numero { get; set; }
		public DateTime DataDocumento { get; set; }
	}
}