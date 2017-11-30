unit EntityManagerReg;

interface

uses
  SysUtils, Classes, DesignIntf;

procedure Register;

implementation

uses EntityManager, EntitysProperty;

procedure Register;
begin
  RegisterComponents('Stellar', [TEntityManager]);
  RegisterPropertyEditor(TypeInfo(TStrings), TEntityManager, 'Entitys', TEntitysProperty);
end;

end.
