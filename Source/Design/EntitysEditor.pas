unit EntitysEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ValEdit;

type
  TEntitysEditorForm = class(TForm)
    paBottom: TPanel;
    buCancel: TButton;
    buOk: TButton;
  private
    FValueEditor: TValueListEditor;

    function GetEntitys: TStrings;
    procedure SetEntitys(const Value: TStrings);
  protected
    function Validate(var vMessage: String): Boolean; virtual;
    procedure SetValues(); virtual;
    procedure PostValues(); virtual;
  public
    constructor Create(Owner: TComponent);

    function Execute: Boolean;
  public
    property Entitys: TStrings read GetEntitys write SetEntitys;
  end;

implementation

{$R *.dfm}

{ TEntitysEditorForm }

constructor TEntitysEditorForm.Create(Owner: TComponent);
begin
  inherited;

  FValueEditor := TValueListEditor.Create(Self);
  FValueEditor.Parent := Self;
  FValueEditor.AlignWithMargins := True;
  FValueEditor.Margins.SetControlBounds(5, 5, 5, 40);
  FValueEditor.Align := alClient;
  FValueEditor.KeyOptions := [keyEdit, keyAdd, keyDelete, keyUnique];
  FValueEditor.TitleCaptions.Clear;
  FValueEditor.TitleCaptions.Add('Unit');
  FValueEditor.TitleCaptions.Add('Class');
end;

function TEntitysEditorForm.Execute: Boolean;
begin
  Result := ShowModal = mrOK;
end;

function TEntitysEditorForm.GetEntitys: TStrings;
begin
  Result := FValueEditor.Strings;
end;

procedure TEntitysEditorForm.PostValues;
begin

end;

procedure TEntitysEditorForm.SetEntitys(const Value: TStrings);
begin
  FValueEditor.Strings.Assign(Value);
end;

procedure TEntitysEditorForm.SetValues;
begin

end;

function TEntitysEditorForm.Validate(var vMessage: String): Boolean;
begin

end;

end.
