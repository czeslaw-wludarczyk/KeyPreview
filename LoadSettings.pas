unit LoadSettings;

interface

uses Winapi.Windows, System.IOUtils, System.IniFiles, ShlObj, System.SysUtils,
  System.UITypes, Graphics, System.Classes, System.UIConsts, StrUtils, VCL.Buttons;

var
  first_run: Boolean;

procedure LoadConfiguration();

implementation

uses Main;

var
  INI: TMemIniFile;
  filename: string;

  //Get ProgramData folder for save configuration file
function GetProgramDataFolder: string;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if SUCCEEDED(SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT,
    @Path[0])) then
    Result := Path
  else
    Result := '';
end;

procedure LoadConfiguration();
var
  path: string;
  i: Integer;
  sButton: TSpeedButton;
begin
  filename := 'main.cfg';
  path := GetProgramDataFolder + '\KeyPreview\';

  if not FileExists(path + filename) then
  begin
    first_run := true;
    Exit;
  end;

  //Inicjalize MemIniFile and set encoding to UTF8
  INI := TMemIniFile.Create(path + filename, TEncoding.UTF8);

  //Try read Configuration for editor from cfg file

  i := INI.ReadInteger('Options', 'Size', 1);
  if i = 1 then
    frmMain.rbSmall.Checked := true;
  if i = 2 then
    frmMain.rbMedium.Checked := true;
  if i = 3 then
    frmMain.rbLarge.Checked := true;

  frmMain.swNumLock.Checked := INI.ReadBool('Show_indicator', 'NumLock', true);
  frmMain.swCapsLock.Checked := INI.ReadBool('Show_indicator', 'CapsLock', true);
  frmMain.swScrollLock.Checked := INI.ReadBool('Show_indicator', 'ScrollLock', true);

  //Indicator Position
  for i := 1 to 9 do
  begin
    sButton := frmMain.FindComponent('SpeedButton' + i.ToString) as TSpeedButton;
    if sButton.Name = 'SpeedButton' + INI.ReadInteger('Options', 'Position', 5).ToString() then
      sButton.Down := true;
  end;

end;

end.

