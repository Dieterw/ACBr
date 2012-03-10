using System.Windows.Forms;

namespace ACBr.Net.ECFTeste
{
	public partial class IdentificaPAF : Form
	{
		#region Constructor

		public IdentificaPAF()
		{
			InitializeComponent();
		}

		#endregion Constructor

		#region Properties

		public string Linha1
		{
			get
			{
				return linha1TextBox.Text;
			}
		}

		public string Linha2
		{
			get
			{
				return linha2TextBox.Text;
			}
		}

		#endregion Properties
	}
}