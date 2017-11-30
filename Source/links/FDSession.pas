unit FDSession;

interface

uses
  System.Classes, System.SysUtils, System.Variants, FireDAC.Comp.Client,
  FireDAC.Comp.UI, Data.DB, HSession, HQuery, uHMetadata, uHTable;

type
  TFDSession = class(THSession)
  private
    FConnection: TFDConnection;
    FWaitCursor: TFDGUIxWaitCursor;
    FParams: TStrings;
  private
    procedure SetParams(const Value: TStrings);
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;

    property Connection: TFDConnection read FConnection write FConnection;
  protected
    procedure Insert(Item: TPersistent); override;
    procedure Update(Item: TPersistent); override;
    procedure Delete(Item: TPersistent); override;
  public
    constructor Create(aOwner: TComponent; Metadata: THMetadata); override;

    procedure Connect();
    function GetSqlQuery(): THQuery; override;
  public
    property Params: TStrings read FParams write SetParams;
  end;

implementation

{ TFDSession }

constructor TFDSession.Create(aOwner: TComponent; Metadata: THMetadata);
begin
  inherited;

  FConnection := TFDConnection.Create(Self);
  FWaitCursor := TFDGUIxWaitCursor.Create(Self);
  FParams := TStringList.Create;
end;

procedure TFDSession.Delete(Item: TPersistent);
begin
  inherited;

end;

procedure TFDSession.Connect;
begin
  Connection.Close;
  Connection.Params.Assign(Params);
  Connection.Connected := True;
end;

function TFDSession.GetConnected: Boolean;
begin
  Result := Connection.Connected;
end;

function TFDSession.GetSqlQuery(): THQuery;
begin
//  Result := TFDQuery.Create(Self);
//  Result.Connection := Connection;
end;

procedure TFDSession.Insert(Item: TPersistent);
var
  Table: THTable;
  SqlText: String;
  Query: TFDQuery;
begin
  inherited;

  Table := Metadata.GetTable(Item.ClassType);
  if not Assigned(Table) then
    raise Exception.Create('Объект "' + Item.ClassName + '" не является сущностью');

  Metadata.SetFieldsValues(Item, Table);
  SqlText := Table.GetInsertSql();

  Query := TFDQuery.Create(Self);
  try
    Query.Connection := Connection;
    Query.SQL.Text := SqlText;


  finally
    Query.Free;
  end;

  //SessionFactory.CurrentSession.
end;

procedure TFDSession.SetConnected(const Value: Boolean);
begin
  Connection.Connected := Value;
end;

procedure TFDSession.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
end;

procedure TFDSession.Update(Item: TPersistent);
begin
  inherited;

end;

end.

