unit JoinColumnAttribute;

interface

type
  JoinColumn = class(TCustomAttribute)
  private
    FName: String;
  public
    constructor Create(const Name: String);
  public
    property Name: String read FName write FName;
  end;

implementation

{ JoinColumn }

constructor JoinColumn.Create(const Name: String);
begin
  Self.Name:= Name;
end;

end.
