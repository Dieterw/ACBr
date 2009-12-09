{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFDCliSiTef;

interface

uses
  Classes, SysUtils, ACBrTEFDClass;

Const
{$IFDEF LINUX}
  CLIB_CliSiTefLib = 'clisitef32i.so' ;
{$ELSE}
  CLIB_CliSiTefLib = 'CliSiTef32I.dll' ;
{$ENDIF}

type
   { TACBrTEFDSiTef }

   { TACBrTEFDCliSiTef }

   TACBrTEFDCliSiTef = class( TACBrTEFDClass )
   private
      fCodigoLoja : String;
      fEnderecoIP : String;
      fNumeroTerminal : String;
      fParametrosAdicionais : TStringList;
     xConfiguraIntSiTefInterativoEx : function (
                pEnderecoIP: PChar;
                pCodigoLoja: PChar;
                pNumeroTerminal: PChar;
                ConfiguraResultado: smallint;
                pParametrosAdicionais: PChar): integer; stdcall;

     xIniciaFuncaoSiTefInterativo : function (
                Modalidade: integer;
                pValor: PChar;
                pNumeroCuponFiscal: PChar;
                pDataFiscal: PChar;
                pHorario: PChar;
                pOperador: PChar;
                pRestricoes: PChar ): integer; stdcall;

     xFinalizaTransacaoSiTefInterativo : procedure (
                 smallint: Word;
                 pNumeroCuponFiscal: PChar;
                 pDataFiscal: PChar;
                 pHorario: PChar ); stdcall;

     xContinuaFuncaoSiTefInterativo : function (
                var ProximoComando: Integer;
                var TipoCampo: Integer;
                var TamanhoMinimo: smallint;
                var TamanhoMaximo: smallint;
                pBuffer: PChar;
                TamMaxBuffer: Integer;
                ContinuaNavegacao: Integer ): integer; stdcall;
     procedure LoadDLLFunctions;

   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar ; override;
     procedure DesInicializar ; override;
   published
     property EnderecoIP     : String read fEnderecoIP     write fEnderecoIP ;
     property CodigoLoja     : String read fCodigoLoja     write fCodigoLoja ;
     property NumeroTerminal : String read fNumeroTerminal write fNumeroTerminal ;
     property ParametrosAdicionais : TStringList read fParametrosAdicionais ;
   end;

implementation

Uses ACBrUtil, dateutils;

{ TACBrTEFDClass }

constructor TACBrTEFDCliSiTef.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ArqReq    := '' ;
  ArqResp   := '' ;
  ArqSTS    := '' ;
  ArqTemp   := '' ;
  GPExeName := '' ;
  fpTipo    := gpCliSiTef;
  Name      := 'CliSiTef' ;

  fParametrosAdicionais := TStringList.Create;

  xConfiguraIntSiTefInterativoEx    := nil ;
  xContinuaFuncaoSiTefInterativo    := nil ;
  xFinalizaTransacaoSiTefInterativo := nil ;
  xIniciaFuncaoSiTefInterativo      := nil ;
end;

destructor TACBrTEFDCliSiTef.Destroy;
begin
   fParametrosAdicionais.Free ;

   inherited Destroy;
end;

procedure TACBrTEFDCliSiTef.Inicializar;
Var
  Sts : Integer ;
  ParamAdic : String ;
begin
  if Inicializado then exit ;

  LoadDLLFunctions;

  ParamAdic := StringReplace( ParametrosAdicionais.Text, sLineBreak, ';',
                              [rfReplaceAll] ) ;

  Sts := xConfiguraIntSiTefInterativoEx( PChar(EnderecoIP), PChar(CodigoLoja),
                                      PChar(NumeroTerminal), 0, PChar(ParamAdic) );

  inherited Inicializar;
end;

procedure TACBrTEFDCliSiTef.LoadDLLFunctions ;
 procedure CliSiTefFunctionDetect( FuncName: String; var LibPointer: Pointer ) ;
 begin
   if not Assigned( LibPointer )  then
   begin
     if not FunctionDetect( CLIB_CliSiTefLib, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a função:'+FuncName+' de: '+CLIB_CliSiTefLib ) ) ;
     end ;
   end ;
 end ;
begin
   CliSiTefFunctionDetect('ConfiguraIntSiTefInterativoEx', @xConfiguraIntSiTefInterativoEx);
   CliSiTefFunctionDetect('ContinuaFuncaoSiTefInterativo', @xContinuaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('FinalizaTransacaoSiTefInterativo', @xFinalizaTransacaoSiTefInterativo);
   CliSiTefFunctionDetect('IniciaFuncaoSiTefInterativo', @xIniciaFuncaoSiTefInterativo);
end ;


procedure TACBrTEFDCliSiTef.DesInicializar;
begin
   inherited DesInicializar;
end;

end.

