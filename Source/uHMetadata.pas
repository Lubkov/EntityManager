unit uHMetadata;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Generics.Collections,
  uHField, uHTable, uTableList, uEntityLoader;

type
  THMetadata = class(TComponent)
  private
    FTableList: TTableList;
    FLoadter: TEntityLoadter;
  protected

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure Load(Entitys: TStrings);

    function GetTable(ClassOfType: TClass): THTable;
    procedure SetFieldsValues(Source: TPersistent; Table: THTable);
  end;

implementation

{ THMetadata }

constructor THMetadata.Create(aOwner: TComponent);
begin
  inherited;

  FLoadter:= TEntityLoadter.Create(Self);
  FTableList := TTableList.Create(Self);
end;

destructor THMetadata.Destroy;
begin

  inherited;
end;

function THMetadata.GetTable(ClassOfType: TClass): THTable;
begin
  Result := FTableList.Find(ClassOfType);
end;

procedure THMetadata.Load(Entitys: TStrings);
begin
  FTableList.Load(Entitys, FLoadter);
end;

procedure THMetadata.SetFieldsValues(Source: TPersistent; Table: THTable);
begin
  FLoadter.SetFieldsValues(Source, Table);
end;

end.

