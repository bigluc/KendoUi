TRIGGER PROCEDURE FOR CREATE OF SignCli.

ASSIGN SignCli.iSignCliId = NEXT-VALUE(SignCliSeq).
{signclic.i}

ASSIGN SignCli.dDateCre = NOW.
PUBLISH "dv-s-getUtilId" (OUTPUT SignCli.iCreParId).

