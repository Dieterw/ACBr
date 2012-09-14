using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace ACBr.Net
{
	public class ACBrAAC : ACBrComponent, IDisposable
	{
		#region InnerTypes

		public sealed class ACBrECFEmpresa : ACBrComposedComponent
		{
			#region Constructor

			internal ACBrECFEmpresa(ACBrECFIdenticacaoPaf identPaf) : base(identPaf.Parent) { }

			#endregion Constructor

			#region Properties

			public string RazaoSocial
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Empresa_GetRazaoSocial);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Empresa_SetRazaoSocial, value);
				}
			}

			public string CNPJ
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Empresa_GetCNPJ);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Empresa_SetCNPJ, value);
				}
			}

			public string IE
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Empresa_GetIE);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Empresa_SetIE, value);
				}
			}

			public string IM
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Empresa_GetIM);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Empresa_SetIM, value);
				}
			}

			#endregion Properties
		}

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
					return GetString(ACBrDll.AAC_IdentPaf_Paf_GetNome);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_SetNome, value);
				}
			}

			public string LinguagemAplicativo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Paf_GetLinguagem);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_SetLinguagem, value);
				}
			}

			public string BancoDeDadosAplicativo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Paf_GetBancoDados);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_SetBancoDados, value);
				}
			}

			public string SistemaOperacionalAplicativo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Paf_GetSistemaOperacional);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_SetSistemaOperacional, value);
				}
			}

			public string VersaoAplicativo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Paf_GetVersao);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_SetVersao, value);
				}
			}

			public string PrincipalExeAplicativo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Paf_PrincipalExe_GetNome);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_PrincipalExe_SetNome, value);
				}
			}

			public string MD5Aplicativo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_Paf_PrincipalExe_GetMD5);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_Paf_PrincipalExe_SetMD5, value);
				}
			}

			#endregion Dados do Aplicativo

			#region Dados de Funcionalidades

			public ACBrPAFTipoFuncionamento TipoFuncionamento
			{
				get
				{
					return (ACBrPAFTipoFuncionamento)GetInt32(ACBrDll.AAC_IdentPaf_Paf_GetTipoFuncionamento);
				}
				set
				{
					SetInt32(ACBrDll.AAC_IdentPaf_Paf_SetTipoFuncionamento, (int)value);
				}
			}

			public ACBrPAFTipoIntegracao TipoIntegracao
			{
				get
				{
					return (ACBrPAFTipoIntegracao)GetInt32(ACBrDll.AAC_IdentPaf_Paf_GetIntegracaoPafECF);
				}
				set
				{
					SetInt32(ACBrDll.AAC_IdentPaf_Paf_SetIntegracaoPafECF, (int)value);
				}
			}

			public ACBrPAFTipoDesenvolvimento TipoDesenvolvimento
			{
				get
				{
					return (ACBrPAFTipoDesenvolvimento)GetInt32(ACBrDll.AAC_IdentPaf_Paf_GetTipoDesenvolvimento);
				}
				set
				{
					SetInt32(ACBrDll.AAC_IdentPaf_Paf_SetTipoDesenvolvimento, (int)value);
				}
			}

			#endregion Dados de Funcionalidades

			#region Dados de Nao Concomitancia

			public bool RealizaPreVenda
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetRealizaPreVenda);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetRealizaPreVenda, value);
				}
			}

			public bool RealizaDAVECF
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetRealizaDAVECF);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetRealizaDAVECF, value);
				}
			}

			public bool RealizaDAVNaoFiscal
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetRealizaDAVNaoFiscal);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetRealizaDAVNaoFiscal, value);
				}
			}

			public bool RealizaDAVOS
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetRealizaDAVOS);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetRealizaDAVOS, value);
				}
			}

			public bool RealizaLancamentoMesa
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetRealizaLancamentoMesa);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetRealizaLancamentoMesa, value);
				}
			}

			public bool RealizaDAVConfAnexoII
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetDAVConfAnexoII);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetDAVConfAnexoII, value);
				}
			}

			#endregion Dados de Nao Concomitancia

			#region Dados de Aplicacoes Especiais

			public bool IndiceTecnicoProducao
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetIndiceTecnicoProd);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetIndiceTecnicoProd, value);
				}
			}

			public bool BarSimiliarECFRestaurante
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetBarSimilarECFRestaurante);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetBarSimilarECFRestaurante, value);
				}
			}

			public bool BarSimiliarECFComum
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetBarSimilarECFComum);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetBarSimilarECFComum, value);
				}
			}

			public bool BarSimiliarBalanca
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetBarSimilarBalanca);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetBarSimilarBalanca, value);
				}
			}

			public bool UsaImpressoraNaoFiscal
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetUsaImpressoraNaoFiscal);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetUsaImpressoraNaoFiscal, value);
				}
			}

			public bool DAVDiscrFormula
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetDAVDiscrFormula);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetDAVDiscrFormula, value);
				}
			}

			#endregion Dados de Aplicacoes Especiais

			#region Dados Criterios UF

			public bool TotalizaValoresLista
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetTotalizaValoresLista);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetTotalizaValoresLista, value);
				}
			}

			public bool TransPreVenda
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetTransfPreVenda);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetTransfPreVenda, value);
				}
			}

			public bool TransDAV
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetTransfDAV);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetTransfDAV, value);
				}
			}

			public bool RecompoeGT
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetRecompoeGT);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetRecompoeGT, value);
				}
			}

			public bool EmitePED
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetEmitePED);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetEmitePED, value);
				}
			}

			public bool CupomMania
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetCupomMania);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetCupomMania, value);
				}
			}

			public bool MinasLegal
			{
				get
				{
					return GetBool(ACBrDll.AAC_IdentPaf_Paf_GetMinasLegal);
				}
				set
				{
					SetBool(ACBrDll.AAC_IdentPaf_Paf_SetMinasLegal, value);
				}
			}

			#endregion Dados Criterios UF

			#endregion Properties
		}

		public sealed class ACBrECFIdenticacaoPaf : ACBrComposedComponent
		{
			#region Constructor

			internal ACBrECFIdenticacaoPaf(ACBrAAC acbrAAC)
				: base(acbrAAC)
			{
				this.Empresa = new ACBrECFEmpresa(this);
				this.Paf = new ACBrECFInfoPaf(this);
				this.ECFsAutorizados = new ACBrAACECFs(this);
			}

			#endregion Constructor

			#region Properties

			public ACBrECFEmpresa Empresa { get; private set; }

			public ACBrECFInfoPaf Paf { get; private set; }

			public ACBrAACECFs ECFsAutorizados { get; private set; }

			public string NumeroLaudo
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_GetNumeroLaudo);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_SetNumeroLaudo, value);
				}
			}

			public string VersaoER
			{
				get
				{
					return GetString(ACBrDll.AAC_IdentPaf_GetVersaoER);
				}
				set
				{
					SetString(ACBrDll.AAC_IdentPaf_SetVersaoER, value);
				}
			}

			#endregion Properties

			#region Methods

			protected override void OnDisposing()
			{
				this.Empresa.Dispose();
				this.Paf.Dispose();
				this.ECFsAutorizados.Dispose();
			}

			#endregion Methods
		}

		public sealed class ACBrAACECFs : ACBrComposedComponent, IEnumerable<ACBrAACECF>
		{
			#region Constructor

			internal ACBrAACECFs(ACBrECFIdenticacaoPaf identPaf) : base(identPaf.Parent) { }

			#endregion Constructor

			#region Properties

			public int Count
			{
				get
				{
					return GetInt32(ACBrDll.AAC_IdentPaf_ECFsAutorizados_Count);
				}
			}

			[IndexerName("GetItem")]
			public ACBrAACECF this[int index]
			{
				get
				{
					return Get(index);
				}
			}

			#endregion Properties

			#region Methods

			public void New(ACBrAACECF aacECF)
			{
				ACBrDll.TECFAutorizado item = new ACBrDll.TECFAutorizado();
				item.ValorGT = aacECF.ValorGT;
				item.NumeroSerie = aacECF.NumeroSerie;
				item.CNI = aacECF.CNI;
				item.CRO = aacECF.CRO;

				int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_New(this.Handle, item);
				CheckResult(ret);
			}

			public void Clear()
			{
				int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_Clear(this.Handle);
				CheckResult(ret);
			}

			private ACBrAACECF Get(int index)
			{
				ACBrDll.TECFAutorizado item = new ACBrDll.TECFAutorizado();
				int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_Get(this.Handle, ref item, index);
				CheckResult(ret);

				ACBrAACECF aacECF = new ACBrAACECF();
				aacECF.ValorGT = item.ValorGT;
				aacECF.NumeroSerie = item.NumeroSerie;
				aacECF.CNI = item.CNI;
				aacECF.CRO = item.CRO;
				aacECF.DtHrAtualizado = DateTime.FromOADate(item.DtHrAtualizado);

				return aacECF;
			}

			#endregion Methods

			#region IEnumerable<ACBrAACECF>

			public IEnumerator<ACBrAACECF> GetEnumerator()
			{
				int count = Count;
				for (int i = 0; i < count; i++)
				{
					yield return Get(i);
				}
			}

			IEnumerator IEnumerable.GetEnumerator()
			{
				return this.GetEnumerator();
			}

			#endregion IEnumerable<ACBrAACECF>
		}

		#endregion InnerTypes

		#region Constructor

		public ACBrAAC()
		{
			Create(ACBrDll.AAC_Create);
			IdentPaf = new ACBrECFIdenticacaoPaf(this);
		}

		#endregion Constructor

		#region Properties

		public string NomeArquivoAuxiliar
		{
			get
			{
				return GetString(ACBrDll.AAC_GetNomeArquivoAux);
			}
			set
			{
				SetString(ACBrDll.AAC_SetNomeArquivoAux, value);
			}
		}

		public string Chave
		{
			get
			{
				return GetString(ACBrDll.AAC_GetChave);
			}
			set
			{
				SetString(ACBrDll.AAC_SetChave, value);
			}
		}

		public string NomeArquivoLog
		{
			get
			{
				return GetString(ACBrDll.AAC_GetArqLOG);
			}
			set
			{
				SetString(ACBrDll.AAC_SetArqLOG, value);
			}
		}

		public string Parametros
		{
			get
			{
				return GetString(ACBrDll.AAC_GetParams);
			}
			set
			{
				SetString(ACBrDll.AAC_SetParams, value);
			}
		}

		public ACBrECFIdenticacaoPaf IdentPaf { get; private set; }

		#endregion Properties

		#region Methods

		public void AbrirArquivo()
		{
			int ret = ACBrDll.AAC_AbrirArquivo(this.Handle);
			CheckResult(ret);
		}

		public void SalvarArquivo()
		{
			int ret = ACBrDll.AAC_SalvarArquivo(this.Handle);
			CheckResult(ret);
		}

		public int VerificarGrandeTotal(string numSerie, double grandTotal)
		{
			int ret = ACBrDll.AAC_VerificarGTECF(this.Handle, numSerie, ref grandTotal);

			return ret;
		}

		public int ECFsAutorizadosCount
		{
			get
			{
				int ret = ACBrDll.AAC_IdentPaf_ECFsAutorizados_Count(this.Handle);

				CheckResult(ret);

				return ret;
			}
		}

		#region Overrides Methods

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				this.IdentPaf.Dispose();
				Destroy(ACBrDll.AAC_Destroy);
			}
		}

		protected internal override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					string error = GetString(ACBrDll.AAC_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr AAC não inicializado.");
			}
		}

		#endregion Overrides Methods

		#endregion Methods
	}
}