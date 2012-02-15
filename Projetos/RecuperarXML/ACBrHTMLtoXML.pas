unit ACBrHTMLtoXML;

interface

uses Forms, SysUtils, Math, pcnNFe, pcnNFeW, pcnAuxiliar, pcnConversao, ACBrUtil,
  Classes, Dialogs;

function GerarXML(Arquivo : AnsiString) : String;

implementation

uses StrUtils;

function SeparaAte(Chave, Texto : AnsiString; var Resto: AnsiString): String;
var
  inicio : integer;
begin
   { Alterado para Uppercase o recebimento dos campos Chave e Texto
       pois devido a diferença de versões (1.10 e 2.00) da NF-e alguns campos
       não estavam sendo localizados
     Desenvolvedor : Higor Machado em 11/02/2011 }
   Chave  := UpperCase(Trim(Chave));
   inicio := pos(Chave, UpperCase(Texto));

   if inicio = 0 then
     result := ''
   else
    begin
       Resto  := copy(Texto,inicio,length(Texto));
       Result := copy(Texto,0,inicio-1);
    end;
end;

function LerCampo(Texto, NomeCampo: string; Tamanho : Integer = 0): string;
var
  ConteudoTag: string;
  inicio, fim: integer;
begin
  NomeCampo := UpperCase(Trim(NomeCampo));
  inicio := pos(NomeCampo, UpperCase(Texto));
  if inicio = 0 then
    ConteudoTag := ''
  else
  begin
    inicio := inicio + Length(NomeCampo);
    if Tamanho > 0 then
       fim := Tamanho
    else
     begin
       Texto := copy(Texto,inicio,length(Texto));
       inicio := 0;
       fim := pos('|&|',Texto)-1;
     end;
    ConteudoTag := trim(copy(Texto, inicio, fim));
  end;
  try
     result := ConteudoTag;
  except
     raise Exception.Create('Conteúdo inválido. '+ConteudoTag);
  end;
end;

function ConverteStrToNumero( Valor : String; TrocaPonto : Boolean = False ) : Real;
begin
  if TrocaPonto then
     Result := StrToFloatDef(StringReplace(Valor,ThousandSeparator,',',[rfReplaceAll]),0)
  else
     Result := StrToFloatDef(StringReplace(Valor,ThousandSeparator,'',[rfReplaceAll]),0);
end;

function GerarXML(Arquivo : AnsiString) : String;
var
 NFe : TNFe;
 GeradorXML : TNFeW;
 ok, bIgnoraDuplicata : Boolean;
 dData      : TDateTime; 
 i, posIni, posFim : Integer;
 sDataEmissao, Versao, sTexto : String;
 CaminhoXML, Grupo, ArquivoTXT, ArquivoRestante, GrupoTmp : AnsiString;
 ArquivoItens, ArquivoItensTemp, ArquivoDuplicatas, ArquivoVolumes : AnsiString;
 produtos: Integer;
begin
 NFe := TNFe.Create;

 ArquivoTXT := StringReplace(Arquivo,#$D#$A,'|&|',[rfReplaceAll]);

 Grupo :=  SeparaAte('Dados da NF-e',ArquivoTXT,ArquivoRestante);

 NFe.infNFe.ID := OnlyNumber(LerCampo(Grupo,'Chave de acesso'));
 NFe.Ide.nNF   := StrToIntDef(OnlyNumber(LerCampo(Grupo,'Número NF-e')),0);
 NFe.procNFe.chNFe:= OnlyNumber(LerCampo(Grupo,'Chave de acesso'));

 { Incluido campo que recebe qual a Versão do XML que o arquivo está. }
 Versao        := LerCampo(Grupo,'Versão');
 NFe.Ide.cNF   := RetornarCodigoNumerico(NFe.infNFe.ID,NFe.infNFe.Versao);

 Grupo :=  SeparaAte('EMITENTE',ArquivoRestante,ArquivoRestante);

 { Alterado forma de atribuição do campo Data de emissão pois devido a
     diferença de versões (1.10 e 2.00) da NF-e a formatação de Datas estava
     com problemas. }
 sDataEmissao := LerCampo(Grupo,'Data de emissão');

 if Length(sDataEmissao) > 0 then
   dData := EncodeDate(StrToInt(copy(sDataEmissao, 07, 4)), StrToInt(copy(sDataEmissao, 04, 2)),
              StrToInt(copy(sDataEmissao, 01, 2)))
 else
   dData := 0;

 NFe.Ide.dEmi := dData;
 NFe.Total.ICMSTot.vNF := ConverteStrToNumero(LerCampo(Grupo,'Valor Total da Nota Fiscal'));
 NFe.Ide.modelo := StrToInt(copy(SomenteNumeros(NFe.infNFe.ID), 21, 2));
 NFe.Ide.serie := StrToInt(copy(SomenteNumeros(NFe.infNFe.ID), 23, 3));

 Grupo :=  SeparaAte('DESTINATÁRIO',ArquivoRestante,ArquivoRestante);

 NFe.Emit.CNPJCPF := OnlyNumber(LerCampo(Grupo,'CNPJ'));
 NFe.Emit.xNome   := LerCampo(Grupo,'Nome/Razão Social');
 NFe.Emit.IE      := OnlyAlphaNum(LerCampo(Grupo,'Inscrição Estadual'));
 NFe.Emit.EnderEmit.UF := LerCampo(Grupo,'UF');

 Grupo :=  SeparaAte('EMISSÃO',ArquivoRestante,ArquivoRestante);

 NFe.Dest.CNPJCPF := OnlyNumber(LerCampo(Grupo,'CNPJ'));
 NFe.Dest.xNome   := LerCampo(Grupo,'Nome/Razão Social');
 NFe.Dest.IE      := OnlyAlphaNum(LerCampo(Grupo,'Inscrição Estadual'));
 NFe.Dest.EnderDest.UF := LerCampo(Grupo,'UF');

 Grupo :=  SeparaAte('Dados do Emitente',ArquivoRestante,ArquivoRestante);

 NFe.Ide.procEmi := StrToProcEmi(ok, LerCampo(Grupo,'Processo',1));
 NFe.Ide.verProc := LerCampo(Grupo, 'Versão do Processo');
 NFe.ide.tpEmis  := StrToTpEmis(ok, LerCampo(Grupo, 'Tipo de Emissão',1));
 NFe.Ide.finNFe  := StrToFinNFe(ok, LerCampo(Grupo, 'Finalidade',1));
 NFe.Ide.natOp   := LerCampo(Grupo, 'Natureza da Operação');
 NFe.ide.tpNF    := StrToTpNF(ok, LerCampo(Grupo, 'Tipo da Operação',1));
 NFe.ide.indPag  := StrToIndpag(ok, LerCampo(Grupo, 'Forma de Pagamento',1));
 NFE.procNFe.digVal   := LerCampo(Grupo, 'Digest Value da NF-e');
 NFe.procNFe.nProt    := LerCampo(Grupo, 'Protocolo');
 NFe.procNFe.dhRecbto := StrToDateDef(LerCampo(Grupo,'Data/Hora'),0);

 //SITUAÇÃO ATUAL:
 {NFE.procNFe.digVal   := LerCampo(Grupo, 'Digest Value da NF-e');
 NFe.procNFe.xMotivo  := LerCampo(Grupo, 'Ocorrência');
 NFe.procNFe.nProt    := LerCampo(Grupo, 'Protocolo');
 NFe.procNFe.dhRecbto := StrToDateDef(LerCampo(Grupo,'Data/Hora'),0);}
 //Recebimento no Ambiente Nacional

 Grupo :=  SeparaAte('Dados do destinatário',ArquivoRestante,ArquivoRestante);

 NFe.Emit.xNome   := LerCampo(Grupo,'Nome / Razão Social');
 NFe.Emit.xFant   := LerCampo(Grupo,'Nome Fantasia');
 NFe.Emit.CNPJCPF := OnlyNumber(LerCampo(Grupo,'CNPJ'));

 // alteração: separar numero do endereço
 NFe.Emit.EnderEmit.xLgr := LerCampo(Grupo,'Endereço');
 NFe.Emit.EnderEmit.xLgr := Copy(NFe.Emit.EnderEmit.xLgr,1, pos(',',NFe.Emit.EnderEmit.xLgr)-1 );
 NFe.Emit.EnderEmit.nro  := copy( LerCampo(Grupo,'Endereço'), pos(',',LerCampo(Grupo,'Endereço'))+1, 10 );

 NFe.Emit.EnderEmit.xBairro := LerCampo(Grupo,'Bairro/Distrito');
 NFe.Emit.EnderEmit.CEP := StrToIntDef(OnlyNumber(LerCampo(Grupo,'CEP')),0);
 NFe.Emit.EnderEmit.cMun := StrToIntDef(LerCampo(Grupo,'Município',7),0);
 NFe.Ide.cUF := StrToIntDef(LerCampo(Grupo,'Município',2),0);
 NFe.Emit.EnderEmit.xMun := copy(LerCampo(Grupo,'Município'),10,60);
 NFe.Emit.EnderEmit.fone := OnlyAlphaNum(LerCampo(Grupo,' Fone/Fax'));
 NFe.Emit.EnderEmit.UF := LerCampo(Grupo,'UF');
 NFe.Emit.EnderEmit.cPais := StrToIntDef(LerCampo(Grupo,'País',4),1058);
 NFe.Emit.EnderEmit.xPais := copy(LerCampo(Grupo,'País'),8,60);
 NFe.Emit.IE      := OnlyAlphaNum(LerCampo(Grupo,'Inscrição Estadual'));
 NFe.Ide.cMunFG := StrToIntDef(LerCampo(Grupo,'Município da Ocorrência do Fato Gerador do ICMS'),0);

 Grupo :=  SeparaAte('Dados dos Produtos e Serviços',ArquivoRestante,ArquivoRestante);

 NFe.Dest.xNome   := LerCampo(Grupo,'Nome / Razão social');
 NFe.Dest.CNPJCPF := OnlyNumber(LerCampo(Grupo,'CNPJ/CPF'));
 NFe.Dest.CNPJCPF := OnlyNumber(LerCampo(Grupo,'CNPJ'));

 // alteração: separar numero do endereço
 NFe.Dest.EnderDest.xLgr := LerCampo(Grupo,'Endereço');
 NFe.Dest.EnderDest.xLgr := Copy(NFe.Dest.EnderDest.xLgr,1, pos(',',NFe.Dest.EnderDest.xLgr)-1 );
 NFe.Dest.EnderDest.nro  := copy( LerCampo(Grupo,'Endereço'), pos(',',LerCampo(Grupo,'Endereço'))+1, 10 );

 // correção, bairro tem espaço entre as barras
 NFe.Dest.EnderDest.xBairro := LerCampo(Grupo,'Bairro / Distrito');
 NFe.Dest.EnderDest.CEP := StrToIntDef(OnlyNumber(LerCampo(Grupo,'CEP')),0);
 NFe.Dest.EnderDest.cMun := StrToIntDef(LerCampo(Grupo,'Município',7),0);
 NFe.Dest.EnderDest.xMun := copy(LerCampo(Grupo,'Município'),10,60);
 NFe.Dest.EnderDest.fone := OnlyAlphaNum(LerCampo(Grupo,' Fone/Fax'));
 NFe.Dest.EnderDest.UF := LerCampo(Grupo,'UF');
 NFe.Dest.EnderDest.cPais := StrToIntDef(LerCampo(Grupo,'País',4),1058);
 NFe.Dest.EnderDest.xPais := copy(LerCampo(Grupo,'País'),8,60);
 NFe.Dest.IE      := OnlyAlphaNum(LerCampo(Grupo,'Inscrição estadual'));

 ArquivoItens :=  SeparaAte('Dados do Transporte',ArquivoRestante,ArquivoItens);

 { Alterado a forma de leitura dos itens devido aos layouts das versões (1.10 e 2.00) da NF-e
    no site da receita apresentarem diferenças. }
 if Trim(Versao) <> '2.00' then
    begin
      while true do
        begin
          ArquivoItensTemp := copy(ArquivoItens, 33, length(ArquivoItens));
           if Grupo = '' then
            begin
              if pos('Num.', ArquivoItensTemp) > 0 then
                begin
                  Grupo := ArquivoItensTemp;
                  ArquivoItens := '';
                end;
              if Grupo = '' then
                Break;
            end;
          with NFe.Det.Add do
            begin
              Prod.nItem := StrToIntDef(LerCampo(Grupo, 'Num.'), 0);
              Prod.xProd := LerCampo(Grupo, 'Descrição');
              Prod.qCom := ConverteStrToNumero(LerCampo(Grupo, 'Qtd.'));
              Prod.uCom := LerCampo(Grupo, 'Unidade Comercial');
              Prod.vProd := ConverteStrToNumero(LerCampo(Grupo, 'Valor(R$)'));
              Prod.cProd := LerCampo(Grupo, 'Código do Produto');
              Prod.NCM := LerCampo(Grupo, 'Código NCM');
              Prod.CFOP := LerCampo(Grupo, 'CFOP');
//              Prod.genero := StrToIntDef(LerCampo(Grupo,'Gênero'),0);
              Prod.vFrete := ConverteStrToNumero(LerCampo(Grupo, 'Valor Total do Frete'));
              Prod.cEAN := LerCampo(Grupo, 'Código EAN Comercial');
              Prod.qCom := ConverteStrToNumero(LerCampo(Grupo, 'Quantidade Comercial'));
              Prod.cEANTrib := LerCampo(Grupo, 'Código EAN Tributável');
              Prod.uTrib := LerCampo(Grupo, 'Unidade Tributável');
              Prod.qTrib := ConverteStrToNumero(LerCampo(Grupo, 'Quantidade Tributável'));
              Prod.vUnCom := ConverteStrToNumero(LerCampo(Grupo, 'Valor unitário de comercialização'));
              Prod.vUnTrib := ConverteStrToNumero(LerCampo(Grupo, 'Valor unitário de tributação'));

              with Imposto.ICMS do
                begin
                  orig := StrToOrig(ok, LerCampo(Grupo, 'Origem da Mercadoria', 1));
                  CST := StrToCSTICMS(ok, LerCampo(Grupo, 'Tributação do ICMS', 2));
                  //Modalidade Definição da BC ICMS NOR
                  vBC := ConverteStrToNumero(LerCampo(Grupo, 'Base de Cálculo do ICMS Normal'));
                  pICMS := ConverteStrToNumero(LerCampo(Grupo, 'Alíquota do ICMS Normal'));
                  vICMS := ConverteStrToNumero(LerCampo(Grupo, 'Valor do ICMS Normal'));
                end;

              with Imposto.IPI do
                begin
                  cEnq := LerCampo(Grupo, 'Código de Enquadramento');
                  vBC := ConverteStrToNumero(LerCampo(Grupo, 'Base de Cálculo'));
                  pIPI := ConverteStrToNumero(LerCampo(Grupo, 'Alíquota'));
                  vIPI := ConverteStrToNumero(LerCampo(Grupo, 'Valor'));
                  CST := StrToCSTIPI(ok, LerCampo(Grupo, 'CST', 2));
                end;

            end;
        end;

    end
  else
    begin
      //Faz tratamento alternativo para NFE 2.0
      produtos := 0;
      while true do
        begin
          ArquivoItensTemp := copy(ArquivoItens, 88, length(ArquivoItens));

          //aki faz o teste com o inteiro para achar quantidade de produtos
          for I := 1 to 990 do
            begin
              if pos('|&|' + intTostr(i) + '|&|', ArquivoItensTemp) > 0 then Inc(produtos);
            end;

          for I := 1 to produtos do
            begin

              if i < produtos then
                Grupo := SeparaAte('|&|' + intTostr(i + 1) + '|&|', ArquivoItensTemp, ArquivoItensTemp)
              else
                Grupo := ArquivoItensTemp;

              with NFe.Det.Add do
              begin
                //Prod.nItem := StrToIntDef(LerCampo(Grupo, 'Num.'), 0);
                Prod.nItem := i;
                Prod.xProd := LerCampo(Grupo, '|&|' + intTostr(i) + '|&|');
                 //retira o código '|&|1|&|'
                grupo := copy(grupo, 8, length(grupo));
                //separa até a próxima tag |&|
                Prod.qCom := ConverteStrToNumero(LerCampo(Grupo, '|&|'));
                  //separa até a próxima tag |&|
                grupo := copy(grupo, pos('|&|', grupo) + 3, length(grupo));

                Prod.uCom := LerCampo(Grupo, '|&|');
                  //separa até a próxima tag |&|
                grupo := copy(grupo, pos('|&|', grupo) + 3, length(grupo));

                Prod.vProd := ConverteStrToNumero(LerCampo(Grupo, '|&|'));
                  //separa até a próxima tag |&|
                grupo := copy(grupo, pos('|&|', grupo) + 3, length(grupo));

                //Daqui em diante continua mesmo layout
                Prod.cProd := LerCampo(Grupo, 'Código do Produto');
                Prod.NCM := LerCampo(Grupo, 'Código NCM');
                Prod.CFOP := LerCampo(Grupo, 'CFOP');
//                  Prod.genero := StrToIntDef(LerCampo(Grupo,'Gênero'),0);
                Prod.vFrete := ConverteStrToNumero(LerCampo(Grupo, 'Valor Total do Frete'));
                Prod.cEAN := LerCampo(Grupo, 'Código EAN Comercial');
                Prod.qCom := ConverteStrToNumero(LerCampo(Grupo, 'Quantidade Comercial'));
                Prod.cEANTrib := LerCampo(Grupo, 'Código EAN Tributável');
                Prod.uTrib := LerCampo(Grupo, 'Unidade Tributável');
                Prod.qTrib := ConverteStrToNumero(LerCampo(Grupo, 'Quantidade Tributável'));
                Prod.vUnCom := ConverteStrToNumero(LerCampo(Grupo, 'Valor unitário de comercialização'));
                Prod.vUnTrib := ConverteStrToNumero(LerCampo(Grupo, 'Valor unitário de tributação'));
                Prod.vDesc := ConverteStrToNumero(LerCampo(Grupo, 'Valor do Desconto'));
                Prod.vOutro := ConverteStrToNumero(LerCampo(Grupo, 'Outras despesas acessórias'));
                if LerCampo(Grupo,'Chassi do veículo ') <> '' then
                begin
                   // preencher as tags referente a veículo
                  Prod.veicProd.chassi  := LerCampo(Grupo,'Chassi do veículo ');
                  Prod.veicProd.cCor    := LerCampo(Grupo,'Cor ');
                  Prod.veicProd.xCor    := LerCampo(Grupo,'Descrição da cor ');
                  Prod.veicProd.nSerie  := LerCampo(Grupo,'Serial (Série) ');
                  Prod.veicProd.tpComb  := LerCampo(Grupo,'Tipo de Combustível ');
                  Prod.veicProd.nMotor  := LerCampo(Grupo,'Número de Motor ');
                  //Prod.veicProd.RENAVAM := LerCampo(Grupo,'RENAVAM');
                  Prod.veicProd.anoMod  := StrToInt(LerCampo(Grupo,'Ano Modelo de Fabricação '));
                  Prod.veicProd.anoFab  := StrToInt(LerCampo(Grupo,'Ano de Fabricação '));
                end;

                with Imposto.ICMS do
                begin
                  orig := StrToOrig(ok, LerCampo(Grupo, 'Origem da Mercadoria', 1));
                  CST := StrToCSTICMS(ok, Trim(LerCampo(Grupo, 'Tributação do ICMS', 3)));
                  //Modalidade Definição da BC ICMS NOR

                  //separa até a próxima tag
                  grupotmp:=Copy(Grupo,Pos('Modalidade',Grupo),Length(Grupo));
                  if Pos('70',CSTICMSToStr(CST))>0 then
                  begin
                    pRedBC:=ConverteStrToNumero(LerCampo(GrupoTmp,'Percentual Redução de BC do ICMS Normal'));
                    vBC := ConverteStrToNumero(LerCampo(GrupoTmp, 'Base de Cálculo'));
                    pICMS := ConverteStrToNumero(LerCampo(GrupoTmp, 'Alíquota'));
                    //separa até a TAG alíquota
                    GrupoTmp:=Copy(GrupoTmp,Pos('Alíquota',GrupoTmp),Length(GrupoTmp));

                    vICMS := ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor'));
                    pMVAST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Percentual da Margen de Valor Adicionado do ICMS ST'));
                    pRedBCST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Percentual da Redução de BC do ICMS ST'));
                    vBCST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor da BC do ICMS ST'));
                    pICMSST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Alíquota do Imposto do ICMS ST'));
                    vICMSST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor do ICMS ST'));
                  end
                  else if Pos('10',CSTICMSToStr(CST))>0 then
                  begin
                    vBC := ConverteStrToNumero(LerCampo(GrupoTmp, 'Base de Cálculo do ICMS Normal'));
                    pICMS := ConverteStrToNumero(LerCampo(GrupoTmp, 'Alíquota ICMS Normal'));
                    //separa até a TAG alíquota
                    GrupoTmp:=Copy(GrupoTmp,Pos('Alíquota ICMS Normal',GrupoTmp),Length(GrupoTmp));

                    vICMS := ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor do ICMS Normal'));
                    vBCST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Base de Cálculo do ICMS ST'));
                    pICMSST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Alíquota do ICMS ST'));
                    vICMSST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor do ICMS ST'));
                  end
                  else
                  begin
                    vBC := ConverteStrToNumero(LerCampo(GrupoTmp, 'Base de Cálculo do ICMS Normal'));
                    pICMS := ConverteStrToNumero(LerCampo(GrupoTmp, 'Alíquota ICMS Normal'));
                    //separa até a TAG alíquota
                    GrupoTmp:=Copy(GrupoTmp,Pos('Alíquota ICMS Normal',GrupoTmp),Length(GrupoTmp));

                    vICMS := ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor do ICMS Normal'));
                    vBCST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Base de Cálculo do ICMS ST'));
                    pICMSST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Alíquota do ICMS ST'));
                    vICMSST:=ConverteStrToNumero(LerCampo(GrupoTmp, 'Valor do ICMS ST'));
                  end;
                end;

                //if LerCampo(Grupo,'|&|IMPOSTO SOBRE PRODUTOS INDUSTRIALIZADOS|&|')<>'' then
                if LerCampo(Grupo,'|&|IMPOSTO SOBRE PRODUTOS INDUSTRIALIZADOS |&|')<>'' then
                begin
                  Grupo := copy(Grupo,pos('|&|IMPOSTO SOBRE PRODUTOS INDUSTRIALIZADOS|&|',grupo),length(grupo));
                  with Imposto.IPI do
                  begin
                    cEnq := LerCampo(Grupo, 'Código de Enquadramento');
                    vBC := ConverteStrToNumero(LerCampo(Grupo, 'Base de Cálculo'));
                    pIPI := ConverteStrToNumero(LerCampo(Grupo, 'Alíquota'));
                    vIPI := ConverteStrToNumero(LerCampo(Grupo, 'Valor IPI'));
                    CST := StrToCSTIPI(ok, LerCampo(Grupo, 'CST', 2));
                  end;
                end;
              end;
            end;
            break;
        end;
    end;
   Grupo:=Copy(Grupo,Pos('Totais',Grupo),Length(Grupo));
   NFe.Total.ICMSTot.vBC   := ConverteStrToNumero(LerCampo(Grupo,'Base de Cálculo ICMS'));
   NFe.Total.ICMSTot.vICMS := ConverteStrToNumero(LerCampo(Grupo,'Valor do ICMS'));
   NFe.Total.ICMSTot.vBCST := ConverteStrToNumero(LerCampo(Grupo,'Base de Cálculo ICMS ST'));
   NFe.Total.ICMSTot.vST   := ConverteStrToNumero(LerCampo(Grupo,'Valor ICMS Substituição'));

   { Incluida condicional que Verifica a versão do XML e então atribui qual o
       texto de busca que deverá ser procurado no arquivo. }
   sTexto := IfThen(Trim(Versao) = '2.00', 'Valor Total dos Produtos', 'Valor dos Produtos');
   NFe.Total.ICMSTot.vProd   := ConverteStrToNumero(LerCampo(Grupo, sTexto));
   NFe.Total.ICMSTot.vFrete:= ConverteStrToNumero(LerCampo(Grupo,'Valor do Frete'));
   NFe.Total.ICMSTot.vSeg  := ConverteStrToNumero(LerCampo(Grupo,'Valor do Seguro'));
   NFe.Total.ICMSTot.vOutro := ConverteStrToNumero(LerCampo(Grupo,'Outras Despesas Acessórias'));
   NFe.Total.ICMSTot.vIPI  := ConverteStrToNumero(LerCampo(Grupo,'Valor Total do IPI'));
   NFe.Total.ICMSTot.vNF   := ConverteStrToNumero(LerCampo(Grupo,'Valor Total da NFe'));

   { Incluida condicional que Verifica a versão do XML e então atribui qual o
       texto de busca que deverá ser procurado no arquivo. }
   sTexto := IfThen(Trim(Versao) = '2.00', 'Valor Total dos Descontos', 'Valor dos Descontos');
   NFe.Total.ICMSTot.vDesc   := ConverteStrToNumero(LerCampo(Grupo, sTexto));
   NFe.Total.ICMSTot.vII   := ConverteStrToNumero(LerCampo(Grupo,'Valor do II'));
   NFe.Total.ICMSTot.vPIS  := ConverteStrToNumero(LerCampo(Grupo,'Valor do PIS'));
   NFe.Total.ICMSTot.vCOFINS := ConverteStrToNumero(LerCampo(Grupo,'Valor da COFINS'));


 ArquivoRestante := copy(ArquivoRestante,pos(UpperCase('Dados do Transporte'),UpperCase(ArquivoRestante)),length(ArquivoRestante));
 Grupo :=  SeparaAte('Dados de Cobrança',ArquivoRestante,ArquivoItens);

 NFe.Transp.modFrete := StrTomodFrete( ok, LerCampo(Grupo,'Modalidade do Frete',1) );

 NFe.Transp.Transporta.CNPJCPF := OnlyNumber(LerCampo(Grupo,'CNPJ'));
 NFe.Transp.Transporta.xNome   := LerCampo(Grupo,'Razão Social / Nome');
 NFe.Transp.Transporta.IE      := LerCampo(Grupo,'Inscrição Estadual');
 NFe.Transp.Transporta.xEnder  := LerCampo(Grupo,'Endereço Completo');
 NFe.Transp.Transporta.xMun    := LerCampo(Grupo,'Município');
 NFe.Transp.Transporta.UF      := LerCampo(Grupo,'UF');
 NFe.Transp.veicTransp.placa   := LerCampo(Grupo,'Placa');
 NFe.Transp.veicTransp.UF      := LerCampo(Grupo,'UF');
 // Volumes
 if pos('VOLUMES',UpperCase(Grupo)) > 0 then
 begin
   i := 0;
   posIni := pos('VOLUMES',UpperCase(Grupo)) + Length('VOLUMES') + 3;
   ArquivoVolumes := copy(Grupo,posIni,length(Grupo));
   while True do
   begin
     NFe.Transp.Vol.Add;
     NFe.Transp.Vol[i].qVol  := StrToIntDef(LerCampo(Grupo,'Quantidade'),0);
     NFe.Transp.vol[i].esp   := LerCampo(Grupo,'Espécie');
     NFe.Transp.Vol[i].marca := LerCampo(Grupo,'Marca');
     NFe.Transp.Vol[i].nVol  := LerCampo(Grupo,'Numeração');
     NFe.Transp.Vol[i].pesoL := ConverteStrToNumero(LerCampo(Grupo,'Peso Líquido'));
     NFe.Transp.Vol[i].pesoB := ConverteStrToNumero(LerCampo(Grupo,'Peso Bruto'));
     Inc(i);
     break;
     // Falta rotina para pegar vários volumes
   end;
 end;

 { Após tentativa de Separar a informação até a parte de 'Dados de Cobrança', em
     algumas NFe's que não possuiam este "node" não estava sendo possivel
     armazenar os dados referente aos 'Totais'. Então caso a NFe não possua este
     "node" automaticamente irá ignorar as informações relacionadas. }

 if Trim(Grupo) = '' then
 begin
   Grupo :=  SeparaAte('Informações Adicionais',ArquivoRestante,ArquivoItens);
   bIgnoraDuplicata := True;
 end;

 Grupo :=  SeparaAte('Informações Adicionais',ArquivoRestante,ArquivoItens);

 if not bIgnoraDuplicata then
 begin
   NFe.Cobr.Fat.nFat  := LerCampo(Grupo,'Número');
   NFe.Cobr.Fat.vOrig := ConverteStrToNumero(LerCampo(Grupo,'Valor Original'));
   NFe.Cobr.Fat.vDesc := ConverteStrToNumero(LerCampo(Grupo,'Valor Desconto'));
   NFe.Cobr.Fat.vLiq  := ConverteStrToNumero(LerCampo(Grupo,'Valor Líquido'));

   //Duplicatas
   if pos('DUPLICATAS',UpperCase(Grupo)) > 0 then
   begin
      i := 0;
      posIni := pos('DUPLICATAS',UpperCase(Grupo)) + Length('DUPLICATAS') + 3;
      ArquivoDuplicatas := copy(Grupo,posIni,length(Grupo));
      posIni := pos('VALOR',UpperCase(ArquivoDuplicatas)) + Length('VALOR') + 4;
      ArquivoDuplicatas := copy(ArquivoDuplicatas,posIni,Length(ArquivoDuplicatas));
      while True do
       begin
         NFe.Cobr.Dup.Add;
         NFe.Cobr.Dup[i].nDup  := copy(ArquivoDuplicatas,1,pos('|&|',ArquivoDuplicatas)-1);
         ArquivoDuplicatas := copy(ArquivoDuplicatas,pos('|&|',ArquivoDuplicatas)+ 3,Length(ArquivoDuplicatas));
         NFe.Cobr.Dup[i].dVenc := StrToDateDef(copy(ArquivoDuplicatas,1,pos('|&|',ArquivoDuplicatas)-1),0);;
         ArquivoDuplicatas := copy(ArquivoDuplicatas,pos('|&|',ArquivoDuplicatas)+ 3,Length(ArquivoDuplicatas));
         NFe.Cobr.Dup[i].vDup  := ConverteStrToNumero(copy(ArquivoDuplicatas,1,pos('|&|',ArquivoDuplicatas)-1));;;
         ArquivoDuplicatas := copy(ArquivoDuplicatas,pos('|&|',ArquivoDuplicatas)+ 3,Length(ArquivoDuplicatas));
         Inc(i);
         if Length(ArquivoDuplicatas) <= 4 then
            break;
       end;
   end;
 end;

 Grupo := ArquivoItens;
 if pos('INFORMAÇÕES COMPLEMENTARES DE INTERESSE DO FISCO',UpperCase(Grupo)) > 0 then
  begin
    posIni := pos('INFORMAÇÕES COMPLEMENTARES DE INTERESSE DO FISCO',UpperCase(Grupo)) + Length('INFORMAÇÕES COMPLEMENTARES DE INTERESSE DO FISCO') + 4 ;
    posFim := pos('|&|',UpperCase(copy(Grupo,posIni,length(Grupo))))-1;
    NFe.InfAdic.infAdFisco := copy(Grupo,posIni,posFim);
  end;
 if pos('INFORMAÇÕES COMPLEMENTARES DE INTERESSE DO CONTRIBUINTE',UpperCase(Grupo)) > 0 then
  begin
    posIni := pos('INFORMAÇÕES COMPLEMENTARES DE INTERESSE DO CONTRIBUINTE',UpperCase(Grupo)) + Length('INFORMAÇÕES COMPLEMENTARES DE INTERESSE DO CONTRIBUINTE') + 4 ;
    posFim := pos('|&|',UpperCase(copy(Grupo,posIni,length(Grupo))))-1;
    NFe.InfAdic.infCpl     := copy(Grupo,posIni,posFim);
  end;

 Grupo :=  SeparaAte('Dados de Nota Fiscal Avulsa',ArquivoRestante,Grupo);
 //OBSERVAÇÕES DO CONTRIBUINTE
 if pos('OBSERVAÇÕES DO CONTRIBUINTE',UpperCase(Grupo)) > 0 then
  begin
    i := 0;
    posIni := pos('OBSERVAÇÕES DO CONTRIBUINTE',UpperCase(Grupo)) + Length('OBSERVAÇÕES DO CONTRIBUINTE') + 3;
    ArquivoDuplicatas := copy(Grupo,posIni,length(Grupo));
    posIni := pos('TEXTO',UpperCase(ArquivoDuplicatas)) + Length('TEXTO') + 4;
    ArquivoDuplicatas := copy(ArquivoDuplicatas,posIni,Length(ArquivoDuplicatas));
    while True do
     begin
       NFe.InfAdic.obsCont.Add;
       NFe.InfAdic.obsCont[i].xCampo  := copy(ArquivoDuplicatas,1,pos('|&|',ArquivoDuplicatas)-1);
       ArquivoDuplicatas := copy(ArquivoDuplicatas,pos('|&|',ArquivoDuplicatas)+ 3,Length(ArquivoDuplicatas));
       NFe.InfAdic.obsCont[i].xTexto := copy(ArquivoDuplicatas,1,pos('|&|',ArquivoDuplicatas)-1);
       ArquivoDuplicatas := copy(ArquivoDuplicatas,pos('|&|',ArquivoDuplicatas)+ 3,Length(ArquivoDuplicatas));
       Inc(i);
       if Length(ArquivoDuplicatas) <= 4 then
          break;
     end;
  end;

 GeradorXML := TNFeW.Create(NFe);
 try
    GeradorXML.schema := TsPL005c;
    GeradorXML.GerarXml;
    CaminhoXML := PathWithDelim(ExtractFilePath(Application.ExeName))+copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-nfe.xml';
    GeradorXML.Gerador.SalvarArquivo(CaminhoXML);
    Result := CaminhoXML;
 finally
    GeradorXML.Free;
 end;
 NFe.Free;
end;

end.
