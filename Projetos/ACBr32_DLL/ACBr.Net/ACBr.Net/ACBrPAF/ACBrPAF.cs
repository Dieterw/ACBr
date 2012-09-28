using System;

namespace ACBr.Net
{
	public class ACBrPAF : ACBrComponent, IDisposable
	{
		#region Fields

		private ACBrAAC aac;
		private ACBrEAD ead;

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

		public string ChaveRSA
		{
			get
			{
				return GetString(ACBrDll.PAF_GetChaveRSA, 1024);
			}
			set
			{
				SetString(ACBrDll.PAF_SetChaveRSA, value);
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

		public ACBrEAD EAD
		{
			get
			{
				return this.ead;
			}
			set
			{
				if (value == null)
				{
					int ret = ACBrDll.PAF_SetEAD(this.Handle, IntPtr.Zero);
					CheckResult(ret);

					this.aac = null;
				}
				else
				{
					int ret = ACBrDll.PAF_SetEAD(this.Handle, value.Handle);
					CheckResult(ret);

					this.ead = value;
				}
			}
		}

		#endregion Properties

		#region Methods

		#region AssinarArquivos

		public void AssinarArquivoComEAD(string arquivo)
		{
			int ret = ACBrDll.PAF_AssinarArquivoComEAD(this.Handle, arquivo);
			CheckResult(ret);
		}

		#endregion AssinarArquivos

		#region SaveFileTXT

		public void SaveFileTXT_B(ACBrPAFRegistroB1 RegistroB1, ACBrPAFRegistroB2[] RegistroB2, string arquivo)
		{
			int i;

			ACBrDll.RegistroHD1Rec RegistroB1Rec = new ACBrDll.RegistroHD1Rec();
			ACBrDll.RegistroB2Rec[] RegistroB2Rec = new ACBrDll.RegistroB2Rec[RegistroB2.Length];

			RegistroB1Rec.RAZAOSOCIAL = ToUTF8(RegistroB1.RazaoSocial);
			RegistroB1Rec.CNPJ = ToUTF8(RegistroB1.CNPJ);
			RegistroB1Rec.UF = ToUTF8(RegistroB1.UF);
			RegistroB1Rec.IE = ToUTF8(RegistroB1.IE);
			RegistroB1Rec.IM = ToUTF8(RegistroB1.IM);

			for (i = 0; i < RegistroB2.Length; i++)
			{
				RegistroB2Rec[i].BOMBA = RegistroB2[i].BOMBA;
				RegistroB2Rec[i].BICO = RegistroB2[i].BICO;
				RegistroB2Rec[i].DATA = RegistroB2[i].DATA.ToOADate();
				RegistroB2Rec[i].HORA = RegistroB2[i].HORA.ToOADate();
				RegistroB2Rec[i].MOTIVO = RegistroB2[i].MOTIVO;
				RegistroB2Rec[i].CNPJ_EMPRESA = RegistroB2[i].CNPJ_EMPRESA;
				RegistroB2Rec[i].CPF_TECNICO = RegistroB2[i].CPF_TECNICO;
				RegistroB2Rec[i].NRO_LACRE_ANTES = RegistroB2[i].NRO_LACRE_ANTES;
				RegistroB2Rec[i].NRO_LACRE_APOS = RegistroB2[i].NRO_LACRE_ANTES;
				RegistroB2Rec[i].ENCERRANTE_ANTES = RegistroB2[i].ENCERRANTE_ANTES;
				RegistroB2Rec[i].ENCERRANTE_APOS = RegistroB2[i].ENCERRANTE_APOS;
				RegistroB2Rec[i].RegistroValido = RegistroB2[i].RegistroValido;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_B(this.Handle, RegistroB1Rec, RegistroB2Rec, RegistroB2.Length, ToUTF8(arquivo));
			CheckResult(ret);
		}

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
			int i, ItemIndex = 0;
			int D3 = 0;

			foreach (ACBrPAFRegistroD2 D2 in RegistroD2)
			{
				D3 += D2.RegistroD3.Count;
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

				foreach (ACBrPAFRegistroD3 RegistroD3 in RegistroD2[i].RegistroD3)
				{
					RegistroD3Rec[ItemIndex].DT_INCLUSAO = RegistroD3.DT_INCLUSAO.ToOADate();
					RegistroD3Rec[ItemIndex].NUM_ITEM = RegistroD3.NUM_ITEM;
					RegistroD3Rec[ItemIndex].COD_ITEM = RegistroD3.COD_ITEM;
					RegistroD3Rec[ItemIndex].DESC_ITEM = RegistroD3.DESC_ITEM;
					RegistroD3Rec[ItemIndex].QTDE_ITEM = RegistroD3.QTDE_ITEM;
					RegistroD3Rec[ItemIndex].UNI_ITEM = RegistroD3.UNI_ITEM;
					RegistroD3Rec[ItemIndex].VL_UNIT = RegistroD3.VL_UNIT;
					RegistroD3Rec[ItemIndex].VL_DESCTO = RegistroD3.VL_DESCTO;
					RegistroD3Rec[ItemIndex].VL_ACRES = RegistroD3.VL_ACRES;
					RegistroD3Rec[ItemIndex].VL_TOTAL = RegistroD3.VL_TOTAL;
					RegistroD3Rec[ItemIndex].DEC_VL_UNIT = RegistroD3.DEC_VL_UNIT;
					RegistroD3Rec[ItemIndex].DEC_QTDE_ITEM = RegistroD3.DEC_QTDE_ITEM;
					RegistroD3Rec[ItemIndex].SIT_TRIB = RegistroD3.SIT_TRIB;
					RegistroD3Rec[ItemIndex].ALIQ = RegistroD3.ALIQ;
					RegistroD3Rec[ItemIndex].IND_CANC = RegistroD3.IND_CANC;
					RegistroD3Rec[ItemIndex].RegistroValido = RegistroD3.RegistroValido;
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

		public void SaveFileTXT_N(ACBrPAFRegistroN1 RegistroN1, ACBrPAFRegistroN2 RegistroN2, ACBrPAFRegistroN3[] RegistroN3, string arquivo)
		{
			int i;

			ACBrDll.RegistroHD1Rec RegistroN1Rec = new ACBrDll.RegistroHD1Rec();
			ACBrDll.RegistroN2Rec RegistroN2Rec = new ACBrDll.RegistroN2Rec();
			ACBrDll.RegistroN3Rec[] RegistroN3Rec = new ACBrDll.RegistroN3Rec[RegistroN3.Length];

			RegistroN1Rec.RAZAOSOCIAL = ToUTF8(RegistroN1.RazaoSocial);
			RegistroN1Rec.CNPJ = ToUTF8(RegistroN1.CNPJ);
			RegistroN1Rec.UF = ToUTF8(RegistroN1.UF);
			RegistroN1Rec.IE = ToUTF8(RegistroN1.IE);
			RegistroN1Rec.IM = ToUTF8(RegistroN1.IM);

			RegistroN2Rec.QTD_N3 = RegistroN3.Length;
			RegistroN2Rec.NOME = RegistroN2.NOME;
			RegistroN2Rec.LAUDO = RegistroN2.LAUDO;
			RegistroN2Rec.VERSAO = RegistroN2.VERSAO;

			for (i = 0; i < RegistroN3.Length; i++)
			{
				RegistroN3Rec[i].NOME_ARQUIVO = RegistroN3[i].NOME_ARQUIVO;
				RegistroN3Rec[i].MD5 = RegistroN3[i].MD5;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_N(this.Handle, RegistroN1Rec, RegistroN2Rec, RegistroN3Rec, ToUTF8(arquivo));
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

		public void SaveFileTXT_R(ACBrPAFRegistroR1 RegistroR1, ACBrPAFRegistroR2[] RegistroR2, ACBrPAFRegistroR4[] RegistroR4, ACBrPAFRegistroR6[] RegistroR6, string arquivo)
		{
			int i, ItemR3 = 0, ItemR5 = 0, ItemR7 = 0, R3 = 0, R5 = 0, R7 = 0;

			#region Contadores

			foreach (ACBrPAFRegistroR2 R2 in RegistroR2)
			{
				R3 += R2.RegistroR3.Count;
			}

			foreach (ACBrPAFRegistroR4 R4 in RegistroR4)
			{
				R5 += R4.RegistroR5.Count;
				R7 += R4.RegistroR7.Count;
			}

			foreach (ACBrPAFRegistroR6 R6 in RegistroR6)
			{
				R7 += R6.RegistroR7.Count;
			}

			#endregion Contadores

			ACBrDll.RegistroR1Rec RegistroR1Rec = new ACBrDll.RegistroR1Rec();
			ACBrDll.RegistroR2Rec[] RegistroR2Rec = new ACBrDll.RegistroR2Rec[RegistroR2.Length];
			ACBrDll.RegistroR3Rec[] RegistroR3Rec = new ACBrDll.RegistroR3Rec[R3];
			ACBrDll.RegistroR4Rec[] RegistroR4Rec = new ACBrDll.RegistroR4Rec[RegistroR4.Length];
			ACBrDll.RegistroR5Rec[] RegistroR5Rec = new ACBrDll.RegistroR5Rec[R5];
			ACBrDll.RegistroR6Rec[] RegistroR6Rec = new ACBrDll.RegistroR6Rec[RegistroR6.Length];
			ACBrDll.RegistroR7Rec[] RegistroR7Rec = new ACBrDll.RegistroR7Rec[R7];

			RegistroR1Rec.NUM_FAB = RegistroR1.NUM_FAB;
			RegistroR1Rec.MF_ADICIONAL = RegistroR1.MF_ADICIONAL;
			RegistroR1Rec.TIPO_ECF = RegistroR1.TIPO_ECF;
			RegistroR1Rec.MARCA_ECF = RegistroR1.MARCA_ECF;
			RegistroR1Rec.MODELO_ECF = RegistroR1.MODELO_ECF;
			RegistroR1Rec.VERSAO_SB = RegistroR1.VERSAO_SB;
			RegistroR1Rec.DT_INST_SB = RegistroR1.DT_INST_SB.ToOADate();
			RegistroR1Rec.HR_INST_SB = RegistroR1.HR_INST_SB.ToOADate();
			RegistroR1Rec.NUM_SEQ_ECF = RegistroR1.NUM_SEQ_ECF;
			RegistroR1Rec.CNPJ = RegistroR1.CNPJ;
			RegistroR1Rec.IE = RegistroR1.IE;
			RegistroR1Rec.CNPJ_SH = RegistroR1.CNPJ_SH;
			RegistroR1Rec.IE_SH = RegistroR1.IE_SH;
			RegistroR1Rec.IM_SH = RegistroR1.IM_SH;
			RegistroR1Rec.NOME_SH = RegistroR1.NOME_SH;
			RegistroR1Rec.NOME_PAF = RegistroR1.NOME_PAF;
			RegistroR1Rec.VER_PAF = RegistroR1.VER_PAF;
			RegistroR1Rec.COD_MD5 = RegistroR1.COD_MD5;
			RegistroR1Rec.DT_INI = RegistroR1.DT_INI.ToOADate();
			RegistroR1Rec.DT_FIN = RegistroR1.DT_FIN.ToOADate();
			RegistroR1Rec.ER_PAF_ECF = RegistroR1.ER_PAF_ECF;
			RegistroR1Rec.InclusaoExclusao = RegistroR1.InclusaoExclusao;
			RegistroR1Rec.RegistroValido = RegistroR1.RegistroValido;

			//R2 e R3
			for (i = 0; i < RegistroR2.Length; i++)
			{
				RegistroR2Rec[i].QTD_R3 = RegistroR2[i].RegistroR3.Count;
				RegistroR2Rec[i].NUM_USU = RegistroR2[i].NUM_USU;
				RegistroR2Rec[i].CRZ = RegistroR2[i].CRZ;
				RegistroR2Rec[i].COO = RegistroR2[i].COO;
				RegistroR2Rec[i].CRO = RegistroR2[i].CRO;
				RegistroR2Rec[i].DT_MOV = RegistroR2[i].DT_MOV.ToOADate();
				RegistroR2Rec[i].DT_EMI = RegistroR2[i].DT_EMI.ToOADate();
				RegistroR2Rec[i].HR_EMI = RegistroR2[i].HR_EMI;
				RegistroR2Rec[i].VL_VBD = RegistroR2[i].VL_VBD;
				RegistroR2Rec[i].PAR_ECF = RegistroR2[i].PAR_ECF;
				RegistroR2Rec[i].RegistroValido = RegistroR2[i].RegistroValido;

				foreach (ACBrPAFRegistroR3 RegistroR3 in RegistroR2[i].RegistroR3)
				{
					RegistroR3Rec[ItemR3].TOT_PARCIAL = RegistroR3.TOT_PARCIAL;
					RegistroR3Rec[ItemR3].VL_ACUM = RegistroR3.VL_ACUM;
					RegistroR3Rec[ItemR3].RegistroValido = RegistroR3.RegistroValido;
					ItemR3++;
				}
			}

			//R4, R5 e R7
			for (i = 0; i < RegistroR4.Length; i++)
			{
				RegistroR4Rec[i].QTD_R5 = RegistroR4[i].RegistroR5.Count;
				RegistroR4Rec[i].QTD_R7 = RegistroR4[i].RegistroR7.Count;
				RegistroR4Rec[i].NUM_USU = RegistroR4[i].NUM_USU;
				RegistroR4Rec[i].NUM_CONT = RegistroR4[i].NUM_CONT;
				RegistroR4Rec[i].COO = RegistroR4[i].COO;
				RegistroR4Rec[i].DT_INI = RegistroR4[i].DT_INI.ToOADate();
				RegistroR4Rec[i].SUB_DOCTO = RegistroR4[i].SUB_DOCTO;
				RegistroR4Rec[i].SUB_DESCTO = RegistroR4[i].SUB_DESCTO;
				RegistroR4Rec[i].TP_DESCTO = RegistroR4[i].TP_DESCTO;
				RegistroR4Rec[i].SUB_ACRES = RegistroR4[i].SUB_ACRES;
				RegistroR4Rec[i].TP_ACRES = RegistroR4[i].TP_ACRES;
				RegistroR4Rec[i].VL_TOT = RegistroR4[i].VL_TOT;
				RegistroR4Rec[i].CANC = RegistroR4[i].CANC;
				RegistroR4Rec[i].VL_CA = RegistroR4[i].VL_CA;
				RegistroR4Rec[i].ORDEM_DA = RegistroR4[i].ORDEM_DA;
				RegistroR4Rec[i].NOME_CLI = RegistroR4[i].NOME_CLI;
				RegistroR4Rec[i].CNPJ_CPF = RegistroR4[i].CNPJ_CPF;
				RegistroR4Rec[i].RegistroValido = RegistroR4[i].RegistroValido;

				foreach (ACBrPAFRegistroR5 RegistroR5 in RegistroR4[i].RegistroR5)
				{
					RegistroR5Rec[ItemR5].NUM_ITEM = RegistroR5.NUM_ITEM;
					RegistroR5Rec[ItemR5].COD_ITEM = RegistroR5.COD_ITEM;
					RegistroR5Rec[ItemR5].DESC_ITEM = RegistroR5.DESC_ITEM;
					RegistroR5Rec[ItemR5].QTDE_ITEM = RegistroR5.QTDE_ITEM;
					RegistroR5Rec[ItemR5].UN_MED = RegistroR5.UN_MED;
					RegistroR5Rec[ItemR5].VL_UNIT = RegistroR5.VL_UNIT;
					RegistroR5Rec[ItemR5].DESCTO_ITEM = RegistroR5.DESCTO_ITEM;
					RegistroR5Rec[ItemR5].ACRES_ITEM = RegistroR5.ACRES_ITEM;
					RegistroR5Rec[ItemR5].VL_TOT_ITEM = RegistroR5.VL_TOT_ITEM;
					RegistroR5Rec[ItemR5].COD_TOT_PARC = RegistroR5.COD_TOT_PARC;
					RegistroR5Rec[ItemR5].IND_CANC = RegistroR5.IND_CANC;
					RegistroR5Rec[ItemR5].QTDE_CANC = RegistroR5.QTDE_CANC;
					RegistroR5Rec[ItemR5].VL_CANC = RegistroR5.VL_CANC;
					RegistroR5Rec[ItemR5].VL_CANC_ACRES = RegistroR5.VL_CANC_ACRES;
					RegistroR5Rec[ItemR5].IAT = RegistroR5.IAT;
					RegistroR5Rec[ItemR5].IPPT = RegistroR5.IPPT;
					RegistroR5Rec[ItemR5].QTDE_DECIMAL = RegistroR5.QTDE_DECIMAL;
					RegistroR5Rec[ItemR5].VL_DECIMAL = RegistroR5.VL_DECIMAL;
					RegistroR5Rec[ItemR5].RegistroValido = RegistroR5.RegistroValido;
					ItemR5++;
				}

				foreach (ACBrPAFRegistroR7 RegistroR7 in RegistroR4[i].RegistroR7)
				{
					RegistroR7Rec[ItemR7].CCF = RegistroR7.CCF;
					RegistroR7Rec[ItemR7].GNF = RegistroR7.GNF;
					RegistroR7Rec[ItemR7].MP = RegistroR7.MP;
					RegistroR7Rec[ItemR7].VL_PAGTO = RegistroR7.VL_PAGTO;
					RegistroR7Rec[ItemR7].IND_EST = RegistroR7.IND_EST;
					RegistroR7Rec[ItemR7].VL_EST = RegistroR7.VL_EST;
					RegistroR7Rec[ItemR7].RegistroValido = RegistroR7.RegistroValido;
					ItemR7++;
				}
			}

			//R6 e R7
			for (i = 0; i < RegistroR6.Length; i++)
			{
				RegistroR6Rec[i].QTD_R7 = RegistroR6[i].RegistroR7.Count;
				RegistroR6Rec[i].NUM_USU = RegistroR6[i].NUM_USU;
				RegistroR6Rec[i].COO = RegistroR6[i].COO;
				RegistroR6Rec[i].GNF = RegistroR6[i].GNF;
				RegistroR6Rec[i].GRG = RegistroR6[i].GRG;
				RegistroR6Rec[i].CDC = RegistroR6[i].CDC;
				RegistroR6Rec[i].DENOM = RegistroR6[i].DENOM;
				RegistroR6Rec[i].DT_FIN = RegistroR6[i].DT_FIN.ToOADate();
				RegistroR6Rec[i].HR_FIN = RegistroR6[i].HR_FIN.ToOADate();
				RegistroR6Rec[i].RegistroValido = RegistroR6[i].RegistroValido;

				foreach (ACBrPAFRegistroR7 RegistroR7 in RegistroR6[i].RegistroR7)
				{
					RegistroR7Rec[ItemR7].CCF = RegistroR7.CCF;
					RegistroR7Rec[ItemR7].GNF = RegistroR7.GNF;
					RegistroR7Rec[ItemR7].MP = RegistroR7.MP;
					RegistroR7Rec[ItemR7].VL_PAGTO = RegistroR7.VL_PAGTO;
					RegistroR7Rec[ItemR7].IND_EST = RegistroR7.IND_EST;
					RegistroR7Rec[ItemR7].VL_EST = RegistroR7.VL_EST;
					RegistroR7Rec[ItemR7].RegistroValido = RegistroR7.RegistroValido;
					ItemR7++;
				}
			}

			int ret = ACBrDll.PAF_SaveFileTXT_R(this.Handle, RegistroR1Rec, RegistroR2Rec, RegistroR2.Length, RegistroR3Rec, RegistroR4Rec, RegistroR4.Length, RegistroR5Rec, RegistroR6Rec, RegistroR6.Length, RegistroR7Rec, ToUTF8(arquivo));
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