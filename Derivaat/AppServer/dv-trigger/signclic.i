
/*------------------------------------------------------------------------

  Program   : signclic.i

  Function  : Creation Trigger for Table SignCli

  Author    : Geert Guns

  Date      : 21/09/2006

  Modified by
  Date        Label       Description                                   User
  ----        -----       -----------                                   ----
  05/05/2008  GEEGUN001   Freeform include setdefaultattdyncli.i        GEEGUN
------------------------------------------------------------------------*/
/* ============================================= */
/* On Creation Of SignCli Record :               */
/*     Automatic Creation Of Attribut dynamic    */
/* ============================================= */

/* B GEEGUN001 20080505 */
/* DEFINE VARIABLE hLibSource   AS HANDLE      NO-UNDO.                               */
/*                                                                                    */
/* RUN dv-s-gelib.p PERSISTENT SET hLibSource.                                        */
/*                                                                                    */
/* RUN setDefaultAttDynCli IN hLibSource (INPUT SignCli.iSignCliId, INPUT FALSE, 0).  */
/*                                                                                    */
/* DELETE PROCEDURE hLibSource.                                                       */

{setDefaultAttDynCli.i}

RUN setDefaultAttdynCli2 (INPUT SignCli.iSignCliId, INPUT FALSE, 0).
/* E GEEGUN001 */

