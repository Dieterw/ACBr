using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace ACBr.Net.ECFTeste
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            List<ACBrECF> ecfs = new List<ACBrECF>();
            for (int i = 0; i < 1000; i++)
            {
                ecfs.Add(new ACBrECF());
            }

            foreach (var ecf in ecfs)
            {
                ecf.Modelo = ModeloECF.DataRegis;
                ecf.Porta = "COM5";
                ecf.AguardaImpressao = true;
            }

            foreach (var ecf in ecfs)
            {
                ecf.Dispose();
            }

            ACBrBal b1 = new ACBrBal();
            ACBrBal b2 = new ACBrBal();

            Console.WriteLine(b1.Ativo);
            Console.WriteLine(b2.Ativo);

            b1.Modelo = ModeloBal.Toledo;
            b1.Porta = "COM1";
            
            b2.Modelo = ModeloBal.Filizola;
            b2.Porta = "COM2";

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }
    }
}
