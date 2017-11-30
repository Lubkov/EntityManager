unit HQuery;

{$I EntityManager.inc}

interface

uses
  {$IFDEF FireDac}
  FireDAC.Comp.Client,
  {$ENDIF}
  System.Classes, System.SysUtils, System.Variants;

type
  {$I Query.inc}

  THQuery = class(TComponent)
  private
    FSQLQuery: THSQLQuery;
  public
    property SQLQuery: THSQLQuery read FSQLQuery write FSQLQuery;
  end;

implementation

end.
