using System;
using System.Windows.Forms;

namespace ACBr.Net.ECFTeste
{
	public partial class LeituraMemoriaFiscalPAF : Form
	{
		#region Constructor

		public LeituraMemoriaFiscalPAF()
		{
			InitializeComponent();
		}

		#endregion Constructor

		#region Properties

		public bool ByPeriod
		{
			get
			{
				return periodRadioButton.Checked;
			}
		}

		public bool ByCCR
		{
			get
			{
				return ccrRadioButton.Checked;
			}
		}

		public DateTime InitialDate
		{
			get
			{
				return initialDateTime.Value;
			}
		}

		public DateTime FinalDate
		{
			get
			{
				return finalDateTime.Value;
			}
		}

		public int InitialCCR
		{
			get
			{
				return (int)initialCCR.Value;
			}
		}

		public int FinalCCR
		{
			get
			{
				return (int)finalCCR.Value;
			}
		}

		public bool Simple
		{
			get
			{
				return this.simpleCheckBox.Checked;
			}
		}

		public bool Imprimir
		{
			get
			{
				return radImprimir.Checked;
			}
		}

		public bool SalvarCotepe1704
		{
			get
			{
				return radCotepe1704.Checked;
			}
		}

		public bool SalvarEspelho
		{
			get
			{
				return radEspelhoMFD.Checked;
			}
		}

		public string Caminho
		{
			get
			{
				return txtLocal.Text;
			}
		}

		#endregion Properties

		#region EventHandlers

		private void ccrRadioButton_CheckedChanged(object sender, EventArgs e)
		{
			initialCCR.Enabled = ccrRadioButton.Checked;
			finalCCR.Enabled = ccrRadioButton.Checked;
		}

		private void periodRadioButton_CheckedChanged(object sender, EventArgs e)
		{
			initialDateTime.Enabled = periodRadioButton.Checked;
			finalDateTime.Enabled = periodRadioButton.Checked;
		}

		private void simpleCheckBox_CheckedChanged(object sender, EventArgs e)
		{
			radCotepe1704.Checked = false;
			radCotepe1704.Enabled = !simpleCheckBox.Checked;
		}

		private void radCotepe1704_CheckedChanged(object sender, EventArgs e)
		{
			txtLocal.Enabled = radCotepe1704.Checked;
			btnBtnProcurar.Enabled = radCotepe1704.Checked;
		}

		private void radEspelhoMFD_CheckedChanged(object sender, EventArgs e)
		{
			txtLocal.Enabled = radEspelhoMFD.Checked;
			btnBtnProcurar.Enabled = radEspelhoMFD.Checked;
		}

		private void btnBtnProcurar_Click(object sender, EventArgs e)
		{
			FolderBrowserDialog fold = new FolderBrowserDialog();
			if (fold.ShowDialog() == DialogResult.OK)
				txtLocal.Text = fold.SelectedPath;
		}

		#endregion EventHandlers
	}
}