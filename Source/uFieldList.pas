unit uFieldList;

interface

uses System.Classes, System.SysUtils, System.Variants, Generics.Collections, uHField;

type
   TFieldList = class
   private
      FItems: TList<THField>;

      function GetItem(Index: Integer): THField;
   protected

   public
      property Items[Index: Integer]: THField read GetItem;
   public
      constructor Create();
      destructor Destroy; override;

      function Count(): Integer;

      function Add(aFieldName, aTableName, aPrefix: String): Integer;

      {список полей, как параметры, для запроса}
      function GetParamList(): String;

      {список полей для запроса}
      function GetFieldsForSelect(): String;
   end;

implementation

uses uServiceUtils;

{ TFieldList }

function TFieldList.Add(aFieldName, aTableName, aPrefix: String): Integer;
begin
   Result:= FItems.Add(THField.Create(aFieldName, aTableName, aPrefix));
end;

function TFieldList.Count: Integer;
begin
   Result:= FItems.Count;
end;

constructor TFieldList.Create;
begin
   FItems:= TList<THField>.Create;
end;

destructor TFieldList.Destroy;
begin
   ClearAndFreeTypedList(TList<TObject>(FItems));

   inherited;
end;

function TFieldList.GetFieldsForSelect(): String;
var i: Integer;
begin
   Result:= '';

   for i:= 0 to Count - 1 do
   begin
      Result:= Format('%s%s.%s as %s, ',
                      [Result,
                       Items[i].TableName,
                       Items[i].FieldName,
                       Items[i].GetAliasName]);
   end;

   Delete(Result, Length(Result) - 1, 2);
end;

function TFieldList.GetItem(Index: Integer): THField;
begin
   Result:= FItems[Index];
end;

function TFieldList.GetParamList: String;
var i: Integer;
begin
   Result:= '';

   for i:= 0 to Count - 1 do
   begin
      Result:= Format('%s :%s, ', [Result, Items[i].FieldName]);
   end;

   Delete(Result, Length(Result), 2);
end;

end.
