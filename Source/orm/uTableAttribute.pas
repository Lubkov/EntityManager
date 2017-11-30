unit uTableAttribute;

interface

type
  TableAttribute = class(TCustomAttribute)
  private
    FName: String;
  public
    constructor Create(const Name: String);
  public
    property Name: String read FName write FName;
  end;

implementation

{ TableAttribute }

constructor TableAttribute.Create(const Name: String);
begin
  inherited Create();

  Self.Name := Name;
end;

end.
