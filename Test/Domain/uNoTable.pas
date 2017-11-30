unit uNoTable;

interface

uses
  System.Classes, System.SysUtils, System.Variants, uTableAttribute,
  uColumnAttribute;

type
  TNoTable = class(TPersistent)
  private
    FID: Variant;
    FName: String;
  public
    constructor Create();
    destructor Destroy; override;
  published
    [Column('ID', False)]
    property ID: Variant read FID write FID;

    [Column('Name', False, 64)]
    property Name: String read FName write FName;
  end;

implementation

{ TNoTable }

constructor TNoTable.Create;
begin

end;

destructor TNoTable.Destroy;
begin

  inherited;
end;

end.

