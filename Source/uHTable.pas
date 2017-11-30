unit uHTable;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Generics.Collections, uHField;

type
  THTable = class(TPersistent)
  private
    FName: String;
    FClassOfType: TClass;
    FFields: TList<THField>;
  private
    function GetField(Index: Integer): THField;
    procedure CheckFieldsCount();
  public
    constructor Create(); overload;
    constructor Create(Name: String; ClassOfType: TClass); overload;
    destructor Destroy; override;
    function Equals(Obj: TObject): Boolean; override;

    function Count(): Integer;
    procedure Clear();
    function Add(Field: THField): Integer;
    procedure ClearValues();

    function GetFieldsCommaText(Prefix: String; PrimaryKey: Boolean): String;
    function GetInsertSql(): String;
    function GetUpdateSql(): String;
    function GetRemoveSql(): String;
  public
    property Name: String read FName write FName;
    property ClassOfType: TClass read FClassOfType write FClassOfType;
    property Fields[Index: Integer]: THField read GetField;
  end;

implementation

{ THTable }

constructor THTable.Create();
begin
  FName := '';
  FClassOfType := nil;
  FFields := TList<THField>.Create;
end;

function THTable.Add(Field: THField): Integer;
begin
  Result := FFields.Add(Field);
end;

procedure THTable.CheckFieldsCount();
begin
  if (Count = 0) then
    raise Exception.Create('Отсутствуют поля у таблицы "' + Name + '"');
end;

procedure THTable.Clear;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Fields[i].Free;
  end;

  FFields.Clear;
end;

procedure THTable.ClearValues;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do begin
    Fields[i].Clear;
  end;
end;

function THTable.Count: Integer;
begin
  Result := FFields.Count;
end;

constructor THTable.Create(Name: String; ClassOfType: TClass);
begin
  Create();

  Self.Name := Name;
  Self.FClassOfType := ClassOfType;
end;

destructor THTable.Destroy;
begin
  Clear;
  FFields.Free;

  inherited;
end;

function THTable.Equals(Obj: TObject): Boolean;
var i: Integer;
begin
  Result := (Obj is THTable) and
            (AnsiCompareStr(THTable(Obj).Name, Name) = 0) and
            (THTable(Obj).ClassOfType = ClassOfType) and
            (THTable(Obj).Count = Count);
  if Result then begin
    for i := 0 to Count - 1 do begin
      if not Fields[i].Equals(THTable(Obj).Fields[i]) then begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function THTable.GetField(Index: Integer): THField;
begin
  Result := FFields[Index];
end;

function THTable.GetFieldsCommaText(Prefix: String; PrimaryKey: Boolean): String;
var
  i: Integer;
begin
  Result := '';
  CheckFieldsCount();

  for i := 0 to Count - 1 do
  begin
    if Fields[i].PrimaryKey <> PrimaryKey then
      Continue;

    if (Result <> '') then
      Result := Result + ',';

    Result := Result + Prefix + Fields[i].Name;
  end;
end;

function THTable.GetInsertSql: String;
begin
  Result := ' INSERT INTO ' + Name + ' (' + GetFieldsCommaText('', False) + ')' +
            ' VALUES (' + GetFieldsCommaText(':', False) + ') ';
end;

function THTable.GetUpdateSql: String;
var
  i: Integer;
  SetSql: String;
  WhereSql: String;
begin
  Result := '';
  SetSql := '';
  WhereSql := '';
  CheckFieldsCount();

  for i := 0 to Count - 1 do
  begin
    if Fields[i].PrimaryKey then begin
      if (WhereSql <> '') then
        WhereSql := WhereSql + ' AND ';
      WhereSql := WhereSql + '(' + Fields[i].Name + ' = :' + Fields[i].Name + ')';
    end
    else begin
      if (SetSql <> '') then
        SetSql := SetSql + ',';
      SetSql := SetSql + Fields[i].Name + ' = :' + Fields[i].Name ;
    end;
  end;

  Result := ' UPDATE ' + Name + ' SET ' + SetSql +
            ' WHERE ' + WhereSql;
end;

function THTable.GetRemoveSql: String;
var
  i: Integer;
  WhereSql: String;
begin
  Result := '';
  WhereSql := '';
  CheckFieldsCount();

  for i := 0 to Count - 1 do
  begin
    if Fields[i].PrimaryKey then begin
      if (WhereSql <> '') then
        WhereSql := WhereSql + ' AND ';
      WhereSql := WhereSql + '(' + Fields[i].Name + ' = :' + Fields[i].Name + ')';
    end;
  end;

  Result := ' DELETE FROM ' + Name + ' WHERE ' + WhereSql;
end;

end.
