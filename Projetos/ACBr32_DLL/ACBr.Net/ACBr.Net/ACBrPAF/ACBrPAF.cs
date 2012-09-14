using System;
using System.Collections.Generic;

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

		public string TrimString
		{
			get
			{
				return GetString(ACBrDll.PAF_GetTrimString);
			}
			set
			{
				SetString(ACBrDll.PAF_SetTrimString, value);
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

		public void SaveFileTXT_D(ACBrPAFRegistroD1 RegistroD1, List<ACBrPAFRegistroD2> RegistroD2, List<ACBrPAFRegistroD3> RegistroD3, string arquivo)
		{
			int i;

			ACBrDll.RegistroD1Rec RegistroD1Rec = new ACBrDll.RegistroD1Rec();
			ACBrDll.RegistroD2Rec[] RegistroD2Rec = new ACBrDll.RegistroD2Rec[RegistroD2.Count];
			ACBrDll.RegistroD3Rec[] RegistroD3Rec = new ACBrDll.RegistroD3Rec[RegistroD3.Count];

			RegistroD1Rec.RAZAOSOCIAL = RegistroD1.RazaoSocial;
			RegistroD1Rec.CNPJ = RegistroD1.CNPJ;
			RegistroD1Rec.UF = RegistroD1.UF;
			RegistroD1Rec.IE = RegistroD1.IE;
			RegistroD1Rec.IM = RegistroD1.IM;

			for (i = 0; i < RegistroD2.Count; i++)
			{
				RegistroD2Rec[i].QTD_ITENS = RegistroD2[i].QTD_ITENS;
				RegistroD2Rec[i].NUM_FAB = RegistroD2[i].NUM_FAB;
				RegistroD2Rec[i].MF_ADICIONAL = RegistroD2[i].MF_ADICIONAL;
				RegistroD2Rec[i].TIPO_ECF = RegistroD2[i].TIPO_ECF;
				RegistroD2Rec[i].MARCA_ECF = RegistroD2[i].MARCA_ECF;
				RegistroD2Rec[i].MODELO_ECF = RegistroD2[i].MODELO_ECF;
				RegistroD2Rec[i].COO = RegistroD2[i].COO;
				RegistroD2Rec[i].NUM_DAV = RegistroD2[i].NUM_DAV;
				RegistroD2Rec[i].DT_DAV = RegistroD2[i].DT_DAV;
				RegistroD2Rec[i].TIT_DAV = RegistroD2[i].TIT_DAV;
				RegistroD2Rec[i].VLT_DAV = RegistroD2[i].VLT_DAV;
				RegistroD2Rec[i].COO_DFV = RegistroD2[i].COO_DFV;
				RegistroD2Rec[i].NUMERO_ECF = RegistroD2[i].NUMERO_ECF;
				RegistroD2Rec[i].NOME_CLIENTE = RegistroD2[i].NOME_CLIENTE;
				RegistroD2Rec[i].CPF_CNPJ = RegistroD2[i].CPF_CNPJ;
				RegistroD2Rec[i].RegistroValido = RegistroD2[i].RegistroValido;
			}

			for (i = 0; i < RegistroD3.Count; i++)
			{
				RegistroD3Rec[i].DT_INCLUSAO = RegistroD3[i].DT_INCLUSAO;
				RegistroD3Rec[i].NUM_ITEM = RegistroD3[i].NUM_ITEM;
				RegistroD3Rec[i].COD_ITEM = RegistroD3[i].COD_ITEM;
				RegistroD3Rec[i].DESC_ITEM = RegistroD3[i].DESC_ITEM;
				RegistroD3Rec[i].QTDE_ITEM = RegistroD3[i].QTDE_ITEM;
				RegistroD3Rec[i].UNI_ITEM = RegistroD3[i].UNI_ITEM;
				RegistroD3Rec[i].VL_UNIT = RegistroD3[i].VL_UNIT;
				RegistroD3Rec[i].VL_DESCTO = RegistroD3[i].VL_DESCTO;
				RegistroD3Rec[i].VL_ACRES = RegistroD3[i].VL_ACRES;
				RegistroD3Rec[i].VL_TOTAL = RegistroD3[i].VL_TOTAL;
				RegistroD3Rec[i].DEC_VL_UNIT = RegistroD3[i].DEC_VL_UNIT;
				RegistroD3Rec[i].DEC_QTDE_ITEM = RegistroD3[i].DEC_QTDE_ITEM;
				RegistroD3Rec[i].SIT_TRIB = RegistroD3[i].SIT_TRIB;
				RegistroD3Rec[i].ALIQ = RegistroD3[i].ALIQ;
				RegistroD3Rec[i].IND_CANC = RegistroD3[i].IND_CANC;
				RegistroD3Rec[i].RegistroValido = RegistroD3[i].RegistroValido;
			}

			int ret = ACBrDll.PAF_SaveFileTXT_D(this.Handle, RegistroD1Rec, RegistroD2Rec, RegistroD2.Count, RegistroD3Rec, ToUTF8(arquivo));
			CheckResult(ret);
		}

		public void SaveFileTXT_P(ACBrPAFRegistroP1 RegistroP1, List<ACBrPAFRegistroP2> RegistroP2, string arquivo)
		{
			int i;

			ACBrDll.RegistroP1Rec RegistroP1Rec = new ACBrDll.RegistroP1Rec();
			ACBrDll.RegistroP2Rec[] RegistroP2Rec = new ACBrDll.RegistroP2Rec[RegistroP2.Count];

			RegistroP1Rec.RAZAOSOCIAL = RegistroP1.RazaoSocial;
			RegistroP1Rec.CNPJ = RegistroP1.CNPJ;
			RegistroP1Rec.UF = RegistroP1.UF;
			RegistroP1Rec.IE = RegistroP1.IE;
			RegistroP1Rec.IM = RegistroP1.IM;
			RegistroP1Rec.InclusaoExclusao = RegistroP1.InclusaoExclusao;

			for (i = 0; i < RegistroP2.Count; i++)
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

			int ret = ACBrDll.PAF_SaveFileTXT_P(this.Handle, RegistroP1Rec, RegistroP2Rec, RegistroP2.Count, ToUTF8(arquivo));
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