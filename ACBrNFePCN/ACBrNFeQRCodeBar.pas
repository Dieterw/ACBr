{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
******************************************************************************}
{$I ACBr.inc}
{$B-}
{$WARNINGS OFF}
unit ACBrNFeQRCodeBar ;

{Change History
July 17th 1998   Before testing whether canvas is qreport.printer.canvas, check
whether it is self.canvas.  Can be asked to draw self when qreportprinter
not initialised}

interface

uses
   WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, printers, QuickRpt, QRCtrls, db, dbctrls, dbTables;


type
  TcsicsiBarCodeType = ( Code128, EAN128);{Postnet & ean8/13.. determines which by Data provided }

  TSPEDBarCode = class(TQRImage)
  private
   {for Barcoding}
    FBarCodeType : TcsicsiBarCodeType;{MAY KEEP THIS.. NOT SURE}
    SavePenColor : TColor;
    SaveBrushColor : TColor;
    SaveFont : TFont;
    FClearZone : boolean;
    FWidthInInches : Double;
    FLeftInInches : Double;

    procedure SetText(const Value: TCaption);

  protected
      StartX1, StartY1, StartX2, StartY2 : integer;
      NewX1, NewY1, NewX2, NewY2 : integer;
      LastX1, LastY1, LastX2, LastY2 : integer;
      StartMX, StartMY : integer; {for start move pos}
      MoveTop, MoveLeft, MoveRight, MoveBottom, MoveAll : boolean;
      function GetHeightInInches : Double;{only Ean}
      function GetWidthInInches : Double;{only Ean}
      function GetTopInInches : Double;{only Ean}
      function GetLeftInInches : Double;{only Ean}
      procedure SetHeightInInches(Value : Double);
      procedure SetWidthInInches(Value : Double);
      procedure SetTopInInches(Value : Double);
      procedure SetLeftInInches(Value : Double);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure DrawBarCode(PrintWhere : TObject;UsePixelsPerInchX : integer);

   { Public declarations }
  published
    Property Text write SetText;
    Property ClearZone : boolean read FClearZone write FClearZone default true;
    Property HeightInInches : Double Read GetHeightInInches write SetHeightInInches;
    Property WidthInInches : double Read GetWidthInInches write SetWidthInInches;
    Property TopInInches : Double Read GetTopInInches write SetTopInInches;
    Property LeftInInches : double Read GetLeftInInches write SetLeftInInches;
    { Published declarations }
  end;

var TempPaintBox : TPaintBox;

implementation

var
  UseHeight, UseWidth : integer;

const
   bars : array [ 0..105 ] of string = (
    '212222', '222122', '222221', '121223', '121322', '131222', '122213', '122312', '132212', '221213',
    '221312', '231212', '112232', '122132', '122231', '113222', '123122', '123221', '223211', '221132',
    '221231', '213212', '223112', '312131', '311222', '321122', '321221', '312212', '322112', '322211',
    '212123', '212321', '232121', '111323', '131123', '131321', '112313', '132113', '132311', '211313',
    '231113', '231311', '112133', '112331', '132131', '113123', '113321', '133121', '313121', '211331',
    '231131', '213113', '213311', '213131', '311123', '311321', '331121', '312113', '312311', '332111',
    '314111', '221411', '431111', '111224', '111422', '121124', '121421', '141122', '141221', '112214',
    '112412', '122114', '122411', '142112', '142211', '241211', '221114', '413111', '241112', '134111',
    '111242', '121142', '121241', '114212', '124112', '124211', '411212', '421112', '421211', '212141',
    '214121', '412121', '111143', '111341', '131141', '114113', '114311', '411113', '411311', '113141',
    '114131', '311141', '411131', '211412', '211214', '211232' ) ;


procedure TSPEDBarCode.DrawBarCode(PrintWhere : TObject;UsePixelsPerInchX : integer);
var
//  MinLength : integer;
  LeadIn : integer;
  Wide : integer; {# pixels}
  StartPoint : integer; {where BarCode next bar Starts}
  StartX, StartY : integer;
  WhichCanvas : TCanvas;
  UsePixelsPerInchY : integer;

{128} procedure PCode128(S : string; Sender: TCanvas; EAN128 : Boolean);
{128}   {EAN 128 ADDS EAN FNC1 .. otherwise Code128 standard}
{128}   {Type NumberSet = (A,B,C);}
{128} var Drk : boolean;
{128}      CodeChars : array[1..400] of char;
{128}      CCPtr,  {alway 1 greater than last code added}
{128}      SI : integer;
{128}       ThisHeight : integer;
{128}
{128}
{128}
{128} procedure  printbar(Sender : TCanvas; drk: boolean; NoOfWide : integer); {Uses global vars so all procs can call}
{128} var Barwidth : integer;
{128} begin
{128}
{128}   with  Sender do
{128}   begin
{128}   if drk then
{128}      Pen.Color := clBlack
{128}   else
{128}      Pen.Color := Self.color;

        Brush.Color := Pen.Color ;

{128}   Barwidth := Wide * NoOfWide;
{128}   Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,ThisHeight + StartY {+ (5 * wide)});
{128}   StartPoint := StartPOint + BarWidth;
{128}
{128}   end
{128} end;
{128}
{128}
{128} procedure barchar(ch : char);
{128} var i : integer;
{128}    BarWidths : string ;
{128} begin
{128}   Sender.Brush.color := Self.Color;
{128}   BarWidths := bars [ ord(ch) ] ; {returned in BarsWidths}
{128}   drk := true;
{128}   for i := 1 to 6  do
{128}   begin
{128}   printbar(Sender,drk,StrToInt( BarWidths[i] ));
{128}   drk := not Drk;
{128}   end;
{128} end;
{128}
{128} procedure AddCC(ch : char);
{128} begin
{128}    CodeChars[CCPtr] := ch;
{128}    CCPtr := CCPtr + 1;
{128} end;
{128}
{128} procedure AddNCode(ch : char);
{128} begin
{128}   if ord(ch) < 32 then AddCC(chr(ord(ch) + 64))
{128}   else
{128}   AddCC(chr(ord(ch) - 32))
{128} end;
{128}
{128}
{128}
{128}
{128} procedure TranslateCode;
{128} TYPE CodeTypeS = (A,B,C,None);
{128} VAR SPtr, SLen, NextC : integer;
{128}     CodeType : CodeTypes;
{128}
{128} function  TrySetC(TempPtr : integer) : Boolean;
{128} var i : integer;
{128} begin
{128}    result := false;
{128}    if TempPtr > SLen - 3 then exit;
{128} {test for 4 consec digits}
{128}     for i := TempPtr to  (TempPtr + 3) DO
{128}     if not (s[i] in ['0'..'9']) then exit;
{128}     result := true;
{128}  end;
{128}
{128}  procedure DoSetC;
{128}  var ch : char;
{128}  begin
{128}     if CodeType <> C then AddCC(#99);
{128}     Codetype := C;
{128}     while (SPtr <= SLen - 1)
{128}             and (s[SPtr] in ['0'..'9'])
{128}             and (s[SPtr + 1] in ['0'..'9']) do
{128}     begin
{128}        ch :=   chr(10 * (ord(s[SPtr]) - 48)  + ord(s[SPtr + 1]) - 48);
{128}        AddCC(ch);
{128}        SPtr := SPtr + 2;
{128}     end;
{128}
{128}  end;
{128}
{128}  function TryNextCode(startPtr : integer) : CodeTypeS;
{128}  var Found : boolean;
{128}     i : integer;
{128}  begin
{128}    result  := B;
{128}    if StartPtr > SLen then exit;
{128}    i := StartPtr - 1;
{128}    found := false;
{128}    REPEAT
{128}      i := i + 1;
{128}      if ord(s[i]) <= 31 then
{128}      begin
{128}        Result := A;
{128}        Found := true;
{128}      end;
{128}      if ord(s[i]) >= 96 then
{128}      begin
{128}      Result := B;
{128}      Found := true;
{128}      end;
{128}    UNTIL (i = SLen) or found;
{128}
{128}  end;
{128}
{128}
{128}  procedure FindNextC;
{128}  var i : integer;
{128}  begin
{128}    {ie not before end of string}
{128}    i := SPtr -1;
{128}    REPEAT
{128}      i := i + 1;
{128}    UNTIL (i >= SLen) or TrySetC(i);
{128}    NextC := i;
{128}    if NextC = SLen then NextC := SLen + 1{(i = SLen + 1) means  not before end of string}
{128}  end;
{128}
{128}
{128}  procedure DoSetA;
{128} Var NextB : integer;
{128}     MustStop : boolean;
{128}
{128}  procedure TryNextB(startPtr : integer;var ItsPtr : integer);
{128}  begin
{128}       ItsPtr := StartPtr - 1;
{128}    REPEAT
{128}      ItsPtr := ItsPtr + 1;
{128}    UNTIL (ItsPtr > SLen) or (ord(s[ItsPtr]) >= 96);
{128}  end;
{128}
{128}
{128}
{128}  begin
{128}     if CodeType <> A then AddCC(#101);
{128}     Codetype := A;
{128}     MustStop := false;
{128}     TryNextB(SPtr,NextB);
{128}     REPEAT
{128}     while (SPtr <= NextB - 1) and (SPtr <= NextC - 1) and (SPtr <= SLen) do
{128}     begin
{128}        AddNCode(s[SPtr]);
{128}        SPtr := SPtr + 1;
{128}     end;
{128}     if SPtr >= NextC then MustStop := true {nextC <= SLen}
{128}     else
{128}     if SPtr > SLen then MustStop := true {nextC <= SLen}
{128}     else
{128}     begin {CAN ASSUME SPtr = NEXT A}
{128}        if TryNextCode(SPtr + 1) = B then MustStop := true
{128}       else
{128}       AddCC(chr(98));{ONE CODE B ONLY.. USE SHIFT}
{128}     end;
{128}     UNTIL MustStop;
{128}  end;
{128}
{128}
{128}
{128}  procedure DoSetB;
{128} Var NextA : integer;
{128}         MustStop : boolean;
{128}
{128}  procedure TryNextA(startPtr : integer;var ItsPtr : integer);
{128}  begin
{128}       ItsPtr := StartPtr - 1;
{128}    REPEAT
{128}      ItsPtr := ItsPtr + 1;
{128}    UNTIL (ItsPtr > SLen) or (ord(s[ItsPtr]) >= 96);
{128}  end;
{128}
{128}
{128}  begin
{128}     if CodeType <> B then AddCC(#100);
{128}     Codetype := B;
{128}     MustStop := false;
{128}     TryNextA(SPtr,NextA);
{128}     REPEAT
{128}     while (SPtr <= NextA - 1) and (SPtr <= NextC - 1) and (SPtr <= SLen) do
{128}     begin
{128}        AddNCode(s[SPtr]);
{128}        SPtr := SPtr + 1;
{128}     end;
{128}     if SPtr >= NextC then MustStop := true {nextC <= SLen ie if end of string , this is true}
{128}     else
{128}     if SPtr > SLen then MustStop := true
{128}     else
{128}     begin {CAN ASSUME SPtr = NEXT A}
{128}        if TryNextCode(SPtr + 1) = A then MustStop := true
{128}       else
{128}       begin
{128}        TryNextA(SPtr + 1,NextA);{Move Next A on further}
{128}        AddCC(chr(98));{ONE CODE A ONLY.. USE SHIFT}
{128}       end;
{128}     end;
{128}     UNTIL MustStop;
{128}  end;
{128}
{128}
{128}
{128}  begin {TranslateCode}
{128}   SPtr := 1; CCPtr := 1;
{128}   SLen := length(s);
{128}   FindNextC;
{128}   if NextC = 1 then
{128}           begin
{128}              CodeType := C;
{128}              AddCC(chr(105));
{128}           end {startC}
{128}   else if TryNextCode(1) = A then
{128}           begin
{128}             Codetype := A;
{128}             AddCC(chr(103));
{128}           end
{128}   else
{128}           begin
{128}              CodeType := B;
{128}              AddCC(chr(104));
{128}           end;
{128}
{128}   if EAN128 then AddCC(#102);
{128}   REPEAT
{128}     if  TrySetC(SPtr)  then DoSetC;
{128}     FindNextC;
{128}     if (SPtr <= (NextC - 1)) then
{128}     begin
{128}       if TryNextCode(SPtr) = A then DoSetA  else DoSetB;
{128}     end;
{128}   UNTIL SPtr > SLen;
{128} end;
{128}
{128}
{128} procedure AddCheckSum;
{128} var i, ExtraChar : integer;
{128}     ChkSum : longint;{can hve long BarCodes}
{128} begin
{128} //  ChkSum := 0;
{128} {  Test differnt checksum .. replace ean128 with true}
{128}   if true then
{128}   begin
{128}   ExtraChar := 1;
{128}   ChkSum := ord(CodeChars[1]);
{128}   end
{128}   else ExtraChar  := 0;
{128}   for i := (1 )  to   (CCPtr -1 - ExtraChar) do
{128}     ChkSum := ChkSum + ord(CodeChars[i + ExtraChar]) * i;
{128}   ChkSum := ChkSum mod 103;
{128}   AddCC(chr(ChkSum));
{128} end;
{128}
{128} begin{PCode128}
{128}     Wide := 1;
{128}     ThisHeight := Self.Height;
{128}     TranslateCode;
{128}     AddCheckSum;
{128}     Wide :=  Self.WIdth div (11 * (CCPtr - 1) + 13   { +2 * Leadin });
{128}     if Wide < 1 then
{128}        exit;
{128}     Leadin := Self.width - Wide * (11 * (CCPtr- 1) + 13);
{128}     Sender.Font.Assign(Self.font);
{128}     Sender.Font.Height := Wide * 4;{must be after wide is allocated}
{128}     Sender.Font.Style := [fsBold];
{128}     Sender.Pen.color := Self.color;
{128}     Sender.Rectangle(StartX,StartY,
{128}             Wide * 11 * (CCPtr -1 ) + 13 * wide + 2 * Leadin * Wide + StartX,
{128}             ThisHeight + StartY {+ (11 * wide)});
{128}     Sender.Brush.color := Self.Color;
{128}     StartPoint := 0;
{128}
{128}     {space at start}
{128}     PrintBar(Sender,false,Leadin);
{128}     SI := 1;
{128}     REPEAT
{128}       BarChar(CodeChars[SI]);
{128}       SI := SI + 1;
{128}     UNTIL (SI >= CCPtr);
{128}         {Stop Symbol}
{128}     PrintBar(Sender,true,2);
{128}     PrintBar(Sender,False,3);
{128}     PrintBar(Sender,true,3);
{128}     PrintBar(Sender,False,1);
{128}     PrintBar(Sender,true,1);
{128}     PrintBar(Sender,False,1);
{128}     PrintBar(Sender,true,2);
{128}     {space at end .. done in rect}
{128}     PrintBar(Sender,false,Leadin);
{128}   end;
{128}

begin{DrawBarCode}
    if UsePixelsPerInchX < 5 then
        UsePixelsPerInchX := Screen.PixelsPerInch;

    IF PrintWhere is TCanvas then
      begin
        try {can't assume parentreport.qrprinter ok it would seem}
          if not (csdesigning in ComponentState) then
              if  WhichCanvas <> Self.Canvas then
                  if PrintWhere = ParentReport.QRPrinter.Canvas then
                     begin
                       UsePixelsPerInchX :=
                          GetDeviceCaps(ParentReport.QRPrinter.Canvas.Handle,LOGPIXELSX);
                       UsePixelsPerInchY :=
                           GetDeviceCaps(ParentReport.QRPrinter.Canvas.Handle, LOGPIXELSY);
                     end;
        except
        end;
        WhichCanvas := TCanvas(PrintWhere);
      end
      else
        begin
          WhichCanvas := Self.Canvas;
        end;
    {POSITIONING}

//    if whichCanvas = Self.canvas then
//       begin
        StartX := 0;
        StartY := 0;
//      end
//    else
//      begin
//        StartY := Self.top;
//        StartX := Self.Left;
//      end;

  UseHeight := Self.Height;
  UseWidth := Self.Width;
  SavePenColor := WHichCanvas.pen.color;
  SaveBrushColor := WHichCanvas.Brush.color;
  SaveFont.Assign(WHichCanvas.Font);

  case Self.FBarCodeType of
    Code128 : PCode128(Self.text,WhichCanvas,false);
    EAN128 : PCode128(Self.text,WhichCanvas,TRUE);
  end;
  WHichCanvas.Font.Assign(SaveFont);
  WHichCanvas.pen.color := SavePenColor ;
  WHichCanvas.Brush.color := SaveBrushColor;
end;


procedure TSPEDBarCode.Print(OfsX, OfsY : integer);
var
  TempLeft,
  TempTop,
  TempHeight,
  TempWidth : Longint;
begin
{May need to test for Default Fields here}

  with ParentReport.QRPrinter do
  begin
    TempLeft := Left;
    TempTop := Top;
    TempHeight := Height;
    TempWidth := Width;
    Left := XPos(OfsX + Size.Left);
    Top := YPos(OfsY + Size.Top);
    Width := XPos(OfsX + Size.Left + Size.Width) - XPos(OfsX + Size.Left);
    Height := YPos(OfsY + Size.Top + Size.Height) - YPos(OfsY + Size.Top);
    DrawBarCode(Canvas,0);
    Left := TempLeft;
    Top := TempTop;
    Height := TempHeight;
    Width := TempWidth;
  end;
end;

procedure TSPEDBarCode.SetText(const Value: TCaption);
var
   TempPChar : PChar;
begin
   TempPChar := StrAlloc(280);
   StrPlCopy(TempPchar,Value,280);
   SetTextBuf(TempPCHAR);
   Invalidate;
end;


procedure TSPEDBarCode.SetHeightInInches(Value : Double);{only Ean}
var Calc : integer;
begin
  Calc := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  Self.height := Round(Value * Calc);
  Invalidate;
end;

procedure TSPEDBarCode.SetWidthInInches(Value : Double);{only Ean}
begin
  Self.Width := Round(Value * GetDeviceCaps(Canvas.Handle, LOGPIXELSX));
  Invalidate;
end;


function TSPEDBarCode.GetHeightInInches : Double;{only Ean}
var Calc : integer; LCalc : longint;
begin
   Calc := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  LCalc := round((Self.height / Calc) * 1000);
  result := LCalc / 1000;

end;

function TSPEDBarCode.GetWidthInInches : Double;{only Ean}
var LCalc : double;
begin
  LCalc := (Self.Width /GetDeviceCaps(Canvas.Handle, LOGPIXELSX));
  FWidthInInches := (round(LCalc * 1000) / 1000); {redundant}
  Result := FWidthInInches;
end;

procedure TSPEDBarCode.SetTopInInches(Value : Double);{only Ean}
var Calc : integer;
begin
  Calc := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  Self.top := Round(Value * Calc);
end;

procedure TSPEDBarCode.SetLeftInInches(Value : Double);{only Ean}
begin
  Self.Left := Round(Value * GetDeviceCaps(Canvas.Handle, LOGPIXELSX));
  Invalidate;
end;


function TSPEDBarCode.GetTopInInches : Double;{only Ean}
var Calc : integer; LCalc : longint;
begin
   Calc := GetDeviceCaps(Self.Canvas.Handle, LOGPIXELSY);
  LCalc := round((Self.top / Calc) * 1000);
  result := LCalc / 1000;
  Invalidate;
end;

function TSPEDBarCode.GetLeftInInches : Double;{only Ean}
var LCalc : double;
begin
  LCalc := (Self.Left /GetDeviceCaps(Self.Canvas.Handle, LOGPIXELSX));
  FLeftInInches := (round(LCalc * 1000) / 1000); {redundant}
  Result := FLeftInInches;
  Invalidate;

end;

procedure TSPEDBarCode.Paint;
begin
  DrawBarCode(Canvas,0);
end;


constructor TSPEDBarCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FBarCodeType := Code128 ;
  ClearZone := true;

  Color := clWhite;
  text := '12';
  SaveFont := TFont.Create;

  if Width < 120 then width := 120;
end;

Destructor TSPEDBarCode.Destroy;
begin
  Inherited Destroy;
end;

end.
