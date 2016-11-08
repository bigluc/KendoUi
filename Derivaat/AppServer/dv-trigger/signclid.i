/*------------------------------------------------------------------------

  Program   : signclid.i

  Function  : Write Trigger for Table Signclid

  Author    : 

  Date      : 


Historique des modifications                                
Date        Dvlp    PT          Version   Description             
--------    ------  -------     -------   ---------------------- 
17/10/11    Katsch  PT19604               dv-s-gelib  
20/10/11    steher  PT.19604/1    43.70   finetuning
------------------------------------------------------------------------*/
DEFINE VARIABLE wiTypRafId    AS INTEGER     NO-UNDO.
DEFINE VARIABLE hLibSource    AS HANDLE      NO-UNDO.
DEFINE VARIABLE wlLibStarted  AS LOGICAL     NO-UNDO.  /* L PT.19604/1 steher 20/10/11 */

/* log delete of signcli */
{predelete.i signcli iSignCliId TRUE "EXCEPT cCmt"} /*EVM030708*/  

/************************************
  Delete attdyncli linked to client 
************************************/
FOR EACH attdyncli EXCLUSIVE-LOCK 
    WHERE attdyncli.iValSujId = signcli.iSignCliId : 
  DELETE AttDynCli.
  RELEASE AttDynCli.
END.

/************************************
  Delete adresses linked to client 
************************************/
FOR EACH AdrCli EXCLUSIVE-LOCK WHERE
  AdrCli.iSignCliId = signcli.iSignCliId:
  DELETE AdrCli.
  RELEASE AdrCli.
END.

/********************************************
  Delete telephone numbers linked to client
********************************************/
FOR EACH TelCli EXCLUSIVE-LOCK WHERE
  TelCli.iSignCliId = signcli.iSignCliId:
  DELETE TelCli.
  RELEASE TelCli.
END.

/********************************************
  Delete web adresses linked to client
********************************************/
FOR EACH WebCli EXCLUSIVE-LOCK WHERE
  WebCli.iSignCliId = signcli.iSignCliId:
  DELETE WebCli.
  RELEASE WebCli.
END.

/* B GEEGUN 20081028 - PT4136 */
/***********************************
  Delete contacts linked to client
***********************************/
FOR EACH CntCli EXCLUSIVE-LOCK 
  WHERE CntCli.iSignCliId = SignCli.iSignCliId
  :
  DELETE CntCli.
  RELEASE CntCli.
END.
/* E GEEGUN 20081028 - PT4136 */

/*--- B GEEGUN 20100709 - PT13005 ---*/
/******************************************
  Delete numéro externe linked to client.
******************************************/
FOR EACH NumCliExt EXCLUSIVE-LOCK
  WHERE NumCliExt.iSignCliId = SignCli.iSignCliId
    :
    DELETE NumCliExt.
    RELEASE NumCliExt.
END.

/******************************************
  Delete numéro externe linked to client.
******************************************/
FOR FIRST sLge NO-LOCK 
  WHERE sLge.cCdLog = 'FR'
    :
    FOR FIRST tTypObjt NO-LOCK
      WHERE tTypObjt.iCdLge = sLge.iCdLge
        AND tTypObjt.cCdLog = 'CLI'
        :
        FOR EACH CmtObjt EXCLUSIVE-LOCK
          WHERE CmtObjt.iTypObjtId = tTypObjt.iCdInt
            AND CmtObjt.iRefObjtId = SignCli.iSignCliId
            :
            DELETE CmtObjt.
            RELEASE CmtObjt.
        END.
    END.
END.
/*--- E GEEGUN 20100709 - PT13005 ---*/

/*********************************** 
  Delete liensraf linked to client
***********************************/
/*B, PT19604, KATSCH, 17/10/2011 */                 
ASSIGN hLibSource   = SESSION:FIRST-PROCEDURE         
       wlLibStarted = FALSE   /* L PT.19604/1 steher 20/10/11 */
       .                                            
                                                    
DO WHILE VALID-HANDLE(hLibSource):                  
  IF hLibSource:NAME = "dv-s-gelib.p" THEN LEAVE.   
  ASSIGN hLibSource = hLibSource:NEXT-SIBLING.      
END.                                                
                                                    
/* B PT.19604 steher 20/10/11 */
/* if not found */                                  
IF NOT VALID-HANDLE(hLibSource) 
THEN DO:
  RUN dv-s-gelib.p PERSISTENT SET hLibSource.

  ASSIGN wlLibStarted = TRUE
         .
END.

/* IF NOT VALID-HANDLE(hLibSource) THEN          */
/* /*E, PT19604, KATSCH, 17/10/2011 */           */
/*   RUN dv-s-gelib.p PERSISTENT SET hLibSource. */
/* E PT.19604 steher 20/10/11 */

ASSIGN wiTypRafId = DYNAMIC-FUNCTION('fGetCodeType' IN hLibSource, INPUT 'tTypRaf':U, INPUT 'CLI':U )
       .

FOR EACH liensraf EXCLUSIVE-LOCK
  WHERE liensraf.itypraforiid = wityprafid
    AND liensraf.irefraforiid = signcli.isigncliid
  :
  DELETE liensraf.
  RELEASE liensraf.
END.

FOR EACH liensraf EXCLUSIVE-LOCK
  WHERE liensraf.ityprafdestid = wityprafid
    AND liensraf.irefrafdestid = signcli.isigncliid
  :
  DELETE liensraf.
  RELEASE liensraf.
END.

IF wlLibStarted THEN  /* L PT.19604/1 steher 20/10/11 */
  DELETE PROCEDURE hLibSource.
  
{logsuprec.i &TableName=SignCli} /* DRV-7641 05-08-2016 */
