 
 /*------------------------------------------------------------------------
    File        : tPaysBE
    Syntax      : 
    Author(s)   : oomsl
    Created     : Sun Oct 30 10:51:05 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="tPaysBE.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="tPaysBE", URI="/tPaysBE", schemaName="dstPaysBE", schemaFile="Derivaat/AppServer/tpaysbe.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS tPaysBE INHERITS BusinessEntity:
	/*------------------------------------------------------------------------------
			Purpose:                                                                      
			Notes:                                                                        
	------------------------------------------------------------------------------*/
	
	{"tpaysbe.i"}
	
	DEFINE DATA-SOURCE srctPays FOR driver.tPays.
	
    
	/*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC tPaysBE():
    	
    	DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray AS CHAR NO-UNDO EXTENT 1.
        
        SUPER (DATASET dstPays:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
     	   in DataSet */     
     	hDataSourceArray[1] =  DATA-SOURCE srctPays:HANDLE.
     	
     	     	
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
    METHOD PUBLIC VOID ReadtPaysBE(
    		INPUT filter AS CHARACTER, 
    		OUTPUT DATASET dstPays):
    	
    	SUPER:ReadData(filter).
    	      
    END METHOD.
	  
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreatetPaysBE(INPUT-OUTPUT DATASET dstPays):    		
    	       
        SUPER:CreateData(DATASET dstPays BY-REFERENCE).        
    END METHOD.    
	
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatetPaysBE(INPUT-OUTPUT DATASET dstPays):    		
	
        SUPER:UpdateData(DATASET dstPays BY-REFERENCE).          
    END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletetPaysBE(INPUT-OUTPUT DATASET dstPays):     		       
	
        SUPER:DeleteData(DATASET dstPays BY-REFERENCE).
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Submit a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="submit", URI="/SubmittPaysBE", alias="", mediaType="application/json").
    METHOD PUBLIC VOID SubmittPaysBE(INPUT-OUTPUT DATASET dstPays):     		       
	
      	SUPER:Submit(DATASET dstPays BY-REFERENCE).    	   
    END METHOD.
	 
    
END CLASS.
