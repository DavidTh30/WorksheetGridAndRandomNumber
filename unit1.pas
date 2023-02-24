unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpspreadsheetgrid, BCMaterialDesignButton, uriparser, fpsTypes, lclintf,
  Grids, ComCtrls, StrUtils, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BCMaterialDesignButton1: TBCMaterialDesignButton;
    BCMaterialDesignButton10: TBCMaterialDesignButton;
    BCMaterialDesignButton11: TBCMaterialDesignButton;
    BCMaterialDesignButton2: TBCMaterialDesignButton;
    BCMaterialDesignButton3: TBCMaterialDesignButton;
    BCMaterialDesignButton4: TBCMaterialDesignButton;
    BCMaterialDesignButton5: TBCMaterialDesignButton;
    BCMaterialDesignButton6: TBCMaterialDesignButton;
    BCMaterialDesignButton7: TBCMaterialDesignButton;
    BCMaterialDesignButton8: TBCMaterialDesignButton;
    BCMaterialDesignButton9: TBCMaterialDesignButton;
    Label1: TLabel;
    PageControl1: TPageControl;
    sWorksheetGrid1: TsWorksheetGrid;
    sWorksheetGrid2: TsWorksheetGrid;
    sWorksheetGrid3: TsWorksheetGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure BCMaterialDesignButton10Click(Sender: TObject);
    procedure BCMaterialDesignButton11Click(Sender: TObject);
    procedure BCMaterialDesignButton1Click(Sender: TObject);
    procedure BCMaterialDesignButton2Click(Sender: TObject);
    procedure BCMaterialDesignButton3Click(Sender: TObject);
    procedure BCMaterialDesignButton4Click(Sender: TObject);
    procedure BCMaterialDesignButton5Click(Sender: TObject);
    procedure BCMaterialDesignButton6Click(Sender: TObject);
    procedure BCMaterialDesignButton7Click(Sender: TObject);
    procedure BCMaterialDesignButton8Click(Sender: TObject);
    procedure BCMaterialDesignButton9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LinearCongruentialGenerator(_Seed_: integer; _A_:integer; _C_:integer; _M_:integer; Sender: TObject);
    procedure LinearCongruentialGenerator_Grid(_Seed_: integer; _A_:integer; _C_:integer; _M_:integer; Sender: TsWorksheetGrid; Col_:integer);
    procedure sWorksheetGrid1Click(Sender: TObject);
    procedure sWorksheetGrid1ClickHyperlink(Sender: TObject;
      const AHyperlink: TsHyperlink);
  private

  public

  end;

type
  TsColor = DWORD;

type
  TsFont = class
    FontName: String;
    Size: Single;
    Style: TsFontStyles;
    Color: TsColor;
    Position: TsFontPosition;
  end;

type
  color = (red, blue, yellow, green, white, black, orange);
  colors = set of color;
  Days = (mon, tue, wed, thu, fri, sat, sun);
  Letters = set of char;
  DaySet = set of days;
  Alphabets = set of 'A' .. 'Z';
  studentAge = set of 13..20;

const
names : array [color] of String[7]
  = ('red', 'blue', 'yellow', 'green', 'white', 'black', 'orange');

const
  scBlack       = $00000000;
  scWhite       = $00FFFFFF;
  scRed         = $000000FF;
  scGreen       = $0000FF00;
  scBlue        = $00FF0000;
  scYellow      = $0000FFFF;
  scMagenta     = $00FF00FF;
  scCyan        = $00FFFF00;
  scDarkRed     = $00000080;
  scDarkGreen   = $00008000;
  scDarkBlue    = $00800000;
  scOlive       = $00008080;
  scPurple      = $00800080;
  scTeal        = $00808000;
  scSilver      = $00C0C0C0;
  scGray        = $00808080;
  scGrey        = scGray; // redefine to allow different spelling
  // Identifier for undefined color
  scNotDefined  = $40000000;
  // Identifier for transparent color
  scTransparent = $20000000;

var
  Form1: TForm1;
  Random0To100 : array [0..100] of integer;
  Percent_Random0To100:integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.LinearCongruentialGenerator(_Seed_: integer; _A_:integer; _C_:integer; _M_:integer; Sender: TObject);
//Linear congruential generator
var
  i:integer;
  _Random_:integer;
begin

  //if Assigned(Sender) then (Sender as TButton).Caption := 'Clicked';
  //if (Sender is TEdit) then TEdit(Sender).Text := 'Clicked'

  TLabel(Sender).Caption:='';
  TLabel(Sender).Tag:=0;
  _Random_:=_Seed_;
  for i := 0 to 100 do
  begin
    if (TLabel(Sender).Tag>0) then
    begin
      _Random_:=((_Random_*_A_)+_C_) mod _M_;
      TLabel(Sender).Caption:= TLabel(Sender).Caption+#13#10+IntToStr(_Random_);
    end;
    if (TLabel(Sender).Tag=0) then
    begin
      TLabel(Sender).Caption:= TLabel(Sender).Caption+IntToStr(_Random_); TLabel(Sender).Tag:=1;
    end;
  end;
end;

procedure TForm1.LinearCongruentialGenerator_Grid(_Seed_: integer; _A_:integer; _C_:integer; _M_:integer; Sender: TsWorksheetGrid; Col_:integer);
//Linear congruential generator
var
  i:integer;
  _Random_:integer;
  c: TGridColumn;
begin
  //sWorksheetGrid1.Cells[0, 1] := 'This is a string';

  if Col_<1 then exit;
  if Sender.ColCount=(Col_) then
  begin
    c := sWorksheetGrid1.Columns.Add;
    c.title.caption := '';       // Set columns caption
    c.Alignment := taRightJustify;        // Align column content to the right
    sWorksheetGrid1.ColWidths[Col_]:=30;
  end;
  if Sender.ColCount<(Col_+1) then exit;

  _Random_:=_Seed_;
  //Sender.AutoColWidth(Col_);
  Sender.Columns.Items[Col_-1].Title.Caption:='Seed='+IntToStr(_Seed_)+' A='+IntToStr(_A_)+' C='+IntToStr(_C_)+' M='+IntToStr(_M_);
  Sender.ColWidths[Col_]:=150;
  for i := 1 to 100 do
  begin
    Sender.Cells[Col_, i]:= IntToStr(_Random_);
    _Random_:=((_Random_*_A_)+_C_) mod _M_;
  end;
end;

procedure TForm1.sWorksheetGrid1Click(Sender: TObject);
begin
  if((sWorksheetGrid1.ColCount-1)<sWorksheetGrid1.ColRow.X)then begin Label1.Caption:=''; exit; end;
  if((sWorksheetGrid1.RowCount-1)<sWorksheetGrid1.ColRow.Y)then begin Label1.Caption:=''; exit; end;

  if(sWorksheetGrid1.Cells[sWorksheetGrid1.ColRow.X,sWorksheetGrid1.ColRow.Y]=null)then
  Label1.Caption:='';
  if(sWorksheetGrid1.Cells[sWorksheetGrid1.ColRow.X,sWorksheetGrid1.ColRow.Y]<>null)then
  Label1.Caption:=sWorksheetGrid1.Cells[sWorksheetGrid1.ColRow.X,sWorksheetGrid1.ColRow.Y];
end;

procedure TForm1.sWorksheetGrid1ClickHyperlink(Sender: TObject; const AHyperlink: TsHyperlink);
var
  uri: TUri;
begin
  uri := ParseURI(AHyperlink.Target);
  case Lowercase(uri.Protocol) of
    'http', 'https', 'ftp', 'mailto', 'file':
      OpenUrl(AHyperlink.Target);
    //OpenURL('https://wiki.lazarus.freepascal.org/');
    else
      ShowMessage('Hyperlink ' + AHyperlink.Target + ' clicked');
  end;
end;

procedure TForm1.BCMaterialDesignButton1Click(Sender: TObject);
begin
  LinearCongruentialGenerator_Grid(1,2,3,4,sWorksheetGrid1,1);
  LinearCongruentialGenerator_Grid(2,3,4,5,sWorksheetGrid1,2);
  LinearCongruentialGenerator_Grid(3,4,5,6,sWorksheetGrid1,3);
  LinearCongruentialGenerator_Grid(4,5,6,5,sWorksheetGrid1,4);
  LinearCongruentialGenerator_Grid(4,5,6,6,sWorksheetGrid1,5);
  LinearCongruentialGenerator_Grid(4,5,6,7,sWorksheetGrid1,6);
  LinearCongruentialGenerator_Grid(4,5,8,7,sWorksheetGrid1,7);
  LinearCongruentialGenerator_Grid(5,6,7,8,sWorksheetGrid1,8);
  LinearCongruentialGenerator_Grid(6,7,8,9,sWorksheetGrid1,9);
  LinearCongruentialGenerator_Grid(4,5,6,9,sWorksheetGrid1,10);
  LinearCongruentialGenerator_Grid(5,6,7,9,sWorksheetGrid1,11);
  LinearCongruentialGenerator_Grid(7,8,9,10,sWorksheetGrid1,12);
  LinearCongruentialGenerator_Grid(8,9,10,11,sWorksheetGrid1,13);
  LinearCongruentialGenerator_Grid(9,10,11,12,sWorksheetGrid1,14);
  LinearCongruentialGenerator_Grid(10,11,12,13,sWorksheetGrid1,15);
  LinearCongruentialGenerator_Grid(1,2,3,13,sWorksheetGrid1,16);
  LinearCongruentialGenerator_Grid(100,200,300,1300,sWorksheetGrid1,17);
  LinearCongruentialGenerator_Grid(100,200,300,130,sWorksheetGrid1,18);
  LinearCongruentialGenerator_Grid(99,99,99,99,sWorksheetGrid1,19);
  LinearCongruentialGenerator_Grid(4,75,74,65537,sWorksheetGrid1,20)
  //LinearCongruentialGenerator(4,5,6,7,label6);
end;

procedure TForm1.BCMaterialDesignButton10Click(Sender: TObject);
var
  i:integer;
  i2:integer;
  _r_:integer;
  min:integer;
  max:integer;
  min_value:integer;
  max_value:integer;
  Tempo0To100 : array [0..100] of boolean;
  Tempo2_0To100 : array [0..100] of integer;
  Counter_:integer;
begin

  Randomize();
  min:=0;
  max:=100;
  min_value:=Percent_Random0To100;
  min_value:=Percent_Random0To100;
  if (max<min) then max:=min+1;

  //_r_:=2*3+1;  //_r_=7
  //showmessage(_r_.ToString);
  for i := 0 to 100 do
  begin
    Tempo0To100[i]:=false;
    Tempo2_0To100[i]:=0;
  end;

  i:=01;
  while i<=10 do
  begin
    //min+random(10000)mod max + 1;
    Application.ProcessMessages;
    min_value:=MinValue(Random0To100);
    max_value:=MaxValue(Random0To100);

    if(min_value<max_value)and(max_value<Percent_Random0To100)or(min_value=max_value)and(max_value<Percent_Random0To100)then
    begin
      for i2 := 0 to 100 do
      begin
        if(Random0To100[i2]=max_value)then Random0To100[i2]:=Percent_Random0To100;
        if(Random0To100[i2]<max_value)then Random0To100[i2]:=round(Percent_Random0To100/2);
      end;
      continue;
    end;

    _r_:=((min+random(10000))mod (max+1)); //min to max
    if(min_value=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      i:=i+1;
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
    if(Random0To100[_r_]=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      i:=i+1;
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
  end;
  for i := 0 to 100 do
  begin
    sWorksheetGrid3.Cells[1,i+1]:= i.ToString+'='+Random0To100[i].ToString+'%';
    if(Tempo0To100[i]=false)then sWorksheetGrid3.Cells[2,i+1]:= '';
    if(Tempo0To100[i]=true)then sWorksheetGrid3.Cells[2,i+1]:= 'Active';
    sWorksheetGrid3.Cells[3,i+1]:= Tempo2_0To100[i].ToString;
    if(Tempo2_0To100[i]=0)then sWorksheetGrid3.Cells[3,i+1]:= '';
  end;
end;

procedure TForm1.BCMaterialDesignButton11Click(Sender: TObject);
var
  i:integer;
  i2:integer;
  _r_:integer;
  min:integer;
  max:integer;
  min_value:integer;
  max_value:integer;
  Tempo0To100 : array [0..100] of boolean;
  Tempo2_0To100 : array [0..100] of integer;
  Counter_:integer;
begin

  Randomize();
  min:=0;
  max:=100;
  min_value:=Percent_Random0To100;
  min_value:=Percent_Random0To100;
  if (max<min) then max:=min+1;

  //_r_:=2*3+1;  //_r_=7
  //showmessage(_r_.ToString);
  for i := 0 to 100 do
  begin
    Tempo0To100[i]:=false;
    Tempo2_0To100[i]:=0;
  end;

  i:=0;
  while i<=100 do
  begin
    //min+random(10000)mod max + 1;
    Application.ProcessMessages;
    min_value:=MinValue(Random0To100);
    max_value:=MaxValue(Random0To100);

    if(min_value<max_value)and(max_value<Percent_Random0To100)or(min_value=max_value)and(max_value<Percent_Random0To100)then
    begin
      for i2 := 0 to 100 do
      begin
        if(Random0To100[i2]=max_value)then Random0To100[i2]:=Percent_Random0To100;
        if(Random0To100[i2]<max_value)then Random0To100[i2]:=round(Percent_Random0To100/2);
      end;
      continue;
    end;

    _r_:=((min+random(10000))mod (max+1)); //min to max
    if(min_value=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      i:=i+1;
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
    if(Random0To100[_r_]=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      i:=i+1;
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
  end;
  for i := 0 to 100 do
  begin
    sWorksheetGrid3.Cells[1,i+1]:= i.ToString+'='+Random0To100[i].ToString+'%';
    if(Tempo0To100[i]=false)then sWorksheetGrid3.Cells[2,i+1]:= '';
    if(Tempo0To100[i]=true)then sWorksheetGrid3.Cells[2,i+1]:= 'Active';
    sWorksheetGrid3.Cells[3,i+1]:= Tempo2_0To100[i].ToString;
    if(Tempo2_0To100[i]=0)then sWorksheetGrid3.Cells[3,i+1]:= '';
  end;
end;

procedure TForm1.BCMaterialDesignButton2Click(Sender: TObject);
begin
  sWorksheetGrid1.AutoCalc := true;
  sWorksheetGrid1.ColWidths[1]:=300;
  //Set cell content
  sWorksheetGrid1.Cells[1,1] := '=TODAY()';
  // Format as date
  sWorksheetGrid1.Numberformat[1,1] := 'yyyy/mm/dd';
  // Select background color
  sWorksheetGrid1.BackgroundColor[1,1] := clSilver;
  sWorksheetGrid1.Cells[1, 2] := 'Chemical formula of <b>water</b>: H<sub>2</sub>O';
  sWorksheetGrid1.Cells[1, 3] := 1.2345;
  sWorksheetGrid1.Cells[1, 4] := EncodeDate(2016, 1, 18);  //DateTimeToStr(EncodeDate(2016, 1, 18))
  sWorksheetGrid1.Cells[1, 5] := '=A3+2';
  sWorksheetGrid1.Cells[1,6] := '=pi()';
  sWorksheetGrid1.Hyperlink[1,7] := 'www.lazarus-ide.org|Open Lazarus web site';

end;

procedure TForm1.BCMaterialDesignButton3Click(Sender: TObject);
begin
  // Protect the worksheet
  sWorksheetGrid1.Worksheet.Protection := DEFAULT_SHEET_PROTECTION;
  sWorksheetGrid1.Worksheet.Protect(true);

  // Unprotect the writeable cells A1 and C2:C5
  sWorksheetGrid1.CellProtection[1, 1] := [];
  sWorksheetGrid1.CellProtections[3, 2, 3, 5] := [];
end;

procedure TForm1.BCMaterialDesignButton4Click(Sender: TObject);
begin
  // Example for merging
  sWorksheetGrid1.MergeCells(1,1, 3,1);          // Combine the first 3 cells of the first row
  sWorksheetGrid1.Cells[1,1] := 'Summary';       // Write the text "Summary" across the 3 cells
  sWorksheetGrid1.HorAlignment[1,1] := haCenter; // and center it.
end;

procedure TForm1.BCMaterialDesignButton5Click(Sender: TObject);
begin
  // Example for unmerging
  sWorksheetGrid1.UnmergeCells(1,1);             // Splits the merged block (1,1..3,1)
end;

procedure TForm1.BCMaterialDesignButton6Click(Sender: TObject);
var
  j:integer;
  k:Int64;
  l:QWord;
  cl : color;
  c : colors;
begin
  sWorksheetGrid2.ColWidths[1]:=400;
  j:=6;
  sWorksheetGrid2.Cells[1,1]:=  IntToBin(j, 16, 0);
  sWorksheetGrid2.Cells[2,1]:=  j;
  sWorksheetGrid2.Cells[1,2]:=  IntToBin(j, 8, 0);
  sWorksheetGrid2.Cells[2,2]:=  j;
  j:=%0000000000000010;
  sWorksheetGrid2.Cells[1,3]:=  IntToBin(j, 4, 0);
  sWorksheetGrid2.Cells[2,3]:=  j;
  j := j << 2;
  sWorksheetGrid2.Cells[1,4]:=  IntToBin(j, 4, 0);
  sWorksheetGrid2.Cells[2,4]:=  j;
  j := j +3;
  sWorksheetGrid2.Cells[1,5]:=  IntToBin(j, 4, 0);
  sWorksheetGrid2.Cells[2,5]:=  j;
  j := not j;
  sWorksheetGrid2.Cells[1,6]:=  IntToBin(j, 8, 0);
  sWorksheetGrid2.Cells[2,6]:=  j;
  sWorksheetGrid2.Cells[1,7]:=  IntToBin(j, 32, 0);
  sWorksheetGrid2.Cells[2,7]:=  j;
  j := 5 and 5;
  sWorksheetGrid2.Cells[1,8]:=  IntToBin(j, 32, 0);
  sWorksheetGrid2.Cells[2,8]:=  j;
  j := 5 and 4;
  sWorksheetGrid2.Cells[1,9]:=  IntToBin(j, 32, 0);
  sWorksheetGrid2.Cells[2,9]:=  j;
  j := j >> 1;
  sWorksheetGrid2.Cells[1,10]:=  IntToBin(j, 4, 0);
  sWorksheetGrid2.Cells[2,10]:=  j;

  for cl:=red to orange do
  sWorksheetGrid2.Cells[1,11]:=names[cl];
  c:=[red, blue]+[yellow, green];
  c:=[red, blue, yellow, green, white, black, orange] - [green, white];
  c:= [red, blue, yellow, green, white, black, orange]*[green, white];
  c:= [red, blue, yellow, green]><[yellow, green, white, black];

  j:= 2147483647;
  sWorksheetGrid2.Cells[1,12]:=  IntToBin(j, 8*SizeOf(Integer), 0);
  sWorksheetGrid2.Cells[2,12]:=  j;
  j := j xor (j << 13);
  j := j xor (j >> 17);
  j := j xor (j << 5);
  sWorksheetGrid2.Cells[1,13]:=  IntToBin(j, 8*SizeOf(Integer), 0);
  sWorksheetGrid2.Cells[2,13]:=  j;

  j := j xor (j << 13);
  j := j xor (j >> 17);
  j := j xor (j << 5);
  sWorksheetGrid2.Cells[1,14]:=  IntToBin(j, 8*SizeOf(Integer), 0);
  sWorksheetGrid2.Cells[2,14]:=  j;

  j := j xor (j << 13);
  j := j xor (j >> 17);
  j := j xor (j << 5);
  sWorksheetGrid2.Cells[1,15]:=  IntToBin(j, 8*SizeOf(Integer), 0);
  sWorksheetGrid2.Cells[2,15]:=  j;

  k:= 3350834255;
  sWorksheetGrid2.Cells[1,16]:=  IntToBin(k, 8*SizeOf(Int64), 0);
  sWorksheetGrid2.Cells[2,16]:=  k;
  k := k xor (k << 13);
  k := k xor (k >> 17);
  k := k xor (k << 5);
  sWorksheetGrid2.Cells[1,17]:=  IntToBin(k, 64, 0);
  sWorksheetGrid2.Cells[2,17]:=  k;

  j := $ff;
  sWorksheetGrid2.Cells[1,18]:=  IntToBin(j, 32, 0);
  sWorksheetGrid2.Cells[2,18]:=  j;
  j := j AND $0f;
  sWorksheetGrid2.Cells[1,19]:=  IntToBin(j, 32, 0);
  sWorksheetGrid2.Cells[2,19]:=  j;

  l:= 3350834255;
  sWorksheetGrid2.Cells[1,20]:=  IntToBin(l,64, 0);
  sWorksheetGrid2.Cells[2,20]:=  l;
  l := l xor (l << 13);
  l := l xor (l >> 17);
  l := l xor (l << 5);
  sWorksheetGrid2.Cells[1,21]:=  IntToBin(l, 8*SizeOf(QWord), 0);
  sWorksheetGrid2.Cells[2,21]:=  l;


end;

procedure TForm1.BCMaterialDesignButton7Click(Sender: TObject);
var
  i:integer;
  _r_:integer;
  min:integer;
  max:integer;
  min_value:integer;
  max_value:integer;
  Tempo0To100 : array [0..100] of boolean;
  Tempo2_0To100 : array [0..100] of integer;
  Counter_:integer;
begin

  Randomize();
  min:=0;
  max:=100;
  min_value:=Percent_Random0To100;
  min_value:=Percent_Random0To100;
  if (max<min) then max:=min+1;

  //_r_:=2*3+1;  //_r_=7
  //showmessage(_r_.ToString);
  for i := 0 to 100 do
  begin
    Tempo0To100[i]:=false;
    Tempo2_0To100[i]:=0;
  end;
  Counter_:=0;

  for i := 0 to 100 do
  begin
    //min+random(10000)mod max + 1;
    Application.ProcessMessages;
    min_value:=MinValue(Random0To100);
    max_value:=MaxValue(Random0To100);
    _r_:=((min+random(10000))mod (max+1)); //min to max
    if(min_value=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
    if(Random0To100[_r_]=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
  end;
  for i := 0 to 100 do
  begin
    sWorksheetGrid3.Cells[1,i+1]:= i.ToString+'='+Random0To100[i].ToString+'%';
    if(Tempo0To100[i]=false)then sWorksheetGrid3.Cells[2,i+1]:= '';
    if(Tempo0To100[i]=true)then sWorksheetGrid3.Cells[2,i+1]:= 'Active';
    sWorksheetGrid3.Cells[3,i+1]:= Tempo2_0To100[i].ToString;
    if(Tempo2_0To100[i]=0)then sWorksheetGrid3.Cells[3,i+1]:= '';
  end;
end;

procedure TForm1.BCMaterialDesignButton8Click(Sender: TObject);
var
  i:integer;
begin
  Percent_Random0To100:=100;
  for i := 0 to 100 do
  begin
    Random0To100[i]:=Percent_Random0To100;
    sWorksheetGrid3.Cells[1,i+1]:= i.ToString+'='+Random0To100[i].ToString;
    sWorksheetGrid3.Cells[2,i+1]:= '';
    sWorksheetGrid3.Cells[3,i+1]:= '';
  end;
end;

procedure TForm1.BCMaterialDesignButton9Click(Sender: TObject);
var
  i:integer;
  i2:integer;
  _r_:integer;
  min:integer;
  max:integer;
  min_value:integer;
  max_value:integer;
  Tempo0To100 : array [0..100] of boolean;
  Tempo2_0To100 : array [0..100] of integer;
  Counter_:integer;
begin

  Randomize();
  min:=0;
  max:=100;
  min_value:=Percent_Random0To100;
  min_value:=Percent_Random0To100;
  if (max<min) then max:=min+1;

  //_r_:=2*3+1;  //_r_=7
  //showmessage(_r_.ToString);
  for i := 0 to 100 do
  begin
    Tempo0To100[i]:=false;
    Tempo2_0To100[i]:=0;
  end;

  for i := 0 to 100 do
  begin
    //min+random(10000)mod max + 1;
    Application.ProcessMessages;
    min_value:=MinValue(Random0To100);
    max_value:=MaxValue(Random0To100);

    if(min_value<max_value)and(max_value<Percent_Random0To100)or(min_value=max_value)and(max_value<Percent_Random0To100)then
    begin
      for i2 := 0 to 100 do
      begin
        if(Random0To100[i2]=max_value)then Random0To100[i2]:=Percent_Random0To100;
        if(Random0To100[i2]<max_value)then Random0To100[i2]:=round(Percent_Random0To100/2);
      end;
      continue;
    end;

    _r_:=((min+random(10000))mod (max+1)); //min to max
    if(min_value=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
    if(Random0To100[_r_]=max_value)then
    begin
      Random0To100[_r_]:=round(Random0To100[_r_]/2);
      Tempo0To100[_r_]:=true;
      Counter_:=Counter_+1;
      Tempo2_0To100[_r_]:=Counter_;
      continue;
    end;
  end;
  for i := 0 to 100 do
  begin
    sWorksheetGrid3.Cells[1,i+1]:= i.ToString+'='+Random0To100[i].ToString+'%';
    if(Tempo0To100[i]=false)then sWorksheetGrid3.Cells[2,i+1]:= '';
    if(Tempo0To100[i]=true)then sWorksheetGrid3.Cells[2,i+1]:= 'Active';
    sWorksheetGrid3.Cells[3,i+1]:= Tempo2_0To100[i].ToString;
    if(Tempo2_0To100[i]=0)then sWorksheetGrid3.Cells[3,i+1]:= '';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
  c: TGridColumn;
begin
  BCMaterialDesignButton1.Caption:='Linear'+#13#10+'congruential'+#13#10+'generator';
  BCMaterialDesignButton7.Caption:='Random type 1'+#13#10+'For loop=100'+#13#10+'generator';
  BCMaterialDesignButton9.Caption:='Random type 2'+#13#10+'For loop=100'+#13#10+'generator';
  BCMaterialDesignButton10.Caption:='Random type 2'+#13#10+'while loop=1-10'+#13#10+'generator';
  BCMaterialDesignButton11.Caption:='Random type 2'+#13#10+'while =0-100'+#13#10+'generator';
  sWorksheetGrid1.ColCount:=0;
  sWorksheetGrid1.RowCount:=101;
  for i := 1 to 6 do
  begin
    c := sWorksheetGrid1.Columns.Add;
    c.title.caption := Chr(64+i);       // Set columns caption
    c.Alignment := taRightJustify;        // Align column content to the right
    c.color := clMoneyGreen;          // Change default color to clMoneyGreen
    //c.Index := 0;                     // Make it the first column
    sWorksheetGrid1.ColWidths[i]:=30;
    //sWorksheetGrid1.DeleteCol(0);
  end;

  Percent_Random0To100:=100;
  for i := 0 to 100 do
  begin
    sWorksheetGrid1.RowHeights[i]:=30;
    Random0To100[i]:=Percent_Random0To100;
  end;

  sWorksheetGrid1.Refresh;
  sWorksheetGrid1.Repaint;

end;

end.

