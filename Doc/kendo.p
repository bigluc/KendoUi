/* WRITE-XML */
DEFINE VARIABLE cTargetType     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFile           AS CHARACTER NO-UNDO.
DEFINE VARIABLE lFormatted      AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cEncoding       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSchemaLocation AS CHARACTER NO-UNDO.
DEFINE VARIABLE lWriteSchema    AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lMinSchema      AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lRetOK          AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lfound          AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cquerystring    AS CHARACTER NO-UNDO.

DEFINE VARIABLE wcapplication AS CHARACTER  NO-UNDO.
DEFINE VARIABLE wcscreen      AS CHARACTER  NO-UNDO.

DEFINE VARIABLE whdataset     AS HANDLE     NO-UNDO.
DEFINE VARIABLE whrelation    AS HANDLE     NO-UNDO.

/* bdwrpscre */
DEFINE BUFFER   bdwrpscre         FOR dwrpscre.
DEFINE VARIABLE whdwrpscre        AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrpscre      AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrpscre     AS HANDLE     NO-UNDO.
whdwrpscre     = BUFFER bdwrpscre:HANDLE.
CREATE TEMP-TABLE whttdwrpscre.
whttdwrpscre:CREATE-LIKE(whdwrpscre).
whttdwrpscre:TEMP-TABLE-PREPARE("Screens").  
wbhttdwrpscre = whttdwrpscre:DEFAULT-BUFFER-HANDLE. 

/* dwrpScreTran */
DEFINE BUFFER   bdwrpScreTran     FOR dwrpScreTran.
DEFINE VARIABLE whdwrpScreTran    AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrpScreTran  AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrpScreTran AS HANDLE     NO-UNDO.
whdwrpScreTran = BUFFER bdwrpScreTran:HANDLE.
CREATE TEMP-TABLE whttdwrpScreTran.
whttdwrpScreTran:CREATE-LIKE(whdwrpScreTran).
whttdwrpScreTran:TEMP-TABLE-PREPARE("ScreensTranslation").  
wbhttdwrpScreTran = whttdwrpScreTran:DEFAULT-BUFFER-HANDLE. 

/* dwrppagescre */ 
DEFINE BUFFER   bdwrppagescre     FOR dwrppagescre.
DEFINE VARIABLE whdwrppagescre    AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrppagescre  AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrppagescre AS HANDLE     NO-UNDO.
whdwrppagescre = BUFFER bdwrppagescre:HANDLE.
CREATE TEMP-TABLE whttdwrppagescre.
whttdwrppagescre:CREATE-LIKE(whdwrppagescre).
whttdwrppagescre:TEMP-TABLE-PREPARE("Pages").  
wbhttdwrppagescre = whttdwrppagescre:DEFAULT-BUFFER-HANDLE.   

/* dwrppagescretran */
DEFINE BUFFER   bdwrppagescretran     FOR dwrppagescretran.
DEFINE VARIABLE whdwrppagescretran    AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrppagescretran  AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrppagescretran AS HANDLE     NO-UNDO.
whdwrppagescretran = BUFFER bdwrppagescretran:HANDLE.
CREATE TEMP-TABLE whttdwrppagescretran.
whttdwrppagescretran:CREATE-LIKE(whdwrppagescretran).
whttdwrppagescretran:TEMP-TABLE-PREPARE("PagesTtranslations").  
wbhttdwrppagescretran = whttdwrppagescretran:DEFAULT-BUFFER-HANDLE. 

/* dwrpinst */
DEFINE BUFFER   bdwrpinst     FOR dwrpinst.
DEFINE VARIABLE whdwrpinst    AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrpinst  AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrpinst AS HANDLE     NO-UNDO.
whdwrpinst = BUFFER bdwrpinst:HANDLE.
CREATE TEMP-TABLE whttdwrpinst.
whttdwrpinst:CREATE-LIKE(whdwrpinst).
whttdwrpinst:TEMP-TABLE-PREPARE("PageInstance").  
wbhttdwrpinst = whttdwrpinst:DEFAULT-BUFFER-HANDLE. 

/* dwrpobje */ 
DEFINE BUFFER   bdwrpobje     FOR dwrpobje.
DEFINE VARIABLE whdwrpobje    AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrpobje  AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrpobje AS HANDLE     NO-UNDO.
whdwrpobje = BUFFER bdwrpobje:HANDLE.
CREATE TEMP-TABLE whttdwrpobje.
whttdwrpobje:CREATE-LIKE(whdwrpobje).
whttdwrpobje:TEMP-TABLE-PREPARE("Pageobject").  
wbhttdwrpobje = whttdwrpobje:DEFAULT-BUFFER-HANDLE. 

/* dwrpfielobje */
DEFINE BUFFER   bdwrpfielobje     FOR dwrpfielobje.
DEFINE VARIABLE whdwrpfielobje    AS HANDLE     NO-UNDO.
DEFINE VARIABLE whttdwrpfielobje  AS HANDLE     NO-UNDO.
DEFINE VARIABLE wbhttdwrpfielobje AS HANDLE     NO-UNDO.
whdwrpfielobje = BUFFER bdwrpfielobje:HANDLE.
CREATE TEMP-TABLE whttdwrpfielobje.
whttdwrpfielobje:CREATE-LIKE(whdwrpfielobje).
whttdwrpfielobje:TEMP-TABLE-PREPARE("Pagefielobject").  
wbhttdwrpfielobje = whttdwrpfielobje:DEFAULT-BUFFER-HANDLE. 

CREATE DATASET whdataset. 
whdataset:SET-BUFFERS(wbhttdwrpscre,wbhttdwrpScreTran,wbhttdwrppagescre,wbhttdwrppagescretran,wbhttdwrpinst,wbhttdwrpobje,wbhttdwrpfielobje).
whrelation = whdataset:ADD-RELATION(wbhttdwrpscre, wbhttdwrpScreTran,"rscre,rscre",false,TRUE).
whrelation = whdataset:ADD-RELATION(wbhttdwrpscre, wbhttdwrppagescre,"rscre,rscre",false,TRUE).
whrelation = whdataset:ADD-RELATION(wbhttdwrppagescre, wbhttdwrppagescretran,"rscre,rscre,rpage,rpage",false,TRUE).
whrelation = whdataset:ADD-RELATION(wbhttdwrppagescre, wbhttdwrpinst,"rscre,rscre,rpage,rpage",false,TRUE).
whrelation = whdataset:ADD-RELATION(wbhttdwrpinst, wbhttdwrpobje,"robje,robje",false,TRUE).
whrelation = whdataset:ADD-RELATION(wbhttdwrpobje, wbhttdwrpfielobje,"robje,robje",false,TRUE).

ASSIGN
  wcapplication = "DV"
  wcscreen      = "wiSignCli_GE_2".

/* bdwrpscre*/
FOR EACH bdwrpscre NO-LOCK 
WHERE bdwrpscre.rappl = wcapplication AND 
      bdwrpscre.cscre = wcscreen : 
  wbhttdwrpscre:BUFFER-CREATE. 
  wbhttdwrpscre:BUFFER-COPY(whdwrpscre).

  /* bdwrpScreTran */
  FOR EACH bdwrpScreTran  NO-LOCK
  WHERE bdwrpScreTran.rappl = wcapplication AND 
        bdwrpScreTran.rscre = bdwrpscre.rscre : 
    wbhttdwrpScreTran:BUFFER-CREATE. 
    wbhttdwrpScreTran:BUFFER-COPY(whdwrpScreTran).
  END.         

  /* dwrppagescre */
  FOR EACH bdwrppagescre NO-LOCK 
  WHERE bdwrppagescre.rappl = wcapplication AND
        bdwrppagescre.rscre = bdwrpscre.rscre  : 
    IF bdwrppagescre.rpage = 2 
    THEN DO : 
    
    wbhttdwrppagescre:BUFFER-CREATE. 
    wbhttdwrppagescre:BUFFER-COPY(whdwrppagescre).


   /* dwrppagescretran */
   FOR EACH bdwrppagescretran  NO-LOCK
    WHERE bdwrppagescretran.rappl = wcapplication AND 
          bdwrppagescretran.rscre = bdwrppagescre.rscre AND 
           bdwrppagescretran.rpage =  bdwrppagescre.rpage : 
      wbhttdwrppagescretran:BUFFER-CREATE. 
      wbhttdwrppagescretran:BUFFER-COPY(whdwrppagescretran).
    END.   

    /* bdwrpinst */ 
    FOR EACH bdwrpinst NO-LOCK 
    WHERE bdwrpinst.rappl = wcapplication AND 
          bdwrpinst.rscre = bdwrppagescre.rscre AND 
          bdwrpinst.rpage =  bdwrppagescre.rpage  :     /* 0 !!!!!!!!!!!!!!!!!!!!!!!!!  */ 
      
      cquerystring = " WHERE PageInstance.rappl = " + quoter(wcapplication) +
                     " AND   PageInstance.rscre = " + string(bdwrppagescre.rscre) +
                     " AND   PageInstance.rinst = " + string(bdwrpinst.rinst) .

      lfound = wbhttdwrpinst:FIND-FIRST(cquerystring) no-error.
      IF NOT lfound
      THEN DO : 
        cquerystring = " WHERE PageInstance.rappl = " + quoter(wcapplication) +
                       " AND   PageInstance.rscre = " + string(bdwrppagescre.rscre) +
                       " AND   PageInstance.rorde = " + string(bdwrpinst.rorde) .
         lfound = wbhttdwrpinst:FIND-FIRST(cquerystring) no-error.
      END.
     
      IF NOT lfound
      THEN DO : 
        wbhttdwrpinst:BUFFER-CREATE.
        wbhttdwrpinst:BUFFER-COPY(whdwrpinst).
      END. 
    

      /* bdwrpobje */
      FOR EACH bdwrpobje NO-LOCK 
      WHERE bdwrpobje.rappl = wcapplication AND 
            bdwrpobje.robje = bdwrpinst.robje : 

        cquerystring = " WHERE Pageobject.rappl = " + quoter(wcapplication) +
                       " AND   Pageobject.robje = " + string(bdwrpinst.robje) .

        lfound = wbhttdwrpobje:FIND-FIRST(cquerystring) no-error.
        
        IF NOT lfound
        THEN DO : 
          wbhttdwrpobje:BUFFER-CREATE.
          wbhttdwrpobje:BUFFER-COPY(whdwrpobje).
        END.

        FOR EACH bdwrpfielobje NO-LOCK 
        WHERE bdwrpfielobje.rappl EQ "DV" AND 
              bdwrpfielobje.robje EQ bdwrpobje.robje :
         
            wbhttdwrpfielobje:BUFFER-CREATE.
            wbhttdwrpfielobje:BUFFER-COPY(whdwrpfielobje).
            
 
          /*
                     FIND dwrpfielobjetran NO-LOCK
                     HERE dwrpfielobjetran.rappl = dwrpfielobje.rappl
              AND dwrpfielobjetran.rfiel = dwrpfielobje.rfiel
              AND dwrpfielobjetran.rlang = "NL"
                  NO-ERROR.
          */        
          


        END.
      END.
      
    END.
    END.
  END.
END.

ASSIGN cTargetType     = "file"
       cFile           = "D:\users\loo\testxml\derivaat.xml"   
       lFormatted      = TRUE  
       cEncoding       = ?  
       cSchemaLocation = ?  
       lWriteSchema    = TRUE  
       lMinSchema      = TRUE. 

lRetOK =  whdataset:WRITE-XML(cTargetType, cFile, lFormatted, cEncoding,  cSchemaLocation, lWriteSchema, lMinSchema).

