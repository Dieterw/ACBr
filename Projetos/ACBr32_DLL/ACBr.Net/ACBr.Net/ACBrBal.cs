using System;
using System.Collections.Generic;
using System.Text;

namespace ACBr.Net
{
    public sealed class ACBrBal : ACBrDevice, IDisposable
    {
        #region Constructor

        public ACBrBal()
        {
            int ret = ACBrDll.BAL_Create(ref this.handle);
            CheckResult(ret);
        }

        #endregion Constructor

        #region Properties

        public bool Ativo
        {
            get
            {
                return GetBool(ACBrDll.BAL_GetAtivo);
            }
        }

        public ModeloBal Modelo
        {
            get
            {
                return (ModeloBal)GetInt32(ACBrDll.BAL_GetModelo);
            }
            set
            {
                SetInt32(ACBrDll.BAL_SetModelo, (int)value);
            }
        }

        public string Porta
        {
            get
            {
                return GetString(ACBrDll.BAL_GetPorta);
            }
            set
            {
                SetString(ACBrDll.BAL_SetPorta, value);
            }
        }

        #endregion Properties

        #region Methods

        public void Ativar()
        {
            int ret = ACBrDll.BAL_Ativar(this.handle);
            CheckResult(ret);
        }

        public void Desativar()
        {
            int ret = ACBrDll.BAL_Desativar(this.handle);
            CheckResult(ret);
        }

        #region Override Methods

        protected override void CheckResult(int ret)
        {
            switch (ret)
            {
                case -1:

                    string error = GetString(ACBrDll.BAL_GetUltimoErro);
                    throw new ACBrECFException(error);

                case -2:

                    throw new ACBrECFException("ACBr BAL não inicializado.");

            }
        }

        protected override void Dispose(bool disposing)
        {
            if (this.handle != IntPtr.Zero)
            {
                int ret = ACBrDll.BAL_Destroy(ref this.handle);
                this.handle = IntPtr.Zero;
            }

            if (disposing)
            {
                GC.SuppressFinalize(this);
            }
        }

        #endregion Override Methods

        #endregion Methods

    }
}
