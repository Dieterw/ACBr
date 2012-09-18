unit ACBrPAFDll;

interface

uses
  SysUtils,
  Classes,
  ACBrPAF,
  ACBrAACDLL,
  ACBrEADDLL,
  ACBrUtil;

{Classe que armazena os EventHandlers para o componente ACBr}
type TEventHandlers = class

end;

{Handle para o componente TACBrECF }
type TPAFHandle = record
  UltimoErro : String;
  PAF : TACBrPAF;
  EventHandlers : TEventHandlers;
end;

{Ponteiro para o Handle }
type PPAFHandle = ^TPAFHandle;

{Records estilo C utilizados nas funções}
type TRegistroHD1Rec = record
   RAZAOSOCIAL      : array[0..50] of char;
   UF               : array[0..2] of char;
   CNPJ             : array[0..14] of char;
   IE               : array[0..14] of char;
   IM               : array[0..14] of char;
end;

type TRegistroHD2Rec = record
   RAZAOSOCIAL      : array[0..50] of char;
   UF               : array[0..2] of char;
   CNPJ             : array[0..14] of char;
   IE               : array[0..14] of char;
   IM               : array[0..14] of char;
   NUM_FAB          : array[0..20] of char;
   MF_ADICIONAL     : array[0..1] of char;
   TIPO_ECF         : array[0..7] of char;
   MARCA_ECF        : array[0..20] of char;
   MODELO_ECF       : array[0..20] of char;
   DT_EST           : Double;
   InclusaoExclusao : Boolean;
   RegistroValido   : Boolean;
end;

type TregistroC2Rec = record
   ID_ABASTECIMENTO      : array[0..15] of char;
   TANQUE                : array[0..3] of char;
   BOMBA                 : array[0..3] of char;
   BICO                  : array[0..3] of char;
   COMBUSTIVEL           : array[0..20] of char;
   DATA_ABASTECIMENTO    : Double;
   HORA_ABASTECIMENTO    : Double;
   ENCERRANTE_INICIAL    : Double;
   ENCERRANTE_FINAL      : Double;
   STATUS_ABASTECIMENTO  : array[0..10] of char;
   NRO_SERIE_ECF         : array[0..14] of char;
   DATA                  : Double;
   HORA                  : Double;
   COO                   : Integer;
   NRO_NOTA_FISCAL       : Integer;
   VOLUME                : Double;
   RegistroValido        : Boolean;
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

type TRegistroD2Rec = record
   QTD_D3         : Integer;
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

type TRegistroE2Rec = record
   COD_MERC       : array[0..14] of char;
   DESC_MERC      : array[0..50] of char;
   UN_MED         : array[0..6] of char;
   QTDE_EST       : Double;
   RegistroValido : Boolean;
end;

type TRegistroH2Rec = record
    CNPJ_CRED_CARTAO : array[0..14] of char;
    COO              : Integer;
    CCF              : Integer;
    VLR_TROCO        : Double;
    DT_TROCO         : Double;
    CPF              : array[0..14] of char;
    Titulo           : array[0..7] of char;
    RegistroValido   : boolean;
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

type TRegistroR1Rec = record
   NUM_FAB          : array[0..20] of char;
   MF_ADICIONAL     : array[0..1] of char;
   TIPO_ECF         : array[0..7] of char;
   MARCA_ECF        : array[0..20] of char;
   MODELO_ECF       : array[0..20] of char;
   VERSAO_SB        : array[0..10] of char;
   DT_INST_SB       : Double;
   HR_INST_SB       : Double;
   NUM_SEQ_ECF      : Integer;
   CNPJ             : array[0..14] of char;
   IE               : array[0..14] of char;
   CNPJ_SH          : array[0..14] of char;
   IE_SH            : array[0..14] of char;
   IM_SH            : array[0..14] of char;
   NOME_SH          : array[0..40] of char;
   NOME_PAF         : array[0..40] of char;
   VER_PAF          : array[0..10] of char;
   COD_MD5          : array[0..32] of char;
   DT_INI           : Double;
   DT_FIN           : Double;
   ER_PAF_ECF       : array[0..4] of char;
   InclusaoExclusao : Boolean;
   RegistroValido   : Boolean;
end;

type TRegistroR2Rec = record
    QTD_R3         : integer;
    NUM_USU        : integer;
    CRZ            : integer;
    COO            : integer;
    CRO            : integer;
    DT_MOV         : Double;
    DT_EMI         : Double;
    HR_EMI         : Double;
    VL_VBD         : Double;
    PAR_ECF        : array[0..1] of char;
    RegistroValido : boolean;
end;

type TRegistroR3Rec = record
    TOT_PARCIAL    : array[0..7] of char;
    VL_ACUM        : Double;
    RegistroValido : boolean;
end;

type TRegistroR4Rec = record
    QTD_R5         : integer;
    QTD_R7         : integer;
    NUM_USU        : integer;
    NUM_CONT       : integer;
    COO            : integer;
    DT_INI         : Double;
    SUB_DOCTO      : Double;
    SUB_DESCTO     : Double;
    TP_DESCTO      : array[0..1] of char;
    SUB_ACRES      : Double;
    TP_ACRES       : array[0..1] of char;
    VL_TOT         : Double;
    CANC           : array[0..1] of char;
    VL_CA          : Double;
    ORDEM_DA       : array[0..1] of char;
    NOME_CLI       : array[0..40] of char;
    CNPJ_CPF      : array[0..14] of char;
    RegistroValido : boolean;
end;

type TRegistroR5Rec = record
    NUM_ITEM       : integer;
    COD_ITEM       : array[0..14] of char;
    DESC_ITEM      : array[0..100] of char;
    QTDE_ITEM      : double;
    UN_MED         : array[0..3] of char;
    VL_UNIT        : double;
    DESCTO_ITEM    : double;
    ACRES_ITEM     : double;
    VL_TOT_ITEM    : double;
    COD_TOT_PARC   : array[0..7] of char;
    IND_CANC       : array[0..1] of char;
    QTDE_CANC      : double;
    VL_CANC        : double;
    VL_CANC_ACRES  : double;
    IAT            : array[0..1] of char;
    IPPT           : array[0..1] of char;
    QTDE_DECIMAL   : integer;
    VL_DECIMAL     : integer;
    RegistroValido : boolean;
end;

type TRegistroR6Rec = record
    QTD_R7         : integer;
    NUM_USU        : integer;
    COO            : integer;
    GNF            : integer;
    GRG            : integer;
    CDC            : integer;
    DENOM          : array[0..2] of char;
    DT_FIN         : double;
    HR_FIN         : double;
    RegistroValido : boolean;
end;

type TRegistroR7Rec = record
    CCF            : integer;
    GNF            : integer;
    MP             : array[0..15] of char;
    VL_PAGTO       : double;
    IND_EST        : array[0..1] of char;
    VL_EST         : double;
    RegistroValido : boolean;
end;

type TRegistroT2Rec = record
   DT_MOV         : Double;
   TP_DOCTO       : array[0..10] of char;
   SERIE          : array[0..2] of char;
   NUM_BILH_I     : integer;
   NUM_BILH_F     : integer;
   NUM_ECF        : array[0..20] of char;
   CRZ            : integer;
   CFOP           : array[0..4] of char;
   VL_CONT        : Double;
   VL_BASECALC    : Double;
   ALIQ           : Double;
   VL_IMPOSTO     : Double;
   VL_ISENTAS     : Double;
   VL_OUTRAS      : Double;
   RegistroValido : boolean;
end;
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
em todas as chamadas de função relativas ao TACBrPAF.
}
Function PAF_Create(var pafHandle: PPAFHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  try

     New(pafHandle);
     pafHandle^.PAF := TACBrPAF.Create(nil);
     pafHandle^.EventHandlers := TEventHandlers.Create();
     pafHandle^.UltimoErro:= '';
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

Function PAF_GetTrimString(const pafHandle: PPAFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     Result := Integer(pafHandle^.PAF.TrimString);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetTrimString(const pafHandle: PPAFHandle; const TrimString : Boolean) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     pafHandle^.PAF.TrimString := TrimString;
     Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_GetAssinarArquivo(const pafHandle: PPAFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     Result := Integer(pafHandle^.PAF.AssinarArquivo);
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function PAF_SetAssinarArquivo(const pafHandle: PPAFHandle; const Assinar : Boolean) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     pafHandle^.PAF.AssinarArquivo:= Assinar;
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
         pafHandle^.UltimoErro := exception.Message;
         Result := -1;
         end
    end;
  end;
end;

Function PAF_SetEAD(const pafHandle: PPAFHandle; const eadHandle : PEADHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if (eadHandle = nil) then
  begin
     pafHandle^.PAF.EAD := nil;
  end
  else
  begin

    try
       pafHandle^.PAF.EAD := eadHandle^.EAD;
       Result := 0;
    except on exception : Exception do
        begin
         pafHandle^.UltimoErro := exception.Message;
         Result := -1;
         end
    end;
  end;
end;

{Salvar arquivos PAF}
Function PAF_SaveFileTXT_C(const pafHandle: PPAFHandle; const RegistroC1Rec : TRegistroHD1Rec;
      const RegistroC2Rec : array of TRegistroC2Rec; const CountC2 : Integer; const Arquivo: pChar) : Integer ;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i : Integer;
  OldMask:string;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountC2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Itens não pode ser Zero';
     Result := -1;
     Exit;
  end;

  try
   pafHandle^.PAF.PAF_C.RegistroC1.RAZAOSOCIAL := RegistroC1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_C.RegistroC1.UF          := RegistroC1Rec.UF;
   pafHandle^.PAF.PAF_C.RegistroC1.CNPJ        := RegistroC1Rec.CNPJ;
   pafHandle^.PAF.PAF_C.RegistroC1.IE          := RegistroC1Rec.IE;
   pafHandle^.PAF.PAF_C.RegistroC1.IM          := RegistroC1Rec.IM;

   pafHandle^.PAF.PAF_C.RegistroC2.Clear;

   for i := 0 to CountC2 - 1 do
   begin
   with pafHandle^.PAF.PAF_C.RegistroC2.New do
   begin
   ID_ABASTECIMENTO      := RegistroC2Rec[i].ID_ABASTECIMENTO;
   TANQUE                := RegistroC2Rec[i].TANQUE;
   BOMBA                 := RegistroC2Rec[i].BOMBA;
   BICO                  := RegistroC2Rec[i].BICO;
   COMBUSTIVEL           := RegistroC2Rec[i].COMBUSTIVEL;
   DATA_ABASTECIMENTO    := RegistroC2Rec[i].DATA_ABASTECIMENTO;
   HORA_ABASTECIMENTO    := RegistroC2Rec[i].HORA_ABASTECIMENTO;
   ENCERRANTE_INICIAL    := RegistroC2Rec[i].ENCERRANTE_INICIAL;
   ENCERRANTE_FINAL      := RegistroC2Rec[i].ENCERRANTE_FINAL;
   STATUS_ABASTECIMENTO  := RegistroC2Rec[i].STATUS_ABASTECIMENTO;
   NRO_SERIE_ECF         := RegistroC2Rec[i].NRO_SERIE_ECF;
   DATA                  := RegistroC2Rec[i].DATA;
   HORA                  := RegistroC2Rec[i].HORA;
   COO                   := RegistroC2Rec[i].COO;
   NRO_NOTA_FISCAL       := RegistroC2Rec[i].NRO_NOTA_FISCAL;
   VOLUME                := RegistroC2Rec[i].VOLUME;
   RegistroValido        := RegistroC2Rec[i].RegistroValido;
   end;
   end;

   OldMask := pafHandle^.PAF.CurMascara;
   pafHandle^.PAF.CurMascara := '';
   pafHandle^.PAF.SaveFileTXT_C(Arquivo);
   pafHandle^.PAF.CurMascara := OldMask;
   Result := 0;
  except
  on exception : Exception do
  begin
  pafHandle^.UltimoErro := exception.Message;
  pafHandle^.PAF.PAF_C.LimpaRegistros;
  Result := -1;
  end
  end;
end;

Function PAF_SaveFileTXT_D(const pafHandle: PPAFHandle; const RegistroD1Rec : TRegistroHD1Rec;
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
     Exit;
  end;

  try
   IndexItem := 0;
   pafHandle^.PAF.PAF_D.RegistroD1.RAZAOSOCIAL  := RegistroD1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_D.RegistroD1.UF           := RegistroD1Rec.UF;
   pafHandle^.PAF.PAF_D.RegistroD1.CNPJ         := RegistroD1Rec.CNPJ;
   pafHandle^.PAF.PAF_D.RegistroD1.IE           := RegistroD1Rec.IE;
   pafHandle^.PAF.PAF_D.RegistroD1.IM           := RegistroD1Rec.IM;

   pafHandle^.PAF.PAF_D.RegistroD2.Clear;

   for i := 0 to CountD2 - 1 do
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

         if RegistroD2Rec[i].QTD_D3 < 1 then
         begin
            pafHandle^.PAF.PAF_D.LimpaRegistros;
            pafHandle^.UltimoErro := 'O numero de itens nas DAVs não pode ser Zero';
            Result := -1;
         end;

         for D := 0 to RegistroD2Rec[i].QTD_D3 - 1 do
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
  pafHandle^.PAF.SaveFileTXT_D(Arquivo);
  Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        pafHandle^.PAF.PAF_D.LimpaRegistros;
        Result := -1;
     end
  end;
end;

Function PAF_SaveFileTXT_E(const pafHandle: PPAFHandle; const RegistroE1Rec : TRegistroHD2Rec;
      const RegistroE2Rec : array of TRegistroE2Rec; const CountE2 : Integer; const Arquivo: pChar) : Integer;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i : Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountE2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Itens não pode ser Zero';
     Result := -1;
     Exit;
  end;

  try
   pafHandle^.PAF.PAF_E.RegistroE1.RAZAOSOCIAL      := RegistroE1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_E.RegistroE1.UF               := RegistroE1Rec.UF;
   pafHandle^.PAF.PAF_E.RegistroE1.CNPJ             := RegistroE1Rec.CNPJ;
   pafHandle^.PAF.PAF_E.RegistroE1.IE               := RegistroE1Rec.IE;
   pafHandle^.PAF.PAF_E.RegistroE1.IM               := RegistroE1Rec.IM;
   pafHandle^.PAF.PAF_E.RegistroE1.NUM_FAB          := RegistroE1Rec.NUM_FAB;
   pafHandle^.PAF.PAF_E.RegistroE1.MF_ADICIONAL     := RegistroE1Rec.MF_ADICIONAL;
   pafHandle^.PAF.PAF_E.RegistroE1.TIPO_ECF         := RegistroE1Rec.TIPO_ECF;
   pafHandle^.PAF.PAF_E.RegistroE1.MARCA_ECF        := RegistroE1Rec.MARCA_ECF;
   pafHandle^.PAF.PAF_E.RegistroE1.MODELO_ECF       := RegistroE1Rec.MODELO_ECF;
   pafHandle^.PAF.PAF_E.RegistroE1.DT_EST           := RegistroE1Rec.DT_EST;
   pafHandle^.PAF.PAF_E.RegistroE1.RegistroValido   := RegistroE1Rec.RegistroValido;
   pafHandle^.PAF.PAF_E.RegistroE1.InclusaoExclusao := RegistroE1Rec.InclusaoExclusao;

   pafHandle^.PAF.PAF_E.RegistroE2.Clear;

   for i := 0 to CountE2 - 1 do
   begin
   with pafHandle^.PAF.PAF_E.RegistroE2.New do
   begin
      COD_MERC       := RegistroE2Rec[i].COD_MERC;
      DESC_MERC      := RegistroE2Rec[i].DESC_MERC;
      UN_MED         := RegistroE2Rec[i].UN_MED;
      QTDE_EST       := RegistroE2Rec[i].QTDE_EST;
      RegistroValido := RegistroE2Rec[i].RegistroValido;
   end;
   end;

   pafHandle^.PAF.SaveFileTXT_E(Arquivo);
   Result := 0;
  except
  on exception : Exception do
  begin
  pafHandle^.UltimoErro := exception.Message;
  pafHandle^.PAF.PAF_E.LimpaRegistros;
  Result := -1;
  end
  end;
end;

Function PAF_SaveFileTXT_H(const pafHandle: PPAFHandle; const RegistroH1Rec : TRegistroHD2Rec;
      const RegistroH2Rec : array of TRegistroH2Rec; const CountH2 : Integer; const Arquivo: pChar) : Integer;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i : Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountH2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Itens não pode ser Zero';
     Result := -1;
     Exit;
  end;

  try
   pafHandle^.PAF.PAF_H.RegistroH1.RAZAOSOCIAL      := RegistroH1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_H.RegistroH1.UF               := RegistroH1Rec.UF;
   pafHandle^.PAF.PAF_H.RegistroH1.CNPJ             := RegistroH1Rec.CNPJ;
   pafHandle^.PAF.PAF_H.RegistroH1.IE               := RegistroH1Rec.IE;
   pafHandle^.PAF.PAF_H.RegistroH1.IM               := RegistroH1Rec.IM;
   pafHandle^.PAF.PAF_H.RegistroH1.NUM_FAB          := RegistroH1Rec.NUM_FAB;
   pafHandle^.PAF.PAF_H.RegistroH1.MF_ADICIONAL     := RegistroH1Rec.MF_ADICIONAL;
   pafHandle^.PAF.PAF_H.RegistroH1.TIPO_ECF         := RegistroH1Rec.TIPO_ECF;
   pafHandle^.PAF.PAF_H.RegistroH1.MARCA_ECF        := RegistroH1Rec.MARCA_ECF;
   pafHandle^.PAF.PAF_H.RegistroH1.MODELO_ECF       := RegistroH1Rec.MODELO_ECF;
   pafHandle^.PAF.PAF_H.RegistroH1.DT_EST           := RegistroH1Rec.DT_EST;
   pafHandle^.PAF.PAF_H.RegistroH1.RegistroValido   := RegistroH1Rec.RegistroValido;
   pafHandle^.PAF.PAF_H.RegistroH1.InclusaoExclusao := RegistroH1Rec.InclusaoExclusao;

   pafHandle^.PAF.PAF_H.RegistroH2.Clear;

   for i := 0 to CountH2 - 1 do
   begin
   with pafHandle^.PAF.PAF_H.RegistroH2.New do
   begin
   RegistroValido   := RegistroH2Rec[i].RegistroValido;
   CNPJ_CRED_CARTAO := RegistroH2Rec[i].CNPJ_CRED_CARTAO;
   COO              := RegistroH2Rec[i].COO;
   CCF              := RegistroH2Rec[i].CCF;
   VLR_TROCO        := RegistroH2Rec[i].VLR_TROCO;
   DT_TROCO         := RegistroH2Rec[i].DT_TROCO;
   CPF              := RegistroH2Rec[i].CPF;
   Titulo           := RegistroH2Rec[i].Titulo;
   end;
   end;

   pafHandle^.PAF.SaveFileTXT_H(Arquivo);
   Result := 0;
  except
  on exception : Exception do
  begin
  pafHandle^.UltimoErro := exception.Message;
  pafHandle^.PAF.PAF_H.LimpaRegistros;
  Result := -1;
  end
  end;
end;

Function PAF_SaveFileTXT_P(const pafHandle: PPAFHandle; const RegistroP1Rec : TRegistroHD1Rec;
      const RegistroP2Rec : array of TRegistroP2Rec; const CountP2 : Integer; const Arquivo: pChar) : Integer;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i : Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountP2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Itens não pode ser Zero';
     Result := -1;
     Exit;
  end;

  try
   pafHandle^.PAF.PAF_P.RegistroP1.RAZAOSOCIAL      := RegistroP1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_P.RegistroP1.UF               := RegistroP1Rec.UF;
   pafHandle^.PAF.PAF_P.RegistroP1.CNPJ             := RegistroP1Rec.CNPJ;
   pafHandle^.PAF.PAF_P.RegistroP1.IE               := RegistroP1Rec.IE;
   pafHandle^.PAF.PAF_P.RegistroP1.IM               := RegistroP1Rec.IM;

   pafHandle^.PAF.PAF_P.RegistroP2.Clear;

   for i := 0 to CountP2 - 1 do
   begin
   with pafHandle^.PAF.PAF_P.RegistroP2.New do
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

Function PAF_SaveFileTXT_R(const pafHandle: PPAFHandle; const RegistroR1Rec : TRegistroR1Rec;
      const RegistroR2Rec : array of TRegistroR2Rec; const CountR2 : Integer; const RegistroR3Rec: array of TRegistroR3Rec;
      const RegistroR4Rec: array of TRegistroR4Rec; const CountR4 : Integer; const RegistroR5Rec: array of TRegistroR5Rec;
      const RegistroR6Rec: array of TRegistroR6Rec; const CountR6 : Integer; const RegistroR7Rec: array of TRegistroR7Rec; const Arquivo: pChar) : Integer ;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i, D, IndexR3, IndexR5, IndexR7: Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountR2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Registros não pode ser Zero';
     Result := -1;
     Exit;
  end;

  if(CountR4 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Registros não pode ser Zero';
     Result := -1;
     Exit;
  end;

  if(CountR6 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Registros não pode ser Zero';
     Result := -1;
     Exit;
  end;

  try
   IndexR3 := 0;
   IndexR5 := 0;
   IndexR7 := 0;
   pafHandle^.PAF.PAF_R.LimpaRegistros;

   pafHandle^.PAF.PAF_R.RegistroR01.NUM_FAB          := RegistroR1Rec.NUM_FAB;
   pafHandle^.PAF.PAF_R.RegistroR01.MF_ADICIONAL     := RegistroR1Rec.MF_ADICIONAL;
   pafHandle^.PAF.PAF_R.RegistroR01.TIPO_ECF         := RegistroR1Rec.TIPO_ECF;
   pafHandle^.PAF.PAF_R.RegistroR01.MARCA_ECF        := RegistroR1Rec.MARCA_ECF;
   pafHandle^.PAF.PAF_R.RegistroR01.MODELO_ECF       := RegistroR1Rec.MODELO_ECF;
   pafHandle^.PAF.PAF_R.RegistroR01.VERSAO_SB        := RegistroR1Rec.VERSAO_SB;
   pafHandle^.PAF.PAF_R.RegistroR01.DT_INST_SB       := RegistroR1Rec.DT_INST_SB;
   pafHandle^.PAF.PAF_R.RegistroR01.HR_INST_SB       := RegistroR1Rec.HR_INST_SB;
   pafHandle^.PAF.PAF_R.RegistroR01.NUM_SEQ_ECF      := RegistroR1Rec.NUM_SEQ_ECF;
   pafHandle^.PAF.PAF_R.RegistroR01.CNPJ             := RegistroR1Rec.CNPJ;
   pafHandle^.PAF.PAF_R.RegistroR01.IE               := RegistroR1Rec.IE;
   pafHandle^.PAF.PAF_R.RegistroR01.CNPJ_SH          := RegistroR1Rec.CNPJ_SH;
   pafHandle^.PAF.PAF_R.RegistroR01.IE_SH            := RegistroR1Rec.IE_SH;
   pafHandle^.PAF.PAF_R.RegistroR01.IM_SH            := RegistroR1Rec.IM_SH;
   pafHandle^.PAF.PAF_R.RegistroR01.NOME_SH          := RegistroR1Rec.NOME_SH;
   pafHandle^.PAF.PAF_R.RegistroR01.NOME_PAF         := RegistroR1Rec.NOME_PAF;
   pafHandle^.PAF.PAF_R.RegistroR01.VER_PAF          := RegistroR1Rec.VER_PAF;
   pafHandle^.PAF.PAF_R.RegistroR01.COD_MD5          := RegistroR1Rec.COD_MD5;
   pafHandle^.PAF.PAF_R.RegistroR01.DT_INI           := RegistroR1Rec.DT_INI;
   pafHandle^.PAF.PAF_R.RegistroR01.DT_FIN           := RegistroR1Rec.DT_FIN;
   pafHandle^.PAF.PAF_R.RegistroR01.ER_PAF_ECF       := RegistroR1Rec.ER_PAF_ECF;
   pafHandle^.PAF.PAF_R.RegistroR01.InclusaoExclusao := RegistroR1Rec.InclusaoExclusao;
   pafHandle^.PAF.PAF_R.RegistroR01.RegistroValido   := RegistroR1Rec.RegistroValido;

   //Registro R2 e R3
   for i := 0 to CountR2 - 1 do
   begin
       with pafHandle^.PAF.PAF_R.RegistroR02.New do
       begin
       NUM_USU        := RegistroR2Rec[i].NUM_USU;
       CRZ            := RegistroR2Rec[i].CRZ;
       COO            := RegistroR2Rec[i].COO;
       CRO            := RegistroR2Rec[i].CRO;
       DT_MOV         := RegistroR2Rec[i].DT_MOV;
       DT_EMI         := RegistroR2Rec[i].DT_EMI;
       HR_EMI         := RegistroR2Rec[i].HR_EMI;
       VL_VBD         := RegistroR2Rec[i].VL_VBD;
       PAR_ECF        := RegistroR2Rec[i].PAR_ECF;
       RegistroValido := RegistroR2Rec[i].RegistroValido;

         if RegistroR2Rec[i].QTD_R3 < 1 then
         begin
            pafHandle^.PAF.PAF_R.LimpaRegistros;
            pafHandle^.UltimoErro := 'O numero de itens no registro R3 não pode ser Zero';
            Result := -1;
         end;

         for D := 0 to RegistroR2Rec[i].QTD_R3 - 1 do
         begin
         with RegistroR03.New do
         begin
         TOT_PARCIAL    := RegistroR3Rec[IndexR3].TOT_PARCIAL;
         VL_ACUM        := RegistroR3Rec[IndexR3].VL_ACUM;
         RegistroValido := RegistroR3Rec[IndexR3].RegistroValido;
         end;
         inc(IndexR3);
         end;
       end;
   end;

   //Registro R4, R5 e R7
   for i := 0 to CountR4 - 1 do
   begin
       with pafHandle^.PAF.PAF_R.RegistroR04.New do
       begin
       NUM_USU        :=  RegistroR4Rec[i].NUM_USU;
       NUM_CONT       :=  RegistroR4Rec[i].NUM_CONT;
       COO            :=  RegistroR4Rec[i].COO;
       DT_INI         :=  RegistroR4Rec[i].DT_INI;
       SUB_DOCTO      :=  RegistroR4Rec[i].SUB_DOCTO;
       SUB_DESCTO     :=  RegistroR4Rec[i].SUB_DESCTO;
       TP_DESCTO      :=  RegistroR4Rec[i].TP_DESCTO;
       SUB_ACRES      :=  RegistroR4Rec[i].SUB_ACRES;
       TP_ACRES       :=  RegistroR4Rec[i].TP_ACRES;
       VL_TOT         :=  RegistroR4Rec[i].VL_TOT;
       CANC           :=  RegistroR4Rec[i].CANC;
       VL_CA          :=  RegistroR4Rec[i].VL_CA;
       ORDEM_DA       :=  RegistroR4Rec[i].ORDEM_DA;
       NOME_CLI       :=  RegistroR4Rec[i].NOME_CLI;
       CNPJ_CPF       :=  RegistroR4Rec[i].CNPJ_CPF;
       RegistroValido :=  RegistroR4Rec[i].RegistroValido;

         if RegistroR4Rec[i].QTD_R5 < 1 then
         begin
            pafHandle^.PAF.PAF_R.LimpaRegistros;
            pafHandle^.UltimoErro := 'O numero de itens no registro R5 não pode ser Zero';
            Result := -1;
         end;

         for D := 0 to RegistroR4Rec[i].QTD_R5 - 1 do
         begin
         with RegistroR05.New do
         begin
         NUM_ITEM       := RegistroR5Rec[IndexR5].NUM_ITEM;
         COD_ITEM       := RegistroR5Rec[IndexR5].COD_ITEM;
         DESC_ITEM      := RegistroR5Rec[IndexR5].DESC_ITEM;
         QTDE_ITEM      := RegistroR5Rec[IndexR5].QTDE_ITEM;
         UN_MED         := RegistroR5Rec[IndexR5].UN_MED;
         VL_UNIT        := RegistroR5Rec[IndexR5].VL_UNIT;
         DESCTO_ITEM    := RegistroR5Rec[IndexR5].DESCTO_ITEM;
         ACRES_ITEM     := RegistroR5Rec[IndexR5].ACRES_ITEM;
         VL_TOT_ITEM    := RegistroR5Rec[IndexR5].VL_TOT_ITEM;
         COD_TOT_PARC   := RegistroR5Rec[IndexR5].COD_TOT_PARC;
         IND_CANC       := RegistroR5Rec[IndexR5].IND_CANC;
         QTDE_CANC      := RegistroR5Rec[IndexR5].QTDE_CANC;
         VL_CANC        := RegistroR5Rec[IndexR5].VL_CANC;
         VL_CANC_ACRES  := RegistroR5Rec[IndexR5].VL_CANC_ACRES;
         IAT            := RegistroR5Rec[IndexR5].IAT;
         IPPT           := RegistroR5Rec[IndexR5].IPPT;
         QTDE_DECIMAL   := RegistroR5Rec[IndexR5].QTDE_DECIMAL;
         VL_DECIMAL     := RegistroR5Rec[IndexR5].VL_DECIMAL;
         RegistroValido := RegistroR5Rec[IndexR5].RegistroValido;
         end;
         inc(IndexR5);
         end;

         for D := 0 to RegistroR4Rec[i].QTD_R7 - 1 do
         begin
         with RegistroR07.New do
         begin
         CCF            := RegistroR7Rec[IndexR7].CCF;
         GNF            := RegistroR7Rec[IndexR7].GNF;
         MP             := RegistroR7Rec[IndexR7].MP;
         VL_PAGTO       := RegistroR7Rec[IndexR7].VL_PAGTO;
         IND_EST        := RegistroR7Rec[IndexR7].IND_EST;
         VL_EST         := RegistroR7Rec[IndexR7].VL_EST;
         RegistroValido := RegistroR7Rec[IndexR7].RegistroValido;
         end;
         inc(IndexR7);
         end;

       end;
   end;

   //Registro R6 e R7
   for i := 0 to CountR6 - 1 do
   begin
       with pafHandle^.PAF.PAF_R.RegistroR06.New do
       begin
       NUM_USU        := RegistroR6Rec[i].NUM_USU;
       COO            := RegistroR6Rec[i].COO;
       GNF            := RegistroR6Rec[i].GNF;
       GRG            := RegistroR6Rec[i].GRG;
       CDC            := RegistroR6Rec[i].CDC;
       DENOM          := RegistroR6Rec[i].DENOM;
       DT_FIN         := RegistroR6Rec[i].DT_FIN;
       HR_FIN         := RegistroR6Rec[i].HR_FIN;
       RegistroValido := RegistroR6Rec[i].RegistroValido;

         if RegistroR6Rec[i].QTD_R7 < 1 then
         begin
            pafHandle^.PAF.PAF_R.LimpaRegistros;
            pafHandle^.UltimoErro := 'O numero de itens no registro R7 não pode ser Zero';
            Result := -1;
         end;

         for D := 0 to RegistroR6Rec[i].QTD_R7 - 1 do
         begin
         with RegistroR07.New do
         begin
         CCF            := RegistroR7Rec[IndexR7].CCF;
         GNF            := RegistroR7Rec[IndexR7].GNF;
         MP             := RegistroR7Rec[IndexR7].MP;
         VL_PAGTO       := RegistroR7Rec[IndexR7].VL_PAGTO;
         IND_EST        := RegistroR7Rec[IndexR7].IND_EST;
         VL_EST         := RegistroR7Rec[IndexR7].VL_EST;
         RegistroValido := RegistroR7Rec[IndexR7].RegistroValido;
         end;
         inc(IndexR7);
         end;
       end;
   end;

  pafHandle^.PAF.SaveFileTXT_R(Arquivo);
  Result := 0;
  except
     on exception : Exception do
     begin
        pafHandle^.UltimoErro := exception.Message;
        pafHandle^.PAF.PAF_R.LimpaRegistros;
        Result := -1;
     end
  end;
end;

Function PAF_SaveFileTXT_T(const pafHandle: PPAFHandle; const RegistroT1Rec : TRegistroHD1Rec;
      const RegistroT2Rec : array of TRegistroT2Rec; const CountT2 : Integer; const Arquivo: pChar) : Integer;{$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  i : Integer;
begin
  if (pafHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  if(CountT2 <= 0) then
  begin
     pafHandle^.UltimoErro := 'O numero de Itens não pode ser Zero';
     Result := -1;
     Exit;
  end;

  try
   pafHandle^.PAF.PAF_T.RegistroT1.RAZAOSOCIAL      := RegistroT1Rec.RAZAOSOCIAL;
   pafHandle^.PAF.PAF_T.RegistroT1.UF               := RegistroT1Rec.UF;
   pafHandle^.PAF.PAF_T.RegistroT1.CNPJ             := RegistroT1Rec.CNPJ;
   pafHandle^.PAF.PAF_T.RegistroT1.IE               := RegistroT1Rec.IE;
   pafHandle^.PAF.PAF_T.RegistroT1.IM               := RegistroT1Rec.IM;

   pafHandle^.PAF.PAF_T.RegistroT2.Clear;

   for i := 0 to CountT2 - 1 do
   begin
   with pafHandle^.PAF.PAF_T.RegistroT2.New do
   begin
   DT_MOV         := RegistroT2Rec[i].DT_MOV;
   TP_DOCTO       := RegistroT2Rec[i].TP_DOCTO;
   SERIE          := RegistroT2Rec[i].SERIE;
   NUM_BILH_I     := RegistroT2Rec[i].NUM_BILH_I;
   NUM_BILH_F     := RegistroT2Rec[i].NUM_BILH_F;
   NUM_ECF        := RegistroT2Rec[i].NUM_ECF;
   CRZ            := RegistroT2Rec[i].CRZ;
   CFOP           := RegistroT2Rec[i].CFOP;
   VL_CONT        := RegistroT2Rec[i].VL_CONT;
   VL_BASECALC    := RegistroT2Rec[i].VL_BASECALC;
   ALIQ           := RegistroT2Rec[i].ALIQ;
   VL_IMPOSTO     := RegistroT2Rec[i].VL_IMPOSTO;
   VL_ISENTAS     := RegistroT2Rec[i].VL_ISENTAS;
   VL_OUTRAS      := RegistroT2Rec[i].VL_OUTRAS;
   RegistroValido := RegistroT2Rec[i].RegistroValido;
   end;
   end;

   pafHandle^.PAF.SaveFileTXT_T(Arquivo);
   Result := 0;
  except
  on exception : Exception do
  begin
  pafHandle^.UltimoErro := exception.Message;
  pafHandle^.PAF.PAF_T.LimpaRegistros;
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
PAF_GetAssinarArquivo, PAF_SetAssinarArquivo,
PAF_SetAAC,

{Salvar Arquivos PAF}
PAF_SaveFileTXT_C, PAF_SaveFileTXT_D,
PAF_SaveFileTXT_E, PAF_SaveFileTXT_H,
PAF_SaveFileTXT_P, PAF_SaveFileTXT_R,
PAF_SaveFileTXT_T;

end.

