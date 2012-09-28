namespace ACBr.Net
{
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
}