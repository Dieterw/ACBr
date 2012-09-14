using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

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
        #endregion

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
        #endregion

        #region Methods

        #region SaveFileTXT
        public void SaveFileTXT_C(ACBrPAFRegistroC1 RegistroC1, ACBrPAFRegistroC2[] RegistroC2, string arquivo)
        {
            int i;

            ACBrDll.RegistroTXRec RegistroC1Rec = new ACBrDll.RegistroTXRec();
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
                RegistroC2Rec[i].HORA_ABASTECIMENTO = ToUTF8(RegistroC2[i].HORA_ABASTECIMENTO.ToLongTimeString());
                RegistroC2Rec[i].ENCERRANTE_INICIAL = RegistroC2[i].ENCERRANTE_INICIAL;
                RegistroC2Rec[i].ENCERRANTE_FINAL = RegistroC2[i].ENCERRANTE_FINAL;
                RegistroC2Rec[i].STATUS_ABASTECIMENTO = ToUTF8(RegistroC2[i].STATUS_ABASTECIMENTO);
                RegistroC2Rec[i].NRO_SERIE_ECF = ToUTF8(RegistroC2[i].NRO_SERIE_ECF);
                RegistroC2Rec[i].DATA = RegistroC2[i].DATA.ToOADate();
                RegistroC2Rec[i].HORA = ToUTF8(RegistroC2[i].HORA.ToLongTimeString());
                RegistroC2Rec[i].COO = RegistroC2[i].COO;
                RegistroC2Rec[i].NRO_NOTA_FISCAL = RegistroC2[i].NRO_NOTA_FISCAL;
                RegistroC2Rec[i].VOLUME = RegistroC2[i].VOLUME;
                RegistroC2Rec[i].RegistroValido = RegistroC2[i].RegistroValido;

            }

            int ret = ACBrDll.PAF_SaveFileTXT_C(this.Handle, ref RegistroC1Rec, ref RegistroC2Rec, RegistroC2.Length, ToUTF8(arquivo));
            CheckResult(ret);
        }

        public void SaveFileTXT_D(ACBrPAFRegistroD1 RegistroD1, ACBrPAFRegistroD2[] RegistroD2, ACBrPAFRegistroD3[] RegistroD3, string arquivo)
        {
            int i;

            ACBrDll.RegistroTXRec RegistroD1Rec = new ACBrDll.RegistroTXRec();
            ACBrDll.RegistroD2Rec[] RegistroD2Rec = new ACBrDll.RegistroD2Rec[RegistroD2.Length];
            ACBrDll.RegistroD3Rec[] RegistroD3Rec = new ACBrDll.RegistroD3Rec[RegistroD3.Length];

            RegistroD1Rec.RAZAOSOCIAL = ToUTF8(RegistroD1.RazaoSocial);
            RegistroD1Rec.CNPJ = ToUTF8(RegistroD1.CNPJ);
            RegistroD1Rec.UF = ToUTF8(RegistroD1.UF);
            RegistroD1Rec.IE = ToUTF8(RegistroD1.IE);
            RegistroD1Rec.IM = ToUTF8(RegistroD1.IM);

            for (i = 0; i < RegistroD2.LongLength; i++)
            {
                RegistroD2Rec[i].QTD_ITENS = RegistroD2[i].QTD_ITENS;
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
            }

            for (i = 0; i < RegistroD3.Length; i++)
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

            int ret = ACBrDll.PAF_SaveFileTXT_D(this.Handle, ref RegistroD1Rec, ref RegistroD2Rec, RegistroD2.Length, ref RegistroD3Rec, ToUTF8(arquivo));
            CheckResult(ret);
        }

        public void SaveFileTXT_P(ACBrPAFRegistroP1 RegistroP1, ACBrPAFRegistroP2[] RegistroP2, string arquivo)
        {
            int i;

            ACBrDll.RegistroTXRec RegistroP1Rec = new ACBrDll.RegistroTXRec();
            ACBrDll.RegistroP2Rec[] RegistroP2Rec = new ACBrDll.RegistroP2Rec[RegistroP2.Length];

            RegistroP1Rec.RAZAOSOCIAL = RegistroP1.RazaoSocial;
            RegistroP1Rec.CNPJ = RegistroP1.CNPJ;
            RegistroP1Rec.UF = RegistroP1.UF;
            RegistroP1Rec.IE = RegistroP1.IE;
            RegistroP1Rec.IM = RegistroP1.IM;
            RegistroP1Rec.InclusaoExclusao = RegistroP1.InclusaoExclusao;

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

            int ret = ACBrDll.PAF_SaveFileTXT_P(this.Handle, ref RegistroP1Rec, ref RegistroP2Rec, RegistroP2.Length, ToUTF8(arquivo));
            CheckResult(ret);
        }
        #endregion

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

        #endregion
    }
}
