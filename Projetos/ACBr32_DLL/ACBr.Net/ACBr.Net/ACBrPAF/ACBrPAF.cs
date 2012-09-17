using System;

namespace ACBr.Net
{
	public class ACBrPAF : ACBrComponent, IDisposable
	{
		#region Fields

		private ACBrAAC aac;

		#endregion Fields

		#region Constructor

		public ACBrPAF()
		{
			Create(ACBrDll.PAF_Create);
		}

		#endregion Constructor

		#region Properties

		public string Path
		{
			get
			{
				return GetString(ACBrDll.PAF_GetPath);
			}
			set
			{
				SetString(ACBrDll.PAF_SetPath, value);
			}
		}

		public string Delimitador
		{
			get
			{
				return GetString(ACBrDll.PAF_GetDelimitador);
			}
			set
			{
				SetString(ACBrDll.PAF_SetDelimitador, value);
			}
		}

		public string CurMascara
		{
			get
			{
				return GetString(ACBrDll.PAF_GetCurMascara);
			}
			set
			{
				SetString(ACBrDll.PAF_SetCurMascara, value);
			}
		}

		public Boolean TrimString
		{
			get
			{
				return GetBool(ACBrDll.PAF_GetTrimString);
			}
			set
			{
				SetBool(ACBrDll.PAF_SetTrimString, value);
			}
		}

		public Boolean AssinarArquivo
		{
			get
			{
				return GetBool(ACBrDll.PAF_GetAssinarArquivo);
			}
			set
			{
				SetBool(ACBrDll.PAF_SetAssinarArquivo, value);
			}
		}

		public ACBrAAC AAC
		{
			get
			{
				return this.aac;
			}
			set
			{
				if (value == null)
				{
					int ret = ACBrDll.PAF_SetAAC(this.Handle, IntPtr.Zero);
					CheckResult(ret);

					this.aac = null;
				}
				else
				{
					int ret = ACBrDll.PAF_SetAAC(this.Handle, value.Handle);
					CheckResult(ret);

					this.aac = value;
				}
			}
		}

		#endregion Properties

		#region Methods

		#region SaveFileTXT

		public void SaveFileTXT_C(ACBrPAFRegistroC1 RegistroC1, ACBrPAFRegistroC2[] RegistroC2, string arquivo)
		{
			int i;

			ACBrDll.RegistroHD1Rec RegistroC1Rec = new ACBrDll.RegistroHD1Rec();
			ACBrDll.RegistroC2Rec[] RegistroC2Rec = new ACBrDll.RegistroC2Rec[RegistroC2.Length];

			RegistroC1Rec.RAZAOSOCIAL = ToUTF8(RegistroC1.RazaoSocial);
			RegistroC1Rec.CNPJ = ToUTF8(RegistroC1.CNPJ);
			RegistroC1Rec.UF = ToUTF8(RegistroC1.UF);
			RegistroC1Rec.IE = ToUTF8(RegistroC1.IE);
			RegistroC1Rec.IM = ToUTF8(RegistroC1.IM);

			for (i = 0; i < RegistroC2.Length; i++)
			{
				RegistroC2Rec[i].ID_ABASTECIMENTO = ToUTF8(RegistroC2[i].ID_ABASTECIMENTO);
				RegistroC2Rec[i].TANQUE = ToUTF8(RegistroC2[i].TANQUE);
				RegistroC2Rec[i].BOMBA = ToUTF8(RegistroC2[i].BOMBA);
				RegistroC2Rec[i].COMBUSTIVEL = ToUTF8(RegistroC2[i].COMBUSTIVEL);
				RegistroC2Rec[i].DATA_ABASTECIMENTO = RegistroC2[i].DATA_ABASTECIMENTO.ToOADate();
				RegistroC2Rec[i].HORA_ABASTECIMENTO = RegistroC2[i].HORA_ABASTECIMENTO.ToOADate();
				RegistroC2Rec[i].ENCERRANTE_INICIAL = RegistroC2[i].ENCERRANTE_INICIAL;
				RegistroC2Rec[i].ENCERRANTE_FINAL = RegistroC2[i].ENCERRANTE_FINAL;
				RegistroC2Rec[i].STATUS_ABASTECIMENTO = ToUTF8(RegistroC2[i].STATUS_ABASTECIMENTO);
				RegistroC2Rec[i].NRO_SERIE_ECF = ToUTF8(RegistroC2[i].NRO_SERIE_ECF);
				RegistroC2Rec[i].DATA = RegistroC2[i].DATA.ToOADate();
				RegistroC2Rec[i].HORA = RegistroC2[i].HORA.ToOADate();
				RegistroC2Rec[i].COO = RegistroC2[i].COO;
				RegistroC2Rec[i].NRO_NOTA_FISCAL = RegistroC2[i].NRO_NOTA_FISCAL;
				RegistroC2Rec[i].VOLUME = RegistroC2[i].VOLUME;
				RegistroC2Rec[i].RegistroValido = RegistroC2[i].RegistroValido;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_C(this.Handle, RegistroC1Rec, RegistroC2Rec, RegistroC2.Length, ToUTF8(arquivo));
			CheckResult(ret);
		}

		public void SaveFileTXT_D(ACBrPAFRegistroD1 RegistroD1, ACBrPAFRegistroD2[] RegistroD2, string arquivo)
		{
			int i, d, ItemIndex = 0;
			int D3 = 0;

			for (i = 0; i < RegistroD2.Length; i++)
			{
				D3 += RegistroD2[i].RegistroD3.Count;
			}

			ACBrDll.RegistroHD1Rec RegistroD1Rec = new ACBrDll.RegistroHD1Rec();
			ACBrDll.RegistroD2Rec[] RegistroD2Rec = new ACBrDll.RegistroD2Rec[RegistroD2.Length];
			ACBrDll.RegistroD3Rec[] RegistroD3Rec = new ACBrDll.RegistroD3Rec[D3];

			RegistroD1Rec.RAZAOSOCIAL = ToUTF8(RegistroD1.RazaoSocial);
			RegistroD1Rec.CNPJ = ToUTF8(RegistroD1.CNPJ);
			RegistroD1Rec.UF = ToUTF8(RegistroD1.UF);
			RegistroD1Rec.IE = ToUTF8(RegistroD1.IE);
			RegistroD1Rec.IM = ToUTF8(RegistroD1.IM);

			for (i = 0; i < RegistroD2.Length; i++)
			{
				RegistroD2Rec[i].QTD_D3 = RegistroD2[i].RegistroD3.Count;
				RegistroD2Rec[i].NUM_FAB = ToUTF8(RegistroD2[i].NUM_FAB);
				RegistroD2Rec[i].MF_ADICIONAL = ToUTF8(RegistroD2[i].MF_ADICIONAL);
				RegistroD2Rec[i].TIPO_ECF = ToUTF8(RegistroD2[i].TIPO_ECF);
				RegistroD2Rec[i].MARCA_ECF = RegistroD2[i].MARCA_ECF;
				RegistroD2Rec[i].MODELO_ECF = RegistroD2[i].MODELO_ECF;
				RegistroD2Rec[i].COO = RegistroD2[i].COO;
				RegistroD2Rec[i].NUM_DAV = RegistroD2[i].NUM_DAV;
				RegistroD2Rec[i].DT_DAV = RegistroD2[i].DT_DAV.ToOADate();
				RegistroD2Rec[i].TIT_DAV = RegistroD2[i].TIT_DAV;
				RegistroD2Rec[i].VLT_DAV = RegistroD2[i].VLT_DAV;
				RegistroD2Rec[i].COO_DFV = RegistroD2[i].COO_DFV;
				RegistroD2Rec[i].NUMERO_ECF = RegistroD2[i].NUMERO_ECF;
				RegistroD2Rec[i].NOME_CLIENTE = RegistroD2[i].NOME_CLIENTE;
				RegistroD2Rec[i].CPF_CNPJ = RegistroD2[i].CPF_CNPJ;
				RegistroD2Rec[i].RegistroValido = RegistroD2[i].RegistroValido;

				for (d = 0; d < RegistroD2[i].RegistroD3.Count; d++)
				{
					RegistroD3Rec[ItemIndex].DT_INCLUSAO = RegistroD2[i].RegistroD3[d].DT_INCLUSAO.ToOADate();
					RegistroD3Rec[ItemIndex].NUM_ITEM = RegistroD2[i].RegistroD3[d].NUM_ITEM;
					RegistroD3Rec[ItemIndex].COD_ITEM = RegistroD2[i].RegistroD3[d].COD_ITEM;
					RegistroD3Rec[ItemIndex].DESC_ITEM = RegistroD2[i].RegistroD3[d].DESC_ITEM;
					RegistroD3Rec[ItemIndex].QTDE_ITEM = RegistroD2[i].RegistroD3[d].QTDE_ITEM;
					RegistroD3Rec[ItemIndex].UNI_ITEM = RegistroD2[i].RegistroD3[d].UNI_ITEM;
					RegistroD3Rec[ItemIndex].VL_UNIT = RegistroD2[i].RegistroD3[d].VL_UNIT;
					RegistroD3Rec[ItemIndex].VL_DESCTO = RegistroD2[i].RegistroD3[d].VL_DESCTO;
					RegistroD3Rec[ItemIndex].VL_ACRES = RegistroD2[i].RegistroD3[d].VL_ACRES;
					RegistroD3Rec[ItemIndex].VL_TOTAL = RegistroD2[i].RegistroD3[d].VL_TOTAL;
					RegistroD3Rec[ItemIndex].DEC_VL_UNIT = RegistroD2[i].RegistroD3[d].DEC_VL_UNIT;
					RegistroD3Rec[ItemIndex].DEC_QTDE_ITEM = RegistroD2[i].RegistroD3[d].DEC_QTDE_ITEM;
					RegistroD3Rec[ItemIndex].SIT_TRIB = RegistroD2[i].RegistroD3[d].SIT_TRIB;
					RegistroD3Rec[ItemIndex].ALIQ = RegistroD2[i].RegistroD3[d].ALIQ;
					RegistroD3Rec[ItemIndex].IND_CANC = RegistroD2[i].RegistroD3[d].IND_CANC;
					RegistroD3Rec[ItemIndex].RegistroValido = RegistroD2[i].RegistroD3[d].RegistroValido;
					ItemIndex++;
				}
			}

			int ret = ACBrDll.PAF_SaveFileTXT_D(this.Handle, RegistroD1Rec, RegistroD2Rec, RegistroD2.Length, RegistroD3Rec, ToUTF8(arquivo));
			CheckResult(ret);
		}

		public void SaveFileTXT_E(ACBrPAFRegistroE1 RegistroE1, ACBrPAFRegistroE2[] RegistroE2, string arquivo)
		{
			int i;

			ACBrDll.RegistroHD2Rec RegistroE1Rec = new ACBrDll.RegistroHD2Rec();
			ACBrDll.RegistroE2Rec[] RegistroE2Rec = new ACBrDll.RegistroE2Rec[RegistroE2.Length];

			RegistroE1Rec.RAZAOSOCIAL = ToUTF8(RegistroE1.RazaoSocial);
			RegistroE1Rec.CNPJ = ToUTF8(RegistroE1.CNPJ);
			RegistroE1Rec.UF = ToUTF8(RegistroE1.UF);
			RegistroE1Rec.IE = ToUTF8(RegistroE1.IE);
			RegistroE1Rec.IM = ToUTF8(RegistroE1.IM);
			RegistroE1Rec.NUM_FAB = ToUTF8(RegistroE1.NUM_FAB);
			RegistroE1Rec.MF_ADICIONAL = ToUTF8(RegistroE1.MF_ADICIONAL);
			RegistroE1Rec.TIPO_ECF = ToUTF8(RegistroE1.TIPO_ECF);
			RegistroE1Rec.MARCA_ECF = ToUTF8(RegistroE1.MARCA_ECF);
			RegistroE1Rec.MODELO_ECF = ToUTF8(RegistroE1.NUM_FAB);
			RegistroE1Rec.DT_EST = RegistroE1.DT_EST.ToOADate();
			RegistroE1Rec.RegistroValido = RegistroE1.RegistroValido;
			RegistroE1Rec.InclusaoExclusao = RegistroE1.InclusaoExclusao;

			for (i = 0; i < RegistroE2.Length; i++)
			{
				RegistroE2Rec[i].COD_MERC = ToUTF8(RegistroE2[i].COD_MERC);
				RegistroE2Rec[i].DESC_MERC = ToUTF8(RegistroE2[i].DESC_MERC);
				RegistroE2Rec[i].UN_MED = ToUTF8(RegistroE2[i].UN_MED);
				RegistroE2Rec[i].QTDE_EST = RegistroE2[i].QTDE_EST;
				RegistroE2Rec[i].RegistroValido = RegistroE2[i].RegistroValido;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_E(this.Handle, RegistroE1Rec, RegistroE2Rec, RegistroE2.Length, ToUTF8(arquivo));
			CheckResult(ret);
		}

		public void SaveFileTXT_H(ACBrPAFRegistroH1 RegistroH1, ACBrPAFRegistroH2[] RegistroH2, string arquivo)
		{
			int i;

			ACBrDll.RegistroHD2Rec RegistroH1Rec = new ACBrDll.RegistroHD2Rec();
			ACBrDll.RegistroH2Rec[] RegistroH2Rec = new ACBrDll.RegistroH2Rec[RegistroH2.Length];

			RegistroH1Rec.RAZAOSOCIAL = ToUTF8(RegistroH1.RazaoSocial);
			RegistroH1Rec.CNPJ = ToUTF8(RegistroH1.CNPJ);
			RegistroH1Rec.UF = ToUTF8(RegistroH1.UF);
			RegistroH1Rec.IE = ToUTF8(RegistroH1.IE);
			RegistroH1Rec.IM = ToUTF8(RegistroH1.IM);
			RegistroH1Rec.NUM_FAB = ToUTF8(RegistroH1.NUM_FAB);
			RegistroH1Rec.MF_ADICIONAL = ToUTF8(RegistroH1.MF_ADICIONAL);
			RegistroH1Rec.TIPO_ECF = ToUTF8(RegistroH1.TIPO_ECF);
			RegistroH1Rec.MARCA_ECF = ToUTF8(RegistroH1.MARCA_ECF);
			RegistroH1Rec.MODELO_ECF = ToUTF8(RegistroH1.NUM_FAB);
			RegistroH1Rec.DT_EST = RegistroH1.DT_EST.ToOADate();
			RegistroH1Rec.RegistroValido = RegistroH1.RegistroValido;
			RegistroH1Rec.InclusaoExclusao = RegistroH1.InclusaoExclusao;

			for (i = 0; i < RegistroH2.Length; i++)
			{
				RegistroH2Rec[i].CNPJ_CRED_CARTAO = ToUTF8(RegistroH2[i].CNPJ_CRED_CARTAO);
				RegistroH2Rec[i].COO = RegistroH2[i].COO;
				RegistroH2Rec[i].CCF = RegistroH2Rec[i].CCF;
				RegistroH2Rec[i].VLR_TROCO = RegistroH2Rec[i].VLR_TROCO;
				RegistroH2Rec[i].DT_TROCO = RegistroH2[i].DT_TROCO.ToOADate();
				RegistroH2Rec[i].CPF = ToUTF8(RegistroH2[i].CPF);
				RegistroH2Rec[i].Titulo = ToUTF8(RegistroH2[i].Titulo);
				RegistroH2Rec[i].RegistroValido = RegistroH2[i].RegistroValido;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_H(this.Handle, RegistroH1Rec, RegistroH2Rec, RegistroH2.Length, ToUTF8(arquivo));
			CheckResult(ret);
		}

		public void SaveFileTXT_P(ACBrPAFRegistroP1 RegistroP1, ACBrPAFRegistroP2[] RegistroP2, string arquivo)
		{
			int i;

			ACBrDll.RegistroHD1Rec RegistroP1Rec = new ACBrDll.RegistroHD1Rec();
			ACBrDll.RegistroP2Rec[] RegistroP2Rec = new ACBrDll.RegistroP2Rec[RegistroP2.Length];

			RegistroP1Rec.RAZAOSOCIAL = RegistroP1.RazaoSocial;
			RegistroP1Rec.CNPJ = RegistroP1.CNPJ;
			RegistroP1Rec.UF = RegistroP1.UF;
			RegistroP1Rec.IE = RegistroP1.IE;
			RegistroP1Rec.IM = RegistroP1.IM;

			for (i = 0; i < RegistroP2.Length; i++)
			{
				RegistroP2Rec[i].COD_MERC_SERV = RegistroP2[i].COD_MERC_SERV;
				RegistroP2Rec[i].DESC_MERC_SERV = RegistroP2[i].DESC_MERC_SERV;
				RegistroP2Rec[i].UN_MED = RegistroP2[i].UN_MED;
				RegistroP2Rec[i].IAT = RegistroP2[i].IAT;
				RegistroP2Rec[i].IPPT = RegistroP2[i].IPPT;
				RegistroP2Rec[i].ST = RegistroP2[i].ST;
				RegistroP2Rec[i].ALIQ = RegistroP2[i].ALIQ;
				RegistroP2Rec[i].VL_UNIT = RegistroP2[i].VL_UNIT;
				RegistroP2Rec[i].RegistroValido = RegistroP2[i].RegistroValido;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_P(this.Handle, RegistroP1Rec, RegistroP2Rec, RegistroP2.Length, ToUTF8(arquivo));
			CheckResult(ret);
		}

		#endregion SaveFileTXT

		#region Override Methods

		protected internal override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					string error = GetString(ACBrDll.PAF_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr PAF não inicializado.");
			}
		}

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				Destroy(ACBrDll.PAF_Destroy);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}