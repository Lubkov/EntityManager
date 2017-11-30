{$IFDEF FireDac}
THSQLQuery = class of TFDQuery;
{$ELSE}
THSQLQuery = class of TQuery;
{$ENDIF}

