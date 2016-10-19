
 /*------------------------------------------------------------------------
    File        : WebcliBE
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Luc
    Created     : Mon Oct 17 18:57:35 CEST 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="iWebCliId").
	
DEFINE TEMP-TABLE ttWebCli BEFORE-TABLE bttWebCli
FIELD iWebCliId AS INTEGER INITIAL "0" LABEL "Web Client Id"
FIELD iSignCliId AS INTEGER INITIAL "0" LABEL "Signalétique Client Id"
FIELD iTypId AS INTEGER INITIAL "0" LABEL "Type_id"
FIELD cAdrElect AS CHARACTER LABEL "Adresse Electronique"
FIELD lDefaut AS LOGICAL INITIAL "No" LABEL "Défaut"
FIELD dDateCre AS DATETIME LABEL "Date Création"
FIELD iCreParId AS INTEGER INITIAL "0" LABEL "Créé Par_id"
FIELD dDateMod AS DATETIME LABEL "Date Modification"
FIELD iModParId AS INTEGER INITIAL "0" LABEL "Modifié Par_id"
INDEX owebcli1  iSignCliId  ASCENDING  lDefaut  ASCENDING  iTypId  ASCENDING 
INDEX owebcli2  cAdrElect  ASCENDING 
INDEX owebcliddatemod  dDateMod  ASCENDING 
INDEX owebclisignclifk  iSignCliId  ASCENDING 
INDEX puwebcli IS  PRIMARY  UNIQUE  iWebCliId  ASCENDING . 


DEFINE DATASET dsWebCli FOR ttWebCli.