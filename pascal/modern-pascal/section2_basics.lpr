program section1_basics; //Program heading

{$mode objfpc}{$H+}{$J+}
{$scopedenums on}
{$R+} //range checking on (debugging)

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,
  sysutils
  { you can add units after this };


procedure MyProcedure(const A: Integer);
begin
  WriteLn('A + 10 is ', A + 10);
end;

function MyFunction(const S: string): string;
begin
  //Functions can return values in one of two ways:
  //1. Call the Exit function with the value to return. This is the
  //equivalent of a return statement.
  //2. Set the Result variable with the return value. Once the function has
  //been completely executed, this value will be returned.
  Result := S + 'something';
  Result := Result + 'something more';
  Result := Result + 'something even more';
end;

function Factorial(const N: Integer): Integer;
begin
  if N > 1 then
    Exit(N * Factorial(N - 1)) //Notice - ; only at end of the full statement
  else
    Exit(1);
end;

{
Operators:
  Variables: :=
  Integer: + - * / div mod
    = <> < > <= >=
  boolean: (relational) and or not xor (takes precedence over comparisons!!)
  Others: (bitwise) and or not xor (takes precedence over comparisons!!)
}

//Enumerated type (non-scoped)
{
type
    TCoffeeType = (cfBlack, cfColdBrew, cfHot, cfSweetened);
}
    //Convention -> start w/ two-letter shortcut to keep namespace neat
    //Or, scoped enums can be used.

//Enumerated type (scoped by compiler directive)
type
  TArrayOfTenString = array [0..9] of string;
  TArrayOfTenStrings1Based = array[1..10] of string;
  TMyRange = 0..9;
  TAlsoArrayOfTenStrings = array[TMyRange] of string;

  TCoffeeType = (Black, ColdBrew, Hot, Sweetened);
  //Enums (and ordinal types) can be used as array indexes
  TCoffeeCosts = array [TCoffeeType] of string;
  //They can also be used ot create sets
  TCoffees = set of TCoffeeType;

var
  X: Single;
  A, B, Index, Value: Integer;
  P: Pointer;
  C: TCoffees;
  MyArray: array [0..9] of Integer;

begin
  WriteLn(MyFunction('Note: '));
  MyProcedure(10);

  X := 15/5;
  WriteLn('X is now: ', X);
  //Notice --> Write & WriteLn routines can take any number of args to print.
  //These arguments can be of any type.
  //These is special syntax for padding & number prcession
  WriteLn('X is now: ', X:1:2);
  //To include a new line in a string, you must use LineEnding constant
  //Notice --> There are no escape sequences.
  WriteLn('This is a multiline string.' + LineEnding + 'This the second line');

  //Factorial
  WriteLn('1! = ', Factorial(1));
  WriteLn('2! = ', Factorial(2));
  WriteLn('3! = ', Factorial(3));
  WriteLn('4! = ', Factorial(4));
  WriteLn('5! = ', Factorial(5));
  WriteLn('6! = ', Factorial(6));

  //If & operators
  A := 0;
  B := 1;
  //if A = 0 and B <> 0 then... //doesn't work due to op precedence
  if (A = 0) and (B <> 0) then
    WriteLn('Hi');

  //Nil
  //Nil is a pointer equal to 0. It is the null pointer of Pascal
  P := nil;
  if P <> nil then
    WriteLn('A is not nil');

  //case of end statement ("switch")
  // Fall-through is not supported
  A := 1;
  case A of
    0: WriteLn('Blah blah');
    1: WriteLn(Factorial(10));
    2..100: WriteLn('these numbers are bad');   //Range
    111, 222, 333: WriteLn('Wow nice numbers'); //List of values
    else WriteLn('uhh'); //default
  end;

  //Enums
  //Enums are "opaque", meaning that it cannot be assigned to/from an integer
  //You can, however, convert enum to int and vice versa

  WriteLn('Coffee Type: ', TCoffeeType.Black,
    ', Index: ', Ord(TCoffeeType.Black));
  WriteLn('Coffee Index: ', 2, ', Type: ', TCoffeeType(2));
  WriteLn('Number of coffee types: ', Ord(High(TCoffeeType)));

  //Sets
  C := [];
  C := [TCoffeeType.Black, TCoffeeType.ColdBrew];
  C := C + [TCoffeeType.Hot];
  C := C * [TCoffeeType.Black];
  Include(C, TCoffeeType.Black);
  Exclude(C, TCoffeeType.Hot);

  //Loops
  //for loop
  //Notice --> You cannot specify how the index value is incremented
  //It is more constrained in that way.
  for Index := 0 to 9 do
    MyArray[Index] := Index * Index;

  //Notice --> You do have the option to use decrementation
  for Index := 9 downto 0 do
    WriteLn('Square is ', MyArray[Index]);

  for Index := Low(MyArray) to High(MyArray) do
    WriteLn('Square is ', MyArray[Index]);

  //while loop
  Index := 0;
  while Index < 10 do
  begin
    WriteLn('Square is ', MyArray[Index]);
    Index += 1; //Inc(Index) works too
  end;

  //repeat loop (equivalent to do-while loop)
  //Runs at least once.
  //Notice --> "until" condition is opposite to "while" condition
  //If condition is true, end looping.
  Index := 0;
  repeat
    WriteLn('Square is ', MyArray[Index]);
    Inc(Index);
  until Index = 10;

  //enhanced for loop (equivalent)
  for Value in MyArray do
    WriteLn('Square is ', Value);
  //Notice --> The for .. in .. do loop can be used to iterate over...
  // - Arrays
  // - All possible values of an enumerated-type
  // - All items in a set
  // - Custom list types

  //String conversions
  WriteLn(IntToStr(1000));
  WriteLn(FloatToStr(1.1));
  WriteLn(Format('%d %f %s', [A, 1.1, 'string']));

  WriteLn();
  WriteLn('Enter an integer:');
  //ReadLn; //Notice -> parentheses are optional for parameter-less functions
  ReadLn(B);
  WriteLn('Factorial of ', B, ': ', Factorial(B));
  ReadLn();
end. //Notice -> The last statement in a program ends with 'end' followed by .

 
