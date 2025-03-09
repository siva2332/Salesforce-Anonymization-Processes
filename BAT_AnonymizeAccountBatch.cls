/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* Class to perform anonymization of Accounts - 24 months
* 4093 :after 24 months ->anonymize accounts
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author        Margherita Gioia
* @created       17/11/2018
                :04/12/2019 - Rajesh Potla / Added logic to fetch countries from metadta and using Logic defined in metadta.
                 06/12/2019 / Souvik Dinda/ US#47980-Added logic to delete person account history during anonymisation if user
                 has required permission set.
                 27Th Aug, 2020/Abhishek Kashyap/ENH_227912,Anonymized accounts having last consent field updated 2 years ago or reset 
                    Newsletter & Commercial and Market Research consent flags for accounts having last consent field updated 2 years ago
                    but having orders in past 6 months.
                    28.10.2020/Souvik Dinda/US#261129: Added a boolean variable to bifurcate for the scenario when the market do not want Order criteria for anonymization.
                    10/12/2020/Kushagra Jain/ Bug #353988: Adding IsPersonAccount check to avoid Anonymizing Business Account
                    09th Mar,2021/Roopa N/RO - US#409770 - Updating Consents if Account has atleast one order in past 6 months and 
                                                            Anonymizing mobile as well as part of automatic full anonymization if Account doesnot contain any order in past 6months
                    22nd Mar,2021/Roopa N/RO - US#417298- Added logic to anonymize related Brand Profiles of accounts.
            2nd April,2020/Abhishek Kashyap/BUG-468283-412283 - Issue with account anonymize via Reverse Integration
            5th April,2021/Roopa N/US#461730 - Updated Account Query to fetch RO Partially anonymized accounts as well whose Count down = 0 and then anonymize fully irrespective of partially anonymize account contains order or not.
        6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
            04th April,2021/Roopa N/ RO - US#461730 - Updated condition to make it metadata driven: to bypass orders check for RO Partially anonymized accounts.
        26th May, 2021/Abhishek Kashyap/BUG:538533-RO-Automatic full anonymization scenario fail
        25th April, 2021/Abhishek Kashyap/Bug-567747-562099 RO ENH - Issue with Reverse Integration of Consent update via Anonymization Batch trigger
        30th April,2021/Abhishek Kashyap/Bug-567747-562099 RO ENH - Issue with Reverse Integration of Consent update via Anonymization Batch trigger
                    11.06.2020/Kushagra Jain/ Bug #508759: Using database class methods instead of DML Statements
                    16-12-2022: Hariharan Pillai/#1015949: Moved Account History Deletion from final block to execute
                    20 Jan 2023: Data retention/archival batch account records are already deleted by BAT_AnonymizeAccountBatch - bug
                     21st June,2024/Varaprasad Sada/Sprint 159:US #1744353 -RO - update of the anonymization script part 2
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/   

global class BAT_AnonymizeAccountBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    //2nd April,2020/Abhishek Kashyap/BUG-468283-Updated the query to include ExternalCustomer Ids
    //25th April, 2021/Abhishek Kashyap/Bug-567747-Added fields to the query, to be used for reverse int for RO when consent is updated due to existing order.
        String query = 'SELECT id,LastName,FirstName,BAT_ConsentDate__c,Country__c,PersonBirthdate, Brand_House__c, PersonEmail,Email__c,PersonMobilePhone,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Related_Lead__c,LastModifiedDate,Month_24_Anonymize_Countdown__c,Registration_Permission__c,External_Information_Systems_Permission__c,Submit_Surveys_Permission__c,Trial_Information_Permission__c,Birth_Date__c,Generic_Permission__c, is_trialist__c,Gender__c,Status__c,BAT_Is_Anonymised__c,BAT_CombustibleStatus__c,BAT_OralStatus__c,BAT_THPStatus__c,BAT_VapeStatus__c,BAT_IsEPOKOptInEmailCommunication__c,BAT_IsEPOKOptInMobileTextWhatsApp__c,BAT_IsEPOKOptInPostal__c,BAT_EPOKMarketResearchAuthorization__c,BAT_EPOKLastCompletedOrderDate__c,BAT_EPOKLastConsentOptInDate__c,BAT_IsVypeOptInEmailCommunication__c,BAT_IsVypeOptInMobileTextWhatsApp__c,BAT_IsVypeOptInPostal__c,BAT_VypeMarketResearchAuthorization__c,GoVype_Last_Completed_Order_Date__c,BAT_VypeLastConsentOptInDate__c,BAT_IsLyftOptInEmailCommunication__c,BAT_IsLyftOptInMobileTextWhatsApp__c,BAT_IsLyftOptInPostal__c,BAT_LyftMarketResearchAuthorization__c,BAT_LyftExternalCompaniesAuthorization__c,BAT_LyftTrialFeedbackAuthorization__c,BAT_LyftLastCompletedOrderDate__c, BAT_LyftLastConsentOptInDate__c,External_Customer_Id__c,'+
             'External_Customer_ID2__c, External_Customer_ID3__c,BAT_ExternalCustomerId4__c,BAT_ExternalCustomerID5__c, BAT_ExternalSubscriberId__c,BAT_ExternalSubscriberId3__c,BAT_ExternalSubscriberId4__c,Email_verified__c, Member_get_Member_Code__c, MgM_Counter__c, Skip_Repurchase_Lock__c,Wrong_Phone_Number__c, Preferred_Tobacconist_Shop__c, Last_Call_Type__c, Member_get_Member_Promotional_Code__c,Age_verified__c, PersonHasOptedOutOfFax, PersonDoNotCall, SMS_Opt_Out__c, PersonHasOptedOutOfEmail, AccountSource, Store_ID__c, BAT_BypassMobileVerification__c, Category__c, Brand__c, Variant__c, Sector__c FROM Account where ';
        global Map<String,BAT_AutomaticAnonymizationConfiguration__mdt> automaticAnonymizationConfigMap = new Map<String,BAT_AutomaticAnonymizationConfiguration__mdt>();
        global User user;
        global Date anonymisationDate = system.today().addMonths(-24);
        global Set<Id> accHistoryDelIdSet = new Set<Id>();
        global BAT_AnonymizeAccountBatch(){
        automaticAnonymizationConfigMap = BAT_Utilities.getAutomaticAnonymizationConfig();
        Boolean isFirstLoop =true;
        user = BAT_Utilities.getUserDetails();
        for(String country: automaticAnonymizationConfigMap.Keyset()){
            if(!automaticAnonymizationConfigMap.get(country).BAT_NotRequiredInBatch__c){
                if(isFirstLoop){
                    query = query + '( Country__c =\''+country+ '\'';
                    isFirstLoop = false;
                }
                else{
                    query = query + 'OR Country__c =\''+country+ '\'';
                }
            }
        }
            
            system.debug('TestingAnonymizationDate'+anonymisationDate);
        //Adding IsPersonAccount check to avoid Anonymizing Business Account
        //Updated below query as part of RO : US#461730 - added PersonMobilePhone != null to fetch Partially anonymized accounts
     /*      query = query + ' ) AND (Month_24_Anonymize_Countdown__c = 0 AND Country__c != \'' + BAT_ConstantsUtility.COUNTRY_RO + '\' ) ' + 
        'AND ((NOT PersonEmail LIKE \'%anonymous%\' ) OR (PersonMobilePhone != NULL AND BAT_ConsentDate__c < :anonymisationDate AND Country__c = \'' + BAT_ConstantsUtility.COUNTRY_RO + '\' )) ' +
        BAT_ConstantsUtility.AND_STRING + ' ' + 
        BAT_ConstantsUtility.ACCOUNT_FIELD_ISPERSONACCOUNT + ' = ' + BAT_ConstantsUtility.BOOLEANTRUE;*/

           /* query = query + ' ) and ((Month_24_Anonymize_Countdown__c = 0 AND (NOT PersonEmail like \'%anonymous%\') and Country__c != \''+BAT_ConstantsUtility.COUNTRY_RO+'\') OR ((PersonMobilePhone != null and BAT_ConsentDate__c <:anonymisationDate) AND Country__c  = \''+BAT_ConstantsUtility.COUNTRY_RO+'\')) ' + 
            BAT_ConstantsUtility.AND_STRING + BAT_ConstantsUtility.SINGLE_SPACE + 
            BAT_ConstantsUtility.ACCOUNT_FIELD_ISPERSONACCOUNT + ' = '+  BAT_ConstantsUtility.BOOLEANTRUE;
           */
             query = query + ' ) and LastName !=\'anonymous\'  AND  IsPersonAccount = true AND ((Month_24_Anonymize_Countdown__c = 0 AND Country__c != \''+BAT_ConstantsUtility.COUNTRY_RO+'\') OR (PersonMobilePhone != null and BAT_ConsentDate__c <:anonymisationDate AND Country__c  = \''+BAT_ConstantsUtility.COUNTRY_RO+'\')) ';
           // BAT_ConstantsUtility.AND_STRING + BAT_ConstantsUtility.SINGLE_SPACE + 
            //BAT_ConstantsUtility.ACCOUNT_FIELD_ISPERSONACCOUNT + ' = '+  BAT_ConstantsUtility.BOOLEANTRUE;
           
            
           //   query = query + ' ) and Month_24_Anonymize_Countdown__c = 0 AND ((NOT PersonEmail like \'%anonymous%\') OR (PersonMobilePhone != null and BAT_ConsentDate__c <:anonymisationDate AND Country__c  = \''+BAT_ConstantsUtility.COUNTRY_RO+'\')) ' + 
         system.debug('Testingquery'+query);                                                                                                                                 
                                                                                                                                          
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);        
    } 
    
    global void execute(Database.BatchableContext BC, list<Account> scope){
       /*if(true){
        * 
            return;
        }*/
        
        system.debug('TestingResult=='+scope);
    //26th May, 2021/Abhishek Kashyap/BUG:538533-RO-moved the variables from global scope to method scope to make them non-stateful, thus preventing callout limit hit issue
        //2nd April,2020/Abhishek Kashyap/BUG-468283-Added variables to have the details of the anonymized accounts which are also to be by reverse integration
        List<SObject> newRecordList = new List<SObject>();
        Map<Id,SObject> oldObjectMap = new Map<Id,SObject>();
    Set<Id> newRecordIdSet = new Set<Id>();
        String queryString= BAT_ConstantsUtility.QUERY_ID_ACCOUNTID_FROM_ORDER;
        List<Id> accidsToAnonymize = new List<Id>(); 
        List<Account> accListToAnonimise = new List<Account>();  
        //27Th Aug, 2020/Abhishek Kashyap/ENH_227912,Created maps to save all the accounts to be anonymmized,Accounts with order in past 6 months and accounts not having orders in past 6 months
        Map<Id, Account> accountIdToAccountMap = new Map<Id, Account>();
        Map<Id, Account> accountWithoutOrderMap = new Map<Id, Account>();
        Map<Id, Account> accountWithOrderMap = new Map<Id, Account>();
        Map<String, List<Account>> countryToAccountListMap = new Map<String, List<Account>>();
    //25th April, 2021/Abhishek Kashyap/Bug-567747-Map to store accounts for which reverse int needs to be triggered
        Map<String,List<Account>> accountMapReverseIntUpdate = new Map<String,List<Account>>();
        //Converting Set to List to check for number of OR conditions with respect to size.
        List<String> listCountries = new List<String>(automaticAnonymizationConfigMap.keySet());
        //US#261129 : Added a flag to indicate if the order query is formed for the market and needs to execute Order query
        Boolean executeOrderQuery = false;
        //27Th Aug, 2020/Abhishek Kashyap/ENH_227912,Populating account map
        //loop begins
        for(Account eachAccount:scope){
            system.debug('==eachAccount='+eachAccount);
            //Added below if condition(BAT_Is_Anonymised__c == false) as part of RO - US#461730 so that for partially anonymized accounts it need not to check order exists or not
            //US#461730 - Updated below condition to make it metadata driven: to bypass orders check for RO Partially anonymzied accounts
            if(automaticAnonymizationConfigMap.containsKey(eachAccount.Country__c) && (!automaticAnonymizationConfigMap.get(eachAccount.Country__c).BAT_BypassOrderCheckPartialAnonyAccounts__c || 
            (automaticAnonymizationConfigMap.get(eachAccount.Country__c).BAT_BypassOrderCheckPartialAnonyAccounts__c  
            && eachAccount.BAT_Is_Anonymised__c == false))){
                if(!countryToAccountListMap.containsKey(eachAccount.Country__c)){
                    countryToAccountListMap.put(eachAccount.Country__c, new List<Account>());
                }
                countryToAccountListMap.get(eachAccount.Country__c).add(eachAccount);
            }
            accountIdToAccountMap.put(eachAccount.Id,eachAccount);
        }//loop ends
    //2nd April,2020/Abhishek Kashyap/BUG-468283-Iterating on Scope for RO Accounts to add them to OldMap to be used in reverseIntegration
        for(Account eachAnonymizedAccount : scope){
            if(eachAnonymizedAccount.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
        //2nd April,2020/Abhishek Kashyap/BUG-468283-Added the cloned objects to OldMap to bypass callByReference updates to same record later
                Account newAccount = new Account();
                newAccount = eachAnonymizedAccount.clone();
                newAccount.id = eachAnonymizedAccount.id; 
                newRecordIdSet.add(eachAnonymizedAccount.Id);
                oldObjectMap.put(newAccount.Id,newAccount);
            }   
        }
        //27Th Aug, 2020/Abhishek Kashyap/ENH_227912,Loop iterates on metadata records, gets the created date to be considered for order and forms the query.
        //loop begins
        for(String eachCountry :automaticAnonymizationConfigMap.Keyset()){
            //The condition checks if the metadata record has numbers of months for which orders should be considered, or else skips order query.
            if(countryToAccountListMap.containsKey(eachCountry) && automaticAnonymizationConfigMap.get(eachCountry).BAT_MonthsForLastOrder__c!=null){
                executeOrderQuery = true;
                List<Account> accountList = countryToAccountListMap.get(eachCountry);
                String lastCreatedDate = String.valueOf(System.now().addMonths(-Integer.valueOf(automaticAnonymizationConfigMap.get(eachCountry).BAT_MonthsForLastOrder__c)).format('yyyy-MM-dd') );
                queryString+=BAT_ConstantsUtility.OPEN_PARENTHESIS_STR+BAT_ConstantsUtility.COUNTRY_STRING_WITHOUT_BRACKET+eachCountry+BAT_ConstantsUtility.DELETEOLDACCOUNTBATCH_ORDERSTARTDATE+lastCreatedDate+
                    BAT_ConstantsUtility.AND_STRING+BAT_ConstantsUtility.ACCOUNTID_IN +BAT_ConstantsUtility.AND_STRING+
                    BAT_ConstantsUtility.DELETEOLDACCOUNTBATCH_RECORDTYPEFILTER+automaticAnonymizationConfigMap.get(eachCountry).BAT_OrderRecordType__c+
                    BAT_ConstantsUtility.QUERY_APOSTROPHE+BAT_ConstantsUtility.CLOSED_PARENTHESIS_STR;
                if(eachCountry <> listCountries[listCountries.size()-1] && automaticAnonymizationConfigMap.get(listCountries[listCountries.size()-1]).BAT_MonthsForLastOrder__c!=null){
                    queryString+=BAT_ConstantsUtility.QUERY_OR+BAT_ConstantsUtility.SINGLE_SPACE;               
                }            }
            }//loop ends
            //27Th Aug, 2020/Abhishek Kashyap/ENH_227912,Query to get accounts having orders in past 6 months
            if(!accountIdToAccountMap.keySet().isEmpty() && executeOrderQuery){
                List<Order> AccountWithOrderList = Database.query(queryString);
                //27Th Aug, 2020/Abhishek Kashyap/ENH_227912, For accounts having orders in past 6 months, reseting the consent flags
                //loop begins
                for(Order eachOrder : AccountWithOrderList){
                    Account eachAccount = new Account();
                    eachAccount.Id=eachOrder.AccountId;
                    eachAccount.Generic_Permission__c = false;
                    eachAccount.Submit_Surveys_Permission__c = false;
                    // Added as per RO US#409770
                    // 21st June,2024/Varaprasad Sada/Sprint 159:US #1744353 -RO - update of the anonymization script part 2
                    eachAccount.PersonHasOptedOutOfEmail = false;
                    eachAccount.SMS_Opt_Out__c = false;
                    eachAccount.PersonDoNotCall = false;
                    eachAccount.BAT_ProfilingConsent__c = false;
            //25th April, 2021/Abhishek Kashyap/Bug-567747-Added fields to the object required to trigger rev int when consent changes due to existing order
                    eachAccount.Country__c = eachOrder.Country__c;
                    eachAccount.BAT_ExternalCustomerID5__c = eachOrder.Account.BAT_ExternalCustomerID5__c;
                    eachAccount.BillingCity = eachOrder.Account.BillingCity;
                    eachAccount.BillingState = eachOrder.Account.BillingState;
                    eachAccount.External_Customer_ID3__c= eachOrder.Account.External_Customer_ID3__c;
                    eachAccount.FirstName= eachOrder.Account.FirstName;
                    eachAccount.Gender__c= eachOrder.Account.Gender__c;
                    eachAccount.LastName= eachOrder.Account.LastName;
                    eachAccount.PersonBirthdate= eachOrder.Account.PersonBirthdate;
                    eachAccount.PersonEmail= eachOrder.Account.PersonEmail;
                    eachAccount.PersonMobilePhone=eachOrder.Account.PersonMobilePhone;
                    eachAccount.Brand_House__c=eachOrder.Account.Brand_House__c;
                    //END US#409770
                    accountWithOrderMap.put(eachAccount.Id, eachAccount);
            //25th April, 2021/Abhishek Kashyap/Bug-567747-Populating the map, if the consent changes for accounts with existing ecommerce orders
                    if(accountIdToAccountMap.get(eachOrder.AccountId).Generic_Permission__c 
                       || accountIdToAccountMap.get(eachOrder.AccountId).Submit_Surveys_Permission__c){
               //25th April, 2021/Abhishek Kashyap/Bug-567747-Added accounts for which consents are updated and rev int needs to be triggered
                           if(accountMapReverseIntUpdate.isEmpty() || !accountMapReverseIntUpdate.containsKey(BAT_ConstantsUtility.EVENT_UPDATE)){
                               accountMapReverseIntUpdate.put(BAT_ConstantsUtility.EVENT_UPDATE, new List<Account>());
                           }
                           accountMapReverseIntUpdate.get(BAT_ConstantsUtility.EVENT_UPDATE).add(accountWithOrderMap.get(eachOrder.AccountId));
                       }
                }//loop ends
            }
            //27Th Aug, 2020/Abhishek Kashyap/ENH_227912, Segrigating accounts not having orders in past 6 months, which will be anonymized
            //loop begins
            for(Id eachAccountId : accountIdToAccountMap.KeySet()){
                if(!accountWithOrderMap.containsKey(eachAccountId)){
                    accountWithoutOrderMap.put(eachAccountId, accountIdToAccountMap.get(eachAccountId));
                }
            }//loop ends
            //27Th Aug, 2020/Abhishek Kashyap/ENH_227912,Anonymizing the accounts
             for(Id accountId:accountWithoutOrderMap.keySet()){
                accidsToAnonymize.add(accountId);
                accListToAnonimise.add(accountWithoutOrderMap.get(accountId));
               }
           
               accListToAnonimise = BAT_Utilities.anonymizeAccounts(accListToAnonimise);
               // Added as per RO US#409770
               if(!accListToAnonimise.isEmpty()){
                    for(Account acc : accListToAnonimise){
                        if(acc.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
                            acc.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
                            acc.PersonMobilePhone__c = BAT_ConstantsUtility.EMPTY_STRING;// Added as part of Bug#461672
                            acc.PersonOtherPhone = BAT_ConstantsUtility.EMPTY_STRING; // Added as part of Bug#514108
                            acc.BAT_FormattedMobile__c = BAT_ConstantsUtility.EMPTY_STRING;// Added as part of Bug#461672
                            acc.Phone_Verified__c = false; //Added as part of RO US#417298
                            acc.BAT_BypassMobileVerification__c = true; //Added as part of RO US#417298
                //6th April,2021/Abhishek Kashyap/US-466621-Set Account Source to blank for full anonymization
                acc.AccountSource = BAT_ConstantsUtility.EMPTY_STRING;
                        }
                    }
               }
               //END US#409770
               List<Asset> assetsToAnonymize = BAT_Utilities.anonymizeRelatedAssets(accidsToAnonymize);       
                List<Case> casesToAnonymize = BAT_Utilities.anonymizeRelatedCases(accidsToAnonymize);
                //Added as part of RO - US#417298 - Anonymize related brand profiles of account for RO
                List<BAT_BrandProfile__c> brandProfilesToAnonymize = BAT_Utilities.anonymizeRelatedBrandProfiles(accidsToAnonymize);
                List<Survey_Information__c> surveysToAnonymize = BAT_Utilities.anonymizeRelatedServeys(accidsToAnonymize);
                List<Event> eventsToAnonymize = BAT_Utilities.anonymizeRelatedEvents(accidsToAnonymize);
                List<Task> tasksToAnonymize = BAT_Utilities.anonymizeRelatedTasks(accidsToAnonymize);
                List<Lead> leadsToAnonymize= BAT_Utilities.anonymizaRelatedLeads(accListToAnonimise);
                List<Opportunity> oppsToAnonymize = BAT_Utilities.anonymizeRelatedOpportunity(accidsToAnonymize);
                List<Order> ordersToAnonymize= BAT_Utilities.anonymizeRelatedOrders(accidsToAnonymize);
                List<ContentDocument> PrivacyDocs = BAT_Utilities.deletePrivacySanpshots(accidsToAnonymize);
            //2nd April,2020/Abhishek Kashyap/BUG-468283-Adding anonymized account records to newRecordList, to be used in ReverseIntegration
            for(Account eachAccount : accListToAnonimise){
            if(newRecordIdSet.contains(eachAccount.Id)){
        //25th April, 2021/Abhishek Kashyap/Bug-567747-Added anonymized accounts for which delete event needs to be fired
                if(accountMapReverseIntUpdate.isEmpty() || !accountMapReverseIntUpdate.containsKey(BAT_ConstantsUtility.EVENT_DELETE)){
                               accountMapReverseIntUpdate.put(BAT_ConstantsUtility.EVENT_DELETE, new List<Account>());
                           }
                accountMapReverseIntUpdate.get(BAT_ConstantsUtility.EVENT_DELETE).add(eachAccount);
            } 
        }
    //25th April, 2021/Abhishek Kashyap/Bug-567747-If RO accounts are anonymized or consents updated, calling reverseIntegration to delete/update corresponding account in CIAM
        if(!accountMapReverseIntUpdate.isEmpty()){
            BAT_ReverseAPICallHandler.initiateReverseAPIFromBatch(accountMapReverseIntUpdate, BAT_ConstantsUtility.STANDARD_ACCOUNT_STR, BAT_ConstantsUtility.COUNTRY,oldObjectMap);
        }
    //27Th Aug, 2020/Abhishek Kashyap/ENH_227912, Merging anonymised accounts and the accounts for with consent flags were updated
        accListToAnonimise.addAll(accountWithOrderMap.values());
                if(!accListToAnonimise.isEmpty()){
                    Database.SaveResult[] accountAnonymiseList = Database.update(accListToAnonimise, false);
                    system.debug('TestingTestaccountAnonymiseList'+accountAnonymiseList);
                    BAT_Utilities.createErrorLogs(accountAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                
                if(!assetsToAnonymize.isEmpty()){
                    Database.SaveResult[] assetAnonymiseList = Database.update(assetsToAnonymize, false);
                    BAT_Utilities.createErrorLogs(assetAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }      
                
                if(!casesToAnonymize.isEmpty()){
                    Database.SaveResult[] caseAnonymiseList = Database.update(casesToAnonymize, false);
                    BAT_Utilities.createErrorLogs(caseAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                
                //Added as part of RO - US#417298 - Anonymize related brand profiles of account for RO
                if(!brandProfilesToAnonymize.isEmpty()){
                    update brandProfilesToAnonymize;
                }
                
                if(!surveysToAnonymize.isEmpty()){ 
                     Database.SaveResult[] surveyAnonymiseList =Database.update(surveysToAnonymize, false);
                     BAT_Utilities.createErrorLogs(surveyAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                if( !eventsToAnonymize.isEmpty()){
                    if(Schema.sObjectType.Event.isDeletable()  && !Test.isRunningTest()){ Database.DeleteResult[] eventsToAnonymiseDeleteList = Database.delete(eventsToAnonymize,false);
                        BAT_Utilities.createErrorLogs(eventsToAnonymiseDeleteList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    }else{
                       Database.SaveResult[] eventAnonymiseList = Database.update(eventsToAnonymize, false);
                       BAT_Utilities.createErrorLogs(eventAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    }
                }
                if(!tasksToAnonymize.isEmpty()){
                    if(Schema.sObjectType.Task.isDeletable() && !Test.isRunningTest()){ Database.DeleteResult[] tasksToAnonymiseDeleteList = Database.delete(tasksToAnonymize,false);
                        BAT_Utilities.createErrorLogs(tasksToAnonymiseDeleteList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    }else{
                        Database.SaveResult[] tasksAnonymiseList = Database.update(tasksToAnonymize, false);
                        BAT_Utilities.createErrorLogs(tasksAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                    }
                }
                if(!leadsToAnonymize.isEmpty()){
                    Database.SaveResult[] leadsAnonymiseList = Database.update(leadsToAnonymize, false);
                    BAT_Utilities.createErrorLogs(leadsAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                if(!oppsToAnonymize.isEmpty()){
                    Database.SaveResult[] opportunityAnonymiseList = Database.update(oppsToAnonymize, false);
                    BAT_Utilities.createErrorLogs(opportunityAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                if(!ordersToAnonymize.isEmpty()){
                    Database.SaveResult[] ordersAnonymiseList =  Database.update(ordersToAnonymize, false);
                    BAT_Utilities.createErrorLogs(ordersAnonymiseList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
                if(!PrivacyDocs.isEmpty()){
                    Database.DeleteResult[] privacyDocsDeleteList = Database.delete(PrivacyDocs,false);
                    BAT_Utilities.createErrorLogs(privacyDocsDeleteList,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_BATCH,BAT_ConstantsUtility.EXECUTE_STR);
                }
            
            for(Account anonymizedAccount: accListToAnonimise){
                if(!automaticAnonymizationConfigMap.isEmpty()
                   && automaticAnonymizationConfigMap.containskey(anonymizedAccount.Country__c)
                   && automaticAnonymizationConfigMap.get(anonymizedAccount.Country__c).BAT_DeletePersonAccountHistory__c){
                       accHistoryDelIdSet.add(anonymizedAccount.Id);
                   }
            }           
            
            //16-12-2022: Hariharan Pillai/#1015949: Moved Account History Deletion from final block to execute
            if(!accHistoryDelIdSet.isEmpty()){
            List<PermissionSetAssignment> personAccDeletionPermList = new List<PermissionSetAssignment>();
            personAccDeletionPermList = [SELECT Id
                                         FROM PermissionSetAssignment
                                         WHERE PermissionSet.Name =: BAT_ConstantsUtility.PERSON_ACC_HISTORY_DELETE_PERMISSION
                                         AND AssigneeId =: user.Id];
            if(personAccDeletionPermList.size() > 0){
                if(!accHistoryDelIdSet.isEmpty()){
                    List<AccountHistory> accountHistoryList = [SELECT Id FROM AccountHistory WHERE AccountId IN: accHistoryDelIdSet];
                    
                    if(accountHistoryList != null && !accountHistoryList.isEmpty()){
                        Database.delete(accountHistoryList,true);
                    }
                }
            }
        }
    }
            

    global void finish(Database.BatchableContext BC) {
        
    }
}