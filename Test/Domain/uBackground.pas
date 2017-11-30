unit uBackground;

interface

uses System.Classes, System.SysUtils, System.Variants, Data.DB,
     uTableAttribute, uColumnAttribute, uIdAttribute;

type
  [Table('Background')]
  TBackground = class(TPersistent)
  private
    FID: Integer;
    FName: String;
    FWidth: Integer;
    FHeight: Integer;
  public
    procedure Assign(aSource: TBackground); overload;
    procedure Assign(aDataSet: TDataSet); overload;

    constructor Create();
    destructor Destroy; override;
  published
    [Id]
    [Column('ID', False)]
    property ID: Integer read FID write FID;

    [Column('Name', False, 256)]
    property Name: String read FName write FName;

    [Column('Width')]
    property Width: Integer read FWidth write FWidth;

    [Column('Height')]
    property Height: Integer read FHeight write FHeight;
  end;

implementation

{ TBackground }

procedure TBackground.Assign(aSource: TBackground);
begin
  Name := aSource.Name;
  Width := aSource.Width;
  Height := aSource.Height;
end;

procedure TBackground.Assign(aDataSet: TDataSet);
var i: Integer;
begin
//   if not IsNullID(aDataSet.FieldByName('BKG' + '_' + 'ID').Value)
//   then
//   begin
////      if IsPublishedProp (Self, 'Name')
////      then
////      begin
////         SetPropValue(Self, 'Name', aDataSet.FieldByName(Prefix+ '_' + 'Name').Value);
////      end;
//
//      ID:= aDataSet.FieldByName('BKG' + '_' + 'ID').AsInteger;
//      Name:= aDataSet.FieldByName('BKG' + '_' + 'Name').AsString;
//      Width:= aDataSet.FieldByName('BKG' + '_' + 'Width').AsInteger;
//      Height:= aDataSet.FieldByName('BKG' + '_' + 'Height').AsInteger;
//   end;
end;

constructor TBackground.Create;
begin
   inherited;

   ID := 0;
   Name := '';
   Width := 0;
   Height := 0;
end;

destructor TBackground.Destroy;
begin

  inherited;
end;

end.
