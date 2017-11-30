unit EntitysProperty;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
  DesignIntf, DesignEditors, StrEdit, StringsEdit;

type
  TEntitysProperty = class(TClassProperty)
  protected
    function GetStrings: TStrings; virtual;
    procedure SetStrings(const Value: TStrings); virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
end;

implementation

uses
  EntitysEditor;

{ TEntitysProperty }

procedure TEntitysProperty.Edit;
var
  Dialog: TEntitysEditorForm;
begin
  Dialog := TEntitysEditorForm.Create(Application);
  try
    Dialog.Entitys := GetStrings;

    if Dialog.Execute then
      SetStrings(Dialog.Entitys);
  finally
    Dialog.Free;
  end;
end;

function TEntitysProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

function TEntitysProperty.GetStrings: TStrings;
begin
  Result := TStrings(GetOrdValue);
end;

procedure TEntitysProperty.SetStrings(const Value: TStrings);
begin
  SetOrdValue(Longint(Value));
end;

end.
