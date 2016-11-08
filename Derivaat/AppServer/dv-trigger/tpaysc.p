TRIGGER PROCEDURE FOR CREATE OF tPays.

ASSIGN tPays.dDateCre = NOW.
PUBLISH "dv-s-getUtilId" (OUTPUT tPays.iCreParId).

