unit uNoFields;

interface

uses
  System.Classes, System.SysUtils, System.Variants, uTableAttribute,
  uColumnAttribute;

type
  [Table('NoFields')]
  TNoFields = class(TPersistent)
  private
  public
    constructor Create();
    destructor Destroy; override;
  published
  end;

implementation

{ TNoFields }

constructor TNoFields.Create;
begin

end;

destructor TNoFields.Destroy;
begin

  inherited;
end;

end.
