unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ES.BaseControls, ES.Shapes, rHTMLLabel,
  Vcl.StdCtrls, SVGIconImage,
  Vcl.ExtCtrls;

type
  TfrmAbout = class(TForm)
    shpBackground: TEsShape;
    imgLogo: TImage;
    lblAppName: TLabel;
    lblCopyright: TLabel;
    lblInfo: TrHTMLLabel;
    lblClick: TLabel;
    lblVersion: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lblClickClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  Self.Left := Screen.PrimaryMonitor.Width div 2 - Self.Width div 2;
  Self.Top := Screen.PrimaryMonitor.Height div 2 - Self.Height div 2;
end;

procedure TfrmAbout.lblClickClick(Sender: TObject);
begin
  Close();
end;

end.
