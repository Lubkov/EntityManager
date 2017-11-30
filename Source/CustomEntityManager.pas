unit CustomEntityManager;

//
//метод возыращает THQuery, собственный класс, с пару методами
//получить SQLQuery типа TFDQuery и метод получения списка List<TPersistent>
//function CreateQuery(QueryString: String): THQuery;
//

interface

{$I EntityManager.inc}

uses
  System.SysUtils, System.Classes, System.TypInfo, System.RTTI,
  Generics.Collections, uHTable, uHField, HSessionFactory, uHMetadata;

type
  TCustomEntityManager = class(TComponent)
  private
    FActive: Boolean;
    FEntitys: TStrings;
    FConnectionParams: TStrings;
    FSessionFactory: THSessionFactory;
    FMetadata: THMetadata;

    function GetIsDesigning: Boolean;
    procedure SetEntitys(const Value: TStrings);
    procedure SetConnectionParams(const Value: TStrings);
  protected
    procedure Loaded(); override;
    function GetSelectSql(ClassOfType: TClass): String;

//    procedure Insert(Item: TPersistent);
//    procedure Update(Item: TPersistent);
//    procedure Delete(Item: TPersistent);
    //function CreateQuery(QueryString: String): TQuery;
  protected
    property Active: Boolean read FActive write FActive;
    property IsDesigning: Boolean read GetIsDesigning;
    property Entitys: TStrings read FEntitys write SetEntitys;
    property Metadata: THMetadata read FMetadata write FMetadata;
    property ConnectionParams: TStrings read FConnectionParams write SetConnectionParams;
    property SessionFactory: THSessionFactory read FSessionFactory write FSessionFactory;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TCustomEntityManager }

constructor TCustomEntityManager.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FEntitys := TStringList.Create;
  FConnectionParams := TStringList.Create;
  FMetadata := THMetadata.Create(Self);
  FSessionFactory := THSessionFactory.Create(Self, FMetadata);
end;

//procedure TCustomEntityManager.Delete(Item: TPersistent);
//begin
//
//end;

destructor TCustomEntityManager.Destroy;
begin
  FEntitys.Free;
  FConnectionParams.Free;

  inherited;
end;

function TCustomEntityManager.GetIsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TCustomEntityManager.GetSelectSql(ClassOfType: TClass): String;
begin

end;

//procedure TCustomEntityManager.Insert(Item: TPersistent);
//var
//  Table: THTable;
//  SqlText: String;
//begin
//  Table := Metadata.GetTable(Item.ClassType);
//  if Assigned(Table) then
//    raise Exception.Create('Объект "' + Item.ClassName + '" не является сущностью');
//
//  FMetadata.SetFieldsValues(Item, Table);
//  SqlText := Table.GetInsertSql();
//
//  //SessionFactory.CurrentSession.
//end;

procedure TCustomEntityManager.Loaded;
begin
  inherited;

  if not IsDesigning then begin
    FMetadata.Load(Entitys);
  end;
end;

procedure TCustomEntityManager.SetConnectionParams(const Value: TStrings);
begin
  FConnectionParams.Assign(Value);
  FSessionFactory.Params := Value;
end;

procedure TCustomEntityManager.SetEntitys(const Value: TStrings);
begin
  FEntitys.Assign(Value);
end;

//procedure TCustomEntityManager.Update(Item: TPersistent);
//begin
//
//end;

end.
