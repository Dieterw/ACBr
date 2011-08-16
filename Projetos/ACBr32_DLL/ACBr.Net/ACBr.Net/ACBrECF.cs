using System;
using System.Text;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace ACBr.Net
{
    public class ACBrECF : ACBrDevice, IDisposable
    {
        #region Fields

        private ACBrECFAliquota[] aliquotas;
        private ACBrECFFormaPagamento[] formasPagamento;
        private ACBrECFComprovanteNaoFiscal[] comprovantesNaoFiscais;

        #endregion Fields

        #region Constructor

        public ACBrECF()
        {
            int ret = ACBrDll.ECF_Create(ref this.handle);
            CheckResult(ret);
        }

        #endregion Constructor

        #region Properties

        public ModeloECF Modelo
        {
            get
            {
                return (ModeloECF)GetInt32(ACBrDll.ECF_GetModelo);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetModelo, (int)value);
            }
        }

        public string Porta
        {
            get
            {
                return GetString(ACBrDll.ECF_GetPorta);
            }
            set
            {
                SetString(ACBrDll.ECF_SetPorta, value);
            }
        }
		
        public int Velocidade
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetVelocidade);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetVelocidade, value);
            }
        }		

        public int TimeOut
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetTimeOut);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetTimeOut, value);
            }
        }

        public bool Ativo
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetAtivo);
            }
        }

        public int Colunas
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetColunas);
            }
        }

        public bool AguardandoResposta
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetAguardandoResposta);
            }
        }

        public string ComandoLog
        {
            get
            {
                return GetString(ACBrDll.ECF_GetComandoLOG);
            }
            set
            {
                SetString(ACBrDll.ECF_SetComandoLOG, value);
            }
        }

        public bool AguardaImpressao
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetAguardaImpressao);
            }
            set
            {
                SetBool(ACBrDll.ECF_SetAguardaImpressao, value);
            }
        }

        public string ModeloStr
        {
            get
            {
                return GetString(ACBrDll.ECF_GetModeloStr);
            }
        }

        public string RFDID
        {
            get
            {
                return GetString(ACBrDll.ECF_GetRFDID);
            }
        }

        public DateTime DataHora
        {
            get
            {
                return GetDateTime(ACBrDll.ECF_GetDataHora);
            }
        }

        public string NumCupom
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCupom);
            }
        }

        public string NumCOO
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCOO);
            }
        }

        public string NumLoja
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumLoja);
            }
        }

        public string NumECF
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumECF);
            }
        }

        public string NumSerie
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumSerie);
            }
        }

        public string NumVersao
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumVersao);
            }
        }

        public DateTime DataMovimento
        {
            get
            {
                return GetDateTime(ACBrDll.ECF_GetDataMovimento);
            }
        }

        public DateTime DataHoraSB
        {
            get
            {
                return GetDateTime(ACBrDll.ECF_GetDataHoraSB);
            }
        }

        public string CNPJ
        {
            get
            {
                return GetString(ACBrDll.ECF_GetCNPJ);
            }
        }

        public string IE
        {
            get
            {
                return GetString(ACBrDll.ECF_GetIE);
            }
        }

        public string IM
        {
            get
            {
                return GetString(ACBrDll.ECF_GetIM);
            }
        }

        public string Cliche
        {
            get
            {
                return GetString(ACBrDll.ECF_GetCliche);
            }
        }

        public string UsuarioAtual
        {
            get
            {
                return GetString(ACBrDll.ECF_GetUsuarioAtual);
            }
        }

        public string SubModeloECF
        {
            get
            {
                return GetString(ACBrDll.ECF_GetSubModeloECF);
            }
        }

        public string PAF
        {
            get
            {
                return GetString(ACBrDll.ECF_GetPAF);
            }
        }

        public string NumCRZ
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCRZ);
            }
        }

        public string NumCRO
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCRO);
            }
        }

        public string NumCCF
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCCF);
            }
        }

        public string NumGNF
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumGNF);
            }
        }

        public string NumGRG
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumGRG);
            }
        }

        public string NumCDC
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCDC);
            }
        }

        public string NumCOOInicial
        {
            get
            {
                return GetString(ACBrDll.ECF_GetNumCOOInicial);
            }
        }

        public decimal VendaBruta
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetVendaBruta);
            }
        }

        public decimal GrandeTotal
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetGrandeTotal);
            }
        }

        public decimal TotalCancelamentos
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalCancelamentos);
            }
        }

        public decimal TotalDescontos
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalDescontos);
            }
        }

        public decimal TotalAcrescimos
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalAcrescimos);
            }
        }

        public decimal TotalTroco
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalTroco);
            }
        }

        public decimal TotalSubstituicaoTributaria
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalSubstituicaoTributaria);
            }
        }

        public decimal TotalNaoTributado
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalNaoTributado);
            }
        }

        public decimal TotalIsencao
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalIsencao);
            }
        }

        public decimal TotalCancelamentosISSQN
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalCancelamentosISSQN);
            }
        }

        public decimal TotalDescontosISSQN
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalDescontosISSQN);
            }
        }

        public decimal TotalAcrescimosISSQN
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalAcrescimosISSQN);
            }
        }

        public decimal TotalSubstituicaoTributariaISSQN
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalSubstituicaoTributariaISSQN);
            }
        }

        public decimal TotalNaoTributadoISSQN
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalNaoTributadoISSQN);
            }
        }

        public decimal TotalIsencaoISSQN
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalIsencaoISSQN);
            }
        }

        public decimal TotalNaoFiscal
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalNaoFiscal);
            }
        }

        public int NumUltItem
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetNumUltItem);
            }
        }

        public bool EmLinha
        {
            get
            {
                const int DEFAULT_TIMEOUT = 1;
                int ret = ACBrDll.ECF_GetEmLinha(this.handle, DEFAULT_TIMEOUT);
                CheckResult(ret);

                return Convert.ToBoolean(ret);
            }
        }

        public bool PoucoPapel
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetPoucoPapel);
            }
        }

        public EstadoECF Estado
        {
            get
            {
                return (EstadoECF)GetInt32(ACBrDll.ECF_GetEstado);
            }
        }

        public bool HorarioVerao
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetHorarioVerao);
            }
        }

        public bool Arredonda
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetArredonda);
            }
        }

        public bool Termica
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetTermica);
            }
        }

        public bool MFD
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetMFD);
            }
        }

        public bool IdentificaConsumidorRodape
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetIdentificaConsumidorRodape);
            }
        }

        public decimal SubTotal
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetSubTotal);
            }
        }

        public decimal TotalPago
        {
            get
            {
                return GetDecimal(ACBrDll.ECF_GetTotalPago);
            }
        }

        public bool GavetaAberta
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetGavetaAberta);
            }
        }

        public bool ChequePronto
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetChequePronto);
            }
        }

        public int IntervaloAposComando
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetIntervaloAposComando);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetIntervaloAposComando, value);
            }
        }

        public bool DescricaoGrande
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetDescricaoGrande);
            }
            set
            {
                SetBool(ACBrDll.ECF_SetDescricaoGrande, value);
            }
        }

        public bool GavetaSinalInvertido
        {
            get
            {
                return GetBool(ACBrDll.ECF_GetGavetaSinalInvertido);
            }
            set
            {
                SetBool(ACBrDll.ECF_SetGavetaSinalInvertido, value);
            }
        }

        public string Operador
        {
            get
            {
                return GetString(ACBrDll.ECF_GetOperador);
            }
            set
            {
                SetString(ACBrDll.ECF_SetOperador, value);
            }
        }

        public int LinhasEntreCupons
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetLinhasEntreCupons);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetLinhasEntreCupons, value);
            }
        }

        public int DecimaisPreco
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetDecimaisPreco);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetDecimaisPreco, value);
            }
        }

        public int DecimaisQtd
        {
            get
            {
                return GetInt32(ACBrDll.ECF_GetDecimaisQtd);
            }
            set
            {
                SetInt32(ACBrDll.ECF_SetDecimaisQtd, value);
            }
        }

        public ACBrECFAliquota[] Aliquotas
        {
            get
            {
                if (aliquotas == null) this.CarregaAliquotas();
                return (ACBrECFAliquota[])aliquotas.Clone();
            }
        }

        public ACBrECFFormaPagamento[] FormasPagamento
        {
            get
            {
                if (formasPagamento == null) CarregaFormasPagamento();
                return (ACBrECFFormaPagamento[])formasPagamento;
            }
        }

        public ACBrECFComprovanteNaoFiscal[] ComprovantesNaoFiscais
        {
            get
            {
                if (comprovantesNaoFiscais == null) CarregaComprovantesNaoFiscais();
                return (ACBrECFComprovanteNaoFiscal[])comprovantesNaoFiscais;
            }
        }

        #endregion Properties

        #region Methods

        #region Métodos Ativar/Desativar

        public void Ativar()
        {
            int ret = ACBrDll.ECF_Ativar(this.handle);
            CheckResult(ret);
        }

        public void Desativar()
        {
            int ret = ACBrDll.ECF_Desativar(this.handle);
            CheckResult(ret);
        }

        #endregion Métodos Ativar/Desativar

        #region Métodos do Cupom Fiscal

        public void IdentificaConsumidor(string cpfCnpj, string nome, string endereco)
        {
            int ret = ACBrDll.ECF_IdentificaConsumidor(this.handle, cpfCnpj, nome, endereco);
            CheckResult(ret);
        }

        public void AbreCupom(string cpfCnpj, string nome, string endereco)
        {
            int ret = ACBrDll.ECF_AbreCupom(this.handle, cpfCnpj, nome, endereco);
            CheckResult(ret);
        }

        public void LegendaInmetroProximoItem()
        {
            int ret = ACBrDll.ECF_LegendaInmetroProximoItem(this.handle);
            CheckResult(ret);
        }

        public void VendeItem(string codigo, string descricao, string aliquotaICMS, decimal qtd, decimal valorUnitario, decimal descontoPorc, string unidade, string tipoDescontoAcrescimo, string descontoAcrescimo)
        {
            int ret = ACBrDll.ECF_VendeItem(this.handle, codigo, descricao, aliquotaICMS, (double)qtd, (double)valorUnitario, (double)descontoPorc, unidade, tipoDescontoAcrescimo, descontoAcrescimo);
            CheckResult(ret);
        }

        public void DescontoAcrescimoItemAnterior(decimal valorDesconto, string descontoAcrescimo)
        {
            int ret = ACBrDll.ECF_DescontoAcrescimoItemAnterior(this.handle, (double)valorDesconto, descontoAcrescimo);
            CheckResult(ret);
        }

        public void SubtotalizaCupom(decimal descontoAcrescimo, string mensagemRodape)
        {
            int ret = ACBrDll.ECF_SubtotalizaCupom(this.handle, (double)descontoAcrescimo, mensagemRodape);
            CheckResult(ret);
        }

        public void EfetuaPagamento(string codFormaPagto, decimal valor, string observacao, bool imprimeVinculado)
        {
            int ret = ACBrDll.ECF_EfetuaPagamento(this.handle, codFormaPagto, (double)valor, observacao, imprimeVinculado);
            CheckResult(ret);
        }

        public void EstornaPagamento(string codFormaPagtoEstornar, string codFormaPagtoEfetivar, double valor, string observacao)
        {
            int ret = ACBrDll.ECF_EstornaPagamento(this.handle, codFormaPagtoEstornar, codFormaPagtoEfetivar, valor, observacao);
        }

        public void FechaCupom(string observacao)
        {
            int ret = ACBrDll.ECF_FechaCupom(this.handle, observacao);
            CheckResult(ret);
        }

        public void CancelaCupom()
        {
            int ret = ACBrDll.ECF_CancelaCupom(this.handle);
            CheckResult(ret);
        }

        public void CancelaItemVendido(int numItem)
        {
            int ret = ACBrDll.ECF_CancelaItemVendido(this.handle, numItem);
            CheckResult(ret);
        }

        public void CancelaItemVendidoParcial(int numItem, decimal quantidade)
        {
            int ret = ACBrDll.ECF_CancelaItemVendidoParcial(this.handle, numItem, (double)quantidade);
            CheckResult(ret);
        }

        public void CancelaDescontoAcrescimoItem(int numItem)
        {
            int ret = ACBrDll.ECF_CancelaDescontoAcrescimoItem(this.handle, numItem);
        }

        public void CancelaDescontoAcrescimoSubTotal(string tipoAcrescimoDesconto)
        {
            int ret = ACBrDll.ECF_CancelaDescontoAcrescimoSubTotal(this.handle, tipoAcrescimoDesconto[0]);
            CheckResult(ret);
        }

        #endregion Métodos do Cupom Fiscal

        #region Relatórios

        public void LeituraX()
        {
            int ret = ACBrDll.ECF_LeituraX(this.handle);
            CheckResult(ret);
        }

        public void ReducaoZ()
        {
            int ret = ACBrDll.ECF_ReducaoZ(this.handle);
            CheckResult(ret);
        }

        public void AbreRelatorioGerencial(int indice)
        {
            int ret = ACBrDll.ECF_AbreRelatorioGerencial(this.handle, indice);
            CheckResult(ret);
        }

        public void LinhaRelatorioGerencial(string linha, int indiceBMP)
        {
            int ret = ACBrDll.ECF_LinhaRelatorioGerencial(this.handle, linha, indiceBMP);
            CheckResult(ret);
        }

        public void AbreCupomVinculado(string coo, string codFormaPagto, decimal valor)
        {
            int ret = ACBrDll.ECF_AbreCupomVinculado(this.handle, coo, codFormaPagto, (double)valor);
            CheckResult(ret);
        }

        public void AbreCupomVinculado(string coo, string codFormaPagto, string codComprovanteNaoFiscal, decimal valor)
        {
            int ret = ACBrDll.ECF_AbreCupomVinculadoCNF(this.handle, coo, codFormaPagto, codComprovanteNaoFiscal, (double)valor);
            CheckResult(ret);
        }

        public void LinhaCupomVinculado(string linha)
        {
            int ret = ACBrDll.ECF_LinhaCupomVinculado(this.handle, linha);
            CheckResult(ret);
        }

        public void FechaRelatorio()
        {
            int ret = ACBrDll.ECF_FechaRelatorio(this.handle);
            CheckResult(ret);
        }

        public void PulaLinhas(int numLinhas)
        {
            int ret = ACBrDll.ECF_PulaLinhas(this.handle, numLinhas);
            CheckResult(ret);
        }

        public void CortaPapel(bool corteParcial)
        {
            int ret = ACBrDll.ECF_CortaPapel(this.handle, corteParcial);
            CheckResult(ret);
        }

        #endregion Relatórios

        #region Alíquotas

        public void CarregaAliquotas()
        {
            int count = ACBrDll.ECF_CarregaAliquotas(this.handle);
            CheckResult(count);

            CarregaAliquotas(count);
        }

        private void CarregaAliquotas(int count)
        {
            aliquotas = new ACBrECFAliquota[count];

            for (int i = 0; i < count; i++)
            {
                var record = new ACBrDll.AliquotaRec();
                int ret = ACBrDll.ECF_GetAliquota(this.handle, ref record, i);
                CheckResult(ret);

                ACBrECFAliquota aliquota = new ACBrECFAliquota();
                aliquota.Indice = String.Copy(record.Indice);
                aliquota.Aliquota = Convert.ToDecimal(record.Aliquota);
                aliquota.Sequencia = record.Sequencia;
                aliquota.Tipo = record.Tipo.ToString();
                aliquota.Total = Convert.ToDecimal(record.Total);

                aliquotas[i] = aliquota;
            }
        }

        public void LerTotaisAliquota()
        {
            int count = ACBrDll.ECF_LerTotaisAliquota(this.handle);
            CheckResult(count);

            CarregaAliquotas(count);
        }

        public void ProgramaAliquota(decimal aliquota, string tipo)
        {
            ProgramaAliquota(aliquota, tipo, string.Empty);
        }

        public void ProgramaAliquota(decimal aliquota, string tipo, string posicao)
        {
            if (string.IsNullOrEmpty(tipo)) throw new ArgumentException();

            int ret = ACBrDll.ECF_ProgramaAliquota(this.handle, (double)aliquota, tipo[0], posicao);
            CheckResult(ret);
        }

        #endregion Alíquotas

        #region Formas de Pagto

        public void CarregaFormasPagamento()
        {
            int count = ACBrDll.ECF_CarregaFormasPagamento(this.handle);
            CheckResult(count);

            CarregaFormasPagamento(count);
        }

        private void CarregaFormasPagamento(int count)
        {
            formasPagamento = new ACBrECFFormaPagamento[count];
            for (int i = 0; i < count; i++)
            {
                var record = new ACBrDll.FormaPagamentoRec();
                int ret = ACBrDll.ECF_GetFormaPagamento(this.handle, ref record, i);
                CheckResult(ret);

                ACBrECFFormaPagamento formaPagamento = new ACBrECFFormaPagamento();
                formaPagamento.Indice = String.Copy(record.Indice);
                formaPagamento.Descricao = String.Copy(record.Descricao);
                formaPagamento.PermiteVinculado = record.PermiteVinculado;
                formaPagamento.Total = Convert.ToDecimal(record.Total);

                formasPagamento[i] = formaPagamento;
            }
        }

        public void LerTotaisFormaPagamento()
        {
            int count = ACBrDll.ECF_LerTotaisFormaPagamento(this.handle);
            CheckResult(count);

            CarregaFormasPagamento(count);
        }

        public void ProgramaFormaPagamento(string descricao, bool permiteVinculado)
        {
            ProgramaFormaPagamento(descricao, permiteVinculado, string.Empty);
        }

        public void ProgramaFormaPagamento(string descricao, bool permiteVinculado, string posicao)
        {
            int ret = ACBrDll.ECF_ProgramaFormaPagamento(this.handle, descricao, permiteVinculado, posicao);
            CheckResult(ret);
        }

        #endregion Formas de Pagto

        #region Comprovantes Não Fiscal

        public void CarregaComprovantesNaoFiscais()
        {
            int count = ACBrDll.ECF_CarregaComprovantesNaoFiscais(this.handle);
            CheckResult(count);

            CarregaComprovantesNaoFiscais(count);
        }

        private void CarregaComprovantesNaoFiscais(int count)
        {
            comprovantesNaoFiscais = new ACBrECFComprovanteNaoFiscal[count];
            for (int i = 0; i < count; i++)
            {
                var record = new ACBrDll.ComprovanteNaoFiscalRec();
                int ret = ACBrDll.ECF_GetComprovanteNaoFiscal(this.handle, ref record, i);
                CheckResult(ret);

                ACBrECFComprovanteNaoFiscal comprovanteNaoFiscal = new ACBrECFComprovanteNaoFiscal();
                comprovanteNaoFiscal.Indice = String.Copy(record.Indice);
                comprovanteNaoFiscal.Descricao = String.Copy(record.Descricao);
                comprovanteNaoFiscal.PermiteVinculado = record.PermiteVinculado;
                comprovanteNaoFiscal.FormaPagamento = String.Copy(record.FormaPagamento);
                comprovanteNaoFiscal.Total = Convert.ToDecimal(record.Total);
                comprovanteNaoFiscal.Contador = record.Contador;

                comprovantesNaoFiscais[i] = comprovanteNaoFiscal;
            }
        }

        public void LerTotaisComprovanteNaoFiscal()
        {
            int count = ACBrDll.ECF_LerTotaisComprovanteNaoFiscal(this.handle);
            CheckResult(count);

            CarregaComprovantesNaoFiscais(count);
        }

        public void ProgramaComprovanteNaoFiscal(string descricao, string tipo)
        {
            ProgramaComprovanteNaoFiscal(descricao, tipo, string.Empty);
        }

        public void ProgramaComprovanteNaoFiscal(string descricao, string tipo, string posicao)
        {
            if (string.IsNullOrEmpty(tipo)) throw new ArgumentException();

            int ret = ACBrDll.ECF_ProgramaComprovanteNaoFiscal(this.handle, descricao, tipo, posicao);
            CheckResult(ret);
        }

        #endregion Comprovantes Não Fiscal

        public void Suprimento(decimal valor, string obs)
        {
            int ret = ACBrDll.ECF_Suprimento(this.handle, (double)valor, obs);
            CheckResult(ret);
        }

        public void Sangria(decimal valor, string obs)
        {
            int ret = ACBrDll.ECF_Sangria(this.handle, (double)valor, obs);
            CheckResult(ret);
        }

        public void AbreGaveta()
        {
            int ret = ACBrDll.ECF_AbreGaveta(this.handle);
            CheckResult(ret);
        }

        #region Override Methods

        protected override void CheckResult(int ret)
        {
            switch (ret)
            {
                case -1:

                    string error = GetString(ACBrDll.ECF_GetUltimoErro);
                    throw new ACBrECFException(error);

                case -2:

                    throw new ACBrECFException("ACBr ECF não inicializado.");

            }
        }

        protected override void Dispose(bool disposing)
        {
            if (this.handle != IntPtr.Zero)
            {
                ACBrDll.ECF_Destroy(ref this.handle);
                this.handle = IntPtr.Zero;
            }

            if (disposing)
            {
                GC.SuppressFinalize(this);
            }
        }

        #endregion Override Methods

        #endregion Methods
    }
}
