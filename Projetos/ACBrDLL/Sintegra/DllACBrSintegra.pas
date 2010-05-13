unit DllACBrSintegra;

interface

uses
  SysUtils, Classes, ACBrSintegra, ACBrConsts;

var
  ACBr_Sintegra: TACBrSintegra;

function ACBr_SintegraCheckAtivo: Boolean;
function ACBr_SintegraAtivar: Integer; stdcall; export;
function ACBr_SintegraDesativar: Integer; stdcall; export;
function ACBr_SintegraRegistro10(CNPJ,Inscricao,RazaoSocial,Cidade,Estado,
  Telefone,DataInicial,DataFinal,CodigoConvenio,NaturezaInformacoes,
  FinalidadeArquivo: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro11(Endereco,Numero,Bairro,Cep,Responsavel,
  Telefone: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro50(CPFCNPJ,Inscricao,DataDocumento,UF,Modelo,
  Serie,Numero,Cfop,EmissorDocumento,ValorContabil,BasedeCalculo,Icms,
  Isentas,Outras,Aliquota,Situacao: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro51(CPFCNPJ,Inscricao,DataDocumento,Estado,
  Serie,Numero,CFOP,ValorContabil,ValorIpi,ValorOutras,ValorIsentas,
  Situacao: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro53(CPFCNPJ,Inscricao,DataDocumento,Estado,
  Modelo,Serie,Numero,CFOP,Emitente,BaseST,IcmsRetido,Despesas,
  Situacao,CodigoAntecipacao: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro54(CPFCNPJ,Modelo,Serie,Numero,CFOP,CST,
  NumeroItem,Codigo,Descricao,Quantidade,Valor,ValorDescontoDespesa,
  BasedeCalculo,BaseST,ValorIpi,Aliquota: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro60M(Emissao,NumSerie,NumOrdem,ModeloDoc,
  CooInicial,CooFinal,CRZ,CRO,VendaBruta,ValorGT: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro60A(Emissao,NumSerie,Aliquota,
  Valor: PChar): Integer; stdcall; export;
function ACBr_SintegraRegistro60D(Emissao,NumSerie,Codigo,Quantidade,
  Valor,BaseDeCalculo,StAliquota,ValorIcms: string): Integer; stdcall; export;
function ACBr_SintegraRegistro70(CPFCNPJ,Inscricao,DataDocumento,UF,
  Modelo,Serie,SubSerie,Numero,Cfop,ValorContabil,
  BasedeCalculo,Icms,Isentas,Outras,CifFobOutros,
  Situacao: PChar): Integer; stdcall; export;

function ACBr_SintegraRegistro75(DataInicial,DataFinal,Codigo,NCM,
  Descricao,Unidade,AliquotaIpi,AliquotaICMS,Reducao,
  BaseST: PChar): Integer; stdcall; export;
function ACBr_SintegraGeraArquivo(Arquivo: PChar;
  VersaoValidador: Integer): Integer; stdcall; export;
function ACBr_SintegraLimparRegistros: Integer; stdcall; export;

implementation

function ACBr_SintegraCheckAtivo: Boolean;
begin
Result:=False;
if Assigned(ACBr_Sintegra) then
  Result:=ACBr_Sintegra.Ativo;
end;

function ACBr_SintegraAtivar: Integer; stdcall; export;
begin
{
Result=0 Erro ao criar componente
Result=1 OK
Result=2 Erro, componente já está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    Result:=2;
  end
  else
  begin
    ACBr_Sintegra:=TACBrSintegra.Create(nil);
    Result:=1;
  end;
except
end;
end;

function ACBr_SintegraDesativar: Integer; stdcall; export;
begin
{
Result=0 Erro ao desativar componente
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    ACBr_Sintegra.Free;
    Result:=1;
  end
  else
  begin
    Result:=2;
  end;
except
end;
end;

function ACBr_SintegraRegistro10(CNPJ,Inscricao,RazaoSocial,Cidade,Estado,
  Telefone,DataInicial,DataFinal,CodigoConvenio,NaturezaInformacoes,
  FinalidadeArquivo: PChar): Integer; stdcall; export;
begin
{
Result=0 Erro ao gerar registro10
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      Registro10.CNPJ:=CNPJ;
      Registro10.Inscricao:=Inscricao;
      Registro10.RazaoSocial:=RazaoSocial;
      Registro10.Cidade:=Cidade;
      Registro10.Estado:=Estado;
      Registro10.Telefone:=Telefone;
      Registro10.DataInicial:=StrToDate(DataInicial);
      Registro10.DataFinal:=StrToDate(DataFinal);
      Registro10.CodigoConvenio:=CodigoConvenio;
      Registro10.NaturezaInformacoes:=NaturezaInformacoes;
      Registro10.FinalidadeArquivo:=FinalidadeArquivo;
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro11(Endereco,Numero,Bairro,Cep,Responsavel,
  Telefone: PChar): Integer; stdcall; export;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      Registro11.Endereco:=Endereco;
      Registro11.Numero:=Numero;
      Registro11.Bairro:=Bairro;
      Registro11.Cep:=Cep;
      Registro11.Responsavel:=Responsavel;
      Registro11.Telefone:=Telefone;
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro50(CPFCNPJ,Inscricao,DataDocumento,UF,Modelo,
  Serie,Numero,Cfop,EmissorDocumento,ValorContabil,BasedeCalculo,Icms,
  Isentas,Outras,Aliquota,Situacao: PChar): Integer; stdcall; export;
var
  wregistro50: TRegistro50;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro50:=TRegistro50.Create;
      wregistro50.CPFCNPJ:=CPFCNPJ;
      wregistro50.Inscricao:=Inscricao;
      wregistro50.DataDocumento:=StrToDate(DataDocumento);
      wregistro50.UF:=UF;
      wregistro50.Modelo:=Modelo;
      wregistro50.Serie:=Serie;
      wregistro50.Numero:=Numero;
      wregistro50.Cfop:=Cfop;
      wregistro50.EmissorDocumento:=EmissorDocumento;
      wregistro50.ValorContabil:=StrToFloatDef(ValorContabil,0);
      wregistro50.BasedeCalculo:=StrToFloatDef(BasedeCalculo,0);
      wregistro50.Icms:=StrToFloatDef(Icms,0);
      wregistro50.Isentas:=StrToFloatDef(Isentas,0);
      wregistro50.Outras:=StrToFloatDef(Outras,0);
      wregistro50.Aliquota:=StrToFloatDef(Aliquota,0);
      wregistro50.Situacao:=Situacao;
      Registros50.Add(wregistro50);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro51(CPFCNPJ,Inscricao,DataDocumento,Estado,
  Serie,Numero,CFOP,ValorContabil,ValorIpi,ValorOutras,ValorIsentas,
  Situacao: PChar): Integer; stdcall; export;
var
  wregistro51: TRegistro51;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro51:=TRegistro51.Create;
      wregistro51.CPFCNPJ:=CPFCNPJ;
      wregistro51.Inscricao:=Inscricao;
      wregistro51.DataDocumento:=StrToDate(DataDocumento);
      wregistro51.Estado:=Estado;
      wregistro51.Serie:=Serie;
      wregistro51.Numero:=Numero;
      wregistro51.Cfop:=Cfop;
      wregistro51.ValorContabil:=StrToFloatDef(ValorContabil,0);
      wregistro51.ValorIpi:=StrToFloatDef(ValorIpi,0);
      wregistro51.ValorOutras:=StrToFloatDef(ValorOutras,0);
      wregistro51.ValorIsentas:=StrToFloatDef(ValorIsentas,0);
      wregistro51.Situacao:=Situacao;
      Registros51.Add(wregistro51);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro53(CPFCNPJ,Inscricao,DataDocumento,Estado,
  Modelo,Serie,Numero,CFOP,Emitente,BaseST,IcmsRetido,Despesas,
  Situacao,CodigoAntecipacao: PChar): Integer; stdcall; export;
var
  wregistro53: TRegistro53;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro53:=TRegistro53.Create;
      wregistro53.CPFCNPJ:=CPFCNPJ;
      wregistro53.Inscricao:=Inscricao;
      wregistro53.DataDocumento:=StrToDate(DataDocumento);
      wregistro53.Estado:=Estado;
      wregistro53.Modelo:=Modelo;
      wregistro53.Serie:=Serie;
      wregistro53.Numero:=Numero;
      wregistro53.Cfop:=Cfop;
      wregistro53.Emitente:=Emitente;
      wregistro53.BaseST:=StrToFloatDef(BaseST,0);
      wregistro53.IcmsRetido:=StrToFloatDef(IcmsRetido,0);
      wregistro53.Despesas:=StrToFloatDef(Despesas,0);
      wregistro53.Situacao:=Situacao;
      wregistro53.CodigoAntecipacao:=CodigoAntecipacao;
      Registros53.Add(wregistro53);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro54(CPFCNPJ,Modelo,Serie,Numero,CFOP,CST,
  NumeroItem,Codigo,Descricao,Quantidade,Valor,ValorDescontoDespesa,
  BasedeCalculo,BaseST,ValorIpi,Aliquota: PChar): Integer; stdcall; export;
var
  wregistro54: TRegistro54;
begin
{
Result=0 Erro ao gerar registro54
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro54:=TRegistro54.Create;
      wregistro54.CPFCNPJ:=CPFCNPJ;
      wregistro54.Modelo:=Modelo;
      wregistro54.Serie:=Serie;
      wregistro54.Numero:=Numero;
      wregistro54.Cfop:=Cfop;
      wregistro54.CST:=CST;
      wregistro54.NumeroItem:=StrToInt(NumeroItem);
      wregistro54.Codigo:=Codigo;
      wregistro54.Descricao:=Descricao;
      wregistro54.Quantidade:=StrToFloatDef(Quantidade,0);
      wregistro54.Valor:=StrToFloatDef(Valor,0);
      wregistro54.ValorDescontoDespesa:=StrToFloatDef(ValorDescontoDespesa,0);
      wregistro54.BasedeCalculo:=StrToFloatDef(BasedeCalculo,0);
      wregistro54.BaseST:=StrToFloatDef(BaseST,0);
      wregistro54.ValorIpi:=StrToFloatDef(ValorIpi,0);
      wregistro54.Aliquota:=StrToFloatDef(Aliquota,0);
      Registros54.Add(wregistro54);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro60M(Emissao,NumSerie,NumOrdem,ModeloDoc,
  CooInicial,CooFinal,CRZ,CRO,VendaBruta,ValorGT: PChar): Integer; stdcall; export;
var
  wregistro60M: TRegistro60M;
begin
{
Result=0 Erro ao gerar registro60M
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro60M:=TRegistro60M.Create;
      wregistro60M.Emissao:=StrToDate(Emissao);
      wregistro60M.NumSerie:=NumSerie;
      wregistro60M.NumOrdem:=StrToIntDef(NumOrdem,0);
      wregistro60M.ModeloDoc:=ModeloDoc;
      wregistro60M.CooInicial:=StrToIntDef(CooInicial,0);
      wregistro60M.CooFinal:=StrToIntDef(CooFinal,0);
      wregistro60M.CRZ:=StrToIntDef(CRZ,0);
      wregistro60M.CRO:=StrToIntDef(CRO,0);
      wregistro60M.VendaBruta:=StrToFloatDef(VendaBruta,0);
      wregistro60M.ValorGT:=StrToFloatDef(ValorGT,0);
      Registros60M.Add(wregistro60M);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro60A(Emissao,NumSerie,Aliquota,
  Valor: PChar): Integer; stdcall; export;
var
  wregistro60A: TRegistro60A;
begin
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro60A:=TRegistro60A.Create;
      wregistro60A.Emissao:=StrToDate(Emissao);
      wregistro60A.NumSerie:=NumSerie;
      wregistro60A.StAliquota:=Aliquota;
      wregistro60A.Valor:=StrToFloatDef(Valor,0);
      Registros60A.Add(wregistro60A);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro70(CPFCNPJ,Inscricao,DataDocumento,UF,
  Modelo,Serie,SubSerie,Numero,Cfop,ValorContabil,
  BasedeCalculo,Icms,Isentas,Outras,CifFobOutros,
  Situacao: PChar): Integer; stdcall; export;
var
  wregistro70: TRegistro70;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro70:=TRegistro70.Create;
      wregistro70.CPFCNPJ:=CPFCNPJ;
      wregistro70.Inscricao:=Inscricao;
      wregistro70.DataDocumento:=StrToDate(DataDocumento);
      wregistro70.UF:=UF;
      wregistro70.Modelo:=Modelo;
      wregistro70.Serie:=Serie;
      wregistro70.SubSerie:=SubSerie;
      wregistro70.Numero:=Numero;
      wregistro70.Cfop:=Cfop;
      wregistro70.ValorContabil:=StrToFloatDef(ValorContabil,0);
      wregistro70.BasedeCalculo:=StrToFloatDef(BasedeCalculo,0);
      wregistro70.Icms:=StrToFloatDef(Icms,0);
      wregistro70.Isentas:=StrToFloatDef(Isentas,0);
      wregistro70.Outras:=StrToFloatDef(Outras,0);
      wregistro70.CifFobOutros:=CifFobOutros;
      wregistro70.Situacao:=Situacao;
      Registros70.Add(wregistro70);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro75(DataInicial,DataFinal,Codigo,NCM,
  Descricao,Unidade,AliquotaIpi,AliquotaICMS,Reducao,
  BaseST: PChar): Integer; stdcall; export;
var
  wregistro75: TRegistro75;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro75:=TRegistro75.Create;
      wregistro75.DataInicial:=StrToDate(DataInicial);
      wregistro75.DataFinal:=StrToDate(DataFinal);
      wregistro75.Codigo:=Codigo;
      wregistro75.NCM:=NCM;
      wregistro75.Descricao:=Descricao;
      wregistro75.Unidade:=Unidade;
      wregistro75.AliquotaIpi:=StrToFloatDef(AliquotaIpi,0);
      wregistro75.AliquotaICMS:=StrToFloatDef(AliquotaICMS,0);
      wregistro75.Reducao:=StrToFloatDef(Reducao,0);
      wregistro75.BaseST:=StrToFloatDef(BaseST,0);
      Registros75.Add(wregistro75);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraGeraArquivo(Arquivo: PChar;
  VersaoValidador: Integer): Integer; stdcall; export;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    ACBr_Sintegra.FileName:=Arquivo;
    ACBr_Sintegra.VersaoValidador:=TVersaoValidador(VersaoValidador);
    ACBr_Sintegra.GeraArquivo;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraLimparRegistros: Integer; stdcall; export;
begin
{
Result=0 Erro ao gerar registro11
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    ACBr_Sintegra.LimparRegistros;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro60D(Emissao,NumSerie,Codigo,Quantidade,
  Valor,BaseDeCalculo,StAliquota,ValorIcms: string): Integer; stdcall; export;
var
  wregistro60D: TRegistro60D;
begin
{
Result=0 Erro ao gerar registro60D
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro60D:=TRegistro60D.Create;
      wregistro60D.Emissao:=StrToDate(Emissao);
      wregistro60D.NumSerie:=NumSerie;
      wregistro60D.Codigo:=Codigo;
      wregistro60D.Quantidade:=StrToFloat(Quantidade);
      wregistro60D.Valor:=StrToFloat(Valor);
      wregistro60D.BaseDeCalculo:=StrToFloat(BaseDeCalculo);
      wregistro60D.StAliquota:=StAliquota;
      wregistro60D.ValorIcms:=StrToFloat(ValorIcms);
      Registros60D.Add(wregistro60D);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

function ACBr_SintegraRegistro74(Data,Codigo,Quantidade,ValorProduto,
  CodigoPosse,CNPJPossuidor,InscricaoPossuidor,UFPossuidor: string): Integer; stdcall; export;
var
  wregistro74: TRegistro74;
begin
{
Result=0 Erro ao gerar registro74
Result=1 OK
Result=2 Erro, componente não está ativo
}
Result:=0;
try
  if ACBr_SintegraCheckAtivo then
  begin
    with ACBr_Sintegra do
    begin
      wregistro74:=TRegistro74.Create;
      wregistro74.Data:=StrToDate(Data);
      wregistro74.Codigo:=Codigo;
      wregistro74.Quantidade:=StrToFloat(Quantidade);
      wregistro74.ValorProduto:=StrToFloat(ValorProduto);
      wregistro74.CodigoPosse:=CodigoPosse;
      wregistro74.CNPJPossuidor:=CNPJPossuidor;
      wregistro74.InscricaoPossuidor:=InscricaoPossuidor;
      wregistro74.UFPossuidor:=UFPossuidor;
      Registros74.Add(wregistro74);
    end;
    Result:=1;
  end
  else
    Result:=2;
except
end;
end;

end.

