using System.ComponentModel;
namespace ACBrFramework
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

		[Browsable(true)]
		public ACBrECFEmpresa Empresa { get; private set; }

		[Browsable(true)]
		public ACBrECFInfoPaf Paf { get; private set; }

		[Browsable(true)]
		public ACBrAACECFs ECFsAutorizados { get; private set; }

		public string NumeroLaudo
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_GetNumeroLaudo);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_SetNumeroLaudo, value);
			}
		}

		public string VersaoER
		{
			get
			{
				return GetString(ACBrAACInterop.AAC_IdentPaf_GetVersaoER);
			}
			set
			{
				SetString(ACBrAACInterop.AAC_IdentPaf_SetVersaoER, value);
			}
		}

		#endregion Properties
	}
}