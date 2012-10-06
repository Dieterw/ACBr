using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using ACBrFramework;

namespace ACBrDefExporter
{
	public partial class MainForm : Form
	{
		#region Constructor

		public MainForm()
		{
			InitializeComponent();
			Populate();
		}

		#endregion Constructor

		#region Methods

		#region EventHandlers

		private void pathButton_Click(object sender, EventArgs e)
		{
			DialogResult result = folderBrowserDialog.ShowDialog(this);

			if (result == DialogResult.OK)
			{
				this.pathTextBox.Text = folderBrowserDialog.SelectedPath;
			}
		}

		private void okButton_Click(object sender, EventArgs e)
		{
			Process();
		}

		private void cancelButton_Click(object sender, EventArgs e)
		{
			this.Close();
		}

		#endregion EventHandlers

		private void Populate()
		{
			foreach (Language language in Enum.GetValues(typeof(Language)))
			{
				languageComboBox.Items.Add(language);
			}

			languageComboBox.SelectedIndex = -1;
		}

		private void Process()
		{
			if (languageComboBox.SelectedItem == null)
			{
				MessageBox.Show(this, "Selecione a linguagem", this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
				return;
			}

			if (!Directory.Exists(pathTextBox.Text))
			{
				MessageBox.Show(this, "Selecione uma pasta válida", this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
				return;
			}

			Language language = (Language)languageComboBox.SelectedItem;

			DefExporter defExporter;
			switch (language)
			{
				case Language.C:
					defExporter = new CDefExporter(pathTextBox.Text);
					break;

				case Language.VB6:
					defExporter = new VBDefExporter(pathTextBox.Text);
					break;

				default:
					defExporter = null;
					break;
			}

			if (defExporter == null)
			{
				MessageBox.Show(this, "DefExporter para essa linguagem não implementado.\nSelecione outra", this.Text, MessageBoxButtons.OK, MessageBoxIcon.Warning);
				return;
			}

			try
			{
				defExporter.Export(typeof(ACBrAACInterop));
				defExporter.Export(typeof(ACBrBALInterop));
				defExporter.Export(typeof(ACBrEADInterop));
				defExporter.Export(typeof(ACBrECFInterop));
				defExporter.Export(typeof(ACBrLCBInterop));
				defExporter.Export(typeof(ACBrPAFInterop));
				defExporter.Export(typeof(ACBrSintegraInterop));

				MessageBox.Show(this, "Definições exportadas com sucesso!", this.Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
				return;
			}
			catch (Exception exception)
			{
				MessageBox.Show(this, "Erro exportando definições:\n" + exception.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}
		}

		#endregion Methods
	}
}
