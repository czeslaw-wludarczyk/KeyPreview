program KeyPreview;

uses
  Vcl.Forms,
  JclAppInst,
  Main in 'Main.pas' {frmMain} ,
  OSD in 'OSD.pas' {frmOSD} ,
  LoadSettings in 'LoadSettings.pas',
  SaveSettings in 'SaveSettings.pas',
  About in 'About.pas' {frmAbout};

{$R *.res}

begin
  JclAppInstances.CheckSingleInstance; // Added instance checking
  Application.Initialize;
  Application.MainFormOnTaskBar := true;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmOSD, frmOSD);
  // Load configuration before create forms
  LoadSettings.LoadConfiguration();
  // Check if application run first time(checked existing ini file for that).
  if LoadSettings.first_run = true then
    Application.ShowMainForm := true
  else
    Application.ShowMainForm := false;
  // Create forms
  Application.Run;

end.
