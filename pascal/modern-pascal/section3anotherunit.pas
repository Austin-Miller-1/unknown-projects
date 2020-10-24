{$mode objfpc}{$H+}
unit Section3AnotherUnit;
interface

//Notice --> This uses section allows both implementation and interface to
//use imports from the used units
uses
  Classes;

//TComponent is from Classes
procedure DoSomething(var C: TComponent);

implementation

//Notice --> Imports from units used by implementation cannot be referenced
//within interface declarations
uses
  SysUtils;

procedure DoSomething(var C: TComponent);
begin
  //From SysUtils
  FreeAndNil(C);
end;

end.

