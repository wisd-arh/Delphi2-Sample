unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ComCtrls, StrUtils;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    SaveDialog1: TSaveDialog;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    Reloadaftercrash1: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure Reloadaftercrash1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Parsing(sl: TStringList);
    procedure ReplaseModel();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  uFInfo, uFSettings, uHTMLP;
{$R *.dfm}

var
  gN: Integer;
  gSize: Integer;

procedure TForm1.N2Click(Sender: TObject);
var
  sl: TStringList;
  s: string;
  f: TextFile;
  col, i, k: integer;
begin
  if (OpenDialog1.Execute) then begin
    AssignFile(f, OpenDialog1.FileName);
    Reset(f);
    sl:=TStringList.Create();
    while not EOF(f) do begin
      readln(f, s);
      sl.Add(s);
    end;
    CloseFile(F);

    StringGrid1.RowCount:=sl.Count;

    col:=1;
    k:=1;
    for i:=0 to sl.Count-1 do begin
      if (col <> 6) or (sl.Strings[i] <> '') then
        StringGrid1.Cells[col, k]:=sl.Strings[i]
      else
        StringGrid1.Cells[col, k]:='Ok';

      inc(col);
      if (col > 6) then begin
        col:=1;
        inc(k);
      end;
    end;
    StringGrid1.RowCount:=k+1;
    ShowMessage('Upload done.' + IntToStr(k) + ' rows.');
  end;
end;

procedure TForm1.N4Click(Sender: TObject);
var
  i, k: integer;
  myRect: TGridRect;

begin
  for i:=1 to StringGrid1.RowCount-1 do
    begin
      if StringGrid1.Cells[4, i] <> '' then
         try
           k:=StrToInt(StringGrid1.Cells[4, i]);
           StringGrid1.Cells[4, i]:=IntToStr(k);
         except

           myRect.Left := 4;
           myRect.Top := i;
           myRect.Right := 4;
           myRect.Bottom := i+1;

           StringGrid1.Selection:=myRect;
           StringGrid1.TopRow:=i;
           exit;
         end;
    end;
  StatusBar1.SimpleText:='All is good.';
end;

procedure TForm1.N6Click(Sender: TObject);
var
  i, k, code: integer;
  s: string;
  f: TextFile;
begin

// INSERT INTO `anns` VALUES  (103,'44444','44444','444444','44444',44444.00,'444444','','','','','Sat Nov 24 18:57:56 2007\n','kate',1,'2-12-2007 23:52:25'),

//  s:='DELETE anns FROM anns WHERE (((anns.user)="sample"));';
//  s:=s+#$A#$D +' INSERT INTO `anns` VALUES ';
  s:='INSERT INTO `anns` VALUES ';
  k:=1000;
  code:=gN;
  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[6, i] <> 'Ok') then continue;
    s:=s+'(';
    s:=s+ IntToStr(code)+ ',';
    s:=s+ '''' + StringGrid1.Cells[1, i] + ''',';
    s:=s+ '''' + StringGrid1.Cells[2, i] + ''',';
    s:=s+ '''' + StringGrid1.Cells[3, i] + ''',';
    s:=s+ '''' + '' + ''',';
    if (StringGrid1.Cells[4, i] <> '') then
      s:=s+ StringGrid1.Cells[4, i] + ','
    else
      s:=s+ '0,';
    s:=s+ '''' + StringGrid1.Cells[5, i] + ''',';
    s:=s+ '''' + '' + ''',';
    s:=s+ '''' + '' + ''',';
    s:=s+ '''' + '' + ''',';
    s:=s+ '''' + '' + ''',';
    s:=s+ '''' + '' + ''',';
    s:=s+ '''' + 'sample' + ''',';
    s:=s+ '0,';
    s:=s+ '''' + '' + ''')';
    inc(code);
    if (Length(s) < gSize) then
      begin
        s:=s+',';
        s:=s+  #$a#$d + ' ';
      end
    else
      begin
        s:=s+';';
        AssignFile(f, Inttostr(k)+'.txt');
        REwrite(f);
        write(f, s);
        Closefile(f);
        inc(k);
        s:='INSERT INTO `anns` VALUES ';
      end;

  end;
  if (s <> 'INSERT INTO `anns` VALUES ') then begin
    if (s[Length(s)] = ' ') then
      s:=Copy(s, 1, Length(s) - 4);
    s:=s+';';
    AssignFile(f, Inttostr(k)+'.txt');
    REwrite(f);
    write(f, s);
    inc(k);
    Closefile(f);
  end;
  StatusBar1.SimpleText:='Done. ' + IntToStr(k-1000) + ' files was added.';
end;

procedure TForm1.N8Click(Sender: TObject);
var
  fname: string;
  f: TextFile;
  sl: TStringList;
  s: string;
begin
  OpenDialog1.Options :=   OpenDialog1.Options - [ofAllowMultiSelect];
  if (OpenDialog1.Execute) then
    fname :=OpenDialog1.FileName
  else exit;
  OpenDialog1.Options :=   OpenDialog1.Options + [ofAllowMultiSelect];

  {$I-}
  AssignFile(f, fname);
  Reset(f);
  {$I+}
  if (IOResult <> 0) then
    begin
      ShowMessage('Не могу открыть файл.');
      exit;
    end;
  sl:=TStringList.Create();

  s:='';
  while not EOF(f) do begin
    readln(f, s);
    sl.Add(s);
  end;
  CloseFile(f);
  Parsing(sl);


  StatusBar1.SimpleText:='Done. Rows-'+IntToStr(sl.Count);
end;

procedure TForm1.Parsing(sl: TStringList);
var
  i: integer;
  s, s1: string;
  p: integer;
  b, m, desc, tel, price, subdesc: string;
  f1, f2, f3: boolean;
  d: double;
  errlist: TStringList;
  s_orig: string;
begin

  StringGrid1.RowCount:=sl.Count;

  errlist:=TStringList.Create;

  for i:=0 to sl.Count-1 do begin
try
    f1:=false;
//    f2:=false;
    f3:=true;
    s:=sl.Strings[i];
    s_orig:=s;
    p:=Pos(' ', s);
    s1:=Copy(s, 1, p-1);

    s1:=AnsiReplaceStr(s1, '"', '');
    s1:=AnsiReplaceStr(s1, ',', '');

    b:=Copy(s1, 1, Pos('-', s1)-1);
    b:=AnsiUpperCase(b);
    m:=Copy(s1, Pos('-', s1)+1, Length(s1)-Pos('-', s1));
    m:=AnsiUpperCase(m);


    s1:=Copy(s, p+1, Length(s)-p);

    if (Pos('Тел.', s1) = 0) then
      s1:=AnsiReplaceText(s1, ' Тел ', ' Тел. ');
    tel:=Copy(s1, Pos('Тел.', s1), Length(s1) - Pos('Тел.', s1));
    if Pos('Тел.', s1) > 0 then
      f1:=true;
    s1:=Copy(s1, 1, Pos('Тел.', s1)-1);

    b:=Trim(b);
    m:=Trim(m);
    s1:=Trim(s1);
    tel:=Trim(tel);
    price:='';
    subdesc:='';

    if (Pos(' - ', s1) > 0) then begin
      desc:=Copy(s1, 1, Pos(' - ', s1)-1);
      f2:=true;
      price:=Copy(s1, Pos(' - ', s1)+3, Length(s1) - (Pos(' - ', s1)+3));
      price:=Trim(price);

      if (Pos(' т.р.', price) > 0) and (Pos(' т.р.', price)+5 < Length(price)) then
        begin
          subdesc:=Copy(price, Pos(' т.р.', price)+5, Length(price) - (Pos(' т.р.', price)+4));
          price:=Copy(price, 1, Pos(' т.р.', price)+4);
          subdesc:=Trim(subdesc);
          desc:= desc + ' ' + subdesc;
        end
      else
      if (Pos(' т.р', price) > 0) and (Pos(' т.р', price)+4 < Length(price)) then
        begin
          subdesc:=Copy(price, Pos(' т.р', price)+4, Length(price) - (Pos(' т.р', price)+3));
          price:=Copy(price, 1, Pos(' т.р', price)+4);
          desc:=Trim(desc);
          if (desc[Length(desc)] <> '.') then
            desc:=desc+'.';
          subdesc:=Trim(subdesc);
          desc:= desc + ' ' + subdesc;
        end;

      if (Pos('т.р', price) > 0) then
        price:=AnsiReplaceText(price, 'млн', '')
      else
        price:=AnsiReplaceText(price, 'млн', '000000');
      price:=AnsiReplaceText(price, 'т.р', '000');
      price:=AnsiReplaceText(price, ' ', '');
      price:=AnsiReplaceText(price, '.', '');

      if (Length(price) > 0) then begin
        try
          d:=StrToFloat(price);
          if (d > 0) then f3:=true; // заглушка для компилятора
        except
          f3:=false;
        end;
      end;
    end else begin
      desc:=s1;
      f2:=true;
    end;

    price:=Trim(price);


    desc:=Trim(desc);
    if (desc[Length(desc)] <> '.') then
      desc:=desc+'.';

    StringGrid1.Cells[1, i+1]:=b;
    StringGrid1.Cells[2, i+1]:=m;
    StringGrid1.Cells[3, i+1]:=desc;
    StringGrid1.Cells[4, i+1]:=price;
    StringGrid1.Cells[5, i+1]:=tel;

    if (Length(b) > 0) and
       (Length(m) > 0) and
       (f1 = true)     and
       (f3 = true)     and
       (f2 = true)
       then begin
      StringGrid1.Cells[6, i+1]:='Ok';
    end;
except
  errlist.Add(s_orig);
end;
  end;

  if errlist.Count > 0 then begin
    Form2.Memo1.Clear;
    Form2.Memo1.Lines.Assign(errlist);
    Form2.ShowModal;
  end;
end;

procedure TForm1.N9Click(Sender: TObject);
var
  i: integer;
  myRect: TGridRect;
begin
  for i:=1 to StringGrid1.RowCount-1 do begin
    if StringGrid1.Cells[6, i] <> 'Ok' then begin
       myRect.Left := 4;
       myRect.Top := i;
       myRect.Right := 4;
       myRect.Bottom := i+1;

       StringGrid1.Selection:=myRect;
       StringGrid1.TopRow:=i;
       exit;
    end;

  end;

end;

procedure TForm1.N10Click(Sender: TObject);
var
  i, p: integer;
  myRect: TGridRect;
begin
  p:=StringGrid1.Selection.Top+1;

  for i:=p to StringGrid1.RowCount-1 do begin
    if StringGrid1.Cells[6, i] <> 'Ok' then begin
       myRect.Left := 4;
       myRect.Top := i;
       myRect.Right := 4;
       myRect.Bottom := i+1;

       StringGrid1.Selection:=myRect;
       StringGrid1.TopRow:=i;
       exit;
    end;

  end;

end;

procedure TForm1.N11Click(Sender: TObject);
const
  fname = 'AutoP.txt';
var
  i, j: integer;
  f: TextFile;
  sl: TStringList;
  s: string;
  s1, s2: string;
begin
  {$I-}
  AssignFile(f, ExtractFilePath(Application.ExeName)+ '\'+fname);
  Reset(f);
  {$I+}
  if (IOResult <> 0) then
    begin
      ShowMessage('Не могу открыть файл.');
      exit;
    end;
  sl:=TStringList.Create();

  s:='';
  while not EOF(f) do begin
    readln(f, s);
    sl.Add(s);
  end;
  CloseFile(f);


  for i:=0 to sl.Count-1 do begin
    s:=sl.Strings[i];
    s1:=LeftStr(s, Pos(' ', s)-1);
    s2:=RightStr(s, Length(s)-Pos(' ', s));
    if s2 <> '' then
      for j:=1 to StringGrid1.RowCount-1 do
        if (s1 = StringGrid1.Cells[1, j]) then begin
          StringGrid1.Cells[1, j]:=s2;
          if (StringGrid1.Cells[6, j] = 'Ok') then
            StringGrid1.Cells[6, j]:='+';
        end;
  end;
  ReplaseModel();
end;

procedure TForm1.ReplaseModel;
const
  fname = 'Models.txt';
var
  i, j: integer;
  f: TextFile;
  sl: TStringList;
  s: string;
  s1, s2: string;
  d: integer;
begin
  {$I-}
  AssignFile(f, ExtractFilePath(Application.ExeName)+ '\'+fname);
  Reset(f);
  {$I+}
  if (IOResult <> 0) then
    begin
      ShowMessage('Не могу открыть файл.');
      exit;
    end;
  sl:=TStringList.Create();

  s:='';
  while not EOF(f) do begin
    readln(f, s);
    sl.Add(s);
  end;
  CloseFile(f);


  for i:=0 to sl.Count-1 do begin
    s:=sl.Strings[i];
    s1:=LeftStr(s, Pos(' ', s)-1);
    s2:=RightStr(s, Length(s)-Pos(' ', s));
    if s2 <> '' then
      for j:=1 to StringGrid1.RowCount-1 do
        if (s1 = StringGrid1.Cells[2, j]) then begin
          StringGrid1.Cells[2, j]:=s2;
          if (StringGrid1.Cells[6, j] = '+') then
            StringGrid1.Cells[6, j]:='!';
        end;
  end;
  for j:=1 to StringGrid1.RowCount-1 do begin
    try
      d:=StrToInt(StringGrid1.Cells[2, j]);
    except
      d:=-1;
    end;
    if (d > 0) and (StringGrid1.Cells[6, j] = '+') then
      StringGrid1.Cells[6, j]:='!';

  end;


end;

procedure TForm1.N12Click(Sender: TObject);
var
  i, j: integer;
  s, s1: string;
begin
  s:='йцукенгшщзхъэждлорпавыфячсмитьбю';
  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[6, i] = '+') then begin
      s1:=AnsiLowerCase(StringGrid1.Cells[2, i]);
      for j:=1 to Length(s1) do
        if (Pos(s1[j], s) > 0) then
          StringGrid1.Cells[6, i] := '-';
    end;
  end;


  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[6, i] = '+') and (Length(StringGrid1.Cells[2, i]) > 3) then begin
      StringGrid1.Cells[2, i]:=AnsiUpperCase(StringGrid1.Cells[2, i][1]) + RightStr(AnsiLowerCase(StringGrid1.Cells[2, i]), Length(StringGrid1.Cells[2, i]) - 1);
      StringGrid1.Cells[6, i] := '!';
    end;
  end;
  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[6, i] = '!') then
      StringGrid1.Cells[6, i] := 'Ok'
    else
      StringGrid1.Cells[6, i] := '';
  end;


end;

procedure TForm1.N13Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[6, i] = 'Ok') then begin
      s:=StringGrid1.Cells[1, i];
      s:=AnsiLowerCase(s);
      s[1]:=AnsiUpperCase(s[1])[1];
      StringGrid1.Cells[1, i]:=s;

      s:=StringGrid1.Cells[2, i];
      s:=AnsiLowerCase(s);
      s[1]:=AnsiUpperCase(s[1])[1];
      StringGrid1.Cells[2, i]:=s;
    end;

  end;
end;

procedure TForm1.N14Click(Sender: TObject);
var
  fname: string;
  i: integer;
  f: TextFile;
  mr: Word;
begin
  if (SaveDialog1.Execute) then
    fname:=SaveDialog1.FileName
  else exit;

  if FileExists(fname) then begin
    mr := MessageDlg('Файл ' + fname + ' уже существует.' + #$A#$D+ 'Заменить файл?', mtConfirmation, mbYesNoCancel, 0);
    if mr = mrYes then begin
      DeleteFile(fname);
    end
    else if mr <> mrNo then exit;

  end;
  AssignFile(f, fname);
  if FileExists(fname) then begin
    Append(f);

  end else
    Rewrite(f);

  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[6, i] = 'Ok') then begin
      WriteLn(f, StringGrid1.Cells[1, i]);
      WriteLn(f, StringGrid1.Cells[2, i]);
      WriteLn(f, StringGrid1.Cells[3, i]);
      WriteLn(f, StringGrid1.Cells[4, i]);
      WriteLn(f, StringGrid1.Cells[5, i]);
      WriteLn(f, '');
    end;
  end;
  CloseFile(f);

  StatusBar1.SimpleText:='Upload done.';
end;

procedure TForm1.N15Click(Sender: TObject);
begin
  Form3.ShowModal;
  if (Form3.ModalResult = mrOk) then begin
    try
      gN:=StrToInt(Form3.Edit1.Text);
    except
      gN:=5000;
      ShowMessage('Не верно указан стартовый номер записи.');
    end;
    try
      gSize:=StrToInt(Form3.Edit2.Text);
    except
      gSize:=20000;
      ShowMessage('Не верно указан максимальный размер запроса.');
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  gN:=5000;
  gSize:=20000;
end;

procedure TForm1.N18Click(Sender: TObject);
var
  i: integer;

begin
  OpenDialog1.Filter:='Html files|*.htm;*.html';
  OpenDialog1.Options:=  OpenDialog1.Options + [ofAllowMultiSelect];
  if (OpenDialog1.Execute) then
    begin
      for i:=0 to OpenDialog1.Files.Count-1 do
        begin
          fAnnsReParser(OpenDialog1.Files[i]);
          Application.ProcessMessages();
        end;
    end;

  StatusBar1.SimpleText:='Extract done.';

  OpenDialog1.Options:=  OpenDialog1.Options - [ofAllowMultiSelect];

  OpenDialog1.Filter:='*.txt|*.txt';
end;

procedure TForm1.Reloadaftercrash1Click(Sender: TObject);
begin

  WinExec('annsparser.exe', SW_SHOW);
  Close();
end;

end.
