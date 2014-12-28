unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, IdSocketHandle,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, IdSysLogServer, IdSysLogMessage;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Clear1: TMenuItem;
    Server1: TMenuItem;
    Start1: TMenuItem;
    Stop1: TMenuItem;
    About1: TMenuItem;
    Help1: TMenuItem;
    Memo1: TMemo;
    IdSyslogServer: TIdSyslogServer;
    procedure Exit1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure IdSyslogServerSyslog(Sender: TObject;
      ASysLogMessage: TIdSysLogMessage; ABinding: TIdSocketHandle);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function ByteArrayToStr(bArray: array of byte): String;
begin
SetLength(Result,SizeOf(bArray));
CopyMemory(@Result[1],@bArray[0],SizeOf(bArray));
end;

procedure TMainForm.Clear1Click(Sender: TObject);
begin
Memo1.Clear;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
IdSyslogServer.Active:=False;
Application.Terminate;
end;

procedure TMainForm.Help1Click(Sender: TObject);
begin
ShowMessage('Mikrotik Web Proxy Logger - www.turbog.com');
end;

procedure TMainForm.IdSyslogServerSyslog(Sender: TObject;
  ASysLogMessage: TIdSysLogMessage; ABinding: TIdSocketHandle);
begin
Memo1.Lines.Add( ASysLogMessage.Msg.Text  );
Memo1.Lines.Add( ASysLogMessage.Msg.Content  );
Memo1.Lines.Add( ASysLogMessage.Msg.Process  );

end;

procedure TMainForm.Start1Click(Sender: TObject);
begin
Memo1.Lines.Add('Server Started');
IdSyslogServer.Active:=True;
end;

procedure TMainForm.Stop1Click(Sender: TObject);
begin
Memo1.Lines.Add('Server Stopped');
IdSyslogServer.Active:=False;
end;

end.
