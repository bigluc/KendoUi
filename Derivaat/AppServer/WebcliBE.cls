 
 /*------------------------------------------------------------------------
    File        : WebcliBE
    Syntax      : 
    Author(s)   : Luc
    Created     : Mon Oct 17 18:57:35 CEST 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="WebcliBE.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="WebcliBE", URI="/WebcliBE", schemaName="dsWebCli", schemaFile="Derivaat/AppServer/webclibe.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS WebcliBE INHERITS BusinessEntity:
	/*------------------------------------------------------------------------------
			Purpose:                                                                      
			Notes:                                                                        
	------------------------------------------------------------------------------*/
	
	{"webclibe.i"}
	
	DEFINE DATA-SOURCE srcWebCli FOR driver.WebCli.
	
    
	/*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC WebcliBE():
    	
    	DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray AS CHAR NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsWebCli:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
     	   in DataSet */     
     	hDataSourceArray[1] =  DATA-SOURCE srcWebCli:HANDLE.
     	
     	     	
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
    METHOD PUBLIC VOID ReadWebcliBE(
    		INPUT filter AS CHARACTER, 
    		OUTPUT DATASET dsWebCli):
    	
    	SUPER:ReadData(filter).
    	      
    END METHOD.
	  
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreateWebcliBE(INPUT-OUTPUT DATASET dsWebCli):    		
    	       
        SUPER:CreateData(DATASET dsWebCli BY-REFERENCE).        
    END METHOD.    
	
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdateWebcliBE(INPUT-OUTPUT DATASET dsWebCli):    		
	
        SUPER:UpdateData(DATASET dsWebCli BY-REFERENCE).          
    END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeleteWebcliBE(INPUT-OUTPUT DATASET dsWebCli):     		       
	
        SUPER:DeleteData(DATASET dsWebCli BY-REFERENCE).
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Submit a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="submit", URI="/SubmitWebcliBE", alias="", mediaType="application/json").
    METHOD PUBLIC VOID SubmitWebcliBE(INPUT-OUTPUT DATASET dsWebCli):     		       
	
      	SUPER:Submit(DATASET dsWebCli BY-REFERENCE).    	   
    END METHOD.
	 
    
END CLASS.
