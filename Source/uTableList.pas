unit uTableList;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Generics.Collections,
  uHField, uHTable, uEntityLoader;

type
  TTableList = class(TComponent)
  private
    FTables: TList<THTable>;
  private
    function GetTable(Index: Integer): THTable;
    //function IsLeftJoin(aItem: String): Boolean;
  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear();
    function Count(): Integer;
    procedure Load(Entitys: TStrings; Loader: TEntityLoadter);
    function Find(ClassOfType: TClass): THTable; overload;

//    {список связанных таблиц для запроса}
//    function GetLinkedTablesSqlText(aTableName: String): String;
  public
    property Tables[Index: Integer]: THTable read GetTable;
  end;

implementation

{ TTableList }

procedure TTableList.Clear;
var i: Integer;
begin
  for i := 0 to Count - 1 do begin
    FTables[i].Free;
  end;
  FTables.Clear;
end;

function TTableList.Count: Integer;
begin
  Result := FTables.Count;
end;

constructor TTableList.Create(aOwner: TComponent);
begin
  inherited;

  FTables := TList<THTable>.Create;
end;

destructor TTableList.Destroy;
begin
  if Assigned(FTables) then begin
    Clear;
    FTables.Free;
  end;

  inherited;
end;

function TTableList.Find(ClassOfType: TClass): THTable;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    if (Tables[i].ClassOfType = ClassOfType) then begin
      Result := Tables[i];
      Exit;
    end;
  end;
end;

function TTableList.GetTable(Index: Integer): THTable;
begin
  Result := FTables[Index];
end;

procedure TTableList.Load(Entitys: TStrings; Loader: TEntityLoadter);
begin
  Loader.Load(Entitys, FTables);
end;

//function TTableList.GetLinkedTablesSqlText(aTableName: String): String;
//
//   function GetJoin(var aTableName: String): String;
//   begin
//      if IsLeftJoin(aTableName)
//      then
//      begin
//         Result:= 'LEFT JOIN';
//         Delete(aTableName, 1, 1);
//      end
//      else
//      begin
//         Result:= 'INNER JOIN';
//      end;
//   end;
//
//var sItem: String;
//    i: Integer;
//begin
//   Result:= '';
//
//   if (aTableName = '')
//   then
//   begin
//      Exit;
//   end;
//
//   for i:= 0 to Count - 1 do
//   begin
//      sItem:= Items[i];
//
//      if aTableName = sItem
//      then
//      begin
//         Continue;
//      end;
//
//      Result:= Format('%s LEFT JOIN %s ON %s.ID = %s.%s_Ref'#13#10,
//                      [Result,
//                       //GetJoin(sItem),
//                       sItem,
//                       sItem,
//                       aTableName,
//                       sItem]);
//   end;
//end;

//function TTableList.IsLeftJoin(aItem: String): Boolean;
//begin
//   Result:= (aItem[1] = '#');
//end;

end.
