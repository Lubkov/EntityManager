unit uTheUser;

interface

uses System.Classes, System.SysUtils, System.Variants, uEntityCommon, Data.DB;

const
     {Пользователь активен}
     THEUSER_ACTIVED_FALSE_IDX = 0;            THEUSER_ACTIVED_FALSE_NAME = 'Нет';
     THEUSER_ACTIVED_TRUE_IDX = 1;             THEUSER_ACTIVED_TRUE_NAME = 'Да';

     {Тип учетной записи}
     THEUSER_USERROLE_ADMIN_IDX = 0;            THEUSER_USERROLE_ADMIN_NAME = 'Администратор';
     THEUSER_USERROLE_USER_IDX = 1;             THEUSER_USERROLE_USER_NAME = 'Пользователь';

const
   THEUSER_PREFIX = 'User_';

   THEUSER_FIELDS_LIST_SQL_TEXT =
         ' TheUser.ID as ' + THEUSER_PREFIX + 'ID, ' +
         ' TheUser.Name as ' + THEUSER_PREFIX + 'Name, ' +
         ' TheUser.Pwd as ' + THEUSER_PREFIX + 'Pwd, ' +
         ' TheUser.UserRole as ' + THEUSER_PREFIX + 'UserRole, ' +
         ' TheUser.Actived as ' + THEUSER_PREFIX + 'Actived ';

   THEUSER_LINKED_TABLES_SQL_TEXT = '';

type
   TTheUser = class(TEntityCommon)
   private
      FName: String;
      FActived: Boolean;
      FPwd: String;
      FUserRole: Integer;
   published
      property Name: String read FName write FName;
      property Pwd: String read FPwd write FPwd;
      property Actived: Boolean read FActived write FActived;
      property UserRole: Integer read FUserRole write FUserRole;
   public
      procedure Assign(aSource: TTheUser); overload;
      procedure Assign(aDataSet: TDataSet); overload;

      constructor Create();
      destructor Destroy; override;
   end;

implementation

uses uServiceUtils;

{ TTheUser }

procedure TTheUser.Assign(aSource: TTheUser);
begin
   Name:= aSource.Name;
   Actived:= aSource.Actived;
   Pwd:= aSource.Pwd;
   UserRole:= aSource.UserRole;
end;

procedure TTheUser.Assign(aDataSet: TDataSet);
begin
   if not IsNullID(aDataSet.FieldByName(THEUSER_PREFIX + 'ID').Value)
   then
   begin
      ID:= aDataSet.FieldByName(THEUSER_PREFIX + 'ID').AsInteger;
      Name:= aDataSet.FieldByName(THEUSER_PREFIX + 'Name').AsString;
      Actived:= aDataSet.FieldByName(THEUSER_PREFIX + 'Actived').AsInteger = THEUSER_ACTIVED_TRUE_IDX;
      Pwd:= aDataSet.FieldByName(THEUSER_PREFIX + 'Pwd').AsString;
      UserRole:= aDataSet.FieldByName(THEUSER_PREFIX + 'UserRole').AsInteger;
   end;
end;

constructor TTheUser.Create;
begin
   inherited Create(); //TheUser

   Actived:= True;
   UserRole:= THEUSER_USERROLE_USER_IDX;
end;

destructor TTheUser.Destroy;
begin

   inherited;
end;

end.
