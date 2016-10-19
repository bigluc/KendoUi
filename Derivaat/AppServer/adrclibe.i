
 /*------------------------------------------------------------------------
    File        : AdrcliBE
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Luc
    Created     : Mon Oct 17 18:56:57 CEST 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="iAdrCliId").
	
DEFINE TEMP-TABLE ttAdrCli BEFORE-TABLE bttAdrCli
FIELD iAdrCliId AS INTEGER INITIAL "0" LABEL "Adresse Client Id"
FIELD iSignCliId AS INTEGER INITIAL "0" LABEL "Signalétique Client Id"
FIELD dDateCre AS DATETIME LABEL "Date Création"
FIELD iCreParId AS INTEGER INITIAL "0" LABEL "Créé Par_id"
FIELD dDateMod AS DATETIME LABEL "Date Modification"
FIELD iModParId AS INTEGER INITIAL "0" LABEL "Modifié Par_id"
FIELD iTypId AS INTEGER INITIAL "0" LABEL "Type_id"
FIELD lDefaut AS LOGICAL INITIAL "NO" LABEL "Défaut"
FIELD cDenom AS CHARACTER LABEL "Dénomination"
FIELD cRue AS CHARACTER LABEL "Rue"
FIELD cNumPorte AS CHARACTER LABEL "Numéro Porte"
FIELD cBtePostale AS CHARACTER LABEL "Boite Postale"
FIELD iCdPostId AS INTEGER INITIAL "0" LABEL "Code Postal_id"
FIELD iPaysId AS INTEGER INITIAL "0" LABEL "Pays_id"
FIELD lNonValid AS LOGICAL INITIAL "no" LABEL "Adresse non valide"
INDEX oadrcli1  iSignCliId  ASCENDING  lDefaut  ASCENDING  iTypId  ASCENDING 
INDEX oadrcli2  iCdPostId  ASCENDING  iPaysId  ASCENDING 
INDEX oadrcli3  iCdPostId  ASCENDING  lDefaut  ASCENDING  iTypId  ASCENDING 
INDEX oadrcliddatemod  dDateMod  ASCENDING 
INDEX oadrcliddatemodcreiadrcliid  dDateMod  ASCENDING  dDateCre  ASCENDING  iAdrCliId  ASCENDING 
INDEX oadrclisignclifk  iSignCliId  ASCENDING 
INDEX puadrcli IS  PRIMARY  UNIQUE  iAdrCliId  ASCENDING . 


DEFINE DATASET dsAdrCli FOR ttAdrCli.