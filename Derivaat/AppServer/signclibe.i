
 /*------------------------------------------------------------------------
    File        : SigncliBE
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Luc
    Created     : Mon Oct 17 18:49:15 CEST 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="iSignCliId").
	
DEFINE TEMP-TABLE ttSignCli BEFORE-TABLE bttSignCli
FIELD iSignCliId AS INTEGER INITIAL "0" LABEL "Signal�tique Client Id"
FIELD iSignCliId2 AS INTEGER INITIAL "0" LABEL "Signal�tique Client Id2"
FIELD iSignCliId3 AS INTEGER INITIAL "0" LABEL "Signal�tique Client Id3"
FIELD iFormeId AS INTEGER INITIAL "0" LABEL "Forme_id"
FIELD cRegCom AS CHARACTER LABEL "Registre Commerce"
FIELD iEntrepPaysId AS INTEGER INITIAL "0" LABEL "Entreprise_Pays_id"
FIELD lIsCA AS LOGICAL INITIAL "NO" LABEL "is CA"
FIELD lIsTVA AS LOGICAL INITIAL "NO" LABEL "is TVA"
FIELD cNum AS CHARACTER LABEL "Num�ro"
FIELD cTVANum AS CHARACTER LABEL "TVA_Num�ro"
FIELD iTVAPaysId AS INTEGER INITIAL "0" LABEL "TVA_Pays_id"
FIELD iCommMkgId AS INTEGER INITIAL "0" LABEL "Communication_Marketing_id"
FIELD iCommOffId AS INTEGER INITIAL "0" LABEL "Communication_Officielle_id"
FIELD lIsDiet AS LOGICAL INITIAL "NO" LABEL "is D'Ieteren"
FIELD lIsRoot AS LOGICAL INITIAL "NO" LABEL "is Root"
FIELD dDateEtab AS DATE LABEL "Date Etablissement"
FIELD dDateClot AS DATE LABEL "Date Cl�ture"
FIELD cDenom AS CHARACTER LABEL "D�nomination"
FIELD iLgeMkgId AS INTEGER INITIAL "0" LABEL "Langue_Marketing_id"
FIELD iLgeOffId AS INTEGER INITIAL "0" LABEL "Langue_Officielle_id"
FIELD cPrenom AS CHARACTER LABEL "Pr�nom_unNom"
FIELD cNom AS CHARACTER LABEL "Nom_unNom"
FIELD iTitreId AS INTEGER INITIAL "0" LABEL "Titre_id"
FIELD cRefPasseport AS CHARACTER LABEL "R�f�rence Passeport"
FIELD cRegNat AS CHARACTER LABEL "Registre National"
FIELD cRefPermisVeh AS CHARACTER LABEL "R�f�rence Permis V�hicule"
FIELD dDatePermisVeh AS DATE LABEL "Date Permis V�hicule"
FIELD dDateNais AS DATE LABEL "Date Naissance"
FIELD lSexe AS LOGICAL INITIAL "NO" LABEL "Sexe"
FIELD dDateCre AS DATETIME LABEL "Date Cr�ation"
FIELD iCreParId AS INTEGER INITIAL "0" LABEL "Cr�� Par_id"
FIELD dDateMod AS DATETIME LABEL "Date Modification"
FIELD iModParId AS INTEGER INITIAL "0" LABEL "Modifi� Par_id"
FIELD iTypPers AS INTEGER INITIAL "0" LABEL "Type Personne"
FIELD lIsAsuj AS LOGICAL INITIAL "NO" LABEL "is Assujetti"
FIELD iTaxPartId AS INTEGER INITIAL "0" LABEL "Taxation Particuli�re_id"
FIELD lIsMkgMailing AS LOGICAL INITIAL "NO" LABEL "is Marketing Mailing"
FIELD lRapTel AS LOGICAL INITIAL "no" LABEL "Rappel T�l�phonique"
FIELD cCmt AS CHARACTER LABEL "Commentaire"
FIELD iTrspAltId AS INTEGER INITIAL "0" LABEL "Transport Alternatif_id"
FIELD cNumConvFleet AS CHARACTER LABEL "Num�ro Convention Fleet"
FIELD cNomRech AS CHARACTER LABEL "Nom Recherche"
FIELD lPublicite AS LOGICAL INITIAL "NO" LABEL "Publicit�"
FIELD cMotCle AS CHARACTER LABEL "Mot Cl�"
FIELD cNumAtt AS CHARACTER LABEL "Num�ro Attestation"
FIELD cOfcDeliv AS CHARACTER LABEL "Office D�livrance"
FIELD dDateVld AS DATE LABEL "Date de validit�"
FIELD cAttTypFich AS CHARACTER LABEL "Attestation_Type Fichier_untexte"
FIELD cAttNom AS CHARACTER LABEL "Attestation_Nom_untexte"
FIELD cAttChemin AS CHARACTER LABEL "Attestation_Chemin_untexte"
FIELD lTiersPynt AS LOGICAL INITIAL "no" LABEL "Tiers Payant"
FIELD cNumComptableExtern AS CHARACTER LABEL "Numero de comptable externe"
FIELD cNomNormal AS CHARACTER LABEL "Nom normalis�"
FIELD iBlocCliId AS INTEGER INITIAL "0" LABEL "Id du blocage"
FIELD cPrenomRech AS CHARACTER LABEL "Recherche prenom"
FIELD cTypNumCli AS CHARACTER LABEL "Type de client selon numero"
FIELD lTVAenAtt AS LOGICAL INITIAL "no" LABEL "TVA en attente"
FIELD dDateDecl AS DATETIME LABEL "Date D�clencheur"
INDEX osignclidatecre  dDateCre  ASCENDING 
INDEX osignclidatedecl  dDateDecl  ASCENDING 
INDEX osigncliddatemod  dDateMod  ASCENDING 
INDEX osigncliddatemodcreisigncliid  dDateMod  ASCENDING  dDateCre  ASCENDING  iSignCliId  ASCENDING 
INDEX osignclientrepnum  cNum  ASCENDING 
INDEX osignclinom  cNom  ASCENDING  cPrenom  ASCENDING 
INDEX osignclisignclifk  iSignCliId2  ASCENDING 
INDEX osignclisignclifk2  iSignCliId3  ASCENDING 
INDEX osignclitvanum  cTVANum  ASCENDING 
INDEX pusigncli IS  PRIMARY  UNIQUE  iSignCliId  ASCENDING 
INDEX wsignclimotcle  cMotCle  ASCENDING 
INDEX wsignclinomdedal  cNomNormal  ASCENDING 
INDEX wsignclinomrech  cNomRech  ASCENDING 
INDEX wsigncliprenomrech  cPrenomRech  ASCENDING . 


DEFINE DATASET dsSignCli FOR ttSignCli.