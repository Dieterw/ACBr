using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using ACBr.Net;

namespace ACBr.Net.ECFTeste
{
    public partial class MainForm : Form
    {
        #region Fields

        private ACBrECF acbrECF;

        #endregion Fields

        #region Constructor

        public MainForm()
        {
            InitializeComponent();

            this.acbrECF = new ACBrECF();

            Popular();
        }

        #endregion Constructor

        #region Methods

        private void Popular()
        {
            modeloComboBox.Items.Clear();
            foreach (var modelo in Enum.GetValues(typeof(ModeloECF))) modeloComboBox.Items.Add(modelo);
            modeloComboBox.SelectedIndex = 0;

            portaComboBox.Items.Clear();
            portaComboBox.Items.Add("COM1");
            portaComboBox.Items.Add("COM2");
            portaComboBox.Items.Add("COM3");
            portaComboBox.Items.Add("COM4");
            portaComboBox.Items.Add("COM5");
            portaComboBox.Items.Add("COM6");
            portaComboBox.Items.Add("LPT1");
            portaComboBox.Items.Add("LPT2");
            portaComboBox.Items.Add("LPT3");
            portaComboBox.Items.Add("ecf.txt");
            portaComboBox.SelectedIndex = 0;

            ativarCheckButton.Checked = false;
        }

        public void Ativar()
        {
            try
            {
                acbrECF.Modelo = (ModeloECF)modeloComboBox.SelectedItem;
                acbrECF.Porta = (string)portaComboBox.SelectedItem;
                acbrECF.TimeOut = (int)timeOutNumericUpDown.Value;

                acbrECF.GavetaSinalInvertido = gavetaCheckBox.Checked;
                acbrECF.DescricaoGrande = descricaoCheckBox.Checked;

                acbrECF.Ativar();
                ativarCheckButton.Checked = true;
                ativarCheckButton.Text = "Desativar";

                messageToolStripStatusLabel.Text = acbrECF.Estado.ToString();
                descriptionToolStripStatusLabel.Text = string.Empty;

                tabControl.SelectedTab = cmdTabPage;
                WriteResp("Ativado: OK!");
                

            }
            catch (Exception exception)
            {
                ativarCheckButton.Checked = false;

                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }

        }

        private void WriteResp(string resp)
        {
            respListBox.Items.Add(resp);
            respListBox.Items.Add("+-+-+-+-+-+-+-+-+-+-+-+-+-+-");
            respListBox.Items.Add("");
            respListBox.SelectedIndex = respListBox.Items.Count - 1;
        }

        public void Desativar()
        {
            try
            {
                acbrECF.Desativar();
                messageToolStripStatusLabel.Text = "OK";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        public void Testar()
        {
            try
            {
                string message = string.Empty;

                message += string.Format("Impressora: {0}", acbrECF.ModeloStr);
                message += string.Format("\nVersão: {0}", acbrECF.NumVersao);
                message += string.Format("\nColunas: {0}", acbrECF.Colunas);
                message += string.Format("\n");
                message += string.Format("\nNúmero de série: {0}", acbrECF.NumSerie);
                message += string.Format("\nNum do ECF: {0}", acbrECF.NumECF);
                message += string.Format("\nData/Hora: {0:dd/MM/yyyy HH:mm:ss}", acbrECF.DataHora);

                messageToolStripStatusLabel.Text = acbrECF.Estado.ToString();
                descriptionToolStripStatusLabel.Text = string.Empty;

                MessageBox.Show(this, message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        public void Sair()
        {
            this.Close();
        }

        public void Ler_Estado()
        {
            try
            {
                WriteResp(string.Format("\nEstado: {0}", acbrECF.Estado));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        public void Ler_DataHora()
        {
            try
            {
                WriteResp(string.Format("\nDataHora: {0}", acbrECF.DataHora));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        public void Ler_NumECF()
        {
            try
            {
                WriteResp(string.Format("\nNum ECF: {0}", acbrECF.NumECF));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }


        private void Ler_NumLoja()
        {
            try
            {
                WriteResp(string.Format("Num Loja: {0}", acbrECF.NumLoja));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        private void Ler_NumSerie()
        {
            try
            {
                WriteResp(string.Format("Num Serie: {0}", acbrECF.NumSerie));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        private void Ler_NumVersao()
        {
            try
            {
                WriteResp(string.Format("Num Versao: {0}", acbrECF.NumVersao));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        private void Ler_CNPJ()
        {
            try
            {
                WriteResp(string.Format("CNPJ: {0}", acbrECF.CNPJ));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        private void Ler_IE()
        {
            try
            {
                WriteResp(string.Format("IE: {0}", acbrECF.IE));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        private void Ler_PAF()
        {
            try
            {
                WriteResp(string.Format("PAF: {0}", acbrECF.PAF));
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }

        private void Ler_TodasVariaveis()
        {
            var type = typeof(ACBrECF);
            foreach (var property in type.GetProperties())
            {
                try
                {
                    object value = property.GetValue(acbrECF, null);

                    if (value is System.Collections.ICollection)
                    {
                        var collection = (System.Collections.ICollection)value;
                        respListBox.Items.Add(string.Format("{0}:", property.Name));

                        foreach (var element in collection)
                        {
                            if (element == null) continue;

                            respListBox.Items.Add("");

                            Type elementType = element.GetType();

                            foreach (var elementProperty in elementType.GetProperties())
                            {
                                object elementValue = elementProperty.GetValue(element, null);
                                respListBox.Items.Add(string.Format("{0}: {1}", elementProperty.Name, elementValue));
                            }

                        }

                        respListBox.Items.Add("");
                        WriteResp(string.Format("{0} elemento(s)", collection.Count));
                    }
                    else
                    {
                        WriteResp(string.Format("{0}: {1}", property.Name, value));
                    }

                    descriptionToolStripStatusLabel.Text = string.Empty;
                }
                catch (NullReferenceException)
                {
                    messageToolStripStatusLabel.Text = "Não inicializado.";
                    descriptionToolStripStatusLabel.Text = string.Empty;
                }
                catch (Exception exception)
                {
                    messageToolStripStatusLabel.Text = "Exception";
                    descriptionToolStripStatusLabel.Text = exception.Message;
                }

                Application.DoEvents();
            }
        }

        private void TestaCupomFiscal()
        {
            try
            {
                respListBox.Items.Add("Abrindo cupom ...");
                acbrECF.AbreCupom("", "", "");
                Application.DoEvents();
                
                for (int i = 0; i < 10; i++)
                {
                    respListBox.Items.Add("Vende Item #" + i + " ...");
                    acbrECF.VendeItem(string.Format("{0:0000000000000}", i + 1), "PRODUTO " + i, "II", 1, 1.99M, 0M, "UN", "%", "D");
                    Application.DoEvents();
                }

                acbrECF.SubtotalizaCupom(0M, "Mensagem SubtotalizaCupom ACBr.NET");
                respListBox.Items.Add("Subtotaliza Cupom ...");
                Application.DoEvents();

                var forma01 = acbrECF.FormasPagamento[0];
                acbrECF.EfetuaPagamento(forma01.Indice, 50M, "Mensagem EfetuaPagamento ACBr.NET", false);
                respListBox.Items.Add("Efetua Pagamento ...");
                Application.DoEvents();

                acbrECF.FechaCupom("Mensagem FechaCupom ACBr.NET");
                respListBox.Items.Add("Fecha Cupom ...");
                Application.DoEvents();

                WriteResp("Finalizado!");
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
                WriteResp(exception.Message);
            }
        }


        private void LeituraX()
        {
            try
            {
                acbrECF.LeituraX();
                WriteResp("LeituaX OK");
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }



        private void ReducaoZ()
        {
            try
            {
                acbrECF.LeituraX();
                WriteResp("ReducaoZ OK");
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (NullReferenceException)
            {
                messageToolStripStatusLabel.Text = "Não inicializado.";
                descriptionToolStripStatusLabel.Text = string.Empty;
            }
            catch (Exception exception)
            {
                messageToolStripStatusLabel.Text = "Exception";
                descriptionToolStripStatusLabel.Text = exception.Message;
            }
        }
        #endregion Methods

        #region Event Handlers

        private void ativarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ativar();
        }

        private void desativarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Desativar();
        }

        private void ativarCheckButton_CheckedChanged(object sender, EventArgs e)
        {
            if (ativarCheckButton.Checked)
            {
                Ativar();
            }
            else
            {
                Desativar();
            }
        }

        private void testarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Testar();
        }

        private void sairToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Sair();
        }

        private void estadoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_Estado();
        }

        private void dataHoraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_DataHora();
        }

        private void numECFToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_NumECF();
        }

        private void numLojaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_NumLoja();
        }

        private void numSérieToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_NumSerie();
        }

        private void numVersãoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_NumVersao();
        }

        private void cNPJToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_CNPJ();
        }

        private void iEToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_IE();
        }

        private void pAFToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_PAF();
        }

        private void lerTodasAsVariáveisToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Ler_TodasVariaveis();
        }

        private void testaCupomFiscalToolStripMenuItem_Click(object sender, EventArgs e)
        {
            TestaCupomFiscal();
        }

        private void leituraXToolStripMenuItem_Click(object sender, EventArgs e)
        {
            LeituraX();
        }
        private void reToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ReducaoZ();
        }

        #endregion Event Handlers







    }
}
