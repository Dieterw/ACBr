{******************************************************************************}
{ Projeto: ACBrNFeMonitor                                                      }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunicação com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
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
{$I ACBr.inc}

unit DoACBrNFeUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnitNFe, Types,
     smtpsend, ssl_openssl, mimemess, mimepart,
     ACBrNFeUtil, RpDevice,
     IdMessage, IdSMTP, IdBaseComponent, IdComponent,
     IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
Function ConvertStrRecived( AStr: String ) : String ;
function UFparaCodigo(const UF: string): integer;
function ObterCodigoMunicipio(const xMun, xUF: string): integer;
procedure GerarIniNFe( AStr: WideString ) ;
function GerarNFeIni( XML : WideString ) : WideString;
procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL : Boolean; sCopias: String='');
procedure EnviarEmailIndy(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL : Boolean; sCopias: String='');
procedure GerarIniCCe( AStr: WideString ) ;

implementation

Uses IniFiles, StrUtils, DateUtils,
  Windows, Forms, XMLIntf, XMLDoc,
  ACBrUtil, ACBrNFeMonitor1 , ACBrNFeWebServices, ACBrNFe,
  ACBrNFeConfiguracoes,
  pcnNFe, pcnConversao,
  pcnRetConsReciNFe, pcnConsStatServ, pcnRetConsStatServ,
  pcnCancNFe, pcnRetCancNFe,
  pcnConsSitNFe, pcnRetConsSitNFe,
  pcnInutNFe, pcnRetInutNFe,
  pcnRetEnvNFe, pcnConsReciNFe, pcnAuxiliar,
  pcnNFeRTXT, ACBrNFeNotasFiscais, pcnRetConsCad, StdCtrls, pcnProcNFe,
  pcnRetCCeNFe, pcnNFeR;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
var
  I,J : Integer;
  ArqNFe, ArqPDF, Chave : String;
  Salva, EnviadoDPEC, OK : Boolean;
  SL     : TStringList;
  Alertas : AnsiString;

  Memo   : TStringList ;
  Files  : String ;
  dtFim  : TDateTime ;

  RetFind   : Integer ;
  SearchRec : TSearchRec ;

  NFeRTXT            : TNFeRTXT;
begin
 with frmAcbrNfeMonitor do
  begin
     try
        if Cmd.Metodo = 'statusservico' then
         begin
           if ACBrNFe1.WebServices.StatusServico.Executar then
            begin

              Cmd.Resposta := ACBrNFe1.WebServices.StatusServico.Msg+
                              '[STATUS]'+sLineBreak+
                              'Versao='+ACBrNFe1.WebServices.StatusServico.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.StatusServico.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrNFe1.WebServices.StatusServico.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrNFe1.WebServices.StatusServico.CStat)+sLineBreak+
                              'XMotivo='+ACBrNFe1.WebServices.StatusServico.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrNFe1.WebServices.StatusServico.CUF)+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.DhRecbto)+sLineBreak+
                              'TMed='+IntToStr(ACBrNFe1.WebServices.StatusServico.TMed)+sLineBreak+
                              'DhRetorno='+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.DhRetorno)+sLineBreak+
                              'XObs='+ACBrNFe1.WebServices.StatusServico.XObs+sLineBreak;
            end;
         end

        else if Cmd.Metodo = 'validarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrNFe1.NotasFiscais.Valida;
         end

        else if Cmd.Metodo = 'assinarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           Salva := ACBrNFe1.Configuracoes.Geral.Salvar;
           if not Salva then
            begin
             ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
             ACBrNFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
            end;
           ACBrNFe1.Configuracoes.Geral.Salvar := True;
           ACBrNFe1.NotasFiscais.Assinar;
           ACBrNFe1.Configuracoes.Geral.Salvar := Salva;
           if NotaUtil.NaoEstaVazio(ACBrNFe1.NotasFiscais.Items[0].NomeArq) then
              Cmd.Resposta := ACBrNFe1.NotasFiscais.Items[0].NomeArq
           else
              Cmd.Resposta := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
         end

        else if Cmd.Metodo = 'consultarnfe' then
         begin
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              ACBrNFe1.NotasFiscais.Clear;
              if FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0));

              ACBrNFe1.WebServices.Consulta.NFeChave := StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]);
            end
           else
            begin
              if not ValidarChave('NFe'+Cmd.Params(0)) then
                 raise Exception.Create('Chave '+Cmd.Params(0)+' inválida.')
              else
                 ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);
            end;
           try
              ACBrNFe1.WebServices.Consulta.Executar;

              Cmd.Resposta := ACBrNFe1.WebServices.Consulta.Msg+sLineBreak+
                              '[CONSULTA]'+sLineBreak+
                              'Versao='+ACBrNFe1.WebServices.Consulta.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Consulta.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrNFe1.WebServices.Consulta.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrNFe1.WebServices.Consulta.CStat)+sLineBreak+
                              'XMotivo='+ACBrNFe1.WebServices.Consulta.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrNFe1.WebServices.Consulta.CUF)+sLineBreak+
                              'ChNFe='+ACBrNFe1.WebServices.Consulta.NFeChave+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Consulta.DhRecbto)+sLineBreak+
                              'NProt='+ACBrNFe1.WebServices.Consulta.Protocolo+sLineBreak+
                              'DigVal='+ACBrNFe1.WebServices.Consulta.protNFe.digVal+sLineBreak;

           except
              raise Exception.Create(ACBrNFe1.WebServices.Consulta.Msg);
           end;
         end

        else if Cmd.Metodo = 'cancelarnfe' then
         begin
           if not ValidarChave('NFe'+Cmd.Params(0)) then
              raise Exception.Create('Chave '+Cmd.Params(0)+' inválida.')
           else
              ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);

           if not ACBrNFe1.WebServices.Consulta.Executar then
              raise Exception.Create(ACBrNFe1.WebServices.Consulta.Msg);

           ACBrNFe1.WebServices.Cancelamento.NFeChave      := ACBrNFe1.WebServices.Consulta.NFeChave;
           ACBrNFe1.WebServices.Cancelamento.Protocolo     := ACBrNFe1.WebServices.Consulta.Protocolo;
           ACBrNFe1.WebServices.Cancelamento.Justificativa := Cmd.Params(1);
           try
              ACBrNFe1.WebServices.Cancelamento.Executar;

              Cmd.Resposta := ACBrNFe1.WebServices.Cancelamento.Msg+sLineBreak+
                              '[CANCELAMENTO]'+sLineBreak+
                              'Versao='+ACBrNFe1.WebServices.Cancelamento.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Cancelamento.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrNFe1.WebServices.Cancelamento.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrNFe1.WebServices.Cancelamento.CStat)+sLineBreak+
                              'XMotivo='+ACBrNFe1.WebServices.Cancelamento.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrNFe1.WebServices.Cancelamento.CUF)+sLineBreak+
                              'ChNFe='+ACBrNFe1.WebServices.Cancelamento.NFeChave+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Cancelamento.DhRecbto)+sLineBreak+
                              'NProt='+ACBrNFe1.WebServices.Cancelamento.Protocolo+sLineBreak;
           except
              raise Exception.Create(ACBrNFe1.WebServices.Cancelamento.Msg);
           end;
         end

        else if Cmd.Metodo = 'imprimirdanfe' then
         begin
           if ACBrNFe1.DANFE.MostrarPreview then
            begin
              Restaurar1.Click;
              Application.BringToFront;
            end;
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           if NotaUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrNFe1.DANFE.Impressora := Cmd.Params(1)
           else
              ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

           if NotaUtil.NaoEstaVazio(Cmd.Params(2)) then
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(Cmd.Params(2),1)
           else
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(edtNumCopia.Text,1);

           if NotaUtil.NaoEstaVazio(Cmd.Params(3)) then
              ACBrNFe1.DANFE.ProtocoloNFe := Cmd.Params(3);

           if (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC) and
              NotaUtil.EstaVazio(ACBrNFe1.DANFE.ProtocoloNFe) then
            begin
              ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
              ACBrNFe1.WebServices.ConsultaDPEC.Executar;
              ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.ConsultaDPEC.dhRegDPEC);
            end;

           ACBrNFe1.NotasFiscais.Imprimir;
           Cmd.Resposta := 'Danfe Impresso com sucesso';
           if ACBrNFe1.DANFE.MostrarPreview then
              Ocultar1.Click;
         end

        else if Cmd.Metodo = 'imprimirdanfepdf' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           if NotaUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrNFe1.DANFE.ProtocoloNFe := Cmd.Params(1);
              
           if (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC) and
              NotaUtil.EstaVazio(ACBrNFe1.DANFE.ProtocoloNFe) then
            begin
              ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
              ACBrNFe1.WebServices.ConsultaDPEC.Executar;
              ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.ConsultaDPEC.dhRegDPEC);
            end;

           try
              ACBrNFe1.NotasFiscais.ImprimirPDF;
              ArqPDF := StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,'NFe','',[rfIgnoreCase])+'.pdf';
              Cmd.Resposta := 'Arquivo criado em: '+ PathWithDelim(ACBrNFe1.DANFE.PathPDF) +
                              ArqPDF ;
           except
              raise Exception.Create('Erro ao criar o arquivo PDF');
           end;
         end

        else if Cmd.Metodo = 'inutilizarnfe' then
         begin                            //CNPJ         //Justificat   //Ano                    //Modelo                 //Série                  //Num.Inicial            //Num.Final
           ACBrNFe1.WebServices.Inutiliza(Cmd.Params(0), Cmd.Params(1), StrToInt(Cmd.Params(2)), StrToInt(Cmd.Params(3)), StrToInt(Cmd.Params(4)), StrToInt(Cmd.Params(5)), StrToInt(Cmd.Params(6)));

           Cmd.Resposta := ACBrNFe1.WebServices.Inutilizacao.Msg+sLineBreak+
                           '[INUTILIZACAO]'+sLineBreak+
                           'Versao='+ACBrNFe1.WebServices.Inutilizacao.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Inutilizacao.TpAmb)+sLineBreak+
                           'VerAplic='+ACBrNFe1.WebServices.Inutilizacao.VerAplic+sLineBreak+
                           'CStat='+IntToStr(ACBrNFe1.WebServices.Inutilizacao.CStat)+sLineBreak+
                           'XMotivo='+ACBrNFe1.WebServices.Inutilizacao.XMotivo+sLineBreak+
                           'CUF='+IntToStr(ACBrNFe1.WebServices.Inutilizacao.CUF)+sLineBreak+
                           'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Inutilizacao.DhRecbto)+sLineBreak+
                           'NProt='+ACBrNFe1.WebServices.Inutilizacao.Protocolo+sLineBreak;
         end

        else if Cmd.Metodo = 'enviarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrNFe1.NotasFiscais.GerarNFe;
           if Cmd.Params(2) <> '0' then
              ACBrNFe1.NotasFiscais.Assinar;

           ACBrNFe1.NotasFiscais.Valida;

           if not(ACBrNFe1.WebServices.StatusServico.Executar) then
            raise Exception.Create(ACBrNFe1.WebServices.StatusServico.Msg);

           if Trim(OnlyNumber(Cmd.Params(1))) = '' then
              ACBrNFe1.WebServices.Enviar.Lote := '1'
           else
              ACBrNFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(1));

           ACBrNFe1.WebServices.Enviar.Executar;

           Cmd.Resposta :=  ACBrNFe1.WebServices.Enviar.Msg+sLineBreak+
                            '[ENVIO]'+sLineBreak+
                            'Versao='+ACBrNFe1.WebServices.Enviar.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Enviar.TpAmb)+sLineBreak+
                            'VerAplic='+ACBrNFe1.WebServices.Enviar.VerAplic+sLineBreak+
                            'CStat='+IntToStr(ACBrNFe1.WebServices.Enviar.CStat)+sLineBreak+
                            'XMotivo='+ACBrNFe1.WebServices.Enviar.XMotivo+sLineBreak+
                            'CUF='+IntToStr(ACBrNFe1.WebServices.Enviar.CUF)+sLineBreak+
                            'NRec='+ACBrNFe1.WebServices.Enviar.Recibo+sLineBreak+
                            'DhRecbto='+DateTimeToStr( ACBrNFe1.WebServices.Enviar.dhRecbto)+sLineBreak+
                            'TMed='+IntToStr( ACBrNFe1.WebServices.Enviar.tMed)+sLineBreak;

           ACBrNFe1.WebServices.Retorno.Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
           ACBrNFe1.WebServices.Retorno.Executar;

           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrNFe1.WebServices.Retorno.Msg+sLineBreak+
                            '[RETORNO]'+sLineBreak+
                            'Versao='+ACBrNFe1.WebServices.Retorno.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb)+sLineBreak+
                            'VerAplic='+ACBrNFe1.WebServices.Retorno.VerAplic+sLineBreak+
                            'NRec='+ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec+sLineBreak+
                            'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.CStat)+sLineBreak+
                            'XMotivo='+ACBrNFe1.WebServices.Retorno.XMotivo+sLineBreak+
                            'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.CUF)+sLineBreak;

           for I:= 0 to ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Count-1 do
            begin
              for J:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
              begin
                if 'NFe'+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe = ACBrNFe1.NotasFiscais.Items[j].NFe.InfNFe.Id  then
                begin
                  Cmd.Resposta := Cmd.Resposta+
                             '[NFE'+Trim(IntToStr(ACBrNFe1.NotasFiscais.Items[J].NFe.Ide.NNF))+']'+sLineBreak+
                             'Versao='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                             'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].tpAmb)+sLineBreak+
                             'VerAplic='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                             'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].cStat)+sLineBreak+
                             'XMotivo='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].xMotivo+sLineBreak+
                             'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.cUF)+sLineBreak+
                             'ChNFe='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe+sLineBreak+
                             'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].dhRecbto)+sLineBreak+
                             'NProt='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].nProt+sLineBreak+
                             'DigVal='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].digVal+sLineBreak;
                  break;
                end;
              end;

              if NotaUtil.NaoEstaVazio(Cmd.Params(4)) then
                 ACBrNFe1.DANFE.Impressora := Cmd.Params(4)
              else
                 ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

              if ACBrNFe1.NotasFiscais.Items[i].Confirmada and (Cmd.Params(3) = '1') then
                 ACBrNFe1.NotasFiscais.Items[i].Imprimir;
            end;
         end
        else if (Cmd.Metodo = 'recibonfe')then
         begin
           ACBrNFe1.WebServices.Recibo.Recibo := Cmd.Params(0);
           if not(ACBrNFe1.WebServices.Recibo.Executar) then
             raise Exception.Create(ACBrNFe1.WebServices.Recibo.xMotivo);

           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrNFe1.WebServices.Recibo.Msg+sLineBreak+
                           '[RETORNO]'+sLineBreak+
                           'Versao='+ACBrNFe1.WebServices.Recibo.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Recibo.TpAmb)+sLineBreak+
                           'VerAplic='+ACBrNFe1.WebServices.Recibo.VerAplic+sLineBreak+
                           'NRec='+ACBrNFe1.WebServices.Recibo.Recibo+sLineBreak+
                           'CStat='+IntToStr(ACBrNFe1.WebServices.Recibo.CStat)+sLineBreak+
                           'XMotivo='+ACBrNFe1.WebServices.Recibo.XMotivo+sLineBreak+
                           'CUF='+IntToStr(ACBrNFe1.WebServices.Recibo.CUF)+sLineBreak+
                           'ChNFe='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].chNFe+sLineBreak+
                           'NProt='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt+sLineBreak+
                           'MotivoNFe='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].xMotivo+sLineBreak;

                           for I:= 0 to ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Count-1 do
                            begin
                              Cmd.Resposta := Cmd.Resposta+
                                '[NFE'+Trim(IntToStr(StrToInt(copy(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].chNFe,26,9))))+']'+sLineBreak+
                                'Versao='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].tpAmb)+sLineBreak+
                                'VerAplic='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                'CStat='+IntToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].cStat)+sLineBreak+
                                'XMotivo='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].xMotivo+sLineBreak+
                                'CUF='+IntToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.cUF)+sLineBreak+
                                'ChNFe='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].chNFe+sLineBreak+
                                'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].dhRecbto)+sLineBreak+
                                'NProt='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].nProt+sLineBreak+
                                'DigVal='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].digVal+sLineBreak;
                            end;

           if ACBrNFe1.Configuracoes.Geral.Salvar then
            begin
              Cmd.Resposta :=  Cmd.Resposta+
              'Arquivo='+ACBrNFe1.Configuracoes.Geral.PathSalvar+Cmd.Params(0)+'-pro-rec.xml';
            end;
         end
        else if (Cmd.Metodo = 'consultacadastro')then
         begin
           ACBrNFe1.WebServices.ConsultaCadastro.UF   := Cmd.Params(0);
           if Cmd.Params(2) = '1' then
              ACBrNFe1.WebServices.ConsultaCadastro.IE := Cmd.Params(1)
           else
            begin
              if Length(Cmd.Params(1)) > 11 then
                 ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := Cmd.Params(1)
              else
                 ACBrNFe1.WebServices.ConsultaCadastro.CPF := Cmd.Params(1);
            end;
            ACBrNFe1.WebServices.ConsultaCadastro.Executar;

            Cmd.Resposta :=  Cmd.Resposta+
                             ACBrNFe1.WebServices.ConsultaCadastro.Msg+sLineBreak+
                             'VerAplic='+ACBrNFe1.WebServices.ConsultaCadastro.verAplic+sLineBreak+
                             'cStat='+IntToStr(ACBrNFe1.WebServices.ConsultaCadastro.cStat)+sLineBreak+
                             'xMotivo='+ACBrNFe1.WebServices.ConsultaCadastro.xMotivo+sLineBreak+
                             'DhCons='+DateTimeToStr(ACBrNFe1.WebServices.ConsultaCadastro.DhCons)+sLineBreak+
                             'cUF='+IntToStr(ACBrNFe1.WebServices.ConsultaCadastro.cUF)+sLineBreak+
                             'IE='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].IE+sLineBreak+
                             'CNPJ='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CNPJ+sLineBreak+
                             'CPF='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CPF+sLineBreak+
                             'UF='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].UF+sLineBreak+
                             'cSit='+IntToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].cSit)+sLineBreak+
                             'xNome='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xNome+sLineBreak+
                             'xFant='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xFant+sLineBreak+
                             'xRegApur='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xRegApur+sLineBreak+
                             'CNAE='+inttostr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CNAE)+sLineBreak+
                             'dIniAtiv='+NotaUtil.FormatDate(DateToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].dIniAtiv))+sLineBreak+
                             'dUltSit='+NotaUtil.FormatDate(DateToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].dUltSit))+sLineBreak+
                             'dBaixa='+NotaUtil.FormatDate(DateToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].dBaixa))+sLineBreak+
                             'xLgr='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xLgr+sLineBreak+
                             'nro='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].nro+sLineBreak+
                             'xCpl='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xCpl+sLineBreak+
                             'xBairro='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xBairro+sLineBreak+
                             'cMun='+inttostr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].cMun)+sLineBreak+
                             'xMun='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xMun+sLineBreak+
                             'CEP='+inttostr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CEP)+sLineBreak;

         end
        else if (Cmd.Metodo = 'criarnfe')      or (Cmd.Metodo = 'criarenviarnfe') or
                (Cmd.Metodo = 'criarnfesefaz') or (Cmd.Metodo = 'criarenviarnfesefaz') or
                (Cmd.Metodo = 'adicionarnfe')  or (Cmd.Metodo = 'adicionarnfesefaz') or
                (Cmd.Metodo = 'enviarlotenfe') or (Cmd.Metodo = 'enviardpecnfe') then
         begin
           if (Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarenviarnfe') or
              (Cmd.Metodo = 'adicionarnfe') then
              GerarIniNFe( Cmd.Params(0)  )
           else
            begin
              if (Cmd.Metodo = 'criarnfesefaz') or (Cmd.Metodo = 'criarenviarnfesefaz') or
                 (Cmd.Metodo = 'adicionarnfesefaz') then
                  begin
                    if not FileExists(Cmd.Params(0)) then
                       raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.')
                    else
                     begin
                       ACBrNFe1.NotasFiscais.Clear;
                       ACBrNFe1.NotasFiscais.Add;
                       NFeRTXT := TNFeRTXT.Create(ACBrNFe1.NotasFiscais.Items[0].NFe);
                       try
                          NFeRTXT.CarregarArquivo(Cmd.Params(0));
                          if not NFeRTXT.LerTxt then
                             raise Exception.Create('Arquivo inválido!');
                       finally
                          NFeRTXT.Free;
                       end;
                     end;
                  end;
            end;
           if (Cmd.Metodo = 'adicionarnfe')  or (Cmd.Metodo = 'adicionarnfesefaz') then
            begin
              ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(1)));
              ACBrNFe1.NotasFiscais.GerarNFe;
              Alertas := ACBrNFe1.NotasFiscais.Items[0].Alertas;
              ACBrNFe1.NotasFiscais.Valida;
              ArqNFe := PathWithDelim(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(1)))+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
              ACBrNFe1.NotasFiscais.SaveToFile(ExtractFilePath(ArqNFe));
              if not FileExists(ArqNFe) then
                 raise Exception.Create('Não foi possível criar o arquivo '+ArqNFe);
            end
           else if (Cmd.Metodo = 'criarnfe')  or (Cmd.Metodo = 'criarnfesefaz') or
           (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') then
            begin
              Salva := ACBrNFe1.Configuracoes.Geral.Salvar;
              if not Salva then
               begin
                ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
                ACBrNFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
               end;
              ACBrNFe1.NotasFiscais.GerarNFe;
              Alertas := ACBrNFe1.NotasFiscais.Items[0].Alertas;
              ACBrNFe1.NotasFiscais.Valida;
              ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
              ACBrNFe1.NotasFiscais.SaveToFile(ArqNFe);
              if not FileExists(ArqNFe) then
                raise Exception.Create('Não foi possível criar o arquivo '+ArqNFe);
            end;

           Cmd.Resposta := ArqNFe;
           if Alertas <> '' then
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+'Alertas:'+Alertas;
           if ((Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarnfesefaz')) and (Cmd.Params(1) = '1') then
            begin
              SL := TStringList.Create;
              SL.LoadFromFile(ArqNFe);
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+SL.Text;
              SL.Free;
            end;

           if (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') or (Cmd.Metodo = 'enviarlotenfe') or (Cmd.Metodo = 'enviardpecnfe') then
            begin
              //Carregar Notas quando enviar lote
              if (Cmd.Metodo = 'enviarlotenfe')  or (Cmd.Metodo = 'enviardpecnfe') then
               begin
                 if not DirectoryExists(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(0))) then
                    raise Exception.Create('Diretório não encontrado:'+PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(0)))
                 else
                  begin
                    ACBrNFe1.NotasFiscais.Clear;
                    RetFind := SysUtils.FindFirst( PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+Cmd.Params(0)+PathDelim+'*-nfe.xml', faAnyFile, SearchRec) ;
                    if (RetFind = 0) then
                     begin
                       while RetFind = 0 do
                        begin
                           ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+Cmd.Params(0)+PathDelim+SearchRec.Name);
                           RetFind := FindNext(SearchRec);
                        end;
                        ACBrNFe1.NotasFiscais.GerarNFe;
                        ACBrNFe1.NotasFiscais.Assinar;
                        ACBrNFe1.NotasFiscais.Valida;
                     end
                    else
                       raise Exception.Create('Não foi encontrada nenhuma nota para o Lote: '+Cmd.Params(0) );
                  end;
               end;

              if (Cmd.Metodo = 'enviardpecnfe') then
               begin
                 EnviadoDPEC  := ACBrNFe1.WebServices.EnviarDPEC.Executar;
                 Cmd.Resposta :=  ACBrNFe1.WebServices.EnviarDPEC.Msg+sLineBreak+
                                 '[DPEC]'+sLineBreak+
                                 'ID='+ACBrNFe1.WebServices.EnviarDPEC.ID+sLineBreak+
                                 'Versao='+ACBrNFe1.WebServices.EnviarDPEC.verAplic+sLineBreak+
                                 'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.EnviarDPEC.TpAmb)+sLineBreak+
                                 'VerAplic='+ACBrNFe1.WebServices.EnviarDPEC.VerAplic+sLineBreak+
                                 'CStat='+IntToStr(ACBrNFe1.WebServices.EnviarDPEC.cStat)+sLineBreak+
                                 'XMotivo='+ACBrNFe1.WebServices.EnviarDPEC.xMotivo+sLineBreak+
                                 'DhRegDPEC='+DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC)+sLineBreak+
                                 'nRegDPEC='+ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC+sLineBreak+
                                 'ChNFe='+ACBrNFe1.WebServices.EnviarDPEC.NFeChave+sLineBreak;
                 if (Cmd.Params(1) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                  begin
                    Restaurar1.Click;
                    Application.BringToFront;
                  end;
                 ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;
                 for I:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
                  begin
                    if (Cmd.Params(1) = '1') and EnviadoDPEC then
                     begin
                       ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC);
                       ACBrNFe1.NotasFiscais.Items[i].Imprimir;
                     end;
                  end;
                 if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                    Ocultar1.Click;
               end
              else //enviarlotenfe
               begin
                 if not(ACBrNFe1.WebServices.StatusServico.Executar) then
                  raise Exception.Create(ACBrNFe1.WebServices.StatusServico.Msg);

                 if (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') then
                  begin
                    if Trim(OnlyNumber(Cmd.Params(1))) = '' then
                       ACBrNFe1.WebServices.Enviar.Lote := '1'
                    else
                       ACBrNFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(1));
                  end
                 else
                  begin
                    if Trim(OnlyNumber(Cmd.Params(0))) = '' then
                       ACBrNFe1.WebServices.Enviar.Lote := '1'
                    else
                       ACBrNFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(0));
                  end;
                 ACBrNFe1.WebServices.Enviar.Executar ;

                 Cmd.Resposta :=  ACBrNFe1.WebServices.Enviar.Msg+sLineBreak+
                                 '[ENVIO]'+sLineBreak+
                                 'Versao='+ACBrNFe1.WebServices.Enviar.verAplic+sLineBreak+
                                 'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Enviar.TpAmb)+sLineBreak+
                                 'VerAplic='+ACBrNFe1.WebServices.Enviar.VerAplic+sLineBreak+
                                 'CStat='+IntToStr(ACBrNFe1.WebServices.Enviar.CStat)+sLineBreak+
                                 'XMotivo='+ACBrNFe1.WebServices.Enviar.XMotivo+sLineBreak+
                                 'CUF='+IntToStr(ACBrNFe1.WebServices.Enviar.CUF)+sLineBreak+
                                 'NRec='+ACBrNFe1.WebServices.Enviar.Recibo+sLineBreak+
                                 'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Enviar.dhRecbto)+sLineBreak+
                                 'TMed='+IntToStr(ACBrNFe1.WebServices.Enviar.TMed)+sLineBreak+
                                 'Msg='+ACBrNFe1.WebServices.Enviar.Msg+sLineBreak;

                 ACBrNFe1.WebServices.Retorno.Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
                 ACBrNFe1.WebServices.Retorno.Executar;

                 Cmd.Resposta :=  Cmd.Resposta+
                                  ACBrNFe1.WebServices.Retorno.Msg+sLineBreak+
                                  '[RETORNO]'+sLineBreak+
                                  'Versao='+ACBrNFe1.WebServices.Retorno.verAplic+sLineBreak+
                                  'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb)+sLineBreak+
                                  'VerAplic='+ACBrNFe1.WebServices.Retorno.VerAplic+sLineBreak+
                                  'NRec='+ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec+sLineBreak+
                                  'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.CStat)+sLineBreak+
                                  'XMotivo='+ACBrNFe1.WebServices.Retorno.XMotivo+sLineBreak+
                                  'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.CUF)+sLineBreak;

                 for I:= 0 to ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Count-1 do
                  begin
                   for J:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
                    begin
                     if 'NFe'+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe = ACBrNFe1.NotasFiscais.Items[j].NFe.InfNFe.Id  then
                      begin
                        Cmd.Resposta := Cmd.Resposta+
                                   '[NFE'+Trim(IntToStr(ACBrNFe1.NotasFiscais.Items[j].NFe.Ide.NNF))+']'+sLineBreak+
                                   'Versao='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                   'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].tpAmb)+sLineBreak+
                                   'VerAplic='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                   'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].cStat)+sLineBreak+
                                   'XMotivo='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].xMotivo+sLineBreak+
                                   'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.cUF)+sLineBreak+
                                   'ChNFe='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe+sLineBreak+
                                   'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].dhRecbto)+sLineBreak+
                                   'NProt='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].nProt+sLineBreak+
                                   'DigVal='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].digVal+sLineBreak+
                                   'Arquivo='+PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[j].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml'+sLineBreak;
                        if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                         begin
                           Restaurar1.Click;
                           Application.BringToFront;
                         end;
                        ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;
                        if ACBrNFe1.NotasFiscais.Items[i].Confirmada and (Cmd.Params(2) = '1') then
                           ACBrNFe1.NotasFiscais.Items[i].Imprimir;
                        if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                           Ocultar1.Click;
                        break;
                      end;
                    end;
                  end;
               end;
            end;
         end

        else if (Cmd.Metodo = 'cartadecorrecao')then
         begin
           ACBrNFe1.CartaCorrecao.CCe.Evento.Clear;

           GerarIniCCe( Cmd.Params(0) );

           ACBrNFe1.EnviarCartaCorrecao(ACBrNFe1.CartaCorrecao.CCe.idLote);

           if ACBrNFe1.Configuracoes.Geral.Salvar then
            begin
              Cmd.Resposta :=  Cmd.Resposta+
              'Arquivo='+ACBrNFe1.WebServices.CartaCorrecao.PathArqResp;
            end;
           Cmd.Resposta := Cmd.Resposta+sLineBreak+
                           'idLote='   +IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.idLote)+sLineBreak+
                           'tpAmb='    +TpAmbToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.tpAmb)+sLineBreak+
                           'verAplic=' +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.verAplic+sLineBreak+
                           'cOrgao='   +IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.cOrgao)+sLineBreak+
                           'cStat='    +IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.cStat)+sLineBreak+
                           'xMotivo='  +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.xMotivo+sLineBreak;
           for I:= 0 to ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Count-1 do
            begin

              Cmd.Resposta := Cmd.Resposta+sLineBreak+
               '[EVENTO'+Trim(IntToStrZero(I+1,3))+']'+sLineBreak+
               'tpAmb='     +TpAmbToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.tpAmb)+sLineBreak+
               'verAplic='  +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.verAplic+sLineBreak+
               'cOrgao='    +IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.cOrgao)+sLineBreak+
               'cStat='     +IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.cStat)+sLineBreak+
               'xMotivo='   +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.xMotivo+sLineBreak+
               'chNFe='     +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.chNFe+sLineBreak+
               'tpEvento='  +IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.tpEvento)+sLineBreak+
               'xEvento='   +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.xEvento+sLineBreak+
               'nSeqEvento='+IntToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.nSeqEvento)+sLineBreak+
               'CNPJDest='  +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.CNPJDest+sLineBreak+
               'dhRegEvento='+DateTimeToStr(ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.dhRegEvento)+sLineBreak+
               'nProt='     +ACBrNFe1.WebServices.CartaCorrecao.CCeRetorno.retEvento.Items[I].RetInfEvento.nProt;
            end;
         end

        else if Cmd.Metodo = 'enviaremail' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(1)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1)) then
            begin
              if FileExists(Cmd.Params(1)) then
               begin
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(1));
                 ArqNFe := Cmd.Params(1);
               end
              else
               begin
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1));
                 ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1);
               end;
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(1)+' não encontrado.');

           if (Cmd.Params(2) = '1') then
            begin
              try
                 ACBrNFe1.NotasFiscais.ImprimirPDF;
                 ArqPDF := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID ;

                 ArqPDF := StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]);
                 ArqPDF := PathWithDelim(ACBrNFe1.DANFE.PathPDF)+ArqPDF+'.pdf';
              except
                 raise Exception.Create('Erro ao criar o arquivo PDF');
              end;
            end;
            try
               if rgEmailTipoEnvio.ItemIndex = 0 then
                  EnviarEmail(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),NotaUtil.SeSenao(NotaUtil.NaoEstaVazio(Cmd.Params(3)),Cmd.Params(3),edtEmailAssunto.Text), ArqNFe, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked,Cmd.Params(4))
               else
                  EnviarEmailIndy(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),NotaUtil.SeSenao(NotaUtil.NaoEstaVazio(Cmd.Params(3)),Cmd.Params(3),edtEmailAssunto.Text), ArqNFe, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked,Cmd.Params(4));
               Cmd.Resposta := 'Email enviado com sucesso';
            except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao enviar email'+sLineBreak+E.Message);
                end;
            end;
         end

        else if Cmd.Metodo = 'setcertificado' then
         begin
           if (Cmd.Params(0)<>'') then
            begin
             {$IFDEF ACBrNFeOpenSSL}
                ACBrNFe1.Configuracoes.Certificados.Certificado := Cmd.Params(0);
                ACBrNFe1.Configuracoes.Certificados.Senha       := Cmd.Params(1);
                edtCaminho.Text := ACBrNFe1.Configuracoes.Certificados.Certificado;
                edtSenha.Text   := ACBrNFe1.Configuracoes.Certificados.Senha;
             {$ELSE}
                ACBrNFe1.Configuracoes.Certificados.NumeroSerie := Cmd.Params(0);
                ACBrNFe1.Configuracoes.Certificados.Senha       := Cmd.Params(1);                
                edtCaminho.Text := ACBrNFe1.Configuracoes.Certificados.NumeroSerie;
             {$ENDIF}
                frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Certificado '+Cmd.Params(0)+' Inválido.');
         end

        else if Cmd.Metodo = 'setambiente' then //1-Produção 2-Homologação
         begin
           if (StrToInt(Cmd.Params(0))>=1) and (StrToInt(Cmd.Params(0))<=2) then
            begin
              ACBrNFe1.Configuracoes.WebServices.Ambiente := StrToTpAmb(OK, Cmd.Params(0));
              rgTipoAmb.ItemIndex := ACBrNFe1.Configuracoes.WebServices.AmbienteCodigo-1;
              frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Ambiente Inválido.');
         end

        else if Cmd.Metodo = 'setformaemissao' then //1-Normal 2-Contingencia 3-SCAN 4-DPEC 5-FSDA
         begin
           if (StrToInt(Cmd.Params(0))>=1) and (StrToInt(Cmd.Params(0))<=5) then
            begin
              ACBrNFe1.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK, Cmd.Params(0));
              rgFormaEmissao.ItemIndex := ACBrNFe1.Configuracoes.Geral.FormaEmissaoCodigo-1;
              frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Forma de Emissão Inválida.');
         end

        else if Cmd.Metodo = 'lernfe' then
         begin
           try
              Cmd.Resposta := GerarNFeIni( Cmd.Params(0)  )
           except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao gerar INI da NFe.'+sLineBreak+E.Message);
                end;
           end;
         end

        else if Cmd.Metodo = 'nfetotxt' then  //1-Arquivo XML, 2-NomeArqTXT
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrNFe1.NotasFiscais.Items[0].SaveToFile(Cmd.Params(1),True);
           Cmd.Resposta := ChangeFileExt(ACBrNFe1.NotasFiscais.Items[0].NomeArq,'.txt');
         end

        else if Cmd.Metodo = 'savetofile' then
         begin
           Memo := TStringList.Create ;
           try
              Memo.Clear ;
              Memo.Text := ConvertStrRecived( cmd.Params(1) );
              Memo.SaveToFile( Cmd.Params(0) );
           finally
              Memo.Free ;
           end ;
         end

        else if Cmd.Metodo = 'loadfromfile' then
         begin
           Files := Cmd.Params(0) ;
           dtFim := IncSecond(now, StrToIntDef(Cmd.Params(1),1) ) ;
           while now <= dtFim do
           begin
              if FileExists( Files ) then
              begin
                 Memo  := TStringList.Create ;
                 try
                    Memo.Clear ;
                    Memo.LoadFromFile( Files ) ;
                    Cmd.Resposta := Memo.Text ;
                    Break ;
                 finally
                    Memo.Free ;
                 end ;
              end ;

              {$IFNDEF CONSOLE}
               Application.ProcessMessages ;
              {$ENDIF}
              sleep(100) ;
           end ;

           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado')
         end

        else if Cmd.Metodo = 'fileexists' then
         begin
           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado')
         end


        else if Cmd.Metodo = 'certificadodatavencimento' then
         begin
           {$IFDEF ACBrNFeOpenSSL}
              Cmd.Resposta := 'Função disponível apenas na versão CAPICOM'
           {$ELSE}
              Cmd.Resposta := DateToStr(ACBrNFe1.Configuracoes.Certificados.DataVenc);
           {$ENDIF}
         end

        else if Cmd.Metodo = 'lerini' then // Recarrega configurações do arquivo INI
           frmAcbrNfeMonitor.LerIni

        else if Cmd.Metodo = 'gerarchave' then
         begin
           GerarChave(Chave,
                      StrToInt(Cmd.Params(0)), //codigoUF
                      StrToInt(Cmd.Params(1)), //codigoNumerico
                      StrToInt(Cmd.Params(2)), //modelo
                      StrToInt(Cmd.Params(3)), //serie
                      StrToInt(Cmd.Params(4)), //numero
                      StrToInt(Cmd.Params(5)), //tpemi
                      NotaUtil.StringToDate(Cmd.Params(6)), //emissao
                      Cmd.Params(7)); //CNPJ
           Cmd.Resposta := Chave;
         end

        else if Cmd.Metodo = 'restaurar' then
           Restaurar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'ocultar' then
           Ocultar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'encerrarmonitor' then
           Application.Terminate

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := 'Ativo'

        else if pos('|'+Cmd.Metodo+'|', '|exit|bye|fim|sair|') > 0 then {fecha conexao}
         begin
           Cmd.Resposta := 'Obrigado por usar o ACBrNFeMonitor' ;
           mCmd.Lines.Clear;

           if Assigned( Conexao ) then
              if Assigned( Conexao.Connection ) then
                 Conexao.Connection.Disconnect ;
         end


        else //Else Final - Se chegou ate aqui, o comando é inválido
           raise Exception.Create('Comando inválido ('+Cmd.Comando+')') ;

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

function UFparaCodigo(const UF: string): integer;
const
  (**)UFS = '.AC.AL.AP.AM.BA.CE.DF.ES.GO.MA.MT.MS.MG.PA.PB.PR.PE.PI.RJ.RN.RS.RO.RR.SC.SP.SE.TO.';
  CODIGOS = '.12.27.16.13.29.23.53.32.52.21.51.50.31.15.25.41.26.22.33.24.43.11.14.42.35.28.17.';
begin
  try
    result := StrToInt(copy(CODIGOS, pos('.' + UF + '.', UFS) + 1, 2));
  except
    result := 0;
  end;
end;

function ObterCodigoMunicipio(const xMun, xUF: string): integer;
var
  i: integer;
  PathArquivo: string;
  List: TstringList;
begin
  result := 0;
  PathArquivo :=  PathWithDelim(ExtractFilePath(Application.ExeName))+ 'MunIBGE'+PathDelim+'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
  if FileExists(PathArquivo) then
   begin
     List := TstringList.Create;
     List.LoadFromFile(PathArquivo);
     i := 0;
     while (i < list.count) and (result = 0) do
      begin
       if pos(UpperCase(TiraAcentos(xMun)), UpperCase(TiraAcentos(List[i]))) > 0 then
          result := StrToInt(Trim(copy(list[i],1,7)));
       inc(i);
      end;
     List.free;
   end;
end;

procedure GerarIniNFe( AStr: WideString ) ;
var
  I, J, K : Integer;
  sSecao, sFim, sCodPro, sNumeroDI, sNumeroADI, sQtdVol, sNumDup, sCampoAdic, sTipo, sDia, sDeduc : String;
  INIRec : TMemIniFile ;
  SL     : TStringList;
  OK     : boolean;
begin
 INIRec := TMemIniFile.create( 'nfe.ini' ) ;
 SL := TStringList.Create;
 if FilesExists(Astr) then
    SL.LoadFromFile(AStr)
 else
    Sl.Text := ConvertStrRecived( Astr );
 INIRec.SetStrings( SL );
 SL.Free ;
 with frmAcbrNfeMonitor do
  begin
   try
      ACBrNFe1.NotasFiscais.Clear;
      with ACBrNFe1.NotasFiscais.Add.NFe do
       begin
         Ide.cNF        := INIRec.ReadInteger( 'Identificacao','Codigo' ,0);
         Ide.natOp      := INIRec.ReadString(  'Identificacao','NaturezaOperacao' ,'');
         Ide.indPag     := StrToIndpag(OK,INIRec.ReadString( 'Identificacao','FormaPag','0'));
         Ide.modelo     := INIRec.ReadInteger( 'Identificacao','Modelo' ,55);
         Ide.serie      := INIRec.ReadInteger( 'Identificacao','Serie'  ,1);
         Ide.nNF        := INIRec.ReadInteger( 'Identificacao','Numero' ,0);
         Ide.dEmi       := NotaUtil.StringToDate(INIRec.ReadString( 'Identificacao','Emissao','0'));
         Ide.dSaiEnt    := NotaUtil.StringToDate(INIRec.ReadString( 'Identificacao','Saida'  ,'0'));
         Ide.hSaiEnt    := NotaUtil.StringToTime(INIRec.ReadString( 'Identificacao','hSaiEnt','0'));  //NFe2
         Ide.tpNF       := StrToTpNF(OK,INIRec.ReadString( 'Identificacao','Tipo','1'));

         Ide.tpImp      := StrToTpImp(  OK, INIRec.ReadString( 'Identificacao','tpImp',TpImpToStr(ACBrNFe1.DANFE.TipoDANFE)));  //NFe2
         Ide.tpEmis     := StrToTpEmis( OK,INIRec.ReadString( 'Identificacao','tpemis',IntToStr(ACBrNFe1.Configuracoes.Geral.FormaEmissaoCodigo)));
//         Ide.cDV
//         Ide.tpAmb
         Ide.finNFe     := StrToFinNFe( OK,INIRec.ReadString( 'Identificacao','Finalidade','0'));
         Ide.procEmi    := StrToProcEmi(OK,INIRec.ReadString( 'Identificacao','procEmi','0')); //NFe2
         Ide.verProc    := INIRec.ReadString(  'Identificacao','verProc' ,'1.0.0.0' );
         Ide.dhCont     := NotaUtil.StringToDateTime(INIRec.ReadString( 'Identificacao','dhCont'  ,'0')); //NFe2
         Ide.xJust      := INIRec.ReadString(  'Identificacao','xJust' ,'' ); //NFe2

         I := 1 ;
         while true do
          begin
            sSecao := 'NFRef'+IntToStrZero(I,3) ;
            sFim   := INIRec.ReadString(  sSecao,'Tipo'  ,'FIM');
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break ;

            sTipo := UpperCase(INIRec.ReadString(  sSecao,'Tipo'  ,'NFe')); //NFe2 NF NFe NFP CTe ECF)

            with Ide.NFref.Add do
             begin
               if sTipo = 'NFE' then
                  refNFe :=  INIRec.ReadString(sSecao,'refNFe','')
               else if sTipo = 'NF' then
                begin
                  RefNF.cUF    := INIRec.ReadInteger( sSecao,'cUF'   ,0);
                  RefNF.AAMM   := INIRec.ReadString(  sSecao,'AAMM'  ,'');
                  RefNF.CNPJ   := INIRec.ReadString(  sSecao,'CNPJ'  ,'');
                  RefNF.modelo := INIRec.ReadInteger( sSecao,'Modelo',0);
                  RefNF.serie  := INIRec.ReadInteger( sSecao,'Serie' ,0);
                  RefNF.nNF    := INIRec.ReadInteger( sSecao,'nNF'   ,0);
                end
               else if sTipo = 'NFP' then
                begin
                  RefNFP.cUF    := INIRec.ReadInteger( sSecao,'cUF'   ,0);  //NFe2
                  RefNFP.AAMM   := INIRec.ReadString(  sSecao,'AAMM'  ,''); //NFe2
                  RefNFP.CNPJCPF:= INIRec.ReadString(  sSecao,'CNPJ'  ,''); //NFe2
                  RefNFP.IE     := INIRec.ReadString(  sSecao,'IE'    ,''); //NFe2
                  RefNFP.Modelo := INIRec.ReadString(  sSecao,'Modelo',''); //NFe2
                  RefNFP.serie  := INIRec.ReadInteger( sSecao,'Serie' ,0);  //NFe2
                  RefNFP.nNF    := INIRec.ReadInteger( sSecao,'nNF'   ,0);  //NFe2
                end
               else if sTipo = 'CTE' then
                  refCTe         := INIRec.ReadString(  sSecao,'refCTe'  ,'') //NFe2
               else if sTipo = 'ECF' then
                begin
                  RefECF.modelo := StrToECFModRef(ok,INIRec.ReadString(  sSecao,'ModECF'  ,'')) ; //NFe2
                  RefECF.nECF   := INIRec.ReadString(  sSecao,'nECF'  ,''); //NFe2
                  RefECF.nCOO   := INIRec.ReadString(  sSecao,'nCOO'  ,''); //NFe2
                end;
             end;
            Inc(I);
          end;

         Emit.CNPJCPF           := INIRec.ReadString(  'Emitente','CNPJ'    ,'');
         Emit.xNome             := INIRec.ReadString(  'Emitente','Razao'   ,'');
         Emit.xFant             := INIRec.ReadString(  'Emitente','Fantasia','');
         Emit.IE                := INIRec.ReadString(  'Emitente','IE'      ,'');
         Emit.IEST              := INIRec.ReadString(  'Emitente','IEST','');
         Emit.IM                := INIRec.ReadString(  'Emitente','IM'  ,'');
         Emit.CNAE              := INIRec.ReadString(  'Emitente','CNAE','');
         Emit.CRT               := StrToCRT(ok, INIRec.ReadString(  'Emitente','CRT','3')); //NFe2

         Emit.EnderEmit.xLgr    := INIRec.ReadString(  'Emitente','Logradouro' ,'');
         if INIRec.ReadString(  'Emitente','Numero'     ,'') <> '' then
            Emit.EnderEmit.nro     := INIRec.ReadString(  'Emitente','Numero'     ,'');
         if INIRec.ReadString(  'Emitente','Complemento'     ,'') <> '' then
            Emit.EnderEmit.xCpl    := INIRec.ReadString(  'Emitente','Complemento','');
         Emit.EnderEmit.xBairro := INIRec.ReadString(  'Emitente','Bairro'     ,'');
         Emit.EnderEmit.cMun    := INIRec.ReadInteger( 'Emitente','CidadeCod'  ,0);
         Emit.EnderEmit.xMun    := INIRec.ReadString(  'Emitente','Cidade'     ,'');
         Emit.EnderEmit.UF      := INIRec.ReadString(  'Emitente','UF'         ,'');
         Emit.EnderEmit.CEP     := INIRec.ReadInteger( 'Emitente','CEP'  ,0);
         if Emit.EnderEmit.cMun <= 0 then
            Emit.EnderEmit.cMun := ObterCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF);
         Emit.EnderEmit.cPais   := INIRec.ReadInteger( 'Emitente','PaisCod'    ,1058);
         Emit.EnderEmit.xPais   := INIRec.ReadString(  'Emitente','Pais'       ,'BRASIL');
         Emit.EnderEmit.fone    := INIRec.ReadString(  'Emitente','Fone' ,'');

         Ide.cUF       := INIRec.ReadInteger( 'Identificacao','cUF'       ,UFparaCodigo(Emit.EnderEmit.UF));
         Ide.cMunFG    := INIRec.ReadInteger( 'Identificacao','CidadeCod' ,Emit.EnderEmit.cMun);

         if INIRec.ReadString(  'Avulsa','CNPJ','') <> '' then
          begin
            Avulsa.CNPJ    := INIRec.ReadString(  'Avulsa','CNPJ','');
            Avulsa.xOrgao  := INIRec.ReadString(  'Avulsa','xOrgao','');
            Avulsa.matr    := INIRec.ReadString(  'Avulsa','matr','');
            Avulsa.xAgente := INIRec.ReadString(  'Avulsa','xAgente','');
            Avulsa.fone    := INIRec.ReadString(  'Avulsa','fone','');
            Avulsa.UF      := INIRec.ReadString(  'Avulsa','UF','');
            Avulsa.nDAR    := INIRec.ReadString(  'Avulsa','nDAR','');
            Avulsa.dEmi    := NotaUtil.StringToDate(INIRec.ReadString(  'Avulsa','dEmi','0'));
            Avulsa.vDAR    := StringToFloatDef(INIRec.ReadString(  'Avulsa','vDAR',''),0);
            Avulsa.repEmi  := INIRec.ReadString(  'Avulsa','repEmi','');
            Avulsa.dPag    := NotaUtil.StringToDate(INIRec.ReadString(  'Avulsa','dPag','0'));
          end;

         Dest.CNPJCPF           := INIRec.ReadString(  'Destinatario','CNPJ'       ,'');
         Dest.xNome             := INIRec.ReadString(  'Destinatario','NomeRazao'  ,'');
         Dest.IE                := INIRec.ReadString(  'Destinatario','IE'         ,'');
         Dest.ISUF              := INIRec.ReadString(  'Destinatario','ISUF'       ,'');
         Dest.Email             := INIRec.ReadString(  'Destinatario','Email'      ,'');  //NFe2

         Dest.EnderDest.xLgr    := INIRec.ReadString(  'Destinatario','Logradouro' ,'');
         if INIRec.ReadString(  'Destinatario','Numero'     ,'') <> '' then
            Dest.EnderDest.nro     := INIRec.ReadString(  'Destinatario','Numero'     ,'');
         if INIRec.ReadString(  'Destinatario','Complemento','') <> '' then
            Dest.EnderDest.xCpl    := INIRec.ReadString(  'Destinatario','Complemento','');
         Dest.EnderDest.xBairro := INIRec.ReadString(  'Destinatario','Bairro'     ,'');
         Dest.EnderDest.cMun    := INIRec.ReadInteger( 'Destinatario','CidadeCod'  ,0);
         Dest.EnderDest.xMun    := INIRec.ReadString(  'Destinatario','Cidade'     ,'');
         Dest.EnderDest.UF      := INIRec.ReadString(  'Destinatario','UF'         ,'');
         Dest.EnderDest.CEP     := INIRec.ReadInteger( 'Destinatario','CEP'       ,0);
         if Dest.EnderDest.cMun <= 0 then
            Dest.EnderDest.cMun := ObterCodigoMunicipio(Dest.EnderDest.xMun,Dest.EnderDest.UF);
         Dest.EnderDest.cPais   := INIRec.ReadInteger( 'Destinatario','PaisCod'    ,1058);
         Dest.EnderDest.xPais   := INIRec.ReadString(  'Destinatario','Pais'       ,'BRASIL');
         Dest.EnderDest.Fone    := INIRec.ReadString(  'Destinatario','Fone'       ,'');

         if INIRec.ReadString(  'Retirada','CNPJ','') <> '' then
          begin
            Retirada.CNPJCPF := INIRec.ReadString( 'Retirada','CNPJ',INIRec.ReadString( 'Retirada','CPF','')); //NFe2
            Retirada.xLgr    := INIRec.ReadString( 'Retirada','xLgr','');
            Retirada.nro     := INIRec.ReadString( 'Retirada','nro' ,'');
            Retirada.xCpl    := INIRec.ReadString( 'Retirada','xCpl','');
            Retirada.xBairro := INIRec.ReadString( 'Retirada','xBairro','');
            Retirada.cMun    := INIRec.ReadInteger('Retirada','cMun',0);
            Retirada.xMun    := INIRec.ReadString( 'Retirada','xMun','');
            Retirada.UF      := INIRec.ReadString( 'Retirada','UF'  ,'');
          end;

         if INIRec.ReadString(  'Entrega','CNPJ','') <> '' then
          begin
            Entrega.CNPJCPF := INIRec.ReadString(  'Entrega','CNPJ',INIRec.ReadString(  'Entrega','CPF','')); //NFe2
            Entrega.xLgr    := INIRec.ReadString(  'Entrega','xLgr','');
            Entrega.nro     := INIRec.ReadString(  'Entrega','nro' ,'');
            Entrega.xCpl    := INIRec.ReadString(  'Entrega','xCpl','');
            Entrega.xBairro := INIRec.ReadString(  'Entrega','xBairro','');
            Entrega.cMun    := INIRec.ReadInteger( 'Entrega','cMun',0);
            Entrega.xMun    := INIRec.ReadString(  'Entrega','xMun','');
            Entrega.UF      := INIRec.ReadString(  'Entrega','UF','');
          end;

         I := 1 ;

         while true do
          begin
            sSecao    := 'Produto'+IntToStrZero(I,3) ;
            sCodPro   := INIRec.ReadString(sSecao,'Codigo','FIM') ;
            if sCodPro = 'FIM' then
               break ;

            with Det.Add do
             begin
               Prod.nItem := I;
               infAdProd      := INIRec.ReadString(sSecao,'infAdProd','');

               Prod.cProd    := INIRec.ReadString( sSecao,'Codigo'   ,'');
               if Length(INIRec.ReadString( sSecao,'EAN','')) > 0 then
                  Prod.cEAN      := INIRec.ReadString( sSecao,'EAN'      ,'');
               Prod.xProd    := INIRec.ReadString( sSecao,'Descricao','');
               if Length(INIRec.ReadString( sSecao,'NCM','')) > 0 then
                  Prod.NCM       := INIRec.ReadString( sSecao,'NCM'      ,'');
               if Length(INIRec.ReadString( sSecao,'EXTIPI','')) > 0 then
                  Prod.EXTIPI       := INIRec.ReadString( sSecao,'EXTIPI'      ,'');
               Prod.CFOP     := INIRec.ReadString( sSecao,'CFOP'     ,'');
               Prod.uCom     := INIRec.ReadString( sSecao,'Unidade'  ,'');
               Prod.qCom     := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0) ;
               Prod.vUnCom   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnitario','') ,0) ;
               Prod.vProd    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorTotal'   ,'') ,0) ;

               if Length(INIRec.ReadString( sSecao,'cEANTrib','')) > 0 then
                  Prod.cEANTrib      := INIRec.ReadString( sSecao,'cEANTrib'      ,'');
               Prod.uTrib     := INIRec.ReadString( sSecao,'uTrib'  , Prod.uCom);
               Prod.qTrib     := StringToFloatDef( INIRec.ReadString(sSecao,'qTrib'  ,''), Prod.qCom);
               Prod.vUnTrib   := StringToFloatDef( INIRec.ReadString(sSecao,'vUnTrib','') ,Prod.vUnCom) ;

               Prod.vFrete    := StringToFloatDef( INIRec.ReadString(sSecao,'vFrete','') ,0) ;
               Prod.vSeg      := StringToFloatDef( INIRec.ReadString(sSecao,'vSeg','') ,0) ;
               Prod.vDesc     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDesconto','') ,0) ;
               Prod.vOutro    := StringToFloatDef( INIRec.ReadString(sSecao,'vOutro','') ,0) ; //NFe2
               Prod.IndTot    := StrToindTot(OK,INIRec.ReadString(sSecao,'indTot','1'));       //NFe2

               Prod.xPed      := INIRec.ReadString( sSecao,'xPed'    ,'');  //NFe2
               Prod.nItemPed  := INIRec.ReadInteger( sSecao,'nItemPed',0);  //NFe2

               J := 1 ;
               while true do
                begin
                  sSecao      := 'DI'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sNumeroDI := INIRec.ReadString(sSecao,'NumeroDI','') ;

                  if sNumeroDI <> '' then
                   begin
                     with Prod.DI.Add do
                      begin
                        nDi         := sNumeroDI;
                        dDi         := NotaUtil.StringToDate(INIRec.ReadString(sSecao,'DataRegistroDI'  ,'0'));
                        xLocDesemb  := INIRec.ReadString(sSecao,'LocalDesembaraco','');
                        UFDesemb    := INIRec.ReadString(sSecao,'UFDesembaraco'   ,'');
                        dDesemb     := NotaUtil.StringToDate(INIRec.ReadString(sSecao,'DataDesembaraco','0'));
                        cExportador := INIRec.ReadString(sSecao,'CodigoExportador','');;

                        K := 1 ;
                        while true do
                         begin
                           sSecao      := 'LADI'+IntToStrZero(I,3)+IntToStrZero(J,3)+IntToStrZero(K,3)  ;
                           sNumeroADI := INIRec.ReadString(sSecao,'NumeroAdicao','FIM') ;
                           if (sNumeroADI = 'FIM') or (Length(sNumeroADI) <= 0) then
                              break;

                           with adi.Add do
                            begin
                              nAdicao     := StrToInt(sNumeroADI);
                              nSeqAdi     := INIRec.ReadInteger( sSecao,'nSeqAdi',K);
                              cFabricante := INIRec.ReadString(  sSecao,'CodigoFabricante','');
                              vDescDI     := StringToFloatDef( INIRec.ReadString(sSecao,'DescontoADI','') ,0);
                            end;
                           Inc(K)
                         end;
                      end;
                   end
                  else
                    Break;
                  Inc(J);
                end;

              sSecao := 'Veiculo'+IntToStrZero(I,3) ;
              sFim   := INIRec.ReadString( sSecao,'Chassi','FIM') ;
              if (sFim <> 'FIM') then
               begin
                 with Prod.veicProd do
                  begin
                    tpOP    := StrTotpOP(OK,INIRec.ReadString( sSecao,'tpOP','0'));
                    chassi  := sFim;
                    cCor    := INIRec.ReadString( sSecao,'cCor'   ,'');
                    xCor    := INIRec.ReadString( sSecao,'xCor'   ,'');
                    pot     := INIRec.ReadString( sSecao,'pot'    ,'');

                    Cilin   := INIRec.ReadString( sSecao,'CM3'    ,'');    //NFe2
                    if Trim(Cilin) = '' then
                       Cilin   := INIRec.ReadString( sSecao,'Cilin'  ,''); //NFe2

                    pesoL   := INIRec.ReadString( sSecao,'pesoL'  ,'');
                    pesoB   := INIRec.ReadString( sSecao,'pesoB'  ,'');
                    nSerie  := INIRec.ReadString( sSecao,'nSerie' ,'');
                    tpComb  := INIRec.ReadString( sSecao,'tpComb' ,'');
                    nMotor  := INIRec.ReadString( sSecao,'nMotor' ,'');

                    CMT     := INIRec.ReadString( sSecao,'CMKG'   ,'');    //NFe2
                    if Trim(CMT) = '' then
                       CMT     := INIRec.ReadString( sSecao,'CMT'    ,''); //NFe2

                    dist    := INIRec.ReadString( sSecao,'dist'   ,'');
//                    RENAVAM := INIRec.ReadString( sSecao,'RENAVAM','');
                    anoMod  := INIRec.ReadInteger(sSecao,'anoMod' ,0);
                    anoFab  := INIRec.ReadInteger(sSecao,'anoFab' ,0);
                    tpPint  := INIRec.ReadString( sSecao,'tpPint' ,'');
                    tpVeic  := INIRec.ReadInteger(sSecao,'tpVeic' ,0);
                    espVeic := INIRec.ReadInteger(sSecao,'espVeic',0);
                    VIN     := INIRec.ReadString( sSecao,'VIN'    ,'');
                    condVeic := StrTocondVeic(OK,INIRec.ReadString( sSecao,'condVeic','1'));
                    cMod    := INIRec.ReadString( sSecao,'cMod'   ,'');
                    cCorDENATRAN := INIRec.ReadString( sSecao,'cCorDENATRAN',''); //NFe2
                    lota    := INIRec.ReadInteger(sSecao,'lota'   ,0);            //NFe2
                    tpRest  := INIRec.ReadInteger(sSecao,'tpRest' ,0);            //NFe2
                  end;
               end;

               J := 1 ;
               while true do
                begin
                  sSecao := 'Medicamento'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim   := INIRec.ReadString(sSecao,'nLote','FIM') ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0) then
                     break;

                 with Prod.med.Add do
                  begin
                    nLote := sFim;
                    qLote := StringToFloatDef(INIRec.ReadString( sSecao,'qLote',''),0) ;
                    dFab  := NotaUtil.StringToDate(INIRec.ReadString( sSecao,'dFab','0')) ;
                    dVal  := NotaUtil.StringToDate(INIRec.ReadString( sSecao,'dVal','0')) ;
                    vPMC  := StringToFloatDef(INIRec.ReadString( sSecao,'vPMC',''),0) ;
                   end;
                  Inc(J)
                end;

               J := 1 ;
               while true do
                begin
                  sSecao := 'Arma'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim   := INIRec.ReadString(sSecao,'nSerie','FIM') ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0) then
                     break;

                 with Prod.arma.Add do
                  begin
                    tpArma := StrTotpArma(OK,INIRec.ReadString( sSecao,'tpArma','0')) ;
                    nSerie := sFim;
                    nCano  := INIRec.ReadString( sSecao,'nCano','') ;
                    descr  := INIRec.ReadString( sSecao,'descr','') ;
                   end;
                  Inc(J)
                end;

              sSecao := 'Combustivel'+IntToStrZero(I,3) ;
              sFim   := INIRec.ReadString( sSecao,'cProdANP','FIM') ;
              if (sFim <> 'FIM') then
               begin
                 with Prod.comb do
                  begin
                    cProdANP := INIRec.ReadInteger( sSecao,'cProdANP',0) ;
                    CODIF    := INIRec.ReadString(  sSecao,'CODIF'   ,'') ;
                    qTemp    := StringToFloatDef(INIRec.ReadString( sSecao,'qTemp',''),0) ;
                    UFcons   := INIRec.ReadString( sSecao,'UFCons','') ;

                    sSecao := 'CIDE'+IntToStrZero(I,3) ;
                    CIDE.qBCprod   := StringToFloatDef(INIRec.ReadString( sSecao,'qBCprod'  ,''),0) ;
                    CIDE.vAliqProd := StringToFloatDef(INIRec.ReadString( sSecao,'vAliqProd',''),0) ;
                    CIDE.vCIDE     := StringToFloatDef(INIRec.ReadString( sSecao,'vCIDE'    ,''),0) ;

                    sSecao := 'ICMSComb'+IntToStrZero(I,3) ;
                    ICMS.vBCICMS   := StringToFloatDef(INIRec.ReadString( sSecao,'vBCICMS'  ,''),0) ;
                    ICMS.vICMS     := StringToFloatDef(INIRec.ReadString( sSecao,'vICMS'    ,''),0) ;
                    ICMS.vBCICMSST := StringToFloatDef(INIRec.ReadString( sSecao,'vBCICMSST',''),0) ;
                    ICMS.vICMSST   := StringToFloatDef(INIRec.ReadString( sSecao,'vICMSST'  ,''),0) ;

                    sSecao := 'ICMSInter'+IntToStrZero(I,3) ;
                    sFim   := INIRec.ReadString( sSecao,'vBCICMSSTDest','FIM') ;
                    if (sFim <> 'FIM') then
                     begin
                       ICMSInter.vBCICMSSTDest := StringToFloatDef(sFim,0) ;
                       ICMSInter.vICMSSTDest   := StringToFloatDef(INIRec.ReadString( sSecao,'vICMSSTDest',''),0) ;
                     end;

                    sSecao := 'ICMSCons'+IntToStrZero(I,3) ;
                    sFim   := INIRec.ReadString( sSecao,'vBCICMSSTCons','FIM') ;
                    if (sFim <> 'FIM') then
                     begin
                       ICMSCons.vBCICMSSTCons := StringToFloatDef(sFim,0) ;
                       ICMSCons.vICMSSTCons   := StringToFloatDef(INIRec.ReadString( sSecao,'vICMSSTCons',''),0) ;
                       ICMSCons.UFcons        := INIRec.ReadString( sSecao,'UFCons','') ;
                     end;
                  end;
               end;

               with Imposto do
                begin
                   sSecao := 'ICMS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST',INIRec.ReadString(sSecao,'CSOSN','FIM')) ;
                   if (sFim <> 'FIM') then
                    begin
                      with ICMS do
                      begin
                        ICMS.orig       := StrToOrig(     OK, INIRec.ReadString(sSecao,'Origem'    ,'0' ));
                        CST             := StrToCSTICMS(  OK, INIRec.ReadString(sSecao,'CST'       ,'00'));
                        CSOSN           := StrToCSOSNIcms(OK, INIRec.ReadString(sSecao,'CSOSN'     ,''  ));     //NFe2
                        ICMS.modBC      := StrTomodBC(    OK, INIRec.ReadString(sSecao,'Modalidade','0' ));
                        ICMS.pRedBC     := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                        ICMS.vBC        := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS.pICMS      := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS.vICMS      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                        ICMS.modBCST    := StrTomodBCST(OK, INIRec.ReadString(sSecao,'ModalidadeST','0'));
                        ICMS.pMVAST     := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST' ,'') ,0);
                        ICMS.pRedBCST   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                        ICMS.vBCST      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                        ICMS.pICMSST    := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                        ICMS.vICMSST    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                        ICMS.UFST       := INIRec.ReadString(sSecao,'UFST'    ,'');                           //NFe2
                        ICMS.pBCOp      := StringToFloatDef( INIRec.ReadString(sSecao,'pBCOp'    ,'') ,0);    //NFe2
                        ICMS.vBCSTRet   := StringToFloatDef( INIRec.ReadString(sSecao,'vBCSTRet','') ,0);     //NFe2
                        ICMS.vICMSSTRet := StringToFloatDef( INIRec.ReadString(sSecao,'vICMSSTRet','') ,0);   //NFe2
                        ICMS.motDesICMS := StrTomotDesICMS(OK, INIRec.ReadString(sSecao,'motDesICMS','0'));   //NFe2
                        ICMS.pCredSN    := StringToFloatDef( INIRec.ReadString(sSecao,'pCredSN','') ,0);      //NFe2
                        ICMS.vCredICMSSN:= StringToFloatDef( INIRec.ReadString(sSecao,'vCredICMSSN','') ,0);  //NFe2
                        ICMS.vBCSTDest  := StringToFloatDef( INIRec.ReadString(sSecao,'vBCSTDest','') ,0);    //NFe2
                        ICMS.vICMSSTDest:= StringToFloatDef( INIRec.ReadString(sSecao,'vICMSSTDest','') ,0);   //NFe2
                      end;
                    end;

                   sSecao := 'IPI'+IntToStrZero(I,3) ;
                   sFim  := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with IPI do
                      begin
                        CST      := StrToCSTIPI(OK, INIRec.ReadString( sSecao,'CST','')) ;
                        clEnq    := INIRec.ReadString(  sSecao,'ClasseEnquadramento','');
                        CNPJProd := INIRec.ReadString(  sSecao,'CNPJProdutor'       ,'');
                        cSelo    := INIRec.ReadString(  sSecao,'CodigoSeloIPI'      ,'');
                        qSelo    := INIRec.ReadInteger( sSecao,'QuantidadeSelos'    ,0);
                        cEnq     := INIRec.ReadString(  sSecao,'CodigoEnquadramento','');

                        vBC    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'   ,'') ,0);
                        qUnid  := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'  ,'') ,0);
                        vUnid  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnidade','') ,0);
                        pIPI   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'    ,'') ,0);
                        vIPI   := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'       ,'') ,0);
                      end;
                    end;

                   sSecao   := 'II'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with II do
                      begin
                        vBc      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        vDespAdu := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDespAduaneiras'   ,'') ,0);
                        vII      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorII'  ,'') ,0);
                        vIOF     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorIOF' ,'') ,0);
                      end;
                    end;

                   sSecao    := 'PIS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with PIS do
                       begin
                        CST :=  StrToCSTPIS(OK, INIRec.ReadString( sSecao,'CST','01'));

                        PIS.vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'     ,'') ,0);
                        PIS.pPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                        PIS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                        PIS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'ValorAliquota'  ,'') ,0);
                        PIS.vPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor' ,'') ,0);
                       end;
                    end;

                   sSecao    := 'PISST'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','F')+ INIRec.ReadString( sSecao,'Quantidade','IM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with PISST do
                      begin
                        vBc       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,'') ,0);
                        pPis      := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaPerc' ,'') ,0);
                        qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0);
                        vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaValor','') ,0);
                        vPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorPISST'   ,'') ,0);
                      end;
                    end;

                   sSecao    := 'COFINS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with COFINS do
                      begin
                        CST := StrToCSTCOFINS(OK, INIRec.ReadString( sSecao,'CST','01'));

                        COFINS.vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'     ,'') ,0);
                        COFINS.pCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                        COFINS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                        COFINS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'ValorAliquota'  ,'') ,0);
                        COFINS.vCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'Valor' ,'') ,0);
                      end;
                    end;

                   sSecao    := 'COFINSST'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','F')+ INIRec.ReadString( sSecao,'Quantidade','IM');
                   if (sFim <> 'FIM') then
                    begin
                     with COFINSST do
                      begin
                         vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,'') ,0);
                         pCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaPerc' ,'') ,0);
                         qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0);
                         vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaValor','') ,0);
                         vCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorCOFINSST','') ,0);
                       end;
                    end;

                   sSecao    := 'ISSQN'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with ISSQN do
                      begin
                        if StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,'') ,0) > 0 then
                         begin
                           vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,'') ,0);
                           vAliq     := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           vISSQN    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorISSQN'   ,'') ,0);
                           cMunFG    := StrToInt( INIRec.ReadString(sSecao,'MunicipioFatoGerador',''));
                           cListServ := INIRec.ReadInteger(sSecao,'CodigoServico',0);
                           cSitTrib  := StrToISSQNcSitTrib( OK,INIRec.ReadString(sSecao,'cSitTrib','')) ; //NFe2
                         end;
                      end;
                    end;
                end;

             end;
            Inc( I ) ;
          end ;

         Total.ICMSTot.vBC     := StringToFloatDef( INIRec.ReadString('Total','BaseICMS'     ,'') ,0) ;
         Total.ICMSTot.vICMS   := StringToFloatDef( INIRec.ReadString('Total','ValorICMS'    ,'') ,0) ;
         Total.ICMSTot.vBCST   := StringToFloatDef( INIRec.ReadString('Total','BaseICMSSubstituicao' ,'') ,0) ;
         Total.ICMSTot.vST     := StringToFloatDef( INIRec.ReadString('Total','ValorICMSSubstituicao','') ,0) ;
         Total.ICMSTot.vProd   := StringToFloatDef( INIRec.ReadString('Total','ValorProduto' ,'') ,0) ;
         Total.ICMSTot.vFrete  := StringToFloatDef( INIRec.ReadString('Total','ValorFrete'   ,'') ,0) ;
         Total.ICMSTot.vSeg    := StringToFloatDef( INIRec.ReadString('Total','ValorSeguro'  ,'') ,0) ;
         Total.ICMSTot.vDesc   := StringToFloatDef( INIRec.ReadString('Total','ValorDesconto','') ,0) ;
         Total.ICMSTot.vII     := StringToFloatDef( INIRec.ReadString('Total','ValorII'      ,'') ,0) ;
         Total.ICMSTot.vIPI    := StringToFloatDef( INIRec.ReadString('Total','ValorIPI'     ,'') ,0) ;
         Total.ICMSTot.vPIS    := StringToFloatDef( INIRec.ReadString('Total','ValorPIS'     ,'') ,0) ;
         Total.ICMSTot.vCOFINS := StringToFloatDef( INIRec.ReadString('Total','ValorCOFINS'  ,'') ,0) ;
         Total.ICMSTot.vOutro  := StringToFloatDef( INIRec.ReadString('Total','ValorOutrasDespesas','') ,0) ;
         Total.ICMSTot.vNF     := StringToFloatDef( INIRec.ReadString('Total','ValorNota'    ,'') ,0) ;

         Total.ISSQNtot.vServ  := StringToFloatDef( INIRec.ReadString('Total','ValorServicos','') ,0) ;
         Total.ISSQNTot.vBC    := StringToFloatDef( INIRec.ReadString('Total','ValorBaseISS','') ,0) ;
         Total.ISSQNTot.vISS   := StringToFloatDef( INIRec.ReadString('Total','ValorISSQN','') ,0) ;
         Total.ISSQNTot.vPIS   := StringToFloatDef( INIRec.ReadString('Total','ValorPISISS','') ,0) ;
         Total.ISSQNTot.vCOFINS := StringToFloatDef( INIRec.ReadString('Total','ValorCONFINSISS','') ,0) ;

         Total.retTrib.vRetPIS    := StringToFloatDef( INIRec.ReadString('retTrib','vRetPIS'   ,'') ,0) ;
         Total.retTrib.vRetCOFINS := StringToFloatDef( INIRec.ReadString('retTrib','vRetCOFINS','') ,0) ;
         Total.retTrib.vRetCSLL   := StringToFloatDef( INIRec.ReadString('retTrib','vRetCSLL'  ,'') ,0) ;
         Total.retTrib.vBCIRRF    := StringToFloatDef( INIRec.ReadString('retTrib','vBCIRRF'   ,'') ,0) ;
         Total.retTrib.vIRRF      := StringToFloatDef( INIRec.ReadString('retTrib','vIRRF'     ,'') ,0) ;
         Total.retTrib.vBCRetPrev := StringToFloatDef( INIRec.ReadString('retTrib','vBCRetPrev','') ,0) ;
         Total.retTrib.vRetPrev   := StringToFloatDef( INIRec.ReadString('retTrib','vRetPrev'  ,'') ,0) ;

         Transp.modFrete := StrTomodFrete(OK, INIRec.ReadString('Transportador','FretePorConta','0'));
         Transp.Transporta.CNPJCPF  := INIRec.ReadString('Transportador','CnpjCpf'  ,'');
         Transp.Transporta.xNome    := INIRec.ReadString('Transportador','NomeRazao','');
         Transp.Transporta.IE       := INIRec.ReadString('Transportador','IE'       ,'');
         Transp.Transporta.xEnder   := INIRec.ReadString('Transportador','Endereco' ,'');
         Transp.Transporta.xMun     := INIRec.ReadString('Transportador','Cidade'   ,'');
         Transp.Transporta.UF       := INIRec.ReadString('Transportador','UF'       ,'');

         Transp.retTransp.vServ    := StringToFloatDef( INIRec.ReadString('Transportador','ValorServico','') ,0) ;
         Transp.retTransp.vBCRet   := StringToFloatDef( INIRec.ReadString('Transportador','ValorBase'   ,'') ,0) ;
         Transp.retTransp.pICMSRet := StringToFloatDef( INIRec.ReadString('Transportador','Aliquota'    ,'') ,0) ;
         Transp.retTransp.vICMSRet := StringToFloatDef( INIRec.ReadString('Transportador','Valor'       ,'') ,0) ;
         Transp.retTransp.CFOP     := INIRec.ReadString('Transportador','CFOP'     ,'');
         Transp.retTransp.cMunFG   := INIRec.ReadInteger('Transportador','CidadeCod',0);

         Transp.veicTransp.placa := INIRec.ReadString('Transportador','Placa'  ,'');
         Transp.veicTransp.UF    := INIRec.ReadString('Transportador','UFPlaca','');
         Transp.veicTransp.RNTC  := INIRec.ReadString('Transportador','RNTC'   ,'');

         Transp.vagao := INIRec.ReadString( 'Transportador','vagao','') ;  //NFe2
         Transp.balsa := INIRec.ReadString( 'Transportador','balsa','') ;  //NFe2

         J := 1 ;
         while true do
          begin
            sSecao := 'Reboque'+IntToStrZero(J,3) ;
            sFim   := INIRec.ReadString(sSecao,'placa','FIM') ;
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break;

            with Transp.Reboque.Add do
             begin
               placa := sFim;
               UF    := INIRec.ReadString( sSecao,'UF'  ,'') ;
               RNTC  := INIRec.ReadString( sSecao,'RNTC','') ;
             end;
            Inc(J)
          end;

         I := 1 ;
         while true do
          begin
            sSecao    := 'Volume'+IntToStrZero(I,3) ;
            sQtdVol   := INIRec.ReadString(sSecao,'Quantidade','FIM') ;
            if (sQtdVol = 'FIM') or (Length(sQtdVol) <= 0)  then
               break ;

            with Transp.Vol.Add do
             begin
               qVol  := StrToInt(sQtdVol);
               esp   := INIRec.ReadString( sSecao,'Especie'  ,'');
               marca := INIRec.ReadString( sSecao,'Marca'    ,'');
               nVol  := INIRec.ReadString( sSecao,'Numeracao','');
               pesoL := StringToFloatDef( INIRec.ReadString(sSecao,'PesoLiquido','') ,0) ;
               pesoB := StringToFloatDef( INIRec.ReadString(sSecao,'PesoBruto'  ,'') ,0) ;

               J := 1;
               while true do
                begin
                  sSecao := 'Lacre'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim   := INIRec.ReadString(sSecao,'nLacre','FIM') ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                     break ;

                  Lacres.Add.nLacre := sFim;

                  Inc(J);
                end;
             end;
            Inc(I);
          end;

         Cobr.Fat.nFat    := INIRec.ReadString( 'Fatura','Numero','');
         Cobr.Fat.vOrig := StringToFloatDef( INIRec.ReadString('Fatura','ValorOriginal','') ,0) ;
         Cobr.Fat.vDesc := StringToFloatDef( INIRec.ReadString('Fatura','ValorDesconto','') ,0) ;
         Cobr.Fat.vLiq  := StringToFloatDef( INIRec.ReadString('Fatura','ValorLiquido' ,'') ,0) ;

         I := 1 ;
         while true do
          begin
            sSecao    := 'Duplicata'+IntToStrZero(I,3) ;
            sNumDup   := INIRec.ReadString(sSecao,'Numero','FIM') ;
            if (sNumDup = 'FIM') or (Length(sNumDup) <= 0) then
               break ;

            with Cobr.Dup.Add do
             begin
               nDup  := sNumDup;
               dVenc := NotaUtil.StringToDate(INIRec.ReadString( sSecao,'DataVencimento','0'));
               vDup  := StringToFloatDef( INIRec.ReadString(sSecao,'Valor','') ,0) ;
             end;
            Inc(I);
          end;

         InfAdic.infAdFisco :=  INIRec.ReadString( 'DadosAdicionais','Fisco','');
         InfAdic.infCpl     :=  INIRec.ReadString( 'DadosAdicionais','Complemento','');

         I := 1 ;
         while true do
          begin
            sSecao     := 'InfAdic'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'Campo','FIM') ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with InfAdic.obsCont.Add do
             begin
               xCampo := sCampoAdic;
               xTexto := INIRec.ReadString( sSecao,'Texto','');
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao     := 'ObsFisco'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'Campo','FIM') ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with InfAdic.obsFisco.Add do
             begin
               xCampo := sCampoAdic;
               xTexto := INIRec.ReadString( sSecao,'Texto','');
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao     := 'procRef'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'nProc','FIM') ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with InfAdic.procRef.Add do
             begin
               nProc := sCampoAdic;
               indProc := StrToindProc(OK,INIRec.ReadString( sSecao,'indProc','0'));
             end;
            Inc(I);
          end;

         sFim   := INIRec.ReadString( 'Exporta','UFembarq','FIM') ;
         if (sFim <> 'FIM') then
          begin
            exporta.UFembarq   := sFim;
            exporta.xLocEmbarq := INIRec.ReadString( 'Exporta','xLocEmbarq','');
          end;

         sFim   := INIRec.ReadString( 'Compra','xNEmp','FIM') ;
         if (sFim <> 'FIM') then
          begin
            compra.xNEmp := sFim;
            compra.xPed  := INIRec.ReadString( 'Compra','xPed','');
            compra.xCont := INIRec.ReadString( 'Compra','xCont','');
          end;

         cana.safra  := INIRec.ReadString( 'cana','safra','');  //NFe2
         cana.ref    := INIRec.ReadString( 'cana','ref'  ,'');  //NFe2
         cana.qTotMes := StringToFloatDef( INIRec.ReadString('cana','qTotMes','') ,0) ; //NFe2
         cana.qTotAnt := StringToFloatDef( INIRec.ReadString('cana','qTotAnt','') ,0) ; //NFe2
         cana.qTotGer := StringToFloatDef( INIRec.ReadString('cana','qTotGer','') ,0) ; //NFe2
         cana.vFor    := StringToFloatDef( INIRec.ReadString('cana','vFor'   ,'') ,0) ; //NFe2
         cana.vTotDed := StringToFloatDef( INIRec.ReadString('cana','vTotDed','') ,0) ; //NFe2
         cana.vLiqFor := StringToFloatDef( INIRec.ReadString('cana','vLiqFor','') ,0) ; //NFe2

         I := 1 ;
         while true do
          begin
            sSecao    := 'forDia'+IntToStrZero(I,3) ;
            sDia      := INIRec.ReadString(sSecao,'dia','FIM') ;
            if (sDia = 'FIM') or (Length(sDia) <= 0) then
               break ;

            with cana.fordia.Add do
             begin
               dia     := StrToInt(sDia);                                                //NFe2
               qtde    := StringToFloatDef( INIRec.ReadString(sSecao,'qtde'   ,'') ,0) ; //NFe2
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao    := 'deduc'+IntToStrZero(I,3) ;
            sDeduc    := INIRec.ReadString(sSecao,'xDed','FIM') ;
            if (sDeduc = 'FIM') or (Length(sDeduc) <= 0) then
               break ;

            with cana.deduc.Add do
             begin
               xDed    := sDeduc;                                                        //NFe2
               vDed    := StringToFloatDef( INIRec.ReadString(sSecao,'vDed'   ,'') ,0) ; //NFe2
             end;
            Inc(I);
          end;
       end;
   finally
      INIRec.Free ;
   end;
  end;
end;

function GerarNFeIni( XML : WideString ) : WideString;
var
  I, J, K : Integer;
  sSecao : String;
  INIRec : TMemIniFile ;
  OK     : boolean;
  IniNFe : TStringList;
  LocNFeR : TNFeR;
begin
 INIRec := TMemIniFile.create( 'nfe.ini' ) ;
 frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Clear;
 if FilesExists(XML) then
    frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.LoadFromFile(XML)
 else
  begin
    LocNFeR := TNFeR.Create(frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Add.NFe);
    try
       LocNFeR.Leitor.Arquivo := ConvertStrRecived( XML );
       LocNFeR.LerXml;
       frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Items[0].XML := LocNFeR.Leitor.Arquivo;
       frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.GerarNFe;
    finally
       LocNFeR.Free;
    end;
  end;

 with frmAcbrNfeMonitor do
  begin
   try
      with ACBrNFe1.NotasFiscais.Items[0].NFe do
       begin
         INIRec.WriteInteger('Identificacao','cUF'     ,Ide.cUF);
         INIRec.WriteInteger('Identificacao','Codigo'  ,Ide.cNF);
         INIRec.WriteString( 'Identificacao','NaturezaOperacao' ,Ide.natOp);
         INIRec.WriteString( 'Identificacao','FormaPag',IndpagToStr(Ide.indPag));
         INIRec.WriteInteger('Identificacao','Modelo'  ,Ide.modelo);
         INIRec.WriteInteger('Identificacao','Serie'   ,Ide.serie);
         INIRec.WriteInteger('Identificacao','Numero'  ,Ide.nNF);
         INIRec.WriteString( 'Identificacao','Emissao' ,DateToStr(Ide.dEmi));
         INIRec.WriteString( 'Identificacao','Saida'   ,DateToStr(Ide.dSaiEnt));
         INIRec.WriteString( 'Identificacao','hSaiEnt' ,TimeToStr(Ide.hSaiEnt));
         INIRec.WriteString( 'Identificacao','Tipo'    ,tpNFToStr(Ide.tpNF ));
         INIRec.WriteInteger('Identificacao','CidadeCod' ,Ide.cMunFG);
         INIRec.WriteString( 'Identificacao','tpAmb'   ,TpAmbToStr(Ide.tpAmb ));
         INIRec.WriteString( 'Identificacao','tpImp'   ,TpImpToStr(Ide.tpImp ));
         INIRec.WriteString( 'Identificacao','tpemis'  ,TpEmisToStr(Ide.tpemis ));
         INIRec.WriteString( 'Identificacao','Finalidade',FinNFeToStr(Ide.finNFe));
         INIRec.WriteString( 'Identificacao','procEmi' ,procEmiToStr(Ide.procEmi) );
         INIRec.WriteString( 'Identificacao','verProc' ,Ide.verProc );
         INIRec.WriteString( 'Identificacao','dhCont'  ,DateToStr(Ide.dhCont));
         INIRec.WriteString( 'Identificacao','xJust'   ,Ide.xJust);

         for I:= 0 to Ide.NFref.Count -1 do
          begin
            with Ide.NFref.Items[i] do
             begin
               sSecao    := 'NFRef'+IntToStrZero(I+1,3) ;
               if trim(refNFe) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','NFe') ;
                  INIRec.WriteString(  sSecao,'refNFe',refNFe) ;
                end
               else if trim(RefNF.CNPJ) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','NF') ;
                  INIRec.WriteInteger( sSecao,'cUF'   ,RefNF.cUF);
                  INIRec.WriteString(  sSecao,'AAMM'  ,RefNF.AAMM);
                  INIRec.WriteString(  sSecao,'CNPJ'  ,RefNF.CNPJ);
                  INIRec.WriteInteger( sSecao,'Modelo',RefNF.modelo);
                  INIRec.WriteInteger( sSecao,'Serie' ,RefNF.serie);
                  INIRec.WriteInteger( sSecao,'nNF'   ,RefNF.nNF);
                end
               else if trim(RefNFP.CNPJCPF) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','NFP') ;
                  INIRec.WriteInteger( sSecao,'cUF'   ,RefNFP.cUF);
                  INIRec.WriteString(  sSecao,'AAMM'  ,RefNFP.AAMM);
                  INIRec.WriteString(  sSecao,'CNPJ'  ,RefNFP.CNPJCPF);
                  INIRec.WriteString(  sSecao,'IE'    ,RefNFP.IE);
                  INIRec.WriteString(  sSecao,'Modelo',RefNFP.modelo);
                  INIRec.WriteInteger( sSecao,'Serie' ,RefNFP.serie);
                  INIRec.WriteInteger( sSecao,'nNF'   ,RefNFP.nNF);
                end
               else if trim(refCTe) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','CTe') ;
                  INIRec.WriteString(  sSecao,'reCTe',refCTe) ;
                end
               else if trim(RefECF.nCOO) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','ECF') ;
                  INIRec.WriteString(  sSecao,'modelo'  ,ECFModRefToStr(RefECF.modelo));
                  INIRec.WriteString(  sSecao,'nECF'  ,RefECF.nECF);
                  INIRec.WriteString(  sSecao,'nCOO'  ,RefECF.nCOO);
                end;
             end;
          end;

         INIRec.WriteString(  'Emitente','CNPJ'    ,Emit.CNPJCPF );
         INIRec.WriteString(  'Emitente','Razao'   ,Emit.xNome);
         INIRec.WriteString(  'Emitente','Fantasia', Emit.xFant );
         INIRec.WriteString(  'Emitente','IE'      ,Emit.IE);
         INIRec.WriteString(  'Emitente','IEST',Emit.IEST);
         INIRec.WriteString(  'Emitente','IM'  ,Emit.IM);
         INIRec.WriteString(  'Emitente','CNAE',Emit.CNAE);
         INIRec.WriteString(  'Emitente','CRT' ,CRTToStr(Emit.CRT));

         INIRec.WriteString(  'Emitente','Logradouro' ,Emit.EnderEmit.xLgr);
         INIRec.WriteString(  'Emitente','Numero'     ,Emit.EnderEmit.nro);
         INIRec.WriteString(  'Emitente','Complemento',Emit.EnderEmit.xCpl);
         INIRec.WriteString(  'Emitente','Bairro'     ,Emit.EnderEmit.xBairro);
         INIRec.WriteInteger( 'Emitente','CidadeCod'  ,Emit.EnderEmit.cMun);
         INIRec.WriteString(  'Emitente','Cidade'     ,Emit.EnderEmit.xMun);
         INIRec.WriteString(  'Emitente','UF'         ,Emit.EnderEmit.UF);
         INIRec.WriteInteger( 'Emitente','CEP'        ,Emit.EnderEmit.CEP);
         INIRec.WriteInteger( 'Emitente','PaisCod'    ,Emit.EnderEmit.cPais);
         INIRec.WriteString(  'Emitente','Pais'       ,Emit.EnderEmit.xPais);
         INIRec.WriteString(  'Emitente','Fone'       ,Emit.EnderEmit.fone);

         if Avulsa.CNPJ  <> '' then
          begin
            INIRec.WriteString(  'Avulsa','CNPJ'   ,Avulsa.CNPJ);
            INIRec.WriteString(  'Avulsa','xOrgao' ,Avulsa.xOrgao);
            INIRec.WriteString(  'Avulsa','matr'   ,Avulsa.matr );
            INIRec.WriteString(  'Avulsa','xAgente',Avulsa.xAgente);
            INIRec.WriteString(  'Avulsa','fone'   ,Avulsa.fone);
            INIRec.WriteString(  'Avulsa','UF'     ,Avulsa.UF);
            INIRec.WriteString(  'Avulsa','nDAR'   ,Avulsa.nDAR);
            INIRec.WriteString(  'Avulsa','dEmi'   ,DateToStr(Avulsa.dEmi));
            INIRec.WriteFloat(   'Avulsa','vDAR'   ,Avulsa.vDAR);
            INIRec.WriteString(  'Avulsa','repEmi' ,Avulsa.repEmi);
            INIRec.WriteString(  'Avulsa','dPag'   ,DateToStr(Avulsa.dPag));
          end;

         INIRec.WriteString(  'Destinatario','CNPJ'       ,Dest.CNPJCPF);
         INIRec.WriteString(  'Destinatario','NomeRazao'  ,Dest.xNome);
         INIRec.WriteString(  'Destinatario','IE'         ,Dest.IE);
         INIRec.WriteString(  'Destinatario','ISUF'       ,Dest.ISUF);
         INIRec.WriteString(  'Destinatario','Email'      ,Dest.Email);

         INIRec.WriteString(  'Destinatario','Logradouro' ,Dest.EnderDest.xLgr);
         INIRec.WriteString(  'Destinatario','Numero'     ,Dest.EnderDest.nro);
         INIRec.WriteString(  'Destinatario','Complemento',Dest.EnderDest.xCpl);
         INIRec.WriteString(  'Destinatario','Bairro'     ,Dest.EnderDest.xBairro);
         INIRec.WriteInteger( 'Destinatario','CidadeCod'  ,Dest.EnderDest.cMun);
         INIRec.WriteString(  'Destinatario','Cidade'     ,Dest.EnderDest.xMun);
         INIRec.WriteString(  'Destinatario','UF'         ,Dest.EnderDest.UF );
         INIRec.WriteInteger( 'Destinatario','CEP'        ,Dest.EnderDest.CEP);
         INIRec.WriteInteger( 'Destinatario','PaisCod'    ,Dest.EnderDest.cPais);
         INIRec.WriteString(  'Destinatario','Pais'       ,Dest.EnderDest.xPais);
         INIRec.WriteString(  'Destinatario','Fone'       ,Dest.EnderDest.Fone);

         if Retirada.CNPJCPF <> '' then
          begin
            INIRec.WriteString( 'Retirada','CNPJ',Retirada.CNPJCPF);
            INIRec.WriteString( 'Retirada','xLgr',Retirada.xLgr);
            INIRec.WriteString( 'Retirada','nro' ,Retirada.nro);
            INIRec.WriteString( 'Retirada','xCpl',Retirada.xCpl);
            INIRec.WriteString( 'Retirada','xBairro',Retirada.xBairro);
            INIRec.WriteInteger('Retirada','cMun',Retirada.cMun);
            INIRec.WriteString( 'Retirada','xMun',Retirada.xMun);
            INIRec.WriteString( 'Retirada','UF'  ,Retirada.UF);
          end;

         if Entrega.CNPJCPF <> '' then
          begin
            INIRec.WriteString(  'Entrega','CNPJ',Entrega.CNPJCPF);
            INIRec.WriteString(  'Entrega','xLgr',Entrega.xLgr);
            INIRec.WriteString(  'Entrega','nro' ,Entrega.nro);
            INIRec.WriteString(  'Entrega','xCpl',Entrega.xCpl);
            INIRec.WriteString(  'Entrega','xBairro',Entrega.xBairro);
            INIRec.WriteInteger( 'Entrega','cMun',Entrega.cMun);
            INIRec.WriteString(  'Entrega','xMun',Entrega.xMun);
            INIRec.WriteString(  'Entrega','UF'  ,Entrega.UF);
          end;

         for I := 0 to Det.Count-1 do
          begin
            with Det.Items[I] do
             begin
               sSecao    := 'Produto'+IntToStrZero(I+1,3) ;
               INIRec.WriteInteger( sSecao,'nItem'    ,Prod.nItem );
               INIRec.WriteString(  sSecao,'infAdProd',infAdProd);

               INIRec.WriteString(  sSecao,'Codigo'   ,Prod.cProd );
               INIRec.WriteString(  sSecao,'EAN'      ,Prod.cEAN);
               INIRec.WriteString(  sSecao,'Descricao',Prod.xProd);
               INIRec.WriteString(  sSecao,'NCM'      ,Prod.NCM);
               INIRec.WriteString(  sSecao,'EXTIPI'   ,Prod.EXTIPI);
               INIRec.WriteString( sSecao,'CFOP'      ,Prod.CFOP);
               INIRec.WriteString( sSecao,'Unidade'   ,Prod.uCom);
               INIRec.WriteFloat(sSecao,'Quantidade'   ,Prod.qCom) ;
               INIRec.WriteFloat(sSecao,'ValorUnitario',Prod.vUnCom) ;
               INIRec.WriteFloat(sSecao,'ValorTotal'   ,Prod.vProd) ;

               INIRec.WriteString( sSecao,'cEANTrib'      ,Prod.cEANTrib);
               INIRec.WriteString( sSecao,'uTrib'  , Prod.uTrib);
               INIRec.WriteFloat(sSecao,'qTrib'  ,Prod.qTrib);
               INIRec.WriteFloat(sSecao,'vUnTrib',Prod.vUnTrib) ;

               INIRec.WriteFloat(sSecao,'vFrete',Prod.vFrete) ;
               INIRec.WriteFloat(sSecao,'vSeg',Prod.vSeg) ;
               INIRec.WriteFloat(sSecao,'ValorDesconto',Prod.vDesc) ;
               INIRec.WriteFloat(sSecao,'vOutro',Prod.vOutro) ;
               INIRec.WriteString(sSecao,'IndTot',indTotToStr(Prod.IndTot));

               INIRec.WriteString(  sSecao,'xPed'     , Prod.xPed);
               INIRec.WriteInteger( sSecao,'nItemPed' , Prod.nItemPed);

               for J:=0 to Prod.DI.Count-1 do
                begin
                  if Prod.DI.Items[j].nDi <> '' then
                   begin
                     with Prod.DI.Items[j] do
                      begin
                        sSecao      := 'DI'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                        INIRec.WriteString(sSecao,'NumeroDI',nDi);
                        INIRec.WriteString(sSecao,'DataRegistroDI'  ,DateToStr(dDi));
                        INIRec.WriteString(sSecao,'LocalDesembaraco',xLocDesemb);
                        INIRec.WriteString(sSecao,'UFDesembaraco'   ,UFDesemb);
                        INIRec.WriteString(sSecao,'DataDesembaraco',DateToStr(dDesemb));
                        INIRec.WriteString(sSecao,'CodigoExportador',cExportador);;

                        for K:=0 to adi.Count-1 do
                         begin
                           with adi.Items[K] do
                            begin
                              sSecao      := 'LADI'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3)+IntToStrZero(K+1,3)  ;
                              INIRec.WriteInteger(sSecao,'NumeroAdicao',nAdicao) ;
                              INIRec.WriteInteger(sSecao,'nSeqAdi'     ,nSeqAdi) ;
                              INIRec.WriteString( sSecao,'CodigoFrabricante',cFabricante);
                              INIRec.WriteFloat(  sSecao,'DescontoADI' ,vDescDI);
                            end;
                         end;
                      end;
                   end
                  else
                    Break;
                end;

              if Prod.veicProd.chassi <> '' then
               begin
                 sSecao := 'Veiculo'+IntToStrZero(I+1,3) ;
                 with Prod.veicProd do
                  begin
                    INIRec.WriteString( sSecao,'tpOP'  ,tpOPToStr(tpOP));
                    INIRec.WriteString( sSecao,'Chassi',chassi) ;
                    INIRec.WriteString( sSecao,'cCor'   ,cCor);
                    INIRec.WriteString( sSecao,'xCor'   ,xCor);
                    INIRec.WriteString( sSecao,'pot'    ,pot);
                    INIRec.WriteString( sSecao,'CM3'    ,Cilin);  //Mantido por compatibilidade com NFe 1.1
                    INIRec.WriteString( sSecao,'Cilin'  ,Cilin);                    
                    INIRec.WriteString( sSecao,'pesoL'  ,pesoL);
                    INIRec.WriteString( sSecao,'pesoB'  ,pesoB);
                    INIRec.WriteString( sSecao,'nSerie' ,nSerie);
                    INIRec.WriteString( sSecao,'tpComb' ,tpComb);
                    INIRec.WriteString( sSecao,'nMotor' ,nMotor);
                    INIRec.WriteString( sSecao,'CMKG'   ,CMT);    //Mantido por compatibilidade com NFe 1.1
                    INIRec.WriteString( sSecao,'CMT'    ,CMT);
                    INIRec.WriteString( sSecao,'dist'   ,dist);
//                    INIRec.WriteString( sSecao,'RENAVAM',RENAVAM);
                    INIRec.WriteInteger(sSecao,'anoMod' ,anoMod);
                    INIRec.WriteInteger(sSecao,'anoFab' ,anoFab);
                    INIRec.WriteString( sSecao,'tpPint' ,tpPint);
                    INIRec.WriteInteger(sSecao,'tpVeic' ,tpVeic);
                    INIRec.WriteInteger(sSecao,'espVeic',espVeic);
                    INIRec.WriteString( sSecao,'VIN'    ,VIN);
                    INIRec.WriteString( sSecao,'condVeic',condVeicToStr(condVeic));
                    INIRec.WriteString( sSecao,'cMod'   ,cMod);
                    INIRec.WriteString( sSecao,'cCorDENATRAN' ,cCorDENATRAN);
                    INIRec.WriteInteger(sSecao,'lota'   ,lota);
                    INIRec.WriteInteger(sSecao,'tpRest' ,tpRest);
                  end;
               end;

               for J:=0 to Prod.med.Count-1 do
                begin
                  sSecao := 'Medicamento'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                  with Prod.med.Items[J] do
                   begin
                     INIRec.WriteString(sSecao,'nLote',nLote) ;
                     INIRec.WriteFloat( sSecao,'qLote',qLote) ;
                     INIRec.WriteString(sSecao,'dFab',DateToStr(dFab)) ;
                     INIRec.WriteString(sSecao,'dVal',DateToStr(dVal)) ;
                     INIRec.WriteFloat( sSecao,'vPMC',vPMC) ;
                    end;
                end;

               for J:=0 to Prod.arma.Count-1 do
                begin
                  sSecao := 'Arma'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                  with Prod.arma.Items[J] do
                   begin
                     INIRec.WriteString( sSecao,'tpArma',tpArmaToStr(tpArma)) ;
                     INIRec.WriteString( sSecao,'nSerie',nSerie) ;
                     INIRec.WriteString( sSecao,'nCano' ,nCano) ;
                     INIRec.WriteString( sSecao,'descr' ,descr) ;
                    end;
                end;

               if (Prod.comb.cProdANP > 0) then
                begin
                 sSecao := 'Combustivel'+IntToStrZero(I+1,3) ;
                 with Prod.comb do
                  begin
                    INIRec.WriteInteger( sSecao,'cProdANP',cProdANP) ;
                    INIRec.WriteString(  sSecao,'CODIF'   ,CODIF) ;
                    INIRec.WriteFloat(   sSecao,'qTemp'   ,qTemp) ;
                    INIRec.WriteString(  sSecao,'UFCons'  ,UFcons) ;

                    sSecao := 'CIDE'+IntToStrZero(I+1,3) ;
                    INIRec.WriteFloat( sSecao,'qBCprod'  ,CIDE.qBCprod) ;
                    INIRec.WriteFloat( sSecao,'vAliqProd',CIDE.vAliqProd) ;
                    INIRec.WriteFloat( sSecao,'vCIDE'    ,CIDE.vCIDE) ;


                    if infNFe.Versao < 2 then
                     begin
                       sSecao := 'ICMSComb'+IntToStrZero(I+1,3) ;
                       INIRec.WriteFloat( sSecao,'vBCICMS'  ,ICMS.vBCICMS) ;
                       INIRec.WriteFloat( sSecao,'vICMS'    ,ICMS.vICMS) ;
                       INIRec.WriteFloat( sSecao,'vBCICMSST',ICMS.vBCICMSST) ;
                       INIRec.WriteFloat( sSecao,'vICMSST'  ,ICMS.vICMSST) ;

                       if (ICMSInter.vBCICMSSTDest>0) then
                        begin
                          sSecao := 'ICMSInter'+IntToStrZero(I+1,3) ;
                          INIRec.WriteFloat( sSecao,'vBCICMSSTDest',ICMSInter.vBCICMSSTDest) ;
                          INIRec.WriteFloat( sSecao,'vICMSSTDest'  ,ICMSInter.vICMSSTDest) ;
                        end;

                       if (ICMSCons.vBCICMSSTCons>0) then
                        begin
                          sSecao := 'ICMSCons'+IntToStrZero(I+1,3) ;
                          INIRec.WriteFloat( sSecao,'vBCICMSSTCons',ICMSCons.vBCICMSSTCons) ;
                          INIRec.WriteFloat( sSecao,'vICMSSTCons'  ,ICMSCons.vICMSSTCons) ;
                          INIRec.WriteString(sSecao,'UFCons'       ,ICMSCons.UFcons) ;
                        end;
                     end;
                  end;
               end;

               with Imposto do
                begin
                   sSecao := 'ICMS'+IntToStrZero(I+1,3) ;
                   with ICMS do
                    begin
                      INIRec.WriteString( sSecao,'Origem',OrigToStr(ICMS.orig));
                      INIRec.WriteString( sSecao,'CST',CSTICMSToStr(CST));
                      INIRec.WriteString( sSecao,'CSOSN',CSOSNIcmsToStr(CSOSN));
                      INIRec.WriteString(sSecao,'Modalidade',modBCToStr(ICMS.modBC));
                      INIRec.WriteFloat( sSecao,'PercentualReducao',ICMS.pRedBC);
                      INIRec.WriteFloat( sSecao,'ValorBase',ICMS.vBC);
                      INIRec.WriteFloat( sSecao,'Aliquota' ,ICMS.pICMS);
                      INIRec.WriteFloat( sSecao,'Valor'    ,ICMS.vICMS);
                      INIRec.WriteString(sSecao,'ModalidadeST',modBCSTToStr(ICMS.modBCST));
                      INIRec.WriteFloat( sSecao,'PercentualMargemST' ,ICMS.pMVAST);
                      INIRec.WriteFloat( sSecao,'PercentualReducaoST',ICMS.pRedBCST);
                      INIRec.WriteFloat( sSecao,'ValorBaseST',ICMS.vBCST);
                      INIRec.WriteFloat( sSecao,'AliquotaST' ,ICMS.pICMSST);
                      INIRec.WriteFloat( sSecao,'ValorST'    ,ICMS.vICMSST);
                      INIRec.WriteString(sSecao,'UFST'       ,ICMS.UFST);
                      INIRec.WriteFloat( sSecao,'pBCOp'      ,ICMS.pBCOp);
                      INIRec.WriteFloat( sSecao,'vBCSTRet'   ,ICMS.vBCSTRet);
                      INIRec.WriteFloat( sSecao,'vICMSSTRet' ,ICMS.vICMSSTRet);
                      INIRec.WriteString(sSecao,'motDesICMS' ,motDesICMSToStr(ICMS.motDesICMS));
                      INIRec.WriteFloat( sSecao,'pCredSN'    ,ICMS.pCredSN);
                      INIRec.WriteFloat( sSecao,'vCredICMSSN',ICMS.vCredICMSSN);
                      INIRec.WriteFloat( sSecao,'vBCSTDest'  ,ICMS.vBCSTDest);
                      INIRec.WriteFloat( sSecao,'vICMSSTDest',ICMS.vICMSSTDest);
                    end;

                   if (IPI.vBC > 0) then
                    begin
                      sSecao := 'IPI'+IntToStrZero(I+1,3) ;
                      with IPI do
                       begin
                         INIRec.WriteString(  sSecao,'CST',CSTIPIToStr(CST)) ;
                         INIRec.WriteString(  sSecao,'ClasseEnquadramento',clEnq);
                         INIRec.WriteString(  sSecao,'CNPJProdutor'       ,CNPJProd);
                         INIRec.WriteString(  sSecao,'CodigoSeloIPI'      ,cSelo);
                         INIRec.WriteInteger( sSecao,'QuantidadeSelos'    ,qSelo);
                         INIRec.WriteString(  sSecao,'CodigoEnquadramento',cEnq);

                         INIRec.WriteFloat( sSecao,'ValorBase'   ,vBC);
                         INIRec.WriteFloat(sSecao,'Quantidade'  ,qUnid);
                         INIRec.WriteFloat(sSecao,'ValorUnidade',vUnid);
                         INIRec.WriteFloat(sSecao,'Aliquota'    ,pIPI);
                         INIRec.WriteFloat(sSecao,'Valor'       ,vIPI);
                       end;
                    end;

                   if (II.vBc > 0) then
                    begin
                      sSecao   := 'II'+IntToStrZero(I+1,3) ;
                      with II do
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase',vBc);
                         INIRec.WriteFloat(sSecao,'ValorDespAduaneiras',vDespAdu);
                         INIRec.WriteFloat(sSecao,'ValorII'  ,vII);
                         INIRec.WriteFloat(sSecao,'ValorIOF' ,vIOF);
                       end;
                    end;

                   sSecao    := 'PIS'+IntToStrZero(I+1,3) ;
                   with PIS do
                    begin
                      INIRec.WriteString( sSecao,'CST',CSTPISToStr(CST));

                      if (CST = pis01) or (CST = pis02) then
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase',PIS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota' ,PIS.pPIS);
                         INIRec.WriteFloat(sSecao,'Valor'    ,PIS.vPIS);
                       end
                      else if CST = pis03 then
                       begin
                         INIRec.WriteFloat(sSecao,'Quantidade'   ,PIS.qBCProd);
                         INIRec.WriteFloat(sSecao,'ValorAliquota',PIS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'Valor'        ,PIS.vPIS);
                       end
                      else if CST = pis99 then
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase' ,PIS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota'  ,PIS.pPIS);
                         INIRec.WriteFloat(sSecao,'Quantidade',PIS.qBCProd);
                         INIRec.WriteFloat(sSecao,'ValorAliquota',PIS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'Valor'     ,PIS.vPIS);
                       end;
                    end;

                   if (PISST.vBc>0) then
                    begin
                      sSecao    := 'PISST'+IntToStrZero(I+1,3) ;
                      with PISST do
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase'    ,vBc);
                         INIRec.WriteFloat(sSecao,'AliquotaPerc' ,pPis);
                         INIRec.WriteFloat(sSecao,'Quantidade'   ,qBCProd);
                         INIRec.WriteFloat(sSecao,'AliquotaValor',vAliqProd);
                         INIRec.WriteFloat(sSecao,'ValorPISST'   ,vPIS);
                       end;
                     end;

                   sSecao    := 'COFINS'+IntToStrZero(I+1,3) ;
                   with COFINS do
                    begin
                      INIRec.WriteString( sSecao,'CST',CSTCOFINSToStr(CST));

                      if (CST = cof01) or (CST = cof02)   then
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase',COFINS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota' ,COFINS.pCOFINS);
                         INIRec.WriteFloat(sSecao,'Valor'    ,COFINS.vCOFINS);
                       end
                      else if CST = cof03 then
                       begin
                         INIRec.WriteFloat(sSecao,'Quantidade',COFINS.qBCProd);
                         INIRec.WriteFloat(sSecao,'Aliquota'  ,COFINS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'Valor'     ,COFINS.vCOFINS);
                       end
                      else if CST = cof99 then
                       begin
                         INIRec.WriteFloat(sSecao,'Valor'     ,COFINS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota'  ,COFINS.pCOFINS);
                         INIRec.WriteFloat(sSecao,'Quantidade',COFINS.qBCProd);
                         INIRec.WriteFloat(sSecao,'ValorAliquota',COFINS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'ValorBase' ,COFINS.vCOFINS);
                       end;
                    end;

                   if (COFINSST.vBC > 0) then
                    begin
                      sSecao    := 'COFINSST'+IntToStrZero(I+1,3) ;
                      with COFINSST do
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase'    ,vBC);
                         INIRec.WriteFloat(sSecao,'AliquotaPerc' ,pCOFINS);
                         INIRec.WriteFloat(sSecao,'Quantidade'   ,qBCProd);
                         INIRec.WriteFloat(sSecao,'AliquotaValor',vAliqProd);
                         INIRec.WriteFloat(sSecao,'ValorCOFINSST',vCOFINS);
                       end;
                    end;

                   if (ISSQN.vBC > 0) then
                    begin
                     sSecao    := 'ISSQN'+IntToStrZero(I+1,3) ;
                     with ISSQN do
                      begin
                        INIRec.WriteFloat(  sSecao,'ValorBase' ,vBC);
                        INIRec.WriteFloat(  sSecao,'Aliquota'  ,vAliq);
                        INIRec.WriteFloat(  sSecao,'ValorISSQN',vISSQN);
                        INIRec.WriteInteger(sSecao,'MunicipioFatoGerador',cMunFG);
                        INIRec.WriteInteger(sSecao,'CodigoServico',cListServ);
                        INIRec.WriteString( sSecao,'cSitTrib',ISSQNcSitTribToStr(cSitTrib));
                      end;
                    end;
                end;

             end;
          end ;

         INIRec.WriteFloat('Total','BaseICMS'     ,Total.ICMSTot.vBC) ;
         INIRec.WriteFloat('Total','ValorICMS'    ,Total.ICMSTot.vICMS) ;
         INIRec.WriteFloat('Total','BaseICMSSubstituicao' ,Total.ICMSTot.vBCST) ;
         INIRec.WriteFloat('Total','ValorICMSSubstituicao',Total.ICMSTot.vST) ;
         INIRec.WriteFloat('Total','ValorProduto' ,Total.ICMSTot.vProd) ;
         INIRec.WriteFloat('Total','ValorFrete'   ,Total.ICMSTot.vFrete) ;
         INIRec.WriteFloat('Total','ValorSeguro'  ,Total.ICMSTot.vSeg) ;
         INIRec.WriteFloat('Total','ValorDesconto',Total.ICMSTot.vDesc) ;
         INIRec.WriteFloat('Total','ValorII'      ,Total.ICMSTot.vII) ;
         INIRec.WriteFloat('Total','ValorIPI'     ,Total.ICMSTot.vIPI) ;
         INIRec.WriteFloat('Total','ValorPIS'     ,Total.ICMSTot.vPIS) ;
         INIRec.WriteFloat('Total','ValorCOFINS'  ,Total.ICMSTot.vCOFINS) ;
         INIRec.WriteFloat('Total','ValorOutrasDespesas',Total.ICMSTot.vOutro) ;
         INIRec.WriteFloat('Total','ValorNota'    ,Total.ICMSTot.vNF) ;

         INIRec.WriteFloat('Total','ValorServicos',Total.ISSQNtot.vServ) ;
         INIRec.WriteFloat('Total','ValorBaseISS' ,Total.ISSQNTot.vBC) ;
         INIRec.WriteFloat('Total','ValorISSQN'   ,Total.ISSQNTot.vISS) ;
         INIRec.WriteFloat('Total','ValorPISISS'  ,Total.ISSQNTot.vPIS) ;
         INIRec.WriteFloat('Total','ValorCONFINSISS',Total.ISSQNTot.vCOFINS) ;

         INIRec.WriteFloat('retTrib','vRetPIS'   ,Total.retTrib.vRetPIS) ;
         INIRec.WriteFloat('retTrib','vRetCOFINS',Total.retTrib.vRetCOFINS) ;
         INIRec.WriteFloat('retTrib','vRetCSLL'  ,Total.retTrib.vRetCSLL) ;
         INIRec.WriteFloat('retTrib','vBCIRRF'   ,Total.retTrib.vBCIRRF) ;
         INIRec.WriteFloat('retTrib','vIRRF'     ,Total.retTrib.vIRRF) ;
         INIRec.WriteFloat('retTrib','vBCRetPrev',Total.retTrib.vBCRetPrev) ;
         INIRec.WriteFloat('retTrib','vRetPrev'  ,Total.retTrib.vRetPrev) ;

         INIRec.WriteString('Transportador','FretePorConta',modFreteToStr(Transp.modFrete));
         INIRec.WriteString('Transportador','CnpjCpf'  ,Transp.Transporta.CNPJCPF);
         INIRec.WriteString('Transportador','NomeRazao',Transp.Transporta.xNome);
         INIRec.WriteString('Transportador','IE'       ,Transp.Transporta.IE);
         INIRec.WriteString('Transportador','Endereco' ,Transp.Transporta.xEnder);
         INIRec.WriteString('Transportador','Cidade'   ,Transp.Transporta.xMun);
         INIRec.WriteString('Transportador','UF'       ,Transp.Transporta.UF);

         INIRec.WriteFloat( 'Transportador','ValorServico',Transp.retTransp.vServ) ;
         INIRec.WriteFloat( 'Transportador','ValorBase'   ,Transp.retTransp.vBCRet) ;
         INIRec.WriteFloat( 'Transportador','Aliquota'    ,Transp.retTransp.pICMSRet) ;
         INIRec.WriteFloat( 'Transportador','Valor'       ,Transp.retTransp.vICMSRet) ;
         INIRec.WriteString('Transportador','CFOP'        ,Transp.retTransp.CFOP);
         INIRec.WriteInteger('Transportador','CidadeCod'  ,Transp.retTransp.cMunFG);

         INIRec.WriteString('Transportador','Placa'  ,Transp.veicTransp.placa);
         INIRec.WriteString('Transportador','UFPlaca',Transp.veicTransp.UF);
         INIRec.WriteString('Transportador','RNTC'   ,Transp.veicTransp.RNTC);

         INIRec.WriteString( 'Transportador','vagao' ,Transp.vagao) ;
         INIRec.WriteString( 'Transportador','balsa' ,Transp.balsa) ;

         for J:=0 to Transp.Reboque.Count-1 do
          begin
            sSecao := 'Reboque'+IntToStrZero(J+1,3) ;
            with Transp.Reboque.Items[J] do
             begin
               INIRec.WriteString(sSecao,'placa',placa) ;
               INIRec.WriteString( sSecao,'UF'  ,UF) ;
               INIRec.WriteString( sSecao,'RNTC',RNTC) ;
             end;
          end;

         for I:=0 to Transp.Vol.Count-1 do
          begin
            sSecao    := 'Volume'+IntToStrZero(I+1,3) ;
            with Transp.Vol.Items[I] do
             begin
               INIRec.WriteInteger(sSecao,'Quantidade' ,qVol) ;
               INIRec.WriteString( sSecao,'Especie'    ,esp);
               INIRec.WriteString( sSecao,'Marca'      ,marca);
               INIRec.WriteString( sSecao,'Numeracao'  ,nVol);
               INIRec.WriteFloat(  sSecao,'PesoLiquido',pesoL) ;
               INIRec.WriteFloat(  sSecao,'PesoBruto'  ,pesoB) ;

               for J:=0 to Lacres.Count-1 do
                begin
                  sSecao := 'Lacre'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                  INIRec.WriteString(sSecao,'nLacre',Lacres.Items[J].nLacre) ;
                end;
             end;
          end;

         INIRec.WriteString('Fatura','Numero',Cobr.Fat.nFat);
         INIRec.WriteFloat( 'Fatura','ValorOriginal',Cobr.Fat.vOrig) ;
         INIRec.WriteFloat( 'Fatura','ValorDesconto',Cobr.Fat.vDesc) ;
         INIRec.WriteFloat( 'Fatura','ValorLiquido' ,Cobr.Fat.vLiq) ;

         for I:=0 to Cobr.Dup.Count-1 do
          begin
            sSecao    := 'Duplicata'+IntToStrZero(I+1,3) ;
            with Cobr.Dup.Items[I] do
             begin
               INIRec.WriteString(sSecao,'Numero',nDup) ;
               INIRec.WriteString(sSecao,'DataVencimento',DateToStr(dVenc));
               INIRec.WriteFloat( sSecao,'Valor' ,vDup) ;
             end;
          end;

         INIRec.WriteString( 'DadosAdicionais','Fisco',InfAdic.infAdFisco);
         INIRec.WriteString( 'DadosAdicionais','Complemento',InfAdic.infCpl);

         for I:=0 to InfAdic.obsCont.Count-1 do
          begin
            sSecao     := 'InfAdic'+IntToStrZero(I+1,3) ;
            with InfAdic.obsCont.Items[I] do
             begin
               INIRec.WriteString(sSecao,'Campo',xCampo) ;
               INIRec.WriteString(sSecao,'Texto',xTexto);
             end;
          end;

         for I:=0 to InfAdic.obsFisco.Count-1 do
          begin
            sSecao     := 'ObsFisco'+IntToStrZero(I+1,3) ;
            with InfAdic.obsFisco.Items[I] do
             begin
               INIRec.WriteString(sSecao,'Campo',xCampo) ;
               INIRec.WriteString(sSecao,'Texto',xTexto);
             end;
          end;

         for I:=0 to InfAdic.procRef.Count-1 do
          begin
            sSecao     := 'procRef'+IntToStrZero(I+1,3) ;
            with InfAdic.procRef.Items[I] do
             begin
               INIRec.WriteString(sSecao,'nProc',nProc) ;
               INIRec.WriteString( sSecao,'indProc', indProcToStr(indProc));
             end;
          end;

         if (exporta.UFembarq <> '') then
          begin
            INIRec.WriteString( 'Exporta','UFembarq'  ,exporta.UFembarq) ;
            INIRec.WriteString( 'Exporta','xLocEmbarq',exporta.xLocEmbarq);
          end;

         if (compra.xNEmp <> '') then
          begin
            INIRec.WriteString( 'Compra','xNEmp',compra.xNEmp) ;
            INIRec.WriteString( 'Compra','xPed' ,compra.xPed);
            INIRec.WriteString( 'Compra','xCont',compra.xCont);
          end;

         INIRec.WriteString('cana','safra'   ,cana.safra);
         INIRec.WriteString('cana','ref'     ,cana.ref);
         INIRec.WriteFloat( 'cana','qTotMes' ,cana.qTotMes) ;
         INIRec.WriteFloat( 'cana','qTotAnt' ,cana.qTotAnt) ;
         INIRec.WriteFloat( 'cana','qTotGer' ,cana.qTotGer) ;
         INIRec.WriteFloat( 'cana','vFor'    ,cana.vFor) ;
         INIRec.WriteFloat( 'cana','vTotDed' ,cana.vTotDed) ;
         INIRec.WriteFloat( 'cana','vLiqFor' ,cana.vLiqFor) ;

         for I:=0 to cana.fordia.Count-1 do
          begin
            sSecao    := 'forDia'+IntToStrZero(I+1,3) ;
            with cana.fordia.Items[I] do
             begin
               INIRec.WriteInteger(sSecao,'dia',dia) ;
               INIRec.WriteFloat( sSecao,'qtde' ,qtde) ;
             end;
          end;

         for I:=0 to cana.deduc.Count-1 do
          begin
            sSecao    := 'deduc'+IntToStrZero(I+1,3) ;
            with cana.deduc.Items[I] do
             begin
               INIRec.WriteString(sSecao,'xDed',xDed) ;
               INIRec.WriteFloat( sSecao,'vDed' ,vDed) ;
             end;
          end;                        

          INIRec.WriteString('procNFe','tpAmb',TpAmbToStr(procNFe.tpAmb)) ;
          INIRec.WriteString('procNFe','verAplic',procNFe.verAplic) ;
          INIRec.WriteString('procNFe','chNFe',procNFe.chNFe) ;
          INIRec.WriteString('procNFe','dhRecbto'  ,DateToStr(procNFe.dhRecbto));
          INIRec.WriteString('procNFe','nProt',procNFe.nProt) ;
          INIRec.WriteString('procNFe','digVal',procNFe.digVal) ;
          INIRec.WriteString('procNFe','cStat',IntToStr(procNFe.cStat)) ;
          INIRec.WriteString('procNFe','xMotivo',procNFe.xMotivo) ;
       end;
   finally
      IniNFe := TStringList.Create;
      INIRec.GetStrings(IniNfe);
      INIRec.Free ;
      Result := StringReplace(IniNFe.Text,sLineBreak+sLineBreak,sLineBreak,[rfReplaceAll]);
      IniNFe.Free;
   end;
  end;
end;

function SubstituirVariaveis(const ATexto: String): String;
var
  TextoStr: String;
begin
  if Trim(ATexto) = '' then
    Result := ''
  else
  begin
    TextoStr := ATexto;
    
    if frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Count <= 0 then
      Exit;

    with frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Items[0].NFe do
    begin
      TextoStr := StringReplace(TextoStr,'[EmitNome]',     Emit.xNome,   [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[EmitFantasia]', Emit.xFant,   [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[EmitCNPJCPF]',  Emit.CNPJCPF, [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[EmitIE]',       Emit.IE,      [rfReplaceAll, rfIgnoreCase]);

      TextoStr := StringReplace(TextoStr,'[DestNome]',     Dest.xNome,   [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[DestCNPJCPF]',  Dest.CNPJCPF, [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[DestIE]',       Dest.IE,      [rfReplaceAll, rfIgnoreCase]);

      TextoStr := StringReplace(TextoStr,'[ChaveNFe]',     procNFe.chNFe, [rfReplaceAll, rfIgnoreCase]);

      TextoStr := StringReplace(TextoStr,'[NumeroNF]',     FormatFloat('000000000',     Ide.nNF),           [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[ValorNF]',      FormatFloat('0.00',          Total.ICMSTot.vNF), [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[dtEmissao]',    FormatDateTime('dd/mm/yyyy', Ide.dEmi),          [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[dtSaida]',      FormatDateTime('dd/mm/yyyy', Ide.dSaiEnt),       [rfReplaceAll, rfIgnoreCase]);
      TextoStr := StringReplace(TextoStr,'[hrSaida]',      FormatDateTime('hh:mm:ss',   Ide.hSaiEnt),       [rfReplaceAll, rfIgnoreCase]);
    end;

    Result := TextoStr;
  end;
end;


procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL : Boolean; sCopias: String='');
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m:TMimemess;
  p: TMimepart;
  CC: Tstrings;
  I : Integer;
  CorpoEmail: TStringList;
begin
  msg_lines := TStringList.Create;
  CorpoEmail := TStringList.Create;
  smtp := TSMTPSend.Create;
  m:=TMimemess.create;
  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
     begin
        CorpoEmail.Text := SubstituirVariaveis(sMensagem.Text);
        m.AddPartText(CorpoEmail, p);
     end;

     if sAttachment <> '' then
       m.AddPartBinaryFromFile(sAttachment, p);
     if sAttachment2 <> '' then
       m.AddPartBinaryFromFile(sAttachment2, p);
     m.header.tolist.add(sTo);
     m.header.From := sFrom;
     m.header.subject:=SubstituirVariaveis(sAssunto);
     m.EncodeMessage;
     msg_lines.Add(m.Lines.Text);

     smtp.UserName := sSmtpUser;
     smtp.Password := sSmtpPasswd;

     smtp.TargetHost := sSmtpHost;
     smtp.TargetPort := sSmtpPort;

     smtp.FullSSL := SSL;
     smtp.AutoTLS := SSL;
     if not smtp.Login() then
       raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.MailFrom(sFrom, Length(sFrom)) then
       raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
     if not smtp.MailTo(sTo) then
       raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
     if NotaUtil.NaoEstaVazio(sCopias) then
      begin
        CC:=TstringList.Create;
        CC.DelimitedText := sLineBreak;
        CC.Text := StringReplace(sCopias,';',sLineBreak,[rfReplaceAll]);
        for I := 0 to CC.Count - 1 do
        begin
           if not smtp.MailTo(CC.Strings[i]) then
              raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
        end;
      end;
     if not smtp.MailData(msg_lines) then
       raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.Logout() then
       raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
  finally
     msg_lines.Free;
     CorpoEmail.Free;
     smtp.Free;
     m.free;
  end;
end;

procedure EnviarEmailIndy(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL : Boolean; sCopias: String='');
var
  IdSMTP    : TIdSMTP;
  IdMessage : TIdMessage;
  IdISSLOHANDLERSocket : TIdSSLIOHandlerSocket;
begin
  IdSMTP    := TIdSMTP.Create(Application);
  IdMessage := TIdMessage.Create(Application);
  IdISSLOHANDLERSocket := TIdSSLIOHandlerSocket.Create(Application);
  try
     IdSMTP.Host := sSmtpHost;
     IdSMTP.Port := StrToIntDef(sSmtpPort,25);
     IdSMTP.Username := sSmtpUser;
     IdSMTP.Password := sSmtpPasswd;

     if SSL then
      begin
        IdISSLOHANDLERSocket.SSLOptions.Method := sslvSSLv3;
        IdISSLOHANDLERSocket.SSLOptions.Mode := sslmClient;
        IdSMTP.AuthenticationType := atLogin;
        IdSMTP.IOHandler := IdISSLOHANDLERSocket;
      end
     else
        IdSMTP.AuthenticationType := atNone;

     IdMessage.From.Address := sFrom;
     IdMessage.Recipients.EMailAddresses := sTo;
     if NotaUtil.NaoEstaVazio(sCopias) then
        IdMessage.CCList.EMailAddresses := sCopias;

     IdMessage.Priority := mpNormal;
     IdMessage.Subject := SubstituirVariaveis(sAssunto);
     IdMessage.Body.Text := SubstituirVariaveis(sMensagem.Text);

     if NotaUtil.NaoEstaVazio(sAttachment) then
        TIdAttachment.create(IdMessage.MessageParts, sAttachment);

     if NotaUtil.NaoEstaVazio(sAttachment2) then
        TIdAttachment.create(IdMessage.MessageParts, sAttachment2);

     try
        IdSMTP.Connect;
     except
        IdSMTP.Connect;
     end;

     try
        IdSMTP.Send(IdMessage);
     finally
        IdSMTP.Disconnect;
     end;
  finally
    IdISSLOHANDLERSocket.Free;
    IdMessage.Free;
    IdSMTP.Free;
  end;
end;

procedure GerarIniCCe( AStr: WideString ) ;
var
  I      : Integer;
  sSecao, sFim : String;
  INIRec : TMemIniFile ;
  SL     : TStringList;
begin
 INIRec := TMemIniFile.create( 'cce.ini' ) ;

 SL := TStringList.Create;
 if FilesExists(Astr) then
    SL.LoadFromFile(AStr)
 else
    Sl.Text := ConvertStrRecived( Astr );

 INIRec.SetStrings( SL );
 SL.Free ;

 with frmAcbrNfeMonitor do
  begin
   try
     ACBrNFe1.CartaCorrecao.CCe.idLote := INIRec.ReadInteger( 'CCE','idLote' ,0);
     I := 1 ;
     while true do
      begin
        sSecao := 'EVENTO'+IntToStrZero(I,3) ;
        sFim   := INIRec.ReadString(  sSecao,'chNFe'  ,'FIM');
        if (sFim = 'FIM') or (Length(sFim) <= 0) then
           break ;

        with ACBrNFe1.CartaCorrecao.CCe.Evento.Add do
         begin
           infEvento.chNFe  := INIRec.ReadString(  sSecao,'chNFe' ,'');
           infEvento.cOrgao := INIRec.ReadInteger( sSecao,'cOrgao' ,0);
           infEvento.CNPJ   := INIRec.ReadString(  sSecao,'CNPJ' ,'');
           infEvento.dhEvento :=  NotaUtil.StringToDateTime(INIRec.ReadString(  sSecao,'dhEvento' ,''));
           infEvento.tpEvento := 110110;
           infEvento.nSeqEvento := INIRec.ReadInteger( sSecao,'nSeqEvento' ,1);
           infEvento.versaoEvento := '1.00';
           infEvento.detEvento.descEvento := 'Carta de Correção';
           infEvento.detEvento.xCorrecao := INIRec.ReadString(  sSecao,'xCorrecao' ,'');
           infEvento.detEvento.xCondUso := ''; //Texto fixo conforme NT 2011.003 -  http://www.nfe.fazenda.gov.br/portal/exibirArquivo.aspx?conteudo=tsiloeZ6vBw=
         end;
        Inc(I);
      end;
   finally
      INIRec.Free ;
   end;
 end;
end;

end.
