namespace ACBrDefExporter
{
	partial class MainForm
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
			this.infoLabel = new System.Windows.Forms.Label();
			this.languageLabel = new System.Windows.Forms.Label();
			this.pathLabel = new System.Windows.Forms.Label();
			this.languageComboBox = new System.Windows.Forms.ComboBox();
			this.pathTextBox = new System.Windows.Forms.TextBox();
			this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
			this.pathButton = new System.Windows.Forms.Button();
			this.okButton = new System.Windows.Forms.Button();
			this.cancelButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// infoLabel
			// 
			this.infoLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.infoLabel.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
			this.infoLabel.Location = new System.Drawing.Point(12, 119);
			this.infoLabel.Name = "infoLabel";
			this.infoLabel.Size = new System.Drawing.Size(374, 63);
			this.infoLabel.TabIndex = 5;
			this.infoLabel.Text = resources.GetString("infoLabel.Text");
			// 
			// languageLabel
			// 
			this.languageLabel.AutoSize = true;
			this.languageLabel.Location = new System.Drawing.Point(12, 9);
			this.languageLabel.Name = "languageLabel";
			this.languageLabel.Size = new System.Drawing.Size(62, 13);
			this.languageLabel.TabIndex = 0;
			this.languageLabel.Text = "Linguagem:";
			// 
			// pathLabel
			// 
			this.pathLabel.AutoSize = true;
			this.pathLabel.Location = new System.Drawing.Point(12, 61);
			this.pathLabel.Name = "pathLabel";
			this.pathLabel.Size = new System.Drawing.Size(180, 13);
			this.pathLabel.TabIndex = 2;
			this.pathLabel.Text = "Caminho para geração dos arquivos:";
			// 
			// languageComboBox
			// 
			this.languageComboBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.languageComboBox.FormattingEnabled = true;
			this.languageComboBox.Location = new System.Drawing.Point(15, 25);
			this.languageComboBox.Name = "languageComboBox";
			this.languageComboBox.Size = new System.Drawing.Size(371, 21);
			this.languageComboBox.TabIndex = 1;
			// 
			// pathTextBox
			// 
			this.pathTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.pathTextBox.Location = new System.Drawing.Point(15, 78);
			this.pathTextBox.Name = "pathTextBox";
			this.pathTextBox.Size = new System.Drawing.Size(334, 20);
			this.pathTextBox.TabIndex = 3;
			// 
			// pathButton
			// 
			this.pathButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.pathButton.Location = new System.Drawing.Point(355, 76);
			this.pathButton.Name = "pathButton";
			this.pathButton.Size = new System.Drawing.Size(31, 23);
			this.pathButton.TabIndex = 4;
			this.pathButton.Text = "...";
			this.pathButton.UseVisualStyleBackColor = true;
			this.pathButton.Click += new System.EventHandler(this.pathButton_Click);
			// 
			// okButton
			// 
			this.okButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.okButton.Location = new System.Drawing.Point(230, 187);
			this.okButton.Name = "okButton";
			this.okButton.Size = new System.Drawing.Size(75, 23);
			this.okButton.TabIndex = 6;
			this.okButton.Text = "&Ok";
			this.okButton.UseVisualStyleBackColor = true;
			this.okButton.Click += new System.EventHandler(this.okButton_Click);
			// 
			// cancelButton
			// 
			this.cancelButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.cancelButton.Location = new System.Drawing.Point(311, 187);
			this.cancelButton.Name = "cancelButton";
			this.cancelButton.Size = new System.Drawing.Size(75, 23);
			this.cancelButton.TabIndex = 7;
			this.cancelButton.Text = "&Cancel";
			this.cancelButton.UseVisualStyleBackColor = true;
			this.cancelButton.Click += new System.EventHandler(this.cancelButton_Click);
			// 
			// MainForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(398, 220);
			this.ControlBox = false;
			this.Controls.Add(this.cancelButton);
			this.Controls.Add(this.okButton);
			this.Controls.Add(this.pathButton);
			this.Controls.Add(this.pathTextBox);
			this.Controls.Add(this.languageComboBox);
			this.Controls.Add(this.pathLabel);
			this.Controls.Add(this.languageLabel);
			this.Controls.Add(this.infoLabel);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.Name = "MainForm";
			this.ShowIcon = false;
			this.Text = "ACBrFramework DefExporter";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label infoLabel;
		private System.Windows.Forms.Label languageLabel;
		private System.Windows.Forms.Label pathLabel;
		private System.Windows.Forms.ComboBox languageComboBox;
		private System.Windows.Forms.TextBox pathTextBox;
		private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
		private System.Windows.Forms.Button pathButton;
		private System.Windows.Forms.Button okButton;
		private System.Windows.Forms.Button cancelButton;
	}
}