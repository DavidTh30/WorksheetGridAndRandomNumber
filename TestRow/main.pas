unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpspreadsheetctrls, fpspreadsheetgrid,fpstypes,fpspreadsheet;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    sWorkbookSource1: TsWorkbookSource;
    sWorkbookTabControl1: TsWorkbookTabControl;
    sWorksheetGrid1: TsWorksheetGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}


{ TMainForm }

procedure TMainForm.FormShow(Sender: TObject);
var
  MyWorksheet1,MyWorksheet2: TsWorksheet;
  i: integer;
begin
  // dummy workbook with worksheet "Sheet1" preloaded
  sWorkbookSource1.Workbook.AddWorksheet('Sheet2');
  MyWorksheet1 := sWorkbookSource1.Workbook.GetWorksheetByIndex(0);
  MyWorksheet2 := sWorkbookSource1.Workbook.GetWorksheetByIndex(1);
  for i := 0 to 9 do // populate MyWorksheet1
    MyWorksheet1.WriteNumber(i,0,i);
  for i := 0 to 14 do // populate MyWorksheet2
    MyWorksheet2.WriteNumber(i,0,i);
  sWorksheetGrid1.SelectSheetByIndex(0);  // show Sheet1 in grid
  sWorksheetGrid1.RowCount := 10;


end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  showmessage('RowCount in grid: ' + inttostr(sWorksheetGrid1.RowCount));
end;

end.

