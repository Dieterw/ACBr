using System;
using System.Text;
using System.Runtime.InteropServices;

namespace ACBr.Net
{
    internal static class ACBrECFDLL
    {
        #region Interop Types

        [StructLayout(LayoutKind.Sequential)]
        public struct AliquotaRec
        {
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
            public string Indice;

            [MarshalAs(UnmanagedType.R8)]
            public double Aliquota;

            [MarshalAs(UnmanagedType.U1)]
            public char Tipo;

            [MarshalAs(UnmanagedType.R8)]
            public double Total;

            [MarshalAs(UnmanagedType.U1)]
            public byte Sequencia;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct FormaPagamentoRec
        {
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
            public string Indice;

            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
            public string Descricao;

            [MarshalAs(UnmanagedType.U1)]
            public bool PermiteVinculado;

            [MarshalAs(UnmanagedType.R8)]
            public double Total;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct ComprovanteNaoFiscalRec
        {
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
            public string Indice;

            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 30)]
            public string Descricao;

            [MarshalAs(UnmanagedType.U1)]
            public bool PermiteVinculado;

            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 4)]
            public string FormaPagamento;

            [MarshalAs(UnmanagedType.R8)]
            public double Total;

            [MarshalAs(UnmanagedType.I4)]
            public int Contador;
        }

        #endregion Interop Types

        [DllImport("ACBrECFDLL.dll")]
        public static extern int UltimoErro(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int Ativar();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int Desativar();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int Inicializar();
        
        #region Propriedades do Componente

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetModelo();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetModelo(int modelo);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetPorta(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetPorta(string porta);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTimeOut();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetTimeOut(int timeOut);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetAtivo();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetColunas();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetAguardandoResposta();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetComandoEnviado(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetRespostaComando(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetComandoLOG(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetComandoLOG(string comandoLog);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetAguardaImpressao();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetAguardaImpressao(bool aguardaImpressao);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetModeloStr(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetRFDID(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetDataHora(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCupom(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCOO(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumLoja(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumECF(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumSerie(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumVersao(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetDataMovimento(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetDataHoraSB(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetCNPJ(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetIE(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetIM(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetCliche(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetUsuarioAtual(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetSubModeloECF(ref StringBuilder buffer, int bufferLen);
        
        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetPAF(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCRZ(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCRO(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCCF(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumGNF(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumGRG(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCDC(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumCOOInicial(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetVendaBruta(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetGrandeTotal(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalCancelamentos(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalDescontos(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalAcrescimos(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalTroco(ref double value);
        
        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalSubstituicaoTributaria(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalNaoTributado(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalIsencao(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalCancelamentosISSQN(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalDescontosISSQN(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalAcrescimosISSQN(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalSubstituicaoTributariaISSQN(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalNaoTributadoISSQN(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalIsencaoISSQN(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalNaoFiscal(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetNumUltItem();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetEmLinha(int timeOut);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetPoucoPapel();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetEstado();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetHorarioVerao();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetArredonda();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTermica();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetMFD();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetIdentificaConsumidorRodape();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetSubTotal(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetTotalPago(ref double value);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetGavetaAberta();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetChequePronto();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetIntervaloAposComando();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetIntervaloAposComando(int intervalo);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetDescricaoGrande();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetDescricaoGrande(bool descricaoGrande);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetGavetaSinalInvertido();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetGavetaSinalInvertido(bool gavetaSinalInvertido);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetOperador(ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetOperador(string operador);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetLinhasEntreCupons();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetLinhasEntreCupons(int linhasEntreCupons);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetDecimaisPreco();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetDecimaisPreco(int decimaisPreco);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetDecimaisQtd();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SetDecimaisQtd(int decimaisQtd);


        #endregion Propriedades do Componente

        #region Cupom Fiscal

        [DllImport("ACBrECFDLL.dll")]
        public static extern int IdentificaConsumidor(string cpfCnpj, string nome, string endereco);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int AbreCupom(string cpfCnpj, string nome, string endereco);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int LegendaInmetroProximoItem();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int VendeItem(string codigo, string descricao, string aliquotaICMS, double qtd, double valorUnitario, double descontoPorc, string unidade, string tipoDescontoAcrescimo, string descontoAcrescimo);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int DescontoAcrescimoItemAnterior(double valorDescontoAcrescimo, string descontoAcrescimo);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int SubtotalizaCupom(double descontoAcrescimo, string mensagemRodape);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int EfetuaPagamento(string codFormaPagto, double valor, string observacao, bool imprimeVinculado);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int EstornaPagamento(string codFormaPagtoEstornar, string codFormaPagtoEfetivar, double valor, string observacao);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int FechaCupom(string observacao);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CancelaCupom();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CancelaItemVendido(int numItem);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CancelaItemVendidoParcial(int numItem, double quantidade);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CancelaDescontoAcrescimoItem(int numItem);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CancelaDescontoAcrescimoSubTotal(char tipoAcrescimoDesconto);

        #endregion Cupom Fiscal

        #region Relatórios

        [DllImport("ACBrECFDLL.dll")]
        public static extern int LeituraX();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int ReducaoZ();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int AbreRelatorioGerencial(int indice);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int LinhaRelatorioGerencial(string linha, int indiceBMP);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int AbreCupomVinculado(string coo, string codFormaPagto, double valor);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int AbreCupomVinculado(string coo, string codFormaPagto, string codComprovanteNaoFiscal, double valor);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int LinhaCupomVinculado(string linha);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int FechaRelatorio();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int PulaLinhas(int numLinhas);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CortaPapel(bool corteParcial);

        #endregion Relatórios

        #region Alíquotas

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetAliquota(ref AliquotaRec aliquota, int index);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CarregaAliquotas();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int LerTotaisAliquota();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int ProgramaAliquota(double aliquota, char tipo);

        #endregion Alíquotas

        #region Formas de Pagto

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetFormaPagamento(ref FormaPagamentoRec formaPagamento, int index);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CarregaFormasPagamento();
        
        [DllImport("ACBrECFDLL.dll")]
        public static extern int LerTotaisFormaPagamento();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int ProgramaFormaPagamento(string descricao, bool permiteVinculado);

        #endregion Formas de Pagto

        #region Comprovante não fiscal

        [DllImport("ACBrECFDLL.dll")]
        public static extern int GetComprovanteNaoFiscal(ref ComprovanteNaoFiscalRec comprovanteNaoFiscal, int index);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int CarregaComprovantesNaoFiscais();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int LerTotaisComprovanteNaoFiscal();

        [DllImport("ACBrECFDLL.dll")]
        public static extern int ProgramaComprovanteNaoFiscal(string descricao, string tipo);

        #endregion Comprovante não fiscal

        [DllImport("ACBrECFDLL.dll")]
        public static extern int Sangria(double valor, string obs);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int Suprimento(double valor, string obs);

        [DllImport("ACBrECFDLL.dll")]
        public static extern int AbreGaveta();

    }
}
