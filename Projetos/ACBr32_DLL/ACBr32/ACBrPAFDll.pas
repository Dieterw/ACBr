unit ACBrPAFDll;

{$mode delphi}

interface

uses
  SysUtils,
  Classes,
  ACBrPAF,
  ACBrPAFClass,
  ACBrAACDLL,
  ACBrDevice,
  ACBrUtil;

{Classe que armazena os EventHandlers para o componente ACBr}
type TEventHandlers = class
    //procedure OnMsgPoucoPapel(Sender: TObject);
end;
{Handle para o componente TACBrECF }
type TPAFHandle = record
  UltimoErro : String;
  PAF : TACBrPAF;
  EventHandlers : TEventHandlers;
end;

{Records estilo C utilizados nas funções}
type TRegistroD1Rec = record
   RAZAOSOCIAL : array[0..50] of char;
   UF          : array[0..2] of char;
   CNPJ        : array[0..14] of char;
   IE          : array[0..14] of char;
   IM          : array[0..14] of char;
end;

type TRegistroD2Rec = record
   QTD_ITENS      : Integer;
   NUM_FAB        : array[0..20] of char;
   MF_ADICIONAL   : array[0..1] of char;
   TIPO_ECF       : array[0..7] of char;
   MARCA_ECF      : array[0..20] of char;
   MODELO_ECF     : array[0..20] of char;
   COO            : array[0..6] of char;
   NUM_DAV        : array[0..13] of char;
   DT_DAV         : Double;
   TIT_DAV        : array[0..30] of char;
   VLT_DAV        : Double;
   COO_DFV        : array[0..6] of char;
   NUMERO_ECF     : array[0..3] of char;
   NOME_CLIENTE   : array[0..40] of char;
   CPF_CNPJ       : array[0..14] of char;
   RegistroValido : Boolean;
end;

type TRegistroD3Rec = record
   DT_INCLUSAO    : double;
   NUM_ITEM       : Integer;
   COD_ITEM       : array[0..14] of char;
   DESC_ITEM      : array[0..100] of char;
   QTDE_ITEM      : Double;
   UNI_ITEM       : array[0..3] of char;
   VL_UNIT        : Double;
   VL_DESCTO      : Double;
   VL_ACRES       : Double;
   VL_TOTAL       : Double;
   DEC_VL_UNIT    : Integer;
   DEC_QTDE_ITEM  : Integer;
   SIT_TRIB       : array[0..1] of char;
   ALIQ           : Double;
   IND_CANC       : array[0..1] of char;
   RegistroValido : Boolean;
end;

type TRegistroP1Rec = record
   RAZAOSOCIAL      : array[0..50] of char;
   UF               : array[0..2] of char;
   CNPJ             : array[0..14] of char;
   IE               : array[0..14] of char;
   IM               : array[0..14] of char;
   InclusaoExclusao : Boolean;
end;

type TRegistroP2Rec = record
   COD_MERC_SERV  : array[0..14] of char;
   DESC_MERC_SERV : array[0..50] of char;
   UN_MED         : array[0..6] of char;
   IAT            : array[0..1] of char;
   IPPT           : array[0..1] of char;
   ST             : array[0..1] of char;
   ALIQ           : Double;
   VL_UNIT        : Double;
   RegistroValido : Boolean;
end;

{Ponteiro para o Handle }
type PPAFHandle = ^TPAFHandle;

implementation

{
PADRONIZAÇÃO DAS FUNÇÕES:

        PARÂMETROS:
        Todas as funções recebem o parâmetro "handle" que é o ponteiro
        para o componente instanciado; Este ponteiro deve ser armazenado
        pela aplicação que utiliza a DLL;

        RETORNO:
        Todas as funções da biblioteca retornam um Integer com as possíveis Respostas:

                MAIOR OU IGUAL A ZERO: SUCESSO
                Outos retornos maior que zero indicam sucesso, com valor específico de cada função.

                MENOR QUE ZERO: ERROS

                  -1 : Erro ao executar;
                       Vide UltimoErro

                  -2 : ACBr não inicializado.

                  Outros retornos negativos indicam erro específico de cada função;

                  A função "UltimoErro" retornará a mensagem da última exception disparada pelo componente.
}

{
CRIA um novo componente TACBrPAF retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplicação que utiliza a DLL e informado
em todas as chamadas de função relativas ao TACBrECF
}
Function PAF_Create(var pafHandle: PPAFHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  try

     New(pafHandle);

     pafHandle^.PAF := TACBrPAF.Create(nil);
     pafHandle^.EventHandlers := TEventHandlers.Create();
     Result := 0;
  except
     on exception : Exception do
     begin
        Result := -1;
        pafHandle^.UltimoErro := exception.Message;
     end
  end;

end;

{
DESTRÓI o objeto TACBrPAF e libera a memória utilizada.
Esta função deve SEMPRE ser chamada pela aplicação que utiliza a DLL
quando o componente não mais for utilizado.
}
Function PAF_Destroy(var pafHandle: PPAFHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try

    pafHandle^.PAF.Destroy();
    pafHandle^.PAF := nil;

    Dispose(pafHandle);
    pafHandle := nil;
    Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        pafHandle^.UltimoErro := exception.Message;
     end
  end;

end;

Function PAF_GetUltimoErro(const pafHandle: PPAFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try
     StrPLCopy(Buffer, pafHandle^.UltimoErro, BufferLen);
     Result := length(pafHandle^.UltimoErro);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

{ Funções mapeando as propriedades do componente }
Function PAF_GetPath(const pafHandle: PPAFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := pafHandle^.PAF.Path;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetPath(const pafHandle: PPAFHandle; const Path : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     pafHandle^.PAF.Path := Path;
     Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_GetDelimitador(const pafHandle: PPAFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := pafHandle^.PAF.Delimitador;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetDelimitador(const pafHandle: PPAFHandle; const Delimitador : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     pafHandle^.PAF.Delimitador := Delimitador;
     Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_GetCurMascara(const pafHandle: PPAFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := pafHandle^.PAF.CurMascara;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetCurMascara(const pafHandle: PPAFHandle; const CurMascara : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     pafHandle^.PAF.CurMascara := CurMascara;
     Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_GetTrimString(const pafHandle: PPAFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := pafHandle^.PAF.TrimString;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetTrimString(const pafHandle: PPAFHandle; const TrimString : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     pafHandle^.PAF.TrimString := CurMascara;
     Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetAAC(const pafHandle: PPAFHandle; const aacHandle : PAACHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if (aacHandle = nil) then
  begin
     pafHandle^.PAF.AAC := nil;
  end
  else
  begin

    try
       pafHandle^.PAF.AAC := aacHandle^.AAC;
       Result := 0;
    except on exception : Exception do
        begin
         ecfHandle^.UltimoErro := exception.Message;
         Result := -1;
         end
    end;
  end;
end;

{Gerar o arquivo de DAV’s emitidos}
Function PAF_SaveFileTXT_D(const pafHandle: PPAFHandle; const RegistroD1Rec : TRegistroD1Rec;
      const RegistroD2Rec : array of TRegistroD2Rec; const CountD2 : Integer; const RegistroD3Rec: array of TRegistroD3Rec; const Arquivo: pChar) : Integer ;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i, IndexItem, D: Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountD2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de DAVs não pode ser Zero';
     Result := -1;
  end;

  try
   IndexItem := o;
   pafHandle^.PAF.PAF_D.RegistroD1.RAZAOSOCIAL  := RegistroD1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_D.RegistroD1.UF           := RegistroD1Rec.UF;
   pafHandle^.PAF.PAF_D.RegistroD1.CNPJ         := RegistroD1Rec.CNPJ;
   pafHandle^.PAF.PAF_D.RegistroD1.IE           := RegistroD1Rec.IE;
   pafHandle^.PAF.PAF_D.RegistroD1.IM           := RegistroD1Rec.IM;
   for i := 0 to CountD2 do
   begin
       with pafHandle^.PAF.PAF_D.RegistroD2.New do
       begin
         NUM_FAB        := RegistroD2Rec[i].NUM_FAB;
         MF_ADICIONAL   := RegistroD2Rec[i].MF_ADICIONAL;
         TIPO_ECF       := RegistroD2Rec[i].TIPO_ECF;
         MARCA_ECF      := RegistroD2Rec[i].MARCA_ECF;
         MODELO_ECF     := RegistroD2Rec[i].MODELO_ECF;
         COO            := RegistroD2Rec[i].COO;
         NUM_DAV        := RegistroD2Rec[i].NUM_DAV;
         DT_DAV         := RegistroD2Rec[i].DT_DAV;
         TIT_DAV        := RegistroD2Rec[i].TIT_DAV;
         VLT_DAV        := RegistroD2Rec[i].VLT_DAV;
         COO_DFV        := RegistroD2Rec[i].COO_DFV;
         NUMERO_ECF     := RegistroD2Rec[i].NUMERO_ECF;
         NOME_CLIENTE   := RegistroD2Rec[i].NOME_CLIENTE;
         CPF_CNPJ       := RegistroD2Rec[i].CPF_CNPJ;
         RegistroValido := RegistroD2Rec[i].RegistroValido;

         if RegistroD2Rec[i].QTD_ITENS < 1 then
         begin
            pafHandle^.PAF.PAF_D.RegistroD2.Free;
            pafHandle^.PAF.PAF_D.RegistroD1.Free;
            pafHandle^.UltimoErro := 'O numero de itens nas DAVs não pode ser Zero';
            Result := -1;
         end;

         for D := 0 to RegistroD2Rec[i].QTD_ITENS do
         begin
         // adicionar os itens do dav, um para cada item
         with RegistroD3.New do
         begin
           DT_INCLUSAO    := RegistroD3Rec[IndexItem].DT_INCLUSAO;
           NUM_ITEM       := RegistroD3Rec[IndexItem].NUM_ITEM;
           COD_ITEM       := RegistroD3Rec[IndexItem].COD_ITEM;
           DESC_ITEM      := RegistroD3Rec[IndexItem].DESC_ITEM;
           QTDE_ITEM      := RegistroD3Rec[IndexItem].QTDE_ITEM;
           UNI_ITEM       := RegistroD3Rec[IndexItem].UNI_ITEM;
           VL_UNIT        := RegistroD3Rec[IndexItem].VL_UNIT;
           VL_DESCTO      := RegistroD3Rec[IndexItem].VL_DESCTO;
           VL_ACRES       := RegistroD3Rec[IndexItem].VL_ACRES;
           VL_TOTAL       := RegistroD3Rec[IndexItem].VL_TOTAL;
           DEC_VL_UNIT    := RegistroD3Rec[IndexItem].DEC_VL_UNIT;
           DEC_QTDE_ITEM  := RegistroD3Rec[IndexItem].DEC_QTDE_ITEM;
           SIT_TRIB       := RegistroD3Rec[IndexItem].SIT_TRIB;
           ALIQ           := RegistroD3Rec[IndexItem].ALIQ;
           IND_CANC       := RegistroD3Rec[IndexItem].IND_CANC;
           RegistroValido := RegistroD3Rec[IndexItem].RegistroValido;
         end;
         inc(IndexItem);
         end;
       end;
   end;
  end;
  pafHandle^.PAF.SaveFileTXT_D(Arquivo);
  Result := 0;
  except
  on exception : Exception do
  begin
  pafHandle^.UltimoErro := exception.Message;
  pafHandle^.PAF.PAF_D.LimpaRegistros;
  Result := -1;
  end;
end;

Function PAF_SaveFileTXT_P(const pafHandle: PPAFHandle; const RegistroP1Rec : TRegistroP1Rec;
      const RegistroP2Rec : array of TRegistroP2Rec; const CountP2 : Integer; const Arquivo: pChar) : Integer ;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i : Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountD2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Itens não pode ser Zero';
     Result := -1;
  end;

  try

   pafHandle^.PAF.PAF_P.RegistroP1.RAZAOSOCIAL      := RegistroP1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_P.RegistroP1.UF               := RegistroP1Rec.UF;
   pafHandle^.PAF.PAF_P.RegistroP1.CNPJ             := RegistroP1Rec.CNPJ;
   pafHandle^.PAF.PAF_P.RegistroP1.IE               := RegistroP1Rec.IE;
   pafHandle^.PAF.PAF_P.RegistroP1.IM               := RegistroP1Rec.IM;
   pafHandle^.PAF.PAF_P.RegistroP1.InclusaoExclusao := RegistroP1Rec.InclusaoExclusao;

   for i := 0 to CountP2 do
   begin
   with pafHandle^.PAF.RegistroP2.New do
   begin
   COD_MERC_SERV  := RegistroP2Rec[i].COD_MERC_SERV;
   DESC_MERC_SERV := RegistroP2Rec[i].DESC_MERC_SERV;
   UN_MED         := RegistroP2Rec[i].UN_MED;
   IAT            := RegistroP2Rec[i].IAT;
   IPPT           := RegistroP2Rec[i].IPPT;
   ST             := RegistroP2Rec[i].ST;
   ALIQ           := RegistroP2Rec[i].ALIQ;
   VL_UNIT        := RegistroP2Rec[i].VL_UNIT;
   RegistroValido := RegistroP2Rec[i].RegistroValido;
   end;
   end;

   pafHandle^.PAF.SaveFileTXT_P(Arquivo);
   Result := 0;
  except
  on exception : Exception do
  begin
  pafHandle^.UltimoErro := exception.Message;
  pafHandle^.PAF.PAF_P.LimpaRegistros;
  Result := -1;
  end
  end;
end;

exports

{ Funções }

PAF_Create,
PAF_Destroy,
PAF_GetUltimoErro,

{ Propriedades Componente }
PAF_GetPath, PAF_SetPath,
PAF_GetDelimitador, PAF_SetDelimitador,
PAF_GetCurMascara, PAF_SetCurMascara,
PAF_GetTrimString, PAF_SetTrimString,
PAF_SetAAC,

{DAV D}
PAF_SaveFileTXT_D, PAF_SaveFileTXT_P;

end.

