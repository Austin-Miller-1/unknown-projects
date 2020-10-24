{$mode objfpc}{$H+}
unit Section3Unit;

//The interface defines the exports of the unit
interface
procedure MyProcedure(const A: Integer);
function MyFunction(const S: string): string;

implementation
uses
  Classes, SysUtils;

procedure MyProcedure(const A: Integer);
begin
  WriteLn(A, ' squared is ', A * A);
end;

function MyFunction(const S: string): string;
begin
  Exit(S + S);
end;

initialization
begin
    WriteLn('Hello world!');
end;

finalization
begin
    WriteLn('Goodbye world!');
end;

end.

