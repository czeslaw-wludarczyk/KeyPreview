unit OSD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ES.BaseControls,
  ES.Shapes, Vcl.ExtCtrls, JvComponentBase, JvThreadTimer;

type
  TfrmOSD = class(TForm)
    shpBackground: TEsShape;
    shpDiode: TEsShape;
    lblKeyInfo: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    procedure SetPosition(position: Integer);
    procedure Size(Size: Integer);
    procedure WMMouseActivate(var Message: TWMMouseActivate);
      message WM_MOUSEACTIVATE;
  public
    { Public declarations }

  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmOSD: TfrmOSD;

implementation

{$R *.dfm}

uses Main;

procedure TfrmOSD.WMMouseActivate(var Message: TWMMouseActivate);
begin
  inherited;
  Message.Result := MA_NOACTIVATE;
end;

procedure TfrmOSD.Size(Size: Integer);
begin

  case Size of
    1:
      begin
        frmOSD.Width := MulDiv(64, CurrentPPI, 96);
        frmOSD.Height := MulDiv(64, CurrentPPI, 96);
        shpDiode.Width := MulDiv(15, CurrentPPI, 96);
        shpDiode.Height := MulDiv(15, CurrentPPI, 96);
        shpDiode.Left := MulDiv(8, CurrentPPI, 96);
        shpDiode.Top := MulDiv(8, CurrentPPI, 96);
        lblKeyInfo.Font.Size := MulDiv(24, CurrentPPI, 96);
      end;

    2:
      begin
        frmOSD.Width := MulDiv(96, CurrentPPI, 96);
        frmOSD.Height := MulDiv(96, CurrentPPI, 96);
        shpDiode.Width := MulDiv(20, CurrentPPI, 96);
        shpDiode.Height := MulDiv(20, CurrentPPI, 96);
        shpDiode.Left := MulDiv(8, CurrentPPI, 96);
        shpDiode.Top := MulDiv(8, CurrentPPI, 96);
        lblKeyInfo.Font.Size := MulDiv(36, CurrentPPI, 96);
      end;
    3:
      begin
        frmOSD.Width := MulDiv(128, CurrentPPI, 96);
        frmOSD.Height := MulDiv(128, CurrentPPI, 96);
        shpDiode.Width := MulDiv(30, CurrentPPI, 96);
        shpDiode.Height := MulDiv(30, CurrentPPI, 96);
        shpDiode.Left := MulDiv(8, CurrentPPI, 96);
        shpDiode.Top := MulDiv(8, CurrentPPI, 96);
        lblKeyInfo.Font.Size := MulDiv(48, CurrentPPI, 96);
      end;
  end;

end;

procedure TfrmOSD.SetPosition(position: Integer);
begin
  self.position := poDesigned;
  case position of
    1:
      begin
        frmOSD.Left := 10;
        frmOSD.Top := 10;
      end;
    2:
      begin
        frmOSD.Left := Screen.PrimaryMonitor.Width div 2 - frmOSD.Width div 2;
        frmOSD.Top := 10;
      end;
    3:
      begin
        frmOSD.Left := Screen.PrimaryMonitor.Width - frmOSD.Width - 10;
        frmOSD.Top := 10;
      end;
    4:
      begin
        frmOSD.Left := 10;
        frmOSD.Top := Screen.PrimaryMonitor.Height div 2 - frmOSD.Height div 2;
      end;
    5:
      begin
        frmOSD.Left := Screen.PrimaryMonitor.Width div 2 - frmOSD.Width div 2;
        frmOSD.Top := Screen.PrimaryMonitor.Height div 2 - frmOSD.Height div 2;
      end;
    6:
      begin
        frmOSD.Left := Screen.PrimaryMonitor.Width - frmOSD.Width - 10;
        frmOSD.Top := Screen.PrimaryMonitor.Height div 2 - frmOSD.Height div 2;
      end;
    7:
      begin
        frmOSD.Left := 10;
        frmOSD.Top := Screen.PrimaryMonitor.Height - frmOSD.Height - 10;
      end;
    8:
      begin
        frmOSD.Left := Screen.PrimaryMonitor.Width div 2 - frmOSD.Width div 2;
        frmOSD.Top := Screen.PrimaryMonitor.Height - frmOSD.Height - 10;
      end;
    9:
      begin
        frmOSD.Left := Screen.PrimaryMonitor.Width - frmOSD.Width - 10;
        frmOSD.Top := Screen.PrimaryMonitor.Height - frmOSD.Height - 10;
      end;
  end;
end;

procedure TfrmOSD.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := FindWindow('Shell_TrayWnd', nil);
end;

procedure TfrmOSD.FormPaint(Sender: TObject);
begin
  if frmMain.SpeedButton1.Down then
    SetPosition(1);
  if frmMain.SpeedButton2.Down then
    SetPosition(2);
  if frmMain.SpeedButton3.Down then
    SetPosition(3);
  if frmMain.SpeedButton4.Down then
    SetPosition(4);
  if frmMain.SpeedButton5.Down then
    SetPosition(5);
  if frmMain.SpeedButton6.Down then
    SetPosition(6);
  if frmMain.SpeedButton7.Down then
    SetPosition(7);
  if frmMain.SpeedButton8.Down then
    SetPosition(8);
  if frmMain.SpeedButton9.Down then
    SetPosition(9);

  if frmMain.rbSmall.Checked then
    Size(1);
  if frmMain.rbMedium.Checked then
    Size(2);
  if frmMain.rbLarge.Checked then
    Size(3);

  Timer1.Enabled := false;
  Timer1.Enabled := true;
end;

procedure TfrmOSD.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  frmOSD.Close;
end;

end.
