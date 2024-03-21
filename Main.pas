///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                               (c) 2024 CWStudio                                   //
//                               Czesław Włudarczyk                                  //
//                                                                                   //
//The code can be freely modified, but information about the application creator     //
//must be included in the source code.                                               //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, JvExExtCtrls, JvShape,
  ES.BaseControls, ES.Switch, Vcl.StdCtrls, Vcl.ButtonGroup, JvComponentBase, JvTrayIcon, Vcl.Menus, Vcl.Buttons,
  JclShell, ShlObj;

const
  WM_NumLockScreen = WM_USER + 1;
  WM_CapsLockScreen = WM_USER + 2;
  WM_ScrollLockScreen = WM_USER + 3;

type
  TfrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    swNumLock: TEsSwitch;
    swCapsLock: TEsSwitch;
    GroupBox2: TGroupBox;
    JvTrayIcon: TJvTrayIcon;
    TrayMenu: TPopupMenu;
    Close1: TMenuItem;
    N1: TMenuItem;
    ShowHide1: TMenuItem;
    N2: TMenuItem;
    About1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    GroupBox3: TGroupBox;
    rbSmall: TRadioButton;
    rbMedium: TRadioButton;
    rbLarge: TRadioButton;
    Panel4: TPanel;
    Label1: TLabel;
    swScrollLock: TEsSwitch;
    procedure FormCreate(Sender: TObject);
    procedure JvTrayIconDblClick(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Close1Click(Sender: TObject);
    procedure ShowHide1Click(Sender: TObject);
    procedure swNumLockClick(Sender: TObject);
    procedure swCapsLockClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FHook: hHook;
    KeyState: TKeyboardState;
    NumLock, CapsLock, ScrollLock, Autostart: Boolean;
  public
    { Public declarations }
    procedure NumLockScreen(var message: TMessage); message WM_NumLockScreen;
    procedure CapsLockScreen(var message: TMessage); message WM_CapsLockScreen;
    procedure ScrollLockScreen(var message: TMessage); message WM_ScrollLockScreen;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses OSD, SaveSettings;

type
  pKBDLLHOOKSTRUCT = ^KBDLLHOOKSTRUCT;

  KBDLLHOOKSTRUCT = packed record
    vkCode: DWORD;
    scanCodem: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: ULONG_PTR;
  end;

var
  hkHook: hHook;

function LowLevelKeyboardProc(code: Integer; WParam: WParam; LParam: LParam):
  LRESULT stdcall;
const
  LLKHF_UP = $0080;
var
  Hook: pKBDLLHOOKSTRUCT;
  bControlKeyDown: Boolean;
begin
  try
    Hook := pKBDLLHOOKSTRUCT(LParam);
    case code of
      HC_ACTION:
        begin
          if (Hook^.flags and LLKHF_UP) <> 0 then

            case Hook.vkCode of
              VK_NUMLOCK: PostMessage(frmMain.Handle, WM_NumLockScreen, Hook.vkCode, 0);
              VK_CAPITAL: PostMessage(frmMain.Handle, WM_CapsLockScreen, Hook.vkCode, 0);
              VK_SCROLL: PostMessage(frmMain.Handle, WM_ScrollLockScreen, Hook.vkCode, 0);
            end;
        end;
    end;
  finally
    Result := CallNextHookEx(hkHook, code, WParam, LParam);
  end;
end;

procedure HookIt;
begin
  hkHook := SetWindowsHookEx(WH_KEYBOARD_LL, @LowLevelKeyboardProc, hInstance, 0);
end;

procedure UnHookIt;
begin
  UnHookWindowsHookEx(hkHook);
end;

procedure TfrmMain.NumLockScreen(var message: TMessage);
begin
  if message.LParam = 0 then
    if KeyState[message.WParam] = 0 then
      KeyState[message.WParam] := 1
    else
      KeyState[message.WParam] := 0;

  if NumLock then
  begin
    if KeyState[VK_NUMLOCK] = 0 then
    begin
      frmOSD.lblKeyInfo.Caption := '1';
      frmOSD.shpDiode.Brush.Color := clRed;
    end
    else if KeyState[VK_NUMLOCK] = 1 then
    begin
      frmOSD.lblKeyInfo.Caption := '1';
      frmOSD.shpDiode.Brush.Color := clGreen;
    end;
    ShowWindow(frmOSD.Handle, SW_SHOWNOACTIVATE);
    frmOSD.Visible := true;
  end;
end;

procedure TfrmMain.CapsLockScreen(var message: TMessage);
begin
  if message.LParam = 0 then
    if KeyState[message.WParam] = 0 then
      KeyState[message.WParam] := 1
    else
      KeyState[message.WParam] := 0;

  if CapsLock then
  begin
    if KeyState[VK_CAPITAL] = 0 then
    begin
      frmOSD.lblKeyInfo.Caption := 'a';
      frmOSD.shpDiode.Brush.Color := clRed;
    end
    else if KeyState[VK_CAPITAL] = 1 then
    begin
      frmOSD.lblKeyInfo.Caption := 'A';
      frmOSD.shpDiode.Brush.Color := clGreen;
    end;
    ShowWindow(frmOSD.Handle, SW_SHOWNOACTIVATE);
    frmOSD.Visible := true;
  end;

end;

procedure TfrmMain.ScrollLockScreen(var message: TMessage);
begin
  if message.LParam = 0 then
    if KeyState[message.WParam] = 0 then
      KeyState[message.WParam] := 1
    else
      KeyState[message.WParam] := 0;

  if KeyState[VK_SCROLL] = 0 then
    begin
      frmOSD.lblKeyInfo.Caption := 'S';
      frmOSD.shpDiode.Brush.Color := clRed;
    end
  else if KeyState[VK_SCROLL] = 1 then
   begin
      frmOSD.lblKeyInfo.Caption := 'S';
      frmOSD.shpDiode.Brush.Color := clGreen;
    end;
    ShowWindow(frmOSD.Handle, SW_SHOWNOACTIVATE);
    frmOSD.Visible := true;
end;

procedure TfrmMain.ShowHide1Click(Sender: TObject);
begin
  if IsWindowVisible(Handle) then
  begin
    frmMain.Visible := false;
    SaveSettings.SaveConfiguration();
  end
  else
  begin
    frmMain.Visible := true;
  end;
end;

procedure TfrmMain.swCapsLockClick(Sender: TObject);
begin
  if swCapsLock.Checked then
    CapsLock := true
  else
    CapsLock := false;
end;

procedure TfrmMain.swNumLockClick(Sender: TObject);
begin
  if swNumLock.Checked then
    NumLock := true
  else
    NumLock := false;
end;

procedure TfrmMain.Close1Click(Sender: TObject);
begin
  UnHookIt;
  SaveSettings.SaveConfiguration();
  Application.Terminate;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  SaveSettings.SaveConfiguration();
  if IsWindowVisible(Handle) then
  begin
    frmMain.Visible := false;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  GetKeyboardState(KeyState);
  //Check configuration from registry or file
  swNumLock.Checked := true;
  NumLock := true;
  swCapsLock.Checked := true;
  CapsLock := true;
  swScrollLock.Checked := true;
  ScrollLock := true;
  //Hook Keyboard
  HookIt;
end;

procedure TfrmMain.JvTrayIconDblClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if IsWindowVisible(Handle) then
  begin
    frmMain.Visible := false;
    SaveSettings.SaveConfiguration();
  end
  else
  begin
    frmMain.Visible := true;
  end;
end;

end.

