namespace ACBrFramework.Net
{
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
				return GetString(ACBrAACInterop.AAC_IdentPaf_Empresa_GetRazaoSocial);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Empresa_SetRazaoSocial, value);
			}
		}

		public string CNPJ
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Empresa_GetCNPJ);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Empresa_SetCNPJ, value);
			}
		}

		public string IE
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Empresa_GetIE);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Empresa_SetIE, value);
			}
		}

		public string IM
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_Empresa_GetIM);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_Empresa_SetIM, value);
			}
		}

		#endregion Properties
	}
}