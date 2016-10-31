
 /*------------------------------------------------------------------------
    File        : tPaysBE
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : oomsl
    Created     : Sun Oct 30 10:51:05 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="iCdInt,iCdLge").
	
DEFINE TEMP-TABLE tttPays BEFORE-TABLE btttPays
FIELD iCdInt AS INTEGER INITIAL "0" LABEL "Code Interne"
FIELD iCdLge AS INTEGER INITIAL "0" LABEL "Code Langue"
FIELD cCdLog AS CHARACTER LABEL "Code Logique"
FIELD cCdTech AS CHARACTER LABEL "Code Technique"
FIELD cLibLog AS CHARACTER LABEL "Libellé Logique"
FIELD cLibInt AS CHARACTER LABEL "Libellé Interne"
FIELD cDescr AS CHARACTER LABEL "Description"
FIELD cAide AS CHARACTER LABEL "Aide"
FIELD iNivSec AS INTEGER INITIAL "0" LABEL "Niveau sécurité"
FIELD dDateCre AS DATETIME LABEL "Date création"
FIELD iCreParId AS INTEGER INITIAL "0" LABEL "Créé Par_id"
FIELD dDateMod AS DATETIME LABEL "Date Modification"
FIELD iModParId AS INTEGER INITIAL "0" LABEL "Modifié Par_id"
INDEX otPayscdlge  iCdLge  ASCENDING 
INDEX otPaysclog  cCdLog  ASCENDING  iCdLge  ASCENDING 
INDEX otpaysddatemod  dDateMod  ASCENDING 
INDEX otpaysddatemodcreicdlgeicdint  dDateMod  ASCENDING  dDateCre  ASCENDING  iCdLge  ASCENDING  iCdInt  ASCENDING 
INDEX putpays IS  PRIMARY  UNIQUE  iCdInt  ASCENDING  iCdLge  ASCENDING . 


DEFINE DATASET dstPays FOR tttPays.