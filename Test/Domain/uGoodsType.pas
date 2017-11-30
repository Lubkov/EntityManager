unit uGoodsType;

interface

uses System.Classes, System.SysUtils, System.Variants, Data.DB,
     uBackground, uTableAttribute, JoinColumnAttribute, uColumnAttribute,
     uIdAttribute;

type
  [Table('GoodsType')]
  TGoodsType = class(TPersistent)
  private
    FID: Variant;
    FName: String;
    FBackground: TBackground;
  public
    procedure Assign(aSource: TGoodsType); overload;
    procedure Assign(aDataSet: TDataSet); overload;

    constructor Create();
    destructor Destroy; override;
  published
    [Id]
    [Column('ID', False)]
    property ID: Variant read FID write FID;

    [Column('Name', False, 64)]
    property Name: String read FName write FName;

    [JoinColumn('Background_Ref')]
    property Background: TBackground read FBackground write FBackground;
  end;

implementation

{ TGoodsType }

procedure TGoodsType.Assign(aSource: TGoodsType);
begin
  Name := aSource.Name;
  Background.Assign(aSource.Background);
  Background.ID := aSource.Background.ID;
end;

procedure TGoodsType.Assign(aDataSet: TDataSet);
begin
//   if not IsNullID(aDataSet.FieldByName('GT' + '_' + 'ID').Value)
//   then
//   begin
//      ID:= aDataSet.FieldByName('GT' + '_' + 'ID').AsInteger;
//      Name:= aDataSet.FieldByName('GT' + '_' + 'Name').AsString;
//
//      Background.Assign(aDataSet);
//   end;
end;

constructor TGoodsType.Create;
begin
  inherited Create();  //GoodsType

  FID := Null;
  FName := '';
  FBackground := TBackground.Create();
end;

destructor TGoodsType.Destroy;
begin
//  try
//     FreeWithCheckExist(FBackground);
//  except
//  end;

  inherited;
end;

end.

