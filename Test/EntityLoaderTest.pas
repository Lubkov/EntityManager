unit EntityLoaderTest;

interface

uses
  System.Classes, System.SysUtils, System.Variants, TestFramework, uEntityLoader,
  Generics.Collections, uHTable, uHField;

type
  TEntityLoaderTest = class(TTestCase)
  private
    FEntityLoadter: TEntityLoadter;
  protected
    procedure SetUp; override;
    procedure TearDown; override;

    property EntityLoadter: TEntityLoadter read FEntityLoadter write FEntityLoadter;
  public
  published
    procedure LoadTest();
    procedure LoadFailTableAttributeTest();
    procedure LoadFieldValuesTest();
  end;

implementation

{ TEntityLoaderTest }

uses uBackground, uGoodsType, uGoods, uNoFields, uNoTable;

procedure TEntityLoaderTest.LoadFailTableAttributeTest;
var
  i: Integer;
  UnitList: TStrings;
  ActualValue: Integer;
  ExpectedValue: Integer;
  Tables: TList<THTable>;
begin
  UnitList:= TStringList.Create;
  try
    ExpectedValue := 1;
    UnitList.Add('uNoTable.TNoTable');
    Tables := TList<THTable>.Create;
    try
      EntityLoadter.Load(UnitList, Tables);
      ActualValue := Tables.Count;
      CheckNotEquals(ExpectedValue, ActualValue);
    finally
      Tables.Free;
    end;
  finally
    UnitList.Free;
  end;
end;

procedure TEntityLoaderTest.LoadFieldValuesTest;
var
  i: Integer;
  Entity: TBackground;
  Table: THTable;
begin
  Entity := TBackground.Create;
  try
    Entity.ID := 99;
    Entity.Name := 'Image name';
    Entity.Width := 120;
    Entity.Height := 32;

    Table := THTable.Create('Background', TBackground);
    try
      Table.Add(THField.Create('ID', False, 0, True));
      Table.Add(THField.Create('Name', False, 256, False));
      Table.Add(THField.Create('Width', True, 0, False));
      Table.Add(THField.Create('Height', True, 0, False));

      EntityLoadter.SetFieldsValues(Entity, Table);

      CheckEquals(Entity.ID, Table.Fields[0].AsInteger);
      CheckEquals(Entity.Name, Table.Fields[1].AsString);
      CheckEquals(Entity.Width, Table.Fields[2].AsInteger);
      CheckEquals(Entity.Height, Table.Fields[3].AsInteger);
    finally
      Table.Free;
    end;
  finally
    Entity.Free;
  end;
end;

procedure TEntityLoaderTest.LoadTest;
var
  i: Integer;
  UnitList: TStrings;
  ActualValue: TList<THTable>;
  ExpectedValue: TList<THTable>;
begin
  UnitList:= TStringList.Create;
  try
    ExpectedValue:= TList<THTable>.Create;
    try
      ExpectedValue.Add(THTable.Create('Background', TBackground));
      ExpectedValue.Items[ExpectedValue.Count - 1].Add(THField.Create('ID', False, 0, True));
      ExpectedValue.Items[ExpectedValue.Count - 1].Add(THField.Create('Name', False, 256, False));
      ExpectedValue.Items[ExpectedValue.Count - 1].Add(THField.Create('Width', True, 0, False));
      ExpectedValue.Items[ExpectedValue.Count - 1].Add(THField.Create('Height', True, 0, False));

      ExpectedValue.Add(THTable.Create('NoFields', TNoFields));

      ExpectedValue.Add(THTable.Create('GoodsType', TGoodsType));
      ExpectedValue.Items[ExpectedValue.Count - 1].Add(THField.Create('ID', False, 0, True));
      ExpectedValue.Items[ExpectedValue.Count - 1].Add(THField.Create('Name', False, 64, False));

      UnitList.Add('uBackground.TBackground');
      UnitList.Add('uNoFields.TNoFields');
      UnitList.Add('uGoodsType.TGoodsType');
      UnitList.Add('uNoTable.TNoTable');

      ActualValue := TList<THTable>.Create;
      try
        EntityLoadter.Load(UnitList, ActualValue);
        CheckEquals(ExpectedValue.Count, ActualValue.Count);

        for i := 0 to ExpectedValue.Count - 1 do begin
          CheckEquals(ExpectedValue.Items[i].Equals(ActualValue.Items[i]), True);
        end;
      finally
        ActualValue.Free;
      end;
    finally
      ExpectedValue.Free;
    end;
  finally
    UnitList.Free;
  end;
end;

procedure TEntityLoaderTest.SetUp;
begin
  inherited;

  FEntityLoadter:= TEntityLoadter.Create(nil);
end;

procedure TEntityLoaderTest.TearDown();
begin
  inherited;

  FEntityLoadter.Free;
end;

initialization
  RegisterTest(TEntityLoaderTest.Suite);

end.
