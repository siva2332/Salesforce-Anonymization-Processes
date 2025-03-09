/*******************************************************************************************************************************
@Class: BAT_CreateRewardBatch
@Version: 1.0
@Author: Deloitte USI
@Purpose:  Created batch to full anonymize the Lead
@Change history: 3-11-2020/Dipika/US #295643 : Created batch 
                                             :14/09/2022/Debasis Maharana/Bug#1104167 - Optimize the code so that it improves the performance and it avoids the Apex CPU time exception.
                                             :16/09/2024/varaprasad Sada/US #1837992-ES - Velo Newsletter (Account & Lead update via Mule ) , Email Verification 
*********************************************************************************************************************************/
global class BAT_AutoAnonymizeLeadBatch implements Database.Batchable<sObject>,Schedulable {
    String query = BAT_ConstantsUtility.AUTOANONYMIZELEADBATCHQUERY_STR;
    
     //Constructor
    global BAT_AutoAnonymizeLeadBatch(){
            Map<String,BAT_AutoAnonymizeBatchConfig__mdt> automaticAnonymizationConfigMap = new Map<String,BAT_AutoAnonymizeBatchConfig__mdt>();
            for(BAT_AutoAnonymizeBatchConfig__mdt batch: [Select BAT_Country__c,BAT_ObjectName__c,BAT_WhereCondition_1__c 
                                               FROM BAT_AutoAnonymizeBatchConfig__mdt WHERE BAT_ObjectName__c =: BAT_ConstantsUtility.LEAD_STR 
]){   
if(batch.BAT_WhereCondition_1__c!=null){
                automaticAnonymizationConfigMap.put(batch.BAT_Country__c,batch);
                }
            }
        
            Boolean isFirstLoop =true;
            for(String country: automaticAnonymizationConfigMap.Keyset()){
                 query = isFirstLoop ? query + '( (Country__c =\''+country+ '\' AND ' +automaticAnonymizationConfigMap.get(country).BAT_WhereCondition_1__c + ')':query + ' OR (Country__c =\''+country+ '\' AND ' +automaticAnonymizationConfigMap.get(country).BAT_WhereCondition_1__c+ ')';
                isFirstLoop = false;
                
            }
            query = query + ' )';
        
        
    }  

    //batch start method    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug('==query=='+query);
        return Database.getQueryLocator(query);
    } 
    
    global void execute(Database.BatchableContext BC, list<Lead> scope){
        system.debug('==scope='+scope.size());
        list<Lead> listLead = new list<Lead>();
        Map<String,List<BAT_AnonymisationMarketConfiguration__mdt>> countryToMtdMap = new Map<String,List<BAT_AnonymisationMarketConfiguration__mdt>>();
        // 3/11/2020/Dipika Gupta/ CZ 295643 get all records of BAT_AnonymisationMarketConfiguration__mdt where BAT_ISPartialAnonymize__c = true 
        for(BAT_AnonymisationMarketConfiguration__mdt anonyLeadMtd : [Select Id,BAT_Market__c,BAT_FieldAPIName__c,BAT_FieldValue__c, 
                                                                      BAT_BlankDate__c,BAT_ISAppendValue__c from BAT_AnonymisationMarketConfiguration__mdt where 
                                                                      BAT_Market__c!=null  And BAT_ISPartialAnonymize__c = true]){
            if(!countryToMtdMap.containsKey(anonyLeadMtd.BAT_Market__c)){
                countryToMtdMap.put(anonyLeadMtd.BAT_Market__c, new List<BAT_AnonymisationMarketConfiguration__mdt>{});
            }
            countryToMtdMap.get(anonyLeadMtd.BAT_Market__c).add(anonyLeadMtd);
        }
        String fieldType;
        // 3/11/2020/Dipika Gupta/ CZ 295643 update Lead data according to BAT_AnonymisationMarketConfiguration__mdt records
        for(Lead lead:scope){
            system.debug('==lead='+lead);
            // 3/11/2020/Dipika Gupta/ CZ 295643 if BAT_IsAppendValue__c is true, need to append the value in existing value
            if(countryToMtdMap.containsKey(lead.Country__c)){//1837992
            for(BAT_AnonymisationMarketConfiguration__mdt anonymiseMtdObj : countryToMtdMap.get(lead.Country__c)){
                //Bug#1104167 - Optimize the code so that it improves the performance and it avoids the Apex CPU time exception.
                fieldType = String.valueOf(Schema.getGlobalDescribe() .get(BAT_ConstantsUtility.LEAD).getDescribe().fields.getMap().get(anonymiseMtdObj.BAT_FieldAPIName__c).getDescribe().getType());
                system.debug('==fieldType='+fieldType);
                if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.EMAIL_STR)){
                    lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, anonymiseMtdObj.BAT_ISAppendValue__c ? lead.get(anonymiseMtdObj.BAT_FieldAPIName__c)+ String.valueOf(anonymiseMtdObj.BAT_FieldValue__c): lead.id + String.valueOf(anonymiseMtdObj.BAT_FieldValue__c));
                }
                if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.STRING_STR) || fieldType.equalsIgnoreCase(BAT_ConstantsUtility.PHONE_STR)||
                   fieldType.equalsIgnoreCase(BAT_ConstantsUtility.PICKLIST_STR) || fieldType.equalsIgnoreCase(BAT_ConstantsUtility.TEXTAREA_STR)){
                       lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, anonymiseMtdObj.BAT_ISAppendValue__c ? lead.get(anonymiseMtdObj.BAT_FieldAPIName__c)+ String.valueOf(anonymiseMtdObj.BAT_FieldValue__c):String.valueOf(anonymiseMtdObj.BAT_FieldValue__c));
                   }
                //1837992--Start
                 if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.BOOLEAN_TYPE)){
                     lead.put(anonymiseMtdObj.BAT_FieldAPIName__c, Boolean.valueOf(String.valueOf(anonymiseMtdObj.BAT_FieldValue__c))); 
                        }
                if(anonymiseMtdObj.BAT_FieldAPIName__c.equalsIgnoreCase(BAT_ConstantsUtility.BIRTH_DATE_API_STR) && lead.BirthDate__c != null){
                    if(anonymiseMtdObj.BAT_BlankDate__c){
                        lead.BirthDate__c= null; 
                    }else {
                        Integer yearOfBirth=lead.BirthDate__c.year();
                        lead.BirthDate__c=Date.newInstance(yearOfBirth,1,1);
                    }
                    //1837992--End 
                }

               
            }
             listLead.add(lead);    
        }
            
            //listLead.add(lead);
        }
        if(!listLead.isEmpty()){
            update listLead;
        }
        list<Id> leadidsToAnonymize = new list<Id>();
        for(Lead lead:listLead){
            leadidsToAnonymize.add(lead.Id);
        }
        // 3/11/2020/Dipika Gupta/ CZ 295643 delete privacy snapshots
        if(!leadidsToAnonymize.isEmpty()){
            List<ContentDocument> PrivacyDocs = BAT_Utilities.deletePrivacySanpshots(leadidsToAnonymize);
            if(!PrivacyDocs.isEmpty()){
                Delete PrivacyDocs;
            }
        }
    }
    global void finish(Database.BatchableContext BC) {}
    
    //Schedulable execute method
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BAT_AutoAnonymizeLeadBatch(), 50);
    }
}