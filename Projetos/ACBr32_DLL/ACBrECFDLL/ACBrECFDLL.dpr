library ACBrECFDLL;

uses
  SysUtils,
  Classes,
  ACBrECF,
  ACBrECFClass,
  ACBrUtil;

var
  ECF      : TACBrECF;
  MsgErro  : String;

{$R *.res}

{
TODAS as funções da biblioteca retornam um Integer com as possíveis Respostas:

MAIOR OU IGUAL A ZERO: SUCESSO
    0 : Executado com sucesso;
        Outos retornos maior que zero indicam sucesso.
        O valor retornado é específico de cada função.

MENOR QUE ZERO: ERROS

  -1 : Erro ao executar;
       Vide UltimoErro

  -2 : ACBr não inicializado.

  Outros retornos negativos indicam erro específico de cada função;

  A função "UltimoErro" retornará a mensagem da última exception disparada pelo componente.
}

Function UltimoErro(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
begin

  try
     StrPLCopy(Buffer, MsgErro, BufferLen);
     Result := length(MsgErro);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function Ativar : Integer; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Ativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function Desativar : Integer; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Desativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function Inicializar(): Integer; StdCall; export;
begin

  if (ECF <> nil) AND (ECF.Ativo) then Desativar;

  try
     ECF :=  TACBrECF.Create(nil);
     ECF.ReTentar := False;
     ECF.ExibeMensagem := False;
     ECF.BloqueiaMouseTeclado := False;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

{Records estilo C utilizados nos retornos das funções}

type TAliquotaRec = record
      Indice : array[0..3] of char;
      Aliquota : double;
      Tipo : char;
      Total : double;
      Sequencia : byte;
end;

type TFormaPagamentoRec = record
      Indice : array[0..3] of char;
      Descricao : array[0..29] of char;
      PermiteVinculado : boolean;
      Total : double;
end;

type TComprovanteNaoFiscalRec = record
    Indice: array[0..3] of char;
    Descricao: array[0..29] of char;
    PermiteVinculado: Boolean;
    FormaPagamento: array[0..3] of char;
    Total: Double ;
    Contador: Integer;
end;

{ Funções mapeando as propriedades do componente }

Function GetModelo : Integer; StdCall; export;
begin

  if (ECF = nil) then
   begin
     Result := -2;
     Exit ;
   end;

  try
     Result := Integer(ECF.Modelo);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function SetModelo(const Modelo : Integer) : Integer; StdCall; export;
begin

  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Modelo := TACBrECFModelo(Modelo);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetPorta(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.Porta;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function SetPorta(const Porta : pChar) : Integer; StdCall; export;
begin

  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Porta := Porta;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetTimeOut : Integer; StdCall; export;
begin

  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     Result := ECF.TimeOut;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function SetTimeOut(const TimeOut : Integer) : Integer; StdCall; export;
begin

  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.TimeOut := TimeOut;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;


Function GetAtivo : Integer; StdCall; export;
begin

  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     if (ECF.Ativo) then
        Result := 1
     else
        Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetColunas : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     Result := ECF.Colunas;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetAguardandoResposta : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
        if ECF.AguardandoResposta then
                Result := 1
        else
                Result :=0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetComandoEnviado(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.ComandoEnviado;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetRespostaComando(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.RespostaComando;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetComandoLOG(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.ComandoLOG;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function SetComandoLOG(const ComandoLog : pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     ECF.ComandoLOG := ComandoLog;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetAguardaImpressao : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
        if ECF.AguardaImpressao then
                Result := 1
        else
                Result :=0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function SetAguardaImpressao(const AguardaImpressao : Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.AguardaImpressao := AguardaImpressao;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetModeloStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
Var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     StrTmp := ECF.ModeloStr;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetRFDID(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
Var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     StrTmp := ECF.RFDID;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDataHora( var ticks : Double) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ticks := double(ECF.DataHora);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDataHoraStr( var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := FormatDateTime('dd/mm/yyyy hh:nn:ss', ECF.DataHora );
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumCupom(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCupom;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumCOO(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCOO;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumLoja(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumLoja;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumECF(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumECF;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumSerie(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumSerie;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumVersao(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumVersao;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end;
  end;
end;

Function GetDataMovimento(var ticks : Double) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ticks := double(ECF.DataMovimento);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDataMovimentoStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := pchar(FormatDateTime('dd/mm/yyyy', ECF.DataMovimento));
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDataHoraSB(var ticks : Double) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ticks := double(ECF.DataHoraSB);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDataHoraSBStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := pchar(FormatDateTime('dd/mm/yyyy hh:nn:ss', ECF.DataHoraSB));
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetCNPJ(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.CNPJ;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetIE(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.IE;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetIM(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.IM;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetCliche(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.Cliche;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetUsuarioAtual(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.UsuarioAtual;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

 Function GetSubModeloECF(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.SubModeloECF;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;


Function GetPAF(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
  StrTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

 try
     StrTmp := ECF.PAF;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;



Function GetNumCRZ(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCRZ;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumCRO(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCRO;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumCCF(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCCF;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumGNF(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumGNF;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumGRG(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumGRG;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetNumCDC(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCDC;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;



Function GetNumCOOInicial(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.NumCOOInicial;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetVendaBruta( var VendaBruta : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     VendaBruta := ECF.VendaBruta;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetGrandeTotal( var GrandeTotal : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     GrandeTotal := ECF.GrandeTotal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalCancelamentos( var TotalCancelamentos : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalCancelamentos := ECF.TotalCancelamentos;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalDescontos( var TotalDescontos : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalDescontos := ECF.TotalDescontos;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalAcrescimos( var TotalAcrescimos : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalAcrescimos := ECF.TotalAcrescimos;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetTotalTroco( var TotalTroco : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalTroco := ECF.TotalTroco;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetTotalSubstituicaoTributaria( var TotalSubstituicaoTributaria : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalSubstituicaoTributaria := ECF.TotalSubstituicaoTributaria;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalNaoTributado( var TotalNaoTributado : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalNaoTributado := ECF.TotalNaoTributado;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalIsencao( var TotalIsencao : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalIsencao := ECF.TotalIsencao;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetTotalCancelamentosISSQN( var TotalCancelamentosISSQN : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalCancelamentosISSQN := ECF.TotalCancelamentosISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetTotalDescontosISSQN( var TotalDescontosISSQN : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalDescontosISSQN := ECF.TotalDescontosISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalAcrescimosISSQN( var TotalAcrescimosISSQN : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalAcrescimosISSQN := ECF.TotalAcrescimosISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalSubstituicaoTributariaISSQN( var TotalSubstituicaoTributariaISSQN : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalSubstituicaoTributariaISSQN := ECF.TotalSubstituicaoTributariaISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetTotalNaoTributadoISSQN( var TotalNaoTributadoISSQN : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalNaoTributadoISSQN := ECF.TotalNaoTributadoISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalIsencaoISSQN( var TotalIsencaoISSQN : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalIsencaoISSQN := ECF.TotalIsencaoISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalNaoFiscal( var TotalNaoFiscal : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalNaoFiscal := ECF.TotalNaoFiscal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetNumUltItem : Integer ; StdCall ; export; begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      Result := ECF.NumUltItem;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;


{ ECF - Flags }


Function GetEmLinha(const TimeOut : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try

     if (ECF.EmLinha(TimeOut)) then
       Result := 1
     else
       Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetPoucoPapel : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try

     if (ECF.PoucoPapel) then
       Result := 1
     else
       Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetEstado : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     Result := integer(ECF.Estado);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetHorarioVerao : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.HorarioVerao then
        Result := 1
     Else
        Result := 0;


  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetArredonda : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.Arredonda then
        Result := 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTermica : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.Termica then
        Result := 1
     Else
        Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetMFD : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.MFD then
        Result:= 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetIdentificaConsumidorRodape : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.IdentificaConsumidorRodape then
        Result:= 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;



Function GetSubTotal( var SubTotal : double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     SubTotal := ECF.Subtotal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetTotalPago( var TotalPago : double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     TotalPago := ECF.TotalPago;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetGavetaAberta : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.GavetaAberta then
        Result := 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetChequePronto() : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     If ECF.ChequePronto then
        Result := 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function GetIntervaloAposComando () : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     Result := ECF.IntervaloAposComando;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function SetIntervaloAposComando (const Intervalo : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.IntervaloAposComando := Intervalo;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDescricaoGrande() : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     if ECF.DescricaoGrande then
       Result := 1
     else
       Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function SetDescricaoGrande(const DescricaoGrande : Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.DescricaoGrande := DescricaoGrande;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetGavetaSinalInvertido() : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     if ECF.GavetaSinalInvertido then
       Result := 1
     else
       Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function SetGavetaSinalInvertido(const GavetaSinalInvertido : Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.GavetaSinalInvertido := GavetaSinalInvertido;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetOperador(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
var
   strTmp : String;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     strTmp := ECF.Operador;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function SetOperador(const Operador : pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Operador := Operador;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetLinhasEntreCupons() : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
       Result := ECF.LinhasEntreCupons;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function SetLinhasEntreCupons (const LinhasEntreCupons : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.LinhasEntreCupons := LinhasEntreCupons;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDecimaisPreco() : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
       Result := ECF.DecimaisPreco;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function SetDecimaisPreco (const DecimaisPreco : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.DecimaisPreco := DecimaisPreco;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function GetDecimaisQtd() : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
       Result := ECF.DecimaisQtd;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function SetDecimaisQtd (const DecimaisQtd : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.DecimaisQtd := DecimaisQtd;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

{Métodos do componente}

{
Métodos do cupom fiscal
}

Function IdentificaConsumidor(const CPF_CNPJ, Nome, Endereco : pChar) : Integer ; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.IdentificaConsumidor( CPF_CNPJ, Nome, Endereco );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function AbreCupom(const CPF_CNPJ, Nome, Endereco : pChar) : Integer; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit;
   end;

  try
     ECF.AbreCupom( CPF_CNPJ, Nome, Endereco );
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function LegendaInmetroProximoItem : Integer; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit;
   end;

  try
     ECF.LegendaInmetroProximoItem;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function VendeItem( const Codigo, Descricao, AliquotaICMS : pChar;
                    const Qtd, ValorUnitario, DescontoPorc : Double;
                    const Unidade, TipoDescontoAcrescimo, DescontoAcrescimo : pChar) : Integer ; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.VendeItem( Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, DescontoPorc, Unidade, TipoDescontoAcrescimo, DescontoAcrescimo );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;


Function DescontoAcrescimoItemAnterior( const ValorDescontoAcrescimo : Double; const DescontoAcrescimo : pChar) : Integer ; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.DescontoAcrescimoItemAnterior(ValorDescontoAcrescimo, DescontoAcrescimo);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;


Function SubtotalizaCupom(const DescontoAcrescimo : Double ; const MensagemRodape : pChar) : Integer; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit;
   end;

  try
     ECF.SubtotalizaCupom( DescontoAcrescimo, MensagemRodape );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EfetuaPagamento(const CodFormaPagto : pChar; const Valor : Double; const Observacao : pChar ; const ImprimeVinculado : Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EstornaPagamento(const CodFormaPagtoEstornar : pChar; const CodFormaPagtoEfetivar : pChar; const Valor: Double; const Observacao : pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.EstornaPagamento(CodFormaPagtoEstornar, CodFormaPagtoEfetivar, Valor, Observacao);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function FechaCupom(const Observacao : pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.FechaCupom( Observacao );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaCupom : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaCupom;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaItemVendido(const NumItem : Integer ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaItemVendido( NumItem );
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaItemVendidoParcial(const NumItem : Integer; const Quantidade : Double ) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaItemVendidoParcial(NumItem, Quantidade);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaDescontoAcrescimoItem(const NumItem : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaDescontoAcrescimoItem(NumItem);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaDescontoAcrescimoSubTotal(const TipoAcrescimoDesconto : Char) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto);
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


{
 Relatórios
}

Function LeituraX : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.LeituraX;
     Result := 0;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ReducaoZ : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.ReducaoZ;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function AbreRelatorioGerencial(const Indice : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.AbreRelatorioGerencial(Indice);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LinhaRelatorioGerencial(const Linha : pChar; const IndiceBMP : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.LinhaRelatorioGerencial(Linha, IndiceBMP);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function AbreCupomVinculado(const COO, CodFormaPagto : pChar; const Valor : Double) : Integer ; StdCall ; overload; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.AbreCupomVinculado(COO, CodFormaPagto, Valor);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function AbreCupomVinculado(const COO, CodFormaPagto, CodComprovanteNaoFiscal : pChar; const Valor : Double) : Integer ; overload; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal, Valor);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LinhaCupomVinculado(const Linha : pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.LinhaCupomVinculado(Linha);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function FechaRelatorio : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.FechaRelatorio;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function PulaLinhas(const NumLinhas : Integer) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.PulaLinhas(NumLinhas);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CortaPapel(const CorteParcial : Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CortaPapel(CorteParcial);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


{
Alíquotas
}

Function GetAliquota(var retAliquota : TAliquotaRec; const index : Integer) : Integer ; StdCall ; export;
var
  aliquota : TACBrECFAliquota;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try

      if (index >= 0) and (index < ECF.Aliquotas.Count) then
      begin
              aliquota := ECF.Aliquotas[index];

              StrPLCopy(retAliquota.Indice, aliquota.Indice, 4);
              retAliquota.Aliquota := aliquota.Aliquota;
              retAliquota.Tipo := aliquota.Tipo;
              retAliquota.Total := aliquota.Total;
              retAliquota.Sequencia := aliquota.Sequencia;
              Result := 0;

      end
      else
      begin
              Result := -3;
      end;

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function CarregaAliquotas() : Integer ; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CarregaAliquotas;
     Result := ECF.Aliquotas.Count;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function GetAliquotasStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
    Var I : Integer;
        strTmp : string ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      strTmp := '' ;
      if ECF.Aliquotas.Count < 1 then
        ECF.CarregaAliquotas ;

      for I := 0 to ECF.Aliquotas.Count -1 do
         strTmp := strTmp + padL(ECF.Aliquotas[I].Indice,4)
                      + ' '
                      + ECF.Aliquotas[I].Tipo
                      + FormatFloat('#0.00', ECF.Aliquotas[I].Aliquota) + '|' ;

     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function LerTotaisAliquota() : Integer ; StdCall ; export;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
     ECF.LerTotaisAliquota;
     Result := ECF.Aliquotas.Count;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function LerTotaisAliquotaStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
   Var I : Integer;
      strTmp : string ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      strTmp := '' ;
      ECF.LerTotaisAliquota ;

      for I := 0 to ECF.Aliquotas.Count -1 do
         strTmp := strTmp + padL(ECF.Aliquotas[I].Indice,4) +
                            FormatFloat('########0.00', ECF.Aliquotas[I].Total ) + '|' ;


     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;


Function ProgramaAliquota(const Aliquota : Double; const Tipo : Char) : Integer ; StdCall ; export;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      ECF.ProgramaAliquota(Aliquota, Tipo);
      Result := 0 ;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;


Function AchaIcmsAliquota( Aliq : Double ; Tipo : Char ; var ret_pos : pchar ) : Integer ; StdCall ; export;
   var ICMS    : TACBrECFAliquota  ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      ICMS := ECF.AchaICMSAliquota( Aliq, Tipo  ) ;
      if ICMS <> nil then
              ret_pos := pchar(padL(ICMS.Indice,4))
      else
         ret_pos := pchar(padL('-1',4));
      Result := 0 ;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;


{
 Forma de pagamento
}


Function GetFormaPagamento( var retFormaPagamento : TFormaPagamentoRec; const index : Integer) : Integer ; StdCall ; export;
var
  formaPagamento : TACBrECFFormaPagamento;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try

      if (index >= 0) and (index < ECF.FormasPagamento.Count) then
      begin

              formaPagamento := ECF.FormasPagamento[index];

              StrPLCopy(retFormaPagamento.Indice, formaPagamento.Indice, 4);
              StrPLCopy(retFormaPagamento.Descricao, formaPagamento.Descricao, 30);
              retFormaPagamento.PermiteVinculado := formaPagamento.PermiteVinculado;
              retFormaPagamento.Total := formaPagamento.Total;
              Result := 0;
      end
      else
      begin
              Result := -3;
      end;

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function CarregaFormasPagamento : Integer ; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CarregaFormasPagamento;
     Result := ECF.FormasPagamento.Count;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function LerTotaisFormaPagamento : Integer ; StdCall ; export;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      ECF.LerTotaisFormaPagamento ;
      Result := ECF.FormasPagamento.Count;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function GetFormasPagamentoStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
    Var I : Integer;
      strTmp : string;
      Vinc : Char ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      strTmp := '' ;
      if ECF.FormasPagamento.Count < 1 then
         ECF.CarregaFormasPagamento ;


      for I := 0 to ECF.FormasPagamento.Count -1 do
      begin
         Vinc := ' ' ;
         if ECF.FormasPagamento[I].PermiteVinculado then
            Vinc := 'V' ;

         strTmp := strTmp + padL(ECF.FormasPagamento[I].Indice,4)
                      + ' '
                      + Vinc
                      + ECF.FormasPagamento[I].Descricao
                      + '|' ;
      end;

      StrPLCopy(Buffer, strTmp, BufferLen);
      Result := length(strTmp)
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function LerTotaisFormaPagamentoStr(var Buffer : pChar; const BufferLen : Integer) : Integer ; StdCall ; export;
   Var I : Integer;
      strTmp : string ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      strTmp := '' ;
      ECF.LerTotaisFormaPagamento ;

      for I := 0 to ECF.FormasPagamento.Count -1 do
         strTmp := strTmp + padL(ECF.FormasPagamento[I].Indice,4)
                      + FormatFloat('########0.00', ECF.FormasPagamento[I].Total ) + '|' ;


      StrPLCopy(Buffer, strTmp, BufferLen);
      Result := length(strTmp)
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function ProgramaFormaPagamento(const Descricao : pChar ; const PermiteVinculado : Boolean) : Integer ; StdCall ; export;
var
  pDesc : String;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      pDesc := String(Descricao);
      ECF.ProgramaFormaPagamento(pDesc, PermiteVinculado);
      Result := 0;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function AchaFPGDescricao( Descricao : String ;  var retorno : pchar  ) : Integer ; StdCall ; export;
   var FPG    : TACBrECFFormaPagamento  ;
       vinc   : string;

begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      FPG := ECF.AchaFPGDescricao( Descricao, False  ) ;

      if FPG <> nil then
      begin
         Vinc := ' ';
         If FPG.PermiteVinculado then
           Vinc := 'V';

         retorno := pchar(padL(FPG.Indice,4) +
                          Vinc+
                          padL( FPG.Descricao, 30));
      end
      else
         retorno := pchar(padL('-1',4));

      Result := 0 ;

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

{
 Comprovantes Não Fiscais
}

Function GetComprovanteNaoFiscal(var retComprovanteNaoFiscal : TComprovanteNaoFiscalRec; const index : Integer) : Integer ; StdCall ; export;
var
  comprovanteNaoFiscal : TACBrECFComprovanteNaoFiscal;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try

      if (index >= 0) and (index < ECF.ComprovantesNaoFiscais.Count) then
      begin
              comprovanteNaoFiscal := ECF.ComprovantesNaoFiscais[index];

              StrPLCopy(retComprovanteNaoFiscal.Indice, comprovanteNaoFiscal.Indice, 4);
              StrPLCopy(retComprovanteNaoFiscal.Descricao, comprovanteNaoFiscal.Descricao, 30);
              retComprovanteNaoFiscal.PermiteVinculado := comprovanteNaoFiscal.PermiteVinculado;
              StrPLCopy(retComprovanteNaoFiscal.FormaPagamento, comprovanteNaoFiscal.FormaPagamento, 4);
              retComprovanteNaoFiscal.Total := comprovanteNaoFiscal.Total;
              retComprovanteNaoFiscal.Contador := comprovanteNaoFiscal.Contador;
              Result := 0;
      end
      else
      begin
              Result := -3;
      end;

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function CarregaComprovantesNaoFiscais() : Integer ; StdCall; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CarregaComprovantesNaoFiscais;
     Result := ECF.Aliquotas.Count;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function LerTotaisComprovanteNaoFiscal() : Integer ; StdCall ; export;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
     ECF.LerTotaisComprovanteNaoFiscal;
     Result := ECF.Aliquotas.Count;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function ComprovantesNaoFiscais( var v_ComprovantesNaoFiscais : pchar ) : Integer ; StdCall ; export;
    Var I : Integer;
      resp : string;
       Vinc : Char ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      resp := '' ;
      if ECF.ComprovantesNaoFiscais.Count < 1 then
         ECF.CarregaComprovantesNaoFiscais ;


      for I := 0 to ECF.ComprovantesNaoFiscais.Count -1 do
      begin
         Vinc := ' ' ;
         if ECF.ComprovantesNaoFiscais[I].PermiteVinculado then
            Vinc := 'V' ;

         resp := resp + padL(ECF.ComprovantesNaoFiscais[I].Indice,4)
                      + ' '
                      + Vinc
                      + ECF.ComprovantesNaoFiscais[I].Descricao
                      + '|' ;
      end;
      if resp <> '' then
      begin
         v_ComprovantesNaoFiscais := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function LerTotaisComprovante( var v_LerTotaisComprovante : pchar ) : Integer ; StdCall ; export;
   Var I : Integer;
      resp : string ;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      resp := '' ;
      ECF.LerTotaisComprovanteNaoFiscal;

      for I := 0 to ECF.ComprovantesNaoFiscais.Count -1 do
         resp := resp + padL(ECF.ComprovantesNaoFiscais[I].Indice,4)
                      + FormatFloat('########0.00', ECF.ComprovantesNaoFiscais[I].Total ) + '|' ;


      if resp <> '' then
      begin
         v_LerTotaisComprovante := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0 ;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function ProgramaComprovanteNaoFiscal(const Descricao, Tipo : pChar) : Integer ; StdCall ; export;
var
 pDesc : String;
begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      pDesc := String(Descricao);
      ECF.ProgramaComprovanteNaoFiscal(pDesc, Tipo);
      Result := 0;
   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function AchaCNFDescricao( Descricao : String ;  var retorno : pchar  ) : Integer ; StdCall ; export;
   var CNF    : TACBrECFComprovanteNaoFiscal  ;
       vinc   : string;

begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      CNF := ECF.AchaCNFDescricao( Descricao, False  ) ;

      if CNF <> nil then
      begin
         Vinc := ' ';
         If CNF.PermiteVinculado then
           Vinc := 'V';

         retorno := pchar(padL(CNF.Indice,4) +
                          Vinc+
                          padL( CNF.Descricao, 30));
      end
      else
         retorno := pchar(padL('-1',4));

      Result := 0 ;

   except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
   end;
end;


{
 ...
}


Function TestaPodeAbrirCupom( var v_TestaPodeAbrirCupom : pchar ) : Integer ; StdCall ; export; begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;
   result := 8;
   try
      ECF.TestaPodeAbrirCupom;
      v_TestaPodeAbrirCupom := pchar( 'OK' ) ;
      Result := 0 ;
   except
      on E : Exception do begin
        v_TestaPodeAbrirCupom := pchar( E.Message );
      end;
   end;
end;


Function Sangria( const Valor: Double; const Obs: pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Sangria(Valor, Obs);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function Suprimento(const Valor: Double; const Obs: pChar) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.Suprimento(Valor, Obs);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function AbreNaoFiscal(CPF_CNPJ: String) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.AbreNaoFiscal(CPF_CNPJ);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function RegistraItemNaoFiscal(CodCNF: String; Valor: Double;
  Obs: AnsiString = '') : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.RegistraItemNaoFiscal(CodCNF,Valor,Obs);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.SubtotalizaNaoFiscal(DescontoAcrescimo,MensagemRodape);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.EfetuaPagamentoNaoFiscal(CodFormaPagto,Valor,Observacao,ImprimeVinculado);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function FechaNaoFiscal(Observacao: AnsiString) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.FechaNaoFiscal(Observacao);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaNaoFiscal : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaNaoFiscal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function AbreGaveta : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.AbreGaveta;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function ImprimeCheque(Banco: String; Valor: Double; Favorecido,
  Cidade: String; Data: TDateTime; Observacao: String) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.ImprimeCheque(Banco,Valor,Favorecido,Cidade,Data,Observacao);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CancelaImpressaoCheque : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CancelaImpressaoCheque;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function MudaHorarioVerao : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.MudaHorarioVerao;
     Result := 0 ;
  except
      on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function MudaArredondamento(Arredondar: Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.MudaArredondamento(Arredondar);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;







{ AINDA NÃO IMPLEMENTADO }



Function PreparaTEF : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.PreparaTEF;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function CorrigeEstadoErro(ReducaoZ: Boolean) : Integer ; StdCall ; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.CorrigeEstadoErro(ReducaoZ);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EnviaComando(cmd: AnsiString; var resp : pchar ) : Integer ; StdCall ; export; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     resp := pchar(ECF.EnviaComando(cmd));
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EnviaComando(cmd: AnsiString; lTimeOut: Integer; var resp : pchar ) : Integer ; StdCall ; export; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     resp := pchar(ECF.EnviaComando(cmd,lTimeOut));
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False) : Integer ; StdCall ; export; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal,
                                   Simplificada);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean) : Integer ; StdCall ; export ; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ECF.LeituraMemoriaFiscal(DataInicial, DataFinal,
                                   Simplificada);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscalSerial(ReducaoInicial,ReducaoFinal: Integer;
                                    Simplificada : Boolean; var Linhas : pchar ) : Integer ; StdCall ; export; overload;
   var v_linha : TStringList;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;
  try
     v_linha := TStringList.Create;
     ECF.LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal, v_linha,
                                   Simplificada);
     Linhas := pchar(v_linha);
     v_linha.Free;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscalSerial(DataInicial,DataFinal: TDateTime; Simplificada : Boolean ;
                                    var Linhas : pchar ) : Integer ; StdCall ; export ; overload;
  var v_linha : TStringList;

begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     v_linha := TStringList.Create;
     ECF.LeituraMemoriaFiscalSerial(DataInicial, DataFinal, v_linha,
                                   Simplificada);
     Linhas := pchar(v_linha);
     v_linha.Free;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        MsgErro := exception.Message;
        Result  := -1;
     end
  end;
end;


exports

{ Funções }

Inicializar,
UltimoErro,
Ativar, Desativar,

{ Propriedades do Componente }

GetModelo, SetModelo, GetPorta, SetPorta, GetTimeOut, SetTimeOut, GetAtivo,

GetColunas, GetAguardandoResposta, GetComandoEnviado, GetRespostaComando, GetComandoLOG, SetComandoLOG,
GetAguardaImpressao, SetAguardaImpressao,

GetModeloStr, GetRFDID, GetDataHora, GetDataHoraStr,
GetNumCupom, GetNumCOO, GetNumLoja, GetNumECF, GetNumSerie, GetNumVersao,

GetDataMovimento, GetDataMovimentoStr, GetDataHoraSB, GetDataHoraSBStr,
GetCNPJ, GetIE, GetIM, GetCliche, GetUsuarioAtual, GetSubModeloECF,

GetPAF, GetNumCRZ, GetNumCRO, GetNumCCF, GetNumGNF, GetNumGRG, GetNumCDC,
GetNumCOOInicial, GetVendaBruta, GetGrandeTotal,
GetTotalCancelamentos, GetTotalDescontos, GetTotalAcrescimos, GetTotalTroco,
GetTotalSubstituicaoTributaria, GetTotalNaoTributado, GetTotalIsencao,

GetTotalCancelamentosISSQN, GetTotalDescontosISSQN,
GetTotalAcrescimosISSQN, GetTotalSubstituicaoTributariaISSQN,
GetTotalNaoTributadoISSQN, GetTotalIsencaoISSQN, GetTotalNaoFiscal,

GetNumUltItem,

GetEmLinha, GetPoucoPapel, GetEstado, GetHorarioVerao, GetArredonda,
GetTermica, GetMFD, GetIdentificaConsumidorRodape,

GetSubTotal, GetTotalPago, GetGavetaAberta,

GetChequePronto,
GetIntervaloAposComando, SetIntervaloAposComando,
GetDescricaoGrande, SetDescricaoGrande,
GetGavetaSinalInvertido, SetGavetaSinalInvertido,
GetOperador, SetOperador,
GetLinhasEntreCupons, SetLinhasEntreCupons,
GetDecimaisPreco, SetDecimaisPreco,
GetDecimaisQtd, SetDecimaisQtd,

{ Métodos do Componente }

IdentificaConsumidor, AbreCupom, LegendaInmetroProximoItem, VendeItem,
DescontoAcrescimoItemAnterior,  SubtotalizaCupom,
EfetuaPagamento, EstornaPagamento,FechaCupom,CancelaCupom ,
CancelaItemVendido, CancelaItemVendidoParcial,
CancelaDescontoAcrescimoItem, CancelaDescontoAcrescimoSubTotal,

LeituraX, ReducaoZ, AbreRelatorioGerencial,
LinhaRelatorioGerencial, LinhaCupomVinculado,
FechaRelatorio, PulaLinhas, CortaPapel;

exports AbreCupomVinculado(const COO, CodFormaPagto : pChar; const Valor : Double) overload;
exports AbreCupomVinculado(const COO, CodFormaPagto, CodComprovanteNaoFiscal : pChar; const Valor : Double) overload;

exports

GetAliquota, CarregaAliquotas, LerTotaisAliquota,
GetAliquotasStr, LerTotaisAliquotaStr,
ProgramaAliquota, AchaIcmsAliquota,

GetFormaPagamento, CarregaFormasPagamento, LerTotaisFormaPagamento,
GetFormasPagamentoStr, LerTotaisFormaPagamentoStr,
ProgramaFormaPagamento, AchaFPGDescricao,

GetComprovanteNaoFiscal, CarregaComprovantesNaoFiscais,
LerTotaisComprovanteNaoFiscal, ProgramaComprovanteNaoFiscal,

ComprovantesNaoFiscais, LerTotaisComprovante, AchaCNFDescricao,

TestaPodeAbrirCupom,
Sangria, Suprimento, CortaPapel, AbreNaoFiscal,
RegistraItemNaoFiscal, SubtotalizaNaoFiscal, EfetuaPagamentoNaoFiscal,
FechaNaoFiscal, CancelaNaoFiscal, AbreGaveta, ImprimeCheque,
CancelaImpressaoCheque, MudaHorarioVerao, MudaArredondamento,
PreparaTEF, CorrigeEstadoErro, AbreRelatorioGerencial,
LinhaRelatorioGerencial, PulaLinhas, LinhaCupomVinculado, FechaRelatorio;

exports EnviaComando(cmd: AnsiString; var resp : pchar ) overload;
exports EnviaComando(cmd: AnsiString; lTimeOut: Integer; var resp : pchar ) overload;

exports LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean) overload;
exports LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False)  overload ;

exports LeituraMemoriaFiscalSerial(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean; const Linhas : pchar = nil) overload;
exports LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False; const Linhas : pchar = nil)  overload ;

end.
