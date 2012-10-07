namespace ACBrFramework
{
	public class ACBrECFRelatorioGerencialRec
	{
		public int Count { get; set; }
		public string[] Linhas { get; set; }

		public ACBrECFRelatorioGerencialRec()
		{
		}

		public ACBrECFRelatorioGerencialRec(int Qtdlinhas)
		{
			Linhas = new string[Qtdlinhas];
		}
	}
}
