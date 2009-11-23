{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007 Andrews Ricardo Bejatto                }
{                                       Anderson Rogerio Bejatto               }
{                                                                              }
{ Colaboradores nesse arquivo:          Daniel Simooes de Almeida              }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 27/03/2007: Andrews R Bejatto/ Anderson R Bejatto/ Daniel Simões de Almeida
|*  - Primeira versao ACBrETQPpla
|* 17/04/2009: Alexsander da Rosa
|*  - Parametro "SubFonte" na procedure ImprimirTexto
******************************************************************************}

{$I ACBr.inc}

unit ACBrETQPpla;

interface
uses ACBrETQClass, ACBrUtil, ACBrDevice
     {$IFDEF VisualCLX}, QGraphics {$ELSE}, Graphics {$ENDIF}
     ,Classes ;

const
   STX : String = chr(002);

type
  TACBrETQPpla = class( TACBrETQClass )
  public
    constructor Create(AOwner: TComponent);

    procedure ImprimirTexto(Orientacao: TACBrETQOrientacao; Fonte: Integer;
      MultiplicadorH, MultiplicadorV: Char; Vertical, Horizontal: Integer;
      Texto: String; SubFonte: Integer = 0); override;
    procedure ImprimirBarras(Orientacao: TACBrETQOrientacao; TipoBarras,
      LarguraBarraLarga, LarguraBarraFina: Char; Vertical, Horizontal: Integer;
      Texto: String; AlturaCodBarras: Integer = 0); override;
    procedure ImprimirLinha(Vertical, Horizontal, Largura, Altura: Integer); override;
    procedure ImprimirCaixa(Vertical, Horizontal, Largura, Altura,
      EspessuraVertical, EspessuraHorizontal: Integer); override;
    procedure ImprimirImagem(MultiplicadorImagem, Linha, Coluna: Integer; NomeImagem: String); override;
    procedure CarregarImagem(MonoBMP : TBitmap; NomeImagem: String; Flipped : Boolean); override;
    procedure Imprimir(Copias: Integer = 1; AvancoEtq: Integer = 0; LimparMemoria: Boolean = True); override;

  end ;

implementation
Uses ACBrETQ,
     {$IFDEF COMPILER6_UP} StrUtils {$ELSE} ACBrD5, Windows{$ENDIF},
     SysUtils ;

{ TACBrETQPpla }

constructor TACBrETQPpla.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  fpModeloStr := 'PPLA';
  Temperatura := 10;
end;

procedure TACBrETQPpla.Imprimir(Copias: Integer = 1; AvancoEtq: Integer = 0;
   LimparMemoria: Boolean = True);
var
   Temp, NCop : String;
begin
  Cmd := '';

  if (Temperatura < 0) or (Temperatura > 20) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 20 para Temperatura'));
  Temp := IntToStrZero(Temperatura,2);

  if (Copias < 0) or (Copias > 9999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para o Número de Cópias 4 caracteres'));
  NCop := IntToStrZero(Copias,4);

  Cmd := STX + 'L' + CRLF + STX + 'm' + CRLF + 'H' + Temp + CRLF + 'D11' + CRLF +
         'Q' + NCop;

  {Inserindo comando iniciais na posicao Zero}
  ListaCmd.Insert(0, Cmd);

  Cmd := '';
  if AvancoEtq = 0 then
     AvancoEtq := Avanco;
  if (AvancoEtq < 0) or (AvancoEtq > 779) then
     Raise Exception.Create(ACBrStr('O Valor máximo para o Avanço de Etiquetas é 779'));

  AvancoEtq := AvancoEtq + 220;

  Cmd := 'E' + CRLF + STX + 'f' + IntToStr(AvancoEtq) + CRLF ;

  if LimparMemoria then
    Cmd := Cmd + STX + 'Q' ;

  ListaCmd.Add(Cmd);

  fpDevice.EnviaString(ListaCmd.GetText);
  ListaCmd.Clear;
end;

procedure TACBrETQPpla.ImprimirBarras(Orientacao: TACBrETQOrientacao; TipoBarras,
  LarguraBarraLarga, LarguraBarraFina: Char; Vertical, Horizontal: Integer;
  Texto: String; AlturaCodBarras: Integer);
var
   eixoY, eixoX, LCodBarras: String;
begin
  Cmd := '';

  if ((Integer(Orientacao) + 1) < 1) or ((Integer(Orientacao) + 1) > 4) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 1 e 4 para Orientação'));

{Tipo de Código de Barras - vai de 'a' até 't' e de 'A' até 'T'
 Largura da Barra Larga, Largura da Barra Fina - De 0 a 9 e de 'A' até 'O'}

  if (Vertical < 0) or (Vertical > 999) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 762 para Vertical'));
  eixoY := IntToStrZero(Vertical,4);

  if (Horizontal < 0) or (Horizontal > 999) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 762 para Horizontal'));
  eixoX := IntToStrZero(Horizontal,4);

  if (AlturaCodBarras < 0) or (AlturaCodBarras > 999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Altura do Código de Barras 3 caracteres'));
  LCodBarras := IntToStrZero(AlturaCodBarras,3);

  Cmd:= IntToStr(Integer(Orientacao) + 1) + TipoBarras + LarguraBarraLarga +
        LarguraBarraFina + LCodBarras + eixoY + eixoX + Texto;

  ListaCmd.Add(Cmd);
end;

procedure TACBrETQPpla.ImprimirCaixa(Vertical, Horizontal, Largura, Altura,
  EspessuraVertical, EspessuraHorizontal: Integer);
var
   eixoY, eixoX, Larg, Alt, EspH, EspV: String;
begin
  Cmd := '';

  if (Vertical < 0) or (Vertical > 999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para Vertical 4 caracteres'));
  eixoY := padR(IntToStr(Vertical),4,'0');

  if (Horizontal < 0) or (Horizontal > 999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para Horizontal 4 caracteres'));
  eixoX := padR(IntToStr(Horizontal),4,'0');

  if (Largura < 0) or (Largura > 9999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Largura da Linha 4 caracteres'));
  Larg := padR(IntToStr(Largura),3,'0');

  if (Altura < 0) or (Altura > 9999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Largura da Linha 4 caracteres'));
  Alt := padR(IntToStr(Altura),3,'0');

  if (EspessuraHorizontal < 0) or (EspessuraHorizontal > 9999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Espessura das Linhas Horizontais 4 caracteres'));
  EspH := padR(IntToStr(EspessuraHorizontal),3,'0');

  if (EspessuraVertical < 0) or (EspessuraVertical > 9999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Espessura das Linhas Verticais 4 caracteres'));
  EspV := padR(IntToStr(EspessuraVertical),3,'0');

  Cmd := STX + 'n' + CRLF + '1X11000' + eixoY + eixoX + 'B' + Larg + Alt +
         EspH + EspV + CRLF + STX + 'm';

  ListaCmd.Add(Cmd);
end;

procedure TACBrETQPpla.ImprimirLinha(Vertical, Horizontal, Largura,
  Altura: Integer);
var
   eixoY, eixoX, Larg, Alt: String;
begin
  Cmd := '';

  if (Vertical < 0) or (Vertical > 999) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 762 para Vertical'));
  eixoY := padR(IntToStr(Vertical), 4, '0');

  if (Horizontal < 0) or (Horizontal > 999) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 762 para Horizontal'));
  eixoX := padR(IntToStr(Horizontal), 4, '0');

  if (Largura < 0) or (Largura > 999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Largura da Linha 3 caracteres'));
  Larg := padR(IntToStr(Largura), 3, '0');

  if (Altura < 0) or (Altura > 999) then
     Raise Exception.Create(ACBrStr('Tamanho máximo para a Altura da Linha 3 caracteres'));
  Alt := padR(IntToStr(Altura), 3, '0');

  Cmd := STX + 'n' + CRLF + '1X11000' + eixoY + eixoX + 'L' + Larg + Alt + CRLF +
         STX + 'm';

  ListaCmd.Add(Cmd);
end;

procedure TACBrETQPpla.ImprimirTexto(Orientacao: TACBrETQOrientacao; Fonte: Integer;
  MultiplicadorH, MultiplicadorV: Char; Vertical, Horizontal: Integer;
  Texto: String; SubFonte: Integer);
var
   eixoY, eixoX, Smooth: String;
begin
  Cmd := '';

  if ((Integer(Orientacao) + 1) < 1) or ((Integer(Orientacao) + 1) > 4) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 1 e 4 para Orientação'));

  if (Fonte < 0) or (Fonte > 9) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 9 para Fonte'));

  if (SubFonte < 0) or (SubFonte > 7) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 7 para SubFonte'));

{ Multiplicador Horizontal, Multiplicador Vertical:
 De 0 a 9 e de A até O representa as escalas de multiplicação (A=10, B=11,..., O=24)}

  if (Vertical < 0) or (Vertical > 1800) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 1800 para Vertical'));
  eixoY := padR(IntToStr(Vertical), 4, '0');

  if (Horizontal < 0) or (Horizontal > 999) then
     Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 762 para Horizontal'));
  eixoX := padR(IntToStr(Horizontal), 4, '0');

  if Length(Texto) > 255 then
     Raise Exception.Create(ACBrStr('Tamanho maximo para o texto 255 caracteres'));

  if Fonte < 9 then
    Smooth := '000'
  else
    Smooth := padR(IntToStr(SubFonte), 3, '0');

  Cmd := IntToStr(Integer(Orientacao) + 1) + IntToStr(Fonte) + MultiplicadorH +
         MultiplicadorV + Smooth + eixoY + eixoX + Texto;

  ListaCmd.Add(Cmd);
end;


procedure TACBrETQPpla.ImprimirImagem(MultiplicadorImagem, Linha,
  Coluna: Integer; NomeImagem: String);
var
  Mul, Lin, Col: String;
begin
  if (MultiplicadorImagem < 0) or (MultiplicadorImagem > 99) then
    Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 99 para MultiplicadorImagem'));
  Mul := padR(IntToStr(MultiplicadorImagem), 2, '0');

  if (Linha < 0) or (Linha > 9999) then
    Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 9999 para Linha'));
  Lin := padR(IntToStr(Linha), 4, '0');

  if (Coluna < 0) or (Coluna > 9999) then
    Raise Exception.Create(ACBrStr('Informe um valor entre 0 e 9999 para Coluna'));
  Col := padR(IntToStr(Coluna), 4, '0');

  NomeImagem := OnlyAlphaNum(UpperCase(LeftStr(Trim(NomeImagem),16))) ;

  Cmd := '1Y' + Mul + '000' + Lin + Col + NomeImagem;

  ListaCmd.Add(Cmd);
end;

//Carrega a imagem na memória RAM da impressora de etiquetas
procedure TACBrETQPpla.CarregarImagem(MonoBMP : TBitmap; NomeImagem: String;
  Flipped : Boolean);
Var
  TipoImagem : Char ;
  MS : TMemoryStream;
  S  : AnsiString ;
begin
  if Flipped then
     TipoImagem := 'B'
  else
     TipoImagem := 'b' ;

  NomeImagem := OnlyAlphaNum(UpperCase(LeftStr(Trim(NomeImagem),16))) ;

  Cmd := STX + 'IA' + TipoImagem + NomeImagem + CRLF ;
  S   := '' ;

  { Lendo em MemoryStream temporário para nao apagar comandos nao processados }
  MS := TMemoryStream.Create;
  try
     MonoBMP.SaveToStream(MS);
     MS.Position := 0 ;
     SetLength(S,MS.Size);
     MS.ReadBuffer(pchar(S)^,MS.Size);
  finally
     MS.Free ;
  end ;

  if Length(S) = 0 then
     raise Exception.Create(ACBrStr('Erro ao ler a Imagem'));

  Cmd := Cmd + S ;

  fpDevice.EnviaString( Cmd );

  ListaCmd.Clear ;
end;


end.
