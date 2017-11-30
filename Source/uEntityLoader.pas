unit uEntityLoader;

interface

uses
  System.Classes, System.SysUtils, System.Variants, System.TypInfo, System.RTTI,
  Generics.Collections, uHTable, uHField, uTableAttribute, uColumnAttribute,
  uIdAttribute;

type
  TEntityLoadter = class(TComponent)
  private
    FRttiContext: TRttiContext;
  private
    function GetTable(const ClassName: string): THTable;
//    procedure LoadEntityAttribute(Table: THTable);

    property RttiContext: TRttiContext read FRttiContext write FRttiContext;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Load(const Entitys: TStrings; var Tables: TList<THTable>);
    procedure SetFieldsValues(Source: TPersistent; Table: THTable);
  end;

implementation

{ TEntityLoadter }

constructor TEntityLoadter.Create(aOwner: TComponent);
begin
  inherited;

  RttiContext := TRttiContext.Create;
end;

destructor TEntityLoadter.Destroy;
begin
  RttiContext.Free;

  inherited;
end;

function TEntityLoadter.GetTable(const ClassName: string): THTable;
var
  RttiType: TRttiType;
  ClassOfType: TClass;
  Attribute: TCustomAttribute;

  procedure LoadFields();
  var
    RttiProperty: TRttiProperty;
    Attribute: TCustomAttribute;
    Field: THField;
    PrimaryKey: Boolean;
  begin
    for RttiProperty in RttiType.GetProperties do begin
      //if (oProperty.PropertyType.TypeKind = tkClass) then begin
      Field := nil;
      PrimaryKey := False;

      for Attribute in RttiProperty.GetAttributes do begin
        if Attribute is ColumnAttribute then
          Field := THField.Create(ColumnAttribute(Attribute).Name,
                                  ColumnAttribute(Attribute).Nullable,
                                  ColumnAttribute(Attribute).Length,
                                  False);
        if Attribute is IdAttribute then
          PrimaryKey := True;
      end;

      if Assigned(Field) then begin
        Field.PrimaryKey := PrimaryKey;
        Result.Add(Field);
      end;
    end;
  end;

begin
  Result := nil;

  RttiType := RttiContext.FindType(Trim(ClassName));
  if not Assigned(RttiType) and (not RttiType.IsInstance) then begin
    Exit;
  end;

  ClassOfType := RttiType.AsInstance.MetaClassType;
  if not Assigned(ClassOfType) then begin
    Exit;
  end;

  for Attribute in RttiType.GetAttributes do begin
    if Attribute is TableAttribute then begin
      Result := THTable.Create(TableAttribute(Attribute).Name, ClassOfType);
      LoadFields();
      Exit;
    end;
  end;
end;

//procedure TEntityLoadter.LoadEntityAttribute(Table: THTable);
//var
//  RttiType: TRttiType;
//  Attribute: TCustomAttribute;
//begin
//  RttiType:= RttiContext.GetType(Table.ClassOfType.ClassInfo);
//
//  for Attribute in RttiType.GetAttributes do begin
//    if Attribute is DBTable then begin
//      Table.Name := DBTable(Attribute).Name;
//      Exit;
//    end;
//  end;
//end;

procedure TEntityLoadter.Load(const Entitys: TStrings; var Tables: TList<THTable>);
var
  i: Integer;
  ClassName: String;
  //ClassOfType: TClass;
  Table: THTable;
begin
  Tables.Clear;

  for i := 0 to Entitys.Count - 1 do begin
    ClassName := Entitys[i];
    Table := GetTable(ClassName);

    if Assigned(Table) then begin
      Tables.Add(Table);
    end;
  end;
end;

procedure TEntityLoadter.SetFieldsValues(Source: TPersistent; Table: THTable);
var
  i: Integer;
begin
  Table.ClearValues;

  for i := 0 to Table.Count - 1 do begin
    Table.Fields[i].Value := GetPropValue(Source, Table.Fields[i].Name);
  end;
end;

end.
