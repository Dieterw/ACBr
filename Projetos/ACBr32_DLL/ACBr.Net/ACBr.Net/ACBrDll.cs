using System;
using System.Text;
using System.Runtime.InteropServices;

namespace ACBr.Net
{
    public static class ACBrDll
    {
        #region ACBrECF

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

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_Create(ref IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_Destroy(ref IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetUltimoErro(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_Ativar(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_Desativar(IntPtr ecfHandle);
        
        #region Propriedades do Componente

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetModelo(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetModelo(IntPtr ecfHandle, int modelo);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetPorta(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetPorta(IntPtr ecfHandle, string porta);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTimeOut(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetTimeOut(IntPtr ecfHandle, int timeOut);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetAtivo(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetColunas(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetAguardandoResposta(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetComandoEnviado(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetRespostaComando(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetComandoLOG(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetComandoLOG(IntPtr ecfHandle, string comandoLog);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetAguardaImpressao(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetAguardaImpressao(IntPtr ecfHandle, bool aguardaImpressao);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetModeloStr(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetRFDID(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetDataHora(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCupom(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCOO(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumLoja(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumECF(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumSerie(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumVersao(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetDataMovimento(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetDataHoraSB(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetCNPJ(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetIE(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetIM(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetCliche(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetUsuarioAtual(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetSubModeloECF(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);
        
        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetPAF(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCRZ(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCRO(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCCF(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumGNF(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumGRG(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCDC(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumCOOInicial(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetVendaBruta(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetGrandeTotal(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalCancelamentos(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalDescontos(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalAcrescimos(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalTroco(IntPtr ecfHandle, ref double value);
        
        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalSubstituicaoTributaria(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalNaoTributado(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalIsencao(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalCancelamentosISSQN(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalDescontosISSQN(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalAcrescimosISSQN(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalSubstituicaoTributariaISSQN(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalNaoTributadoISSQN(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalIsencaoISSQN(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalNaoFiscal(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetNumUltItem(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetEmLinha(IntPtr ecfHandle, int timeOut);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetPoucoPapel(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetEstado(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetHorarioVerao(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetArredonda(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTermica(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetMFD(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetIdentificaConsumidorRodape(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetSubTotal(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetTotalPago(IntPtr ecfHandle, ref double value);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetGavetaAberta(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetChequePronto(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetIntervaloAposComando(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetIntervaloAposComando(IntPtr ecfHandle, int intervalo);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetDescricaoGrande(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetDescricaoGrande(IntPtr ecfHandle, bool descricaoGrande);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetGavetaSinalInvertido(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetGavetaSinalInvertido(IntPtr ecfHandle, bool gavetaSinalInvertido);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetOperador(IntPtr ecfHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetOperador(IntPtr ecfHandle, string operador);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetLinhasEntreCupons(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetLinhasEntreCupons(IntPtr ecfHandle, int linhasEntreCupons);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetDecimaisPreco(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetDecimaisPreco(IntPtr ecfHandle, int decimaisPreco);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetDecimaisQtd(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SetDecimaisQtd(IntPtr ecfHandle, int decimaisQtd);

        #endregion Propriedades do Componente

        #region Cupom Fiscal

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_IdentificaConsumidor(IntPtr ecfHandle, string cpfCnpj, string nome, string endereco);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_AbreCupom(IntPtr ecfHandle, string cpfCnpj, string nome, string endereco);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LegendaInmetroProximoItem(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_VendeItem(IntPtr ecfHandle, string codigo, string descricao, string aliquotaICMS, double qtd, double valorUnitario, double descontoPorc, string unidade, string tipoDescontoAcrescimo, string descontoAcrescimo);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_DescontoAcrescimoItemAnterior(IntPtr ecfHandle, double valorDescontoAcrescimo, string descontoAcrescimo);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_SubtotalizaCupom(IntPtr ecfHandle, double descontoAcrescimo, string mensagemRodape);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_EfetuaPagamento(IntPtr ecfHandle, string codFormaPagto, double valor, string observacao, bool imprimeVinculado);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_EstornaPagamento(IntPtr ecfHandle, string codFormaPagtoEstornar, string codFormaPagtoEfetivar, double valor, string observacao);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_FechaCupom(IntPtr ecfHandle, string observacao);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CancelaCupom(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CancelaItemVendido(IntPtr ecfHandle, int numItem);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CancelaItemVendidoParcial(IntPtr ecfHandle, int numItem, double quantidade);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CancelaDescontoAcrescimoItem(IntPtr ecfHandle, int numItem);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CancelaDescontoAcrescimoSubTotal(IntPtr ecfHandle, char tipoAcrescimoDesconto);

        #endregion Cupom Fiscal

        #region Relatórios

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LeituraX(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_ReducaoZ(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_AbreRelatorioGerencial(IntPtr ecfHandle, int indice);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LinhaRelatorioGerencial(IntPtr ecfHandle, string linha, int indiceBMP);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_AbreCupomVinculado(IntPtr ecfHandle, string coo, string codFormaPagto, double valor);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_AbreCupomVinculadoCNF(IntPtr ecfHandle, string coo, string codFormaPagto, string codComprovanteNaoFiscal, double valor);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LinhaCupomVinculado(IntPtr ecfHandle, string linha);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_FechaRelatorio(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_PulaLinhas(IntPtr ecfHandle, int numLinhas);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CortaPapel(IntPtr ecfHandle, bool corteParcial);

        #endregion Relatórios

        #region Alíquotas

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetAliquota(IntPtr ecfHandle, ref AliquotaRec aliquota, int index);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CarregaAliquotas(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LerTotaisAliquota(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_ProgramaAliquota(IntPtr ecfHandle, double aliquota, char tipo, string posicao);

        #endregion Alíquotas

        #region Formas de Pagto

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetFormaPagamento(IntPtr ecfHandle, ref FormaPagamentoRec formaPagamento, int index);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CarregaFormasPagamento(IntPtr ecfHandle);
        
        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LerTotaisFormaPagamento(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_ProgramaFormaPagamento(IntPtr ecfHandle, string descricao, bool permiteVinculado, string posicao);

        #endregion Formas de Pagto

        #region Comprovante não fiscal

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_GetComprovanteNaoFiscal(IntPtr ecfHandle, ref ComprovanteNaoFiscalRec comprovanteNaoFiscal, int index);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_CarregaComprovantesNaoFiscais(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_LerTotaisComprovanteNaoFiscal(IntPtr ecfHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_ProgramaComprovanteNaoFiscal(IntPtr ecfHandle, string descricao, string tipo, string posicao);

        #endregion Comprovante não fiscal

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_Sangria(IntPtr ecfHandle, double valor, string obs);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_Suprimento(IntPtr ecfHandle, double valor, string obs);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ECF_AbreGaveta(IntPtr ecfHandle);

        #endregion ACBrECF

        #region ACBrBal

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_Create(ref IntPtr balHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_Destroy(ref IntPtr balHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetUltimoErro(IntPtr balHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_Ativar(IntPtr balHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_Desativar(IntPtr balHandle);

        #region Propriedades do Componente

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetModelo(IntPtr balHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_SetModelo(IntPtr balHandle, int modelo);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetModeloStr(IntPtr balHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetPorta(IntPtr balHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_SetPorta(IntPtr balHandle, string porta);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetAtivo(IntPtr balHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetUltimoPesoLido(IntPtr balHandle, ref double peso);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_GetUltimaResposta(IntPtr balHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BAL_LePeso(IntPtr balHandle, int timeout, ref double peso);

        #endregion Propriedades do Componente

        #endregion ACBrBal

        #region ACBrLCB

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_Create(ref IntPtr lcbHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_Destroy(ref IntPtr lcbHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_GetUltimoErro(IntPtr lcbHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_Ativar(IntPtr lcbHandle);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_Desativar(IntPtr lcbHandle);

        #region Propriedades do Componente

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_GetPorta(IntPtr lcbHandle, ref StringBuilder buffer, int bufferLen);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_SetPorta(IntPtr lcbHandle, string porta);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_GetAtivo(IntPtr lcbHandle);

        public delegate void TNotifyEvent(IntPtr p);

        [DllImport("ACBr32.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LCB_SetOnLeCodigo(IntPtr lcbHandle, [MarshalAs(UnmanagedType.FunctionPtr)]TNotifyEvent method);

        #endregion Propriedades do Componente

        #endregion ACBrLCB
    }
}
