TRIGGER PROCEDURE FOR WRITE OF SignCli NEW new-SignCli OLD old-SignCli.

ASSIGN new-SignCli.dDateMod = NOW.
PUBLISH "dv-s-getUtilId" (OUTPUT new-SignCli.iModParId).

{signcliw.i}

