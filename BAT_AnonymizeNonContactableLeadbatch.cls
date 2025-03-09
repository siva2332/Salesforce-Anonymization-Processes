/*********************************************************************************************************************************************
 @Author           : Deloitte
 @Class            : BAT_ChannelIdentifierBatch
 @TestClass        : Test_BAT_AnonymizeNonContactablebatch
 @Description      : Anonymizing non-contactable Leads records older than 3 months by this batch
 @ChangeHistory    : v1.0.0 Sameer Ranjan => Initial Version. Sprint 126 - US #1326044 - IT Vuse | Monthly batch for anonymizing non-contactable Leads older than 3 months
 *****************************************************************************************************************************************/
public without sharing class BAT_AnonymizeNonContactableLeadbatch implements Database.Batchable<sObject>, Schedulable, Database.Stateful{
    // Fetch batch size
    private Batch_size_configuration__mdt batchConfig = Batch_size_configuration__mdt.getInstance(BAT_ConstantsUtility.ANONYMIZE_NONCONTACTABLE_LEAD_BATCH);
    Set<Id> specificLeadIds;
    // Default Query Limit
    Integer queryLimit = 200;
    Integer order = 1;

    public BAT_AnonymizeNonContactableLeadbatch(){
        // Default batch constructor
    }
    // For next batch
    public BAT_AnonymizeNonContactableLeadbatch(Integer order){
        this.order = order;
    }

    // For specific Lead
    public BAT_AnonymizeNonContactableLeadbatch(Set<Id> specificLeadIds){
        this.specificLeadIds = specificLeadIds;
    }

    /**
     * @description : Schedule Job Method
     * @author Sameer Ranjan (sameranjan@deloitte.com)
     * @param sc
     **/
    public void execute(SchedulableContext sc){
        if (batchConfig == null){
            return;
        }
        if(batchConfig.records_number__c == null){
            return;
        }
        Integer batchSize = Integer.valueOf(batchConfig.records_number__c);
        if(batchConfig.BAT_QueryLimit__c != null){
            queryLimit = Integer.valueOf(batchConfig.BAT_QueryLimit__c);
        }
        // To check custom setting records are available or not
        if (getConfigRecord() == null){
            return;
        }
        if(Test.isRunningTest()){
            return;
        }
        Database.executeBatch(new BAT_AnonymizeNonContactableLeadbatch(), batchSize);
    }

    /**
     * @description : Batch start method
     * @author Sameer Ranjan (sameranjan@deloitte.com)
     * @param bc
     * @return Database.QueryLocator
     **/
    public Database.QueryLocator start(Database.BatchableContext bc){
        String equery = queryBuilder();
        return Database.getQueryLocator(equery);
    }

    public String queryBuilder(){
        BAT_AnonymizeNonContactableLeadConfig__c configRecord = getConfigRecord();
        // return variable
        String query = 'SELECT Id,FirstName,LastName,Street,Email,MobilePhone,Registration_Permission__c,';
               query += ' Submit_Surveys_Permission__c,CreatedDate,Country__c,Trial_Information_Permission__c,External_Systems_Information_Permission__c,';
               query += ' Generic_Permission__c,BAT_isVypeOptInEmailCommunication__c,BAT_isVypeOptInMobileTextWhatsApp__c,BirthDate__c ';
               query += ' FROM Lead ';
        // Condition
        String whereClause = 'WHERE Country__c = \'' + configRecord.BAT_Country__c + '\' AND ';
               whereClause += BAT_ConstantsUtility.EMPTY_STRING + configRecord.BAT_WhereClauseAddition__c + ' AND ';
               whereClause += BAT_ConstantsUtility.EMPTY_STRING + configRecord.BAT_WhereClauseDateFilter__c + ' ';
        if(specificLeadIds != null){
            whereClause +=  'AND Id IN:specificLeadIds ';
        }
        String orderBy = 'ORDER BY CreatedDate DESC ';
               query += whereClause + orderBy;
        if(queryLimit != null){
            query += 'LIMIT ' + queryLimit;
        }
        return query;
    }

    BAT_AnonymizeNonContactableLeadConfig__c getConfigRecord(){
        String key = BAT_ConstantsUtility.PREFIX_CONFIG + order;
        return BAT_AnonymizeNonContactableLeadConfig__c.getInstance(key);
    }

    /**s
     * @description : Batch execute method
     * @author Sameer Ranjan (sameranjan@deloitte.com)
     * @param bc
     * @param records
     **/
    public void execute(Database.BatchableContext bc, List<Lead> records){
        try{
            for(Lead rec : records){
                updateLeadRecord(rec);
            }
            Database.SaveResult[] dmlResults = Database.update (records, false);
            BAT_Utilities.createErrorLogs(dmlResults, BAT_ConstantsUtility.ANONYMIZE_NONCONTACTABLE_LEAD_BATCH, BAT_ConstantsUtility.EMPTY_STRING);
        } catch (Exception ex){
            BAT_Utilities.createLog(ex, BAT_ConstantsUtility.ANONYMIZE_NONCONTACTABLE_LEAD_BATCH, BAT_ConstantsUtility.EMPTY_STRING);
        }
    }

    public void updateLeadRecord(Lead record){
        record.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
        record.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
        record.Street = BAT_ConstantsUtility.EMPTY_STRING;
        record.Email = record.id + BAT_ConstantsUtility.EMPTY_STRING + Integer.valueof((Math.random() * 100)) + BAT_ConstantsUtility.ATTHERATE_ANONYMOUS_DOT + record.Country__c.toLowerCase();
        record.MobilePhone = BAT_ConstantsUtility.MOBILE_PHONE;
        record.Registration_Permission__c = false;
        record.Submit_Surveys_Permission__c = false;
        record.Trial_Information_Permission__c = false;
        record.External_Systems_Information_Permission__c = false;
        record.Generic_Permission__c = false;
        record.BAT_isVypeOptInEmailCommunication__c = false;
        record.BAT_isVypeOptInMobileTextWhatsApp__c = false;
        if (record.BirthDate__c != null){
            Integer yearOfBirth = record.BirthDate__c.year() != null ? record.BirthDate__c.year() : 1980;
            record.BirthDate__c = Date.newInstance(yearOfBirth, 1, 1);
        }
    }

    /**
     * @description : Batch Finish method
     * @author Sameer Ranjan (sameranjan@deloitte.com)
     * @param bc
     **/
    public void finish(Database.BatchableContext bc){
        try{
            // Finish method
            // Increment order
            order++;
            if (getConfigRecord() == null){
                return;
            }
            Integer batchSize = Integer.valueOf(batchConfig.records_number__c);
            Database.executeBatch(new BAT_AnonymizeNonContactableLeadbatch(order), batchSize);
        } catch (Exception ex){
            BAT_Utilities.createLog(ex, BAT_ConstantsUtility.ANONYMIZE_NONCONTACTABLE_LEAD_BATCH, BAT_ConstantsUtility.EMPTY_STRING);
        }
    }

}