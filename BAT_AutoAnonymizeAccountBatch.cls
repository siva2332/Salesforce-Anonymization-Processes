/*******************************************************************************************************************************
@Class: BAT_AutoAnonymizeAccountBatch
@Version: 1.0
@Author: Deloitte USI
@Purpose:  Created batch to full anonymize the Account
@Change history: 3-11-2020/Dipika/US #295643 : Created batch 
                14-01-2021/Idrees/US #340701 : Updated Batch to execute custom conditions for all countries
02/01/2024/Shanmuga/US#1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account

*********************************************************************************************************************************/
global class BAT_AutoAnonymizeAccountBatch implements Database.Batchable<sObject>,Schedulable {
    global Map<String,BAT_AutoAnonymizeBatchConfig__mdt> automaticAnonymizationConfigMap = new Map<String,BAT_AutoAnonymizeBatchConfig__mdt>();
    String query = BAT_ConstantsUtility.AUTOANONYMIZEACCOUNTBATCHQUERY_STR;    
    //Constructor
    global BAT_AutoAnonymizeAccountBatch(){
            for(BAT_AutoAnonymizeBatchConfig__mdt batch: [Select BAT_Country__c,BAT_ObjectName__c,BAT_WhereCondition_1__c,BAT_IsFullAnonymizationRequired__c,BAT_IsAssetAnonymizationRequired__c,BAT_IsTaskAnonymizationRequired__c,BAT_IsDelinkAssetAccount__c 
                                               FROM BAT_AutoAnonymizeBatchConfig__mdt WHERE BAT_ObjectName__c ='Account' and IsActive__c = true
]){    
if(batch.BAT_WhereCondition_1__c!=null){

                automaticAnonymizationConfigMap.put(batch.BAT_Country__c,batch);
                }
            }
        
         DateTime now = System.now();
            Boolean isFirstLoop =true;
            for(String country: automaticAnonymizationConfigMap.Keyset()){
                 query = isFirstLoop ? query + '( (Country__c =\''+country+ '\' AND ' +automaticAnonymizationConfigMap.get(country).BAT_WhereCondition_1__c + ')':
                         query + ' OR (Country__c =\''+country+ '\' AND ' +automaticAnonymizationConfigMap.get(country).BAT_WhereCondition_1__c+ ')';
                isFirstLoop = false;
                
            }
            query = query + ' )';
        system.debug('Query=='+query);
    }   

    //batch start method    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);  
    } 
    
    global void execute(Database.BatchableContext BC, list<Account> scope){
        List<Account> accListToAnonimise = new List<Account>();
        List<Account> accListToFullAnonimise = new List<Account>();
        List<Asset> assetsToAnonymize = new List<Asset>();
       	List<Task> tasksToAnonymize = new List<Task>();
        list<Id> accIdsToAnonymize = new list<Id>();
        List<Id> accIdsForAssetAnonymize = new list<Id>();
        //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account--starts--
         List<Asset> assetsToDelink = new List<Asset>();
        List<Id> accIdsForAssetdelink = new list<Id>();
       //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account--ends--
        List<Id> accIdsForTaskAnonymize = new list<Id>();
        for(Account account:scope){
            if(automaticAnonymizationConfigMap.containsKey(account.Country__c)){
                //Full anonymization takes place as per BAT_IsFullAnonymizationRequired__c flag set for country
                if(automaticAnonymizationConfigMap.get(account.Country__c).BAT_IsFullAnonymizationRequired__c){
                    accListToFullAnonimise.add(account);
                }
                else {
                    //proceeds with partial anonymisation set for country
                    account.PersonEmail = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL; 
                    account.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                    account.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                    account.PersonMobilePhone = null;
                    accListToAnonimise.add(account);
                }
            }
            
        }
        BAT_ConstantsUtility.isTriggerBypassed = true;
        BAT_ConstantsUtility.isAnonymized = true;
        //Adding all anonymised accounts in one list
        accListToFullAnonimise = BAT_Utilities.anonymizeAccounts(accListToFullAnonimise);       
        accListToAnonimise.addAll(accListToFullAnonimise);
        
        for(Account acc : accListToAnonimise){
            accIdsToAnonymize.add(acc.Id);
            //Assets will be anonymized as per BAT_IsAssetAnonymizationRequired__c set for specific countries
            if(automaticAnonymizationConfigMap.get(acc.Country__c).BAT_IsAssetAnonymizationRequired__c){
                accIdsForAssetAnonymize.add(acc.Id);
            }
            system.debug('country name'+acc.country__c);
           
             //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account--
             if(automaticAnonymizationConfigMap.get(acc.Country__c).BAT_IsDelinkAssetAccount__c){
        		accIdsForAssetdelink.add(acc.Id);
            }
              
            //Tasks will be anonymized as per BAT_IsTaskAnonymizationRequired__c set for specific countries
            if(automaticAnonymizationConfigMap.get(acc.Country__c).BAT_IsTaskAnonymizationRequired__c){
                accIdsForTaskAnonymize.add(acc.Id);
            }
        }
        
        if(!accIdsForAssetAnonymize.isEmpty()){
            //Assets anonymisation
            assetsToAnonymize = BAT_Utilities.anonymizeRelatedAssets(accIdsForAssetAnonymize);
        }
       
        //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account starts--
           if(!accIdsForAssetdelink.isEmpty()){
            assetsToDelink = BAT_Utilities.DelinkRelatedAssets(accIdsForAssetdelink);
        }
       //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account ends--
        
        if(!accIdsForTaskAnonymize.isEmpty()){
            //Tasks anonymization
            tasksToAnonymize = BAT_Utilities.anonymizeRelatedTasks(accIdsForTaskAnonymize);
        }
        
        if(!accListToAnonimise.isEmpty()){
            //updating accounts anonymise list
            update accListToAnonimise;
        }
        if(!assetsToAnonymize.isEmpty()){
            //updating assets anonymise list
            update assetsToAnonymize;
        }
        //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account starts--
        if(!assetsToDelink.isEmpty()){
            //De-Linking the Asset
            update assetsToDelink;
        }
        //1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account ends--
        if(!tasksToAnonymize.isEmpty()){
            //updating tasks anonymise list
            if(Schema.sObjectType.Task.isDeletable() && !Test.isRunningTest()){ 
                delete tasksToAnonymize;
            }else{
                update tasksToAnonymize;
            }
        }
        // 3/11/2020/Dipika Gupta/ CZ 295637 delete privacy snapshots
        List<ContentDocument> privacyDocs = BAT_Utilities.deletePrivacySanpshots(accIdsToAnonymize);
        if(!privacyDocs.isEmpty()){
            Delete privacyDocs;
        }
    } 
    global void finish(Database.BatchableContext BC) {}
    //Schedulable execute method
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BAT_AutoAnonymizeAccountBatch(), 50);
    }
}