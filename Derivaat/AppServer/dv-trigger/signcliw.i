/*------------------------------------------------------------------------
Historique des modifications
Date        Dvlp    DRV         Sub-DRV     Version   Description                                
----------  ------  ----------  ----------  --------  ---------------------- 
20140113    GEEGUN  DRV-3527    DRV-3588    V49       Remplissage du champ ddatedecl
20140113    GEEGUN  DRV-3886    DRV-3905    V49       Remplissage du champ cMotCle
20140207    GEEGUN  DRV-3527    DRV-3588    V50       Correction du remplissage du champ dDateDecl
20140210    GEEGUN  DRV-3886    DRV-3905    V50       Ajouté wcCdEntrepPays
20140210    GEEGUN  DRV-3845    DRV-3885    V50
20140218    LEAWUY  DRV-3845    DRV-3885/2  V50       Only add cNum to cMotCle when it is available 
25/03/2014  steher  DRV-3845    DRV-3885/3  50.xx     remove AdrCli.cRue from SignCli.cMotCle
03/07/2014  YVUT    DRV-4956    DRV-4964    50        Champ cMotCle avec commune dans les 2 langues (FR + NL)

------------------------------------------------------------------------------------------------------------------------------*/
DEFINE VARIABLE cListeControle  AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cListeAction    AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cNomClean       AS CHARACTER  NO-UNDO.
DEFINE VARIABLE cPrenomClean    AS CHARACTER  NO-UNDO. /* L GEEGUN 20090727 */ /*--- L GEEGUN 20120102 - PT18163 -  ---*/
DEFINE VARIABLE cError          AS CHARACTER  NO-UNDO.
DEFINE VARIABLE wiCdLge         AS INTEGER    NO-UNDO. /*--- L GEEGUN 20140113 - DRV-3905 (DRV-3886) ---*/
DEFINE VARIABLE wlResult        AS LOGICAL    NO-UNDO. /*--- L GEEGUN 20140207 - DRV-3527 (DRV-3588) ---*/
DEFINE VARIABLE wcCdEntrepPays  AS CHARACTER  INIT "BE"   NO-UNDO.  /*--- L GEEGUN 20140210 - DRV-3886 (DRV-3905) - init "BE" ---*/
DEFINE VARIABLE wcDummyFR       AS CHARACTER  NO-UNDO.              /*L YVUT - DRV-4964*/

DEFINE BUFFER TVA_signcli FOR signcli.

ASSIGN cListeControle = "A-Z" + CHR(1) + "0-9"      
       cListeAction =  "PASACCENT" + CHR(1) +  
                       "MAJUSCULE" + CHR(1) +  
                       "NETTOYAGE".

RUN dv-p-fcleanup.p (INPUT new-SignCli.cNom , 
                     INPUT clistecontrole, 
                     INPUT YES, 
                     INPUT clisteaction,
                     OUTPUT cNomClean,
                     OUTPUT cerror).

/* B GEEGUN 20090727 - PT5841 - remove cPrenomClean */
/* RUN dv-p-fcleanup.p (INPUT new-SignCli.cPrenom , */
/*                      INPUT clistecontrole,       */
/*                      INPUT YES,                  */
/*                      INPUT clisteaction,         */
/*                      OUTPUT cPrenomClean,        */
/*                      OUTPUT cerror).             */

ASSIGN new-SignCli.cNomRech = new-SignCli.cNom + " " + TRIM(cNomClean /* + " " + cPrenomClean*/ ). /* L GEEGUN 20090327 - PT6015 */ /* L GEEGUN 20090727 - PT5841 */ /* L GEEGUN 20091001 - PT8124 */
/* E GEEGUN 20090727 - PT5841 */

ASSIGN new-SignCli.cNomNormal = TRIM(cNomClean). /* PT.13174 */

/*--- B GEEGUN 20120102 - PT18163 ---*/
RUN dv-p-fcleanup.p (INPUT new-SignCli.cPrenom ,
                     INPUT clistecontrole,
                     INPUT YES,
                     INPUT clisteaction,
                     OUTPUT cPrenomClean,
                     OUTPUT cerror).

ASSIGN new-SignCli.cPrenomRech = new-SignCli.cPrenom + " " + TRIM(cPrenomClean).
/*--- E GEEGUN 20120102 - PT18163 ---*/

/* Premier client du numéro de tva => lisroot = true */
IF NOT CAN-FIND (FIRST TVA_signcli NO-LOCK
                 WHERE TVA_signcli.cNum = new-SignCli.cNum AND
                       TVA_signcli.iEntrepPaysId = new-Signcli.iEntrepPaysId AND
                       TVA_signcli.iSignCliId <> new-Signcli.iSignCliId)
    THEN new-Signcli.lIsroot = TRUE.
    
/*--- B GEEGUN 20140113 - DRV-3905 (DRV-3886) ---*/
/**********************************************************
  Remplissage du champ cMotCle pour 'Google Like Search'
**********************************************************/
FOR FIRST sLge NO-LOCK
    WHERE sLge.cCdLog = "FR"
    :
    ASSIGN wiCdLge = sLge.iCdLge
           .
END.

/*--- B GEEGUN 20140210 - DRV-3885 (DRV-3845) ---*/
FOR FIRST tPays NO-LOCK
    WHERE tPays.iCdInt = new-SignCli.iEntrepPaysId
      AND tPays.iCdLge = wiCdLge
    :
    ASSIGN wcCdEntrepPays = tPays.cCdLog
           .
END.
/*--- E GEEGUN 20140210 - DRV-3885 (DRV-3845) ---*/

ASSIGN new-SignCli.cMotCle = ""
       new-SignCli.cMotCle = new-SignCli.cNomRech + " " + new-SignCli.cPrenomRech + " "
                           /*--- B GEEGUN 20140210 - DRV-3885 (DRV-3845) ---*/
                           /* + new-SignCli.cNum + " " + "BE" + new-SignCli.cNum + " " */
                           /* + new-SignCli.cNum + " " + TRIM(wcCdEntrepPays + new-Signcli.cNum) + " " */  /* L - LEAWUY - DRV-3885/2 */
                           /*--- E GEEGUN 20140210 - DRV-3885 (DRV-3845) ---*/
       .

/* B - LEAWUY - DRV-3885/2 */
IF new-SignCli.cNum <> ""
THEN DO:
  ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + new-SignCli.cNum + " " + TRIM(wcCdEntrepPays + new-Signcli.cNum) + " "
         .
END.
/* E - LEAWUY - DRV-3885/2 */

/*B YVUT - DRV-4964*/
FOR EACH AdrCli NO-LOCK WHERE AdrCli.iSignCliId = new-Signcli.iSignCliId
                        AND AdrCli.lDefaut
    :
    FOR FIRST tCdPost NO-LOCK WHERE tCdPost.iCdInt = AdrCli.iCdPostId
                                AND tCdPost.iCdLge = wiCdLge
        :
        ASSIGN  wcDummyFR           = TRIM( tCdPost.cCdLog ) + TRIM( tCdPost.cLibLog )
                new-SignCli.cMotCle = new-SignCli.cMotCle + tCdPost.cCdLog + ' ' + tCdPost.cLibLog + ' '
                .
    END.  /*4FNL tCdPost*/
    /* Do the same but for Lge 'NL' */
    FOR FIRST sLge NO-LOCK WHERE sLge.cCdLog = 'NL'
      , FIRST tCdPost NO-LOCK WHERE tCdPost.iCdInt = AdrCli.iCdPostId
                                AND tCdPost.iCdLge = sLge.iCdLge
        :
        /* Only add when NL-info is different then FR-info */
        IF  wcDummyFR <> TRIM( tCdPost.cCdLog ) + TRIM( tCdPost.cLibLog )
            THEN  ASSIGN  new-SignCli.cMotCle = new-SignCli.cMotCle + tCdPost.cCdLog + ' ' + tCdPost.cLibLog + ' '
                          .
    END.  /*4FNL sLge*/
END.  /*FENL AdrCli*/
/* /* B steher DRV-3885/3 */                                                                                     */
/* /* FOR EACH AdrCli NO-LOCK                                                                                 */ */
/* /*     WHERE AdrCli.iSignCliId = new-Signcli.iSignCliId                                                    */ */
/* /*       AND AdrCli.lDefaut                                                                                */ */
/* /*     :                                                                                                   */ */
/* /*     ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + AdrCli.cRue + " "                                */ */
/* /*            .                                                                                            */ */
/* /*                                                                                                         */ */
/* /*     FOR FIRST tCdPost NO-LOCK                                                                           */ */
/* /*         WHERE tCdPost.iCdInt = AdrCli.iCdPostId                                                         */ */
/* /*           AND tCdPost.iCdLge = wiCdLge                                                                  */ */
/* /*         :                                                                                               */ */
/* /*         ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + tCdPost.cCdLog + " " + tCdPost.cLibLog + " " */ */
/* /*                .                                                                                        */ */
/* /*     END.                                                                                                */ */
/* /* END.                                                                                                    */ */
/* /*hierhier*/                                                                                                  */
/* FOR EACH AdrCli NO-LOCK                                                                                       */
/*                 WHERE AdrCli.iSignCliId = new-Signcli.iSignCliId                                              */
/*                 AND   AdrCli.lDefaut                                                                          */
/*   , FIRST tCdPost NO-LOCK                                                                                     */
/*                   WHERE tCdPost.iCdInt = AdrCli.iCdPostId                                                     */
/*                   AND   tCdPost.iCdLge = wiCdLge                                                              */
/*   :                                                                                                           */
/*   ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + tCdPost.cCdLog + " " + tCdPost.cLibLog + " "             */
/*          .                                                                                                    */
/* END.                                                                                                          */
/* /* E steher DRV-3885/3 */                                                                                     */
/*E YVUT - DRV-4964*/

FOR EACH TelCli NO-LOCK
    WHERE TelCli.iSignCliId = new-Signcli.iSignCliId
      AND TelCli.lDefaut
    :
    ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + TelCli.cNumLoc + " " 
                               + TelCli.cPreLoc + TelCli.cIndLoc + TelCli.cNumLoc + " "
                               + "+" + TelCli.cIndPays + TelCli.cIndLoc + TelCli.cNumLoc + " "
                               + "00" + TelCli.cIndPays + TelCli.cIndLoc + TelCli.cNumLoc + " "
           .
END.

FOR EACH WebCli NO-LOCK
    WHERE WebCli.iSignCliId = new-Signcli.iSigncliId
      AND WebCli.lDefaut
    :
    ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + WebCli.cAdrElect + " "
           .

    IF CAN-FIND(FIRST tTypAdrWeb NO-LOCK WHERE tTypAdrWeb.iCdInt = WebCli.iTypId
                                           AND tTypAdrWeb.cCdLog = "EMAIL"
                                           AND tTypAdrWeb.iCdLge = wiCdLge ) 
    THEN DO:
        ASSIGN new-SignCli.cMotCle = new-SignCli.cMotCle + ENTRY(1, WebCli.cAdrElect, "@") + " "
               .
    END.
END.

ASSIGN new-SignCli.cMotCle = REPLACE(new-SignCli.cMotCle, "  ", " ")
       new-SignCli.cMotCle = RIGHT-TRIM(new-SignCli.cMotCle, " ")
       .
/*--- E GEEGUN 20140113 - DRV-3905 (DRV-3886) ---*/

/*--- B GEEGUN 20140207 - DRV-3588 (DRV-3527) ---*/
/*******************************************************************************************************
  1) On remet les valeurs des champs ddatemod et imodparid,
     si aucun champ, autre que ddatedecl, ddatecre, ddatemod, icreparid et imodparid, a été modifié.
     
  2) On met à jour la date déclencheur quand un champ,
     autre que cmotcle, ddatedecl, ddatecre, ddatemod, icreparid et imodparid, a été modifié.
*******************************************************************************************************/
/* /*--- B GEEGUN 20140113 - DRV-3588 (DRV-3527) ---*/ */
/* ASSIGN new-SignCli.dDateDecl = TODAY                     */
/*        .                                            */
/* /*--- E GEEGUN 20140113 - DRV-3588 (DRV-3527) ---*/ */

BUFFER-COMPARE New-SignCli 
    EXCEPT cMotCle dDateDecl dDateCre dDateMod iCreParId iModParId 
    TO Old-SignCli
    CASE-SENSITIVE
    SAVE wlResult
    .
IF wlResult 
THEN ASSIGN New-SignCli.dDateMod = Old-SignCli.dDateMod
            New-SignCli.iModParId = Old-SignCli.iModParId
            .
ELSE ASSIGN New-SignCli.dDateDecl = New-SignCli.dDateMod 
            .
/*--- E GEEGUN 20140207 - DRV-3588 (DRV-3527) ---*/
