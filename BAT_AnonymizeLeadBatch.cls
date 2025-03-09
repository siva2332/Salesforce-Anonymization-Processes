/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* Class for anonymize leads
* 4093 : after 24 months ->anonymize leads
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author        Margherita Gioia
* @created       17/11/2018
* @modified      21/11/2018
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @changes
* 21/11/2018      Initial version.
* 10/06/2020/ Satya Nallri/Bug # 143762- Lead anonymization batch is throwing 'Attempt to de reference null pointer' 			exception when there's 		 no Birthdate is present.
* 11/08/2022/ Hariharan Pillai/US # 1066069- Created a Label for Countries to anonymize the leads
* 16/12/2022/ Hariharan Pillai/Bug #1234764- Modified Document Update to move it out from for loop
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

global class BAT_AnonymizeLeadBatch implements Database.Batchable<Sobject> 
{   
    
    String query = 'Select id, LastName, FirstName,Email, Country__c, MobilePhone, Street,Month_24_Anonymize_Countdown__c,Registration_Permission__c,Submit_Surveys_Permission__c, Trial_Information_Permission__c,BirthDate__c,External_Systems_Information_Permission__c,Generic_Permission__c, BAT_isVypeOptInEmailCommunication__c, BAT_isVypeOptInMobileTextWhatsApp__c From Lead Where  Country__c IN'
                    + Label.BAT_LeadAnonymizationCountries + ' and Month_24_Anonymize_Countdown__c =0 and (NOT Email like \'%anonymous%\') LIMIT 50000';
  
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        System.Debug('QUERY: ' + query);
        return Database.getQueryLocator(query);
    } 
    
    
    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────┐
    * This batch method anonymize the Lead record after 24 months
    * ────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    	 :  list<Lead>, Database.BatchableContext
    * @return   	 :  void    
	* @Change History: 10/06/2020/ Satya Nallri/Bug # 143762- Lead anonymization batch is throwing 'Attempt to de reference null pointer' 			exception when there's no Birthdate is present. 
	* 				 : 11/08/2022/ Hariharan Pillai/US # 1066069- Created a Label for Countries to anonymize the leads
	*				 : 16/12/2022/ Hariharan Pillai/Bug #1234764- Modified Document Update to move it out from for loop
    * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */       
    
    global void execute(Database.BatchableContext BC, list<Lead> scope)
    { 

        //Getting records and related document infos
        String LeadAnonymizationCountries = Label.BAT_LeadAnonymizationCountries;
		String pSnapshotsQuery = 'SELECT Document_Name__c FROM Privacy_Snapshot_Permission__mdt WHERE DeveloperName IN '+ Label.BAT_LeadAnonymizationCountries;
        List<Privacy_Snapshot_Permission__mdt> pSnapshots = Database.query(pSnapshotsQuery);
        List<ContentDocument> docsToDelete= new List<ContentDocument>();
        List<Document> existingFiles= new List<Document>();
        Id anonymizationFileFolderId;
        
		String anonymizeFileConfsQuery='SELECT MasterLabel,File_Name__c,Folder_API_Name__c FROM Anonymization_File_Configuration__mdt WHERE MasterLabel IN '+Label.BAT_LeadAnonymizationCountries;
        List<Anonymization_File_Configuration__mdt> anonymizeFileConfs= Database.query(anonymizeFileConfsQuery);
            
        if(!anonymizeFileConfs.isEmpty()){
            existingFiles=[SELECT ID,Body FROM Document WHERE Name= :anonymizeFileConfs[0].File_Name__c AND Folder.DeveloperName = :anonymizeFileConfs[0].Folder_API_Name__c LIMIT 1];
            anonymizationFileFolderId=[SELECT Id FROM Folder WHERE DeveloperName=:anonymizeFileConfs[0].Folder_API_Name__c LIMIT 1].Id;
        }


        Set<Id> leadIds = new Set<Id>();
        Integer i = 0;
        Map<Id,Lead> mapidToObj = new Map<Id,Lead>();

        List<Document> docToUpdate=new List<Document>();
        List<Document> docToInsert=new List<Document>();
		
        Document currentDoc = new Document();
        String currentBody = '';
        if(!existingFiles.isEmpty()){
		    currentDoc=existingFiles[0];
            currentBody=currentDoc.Body.toString();
        }

        //Updating lead informations

        for(Lead l:scope){
            
            //saving anonymization info on SEA file
            String leadFullName=l.FirstName+' '+l.LastName+' '+'(LEAD)'+'\n';

            
            if(!existingFiles.isEmpty()){
                
                currentDoc.Body=Blob.valueOf(currentBody+leadFullName);
          
            }else{

                Document newDoc=new Document();
                newDoc.Name=anonymizeFileConfs[0].File_Name__c;
                newDoc.FolderId=anonymizationFileFolderId;
                newDoc.ContentType = 'text/plain';
                newDoc.Type='txt';
                newDoc.Body=Blob.valueOf(leadFullName);
                docToInsert.add(newDoc);

            }

            //updating lead informations

            l.LastName = 'anonymous';
            l.Street  = '';
            l.FirstName = 'anonymous';
            l.Email = l.id +String.valueOf(i)+'@anonymous.it';
            l.MobilePhone = '300000000';
            l.Registration_Permission__c = false;
            l.Submit_Surveys_Permission__c = false;
            l.Trial_Information_Permission__c = false;
            l.External_Systems_Information_Permission__c = false;
            l.Generic_Permission__c = false;
            l.BAT_isVypeOptInEmailCommunication__c = false;
            l.BAT_isVypeOptInMobileTextWhatsApp__c = false;
			if(l.BirthDate__c != null){
				Integer yearOfBirth=l.BirthDate__c.year() != null ? l.BirthDate__c.year() :1980;
				l.BirthDate__c=Date.newInstance(yearOfBirth,1,1);
			}

            leadIds.add(l.Id);
            mapidToObj.put(l.Id, l);

            i++;
        }
        if(!existingFiles.isEmpty()){
            docToUpdate.add(currentDoc);
        }
        update scope;   

        //Checking privacy snapshots existence

        if(!pSnapshots.isEmpty()){

            for(ContentDocumentLink cdl : [SELECT Id,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN: leadIds]){  
                    docsToDelete.add(new ContentDocument(Id=cdl.ContentDocumentId));
            }

        }


        //executing record operations

        if(!docToUpdate.isEmpty()){
            update docToUpdate;
        }

        if(!docToInsert.isEmpty()){
            insert docToInsert;
        }

        if(!docsToDelete.isEmpty()){
            delete docsToDelete;
        }


       
    }
        
    global void finish(Database.BatchableContext BC) 
    {                 
        
        
       
    }
    
    
  
}