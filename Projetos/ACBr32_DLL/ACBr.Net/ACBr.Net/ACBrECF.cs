using System;
using System.Text;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace ACBr.Net
{
    public class ACBrECF : IDisposable
    {
        #region Inner Types

        private delegate int StringEntryPointDelegate(ref StringBuilder buffer, int bufferLen);
        private delegate int DoubleEntryPointDelegate(ref double value);
        private delegate int VoidEntryPointDelegate();

        #endregion Inner Types

        #region Fields

        private IList<ACBrECFAliquota> aliquotas;
        private IList<ACBrECFFormaPagamento> formasPagamento;
        private IList<ACBrECFComprovanteNaoFiscal> comprovantesNaoFiscais;

        #endregion Fields

        #region Constructor

        public ACBrECF()
        {
            int ret = ACBrECFDLL.Inicializar();
            CheckResult(ret);
        }

        ~ACBrECF()
        {
            Dispose();
        }

        #endregion Constructor

        #region Properties

        public ModeloECF Modelo
        {
            get
            {
                return (ModeloECF)GetInt32(ACBrECFDLL.GetModelo);
            }
            set
            {
                int ret = ACBrECFDLL.SetModelo((int)value);
                CheckResult(ret);
            }
        }

        public string Porta
        {
            get
            {
                return GetString(ACBrECFDLL.GetPorta);
            }
            set
            {
                int ret = ACBrECFDLL.SetPorta(value);
                CheckResult(ret);
            }
        }

        public int TimeOut
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetTimeOut);
            }
            set
            {
                int ret = ACBrECFDLL.SetTimeOut(value);
                CheckResult(ret);
            }
        }

        public bool Ativo
        {
            get
            {
                return GetBool(ACBrECFDLL.GetAtivo);
            }
        }

        public int Colunas
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetColunas);
            }
        }

        public bool AguardandoResposta
        {
            get
            {
                return GetBool(ACBrECFDLL.GetAguardandoResposta);
            }
        }

        public string ComandoLog
        {
            get
            {
                return GetString(ACBrECFDLL.GetComandoLOG);
            }
            set
            {
                int ret = ACBrECFDLL.SetComandoLOG(value);
                CheckResult(ret);
            }
        }

        public bool AguardaImpressao
        {
            get
            {
                return GetBool(ACBrECFDLL.GetAguardaImpressao);
            }
            set
            {
                int ret = ACBrECFDLL.SetAguardaImpressao(value);
                CheckResult(ret);
            }
        }

        public string ModeloStr
        {
            get
            {
                return GetString(ACBrECFDLL.GetModeloStr);
            }
        }

        public string RFDID
        {
            get
            {
                return GetString(ACBrECFDLL.GetRFDID);
            }
        }

        public DateTime DataHora
        {
            get
            {
                return GetDateTime(ACBrECFDLL.GetDataHora);
            }
        }

        public string NumCupom
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCupom);
            }
        }

        public string NumCOO
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCOO);
            }
        }

        public string NumLoja
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumLoja);
            }
        }

        public string NumECF
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumECF);
            }
        }

        public string NumSerie
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumSerie);
            }
        }

        public string NumVersao
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumVersao);
            }
        }

        public DateTime DataMovimento
        {
            get
            {
                return GetDateTime(ACBrECFDLL.GetDataMovimento);
            }
        }

        public DateTime DataHoraSB
        {
            get
            {
                return GetDateTime(ACBrECFDLL.GetDataHoraSB);
            }
        }

        public string CNPJ
        {
            get
            {
                return GetString(ACBrECFDLL.GetCNPJ);
            }
        }

        public string IE
        {
            get
            {
                return GetString(ACBrECFDLL.GetIE);
            }
        }

        public string IM
        {
            get
            {
                return GetString(ACBrECFDLL.GetIM);
            }
        }

        public string Cliche
        {
            get
            {
                return GetString(ACBrECFDLL.GetCliche);
            }
        }

        public string UsuarioAtual
        {
            get
            {
                return GetString(ACBrECFDLL.GetUsuarioAtual);
            }
        }

        public string SubModeloECF
        {
            get
            {
                return GetString(ACBrECFDLL.GetSubModeloECF);
            }
        }

        public string PAF
        {
            get
            {
                return GetString(ACBrECFDLL.GetPAF);
            }
        }

        public string NumCRZ
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCRZ);
            }
        }

        public string NumCRO
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCRO);
            }
        }

        public string NumCCF
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCCF);
            }
        }

        public string NumGNF
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumGNF);
            }
        }

        public string NumGRG
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumGRG);
            }
        }

        public string NumCDC
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCDC);
            }
        }

        public string NumCOOInicial
        {
            get
            {
                return GetString(ACBrECFDLL.GetNumCOOInicial);
            }
        }

        public decimal VendaBruta
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetVendaBruta);
            }
        }

        public decimal GrandeTotal
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetGrandeTotal);
            }
        }

        public decimal TotalCancelamentos
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalCancelamentos);
            }
        }

        public decimal TotalDescontos
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalDescontos);
            }
        }

        public decimal TotalAcrescimos
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalAcrescimos);
            }
        }

        public decimal TotalTroco
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalTroco);
            }
        }

        public decimal TotalSubstituicaoTributaria
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalSubstituicaoTributaria);
            }
        }

        public decimal TotalNaoTributado
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalNaoTributado);
            }
        }

        public decimal TotalIsencao
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalIsencao);
            }
        }

        public decimal TotalCancelamentosISSQN
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalCancelamentosISSQN);
            }
        }

        public decimal TotalDescontosISSQN
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalDescontosISSQN);
            }
        }

        public decimal TotalAcrescimosISSQN
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalAcrescimosISSQN);
            }
        }

        public decimal TotalSubstituicaoTributariaISSQN
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalSubstituicaoTributariaISSQN);
            }
        }

        public decimal TotalNaoTributadoISSQN
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalNaoTributadoISSQN);
            }
        }

        public decimal TotalIsencaoISSQN
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalIsencaoISSQN);
            }
        }

        public decimal TotalNaoFiscal
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalNaoFiscal);
            }
        }

        public int NumUltItem
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetNumUltItem);
            }
        }

        public bool EmLinha
        {
            get
            {
                const int DEFAULT_TIMEOUT = 1;
                int ret = ACBrECFDLL.GetEmLinha(DEFAULT_TIMEOUT);
                CheckResult(ret);

                return Convert.ToBoolean(ret);
            }
        }

        public bool PoucoPapel
        {
            get
            {
                return GetBool(ACBrECFDLL.GetPoucoPapel);
            }
        }

        public EstadoECF Estado
        {
            get
            {
                return (EstadoECF)GetInt32(ACBrECFDLL.GetEstado);
            }
        }

        public bool HorarioVerao
        {
            get
            {
                return GetBool(ACBrECFDLL.GetHorarioVerao);
            }
        }

        public bool Arredonda
        {
            get
            {
                return GetBool(ACBrECFDLL.GetArredonda);
            }
        }

        public bool Termica
        {
            get
            {
                return GetBool(ACBrECFDLL.GetTermica);
            }
        }

        public bool MFD
        {
            get
            {
                return GetBool(ACBrECFDLL.GetMFD);
            }
        }

        public bool IdentificaConsumidorRodape
        {
            get
            {
                return GetBool(ACBrECFDLL.GetIdentificaConsumidorRodape);
            }
        }

        public decimal SubTotal
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetSubTotal);
            }
        }

        public decimal TotalPago
        {
            get
            {
                return GetDecimal(ACBrECFDLL.GetTotalPago);
            }
        }

        public bool GavetaAberta
        {
            get
            {
                return GetBool(ACBrECFDLL.GetGavetaAberta);
            }
        }

        public bool ChequePronto
        {
            get
            {
                return GetBool(ACBrECFDLL.GetChequePronto);
            }
        }

        public int IntervaloAposComando
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetIntervaloAposComando);
            }
            set
            {
                int ret = ACBrECFDLL.SetIntervaloAposComando(value);
                CheckResult(ret);
            }
        }

        public bool DescricaoGrande
        {
            get
            {
                return GetBool(ACBrECFDLL.GetDescricaoGrande);
            }
            set
            {
                int ret = ACBrECFDLL.SetDescricaoGrande(value);
                CheckResult(ret);
            }
        }

        public bool GavetaSinalInvertido
        {
            get
            {
                return GetBool(ACBrECFDLL.GetGavetaSinalInvertido);
            }
            set
            {
                int ret = ACBrECFDLL.SetGavetaSinalInvertido(value);
                CheckResult(ret);
            }
        }

        public string Operador
        {
            get
            {
                return GetString(ACBrECFDLL.GetOperador);
            }
            set
            {
                int ret = ACBrECFDLL.SetOperador(value);
                CheckResult(ret);

            }
        }

        public int LinhasEntreCupons
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetLinhasEntreCupons);
            }
            set
            {
                int ret = ACBrECFDLL.SetLinhasEntreCupons(value);
                CheckResult(ret);
            }
        }

        public int DecimaisPreco
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetDecimaisPreco);
            }
            set
            {
                int ret = ACBrECFDLL.SetDecimaisPreco(value);
                CheckResult(ret);
            }
        }

        public int DecimaisQtd
        {
            get
            {
                return GetInt32(ACBrECFDLL.GetDecimaisQtd);
            }
            set
            {
                int ret = ACBrECFDLL.SetDecimaisQtd(value);
                CheckResult(ret);
            }
        }

        public IList<ACBrECFAliquota> Aliquotas
        {
            get
            {
                if (aliquotas == null) this.CarregaAliquotas();
                return aliquotas;
            }
        }

        public IList<ACBrECFFormaPagamento> FormasPagamento
        {
            get
            {
                if (formasPagamento == null) CarregaFormasPagamento();
                return formasPagamento;
            }
        }

        public IList<ACBrECFComprovanteNaoFiscal> ComprovantesNaoFiscais
        {
            get
            {
                if (comprovantesNaoFiscais == null) CarregaComprovantesNaoFiscais();
                return comprovantesNaoFiscais;
            }
        }

        #endregion Properties

        #region Methods

        #region Métodos Ativar/Desativar

        public void Ativar()
        {
            int ret = ACBrECFDLL.Ativar();
            CheckResult(ret);
        }

        public void Desativar()
        {
            int ret = ACBrECFDLL.Desativar();
            CheckResult(ret);
        }

        #endregion Métodos Ativar/Desativar

        #region Métodos do Cupom Fiscal

        public void IdentificaConsumidor(string cpfCnpj, string nome, string endereco)
        {
            int ret = ACBrECFDLL.IdentificaConsumidor(cpfCnpj, nome, endereco);
            CheckResult(ret);
        }

        public void AbreCupom(string cpfCnpj, string nome, string endereco)
        {
            int ret = ACBrECFDLL.AbreCupom(cpfCnpj, nome, endereco);
            CheckResult(ret);
        }

        public void LegendaInmetroProximoItem()
        {
            int ret = ACBrECFDLL.LegendaInmetroProximoItem();
            CheckResult(ret);
        }

        public void VendeItem(string codigo, string descricao, string aliquotaICMS, decimal qtd, decimal valorUnitario, decimal descontoPorc, string unidade, string tipoDescontoAcrescimo, string descontoAcrescimo)
        {
            int ret = ACBrECFDLL.VendeItem(codigo, descricao, aliquotaICMS, (double)qtd, (double)valorUnitario, (double)descontoPorc, unidade, tipoDescontoAcrescimo, descontoAcrescimo);
            CheckResult(ret);
        }

        public void DescontoAcrescimoItemAnterior(decimal valorDesconto, string descontoAcrescimo)
        {
            int ret = ACBrECFDLL.DescontoAcrescimoItemAnterior((double)valorDesconto, descontoAcrescimo);
            CheckResult(ret);
        }

        public void SubtotalizaCupom(decimal descontoAcrescimo, string mensagemRodape)
        {
            int ret = ACBrECFDLL.SubtotalizaCupom((double)descontoAcrescimo, mensagemRodape);
            CheckResult(ret);
        }

        public void EfetuaPagamento(string codFormaPagto, decimal valor, string observacao, bool imprimeVinculado)
        {
            int ret = ACBrECFDLL.EfetuaPagamento(codFormaPagto, (double)valor, observacao, imprimeVinculado);
            CheckResult(ret);
        }

        public void EstornaPagamento(string codFormaPagtoEstornar, string codFormaPagtoEfetivar, double valor, string observacao)
        {
            int ret = ACBrECFDLL.EstornaPagamento(codFormaPagtoEstornar, codFormaPagtoEfetivar, valor, observacao);
        }

        public void FechaCupom(string observacao)
        {
            int ret = ACBrECFDLL.FechaCupom(observacao);
            CheckResult(ret);
        }

        public void CancelaCupom()
        {
            int ret = ACBrECFDLL.CancelaCupom();
            CheckResult(ret);
        }

        public void CancelaItemVendido(int mumItem)
        {
            int ret = ACBrECFDLL.CancelaItemVendido(mumItem);
            CheckResult(ret);
        }

        public void CancelaItemVendidoParcial(int numItem, decimal quantidade)
        {
            int ret = ACBrECFDLL.CancelaItemVendidoParcial(numItem, (double)quantidade);
            CheckResult(ret);
        }

        public void CancelaDescontoAcrescimoItem(int numItem)
        {
            int ret = ACBrECFDLL.CancelaDescontoAcrescimoItem(numItem);
        }

        public void CancelaDescontoAcrescimoSubTotal(string tipoAcrescimoDesconto)
        {
            int ret = ACBrECFDLL.CancelaDescontoAcrescimoSubTotal(tipoAcrescimoDesconto[0]);
            CheckResult(ret);
        }

        #endregion Métodos do Cupom Fiscal

        #region Relatórios

        public void LeituraX()
        {
            int ret = ACBrECFDLL.LeituraX();
            CheckResult(ret);
        }

        public void ReducaoZ()
        {
            int ret = ACBrECFDLL.ReducaoZ();
            CheckResult(ret);
        }

        public void AbreRelatorioGerencial(int indice)
        {
            int ret = ACBrECFDLL.AbreRelatorioGerencial(indice);
            CheckResult(ret);
        }

        public void LinhaRelatorioGerencial(string linha, int indiceBMP)
        {
            int ret = ACBrECFDLL.LinhaRelatorioGerencial(linha, indiceBMP);
            CheckResult(ret);
        }

        public void AbreCupomVinculado(string coo, string codFormaPagto, decimal valor)
        {
            int ret = ACBrECFDLL.AbreCupomVinculado(coo, codFormaPagto, (double)valor);
            CheckResult(ret);
        }

        public void AbreCupomVinculado(string coo, string codFormaPagto, string codComprovanteNaoFiscal, decimal valor)
        {
            int ret = ACBrECFDLL.AbreCupomVinculado(coo, codFormaPagto, codComprovanteNaoFiscal, (double)valor);
            CheckResult(ret);
        }

        public void LinhaCupomVinculado(string linha)
        {
            int ret = ACBrECFDLL.LinhaCupomVinculado(linha);
            CheckResult(ret);
        }

        public void FechaRelatorio()
        {
            int ret = ACBrECFDLL.FechaRelatorio();
            CheckResult(ret);
        }

        public void PulaLinhas(int numLinhas)
        {
            int ret = ACBrECFDLL.PulaLinhas(numLinhas);
            CheckResult(ret);
        }

        public void CortaPapel(bool corteParcial)
        {
            int ret = ACBrECFDLL.CortaPapel(corteParcial);
            CheckResult(ret);
        }

        #endregion Relatórios

        #region Alíquotas

        public void CarregaAliquotas()
        {
            int count = ACBrECFDLL.CarregaAliquotas();
            CheckResult(count);

            CarregaAliquotas(count);
        }

        private void CarregaAliquotas(int count)
        {
            aliquotas = new List<ACBrECFAliquota>(count);
            for (int i = 0; i < count; i++)
            {
                var record = new ACBrECFDLL.AliquotaRec();
                int ret = ACBrECFDLL.GetAliquota(ref record, i);
                CheckResult(ret);

                ACBrECFAliquota aliquota = new ACBrECFAliquota();
                aliquota.Indice = String.Copy(record.Indice);
                aliquota.Aliquota = Convert.ToDecimal(record.Aliquota);
                aliquota.Sequencia = record.Sequencia;
                aliquota.Tipo = record.Tipo.ToString();
                aliquota.Total = Convert.ToDecimal(record.Total);

                aliquotas.Add(aliquota);
            }
        }

        public void LerTotaisAliquota()
        {
            int count = ACBrECFDLL.LerTotaisAliquota();
            CheckResult(count);

            CarregaAliquotas(count);
        }

        public void ProgramaAliquota(decimal aliquota, string tipo)
        {
            if (string.IsNullOrEmpty(tipo)) throw new ArgumentException();

            int ret = ACBrECFDLL.ProgramaAliquota((double)aliquota, tipo[0]);
            CheckResult(ret);
        }

        #endregion Alíquotas

        #region Formas de Pagto

        public void CarregaFormasPagamento()
        {
            int count = ACBrECFDLL.CarregaFormasPagamento();
            CheckResult(count);

            CarregaFormasPagamento(count);
        }

        private void CarregaFormasPagamento(int count)
        {
            formasPagamento = new List<ACBrECFFormaPagamento>(count);
            for (int i = 0; i < count; i++)
            {
                var record = new ACBrECFDLL.FormaPagamentoRec();
                int ret = ACBrECFDLL.GetFormaPagamento(ref record, i);
                CheckResult(ret);

                ACBrECFFormaPagamento formaPagamento = new ACBrECFFormaPagamento();
                formaPagamento.Indice = String.Copy(record.Indice);
                formaPagamento.Descricao = String.Copy(record.Descricao);
                formaPagamento.PermiteVinculado = record.PermiteVinculado;
                formaPagamento.Total = Convert.ToDecimal(record.Total);

                formasPagamento.Add(formaPagamento);
            }
        }

        public void LerTotaisFormaPagamento()
        {
            int count = ACBrECFDLL.LerTotaisFormaPagamento();
            CheckResult(count);

            CarregaFormasPagamento(count);
        }
        
        public void ProgramaFormaPagamento(string descricao, bool permiteVinculado)
        {
            int ret = ACBrECFDLL.ProgramaFormaPagamento(descricao, permiteVinculado);
            CheckResult(ret);
        }

        #endregion Formas de Pagto

        #region Comprovantes Não Fiscal

        public void CarregaComprovantesNaoFiscais()
        {
            int count = ACBrECFDLL.CarregaComprovantesNaoFiscais();
            CheckResult(count);

            CarregaComprovantesNaoFiscais(count);
        }

        private void CarregaComprovantesNaoFiscais(int count)
        {
            comprovantesNaoFiscais = new List<ACBrECFComprovanteNaoFiscal>(count);
            for (int i = 0; i < count; i++)
            {
                var record = new ACBrECFDLL.ComprovanteNaoFiscalRec();
                int ret = ACBrECFDLL.GetComprovanteNaoFiscal(ref record, i);
                CheckResult(ret);

                ACBrECFComprovanteNaoFiscal comprovanteNaoFiscal = new ACBrECFComprovanteNaoFiscal();
                comprovanteNaoFiscal.Indice = String.Copy(record.Indice);
                comprovanteNaoFiscal.Descricao = String.Copy(record.Descricao);
                comprovanteNaoFiscal.PermiteVinculado = record.PermiteVinculado;
                comprovanteNaoFiscal.FormaPagamento = String.Copy(record.FormaPagamento);
                comprovanteNaoFiscal.Total = Convert.ToDecimal(record.Total);
                comprovanteNaoFiscal.Contador = record.Contador;

                comprovantesNaoFiscais.Add(comprovanteNaoFiscal);
            }
        }

        public void LerTotaisComprovanteNaoFiscal()
        {
            int count = ACBrECFDLL.LerTotaisComprovanteNaoFiscal();
            CheckResult(count);

            CarregaComprovantesNaoFiscais(count);
        }

        public void ProgramaComprovanteNaoFiscal(string descricao, string tipo)
        {
            if (string.IsNullOrEmpty(tipo)) throw new ArgumentException();

            int ret = ACBrECFDLL.ProgramaComprovanteNaoFiscal(descricao, tipo);
            CheckResult(ret);
        }

        #endregion Comprovantes Não Fiscal

        public void Suprimento(decimal valor, string obs)
        {
            int ret = ACBrECFDLL.Suprimento((double)valor, obs);
            CheckResult(ret);
        }

        public void Sangria(decimal valor, string obs)
        {
            int ret = ACBrECFDLL.Sangria((double)valor, obs);
            CheckResult(ret);
        }

        public void AbreGaveta()
        {
            int ret = ACBrECFDLL.AbreGaveta();
            CheckResult(ret);
        }

        #region P/Invoke Helper Methods

        private string GetString(StringEntryPointDelegate entryPoint)
        {
            const int BUFFER_LEN = 1024;
            StringBuilder buffer = new StringBuilder(BUFFER_LEN);

            int ret = entryPoint(ref buffer, BUFFER_LEN);
            CheckResult(ret);

            return buffer.ToString();
        }

        private DateTime GetDateTime(DoubleEntryPointDelegate entryPoint)
        {
            double ticks = 0d;
            int ret = entryPoint(ref ticks);
            CheckResult(ret);

            return DateTime.FromOADate(ticks);
        }

        private decimal GetDecimal(DoubleEntryPointDelegate entryPoint)
        {
            double value = 0d;
            int ret = entryPoint(ref value);
            CheckResult(ret);

            return Convert.ToDecimal(value);
        }

        private int GetInt32(VoidEntryPointDelegate entryPoint)
        {
            int ret = entryPoint();
            CheckResult(ret);

            return ret;
        }

        private bool GetBool(VoidEntryPointDelegate entryPoint)
        {
            int ret = entryPoint();
            CheckResult(ret);

            return ret == 1 ? true : false;
        }

        private void CheckResult(int ret)
        {
            switch (ret)
            {
                case -1:

                    string error = GetString(ACBrECFDLL.UltimoErro);
                    throw new ACBrECFException(error);

                case -2:

                    throw new ACBrECFException("ACBr não inicializado.");

            }
        }

        #endregion P/Invoke Helper Methods

        #endregion Methods

        #region IDisposable Members

        public void Dispose()
        {
            try
            {
                this.Desativar();
            }
            catch { }

            GC.SuppressFinalize(this);
        }

        #endregion IDisposable Members
    }
}
