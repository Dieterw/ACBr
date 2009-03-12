{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}
unit ACBrNFeValoresTotais;

interface

uses
  Classes;

type

  TValoresTotais = class(TPersistent)
  private
    FBaseICMS:Double;
    FValorICMS:Double;
    FBaseICMSSubstituicao:Double;
    FValorICMSSubstituicao:Double;
    FValorProduto:Double;
    FValorFrete:Double;
    FValorSeguro:Double;
    FValorDesconto:Double;
    FValorII:Double;
    FValorIPI:Double;
    FValorPIS:Double;
    FValorCOFINS:Double;
    FValorOutrasDespesas:Double;
    FValorNota:Double;
  published
    property BaseICMS: Double read FBaseICMS write FBaseICMS;
    property ValorICMS: Double read FValorICMS write FValorICMS;
    property BaseICMSSubstituicao: Double read FBaseICMSSubstituicao write FBaseICMSSubstituicao;
    property ValorICMSSubstituicao: Double read FValorICMSSubstituicao write FValorICMSSubstituicao;
    property ValorProduto: Double read FValorProduto write FValorProduto;
    property ValorFrete: Double read FValorFrete write FValorFrete;
    property ValorSeguro: Double read FValorSeguro write FValorSeguro;
    property ValorDesconto: Double read FValorDesconto write FValorDesconto;
    property ValorII: Double read FValorII write FValorII;
    property ValorIPI: Double read FValorIPI write FValorIPI;
    property ValorPIS: Double read FValorPIS write FValorPIS;
    property ValorCOFINS: Double read FValorCOFINS write FValorCOFINS;
    property ValorOutrasDespesas: Double read FValorOutrasDespesas write FValorOutrasDespesas;
    property ValorNota: Double read FValorNota write FValorNota;
  end;


implementation

end.
