TRIGGER PROCEDURE FOR WRITE OF tPays NEW new-tPays OLD old-tPays.

ASSIGN new-tPays.dDateMod = NOW.
PUBLISH "dv-s-getUtilId" (OUTPUT new-tPays.iModParId).
{tpaysw.i}

