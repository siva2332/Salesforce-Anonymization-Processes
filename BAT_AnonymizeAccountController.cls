/********************************************************************************************************
* @Author        : Deloitte
* @Description   : Class to implement anonymization process and builds txt file to be used by EM to track anonymized accounts
* @Date          : 31/05/2018.
* @Component     : Used in Lightning component "BAT_AnonymizeAccountComponent". 
* @Object        : Account
* @Changes
* 19/11/2018     Lorenzo Temperini
* VSTS 4080 BAT ITALY - PERSONAL INFORMATION STORAGE
                04/04/2019/Abhishek Kashyap/ DE: Sprint 6 - 13295 Removed references of Account.Opt_Out_From_Email_Contact_DE__c, Account.Opt_Out_From_Mobile_Contact_DE__c and Account.IsAgreement_On_Data_Handling_DE__c
                and replaced it with Account.BAT_IsGloOptInEmailCommunication__c, Account.BAT_IsGloOptInMobileTextWhatsApp__c and Account.BAT_isGloPersonalDataHandling__c respectively.
                Commented Account.IsMarket_Research_Authorisation_DE__c field update.
				18/04/2019/ Abhishek Kashyap/ US - 19460, DE-Market, Updated account category status field when account gets anonymised.
				25.04.2019/ Abhishek Kashyap/ US - 20271, DE-Market, Replaced BAT_isGloPersonalDataHandling__c with Registration_Permission__c and created new field BAT_IsVypePersonalDataHandling__c
				10-7-2019/Abhishek Kashyap/BUG-33772 - updated anonymizeAccount method for field anonymization for AT and DE update
				10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217 / Moving Anonymization logic to BAT_Utilities to make code reusable.
	12.08.2019/ Sri Harsha P/ US - 33838, MX-Market, Added Condition for MX specific fields Shipping, Billing Address, Order Information
		23.08.2019/Abhishek Kashyap/US-37576 - Added velo consent fields for anonymization.
				06/12/2019 / Souvik Dinda/ US#47980: Added code to delete account history when anonymizing account based on user's
                permission set.
                12/03/2020/Akshaya Sarvesh/Added braces after If statements as part of Force Reviewer violation
                20/03/2020/ Edwin Resendiz/ Bug #102089 Added null validation from Account
				23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
                22nd,Mar,2021/Roopa N/RO : US#417298 - Added required fields for RO Anonymization
                26th Mar,2021/Roopa N/RO : Bug#461672 - Anonymizing custom field "PersonMobilePhone__c" as well as part of RO full anonymization
		6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
		16th April, 2021/Abhishek Kashyap/US-225171-RO - Anonymized personal data visible in Orders
		22nd April, 2021/Abhishek Kashyap/US-543158-RO - Anonymization in the to be architecture - update
		30th June, 2022/Rajeswari / US - 1029822 - CH - Admin Portal - Anonymise Account
		22-07-2022/Sonal Srivastava/ US #1076739 / CH - Admin Portal - Anonymisation of Individual (Track customer consent) record along with account
        11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
        06.02.2023/Rama Akella/Bug#1293078: Throw validation error message in case of 'Field_Custom_Validation_Exception'
*********************************************************************************************************/
public without sharing class BAT_AnonymizeAccountController {
   
/********************************************************************************************************
       * @Author        :   Deloitte.
       * @Date          :   01/21/2019.
       * @Description   :   This method is invoked from "doInit function in BAT_AnonymizeAccountComponentController.js " and used to get Account with account Id.
       * @Paramters     :   Account id.
       * @Return        :   Account.
       * Change history :   03.04.2019/Nancy Thangamani/US:15497/Added the is Anonymized field in the account query.
                18/04/2019/ Abhishek Kashyap/ US - 19460, DE-Market, Added BAT_CombustibleStatus__c,BAT_OralStatus__c,
                     BAT_THPStatus__c,BAT_VapeStatus__c to the query.
 *********************************************************************************************************/ 
    @AuraEnabled
    public static Account getAccount(Id accountId){
    //Added External_Customer_Id fields - by Usha for US#:3601
    //Added IsPostal_Opt_Out__c,PersonHasOptedOutOfEmail,IsMobile_Opt_Out__c fields in query as part of US#4397
    //18/04/2019/ Abhishek Kashyap/ US - 19460, DE-Market, Added BAT_CombustibleStatus__c,BAT_OralStatus__c,BAT_THPStatus__c,BAT_VapeStatus__c to the query.
    //22nd April, 2021/Abhishek Kashyap/US-543158-Update the query to get Brand Profile record details
    Account account = new Account();
    try{
            if(String.isNotBlank(accountId)){ // added if condition -
                account = [SELECT id, LastName, FirstName, Country__c, PersonEmail, PersonMobilePhone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, Related_Lead__c,
                           Registration_Permission__c,External_Information_Systems_Permission__c,Submit_Surveys_Permission__c,
                           Trial_Information_Permission__c,Birth_Date__c,Generic_Permission__c, is_trialist__c,Gender__c,Status__c, BAT_Is_Anonymised__c,
                           BAT_CombustibleStatus__c,BAT_OralStatus__c,BAT_THPStatus__c,BAT_VapeStatus__c,
                           BAT_IsEPOKOptInEmailCommunication__c,BAT_IsEPOKOptInMobileTextWhatsApp__c,BAT_IsEPOKOptInPostal__c,	
                           BAT_EPOKMarketResearchAuthorization__c,BAT_EPOKLastCompletedOrderDate__c,BAT_EPOKLastConsentOptInDate__c,
                           BAT_IsVypeOptInEmailCommunication__c,BAT_IsVypeOptInMobileTextWhatsApp__c,BAT_IsVypeOptInPostal__c,
                           BAT_VypeMarketResearchAuthorization__c,GoVype_Last_Completed_Order_Date__c,BAT_VypeLastConsentOptInDate__c,	
                           BAT_IsLyftOptInEmailCommunication__c,BAT_IsLyftOptInMobileTextWhatsApp__c,BAT_IsLyftOptInPostal__c,	
                           BAT_LyftMarketResearchAuthorization__c,BAT_LyftExternalCompaniesAuthorization__c,
                           BAT_LyftTrialFeedbackAuthorization__c,BAT_LyftLastCompletedOrderDate__c,	BAT_LyftLastConsentOptInDate__c,
                           External_Customer_Id__c,	External_Customer_ID3__c,BAT_ExternalCustomerId4__c, BAT_ExternalSubscriberId__c,BAT_ExternalSubscriberId3__c,	BAT_ExternalSubscriberId4__c,
                           Email_verified__c, Member_get_Member_Code__c, MgM_Counter__c, Skip_Repurchase_Lock__c,
                           Wrong_Phone_Number__c, Preferred_Tobacconist_Shop__c, Last_Call_Type__c, Member_get_Member_Promotional_Code__c,
                           Age_verified__c, PersonHasOptedOutOfFax, PersonDoNotCall, SMS_Opt_Out__c, PersonHasOptedOutOfEmail, AccountSource,
                           Store_ID__c, BAT_BypassMobileVerification__c, Category__c, Brand__c, Variant__c, Sector__c, PersonIndividualId,BAT_AMPEmailOptOut__c,BAT_AMPLastConsentDate__c,CreatedDate,BAT_ConsentDate__c  
                           FROM Account 
                           WHERE id =: accountId];//1771605 
                System.debug(account);
            }
        }
        catch(Exception ex){
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_CONTROLLER,BAT_ConstantsUtility.GET_ACCOUNT_METHOD);
            return account;
        }
        return account;
   }
    /********************************************************************************************************
    * @Author        :   Deloitte.
    * @Date          :   01/21/2019.
    * @Description   :   This method is invoked from "handleAnonymize function in BAT_AnonymizeAccountComponentController.js " and used to update the Asset,event,task,Lead.
    * @Paramters     :   Account.
    * @Return        :   Map<String,String>.
    * @change history:   3rd April :SPRINT 3: US:15497 DE is Anonymise logic for the updated records both manually and via integration.
    			18/04/2019/ Abhishek Kashyap/ US - 19460, DE-Market, Updated account category status field when account gets anonymised.
			25.04.2019/ Abhishek Kashyap/ US - 20271, DE-Market, Replaced BAT_isGloPersonalDataHandling__c with Registration_Permission__c and created new field BAT_IsVypePersonalDataHandling__c
			10-7-2019/Abhishek Kashyap/BUG-33772 - Field anonymization for AT and DE update
			23.08.2019/Abhishek Kashyap/US-37576 - Added velo consent fields for anonymization.
			10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217 / Moving Anonymization logic to BAT_Utilities to make code reusable.
						06/12/2019 / Souvik Dinda/ US#47980: Added code to delete account history when anonymizing account based on user's
						permission set.
                        20/03/2020/ Edwin Resendiz/ Bug #102089 Added null validation from Account
						08th Mar, 2021/RO - US# 409772/Added by Roopa N/ Passing isFullyAnonymize parameter & added condition to make personMobilePhone blank
			6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
                        22nd Mar,2021/Roopa N/RO - US#417298 - Added fields for RO Full Anonymization
			15th April,2020/Abhishek Kashyap/Bug-487779-478408 - Brand Profile status is not reset to Inactive after receiving Delete event from CIAM Integration
			16th April, 2021/Abhishek Kashyap/US-225171-RO - Anonymized personal data visible in Orders
			22nd April, 2021/Abhishek Kashyap/US-543158-RO - Anonymization in the to be architecture - update
			30th June, 2022/Rajeswari / US - 1029822 - CH - Admin Portal - Anonymise Account
            11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
            06.02.2023/Rama Akella/Bug#1293078: Throw validation error message in case of 'Field_Custom_Validation_Exception'
            08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account
    *********************************************************************************************************/  
    @AuraEnabled
    public static Map<String,String> anonymizeAccount(Account account,boolean isFullyAnonymize){
        
        Map<String,String> returnMap = new Map<String,String>();
        List<Profile> loggedInUserProfile = new List<Profile>();
        List<Event> associatedEvents = new List<Event>();
        List<Task> associatedTasks = new List<Task>();
	//16th April, 2021/Abhishek Kashyap/US-225171-Declared sets of Order, Asset and Case
        Set<Id> deleteRelatedOrderAccountIdSet = new Set<Id>();
        Set<Id> deleteRelatedConsentAccountIdSet = new Set<Id>();
        Set<Id> deleteRelatedAssetAccountIdSet = new Set<Id>();
        Set<Id> deleteRelatedCaseAccountIdSet = new Set<Id>();
        User currentUser = BAT_Utilities.getUserDetails();
        Set<Id> accIdHistoryDeleteSet = new Set<Id>();
        List<Account> accountsAnonymized = new List<Account>();
        
        Map<String,BAT_AutomaticAnonymizationConfiguration__mdt> automaticAnonymizationConfigMap = BAT_Utilities.getAutomaticAnonymizationConfig();
        Map<String,List<BAT_AccountToCaseMappingConfiguration__mdt>> accToCaseMappingConfigMap = BAT_Utilities.getAccountToCaseMappingConfig();
       
		BAT_Utilities.privacySnapshotDeletionWrapper snapshotWrapper = new BAT_Utilities.privacySnapshotDeletionWrapper();
        try{
            
            //Find logged in user's profile - by Usha for US#:3601
            String userProfileName = BAT_Utilities.getProfileName();
            List<Account> newAccounts = new List<Account>();
            List<id> accountids = new List<id>();
            List<id> privacySnapshotDeletionParentIds = new List<id>();
            List<id> nonSwedenAccountIds = new List<id>();
            Set<Id> contactIdSet = new Set<Id>();
            List<Case> caseToUpdateList = new List<Case>();
            if(account!=null) {
                //Idrees Ali/ Created separate set for storing non-SE account id's
                // 16/11/2023/US: 1521043/SE/DK - Admin Portal - Anonymise Account---added country DK
                if(account.Country__c != BAT_ConstantsUtility.COUNTRY_SE && account.Country__c != BAT_ConstantsUtility.DK_STR){
                    nonSwedenAccountIds.add(account.Id);
                }
                if(!accToCaseMappingConfigMap.isEmpty() && accToCaseMappingConfigMap.containsKey(account.Country__c) && (account.Country__c == BAT_ConstantsUtility.COUNTRY_SE || account.Country__c == BAT_ConstantsUtility.DK_STR)){
                    Account accRec = [Select id, PersonContactId from account where id = :account.Id];
                    contactIdSet.add(accRec.PersonContactId);
                }
                if(!contactIdSet.isEmpty()){
                    List<Case> caseList = [Select Id,First_Name__c,Last_Name__c,Phone_Number__c,Email__c,Country__c,ContactId from Case where ContactId IN : contactIdSet];
                    if(!caseList.isEmpty()){
                        caseToUpdateList = BAT_Utilities.caseFieldUpdateBasedOnMapping(contactIdSet,caseList,accToCaseMappingConfigMap);
                    }
                }
                newAccounts.add(account);
                accountids.add(account.id);
                
                 system.debug('LK Line'+account.BAT_AMPLastConsentDate__c);
                 system.debug('LK Line'+account.LastName);
                 system.debug('LK Line'+account.PersonHasOptedOutOfEmail);
                //generateAnonymizationFile before it is sent for deletion
                generateAnonymizationFile(account,account.Country__c);
				//Added Null check before DML operation as part of ForceReviewer changes.
				
				if(!automaticAnonymizationConfigMap.containsKey(account.Country__c)
                  ||(automaticAnonymizationConfigMap.containsKey(account.Country__c) &&
                        !automaticAnonymizationConfigMap.get(account.Country__c).BAT_IsRetainPrivacySnapShot__c) ){
                        //Added Null check before DML operation as part of ForceReviewer changes.
                        if(!deletePrivacySnapshot(nonSwedenAccountIds)){ returnMap.put(Label.LIGHTNING_Error_Label,Label.ANONYMIZE_Error_Message);
                         system.debug('LK Line before 1'+nonSwedenAccountIds);                                               
                          return returnMap;
                        }
                }
                snapshotWrapper = BAT_Utilities.checkCriteriaforSnapshotDeletion(account);
                 
                 system.debug('LK Line'+account.BAT_AMPLastConsentDate__c);
                 system.debug('LK Line'+account.LastName);
                 system.debug('LK Line'+account.PersonHasOptedOutOfEmail);
            }
            //11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
            if(automaticAnonymizationConfigMap.containsKey(account.Country__c) &&
                automaticAnonymizationConfigMap.get(account.Country__c).BAT_Anonymize_Related_Survey__c){
                List<Id> PersonContactIds = new List<Id>();
                List<Id> AccIds = new List<Id>();
                AccIds.add(account.Id);
                PersonContactIds.add([select PersonContactId FROM account where ID =: account.Id LIMIT 1].PersonContactId);
                BAT_Utilities.anonymizeRelatedSurveyInvitation(PersonContactIds,AccIds);
            }
            //Added by Roopa N as part of RO - US# 409772
            if(newAccounts != null && !newAccounts.isEmpty()){
                for(Account acc :newAccounts){
                    if(isFullyAnonymize && acc.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
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
            
            
	    	//22nd April, 2021/Abhishek Kashyap/US-543158-Added flag to segrigate anonymization flow from button or direct record update
            BAT_ConstantsUtility.IS_ANONYMIZE_ACCOUNT_BUTTON_FLAG = true;
            accountsAnonymized = BAT_Utilities.anonymizeAccounts(newAccounts);
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(accountsAnonymized != null && !accountsAnonymized.isEmpty()){
                update accountsAnonymized;
            }
            /*UPDATING-DELETING RELATED OBJECTS*/
            /*UPDATING ASSETS*/
                List<asset> assetToUpdate = new List<asset>();
                assetToUpdate = BAT_Utilities.anonymizeRelatedAssets(accountids);
				//Added Null check before DML operation as part of ForceReviewer changes.
            	if(assetToUpdate != null && !assetToUpdate.isEmpty()){
                   update assetToUpdate;
                }
            /*UPDATING CASES*/
                List<Case> caseToUpdate = new List<Case>();
                caseToUpdate = BAT_Utilities.anonymizeRelatedCases(nonSwedenAccountIds);	
				//Added Null check before DML operation as part of ForceReviewer changes.
                if(caseToUpdate != null && !caseToUpdate.isEmpty()){
                   update caseToUpdate;
                }
            /*UPDATING SURVEY RECORDS*/
            List<Survey_Information__c> surveysToUpdate=new List<Survey_Information__c>();
                surveysToUpdate = BAT_Utilities.anonymizeRelatedServeys(accountids);
				//Added Null check before DML operation as part of ForceReviewer changes.
                if(surveysToUpdate != null && !surveysToUpdate.isEmpty()){
                   update surveysToUpdate;
                }
				//Added as part of US#417298 - Anonymize related brand profiles of account for RO
                List<BAT_BrandProfile__c> brandProfileToUpdate = new List<BAT_BrandProfile__c>();
                brandProfileToUpdate = BAT_Utilities.anonymizeRelatedBrandProfiles(accountids);
                if(brandProfileToUpdate != null && !brandProfileToUpdate.isEmpty()){
                   update brandProfileToUpdate;
                }
                //END US#417298
            /*DELETING ACTIVITIES RECORDS*/
            /*FULL ANONYMIZATION ITALY CR: 03/09/2017*/
            associatedEvents = BAT_Utilities.anonymizeRelatedEvents(accountids);
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(associatedEvents != null && !associatedEvents.isEmpty()){
                if(Schema.sObjectType.Event.isDeletable()  && !Test.isRunningTest()){ delete associatedEvents;
                }else{
                    update associatedEvents;
                }
            }
            associatedTasks = BAT_Utilities.anonymizeRelatedTasks(accountids);
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(associatedTasks != null && !associatedTasks.isEmpty()){
                if(Schema.sObjectType.Task.isDeletable() && !Test.isRunningTest()){ delete associatedTasks;
                }else{
                    update associatedTasks;
                }
            }
            List<Lead> leadList = BAT_Utilities.anonymizaRelatedLeads(newAccounts);
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(leadList != null && !leadList.isEmpty()){
                update leadList;
            }
			//Updating Individual Records
            List<Individual> individualList = BAT_Utilities.anonymizeRelatedIndividuals(newAccounts);
            if(individualList != null && !individualList.isEmpty()){
                update individualList;
            }
               List<Opportunity> opptyList = new List<Opportunity>();
               opptyList = BAT_Utilities.anonymizeRelatedOpportunity(accountids);
                //Added an empty check - by Prince for Bug#: 3263
				//Added Null check before DML operation as part of ForceReviewer changes.
                if(opptyList != null && !opptyList.isEmpty()){ update opptyList;
                }
            //Starts-- Updating Orders - by Usha for US#:3601 Only for UK. 
            //Shipping address is only being used by UK market, that is why it is not configurable for other market currently.
            //MX Sprint 1: US:33838 Added Billing First Name, Billing Last Name, Billing Street  
            /*UPDATING ORDERS*/
                List<Order> ordersToUpdateLst = new List<Order>();
                ordersToUpdateLst = BAT_Utilities.anonymizeRelatedOrders(accountids);
				//Added Null check before DML operation as part of ForceReviewer changes.
                if(ordersToUpdateLst != null && !ordersToUpdateLst.isEmpty()){
                    update ordersToUpdateLst;
                }
			/*UPDATING ContactPOintTypeCosents - US 1029822*/
            	List<ContactPointTypeConsent> consentsToUpdateLst = new List<ContactPointTypeConsent>();
                consentsToUpdateLst = BAT_Utilities.anonymizeRelatedContactPoints(accountids);
                if(consentsToUpdateLst != null && !consentsToUpdateLst.isEmpty()){
                    update consentsToUpdateLst;
                }
            //Added as part of US#47980
            if(accountsAnonymized != null && !accountsAnonymized.isEmpty()){
				//Added Null check before DML operation as part of ForceReviewer changes.
                for(Account anonymizedAccount : accountsAnonymized){
                    accIdHistoryDeleteSet.add(anonymizedAccount.Id);
                }
                //16th April, 2021/Abhishek Kashyap/US-225171-Populated the sets with Order IDs to delete history, derived by metadata
                for(Order eachOrder:ordersToUpdateLst){
                    String country = eachOrder.Account.Country__c;
                    if(!automaticAnonymizationConfigMap.isEmpty() && automaticAnonymizationConfigMap.containskey(country)
                       && automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedOrderHistory__c){
                        deleteRelatedOrderAccountIdSet.add(eachOrder.Id);
                   }
                }
			//30th June,2022/Rajeswari/ US-1029822- Populated the sets with Consent IDs to delete history, derived by metadata
				for(ContactPointTypeConsent eachConsent:consentsToUpdateLst){
                    String country = eachConsent.BAT_Country__c;
                    if(!automaticAnonymizationConfigMap.isEmpty() && automaticAnonymizationConfigMap.containskey(country)
                       && automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedConsentHistory__c){
                        deleteRelatedConsentAccountIdSet.add(eachConsent.Id);
                   }
                }
		//16th April, 2021/Abhishek Kashyap/US-225171-Populated the sets with Asset IDs to delete history, derived by metadata
                for(Asset eachAsset:assetToUpdate){
                    String country = eachAsset.Account.Country__c;
                    if(!automaticAnonymizationConfigMap.isEmpty()
                   && automaticAnonymizationConfigMap.containskey(country)&& automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedAssetHistory__c){
                        deleteRelatedAssetAccountIdSet.add(eachAsset.Id);
                   }
                }
		//16th April, 2021/Abhishek Kashyap/US-225171-Populated the sets with Case IDs to delete history, derived by metadata
                for(Case eachCase:caseToUpdate){
                    String country = eachCase.Country__c;
                    if(!automaticAnonymizationConfigMap.isEmpty()
                   && automaticAnonymizationConfigMap.containskey(country)&& automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedCaseHistory__c){
                        deleteRelatedCaseAccountIdSet.add(eachCase.Id);
                   }
                }
		//16th April, 2021/Abhishek Kashyap/US-225171-restructured the method to delete Account, Order, Asset and Case history in single future call
                
                if(!system.isBatch()){//1771605
               BAT_Utilities.deletePersonAccHistory(accIdHistoryDeleteSet, currentUser.Id, deleteRelatedOrderAccountIdSet,deleteRelatedConsentAccountIdSet,deleteRelatedAssetAccountIdSet, deleteRelatedCaseAccountIdSet);
                }
                    //Idrees Ali/ US#859464 / Added logic for deleting privacy snapshots of account/lead based on certain conditions
                if(snapshotWrapper.privacySnapshotDeletionParentIds != null && !snapshotWrapper.privacySnapshotDeletionParentIds.isEmpty() ){
                    system.debug('LK Line after 331 privacySnapshotDeletionParentIds'+snapshotWrapper.privacySnapshotDeletionParentIds);
                    deletePrivacySnapshot(snapshotWrapper.privacySnapshotDeletionParentIds);
                }
                if(!caseToUpdateList.isEmpty()){ 
                    update caseToUpdateList;
                }
            }
            //Ends-- Updating Orders - by Usha for US#:3601 Only for UK.
            returnMap.put(Label.LIGHTNING_Success_Label,Label.ANONYMIZE_Success_Message);   
            return returnMap;
        }
        catch(Exception ex){ 
            //Throw the validation rule error message if the exception is FIELD_CUSTOM_VALIDATION_EXCEPTION
            if(ex.getMessage().contains(BAT_ConstantsUtility.VALIDATION_EXCEPTION)){
            	returnMap.put(Label.LIGHTNING_Error_Label,ex.getMessage().substringAfter(BAT_ConstantsUtility.VALIDATION_EXCEPTION+BAT_ConstantsUtility.COMMA_STR)); 
            } else{
                //Added Apex_Log
                BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_CONTROLLER,BAT_ConstantsUtility.ANONYMIZE_ACCOUNT_METHOD);
                returnMap.put(Label.LIGHTNING_Error_Label,Label.ANONYMIZE_Error_Message);
            }
            
            return returnMap;
        }
    } 
    /********************************************************************************************************
       * @Author        :   Luca Proietti Nicolai.
       * @Date          :   01/21/2019.
       * @Description   :   Delete the Privacy Snaphot for Anonimaze feature.
       * @Paramters     :   List<id>.
       * @Return        :   Boolean.
       * @change history:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217 / Moving Anonymization logic to BAT_Utilities to make code reusable.
							23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
    *********************************************************************************************************/  
    @TestVisible
    private static boolean deletePrivacySnapshot(List<id> accountIds){
        try{
            system.debug('LK Line after 367 accountIds:'+accountIds);
            List<ContentDocument> documents = new List<ContentDocument>();
            documents = BAT_Utilities.deletePrivacySanpshots(accountIds);
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(documents != null && !documents.isEmpty()){
                delete documents;
            }
        }
        catch(Exception ex){ 
            // Added Apex_Log
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_CONTROLLER,BAT_ConstantsUtility.DELET_PRIVACY_SNAPSHOT);
            return false;
        }
        return true;
    }
    /********************************************************************************************************
       * @Author        :   Lorenzo temperini.
       * @Date          :   05-09-2018 
       * @Description   :   Generate GDPR Document File (Italy or Enabled Markets.
       * @Paramters     :   Account,String.
       * @Return        :   Void.
	   * @ChangeHistory	:	23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
    *********************************************************************************************************/  
    private static void generateAnonymizationFile(Account acc, String country){
         List<Anonymization_File_Configuration__mdt> anonymizeFileConfs = new List<Anonymization_File_Configuration__mdt>();
         anonymizeFileConfs = [SELECT MasterLabel,File_Name__c,Folder_API_Name__c 
                               FROM Anonymization_File_Configuration__mdt 
                               WHERE MasterLabel = :country];
        if(!anonymizeFileConfs.isEmpty()){
            String accountFullName = BAT_ConstantsUtility.ACCOUNT_NAME + acc.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + 
                                     acc.LastName + BAT_ConstantsUtility.DOUBLE_SPACE + BAT_ConstantsUtility.ACCOUNT_EMAIL + 
                                     acc.PersonEmail + BAT_ConstantsUtility.DOUBLE_SPACE + BAT_ConstantsUtility.ACCOUNT_PHONE + 
                                     acc.PersonMobilePhone + BAT_ConstantsUtility.DOUBLE_SPACE + BAT_ConstantsUtility.ACCOUNT_DATE_BIRTH + 
                                     acc.Birth_Date__c + BAT_ConstantsUtility.DOUBLE_SPACE + BAT_ConstantsUtility.ACCOUNT_GENDER + acc.Gender__c + 
                                     BAT_ConstantsUtility.DOUBLE_SPACE + BAT_ConstantsUtility.ACCOUNT_STATUS + acc.Status__c + BAT_ConstantsUtility.ATH_NextLine;
            Folder folder = new Folder();
            List<Document> existingFiles = new List<Document>();
            List<Document> docToUpdate = new List<Document>();
            List<Document> docToInsert = new List<Document>();
            if(anonymizeFileConfs[0].Folder_API_Name__c != null){
                folder = [SELECT ID FROM Folder WHERE DeveloperName=:anonymizeFileConfs[0].Folder_API_Name__c LIMIT 1];
            }
            if(anonymizeFileConfs[0].File_Name__c != null){
                existingFiles = [SELECT ID,Body FROM Document WHERE Name= :anonymizeFileConfs[0].File_Name__c AND FolderId= :folder.id];
            }
            
            if(!existingFiles.isEmpty()){
                Document currentDoc = existingFiles[0];
                String currentBody = currentDoc.Body.toString();
                currentDoc.Body = Blob.valueOf(currentBody+accountFullname);
                docToUpdate.add(currentDoc);
            }else if(anonymizeFileConfs[0].File_Name__c != null && folder.id != null){
                Document newDoc = new Document();
                newDoc.Name = anonymizeFileConfs[0].File_Name__c;
                newDoc.FolderId = folder.id;
                newDoc.ContentType = BAT_ConstantsUtility.CONTENT_TYPE_TEXTPLAIN;
                newDoc.Type = BAT_ConstantsUtility.TYPE_TEXT;
                newDoc.Body = Blob.valueOf(accountFullName);
                docToInsert.add(newDoc);
            }
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(docToUpdate != null && !docToUpdate.isEmpty()){
                try{
                    update docToUpdate;
                }catch(Exception ex){ BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_CONTROLLER,BAT_ConstantsUtility.GENERATE_ANONYMIZE_FILE_UDATE);
                }    
            }
			//Added Null check before DML operation as part of ForceReviewer changes.
            if(docToInsert != null && !docToInsert.isEmpty()){
                try{
                    insert docToInsert;
                }catch(Exception ex){ BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_ANONYMIZED_ACCOUNT_CONTROLLER,BAT_ConstantsUtility.GENERATE_ANONYMIZE_FILE_INSERT);
                }
                
            }
        }
    }
}