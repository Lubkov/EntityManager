unit HTableTest;

interface

uses
  System.Classes, System.SysUtils, System.Variants, TestFramework,
  Generics.Collections, uHTable, uHField;

type
  THTableTest = class(TTestCase)
  private
    FTable: THTable;
  private
    procedure Load();
    function TrimValue(Value: String): String;
    procedure GetInsertSqlNoFields();
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  protected
    property Table: THTable read FTable write FTable;
  public
  published
    procedure GetInsertSqlTest();
    procedure GetInsertSqlNoFieldsTest();
    procedure GetUpdateSqlTest();
    procedure GetRemoveSqlTest();
    procedure CountTest();
    procedure ClearTest();
    procedure GetFieldsCommaTextTest();
    procedure GetFieldsCommaTextWithPrefixTest();
    procedure GetPrimaryKeyCommaTextTest();
    procedure GetPrimaryKeyCommaTextWithPrefixTest();
  end;

implementation

uses uBackground;

{ THTableTest }

procedure THTableTest.ClearTest;
var
  ActualValue: Integer;
  ExpectedValue: Integer;
begin
  ExpectedValue := 0;

  Load();
  Table.Clear;
  ActualValue := Table.Count;
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.CountTest;
var
  ActualValue: Integer;
  ExpectedValue: Integer;
begin
  ExpectedValue := 4;

  Load();
  ActualValue := Table.Count;
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.GetFieldsCommaTextTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue := TrimValue('Name,Width,Height');

  Load();
  ActualValue := TrimValue(Table.GetFieldsCommaText('', False));
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.GetFieldsCommaTextWithPrefixTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue := TrimValue(':Name,:Width,:Height');

  Load();
  ActualValue := TrimValue(Table.GetFieldsCommaText(':', False));
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.GetInsertSqlNoFields;
begin
  Table.GetInsertSql();
end;

procedure THTableTest.GetInsertSqlNoFieldsTest;
begin
  Table.Name := 'Background';
  Table.ClassOfType := TBackground;
  CheckException(GetInsertSqlNoFields, Exception);
end;

procedure THTableTest.GetInsertSqlTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue :=
    TrimValue('INSERT INTO Background (Name,Width,Height) ' +
              'VALUES (:Name,:Width,:Height)');

  Load();
  ActualValue := TrimValue(Table.GetInsertSql());
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.GetPrimaryKeyCommaTextTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue := TrimValue('ID');

  Load();
  ActualValue := TrimValue(Table.GetFieldsCommaText('', True));
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.GetPrimaryKeyCommaTextWithPrefixTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue := TrimValue(':ID');

  Load();
  ActualValue := TrimValue(Table.GetFieldsCommaText(':', True));
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.GetUpdateSqlTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue :=
    TrimValue('UPDATE Background SET Name = :Name,Width = :Width,Height = :Height ' +
              'WHERE (ID = :ID)');

  Load();
  ActualValue := TrimValue(Table.GetUpdateSql());
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.Load;
begin
  Table.Name := 'Background';
  Table.ClassOfType := TBackground;

  Table.Add(THField.Create('ID', False, 0, True));
  Table.Add(THField.Create('Name', False, 256, False));
  Table.Add(THField.Create('Width', False, 0, False));
  Table.Add(THField.Create('Height', False, 0, False));
end;

procedure THTableTest.GetRemoveSqlTest;
var
  ActualValue: String;
  ExpectedValue: String;
begin
  ExpectedValue :=
    TrimValue('DELETE FROM Background WHERE (ID = :ID)');

  Load();
  ActualValue := TrimValue(Table.GetRemoveSql());
  CheckEquals(ExpectedValue, ActualValue);
end;

procedure THTableTest.SetUp;
begin
  inherited;

  FTable := THTable.Create;
end;

procedure THTableTest.TearDown;
begin
  inherited;

  FTable.Free;
end;

function THTableTest.TrimValue(Value: String): String;
begin
  Result := Trim(AnsiLowerCase(Value));
end;

initialization
  RegisterTest(THTableTest.Suite);

end.
