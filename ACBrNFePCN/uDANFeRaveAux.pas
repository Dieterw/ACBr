unit uDANFeRaveAux;

interface

{uses Graphics, Forms, Windows, SysUtils, Classes,
     Variants, DBClient, Math, Rotinas, StdCtrls, DB,
     Controls, ExtCtrls, Mask,
     RpDefine, RpBase, RpSystem, RpBars, RpMemo,
     ACBrNFe, ACBrNFeNotasFiscais, ACBrBarCode, AJBarcode,
     ACBrNFeXML, ACBrNFeEndereco, MaskUtils, ACBrNFe_nfe;}

uses ACBrNFe_nfe, SysUtils;

function Formatar_ChaveAcessoNFe(Chave:String):String;
function Formatar_Data(cData:string):String;
function Formatar_Telefone(cFone:string):String;
function Formatar_Valor(cValor:string;Mask:string='';ExibirValorZerado:Boolean=True):String;
procedure GetICMS(ICMS:IXMLICMS;var aCST, aBC, aALIQ, aIMPOSTO:string);
procedure GetIPI(IPI:IXMLIPI;var aALIQ, aIMPOSTO:string);
function Limpar(cNum:string):String;
function Formatar_CnpjCpf(cnum:String):String;
function Formatar_Cep(cep:string):string;
function se(bCond:boolean;rTrue,rFalse:variant):variant;


implementation

function Limpar(cNum:string):String;
var i:integer;
begin
  Result:='';
  for i:=1 to Length(cNum) do
     if Pos(cNum[i],'./-,*\#+=_')=0 then
        Result:=Result+cNum[i];
end;

function Formatar_ChaveAcessoNFe(Chave:String):String;
var i:Integer;
begin
  Result:=Chave;
  for i:=1 to 10 do
    Insert('.',Result,(i*4)+i);
end;

function Formatar_Data(cData:string):String;
begin
  Result:=Limpar(cData);
  if Result>'' then
     Result:=Copy(Result,7,2)+'/'+Copy(Result,5,2)+'/'+Copy(Result,1,4);
end;

function Formatar_Telefone(cFone:string):String;
begin
  Result:=Limpar(cFone);
  if Result>'' then begin
     Insert('(',Result,1);
     Insert(') ',Result,4);
     Insert('-',Result,10);
  end;
end;

function Formatar_Valor(cValor:string;Mask:string='';ExibirValorZerado:Boolean=True):String;
var nValor:Double;
begin
  Result:='';
  if (Trim(cValor)>'') or (ExibirValorZerado) then begin
     if cValor='' then
        cValor:='0';
     if not TryStrToFloat(cValor,nValor) then
        cValor:=StringReplace(cValor,'.',',',[rfReplaceAll]);
        if not TryStrToFloat(cValor,nValor) then
           nValor:=0;
     if Mask='' then
        Result:=FormatFloat(',0.00######',StrToFloat(cValor))
       else
        Result:=FormatFloat(mask,StrToFloat(cValor));
  end;
end;

procedure GetICMS(ICMS:IXMLICMS;var aCST, aBC, aALIQ, aIMPOSTO:string);
begin
  with ICMS.ICMS00 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMS;
       aALIQ:=PICMS;
       aBC:=VBC;
    end;
  end;
  with ICMS.ICMS10 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMS;
       aALIQ:=PICMS;
       aBC:=VBC;
    end;
  end;
  with ICMS.ICMS20 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMS;
       aALIQ:=PICMS;
       aBC:=VBC;
    end;
  end;
  with ICMS.ICMS30 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMSST;
       aALIQ:=PICMSST;
       aBC:=VBCST;
    end;
  end;
  with ICMS.ICMS40 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:='0';
       aALIQ:='0';
       aBC:='0';
    end;
  end;
  with ICMS.ICMS51 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMS;
       aALIQ:=PICMS;
       aBC:=VBC;
    end;
  end;
  with ICMS.ICMS60 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMSST;
       aALIQ:='0';
       aBC:=VBCST;
    end;
  end;
  with ICMS.ICMS60 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMSST;
       aALIQ:='0';
       aBC:=VBCST;
    end;
  end;
  with ICMS.ICMS70 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMS;
       aALIQ:=PICMS;
       aBC:=VBC;
    end;
  end;
  with ICMS.ICMS90 do begin
    if CST<>'' then begin
       aCST:=Orig+CST;
       aIMPOSTO:=VICMS;
       aALIQ:=PICMS;
       aBC:=VBC;
    end;
  end;
end;

procedure GetIPI(IPI:IXMLIPI;var aALIQ, aIMPOSTO:string);
begin
  if IPI.IPITrib.CST<>'' then begin
     aIMPOSTO:=IPI.IPITrib.VIPI;
     aALIQ:=IPI.IPITrib.PIPI;
   end
   else begin
     aIMPOSTO:='0';
     aALIQ:='0';
  end;
end;

function Formatar_Cep(cep:string):string;
begin
  cep:=Limpar(Cep);
  Result:=copy(cep,1,2)+'.'+
          copy(cep+'   ',3,3)+'-'+
          copy(cep,6,3);
  Result:=trim(Result);
  if length(Result)<10 then
     Result:='';
end;

function Formatar_CnpjCpf(cnum:String):String;
begin
  cnum:=Limpar(cnum);
  case Length(cnum) of
     11:cnum:=Copy(cNum,1,3)+'.'+Copy(cNum,4,3)+'.'+Copy(cNum,7,3)+'-'+Copy(cNum,10,2);
     14:cnum:=Copy(cNum,1,2)+'.'+Copy(cNum,3,3)+'.'+Copy(cNum,6,3)+'/'+Copy(cNum,9,4)+'-'+Copy(cNum,13,2);
  end;
  Result:=cnum;
end;

function se(bCond:boolean;rTrue,rFalse:variant):variant;
begin
  if bCond then
     result:=rTrue
    else
     result:=rFalse;
end;


end.
