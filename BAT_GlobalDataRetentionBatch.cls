/*******************************************************************************************************************************
@Class: BAT_GlobalDataRetentionBatch
@Version: 1.0
@Author: Deloitte USI
@Purpose:  Created Generic batch as part of Salesforce Data Retention Policy for various Countries
@Change history: 08-12-2021/Idrees Ali/US #756326 : Created batch
04-04-2022/Turbasu Ghosh / Bug #905783/Added leadPlatformEventFlag- Avoid trigger run if lead is anonymized send platform event 
06-04-2022/Praveen/US #897350: UK - Salesforce Data Retention Policy - Account(Technical Re-work)
06-05-2022/Rajeswari/US #829216: ZA - Salesforce Data Retention Policy - Account
16-05-2022/Sonal Srivastava/US #778529: FR - Salesforce Data Retention Policy - Lead
14-08-2022/Idrees Ali/ ENH - Sprint 111- US#861864 - SE - Salesforce Data Retention Policy - Leads- Enabled SE for lead reverse integration
and added code to disable snapshot deletion for leads 
10-Nov-2022/Praveen/ US #1136793 : SI - Account - Data Retention Policy
10-Nov-2022/Praveen/ US #1204932:UK - data retention Batch throttling of the anonymization requests through Mulesoft 
10-Feb-2023/Rahul Upadhyay/ US #798020:NL - Salesforce Data Retention Policy - Order-Updated query to return blank when condition extracted is null
07-March-2023/Swaraj Ray/ US #861816: SE - Salesforce Data Retention Policy - Cases
21.03.2023/ Idrees Ali/ US#1285878: Data Archival Process - Discrepancy with regard to Field Values & Throttling mechanism Redesign- Added logic for enabling batch to schedule 
automatically every 5 minutes for objects-market requiring throttling of reverse integration requests driven via custom setting
29.09.2023/Lalit / US:#1503391|| HR|SI - DATA RETENTION POLICY -Account
06-Dec-2023/BJSURAJ/US: #1579492 - RO - Lead Anonymization & unsubscribing process
18-Jan-2024/BJSURAJ/US: #1602116 - IT | Old Case and SurveyTaker__c records anonymization flow
*********************************************************************************************************************************/
global class BAT_GlobalDataRetentionBatch implements Database.Batchable<sObject>,Database.Stateful, Database.AllowsCallouts {
    global Map<String,BAT_GlobalDataRetentionConfig__mdt> globalDataRetentionConfigMap = new Map<String,BAT_GlobalDataRetentionConfig__mdt>();
    global Map<String,List<BAT_GlobalAnonymisationMapping__mdt>> globalAnonymisationMap = new Map<String,List<BAT_GlobalAnonymisationMapping__mdt>>();
    global Map<String,List<BAT_AccountToCaseMappingConfiguration__mdt>> accToCaseMappingConfigMap = new Map<String,List<BAT_AccountToCaseMappingConfiguration__mdt>>();
    String query = BAT_ConstantsUtility.SELECTSTRING; 
    String objectName= BAT_ConstantsUtility.BLANK;
    String countryName= BAT_ConstantsUtility.BLANK;
    String directoryLocation= BAT_ConstantsUtility.BLANK;
    Integer sequence,maxSize,sleepTime;
    List<String> fieldToQueryList = new List<String>();
    Map<Integer,String> countrySequenceMap = new Map<Integer,String>();
    List<BAT_GlobalDataRetentionConfig__mdt> configList = new List<BAT_GlobalDataRetentionConfig__mdt>();
    Set<Id> successfulAnonymisedRecordsIdSet = new Set<Id>();
    Map<Integer,BAT_GlobalDataRetentionConfig__mdt> CountryConfigMap = new Map<Integer,BAT_GlobalDataRetentionConfig__mdt>();
    public final Static String strTodayDate = DateTime.now().format(BAT_ConstantsUtility.DD_MM_YYYY);
    Set<String> relatedLeadIdsSet = new Set<String>();
    Set<Id> successfulDeletionRecordsIdSet = new Set<Id>();
    Map<String,Boolean> mapOfObjectsToThrottle = new Map<String,Boolean>();
    Integer countOfRecords = 0;
    map<String,map<String,list<sObject>>> mapOfRelatedRecords = new map<String,map<String,list<sObject>>>();
    //1630499- CA-Vuse Re-Activating Cold Records starts//
    Boolean isdeletechild=false;
    Boolean orderbypass=false;
    //1630499- CA-Vuse Re-Activating Cold Records ends
    
    //Constructor
    global BAT_GlobalDataRetentionBatch(Integer sequence){
        //param1 - 1 - country sequence for metadata records
        //param2 - Maximum size of each query limit
        //param3 - Sleep time for each execute method
        this(sequence, null,null);
    }
    //Constructor
    global BAT_GlobalDataRetentionBatch(Integer sequence,Integer maxSize,Integer sleepTime){
        //Storing the sequence of the object in context
        this.sequence = sequence;
        //Each query limit value
        this.maxSize = maxSize;
        //Sleep time for each execute method
        this.sleepTime = sleepTime;
        //String to store limit check
        String queryLimit = maxSize > 0 ? BAT_ConstantsUtility.LIMIT_STRING+ maxSize:'';
        Boolean isFirstLoop = true;
        String fieldsToQueryString = BAT_ConstantsUtility.BLANK;
        Integer i,j = 1;
          //1630499- CA-Vuse Re-Activating Cold Records added BAT_IsChildDeletion__c in soql--//
        for(BAT_GlobalDataRetentionConfig__mdt batch: [Select MasterLabel,BAT_ObjectName__c,BAT_AzureStorageLocation__c,BAT_WhereClause__c,BAT_Sequence__c,BAT_IsDeletionRequired__c,BAT_IsAnonymisationRequired__c,BAT_FieldToQuery__c,BAT_IsThrottlingRequired__c,BAT_IsChildDeletion__c 
                                                       FROM BAT_GlobalDataRetentionConfig__mdt WHERE Active__c=true and  BAT_ObjectName__c='Account' ORDER BY MasterLabel,BAT_Sequence__c]){
                                                           configList.add(batch);
                                                           CountryConfigMap.put(j, batch);
                                                           mapOfObjectsToThrottle.put(batch.MasterLabel + BAT_ConstantsUtility.STR_COLON + batch.BAT_ObjectName__c, batch.BAT_IsThrottlingRequired__c );
                                                           j++;
                                                       }
        
        BAT_GlobalDataRetentionConfig__mdt batch = CountryConfigMap.get(sequence);
         system.debug('Testbatch'+batch);
        countrySequenceMap.put(sequence,batch.MasterLabel);
        countryName = countrySequenceMap.get(sequence);
        objectName = batch.BAT_ObjectName__c;
        directoryLocation = batch.BAT_AzureStorageLocation__c;
          //1630499- CA-Vuse Re-Activating Cold Records starts--//
        isdeletechild  =batch.BAT_IsChildDeletion__c;
          //1630499- CA-Vuse Re-Activating Cold Records ends--//
        system.debug('Testingisdeletechild'+isdeletechild);
        //creating a map of country vs metadata record for the object in context
        globalDataRetentionConfigMap.put(batch.MasterLabel,batch);
      
        Map<String, Schema.SObjectType> global_describe = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> object_fields_map = global_describe.get(objectName).getDescribe().fields.getMap(); 
        List<String> objFieldNames = new List<String>();
        for(Schema.SObjectField strFieldName:object_fields_map.values()){
            objFieldNames.add(String.valueOf(strFieldName));
        }
        for(String strFieldName:objFieldNames){
            fieldsToQueryString += strFieldName + BAT_ConstantsUtility.COMMA_STR;
        }
        fieldsToQueryString = fieldsToQueryString.removeEnd(BAT_ConstantsUtility.COMMA_STR);
        query += fieldsToQueryString + BAT_ConstantsUtility.ASSET_SYNC_BATCH_SOQLFROM + objectName  + BAT_ConstantsUtility.WHERE_STR  ;

        for(String country: globalDataRetentionConfigMap.Keyset()){
            //Building query string with conditions extracted from metadata record
            if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR)){
                String whereCondition = BAT_ConstantsUtility.BAT_BATCH_ACC_COUNTRY + country + BAT_ConstantsUtility.QUERY_APOSTROPHE;
                whereCondition += String.isBlank(globalDataRetentionConfigMap.get(country).BAT_WhereClause__c) ? '' : BAT_ConstantsUtility.AND_STRING+globalDataRetentionConfigMap.get(country).BAT_WhereClause__c;
                query = isFirstLoop ? query + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + whereCondition + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR:
                query + BAT_ConstantsUtility.QUERY_OR + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + whereCondition + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR;
                isFirstLoop = false;
            }
            //1703189-DE - multicategory Loyalty program - Anonymisation starts--
            else if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.BRAND_PROFILE_OBJECT_API_NAME)){// brandprofile anonymization
                query = isFirstLoop ? query + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + globalDataRetentionConfigMap.get(country).BAT_WhereClause__c + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR:
                query + BAT_ConstantsUtility.QUERY_OR + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + globalDataRetentionConfigMap.get(country).BAT_WhereClause__c + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR;
                isFirstLoop = false;
            }
            //1703189-DE - multicategory Loyalty program - Anonymisation ends--
            
            else if(objectName != BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT){
                //US #798020: NL_Order- sending blank value when conditions extracted from metadata record is null 
                String whereCondition = BAT_ConstantsUtility.BAT_BATCH_ACC_COUNTRY + country + BAT_ConstantsUtility.QUERY_APOSTROPHE; 
                whereCondition += String.isBlank(globalDataRetentionConfigMap.get(country).BAT_WhereClause__c) ? '' : BAT_ConstantsUtility.AND_STRING+globalDataRetentionConfigMap.get(country).BAT_WhereClause__c;
                query = isFirstLoop ? query + BAT_ConstantsUtility.BATCH_COUNTRY_FILTER +country+ BAT_ConstantsUtility.BATCH_AND_FILTER +whereCondition + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR:
                query + BAT_ConstantsUtility.BATCH_COUNTRY_FILTER_WITH_OR +country+ BAT_ConstantsUtility.BATCH_AND_FILTER +whereCondition+ BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR;
                isFirstLoop = false;
            }else{
                query = isFirstLoop ? query + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + globalDataRetentionConfigMap.get(country).BAT_WhereClause__c + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR:
                query + BAT_ConstantsUtility.QUERY_OR + BAT_ConstantsUtility.OPEN_PARENTHESIS_STR + globalDataRetentionConfigMap.get(country).BAT_WhereClause__c + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR;
                isFirstLoop = false;
            }
        }
        if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR)){
            if(countryName == BAT_ConstantsUtility.COUNTRY_KZ){
                //BJSURAJ/US: #1335387 - KZ -  anonymization of all KZ accounts from CRM
                query = query + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR+BAT_ConstantsUtility.AND_STRING+BAT_ConstantsUtility.BAT_BATCH_ACC_COMMON_CONDITION + queryLimit;
                query = query.replace(BAT_ConstantsUtility.Month24AnonymizeCountdownIsZero, BAT_ConstantsUtility.Month24AnonymizeCountdownIsNull);
            }
          /*  else if(countryName == BAT_ConstantsUtility.COUNTRY_SK){
                query = query + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR+BAT_ConstantsUtility.AND_STRING+BAT_ConstantsUtility.BAT_BATCH_ACC_COMMON_CONDITION + queryLimit;
                query = query.replace(BAT_ConstantsUtility.Month24AnonymizeCountdownIsZero, BAT_ConstantsUtility.Month24AnonymizeCountdownIsNull);
                
                 System.debug('line no 124' +query);
            }*/
               //Lalit / US:#1503391|| Adding where clause condition for Account Query
            else if(globalDataRetentionConfigMap.get(countryName).BAT_WhereClause__c!=null){
              query = query  + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR +queryLimit;
            } 
            else{
                query = query + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR+BAT_ConstantsUtility.AND_STRING+BAT_ConstantsUtility.BAT_BATCH_ACC_COMMON_CONDITION + queryLimit;
            }
        }
        
        /*if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_LEAD_STR)){
            if(countryName == BAT_ConstantsUtility.COUNTRY_CZ){
                //REEMA
            System.debug('Lead line no 139');  
            }
         }*/
        else{
            query = query + BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR+ queryLimit; 
        }
        
        System.debug('++Query ' +query);

        
    }
    

    //batch start method   
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //18-Jan-2024/BJSURAJ/US: #1602116/Added Country Check
        if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.OBJECT_SURVEYTAKER) && query.containsIgnoreCase(BAT_ConstantsUtility.COUNTRY)){
            query = query.replaceAll(BAT_ConstantsUtility.COUNTRY,BAT_ConstantsUtility.SURVEYTAKER_COUNTRY);
            query = query.replaceAll(BAT_ConstantsUtility.SURVEYTAKER_COUNTRY2,BAT_ConstantsUtility.SURVEYTAKER_COUNTRY);
        }
        if(objectName.equalsIgnoreCase('Case') && countryName.equalsIgnoreCase('IT')){
            System.debug('bjs_IT_Case_query = '+ query);
        }
        system.debug('reema'+query);
        return Database.getQueryLocator(query);
        //system.debug('reema'+query);
    } 
    //batch execute method
    global void execute(Database.BatchableContext BC, list<sObject> scope){
        //Calling sleep method for each execute() - to have some time for magento to process anonymous records
        if(!Test.isRunningTest() && sleepTime!=null){            
            Sleep(sleepTime);
        }
        List<sObject> objectAnonymisationRecordsList = new List<sObject>();
        List<sObject> objectDeletionRecordsList = new List<sObject>();
        List<sObject> finalObjectDeletionRecordsList = new List<sObject>();
        List<ContentDocument> privacyDocsList = new List<ContentDocument>();
        List<Case> caseToUpdateList = new List<Case>();
        //1630499- CA-Vuse Re-Activating Cold Records starts--//
         List<Case> caseToDeleteList = new List<Case>();
        //1630499- CA-Vuse Re-Activating Cold Records ends--//
        List<sObject> chatTranscriptToDeleteList = new List<sObject>();
        List<sObject> campaignMemToDeleteList = new List<sObject>();
        List<sObject> productInterestToDeleteList = new List<sObject>();
        List<sObject> ordersToUpdateList = new List<sObject>();
        Map<String,sObject> anonymisedRecordMap = new Map<String,sObject>();
        Map<String,sObject> ordersToAnonymizeMap = new Map<String,sObject>();
        Map<String,sObject> casesToAnonymizeMap = new Map<String,sObject>();  
        Map<String,sObject> leadsToAnonymizeMap = new Map<String,sObject>();
        Map<Id,List<LiveChatTranscript>> chatTranscriptsToDeleteMap = new Map<Id,List<LiveChatTranscript>>();
        Map<Id,List<Order>> accountRelatedOrdersDeleteMap = new Map<Id,List<Order>>();
        Set<Id> successfullyUpdatedOrderRecordsIdSet = new Set<Id>();
        Set<Id> contactIdSet = new Set<Id>();
        
        Set<Id> accountanonymiseRecordsIdSet = new Set<Id>();
        Set<Id> sObjectdeletionRecordsIdSet = new Set<Id>();
        Map<String,List<Lead>> leadMapReverseIntUpdate = new Map<String,List<Lead>>();

        Map<Id,SObject> oldObjectMap = new Map<Id,SObject>();
        Set<String> APIFirstEnabledCountrySet = new Set<String>{BAT_ConstantsUtility.COUNTRY_FR,BAT_ConstantsUtility.COUNTRY_SE};
            // Reverse integration for platform Events starts //
        Set<String> PlatformEventFirstEnabledCountrySet = new Set<String>{BAT_ConstantsUtility.COUNTRY_IT};
          Map<String,List<Sobject>> sobjRecReverseIntUpdate = new Map<String,List<Sobject>>();
            // Reverse integration for platform Events ends //
            Set<Id> successfulAnonymisedRecordsIdSetForSnapshotDeletion = new Set<Id>();
        String countryStr = BAT_ConstantsUtility.BLANK;
        
        for(sObject objRec : scope){
            //Maintaining count of records returned as part of scope
            ++countOfRecords;
            if(objectName != BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT){
                //18-Jan-2024/BJSURAJ/US: #1602116/Added Country Check
                if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.OBJECT_SURVEYTAKER)){
                    countryStr = String.valueOf(objRec.get(BAT_ConstantsUtility.SURVEYTAKER_COUNTRY));
                }
                 //1703189-DE - multicategory Loyalty program - Anonymisation starts--
                else if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.BRAND_PROFILE_OBJECT_API_NAME)){
                    countryStr = String.valueOf(objRec.get(BAT_ConstantsUtility.BRAND_PROFILE_COUNTRY_API_NAME));
                }
                 //1703189-DE - multicategory Loyalty program - Anonymisation ends--
                else{
                    countryStr = String.valueOf(objRec.get(BAT_ConstantsUtility.COUNTRY));
                }
                if(objectName.equalsIgnoreCase('Case') && countryStr.equalsIgnoreCase('IT')){
                    System.debug('bjs_IT_Case_objRec = '+ objRec);
                }
                //Segregating lists for anonymisation/deletion of objects based upon metadata record
                if(globalDataRetentionConfigMap.containsKey(countryStr) && globalDataRetentionConfigMap.get(countryStr).BAT_IsAnonymisationRequired__c){
                    objectAnonymisationRecordsList.add(objRec);
                    accountanonymiseRecordsIdSet.add((Id)objRec.get('Id'));
                    if(objectName == BAT_ConstantsUtility.LEAD_STR ){
                        oldObjectMap.put((Id)objRec.get('Id'),objRec.clone());
                    }
                }
                if(globalDataRetentionConfigMap.containsKey(countryStr) && globalDataRetentionConfigMap.get(countryStr).BAT_IsDeletionRequired__c){
                    objectDeletionRecordsList.add(objRec);
                    sObjectdeletionRecordsIdSet.add((Id)objRec.get('Id'));
                }
            }else{
                objectDeletionRecordsList.add(objRec);
            }
        }

        //US#829216 - Start
        //below if block stores all orders created within last 3 years related to the account records
        if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
            //Creating a map of Account ID vs List related order records created within last 3 years
            for(Order orderRec: [Select Id,AccountId from Order where AccountId IN:accountanonymiseRecordsIdSet and CreatedDate >= LAST_N_Days:1095 and Country__c='ZA' and account.Country__c = 'ZA']){
                if(!accountRelatedOrdersDeleteMap.containsKey(orderRec.AccountId)){
                    accountRelatedOrdersDeleteMap.put(orderRec.AccountId, new List<Order>());
                }
                accountRelatedOrdersDeleteMap.get(orderRec.AccountId).add(orderRec);
            }
        } 
        //Deleting account records from anonymization list taht has orders created within last 3 years
        if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR && !objectAnonymisationRecordsList.isEmpty()){
            if(!accountRelatedOrdersDeleteMap.isEmpty()){
                integer i=0;
                while (i < objectAnonymisationRecordsList.size()){
                    if(accountRelatedOrdersDeleteMap.containskey(objectAnonymisationRecordsList.get(i).id)){
                        objectAnonymisationRecordsList.remove(i); 
                    } else {
                        i++;
                    }   
                }
            }
        } // US#829216 - End
        
        
        Boolean isFileUploaded = false;
        //Turn On/Off label
        if(Boolean.valueOf(Label.AnonymizationBackupON)){
           
            String strCurrentTimeMain = DateTime.now().format(BAT_ConstantsUtility.HH_MM_A);
            if(globalDataRetentionConfigMap.containsKey(countryStr) && globalDataRetentionConfigMap.get(countryStr).BAT_IsAnonymisationRequired__c){
                Blob blobFile = BAT_Utilities.generateCSVBlob(objectName,objectAnonymisationRecordsList);
                isFileUploaded = Test.isRunningTest()? true: new BAT_AzureFilesCalloutService(BAT_ConstantsUtility.AZURE_FILE_API_NAMED_CREDENTIAL ,BAT_ConstantsUtility.AZURE_TOKEN_PROVIDER).uploadPDFFile(countryName, directoryLocation+strTodayDate ,blobFile, objectName+'_'+strCurrentTimeMain+'.csv');
            }
            if(globalDataRetentionConfigMap.containsKey(countryName) && globalDataRetentionConfigMap.get(countryName).BAT_IsDeletionRequired__c){
                Blob blobFile = BAT_Utilities.generateCSVBlob(objectName,objectDeletionRecordsList);
                isFileUploaded = Test.isRunningTest()? true: new BAT_AzureFilesCalloutService(BAT_ConstantsUtility.AZURE_FILE_API_NAMED_CREDENTIAL ,BAT_ConstantsUtility.AZURE_TOKEN_PROVIDER).uploadPDFFile(countryName, directoryLocation+strTodayDate ,blobFile, objectName+'_'+strCurrentTimeMain+'.csv');
            }
        }
        
        
        //Enter anonymisation if the backup file is uploaded or the Backup creation is inactive
        if(isFileUploaded || !Boolean.valueOf(Label.AnonymizationBackupON)){
            //below If block deals with anonymisation process
            if(!objectAnonymisationRecordsList.isEmpty()){
                //US#829216 - added country check to not stamp PII fields on case object for ZA
                //Added below logic to update all case records related to account for stamping PII fields on case object
                if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                    accToCaseMappingConfigMap = BAT_Utilities.getAccountToCaseMappingConfig();
                    //Storing PersonContactID in the set
                    for(sObject accRec : objectAnonymisationRecordsList){
                        if(accRec.get(BAT_ConstantsUtility.COUNTRY) != BAT_ConstantsUtility.Country_ZA){
                            contactIdSet.add((Id)String.valueOf(accRec.get(BAT_ConstantsUtility.ACCOUNT_PERSONCONTACTID_APINAME)));
                        }
                    }
                    //Stamping PII data related fields on case from corresponding values on account
                    if(!contactIdSet.isEmpty()){
                        List<Case> caseList = new List<Case>();
                        System.debug('bjs_countryName = '+ countryName);
                        if(countryName.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT)){//18-Jan-2024/BJSURAJ/US: #1602116/Added Country Check For IT
                            System.debug('bjs_getting case records queried');
                            caseList = [Select Id,AccountEmail__c,Subject,Description,AccountName__c,Mobile_DE__c,First_Name__c,Last_Name__c,Phone_Number__c,Email__c,Country__c,ContactId,BAT_City__c,RecordTypeId from Case];
                            For(Case cs : [Select Id,AccountEmail__c,Subject,Description,AccountName__c,Mobile_DE__c,First_Name__c,Last_Name__c,Phone_Number__c,Email__c,Country__c,ContactId,BAT_City__c,RecordTypeId from Case where ContactId IN : contactIdSet]){
                                System.debug('bjs_IT_Case = '+ cs);
                            }
                            System.debug('bjs_caseList.size = '+ caseList + ', and caseList record is = ' + caseList);
                        }else{
                            System.debug('bjs_NO_IT_Case_is_available');
                            caseList = [Select Id,First_Name__c,Last_Name__c,Phone_Number__c,Email__c,Country__c,ContactId,BAT_City__c,RecordTypeId from Case where ContactId IN : contactIdSet];
                        }
                        
                        if(!caseList.isEmpty()){
                            caseToUpdateList = BAT_Utilities.caseFieldUpdateBasedOnMapping(contactIdSet,caseList,accToCaseMappingConfigMap);
                        }
                    }
                    //Updating the Case Records
                    if(!caseToUpdateList.isEmpty()){
                        //Bypassing trigger for Case update
                        BAT_ConstantsUtility.isTriggerBypassed = true;
                        Database.SaveResult[] updatedCasesList = Database.update(caseToUpdateList, false);
                        BAT_ConstantsUtility.isTriggerBypassed = false;
                        BAT_Utilities.createErrorLogs(updatedCasesList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    }
                }
                //common method used for anonymising fields for objects
                anonymisedRecordMap = BAT_Utilities.genericFieldAnonymisationPopulationMethod(objectName,objectAnonymisationRecordsList);
                //Below block will anonymise the context object and store the ID's of successful ones for related objects anonymisation
                if(!anonymisedRecordMap.isEmpty()){
                    //US# 778529 - FR - Salesforce Data Retention Policy - Lead - API first approach Changes for Lead Reverse Integration 
                    for(sObject leadrec : anonymisedRecordMap.values()){
                        if(objectName == BAT_ConstantsUtility.LEAD_STR && !APIFirstEnabledCountrySet.isEmpty() && APIFirstEnabledCountrySet.contains(String.ValueOf(leadrec.get(BAT_ConstantsUtility.COUNTRY)))) {
                            if(leadMapReverseIntUpdate.isEmpty() || !leadMapReverseIntUpdate.containsKey(BAT_ConstantsUtility.EVENT_DELETE)){
                                leadMapReverseIntUpdate.put(BAT_ConstantsUtility.EVENT_DELETE, new List<Lead>());
                            }
                            leadMapReverseIntUpdate.get(BAT_ConstantsUtility.EVENT_DELETE).add((Lead)leadrec);
                        }
                       } 
                    if(!leadMapReverseIntUpdate.isEmpty()){
                        BAT_Utilities.getUserDetailsGlobal();
                        if(countryName.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR)){
                            BAT_ReverseAPICallHandlerV2.MethodParameters apiHandlerMethodParameters = new BAT_ReverseAPICallHandlerV2.MethodParameters(); 
                            apiHandlerMethodParameters.eventType = BAT_ConstantsUtility.EVENT_DELETE;
                            apiHandlerMethodParameters.objectName = BAT_ConstantsUtility.LEAD_STR;
                            apiHandlerMethodParameters.countryAPI = BAT_ConstantsUtility.COUNTRY;
                            apiHandlerMethodParameters.listOfEligibleRecords = leadMapReverseIntUpdate.get(BAT_ConstantsUtility.EVENT_DELETE);
                            apiHandlerMethodParameters.oldMap = oldObjectMap;
                            BAT_ReverseAPICallHandlerV2 apiHandler = new BAT_ReverseAPICallHandlerV2(); 
                            apiHandler.CallReverseAPI(apiHandlerMethodParameters);
                            if(!BAT_Utilities.batchContextIntegrationLogList.isEmpty()){
                                insert BAT_Utilities.batchContextIntegrationLogList;
                            }
                        }
                        else{
                            BAT_ReverseAPICallHandler.initiateReverseAPIFromBatch(leadMapReverseIntUpdate, BAT_ConstantsUtility.LEAD_STR, BAT_ConstantsUtility.COUNTRY,oldObjectMap);
                        }
                    }
                    
                    //End of US# 778529 - FR - Salesforce Data Retention Policy - Lead
                    
                    //US#760954-UK-Salesforce Data Retention Policy - Lead- Added below check to send platform events only for Lead object
                    //Bug#905783-865425- Anonymized in Salesforce, request is not sent to Mulesoft- leadPlatformEventFlag- Added below check to send platform events only for Lead object
                    BAT_ConstantsUtility.isLeadAnonymized = (objectName == BAT_ConstantsUtility.LEAD_STR) ? true : false;
                    //first
                     // 1764639-IT | Reverse integration flow with batch anonymization starts//
                    BAT_ConstantsUtility.isReverseanonymized = (objectName == BAT_ConstantsUtility.ACCOUNT && countryName == BAT_ConstantsUtility.COUNTRY_IT)  ? true : false;
                    // 1764639-IT | Reverse integration flow with batch anonymization ends//
                    Database.SaveResult[] sObjectAnonymiseList = Database.update(anonymisedRecordMap.values(), false);
                    BAT_ConstantsUtility.leadPlatformEventFlag = (objectName == BAT_ConstantsUtility.LEAD_STR) ? true : false;
                    BAT_ConstantsUtility.isLeadAnonymized = false;
                    //End of US#760954-UK-Salesforce Data Retention Policy - Lead
                    BAT_Utilities.createErrorLogs(sObjectAnonymiseList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    if(!sObjectAnonymiseList.isEmpty()){
                        for (Database.SaveResult anonymisedSuccessRecord : sObjectAnonymiseList) {
                            if(anonymisedSuccessRecord.isSuccess()){
                                //Storing record Ids of all successfully anonymised records
                                successfulAnonymisedRecordsIdSet.add(anonymisedSuccessRecord.getId());
                                if(objectName == BAT_ConstantsUtility.LEAD_STR){
                                    String leadCountryInContext = String.valueOf(anonymisedRecordMap.get(String.valueOf(anonymisedSuccessRecord.getId())).get(BAT_ConstantsUtility.COUNTRY));
                                    Id leadRecId = anonymisedSuccessRecord.getId();
                                    if(leadCountryInContext != BAT_ConstantsUtility.COUNTRY_SE || 
                                       (leadCountryInContext == BAT_ConstantsUtility.COUNTRY_SE && oldObjectMap.get(leadRecId).get(BAT_ConstantsUtility.EMAILOPTOUT_FIELDAPINAME_STR) == true && 
                                        oldObjectMap.get(leadRecId).get(BAT_ConstantsUtility.LASTEMAILDATE_FIELDAPINAME_STR) == null && oldObjectMap.get(leadRecId).get(BAT_ConstantsUtility.LASTCONSENTDATE) == null)){
                                            successfulAnonymisedRecordsIdSetForSnapshotDeletion.add(anonymisedSuccessRecord.getId());
                                        }
                                }
                                else{
                                    successfulAnonymisedRecordsIdSetForSnapshotDeletion.add(anonymisedSuccessRecord.getId());
                                }
                                    
                                //below block runs only for account object and stores Id's of related leads for anonymisation
                                if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                                    relatedLeadIdsSet.add(String.valueOf(anonymisedRecordMap.get(String.valueOf(anonymisedSuccessRecord.getId())).get(BAT_ConstantsUtility.ATH_RELATED_LEAD_API)));
                                }
                            }
                        }
                    }
                }
                
                if(!sobjRecReverseIntUpdate.isEmpty()){
                        BAT_Utilities.getUserDetailsGlobal();
                        system.debug('TestingResultsobjRecReverseIntUpdate'+sobjRecReverseIntUpdate);
                        //BAT_PlatformEventHandler.initiateReverseEventFromBatch(sobjRecReverseIntUpdate,BAT_ConstantsUtility.EVENT_DELETE,objectName);
                        
                    }
                //Privacy snapshots deletion method
                privacyDocsList = !successfulAnonymisedRecordsIdSetForSnapshotDeletion.isEmpty() ? BAT_Utilities.deletePrivacySanpshots(new List<Id>(successfulAnonymisedRecordsIdSetForSnapshotDeletion)) : privacyDocsList;
                //below logic anonymises related objects for account
                //Idrees Ali/12.04.2023/ ENH SP 127 : Removed duplicate if block causing 'Entity is deleted' exception
                if(!privacyDocsList.isEmpty()){
                    Database.DeleteResult[] privacyDocsDeleteList = Database.delete(privacyDocsList,false);
                    BAT_Utilities.createErrorLogs(privacyDocsDeleteList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                //End of DML's being done for the related objects according to the context object
            }
        //below If block deals with deletion process
        if(!objectDeletionRecordsList.isEmpty()){
            //storing all object record deletion list except order since it requires updating the status 
            if(objectName != BAT_ConstantsUtility.ORDER_STR){
                finalObjectDeletionRecordsList.addAll(objectDeletionRecordsList);
            }
            // Swaraj Ray - #861816 - SE - Salesforce Data Retention Policy - Cases
                // Below code stores the related chat transcripts to case
                // // start
                if(objectName == BAT_ConstantsUtility.CASE_STR){
                    string relatedQuery = BAT_Utilities.createDynamicQueries(BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT);
                    relatedQuery = relatedQuery + BAT_ConstantsUtility.CASE_ID_IN;
                    storeRelatedRecords(BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT,BAT_ConstantsUtility.CASE_ID,relatedQuery,sObjectdeletionRecordsIdSet,mapOfRelatedRecords);
                }
                // end
            //below if block stores all chat transcripts related to the context case record
           /* if(objectName == BAT_ConstantsUtility.CASE_STR){
                //Creating a map of parent CaseId Vs List of relate chat transcript records
                for(LiveChatTranscript chatTranscriptRec : [Select Id,CaseId from LiveChatTranscript where CaseId IN:sObjectdeletionRecordsIdSet]){
                    if(!chatTranscriptsToDeleteMap.containsKey(chatTranscriptRec.CaseId)){
                        chatTranscriptsToDeleteMap.put(chatTranscriptRec.CaseId, new List<LiveChatTranscript>());
                    }
                    chatTranscriptsToDeleteMap.get(chatTranscriptRec.CaseId).add(chatTranscriptRec);
                }
            }*/
           //1630499- CA-Vuse Re-Activating Cold Records starts--//
             //if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR && countryName.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CA)){
            if(isdeletechild && objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) {
                orderbypass=true;
            for(Case caserec : [SELECT Id FROM Case WHERE AccountID IN :sObjectdeletionRecordsIdSet]){
                    caseToDeleteList.add(caserec);
                system.debug('caseToDeleteListTest'+caseToDeleteList);
               }
              
              for(Account obj : [SELECT Id,name,Related_Lead__c FROM Account WHERE Id IN :sObjectdeletionRecordsIdSet]){
                Id relatedLeadId = (Id)obj.get(BAT_ConstantsUtility.ATH_RELATED_LEAD_API);
                    if(relatedLeadId != null) {
                    relatedLeadIdsSet.add(relatedLeadId);
                }
            }
            
              for (Order orderRec : [SELECT Id, AccountId, Status,Country__c FROM Order WHERE AccountId IN :sObjectdeletionRecordsIdSet])
                 {
                     system.debug('orderstatus'+orderRec.Status);
                   if(orderRec.get(BAT_ConstantsUtility.ORDER_STATUS_APINAME) != BAT_ConstantsUtility.BAT_ORDER_STATUS_CREATED){
                    orderRec.put(BAT_ConstantsUtility.ORDER_STATUS_APINAME,BAT_ConstantsUtility.BAT_ORDER_STATUS_CREATED);
                     ordersToUpdateList.add(orderRec);
                       system.debug('ordersToUpdateListTest'+ordersToUpdateList);
                    }  
                 }
             }
            //1630499- CA-Vuse Re-Activating Cold Records ends--//
            //Order Object Deletion Process comprises first updating records to 'Created' Status and then deleting it
            
            if(objectName == BAT_ConstantsUtility.ORDER_STR)
            {
                // start
                string relatedQuery = BAT_Utilities.createDynamicQueries(BAT_ConstantsUtility.ORDERITEM_STR);
                relatedQuery = relatedQuery + BAT_ConstantsUtility.ORDER_ID_IN;
                storeRelatedRecords(BAT_ConstantsUtility.ORDERITEM_STR,BAT_ConstantsUtility.ORDER_ID,relatedQuery,sObjectdeletionRecordsIdSet,mapOfRelatedRecords);
                // end                         
                for(sObject orderRec : objectDeletionRecordsList){
                    //if the order's status is not Created, updating the status to created to allow deletion of records
                    if(orderRec.get(BAT_ConstantsUtility.ORDER_STATUS_APINAME) != BAT_ConstantsUtility.BAT_ORDER_STATUS_CREATED){
                    orderRec.put(BAT_ConstantsUtility.ORDER_STATUS_APINAME,BAT_ConstantsUtility.BAT_ORDER_STATUS_CREATED);
                        ordersToUpdateList.add(orderRec);
                    }else{
                        finalObjectDeletionRecordsList.add(orderRec);
                    }
                }
            }
                 ////1630499- CA-Vuse Re-Activating Cold Records added account and country CA--//
                //if(objectName == BAT_ConstantsUtility.ORDER_STR ||(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR && countryName.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CA))){
            if(objectName == BAT_ConstantsUtility.ORDER_STR || (isdeletechild && objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR)){
            if(!ordersToUpdateList.isEmpty()){
                    //Bypassing Trigger for order update
                    BAT_ConstantsUtility.isTriggerBypassed = true;
                    Database.SaveResult[] updatedOrderSuccessList= Database.update(ordersToUpdateList,false);
                    BAT_ConstantsUtility.isTriggerBypassed = false;
                    BAT_Utilities.createErrorLogs(updatedOrderSuccessList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    //Successfully updated Order records are being passed on for Deletion
                    for(Database.saveResult sr :updatedOrderSuccessList ){
                        if(sr.isSuccess()){
                            successfullyUpdatedOrderRecordsIdSet.add(sr.getId());
                        }
                    }
                    for(Order successOrderRec : [Select Id,Status,Country__c from Order where Id IN :successfullyUpdatedOrderRecordsIdSet]){
                       //1630499- CA-Vuse Re-Activating Cold Records starts added bypass condition for related accounts--//
                        if(!orderbypass){
                            finalObjectDeletionRecordsList.add(successOrderRec);}
                    }
                }
            }
       
            //1630499- CA-Vuse Re-Activating Cold Records starts--//
                if(!caseToDeleteList.isEmpty()){
                        BAT_ConstantsUtility.isTriggerBypassed = true;
                        Database.DeleteResult[] caseDeleteList = Database.delete(caseToDeleteList, false);
                        BAT_ConstantsUtility.isTriggerBypassed = false;
                        BAT_Utilities.createErrorLogs(caseDeleteList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    }
//1630499- CA-Vuse Re-Activating Cold Records ends--//            
            //Common block for deletion of objects and storing the Ids of successfully deleted context records
            //Bypassing Trigger for sobjects deletion
            BAT_ConstantsUtility.isTriggerBypassed = true;
            Database.DeleteResult[] sObjectsDeleteList = Database.delete(finalObjectDeletionRecordsList, false);
            BAT_ConstantsUtility.isTriggerBypassed = false;
            BAT_Utilities.createErrorLogs(sObjectsDeleteList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
            for(Database.DeleteResult sr :sObjectsDeleteList ){
                if(sr.isSuccess()){
                    successfulDeletionRecordsIdSet.add(sr.getId());
                }
                
            }
            //Deleting only those chat transcript records that are related to successfully deleted parent case record
            /*if(objectName == BAT_ConstantsUtility.CASE_STR && !successfulDeletionRecordsIdSet.isEmpty() ){
                for(Id caseRecId : successfulDeletionRecordsIdSet){
                    if(!chatTranscriptsToDeleteMap.isEmpty() && chatTranscriptsToDeleteMap.containsKey(caseRecId)){
                        chatTranscriptToDeleteList.addAll(chatTranscriptsToDeleteMap.get(caseRecId));
                    }
                }
                if(!chatTranscriptToDeleteList.isEmpty()){
                    Database.DeleteResult[] chatTranscriptDeleteList = Database.delete(chatTranscriptToDeleteList, false);
                    BAT_Utilities.createErrorLogs(chatTranscriptDeleteList,BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
            }*/
        }
    }
    }
    //batch finish method
    global void finish(Database.BatchableContext BC) {
        //Below code block is added to delete account/lead history of anonymised records completely
        if(!successfulAnonymisedRecordsIdSet.isEmpty() || !successfulDeletionRecordsIdSet.isEmpty() || !mapOfRelatedRecords.isEmpty()){
            //calling queuable
            directoryLocation += strTodayDate + '/Related';
            BAT_RelatedRecordsDeletionQueable objRelatedQueable = new BAT_RelatedRecordsDeletionQueable(objectName,successfulAnonymisedRecordsIdSet,countryName,directoryLocation,relatedLeadIdsSet,successfulDeletionRecordsIdSet,mapOfRelatedRecords);
            system.enqueueJob(objRelatedQueable); 
    
                
            List<PermissionSetAssignment> objectHistoryDeletionPermList = new List<PermissionSetAssignment>();
            List<AccountHistory> accountHistoryList = new List<AccountHistory>();
            List<LeadHistory> leadHistoryList = new List<LeadHistory>();
            //Checking if the context user has Object history Deletion permission
            objectHistoryDeletionPermList = [SELECT Id
                                             FROM PermissionSetAssignment
                                             WHERE PermissionSet.Name =: BAT_ConstantsUtility.PERSON_ACC_HISTORY_DELETE_PERMISSION
                                             AND AssigneeId =: UserInfo.getUserId()];
            if(objectHistoryDeletionPermList.size() > 0){
                if(!successfulAnonymisedRecordsIdSet.isEmpty()){
                    system.debug('Testinggsuccess'+successfulAnonymisedRecordsIdSet);
                    if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                        accountHistoryList = [SELECT Id FROM AccountHistory WHERE AccountId IN: successfulAnonymisedRecordsIdSet];
                    system.debug('TestinggsuccessaccountHistoryList'+accountHistoryList);
                    }else if(objectName == BAT_ConstantsUtility.LEAD_STR){
                        leadHistoryList = [SELECT Id FROM LeadHistory WHERE LeadId IN: successfulAnonymisedRecordsIdSet];  
                    }
                    if(accountHistoryList != null && !accountHistoryList.isEmpty()){
                        Database.delete(accountHistoryList,true);
                    }
                    if(leadHistoryList != null && !leadHistoryList.isEmpty()){
                        Database.delete(leadHistoryList,true);
                    }
                }
            }
        }
        //incrementing the sequence to hold the next config record of country name for which the batch needs to be processed
        Integer currentSequence = sequence;
        Integer nextObjectsequence = ++sequence;
        String upcomingCountry = BAT_ConstantsUtility.BLANK_STR;
        String upcomingObjectName = BAT_ConstantsUtility.BLANK_STR;
        String keyword = BAT_ConstantsUtility.BLANK_STR;
        //06.02.2023/ Idrees Ali/ US#1285878: Data Archival Process - Discrepancy with regard to Field Values & Throttling mechanism Redesign
        keyword = countryName + BAT_ConstantsUtility.STR_COLON + objectName;
        BAT_GlobalDataRetentionThrottlingLimit__c throttlingCustomSettingRecord = BAT_GlobalDataRetentionThrottlingLimit__c.getInstance(keyword);
        //Below logic checks if the current country & object name combination requires throttling based on metadata map and 
        //schedules the batch to run every 5 minutes ---> Step 2
        if(!Test.isRunningTest() && !mapOfObjectsToThrottle.isEmpty() && !String.isBlank(keyword) && mapOfObjectsToThrottle.containsKey(keyword) && mapOfObjectsToThrottle.get(keyword) == true && countOfRecords != 0 
           && throttlingCustomSettingRecord != null && throttlingCustomSettingRecord.BAT_TotalRecordsProcessed__c < throttlingCustomSettingRecord.BAT_UpperLimitOfRecords__c){  
               throttlingCustomSettingRecord.BAT_TotalRecordsProcessed__c += countOfRecords;
               update throttlingCustomSettingRecord;
               system.scheduleBatch(new BAT_GlobalDataRetentionBatch(currentSequence,Integer.valueOf(throttlingCustomSettingRecord.BAT_MaxRecordsPerBatch__c),null), BAT_ConstantsUtility.BAT_GLOBALDATARETENTIONBATCH_CURRENTOBJ_STR + keyword, 5);
           }    
        //Below logic checks if the next country & object name combination requires throttling based on metadata map and 
        //schedules the batch to run every 5 minutes ---> Step 1
        else if(!Test.isRunningTest() && CountryConfigMap.containsKey(nextObjectsequence) && !mapOfObjectsToThrottle.isEmpty() && mapOfObjectsToThrottle.containsKey(CountryConfigMap.get(nextObjectsequence).MasterLabel + BAT_ConstantsUtility.STR_COLON +  CountryConfigMap.get(nextObjectsequence).BAT_ObjectName__c) 
                && mapOfObjectsToThrottle.get(CountryConfigMap.get(nextObjectsequence).MasterLabel + BAT_ConstantsUtility.STR_COLON +  CountryConfigMap.get(nextObjectsequence).BAT_ObjectName__c) == true ){
                    String nextObjectkeyword = CountryConfigMap.get(nextObjectsequence).MasterLabel + BAT_ConstantsUtility.STR_COLON +  CountryConfigMap.get(nextObjectsequence).BAT_ObjectName__c;
                    throttlingCustomSettingRecord = BAT_GlobalDataRetentionThrottlingLimit__c.getInstance(nextObjectkeyword);
                    if(throttlingCustomSettingRecord!= null && throttlingCustomSettingRecord.BAT_TotalRecordsProcessed__c != 0){
                        throttlingCustomSettingRecord.BAT_TotalRecordsProcessed__c = 0;
                        update throttlingCustomSettingRecord;
                    }
                    system.scheduleBatch(new BAT_GlobalDataRetentionBatch(nextObjectsequence,Integer.valueOf(throttlingCustomSettingRecord.BAT_MaxRecordsPerBatch__c),null), BAT_ConstantsUtility.BAT_GLOBALDATARETENTIONBATCH_UPCOMINGOBJ_STR + nextObjectkeyword, 5);
                }
        
        else if(CountryConfigMap.containsKey(nextObjectsequence) && CountryConfigMap.get(nextObjectsequence) != null ){
            List<Batch_size_configuration__mdt> batchConfigs = [SELECT ID,MasterLabel,DeveloperName,records_number__c,BAT_QueryLimit__c,BAT_SleepTime__c FROM Batch_size_configuration__mdt WHERE MasterLabel = :BAT_ConstantsUtility.BAT_GLOBAL_DATA_RETENTION_BATCH];
            Integer batchSize,maxSize,sleepTime;
            if(!batchConfigs.isEmpty()){
                batchSize = !batchConfigs.isEmpty() ? Integer.valueOf(batchConfigs[0].records_number__c) : 50;
                maxSize = !batchConfigs.isEmpty() ? Integer.valueOf(batchConfigs[0].BAT_QueryLimit__c) : null;
                sleepTime = !batchConfigs.isEmpty() ? Integer.valueOf(batchConfigs[0].BAT_SleepTime__c) : null;
            }
            Database.executeBatch(new BAT_GlobalDataRetentionBatch(nextObjectsequence,maxSize,sleepTime), batchSize);
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @description   : [All Markets]Sleep method to handle the wait time
* @createdDate   : 9 Nov 2022
*********************************************************************************************************/
    private static void Sleep(integer milliseconds){
        Long timeDiff = 0;
        DateTime firstTime = System.now();
        do{
            timeDiff = System.now().getTime() - firstTime.getTime();
        }
        while(timeDiff <= milliseconds);      
    }
    /************************************************************************************************************************************
    *@author        :Deloitte  
    *@method        :storeRelatedRecords
    *@returns       :String
    *@description   :This method stores related records to the Object
    *@changeHistory :12th January, 2023 / Swaraj Ray /Created the method - #1142557 - ZA - Data Archival Process
    ************************************************************************************************************************************/
    public static void storeRelatedRecords( String relatedObjectName, String relatedLookUpField, String relatedQuery,Set<Id> sObjectdeletionRecordsIdSet, map<String,map<String,list<sObject>>> mapOfRelatedRecords){
        for(sObject record : Database.query(relatedQuery)){
            if(mapOfRelatedRecords.containsKey(relatedObjectName)){
                if(mapOfRelatedRecords.get(relatedObjectName).containsKey((String)record.get(relatedLookUpField))){
                    mapOfRelatedRecords.get(relatedObjectName).get((String)record.get(relatedLookUpField)).add(record);
                }else{
                    mapOfRelatedRecords.get(relatedObjectName).put((String)record.get(relatedLookUpField),new List<sObject>{record});
                }
                
            }
            else {
                mapOfRelatedRecords.put(relatedObjectName, new map<String,List<sObject>>{(String)record.get(relatedLookUpField)=>new List<sObject>{record}});
            }
        }
    }
}