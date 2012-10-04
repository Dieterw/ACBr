namespace ACBrFramework
{
	public sealed class ACBrECFInfoPaf : ACBrComposedComponent
	{
		#region Constructor

		internal ACBrECFInfoPaf(ACBrECFIdenticacaoPaf identPaf) : base(identPaf.Parent) { }

		#endregion Constructor

		#region Properties

		#region Dados do Aplicativo

		public string NomeAplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_GetNome);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_SetNome, value);
			}
		}

		public string LinguagemAplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_GetLinguagem);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_SetLinguagem, value);
			}
		}

		public string BancoDeDadosAplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_GetBancoDados);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_SetBancoDados, value);
			}
		}

		public string SistemaOperacionalAplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_GetSistemaOperacional);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_SetSistemaOperacional, value);
			}
		}

		public string VersaoAplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_GetVersao);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_SetVersao, value);
			}
		}

		public string PrincipalExeAplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_PrincipalExe_GetNome);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_PrincipalExe_SetNome, value);
			}
		}

		public string MD5Aplicativo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Paf_PrincipalExe_GetMD5);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Paf_PrincipalExe_SetMD5, value);
			}
		}

		#endregion Dados do Aplicativo

		#region Dados de Funcionalidades

		public ACBrPAFTipoFuncionamento TipoFuncionamento
		{
			get
			{
				return (ACBrPAFTipoFuncionamento)GetInt32(ACBrAACInterop.AAC_IdentPaf_Paf_GetTipoFuncionamento);
			}
			set
			{
				SetInt32(ACBrAACInterop.AAC_IdentPaf_Paf_SetTipoFuncionamento, (int)value);
			}
		}

		public ACBrPAFTipoIntegracao TipoIntegracao
		{
			get
			{
				return (ACBrPAFTipoIntegracao)GetInt32(ACBrAACInterop.AAC_IdentPaf_Paf_GetIntegracaoPafECF);
			}
			set
			{
				SetInt32(ACBrAACInterop.AAC_IdentPaf_Paf_SetIntegracaoPafECF, (int)value);
			}
		}

		public ACBrPAFTipoDesenvolvimento TipoDesenvolvimento
		{
			get
			{
				return (ACBrPAFTipoDesenvolvimento)GetInt32(ACBrAACInterop.AAC_IdentPaf_Paf_GetTipoDesenvolvimento);
			}
			set
			{
				SetInt32(ACBrAACInterop.AAC_IdentPaf_Paf_SetTipoDesenvolvimento, (int)value);
			}
		}

		#endregion Dados de Funcionalidades

		#region Dados de Nao Concomitancia

		public bool RealizaPreVenda
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetRealizaPreVenda);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetRealizaPreVenda, value);
			}
		}

		public bool RealizaDAVECF
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetRealizaDAVECF);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetRealizaDAVECF, value);
			}
		}

		public bool RealizaDAVNaoFiscal
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetRealizaDAVNaoFiscal);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetRealizaDAVNaoFiscal, value);
			}
		}

		public bool RealizaDAVOS
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetRealizaDAVOS);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetRealizaDAVOS, value);
			}
		}

		public bool RealizaLancamentoMesa
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetRealizaLancamentoMesa);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetRealizaLancamentoMesa, value);
			}
		}

		public bool RealizaDAVConfAnexoII
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetDAVConfAnexoII);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetDAVConfAnexoII, value);
			}
		}

		#endregion Dados de Nao Concomitancia

		#region Dados de Aplicacoes Especiais

		public bool IndiceTecnicoProducao
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetIndiceTecnicoProd);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetIndiceTecnicoProd, value);
			}
		}

		public bool BarSimiliarECFRestaurante
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetBarSimilarECFRestaurante);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetBarSimilarECFRestaurante, value);
			}
		}

		public bool BarSimiliarECFComum
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetBarSimilarECFComum);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetBarSimilarECFComum, value);
			}
		}

		public bool BarSimiliarBalanca
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetBarSimilarBalanca);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetBarSimilarBalanca, value);
			}
		}

		public bool UsaImpressoraNaoFiscal
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetUsaImpressoraNaoFiscal);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetUsaImpressoraNaoFiscal, value);
			}
		}

		public bool DAVDiscrFormula
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetDAVDiscrFormula);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetDAVDiscrFormula, value);
			}
		}

		#endregion Dados de Aplicacoes Especiais

		#region Dados Criterios UF

		public bool TotalizaValoresLista
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetTotalizaValoresLista);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetTotalizaValoresLista, value);
			}
		}

		public bool TransPreVenda
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetTransfPreVenda);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetTransfPreVenda, value);
			}
		}

		public bool TransDAV
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetTransfDAV);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetTransfDAV, value);
			}
		}

		public bool RecompoeGT
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetRecompoeGT);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetRecompoeGT, value);
			}
		}

		public bool EmitePED
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetEmitePED);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetEmitePED, value);
			}
		}

		public bool CupomMania
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetCupomMania);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetCupomMania, value);
			}
		}

		public bool MinasLegal
		{
			get
			{
				return GetBool(ACBrAACInterop.AAC_IdentPaf_Paf_GetMinasLegal);
			}
			set
			{
				SetBool(ACBrAACInterop.AAC_IdentPaf_Paf_SetMinasLegal, value);
			}
		}

		#endregion Dados Criterios UF

		#endregion Properties
	}
}