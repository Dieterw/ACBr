namespace ACBr.Net.ECFTeste
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
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.messageToolStripStatusLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.descriptionToolStripStatusLabel = new System.Windows.Forms.ToolStripStatusLabel();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.principalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ativarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.desativarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.testarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.sobreACBrNETToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem2 = new System.Windows.Forms.ToolStripSeparator();
            this.sairToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.variáveisToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.equipamentoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.estadoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dataHoraToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.numECFToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.numLojaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.numSérieToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.numVersãoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cNPJToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.iEToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pAFToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.lerTodasAsVariáveisToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.relatóriosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.leituraXToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.reToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cupomFiscalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.testaCupomFiscalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tabControl = new System.Windows.Forms.TabControl();
            this.ecfTabPage = new System.Windows.Forms.TabPage();
            this.descricaoCheckBox = new System.Windows.Forms.CheckBox();
            this.gavetaCheckBox = new System.Windows.Forms.CheckBox();
            this.intervaloNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.intervaloLabel = new System.Windows.Forms.Label();
            this.timeOutNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.portaComboBox = new System.Windows.Forms.ComboBox();
            this.modeloComboBox = new System.Windows.Forms.ComboBox();
            this.timeOutLabel = new System.Windows.Forms.Label();
            this.portaLabel = new System.Windows.Forms.Label();
            this.modeloLabel = new System.Windows.Forms.Label();
            this.cmdTabPage = new System.Windows.Forms.TabPage();
            this.respListBox = new System.Windows.Forms.ListBox();
            this.ativarCheckButton = new System.Windows.Forms.CheckBox();
            this.label1 = new System.Windows.Forms.Label();
            this.velocidadeComboBox = new System.Windows.Forms.ComboBox();
            this.statusStrip1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.tabControl.SuspendLayout();
            this.ecfTabPage.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.intervaloNumericUpDown)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.timeOutNumericUpDown)).BeginInit();
            this.cmdTabPage.SuspendLayout();
            this.SuspendLayout();
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.messageToolStripStatusLabel,
            this.descriptionToolStripStatusLabel});
            this.statusStrip1.Location = new System.Drawing.Point(0, 336);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(535, 22);
            this.statusStrip1.TabIndex = 0;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // messageToolStripStatusLabel
            // 
            this.messageToolStripStatusLabel.AutoSize = false;
            this.messageToolStripStatusLabel.BorderSides = ((System.Windows.Forms.ToolStripStatusLabelBorderSides)((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top)
                        | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right)
                        | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom)));
            this.messageToolStripStatusLabel.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenOuter;
            this.messageToolStripStatusLabel.Name = "messageToolStripStatusLabel";
            this.messageToolStripStatusLabel.Size = new System.Drawing.Size(150, 17);
            this.messageToolStripStatusLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // descriptionToolStripStatusLabel
            // 
            this.descriptionToolStripStatusLabel.BorderSides = ((System.Windows.Forms.ToolStripStatusLabelBorderSides)((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top)
                        | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right)
                        | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom)));
            this.descriptionToolStripStatusLabel.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenOuter;
            this.descriptionToolStripStatusLabel.Name = "descriptionToolStripStatusLabel";
            this.descriptionToolStripStatusLabel.Size = new System.Drawing.Size(370, 17);
            this.descriptionToolStripStatusLabel.Spring = true;
            this.descriptionToolStripStatusLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.principalToolStripMenuItem,
            this.variáveisToolStripMenuItem,
            this.relatóriosToolStripMenuItem,
            this.cupomFiscalToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(535, 24);
            this.menuStrip1.TabIndex = 1;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // principalToolStripMenuItem
            // 
            this.principalToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ativarToolStripMenuItem,
            this.desativarToolStripMenuItem,
            this.testarToolStripMenuItem,
            this.toolStripMenuItem1,
            this.sobreACBrNETToolStripMenuItem,
            this.toolStripMenuItem2,
            this.sairToolStripMenuItem});
            this.principalToolStripMenuItem.Name = "principalToolStripMenuItem";
            this.principalToolStripMenuItem.Size = new System.Drawing.Size(58, 20);
            this.principalToolStripMenuItem.Text = "&Principal";
            // 
            // ativarToolStripMenuItem
            // 
            this.ativarToolStripMenuItem.Name = "ativarToolStripMenuItem";
            this.ativarToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
            this.ativarToolStripMenuItem.Text = "&Ativar";
            this.ativarToolStripMenuItem.Click += new System.EventHandler(this.ativarToolStripMenuItem_Click);
            // 
            // desativarToolStripMenuItem
            // 
            this.desativarToolStripMenuItem.Name = "desativarToolStripMenuItem";
            this.desativarToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
            this.desativarToolStripMenuItem.Text = "&Desativar";
            this.desativarToolStripMenuItem.Click += new System.EventHandler(this.desativarToolStripMenuItem_Click);
            // 
            // testarToolStripMenuItem
            // 
            this.testarToolStripMenuItem.Name = "testarToolStripMenuItem";
            this.testarToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
            this.testarToolStripMenuItem.Text = "&Testar";
            this.testarToolStripMenuItem.Click += new System.EventHandler(this.testarToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(160, 6);
            // 
            // sobreACBrNETToolStripMenuItem
            // 
            this.sobreACBrNETToolStripMenuItem.Name = "sobreACBrNETToolStripMenuItem";
            this.sobreACBrNETToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
            this.sobreACBrNETToolStripMenuItem.Text = "Sobre ACBr.NET";
            // 
            // toolStripMenuItem2
            // 
            this.toolStripMenuItem2.Name = "toolStripMenuItem2";
            this.toolStripMenuItem2.Size = new System.Drawing.Size(160, 6);
            // 
            // sairToolStripMenuItem
            // 
            this.sairToolStripMenuItem.Name = "sairToolStripMenuItem";
            this.sairToolStripMenuItem.Size = new System.Drawing.Size(163, 22);
            this.sairToolStripMenuItem.Text = "&Sair";
            this.sairToolStripMenuItem.Click += new System.EventHandler(this.sairToolStripMenuItem_Click);
            // 
            // variáveisToolStripMenuItem
            // 
            this.variáveisToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.equipamentoToolStripMenuItem,
            this.lerTodasAsVariáveisToolStripMenuItem});
            this.variáveisToolStripMenuItem.Name = "variáveisToolStripMenuItem";
            this.variáveisToolStripMenuItem.Size = new System.Drawing.Size(62, 20);
            this.variáveisToolStripMenuItem.Text = "Variáveis";
            // 
            // equipamentoToolStripMenuItem
            // 
            this.equipamentoToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.estadoToolStripMenuItem,
            this.dataHoraToolStripMenuItem,
            this.numECFToolStripMenuItem,
            this.numLojaToolStripMenuItem,
            this.numSérieToolStripMenuItem,
            this.numVersãoToolStripMenuItem,
            this.cNPJToolStripMenuItem,
            this.iEToolStripMenuItem,
            this.pAFToolStripMenuItem});
            this.equipamentoToolStripMenuItem.Name = "equipamentoToolStripMenuItem";
            this.equipamentoToolStripMenuItem.Size = new System.Drawing.Size(192, 22);
            this.equipamentoToolStripMenuItem.Text = "Equipamento";
            // 
            // estadoToolStripMenuItem
            // 
            this.estadoToolStripMenuItem.Name = "estadoToolStripMenuItem";
            this.estadoToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.estadoToolStripMenuItem.Text = "Estado";
            this.estadoToolStripMenuItem.Click += new System.EventHandler(this.estadoToolStripMenuItem_Click);
            // 
            // dataHoraToolStripMenuItem
            // 
            this.dataHoraToolStripMenuItem.Name = "dataHoraToolStripMenuItem";
            this.dataHoraToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.dataHoraToolStripMenuItem.Text = "Data / Hora";
            this.dataHoraToolStripMenuItem.Click += new System.EventHandler(this.dataHoraToolStripMenuItem_Click);
            // 
            // numECFToolStripMenuItem
            // 
            this.numECFToolStripMenuItem.Name = "numECFToolStripMenuItem";
            this.numECFToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.numECFToolStripMenuItem.Text = "Num ECF";
            this.numECFToolStripMenuItem.Click += new System.EventHandler(this.numECFToolStripMenuItem_Click);
            // 
            // numLojaToolStripMenuItem
            // 
            this.numLojaToolStripMenuItem.Name = "numLojaToolStripMenuItem";
            this.numLojaToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.numLojaToolStripMenuItem.Text = "Num Loja";
            this.numLojaToolStripMenuItem.Click += new System.EventHandler(this.numLojaToolStripMenuItem_Click);
            // 
            // numSérieToolStripMenuItem
            // 
            this.numSérieToolStripMenuItem.Name = "numSérieToolStripMenuItem";
            this.numSérieToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.numSérieToolStripMenuItem.Text = "Num Série";
            this.numSérieToolStripMenuItem.Click += new System.EventHandler(this.numSérieToolStripMenuItem_Click);
            // 
            // numVersãoToolStripMenuItem
            // 
            this.numVersãoToolStripMenuItem.Name = "numVersãoToolStripMenuItem";
            this.numVersãoToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.numVersãoToolStripMenuItem.Text = "Num Versão";
            this.numVersãoToolStripMenuItem.Click += new System.EventHandler(this.numVersãoToolStripMenuItem_Click);
            // 
            // cNPJToolStripMenuItem
            // 
            this.cNPJToolStripMenuItem.Name = "cNPJToolStripMenuItem";
            this.cNPJToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.cNPJToolStripMenuItem.Text = "CNPJ";
            this.cNPJToolStripMenuItem.Click += new System.EventHandler(this.cNPJToolStripMenuItem_Click);
            // 
            // iEToolStripMenuItem
            // 
            this.iEToolStripMenuItem.Name = "iEToolStripMenuItem";
            this.iEToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.iEToolStripMenuItem.Text = "IE";
            this.iEToolStripMenuItem.Click += new System.EventHandler(this.iEToolStripMenuItem_Click);
            // 
            // pAFToolStripMenuItem
            // 
            this.pAFToolStripMenuItem.Name = "pAFToolStripMenuItem";
            this.pAFToolStripMenuItem.Size = new System.Drawing.Size(142, 22);
            this.pAFToolStripMenuItem.Text = "PAF";
            this.pAFToolStripMenuItem.Click += new System.EventHandler(this.pAFToolStripMenuItem_Click);
            // 
            // lerTodasAsVariáveisToolStripMenuItem
            // 
            this.lerTodasAsVariáveisToolStripMenuItem.Name = "lerTodasAsVariáveisToolStripMenuItem";
            this.lerTodasAsVariáveisToolStripMenuItem.Size = new System.Drawing.Size(192, 22);
            this.lerTodasAsVariáveisToolStripMenuItem.Text = "Ler Todas as Variáveis";
            this.lerTodasAsVariáveisToolStripMenuItem.Click += new System.EventHandler(this.lerTodasAsVariáveisToolStripMenuItem_Click);
            // 
            // relatóriosToolStripMenuItem
            // 
            this.relatóriosToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.leituraXToolStripMenuItem,
            this.reToolStripMenuItem});
            this.relatóriosToolStripMenuItem.Name = "relatóriosToolStripMenuItem";
            this.relatóriosToolStripMenuItem.Size = new System.Drawing.Size(67, 20);
            this.relatóriosToolStripMenuItem.Text = "Relatórios";
            // 
            // leituraXToolStripMenuItem
            // 
            this.leituraXToolStripMenuItem.Name = "leituraXToolStripMenuItem";
            this.leituraXToolStripMenuItem.Size = new System.Drawing.Size(136, 22);
            this.leituraXToolStripMenuItem.Text = "Leitura X";
            this.leituraXToolStripMenuItem.Click += new System.EventHandler(this.leituraXToolStripMenuItem_Click);
            // 
            // reToolStripMenuItem
            // 
            this.reToolStripMenuItem.Name = "reToolStripMenuItem";
            this.reToolStripMenuItem.Size = new System.Drawing.Size(136, 22);
            this.reToolStripMenuItem.Text = "Redução Z";
            this.reToolStripMenuItem.Click += new System.EventHandler(this.reToolStripMenuItem_Click);
            // 
            // cupomFiscalToolStripMenuItem
            // 
            this.cupomFiscalToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.testaCupomFiscalToolStripMenuItem});
            this.cupomFiscalToolStripMenuItem.Name = "cupomFiscalToolStripMenuItem";
            this.cupomFiscalToolStripMenuItem.Size = new System.Drawing.Size(81, 20);
            this.cupomFiscalToolStripMenuItem.Text = "Cupom Fiscal";
            // 
            // testaCupomFiscalToolStripMenuItem
            // 
            this.testaCupomFiscalToolStripMenuItem.Name = "testaCupomFiscalToolStripMenuItem";
            this.testaCupomFiscalToolStripMenuItem.Size = new System.Drawing.Size(177, 22);
            this.testaCupomFiscalToolStripMenuItem.Text = "Testa Cupom Fiscal";
            this.testaCupomFiscalToolStripMenuItem.Click += new System.EventHandler(this.testaCupomFiscalToolStripMenuItem_Click);
            // 
            // tabControl
            // 
            this.tabControl.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.tabControl.Controls.Add(this.ecfTabPage);
            this.tabControl.Controls.Add(this.cmdTabPage);
            this.tabControl.Location = new System.Drawing.Point(10, 27);
            this.tabControl.Name = "tabControl";
            this.tabControl.SelectedIndex = 0;
            this.tabControl.Size = new System.Drawing.Size(513, 260);
            this.tabControl.TabIndex = 0;
            // 
            // ecfTabPage
            // 
            this.ecfTabPage.Controls.Add(this.label1);
            this.ecfTabPage.Controls.Add(this.velocidadeComboBox);
            this.ecfTabPage.Controls.Add(this.descricaoCheckBox);
            this.ecfTabPage.Controls.Add(this.gavetaCheckBox);
            this.ecfTabPage.Controls.Add(this.intervaloNumericUpDown);
            this.ecfTabPage.Controls.Add(this.intervaloLabel);
            this.ecfTabPage.Controls.Add(this.timeOutNumericUpDown);
            this.ecfTabPage.Controls.Add(this.portaComboBox);
            this.ecfTabPage.Controls.Add(this.modeloComboBox);
            this.ecfTabPage.Controls.Add(this.timeOutLabel);
            this.ecfTabPage.Controls.Add(this.portaLabel);
            this.ecfTabPage.Controls.Add(this.modeloLabel);
            this.ecfTabPage.Location = new System.Drawing.Point(4, 22);
            this.ecfTabPage.Name = "ecfTabPage";
            this.ecfTabPage.Padding = new System.Windows.Forms.Padding(3);
            this.ecfTabPage.Size = new System.Drawing.Size(505, 234);
            this.ecfTabPage.TabIndex = 0;
            this.ecfTabPage.Text = "ECF";
            this.ecfTabPage.UseVisualStyleBackColor = true;
            // 
            // descricaoCheckBox
            // 
            this.descricaoCheckBox.AutoSize = true;
            this.descricaoCheckBox.Location = new System.Drawing.Point(9, 90);
            this.descricaoCheckBox.Name = "descricaoCheckBox";
            this.descricaoCheckBox.Size = new System.Drawing.Size(112, 17);
            this.descricaoCheckBox.TabIndex = 10;
            this.descricaoCheckBox.Text = "Descricao Grande";
            this.descricaoCheckBox.UseVisualStyleBackColor = true;
            // 
            // gavetaCheckBox
            // 
            this.gavetaCheckBox.AutoSize = true;
            this.gavetaCheckBox.Location = new System.Drawing.Point(9, 67);
            this.gavetaCheckBox.Name = "gavetaCheckBox";
            this.gavetaCheckBox.Size = new System.Drawing.Size(131, 17);
            this.gavetaCheckBox.TabIndex = 9;
            this.gavetaCheckBox.Text = "Gaveta Sinal Invertido";
            this.gavetaCheckBox.UseVisualStyleBackColor = true;
            // 
            // intervaloNumericUpDown
            // 
            this.intervaloNumericUpDown.Location = new System.Drawing.Point(378, 30);
            this.intervaloNumericUpDown.Name = "intervaloNumericUpDown";
            this.intervaloNumericUpDown.Size = new System.Drawing.Size(72, 20);
            this.intervaloNumericUpDown.TabIndex = 7;
            this.intervaloNumericUpDown.Value = new decimal(new int[] {
            100,
            0,
            0,
            0});
            // 
            // intervaloLabel
            // 
            this.intervaloLabel.AutoSize = true;
            this.intervaloLabel.Location = new System.Drawing.Point(375, 14);
            this.intervaloLabel.Name = "intervaloLabel";
            this.intervaloLabel.Size = new System.Drawing.Size(51, 13);
            this.intervaloLabel.TabIndex = 6;
            this.intervaloLabel.Text = "Intervalo:";
            // 
            // timeOutNumericUpDown
            // 
            this.timeOutNumericUpDown.Location = new System.Drawing.Point(325, 30);
            this.timeOutNumericUpDown.Name = "timeOutNumericUpDown";
            this.timeOutNumericUpDown.Size = new System.Drawing.Size(47, 20);
            this.timeOutNumericUpDown.TabIndex = 5;
            this.timeOutNumericUpDown.Value = new decimal(new int[] {
            3,
            0,
            0,
            0});
            // 
            // portaComboBox
            // 
            this.portaComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.portaComboBox.FormattingEnabled = true;
            this.portaComboBox.Location = new System.Drawing.Point(163, 29);
            this.portaComboBox.Name = "portaComboBox";
            this.portaComboBox.Size = new System.Drawing.Size(67, 21);
            this.portaComboBox.TabIndex = 3;
            // 
            // modeloComboBox
            // 
            this.modeloComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.modeloComboBox.FormattingEnabled = true;
            this.modeloComboBox.Location = new System.Drawing.Point(9, 29);
            this.modeloComboBox.Name = "modeloComboBox";
            this.modeloComboBox.Size = new System.Drawing.Size(148, 21);
            this.modeloComboBox.TabIndex = 1;
            // 
            // timeOutLabel
            // 
            this.timeOutLabel.AutoSize = true;
            this.timeOutLabel.Location = new System.Drawing.Point(322, 14);
            this.timeOutLabel.Name = "timeOutLabel";
            this.timeOutLabel.Size = new System.Drawing.Size(50, 13);
            this.timeOutLabel.TabIndex = 4;
            this.timeOutLabel.Text = "TimeOut:";
            // 
            // portaLabel
            // 
            this.portaLabel.AutoSize = true;
            this.portaLabel.Location = new System.Drawing.Point(160, 13);
            this.portaLabel.Name = "portaLabel";
            this.portaLabel.Size = new System.Drawing.Size(35, 13);
            this.portaLabel.TabIndex = 2;
            this.portaLabel.Text = "Porta:";
            // 
            // modeloLabel
            // 
            this.modeloLabel.AutoSize = true;
            this.modeloLabel.Location = new System.Drawing.Point(6, 13);
            this.modeloLabel.Name = "modeloLabel";
            this.modeloLabel.Size = new System.Drawing.Size(45, 13);
            this.modeloLabel.TabIndex = 0;
            this.modeloLabel.Text = "Modelo:";
            // 
            // cmdTabPage
            // 
            this.cmdTabPage.Controls.Add(this.respListBox);
            this.cmdTabPage.Location = new System.Drawing.Point(4, 22);
            this.cmdTabPage.Name = "cmdTabPage";
            this.cmdTabPage.Padding = new System.Windows.Forms.Padding(3);
            this.cmdTabPage.Size = new System.Drawing.Size(505, 234);
            this.cmdTabPage.TabIndex = 1;
            this.cmdTabPage.Text = "Cmd/Resp";
            this.cmdTabPage.UseVisualStyleBackColor = true;
            // 
            // respListBox
            // 
            this.respListBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.respListBox.FormattingEnabled = true;
            this.respListBox.Location = new System.Drawing.Point(6, 6);
            this.respListBox.Name = "respListBox";
            this.respListBox.Size = new System.Drawing.Size(493, 212);
            this.respListBox.TabIndex = 0;
            // 
            // ativarCheckButton
            // 
            this.ativarCheckButton.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.ativarCheckButton.Appearance = System.Windows.Forms.Appearance.Button;
            this.ativarCheckButton.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.ativarCheckButton.Location = new System.Drawing.Point(419, 293);
            this.ativarCheckButton.Name = "ativarCheckButton";
            this.ativarCheckButton.Size = new System.Drawing.Size(104, 35);
            this.ativarCheckButton.TabIndex = 11;
            this.ativarCheckButton.Text = "Ativar";
            this.ativarCheckButton.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.ativarCheckButton.UseVisualStyleBackColor = true;
            this.ativarCheckButton.CheckedChanged += new System.EventHandler(this.ativarCheckButton_CheckedChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(233, 14);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 12;
            this.label1.Text = "Porta:";
            // 
            // velocidadeComboBox
            // 
            this.velocidadeComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.velocidadeComboBox.FormattingEnabled = true;
            this.velocidadeComboBox.Location = new System.Drawing.Point(236, 29);
            this.velocidadeComboBox.Name = "velocidadeComboBox";
            this.velocidadeComboBox.Size = new System.Drawing.Size(83, 21);
            this.velocidadeComboBox.TabIndex = 11;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(535, 358);
            this.Controls.Add(this.ativarCheckButton);
            this.Controls.Add(this.tabControl);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "MainForm";
            this.Text = "Teste Impressora Fiscal - ACBr.NET";
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.tabControl.ResumeLayout(false);
            this.ecfTabPage.ResumeLayout(false);
            this.ecfTabPage.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.intervaloNumericUpDown)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.timeOutNumericUpDown)).EndInit();
            this.cmdTabPage.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel messageToolStripStatusLabel;
        private System.Windows.Forms.ToolStripStatusLabel descriptionToolStripStatusLabel;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem principalToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ativarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem desativarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem testarToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem sobreACBrNETToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem2;
        private System.Windows.Forms.ToolStripMenuItem sairToolStripMenuItem;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage ecfTabPage;
        private System.Windows.Forms.CheckBox descricaoCheckBox;
        private System.Windows.Forms.CheckBox gavetaCheckBox;
        private System.Windows.Forms.NumericUpDown intervaloNumericUpDown;
        private System.Windows.Forms.Label intervaloLabel;
        private System.Windows.Forms.NumericUpDown timeOutNumericUpDown;
        private System.Windows.Forms.ComboBox portaComboBox;
        private System.Windows.Forms.ComboBox modeloComboBox;
        private System.Windows.Forms.Label timeOutLabel;
        private System.Windows.Forms.Label portaLabel;
        private System.Windows.Forms.Label modeloLabel;
        private System.Windows.Forms.TabPage cmdTabPage;
        private System.Windows.Forms.CheckBox ativarCheckButton;
        private System.Windows.Forms.ToolStripMenuItem variáveisToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem equipamentoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem estadoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dataHoraToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem numECFToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem numLojaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem numSérieToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem numVersãoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cNPJToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem iEToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pAFToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem relatóriosToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem cupomFiscalToolStripMenuItem;
        private System.Windows.Forms.ListBox respListBox;
        private System.Windows.Forms.ToolStripMenuItem lerTodasAsVariáveisToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem testaCupomFiscalToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem leituraXToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem reToolStripMenuItem;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox velocidadeComboBox;
    }
}

