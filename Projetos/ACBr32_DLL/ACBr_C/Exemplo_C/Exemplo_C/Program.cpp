#include <stdio.h>
#include <stdlib.h>
#include "ACBr.h"

void CheckResult(int ret);

ACBR_HANDLE ecfHANDLE;

int main()
{
	int ret, i;
	FormaPagamentoRec formaPagto;
	PCHAR buff = (PCHAR)malloc(100);
	PCHAR porta = (PCHAR)malloc(20);
	PCHAR modelo = (PCHAR)malloc(20);

	printf("ACBR32.dll - Teste em C/C++\n\n");

	printf("SELECIONE O MODELO DE ECF:\n");
	printf("  1. NaoFiscal\n");
	printf("  2. Bematech\n");
	printf("  3. Sweda\n");
	printf("  4. Daruma\n");
	printf("  5. Schalter\n");
	printf("  6. Mecaf\n");
	printf("  7. Yanco\n");
	printf("  8. DataRegis\n");
	printf("  9. Urano\n");
	printf(" 10. ICash\n");
	printf(" 11. Quattro\n");
	printf(" 12. FiscNET\n");
	printf(" 13. Epson\n");
	printf(" 14. NCR\n");
	printf(" 15. SwedaSTX\n");
	
	printf("\nENTRE COM O ECF: ");
	gets(modelo);
	
	printf("\nENTRE COM A PORTA: ");
	gets(porta);

	printf("\nCriando componente ...\n");
	ret = ECF_Create(&ecfHANDLE);
	CheckResult(ret);

	printf("SetModelo\n");
	ret = ECF_SetModelo(ecfHANDLE, atoi(modelo));
	CheckResult(ret);

	printf("GetModeloStr");
	ret = ECF_GetModeloStr(ecfHANDLE, buff, 100);
	CheckResult(ret);
	printf(": %s\n", buff);

	printf("SetPorta\n");
	ret = ECF_SetPorta(ecfHANDLE, porta);
	CheckResult(ret);

	printf("GetPorta");
	ret = ECF_GetPorta(ecfHANDLE, buff, 100);
	CheckResult(ret);
	printf(": %s\n", buff);

	printf("GetAtivo");
	ret = ECF_GetAtivo(ecfHANDLE);
	CheckResult(ret);
	printf(": %i\n", ret);

	printf("Ativar\n");
	ECF_Ativar(ecfHANDLE);
	CheckResult(ret);

	printf("GetAtivo");
	ret = ECF_GetAtivo(ecfHANDLE);
	CheckResult(ret);
	printf(": %i\n", ret);

	printf("\nLeituraX\n");
	ret = ECF_LeituraX(ecfHANDLE);
	CheckResult(ret);

	printf("\nCarrega Formas de Pagamento\n");
	ret = ECF_CarregaFormasPagamento(ecfHANDLE);
	CheckResult(ret);

	printf("Formas de pagamento\n");

	for (i=0; i<ret; i++)
	{
		ret = ECF_GetFormaPagamento(ecfHANDLE, &formaPagto, i);
		CheckResult(ret);

		printf(" - %s %s\n", formaPagto.Indice, formaPagto.Descricao);
	}

	

	printf("\nTesta cupom fiscal\n");
	ret = ECF_AbreCupom(ecfHANDLE, "", "", "");
	CheckResult(ret);

	
	for (i=0; i<10; i++)
	{
		printf("Vende item %i\n", i + 1);
		ret = ECF_VendeItem(ecfHANDLE, "0001", "PRODUTO", "I", 1, 0.01, 0, "UN", "D", "$");
		CheckResult(ret);
	}

	printf("Subtotaliza\n");
	ret = ECF_SubtotalizaCupom(ecfHANDLE, 0, "MENSAGEM SUBTOTALIZA");
	CheckResult(ret);

	printf("Efetua Pagamento\n");
	ret = ECF_EfetuaPagamento(ecfHANDLE, formaPagto.Indice, 1, "MENSAGEM FORMA DE PAGTO", 0);
	CheckResult(ret);

	printf("Fecha cupom\n");
	ret = ECF_FechaCupom(ecfHANDLE, "MENSAGEM FECHAMENTO");
	CheckResult(ret);

	ret = ECF_Destroy(&ecfHANDLE);
	ecfHANDLE = 0;

	free(buff);

	printf("Finalizado\n");
	getchar();
}

void CheckResult(int ret)
{
	if (ret < 0)
	{
		PCHAR buff = malloc(100);
		ECF_GetUltimoErro(ecfHANDLE, buff, 100);
		printf("ERRO: ");
		printf(buff);
		printf("\n");
		free(buff);
	}
}