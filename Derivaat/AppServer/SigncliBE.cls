 
 /*------------------------------------------------------------------------
    File        : SigncliBE
    Syntax      : 
    Author(s)   : Luc
    Created     : Mon Oct 17 18:49:15 CEST 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="SigncliBE.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="SigncliBE", URI="/SigncliBE", schemaName="dsSignCli", schemaFile="Derivaat/AppServer/signclibe.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS SigncliBE INHERITS BusinessEntity:
	/*------------------------------------------------------------------------------
			Purpose:                                                                      
			Notes:                                                                        
	------------------------------------------------------------------------------*/
	
	{"signclibe.i"}
	
	DEFINE DATA-SOURCE srcSignCli FOR driver.SignCli.
	
    
	/*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC SigncliBE():
    	
    	DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray AS CHAR NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsSignCli:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
     	   in DataSet */     
     	hDataSourceArray[1] =  DATA-SOURCE srcSignCli:HANDLE.
     	
     	     	
     	/* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
 	       ignored in create stmt */
     	    
     	cSkipListArray[1] = "".
     	
     	
     	THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
     	        
    END CONSTRUCTOR.
    	
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadSigncliBE(
    		INPUT filter AS CHARACTER, 
    		OUTPUT DATASET dsSignCli):
    	
    	SUPER:ReadData(filter).
    	      
    END METHOD.
	  
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreateSigncliBE(INPUT-OUTPUT DATASET dsSignCli):    		
    	       
        SUPER:CreateData(DATASET dsSignCli BY-REFERENCE).        
    END METHOD.    
	
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdateSigncliBE(INPUT-OUTPUT DATASET dsSignCli):    		
	
        SUPER:UpdateData(DATASET dsSignCli BY-REFERENCE).          
    END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeleteSigncliBE(INPUT-OUTPUT DATASET dsSignCli):     		       
	
        SUPER:DeleteData(DATASET dsSignCli BY-REFERENCE).
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Submit a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="submit", URI="/SubmitSigncliBE", alias="", mediaType="application/json").
    METHOD PUBLIC VOID SubmitSigncliBE(INPUT-OUTPUT DATASET dsSignCli):     		       
	
      	SUPER:Submit(DATASET dsSignCli BY-REFERENCE).    	   
    END METHOD.
	 
    
END CLASS.
