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

unit DoECFUnit ;

{$mode objfpc}{$H+}

interface
Uses Classes, TypInfo, SysUtils, CmdUnit ;

Procedure DoECF( Cmd : TACBrCmd ) ;
Function PegaAliquotas : AnsiString ;
Function PegaTotaisAliquotas : AnsiString ;
Function PegaFormasPagamento : AnsiString ;
Function PegaTotaisFormasPagamento : AnsiString ;
Function PegaComprovantesNaoFiscais : AnsiString ;
Function PegaTotaisComprovantesNaoFiscais : AnsiString ;
Function PegaUnidadesMedida : AnsiString ;
Procedure StringToMemo( AString : AnsiString; var Memo : TStringList );

implementation
uses ACBrECF, ACBrDevice, ACBrUtil, ACBrECFClass, StrUtils,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoECF( Cmd : TACBrCmd ) ;
Var wDescricao : AnsiString ;
    Linhas     : TStringList ;
    Linha      : AnsiString ;
    FPG        : TACBrECFFormaPagamento ;
    ICMS       : TACBrECFAliquota ;
    CNF        : TACBrECFComprovanteNaoFiscal ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'ativar' then  { Ativa o ecf }
         begin
           Ativar ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.AvaliaEstadoTsECF ;{$ENDIF}
         end

        else if Cmd.Metodo = 'desativar' then
         begin
           Desativar ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.AvaliaEstadoTsECF ;{$ENDIF}
         end

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := BoolToStr(Ativo, true)

        else if Cmd.Metodo = 'colunas' then
           Cmd.Resposta := IntToStr( Colunas )

        else if Cmd.Metodo = 'comandoenviado' then
           Cmd.Resposta := ComandoEnviado

        else if Cmd.Metodo = 'respostacomando' then
           Cmd.Resposta := RespostaComando

        else if Cmd.Metodo = 'modelostr' then
           Cmd.Resposta := ModeloStr

        else if Cmd.Metodo = 'modelo' then
           Cmd.Resposta := GetEnumName(TypeInfo(TACBrECFModelo),Integer(Modelo))

        else if Cmd.Metodo = 'porta' then
           Cmd.Resposta := Porta

        else if Cmd.Metodo = 'timeout' then
           Cmd.Resposta := IntToStr( TimeOut )

        else if Cmd.Metodo = 'settimeout' then
           TimeOut := StrToInt( Trim(Cmd.Params(0)) )

        else if Cmd.Metodo = 'maxlinhasbuffer' then
           Cmd.Resposta := IntToStr( MaxLinhasBuffer )

        else if Cmd.Metodo = 'setmaxlinhasbuffer' then
           MaxLinhasBuffer := StrToInt( Trim(Cmd.Params(0)) )

        else if Cmd.Metodo = 'datahora' then
           Cmd.Resposta := FormatDateTime('dd/mm/yy hh:nn:ss', DataHora )

        else if Cmd.Metodo = 'numcupom' then
         begin
           Cmd.Resposta := NumCupom ;
           if Cmd.Resposta = '' then
              raise Exception.Create('Erro na leitura do COO');
         end

        else if Cmd.Metodo = 'numloja' then
           Cmd.Resposta := NumLoja

        else if Cmd.Metodo = 'numcro' then
           Cmd.Resposta := NumCRO

        else if Cmd.Metodo = 'numcrz' then
           Cmd.Resposta := NumCRZ

        else if Cmd.Metodo = 'numecf' then
           Cmd.Resposta := NumECF

        else if Cmd.Metodo = 'numserie' then
           Cmd.Resposta := NumSerie

        else if Cmd.Metodo = 'numversao' then
           Cmd.Resposta := NumVersao

        else if Cmd.Metodo = 'datamovimento' then
           Cmd.Resposta := FormatDateTime('dd/mm/yy', DataMovimento )

        else if Cmd.Metodo = 'cnpj' then
           Cmd.Resposta := CNPJ

        else if Cmd.Metodo = 'ie' then
           Cmd.Resposta := IE

        else if Cmd.Metodo = 'numcooinicial' then
           Cmd.Resposta := NumCOOInicial

        else if Cmd.Metodo = 'vendabruta' then
           Cmd.Resposta := FloatToStr( VendaBruta )

        else if Cmd.Metodo = 'grandetotal' then
           Cmd.Resposta := FloatToStr( GrandeTotal )

        else if Cmd.Metodo = 'totalcancelamentos' then
           Cmd.Resposta := FloatToStr( TotalCancelamentos )

        else if Cmd.Metodo = 'totaldescontos' then
           Cmd.Resposta := FloatToStr( TotalDescontos )

        else if Cmd.Metodo = 'totalacrescimos' then
           Cmd.Resposta := FloatToStr( TotalAcrescimos )

        else if Cmd.Metodo = 'totalsubstituicaotributaria' then
           Cmd.Resposta := FloatToStr( TotalSubstituicaoTributaria )

        else if Cmd.Metodo = 'totalnaotributado' then
           Cmd.Resposta := FloatToStr( TotalNaoTributado )

        else if Cmd.Metodo = 'totalisencao' then
           Cmd.Resposta := FloatToStr( TotalIsencao )

        else if Cmd.Metodo = 'numultitem' then
           Cmd.Resposta := IntToStr( NumUltItem )

        else if Cmd.Metodo = 'dadosreducaoz' then
           Cmd.Resposta := DadosReducaoZ 

        else if Cmd.Metodo = 'dadosultimareducaoz' then
           Cmd.Resposta := DadosUltimaReducaoZ

        else if Cmd.Metodo = 'aliquotas' then
           Cmd.Resposta := PegaAliquotas

        else if Cmd.Metodo = 'carregaaliquotas' then
         begin
           CarregaAliquotas ;
           Cmd.Resposta := PegaAliquotas ;
         end

        else if Cmd.Metodo = 'lertotaisaliquota' then
           Cmd.Resposta := PegaTotaisAliquotas
           
        else if Cmd.Metodo = 'programaaliquota' then
            ProgramaAliquota( StringToFloat( Cmd.Params(0) ), {% Aliquota }
                              padL(Cmd.Params(1),1,'T')[1],  { Tipo: char(T, S)}
                              Cmd.Params(2) )                   { Posicao = '' }

        else if Cmd.Metodo = 'achaicmsaliquota' then
         begin
           ICMS := AchaICMSAliquota( StringToFloat( Cmd.Params(0) ),{% Aliquota}
                                     padL(Cmd.Params(1),1)[1]) ;  { Tipo = ' ' }
           if ICMS <> nil then
              Cmd.Resposta := padL(ICMS.Indice,4) +
                              ICMS.Tipo +
                              FormatFloat('##0.00', ICMS.Aliquota )
           else
              raise Exception.Create('Aliquota: '+
                                     Trim(cmd.Params(0)+' '+cmd.Params(1))+
                                     ' não encontrada');
         end

        else if Cmd.Metodo = 'formaspagamento' then
           Cmd.Resposta := PegaFormasPagamento

        else if Cmd.Metodo = 'carregaformaspagamento' then
         begin
           CarregaFormasPagamento ;
           Cmd.Resposta := PegaFormasPagamento
         end

        else if Cmd.Metodo = 'lertotaisformapagamento' then
           Cmd.Resposta := PegaTotaisFormasPagamento

        else if Cmd.Metodo = 'programaformapagamento' then
         begin
            wDescricao := Cmd.Params(0) ;
            ProgramaFormaPagamento( wDescricao ,                   { Descricao }
                   StrToBoolDef(Trim(Cmd.Params(1)),true),    {Permitevinculado}
                   Cmd.Params(2) ) ;                            { Posicao = '' }
         end

        else if Cmd.Metodo = 'achafpgdescricao' then
         begin
           FPG := AchaFPGDescricao(cmd.Params(0)) ;
           if FPG <> nil then
              Cmd.Resposta := padL( FPG.Indice,4)+
                              IfThen(FPG.PermiteVinculado,'V',' ')+
                              padL( FPG.Descricao, 30)
           else
              raise Exception.Create('Forma de Pagamento: '+Trim(cmd.Params(0))+
                                     ' não encontrada');
         end

        else if Cmd.Metodo = 'comprovantesnaofiscais' then
           Cmd.Resposta := PegaComprovantesNaoFiscais

        else if Cmd.Metodo = 'carregacomprovantesnaofiscais' then
         begin
           CarregaComprovantesNaoFiscais ;
           Cmd.Resposta := PegaComprovantesNaoFiscais
         end

        else if Cmd.Metodo = 'lertotaiscomprovantenaofiscal' then
           Cmd.Resposta := PegaTotaisComprovantesNaoFiscais

        else if Cmd.Metodo = 'programacomprovantenaofiscal' then
         begin
            wDescricao := Cmd.Params(0) ;
            ProgramaComprovanteNaoFiscal( wDescricao,           { Descricao }
                                          Cmd.Params(1),        { Tipo = '' }
                                          Cmd.Params(2) );      { Posicao = '' }
         end

        else if Cmd.Metodo = 'achacnfdescricao' then
         begin
           CNF := AchaCNFDescricao( cmd.Params(0) ) ;
           if CNF <> nil then
              Cmd.Resposta := padL( CNF.Indice,4) +
                              IfThen(CNF.PermiteVinculado,'V',' ')+
                              padL( CNF.Descricao,30) +
                              padL( CNF.FormaPagamento,4) 
           else
              raise Exception.Create('Comprovante Não Fiscal: '+Trim(cmd.Params(0))+
                                     ' não encontrado');
         end

        else if Cmd.Metodo = 'unidadesmedida' then
           Cmd.Resposta := PegaUnidadesMedida

        else if Cmd.Metodo = 'carregaunidadesmedida' then
         begin
           CarregaUnidadesMedida ;
           Cmd.Resposta := PegaUnidadesMedida ;
         end

        else if Cmd.Metodo = 'programaunidademedida' then
         begin
            wDescricao := Cmd.Params(0) ;
            ProgramaUnidadeMedida( wDescricao ) ;
         end

        else if Cmd.Metodo = 'testapodeabrircupom' then
           TestaPodeAbrirCupom

        else if Cmd.Metodo = 'identificaoperador' then
           IdentificaOperador( Cmd.Params(0) )                          { Nome }

        else if Cmd.Metodo = 'identificaconsumidor' then
           IdentificaConsumidor( Cmd.Params(0),                   { CPF / CNPJ }
                      Cmd.Params(1),                                    { NOME }
                      Cmd.Params(2) )                               { ENDERECO }
                      
        else if Cmd.Metodo = 'abrecupom' then
           AbreCupom( Cmd.Params(0),                              { CPF / CNPJ }
                      Cmd.Params(1),                                    { NOME }
                      Cmd.Params(2) )                               { ENDERECO }

        else if Cmd.Metodo = 'vendeitem' then
         begin
           VendeItem( Cmd.Params(0), Cmd.Params(1),           { Cod, Descricao }
                      Trim(Cmd.Params(2)),                          { Aliquota }
                      StringToFloat( Cmd.Params(3)),                     { Qtd }
                      StringToFloat( Cmd.Params(4)),                  { P.Unit }
                      StringToFloatDef( Cmd.Params(5), 0),          { Descondo }
                      Cmd.Params(6),                                      { Un }
                      PadL(Cmd.Params(7),1,'%'),               { Tipo Desconto }
                      PadL(Cmd.Params(8),1,'D') );             { Desc / Acresc }
          { Aguarda 1 segundo ou até o ECF ficar Em linha novamente }
           EmLinha( 1 ) ;
          { O comando acima é util para evitar erros na Impressao de Itens NAO
            concomitante, (imprimir todo o cupom), Pois o método "VendeItem" NAO
            seta "AguardaImpressao := True" para ficar mais rápido }
         end

        else if Cmd.Metodo = 'subtotalizacupom' then
           SubtotalizaCupom( StringToFloatDef( Cmd.Params(0), 0),  {Acresc/Desc}
                             Cmd.Params(1) )                  { Msg.Rodape = ''}

        else if Cmd.Metodo = 'efetuapagamento' then
           EfetuaPagamento( Cmd.Params(0),                 { CodFormaPagamento }
                            StringToFloat( Cmd.Params(1)),             { Valor }
                            Cmd.Params(2),                        { Observacao }
                            StrToBoolDef(Trim(Cmd.Params(3)),false) ){ Imp.Vinculado }

        else if Cmd.Metodo = 'fechacupom' then
           FechaCupom( Cmd.Params(0) )

        else if Cmd.Metodo = 'cancelacupom' then
           CancelaCupom

        else if Cmd.Metodo = 'cancelaitemvendido' then
           CancelaItemVendido( StrToInt(Trim(Cmd.Params(0)) ) )      { NumItem }

        else if Cmd.Metodo = 'subtotal' then
           Cmd.Resposta := FloatToStr( Subtotal )

        else if Cmd.Metodo = 'totalpago' then
           Cmd.Resposta := FloatToStr( TotalPago )

        else if Cmd.Metodo = 'sangria' then
           Sangria( StringToFloat( Cmd.Params(0)),                     { Valor }
                    Cmd.Params(1),                                       { Obs }
                    Cmd.Params(2),                              { DescricaoCNF }
                    Cmd.Params(3))                              { DescricaoFPG }

        else if Cmd.Metodo = 'suprimento' then
           Suprimento( StringToFloat( Cmd.Params(0)),                  { Valor }
                       Cmd.Params(1),                                    { Obs }
                       Cmd.Params(2),                           { DescricaoCNF }
                       Cmd.Params(3))                           { DescricaoFPG }

        else if Cmd.Metodo = 'cortapapel' then
           CortaPapel( StrToBoolDef(Trim(Cmd.Params(0)),false) ) { Corte Parcial }

        else if Cmd.Metodo = 'naofiscalcompleto' then
           NaoFiscalCompleto( Cmd.Params(0),                          { CodCNF }
                              StringToFloat(Cmd.Params(1)),            { Valor }
                              Cmd.Params(2),                   { CodFormaPagto }
                              Cmd.Params(3) )                            { Obs }

        else if Cmd.Metodo = 'abrenaofiscal' then
           AbreNaoFiscal( Cmd.Params(0) )                           { CPF_CNPJ }

        else if Cmd.Metodo = 'registraitemnaofiscal' then
           RegistraItemNaoFiscal( Cmd.Params(0),                      { CodCNF }
                              StringToFloat(Cmd.Params(1)),            { Valor }
                              Cmd.Params(3) )                            { Obs }

        else if Cmd.Metodo = 'subtotalizanaofiscal' then
           SubtotalizaNaoFiscal( StringToFloatDef( Cmd.Params(0), 0) )  {Acresc/Desc}

        else if Cmd.Metodo = 'efetuapagamentonaofiscal' then
           EfetuaPagamentoNaoFiscal( Cmd.Params(0),        { CodFormaPagamento }
                            StringToFloat( Cmd.Params(1)),             { Valor }
                            Cmd.Params(2),                        { Observacao }
                            StrToBoolDef(Trim(Cmd.Params(3)),false) ){ Imp.Vinculado }

        else if Cmd.Metodo = 'fechanaofiscal' then
           FechaNaoFiscal( Cmd.Params(0) )

        else if Cmd.Metodo = 'cancelanaofiscal' then
           CancelaNaoFiscal

        else if Cmd.Metodo = 'leiturax' then
           LeituraX

        else if Cmd.Metodo = 'reducaoz' then
           ReducaoZ( StringToDateTimeDef(Cmd.Params(0),0) )

        else if Cmd.Metodo = 'poucopapel' then
           Cmd.Resposta := BoolToStr( PoucoPapel, true )

        else if Cmd.Metodo = 'horarioverao' then
           Cmd.Resposta := BoolToStr( HorarioVerao, true )

        else if Cmd.Metodo = 'arredonda' then
           Cmd.Resposta := BoolToStr( Arredonda, true )

        else if Cmd.Metodo = 'mfd' then
           Cmd.Resposta := BoolToStr( MFD, true )

        else if Cmd.Metodo = 'termica' then
           Cmd.Resposta := BoolToStr( Termica, true )

        else if Cmd.Metodo = 'estado' then
           Cmd.Resposta := GetEnumName(TypeInfo(TACBrECFEstado),Integer(Estado))

        else if Cmd.Metodo = 'abregaveta' then
           AbreGaveta

        else if Cmd.Metodo = 'gavetaaberta' then
           Cmd.Resposta := BoolToStr( GavetaAberta, true )

        else if Cmd.Metodo = 'imprimecheque' then
           ImprimeCheque( Cmd.Params(0),                               { Banco }
                          StringToFloat(Cmd.Params(1)),                { Valor }
                          Cmd.Params(2),                          { Favorecido }
                          Cmd.Params(3),                              { Cidade }
                          StringToDateTime(Cmd.Params(4)),                {Data}
                          Cmd.Params(5) )                         { Observação }

        else if Cmd.Metodo = 'cancelaimpressaocheque' then
           CancelaImpressaoCheque

        else if Cmd.Metodo = 'chequepronto' then
           Cmd.Resposta := BoolToStr( ChequePronto, true )

        else if Cmd.Metodo = 'mudahorarioverao' then
           if Cmd.Params(0) <> '' then
              MudaHorarioVerao( StrToBool(Trim(Cmd.Params(0))) )
           else
              MudaHorarioVerao( not HorarioVerao )

        else if Cmd.Metodo = 'mudaarredondamento' then
           MudaArredondamento( StrToBool(Trim(Cmd.Params(0))) )

        else if Cmd.Metodo = 'preparatef' then
           PreparaTEF

        else if Cmd.Metodo = 'corrigeestadoerro' then
           CorrigeEstadoErro

        else if Cmd.Metodo = 'abrerelatoriogerencial' then
           AbreRelatorioGerencial

        else if Cmd.Metodo = 'relatoriogerencial' then
         begin
           Linhas := TStringList.Create ;
           try
              StringToMemo( Cmd.Params(0), Linhas ); {Linha separadas por | (pipe)}
              RelatorioGerencial( Linhas,
                                  StrToIntDef(Trim(Cmd.Params(1)),1) ); { Vias }
           finally
              Linhas.Free ;
           end ;
         end

        else if Cmd.Metodo = 'pulalinhas' then
           PulaLinhas( StrToIntDef( Trim(Cmd.Params(0)),0) )            { Num.Linhas }
           
        else if Cmd.Metodo = 'linharelatoriogerencial' then
         begin
           Linha := StringReplace( Cmd.Params(0),'|',#10,[rfReplaceAll]) ;
           LinhaRelatorioGerencial( Linha )                    { Linha }
         end 

        else if Cmd.Metodo = 'abrecupomvinculado' then
           if StringToFloatDef(Cmd.Params(3),-99) <> -99 then { Param 4 é valor ? }
              AbreCupomVinculado( Cmd.Params(0),                         { COO }
                                  Cmd.Params(1),               { CodFormaPagto }
                                  Cmd.Params(2),     { CodComprovanteNaoFiscal }
                                  StringToFloat( Cmd.Params(3) ) )     { Valor }
           else
              AbreCupomVinculado( Cmd.Params(0),                         { COO }
                                  Cmd.Params(1),               { CodFormaPagto }
                                  StringToFloat( Cmd.Params(2) ) )     { Valor }

        else if Cmd.Metodo = 'linhacupomvinculado' then
         begin
           Linha := StringReplace( Cmd.Params(0),'|',#10,[rfReplaceAll]) ;
           LinhaCupomVinculado( Linha )                    { Linha }
         end 

        else if Cmd.Metodo = 'cupomvinculado' then
         begin
           Linhas := TStringList.Create ;
           try
              StringToMemo( Cmd.Params(0), Linhas ); {Linha separadas por | (pipe)}

              if StringToFloatDef(Cmd.Params(3),-99) <> -99 then { Param 4 é valor ? }
                 CupomVinculado( Cmd.Params(0),                          { COO }
                                 Cmd.Params(1),                { CodFormaPagto }
                                 Cmd.Params(2),      { CodComprovanteNaoFiscal }
                                 StringToFloat( Cmd.Params(3) ),       { Valor }
                                 Linhas )
              else
                 CupomVinculado( Cmd.Params(0),                          { COO }
                                 Cmd.Params(1),                { CodFormaPagto }
                                 StringToFloat( Cmd.Params(2) ),       { Valor }
                                 Linhas )
           finally
              Linhas.Free ;
           end ;
         end

        else if Cmd.Metodo = 'fecharelatorio' then
           FechaRelatorio

        else if Cmd.Metodo = 'leituramemoriafiscal' then
           if pos(DateSeparator,Cmd.Params(0)) > 0 then
              LeituraMemoriaFiscal( StringToDateTime(Cmd.Params(0)),{Dt.Inicial}
                                    StringToDateTime(Cmd.Params(1)) ) {Dt.Final}
           else
              LeituraMemoriaFiscal( StrToInt(Trim(Cmd.Params(0))),  { ReducaoInicial }
                                    StrToInt(Trim(Cmd.Params(1))) )   { ReducaoFinal }

        else if Cmd.Metodo = 'leituramemoriafiscalserial' then
         begin
           Linhas := TStringList.Create ;
           try
              if pos(DateSeparator,Cmd.Params(0)) > 0 then
                 LeituraMemoriaFiscalSerial(
                     StringToDateTime(Cmd.Params(0)),             { Dt.Inicial }
                     StringToDateTime(Cmd.Params(1)),               { Dt.Final }
                     Linhas )                                        { Retorno }
              else
                 LeituraMemoriaFiscalSerial(
                     StrToInt(Trim(Cmd.Params(0))),           { ReducaoInicial }
                     StrToInt(Trim(Cmd.Params(1))),             { ReducaoFinal }
                     Linhas ) ;                                      { Retorno }

              Cmd.Resposta := Linhas.Text ;
           finally
              Linhas.Free ;
           end ;
         end

        else if Cmd.Metodo = 'leituramfdserial' then
         begin
           Linhas := TStringList.Create ;
           try
              if pos(DateSeparator,Cmd.Params(0)) > 0 then
                 LeituraMFDSerial(
                     StringToDateTime(Cmd.Params(0)),             { Dt.Inicial }
                     StringToDateTime(Cmd.Params(1)),               { Dt.Final }
                     Linhas )                                        { Retorno }
              else
                 LeituraMFDSerial(
                     StrToInt(Trim(Cmd.Params(0))),               { COOInicial }
                     StrToInt(Trim(Cmd.Params(1))),                 { COOFinal }
                     Linhas ) ;                                      { Retorno }

              Cmd.Resposta := Linhas.Text ;
           finally
              Linhas.Free ;
           end ;
         end

        else if Cmd.Metodo = 'enviacomando' then
           if Cmd.Params(1) <> '' then
              EnviaComando(Cmd.Params(0),StrToInt(Trim(Cmd.Params(1))))
           else
              EnviaComando(Cmd.Params(0))

        ELSE
           raise Exception.Create('Comando inválido ('+Cmd.Comando+')') ;

     finally
        if Length( Cmd.Resposta ) = 0 then
           Cmd.Resposta := RespostaComando ;
     end ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaAliquotas : AnsiString ;
Var I : Integer ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     if Aliquotas.Count < 1 then
        CarregaAliquotas ;

     for I := 0 to Aliquotas.Count -1 do
        Result := Result + padL(Aliquotas[I].Indice,4) +
                           Aliquotas[I].Tipo +
                           FormatFloat('##0.00', Aliquotas[I].Aliquota ) + '|' ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaTotaisAliquotas : AnsiString ;
Var I : Integer ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     LerTotaisAliquota ;

     for I := 0 to Aliquotas.Count -1 do
        Result := Result + padL(Aliquotas[I].Indice,4) +
                           FormatFloat('########0.00', Aliquotas[I].Total ) + '|' ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaFormasPagamento : AnsiString ;
Var I : Integer ;
    Vinc : Char ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     if FormasPagamento.Count < 1 then
        CarregaFormasPagamento ;

     for I := 0 to FormasPagamento.Count -1 do
     begin
        Vinc := ' ' ;
        if FormasPagamento[I].PermiteVinculado then
           Vinc := 'V' ;

        Result := Result + padL( FormasPagamento[I].Indice,4) + Vinc +
                           padL( FormasPagamento[I].Descricao, 30) + '|' ;
     end ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaTotaisFormasPagamento : AnsiString ;
Var I : Integer ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     LerTotaisFormaPagamento ;
     
     for I := 0 to FormasPagamento.Count -1 do
     begin
        Result := Result + padL( FormasPagamento[I].Indice,4)  +
                           FormatFloat('########0.00', FormasPagamento[I].Total ) + '|' ;
     end ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaComprovantesNaoFiscais : AnsiString ;
Var I : Integer ;
    Vinc : Char ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     if ComprovantesNaoFiscais.Count < 1 then
        CarregaComprovantesNaoFiscais ;

     for I := 0 to ComprovantesNaoFiscais.Count -1 do
     begin
        Vinc := ' ' ;
        if ComprovantesNaoFiscais[I].PermiteVinculado then
           Vinc := 'V' ;

        Result := Result + padL( ComprovantesNaoFiscais[I].Indice,4) + Vinc +
                           padL( ComprovantesNaoFiscais[I].Descricao,30) +
                           padL( ComprovantesNaoFiscais[I].FormaPagamento,4) + '|' ;
     end ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaTotaisComprovantesNaoFiscais : AnsiString ;
Var I : Integer ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     LerTotaisComprovanteNaoFiscal ;
     
     for I := 0 to ComprovantesNaoFiscais.Count -1 do
     begin
        Result := Result + padL( ComprovantesNaoFiscais[I].Indice,4)  +
                           FormatFloat('########0.00', ComprovantesNaoFiscais[I].Total ) + '|' ;
     end ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Function PegaUnidadesMedida : AnsiString ;
Var I : Integer ;
begin
  Result := '' ;
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrECF1 {$ELSE}dm.ACBrECF1 {$ENDIF} do
  begin
     if UnidadesMedida.Count < 1 then
        CarregaUnidadesMedida ;

     for I := 0 to UnidadesMedida.Count -1 do
        Result := Result + padL( UnidadesMedida[I].Indice,4) +
                           padL( UnidadesMedida[I].Descricao,4) + '|' ;

     if Result <> '' then
        Result := copy(Result,1,Length(Result)-1) ;
  end ;
end ;

{------------------------------------------------------------------------------}
Procedure StringToMemo( AString : AnsiString; var Memo : TStringList );
begin
  AString   := StringReplace(AString,#13+#10,'|',[rfReplaceAll]) ;
  AString   := StringReplace(AString,#10,'|',[rfReplaceAll]) ;
  Memo.Text := StringReplace(AString,'|',sLineBreak,[rfReplaceAll]) ;
end ;

end.


