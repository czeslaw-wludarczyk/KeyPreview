unit SaveSettings;

interface

uses Winapi.Windows, System.IOUtils, System.IniFiles, ShlObj, SysUtils,
  System.UITypes, Graphics, System.Classes, System.UIConsts, Main, Vcl.Buttons;

procedure SaveConfiguration();

implementation

var
  INI: TMemIniFile;
  filename: string;

  // Get ProgramData folder for save configuration file
function GetProgramDataFolder: string;
var
  Path: array [0 .. MAX_PATH] of Char;
begin
  if SUCCEEDED(SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT,
    @Path[0])) then
    Result := Path
  else
    Result := '';
end;

procedure SaveConfiguration();
var
  Path: string;
  i: Integer;
  sButton: TSpeedButton;
begin
  filename := 'main.cfg';
  Path := GetProgramDataFolder + '\KeyPreview\';

  // Check if dir exist
  if DirectoryExists(Path) then
  else
    CreateDir(Path);
  if FileExists(Path + filename) then
    DeleteFile(Path + filename);

  // Inicjalize MemIniFile and set encoding to UTF8
  INI := TMemIniFile.Create(Path + filename, TEncoding.UTF8);

  // Try read Configuration for editor from cfg file
  try

    // Indicator Size
    if frmMain.rbSmall.Checked then
      i := 1;
    if frmMain.rbMedium.Checked then
      i := 2;
    if frmMain.rbLarge.Checked then
      i := 3;
    INI.WriteInteger('Options', 'Size', i);

    // Indicator Show
    INI.WriteBool('Show_indicator', 'NumLock', frmMain.swNumLock.Checked);
    INI.WriteBool('Show_indicator', 'CapsLock', frmMain.swCapsLock.Checked);
    INI.WriteBool('Show_indicator', 'ScrollLock', frmMain.swScrollLock.Checked);

    // Indicator Position
    for i := 1 to 9 do
    begin
      sButton := frmMain.FindComponent('SpeedButton' + i.ToString)
        as TSpeedButton;
      if sButton.Down = true then
        INI.WriteInteger('Options', 'Position', i);
    end;

  finally

  end;

  INI.UpdateFile;
end;

end.
