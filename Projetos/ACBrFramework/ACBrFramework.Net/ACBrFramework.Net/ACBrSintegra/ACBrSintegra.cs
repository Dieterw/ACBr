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

		public void Registro50(SintegraRegistro50[] registro50)
		{
			ACBrSintegraInterop.Registro50Rec[] record = new ACBrSintegraInterop.Registro50Rec[registro50.Length];
			for (int i = 0; i < registro50.Length; i++)
			{
				record[i].CPFCNPJ = ToUTF8(registro50[i].CPFCNPJ.ToString());
				record[i].Inscricao = ToUTF8(registro50[i].Inscricao.ToString());
				record[i].UF = ToUTF8(registro50[i].UF);
				record[i].Situacao = ToUTF8(registro50[i].Situacao);
				record[i].Aliquota = registro50[i].Aliquota;
				record[i].Isentas = registro50[i].Isentas;
				record[i].Icms = registro50[i].Icms;
				record[i].ValorContabil = registro50[i].ValorContabil;
				record[i].BasedeCalculo = registro50[i].BasedeCalculo;
				record[i].Outras = registro50[i].Outras;
				record[i].EmissorDocumento = ToUTF8(registro50[i].EmissorDocumento);
				record[i].Cfop = ToUTF8(registro50[i].Cfop);
				record[i].Serie = ToUTF8(registro50[i].Serie);
				record[i].Modelo = ToUTF8(registro50[i].Modelo);
				record[i].Numero = ToUTF8(registro50[i].Numero.ToString());
				record[i].DataDocumento = registro50[i].DataDocumento.ToOADate();
			}

			int ret = ACBrSintegraInterop.SIN_Registro50(this.Handle, record, registro50.Length);
			CheckResult(ret);
		}

		public void Registro51(SintegraRegistro51[] registro51)
		{
			ACBrSintegraInterop.Registro51Rec[] record = new ACBrSintegraInterop.Registro51Rec[registro51.Length];
			for (int i = 0; i < registro51.Length; i++)
			{
				record[i].CPFCNPJ = ToUTF8(registro51[i].CPFCNPJ.ToString());
				record[i].Inscricao = ToUTF8(registro51[i].Inscricao.ToString());
				record[i].Estado = ToUTF8(registro51[i].Estado);
				record[i].ValorContabil = registro51[i].ValorContabil;
				record[i].Cfop = ToUTF8(registro51[i].Cfop);
				record[i].Serie = ToUTF8(registro51[i].Serie);
				record[i].Numero = ToUTF8(registro51[i].Numero.ToString());
				record[i].DataDocumento = registro51[i].DataDocumento.ToOADate();
				record[i].ValorIpi  = registro51[i].ValorIpi;
				record[i].Situacao = ToUTF8(registro51[i].Situacao);
				record[i].ValorIsentas = registro51[i].ValorIsentas;
				record[i].ValorOutras = registro51[i].ValorOutras;
			}

			int ret = ACBrSintegraInterop.SIN_Registro51(this.Handle, record, registro51.Length);
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