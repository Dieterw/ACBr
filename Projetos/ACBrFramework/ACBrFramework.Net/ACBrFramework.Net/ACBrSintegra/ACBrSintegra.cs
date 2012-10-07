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
			record.RazaoSocial = ToUTF8(registro10.RazaoSocial);
			record.CNPJ = ToUTF8(registro10.CNPJ.ToString());
			record.Inscricao = ToUTF8(registro10.Inscricao.ToString());
			record.Cidade = ToUTF8(registro10.Cidade);
			record.Estado = ToUTF8(registro10.Estado);
			record.Telefone = ToUTF8(registro10.Telefone.ToString());
			record.DataInicial = registro10.DataInicial.ToOADate();
			record.DataFinal = registro10.DataFinal.ToOADate();
			record.NaturezaInformacoes = registro10.NaturezaInformacoes;
			record.FinalidadeArquivo = registro10.FinalidadeArquivo;
			record.CodigoConvenio = registro10.CodigoConvenio;

			int ret = ACBrSintegraInterop.SIN_Registro10(this.Handle, record);
			CheckResult(ret);
		}

		public void Registro11(SintegraRegistro11 registro11)
		{
			var record = new ACBrSintegraInterop.Registro11Rec();
			record.Responsavel = ToUTF8(registro11.Responsavel);
			record.Bairro = ToUTF8(registro11.Bairro);
			record.Cep = ToUTF8(registro11.Cep.ToString());
			record.Numero = ToUTF8(registro11.Numero.ToString());
			record.Complemento = ToUTF8(registro11.Complemento);
			record.Endereco = ToUTF8(registro11.Endereco);
			record.Telefone = ToUTF8(registro11.Telefone.ToString());	

			int ret = ACBrSintegraInterop.SIN_Registro11(this.Handle, record);
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