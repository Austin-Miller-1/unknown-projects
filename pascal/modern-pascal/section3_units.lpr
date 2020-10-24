program section3_units;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Section3Unit, Section3AnotherUnit;
  //Using a unit brings everything declared in the interface into the namespace
  //Notice --> If multiple units define the same identifier,
  //the last unit "wins".
  //To prevent problems, you can use the fully qualified name of the import

var
  InputInt: Integer;
  InputStr: string;

begin
  WriteLn('Provide an integer');
  ReadLn(InputInt);
  MyProcedure(InputInt);

  WriteLn('Provide a string');
  ReadLn(InputStr);
  WriteLn(Section3Unit.MyFunction(InputStr));
  ReadLn();
end.

