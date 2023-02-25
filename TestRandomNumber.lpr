program TestRandomNumber;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uecontrols, Unit1
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='WorksheetGrid and Random number';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TWorksheetGridAndRandomNumber, 
    WorksheetGridAndRandomNumber);
  Application.Run;
end.

