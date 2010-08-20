{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunicação com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2006 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Juliana Rodrigues Prado Tamizou                 }
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

{$mode objfpc}{$H+}

unit DoBoletoUnit;

interface

uses
  Classes, SysUtils, CmdUnit,IniFiles;

procedure DoBoleto(Cmd: TACBrCmd);
procedure LerIniBoletos(aStr:WideString);
procedure IncluirTitulo(aIni: TIniFile; Sessao: String);


implementation

uses ACBrBoleto, ACBrUtil, ACBrMonitor1, DoACBrUnit ;

procedure DoBoleto ( Cmd: TACBrCmd ) ;
begin
   with FrmACBrMonitor.ACBrBoleto1 do
   begin
      if Cmd.Metodo = 'configurarcedente' then
       begin
         with Cedente do
         begin
            Nome          := Cmd.Params(0);
            CNPJCPF       := Cmd.Params(1);
            Logradouro    := Cmd.Params(3);
            NumeroRes     := cmd.Params(4);
            Complemento   := cmd.Params(5);
            Bairro        := cmd.Params(6);
            Cidade        := cmd.Params(7);
            UF            := Cmd.Params(8);
            CEP           := Cmd.Params(9);

            FrmACBrMonitor.cbxBOLF_J.ItemIndex := StrToIntDef(cmd.Params(2),2);

            case  FrmACBrMonitor.cbxBOLF_J.ItemIndex of
               0: TipoInscricao := pFisica;
               1: TipoInscricao := pJuridica;
              else
                 TipoInscricao := pOutras;
            end;

            FrmACBrMonitor.cbxBOLEmissao.ItemIndex := StrToIntDef(cmd.Params(10),0);
            case FrmACBrMonitor.cbxBOLEmissao.ItemIndex of
              0: ResponEmissao := tbCliEmite;
              1: ResponEmissao := tbBancoEmite;
              2: ResponEmissao := tbBancoReemite;
              3: ResponEmissao := tbBancoNaoReemite;
              else
                ResponEmissao := tbCliEmite;
            end;
         end;

         with FrmACBrMonitor do
         begin
            edtBOLRazaoSocial.Text  := Cedente.Nome;
            edtBOLCNPJ.Text         := Cedente.CNPJCPF;
            edtBOLLogradouro.Text   := Cedente.Logradouro;
            edtBOLNumero.Text       := Cedente.NumeroRes;
            edtBOLBairro.Text       := Cedente.Bairro;
            edtBOLCidade.Text       := Cedente.Cidade;
            edtBOLComplemento.Text  := Cedente.Complemento;
            cbxBOLUF.Text           := Cedente.UF;
            edtBOLCEP.Text          := Cedente.CEP;

            SalvarConfBoletos;
         end;

       end
      else if Cmd.Metodo = 'configurarconta' then
       begin
          with Cedente do
          begin
            Conta         := cmd.Params(0);
            ContaDigito   := Cmd.Params(1);
            Agencia       := cmd.Params(2);
            AgenciaDigito := Cmd.Params(3);
          end;

          with FrmACBrMonitor do
          begin
            edtBOLConta.Text         := Cedente.Conta;
            edtBOLDigitoConta.Text   := Cedente.ContaDigito;
            edtBOLAgencia.Text       := Cedente.Agencia;
            edtBOLDigitoAgencia.Text := Cedente.AgenciaDigito;

            SalvarConfBoletos;
          end;
       end

      else if cmd.Metodo = 'configurarbanco' then
       begin
         Banco.Numero := StrToInt(cmd.Params(0));
         FrmACBrMonitor.cbxBOLBanco.Text:= IntToStrZero(Banco.Numero,3);
         FrmACBrMonitor.SalvarConfBoletos;
       end

      else if cmd.Metodo = 'limparlista' then
         ListadeBoletos.Clear

      else if cmd.Metodo = 'totaltituloslista' then
         Cmd.Resposta:= IntToStr(ListadeBoletos.Count)

      else if cmd.Metodo = 'imprimir' then
         Imprimir

      else if cmd.Metodo = 'gerarpdf' then
         GerarPDF

      else if cmd.Metodo = 'gerarhtml' then
         GerarHTML

      else if cmd.Metodo = 'gerarremessa' then
       begin
         DirArqRemessa := Cmd.Params(0);
         GerarRemessa( StrToInt(cmd.Params(1)))
       end

      else if cmd.Metodo = 'lerretorno' then
       begin
         DirArqRetorno  := Cmd.Params(0);
         NomeArqRetorno := cmd.Params(1);
         LerRetorno();
       end

      else if cmd.Metodo = 'incluirtitulos' then
       begin
        LerIniBoletos(Cmd.Params(0));
        if Cmd.Params(1) = 'I' then
          Imprimir
        else if Cmd.Params(1)= 'P' then
          GerarPDF;
      end;
   end;

end;

procedure LerIniBoletos( aStr: WideString ) ;
var
   IniBoletos: TMemIniFile;
   SL: TStringList;
   ContTitulos: Integer;
   NomeSessao: String;
   Emissao: LongInt;
begin
  IniBoletos := TMemIniFile.Create('boletos.ini');
  SL         := TStringList.Create;

  if (pos(#10,aStr) = 0) and FileExists(aStr) then
     SL.LoadFromFile(aStr)
  else
    SL.Text := ConvertStrRecived(aStr);

  IniBoletos.SetStrings(SL);
  SL.Free;

  with FrmACBrMonitor.ACBrBoleto1 do
  begin
     if IniBoletos.SectionExists('Cedente') then
     begin
        with Cedente do
        begin
           Nome          := IniBoletos.ReadString('BOLETO','Cedente.Nome',Nome);
           CNPJCPF       := IniBoletos.ReadString('BOLETO','Cedente.CNPJCPF',CNPJCPF);
           Logradouro    := IniBoletos.ReadString('BOLETO','Cedente.Logradouro',Logradouro);
           NumeroRes     := IniBoletos.ReadString('BOLETO','Cedente.Numero',NumeroRes);
           Bairro        := IniBoletos.ReadString('BOLETO','Cedente.Bairro','');
           Cidade        := IniBoletos.ReadString('BOLETO','Cedente.Cidade','');
           CEP           := IniBoletos.ReadString('BOLETO','Cedente.CEP','');
           Complemento   := IniBoletos.ReadString('BOLETO','Cedente.Complemento','');
           UF            := IniBoletos.ReadString('BOLETO','Cedente.UF','');

           Emissao:= IniBoletos.ReadInteger('BOLETO','Cedente.RespEmis',0);
           case Emissao of
              0: ResponEmissao := tbCliEmite;
              1: ResponEmissao := tbBancoEmite;
              2: ResponEmissao := tbBancoReemite;
              3: ResponEmissao := tbBancoNaoReemite;
             else
               ResponEmissao := tbCliEmite;
           end;
        end;
     end;

     if IniBoletos.SectionExists('Conta') then
     begin
        with Cedente do
        begin
          Conta         := IniBoletos.ReadString('BOLETO','Conta','');
          ContaDigito   := IniBoletos.ReadString('BOLETO','DigitoConta','');
          Agencia       := IniBoletos.ReadString('BOLETO','Agencia','');
          AgenciaDigito := IniBoletos.ReadString('BOLETO','DigitoAgencia','');
        end;
     end;

     if IniBoletos.SectionExists('Banco') then
        Banco.Numero := IniBoletos.ReadInteger('BOLETO','Banco',0);

     if IniBoletos.SectionExists('Titulo') then
        IncluirTitulo(IniBoletos,'Titulo');

     ContTitulos := 1;
     NomeSessao  := 'Titulo1' ;
     while IniBoletos.SectionExists(NomeSessao)do
     begin
        IncluirTitulo( IniBoletos, NomeSessao );
        Inc( ContTitulos );
        NomeSessao := 'Titulo'+IntToStr( ContTitulos );
     end;
  end;
end;

procedure IncluirTitulo ( aIni: TIniFile; Sessao: String ) ;
var
   Titulo : TACBrTitulo;
   MemFormatada : String;
begin
   with FrmACBrMonitor.ACBrBoleto1 do
   begin
      Titulo := CriarTituloNaLista;

      MemFormatada := aIni.ReadString(Sessao,'Mensagem','') ;
      MemFormatada := StringReplace( MemFormatada,'|',sLineBreak, [rfReplaceAll] );

      with Titulo do
      begin
         if aIni.ReadInteger(Sessao,'Aceite',1) = 0 then
            Aceite := atSim
         else
            Aceite := atNao;

         try
            Sacado.Pessoa := TACBrPessoa( aIni.ReadInteger(Sessao,'Sacado.Pessoa',2) );
         except
            Sacado.Pessoa := pOutras;
         end ;

         try
            OcorrenciaOriginal.Tipo := TACBrTipoOcorrencia(
               aini.ReadInteger(Sessao,'OcorrenciaOriginal.TipoOcorrencia',1) ) ;
         except
            OcorrenciaOriginal.Tipo := toRemessaRegistrar ;
         end ;

         Vencimento          := StrToDateDef(Trim(aIni.ReadString(Sessao,'Vencimento','')), now);
         DataDocumento       := StrToDateDef(Trim(aIni.ReadString(Sessao,'DataDocumento','')),now);
         DataProcessamento   := StrToDateDef(Trim(aini.ReadString(Sessao,'DataProcessamento','')),now);
         DataAbatimento      := StrToDateDef(Trim(aini.ReadString(Sessao,'DataAbatimento','')),0);
         DataDesconto        := StrToDateDef(Trim(aini.ReadString(Sessao,'DataDesconto','')),0);
         DataMoraJuros       := StrToDateDef(Trim(aini.ReadString(Sessao,'DataMora','')),0);
         DataProtesto        := StrToDateDef(Trim(aIni.ReadString(Sessao,'DataProtesto','')),0);
         LocalPagamento      := Trim(aIni.ReadString(Sessao,'LocalPagamento',LocalPagamento));
         NumeroDocumento     := aIni.ReadString(Sessao,'NumeroDocumento',NumeroDocumento);
         EspecieDoc          := aIni.ReadString(Sessao,'Especie',EspecieDoc);
         NossoNumero         := aini.ReadString(Sessao,'NossoNumero','');
         Carteira            := aini.ReadString(Sessao,'Carteira','');
         ValorDocumento      := aini.ReadFloat(Sessao,'ValorDocumento',ValorDocumento);
         Sacado.NomeSacado   := aIni.ReadString(Sessao,'Sacado.NomeSacado','');
         Sacado.CNPJCPF      := RemoveStrings(aini.ReadString(Sessao,'Sacado.CNPJCPF',''),CIgnorarChars);
         Sacado.Logradouro   := aIni.ReadString(Sessao,'Sacado.Logradouro','');
         Sacado.Numero       := aIni.ReadString(Sessao,'Sacado.Numero','');
         Sacado.Bairro       := aIni.ReadString(Sessao,'Sacado.Bairro','');
         Sacado.Complemento  := aIni.ReadString(Sessao,'Sacado.Complemento','');
         Sacado.Cidade       := aIni.ReadString(Sessao,'Sacado.Cidade','');
         Sacado.UF           := aIni.ReadString(Sessao,'Sacado.UF','');
         Sacado.CEP          := RemoveStrings(aIni.ReadString(Sessao,'Sacado.CEP',''),CIgnorarChars);
         Sacado.Email        := aIni.ReadString(Sessao,'Sacado.Email',Sacado.Email);
         EspecieMod          := aIni.ReadString(Sessao,'EspecieMod',EspecieMod);
         Mensagem.Text       := MemFormatada;
         Instrucao1          := padL(aIni.ReadString(Sessao,'Instrucao1',Instrucao1),2);
         Instrucao2          := padL(aIni.ReadString(Sessao,'Instrucao2',Instrucao2),2);
         Parcela             := aIni.ReadInteger(Sessao,'Parcela',Parcela);
         TotalParcelas       := aIni.ReadInteger(Sessao,'TotalParcelas',TotalParcelas);
         ValorAbatimento     := aIni.ReadFloat(Sessao,'ValorAbatimento',ValorAbatimento);
         ValorDesconto       := aIni.ReadFloat(Sessao,'ValorDesconto',ValorDesconto);
         ValorMoraJuros      := aIni.ReadFloat(Sessao,'ValorMoraJuros',ValorMoraJuros);
         ValorIOF            := aIni.ReadFloat(Sessao,'ValorIOF',ValorIOF);
         ValorOutrasDespesas := aIni.ReadFloat(Sessao,'ValorOutrasDespesas',ValorOutrasDespesas);
         SeuNumero           := aIni.ReadString(Sessao,'SeuNumero',SeuNumero);
         PercentualMulta     := aIni.ReadFloat(Sessao,'PercentualMulta',PercentualMulta);
      end;
   end;
end;

end.

