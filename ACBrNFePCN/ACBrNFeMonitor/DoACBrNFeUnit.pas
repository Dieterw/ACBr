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
Uses Classes, TypInfo, SysUtils, CmdUnitNFe, Types, smtpsend, ssl_openssl, mimemess, mimepart, RpDevice ;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
Function ConvertStrRecived( AStr: String ) : String ;
function UFparaCodigo(const UF: string): integer;
function ObterCodigoMunicipio(const xMun, xUF: string): integer;
procedure GerarIniNFe( AStr: WideString ) ;
procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL : Boolean);

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
  pcnRetEnvNFe, pcnConsReciNFe,
  pcnNFeRTXT;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
var
  I : Integer;
  ArqNFe, ArqPDF : String;
  Salva  : Boolean;
  SL     : TStringList;

  NFeRetConsStatServ : TRetConsStatServ;
  NFeRetConsSitNFe   : TRetConsSitNFe;
  NFeRetCancNFe      : TRetCancNFe;
  NFeRetEnviNFe      : TRetEnvNFe;
  NFeRetConsReciNFe  : TRetConsReciNFe;
  NFeRetInutNFe      : TRetInutNFe;
  NFeRTXT            : TNFeRTXT;
begin
 with frmAcbrNfeMonitor do
  begin
     try
        if Cmd.Metodo = 'statusservico' then
         begin
           if ACBrNFe1.WebServices.StatusServico.Executar then
            begin
              NFeRetConsStatServ := TRetConsStatServ.Create;
              NFeRetConsStatServ.Leitor.Arquivo := ACBrNFe1.WebServices.StatusServico.RetWS;
              NFeRetConsStatServ.LerXML;

              Cmd.Resposta := ACBrNFe1.WebServices.StatusServico.Msg+
                              '[STATUS]'+sLineBreak+
                              'Versao='+NFeRetConsStatServ.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(NFeRetConsStatServ.TpAmb)+sLineBreak+
                              'VerAplic='+NFeRetConsStatServ.VerAplic+sLineBreak+
                              'CStat='+IntToStr(NFeRetConsStatServ.CStat)+sLineBreak+
                              'XMotivo='+NFeRetConsStatServ.XMotivo+sLineBreak+
                              'CUF='+IntToStr(NFeRetConsStatServ.CUF)+sLineBreak+
                              'DhRecbto='+DateTimeToStr(NFeRetConsStatServ.DhRecbto)+sLineBreak+
                              'TMed='+IntToStr(NFeRetConsStatServ.TMed)+sLineBreak+
                              'DhRetorno='+DateTimeToStr(NFeRetConsStatServ.DhRetorno)+sLineBreak+
                              'XObs='+NFeRetConsStatServ.XObs+sLineBreak;
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
         end

        else if Cmd.Metodo = 'consultarnfe' then
         begin
           ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);
           try
              ACBrNFe1.WebServices.Consulta.Executar;
              NFeRetConsSitNFe := TRetConsSitNFe.Create;
              NFeRetConsSitNFe.Leitor.Arquivo := ACBrNFe1.WebServices.Consulta.RetWS;
              NFeRetConsSitNFe.LerXml;

              Cmd.Resposta := ACBrNFe1.WebServices.Consulta.Msg+sLineBreak+
                              '[CONSULTA]'+sLineBreak+
                              'Versao='+NFeRetConsSitNFe.verAplic+sLineBreak+
//                              'Id='+NFeRetConsSitNFe.Id+sLineBreak+
                              'TpAmb='+TpAmbToStr(NFeRetConsSitNFe.TpAmb)+sLineBreak+
                              'VerAplic='+NFeRetConsSitNFe.VerAplic+sLineBreak+
                              'CStat='+IntToStr(NFeRetConsSitNFe.CStat)+sLineBreak+
                              'XMotivo='+NFeRetConsSitNFe.XMotivo+sLineBreak+
                              'CUF='+IntToStr(NFeRetConsSitNFe.CUF)+sLineBreak+
                              'ChNFe='+NFeRetConsSitNFe.ChNFe+sLineBreak+
                              'DhRecbto='+DateTimeToStr(NFeRetConsSitNFe.DhRecbto)+sLineBreak+
                              'NProt='+NFeRetConsSitNFe.NProt+sLineBreak+
                              'DigVal='+NFeRetConsSitNFe.DigVal+sLineBreak;

           except
              raise Exception.Create(ACBrNFe1.WebServices.Consulta.Msg);
           end;
         end

        else if Cmd.Metodo = 'cancelarnfe' then
         begin
           ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);
           ACBrNFe1.WebServices.Consulta.Executar;

           ACBrNFe1.WebServices.Cancelamento.NFeChave      := ACBrNFe1.WebServices.Consulta.NFeChave;
           ACBrNFe1.WebServices.Cancelamento.Protocolo     := ACBrNFe1.WebServices.Consulta.Protocolo;
           ACBrNFe1.WebServices.Cancelamento.Justificativa := Cmd.Params(1);
           try
              ACBrNFe1.WebServices.Cancelamento.Executar;
              NFeRetCancNFe := TRetCancNFe.Create;
              NFeRetCancNFe.Leitor.Arquivo := ACBrNFe1.WebServices.Cancelamento.RetWS;
              NFeRetCancNFe.LerXml;

              Cmd.Resposta := ACBrNFe1.WebServices.Cancelamento.Msg+sLineBreak+
                              '[CANCELAMENTO]'+sLineBreak+
                              'Versao='+NFeRetCancNFe.verAplic+sLineBreak+
//                              'Id='+NFeRetCancNFe.Id+sLineBreak+
                              'TpAmb='+TpAmbToStr(NFeRetCancNFe.TpAmb)+sLineBreak+
                              'VerAplic='+NFeRetCancNFe.VerAplic+sLineBreak+
                              'CStat='+IntToStr(NFeRetCancNFe.CStat)+sLineBreak+
                              'XMotivo='+NFeRetCancNFe.XMotivo+sLineBreak+
                              'CUF='+IntToStr(NFeRetCancNFe.CUF)+sLineBreak+
                              'ChNFe='+NFeRetCancNFe.ChNFe+sLineBreak+
                              'DhRecbto='+DateTimeToStr(NFeRetCancNFe.DhRecbto)+sLineBreak+
                              'NProt='+NFeRetCancNFe.NProt+sLineBreak;
           except
              raise Exception.Create(ACBrNFe1.WebServices.Cancelamento.Msg);
           end;
         end

        else if Cmd.Metodo = 'imprimirdanfe' then
         begin
           if ACBrNFeDANFERave1.MostrarPreview then
            begin
              Restaurar1.Click;
              Application.BringToFront;
            end;
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs\'+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs\'+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           RPDev.DeviceIndex := cbxImpressora.ItemIndex;
           ACBrNFe1.NotasFiscais.Imprimir;
           Cmd.Resposta := 'Danfe Impresso com sucesso';
           if ACBrNFeDANFERave1.MostrarPreview then
              Ocultar1.Click;
         end

        else if Cmd.Metodo = 'imprimirdanfepdf' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           try
              ACBrNFe1.NotasFiscais.ImprimirPDF;
              Cmd.Resposta := 'Arquivo criado em '+ExtractFileDir(application.ExeName)+'\'+copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'.pdf'
           except
              raise Exception.Create('Erro ao criar o arquivo PDF');
           end;
         end

        else if Cmd.Metodo = 'inutilizarnfe' then
         begin                            //CNPJ         //Justificat   //Ano                    //Modelo                 //Série                  //Num.Inicial            //Num.Final
           ACBrNFe1.WebServices.Inutiliza(Cmd.Params(0), Cmd.Params(1), StrToInt(Cmd.Params(2)), StrToInt(Cmd.Params(3)), StrToInt(Cmd.Params(4)), StrToInt(Cmd.Params(5)), StrToInt(Cmd.Params(6)));

           NFeRetInutNFe := TRetInutNFe.Create;
           NFeRetInutNFe.Leitor.Arquivo := ACBrNFe1.WebServices.Inutilizacao.RetWS;
           NFeRetInutNFe.LerXml;

           Cmd.Resposta := ACBrNFe1.WebServices.Inutilizacao.Msg+sLineBreak+
                           '[INUTILIZACAO]'+sLineBreak+
                           'Versao='+NFeRetInutNFe.verAplic+sLineBreak+
//                           'Id='+NFeRetInutNFe.Id+sLineBreak+
                           'TpAmb='+TpAmbToStr(NFeRetInutNFe.TpAmb)+sLineBreak+
                           'VerAplic='+NFeRetInutNFe.VerAplic+sLineBreak+
                           'CStat='+IntToStr(NFeRetInutNFe.CStat)+sLineBreak+
                           'XMotivo='+NFeRetInutNFe.XMotivo+sLineBreak+
                           'CUF='+IntToStr(NFeRetInutNFe.CUF)+sLineBreak+
                           'DhRecbto='+DateTimeToStr(NFeRetInutNFe.DhRecbto)+sLineBreak+
                           'NProt='+NFeRetInutNFe.NProt+sLineBreak;
         end

        else if Cmd.Metodo = 'enviarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           if Cmd.Params(2) <> '0' then
              ACBrNFe1.NotasFiscais.Assinar;

           ACBrNFe1.NotasFiscais.Valida;

           if not(ACBrNFe1.WebServices.StatusServico.Executar) then
            raise Exception.Create(ACBrNFe1.WebServices.StatusServico.Msg);

           ACBrNFe1.WebServices.Enviar.Lote := StrToInt(Cmd.Params(1));
           if not(ACBrNFe1.WebServices.Enviar.Executar) then
            raise Exception.Create(ACBrNFe1.WebServices.Enviar.Msg);

           NFeRetEnviNFe := TRetEnvNFe.Create;
           NFeRetEnviNFe.Leitor.Arquivo := ACBrNFe1.WebServices.Enviar.RetWS;
           NFeRetEnviNFe.LerXMl;

           Cmd.Resposta :=  ACBrNFe1.WebServices.Enviar.Msg+sLineBreak+
                            '[ENVIO]'+sLineBreak+
                            'Versao='+NFeRetEnviNFe.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(NFeRetEnviNFe.TpAmb)+sLineBreak+
                            'VerAplic='+NFeRetEnviNFe.VerAplic+sLineBreak+
                            'CStat='+IntToStr(NFeRetEnviNFe.CStat)+sLineBreak+
                            'XMotivo='+NFeRetEnviNFe.XMotivo+sLineBreak+
                            'CUF='+IntToStr(NFeRetEnviNFe.CUF)+sLineBreak+
                            'NRec='+NFeRetEnviNFe.infRec.nRec+sLineBreak+
                            'DhRecbto='+DateTimeToStr( NFeRetEnviNFe.infRec.dhRecbto)+sLineBreak+
                            'TMed='+IntToStr( NFeRetEnviNFe.infRec.tMed)+sLineBreak;

           ACBrNFe1.WebServices.Retorno.Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
           if not(ACBrNFe1.WebServices.Retorno.Executar) then
            raise Exception.Create(ACBrNFe1.WebServices.Retorno.Msg);

           NFeRetConsReciNFe := ACBrNFe1.WebServices.Retorno.NFeRetorno;

           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrNFe1.WebServices.Retorno.Msg+sLineBreak+
                            '[RETORNO]'+sLineBreak+
                            'Versao='+NFeRetConsReciNFe.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(NFeRetConsReciNFe.TpAmb)+sLineBreak+
                            'VerAplic='+NFeRetConsReciNFe.VerAplic+sLineBreak+
                            'NRec='+NFeRetConsReciNFe.NRec+sLineBreak+
                            'CStat='+IntToStr(NFeRetConsReciNFe.CStat)+sLineBreak+
                            'XMotivo='+NFeRetConsReciNFe.XMotivo+sLineBreak+
                            'CUF='+IntToStr(NFeRetConsReciNFe.CUF)+sLineBreak;
           for I:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
            begin
              ACBrNFe1.WebServices.Consulta.NFeChave := copy(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
              ACBrNFe1.WebServices.Consulta.Executar;

              NFeRetConsSitNFe := TRetConsSitNFe.Create;
              NFeRetConsSitNFe.Leitor.Arquivo := ACBrNFe1.WebServices.Consulta.RetWS;
              NFeRetConsSitNFe.LerXML;

              Cmd.Resposta := Cmd.Resposta+
                             '[NFE'+Trim(IntToStr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.NNF))+']'+sLineBreak+
                             'Versao='+NFeRetConsSitNFe.verAplic+sLineBreak+
//                             'Id='+NFeRetConsSitNFe.InfProt.Id+sLineBreak+
                             'TpAmb='+TpAmbToStr(NFeRetConsSitNFe.TpAmb)+sLineBreak+
                             'VerAplic='+NFeRetConsSitNFe.VerAplic+sLineBreak+
                             'CStat='+IntToStr(NFeRetConsSitNFe.CStat)+sLineBreak+
                             'XMotivo='+NFeRetConsSitNFe.XMotivo+sLineBreak+
                             'CUF='+IntToStr(NFeRetConsSitNFe.CUF)+sLineBreak+
                             'ChNFe='+NFeRetConsSitNFe.ChNFe+sLineBreak+
                             'DhRecbto='+DateTimeToStr(NFeRetConsSitNFe.DhRecbto)+sLineBreak+
                             'NProt='+NFeRetConsSitNFe.NProt+sLineBreak+
                             'DigVal='+NFeRetConsSitNFe.DigVal+sLineBreak;

              RPDev.DeviceIndex := cbxImpressora.ItemIndex; 
              if ACBrNFe1.NotasFiscais.Items[i].Confirmada and (Cmd.Params(3) = '1') then
                 ACBrNFe1.NotasFiscais.Items[i].Imprimir;
            end;
         end
        else if (Cmd.Metodo = 'recibonfe')then
         begin
           ACBrNFe1.WebServices.Recibo.Recibo := Cmd.Params(0);
           if not(ACBrNFe1.WebServices.Recibo.Executar) then
             raise Exception.Create(ACBrNFe1.WebServices.Recibo.Msg);

           NFeRetConsReciNFe := ACBrNFe1.WebServices.Recibo.NFeRetorno;

{           ACBrNFe1.WebServices.Retorno.Recibo :=  Cmd.Params(0);
           if not(ACBrNFe1.WebServices.Retorno.Executar) then
            raise Exception.Create(ACBrNFe1.WebServices.Retorno.Msg);

           NFeRetConsReciNFe := ACBrNFe1.WebServices.Retorno.NFeRetorno;}

           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrNFe1.WebServices.Recibo.Msg+sLineBreak+
                           '[RETORNO]'+sLineBreak+
                           'Versao='+NFeRetConsReciNFe.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(NFeRetConsReciNFe.TpAmb)+sLineBreak+
                           'VerAplic='+NFeRetConsReciNFe.VerAplic+sLineBreak+
                           'NRec='+NFeRetConsReciNFe.NRec+sLineBreak+
                           'CStat='+IntToStr(NFeRetConsReciNFe.CStat)+sLineBreak+
                           'XMotivo='+NFeRetConsReciNFe.XMotivo+sLineBreak+
                           'CUF='+IntToStr(NFeRetConsReciNFe.CUF)+sLineBreak;

           if ACBrNFe1.Configuracoes.Geral.Salvar then
            begin
              Cmd.Resposta :=  Cmd.Resposta+
              'Arquivo='+ACBrNFe1.Configuracoes.Geral.PathSalvar+Cmd.Params(0)+'-pro-rec.xml';
            end;  


         end
        else if (Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarenviarnfe') or
                (Cmd.Metodo = 'criarnfesefaz') or (Cmd.Metodo = 'criarenviarnfesefaz') then
         begin
           if (Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarenviarnfe') then
              GerarIniNFe( Cmd.Params(0)  )
           else
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

           Salva := ACBrNFe1.Configuracoes.Geral.Salvar;
           if not Salva then
            begin
             ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
             ACBrNFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
            end;
           ACBrNFe1.Configuracoes.Geral.Salvar := True;
           ACBrNFe1.NotasFiscais.GerarNFe;
           ACBrNFe1.NotasFiscais.Valida;
           ACBrNFe1.Configuracoes.Geral.Salvar := Salva;

           ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';

           if ((Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarnfesefaz')) and (Cmd.Params(1) = '1') then
            begin
              SL := TStringList.Create;
              SL.LoadFromFile(ArqNFe);
              Cmd.Resposta :=  'NFe criada em: '+ArqNFe+sLineBreak+SL.Text;
              SL.Free;
            end
           else
              Cmd.Resposta :=  'NFe criada em: '+ArqNFe;

           if (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') then
            begin
              if not(ACBrNFe1.WebServices.StatusServico.Executar) then
               raise Exception.Create(ACBrNFe1.WebServices.StatusServico.Msg);

              ACBrNFe1.WebServices.Enviar.Lote := StrToInt(Cmd.Params(1));
              if not(ACBrNFe1.WebServices.Enviar.Executar) then
               raise Exception.Create(ACBrNFe1.WebServices.Enviar.Msg);

              NFeRetEnviNFe := TRetEnvNFe.Create;
              NFeRetEnviNFe.Leitor.Arquivo :=  ACBrNFe1.WebServices.Enviar.RetWS;
              NFeRetEnviNFe.LerXml;

              Cmd.Resposta :=  ACBrNFe1.WebServices.Enviar.Msg+sLineBreak+
                              '[ENVIO]'+sLineBreak+
                              'Versao='+NFeRetEnviNFe.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(NFeRetEnviNFe.TpAmb)+sLineBreak+
                              'VerAplic='+NFeRetEnviNFe.VerAplic+sLineBreak+
                              'CStat='+IntToStr(NFeRetEnviNFe.CStat)+sLineBreak+
                              'XMotivo='+NFeRetEnviNFe.XMotivo+sLineBreak+
                              'CUF='+IntToStr(NFeRetEnviNFe.CUF)+sLineBreak+
                              'NRec='+NFeRetEnviNFe.InfRec.NRec+sLineBreak+
                              'DhRecbto='+DateTimeToStr(NFeRetEnviNFe.InfRec.DhRecbto)+sLineBreak+
                              'TMed='+IntToStr(NFeRetEnviNFe.InfRec.TMed)+sLineBreak;

              ACBrNFe1.WebServices.Retorno.Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
              if not(ACBrNFe1.WebServices.Retorno.Executar) then
               raise Exception.Create(ACBrNFe1.WebServices.Retorno.Msg);

              NFeRetConsReciNFe := ACBrNFe1.WebServices.Retorno.NFeRetorno;

              Cmd.Resposta :=  Cmd.Resposta+
                               ACBrNFe1.WebServices.Retorno.Msg+sLineBreak+
                              '[RETORNO]'+sLineBreak+
                              'Versao='+NFeRetConsReciNFe.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(NFeRetConsReciNFe.TpAmb)+sLineBreak+
                              'VerAplic='+NFeRetConsReciNFe.VerAplic+sLineBreak+
                              'NRec='+NFeRetConsReciNFe.NRec+sLineBreak+
                              'CStat='+IntToStr(NFeRetConsReciNFe.CStat)+sLineBreak+
                              'XMotivo='+NFeRetConsReciNFe.XMotivo+sLineBreak+
                              'CUF='+IntToStr(NFeRetConsReciNFe.CUF)+sLineBreak;

              for I:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
               begin
                 ACBrNFe1.WebServices.Consulta.NFeChave := copy(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
                 ACBrNFe1.WebServices.Consulta.Executar;
                 NFeRetConsSitNFe := TRetConsSitNFe.Create;
                 NFeRetConsSitNFe.Leitor.Arquivo := ACBrNFe1.WebServices.Consulta.RetWS;
                 NFeRetConsSitNFe.LerXML;

                 Cmd.Resposta := Cmd.Resposta+
                                '[NFE'+Trim(IntToStr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.NNF))+']'+sLineBreak+
                                'Versao='+NFeRetConsSitNFe.verAplic+sLineBreak+
//                                'Id='+NFeRetConsSitNFe.InfProt.Id+sLineBreak+
                                'TpAmb='+TpAmbToStr(NFeRetConsSitNFe.TpAmb)+sLineBreak+
                                'VerAplic='+NFeRetConsSitNFe.VerAplic+sLineBreak+
                                'CStat='+IntToStr(NFeRetConsSitNFe.CStat)+sLineBreak+
                                'XMotivo='+NFeRetConsSitNFe.XMotivo+sLineBreak+
                                'CUF='+IntToStr(NFeRetConsSitNFe.CUF)+sLineBreak+
                                'ChNFe='+NFeRetConsSitNFe.ChNFe+sLineBreak+
                                'DhRecbto='+DateTimeToStr(NFeRetConsSitNFe.DhRecbto)+sLineBreak+
                                'NProt='+NFeRetConsSitNFe.NProt+sLineBreak+
                                'DigVal='+NFeRetConsSitNFe.DigVal+sLineBreak;

                 if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                  begin
                    Restaurar1.Click;
                    Application.BringToFront;
                  end;
                 RPDev.DeviceIndex := cbxImpressora.ItemIndex;
                 if ACBrNFe1.NotasFiscais.Items[i].Confirmada and (Cmd.Params(2) = '1') then
                    ACBrNFe1.NotasFiscais.Items[i].Imprimir;
                 if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                    Ocultar1.Click;
            end;

            end;
         end

        else if Cmd.Metodo = 'enviaremail' then
         begin
           if FileExists(Cmd.Params(1)) then
            begin
              ACBrNFe1.NotasFiscais.Clear;
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(1));
            end  
           else
              raise Exception.Create('Arquivo '+Cmd.Params(1)+' não encontrado.');

           if (Cmd.Params(2) = '1') then
            begin
              try
                 ACBrNFe1.NotasFiscais.ImprimirPDF;
                 ArqPDF := ExtractFileDir(application.ExeName)+'\'+ACBrNFe1.NotasFiscais.Items[0].NFe.InfNFe.Id+'.pdf'
              except
                 raise Exception.Create('Erro ao criar o arquivo PDF');
              end;
            end;
            try
               EnviarEmail(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0), edtEmailAssunto.Text, Cmd.Params(1), ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked);
               Cmd.Resposta := 'Email enviado com sucesso';
            except
               raise Exception.Create('Erro ao enviar email');
            end;
         end

        else if Cmd.Metodo = 'restaurar' then
           Restaurar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'ocultar' then
           Ocultar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'encerrarmonitor' then
           Application.Terminate

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
  PathArquivo :=  PathWithDelim(ExtractFilePath(Application.ExeName))+ 'MunIBGE\MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
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
  I, J : Integer;
  sSecao, sFim, sCodPro, sNumeroDI, sNumeroADI, sQtdVol, sNumDup, sCampoAdic : String;
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
         Ide.natOp      := INIRec.ReadString(  'Identificacao','NaturezaOperacao' ,'');
         Ide.modelo     := INIRec.ReadInteger( 'Identificacao','Modelo' ,55);
         Ide.serie      := INIRec.ReadInteger( 'Identificacao','Serie'  ,1);
         Ide.cNF        := INIRec.ReadInteger( 'Identificacao','Codigo' ,0);
         Ide.nNF        := INIRec.ReadInteger( 'Identificacao','Numero' ,0);
         Ide.dEmi       := StrToDate(INIRec.ReadString( 'Identificacao','Emissao',''));
         Ide.dSaiEnt    := StrToDate(INIRec.ReadString( 'Identificacao','Saida'  ,''));
         Ide.tpNF       := StrToTpNF(OK,INIRec.ReadString( 'Identificacao','Tipo','1'));
         Ide.indPag     := StrToIndpag(OK,INIRec.ReadString( 'Identificacao','FormaPag','0'));
         Ide.finNFe     := StrToFinNFe(OK,INIRec.ReadString( 'Identificacao','Finalidade','0'));
         Ide.verProc    := INIRec.ReadString(  'Identificacao','verProc' ,'1.0.0.0' );

         Emit.CNPJCPF           := INIRec.ReadString(  'Emitente','CNPJ'    ,'');
         Emit.IE                := INIRec.ReadString(  'Emitente','IE'      ,'');
         Emit.xNome             := INIRec.ReadString(  'Emitente','Razao'   ,'');
         Emit.xFant             := INIRec.ReadString(  'Emitente','Fantasia','');
         Emit.EnderEmit.fone    := INIRec.ReadString(  'Emitente','Fone' ,'');
         Emit.EnderEmit.CEP     := INIRec.ReadInteger( 'Emitente','CEP'  ,0);
         Emit.EnderEmit.xLgr    := INIRec.ReadString(  'Emitente','Logradouro' ,'');
         if INIRec.ReadString(  'Emitente','Numero'     ,'') <> '' then
            Emit.EnderEmit.nro     := INIRec.ReadString(  'Emitente','Numero'     ,'');
         if INIRec.ReadString(  'Emitente','Complemento'     ,'') <> '' then
            Emit.EnderEmit.xCpl    := INIRec.ReadString(  'Emitente','Complemento','');
         Emit.EnderEmit.xBairro := INIRec.ReadString(  'Emitente','Bairro'     ,'');
         Emit.EnderEmit.cMun    := INIRec.ReadInteger( 'Emitente','CidadeCod'  ,0);
         Emit.EnderEmit.xMun    := INIRec.ReadString(  'Emitente','Cidade'     ,'');
         Emit.EnderEmit.UF      := INIRec.ReadString(  'Emitente','UF'         ,'');
         if Emit.EnderEmit.cMun <= 0 then
            Emit.EnderEmit.cMun := ObterCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF);
         Emit.EnderEmit.cPais   := INIRec.ReadInteger( 'Emitente','PaisCod'    ,1058);
         Emit.EnderEmit.xPais   := INIRec.ReadString(  'Emitente','Pais'       ,'BRASIL');
             ;
         Ide.cUF       := INIRec.ReadInteger( 'Identificacao','cUF'       ,UFparaCodigo(Emit.EnderEmit.UF));
         Ide.cMunFG    := INIRec.ReadInteger( 'Identificacao','CidadeCod' ,Emit.EnderEmit.cMun);

         Dest.CNPJCPF           := INIRec.ReadString(  'Destinatario','CNPJ'       ,'');
         Dest.IE                := INIRec.ReadString(  'Destinatario','IE'         ,'');
         Dest.ISUF              := INIRec.ReadString(  'Destinatario','ISUF'         ,'');
         Dest.xNome             := INIRec.ReadString(  'Destinatario','NomeRazao'  ,'');
         Dest.EnderDest.Fone    := INIRec.ReadString(  'Destinatario','Fone'       ,'');
         Dest.EnderDest.CEP     := INIRec.ReadInteger( 'Destinatario','CEP'       ,0);
         Dest.EnderDest.xLgr    := INIRec.ReadString(  'Destinatario','Logradouro' ,'');
         if INIRec.ReadString(  'Destinatario','Numero'     ,'') <> '' then
            Dest.EnderDest.nro     := INIRec.ReadString(  'Destinatario','Numero'     ,'');
         if INIRec.ReadString(  'Destinatario','Complemento','') <> '' then
            Dest.EnderDest.xCpl    := INIRec.ReadString(  'Destinatario','Complemento','');
         Dest.EnderDest.xBairro := INIRec.ReadString(  'Destinatario','Bairro'     ,'');
         Dest.EnderDest.cMun    := INIRec.ReadInteger( 'Destinatario','CidadeCod'  ,0);
         Dest.EnderDest.xMun    := INIRec.ReadString(  'Destinatario','Cidade'     ,'');
         Dest.EnderDest.UF      := INIRec.ReadString(  'Destinatario','UF'         ,'');
         if Dest.EnderDest.cMun <= 0 then
            Dest.EnderDest.cMun := ObterCodigoMunicipio(Dest.EnderDest.xMun,Dest.EnderDest.UF);
         Dest.EnderDest.cPais   := INIRec.ReadInteger( 'Destinatario','PaisCod'    ,1058);
         Dest.EnderDest.xPais   := INIRec.ReadString(  'Destinatario','Pais'       ,'BRASIL');

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
               Prod.cProd    := INIRec.ReadString( sSecao,'Codigo'   ,'');
               if Length(INIRec.ReadString( sSecao,'EAN','')) > 0 then
                  Prod.cEAN      := INIRec.ReadString( sSecao,'EAN'      ,'');
               Prod.xProd    := INIRec.ReadString( sSecao,'Descricao','');
               if Length(INIRec.ReadString( sSecao,'NCM','')) > 0 then
                  Prod.NCM       := INIRec.ReadString( sSecao,'NCM'      ,'');
               if Length(INIRec.ReadString( sSecao,'EXTIPI','')) > 0 then
                  Prod.EXTIPI       := INIRec.ReadString( sSecao,'EXTIPI'      ,'');
               if Length(INIRec.ReadString( sSecao,'genero','')) > 0 then
                  Prod.genero       := INIRec.Readinteger( sSecao,'genero'      ,0);
               Prod.CFOP     := INIRec.ReadString( sSecao,'CFOP'     ,'');
               Prod.uCom     := INIRec.ReadString( sSecao,'Unidade'  ,'');
               Prod.qCom     := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0) ;
               Prod.vUnCom   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnitario','') ,0) ;
               Prod.vProd    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorTotal'   ,'') ,0) ;

               if Length(INIRec.ReadString( sSecao,'cEANTrib','')) > 0 then
                  Prod.cEANTrib      := INIRec.ReadString( sSecao,'cEANTrib'      ,'');
               Prod.uTrib     := INIRec.ReadString( sSecao,'uTrin'  , Prod.uCom);
               Prod.qTrib     := StringToFloatDef( INIRec.ReadString(sSecao,'qTrib'   ,'') ,Prod.qCom) ;
               Prod.vUnTrib   := StringToFloatDef( INIRec.ReadString(sSecao,'vUnTrib','') ,Prod.vUnCom) ;

               Prod.vFrete    := StringToFloatDef( INIRec.ReadString(sSecao,'vFrete','') ,0) ;
               Prod.vSeg      := StringToFloatDef( INIRec.ReadString(sSecao,'vSeg','') ,0) ;
               Prod.vDesc     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDesconto','') ,0) ;

               sNumeroDI := INIRec.ReadString(sSecao,'NumeroDI','') ;

               if sNumeroDI <> '' then
                begin
                  with Prod.DI.Add do
                   begin
                     nDi         := sNumeroDI;
                     dDi         := StrToDate(INIRec.ReadString(sSecao,'DataRegistroDI'  ,''));
                     xLocDesemb  := INIRec.ReadString(sSecao,'LocalDesembaraco','');
                     UFDesemb    := INIRec.ReadString(sSecao,'UFDesembaraco'   ,'');
                     dDesemb     := StrToDate(INIRec.ReadString(sSecao,'DataDesembaraco',''));
                     cExportador := INIRec.ReadString(sSecao,'CodigoExportador','');;

                     J := 1 ;
                     while true do
                      begin
                        sSecao      := 'LADI'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                        sNumeroADI := INIRec.ReadString(sSecao,'NumeroAdicao','FIM') ;
                        if (sNumeroADI = 'FIM') or (Length(sNumeroADI) <= 0) then
                           break;

                        with adi.Add do
                         begin
                           nAdicao     := StrToInt(sNumeroADI);
                           nSeqAdi     := J;
                           cFabricante := INIRec.ReadString( sSecao,'CodigoFrabricante','');
                           vDescDI     := StringToFloatDef( INIRec.ReadString(sSecao,'DescontoADI','') ,0);
                         end;
                        Inc(J)
                      end;
                   end;
                end;

               with Imposto do
                begin
                   sSecao := 'ICMS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                      with ICMS do
                      begin
                        CST    := StrToCSTICMS(OK,INIRec.ReadString( sSecao,'CST','00'));

                        if CST = cst00 then
                         begin
                           ICMS.orig   := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBC  := StrTomodBC(OK, INIRec.ReadString(sSecao,'Modalidade','0'));
                           ICMS.vBC    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           ICMS.pICMS  := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           ICMS.vICMS  := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                         end
                        else if CST = cst10 then
                         begin
                           ICMS.orig    := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBC   := StrTomodBC(OK, INIRec.ReadString(sSecao,'Modalidade','0'));
                           ICMS.vBC     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           ICMS.pICMS   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           ICMS.vICMS   := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                           ICMS.modBCST := StrTomodBCST(OK, INIRec.ReadString(sSecao,'ModalidadeST','0'));
                           ICMS.pMVAST  := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST' ,'') ,0);
                           ICMS.pRedBC  := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                           ICMS.vBCST   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                           ICMS.pICMSST := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                           ICMS.vICMSST := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                         end
                        else if CST = cst20 then
                         begin
                           ICMS.orig   := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBC  := StrTomodBC(OK, INIRec.ReadString(sSecao,'Modalidade','0'));
                           ICMS.pRedBC := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                           ICMS.vBC    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           ICMS.pICMS  := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           ICMS.vICMS  := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                         end
                        else if CST = cst30 then
                         begin
                           ICMS.orig     := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBCST  := StrTomodBCST(OK, INIRec.ReadString(sSecao,'ModalidadeST','0'));
                           ICMS.pMVAST   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST','') ,0);
                           ICMS.pRedBCST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                           ICMS.vBCST    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                           ICMS.pICMSST  := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                           ICMS.vICMSST  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                         end
                        else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
                         begin
                           ICMS.orig     := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                         end
                        else if CST = cst51 then
                         begin
                           ICMS.orig   := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBC  := StrTomodBC(OK, INIRec.ReadString(sSecao,'Modalidade','0'));
                           ICMS.pRedBC := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                           ICMS.vBC    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           ICMS.pICMS  := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           ICMS.vICMS  := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                         end
                        else if CST = cst60 then
                         begin
                           ICMS.orig     := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.vBCST := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                           ICMS.vICMSST     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                         end
                        else if CST = cst70 then
                         begin
                           ICMS.orig     := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBC    := StrTomodBC(OK, INIRec.ReadString(sSecao,'Modalidade','0'));
                           ICMS.pRedBC   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                           ICMS.vBC      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           ICMS.pICMS    := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           ICMS.vICMS    := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                           ICMS.modBCST  := StrTomodBCST(OK, INIRec.ReadString(sSecao,'ModalidadeST','0'));
                           ICMS.pMVAST   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST','') ,0);
                           ICMS.pRedBCST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                           ICMS.vBC      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                           ICMS.pICMSST  := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                           ICMS.vICMSST  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                         end
                        else if CST = cst90 then
                         begin
                           ICMS.orig     := StrToOrig( OK, INIRec.ReadString(sSecao,'Origem'    ,'0'));
                           ICMS.modBC    := StrTomodBC(OK, INIRec.ReadString(sSecao,'Modalidade','0'));
                           ICMS.pRedBC   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                           ICMS.vBC      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           ICMS.pICMS    := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           ICMS.vICMS    := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                           ICMS.modBCST  := StrTomodBCST(OK, INIRec.ReadString(sSecao,'ModalidadeST','0'));
                           ICMS.pMVAST   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST' ,'') ,0);
                           ICMS.pRedBCST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                           ICMS.vBCST    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                           ICMS.pICMSST  := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                           ICMS.vICMSST  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                         end;
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

                        if (CST = pis01) or (CST = pis02) then
                         begin
                           PIS.vBC  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           PIS.pPIS := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           PIS.vPIS := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                         end
                        else if CST = pis03 then
                         begin
                           PIS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                           PIS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                           PIS.vPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                         end
                        else if CST = pis99 then
                         begin
                           PIS.vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                           PIS.pPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                           PIS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                           PIS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'ValorAliquota'  ,'') ,0);
                           PIS.vPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase' ,'') ,0);
                         end;
                      end;
                    end;

                   sSecao    := 'PISST'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','FIM') ;
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

                        if (CST = cof01) or (CST = cof02)   then
                         begin
                           COFINS.vBC     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                           COFINS.pCOFINS := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                           COFINS.vCOFINS := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                         end
                        else if CST = cof03 then
                         begin
                           COFINS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                           COFINS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                           COFINS.vCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                         end
                        else if CST = cof99 then
                         begin
                           COFINS.vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
//                           COFINS.TipoCalculo := TNFeTipoCalculo( INIRec.ReadInteger(sSecao,'TipoCalculo',0)) ;
                           COFINS.pCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                           COFINS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                           COFINS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'ValorAliquota'  ,'') ,0);
                           COFINS.vCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase' ,'') ,0);
                         end;
                      end;
                    end;

                   sSecao    := 'COFINSST'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','FIM') ;
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
                         end;
                      end;
                    end;
                end;

             end;
            Inc( I ) ;
          end ;

         Total.ICMSTot.vBC     := StringToFloatDef( INIRec.ReadString('Total','BaseICMS'     ,'') ,0) ;
         Total.ICMSTot.vICMS   := StringToFloatDef( INIRec.ReadString('Total','ValorICMS'    ,'') ,0) ;
         Total.ICMSTot.vProd   := StringToFloatDef( INIRec.ReadString('Total','ValorProduto' ,'') ,0) ;
         Total.ICMSTot.vBCST   := StringToFloatDef( INIRec.ReadString('Total','BaseICMSSubstituicao' ,'') ,0) ;
         Total.ICMSTot.vST     := StringToFloatDef( INIRec.ReadString('Total','ValorICMSSubstituicao','') ,0) ;
         Total.ICMSTot.vFrete  := StringToFloatDef( INIRec.ReadString('Total','ValorFrete'   ,'') ,0) ;
         Total.ICMSTot.vSeg    := StringToFloatDef( INIRec.ReadString('Total','ValorSeguro'  ,'') ,0) ;
         Total.ICMSTot.vDesc   := StringToFloatDef( INIRec.ReadString('Total','ValorDesconto','') ,0) ;
         Total.ICMSTot.vII     := StringToFloatDef( INIRec.ReadString('Total','ValorII'      ,'') ,0) ;
         Total.ICMSTot.vIPI    := StringToFloatDef( INIRec.ReadString('Total','ValorIPI'     ,'') ,0) ;
         Total.ICMSTot.vPIS    := StringToFloatDef( INIRec.ReadString('Total','ValorPIS'     ,'') ,0) ;
         Total.ICMSTot.vCOFINS := StringToFloatDef( INIRec.ReadString('Total','ValorCOFINS'  ,'') ,0) ;
         Total.ICMSTot.vOutro  := StringToFloatDef( INIRec.ReadString('Total','ValorOutrasDespesas','') ,0) ;
         Total.ISSQNtot.vServ  := StringToFloatDef( INIRec.ReadString('Total','ValorServicos','') ,0) ;
         Total.ISSQNTot.vBC    := StringToFloatDef( INIRec.ReadString('Total','ValorBaseISS','') ,0) ;
         Total.ISSQNTot.vISS   := StringToFloatDef( INIRec.ReadString('Total','ValorISSQN','') ,0) ;
         Total.ISSQNTot.vPIS   := StringToFloatDef( INIRec.ReadString('Total','ValorPISISS','') ,0) ;
         Total.ISSQNTot.vCOFINS := StringToFloatDef( INIRec.ReadString('Total','ValorCONFINSISS','') ,0) ;
         Total.ICMSTot.vNF     := StringToFloatDef( INIRec.ReadString('Total','ValorNota'    ,'') ,0) ;

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
               dVenc := StrToDate(INIRec.ReadString( sSecao,'DataVencimento',''));
               vDup  := StringToFloatDef( INIRec.ReadString(sSecao,'Valor','') ,0) ;
             end;
            Inc(I);
          end;

         InfAdic.infCpl     :=  INIRec.ReadString( 'DadosAdicionais','Complemento','');
         InfAdic.infAdFisco :=  INIRec.ReadString( 'DadosAdicionais','Fisco','');

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

       end;
   finally
      INIRec.Free ;
   end;
  end;
end;

procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL : Boolean);
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m:TMimemess;
  p: TMimepart;
begin
  msg_lines := TStringList.Create;
  smtp := TSMTPSend.Create;
 m:=TMimemess.create;
  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
        m.AddPartText(sMensagem, p);
     if sAttachment <> '' then
       m.AddPartBinaryFromFile(sAttachment, p);
     if sAttachment2 <> '' then
       m.AddPartBinaryFromFile(sAttachment2, p);
     m.header.tolist.add(sTo);
     m.header.From := sFrom;
     m.header.subject:=sAssunto;
     m.EncodeMessage;
     msg_lines.Add(m.Lines.Text);

     smtp.UserName := sSmtpUser;
     smtp.Password := sSmtpPasswd;

     smtp.TargetHost := sSmtpHost;
     smtp.TargetPort := sSmtpPort;

     smtp.FullSSL := SSL;
     smtp.AutoTLS := SSL;
     if not smtp.Login() then
       raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString);

     if not smtp.MailFrom(sFrom, Length(sFrom)) then
       raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString);
     if not smtp.MailTo(sTo) then
       raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString);
     if not smtp.MailData(msg_lines) then
       raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString);

     if not smtp.Logout() then
       raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString);
  finally
     msg_lines.Free;
     smtp.Free;
     m.free;
  end;
end;

end.
