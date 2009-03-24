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
procedure GerarIniNFe( AStr: WideString ) ;

implementation

Uses IniFiles, StrUtils, DateUtils,
  Windows, Forms, sndkey32,
  ACBrUtil, ACBrNFeMonitor1 , ACBrNFeWebServices, ACBrNFe,
  ACBrNFeConfiguracoes, ACBrNFeTypes, ACBrNFeNotasFiscais,
  ACBrNFeDadosProdutos, ACBrNFeXML, ACBrNFeTransportador,
  ACBrNFeDadosAdicionais;

Procedure DoACBrNFe( Cmd : TACBrNFeCmd ) ;
var
  I : Integer;
  ArqNFe : String;
  Salva  : Boolean;
  SL     : TStringList;
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
           Cmd.Resposta :=  ACBrNFe1.WebServices.Retorno.Msg;
         end

        else if (Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarenviarnfe')then
         begin
           GerarIniNFe( Cmd.Params(0)  ) ;

           Salva := ACBrNFe1.Configuracoes.Geral.Salvar;
           if not Salva then
            begin
             ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
             ACBrNFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
            end;
           ACBrNFe1.Configuracoes.Geral.Salvar := True;
           ACBrNFe1.NotasFiscais.GerarNFe;
           ACBrNFe1.NotasFiscais.Assinar;
           ACBrNFe1.NotasFiscais.Valida;
           ACBrNFe1.Configuracoes.Geral.Salvar := Salva;

           ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[0].XML.GetNFeChave, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';

           SL := TStringList.Create;
           SL.LoadFromFile(ArqNFe);
           if (Cmd.Metodo = 'criarnfe') and (Cmd.Params(1) = '1') then
              Cmd.Resposta :=  'NFe criada em: '+ArqNFe+sLineBreak+SL.Text
           else
              Cmd.Resposta :=  'NFe criada em: '+ArqNFe;

           SL.Free;
           if Cmd.Metodo = 'criarenviarnfe' then
            begin
              if ACBrNFe1.WebServices.Envia(StrToInt(Cmd.Params(1))) then
               begin
                 for I:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
                  begin
                    if ACBrNFe1.NotasFiscais.Items[i].XML.Confirmada then
                     begin
                       Cmd.Resposta :=  Cmd.Resposta+sLineBreak+
                                        ACBrNFe1.NotasFiscais.Items[i].XML.NFe.InfNFe.Ide.NNF+' - '+ACBrNFe1.NotasFiscais.Items[i].XML.Msg;
                       if (Cmd.Params(2) = '1') then
                          ACBrNFe1.NotasFiscais.Items[i].XML.Imprimir;
                     end;
                  end;
               end;
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+ACBrNFe1.WebServices.Retorno.Msg;
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

procedure GerarIniNFe( AStr: WideString ) ;
var
  I, J : Integer;
  sSecao, sCodPro, sNumeroDI, sNumeroADI, sQtdVol, sNumDup, sCampoAdic : String;
  INIRec : TMemIniFile ;
  SL     : TStringList;
begin
 INIRec := TMemIniFile.create( 'nfe.ini' ) ;
 SL := TStringList.Create;
 Sl.Text := ConvertStrRecived( Astr );
 INIRec.SetStrings( SL );
 SL.Free ;
 with frmAcbrNfeMonitor do
  begin
   try
      ACBrNFe1.NotasFiscais.Clear;
      with ACBrNFe1.NotasFiscais.Add do
       begin
         Identificacao.NaturezaOperacao  := INIRec.ReadString(  'Identificacao','NaturezaOperacao' ,'');
         Identificacao.Modelo            := INIRec.ReadInteger( 'Identificacao','Modelo' ,55);
         Identificacao.Serie             := INIRec.ReadInteger( 'Identificacao','Serie'  ,1);
         Identificacao.Codigo            := INIRec.ReadInteger( 'Identificacao','Codigo' ,0);
         Identificacao.Numero            := INIRec.ReadInteger( 'Identificacao','Numero' ,0);
         Identificacao.DataEmissao       := StrToDate(INIRec.ReadString( 'Identificacao','Emissao',''));
         Identificacao.DataSaida         := StrToDate(INIRec.ReadString( 'Identificacao','Saida'  ,''));
         Identificacao.Tipo              := TNFeTipo(INIRec.ReadInteger( 'Identificacao','Tipo',1));
         Identificacao.FormaPagamento    := TNFeFormaPagamento(INIRec.ReadInteger( 'Identificacao','FormaPag',0));
         Identificacao.Finalidade        := TNFeFinalidade(INIRec.ReadInteger( 'Identificacao','Finalidade',0));

         Emitente.CNPJ                      := INIRec.ReadString(  'Emitente','CNPJ'    ,'');
         Emitente.IE                        := INIRec.ReadString(  'Emitente','IE'      ,'');
         Emitente.Nome.RazaoSocial          := INIRec.ReadString(  'Emitente','Razao'   ,'');
         Emitente.Nome.Fantasia             := INIRec.ReadString(  'Emitente','Fantasia','');
         Emitente.Endereco.Fone             := INIRec.ReadString(  'Emitente','Fone' ,'');
         Emitente.Endereco.CEP              := INIRec.ReadString(  'Emitente','CEP'  ,'');
         Emitente.Endereco.Logradouro       := INIRec.ReadString(  'Emitente','Logradouro' ,'');
         Emitente.Endereco.Numero           := INIRec.ReadString(  'Emitente','Numero'     ,'');
         Emitente.Endereco.Complemento      := INIRec.ReadString(  'Emitente','Complemento','');
         Emitente.Endereco.Bairro           := INIRec.ReadString(  'Emitente','Bairro'     ,'');
         Emitente.Endereco.Cidade.Codigo    := INIRec.ReadInteger( 'Emitente','CidadeCod'  ,0);
         Emitente.Endereco.Cidade.Descricao := INIRec.ReadString(  'Emitente','Cidade'     ,'');
         Emitente.Endereco.UF               := INIRec.ReadString(  'Emitente','UF'         ,'');
         Emitente.Endereco.Pais.Codigo      := INIRec.ReadInteger( 'Emitente','PaisCod'    ,0);
         Emitente.Endereco.Pais.Descricao   := INIRec.ReadString(  'Emitente','Pais'       ,'');

         Destinatario.CNPJCPF                   := INIRec.ReadString(  'Destinatario','CNPJ'       ,'');
         Destinatario.IE                        := INIRec.ReadString(  'Destinatario','IE'         ,'');
         Destinatario.ISUF                      := INIRec.ReadString(  'Destinatario','ISUF'         ,'');
         Destinatario.NomeRazao                 := INIRec.ReadString(  'Destinatario','NomeRazao'  ,'');
         Destinatario.Endereco.Fone             := INIRec.ReadString(  'Destinatario','Fone'       ,'');
         Destinatario.Endereco.CEP              := INIRec.ReadString(  'Destinatario','CEP'       ,'');
         Destinatario.Endereco.Logradouro       := INIRec.ReadString(  'Destinatario','Logradouro' ,'');
         Destinatario.Endereco.Numero           := INIRec.ReadString(  'Destinatario','Numero'     ,'');
         Destinatario.Endereco.Complemento      := INIRec.ReadString(  'Destinatario','Complemento','');
         Destinatario.Endereco.Bairro           := INIRec.ReadString(  'Destinatario','Bairro'     ,'');
         Destinatario.Endereco.Cidade.Codigo    := INIRec.ReadInteger( 'Destinatario','CidadeCod'  ,0);
         Destinatario.Endereco.Cidade.Descricao := INIRec.ReadString(  'Destinatario','Cidade'     ,'');
         Destinatario.Endereco.UF               := INIRec.ReadString(  'Destinatario','UF'         ,'');
         Destinatario.Endereco.Pais.Codigo      := INIRec.ReadInteger( 'Destinatario','PaisCod'    ,0);
         Destinatario.Endereco.Pais.Descricao   := INIRec.ReadString(  'Destinatario','Pais'       ,'');

         I := 1 ;
         while true do
          begin
            sSecao    := 'Produto'+IntToStrZero(I,3) ;
            sCodPro   := INIRec.ReadString(sSecao,'Codigo','FIM') ;
            if sCodPro = 'FIM' then
               break ;

            with DadosProdutos.Add do
             begin
               CFOP          := INIRec.ReadInteger(sSecao,'CFOP'     ,0);
               Codigo        := INIRec.ReadString( sSecao,'Codigo'   ,'');
               Descricao     := INIRec.ReadString( sSecao,'Descricao','');
               EAN           := INIRec.ReadString( sSecao,'EAN'      ,'');
               NCM           := INIRec.ReadString( sSecao,'NCM'      ,'');
               Unidade       := INIRec.ReadString( sSecao,'Unidade'  ,'');
               Quantidade    := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0) ;
               ValorUnitario := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnitario','') ,0) ;
               ValorTotal    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorTotal'   ,'') ,0) ;
               ValorDesconto := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDesconto','') ,0) ;

               sNumeroDI := INIRec.ReadString(sSecao,'NumeroDI','') ;

               if sNumeroDI <> '' then
                begin
                  with DI do
                   begin
                     NumeroDI         := sNumeroDI;
                     DataRegistroDI   := StrToDate(INIRec.ReadString(sSecao,'DataRegistroDI'  ,''));
                     LocalDesembaraco := INIRec.ReadString(sSecao,'LocalDesembaraco','');
                     UFDesembaraco    := INIRec.ReadString(sSecao,'UFDesembaraco'   ,'');
                     DataDesembaraco  := StrToDate(INIRec.ReadString(sSecao,'DataDesembaraco',''));
                     CodigoExportador := INIRec.ReadString(sSecao,'CodigoExportador','');;

                     J := 1 ;
                     while true do
                      begin
                        sSecao      := 'LADI'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                        sNumeroADI := INIRec.ReadString(sSecao,'NumeroAdicao','FIM') ;
                        if (sNumeroADI = 'FIM') or (Length(sNumeroADI) <= 0) then
                           break;

                        with LADI.Add do
                         begin
                           NumeroAdicao      := StrToInt(sNumeroADI);
                           CodigoFrabricante := INIRec.ReadString( sSecao,'CodigoFrabricante','');
                           ValorDesconto     := StringToFloatDef( INIRec.ReadString(sSecao,'DescontoADI','') ,0);
                         end;
                        Inc(J)  
                      end;
                   end;
                end;

               with Tributos do
                begin
                  with ICMS do
                   begin
                     sSecao    := 'ICMS'+IntToStrZero(I,3) ;
                     CST := INIRec.ReadString( sSecao,'CST','');

                     if CST = '00' then
                      begin
                        ICMS00.Origem     := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS00.Modalidade := TNFeModalidade(INIRec.ReadInteger(sSecao,'Modalidade',0));
                        ICMS00.ValorBase  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS00.Aliquota   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS00.Valor      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                      end
                     else if CST = '10' then
                      begin
                        ICMS10.Origem       := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS10.Modalidade   := TNFeModalidade(INIRec.ReadInteger(sSecao,'Modalidade',0));
                        ICMS10.ValorBase    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS10.Aliquota     := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS10.Valor        := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                        ICMS10.ModalidadeST := TNFeModalidadeST(INIRec.ReadInteger(sSecao,'ModalidadeST',0));
                        ICMS10.PercentualMargemST  := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST' ,'') ,0);
                        ICMS10.PercentualReducaoST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                        ICMS10.ValorBaseST  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                        ICMS10.AliquotaST   := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                        ICMS10.ValorST      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                      end
                     else if CST = '20' then
                      begin
                        ICMS20.Origem            := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS20.Modalidade        := TNFeModalidade(INIRec.ReadInteger(sSecao,'Modalidade',0));
                        ICMS20.PercentualReducao := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                        ICMS20.ValorBase         := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS20.Aliquota          := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS20.Valor             := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                      end
                     else if CST = '30' then
                      begin
                        ICMS30.Origem              := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS30.ModalidadeST        := TNFeModalidadeST(INIRec.ReadInteger(sSecao,'ModalidadeST',0));
                        ICMS30.PercentualMargemST  := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST','') ,0);
                        ICMS30.PercentualReducaoST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                        ICMS30.ValorBaseST         := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                        ICMS30.AliquotaST          := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                        ICMS30.ValorST             := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                      end
                     else if (CST = '40') or (CST = '41') or (CST = '50') then
                      begin
                        ICMS40_41_50.Origem := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                      end
                     else if CST = '51' then
                      begin
                        ICMS51.Origem            := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS51.Modalidade        := TNFeModalidade(INIRec.ReadInteger(sSecao,'Modalidade',0));
                        ICMS51.PercentualReducao := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                        ICMS51.ValorBase         := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS51.Aliquota          := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS51.Valor             := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                      end
                     else if CST = '60' then
                      begin
                        ICMS60.Origem      := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS60.ValorBaseST := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                        ICMS60.ValorST     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                      end
                     else if CST = '70' then
                      begin
                        ICMS70.Origem            := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS70.Modalidade        := TNFeModalidade(INIRec.ReadInteger(sSecao,'Modalidade',0));
                        ICMS70.PercentualReducao := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                        ICMS70.ValorBase         := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS70.Aliquota          := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS70.Valor             := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                        ICMS70.ModalidadeST      := TNFeModalidadeST(INIRec.ReadInteger(sSecao,'ModalidadeST',0));
                        ICMS70.PercentualMargemST  := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST','') ,0);
                        ICMS70.PercentualReducaoST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                        ICMS70.ValorBaseST       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                        ICMS70.AliquotaST        := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                        ICMS70.ValorST           := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                      end
                     else if CST = '90' then
                      begin
                        ICMS90.Origem       := TNFeOrigem(    INIRec.ReadInteger(sSecao,'Origem'    ,0));
                        ICMS90.Modalidade   := TNFeModalidade(INIRec.ReadInteger(sSecao,'Modalidade',0));
                        ICMS90.PercentualReducao := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao','') ,0);
                        ICMS90.ValorBase    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        ICMS90.Aliquota     := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        ICMS90.Valor        := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                        ICMS90.ModalidadeST := TNFeModalidadeST(INIRec.ReadInteger(sSecao,'ModalidadeST',0));
                        ICMS90.PercentualMargemST  := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST' ,'') ,0);
                        ICMS90.PercentualReducaoST := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST','') ,0);
                        ICMS90.ValorBaseST  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST','') ,0);
                        ICMS90.AliquotaST   := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,'') ,0);
                        ICMS90.ValorST      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,'') ,0);
                      end;
                   end;

                  with IPI do
                   begin
                     sSecao    := 'IPI'+IntToStrZero(I,3) ;

                     CST := INIRec.ReadString( sSecao,'CST','') ;
                     ClasseEnquadramento := INIRec.ReadString(  sSecao,'ClasseEnquadramento','');
                     CNPJProdutor        := INIRec.ReadString(  sSecao,'CNPJProdutor'       ,'');
                     CodigoSeloIPI       := INIRec.ReadString(  sSecao,'CodigoSeloIPI'      ,'');
                     QuantidadeSelos     := StringToFloatDef( INIRec.ReadString(sSecao,'QuantidadeSelos'    ,'') ,0);
                     CodigoEnquadramento := INIRec.ReadString(  sSecao,'CodigoEnquadramento','');

                     ValorBase    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'   ,'') ,0);
                     Quantidade   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'  ,'') ,0);
                     ValorUnidade := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnidade','') ,0);
                     Aliquota     := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'    ,'') ,0);
                     Valor        := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'       ,'') ,0);
                   end;

                  with II do
                   begin
                     sSecao    := 'II'+IntToStrZero(I,3) ;

                     ValorBase := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                     ValorDespAduaneiras := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDespAduaneiras'   ,'') ,0);
                     ValorII   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorII'  ,'') ,0);
                     ValorIOF  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorIOF' ,'') ,0);
                   end;

                  with PIS do
                   begin
                     sSecao    := 'PIS'+IntToStrZero(I,3) ;
                     CST := INIRec.ReadString( sSecao,'CST','01');

                     if (CST = '01') or (CST = '02') then
                      begin
                        PIS01_02.ValorBase := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        PIS01_02.Aliquota  := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        PIS01_02.Valor     := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                      end
                     else if CST = '03' then
                      begin
                        PIS03.Quantidade := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                        PIS03.Aliquota   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                        PIS03.Valor      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                      end
                     else if CST = '99' then
                      begin
                        PIS99.Valor       := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                        PIS99.TipoCalculo := TNFeTipoCalculo( INIRec.ReadInteger(sSecao,'TipoCalculo',0));
                        PIS99.Quantidade  := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                        PIS99.Aliquota    := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                        PIS99.ValorBase   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase' ,'') ,0);
                      end;
                   end;

                  with PISST do
                   begin
                     sSecao    := 'PISST'+IntToStrZero(I,3) ;
                     ValorBase     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,'') ,0);
                     AliquotaPerc  := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaPerc' ,'') ,0);
                     Quantidade    := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0);
                     AliquotaValor := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaValor','') ,0);
                     ValorPISST    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorPISST'   ,'') ,0);
                   end;

                  with COFINS do
                   begin
                     sSecao    := 'COFINS'+IntToStrZero(I,3) ;
                     CST := INIRec.ReadString( sSecao,'CST','01');

                     if (CST = '01') or (CST = '02')   then
                      begin
                        COFINS01_02.ValorBase := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase','') ,0);
                        COFINS01_02.Aliquota  := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,'') ,0);
                        COFINS01_02.Valor     := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,'') ,0);
                      end
                     else if CST = '03' then
                      begin
                        COFINS03.Quantidade := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                        COFINS03.Aliquota   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                        COFINS03.Valor      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                      end
                     else if CST = '99' then
                      begin
                        COFINS99.Valor       := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'     ,'') ,0);
                        COFINS99.TipoCalculo := TNFeTipoCalculo( INIRec.ReadInteger(sSecao,'TipoCalculo',0)) ;
                        COFINS99.Quantidade  := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade','') ,0);
                        COFINS99.Aliquota    := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'  ,'') ,0);
                        COFINS99.ValorBase   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase' ,'') ,0);
                      end;
                   end;

                  with COFINSST do
                   begin
                     sSecao    := 'COFINSST'+IntToStrZero(I,3) ;

                     ValorBase     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,'') ,0);
                     AliquotaPerc  := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaPerc' ,'') ,0);
                     Quantidade    := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,'') ,0);
                     AliquotaValor := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaValor','') ,0);
                     ValorCOFINSST := StringToFloatDef( INIRec.ReadString(sSecao,'ValorCOFINSST','') ,0);
                   end;
                end;

             end;
            Inc( I ) ;
          end ;

         ValoresTotais.BaseICMS      := StringToFloatDef( INIRec.ReadString('Total','BaseICMS'     ,'') ,0) ;
         ValoresTotais.ValorICMS     := StringToFloatDef( INIRec.ReadString('Total','ValorICMS'    ,'') ,0) ;
         ValoresTotais.ValorProduto  := StringToFloatDef( INIRec.ReadString('Total','ValorProduto' ,'') ,0) ;
         ValoresTotais.BaseICMSSubstituicao  := StringToFloatDef( INIRec.ReadString('Total','BaseICMSSubstituicao' ,'') ,0) ;
         ValoresTotais.ValorICMSSubstituicao := StringToFloatDef( INIRec.ReadString('Total','ValorICMSSubstituicao','') ,0) ;
         ValoresTotais.ValorFrete    := StringToFloatDef( INIRec.ReadString('Total','ValorFrete'   ,'') ,0) ;
         ValoresTotais.ValorSeguro   := StringToFloatDef( INIRec.ReadString('Total','ValorSeguro'  ,'') ,0) ;
         ValoresTotais.ValorDesconto := StringToFloatDef( INIRec.ReadString('Total','ValorDesconto','') ,0) ;
         ValoresTotais.ValorII       := StringToFloatDef( INIRec.ReadString('Total','ValorII'      ,'') ,0) ;
         ValoresTotais.ValorIPI      := StringToFloatDef( INIRec.ReadString('Total','ValorIPI'     ,'') ,0) ;
         ValoresTotais.ValorPIS      := StringToFloatDef( INIRec.ReadString('Total','ValorPIS'     ,'') ,0) ;
         ValoresTotais.ValorCOFINS   := StringToFloatDef( INIRec.ReadString('Total','ValorCOFINS'  ,'') ,0) ;
         ValoresTotais.ValorOutrasDespesas := StringToFloatDef( INIRec.ReadString('Total','ValorOutrasDespesas','') ,0) ;
         ValoresTotais.ValorNota     := StringToFloatDef( INIRec.ReadString('Total','ValorNota'    ,'') ,0) ;

         Transportador.FretePorConta := TNFeFrete(INIRec.ReadInteger('Transportador','FretePorConta',0));
         Transportador.CnpjCpf       := INIRec.ReadString('Transportador','CnpjCpf'  ,'');
         Transportador.NomeRazao     := INIRec.ReadString('Transportador','NomeRazao','');
         Transportador.IE            := INIRec.ReadString('Transportador','IE'       ,'');
         Transportador.Endereco      := INIRec.ReadString('Transportador','Endereco' ,'');
         Transportador.Cidade        := INIRec.ReadString('Transportador','Cidade'   ,'');
         Transportador.UF            := INIRec.ReadString('Transportador','UF'       ,'');

         Transportador.RetencaoICMS.ValorServico := StringToFloatDef( INIRec.ReadString('Transportador','ValorServico','') ,0) ;
         Transportador.RetencaoICMS.ValorBase    := StringToFloatDef( INIRec.ReadString('Transportador','ValorBase'   ,'') ,0) ;
         Transportador.RetencaoICMS.Aliquota     := StringToFloatDef( INIRec.ReadString('Transportador','Aliquota'    ,'') ,0) ;
         Transportador.RetencaoICMS.Valor        := StringToFloatDef( INIRec.ReadString('Transportador','Valor'       ,'') ,0) ;
         Transportador.RetencaoICMS.CFOP         := INIRec.ReadInteger('Transportador','CFOP'     ,0);
         Transportador.RetencaoICMS.Cidade       := INIRec.ReadInteger('Transportador','CidadeCod',0);

         Transportador.Veiculo.Placa := INIRec.ReadString('Transportador','Placa'  ,'');
         Transportador.Veiculo.UF    := INIRec.ReadString('Transportador','UFPlaca','');
         Transportador.Veiculo.RNTC  := INIRec.ReadString('Transportador','RNTC'   ,'');

         I := 1 ;
         while true do
          begin
            sSecao    := 'Volume'+IntToStrZero(I,3) ;
            sQtdVol   := INIRec.ReadString(sSecao,'Quantidade','FIM') ;
            if (sQtdVol = 'FIM') or (Length(sQtdVol) <= 0)  then
               break ;

            with Transportador.Volumes.Add do
             begin
               Quantidade  := StrToInt(sQtdVol);
               Especie     := INIRec.ReadString( sSecao,'Especie'  ,'');
               Marca       := INIRec.ReadString( sSecao,'Marca'    ,'');
               Numeracao   := INIRec.ReadString( sSecao,'Numeracao','');
               PesoLiquido := StringToFloatDef( INIRec.ReadString(sSecao,'PesoLiquido','') ,0) ;
               PesoBruto   := StringToFloatDef( INIRec.ReadString(sSecao,'PesoBruto'  ,'') ,0) ;
             end;
            Inc(I);
          end;

         Fatura.Numero        := INIRec.ReadString( 'Fatura','Numero','');
         Fatura.ValorOriginal := StringToFloatDef( INIRec.ReadString('Fatura','ValorOriginal','') ,0) ;
         Fatura.ValorDesconto := StringToFloatDef( INIRec.ReadString('Fatura','ValorDesconto','') ,0) ;
         Fatura.ValorLiquido  := StringToFloatDef( INIRec.ReadString('Fatura','ValorLiquido' ,'') ,0) ;

         I := 1 ;
         while true do
          begin
            sSecao    := 'Duplicata'+IntToStrZero(I,3) ;
            sNumDup   := INIRec.ReadString(sSecao,'Numero','FIM') ;
            if (sNumDup = 'FIM') or (Length(sNumDup) <= 0) then
               break ;

            with Fatura.Duplicatas.Add do
             begin
               Numero         := sNumDup;
               DataVencimento := StrToDate(INIRec.ReadString( sSecao,'DataVencimento',''));
               Valor          := StringToFloatDef( INIRec.ReadString(sSecao,'Valor','') ,0) ;
             end;
            Inc(I);
          end;

         DadosAdicionais.Complemento :=  INIRec.ReadString( 'DadosAdicionais','Complemento','');

         I := 1 ;
         while true do
          begin
            sSecao     := 'InfAdic'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'Campo','FIM') ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with DadosAdicionais.Informacoes.Add do
             begin
               Campo := sCampoAdic;
               Texto := INIRec.ReadString( sSecao,'Texto','');
             end;
            Inc(I);
          end;

       end;
   finally
      INIRec.Free ;
   end;
  end;
end;

end.
