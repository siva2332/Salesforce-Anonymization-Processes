/********************************************************************************************************
* @Author        : Deloitte
* @Description   : Class to implement anonymization process and builds txt file to be used by EM to track anonymized Lead.
* @Date          : 23/01/2019.
* @Component     : Used in Lightning component "BAT_AnonymizeLeadComponent". 
* @Object        : Lead
* @changeHistory : 23.03.220/Tejaswi Nissanluka/ Added Null check before DML operation as part of ForceReviewer changes.
                   13/08/2020/Kushagra Jain/ Bug #196825 Added null validation For Lead
				   3/11/2020/Dipika Gupta/ CZ 295643 updated for partial anonymisation
                   14/09/2022/Debasis Maharana/Bug#1104167 - Optimize the code so that it improves the performance and it avoids the Apex CPU time exception.
                   11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
*********************************************************************************************************/
public without sharing class BAT_AnonymizeLeadController {
    /********************************************************************************************************
    * @Author        :   Deloitte.
    * @Date          :   01/21/2019.
    * @Description   :   This method is invoked from "doInit function in BAT_AnonymizeLeadComponentController.js " and used to get Lead with lead Id.
    * @Paramters     :   Account id.
    * @Return        :   Account.
    *********************************************************************************************************/ 
    @AuraEnabled
    public static Lead getLead(Id leadId){
        Lead lead = new Lead();
        try{
            if(String.isNotBlank(leadId)){
                lead = [Select id, LastName, FirstName,Email, Country__c, MobilePhone, Street,Registration_Permission__c,Brand_House__c,
                        Submit_Surveys_Permission__c, Trial_Information_Permission__c,BirthDate__c,External_Systems_Information_Permission__c,
                        Generic_Permission__c 
                        FROM Lead 
                        WHERE id =: leadId];
            }
        }
        catch(Exception ex){
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.ANONYMIZE_LEAD_CONTROLLER_CLASS,BAT_ConstantsUtility.GET_LEAD_METHOD);
            return lead;
        }
        return lead;
    }
    /********************************************************************************************************
    * @Author        :   Deloitte.
    * @Date          :   01/21/2019.
    * @Description   :   This method is invoked from "handleAnonymize function in BAT_AnonymizeLeadComponentController.js " and used to update the Lead.
    * @Paramters     :   Account.
    * @Return        :   Map<String,String>.
    * @changeHistory :   02.27.2019/Sudaif Haider/ Optimised Logic for All Markets/US#9157
						 29.06.2020/Tejaswi Nissankula/ID:US#136705 Added BAT_BlankDate__c check to set the BirthDate field value to null.
						 13/08/2020/Kushagra Jain/ Bug #196825 Added null validation For Lead
                         06/10/2020/ Rama Akella/ US#281008 Added logic to delete lead history on anonymization
						 3/11/2020/Dipika Gupta/ CZ 295643 updated for partial anonymisation
                         14/09/2022/Debasis Maharana/Bug#1104167 - Optimize the code so that it improves the performance and it avoids the Apex CPU time exception.
                         11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
    *********************************************************************************************************/ 
    @AuraEnabled
    public static Map<String,String> anonymizeLead(Lead lead){
        Map<String,String> returnMap = new Map<String,String>();
        Set<ID> leadIDSet = new Set<ID>();
        Map<String,BAT_AutomaticAnonymizationConfiguration__mdt> automaticAnonymizationConfigMap = BAT_Utilities.getAutomaticAnonymizationConfig();   
        try{
            if(lead!=null){
            generateAnonymizationFile(lead,lead.Country__c);
		    }
            /* UK US 9157
             * Created Metadata BAT_AnonymisationMarketConfiguration__mdt to store the Field API names, Market and value to be updated after
             * anonymization. Created Map for country vs List of Metadata object. 
            */
			
			// 3/11/2020/Dipika Gupta/ CZ 295643 fetch records where BAT_IsPartialAnonymize__c  is not true
            Map<String,List<BAT_AnonymisationMarketConfiguration__mdt>> countryToMtdMap = new Map<String,List<BAT_AnonymisationMarketConfiguration__mdt>>();
            for(BAT_AnonymisationMarketConfiguration__mdt anonyLeadMtd : [Select Id,BAT_Market__c,BAT_FieldAPIName__c,BAT_FieldValue__c, 
                                                                          BAT_BlankDate__c,BAT_IsAppendValue__c,BAT_IsCurrentDate__c from BAT_AnonymisationMarketConfiguration__mdt where 
                                                                          BAT_Market__c!=null and BAT_IsPartialAnonymize__c = false]){
                                                                             
    System.debug('Record Id: ' + anonyLeadMtd.Id);
    System.debug('BAT_Market__c: ' + anonyLeadMtd.BAT_Market__c);
    System.debug('BAT_FieldAPIName__c: ' + anonyLeadMtd.BAT_FieldAPIName__c);
    System.debug('BAT_FieldValue__c: ' + anonyLeadMtd.BAT_FieldValue__c);
    System.debug('BAT_BlankDate__c: ' + anonyLeadMtd.BAT_BlankDate__c);
    System.debug('BAT_IsAppendValue__c: ' + anonyLeadMtd.BAT_IsAppendValue__c);
   
                                                                             
                if(!countryToMtdMap.containsKey(anonyLeadMtd.BAT_Market__c)){
                    countryToMtdMap.put(anonyLeadMtd.BAT_Market__c, new List<BAT_AnonymisationMarketConfiguration__mdt>{});
                }
                countryToMtdMap.get(anonyLeadMtd.BAT_Market__c).add(anonyLeadMtd);
            }
            /* UK US 9157
             * Below If fetches the Key If Lead country exists in metadata the Fields will be anonymized for that country/market as given 
             * in metadata otherwise the Default Fields data will be anonymized
            */
            String KeyStr;
            String fieldType;
            if(!countryToMtdMap.isEmpty() && countryToMtdMap.containsKey(lead.country__c)){
                KeyStr = lead.country__c;
            }
            else{
                KeyStr = BAT_ConstantsUtility.DEFAULT_STR;
            }
            /* UK US 9157
             * Loop over List of Metadata Objects fetched for Lead Country or Default for Other Markets.
             * It fetches the Field from Metadata, checks the data type of the field and assigns the anonymized value (Stored in metadata)
            */
			// 3/11/2020/Dipika Gupta/ CZ 295643 if BAT_IsAppendValue__c is true, need to append the value in existing value
			// 3/11/2020/Dipika Gupta/ CZ 295643 if BAT_IsCurrentDate__c is true, date field will be updated with current date
            if(!countryToMtdMap.isEmpty()){
                for(BAT_AnonymisationMarketConfiguration__mdt anonymiseMtdObj : countryToMtdMap.get(KeyStr)){
                     System.debug('BAT_Market__c: ' + anonymiseMtdObj.BAT_Market__c);
    System.debug('BAT_FieldAPIName__c: ' + anonymiseMtdObj.BAT_FieldAPIName__c);
    System.debug('BAT_FieldValue__c: ' + anonymiseMtdObj.BAT_FieldValue__c);
                    
                      //Bug#1104167 - Optimize the code so that it improves the performance and it avoids the Apex CPU time exception.
                        fieldType = String.valueOf(Schema.getGlobalDescribe().get(BAT_ConstantsUtility.LEAD).getDescribe().fields.getMap().get(anonymiseMtdObj.BAT_FieldAPIName__c).getDescribe().getType());
                        if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.BOOLEAN_TYPE)){
                            System.debug('Entered boolean ' + anonymiseMtdObj.BAT_FieldAPIName__c);
                            lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, Boolean.valueOf(String.valueOf(anonymiseMtdObj.BAT_FieldValue__c))); 
                        }
                        if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.EMAIL_STR)){
                             lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, anonymiseMtdObj.BAT_IsAppendValue__c ? lead.get(anonymiseMtdObj.BAT_FieldAPIName__c)+ String.valueOf(anonymiseMtdObj.BAT_FieldValue__c): lead.id + String.valueOf(anonymiseMtdObj.BAT_FieldValue__c));
                       
                        }
                        if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.STRING_STR) || fieldType.equalsIgnoreCase(BAT_ConstantsUtility.PHONE_STR)||
                          fieldType.equalsIgnoreCase(BAT_ConstantsUtility.PICKLIST_STR) || fieldType.equalsIgnoreCase(BAT_ConstantsUtility.TEXTAREA_STR)){
                            lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, anonymiseMtdObj.BAT_IsAppendValue__c ? lead.get(anonymiseMtdObj.BAT_FieldAPIName__c)+ String.valueOf(anonymiseMtdObj.BAT_FieldValue__c):String.valueOf(anonymiseMtdObj.BAT_FieldValue__c));
                        }
                        if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATETIME_STR)){
                            lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, anonymiseMtdObj.BAT_FieldValue__c != null ? DateTime.valueOf(anonymiseMtdObj.BAT_FieldValue__c) : null);
                        }
						
                        if(anonymiseMtdObj.BAT_FieldAPIName__c.equalsIgnoreCase(BAT_ConstantsUtility.BIRTH_DATE_API_STR) && lead.BirthDate__c != null){
                            if(anonymiseMtdObj.BAT_BlankDate__c){
                               lead.BirthDate__c= null; 
                            }else {
                                Integer yearOfBirth=lead.BirthDate__c.year();
                                lead.BirthDate__c=Date.newInstance(yearOfBirth,1,1);
                            }
                        }
						else if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATE_STR)){
                            lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, anonymiseMtdObj.BAT_IsCurrentDate__c ? Date.today() :(anonymiseMtdObj.BAT_FieldValue__c != null ? Date.valueOf(anonymiseMtdObj.BAT_FieldValue__c) : null));
                        }
                }
            }
			// 3/11/2020/Dipika Gupta/ CZ 295643 if BAT_IsRetainPrivacySnapShot__c is true, do not delete priavcy snapshot records
			//31/10/2022/Idress Ali / SE - 1098948 - SE - Salesforce Data Retention Policy - Privacy Snapshots - Part 2
			boolean isDeletePrivacySnapshot = true;
            if((!automaticAnonymizationConfigMap.containsKey(lead.Country__c) && lead.Country__c != BAT_ConstantsUtility.COUNTRY_SE)
                  ||(automaticAnonymizationConfigMap.containsKey(lead.Country__c) &&
                        !automaticAnonymizationConfigMap.get(lead.Country__c).BAT_IsRetainPrivacySnapShot__c) ||
              (lead.Country__c == BAT_ConstantsUtility.COUNTRY_SE && (Date.today().addYears(-10) >= lead.BAT_LastEmailDate__c ) )){
                 isDeletePrivacySnapshot = deletePrivacySnapshot(lead) ;          
			}
            //11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
            if(automaticAnonymizationConfigMap.containsKey(lead.Country__c) &&
               automaticAnonymizationConfigMap.get(lead.Country__c).BAT_Anonymize_Related_Survey__c){
                   List<Id> leadIds = new List<Id>();
                   leadIds.add(lead.Id);
                   BAT_Utilities.anonymizeRelatedSurveyInvitation(leadIds,null);
               }
            //VSTS 1112-CH2874369 - Privacy issue
            if(lead!=null && isDeletePrivacySnapshot){
                  system.debug('&&&&&&&&&');
                leadIDSet.add(lead.Id);
                //Workitem - 8593 Setting flag to true to exempt trigger run
                BAT_ConstantsUtility.isTriggerBypassed = true;
                //Added logic to delete lead history on lead anonymization
                if(automaticAnonymizationConfigMap.containskey(lead.country__c) && automaticAnonymizationConfigMap.get(lead.country__c).BAT_DeleteLeadHistory__c){
                    BAT_Utilities.deleteLeadHistory(leadIDSet, UserInfo.getUserId());
                }
                update lead;
                system.debug('@@@@@@@@@@');
                returnMap.put(Label.LIGHTNING_Success_Label,Label.ANONYMIZE_Success_Message);
            }
            else{
                    system.debug('***********');
                returnMap.put(Label.LIGHTNING_Error_Label,Label.ANONYMIZE_Error_Message);
            }
        }catch(Exception ex){
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.ANONYMIZE_LEAD_CONTROLLER_CLASS,BAT_ConstantsUtility.ANONYMIZE_LEAD_METHOD);
            returnMap.put(Label.LIGHTNING_Error_Label,Label.ANONYMIZE_Error_Message);
             system.debug('00000000000');
        }
        return returnMap;
    }
    /********************************************************************************************************
    * @Author        :   Deloitte.
    * @Date          :   01/21/2019.
    * @Description   :   This method called from anonymizelead method to delete the privacy snapshot.
    * @Paramters     :   Lead.
    * @Return        :   boolean.
	* @changeHistory :   23.03.220/Tejaswi Nissanluka/ Added Null check before DML operation as part of ForceReviewer changes.
    *********************************************************************************************************/ 
    private static boolean deletePrivacySnapshot(Lead lead){
        try{
            List<ContentDocument> documents = new List<ContentDocument>();
            if(!String.isEmpty(lead.Country__c)){
                List<Privacy_Snapshot_Permission__mdt> pSnapshots = new List<Privacy_Snapshot_Permission__mdt>();
                pSnapshots = [SELECT Document_Name__c
                              FROM Privacy_Snapshot_Permission__mdt 
                              WHERE DeveloperName = : lead.Country__c ];
                if(!pSnapshots.isEmpty()){
                    //Updated code to fix DEF-1718 - GDPR - Privacy snapshots not deleted when account is anonymised.
                    //Querying the content document links related to the lead and prepare for deletion.
                    for(ContentDocumentLink cdl : [SELECT id, ContentDocumentId 
                                                   FROM ContentDocumentLink 
                                                   WHERE LinkedEntityID = :lead.Id]){
                         documents.add(new ContentDocument(ID = cdl.ContentDocumentId));
                    }
					
					//Added Null check before DML operation as part of ForceReviewer changes.
                    if(documents != null && !documents.isEmpty()){
                      delete documents;
                    }
                }
            }
        }
        catch(Exception ex){
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.ANONYMIZE_LEAD_CONTROLLER_CLASS,BAT_ConstantsUtility.DELETE_PRIVACY_SNAPSHOT_METHOD);
            return false;
        }
        return true;  
    }
    /********************************************************************************************************
    * @Author        :   Deloitte.
    * @Date          :   01/21/2019.
    * @Description   :   this method called from anonymizelead method to generate the Anonymization files.
    * @Paramters     :   Lead,String.
    * @Return        :   Void.
	* @changeHistory :   23.03.220/Tejaswi Nissanluka/ Added Null check before DML operation as part of ForceReviewer changes.
    *********************************************************************************************************/ 
    @TestVisible
    private static void generateAnonymizationFile(Lead lead,String country){
        List<Anonymization_File_Configuration__mdt> anonymizeFileConfs = new List<Anonymization_File_Configuration__mdt>();
        anonymizeFileConfs = [SELECT MasterLabel,File_Name__c,Folder_API_Name__c 
                              FROM Anonymization_File_Configuration__mdt 
                              WHERE MasterLabel=:country];
        if(!anonymizeFileConfs.isEmpty()){
            String leadFullName=lead.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + lead.LastName + BAT_ConstantsUtility.SINGLE_SPACE + '(LEAD)' + '\n'; 
            Folder folder = new Folder();
            List<Document> existingFiles = new List<Document>();
            List<Document> docToUpdate=new List<Document>();
            List<Document> docToInsert=new List<Document>();
            if(anonymizeFileConfs[0].Folder_API_Name__c != null){
	            folder = [SELECT ID FROM Folder WHERE DeveloperName=:anonymizeFileConfs[0].Folder_API_Name__c LIMIT 1];
            }
            if(anonymizeFileConfs[0].File_Name__c != null){
	            existingFiles=[SELECT ID,Body FROM Document WHERE Name= :anonymizeFileConfs[0].File_Name__c AND FolderId= :folder.id];
            }
            if(!existingFiles.isEmpty()){
                Document currentDoc=existingFiles[0];
                String currentBody=currentDoc.Body.toString();
                currentDoc.Body=Blob.valueOf(currentBody+leadFullName);
                docToUpdate.add(currentDoc);   
            }else if(anonymizeFileConfs[0].File_Name__c != null && folder.id != null){
                Document newDoc=new Document();
                newDoc.Name=anonymizeFileConfs[0].File_Name__c;
                newDoc.FolderId=folder.id;
                newDoc.ContentType = BAT_ConstantsUtility.CONTENT_TYPE_TEXTPLAIN;
                newDoc.Type= BAT_ConstantsUtility.TYPE_TEXT;
                newDoc.Body=Blob.valueOf(leadFullName);
                docToInsert.add(newDoc);  
            }
			
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(docToUpdate != null && !docToUpdate.isEmpty()){
                try{
                    update docToUpdate;
                }catch(Exception ex){
                    BAT_Utilities.createLog(ex,BAT_ConstantsUtility.ANONYMIZE_LEAD_CONTROLLER_CLASS,BAT_ConstantsUtility.GENERATE_ANONYMIZE_FILE_METHOD + ' (UPDATE)');
                } 
            }
			
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(docToInsert != null && !docToInsert.isEmpty()){
                try{
                    insert docToInsert;
                }catch(Exception ex){
                    BAT_Utilities.createLog(ex,BAT_ConstantsUtility.ANONYMIZE_LEAD_CONTROLLER_CLASS,BAT_ConstantsUtility.GENERATE_ANONYMIZE_FILE_METHOD + ' (INSERT)');
                }
            
            }

        }
    }  
}