unit UnitDeclaracoesEpson;

interface

const
{$IFDEF LINUX}
 cLIB_Epson = 'libInterfaceEpson.so';
{$ELSE}
 cLIB_Epson = 'InterfaceEpson.dll';
{$ENDIF}

//=================================================================================================
// EPSON_Serial
//=================================================================================================
function EPSON_Serial_Abrir_Porta(dwVelocidade:Integer; wPorta:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Serial_Abrir_PortaEx():Integer;StdCall; External cLIB_Epson;
function EPSON_Serial_Fechar_Porta ():Integer;StdCall; External cLIB_Epson;
function EPSON_Serial_Obter_Estado_Com():Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Fiscal
//=================================================================================================
function EPSON_Fiscal_Abrir_Cupom(pszCNPJ:PChar; pszRazaoSocial:PChar; pszEndereco1:PChar; pszEndereco2:PChar; dwPosicao:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Dados_Usuario(pszCGC:PChar; pszSocialReason:PChar; pszAddress1:PChar; pszAddress2:PChar; dwPosition:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Vender_Item(pszCodigo:PChar; pszDescricao:PChar; pszQuantidade:PChar; dwQuantCasasDecimais:Integer; pszUnidade:PChar; pszPrecoUnidade:PChar; dwPrecoCasasDecimais:Integer; pszAliquotas:PChar; dwLinhas:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Obter_SubTotal(pszSubTotal:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Pagamento(pszNumeroPagamento:PChar; pszValorPagamento:PChar; dwCasasDecimais:Integer; pszDescricao1:PChar; pszDescricao2:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Desconto_Acrescimo_Item(pszValor:PChar; dwCasasDecimais:Integer; bDesconto:Boolean; bPercentagem:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Desconto_Acrescimo_Subtotal(pszValor:PChar; dwCasasDecimais:Integer; bDesconto:Boolean; bPercentagem:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Cancelar_Cupom():Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Cancelar_Item(pszNumeroItem:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Cancelar_Ultimo_Item():Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Cancelar_Desconto_Acrescimo_Item(bDesconto:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Cancelar_Acrescimo_Desconto_Subtotal(bDesconto:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Cancelar_Item_Parcial(pszNumeroItem:PChar; pszQuantidade:PChar; dwQuantCasasDecimais:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Imprimir_Mensagem(pszLinhaTexto1:PChar; pszLinhaTexto2:PChar; pszLinhaTexto3:PChar; pszLinhaTexto4:PChar; pszLinhaTexto5:PChar; pszLinhaTexto6:PChar; pszLinhaTexto7:PChar; pszLinhaTexto8:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Configurar_Codigo_Barras_Mensagem(dwLinha:Integer; dwTipo:Integer; dwAltura:Integer; dwLargura:Integer; dwPosicao:Integer; dwCaracter:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Fechar_CupomEx(pszTotalCupom:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Fechar_Cupom(bCortarPapel:Boolean; bAdicional:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Fiscal_Mensagem_Aplicacao(pszLinha01:PChar; pszLinha02:PChar):Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_NaoFiscal
//=================================================================================================
function EPSON_NaoFiscal_Abrir_Comprovante(pszCNPJ:PChar; pszRazaoSocial:PChar; pszEndereco1:PChar; pszEndereco2:PChar; dwPosicao:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Vender_Item(pszNumeroOperacao:PChar; pszValorOperacao:PChar; dwCasasDecimais:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Obter_SubTotal(pszSubTotal:PChar):Integer;StdCall;External cLIB_Epson;
function EPSON_NaoFiscal_Desconto_Acrescimo_Item(pszValor:PChar; dwCasasDecimais:Integer; bDesconto:Boolean; bPercentagem:Boolean):Integer;StdCall;External cLIB_Epson;
function EPSON_NaoFiscal_Desconto_Acrescimo_Subtotal(pszValor:PChar; dwCasasDecimais:Integer; bDesconto:Boolean; bPercentagem:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Pagamento(pszNumeroPagamento:PChar; pszValorPagamento:PChar; dwCasasDecimais:Integer; pszDescricao1:PChar; pszDescricao2:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_Item(pszItem:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_Ultimo_Item():Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_Item(bDesconto:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_Desconto_Acrescimo_Subtotal(bDesconto:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_Comprovante():Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Fechar_Comprovante(bCortarPapel:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Abrir_CCD(pszNumeroPagamento:PChar; pszValor:PChar; dwCasasDecimais:Integer; pszParcelas:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Abrir_Relatorio_Gerencial(pszNumeroRelatorio:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Imprimir_Linha(pszLinha:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Fechar_CCD(bCortarPapel:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Fechar_Relatorio_Gerencial(bCortarPapel:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_CCD(pszNumeroPagamento:PChar; pszValor:PChar; dwCasasDecimais:Integer; pszParcelas:PChar; pszNumeroCupom:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Cancelar_Pagamento(pszFormaPagamento:PChar; pszNovaFormaPagamento:PChar; pszValor:PChar; dwCasasDecimais:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Nova_Parcela_CCD():Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Nova_Via_CCD():Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Reimprimir_CCD():Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Sangria(pszValor:PChar; dwCasasDecimais:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Fundo_Troco(pszValor:PChar; dwCasasDecimais:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_NaoFiscal_Imprimir_Codigo_Barras(dwTipo:Integer; dwAltura:Integer; dwLargura:Integer; dwPosicao:Integer; dwCaracter:Integer; pszCodigo:PChar):Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_RelatorioFiscal
//=================================================================================================
function EPSON_RelatorioFiscal_LeituraX():Integer;StdCall; External cLIB_Epson;
function EPSON_RelatorioFiscal_RZ(pszData:PChar; pszHora:PChar; dwHorarioVerao:Integer; pszCRZ:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_RelatorioFiscal_Leitura_MF(pszInicio:PChar; pszFim:PChar; dwTipoImpressao:Integer; pszBuffer:PChar; pszArquivo:PChar; pdwTamanhoBuffer:PInteger; dwTamBuffer:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_RelatorioFiscal_Salvar_LeituraX(pszArquivo:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_RelatorioFiscal_Abrir_Dia():Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Obter
//=================================================================================================
function EPSON_Obter_Dados_Usuario(pszDadosUsuario:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Tabela_Aliquotas(pszTabelaAliquotas:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Jornada(chOption:PChar; pszZnumber:PChar; pszData:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Tabela_Pagamentos(pszTabelaPagamentos:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Tabela_NaoFiscais(pszTabelaNaoFiscais:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Tabela_Relatorios_Gerenciais(pszTabelaRelatoriosGerenciais:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Cancelado(pszTotalCancelado:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Aliquotas(pszAliquotasTotal:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Bruto(pszVendaBruta:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Descontos(pszTotalDescontos:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Acrescimos(pszTotalAcrescimos:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Dados_Impressora(pszDadosImpressora:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Cliche_Usuario(pszDadosUsuario:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Data_Hora_Jornada(pszDataHora:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Numero_ECF_Loja(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Hora_Relogio(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Simbolo_Moeda(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Casas_Decimais(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Contadores(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Estado_Impressora(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_GT(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Linhas_Impressas(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Linhas_Impressas_RG(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Linhas_Impressas_CCD(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Linhas_Impressas_Vendas(pszLinhasImpressas:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Linhas_Impressas_Pagamentos(pszLinhasImpressas:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Itens_Vendidos(pszItens:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Estado_Memoria_Fiscal(pszEstado:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Estado_MFD(pszEstado:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Total_Leituras_X_Impressas(pszLeituras:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Dados_Jornada(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Caracteres_Linha(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Operador(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Numero_Ultimo_Item(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Informacao_Item(pszNumeroItem:PChar; pszDadosItem:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Estado_Cupom(pszEstado:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Informacao_Ultimo_Documento(pszInfo:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Estado_Corte_Papel(Var bHabilitado:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Estado_Horario_Verao(Var bEstado:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Versao_DLL(pszVersao:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Mensagem_Erro(pszCodigoErro:PChar; pszMensagemErro:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Venda_Bruta(pszBrutAmount:PChar; pszLastBrutAmount:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Obter_Dados_MF_MFD(pszInicio:PChar; pszFinal:PChar; dwTipoEntrada:Integer; dwEspelhos:Integer; dwAtoCotepe:Integer; dwSintegra:Integer; pszArquivoSaida:PChar):Integer;StdCall; External cLIB_Epson;
//function EPSON_Obter_Dados_Arquivos_MF_MFD():Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Config
//=================================================================================================
function EPSON_Config_Aliquota(pszTaxa:PChar; bTipoISS:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Relatorio_Gerencial(pszReportDescription:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Forma_Pagamento(bVinculado:Boolean; pszNumeroMeio:PChar; pszDescricao:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Totalizador_NaoFiscal(pszDescricao:PChar; Var pdwNumeroTotalizador:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Corte_Papel(bHabilitado:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Horario_Verao():Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Espaco_Entre_Documentos(pszLinhas:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Espaco_Entre_Linhas(pszEspacos:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Logotipo(pszDados:PChar; dwTamDados:Integer; pszLinha:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Habilita_Logotipo(bHabilita:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Operador(pszDados:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_OperadorEX(pszDados:PChar; dwReport:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Serial_Impressora(pszVelocidade:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Config_Dados_Sintegra(pszRazaoSocial:PChar; pszLogradouro:PChar; pszNumero:PChar; pszComplemento:PChar; pszBairro:PChar; pszMunicipio:PChar; pszCEP:PChar; pszUF:PChar; pszFax:PChar; pszFone:PChar; pszNomeContato:PChar):Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Cheque
//=================================================================================================
function EPSON_Cheque_Configurar_Moeda(pszSingular:PChar; pszPlural:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Configurar_Parametros1(pszNumeroRegistro:PChar; pszValorX:PChar; pszValorY:PChar; pszDescricao1X:PChar; pszDescricao1Y:PChar; pszDescricao2X:PChar; pszDescricao2Y:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Configurar_Parametros2(pszNumeroRegistro:PChar; pszParaX:PChar; pszParaY:PChar; pszCidadeX:PChar; pszCidadeY:PChar; pszOffsetDia:PChar; pszOffsetMes:PChar; pszOffsetAno:PChar; pszAdicionalX:PChar; pszAdicionalY:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Imprimir(pszNumeroRegistro:PChar; pszValor:PChar; dwCasasDecimais:Integer; ByValpszPara:PChar; pszCidade:PChar; pszDados:PChar; pszTexto:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_ImprimirEX(pszNumeroRegistro:PChar; pszValor:PChar; dwCasasDecimais:Integer; pszPara:PChar; pszCidade:PChar; pszDados:PChar; pszTexto:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Preparar_Endosso():Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Imprimir_Endosso(pszLinhaTexto:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Ejetar_Endosso():Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Cancelar_Impressao():Integer;StdCall; External cLIB_Epson;
function EPSON_Cheque_Ler_MICR(pszMICR:PChar):Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Impressora
//=================================================================================================
function EPSON_Impressora_Abrir_Gaveta():Integer;StdCall; External cLIB_Epson;
function EPSON_Impressora_Avancar_Papel(dwLines:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Impressora_Cortar_Papel():Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Autenticar
//=================================================================================================
function EPSON_Autenticar_Imprimir(pszMensagem:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Autenticar_Reimprimir():Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Sys
//=================================================================================================
//function EPSON_Sys_Informar_Handle_Janela( hwndEdit:HWND ):Integer;StdCall; External cLIB_Epson;
function EPSON_Sys_Atualizar_Janela():Integer;StdCall; External cLIB_Epson;
function EPSON_Sys_Aguardar_Arquivo(pszArquivo:PChar; dwTimeout:Integer; bBloqueiaEntradas:Boolean; bSincrono:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Sys_Bloquear_Entradas(bBloqueiaEntradas:Boolean):Integer;StdCall; External cLIB_Epson;
function EPSON_Sys_Log(pszPath:PChar; dwAction:Integer):Integer;StdCall; External cLIB_Epson;
//=================================================================================================
// EPSON_Display
//=================================================================================================
function EPSON_Display_Enviar_Texto(pszTexto:PChar):Integer;StdCall; External cLIB_Epson;
function EPSON_Display_Set_Cursor(dwAcao:Integer; dwColuna:Integer; dwLinha:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Display_Apagar_Texto(dwLinha:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Display_Configurar(dwBrilho:Integer; dwLampejo:Integer; dwRolagem:Integer):Integer;StdCall; External cLIB_Epson;
function EPSON_Display_Inicializar(dwAcao:Integer):Integer;StdCall; External cLIB_Epson;
//=================================================================================================

implementation

end.
