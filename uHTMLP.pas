unit uHTMLP;

interface
uses
  SysUtils, StrUtils, Classes;

  procedure fAnnsReParser(fName: string);


implementation

const
  scTableStart = '<table class="contentpaneopen"';
  scTableEnd = '</table>';
  scExtension = '.txt';

function fReader(fName: string): string;
var
  f: File;
begin
  AssignFile(f, fName);
  Reset(f, 1);

  SetLength(result, FileSize(f));
  BlockRead(f, result[1], FileSize(f));
  CloseFile(f);
end;

function fExtractTable(buf: string): string;
var
  p1, p2: integer;
  s: string;
begin
  p1:=Pos(scTableStart, buf);
  s:=RightStr(buf, Length(buf) - p1 + 1);
  p2:=Pos(scTableEnd, s);

  result:=LeftStr(s, p2-1 + Length(scTableEnd));
end;

procedure fCreateEx(buf: string; fName: string);
var
  f: File;
begin
  AssignFile(f, fName);
  Rewrite(f, 1);
  BlockWrite(f, buf[1], Length(buf));

  CloseFile(f);
end;

function DelTag(buf: string; tag: string): string;
var
  i, j: integer;
begin
  result:=buf;
  j:=Length(tag);
  while (true) do
    begin
      i:=Pos(tag, result);
      if i=0 then break;
      Delete(result, i, j);
    end;
end;

function fReplaceTags(buf: string; tag: string): string;
begin
  result:=buf;
{
  result:=AnsiReplaceStr(result, '<'+tag+'>', '');
  result:=AnsiReplaceStr(result, '</'+tag+'>', '');
}

  result:=DelTag(result, '<'+tag+'>');
  result:=DelTag(result, '</'+tag+'>');

end;

function fTrim(buf: string):string;
var
  sl: tStringList;
  i: integer;
  s: string;
  c: integer;
begin
  sl:=TStringList.Create();
  sl.Text:=buf;
{
  for i:=0 to sl.Count-1 do
    begin
      sl.Strings[i]:=Trim(sl.Strings[i]);
    end;
}
  result:='';
  c:=0;
  for i:=0 to sl.Count-1 do
    begin
      s:=Trim(sl.Strings[i]);
      if (Length(s) > 0) then
        begin
          inc(c);
          if (c > 2) then
            result:=result+s+#13#10;
        end;
    end;
{
  sl.Text:=result;
  result:='';
  for i:=2 to sl.Count-1 do
    begin
//      if (i mod 2) = 0 then continue;
      result:=result+sl.Strings[i]+#13#10;
    end;
}
  sl.Free();
end;

procedure fAnnsReParser(fName: string);
var
  buf: string;
begin
  buf:=fReader(fName);
  buf:=fExtractTable(buf);
  buf:=DelTag(buf, '<div class="announce">');
  buf:=DelTag(buf, '</div>');
  buf:=fReplaceTags(buf, 'tr');
  buf:=fReplaceTags(buf, 'td');
  buf:=fReplaceTags(buf, 'b');
  buf:=DelTag(buf, '</table>');

//  buf:=fReplaceTags(buf, 'div');
  buf:=fTrim(buf);
  fCreateEx(buf, fName + scExtension);
end;



end.
