program EntityManagerTest;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  EntityLoaderTest in 'EntityLoaderTest.pas',
  uBackground in 'Domain\uBackground.pas',
  uGoods in 'Domain\uGoods.pas',
  uGoodsType in 'Domain\uGoodsType.pas',
  uNoFields in 'Domain\uNoFields.pas',
  uNoTable in 'Domain\uNoTable.pas',
  HTableTest in 'HTableTest.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

