using System;
using System.Drawing;

namespace ACBrFramework
{
	[ToolboxBitmap(typeof(ACBrSintegra), @"ACBrSintegra.ico.bmp")]
	public class ACBrSintegra : ACBrComponent, IDisposable
	{
		#region Fields

		#endregion Fields

		#region Constructor

		public ACBrSintegra()
		{
		}

		#endregion Constructor

		#region Properties

		public string FileName
		{
			get
			{
				return GetString(ACBrSintegraInterop.SIN_GetFileName);
			}
			set
			{
				SetString(ACBrSintegraInterop.SIN_SetFileName, value);
			}
		}

		public VersaoValidador VersaoValidador
		{
			get
			{
				return (VersaoValidador)GetInt32(ACBrSintegraInterop.SIN_GetVersaoValidador);
			}
			set
			{
				SetInt32(ACBrSintegraInterop.SIN_SetVersaoValidador, (int)value);
			}
		}

		public bool Ativo
		{
			get
			{
				return GetBool(ACBrSintegraInterop.SIN_GetAtivo);
			}
		}

		#endregion Properties

		#region Methods

		public void LimparRegistros()
		{
			int ret = ACBrSintegraInterop.SIN_LimparRegistros(this.Handle);
			CheckResult(ret);
		}

		public void Registro10(SintegraRegistro10 registro10)
		{
			var record = new ACBrSintegraInterop.Registro10Rec();
			record.RazaoSocial = registro10.RazaoSocial;
			record.CNPJ = registro10.CNPJ;
			record.Inscricao = registro10.Inscricao;
			record.Cidade = registro10.Cidade;
			record.Estado = registro10.Estado;
			record.Telefone = registro10.Telefone;
			record.DataInicial = registro10.DataInicial.ToOADate();
			record.DataFinal = registro10.DataFinal.ToOADate();
			record.NaturezaInformacoes = registro10.NaturezaInformacoes;
			record.FinalidadeArquivo = registro10.FinalidadeArquivo;
			record.CodigoConvenio = registro10.CodigoConvenio;

			int ret = ACBrSintegraInterop.SIN_Registro10(this.Handle, record);
			CheckResult(ret);
		}

		#region Override Methods

		protected internal override void OnInitializeComponent()
		{
			CallCreate(ACBrSintegraInterop.SIN_Create);
		}

		protected internal override void CheckResult(int ret)
		{
			switch (ret)
			{
				case -1:

					string error = GetString(ACBrSintegraInterop.SIN_GetUltimoErro);
					throw new ACBrECFException(error);

				case -2:

					throw new ACBrECFException("ACBr Sintegra não inicializado.");
			}
		}

		protected override void OnDisposing()
		{
			if (this.Handle != IntPtr.Zero)
			{
				CallDestroy(ACBrSintegraInterop.SIN_Destroy);
			}
		}

		#endregion Override Methods

		#endregion Methods
	}
}