using System;
using System.Windows.Forms;

namespace ACBr.Net.ECFTeste
{
	public partial class LeituraMemoriaFiscal : Form
	{
		#region Constructor

		public LeituraMemoriaFiscal()
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

		#endregion Properties

		#region Methods

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

		#endregion EventHandlers

		#endregion Methods
	}
}