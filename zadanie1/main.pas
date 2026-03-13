program Zadanie1;

uses SysUtils;

type
    TDataArray = array of Integer;

procedure GenerateRandomNumbers(var arr: TDataArray; min, max, count: Integer);
var
    i: Integer;
begin
    SetLength(arr, count);
    for i := 0 to count - 1 do
        arr[i] := min + Random(max - min + 1);
end;

procedure BubbleSort(var arr: TDataArray; count: Integer);
var
    i, j, temp: Integer;
begin
    if count < 2 then Exit;
    for i := 0 to count - 2 do
        for j := 0 to count - i - 2 do
            if arr[j] > arr[j + 1] then
            begin
                temp := arr[j];
                arr[j] := arr[j + 1];
                arr[j + 1] := temp;
            end;
end;

procedure TestSortEmpty;
var
    arr: TDataArray;
begin
    Write('Test 1 - Sort Empty: ');
    GenerateRandomNumbers(arr, 0, 100, 0);
    BubbleSort(arr, 0);
    if Length(arr) = 0 then WriteLn('PASS') else WriteLn('FAIL');
end;

procedure TestSortSingleElement;
var
    arr: TDataArray;
begin
    Write('Test 2 - Sort Single: ');
    GenerateRandomNumbers(arr, 5, 5, 1);
    BubbleSort(arr, 1);
    if (Length(arr) = 1) and (arr[0] = 5) then WriteLn('PASS') else WriteLn('FAIL');
end;

procedure TestSortReverse;
var
    arr: TDataArray;
begin
    Write('Test 3 - Sort Reverse: ');
    SetLength(arr, 3);
    arr[0] := 3; arr[1] := 2; arr[2] := 1;
    BubbleSort(arr, 3);
    if (arr[0] = 1) and (arr[1] = 2) and (arr[2] = 3) then WriteLn('PASS') else WriteLn('FAIL');
end;

procedure TestGenerationRange;
var
    arr: TDataArray;
    i: Integer;
    allInRange: Boolean;
begin
    Write('Test 4 - Generation Range (10-20): ');
    GenerateRandomNumbers(arr, 10, 20, 50);
    allInRange := True;
    for i := 0 to 49 do
        if (arr[i] < 10) or (arr[i] > 20) then allInRange := False;
    
    if (Length(arr) = 50) and allInRange then WriteLn('PASS') else WriteLn('FAIL');
end;

procedure TestSortRandom;
var
    arr: TDataArray;
    i: Integer;
    sorted: Boolean;
begin
    Write('Test 5 - Sort Random 50 (0-100): ');
    GenerateRandomNumbers(arr, 0, 100, 50);
    BubbleSort(arr, 50);
    sorted := True;
    for i := 0 to 48 do
        if arr[i] > arr[i + 1] then sorted := False;
    if sorted then WriteLn('PASS') else WriteLn('FAIL');
end;

begin
    Randomize;
    TestSortEmpty;
    TestSortSingleElement;
    TestSortReverse;
    TestGenerationRange;
    TestSortRandom;
end.
