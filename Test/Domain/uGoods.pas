unit uGoods;

interface

uses System.Classes, System.SysUtils, System.Variants, Data.DB,
     uGoodsType, uBackground, uTableAttribute, uColumnAttribute, uIdAttribute;

const
  GOODS_PREFIX = 'G_';

  GOODS_FIELDS_LIST_SQL_TEXT =
        ' Goods.ID as ' + GOODS_PREFIX + 'ID, ' +
        ' Goods.Name as ' + GOODS_PREFIX + 'Name, ' +
        ' Goods.Number as ' + GOODS_PREFIX + 'Number, ';
        //GOODSTYPE_FIELDS_LIST_SQL_TEXT;

  GOODS_LINKED_TABLES_SQL_TEXT = ' LEFT JOIN GoodsType ON GoodsType.ID = Goods.Goods_Type_Ref ';
                                 //GOODSTYPE_LINKED_TABLES_SQL_TEXT;

type
  //[Table('Goods')]
  TGoods = class(TPersistent)
  private
    FID: Integer;
    FName: String;
    FNumber: Integer;
    FGoodsType: TGoodsType;
  public
    procedure Assign(aSource: TGoods); overload;
    procedure Assign(aDataSet: TDataSet); overload;

    constructor Create();
    destructor Destroy; override;
  published
    [Id]
    [Column('ID', False)]
    property ID: Integer read FID write FID;

    [Column('Name', False, 64)]
    property Name: String read FName write FName;

    [Column('Number')]
    property Number: Integer read FNumber write FNumber;

    [Column('GoodsType')]
    property GoodsType: TGoodsType read FGoodsType write FGoodsType;
  end;

implementation

{ TGoods }

procedure TGoods.Assign(aSource: TGoods);
begin
  Name := aSource.Name;
  Number := aSource.Number;

  GoodsType.Assign(aSource.GoodsType);
  GoodsType.ID := aSource.GoodsType.ID;
end;

procedure TGoods.Assign(aDataSet: TDataSet);
begin
//   if not IsNullID(aDataSet.FieldByName(GOODS_PREFIX + 'ID').Value)
//   then
//   begin
//      ID:= aDataSet.FieldByName(GOODS_PREFIX + 'ID').AsInteger;
//      Name:= aDataSet.FieldByName(GOODS_PREFIX + 'Name').AsString;
//      Number:= aDataSet.FieldByName(GOODS_PREFIX + 'Number').AsInteger;
//
//      GoodsType.Assign(aDataSet);
//   end;
end;

constructor TGoods.Create;
begin
  inherited Create(); //Goods

  FID := 0;
  FName := '';
  FNumber := 0;
  FGoodsType := TGoodsType.Create();
end;

destructor TGoods.Destroy;
begin
//   try
//      FreeWithCheckExist(FGoodsType);
//   except
//   end;

  inherited;
end;

end.

