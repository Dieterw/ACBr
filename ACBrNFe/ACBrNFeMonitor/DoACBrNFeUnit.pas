{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunicação com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2006 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na página do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa é software livre; você pode redistribuí-lo e/ou modificá-lo   }
{ sob os termos da Licença Pública Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a versão 2 da Licença como (a seu critério)       }
{ qualquer versão mais nova.                                                   }
{                                                                              }
{  Este programa é distribuído na expectativa de ser útil, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia implícita de COMERCIALIZAÇÃO OU DE ADEQUAÇÃO A}
{ QUALQUER PROPÓSITO EM PARTICULAR. Consulte a Licença Pública Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral GNU junto com este}
{ programa; se não, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Você também pode obter uma     }
{ copia da licença em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

unit DoACBrNFeUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnitNFe, Types ;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
Function ConvertStrRecived( AStr: String ) : String ;

implementation

Uses ACBrUtil, StrUtils, DateUtils,
  sndkey32, Windows, Forms, ACBrNFeMonitor1 , ACBrNFeWebServices;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
var
 I : Integer;
begin
 with frmAcbrNfeMonitor do
  begin
     try
        if Cmd.Metodo = 'statusservico' then
         begin
           if ACBrNFe1.WebServices.StatusServico.Executar then
              Cmd.Resposta := ACBrNFe1.WebServices.StatusServico.Msg
         end

        else if Cmd.Metodo = 'validarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrNFe1.NotasFiscais.Valida;
         end

        else if Cmd.Metodo = 'assinarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');              

           ACBrNFe1.NotasFiscais.Assinar;
         end

        else if Cmd.Metodo = 'consultarnfe' then
         begin
           ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);
           if ACBrNFe1.WebServices.Consulta.Executar then
              Cmd.Resposta := ACBrNFe1.WebServices.Consulta.Msg
           else
              raise Exception.Create(ACBrNFe1.WebServices.Consulta.Msg);
         end

        else if Cmd.Metodo = 'cancelarnfe' then
         begin
           ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);
           ACBrNFe1.WebServices.Consulta.Executar;

           ACBrNFe1.WebServices.Cancelamento.NFeChave      := ACBrNFe1.WebServices.Consulta.NFeChave;
           ACBrNFe1.WebServices.Cancelamento.Protocolo     := ACBrNFe1.WebServices.Consulta.Protocolo;
           ACBrNFe1.WebServices.Cancelamento.Justificativa := Cmd.Params(1);
           if ACBrNFe1.WebServices.Cancelamento.Executar then
              Cmd.Resposta := ACBrNFe1.WebServices.Cancelamento.Msg
           else
              raise Exception.Create(ACBrNFe1.WebServices.Cancelamento.Msg);
         end

        else if Cmd.Metodo = 'imprimirdanfe' then
         begin
           Restaurar1.Click;
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');              

           ACBrNFe1.NotasFiscais.Imprimir;
           Ocultar1.Click;
         end

        else if Cmd.Metodo = 'inutilizarnfe' then
         begin                            //CNPJ         //Justificat   //Ano                    //Modelo                 //Série                  //Num.Inicial            //Num.Final
           ACBrNFe1.WebServices.Inutiliza(Cmd.Params(0), Cmd.Params(1), StrToInt(Cmd.Params(2)), StrToInt(Cmd.Params(3)), StrToInt(Cmd.Params(4)), StrToInt(Cmd.Params(5)), StrToInt(Cmd.Params(6)));
           Cmd.Resposta := ACBrNFe1.WebServices.Inutilizacao.Msg;
         end

        else if Cmd.Metodo = 'enviarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');              

           if Cmd.Params(2) <> '0' then
              ACBrNFe1.NotasFiscais.Assinar;

           ACBrNFe1.NotasFiscais.Valida;

           if ACBrNFe1.WebServices.Envia(StrToInt(Cmd.Params(1))) then
            begin
              for I:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
               begin
                 if ACBrNFe1.NotasFiscais.Items[i].XML.Confirmada and (Cmd.Params(3) = '1') then
                    ACBrNFe1.NotasFiscais.Items[i].XML.Imprimir;
               end;
            end;
           Cmd.Resposta := ACBrNFe1.WebServices.Retorno.Msg;
         end

        else if Cmd.Metodo = 'restaurar' then
           Restaurar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'ocultar' then
           Ocultar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'encerrarmonitor' then
           Application.Terminate

        else //Else Final - Se chegou ate aqui, o comando é inválido
           raise Exception.Create('Comando inválido ('+ copy(Cmd.Comando,6,length(Cmd.Comando))+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end;
end ;

Function ConvertStrRecived( AStr: String ) : String ;
 Var P   : Integer ;
     Hex : String ;
     CharHex : Char ;
begin
  { Verificando por codigos em Hexa }
  Result := AStr ;

  P := pos('\x',Result) ;
  while P > 0 do
  begin
     Hex := copy(Result,P+2,2) ;

     try
        CharHex := Chr(StrToInt('$'+Hex)) ;
     except
        CharHex := ' ' ;
     end ;

     Result := StringReplace(Result,'\x'+Hex,CharHex,[rfReplaceAll]) ;
     P      := pos('\x',Result) ;
  end ;
end ;

end.


