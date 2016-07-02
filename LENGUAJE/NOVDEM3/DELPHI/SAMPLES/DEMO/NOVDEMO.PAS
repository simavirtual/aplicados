unit Novdemo;
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, TabNotBk, Novlib, Demo;

type
  TDemoForm = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Label1: TLabel;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    ListBox2: TListBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    ListBox3: TListBox;
    ListBox4: TListBox;
    ListBox5: TListBox;
    Label21: TLabel;
    Label22: TLabel;
    GroupBox3: TGroupBox;
    Label23: TLabel;
    JobClient: TLabel;
    Label25: TLabel;
    JobSize: TLabel;
    Label27: TLabel;
    JobDesc: TLabel;
    Label24: TLabel;
    JobStatus: TLabel;
    Label26: TLabel;
    JobCopies: TLabel;
    JobDate: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    JobTime: TLabel;
    JobFormName: TLabel;
    Label35: TLabel;
    JobTargetDate: TLabel;
    Label36: TLabel;
    JobTargetTime: TLabel;
    Label28: TLabel;
    UserHold: TLabel;
    Label29: TLabel;
    OperatorHold: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label11: TLabel;
    Button1: TButton;
    LoginName: TEdit;
    Label30: TLabel;
    Password: TEdit;
    Label33: TLabel;
    Label34: TLabel;
    JobDeferred: TLabel;
    Label38: TLabel;
    JobFileName: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure TabbedNotebook1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ListBox5Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

procedure DisplayOpenFiles(Connection: Integer);

var
  DemoForm: TDemoForm;
  UpdatePage0: Bool;
  UpdatePage1: Bool;
  UpdatePage2: Bool;
  UpdatePage3: Bool;
  UpdatePage4: Bool;
  ConnNo: Array [0..100] of Integer;
  JobNo:Array [0..50] of Integer;
  PreferredServer:Integer;
  BinderyID:longint;
  LoggedIn:Boolean;

implementation

{$R *.DFM}

function NW2USDate(NWDate:string): string;
Var USDate:string;
begin
    USDate := '  /  /    ';
    USDate[1]:=NWDate[5];
    USDate[2]:=NWDate[6];
    USDate[4]:=NWDate[7];
    USDate[5]:=NWDate[8];
    USDate[7]:=NWDate[1];
    USDate[8]:=NWDate[2];
    USDate[9]:=NWDate[3];
    USDate[10]:=NWDate[4];
    NW2USDate := USDate;
end;

procedure ClearJobInfo;
begin
  with DemoForm do
  begin
    JobClient.Caption := '';
    JobSize.Caption   := '';
    JobDesc.Caption   := '';
    JobStatus.Caption := '';
    UserHold.Caption  := '';
    JobDate.Caption   := '';
    JobTime.Caption   := '';
    JobCopies.Caption := '';
    OperatorHold.Caption := '';
    JobTargetDate.Caption := '';
    JobTargetTime.Caption := '';
    JobDeferred.Caption := '';
    JobFileName.Caption :='';
  end
end;

procedure ClearFileInfo;
begin
  with DemoForm do
  begin
   Label19.Caption := 'File Users';
   Label20.Caption := '';
   Label13.Caption := '';
   Label14.Caption := '';
   Label15.Caption := '';
   ListBox3.Items.Clear;
   ListBox3.Enabled := False;
  end
end;

Procedure LoadAvailableServers;
var
  ServerList : TStringList;
  NumServers : Integer;
  Server : String;
begin
  ServerList := TStringList.Create;
  Server := FSObjectList('*', OT_FILE_SERVER, TRUE);
  while Server<>'' do
  begin
      ServerList.Add(Server);
      Server := FSObjectList('*', OT_FILE_SERVER, FALSE);
  end;
  with DemoForm.ComboBox2.Items do
  begin
       Clear;
       AddStrings(ServerList);
  end;
  DemoForm.ComboBox2.Text := FSPreferredNameGet;
  DemoForm.ComboBox2.ItemIndex:=0;
  ServerList.Free;
end;

Procedure LoadConnectedServers;
var
  ServerList : TStringList;
  NumServers : Integer;
  Server : String;
begin
  ServerList := TStringList.Create;
  for NumServers := 1 to 8 do
  begin
      Server := FSNameGet(NumServers);
      if not (Server='') then
         ServerList.Add(Server);
  end;
  with DemoForm.ComboBox1.Items do
  begin
       Clear;
       AddStrings(ServerList);
  end;
  DemoForm.ComboBox1.Text := FSPreferredNameGet;
  DemoForm.ComboBox1.ItemIndex:=0;
  ServerList.Free;
end;

Procedure LoadQueues;
var
  QueueList : TStringList;
  Queue : String;
begin
  QueueList := TStringList.Create;
  Queue := FSObjectList('*', OT_PRINT_QUEUE, TRUE);
  while Queue<>'' do
  begin
      QueueList.Add(Queue);
      Queue := FSObjectList('*', OT_PRINT_QUEUE, FALSE);
  end;
  with DemoForm.ListBox4.Items do
  begin
       Clear;
       AddStrings(QueueList);
  end;
  DemoForm.ListBox4.ItemIndex:=0;
  QueueList.Free;
  DemoForm.ListBox5.Items.Clear;
end;

Procedure LoadConnections;
var
  UserList : TStringList;
  Connection : Integer;
  LogName : String;
  ConCount : Integer;
begin
  UserList := TStringList.Create;
  ConCount := 0;
  for Connection := 1 to 100 do
  begin
    LogName := WSLoginNameGet(Connection);
    if not (LogName='') then
    begin
      UserList.Add(LogName);
      inc(ConCount);
      ConnNo[ConCount] := Connection;
    end;
  end;
  UserList.Sorted := False;
  with DemoForm.ListBox1 do
  begin
    Items.Clear;
    Items.AddStrings(Userlist);
    ItemIndex:=0;
  end;
  UserList.Free;
  with DemoForm.ListBox2 do
  begin
    Items.Clear;
  end;
end;


Procedure DoPage2;
Begin
     If UpdatePage2 then
     begin
          LoadConnections;
          UpdatePage2:=False;
     end;
end;

Procedure DoPage3;
begin
  if UpdatePage3 then
     begin
       with DemoForm do
         begin
           ListBox4.Items.Clear;
           ListBox5.Items.Clear;
          end;
          ClearJobInfo;
          LoadQueues;
          UpdatePage3:=False;
     end;
end;

Procedure DoPage4;
Begin
  If UpdatePage4 then
     begin
        LoadAvailableServers;
        UpdatePage4:=False;
     end;
end;

procedure DoPage1;
begin
     if UpdatePage1 then
     begin
          DemoForm.Edit1.text := NovVersionGet;
          DemoForm.Edit2.text := 'V'+NWVersionNumberGet+' Rev: '+IntTostr(NWRevisionNumberGet)+' S/N '+NWSerialNumberGet;
          DemoForm.Edit3.text := SpxVersionNumberGet;
          DemoForm.Edit4.text := WSShellVersionGet;
          DemoForm.Edit5.text := WSOSNameGet+' '+WSOSVersionGet+' ('+WSLongNameGet+')';
          DemoForm.Edit6.text := WSNodeAddressGet(NOVDEFINT);
          DemoForm.Edit7.text := WSNetAddressGet(NOVDEFINT);
          DemoForm.Edit8.text := FSNameGet(NOVDEFINT);
          UpdatePage1:=False;
     end;
end;


Procedure LoadQueueJobs(QueueName:String);
var
  JobList   : TStringList;
  Job       : Integer;
  JobString : String;
  Banner    : String;
  Description: String;
  JobCount  : Integer;
  QueueID   : Longint;
  Counter   : Integer;
begin
  JobList := TStringList.Create;
  ClearJobInfo;
  QueueId := QueIDGet(QueueName);
  JobCount := QueQjbList(QueueID, TRUE);
  If JobCount > 0 then
  begin
       If JobCount > 50 then
          JobCount := 50;
       Counter := 1;
       For Counter := 1 to JobCount do
       begin
            Job := QueQjbList(QueueID, FALSE);
            JobString := '#'+IntToStr(Job);
            JobNo[Counter]:=Job;
            Banner := QjbBannerGet(QueueID, Job);
            JobString := JobString + ' - '+ Banner;
            Description := QjbDescriptionGet(QueueID, Job);
            JobString := JobString + ' - '+Description;
            JobList.Add(JobString);
       end;
  end;
  if JobCount > 0 then
  begin
    with DemoForm.ListBox5.Items do
    begin
       Clear;
       AddStrings(JobList);
    end;
    DemoForm.ListBox5.ItemIndex:=0;
    DemoForm.ListBox5.Enabled := TRUE;
  end
  else
  begin
    DemoForm.ListBox5.Items.Clear;
    DemoForm.ListBox5.Enabled := FALSE;
  end;
  JobList.Free;
end;

procedure TDemoForm.FormActivate(Sender: TObject);
begin
if (LoggedIn) then
  begin
    LoadConnectedServers;
    TabbedNotebook1.ActivePage := 'Select Server';
    UpdatePage1:=True;
    UpdatePage2:=True;
    UpdatePage3:=True;
    UpdatePage4:=True;
  end
else
  begin
    UpdatePage4:=True;
    TabbedNotebook1.ActivePage := 'Login';
    DoPage4;
  end;
end;

procedure TDemoForm.TabbedNotebook1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  case NewTab of
  1: DoPage1;
  2: DoPage2;
  3: DoPage3;
  4: DoPage4;
  end
end;

procedure TDemoForm.ComboBox1Change(Sender: TObject);
Var Server: Integer;
begin
    Server := ComboBox1.ItemIndex;
    FSPreferredNameSet(ComboBox1.Items[Server]);
    UpdatePage1 := True;
    UpdatePage2 := True;
    UpdatePage3 := True;
end;

procedure TDemoForm.ListBox1DblClick(Sender: TObject);
Var User:integer;
    Username:string;
    UserCon:integer;
    UserDate:string;
begin
    user:=ListBox1.ItemIndex;
    Username:=ListBox1.Items[User];
    UserCon := ConnNo[User+1];
    UserDate := WSLoginDateGet(UserCon);
    UserDate := Copy(UserDate,5,2)+'/'+Copy(UserDate,7,2)+'/'+Copy(UserDate,1,4);
    DemoForm.GroupBox2.Caption := UsrFullNameGet(Username);
    DisplayOpenFiles(UserCon);
end;


procedure TDemoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if (PreferredServer <> -1) then
        FSPreferredConnSet(PreferredServer);
     NovTaskEnd; { Inform Novlib this task is ending }
end;

function NovUserFileOpenList( Connection: integer; FileList: TStringList ): integer;
var FileName : String ;
    Counter  : Integer;
begin
     Counter:=1 ;
     FileName := FilOpenFileList(Connection,Counter);
     while (FileName <> '') do
     begin
        while Pos('/', FileName) > 0 do
           FileName[Pos('/', FileName)] := '\';
        FileList.Add(FileName);
        inc(Counter);
        FileName := FilOpenFileList(Connection,Counter)
     end;
     NovUserFileOpenList := FileList.Count;
end;


Procedure DisplayOpenFiles(Connection: integer);
Var FileList: TStringList;
    FileCount: Integer;
begin
  ClearFileInfo;
  if (UsrCurConsoleOperatorTest) then
    begin
     FileList:=TStringList.Create;
     FileCount := NovUserFileOpenList(Connection, FileList);
     if FileCount > 0 then
       begin
         FileList.Sorted := True;
         with DemoForm.ListBox2 do
         begin
           Items.Clear;
           Items.AddStrings(FileList);
           ItemIndex:=0;
           Enabled := True;
           Setfocus;
         end;
       end
     else
       begin
         DemoForm.ListBox2.Items.Clear;
         DemoForm.ListBox2.Enabled := FALSE;
      end;
      FileList.Free;
    end
  else
    begin
      DemoForm.ListBox2.Enabled := FALSE;
      messagedlg('You need Console Operator status'+ chr(10)+
                 'to list a user''s open files'+ chr(10) +
                 '(This is a NetWare security issue)',mtError,[mbAbort],0);
    end;
end;

procedure DisplayFileInfo(FileName:string);
Var Attributes:string;
    Counter:integer;
    Connection:integer;
    FileUser:TStringList;
begin
   ClearFileInfo;
   DemoForm.Label20.Caption := FileName;
   Attributes := NovAttributeString(FilAttributeGet(FileName));
   DemoForm.Label13.Caption := Attributes;
   DemoForm.Label14.Caption := NW2USDate(FilCreateDateGet(FileName))+' @ '+FilCreateTimeGet(FileName);
   DemoForm.Label15.Caption := NW2USDate(FilModifyDateGet(FileName))+' @ '+FilModifyTimeGet(FileName);
   FileUser := TStringList.Create;
   Counter :=1;
   Connection := FilOpenConnList(FileName,Counter);
   while Connection <> NOVERRINT do
   begin
        FileUser.Add(WSLoginNameGet(Connection));
        Inc(Counter);
        Connection:= FilOpenConnList(FileName,Counter);
   end;
   Dec(Counter);
   if Counter > 0 then
     with DemoForm.ListBox3 do
     begin
       Items.Clear;
       Items.AddStrings(FileUser);
       ItemIndex:=0;
       Enabled := True;
     end;
   FileUser.Free;
   DemoForm.Label19.Caption := 'File Users ('+IntToStr(Counter)+')';
end;

procedure DisplayJobInfo(QueueName:string; JobNumber:Integer);
Var QueueID:longint;
begin
     QueueID := QueIDGet(QueueName);
     With DemoForm Do
     begin
          JobClient.Caption := UsrFullNameGet(UsrNameGet(QJbUserIdGet(QueueID, JobNumber)));
          JobSize.Caption := IntToStr(QJbSizeGet(QueueID, JobNumber));
          JobDesc.Caption := QJbDescriptionGet(QueueID, JobNumber);
          if QJbAddingTest(QueueID, JobNumber) then
             JobStatus.Caption := 'Job currently adding to queue'
          else
             if QJbUserHoldGet(QueueID, JobNumber) or QJbOperatorHoldGet(QueueID, JobNumber) then
                JobStatus.Caption := 'On hold'
             else
                 JobStatus.Caption := 'Ready to be serviced';
          if QJbUserHoldGet(QueueID, JobNumber) then
             UserHold.Caption := 'Yes'
          else
             UserHold.Caption := 'No';
          JobDate.Caption := NW2USDate(QJbDateGet(QueueID,JobNumber));
          JobTime.Caption := QJbTimeGet(QueueID,JobNumber);
          JobCopies.Caption := IntToStr(QJbCopiesGet(QueueID, JobNumber));
          if QJbOperatorHoldGet(QueueID, JobNumber) then
             OperatorHold.Caption := 'Yes'
          else
             OperatorHold.Caption := 'No';
          JobTargetDate.Caption := QJbDeferDateGet(QueueID, JobNumber);
          JobTargetTime.Caption := QJbDeferTimeGet(QueueID, JobNumber);
          if JobTargetDate.Caption ='' then
             JobDeferred.Caption := 'No'
          else
             JobDeferred.Caption := 'Yes';
          JobFileName.Caption := QJbFileNameGet(QueueID, JobNumber);
     end;
end;

procedure TDemoForm.ListBox2DblClick(Sender: TObject);
Var FileName:string;
    UserDate:string;
begin
    FileName:=ListBox2.Items[ListBox2.ItemIndex];
    DisplayFileInfo(FileName);
end;

procedure TDemoForm.ListBox5Click(Sender: TObject);
begin
    DisplayJobInfo(ListBox4.Items[ListBox4.ItemIndex], JobNo[ListBox5.ItemIndex+1]);
end;

procedure TDemoForm.ListBox4Click(Sender: TObject);
begin
     LoadQueueJobs(DemoForm.ListBox4.Items[DemoForm.ListBox4.ItemIndex]);
end;

procedure TDemoForm.Button1Click(Sender: TObject);
Var CurrentServer:Integer;
begin
     if LoginName.Text='' then
        LoginName.SetFocus
     else
        CurrentServer:= FSPreferredConnGet;
        if FSWSAttach(ComboBox2.Text)>0 then
        begin
           FSPreferredNameSet(ComboBox2.Text);
           FSWSLogin(UpperCase(LoginName.Text),UpperCase(Password.Text), OT_USER);
           if NWErrorGet=0 then
             begin
              messagedlg('Successfully logged in to '+ComboBox2.Text,mtInformation,[mbOk],0);
              LoadConnectedServers;
             end
           else
             begin
               messagedlg('Unable to login to '+ComboBox2.Text+' code: '+IntToStr(NWErrorGet),mtWarning,[mbOk],0);
               FSPreferredConnSet(CurrentServer);
             end;
          end;
          UpdatePage1 := True;
          UpdatePage2 := True;
          UpdatePage3 := True;
end;


begin
PreferredServer:=-1;
  BinderyID := WSLoginIDGet(WSConnNumberGet);
  if (BinderyID<>NOVERRLONG) then
    begin
      LoggedIn := True;
    end
  else
    begin
      LoggedIn := False;
    end;
end.
