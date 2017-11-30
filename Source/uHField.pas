unit uHField;

interface

uses
  System.Classes, System.SysUtils, System.Variants;

type
  THField = class(TPersistent)
  private
    FName: String;
    FNullable: Boolean;
    FLength: Integer;
    FPrimaryKey: Boolean;
    FValue: Variant;
  public
    constructor Create(const Name: String;
                       const Nullable: Boolean;
                       const Length: Integer;
                       const PrimaryKey: Boolean);


    function Equals(Obj: TObject): Boolean; override;

    function GetAliasName(Prefix: String): String;

    procedure Clear();

    function IsNull(): Boolean;
    function AsString(): String;
    function AsInteger(): Integer;
    function AsFloat(): Double;
  public
    property Name: String read FName write FName;
    property Nullable: Boolean read FNullable write FNullable;
    property Length: Integer read FLength write FLength;
    property PrimaryKey: Boolean read FPrimaryKey write FPrimaryKey;
    property Value: Variant read FValue write FValue;
  end;

implementation

{ THField }

function THField.AsFloat: Double;
begin
  Result := 0;
  if VarIsOrdinal(Value) or VarIsFloat(Value) then
    Result := Value;
end;

function THField.AsInteger: Integer;
begin
  Result := 0;
  if VarIsOrdinal(Value) or VarIsFloat(Value) then
    Result := Value;
end;

function THField.AsString: String;
begin
  Result := VarToStr(Value);
end;

procedure THField.Clear;
begin
  Value := Null;
end;

constructor THField.Create(const Name: String;
                           const Nullable: Boolean;
                           const Length: Integer;
                           const PrimaryKey: Boolean);
begin
  Self.Name := Name;
  Self.Nullable := Nullable;
  Self.Length := Length;
  Self.PrimaryKey := PrimaryKey;
  Self.Value := Null;
end;

function THField.GetAliasName(Prefix: String): String;
begin
  Result := Prefix + Name;
end;

function THField.IsNull: Boolean;
begin
//  Result := VarToStr(Value) = VarToStr();
end;

function THField.Equals(Obj: TObject): Boolean;
begin
  Result := (Obj is THField) and
            (AnsiCompareStr(THField(Obj).Name, Name) = 0) and
            (THField(Obj).Nullable = Nullable) and
            (THField(Obj).Length = Length) and
            (THField(Obj).PrimaryKey = PrimaryKey);
end;

end.
