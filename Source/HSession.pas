unit HSession;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Data.DB, HQuery, uHMetadata;

type
  THSession = class(TComponent)
  private
    FMetadata: THMetadata;
  protected
    function GetConnected: Boolean; virtual;
    procedure SetConnected(const Value: Boolean); virtual;

    property Metadata: THMetadata read FMetadata;
  public
    constructor Create(aOwner: TComponent; Metadata: THMetadata); virtual;

    procedure Connect(Params: TStrings); virtual;
    function GetSqlQuery(): THQuery; virtual;
    procedure Insert(Item: TPersistent); virtual;
    procedure Update(Item: TPersistent); virtual;
    procedure Delete(Item: TPersistent); virtual;
  public
    property Connected: Boolean read GetConnected write SetConnected;
  end;

implementation

{ THSession }

constructor THSession.Create(aOwner: TComponent; Metadata: THMetadata);
begin
  inherited Create(aOwner);

  FMetadata := Metadata;
end;

procedure THSession.Connect(Params: TStrings);
begin

end;

procedure THSession.Delete(Item: TPersistent);
begin

end;

function THSession.GetConnected: Boolean;
begin
  Result := False;
end;

function THSession.GetSqlQuery: THQuery;
begin

end;

procedure THSession.Insert(Item: TPersistent);
begin

end;

procedure THSession.SetConnected(const Value: Boolean);
begin

end;

procedure THSession.Update(Item: TPersistent);
begin

end;

end.

