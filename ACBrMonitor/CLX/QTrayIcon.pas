{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: QTrayIcon.pas, released on 2003-03-12.

The Initial Developer of the Original Code is Andreas Hausladen [Andreas.Hausladen@gmx.de]
Portions created by Andreas Hausladen are Copyright (C) 2003-2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): ______________________________

Last Modified: 2004-09-30

Known Issues:
-----------------------------------------------------------------------------}

unit QTrayIcon;

interface

uses
  {$IFDEF LINUX}
  Libc, Xlib,
  {$ENDIF LINUX}
  {$IFDEF MSWINDOWS}
  Windows, Messages, ShellAPI,
  {$ENDIF MSWINDOWS}
  Qt, QTypes, Types, SysUtils, Classes, QGraphics, QControls, QForms, QMenus,
  QExtCtrls;

type
  TTrayIcon = class(TComponent)
  private
    {$IFDEF MSWINDOWS}
    WinIcon: HICON;
    WinIconMask: HBITMAP;
    FHandle: HWND;
    FMouseOver: Boolean;
    FMouseOverTimer: TTimer;
    FMouseOverWindow: HWND;
    FGlobalPos: TPoint;
    {$ENDIF MSWINDOWS}
    {$IFDEF LINUX}
    FHandle: QLabelH;
    FHooks: QLabel_hookH;
    {$ENDIF LINUX}

    FToolTip: TCaption;
    FShowToolTip: Boolean;

    FIcon: TIcon;
    FBitmap: TBitmap;
    FMasked: Boolean;

    FPopupMenu: TPopupMenu;
    FAutoShow: Boolean;

    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnClosed: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    procedure IconChanged(Sender: TObject);
    procedure SetIcon(Value: TIcon);
    procedure SetBitmap(Value: TBitmap);
    procedure SetMasked(Value: Boolean);
    procedure SetToolTip(const Value: TCaption);
    procedure SetShowToolTip(Value: Boolean);
    procedure SetAutoShow(Value: Boolean);
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);

    {$IFDEF MSWINDOWS}
    function CreateWinIcon: Boolean;
    procedure SetTrayData(Msg: LongWord);
    procedure WndProc(var Msg: Messages.TMessage);
    procedure MouseOverTimerEvent(Sender: TObject);
    {$ENDIF MSWINDOWS}
    {$IFDEF LINUX}
    function SetPixmap: Boolean;
    {$ENDIF LINUX}
  protected
    {$IFDEF LINUX}
    procedure HookEvents; virtual;
    function MainEventFilter(Sender: QObjectH; Event: QEventH): Boolean; cdecl;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; virtual;
    {$ENDIF LINUX}
    procedure CreateHandle; virtual;
    procedure DestroyHandle; virtual;
    procedure UpdateToolTip;

    procedure Closed; dynamic;
    procedure Click; dynamic;
    procedure DblClick; dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure MouseEnter; dynamic;
    procedure MouseLeave; dynamic;

    procedure Loaded; override;

    {$IFDEF MSWINDOWS}
    property Handle: HWND read FHandle write FHandle;
    {$ENDIF MSWINDOWS}
    {$IFDEF LINUX}
    property Handle: QLabelH read FHandle write FHandle;
    {$ENDIF LINUX}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Show;
    procedure Hide;

    property Visible: Boolean read GetVisible write SetVisible;
  published
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    // Set a popup menu to handle RMB

    property AutoShow: Boolean read FAutoShow write SetAutoShow default False;
    // Set AutoShow to True if the component should show the TNA icon
    // immediatelly after the component is loaded from resource.

    property Icon: TIcon read FIcon write SetIcon;
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Masked: Boolean read FMasked write SetMasked default False;
    property ToolTip: TCaption read FToolTip write SetToolTip;
    property ShowToolTip: Boolean read FShowToolTip write SetShowToolTip default False;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnClosed: TNotifyEvent read FOnClosed write FOnClosed;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  {$IFDEF LINUX}
  TToolTip = class(TObject)
  public
    class procedure Add(Widget: QWidgetH; const ToolTip: string); overload;
    class procedure Add(Control: TWidgetControl; const ToolTip: string); overload;
    class procedure Remove(Widget: QWidgetH); overload;
    class procedure Remove(Control: TWidgetControl); overload;

    class procedure SetFont(Font: TFont); overload;
    class procedure SetFont(Font: QFontH); overload;
    class procedure SetPalette(Palette: TPalette); overload;
    class procedure SetPalette(Palette: QPaletteH); overload;
  end;
  {$ENDIF LINUX}

procedure SetWidgetFlags(Handle: QWidgetH; const Flags: array of WidgetFlags);

procedure Register;

implementation

{$D-}

{$IFDEF MSWINDOWS}
const
  WM_TRAYNOTIFY = WM_USER + 21;

  NIN_SELECT = WM_USER + 0;
  NINF_KEY = 1;
  NIN_KEYSELECT = NIN_SELECT or NINF_KEY;
{$ENDIF MSWINDOWS}

procedure Register;
begin
  RegisterComponents('AHComps', [TTrayIcon]);
end;

{$IFDEF LINUX}
procedure QToolTip_add(Widget: QWidgetH; Text: QStringH); cdecl; external '' name 'add__8QToolTipP7QWidgetRC7QString';
procedure QToolTip_remove(Widget: QWidgetH); cdecl; external '' name 'remove__8QToolTipP7QWidget';

procedure QString_create_internal(Memory: QStringH; Text: PChar); cdecl; external '' name '__7QStringPCc';
procedure QString_deref(Handle: QStringH); cdecl; external '' name 'deref__7QString';

const
  sizeof_QString = SizeOf(Pointer);

function QString_create(const Text: string): QStringH;
begin
  Result := AllocMem(sizeof_QString);
  QString_create_internal(Result, PChar(Text));
end;

procedure QString_destroy(Handle: QStringH);
begin
  QString_deref(Handle);
  FreeMem(Pointer(Handle));
end;

class procedure TToolTip.Add(Widget: QWidgetH; const ToolTip: string);
var
  qs: QStringH;
begin
  qs := QString_create(ToolTip);
  try
    QToolTip_add(Widget, qs);
  finally
    QString_destroy(qs);
  end;
end;

class procedure TToolTip.Add(Control: TWidgetControl; const ToolTip: string);
begin
  if Assigned(Control) then
    Add(Control.Handle, ToolTip);
end;

class procedure TToolTip.Remove(Widget: QWidgetH);
begin
  if Assigned(Widget) then
    QToolTip_remove(Widget);
end;

class procedure TToolTip.Remove(Control: TWidgetControl);
begin
  if Assigned(Control) then
    Remove(Control.Handle);
end;

class procedure TToolTip.SetFont(Font: QFontH);
begin
  if Assigned(Font) then
    QApplication_setFont(Font, True, 'QTipLabel');
end;

class procedure TToolTip.SetFont(Font: TFont);
begin
  if Assigned(Font) then
    SetFont(Font.Handle);
end;

class procedure TToolTip.SetPalette(Palette: QPaletteH);
begin
  if Assigned(Palette) then
    QApplication_setPalette(Palette, True, 'QTipLabel');
end;

class procedure TToolTip.SetPalette(Palette: TPalette);
begin
  if Assigned(Palette) then
    SetPalette(Palette);
end;
{$ENDIF LINUX}

procedure SetWidgetFlags(Handle: QWidgetH; const Flags: array of WidgetFlags);
var
  I: Integer;
  F: Cardinal;
begin
  F := 0;
  for I := 0 to Ord(High(Flags)) do
    F := F or Cardinal(Flags[I]);
  QOpenWidget_SetWFlags(QOpenWidgetH(Handle), F);
end;

{
function XClientToScreen(winId: XID; pt: TPoint): TPoint;
var
  w: XWindowAttributes;
  root, parent: XID;
  ChildCount: Cardinal;
  ChildList: PWindow;
begin
  Result := pt;
  XGetWindowAttributes(Application.Display, winId, @w);
  Inc(Result.X, w.x);
  Inc(Result.Y, w.y);

  ChildCount := 0;
  XQueryTree(Application.Display, winId, @root, @parent, @ChildList, @ChildCount);
  XFree(ChildList);

  if (parent <> XRootWindow(Application.Display, 0)) and (parent <> 0) then
    Result := XClientToScreen(parent, Result);
end;
}

{ TTrayIcon }

constructor TTrayIcon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  FBitmap := TBitmap.Create;
  FBitmap.OnChange := IconChanged;
end;

destructor TTrayIcon.Destroy;
begin
  Hide;
  FIcon.Free;
  FBitmap.Free;
  inherited Destroy;
end;

procedure TTrayIcon.Loaded;
begin
  inherited Loaded;
  if FAutoShow then
    Show;
end;

procedure TTrayIcon.SetIcon(Value: TIcon);
begin
  if Value <> FIcon then
    FIcon.Assign(Value);
end;

procedure TTrayIcon.SetBitmap(Value: TBitmap);
begin
  if Value <> FBitmap then
    FBitmap.Assign(Value);
end;

procedure TTrayIcon.SetMasked(Value: Boolean);
begin
  if Value <> FMasked then
  begin
    FMasked := Value;
    IconChanged(FIcon);
  end;
end;

procedure TTrayIcon.SetToolTip(const Value: TCaption);
begin
  if Value <> FToolTip then
  begin
    FToolTip := Value;
    UpdateToolTip;
  end;
end;

procedure TTrayIcon.SetShowToolTip(Value: Boolean);
begin
  if Value <> FShowToolTip then
  begin
    FShowToolTip := Value;
    UpdateToolTip;
  end;
end;

procedure TTrayIcon.SetAutoShow(Value: Boolean);
begin
  if Value <> FAutoShow then
  begin
    FAutoShow := Value;
    if not (csLoading in ComponentState) and FAutoShow then
      Show;
  end;
end;

procedure TTrayIcon.Click;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TTrayIcon.DblClick;
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

procedure TTrayIcon.Closed;
begin
  if Assigned(FOnClosed) then
    FOnClosed(Self);
end;

procedure TTrayIcon.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TTrayIcon.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(Self, Shift, X, Y);
end;

procedure TTrayIcon.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);

  case Button of
    mbRight:
      if FPopupMenu <> nil then
        with Mouse.CursorPos do
          FPopupMenu.Popup(X, Y);

    mbLeft, mbMiddle:
        Click ;
  end;
end;

procedure TTrayIcon.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TTrayIcon.MouseLeave;
begin
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

function TTrayIcon.GetVisible: Boolean;
begin
  Result := Integer(FHandle) <> 0;
end;

procedure TTrayIcon.SetVisible(const Value: Boolean);
begin
  if Visible <> Value then
  begin
    if Visible then
      Hide
    else
      Show;
  end;
end;

{$IFDEF LINUX}
function TTrayIcon.SetPixmap: Boolean;
var
  Pixmap: QPixmapH;
begin
  Result := False;
  if not FIcon.Empty then
    Pixmap := FIcon.Handle
  else if not FBitmap.Empty then
    Pixmap := FBitmap.Handle
  else if (Application.MainForm <> nil) and not TForm(Application.MainForm).Icon.Empty then
    Pixmap := TForm(Application.MainForm).Icon.Handle
  else
    Exit;
  Result := True;

  QLabel_setPixmap(Handle, Pixmap);
  if FMasked and not Icon.Empty then
    QWidget_setMask(Handle, QPixmap_mask(Pixmap))
  else
    QWidget_clearMask(Handle);

  QWidget_repaint(Handle);
end;

procedure TTrayIcon.HookEvents;
var
  Method: TMethod;
begin
  TEventFilterMethod(Method) := MainEventFilter;
  Qt_hook_hook_events(FHooks, Method);
end;

function TTrayIcon.MainEventFilter(Sender: QObjectH; Event: QEventH): Boolean; cdecl;
begin
  try
    Result := EventFilter(Sender, Event);
  except
    Application.HandleException(Self);
    Result := False;
  end;
end;

function TTrayIcon.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;

  function MouseEvent(Event: QMouseEventH): Boolean;
  var
    P: TPoint;
    ShiftState: TShiftState;
    Button: ButtonState;
    MouseButton: TMouseButton;
  begin
    Result := True;

    P.X := QMouseEvent_x(Event);
    P.Y := QMouseEvent_y(Event);
    QWidget_mapToGlobal(QWidgetH(Sender), @P, @P);
    QWidget_mapFromGlobal(Handle, @P, @P);
    ShiftState := ButtonStateToShiftState(QMouseEvent_state(Event));
    Button := QMouseEvent_button(Event);
    if Integer(ButtonState_MidButton) and Integer(Button) <> 0 then
      MouseButton := mbMiddle
    else if Integer(ButtonState_RightButton) and Integer(Button) <> 0 then
      MouseButton := mbRight
    else
      MouseButton := mbLeft;

    case QEvent_type(Event) of
      QEventType_MouseButtonPress:
        MouseDown(MouseButton, ShiftState, P.X, P.Y);

      QEventType_MouseButtonRelease:
        begin
          MouseUp(MouseButton, ShiftState, P.X, P.Y);
          if MouseButton = mbLeft then
            Click;
        end;

      QEventType_MouseButtonDblClick:
        begin
          DblClick;
          MouseDown(MouseButton, ShiftState + [ssDouble], P.X, P.Y);
        end;

      QEventType_MouseMove:
        MouseMove(ShiftState, P.X, P.Y);

    else
      Result := False;
    end;
  end;

begin
  Result := False;
  case QEvent_type(Event) of
    QEventType_Close:
      begin
        Closed;
        Result := True;
        QCloseEvent_accept(QCloseEventH(Event)); // without this KDE cannot logout
      end;

    QEventType_Enter:
      MouseEnter;

    QEventType_Leave:
      MouseLeave;

    QEventType_MouseButtonPress,
    QEventType_MouseButtonRelease,
    QEventType_MouseButtonDblClick,
    QEventType_MouseMove:
      Result := MouseEvent(QMouseEventH(Event));
  end;
end;

{ Gnome }
var
  OldHandler: XErrorHandler = nil;
  DockXError: Integer = 0;

function DockXErrorHandler(dpy: PDisplay; Error: PXErrorEvent): Longint; cdecl;
begin
  DockXError := Error.error_code;
  Result := OldHandler(dpy, Error);
end;

procedure TrapErrors;
begin
  DockXError := 0;
  OldHandler := XSetErrorHandler(@DockXErrorHandler);
end;

function UntrapErrors: Boolean;
begin
  XSetErrorHandler(OldHandler);
  Result := DockXError = 0;
end;

function SendXMessage(dpy: PDisplay; w: Window; Msg, data1, data2, data3: LongWord): Boolean;
var
  Event: XEvent;
begin
  FillChar(Event, SizeOf(Event), 0);
  Event.xclient.xtype := ClientMessage;
  Event.xclient.xwindow := w;
  Event.xclient.message_type := XInternAtom(dpy, '_NET_SYSTEM_TRAY_OPCODE', 0);
  Event.xclient.format := 32;
  Event.xclient.data.l[0] := CurrentTime;
  Event.xclient.data.l[1] := msg;
  Event.xclient.data.l[2] := data1;
  Event.xclient.data.l[3] := data2;
  Event.xclient.data.l[4] := data3;

  TrapErrors;
  XSendEvent(dpy, w, 0, NoEventMask, @Event);
  XSync(dpy, 0);
  Result := UntrapErrors;
end;

{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
function CreateIconMask(Pixmap: QPixmapH): HBITMAP; // Pixmap must be a QBitmapH
var
  Img: QImageH;
  BytesPerLine, y: Integer;
  Bits: array of Byte;
begin
  Img := QImage_create;
  try
    QPixmap_convertToImage(Pixmap, Img);
    QImage_invertPixels(Img, True);

    BytesPerLine := ((QImage_width(Img) + 15) div 16) * 2; // 16 bit alignment
    SetLength(Bits, BytesPerLine * QImage_height(Img));

    for y := 0 to QImage_height(Img) - 1 do
      Move(QImage_scanLine(Img, y)^, Bits[y * BytesPerLine], BytesPerLine);

    Result := CreateBitmap(QImage_width(Img), QImage_height(Img), 1, 1, @Bits[0]);
  finally
    QImage_destroy(Img);
  end;
end;

function TTrayIcon.CreateWinIcon: Boolean;
var
  IconInfo: TIconInfo;
  Pixmap: QPixmapH;
  MaskPix: QPixmapH;
  Mask: QBitmapH;
  Color: QColorH;
begin
  Result := True;
  if WinIcon <> 0 then
    DeleteObject(WinIcon);
  if WinIconMask <> 0 then
    DeleteObject(WinIconMask);

  if not FIcon.Empty then
    Pixmap := FIcon.Handle
  else if not FBitmap.Empty then
    Pixmap := FBitmap.Handle
  else if (Application.MainForm <> nil) and not TForm(Application.MainForm).Icon.Empty then
    Pixmap := TForm(Application.MainForm).Icon.Handle
  else
  begin
    WinIcon := 0;
    WinIconMask := 0;
    Result := False;
    Exit;
  end;

  MaskPix := QPixmap_create(QPixmap_width(Pixmap), QPixmap_height(Pixmap), QPixmap_depth(Pixmap), QPixmapOptimization_NormalOptim);
  Mask := QBitmap_create(QPixmap_width(Pixmap), QPixmap_height(Pixmap), False, QPixmapOptimization_NormalOptim);
  try
    if Masked and (QPixmap_mask(Pixmap) <> nil) then
    begin
      Color := QColor(clBlack);
      QPixmap_fill(MaskPix, Color);
      bitBlt(Mask, 0, 0, QPixmap_mask(Pixmap), 0, 0, QPixmap_width(Pixmap), QPixmap_height(Pixmap), RasterOp_CopyROP, True);
    end
    else
    begin
      Color := QColor_create(255, 255, 255);
      QPixmap_fill(MaskPix, Color);
    end;
    QColor_destroy(Color);

    bitBlt(MaskPix, 0, 0, QPixmap_mask(Pixmap), 0, 0, QPixmap_width(Pixmap), QPixmap_height(Pixmap), RasterOp_CopyROP, True);
    WinIconMask := CreateIconMask(Mask);
  finally
    QPixmap_destroy(MaskPix);
    QBitmap_destroy(Mask);
  end;

  FillChar(IconInfo, SizeOf(IconInfo), 0);
  IconInfo.fIcon := True;
  IconInfo.hbmMask := WinIconMask;
  IconInfo.hbmColor := QPixmap_hbm(Pixmap);

  WinIcon := CreateIconIndirect(IconInfo);
end;

procedure TTrayIcon.SetTrayData(Msg: LongWord);
var
  S: AnsiString;
  Tray: TNotifyIconData;
begin
  if not CreateWinIcon then
    Exit;
  FillChar(Tray, SizeOf(Tray), 0);
  Tray.cbSize := SizeOf(Tray);
  Tray.Wnd := FHandle;
  Tray.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  Tray.uCallbackMessage := WM_TRAYNOTIFY;
  Tray.hIcon := WinIcon;
  if ShowToolTip and (ToolTip <> '') then
  begin
    S := GetShortHint(ToolTip); // convert to AnsiString
    S := StringReplace(FToolTip, #13#10 , ' - ', [rfReplaceAll]);
    S := StringReplace(FToolTip, #10 , ' - ', [rfReplaceAll]);

    StrPLCopy(Tray.szTip, S, SizeOf(Tray.szTip) - 1);
  end;
  Shell_NotifyIcon(Msg, @Tray);
end;

procedure ScreenToClientPos(var Pt: TPoint);
begin
  ScreenToClient(WindowFromPoint(Pt), Pt);
  Pt.X := Pt.X mod 18 - 1;
  Pt.Y := Pt.Y mod 18 - 1;
end;

procedure TTrayIcon.WndProc(var Msg: Messages.TMessage);
var
  CPt, GPt, Pt: TPoint;
  Shift: TShiftState;
begin
  try
  case Msg.Msg of
    WM_DESTROY:
      Closed;

    WM_TRAYNOTIFY:
      begin
        Pt := Mouse.CursorPos;
        GPt := Pt;
        ScreenToClientPos(Pt);

        // obtain the shift state
        Shift := [];
        if GetKeyState(VK_SHIFT  ) < 0 then Include(Shift, ssShift);
        if GetKeyState(VK_CONTROL) < 0 then Include(Shift, ssCtrl);
        if GetKeyState(VK_LBUTTON) < 0 then Include(Shift, ssLeft);
        if GetKeyState(VK_RBUTTON) < 0 then Include(Shift, ssRight);
        if GetKeyState(VK_MBUTTON) < 0 then Include(Shift, ssMiddle);
        if GetKeyState(VK_MENU   ) < 0 then Include(Shift, ssAlt);

        case Msg.LParam of
          WM_LBUTTONDOWN:
            MouseDown(mbLeft, Shift, Pt.X, Pt.Y);
          WM_LBUTTONUP:
            MouseUp(mbLeft, Shift, Pt.X, Pt.Y);
          WM_LBUTTONDBLCLK:
            begin
              DblClick;
              MouseDown(mbLeft, Shift + [ssDouble], Pt.X, Pt.Y);
            end;

          WM_MBUTTONDOWN:
            MouseDown(mbMiddle, Shift, Pt.X, Pt.Y);
          WM_MBUTTONUP:
            MouseUp(mbMiddle, Shift, Pt.X, Pt.Y);

          WM_RBUTTONDOWN:
            MouseDown(mbRight, Shift, Pt.X, Pt.Y);
          WM_RBUTTONUP, NIN_KEYSELECT:
            MouseUp(mbRight, Shift, Pt.X, Pt.Y);

          WM_MOUSEMOVE:
            begin
              if not FMouseOver then
              begin
                FMouseOver := True;
                FMouseOverTimer := TTimer.Create(Self);
                FMouseOverTimer.OnTimer := MouseOverTimerEvent;
                FMouseOverTimer.Interval := 50; // idle Timer
                FMouseOverTimer.Enabled := True;
                FMouseOverWindow := WindowFromPoint(GPt);
                CPt := GPt;
                ScreenToClientPos(CPt);
                FGlobalPos := Point(GPt.X - CPt.X, GPt.Y - CPt.Y);
                MouseEnter;
              end;
              MouseMove(Shift, Pt.X, Pt.Y);
            end;
        end;
        Msg.Result := 0;
      end;
    else
      with Msg do
        Result := DefWindowProc(Handle, Msg, WParam, LParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TTrayIcon.MouseOverTimerEvent(Sender: TObject);
var
  Pt: TPoint;
begin
  Pt := Mouse.CursorPos;
  if FMouseOverWindow <> WindowFromPoint(Pt) then
    FMouseOver := False
  else
    FMouseOver := PtInRect(
      Rect(FGlobalPos.X, FGlobalPos.Y, FGlobalPos.X + 18, FGlobalPos.Y + 18),
      Pt);

  if not FMouseOver then
  begin
    FreeAndNil(FMouseOverTimer);
    FMouseOverWindow := 0;

    MouseLeave;
  end;
end;
{$ENDIF MSWINDOWS}

procedure TTrayIcon.CreateHandle;
{$IFDEF LINUX}
const
  SYSTEM_TRAY_REQUEST_DOCK = 0;
var
  dsp: PDisplay;
  win: WId;
  data: Integer;
  InNetTray: Boolean;
  Screen: PScreen;
  ScreenId: Integer;
  SelectionAtom, KwmDockWindowAtom, KdeNetSysTrayWindowForAtom: Atom;
  ManagerWindow: Window;
{$ENDIF LINUX}
begin
  if not Visible then
  begin
    {$IFDEF MSWINDOWS}
    FHandle := AllocateHWnd(WndProc);
    {$ENDIF MSWINDOWS}

    {$IFDEF LINUX}
    FHandle := QLabel_create(nil, PChar(Name), Integer(WidgetFlags_WMouseNoMask));
    FHooks := QLabel_hook_create(FHandle);
    HookEvents;

    dsp := Application.Display; // get the display
    win := QWidget_winId(Handle); // get the window

    // KDE/GNOME
    QWidget_setMinimumSize(Handle, 22, 22);
    QWidget_setBackgroundMode(Handle, QWidgetBackgroundMode_X11ParentRelative);
    SetWidgetFlags(Handle, [WidgetFlags_WRepaintNoErase]);

    InNetTray := False;
    Screen := XDefaultScreenOfDisplay(dsp);
    ScreenId := XScreenNumberOfScreen(Screen);
    SelectionAtom := XInternAtom(dsp, PChar(Format('_NET_SYSTEM_TRAY_S%d', [ScreenId])), 0);
    XGrabServer(dsp);
    ManagerWindow := XGetSelectionOwner(dsp, SelectionAtom);
    if ManagerWindow <> Xlib.None then
      XSelectInput(dsp, ManagerWindow, StructureNotifyMask);
    XUngrabServer(dsp);
    XFlush(dsp);
    if ManagerWindow <> Xlib.None then
    begin
      InNetTray := True;
      if not SendXMessage(dsp, ManagerWindow, SYSTEM_TRAY_REQUEST_DOCK, win, 0, 0) then
        InNetTray := False;
    end;

    KwmDockWindowAtom := XInternAtom(dsp, 'KWM_DOCKWINDOW', 0);
    KdeNetSysTrayWindowForAtom := XInternAtom(dsp, '_KDE_NET_WM_SYSTEM_TRAY_WINDOW_FOR', 0);

    data := 0;
    XChangeProperty(dsp, win, KwmDockWindowAtom, KwmDockWindowAtom, 32, PropModeReplace, @data, 1);
    XChangeProperty(dsp, win, KdeNetSysTrayWindowForAtom, XA_WINDOW, 32, PropModeReplace, @data, 1);

    QWidget_resize(Handle, 22, 22);
    if not inNetTray then
      QWidget_move(Handle, -21, -21);

    QWidget_update(Handle);
    {$ENDIF LINUX}
  end;
end;

procedure TTrayIcon.DestroyHandle;
begin
  {$IFDEF MSWINDOWS}
  if FHandle <> 0 then
    DeallocateHWnd(FHandle);
  FHandle := 0;

  if WinIcon <> 0 then
    DeleteObject(WinIcon);
  WinIcon := 0;
  if WinIconMask <> 0 then
    DeleteObject(WinIconMask);
  WinIconMask := 0;
  {$ENDIF MSWINDOWS}
  {$IFDEF LINUX}
  QLabel_hook_destroy(FHooks);
  QLabel_destroy(FHandle);
  FHandle := nil;
  FHooks := nil;
  {$ENDIF LINUX}
end;

procedure TTrayIcon.Show;
begin
  if csDesigning in ComponentState then
    Exit;

  CreateHandle;

  {$IFDEF MSWINDOWS}
  SetTrayData(NIM_ADD);
  {$ENDIF MSWINDOWS}
  {$IFDEF LINUX}
  SetPixmap;
  UpdateToolTip;
  QWidget_show(Handle);
  {$ENDIF LINUX}
end;

procedure TTrayIcon.Hide;
{$IFDEF MSWINDOWS}
var
  Tray: TNotifyIconData;
{$ENDIF MSWINDOWS}
begin
  if Visible then
  begin
    {$IFDEF MSWINDOWS}
    FillChar(Tray, SizeOf(Tray), 0);
    Tray.cbSize := SizeOf(Tray);
    Tray.Wnd := FHandle;

    Shell_NotifyIcon(NIM_DELETE, @Tray);
    {$ENDIF MSWINDOWS}

    DestroyHandle;
  end;
end;

procedure TTrayIcon.UpdateToolTip;
begin
  if Visible then
  begin
    {$IFDEF MSWINDOWS}
    SetTrayData(NIM_MODIFY);
    {$ENDIF MSWINDOWS}
    {$IFDEF LINUX}
    TToolTip.Remove(Handle);
    if FShowToolTip then
      TToolTip.Add(Handle, FToolTip);
    {$ENDIF LINUX}
  end;
end;

procedure TTrayIcon.IconChanged(Sender: TObject);
begin
  if Visible then
  begin
    {$IFDEF MSWINDOWS}
    SetTrayData(NIM_MODIFY);
    {$ENDIF MSWINDOWS}
    {$IFDEF LINUX}
    SetPixmap;
    {$ENDIF LINUX}
  end;
end;

end.
