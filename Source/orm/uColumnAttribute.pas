unit uColumnAttribute;

interface

uses Variants;

type
  ColumnAttribute = class(TCustomAttribute)
  private
    FName: String;
    FNullable: Boolean;
    FLength: Integer;
    FNullValue: Variant;
  public
    constructor Create(const Name: String;
                       const Nullable: Boolean;
                       const Length: Integer;
                       const NullValue: Variant); overload;


    constructor Create(const Name: String;
                       const Nullable: Boolean;
                       const Length: Integer); overload;

    constructor Create(const Name: String;
                       const Nullable: Boolean); overload;

    constructor Create(const Name: String); overload;
  public
    property Name: String read FName write FName;
    property Nullable: Boolean read FNullable write FNullable;
    property Length: Integer read FLength write FLength;
    property NullValue: Variant read FNullValue write FNullValue;
  end;

implementation

{ ColumnAttribute }

constructor ColumnAttribute.Create(const Name: String;
                                   const Nullable: Boolean;
                                   const Length: Integer);
begin
  Create(Name, Nullable, Length, Null);
end;

constructor ColumnAttribute.Create(const Name: String;
                                   const Nullable: Boolean);
begin
  Create(Name, Nullable, 0, Null);
end;

constructor ColumnAttribute.Create(const Name: String);
begin
  Create(Name, True, 0, Null);
end;

constructor ColumnAttribute.Create(const Name: String;
                                   const Nullable: Boolean;
                                   const Length: Integer;
                                   const NullValue: Variant);
begin
  inherited Create();

  Self.Name := Name;
  Self.Nullable := Nullable;
  Self.Length := Length;
  Self.NullValue := NullValue;
end;

end.
