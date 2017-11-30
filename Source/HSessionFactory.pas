unit HSessionFactory;

interface

{$I EntityManager.inc}

uses
  System.Classes, System.SysUtils, System.Variants, Data.DB, HSession, uHMetadata;

type
  THSessionFactory = class(TComponent)
  private
    FParams: TStrings;
    FCurrentSession: THSession;
    FMetadata: THMetadata;
  private
    procedure SetParams(const Value: TStrings);
    function GetCurrentSession: THSession;
  public
    constructor Create(aOwner: TComponent; Metadata: THMetadata);
    destructor Destroy; override;
  public
    property Metadata: THMetadata read FMetadata;
    property Params: TStrings read FParams write SetParams;
    property CurrentSession: THSession read GetCurrentSession;
  end;

implementation

{$IFDEF FireDac}
uses FDSession;
{$ENDIF}

{ THSessionFactory }

constructor THSessionFactory.Create(aOwner: TComponent; Metadata: THMetadata);
begin
  inherited Create(aOwner);

  FMetadata := Metadata;
  FParams := TStringList.Create;
end;

destructor THSessionFactory.Destroy;
begin
  FParams.Free;
  FMetadata := nil;

  inherited;
end;

function THSessionFactory.GetCurrentSession: THSession;
begin
  if not Assigned(FCurrentSession) then begin
    {$IFDEF FireDac}
    FCurrentSession := TFDSession.Create(Self, Metadata);
    {$ELSE}
    FCurrentSession := THSession.Create(Self, Metadata);
    {$ENDIF}
  end;

  Result := FCurrentSession;
end;

procedure THSessionFactory.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
end;

end.
