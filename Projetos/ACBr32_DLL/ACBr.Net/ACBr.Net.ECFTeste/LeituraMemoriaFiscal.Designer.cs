namespace ACBr.Net.ECFTeste
{
	partial class LeituraMemoriaFiscal
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
			this.initialDateTime = new System.Windows.Forms.DateTimePicker();
			this.finalDateTime = new System.Windows.Forms.DateTimePicker();
			this.periodRadioButton = new System.Windows.Forms.RadioButton();
			this.ccrRadioButton = new System.Windows.Forms.RadioButton();
			this.initialCCR = new System.Windows.Forms.NumericUpDown();
			this.finalCCR = new System.Windows.Forms.NumericUpDown();
			this.button1 = new System.Windows.Forms.Button();
			this.button2 = new System.Windows.Forms.Button();
			this.simpleCheckBox = new System.Windows.Forms.CheckBox();
			((System.ComponentModel.ISupportInitialize)(this.initialCCR)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.finalCCR)).BeginInit();
			this.SuspendLayout();
			// 
			// initialDateTime
			// 
			this.initialDateTime.Format = System.Windows.Forms.DateTimePickerFormat.Short;
			this.initialDateTime.Location = new System.Drawing.Point(34, 35);
			this.initialDateTime.Name = "initialDateTime";
			this.initialDateTime.Size = new System.Drawing.Size(103, 20);
			this.initialDateTime.TabIndex = 0;
			// 
			// finalDateTime
			// 
			this.finalDateTime.Format = System.Windows.Forms.DateTimePickerFormat.Short;
			this.finalDateTime.Location = new System.Drawing.Point(143, 35);
			this.finalDateTime.Name = "finalDateTime";
			this.finalDateTime.Size = new System.Drawing.Size(103, 20);
			this.finalDateTime.TabIndex = 1;
			// 
			// periodRadioButton
			// 
			this.periodRadioButton.AutoSize = true;
			this.periodRadioButton.Checked = true;
			this.periodRadioButton.Location = new System.Drawing.Point(11, 12);
			this.periodRadioButton.Name = "periodRadioButton";
			this.periodRadioButton.Size = new System.Drawing.Size(81, 17);
			this.periodRadioButton.TabIndex = 2;
			this.periodRadioButton.TabStop = true;
			this.periodRadioButton.Text = "Por período";
			this.periodRadioButton.UseVisualStyleBackColor = true;
			this.periodRadioButton.CheckedChanged += new System.EventHandler(this.periodRadioButton_CheckedChanged);
			// 
			// ccrRadioButton
			// 
			this.ccrRadioButton.AutoSize = true;
			this.ccrRadioButton.Location = new System.Drawing.Point(11, 70);
			this.ccrRadioButton.Name = "ccrRadioButton";
			this.ccrRadioButton.Size = new System.Drawing.Size(83, 17);
			this.ccrRadioButton.TabIndex = 3;
			this.ccrRadioButton.Text = "Por redução";
			this.ccrRadioButton.UseVisualStyleBackColor = true;
			this.ccrRadioButton.CheckedChanged += new System.EventHandler(this.ccrRadioButton_CheckedChanged);
			// 
			// initialCCR
			// 
			this.initialCCR.Enabled = false;
			this.initialCCR.Location = new System.Drawing.Point(34, 93);
			this.initialCCR.Name = "initialCCR";
			this.initialCCR.Size = new System.Drawing.Size(103, 20);
			this.initialCCR.TabIndex = 4;
			// 
			// finalCCR
			// 
			this.finalCCR.Enabled = false;
			this.finalCCR.Location = new System.Drawing.Point(143, 93);
			this.finalCCR.Name = "finalCCR";
			this.finalCCR.Size = new System.Drawing.Size(103, 20);
			this.finalCCR.TabIndex = 5;
			// 
			// button1
			// 
			this.button1.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.button1.Location = new System.Drawing.Point(200, 170);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(75, 23);
			this.button1.TabIndex = 6;
			this.button1.Text = "Cancelar";
			this.button1.UseVisualStyleBackColor = true;
			// 
			// button2
			// 
			this.button2.DialogResult = System.Windows.Forms.DialogResult.OK;
			this.button2.Location = new System.Drawing.Point(119, 170);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(75, 23);
			this.button2.TabIndex = 7;
			this.button2.Text = "Ok";
			this.button2.UseVisualStyleBackColor = true;
			// 
			// simpleCheckBox
			// 
			this.simpleCheckBox.AutoSize = true;
			this.simpleCheckBox.Location = new System.Drawing.Point(12, 137);
			this.simpleCheckBox.Name = "simpleCheckBox";
			this.simpleCheckBox.Size = new System.Drawing.Size(82, 17);
			this.simpleCheckBox.TabIndex = 8;
			this.simpleCheckBox.Text = "Simplificado";
			this.simpleCheckBox.UseVisualStyleBackColor = true;
			// 
			// LeituraMemoriaFiscal
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(284, 204);
			this.Controls.Add(this.simpleCheckBox);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.finalCCR);
			this.Controls.Add(this.initialCCR);
			this.Controls.Add(this.ccrRadioButton);
			this.Controls.Add(this.periodRadioButton);
			this.Controls.Add(this.finalDateTime);
			this.Controls.Add(this.initialDateTime);
			this.Name = "LeituraMemoriaFiscal";
			this.Text = "LeituraMemoriaFiscal";
			((System.ComponentModel.ISupportInitialize)(this.initialCCR)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.finalCCR)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.DateTimePicker initialDateTime;
		private System.Windows.Forms.DateTimePicker finalDateTime;
		private System.Windows.Forms.RadioButton periodRadioButton;
		private System.Windows.Forms.RadioButton ccrRadioButton;
		private System.Windows.Forms.NumericUpDown initialCCR;
		private System.Windows.Forms.NumericUpDown finalCCR;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.CheckBox simpleCheckBox;
	}
}