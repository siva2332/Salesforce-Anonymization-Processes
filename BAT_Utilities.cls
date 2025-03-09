/****************************************************************************************
@Author           : Deloitte
@Class            : BAT_Utilities
@TestClass        : TestClass_BAT_Utilities
@Description      : generic methods available to be used by all the other Apex classes
@CreatedDate      : 28/03/2018 
@LastModifiedDate : 30/05/2019 
@ChangeHistory    :  Added by Usha - As part of Optimization to this class,
                     added the constants strings, comments ,given proper names for varibles.
                     03.04.2019/Tejaswi Nissankula/Added method verifyMobileNumberChange
                     04.04.2019/akshata Rajmane /added method to valdiate mobile formats wrt country
                     08.04.2019/Shreeyanshu Kumar/Added method 'getAccountsofAssets'
                     30.05.2019/Abhishek Kashyap/DE :Sprint16 : 13295  Added method 'stampDateTimeOnConsentChange', On change of consent chekbox on Account or Lead, the methos stamps date and time on respective date time field.
                     02.07.2019/Sudaif Haider/Added method getselectOptions to fetch picklist values.
                     02.07.2019/Osheen Sahajpal/Added method getProductAndRangeList to fetch Prduct2 list
                     02.07.2019/Osheen Sahajpal/Added method getPriceBookEntryList to fetch Active pricebookEntries
                     02.07.2019/Osheen Sahajpal/Added method createOrder to return order object for insertion
                     02.07.2019/Osheen Sahajpal/Added method createOrderItem to return orderItem object for insertion
             04.07.2019/Osheen Sahajpal/Added method getValidAccountSource to show custom Account Source
             18.07.2019/Souvik Dinda/Added method to calculate duration of case in hours and fetching businessHoursName
              from BAT_BusinessHoursForCountry__mdt per country.
             19.07.2019/Osheen Sahajpal/Added isTrial parameter on CreateOrder method
             09/08/2019 / Souvik Dinda / US#34105: Added  FirstName and LastName to be retrieved from account.
                    10-01-2019/ Satya Nalluri / BUG #48839/Created new method 'deleteLeadPrivacySanpshots' to delete related privacy snapshots when lead is deleted
             05/09/2019/Osheen Sahajpal/Updated CreateAsset method to add brand mapping for MX users
                     10-09-2019/ Rajesh Potla / Added method anonymizeAccounts to anonymize the accounts.
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedAssets to anonymize the related assets of the accounts.                     
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedCases to anonymize the related Cases of the accounts.
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedServeys to anonymize the related Surveys of the accounts.                     
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedEvents to anonymize the related Events of the accounts.                     
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedTasks to anonymize the related Tasks of the accounts.                     
                     10-09-2019/ Rajesh Potla / Added method anonymizaRelatedLeads to anonymize the related Leads of the accounts.                     
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedOpportunity to anonymize the related Opportunities of the accounts.                     
                     10-09-2019/ Rajesh Potla / Added method anonymizeRelatedOrders to anonymize the related orders of the accounts.
                     10-09-2019/ Rajesh Potla / Added method deletePrivacySanpshots to delete privacy snapshot Documents.
                     11-09-2019/ Souvik Dinda / US#34846 Added new method createBulkTask to create bulk Task from Generate Bulk Task Tab. 
             23/09/2019/Osheen Sahajpal/Created Method isGenericPermissionRequired to get apt value 
                     for Generic_Permission__c field for Account and Lead.                    
                     26-09-2019/ Satya Nalluri / US#44705 Added new method to return a map of recordtype Id and developer name
             16-10-2019/ Rajesh Potla / US#48270 - Added fields to query.
             24/10/2019 / Sri P/ US#48488 - Added country logic for fetchRetailerPointTableMetadata Method 
             28/10/2019 / Sri P/ US#49285 - Added fetchExternalAssetSourceConfiguration method to fetch External Asset Source Configuration  metadata records
             28/10/2019 / Rajesh Potla/ US#53692 - Added fetchExternalAssetSourceConfiguration method to fetch External Asset Source Configuration  metadata records
                      18/11/2019/ Rajesh Potla/ US#53691 New method to assign defalut account and points.
                  22/11/2019/ Souvik Dinda/ US#34462 New method to load configurations from BAT_EntryCodeCheckConfiguration__mdt into Map
                    02.12.2019/Souvik Dinda/US#57151- New method to load BAT_LeadBypassValidationRules__mdt into Map. Custom metadata stores
                    username of specific market to bypass Lead validation rules from Integration.
            03/12/2019/ Souvik Dinda /US#56983- New method to load configurations from BAT_CaseEmailActivityTrackingConfig__mdt into Map.
            06/12/2019/ Souvik Dinda/ US#47980 - Added method to delete account history when user has the appropriate permission set.
             10/12/2019/Osheen Sahajpal/CA: Sprint-2: US #64691: Updated method stampDateTimeOnConsentChange to make it work on record creation.
                      10/12/2019/ Rajesh Potla/ Us#60938 - Added setByPassFlagAccountEditValidation method to bypass account edit validation.
                     11 Dec,2019/Abhishek Kashyap/US-62135, CA - Admin Portal - Automatic Asset Creation   
            16.01.2020/Tejaswi Nissankula/ Added BAT_UserName__c field in query in getAccountSourceConfigDetails method bug #76248
            17/01/2020/Edwin Resendiz/ #74903 - Removed inner query to avoid SOQL rows limit.
            17/01/2020/Edwin Resendiz/ #74903 - Add Method getAssetsOfAccount
            17/01/2020/Edwin Resendiz/ #74903 - Add Method getMapAssetOfAccounts
            25 Feb,2020/Abhishek Kashyap/US-92258, DE | GLO- Asset is not getting created once the order state is complete in CRM.
            03 Mar, 2020/Abhishek Kashyap/BUG-93487, IT -IT VYPE US 91211 ENHUAT FAIL - Even if the Order Status is 'Complete' in SF ENHUAT, No 'Assets' are generated and Account 'Vape Status' is still 'Prospect'
            09/03/2020/ Rajesh Potla/ US#83887 : Added fetchGloFirstDeviceConfiguration method to load BAT_GloFirstDeviceExcludeConfiguration__mdt in Map.
            09/03/2020/ Rajesh Potla/ US#83887 : Changed getMapAssetOfAccounts method param from List<Account> to set<id> .
            @changeHistory: 10.03.2020 / Idrees Ali Jabalpurwala / US-93279, [All Market] Method to stamp consumer details on case 
            according to BAT_AccountToCaseMappingConfiguration__mdt
            24/03/2020/ Rajesh Potla/ US#95229 - Add Method fetchOriginatedByConfiguration.
            24/03/2020/ Rajesh Potla/ US#95229 - Add Method getAccByEvaluationDaysCriteria.
            27.03.2020/Edwin Resendiz/BUG#103546 - Modified and Added the logic for UK and Marketing Cloud
            24.04.2020/Tejaswi Nissankula/KZ:Glo: US#116546 - Added BAT_BrandAndStatus__c,BAT_Source__c fields in query in getLeadValidationBypassConfig method.
            27.04.2020/Tejaswi Nissankula/KZ:Glo: US#104691 - Added method "getBlackListEnabledCountryDetails"
            28.04.2020/Tejaswi Nissankula/KZ:Glo:US#104700 Added KZ check to populate brand on Asset in "createAsset" method
            28/04/2020/Souvik Dinda/ US#116614 - Populating Set of Model from the Model names mentioned against the records for model specific point system
            in BAT_RetailerPointTable__mdt.
            05/05/2020/Satya Nalluri/Bug#119774/Updated code in 'calculateTotalPointsOnRewardProfile' method to handle null pointer exception on total points value
            28/01/2020/ Souvik Dinda/ US#71390:Added email format check method for Email Verification
            28/01/2020/ Souvik Dinda/ US#71390:Added method to load BAT_EmailValidationConfiguration__mdt in Map.
            07.05.2020/Tejaswi Nissankula/NEA:US#124550:Added Pricebook2.Channel__c filter to make sure the query returns only 1:1 Portal 
            related pricebook entries.
            12.06.2020 / Tejaswi Nissankula /ID: Sprint 1:US#139252,139255 :Added min and max blank checks logic to cover the scenario when
            the markets requirment is just to validate the prefix formate of mobile but not min or max digits available after prefix(method : validateMobileFormatwrtCountry).  
            16.06.2020/Tejaswi Nissankula/US#139252- Created a new method getleadBypassAssignmentRuleConfig     
            21.05.2020 / Rajeev Arya /US #71365 : Added logic to check the difference between the verified and changed Email Address before saving record.
            29/06/2020/Tejaswi Nissankula/US#136698 : Added required anonymize fields on Account and related order for ID
            15.05.2020/ Souvik Dinda/ US#71379: Added logic to populate account record types for market which has only Email Verification enabled.
            21-07-2020/ Akshata Rajmane / ID: Sprint-4: US#226705 / added fields for indonesia
            25.06.2020/ Mallik Balla/ [PL] US#176027 : Updated the class to add methods - getLeadAccountBrandStatusMap - to get lead and account status maps, setLeadStatusField - to update the lead status fields   
            30/06/2020/ Dipika Gupta/ PL US#151577:Added method to Create Task for Lead.
            14.07.2020/ Mallik Balla/ [PL] Bug #217550 : Modified the if condition such that account fields for PL - will be updated only when the values coming from the integration eSC/Magento are blank.
            24.07.2020/Edwin Resendiz/Bug #225170 - Added first name and Last name billing to RO.
            25.08.2020/ Mallik Balla/ [PL] Bug Fix #268389  - Modified to set the key as accountID+:+brand
            10.08.2020/ Edwin Resendiz- Bug #226357- Added method to retrieve the markets that do not have case sustitution record page.
            25.08.2020/ Osheen Sahajpal /RO:Sprint-60:US #225174:Added supporting methods to return metadata records and related child records for account delete
            21-07-2020/ Akshata Rajmane / ID: Sprint-4: US#226705 / added fields for indonesia
            03-09-2020/ Souvik Dinda/ US #225174- Created a new method to change the order status to draft from activated orders and adding it to deletion list.
            08.10.2020 / Allada Yeshwanth / US#290427 - Modified validateMobileFormatwrtCountry method. Created new method fetchInternationalRec to fetch internation mobile validation rec. Moved the validation logic from if condition to separate method isPhnNotValid.
                                                        Modified the method getMobileFormatValidationDetails which fetches the metadata recs, moved the query to separate method getMobileFormatValidationDetailsRecs to make it reusable.Added checkbox field in the query.
            15.10.2020 / Allada Yeshwanth / CZ: Sprint 2: US#298152 - Added fields in query in method getEmailValidationConfig()
            22-Oct-2020/ Roopa N/ CZ: Sprint2: US#290314 - Added new field in query in method getDuplicateLeadsbyCountry()

            17.09.2020 - Anna Gomez(Deloitte) Bug#283098 - Bulkify setDefaultPrivacyDetailsConfig() method
             14-10-2020/ sandeep Joshi/ ZA:sprint 2:US #284782- Added  three fields of account in a new IF loop for anonamization requirement of SouthAfrica in a method anonymizeAccounts And 
                                                                added ZA country check(EQUALS) in OR condition in two existing if loop of method anonymizeRelatedOrders.
            17-10-2020/sandeep Joshi/ ZA:sprint 2:US#287199- Modified the If condition and added else part in method convertSubscriberToAccount  so it will skip the code in 'if block' 
            because Is_Lead_Preference__c(NEW  field created in  CsMd Lead Conversion Field Configuration) is TRUE and it is mandatory to copy lead field value to account during lead conversion.
            05/11/2020/ Sandeep Joshi/ US#318445 :Added method to load BAT_CaseOriginConfiguration__mdt  in Map.
            01.10.2020 - Anna Gomez(Deloitte) Bug#208156 - Updated validateMobileFormatwrtCountry() to add Mobile Number Format Error Message in English version
            05.10.2020/Saurabh Sharma/ Made changes to getPointConditionName for  US227850
            23.10.2020/Saurabh Sharma/ US227850 - in fetchRetailerPointTableMetadata Replaced BAT_Cluster__c to  BAT_ClusterName__c
            28.10.2020/Saurabh Sharma/US#287284- Created the method getGlobalFieldAnonymizeMapping and getLiveChatTranscriptAnonyConfig to get Anonimyzation 
                       configuration from meta
        10/08/2020/ Akshata Rajmane /FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes
            23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields 
            17.09.2020 - Anna Gomez(Deloitte) Bug#283098 - Bulkify setDefaultPrivacyDetailsConfig() method
            23.10.2020 / Allada Yeshwanth / Fixed the error message logic to work for all markets
            20th Nov-2020/Roopa N/ CZ: Bug #331468: Bypassing Email verified, Email Verification Status updation if Integration User updates email on Account/lead
            23.10.2020/Saurabh Sharma/ US227850 - in fetchRetailerPointTableMetadata Replaced BAT_Cluster__c to  BAT_ClusterName__c
            05.11.2020/Souvik Dinda/US#296128 - Added new fields in the getGloVypeCounterConfig() method : BAT_GloMGMPromotionalCodeFieldName__c and BAT_VypeMGMPromotionalCodeFieldName__c.
            * 27.11.2020/Nida Abshar Khan? US 314624, Added logic to get Data from Custom Metadata BAT_RestrictedProfile__mdt
            30.11.2020/Souvik Dinda/US#326287-Added logic to restrict account value with lead's value when there is a account source present in BAT_LeadConversionFieldConfiguration__mdt for the respective records.
            14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
            2nd Feb,2021 / Akshata Rajmane / US #386649 : GR - Admin Portal - Anonymise Account
            5th Feb,2021 / Akshata Rajmane / US#387269: Added field BAT_DefaultVuseAccount__c to query
             03.12.2020/ Anna Gomez/ Bug#340704: Removed isPLUser when update is allowed Verification enabled
             04.12.2020/Souvik Dinda/US#306018 - Added new fields related to Glo Order and Product details to be checked for evaluation.
             11-12-2020/ Kushagra Jain /Bug #353988:Updated deleteLeadPrivacySanpshots method to fix  ContentDocumentLink requires a filter by a single Id error
             13.01.2021/Rama Akella / US#357618 - Added condition to update Map based on profile names
            13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701:supporting methods for auto asset association with account
            14/01/2021/Idrees Ali/US#340701- Added External Session Id for anonymization
             16.01.2021/Souvik Dinda/US#346313 - Added logic to dynamically check the AccountSource and store in a set for
             25.01.2021/Dipika/BUG#386666 - Bypassed of restriction email change functionality for customer service CZ Users
            21.01.2021/Osheen Sahajpal/ENH: Sprint-71: SRB:US #217575:supporting methods for auto field update on objects
            22.02.2021 /Idrees Ali Jabalpurwala/US#308275 : Added setBypassOpportunityAssetValidationFlag
             28.02.2021/Rama Akella /US#357609-Added mobile number to country map to the sendMessage method in order to handle bulk reuqest and seperating the logic for UA and Other markets
            21.01.2021 || SK: 379339 || Allada Yeshwanth || added new method getCountriesBasedOnRegion and added region param to getUserDetails method
            21.01.2021||SK ||Allada Yeshwanth|| Pulled International error message from Label to enable the translation error message for all markets
            09.02.2021 || BUG: #407480 : Added string.isBlank check for email change error Message
            21.01.2021/Osheen Sahajpal/ENH: Sprint-71: SRB:US #217575:supporting methods for auto field update on objects
            22.02.2021 /Idrees Ali Jabalpurwala/US#308275 : Added setBypassOpportunityAssetValidationFlag   
            15.02.2021/ Akshata Rajmane/ US#390850 : GR - POS Agent - Reward Points calculation
            25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || modified verifyMobileNumberAndEmailChange method to work on rec'country instead of user's country as this is impacting cluster user.
            :11.03.2021/Akshata Rajmane/Bug#443536:Billing Address are not blank on the order after Account Anonymisation
            //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || modified verifyMobileNumberAndEmailChange method to work on rec'country instead of user's country as this is impacting cluster user.
            04.03.2021/Anna Gomez/Bug#431337: Added country filter when retrieving BAT_Utilities.getAssets()
            18th Feb,2021/Roopa N/RO:Sprint1: US#405873/ Created new method "getAccountLockUnlockConfig" to fetch records from "BAT_AccountLockUnlockConfiguration__mdt" metadata object
            25th Feb,2021 / Roopa N / US #405880 : RO - Admin Portal - Anonymise Account - Added required fields for RO Anonymization
            05.03.2021/Souvik Dinda/US#382068: Added BAT_Profile__c to getLeadValidationBypassConfig() SOQL query.
            17th March,2021/Abhishek Kashyap/BUG#449383-411752 - Issue with new account creation via CIAM Integration where same email already exists in SF, Updated verifyMobileNumberAndEmailChange
            22nd Mar,2021/Roopa N/RO - US#417298- Added logic to anonymize related Brand Profiles of accounts.
            26th Mar,2021/Roopa N/RO - Bug#461672 - anonymizing this field as part of global anonymization process for all markets
        2nd April,2021/Abhishek Kashyap/BUG-468283-412283 - Issue with account anonymize via Reverse Integration
        5th April,2021/Roopa N/RO: US#461730 - Anonymizing Web Email as well for RO Cases as part of RO anonymization process
    6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
            08.04.2021/ Allada Yeshwanth/ Created Method updateEmailAndPhone for BUG: #402351
            09.04.2021/Allada Yeshwanth / BUG:#402351 / Used static variable to prevent SOQL everytime getProfileName method is called.
            20.04.2021/Souvik Dinda/US#457163:Added BAT Read Only - ES for duplicate Asset scenario where asset created by BAT Read Only-ES can copied to Glo Store/POS Agent's asset.
            27.04.2021/ Allada Yeshwanth/ calling updateEmailAndPhone from anonimyzeAccounts method. And updated updateEmailandPhone method to update even blank values
            12.05.2021/Idrees Ali/US#505984 - Avalanche - Admin Portal - Anonymise Account
            26.04.2021/Souvik Dinda/US#494440: Introduced a new Map to store Country and Asset Sources from BAT_ExternalAssetSourceConfiguration__mdt for checking asset sources more than one for a market.
            21.05.2021/Souvik Dinda/US#451955-Modified fetchRetailerPointTableMetadata() method to accomodate records for Point value 0 for all the markets.
            04.06.2021/Souvik Dinda/US#527351 - Global method to get person contact details for CampaignMember contactId.
            18.06.2021/Souvik Dinda/ US#487564 - Created one method to return list of Task based on the values to be set mentioned in the BAT_CaseTaskCreationConfiguration__mdt.
            18.06.2021/Anna Gomez/Bug#563880/UserTriggerHandler optimization to avoid SOQL101
            08.jul.2021 || ENH || US: # 537698 || Allada Yeshwanth || blanked personOtherPhone for PL if mobile is blank
            //US: #537702 || Allada Yeshwanth || ENH : Sprint 83 || bypassing Mobile and email change check for PL Hostess
            12 July 2021- Dipika Gupta- US 555967 If country is spain and brand is not blank, point condition is created with brand
            13.07.2021/Idrees Ali/Sprint-82: US #443357:Lead Conversion - Mark Consent Fields as Opt Out once Lead is Converted and Account is created
            28 July 2021- Dipika Gupta- 604136 Sprint-84: Added method to create apex log record
            30.07.2021 /Dipika Gupta/US#541023 : Added setBypassOpportunityAssetMandateValidationFlag
            18.08.2021/ Allada Yeshwanth / US: #540266 || Created the method to fetch BAT_ExternalCustomerIdMapping__mtd records
            29.09.2021/Idrees Ali/MY-Vuse:US#739516 - Added Blank check to prevent 'Argument cannot be Null' error
            US: #708711 // Allada Yeshwanth // add ed methods for lead conversion reward points {createRewardProfilePointsForLeads,getLeadRewardPointConfigMtd}
            US: #708320 // Allada Yeshwanth // Added funcaionality to fetch lead record Id "New"
            //14-10-2021/Osheen Sahajpal/ ENH: Sprint-89: US#733171 - Adding code to update qualtrics workflow inflight flag and Non Subscription Order date for UK
            21.10.2021/Idrees Ali/MY-Vuse:US#738037 - Rectified duplicate if checks in 'stampDateTimeOnConsentChange' method
            21.10.2021/Rama Akella/Bug#773419- createRewardProfilePointsForLeads - Optimized code by passing List<Account> as parameter instead of Map<rewardProfileId,List<Lead>>
            11.11.2021/Rama Akella/US#794776: UK - lastOrderDateUpdate - Brand check to run the logic only for Vype/Vuse
            25.11.2021 / Allada Yeshwanth / ENH : US: #741230 / Bypass duplicate error for IT_ES_GR if the Asset status is obsolete
            13.12.2021/ Allada Yeshwanth /ENH:Sprint-94:ZA #823193 / passed new purpose parameter to fetch global field update metadata
            14.02.2021/Idrees Ali Jabalpurwala/US#756326- Optimised 'caseFieldUpdateBasedOnMappingmethod'
            28.01.2022 - Idrees Ali - Added Contact.BAT_Profile__c as part of US#726674
            09.02.2022/Rajeswari Nidamanuri/added PT country under verifyMobileNumberAndEmailChange as part of US#890256
            16.02.2022/Rajeswari Nidamanuri/US #893452 - PT Glo - Admin Portal - Anonymise Account
            19.04.2022/Idrees Ali/ENH-CA: US#821197 - Added CA check for VUSE_ITCAN consent field to allow consent date to be updated for both create and update when value is TRUE
            14-4-2022/ Praveen / US #844762/ PL - First device logic change/ Added the country set to check whether to consider brands for first device logic
            03.06.2022/ Debasis Maharana /Bug#1016791 / Added extra validation for 'Member_get_Member_Promotional_Code__c' to avoide null pointer exception
            30-06-2022/Rajeswari/ US #1029822 / CH-CH - Admin Portal - Anonymise Account/Added country checks and created contactPointTypeConsent method to anonymize consents
            22-07-2022/Sonal Srivastava/ US #1076739 / CH - Admin Portal - Anonymisation of Individual (Track customer consent) record along with account
            26.07.2022/Rama Akella/ Bug#1078354:fetchRetailerPointTableMetadata - Made the method parameterized with countrySet to optimize the code
            02.08.2022/Rama Akella/Bug#1078354:fetchRetailerPointTableMetadata - Updated the query to retrieve 'Global' metadata along with the market metadata
            10.08.2022/Anna Gomez/ENH-IT: US#1068152 - Added logic to allow Consent Date field update to null
            //31Aug/Turbasu Ghosh/US#1028107 :Global: All Markets: To include Synchronisation field on Lead to synchronise data correctly on Marketing Cloud
            09.06.2022/Idrees Ali/ ENH - Sprint 113 - US#1119472:CZ & SK - VELO Acclimatization- added new method 'concatenateBrandHouseForIntegration'
            14.09.2022/ Debasis Maharana / BUG#1104167 Optimize the code so that it improves the performance and it avoids the Apex CPU time exception.
            15.09.2022/samekala@deloitte.com/Bug#1134232 Sharing the Access to Tobacconist When the record is created by BAT Glo Corner -IT profile
            09.06.2022/Idrees Ali/ ENH - Sprint 113 - US#1119472:CZ & SK - VELO Acclimatization- added new method 'concatenateBrandHouseForIntegration'
            //08/09/2022/ Chetan Patil/ US#1121760 - Added  fields  for Slovenia anonymization (SI)
            11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method
            26..9.2022 /US #1105804/Global - Privacy Snapshot creation for Account
            21.10.2022/Idrees Ali/US-1070693-Created the method 'callReverseAPIForsObjectRecords'
            14.11.2022/ Idrees Ali /ENH:Sprint-118:SEA:US #1139217- SEA (IT) Admin - Flexible reward scheme management- created method 'fetchConditionNameOnTheBasisOfCouponCode'
            15.07.2022/Sameer Ranjan / US #1035808 - CZ - MultiCategory - Account anonymisation on Salesforce
            19.12.2022/Rahul Upadhyay/ ENH: Sprint 120 : US#1199173 - Brand House field population/update - created getAccountBrandHouseAssignDetails and getLeadBrandHouseAssignDetails method
            04/01/2023- Bug#1207453- Debasis Maharana - The code was restructured to resolve the Apex CPU time limit being exceeded.
            12-Nov-2022/Mangesh/US #1133000 : generateCSVBlob method is created to generate CSV files
            07 Apr 2022/ Praveen/ US # 897350 / Added a missed boolean check for BAT_FieldType__c
            5.1.2023/Chetan Patil || Bug#1225538 || Fixed the Apex exception that prevented us from performing an operation on an inactive user.
            18.01.2023/Swaraj Ray/ #1142557 - ZA - Data Archival Process/ Created method to create dynamic queries for all the objects
            //12/02/2022/ Hariharan Pillai/ Bug #1297646 - Added custom PersonMobilePhone__c field to be anonymized
            //24 Jan 2023: ENH: #1278719: adding new field in the query BAT_NotRequiredInBatch__c
           30.01.2023/Swaraj Ray/ BAT#1257012 - Updated the method to have custom validation for the new Segments values
           22.02.2023/Rahul Upadhyay/ BAT#1217511 - Created method: getNewsLetterSubscriberLeadRecordTypeId
           03.07.2023/Rahul Upadhyay/ENH: Sprint-125: US #1188291: Created method: getQueueConfigsLiveChat
            07.03.2023/Swaraj Ray/ #861816 - SE - Salesforce Data Retention Policy - Cases/ Created method to create dynamic queries for all the objects
            15.03.2023/Idrees Ali/ENH: Sprint-125: US #1317478: Created the method 'intiateReverseApiFromBatchV2'
            24.03.2023/Idrees Ali/ENH: Sprint-126:  [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM - Added Methods
            09.05.2023/ Debasis Maharana / BUG#1370423 / Update was not happening because asset id was not assigned before asset update.
            09.05.2023 / Debasis Maharana / BUG#1370422 || Fixed exception- Attempt to de-reference a null object
            //15/05/2023/ Chirag Kalra / US #1345992 : Added Field to Anonymize for FR
            19.05.2023/Chirag Kalra / ENH - Sprint 130 - US#1131916:ZA || Duplicate Records in CRM
            22.12.2023/ShanmugaPriyan/US: #1591514- IT GLO | Asset update from Sharpend
            02/01/2024/Shanmuga/US#1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account
            28.02.2024/Varaprasad Sada/US#1637513-RS HR SI - Multicategory consents update + profiling consent (CRM Only)
            09.July.2024/varaprasad sada / US#1771605-SE - Salesforce Data Retention Policy - Account (part2)
******************************************************************************************/ 
public without sharing class BAT_Utilities {

    // Variable only true when logic call from account trigger
    public static Boolean callFromAccountTrigger = false;
    // Variable only true when account last modified source would eCommerce
    private static Boolean isAccountLastModifiedSourceECommerce = false;

    /*Starts 2636- Added by Prince on Oct 25th,2018 for US#:2636 */
    private static final String consumerStr = BAT_ConstantsUtility.CONSUMER_STR; 
    private static final String soldStr =  BAT_ConstantsUtility.ASSET_TYPE_SOLD; 
    private static final String ownStoreStr = BAT_ConstantsUtility.OWN_STORE_STR;
    private static final String UnitedKindomStr = BAT_ConstantsUtility.UnitedKindom_STR;
    private static final String UKStr = BAT_ConstantsUtility.UK_STR;
    private static Id contextUserId = UserInfo.getUserId(); 
    private static boolean skipTriggerRun = false;
    public static String jsonmappingvalue='';
    public static set<string> profileNameSetForNEAPortal = new set<string>();
    //for US#11035
    public static Map < String, String > pointValueMap = new Map < String, String > ();
    //public static Map<String,List<BAT_RetailerPointTable__mdt>> mapOfConditionToRecords = 
       // new Map<String,List<BAT_RetailerPointTable__mdt>>();
        
         public static Map<String,List<BAT_RetailerPointDirectory__c>> mapOfConditionToRecords = 
        new Map<String,List<BAT_RetailerPointDirectory__c>>();// BAT_RetailerPointDirectory__c // BAT_RetailerPointTable__mdt
        
        
    //Set of Model names to make the Point System specific to Models dynamic
    public static Set<String> modelNameSet = new Set<String>();
    //mobileFormatCountryMap will get the data from method validateMobileFormatwrtCountry and used it in verifyMobileNumberChange method 
    public static Map<string,BAT_MobileFormatValidationConfiguration__mdt> mobileFormatCountryMap = new Map<string,BAT_MobileFormatValidationConfiguration__mdt>();
    //Map to load EmailValidationConfiguration metadata
    public static Map<string,BAT_EmailValidationConfiguration__mdt> emailValidationConfigMap = new Map<string,BAT_EmailValidationConfiguration__mdt>();
    /*Ends 2636- Added by Prince on Oct 25th,2018 for US#:2636 */
    //Get instance from INSTANCE.visual.force.com page so we can build
    //US#93279 Added by Idrees Ali
    public static Set<Id> recordTypeSet = new Set<Id>();
  //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Added this to store the brand to status field value map for Lead and Account
  public static Map<String,BAT_LeadAccountBrandToStatusFieldValue__mdt> brandToStatusFieldAndValueMap;
    public static AssetAssociationConditionsWrapper assetAssociateWrap = new AssetAssociationConditionsWrapper();
    //Set of Account Source names to check for assigning points
    public static Set<String> accSourceNameSet = new Set<String>();
    public static GlobalFieldUpdateWrapper globalFieldUpdateWrap = new GlobalFieldUpdateWrapper();
    public static string userProfileName = getProfileName(); //09.04.2021/Allada Yeshwanth / BUG:#402351 / Used static variable to prevent SOWL everytime this method is called.
    //19.04.2021/Souvik Dinda/US#457163-Allow tobacconist to register assets created by "BAT Read-Only - ES" profile users
    public static Map<String, Set<String>> assetSourceProfileNameMap = new Map<String, Set<String>>();
    //20th April, 2021/Abhishek Kashyap/US-225171-created global user object
    public static User loggedInUserObject;
    //Created a static Map to store country vs Asset Sources to bypass in External Asset Source
    public static Map<String, Set<String>> entryCodeCheckAssetSourceMap = new Map<String, Set<String>>();
    //18.06.2021/Anna Gomez/Bug#563880/UserTriggerHandler optimization to avoid SOQL101
    public static Map<Id,Profile> profileNameMap;
    public static Map<String,List<BAT_GlobalAnonymisationMapping__mdt>> globalAnonymisationMap = new Map<String,List<BAT_GlobalAnonymisationMapping__mdt>>();
    public static Id NewLeadRecordTypeId; // US: #708320 // TO store the Lead Record Type ID "New"
     //1703189-DE - multicategory Loyalty program - Anonymisation starts--
    public static Map<String,List<BAT_BrandProfileAnonymization__mdt>> brandprofileAnonymisationMap = new Map<String,List<BAT_BrandProfileAnonymization__mdt>>();
     //1703189-DE - multicategory Loyalty program - Anonymisation ends--
    public static Id NewsletterSubscriberLeadRecordTypeId; // US: #1217511 // TO store the Lead Record Type ID "Newsletter Subscriber"
    public static Id retailerRecordTypeId;// US: #530277 // To fetch Account's Retailer Record Type Id 
    public static marketingCloudMetadataWrapper marketingCloudWrapper = new marketingCloudMetadataWrapper();
    public static Set<String> couponCodeSet = new Set<String>();
    //public static Map<String,List<BAT_RetailerPointTable__mdt>> mapOfCouponCodeConditions = new Map<String,List<BAT_RetailerPointTable__mdt>>();
    public static Map<String,List<BAT_RetailerPointDirectory__c>> mapOfCouponCodeConditions = new Map<String,List<BAT_RetailerPointDirectory__c>>();
    
    
    public static Map<String,String> couponCodePicklistValuesMap = new Map<String,String>() ;

    //Bug#1207453- Debasis Maharana - Created these variables to hold the value for different object field types.
    static Map <String, Schema.SObjectField> accountMapfields = NULL;
    static Map <String, Schema.SObjectField> assetMapfields = NULL;
    static Map <String, Schema.SObjectField> caseMapfields = NULL;
    static Map <String, Schema.SObjectField> leadMapfields = NULL;
      //12.12.2022/himaBindu / Created the method as part of US#1080293 - UK customer care - Customer Care Skill Based Routing
    public static emailToCaseConfigWrapper email2CaseWrapper = new emailToCaseConfigWrapper();
    
    //15.03.2023/Idrees Ali/ENH: Sprint-125: US #1317478: Created the method 'intiateReverseApiFromBatchV2'
    public static List<BAT_Integration_Log_DE__c> batchContextIntegrationLogList = new List<BAT_Integration_Log_DE__c>();
    //28.04.2023/Idrees Ali// US: #859464 // Wrapper class declaration for SE Account Data retention
    public static privacySnapshotDeletionWrapper snapshotWrapper = new privacySnapshotDeletionWrapper(); 
    //05.11.2023 /Reema Meher- [CZ] US#1454597-UA - CZ - multicategory loyalty program - CRM & M2
    //public static RecordType directConsumerRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Direct_Consumer' Limit 1];
    /********************************************************************************************************
    @ author:          Deloitte  
    @ method:          getcityfromUserRoleName 
    @ returns:         String
    @ params:          string roleName, String country
    * @description:    This method returns the Userrole City
    * @changeHistory:  Added by Usha - Added Header Comments
    *********************************************************************************************************/
    public static string getcityfromUserRoleName(string roleName, String country){
        // store user city.
        String userCity;
        userCity = roleName.substringAfter(BAT_ConstantsUtility.STR_CHAR_HYPHEN);
        if(roleName.containsIgnoreCase(BAT_ConstantsUtility.AREA_MANGER)){ 
            userCity = BAT_ConstantsUtility.AM + userCity;                                                
        }
        // if its UA/AZ team Leader then feching the number from it. and amend to usercity.
        if(country == BAT_ConstantsUtility.COUNTRY_UA ||country == BAT_ConstantsUtility.COUNTRY_AZ ){
            // To store number from role
            String teamRolePersonNumber ;
            // get the string after Hyphen in role
            String beforeCityRole = roleName.substringBefore(BAT_ConstantsUtility.STR_CHAR_HYPHEN);
           if(String.isNotBlank(beforeCityRole)){
               // get the number string from team person
             teamRolePersonNumber = beforeCityRole.substringAfter(BAT_ConstantsUtility.USER_ROLE_TEAM_PERSON);
             if(String.isBlank(teamRolePersonNumber)){
                 // get the number from team lead.
                teamRolePersonNumber = beforeCityRole.substringAfter(BAT_ConstantsUtility.USER_ROLE_TEAM_LEAD); 
              }
           }
            userCity = teamRolePersonNumber + userCity;
        }
        
        userCity = string.isNotBlank(userCity)?userCity.remove(BAT_ConstantsUtility.SINGLE_SPACE):'';
        
        return  userCity; 
    }
  
  
  /***********************************************************************************************************
        @ author:          ITC Infotech  
        @ method:          getDirectConsumerRecordType 
        @ returns:         Id
        @ params:          
        * @description:    Methods to get Direct Consumer RecordTypeId
        * @changeHistory: 05.11.2023 /Reema Meher- [CZ] US#1454597-UA - CZ - multicategory loyalty program - CRM & M2
    *********************************************************************************************************/
    public static RecordType directConsumerRecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Direct_Consumer' Limit 1];
    
    public static RecordType getDirectConsumerRecordType() {
        return directConsumerRecordType;
    }
    /***********************************************************************************************************
    @ author:          Deloitte  
    @ method:          getInstance 
    @ returns:         String
    @ params:          
    * @description:    [All Markets]Method to Get instance 
    * @changeHistory:  Added by Usha - Added Header Comments
    *********************************************************************************************************/ 
    public Static String getInstance(){
        String instance = '';
        Organization o = [SELECT OrganizationType, InstanceName FROM Organization limit 1];
        String orgType = o.OrganizationType;
        String insName = o.InstanceName;
        if(orgType == 'Developer Edition' || insName.startsWithIgnoreCase('cs')){
            List<String> parts = ApexPages.currentPage().getHeaders().get('Host').split('\\.');
            instance = parts[parts.size() - 4] + '.';
        }
        return instance;
    }
    /***********************************************************************************************************
        @ author:          Deloitte  
        @ method:          getSubdomainPrefix 
        @ returns:         String
        @ params:          
        * @description:    Methods to get instance name and domain prefix from Organization.
        * @changeHistory:  Added by Usha - Added Header Comments
    *********************************************************************************************************/
    //Needed in cases if current org is sandbox
    public static String getSubdomainPrefix(){
        Organization o = [SELECT OrganizationType, InstanceName FROM Organization limit 1];
        String orgType = o.OrganizationType;
        String insName = o.InstanceName;
        if(insName.startsWithIgnoreCase('cs')){
            return UserInfo.getUserName().substringAfterLast('.')+ '-';
        }
        return '';
    }
    /***********************************************************************************************************
        @ author:          Deloitte  
        @ method:          isIntegrationUser 
        @ returns:         Boolean
        @ params:          User
        * @description:    Methods to check the integration user
        * @changeHistory:  Added by Usha - Added Header Comments
    *********************************************************************************************************/
    public static Boolean isIntegrationUser(User currentUser){
        return currentUser!=null && currentUser.Name!=null?currentUser.Name.toUpperCase().contains(BAT_ConstantsUtility.INTEGRATION_USER_UPPER_CASE):false;
    }
    /***********************************************************************************************************
        @ author:          Deloitte  
        @ method:          getAssets 
        @ returns:         Map<String,Asset>
        @ params:          Set<String>
        * @description:    Methods to fetch the Assets
        * @changeHistory:  Added by Usha - Added Header Comments
                        :  US#48270 - Added query fields.
                        :  23.07.2020 - Anna Gomez - Bug#171971: Added query fields - Account.FirstName,Account.LastName 
                        : 04.03.2020 - Anna Gomez - Bug#431337: Added country filter when retrieving duplicate assets
                        : 04.03.2020 - Dipika Gupta - Bug#400551: Added query fields - Asset_Owner_First_Name__c,Asset_Owner_Last_Name__c
                        : 20.04.2021 - Souvik Dinda-US#457163: Added Owner_Profile__c to the query for checking asset's created profile.
                        : 25.11.2021 / Allada Yeshwanth / ENH : US: #741230 / Bypass duplicate error for IT_ES_GR if the Asset status is obsolete
    *********************************************************************************************************/
    //2515 NL: Duplicate asset check, currently referred in AssetTrigggerHandler and SubmitOrderController classes
        public static  Map<String,Asset> getAssets(Set<String> deviceNumbers, Set<String> countries){
        
        Map<String,Asset> codeAssetMap=new Map<String,Asset>();
        // 25.11.2021 / Allada Yeshwanth / ENH : US: #741230 / Bypass duplicate error for IT_ES_GR if the Asset status is obsolete
        Set<String> bypassAssetDupErrorCountrySet = new Set<String>();
        bypassAssetDupErrorCountrySet.addAll(getCountrySetToBypassObsoleteAsset());
        if(!deviceNumbers.isEmpty()){
            //US#48270 - Added query fields.
            //US#489103 - Added query field - BAT_OtherRegistrationChannel__c
            // Added query field - BAT_ThirdPartyRetailer__c -//US#1591514-IT GLO | Asset update from Sharpend
            for(Asset a : [SELECT Name,ID,Country__c,NewDevice__c,AccountId,Account.Name,Status,Type__c,Colour__c,Owner.name,
                            BAT_Model__c,PurchaseDate,BAT_AssetSource__c,Selling_Reward_Profile__c,Account.FirstName,
                            Account.LastName,Asset_Owner_First_Name__c,Asset_Owner_Last_Name__c, Owner_Profile__c, BAT_OtherRegistrationChannel__c,BAT_ThirdPartyRetailer__c  FROM Asset where name IN :deviceNumbers AND Country__c IN: countries LIMIT 50000]){
                //VSTS4750 , Fix for name consider upper / lower case letters so you can enter, eg. , 2 devices with "ABC" and "abc.
                //ENH : US: #741230 / BYpassed duplicate asset error for IT-ES-GR when exsiting asset status is obsolete.
                if(bypassAssetDupErrorCountrySet.contains(a.Country__c)){
                    if(!a.Status.equalsIgnoreCase(BAT_ConstantsUtility.BAT_ASSETSTATUSOBSOLETE)){
                        codeAssetMap.put(a.Name.toUppercase(),a);
                    }
                }
                else{
                    codeAssetMap.put(a.Name.toUppercase(),a);
                }
            }
            
        }
        
        return codeAssetMap;
        
    }

    /***********************************************************************************************************
        @ author:          Deloitte  
        @ method:          fetchDefaultSerialNumber 
        @ returns:         List<DefaultAssetSerialNumber__mdt>
        @ params:          String countryStr
        * @description:    Methods to fetch Default Serial Number
        * @changeHistory:  Added by Usha - Added Header Comments
    *********************************************************************************************************/
    //Added by Prince on Nov3th, 2018 for US#4879
    public static List<DefaultAssetSerialNumber__mdt> fetchDefaultSerialNumber(String countryStr) {
        List<DefaultAssetSerialNumber__mdt> defaultSnList = [SELECT ID,MasterLabel,DeveloperName,BAT_FieldToUpdate__c FROM DefaultAssetSerialNumber__mdt 
                                                             WHERE DeveloperName=:countryStr limit 1];
        return defaultSnList;
    }

 /*********************************************************************************
    @Author       : Deloitte
    @Method       : sendMessage
    @Returns      : Void
    @Params       : Map<string,String> .
    @Description  : this method to send SMS and insert error logs.
    @ChangeHistory: 03/25/2019 - created new Method.
                    11.06.2019 / Rajesh Potla /US#26200 - Implemented Deduplication logic
                    28.02.2021/Rama Akella /US#357609-Added map to the method in order to get mobile number with country in order to handle bulk reuqest and sperating the logic for UA and Other markets
*******************************************************************************/ 
    @future(callout = true)
    public static void sendMessage(Map<string,String> sendmessageMap,Map<String,String> fromAddress, Map<String,String> mobileNumberCountryMap){
        List<Apex_Log__c> apexLogs = new List<Apex_Log__c>();
        String deDuplicationId = generateRandomNumber(BAT_ConstantsUtility.Six_Digit_Random_Number);
        //US#357609-Added map to the method in order to get mobile number with country in order to handle bulk reuqest and sperating the logic for UA and Other markets
        Map<string,String> responseMap = BAT_IntegrationUtility.sendMessage(sendmessageMap,fromAddress,deDuplicationId,mobileNumberCountryMap);
        for(String phoneNum: responseMap.keySet()){
            if(responseMap.containsKey(phoneNum) && responseMap.get(phoneNum).containsIgnoreCase(BAT_ConstantsUtility.SMS_FAILED)){
                Apex_Log__c apexlog = new Apex_Log__c();
                apexlog.Class_Name__c = BAT_ConstantsUtility.REWARPROFILE_TRIGGERHANDLER_CLASS;
                apexlog.Method_Name__c = BAT_ConstantsUtility.SEND_MESSAGE_METHOD;
                apexlog.Exception__c  = BAT_ConstantsUtility.PHONE_NUMBER+phoneNum+BAT_ConstantsUtility.BLANK+BAT_ConstantsUtility.ERROR_STATUS+responseMap.get(phoneNum);
                apexLogs.add(apexlog);
            }
            
        }
        if(!apexlogs.isEmpty()){
            Insert apexlogs;
        }
        
    }
    /***********************************************************************************************************
    @ author:          Deloitte  
    @ method:          getCurrentUserDateTime 
    @ returns:         void
    * @description:    Methods to get Proper Time Based on Current User for Asset Name
    * @changeHistory:  Added by Kushagra - Added Header Comments
                        05.11.2019 Added by Kushagra- Enhancement:##54886 
    *********************************************************************************************************/ 
    public static DateTime getCurrentUserDateTime(){ 
        Datetime now = System.now(); 
        Integer offset = UserInfo.getTimezone().getOffset(now); 
        Datetime local = now.addSeconds(offset/1000);
        return local;
    }   
    /***********************************************************************************************************
    @ author:          Deloitte  
    @ method:          getCountrySpecificRange 
    @ returns:         Map<String,BAT_RangeFieldConfiguration__mdt>
    @ params:          
    * @description:    Methods to fetch country specific range value
    * @changeHistory:  Added by Kushagra - Added Header Comments
                        07.11.2019 Added by Kushagra - US:#54886 Created for MX Enhancements.
                        March9th,2020/Prince Chawla/BUG-97185 - To resolve Too Many SOQL - Added userObj Param and removed additonal User query.
    *********************************************************************************************************/ 
    public static Map<String,BAT_RangeFieldConfiguration__mdt> getCountrySpecificRange(User userObj){
      
            Map<String, BAT_RangeFieldConfiguration__mdt> rangetoMtdMap = new Map <String, BAT_RangeFieldConfiguration__mdt>();
            for(BAT_RangeFieldConfiguration__mdt rangeFieldMtd : [Select masterLabel, BAT_Range__c, BAT_FieldToUpdate__c,
                                                                          BAT_Value__c from BAT_RangeFieldConfiguration__mdt
                                                                          where masterLabel = : userObj.Country__c]){
               rangetoMtdMap.put(rangeFieldMtd.BAT_Range__c.toLowerCase(), rangeFieldMtd);
             }
        return rangetoMtdMap;
    }   
    /***********************************************************************************************************
    @ author:          Deloitte  
    @ method:          createAsset 
    @ returns:         void
    @ params:          Account accrec , String color
    * @description:    Methods to fetch create Asset
    * @changeHistory:  Added by Usha - Added Header Comments
                        31.10.2018 Added by Prince - US:#3262 Created for own store portal.
                        March9th,2020/Prince Chawla/BUG-97185 -To resolve Too Many SOQL - Added contextUser Param.     
    *********************************************************************************************************/ 
    public static void createAsset(Account accrec , String color){ 
        List<Product2> prodUKList = [SELECT ID,Family,Name,Device_Colour__c,External_SKU__c FROM Product2 where Country__c =:UKStr limit 1];
        //Create new Asset with each 'Direct Consumer' Account coming up.
        Product2 prod= !prodUKList.isEmpty()? prodUKList.get(0): null; 
        Asset newAst = createAsset(accrec.Id, UKStr, prod, '', UKStr, true, BAT_Utilities.getUserDetails());
        newAst.Colour__c = color; 
        insert newAst;
    }   
    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createAsset
    * @returns       : Asset
    * @params        : Id accId, String countryStr, Product2 prod, String deviceNum, String marketStr, boolean isFirstDevice
    * @description   : This method is to create asset
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
                       04/07/2019/Osheen Sahajpal/Updated asset creation to accomodate NEA fields
                       05/09/2019/Osheen Sahajpal/Updated to add brand mapping for MX users
                       11 Dec,2019/Abhishek Kashyap/US-62135, CA - Admin Portal - Automatic Asset Creation  
                       03 Mar, 2020/Abhishek Kashyap/BUG-93487, IT - VYPE US 91211 ENHUAT FAIL - Even if the Order Status is 'Complete' in SF ENHUAT, No 'Assets' are generated and Account 'Vape Status' is still 'Prospect'
                       March9th,2020/Prince Chawla/BUG-97185 -To resolve Too Many SOQL - Added contextUser Param.
                       28.04.2020/Tejaswi Nissankula/KZ:Glo:US#104700 Added KZ check to populate brand on Asset
                       08.12.2020/Souvik Dinda/US#337607-Added country check for DK so that Vuse devices can be created with Brand.
    *********************************************************************************************************/ 

    public static Asset createAsset(Id accId, String countryStr, Product2 prod, String deviceNum, String marketStr, boolean isFirstDevice, User contextUser){
        List<DefaultAssetSerialNumber__mdt> defaultSnList = fetchDefaultSerialNumber(countryStr);
        //NEA Sprint-3: US#25775 Variable used to check if asset is for NEA
        Boolean isNeaAsset = false;
        //NEA Sprint-3: US#25775 Variable checked to true if Country is DK, NL or SE
        if(countryStr.equalsIgnoreCase(BAT_ConstantsUtility.DK_STR) || 
           countryStr.equalsIgnoreCase(BAT_ConstantsUtility.SE_STR) || 
           countryStr.equalsIgnoreCase(BAT_ConstantsUtility.NL_STR)){
            isNeaAsset = true;
        }
        //End
        Asset newDevice = new Asset();             
        if(prod!=null && accId!=null){
            //NEA Sprint-3: US#25775 made fields common for other countries and UK except NEA
            if(!isNeaAsset){
                newDevice.newDevice__c = true;
            }
            //End
            newDevice.Colour__c = prod.Device_Colour__c; // NEA BugFix:#33850-Added colour mapping for NEA Assets too
            newDevice.AccountId = accId;
            newDevice.Product2Id = prod.Id;
            newDevice.Status = BAT_ConstantsUtility.ACTIVE_STR;
            newDevice.First_Device__c = isFirstDevice; //updated for Bug Fix 5234
            newDevice.ownerId = contextUserId;
            newDevice.Country__c = countryStr;
            //Adding extra fields for UK.
            //NEA Sprint-3: US#25775 Adding extra fields for NEA
            if(marketStr.equalsIgnoreCase(UKStr) || isNeaAsset || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ)){
                if(marketStr.equalsIgnoreCase(UKStr)){
                    newDevice.ConsumablesBought__c ='1';
                }
                newDevice.Type__c = BAT_ConstantsUtility.ASSET_TYPE_SOLD;
                newDevice.PurchaseDate = System.today();
            }
            //05-09-2019/Osheen Sahajpal/MX: US #37031-Mapping Brand field to Vype for only MX users
            //11 Dec,2019/Abhishek Kashyap/US-62135, CA, Added condition to populate Brand on Asset
            //25 Feb,2020/Abhishek Kashyap/US-92258, DE | Added condition of DE to populate brand on Asset
            //03 Mar, 2020/Abhishek Kashyap/BUG-93487, IT - Added condition of IT to populate brand on Asset
            //15th June, 2020/Tanmoy Bardhan/US-1047360 , CZ - Added condition of CZ to populate brand on Asset
            if((marketStr.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MX_STR) || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CA_STR) || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.DE_STR) || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT) || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) 
               || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.DK_STR) || marketStr.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ)) && String.isNotBlank(prod.Brand__c)){
                newDevice.BAT_Brand__c = prod.Brand__c;
                //Added as part of MX Enhancement #54886 : Assign ePod Product to Model
                //March9th,2020/Prince Chawla/BUG-97185 - To resolve Too Many SOQL - Added contextUser and passed it to getCountrySpecificRange method.
                Map<String, BAT_RangeFieldConfiguration__mdt> rangetoMtdMap = BAT_Utilities.getCountrySpecificRange(contextUser);
                //Convert the Range value to the lowercase in the source and destination while checking in the map as per MX Enhancement #54886.
                 //08-01-2020/Abhishek Kashyap/Moved rangeLowerCaseStr inside if block to prevent null exceptions.
                if(String.isNotBlank(prod.Range__c) && rangetoMtdMap.containsKey(prod.Range__c.toLowerCase())){
                    String rangeLowerCaseStr = prod.Range__c.toLowerCase();
                    newDevice.put(rangetoMtdMap.get(rangeLowerCaseStr).BAT_FieldToUpdate__c,rangetoMtdMap.get(rangeLowerCaseStr).BAT_Value__c);
                }
            }
            if(!defaultSnList.isEmpty()){
                if(!String.isBlank(deviceNum)){
                    //VSTS -6095-Asset/device number issue
                    newDevice.Name =deviceNum;
                }
                //Added for UK US#15120 - To populate Product's field in the AssetName(coming from the  DefaultAssetSerialNumber__mdt metaData)
                else if(String.isNotBlank(defaultSnList.get(0).BAT_FieldToUpdate__c)){
                    Schema.sObjectType entityType = prod.Id.getSObjectType();
                    String entityTypeStr = String.valueOf(entityType);
                    Boolean doesFieldExist = doesFieldExist(entityTypeStr, defaultSnList.get(0).BAT_FieldToUpdate__c);
                    if(doesFieldExist){
                    // Added UserLocale time for Asset Name as part of Mx Enhancement:54886
                        String assetName = String.valueOf(prod.get(defaultSnList.get(0).BAT_FieldToUpdate__c)) + BAT_Utilities.getCurrentUserDateTime() ;
                        newDevice.put('Name', assetName);
                    }
                }
                else{
                //  Added UserLocale time for Asset Name as part of Mx Enhancement:54886
                    newDevice.Name = defaultSnList.get(0).MasterLabel + prod.External_SKU__c+'-'+BAT_Utilities.getCurrentUserDateTime(); 
                }
            }
            else{
            // Added UserLocale time for Asset Name as part of Mx Enhancement:54886
                //VSTS -6095-Asset/device number issue
                newDevice.Name=(String.isNotBlank(deviceNum)?deviceNum:prod.External_SKU__c+'-'+BAT_Utilities.getCurrentUserDateTime());
            }
        }
        return newDevice; 
    }

    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createLog
    * @returns       : Void
    * @params        : Exception ex,String className, String methodName
    * @description   : This method is to insert exception logs
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
    *********************************************************************************************************/ 
    public static void createLog(Exception ex,String className, String methodName){
         Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = className, Exception__c =ex.getStackTraceString()+'\n'+ex.getMessage()+'\n'+ex.getCause(), Method_Name__c = methodName);
         insert apexLog;
    }

    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getProfileName
    * @returns       : String
    * @params        :
    * @description   : To get Profile Name of the User
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
    *********************************************************************************************************/ 

    public static String getProfileName(){
         String profileName =BAT_ConstantsUtility.SINGLE_SPACE;
       list<profile> currentUserProfile = [SELECT Name 
                              FROM Profile 
                              WHERE id=: UserInfo.getProfileId() limit 1];
        if(!currentUserProfile.isEmpty())
           profileName = currentUserProfile[0].name;                         
        return profileName;
    }
    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getNextWorkingDate
    * @returns       : Date
    * @params        : Date workingDate
    * @description   : Build a generic method, To get next working day, skipping the weekends and Holidays.
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
                      06.07.2020/Dipika /Updated Method to exclude all weekend
    *********************************************************************************************************/ 
     public static Date getNextWorkingDate(Date workingDate, Integer offSetDays){
        Integer daysCounter = 0;
        DateTime dt = dateTime.newInstance(workingDate,Time.newInstance(23,59,59,59));
        String day = dt.format(BAT_ConstantsUtility.DATE_FORMAT);//Provides the day of the Date.
        Set <Date> holidayCheck = new Set<Date>();
        List<Holiday> holidayDates = [Select ActivityDate from Holiday LIMIT : Limits.getLimitQueries()];    
        for(Holiday holiday : holidayDates){
            holidayCheck.add(holiday.ActivityDate);
        }
        //Find the next working day and return the date.
        //If day is saturday/sunday/holiday, exclude to get next workink day
        while(daysCounter < offSetDays
             || (holidayCheck.contains(workingDate)|| day.equalsIgnoreCase(BAT_ConstantsUtility.SATURDAY)||day.equalsIgnoreCase(BAT_ConstantsUtility.SUNDAY))){
            if(holidayCheck.contains(workingDate)|| day.equalsIgnoreCase(BAT_ConstantsUtility.SATURDAY)||day.equalsIgnoreCase(BAT_ConstantsUtility.SUNDAY)){
                workingDate= workingDate+1;
                dt = dateTime.newInstance(workingDate,Time.newInstance(23,59,59,59));
                day = dt.format(BAT_ConstantsUtility.DATE_FORMAT);
                continue;
            }
            else{
                daysCounter++;
                workingDate= workingDate+1;
                dt = dateTime.newInstance(workingDate,Time.newInstance(23,59,59,59));
                day = dt.format(BAT_ConstantsUtility.DATE_FORMAT);
            }
        }
        
        
        return workingDate;
    }
    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createTask
    * @returns       : task
    * @params        : Account, Order, Account_HyperCare_Configuration__mdt
    * @description   : A generic method, To create task using Account, Order and MetaData.
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
                       27.10.2020/Eswar Chaturvedula/ Populatin Country field for task creation.
    *********************************************************************************************************/ 

    public static Task createTask(Account acc, Order ord , Account_HyperCare_Configuration__mdt accHyperMdt,Id ownerId){
        //Create New Task and return.
        //VSTS 263163 - Populating Country field for task creation
        Task newTask = new Task();  
        if(acc!=null && ord!=null && accHyperMdt!=null){
            newTask.WhoId = acc.PersonContactId;
            newTask.WhatId = ord.Id;
            newTask.BAT_Country__c = accHyperMdt.Country__c;
            newTask.Consumer_Delivery_City__c = acc.ShippingCity;
            newTask.Consumer_Phone_Number__c = acc.PersonMobilePhone;
            newTask.Order_Source__c = ord.Order_Source__c;
            newTask.OwnerId = ownerId!=null? ownerId : acc.OwnerId;
            newTask.Status = BAT_ConstantsUtility.OPEN_STR;
            newTask.Subject = accHyperMdt!=null? accHyperMdt.Task_subject__c : BAT_ConstantsUtility.EPEN3Sub_STR;
            newTask.ActivityDate = ord.EffectiveDate!=null ? getNextWorkingDate(ord.EffectiveDate,4) : Date.today();
            newTask.Call_Type__c = BAT_ConstantsUtility.DAY4_STR;
            newTask.Consumer_Email_address__c = acc.PersonEmail;//UK US:#6930
            newTask.Consumer_Source__c = acc.AccountSource; //UK #6165 #6163 - by Sudaif
        }
        return newTask;
    }
    
    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createTask
    * @returns       : task
    * @params        : Lead,BAT_LeadTaskCreationConfiguration__mdt
    * @description   : A generic method, To create task using Lead and MetaData.
    * @changeHistory : 30/06/2020/ Dipika Gupta/ PL US#151577/Created method
                       13/8/2020/Rama Akella/ PL:US#258533/Populating Task Country
    *********************************************************************************************************/ 

    public static Task createTask(Lead leadRecord , BAT_LeadTaskCreationConfiguration__mdt config,Id ownerId){
        //Create New Task and return.
        Task newTask = new Task();  
        if(leadRecord!=null && config!=null){
            newTask.WhoId = leadRecord.Id;
            newTask.Subject = config.BAT_TaskSubject__c;
            newTask.ActivityDate = config.BAT_ExcludeWeekend__c ? BAT_Utilities.getNextWorkingDate(Date.today(),Integer.valueOf(config.BAT_TaskOffsetDays__c)): Date.today();
            newTask.OwnerId = leadRecord.OwnerId;
            newTask.Call_Type__c = config.BAT_CallType__c;
            newTask.Priority = config.BAT_TaskPriority__c;
            newTask.BAT_Country__c = config.BAT_Country__c;
        }
        return newTask;
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : checkDeviceForTrial
    * @returns       : void
    * @params        : List<Opportunity> opps, List<Account> accs
    * @description   : [KZ,UA]This method prevent Social Seller to create Trial if no devices are availables
    * @changeHistory : 12.05.2018/Luca Proietti Nicolai/Created the method[US#4613,4605]
                     : 11.02.2019/Tejaswi Nissankula/Code Optimization and removed system.debug logs
    *********************************************************************************************************/
        
        public static void checkDeviceForTrial(Opportunity[] opps, Account[] accs){

            Set<String> countrySet = new Set<String>();
            Map<String,Boolean> enableFeatureMap = new Map<String,Boolean>();
            Map<String,List<Asset>> ProfileToDevicesMap = new Map<String,List<Asset>>(); 
            //map of country and is trial status available for that country
            Map<String ,Boolean> mapOfCountrySpecificStatus = new Map<String,Boolean>();
            Set<String> profileset = new Set<String>();
            Set<Id> owners = new Set<Id>();
            
            boolean isAccountRecordsExist = false;
            boolean isOpptyRecordsExist = false;
            
            if(opps != null && !opps.isEmpty()){
                isOpptyRecordsExist = true;         
            }else if(accs != null && !accs.isEmpty()){
                isAccountRecordsExist = true;
            }
            

            if(isOpptyRecordsExist){
                for(Opportunity op : opps){
                    countrySet.add(op.Country__c);
                    profileset.add(op.Owner_Profile__c);
                    owners.add(op.OwnerId);
                }
            } 
            else if(isAccountRecordsExist){
                for(Account a : accs){
                    countrySet.add(a.Country__c);
                    profileset.add(a.Owner_Profile__c);
                    owners.add(a.OwnerId);
                }
            }
     
            for(Meta_Asset_SS__mdt meta: [SELECT MasterLabel,Profile__c,BAT_IsChangeStageToTrail__c
                                                FROM Meta_Asset_SS__mdt
                                                WHERE MasterLabel IN : countrySet
                                                AND Profile__c IN :profileset]){
                enableFeatureMap.put(meta.Profile__c, true);
                //if BAT_isChangeStageToTrail__c is true ,then code will change the status of trial to
                //'in trail' for that country
                if(meta.BAT_IsChangeStageToTrail__c)
                {
                    mapOfCountrySpecificStatus.put(meta.MasterLabel, meta.BAT_IsChangeStageToTrail__c);

                }
            }
            if(!enableFeatureMap.isEmpty()){
                //CHECK DEVICE
                List<Asset> devices = [SELECT Id,Name,Owner.Profile_Name__c,Country__c
                                        FROM Asset
                                        WHERE OwnerId IN : owners
                                        AND Type__c = :BAT_ConstantsUtility.ASSET_TYPE_TRIAL
                                        AND Status = :BAT_ConstantsUtility.ASSET_STATUS_ACTIVE
                                        AND AccountId = null
                                        AND Id NOT IN (SELECT Asset__c 
                                                        FROM Opportunity 
                                                        WHERE Asset__r.Type__c = :BAT_ConstantsUtility.ASSET_TYPE_TRIAL
                                                        AND Asset__r.OwnerId = : owners
                                                        AND OwnerId = : owners) 
                                        ORDER BY Name DESC
                                        LIMIT 10000 ];

                if(!devices.isEmpty()){
                    for(Asset asset : devices){
                        if(ProfileToDevicesMap.containsKey(asset.Owner.Profile_Name__c)){
                            ProfileToDevicesMap.get(asset.Owner.Profile_Name__c).add(asset);
                        }
                        else{
                           ProfileToDevicesMap.put(asset.Owner.Profile_Name__c, new List<Asset>{asset}); 
                        }
                    }
                    
                }

                else {
                    if(isAccountRecordsExist){
                        for(Account acc: accs){
                            if(acc.Is_Trialist__c && enableFeatureMap.containsKey(acc.Owner_Profile__c)){ acc.addError(Label.CheckDevices_KO);
                            }
                        }
                    }
                    else if(isOpptyRecordsExist){
                         for(Opportunity opp: opps){
                            if(enableFeatureMap.containsKey(opp.Owner_Profile__c)){
                                opp.addError(Label.CheckDevices_KO);
                            }
                        }
                    }
                }

                //check on devices

                if(!ProfileToDevicesMap.isEmpty()){
                    if(isAccountRecordsExist){
                        for(Account acc: accs){
                            if(acc.Is_Trialist__c && enableFeatureMap.containsKey(acc.Owner.Profile_Name__c) ){
                                if(!ProfileToDevicesMap.containsKey(acc.Owner_Profile__c) || ProfileToDevicesMap.get(acc.Owner_Profile__c).size() == 0){
                                     acc.addError(Label.CheckDevices_KO);
                                }
                            }
                        }
                    }
                    else if(isOpptyRecordsExist){
                         for(Opportunity opp: opps){
                            if(!ProfileToDevicesMap.containsKey(opp.Owner_Profile__c) || ProfileToDevicesMap.get(opp.Owner_Profile__c).size() == 0){
                                opp.addError(Label.CheckDevices_KO);
                            }
                else if(ProfileToDevicesMap.get(opp.Owner_Profile__c).size()>0 && (ProfileToDevicesMap.get(opp.Owner_Profile__c).get(0).Country__c.equalsIgnoreCase('UA') || ProfileToDevicesMap.get(opp.Owner_Profile__c).get(0).Country__c.equalsIgnoreCase('AZ'))){
                                opp.Asset__c = ProfileToDevicesMap.get(opp.Owner_Profile__c).get(0).Id;
                                opp.StageName = 'In Trial';
                                opp.Start_Date__c = Date.today();
                                opp.CloseDate  = Date.today().addDays(7);
                            }
                        }
                    }
                }
            }
        }  
        
    /**********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createErrorLogs
    * @returns       : void
    * @params        : Database.SaveResult[] resultList,String className, String methodName
    * @description   : This method is to insert exception logs for Save operations
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
                       13.02.2023/Sameer Ranjan/Added record Id in exception field for insert and update dml operation 
    *********************************************************************************************************/ 
    public static void createErrorLogs(Database.SaveResult[] resultList,String className, String methodName){
        List<Apex_Log__c> apexLog = new List<Apex_Log__c>();
        for(Database.SaveResult sr : resultList){
            if(!sr.isSuccess()){ for(Database.Error err : sr.getErrors()) {
                    Apex_Log__c logRecord = new Apex_Log__c(Class_Name__c = className, Exception__c =err.getStatusCode()+'\n'+err.getFields()+'\n'+err.getMessage()+'\nrecord Id:'+sr.getId(), Method_Name__c = methodName);
                    apexLog.add(logRecord);
                }
            }
        }
        
        if(!apexLog.isEmpty()) { insert apexLog;
        }
    }
    
    /**********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createApexErrorLogs
    * @returns       : List<Apex_Log__c>
    * @params        : Database.SaveResult[] resultList,String className, String methodName
    * @description   : This method returns exception logs for Save operations
    * @changeHistory : 28.07.2021/Dipika Gupta /Create method
    *********************************************************************************************************/ 
    public static List<Apex_Log__c> createApexErrorLogs(Database.SaveResult[] resultList,String className, String methodName){
        List<Apex_Log__c> listApexLog = new List<Apex_Log__c>();
        for(Database.SaveResult sr : resultList){
            if(!sr.isSuccess()){ 
                for(Database.Error err : sr.getErrors()) {
                    Apex_Log__c logRecord = new Apex_Log__c(Class_Name__c = className, Exception__c =err.getStatusCode()+'\n'+err.getFields()+'\n'+err.getMessage(), Method_Name__c = methodName);
                    listApexLog.add(logRecord);
                }
            }
        }
        
        return listApexLog;
    }

    /**********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createErrorLogs
    * @returns       : void
    * @params        : Database.DeleteResult[] resultList,String className, String methodName
    * @description   : This method is to insert exception logs for delete operations
    * @changeHistory : 03.12.2019/ushabala Kanduru /Updated Header Comments
    *********************************************************************************************************/ 

        public static void createErrorLogs(Database.DeleteResult[] resultList,String className, String methodName){
            List<Apex_Log__c> apexLog = new List<Apex_Log__c>();
            
            for(Database.DeleteResult sr : resultList){
                if(!sr.isSuccess()){ for(Database.Error err : sr.getErrors()) {
                        Apex_Log__c logRecord = new Apex_Log__c(Class_Name__c = className, Exception__c =err.getStatusCode()+'\n'+err.getFields()+'\n'+err.getMessage(), Method_Name__c = methodName);
                        apexLog.add(logRecord);
                    }
                }
            }
            
            if(!apexLog.isEmpty()) { insert apexLog;
            }
        }
    /**********************************************************************************************************
    * @author        : ITCINFOTECH
    * @method Name   : createErrorLogs
    * @returns       : void
    * @params        : Exception,String className, String methodName
    * @description   : This method is to create exception logs for file Upload into AZURE
    * @changeHistory : 24-Aug-2023/BJSURAJ /US #1335412 || 'KZ -  Privacy Snapshots backup for all anonymized records Leads/Accounts'/Created this method
    *********************************************************************************************************/ 
    public static void createErrorLogs(String customErrorMessage,String className, String methodName){
        List<Apex_Log__c> apexLog = new List<Apex_Log__c>();
        
        Apex_Log__c logRecord = new Apex_Log__c(Class_Name__c = className, Exception__c =customErrorMessage, Method_Name__c = methodName);
        apexLog.add(logRecord);
        
        if(!apexLog.isEmpty()) { 
            insert apexLog;
        }
    }
    /**********************************************************************************************************
    * @author        : ITCINFOTECH
    * @method Name   : createErrorLogs
    * @returns       : void
    * @params        : Exception,String className, String methodName
    * @description   : This method is to create exception logs for file Upload into AZURE
    * @changeHistory : 24-Aug-2023/BJSURAJ /US #1335412 || 'KZ -  Privacy Snapshots backup for all anonymized records Leads/Accounts'/Created this method
    *********************************************************************************************************/ 
    public static void createErrorLogs(Exception err,String className, String methodName){
        List<Apex_Log__c> apexLog = new List<Apex_Log__c>();
        
        Apex_Log__c logRecord = new Apex_Log__c(Class_Name__c = className, Exception__c =err.getMessage(), Method_Name__c = methodName);
        apexLog.add(logRecord);
        
        if(!apexLog.isEmpty()) { 
            insert apexLog;
        }
    }
    /**********************************************************************************************************
    * @author        : ITCINFOTECH
    * @method Name   : createErrorLogs
    * @returns       : void
    * @params        : Database.UpsertResult[] resultList,String className, String methodName
    * @description   : This method is to upsert exception logs for delete operations
    * @changeHistory : 25-july-2023/BJSURAJ /Created this method
    *********************************************************************************************************/ 
    public static void createErrorLogs(Database.UpsertResult[] resultList,String className, String methodName){
        List<Apex_Log__c> apexLog = new List<Apex_Log__c>();
        for(Database.UpsertResult sr : resultList){
            if(!sr.isSuccess()){ for(Database.Error err : sr.getErrors()) {
                    Apex_Log__c logRecord = new Apex_Log__c(Class_Name__c = className, Exception__c =err.getStatusCode()+'\n'+err.getFields()+'\n'+err.getMessage()+'\nrecord Id:'+sr.getId(), Method_Name__c = methodName);
                    apexLog.add(logRecord);
                }
            }
        }
        if(!apexLog.isEmpty()) { 
            insert apexLog;
        }
    }
    /**********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getFieldType
    * @returns       : Account
    * @params        : Map<String, String> Order Account
    * @description   : This method calculates the Last completed Order date when order status is complete
    * @changeHistory : 02.19.2019/Sudaif Haider/Created the method/US#9159
                       03.12.2019/ushabala Kanduru /Updated Header Comments
                       14-10-2021/Osheen Sahajpal/ ENH: Sprint-89: US#733171 - Adding code to update qualtrics workflow inflight flag and Non Subscription Order date for UK
                       11.11.2021/Rama Akella/US#794776: UK - Brand check to run the logic only for Vype/Vuse
    *********************************************************************************************************/ 
    public static Account lastOrderDateUpdate(Map<String, String> OrderSrcToFieldAPiMap, Order ord, Account acc){
        if(ord.Country__c!=null && ord.Order_Source__c!=null){
            String keyStr = ord.Country__c + ord.Order_Source__c;
            if(OrderSrcToFieldAPiMap.containsKey(keyStr.toUpperCase())){
                acc.put(OrderSrcToFieldAPiMap.get(keyStr.toUpperCase()), DateTime.now());                               
                //14-10-2021/Osheen Sahajpal/ ENH: Sprint-89: US#733171 - Adding code to update qualtrics workflow inflight flag and Non Subscription Order date for UK
                //Updated if condition to make it run only for Vype and Vuse brands for UK
                if(ord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR) && (String.isNotBlank(ord.BAT_Brand__c) && (ord.BAT_Brand__c.equalsIgnoreCase(BAT_ConstantsUtility.VYPE_DEVICE_STR) || ord.BAT_Brand__c.equalsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR))) 
                && (ord.BAT_IsFirstSubscriptionOrder__c || String.isBlank(ord.BAT_SubscriptionGroupID__c))){
                    acc.In_Flight_Hypercare__c = TRUE;
                    acc.BAT_LastOrderDate__c = DateTime.now();
                }
                
                return acc;
            }
        }
        return null;
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : invokeHypercareJourney
    * @returns       : void
    * @params        : List<Sobject>,String,String,String,String
    * @description   : [UK]Method to invoke marketing cloud welcoming onboarding journey.Method called from 
                        BAT_AccountTriggerHandler,BAT_LeadTriggerHandler on afterInsert
    * @changeHistory : Neha Lund/Created the method[US#6079]
    *               14.09.2022/Idrees Ali/ US#1070502:IT | GH | Glo | lterative solution for Reach system using SFMC
    *********************************************************************************************************/
        
        public static void invokeHypercareJourney(List<Sobject> triggerNew, String objectName, String subscriberKey, String emailAPI, String firstNameAPI, String eventType){
        
        Marketing_Cloud_Credentials__mdt credentials = new Marketing_Cloud_Credentials__mdt();
        
        Map<String, Marketing_Cloud_Credentials__mdt> countryCreds = new Map<String, Marketing_Cloud_Credentials__mdt>();
        Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> countryFieldMappingMap = new Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> ();
        Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> countryCriteriaMap = new Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> ();
            
        marketingCloudWrapper = fetchMarketingCloudMeta(objectName,eventType);
            
        countryCriteriaMap = marketingCloudWrapper.countryCriteriaMap;
            
        for( Marketing_Cloud_Credentials__mdt cr: [SELECT DeveloperName, APIEventDefinitionID__c, ClientID__c,
                                                    ClientSecret__c, MarketingCloudRequestURL__c, MarketingCloudTokenURL__c
                                                    from Marketing_Cloud_Credentials__mdt ]){
                                                    
                countryCreds.put(cr.DeveloperName, cr);
        }
         
         String keyOfCriteriaMap = BAT_ConstantsUtility.BLANK;
         String recordCountry = BAT_ConstantsUtility.BLANK;
         String firstName  =  BAT_ConstantsUtility.BLANK;
         
         for(Sobject record: triggerNew){
            
            if( !String.isBlank(firstNameAPI) ){
                firstName = String.valueOf( record.get(firstNameAPI) );
            }
            
            keyOfCriteriaMap = String.valueOf( record.get(BAT_ConstantsUtility.COUNTRY) ) + BAT_ConstantsUtility.STR_COLON + objectName;
            recordCountry = String.valueOf( record.get(BAT_ConstantsUtility.COUNTRY) );
    
             integer counter = 0;
            
             if( countryCriteriaMap.containsKey(keyOfCriteriaMap) ){
                 
                 for(BAT_MarketingMandatoryFieldCriteria__mdt mt:countryCriteriaMap.get(keyOfCriteriaMap)){
                     if(mt.FieldName__c == BAT_ConstantsUtility.PROFILENAME_STR){
                    List<String> entryProfileNames = mt.RequiredTextValue__c.split(BAT_ConstantsUtility.BAT_SEMICOLON_STR);
                         if(entryProfileNames.contains(userProfileName)){
                             counter++;
                         }
                     }
                     else{
                        if(String.valueof(record.get(mt.FieldName__c)) == mt.RequiredTextValue__c){
                             counter++;
                         }
                         else{
                          List<String> entryAccountSource = mt.RequiredTextValue__c.split(BAT_ConstantsUtility.BAT_SEMICOLON_STR);
                         if(entryAccountSource.contains(String.valueof(record.get(mt.FieldName__c)))){
                            counter++;
                         }
                      }
                     }
                 }
                 system.debug('LK Line countryCriteriaMap.get(keyOfCriteriaMap).size() '+countryCriteriaMap.get(keyOfCriteriaMap).size());
                 system.debug('LK Line 1113 '+countryCreds.containsKey(recordCountry));
                if( counter == countryCriteriaMap.get(keyOfCriteriaMap).size() && countryCreds.containsKey(recordCountry)){
                  credentials = countryCreds.get(recordCountry);
                  String recordStr = JSON.serialize(record);
                  BAT_MarketingAPI.invokeMarketingCloudJourney(credentials.ClientID__c,
                    credentials.ClientSecret__c, String.valueOf(record.get(subscriberKey)), String.valueOf(record.get(emailAPI)), firstName,
                           objectName, credentials.APIEventDefinitionID__c, credentials.MarketingCloudTokenURL__c, credentials.MarketingCloudRequestURL__c, eventType,recordStr);
                 }
                 
                 
             }
         }  
        }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getFieldType
    * @returns       : String
    * @params        : String, String 
    * @description   : [All Markets] Created to get the Type of the Field for Any object Passed as String. Returns Field Type as String.
    * @changeHistory : 02.19.2019/Sudaif Haider/Created the method/US#9159
    *********************************************************************************************************/     
    public static String getFieldType(String fieldName, String objName){
        
        Schema.DisplayType fieldType = Schema.getGlobalDescribe() 
                                        .get(objName)
                                        .getDescribe()
                                        .fields
                                        .getMap()
                                        .get(fieldName)
                                        .getDescribe()
                                        .getType();
            String fieldTypeStr = String.valueOf(fieldType);
            return fieldTypeStr;
        }
    /************************************************************************************************************************************
    @ author:          Deloitte  
    @ method:          assignRecordType 
    @ returns:         Id
    @ params:          String objectName, String userName
    * @description:    [UK]Method to assign record type based on the user who is creating the record
    * @changeHistory:   Neha Lund/Created the method[US#10812]
    ************************************************************************************************************************************/
    public static Id assignRecordType (String objectName, String userName){
         
         List<BAT_ObjectUserRecordTypeMapping__mdt> userRecordType = [SELECT BAT_RecordTypeDeveloperName__c from BAT_ObjectUserRecordTypeMapping__mdt 
                                                                WHERE BAT_ObjectName__c = :objectName and 
                                                                BAT_UserName__c = :userName];
         if (!userRecordType.isEmpty()){
             //Return record type based on Object and user 
             return getRecTypeIdByDevName(objectName,userRecordType[0].BAT_RecordTypeDeveloperName__c);
         }
         return null;
    }
     /************************************************************************************************************************************
    @ author:         Deloitte  
    @ method:         createSurveyInvitation 
    @ returns:         void
    @ params:          List<Sobject> triggerNew, String objectName, String subscriberKey, String emailAPI, String firstNameAPI
    * @description:    [UK]Method to generate unique links for Surveys to be sent by marketing cloud
    * @changeHistory:   Neha Lund/Created the method[US#10186]
    Souvik Dinda/ 04.04.2019 / Added Boolean optionsCollectAnonymousResponse in method argument.
************************************************************************************************************************************/
    public static SurveyInvitation createSurveyInvitation (String Name, ID surveyId, ID communityID, ID participantID, Boolean optionsCollectAnonymousResponse){
        
        SurveyInvitation sInvitation = new SurveyInvitation();
        sInvitation.Name = Name;
        sInvitation.SurveyId = surveyId;
        sInvitation.communityID = communityId;
        sInvitation.ParticipantId = participantId;
        sInvitation.OptionsAllowGuestUserResponse = true;
        sInvitation.OptionsCollectAnonymousResponse = optionsCollectAnonymousResponse;
        sInvitation.OptionsAllowParticipantAccessTheirResponse = false;
        return sInvitation;
    } 
    /************************************************************************************************************************************
    @ author:          Deloitte  
    @ method:          getRecTypeIdByDevName 
    @ returns:         Id
    @ params:          String objectName, String developerName
    * @description:    [All Markets]Method to fetch RecordType By developerName
    * @changeHistory:   Sudaif Haider/Created the method[US#10812]
    ************************************************************************************************************************************/    
        public static Id getRecTypeIdByDevName(String ObjectName, String developerName) {
            
            Schema.DescribeSObjectResult objTypesDesc = Schema.getGlobalDescribe().get(objectName).getDescribe();
            Map<String,Schema.RecordTypeInfo>  rtMapByName  = objTypesDesc.getRecordTypeInfosByDeveloperName();
            Id recTypeId;
            if(!rtMapByName.isEmpty() && String.isNotBlank(developerName) && rtMapByName.containsKey(developerName)){
                 recTypeId = rtMapByName.get(developerName).getRecordTypeId();
            }
            return recTypeId;
        }
     
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : deleteTasks
    * @returns       : void
    * @params        : List<SObject> sObjectRecords, String objectName, map objectId to task Subject
    * @description   : This method will be used to delete Tasks for related Parent object
    * @changeHistory : 12.03.2019/Herin Dedhia/Created the method to delete tasks 
30.06.2019/Dipika Gupta/Created the method to delete tasks with subjects
    *********************************************************************************************************/
    public static void deleteTasks(Set<Id> deletionRecords, String objectName, map<Id,Set<String>> mapObjectIdSubjects){
        List<Task> tasksToBeDeleted = new List<Task>();
        List<Task> finaltasksToBeDeleted = new List<Task>();
        if(objectName == BAT_ConstantsUtility.LEAD_STR || objectName == BAT_ConstantsUtility.STANDARD_CONTACT_STR){
            tasksToBeDeleted = [ SELECT Id, Status,WhoId,Subject
                                 FROM Task 
                                 WHERE (WhoId IN :deletionRecords 
                                 OR WhoId IN: mapObjectIdSubjects.keySet() )
                                AND Status != :BAT_ConstantsUtility.TASK_STATUS_COMPLETED
                               ];
            for(Task tsk: tasksToBeDeleted){
                if(mapObjectIdSubjects.containsKey(tsk.WhoId) && tsk.Subject != null){
                    if(mapObjectIdSubjects.get(tsk.WhoId).contains(tsk.Subject.toLowerCase())){
                      finaltasksToBeDeleted.add(tsk)  ;
                    }
                }
                else{
                    finaltasksToBeDeleted.add(tsk)  ;
                }
            }
        }else{
            tasksToBeDeleted = [ SELECT Id, Status,WhatId,Subject
                                 FROM Task WHERE ( WhatId IN :deletionRecords
                                        OR WhatId IN: mapObjectIdSubjects.keySet() ) AND Status != :BAT_ConstantsUtility.TASK_STATUS_COMPLETED
                                 ];
            for(Task tsk: tasksToBeDeleted){
                if(mapObjectIdSubjects.containsKey(tsk.WhatId) && tsk.Subject != null){
                    if(mapObjectIdSubjects.get(tsk.WhatId).contains(tsk.Subject.toLowerCase())){
                      finaltasksToBeDeleted.add(tsk)  ;
                    }
                }
                else{
                    finaltasksToBeDeleted.add(tsk)  ;
                }
            }
        }
        
        list<Database.deleteresult> deleteResultList = new  list<Database.deleteresult>();
        List<Apex_Log__c> lstApexLog = new List<Apex_Log__c>();
        Integer recordid = 0;
        if(!finaltasksToBeDeleted.isEmpty()){ 
            deleteResultList = Database.delete(finaltasksToBeDeleted, false);
        }
        for(Database.deleteresult dsr : deleteResultList){
            if(!dsr.isSuccess()){
                String errMsg = dsr.getErrors()[0].getMessage();
                Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = 'BAT_Utilities', Exception__c = finaltasksToBeDeleted[recordid].Id+': '+errMsg, Method_Name__c = 'Delete Task');
                lstApexLog.add(apexLog);
            }            
               recordid++;
            
        }
        insert lstApexLog;
    }
   
 /*********************************************************************************
   @Author       : Deloitte
   @Method       : getSobjectFieldApiName
   @Returns      : SObjectField
   @Params       : String ObjectApiName, String Field ApiName
   @Description  : This method return the SobjectField from getDescribe of SobjectType. 
   @ChangeHistory: 13/03/2019-US#8216-Created the method
                 : 04/01/2023- Bug#1207453- Debasis Maharana - The code was restructured to resolve the Apex CPU time limit being exceeded.Â 
  *******************************************************************************/ 
  public static SObjectField getSobjectFieldApiName(String objectName, String fieldApiName) {
    switch on objectName {

        when 'Account' {
            if (accountMapfields == null) {
                SObjectType type = Schema.getGlobalDescribe().get(objectName);
                accountMapfields = type.getDescribe().fields.getMap();
            }
            return accountMapfields?.get(fieldApiName);
        }
        when 'Asset' {
            if (assetMapfields == null) {
                SObjectType type = Schema.getGlobalDescribe().get(objectName);
                assetMapfields = type.getDescribe().fields.getMap();
            }
            return assetMapfields?.get(fieldApiName);
        }
        when 'Case' {
            if (caseMapfields == null) {
                SObjectType type = Schema.getGlobalDescribe().get(objectName);
                caseMapfields = type.getDescribe().fields.getMap();
            }
            return caseMapfields?.get(fieldApiName);
        }
        when 'Lead' {
            if (leadMapfields == null) {
                SObjectType type = Schema.getGlobalDescribe().get(objectName);
                leadMapfields = type.getDescribe().fields.getMap();
            }
            return leadMapfields?.get(fieldApiName);
        }
        when
        else {
            SObjectType type = Schema.getGlobalDescribe().get(objectName);
            Map < String, Schema.SObjectField > mapfields = type.getDescribe().fields.getMap();
            return mapfields?.get(fieldApiName);
        }
    }
}

  /*********************************************************************************
    @Author       : Deloitte
    @Method       : calculateTotalPointsOnRewardProfile
    @Returns      : void
    @Params       : List<BAT_Point__c> ,Map<id,BAT_Reward_Profile__c>
    @Description  : This method Calucate the total points and stamp on reward profile total point field.
    @ChangeHistory: 13/03/2019/US#8216/Created the method
                  : 05/05/2020/Satya Nalluri/Bug#119774/Updated code to handle null pointer exception on total points value
                  : 01.12.2022/Anna Gomez/ENH US:#1227255/PT-Update on Total Points sum recalculation minus Redeem Points for PT market
    *******************************************************************************/     
    public static void calculateTotalPointsOnRewardProfile(List<BAT_Point__c> pointList,Map<id,BAT_Reward_Profile__c> rewardProfileMap){
        if(!rewardProfileMap.isEmpty()){
            for(BAT_Point__c point : pointList){
                if(rewardProfileMap.containsKey(point.Reward_Profile__c)){
                    if(rewardProfileMap.get(point.Reward_Profile__c).Total_Points__c == null){
                        rewardProfileMap.get(point.Reward_Profile__c).Total_Points__c = 0;
                    }
                    rewardProfileMap.get(point.Reward_Profile__c).Total_Points__c+=point.Value__c; 
                } 
            }
            
            //ENH-Sprint 119:US:#1227255/PT-Update on Total Points sum recalculation minus Redeem Points for PT market
            for(BAT_Reward_Profile__c rw: rewardProfileMap.values()){
                if(rw.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_PT)){
                    rw.Total_Points__c = rw.Total_Points__c - rw.Redeem_Points__c;
                }
            }
            
            //Added As part of 10258
            setByPassFlagForRewardValidation(True);
            //End 10258
            
            update rewardProfileMap.Values();
            
            //Added As part of 10258
            setByPassFlagForRewardValidation(false);
            //End 10258
        }   
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : setByPassFlagForRewardValidation
    * @returns       : void
    * @params        : boolean
    * @description   : [KZ] Method used to update the BAT_BypassFlag__c from Custom setting BAT_BypassValidationSetting__c.
    * @changeHistory : 10.04.2019 /created the method US#10258
    *********************************************************************************************************/
    public static void setByPassFlagForRewardValidation(boolean flagToset){
        BAT_BypassValidationSetting__c BypassFlagSetting = BAT_BypassValidationSetting__c.getOrgDefaults();
        if(flagToset != BypassFlagSetting.BAT_ByPassRewardValidationFlag__c){     
            BypassFlagSetting.BAT_ByPassRewardValidationFlag__c = flagToset;
            update BypassFlagSetting;
        }
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : setByPassFlagAccountEditValidation
    * @returns       : void
    * @params        : boolean
    * @description   : [RO] Method used to update the BAT_ByPassAccountEditValidationFlag__c from Custom setting BAT_BypassValidationSetting__c.
    * @changeHistory : 09.12.2019 /created the method US#60938
    * @changeHistory : 09.01.2020 /Idrees Ali Jabalpurwala/added null check for this validation
    *********************************************************************************************************/
    public static void setByPassFlagAccountEditValidation(boolean flagToset){
        BAT_BypassValidationSetting__c BypassFlagSetting = BAT_BypassValidationSetting__c.getOrgDefaults();
        if(byPassFlagSetting.id != null && flagToset != BypassFlagSetting.BAT_ByPassAccountEditValidationFlag__c){     
            BypassFlagSetting.BAT_ByPassAccountEditValidationFlag__c= flagToset;
            update BypassFlagSetting;
        }
    } 
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : setBypassOpportunityAssetValidationFlag
    * @returns       : void
    * @params        : boolean
    * @description   : [UA] Method used to update the BAT_BypassOpportunityAssetValidationFlag__c from Custom setting BAT_BypassValidationSetting__c.
    * @changeHistory : 22.02.2021 /Idrees Ali Jabalpurwala/created this method as part of US#308275 
    *********************************************************************************************************/
    public static void setBypassOpportunityAssetValidationFlag(boolean flagToset){
        BAT_BypassValidationSetting__c BypassFlagSetting = BAT_BypassValidationSetting__c.getOrgDefaults();
        if(byPassFlagSetting.id != null && flagToset != BypassFlagSetting.BAT_BypassOpportunityAssetValidationFlag__c){     
            BypassFlagSetting.BAT_BypassOpportunityAssetValidationFlag__c= flagToset;
            update BypassFlagSetting;
        }
    } 
    
    
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : setBypassOpportunityAssetMandateValidationFlag
    * @returns       : void
    * @params        : boolean
    * @description   : [UA] Method used to update the BAT_BypassOppAssetMandateValidationFlag__c from Custom setting BAT_BypassValidationSetting__c.
    * @changeHistory : 30.07.2021 /Dipika Gupta/created this method as part of US#308275    
    *********************************************************************************************************/
    public static void setBypassOpportunityAssetMandateValidationFlag(boolean flagToset){
        BAT_BypassValidationSetting__c BypassFlagSetting = BAT_BypassValidationSetting__c.getOrgDefaults();
        if(byPassFlagSetting.id != null && flagToset != BypassFlagSetting.BAT_BypassOppAssetMandateValidationFlag__c){     
            BypassFlagSetting.BAT_BypassOppAssetMandateValidationFlag__c= flagToset;
            update BypassFlagSetting;
        }
    }  
    
    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         convertSubscriberToAccount 
    *@ returns:        Account acc, Lead leadObj, String strCountry
    *@ params:         Lead
    *@description:     [All Markets] Method to populate Lead Subscriber Ids to Account's consumer Id 
                       when new account is getting registered.
                       Example: 1 x Lead exists in SF for test@test.com - it has 3 subscriber IDs (1 x GoVype, 1 x 10M, 1 x VIP).
                       With same email test@test.com registers for an account on GoVype. 
                       Lead is deleted and, Person Account is created in SF with 1 x customer ID for GoVype 
                       (Account creation is handled by Integration) and 2 subscriber IDs (1 x 10M, 1 x VIP).
    *@changeHistory:   Prince Chawla/Created the method[US#14375]
                       [PL] 25.06.2020/ Mallik Balla/ US# 176027 : Modified the method to add extra parameter strCountry which queries 
                       the metadata with only the country records specified
                       [PL] 14.07.2020/ Mallik Balla/ Bug #217550 : Modified the if condition such that account fields for PL - 
                       will be updated only when the values coming from the integration eSC/Magento are blank.
                       30.11.2020/Souvik Dinda/US#326287-Added logic to restrict account value with lead's value when there is a account source
                       present in BAT_LeadConversionFieldConfiguration__mdt for the respective records.
    ************************************************************************************************************************************/
    public static void convertSubscriberToAccount(Account accObj, Lead leadObj, String strCountry){
      if(accObj!=null && leadObj!=null && String.isNotBlank(strCountry)){
        Map<String,String> accApiToLeadApiMap  = new Map<String,String>();
        Map<String,BAT_LeadConversionFieldConfiguration__mdt> leadPreferenceCheckMap = new Map<String,BAT_LeadConversionFieldConfiguration__mdt>();
        for(BAT_LeadConversionFieldConfiguration__mdt leadConvMdt :[SELECT Id,MasterLabel,DeveloperName,
                                                                    BAT_AccountFieldAPIName__c,BAT_LeadFieldAPIName__c,
                                                                    BAT_IsLeadPreference__c,
                                                                    BAT_AccountSourceForLeadPreference__c, BAT_IsBypassForOtherSources__c,
                                                                    BAT_AccountFieldExpectedValue__c,
                                                                    BAT_IsBooleanField__c
                                                                    FROM BAT_LeadConversionFieldConfiguration__mdt 
                                                                    WHERE MasterLabel =:strCountry
                                                                    ORDER BY MasterLabel DESC]){
            accApiToLeadApiMap.put(leadConvMdt.BAT_AccountFieldAPIName__c , leadConvMdt.BAT_LeadFieldAPIName__c);
            leadPreferenceCheckMap.put(leadConvMdt.BAT_AccountFieldAPIName__c , leadConvMdt);
        }
        Object accFieldValue;
        Object leadFieldValue;
        String leadFieldApi;
        Set<String> accSourceForLeadPrefSet;        
        if(String.isNotBlank(accObj.PersonEmail) && String.isNotBlank(leadObj.Email)
           && accObj.PersonEmail.equalsIgnoreCase(leadObj.Email) && !accApiToLeadApiMap.isEmpty()){ 
            String objType = String.valueOf(accObj.getSObjectType());
            for(String accFieldApi : accApiToLeadApiMap.keySet()){
                accFieldValue = accObj.get(accFieldApi);
                leadFieldApi =  accApiToLeadApiMap.get(accFieldApi);
                leadFieldValue  = leadObj.get(accApiToLeadApiMap.get(accFieldApi));
                //Getting all the sources of account in a Set for which the Lead value will not be over-ridden with incoming Account's value.
               if(leadPreferenceCheckMap.get(accFieldApi).BAT_AccountSourceForLeadPreference__c != null){
                   accSourceForLeadPrefSet = new Set<String>(leadPreferenceCheckMap.get(accFieldApi).BAT_AccountSourceForLeadPreference__c.split(BAT_ConstantsUtility.COMMA_STR));
               }
                //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Modified the check to include PL check where the account initial value need not be blank.
                //[PL] 14.07.2020/ Mallik Balla/ Bug #217550 : Modified the if condition such that account fields for PL - will be updated only when the values coming from the integration eSC/Magento are blank.
                // Also changed the String.isNotBlank(leadFieldValue) to leadFieldValue!=null, as checkbox field outcome can be boolean and might fail with error - Illegal assignment.
                if(accFieldValue == null && leadFieldValue!=null
                          && (!leadPreferenceCheckMap.get(accFieldApi).BAT_IsLeadPreference__c
                              ||(leadPreferenceCheckMap.get(accFieldApi).BAT_IsLeadPreference__c
                                 && accSourceForLeadPrefSet != null
                                 && !accSourceForLeadPrefSet.isEmpty()
                                 && accObj.AccountSource != null
                                 && !accSourceForLeadPrefSet.contains(accObj.AccountSource)
                                 && leadPreferenceCheckMap.get(accFieldApi).BAT_IsBypassForOtherSources__c))){
                                     //Considering the fact Lead and Account Subscriber Ids are created with the same API Name.
                                     //Populate Subscriber Ids of Account only when It does't have Customer Id with that Source.
                                     if(BAT_Utilities.doesFieldExist(objType, leadFieldApi)){
                                         accObj.put(leadFieldApi , leadFieldValue);
                                     }
                                     else{
                                         accObj.put(accFieldApi , leadFieldValue);
                                     }
                                 }
                    //US#326287-Added logic to restrict account value with lead's value when there is a account source mentioned for the fields
                       //those need not be over-ridden by account's value.
                       else if(leadFieldValue!=null &&  
                               ((leadPreferenceCheckMap.get(accFieldApi).BAT_IsLeadPreference__c 
                                 && accSourceForLeadPrefSet == null) 
                                || (leadPreferenceCheckMap.get(accFieldApi).BAT_IsLeadPreference__c 
                                    && accSourceForLeadPrefSet != null && !accSourceForLeadPrefSet.isEmpty()
                                    && accObj.AccountSource != null
                                    && accSourceForLeadPrefSet.contains(accObj.AccountSource)))){
                                        if (leadPreferenceCheckMap.get(accFieldApi).BAT_AccountFieldExpectedValue__c == null
                                            || (leadPreferenceCheckMap.get(accFieldApi).BAT_AccountFieldExpectedValue__c != null
                                                && leadPreferenceCheckMap.get(accFieldApi).BAT_IsBooleanField__c
                                                && accObj.get(leadPreferenceCheckMap.get(accFieldApi).BAT_AccountFieldAPIName__c) != Boolean.valueOf(leadPreferenceCheckMap.get(accFieldApi).BAT_AccountFieldExpectedValue__c))){
                                                    if(BAT_Utilities.doesFieldExist(objType, leadFieldApi)){
                                                        accObj.put(leadFieldApi , leadFieldValue);
                                                    }
                                                    else{
                                                        accObj.put(accFieldApi , leadFieldValue);
                                                    }
                                                }
                                    }
                
            }
        } 
    }
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getUserDetails
    * @returns       : user
    * @params        : none
    * @description   :  [All Market] Method used to get the login user details
    * @changeHistory : 20.03.2019 / Tejaswi Nissankula / created the method
                       16.08.2019 / Tejaswi Nissankula / Added BAT_Brand__c field in query
                       07.11.2019/  Kushagra Jain /  #US:54886: Adding User details conditions
                       01.10.2020 - Anna Gomez - Bug#208156 - Bug#208156: Add LanguageLocaleKey
                       21.01.2021 - Allada Yeshwanth - Added BAT_Region__c
                       28.01.2022 - Idrees Ali - Added Contact.BAT_Profile__c as part of US#726674
    *********************************************************************************************************/
    public static User getUserDetails(){
        User user =[select Id,Name,Country__c,ProfileId,Profile.Name,Store_ID_User__c,city,Bypass_Validation_Rule__c,Username,BAT_Brand__c,LanguageLocaleKey,BAT_Region__c,Contact.BAT_Profile__c,BAT_IsAllowedMultiCountryMobile__c from User where Id=:UserInfo.getUserId()]; //Added BAT_IsAllowedMultiCountryMobile__c  US 1607214  
        return user;
    }
   /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         doesFieldExist 
    *@ returns:        String objName, string fieldName
    *@ params:         Boolean
    *@description:     [All Markets] Method to check to validate a field exists on the given object.
    *@changeHistory:   Prince Chawla/Created the method [US#14375]
    ************************************************************************************************************************************/
    public static boolean doesFieldExist(String objApiName, string fieldApiName){
        /* used Type.forName for better performance than globalDescribe method like this, 
         * SObject objSObjectType = Schema.getGlobalDescribe().get(objApiName).newSObject(); */
        SObjectType sObjType = ((SObject)(Type.forName('Schema.'+objApiName).newInstance())).getSObjectType();
        String fieldApiLowerCase = fieldApiName.toLowerCase(); 
        //getDescribe().fields returns all API names in lowercase, so for comparision converted upperCase to lowerCase.
        return sObjType.getDescribe().fields.getMap().containsKey(fieldApiLowerCase);
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : validateMobileFormatwrtCountry
* @returns       : Map<String,String>
* @params        : mapOfCountrytoMobileNum
* @description   : [All Market] Method used to validate the format of mobile
* @changeHistory : 03.04.2019 / Akshata Rajmane / created the method
                 : 12.06.2020 / Tejaswi Nissankula /ID: Sprint 1:US#139252,139255 :Added min and max blank checks 
                   logic to cover the scenario when the markets requirment is just to validate the prefix formate 
                   of mobile but not min or max digits available after prefix. 
                 : 08.10.2020 / Allada Yeshwanth / ID: Sprint 1:US#290427 : Added functionality to fetch international
                   record from metadata and moved the logic of checking the records wrt metadata to a separate method.
                   01.10.2020 - Anna Gomez - Bug#208156 - Added Mobile Number Format Error Message in English version
                   23.10.2020 / Allada Yeshwanth / Fixed the error message logic to work for all markets
                   21.01.2021||SK ||Allada Yeshwanth|| Pulled International error message from Label to enable the translation error message for all markets
*********************************************************************************************************/
    public static Map<String,String> validateMobileFormatwrtCountry(Map<String,List<String>> mapOfCountrytoMobileNum){
        Map<String ,String> resultMap = new Map<String,String>();
        BAT_MobileFormatValidationConfiguration__mdt InternationalRec;
        User user = getUserDetails();
        Map<String,List<String>> mapMultipleCountryCode = new Map<String,List<String>>();
       // Boolean isCountrySKwithHRCode = false;
       /* System.debug('-=1' +user.country__c );
        System.debug('-=2' +user.BAT_IsAllowedMultiCountryMobile__c );
        System.debug('-=3' +mapOfCountrytoMobileNum.containsKey('SK') );
        //System.debug('-=4' +mapOfCountrytoMobileNum.get('SK')[0] );
        System.debug('-=5' +mapOfCountrytoMobileNum.get('SK')[0].substring(0,3) );
        */
     /*   if(user.country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_SK) && user.BAT_IsAllowedMultiCountryMobile__c &&  mapOfCountrytoMobileNum.containsKey(BAT_ConstantsUtility.Country_SK)){
                if(mapMultipleCountryCode.get(BAT_ConstantsUtility.Country_SK)==null){
                    List<String> countryCodeList  = new List<String>();
                    If(mapOfCountrytoMobileNum.get(BAT_ConstantsUtility.Country_SK)[0].substring(0,3).equalsIgnoreCase(BAT_ConstantsUtility.HUNGARY_COUNTRYCODE)){
                        countryCodeList.add(mapOfCountrytoMobileNum.get(BAT_ConstantsUtility.Country_SK)[0].substring(0,3));
                    }
                    else if()
                    
                    mapMultipleCountryCode.put(BAT_ConstantsUtility.Country_SK,countryCodeList);
                }
                else{
                       mapMultipleCountryCode.get(BAT_ConstantsUtility.Country_SK).add(mapOfCountrytoMobileNum.get(BAT_ConstantsUtility.Country_SK)[0].substring(0,3))  ;                          
                }
            
        }*/
        mobileFormatCountryMap = getMobileFormatValidationDetails(mapOfCountrytoMobileNum.keySet(),mapOfCountrytoMobileNum,user);

        //ID: Sprint 1:US#290427: Added to fetch international metadata rec.
        //Checking and fetching international rec
        If(mobileFormatCountryMap != null && mobileFormatCountryMap.size() > 0){
            internationalRec = fetchInternationalRec(mobileFormatCountryMap);
        }

        if(!user.Bypass_Validation_Rule__c && !mobileFormatCountryMap.isEmpty())
        {
            for(BAT_MobileFormatValidationConfiguration__mdt rec: mobileFormatCountryMap.values())
                
            { 
                //ID:Sprint 1: US#139252,139255 : Removed min and max null checks
                if(rec.BAT_PrefixFormat__c !=null)
                {
                    integer prefixLength = rec.BAT_PrefixFormat__c.length();
                    if(!mapOfCountrytoMobileNum.isEmpty() && mapOfCountrytoMobileNum.containsKey(rec.MasterLabel)){////chirag changed developername to masterlabel
                        for(String mobileNum : mapOfCountrytoMobileNum.get(rec.MasterLabel))//chirag changed developername to masterlabel
                        {
                            //ID: Sprint 1: US#290427 : created a separate method to validate as this is called multiple times
                            //function called to check if the mobileNum is NOT valid wrt mobile metadata rec of the country.
                            if(isPhnNotValid(rec,mobileNum))
                            {
                                Boolean isError = true;
                                String errorMessage ; 
                                //if error put it in the errormap
                                if(user.LanguageLocaleKey.contains(BAT_ConstantsUtility.USER_LANGUAGE_ENGLISH) && rec.BAT_MobileNumberFormatErrorMsgEnglish__c != null && rec.BAT_MobileNumberFormatErrorMsgEnglish__c != '' ){
                                     errorMessage = rec.BAT_MobileNumberFormatErrorMsgEnglish__c;
                                 } else {
                                     errorMessage = rec.BAT_MobileNumberFormatErrorMessage__c;
                                 } 
                                //ID: Sprint 1: US#290427 :
                                //function called to check if the mobileNum is NOT valid wrt International mobile metadata rec.
                                if(rec.BAT_isInternational__c && InternationalRec != null){
                                    if(rec.BAT_PrefixFormat__c.length() < mobileNum.length() 
                                       && 
                                       rec.BAT_PrefixFormat__c != mobileNum.substring(0,rec.BAT_PrefixFormat__c.length())
                                      ){
                                        if(isPhnNotValid(internationalRec,mobileNum)){
                                            //21.01.2021||SK ||Allada Yeshwanth|| Pulled International error message from Label to enable the translation error message for all markets
                                            errorMessage = Label.BAT_GlobalMobileFormatError;
                                        }
                                        else{
                                            //this will be set to false if the mobile number is valid according to international metadata rec.
                                            isError = false;
                                        }
                                    }
                                }
                             //if error put it in the errormap
                                if(isError){
                                    resultMap.put(MobileNum,errorMessage);   
                                }  
                                 
                            }
                        }
                    } 
                    
                }
            }

        }
        
        return resultMap;   
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : isPhnNotValid
    * @returns       : Boolean
    * @params        : rec,mobileNum
    * @description   : Returns true if the mobileNum does NOT match with the config of Mobile Format Validation Configuration record rec
    * @changeHistory : 08.10.2020 / Allada Yeshwanth / Created for US#290427. 
    *********************************************************************************************************/
    public static Boolean isPhnNotValid(BAT_MobileFormatValidationConfiguration__mdt rec,String mobileNum){
        Boolean isNotValid = false;
        integer mobileLength = mobileNum.length();
        string countryCode = BAT_ConstantsUtility.SINGLE_SPACE;
        integer prefixLength = rec.BAT_PrefixFormat__c.length();
        if(mobileLength > prefixLength)
        {
            countryCode = mobileNum.substring(0,prefixLength);   
        }
        //if is for checking format of mobile number
        //ID: Sprint 1:US#139252,139255 :Added min and max blank checks logic to cover the scenario when markets requirment is 
        //just to validate the prefix formate of mobile but not min or max digits available after prefix.
        if(!(rec.BAT_PrefixFormat__c == countryCode && 
             Pattern.compile('^\\+[0-9]*$').matcher(mobileNum).matches() &&
             ((rec.BAT_MinNumberOfDigits__c == null || 
               (rec.BAT_MinNumberOfDigits__c != null && mobileLength >= rec.BAT_MinNumberOfDigits__c)) &&
              (rec.BAT_MaxNumberOfDigits__c == null || 
               (rec.BAT_MaxNumberOfDigits__c !=null && mobileLength <= rec.BAT_MaxNumberOfDigits__c)))))
        {
            isNotValid = true;
        }
        return isNotValid;
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : fetchInternationalRec
* @returns       : BAT_MobileFormatValidationConfiguration__mdt
* @params        : mobileFormatCountryMap
* @description   : Used to fetch international mobile validation metadata rec.
* @changeHistory : Created by Allada Yeshwanth for US#290427. 
                 
*********************************************************************************************************/
    public static BAT_MobileFormatValidationConfiguration__mdt fetchInternationalRec(Map<string,BAT_MobileFormatValidationConfiguration__mdt> mobileFormatCountryMap){
        
        Boolean fetchInternationalRec = false;
        //Iterate over the recs to check if we need to fetch international rec for atleast one country
        for(BAT_MobileFormatValidationConfiguration__mdt rec: mobileFormatCountryMap.values()){
            if(rec.BAT_isInternational__c){
                fetchInternationalRec = true;
                break;
            }
        }
        
        //Fetch the international rec if the boolean sets to true.
        if(fetchInternationalRec){
            Set<String> intValidationRecSet = new Set<String>();
            intValidationRecSet.add(BAT_ConstantsUtility.INTERNATIONAL_MOBILE_VALIDATION_REC_NAME);
            Map<String,BAT_MobileFormatValidationConfiguration__mdt> internationalRecMap = getMobileFormatValidationDetailsRecs(intValidationRecSet,null,null);//chirag
            
            if(internationalRecMap.containsKey(BAT_ConstantsUtility.INTERNATIONAL_MOBILE_VALIDATION_REC_NAME)){
                return internationalRecMap.get(BAT_ConstantsUtility.INTERNATIONAL_MOBILE_VALIDATION_REC_NAME);
            }
            return null;
            
        }
        return null;
        
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : updateAccStatus
    * @returns       : Account
    * @params        : Order ord, Account acc
    * @description   : [All Market] Method used to Update Consumer Brand Status
    * @changeHistory : 03.04.2019 / Usha / created the method
    *********************************************************************************************************/
    public static Account updateAccStatus(Order ord, Account acc){
        Map<String,List<BAT_UKOrderHypercareTaskCriteria__mdt>> accCriteriaMap = new Map<String,List<BAT_UKOrderHypercareTaskCriteria__mdt>>(fetchCriteriaFromMdt(ord.Country__c,BAT_ConstantsUtility.ACCOUNT));
        if(String.isNotBlank(acc.BAT_VapeStatus__c) && !acc.BAT_VapeStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER) 
           && !accCriteriaMap.isEmpty() && accCriteriaMap.containsKey(BAT_ConstantsUtility.VAPE_STATUS)){
            for(BAT_UKOrderHypercareTaskCriteria__mdt vapeInfo:accCriteriaMap.get(BAT_ConstantsUtility.VAPE_STATUS)){
                if((vapeInfo.BAT_OrderSource__c).equalsIgnoreCase(ord.Order_Source__c)){
                    if(vapeInfo.BAT_PaymentMethodOperator__c!=NULL && ord.Payment_Method__c!=NULL){
                        if((((BAT_ConstantsUtility.NOTEQUALS).equalsIgnoreCase(vapeInfo.BAT_PaymentMethodOperator__c)) &&   
                            !ord.Payment_Method__c.equalsIgnoreCase(vapeInfo.BAT_PaymentMethod__c))){
                            acc.put(vapeInfo.BAT_FieldToUpdate__c,vapeInfo.BAT_FieldValue__c);
                            break;
                        }else{
                            if(((BAT_ConstantsUtility.EQUALS).equalsIgnoreCase(vapeInfo.BAT_PaymentMethodOperator__c)) && 
                               ((ord.Payment_Method__c).equalsIgnoreCase(vapeInfo.BAT_PaymentMethod__c))){
                                acc.put(vapeInfo.BAT_FieldToUpdate__c,vapeInfo.BAT_FieldValue__c);
                                break;
                            }
                        }
                    }else{
                        if(vapeInfo.BAT_PaymentMethodOperator__c==NULL){
                            acc.put(vapeInfo.BAT_FieldToUpdate__c,vapeInfo.BAT_FieldValue__c);
                            break;
                        }
                    }
                }
            }
        }
        if(String.isNotBlank(acc.BAT_OralStatus__c) && !acc.BAT_OralStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER) &&
           !accCriteriaMap.isEmpty() && accCriteriaMap.containsKey(BAT_ConstantsUtility.ORAL_STATUS)){
            for(BAT_UKOrderHypercareTaskCriteria__mdt oralInfo:accCriteriaMap.get(BAT_ConstantsUtility.ORAL_STATUS)){
                
                if(((oralInfo.BAT_OrderSource__c).equalsIgnoreCase(ord.Order_Source__c)) && ord.Order_Total__c !=NULL){
                    if(((BAT_ConstantsUtility.EQUALS).equalsIgnoreCase(oralInfo.BAT_OrderTotalOperator__c)) && (ord.Voucher_Code__c!=NULL) && (ord.Order_Total__c == oralInfo.BAT_OrderTotal__c)){
                        if(((ord.Voucher_Code__c).equalsIgnoreCase(oralInfo.BAT_VoucherCode__c))){
                            acc.put(oralInfo.BAT_FieldToUpdate__c,oralInfo.BAT_FieldValue__c);
                            break;
                        }                    
                    }else{
                        if(ord.Order_Total__c!=oralInfo.BAT_OrderTotal__c && ((BAT_ConstantsUtility.NOTEQUALS).equalsIgnoreCase(oralInfo.BAT_OrderTotalOperator__c))){
                            acc.put(oralInfo.BAT_FieldToUpdate__c,oralInfo.BAT_FieldValue__c);
                            break;
                        }
                    }
                }
            }
        }
        return acc;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : fetchCriteriaFromMdt
    * @returns       : criteriaMap
    * @params        : Map<String,List<BAT_UKOrderHypercareTaskCriteria__mdt>>
    * @description   : [All Market] Method used to fetch the Custom Metdata BAT_UKOrderHypercareTaskCriteria__mdt based on User input.
    * @changeHistory : 03.04.2019 / Usha / created the method

    *********************************************************************************************************/
    private static Map<String,List<BAT_UKOrderHypercareTaskCriteria__mdt>> fetchCriteriaFromMdt(String country, String objName){
        Map<String,List<BAT_UKOrderHypercareTaskCriteria__mdt>> criteriaMap = new Map<String,List<BAT_UKOrderHypercareTaskCriteria__mdt>>();
        if(country!=NULL){
            for(BAT_UKOrderHypercareTaskCriteria__mdt info:[select MasterLabel,     BAT_OrderSource__c,BAT_PaymentMethod__c,BAT_FieldToUpdate__c,
                                                            BAT_OrderTotalOperator__c,BAT_FieldValue__c,BAT_PaymentMethodOperator__c,BAT_OrderTotal__c,BAT_VoucherCode__c 
                                                            from BAT_UKOrderHypercareTaskCriteria__mdt where MasterLabel = :country and BAT_ObjectName__c=:objName]){
                if(info.BAT_FieldToUpdate__c!=NULL){
                    
                    if(!criteriaMap.containsKey(info.BAT_FieldToUpdate__c)){
                        criteriaMap.put(info.BAT_FieldToUpdate__c,new List<BAT_UKOrderHypercareTaskCriteria__mdt>());
                    }
                    criteriaMap.get(info.BAT_FieldToUpdate__c).add(info);
                }
            }
        }
        return criteriaMap;
    }

/*********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : verifyMobileNumberAndEmailChange
    * @returns       : void
    * @params        : string,user
    * @description   : [All Market except UK,DE] : We are blocking the non-admin and non-integration users 
                        from updating mobile number on record upon completion of mobile verification process.
                        But when Admin,EM Admin or Integartion user try to update the mobile number ,we will save 
                        the record by setting the phone verified as flase and bypass as true along with mobile 
                        number update.
    * @changeHistory : 03.04.2019 / Tejaswi Nissankula / created the method
    *                   31.01.2020/ Souvik Dinda/ US#71390: Re-used the method to check verified email changed
    *                   during insertion/updation. Changed method name to make it generic.
    *                   21.05.2020/ Rajeev Arya/ US#71365: Updated the method to check if the verified email has been changed for Accounts
    *                   15.05.2020/ Souvik Dinda/ US#71379: Added logic to populate account record types for market which has only Email *
*28.07.2020/ Dipika Gupta/ US#194108: If user country is PL, update is allowed                   Verification enabled.
    *                   20th Nov-2020/Roopa N/ CZ: Bug #331468: Bypassing Email verified, Email Verification Status updation if Integration User updates email on Account/lead
    *                   03.12.2020/ Anna Gomez/ Bug#340704: Removed isPLUser when update is allowed Verification enabled
                        25.1.2021/ /Dipika/BUG#386666 - Bypassed of restriction email change functionality for customer service CZ Users 
                        //BUG: #407480 : Added string.isBlank check for email change error Message
                        //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || Modified the method to work on rec's country instead of User's country as this is working for cluster users aswell.
                        BUG#449383-411752 - Issue with new account creation via CIAM Integration where same email already exists in SF
                        16th April/Abhishek Kashyap/Bug-489937-466400 - Careline cannot edit Email or Phone if it is already verified
                        //US: #537702 || Allada Yeshwanth || ENH : Sprint 83 || bypassing Mobile and email change check for PL Hostess
    *********************************************************************************************************/
    public static void verifyMobileNumberAndEmailChange(List<sObject> newRecords,Map<Id,sobject> oldMap,string objectName,User user){
        boolean isAdminOrIntegrationUser = true;
        boolean isCZIntegrationUser = false; // Added as part of CZ Bug #331468
        boolean isROIntegrationUser = false; // Added as part of RO US#405626
        boolean isCSPLUser = false;
        //16th April/Abhishek Kashyap/Bug-489937-Flag to check if the logged in user is customer Service RO
        boolean isCSROUser = false;
        string visibleMobileNum;
        string nonVisibleMobileNum;
        String visibleEmail;
        String nonVisibleEmail;
        String emailVerifiedAPI = BAT_ConstantsUtility.EMAIL_VERIFIED_FIELD_API;
        String emailVerificationStatusAPI = BAT_ConstantsUtility.EMAIL_VERIFICATION_STATUS_FIELD_API;
        string phoneVerified = BAT_ConstantsUtility.PHONE_VERIFIED_API_NAME;
        string byPassVerification = BAT_ConstantsUtility.BYPASSMOBILEVERIFICATION_API_NAME;
        string isPersonAccount = BAT_ConstantsUtility.BLANK_STR;
        string recordTypeId = BAT_ConstantsUtility.RECORDTYPEID;
        set<string> countrySet = new set<string>();
        Map<string,BAT_GlobalEnableSMSConfiguration__mdt> globalSmsConfigMap = new Map<string,BAT_GlobalEnableSMSConfiguration__mdt>();
        List<Schema.RecordTypeInfo> objRecordTypes = new List<Schema.RecordTypeInfo>();
        List<string> recordTypeList = new List<String>();
        //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || Variables to store recordtype List and Id according to country
        Map<string,List<string>> countryRecTypeMap = new Map<String,List<String>>();
        Map<String,set<Id>> countryRecordTypeIdSet = new Map<String,set<Id>>();
        if(user!= null){
            //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || Iterating over records to populate country set
            for(sObject rec: newRecords){
                if(String.isNotBlank((string)rec.get(BAT_ConstantsUtility.country))){
                    countrySet.add((string)rec.get(BAT_ConstantsUtility.country));
                }
            }
            mobileFormatCountryMap = getMobileFormatValidationDetails(countrySet,null,null);//chirag
            globalSmsConfigMap = getGlobalEnableSMSDetails(countrySet);
            emailValidationConfigMap = getEmailValidationConfig();
        }  
        
        // check the login user profile
        if(user.Profile.Name != NULL && (!user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.SYSTEM_ADMIN) &&
           !user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER))){
               isAdminOrIntegrationUser = false;
        }
        // Added as part of CZ Bug #331468
        if(user.Profile.Name != NULL &&
           user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && user.Country__c == BAT_ConstantsUtility.COUNTRY_CZ){
               isCZIntegrationUser = true;
        }
        // Added as part of RO US#405626
        if(user.Profile.Name != NULL &&
           user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && user.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
               isROIntegrationUser = true;
        }
        //Added as part of CZ Bug #386666
        if(user.Profile.Name == BAT_ConstantsUtility.PROFILE_BAT_CUSTOMER_SERVICE_CZ){
            isCSPLUser = true;
        }
        //16th April/Abhishek Kashyap/Bug-489937-Set the flag to true if the loggedin user is customer Service RO
        if(user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.PROFILE_BAT_CUSTOMER_SERVICE_RO)){
            isCSROUser = true;
        }
        //END Bug #331468
        //US: #537702 || Allada Yeshwanth || ENH : Sprint 83 || bypassing Mobile and email change check for PL Hostess
        if(user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.BAT_PROFILE_PLHOSTESS)){
            return;
        }

        //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || transformed the logic to iterate over records country isntead of user's country
        //Get the record types which are in scope of SMS functionality
        if(!globalSmsConfigMap.isEmpty()) { 
            for(string recCountry : countrySet){
                if(globalSmsConfigMap.containsKey(recCountry) && globalSmsConfigMap.get(recCountry).BAT_IsSendMobileVerificationSMSEnabled__c){
                    recordTypeList = new List<string>();
                    //Get the recod types which are in scope on Account object
                    if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR &&
                        String.isNOTBlank(globalSmsConfigMap.get(recCountry).BAT_ScopeOfRecordTypesOnAccount__c)){
                            string localScopeofRecTypes = globalSmsConfigMap.get(recCountry).BAT_ScopeOfRecordTypesOnAccount__c;
                            recordTypeList = localScopeofRecTypes.split(BAT_ConstantsUtility.COMMA_STR);
    
                    }
                    //Get the recod types which are in scope on Account object
                    else if(objectName == BAT_ConstantsUtility.LEAD_STR &&
                        String.isNOTBlank(globalSmsConfigMap.get(recCountry).BAT_ScopeOfRecordTypesOnLead__c)){
                            string localScopeofRecTypes = globalSmsConfigMap.get(recCountry).BAT_ScopeOfRecordTypesOnLead__c;
                            recordTypeList = localScopeofRecTypes.split(BAT_ConstantsUtility.COMMA_STR);
                    }
                    if(!recordTypeList.isEmpty()){
                        countryRecTypeMap.put(recCountry,recordTypeList);
                    }
                }
            }
        }
        
        
        //Added logic to populate recordTypeSet for markets for which mobile verification is not enabled [UK, NEA] 
        if(countryRecTypeMap.isEmpty() && !emailValidationConfigMap.isEmpty()){
            for(string recCountry : countrySet){
                if(emailValidationConfigMap.containsKey(recCountry) &&  emailValidationConfigMap.get(recCountry).BAT_IsOnlyEmailVerificationEnabled__c){
                    if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR && String.isNOTBlank(emailValidationConfigMap.get(recCountry).BAT_ScopeOfRecordTypesOnAccount__c)) {
                        string localScopeofRecTypes = emailValidationConfigMap.get(recCountry).BAT_ScopeOfRecordTypesOnAccount__c;
                        recordTypeList = new List<String>();
                        recordTypeList = localScopeofRecTypes.split(BAT_ConstantsUtility.COMMA_STR);
                        countryRecTypeMap.put(recCountry,recordTypeList);
                    }
                }
            }
        }   
        
        //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || Preparing the set of availble recType Id wrt country for user
        // Get record type id which are in scope and available to login user
        if(!countryRecTypeMap.isEmpty()){
            if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                objRecordTypes = Account.SObjectType.getDescribe().getRecordTypeInfos();
            }
            else if(objectName == BAT_ConstantsUtility.LEAD_STR){
                objRecordTypes = Lead.SObjectType.getDescribe().getRecordTypeInfos();
            }
            for(String country : countryRecTypeMap.keySet()){
                set<Id> availableRecTypeId = new Set<Id>();
                for(RecordTypeInfo rt : objRecordTypes){
                    if(rt.isAvailable() && !rt.isMaster()  && countryRecTypeMap.get(country).contains(rt.getDeveloperName())){
                        availableRecTypeId.add(rt.getRecordTypeId());
                    }
                }
                countryRecordTypeIdSet.put(country,availableRecTypeId);
            }   
        }
         
       //when method called from context of Account below logic will execute
        if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
            visibleMobileNum = BAT_ConstantsUtility.ACCOUNT_FIELD_MOBILEPHONE;
            nonVisibleMobileNum = BAT_ConstantsUtility.ACCOUNT_FIELD_HOMEPHONE;
            isPersonAccount = BAT_ConstantsUtility.ACCOUNT_FIELD_ISPERSONACCOUNT;
            visibleEmail = BAT_ConstantsUtility.ACCPERSONEMAIL;
            nonVisibleEmail = BAT_ConstantsUtility.ACCOUNT_TEMP_EMAIL_FIELD_API;  
        }
        //when method called from context of Lead below logic will execute
        else if(objectName == BAT_ConstantsUtility.LEAD_STR){
            visibleMobileNum = BAT_ConstantsUtility.LEAD_FIELD_MOBILEPHONE;
            nonVisibleMobileNum = BAT_ConstantsUtility.LEAD_FIELD_HOMEPHONE;
            visibleEmail = BAT_ConstantsUtility.LEAD_Email;
            nonVisibleEmail = BAT_ConstantsUtility.TEMPORARY_EMAIL_FIELD_API;
        }
        //25.02.2021|| SK BUG: #423579 || Allada Yeshwanth || modified the logic to work on rec's country instead of user's country
        //when user try to change mobile number after mobile verification process
        //Added PT country to set phoneverfied to false when mobile field is blank
        for(sObject rec : newRecords){
            String recCountry = (string)rec.get(BAT_ConstantsUtility.COUNTRY);
            if(!countryRecordTypeIdSet.isEmpty() && countryRecordTypeIdSet.containsKey(recCountry) &&
                countryRecordTypeIdSet.get(recCountry).contains((Id)rec.get(recordTypeID)) &&
               rec.get(phoneVerified) == true &&
               ((rec.get(visibleMobileNum) != null && rec.get(visibleMobileNum) != BAT_ConstantsUtility.BLANK_STR)|| 
                ((recCountry == BAT_ConstantsUtility.COUNTRY_MY ||recCountry == BAT_ConstantsUtility.COUNTRY_PT) && rec.get(visibleMobileNum) == null)) &&
               (isPersonAccount == BAT_ConstantsUtility.BLANK_STR ||
                (isPersonAccount != BAT_ConstantsUtility.BLANK_STR && 
                 rec.get(isPersonAccount) == true)) &&
               ((oldMap == null &&
                 rec.get(nonVisibleMobileNum) != null && 
                 rec.get(nonVisibleMobileNum) != BAT_ConstantsUtility.BLANK_STR &&
                 rec.get(visibleMobileNum) != rec.get(nonVisibleMobileNum)) || 
                (oldMap != null && 
                 !oldMap.isEmpty() &&
                 oldMap.containsKey(rec.Id) && 
                 rec.get(visibleMobileNum) != oldMap.get(rec.Id).get(visibleMobileNum)))){
                     //Throw error when login user is non-admin or non-integration user
                     //28.07.2020/ Dipika Gupta/ US#194108: If user is PL, by pass the error to update mobile number
                     //16th April/Abhishek Kashyap/Bug-489937-Bypassed the error for RO customer service
                    //29.09.2021/Idrees Ali/MY-Vuse:US#739516 - Added Blank check to prevent 'Argument cannot be Null' error
                     if(!isAdminOrIntegrationUser && !mobileFormatCountryMap.isEmpty() && mobileFormatCountryMap.containsKey(recCountry) && !isCSROUser
                        && String.isNotBlank(mobileFormatCountryMap.get(recCountry).BAT_MobileNumberChangedErrorMessage__c)){
                            rec.addError(mobileFormatCountryMap.get(recCountry).BAT_MobileNumberChangedErrorMessage__c);
                        }
                     //update record when login user is admin or integration user
                     //17th March,2021/Abhishek Kashyap/BUG#449383-411752 - Issue with new account creation via CIAM Integration where same email already exists in SF
                     //Bypassed the flag reset for RO integration User, to cover Phone update from Integration User.
                     else if(!isROIntegrationUser){
                         rec.put(phoneVerified,false);
                         rec.put(byPassVerification,true);
                         rec.put(nonVisibleMobileNum,null);
                     }
                 }
            //added for email check when email is verfied and changed during creation/updation
            //US #71365 : adding the condition to check for Account object
            //BUG: #407480 : Added string.isBlank check for error Message
            else if(!countryRecordTypeIdSet.isEmpty() && countryRecordTypeIdSet.containsKey(recCountry) &&
                    countryRecordTypeIdSet.get(recCountry).contains((Id)rec.get(recordTypeID)) &&
                    rec.get(emailVerifiedAPI) == true &&
                    rec.get(visibleEmail) != null && 
                    rec.get(visibleEmail) != BAT_ConstantsUtility.BLANK_STR &&
                    ((oldMap == null &&
                      rec.get(nonVisibleEmail) != null && rec.get(nonVisibleEmail) != BAT_ConstantsUtility.BLANK_STR &&
                      rec.get(visibleEmail) != rec.get(nonVisibleEmail)) || 
                     (oldMap != null && 
                      !oldMap.isEmpty() &&
                      oldMap.containsKey(rec.Id) && 
                      rec.get(visibleEmail) != oldMap.get(rec.Id).get(visibleEmail)))){
                          //16th April/Abhishek Kashyap/Bug-489937-Bypassed the error for RO customer service
                          if(!isAdminOrIntegrationUser && !emailValidationConfigMap.isEmpty() &&
                             emailValidationConfigMap.containsKey(recCountry) && !isCSPLUser && String.isNotBlank(emailValidationConfigMap.get(recCountry).BAT_EmailChangedErrorMessage__c) && !isCSROUser){
                                 rec.addError(emailValidationConfigMap.get(recCountry).BAT_EmailChangedErrorMessage__c);
                             }
                          //update record when login user is admin or integration user
                          // Added if "!isCZIntegrationUser" to existing else condition as part of CZ Bug #331468
                          // Added as part of RO US#405626
                          else if(!isCZIntegrationUser && !isROIntegrationUser){
                              rec.put(emailVerifiedAPI, false);
                              rec.put(emailVerificationStatusAPI, BAT_ConstantsUtility.EMAILVERIFICATION_STATUS_BYPASSED);
                              rec.put(nonVisibleEmail, null);
                          }
                      }
        } 
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getMobileFormatValidationDetails
    * @returns       : Map
    * @params        : List<string>
    * @description   : [All Market] : Retrieves mobileformatvalidation custom metadata records based on country 
    * @changeHistory : 22.04.2019 / Tejaswi Nissankula / created the method
    *                : 08.10.2020 / Allada Yeshwanth / ID: Sprint 1:US#290427 : Moved the query to separate method to utilize
    *                   it for fetching international metadata record.
    *********************************************************************************************************/
    public static Map<string,BAT_MobileFormatValidationConfiguration__mdt> getMobileFormatValidationDetails(set<String> countrySet,Map<String,List<String>> mapOfCountrytoMobileNum,User user){
    
        if(mobileFormatCountryMap.isEmpty() && !countrySet.isEmpty()){
            mobileFormatCountryMap = getMobileFormatValidationDetailsRecs(countrySet,mapOfCountrytoMobileNum,user);
        }
        return mobileFormatCountryMap;
        
    }
    
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getMobileFormatValidationDetailsRecs
    * @returns       : Map
    * @params        : List<string>
    * @description   : Run the query on the requested country set and return map of records.
    * @changeHistory : 08.10.2020 / Allada Yeshwanth / Created for US#290427. 
                        21.06.2021 || Allada Yeshwanth || PL || PBI: #538696 || Added BAT_DuplicateMobileCheckEnabledProfiles__c in the query
    *********************************************************************************************************/
    public static Map<string,BAT_MobileFormatValidationConfiguration__mdt> getMobileFormatValidationDetailsRecs(set<String> countrySet,Map<String,List<String>> mapMultipleCountryCode,User user){//chirag
    
        Map<string,BAT_MobileFormatValidationConfiguration__mdt> mobileFormatMap = new Map<string,BAT_MobileFormatValidationConfiguration__mdt>();
        if(!countrySet.isEmpty()){
            for(BAT_MobileFormatValidationConfiguration__mdt rec : [select DeveloperName,BAT_PrefixFormat__c,BAT_MinNumberOfDigits__c,
                                                                   BAT_MaxNumberOfDigits__c,BAT_MobileNumberFormatErrorMessage__c,
                                                                   BAT_DuplicateMobileCheckEnabledProfiles__c,
                                                                   BAT_isInternational__c,
                                                                   BAT_MobileNumberChangedErrorMessage__c ,
                                                                   BAT_MobileNumberFormatErrorMsgEnglish__c, MasterLabel,BAT_Default__c ////chirag added masterlabel to query
                                                                   from BAT_MobileFormatValidationConfiguration__mdt 
                                                                   where MasterLabel IN: countrySet]){ //chirag changed developername to masterlabel
                                 if(user!=null && user.country__c !=null && user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_SK) && rec.MasterLabel.equalsIgnoreCase(BAT_ConstantsUtility.Country_SK)){
                                     if(rec.BAT_Default__c && mobileFormatMap.get(rec.MasterLabel)==null){
                                         mobileFormatMap.put(rec.MasterLabel,rec);
                                         continue;
                                     } 
                                     else if(mapMultipleCountryCode!=null && mapMultipleCountryCode.get(BAT_ConstantsUtility.Country_SK)!=null 
                                             && mapMultipleCountryCode.get(BAT_ConstantsUtility.Country_SK)[0].substring(0,rec.BAT_PrefixFormat__c.length()).equalsIgnoreCase(rec.BAT_PrefixFormat__c)
                                             && user.BAT_IsAllowedMultiCountryMobile__c){
                                                    mobileFormatMap.put(rec.MasterLabel,rec);
                                                    continue;
                                     }
                                     continue;
                                                    
                                }
                                                                       
                mobileFormatMap.put(rec.MasterLabel,rec);        //chirag changed developername to masterlabel                                              
            }
        }
        return mobileFormatMap;
        
    }
/********************************************************************************************************
* @author        : Deloitte
* @method Name   : getGlobalEnableSMSDetails
* @returns       : Map<BAT_GlobalEnableSMSConfiguration__mdt>
* @params        : Set<string>
* @description   : [All Market] : Retrieves GlobalEnableSMS custom metadata records based on country 
* @changeHistory : 22.04.2019 / Tejaswi Nissankula / created the method
                   26th May,2020/Abhishek Kashyap/US-128051- Updated the query to retrieve 
                    BAT_IsBrandDependent__c, BAT_DefaultCountryCode__c
                   9th June,2020/Abhishek Kashyap/US-136771,134073- Updated query to retrieve BAT_BypassLeadAssignmentProfiles__c,
                    BAT_EnableMultiBrandSelection__c
                    13-10-2020/Allada Yeshwanth/ US:#298151   updated the query to retrieve BAT_isBypassDisabled__c,BAT_Bypass_Disabled_Profiles__c,BAT_Brand_Disabled_Profiles__c 
*********************************************************************************************************/
    
    public static Map<string,BAT_GlobalEnableSMSConfiguration__mdt> getGlobalEnableSMSDetails(Set<string> countrySet){
        
        Map<string,BAT_GlobalEnableSMSConfiguration__mdt> globalSMSCountryMap = new Map<string,BAT_GlobalEnableSMSConfiguration__mdt>();
        if(!countrySet.isEmpty()){
            //26th May,2020/Abhishek Kashyap/US-128051- Updated the query to retrieve BAT_IsBrandDependent__c, BAT_DefaultCountryCode__c
            //13-10-2020/Allada Yeshwanth/ US:#298151   updated the query to retrieve BAT_isBypassDisabled__c,BAT_Bypass_Disabled_Profiles__c,BAT_Brand_Disabled_Profiles__c 
            for(BAT_GlobalEnableSMSConfiguration__mdt rec : [select DeveloperName,BAT_IsSendMobileVerificationSMSEnabled__c,
                                                                    BAT_ScopeOfRecordTypesOnAccount__c,BAT_ScopeOfRecordTypesOnLead__c,
                                                                    BAT_IsBrandDependent__c, BAT_DefaultCountryCode__c,BAT_BypassLeadAssignmentProfiles__c,
                                                                    BAT_EnableMultiBrandSelection__c, BAT_IsEnableForAdmin__c,
                                                                    BAT_isBypassDisabled__c,BAT_BypassDisabledProfiles__c,BAT_BrandDisabledProfiles__c
                                                                    from BAT_GlobalEnableSMSConfiguration__mdt
                                                                    where DeveloperName =: countrySet]){
                    globalSMSCountryMap.put(rec.DeveloperName,rec);                                                      
            }
            
        }
        return globalSMSCountryMap;
        
    }   

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : fetchRetailerPointTableMetadata
    * @returns       : void
    * @params        : null
    * @description   : [All Market] Method used to fetch the Custom Metdata BAT_RetailerTable__mdt.
    * @changeHistory : 15.04.2019 / Akshata Rajmane / created the method
    *                  25.10.2019 / Sri P/ Added Condition to get Country values from Metadata Records
                       28/04/2020/Souvik Dinda/ US#116614 - Populating Set of Model from the Model names mentioned against the records for model specific point system
                        in BAT_RetailerPointTable__mdt.
                       05.10.2020/ Saurabh Sharma/ US227850 - added if else loop to add cluster value containing point 0 for no reward
                       23.10.2020/Saurabh Sharma/ US227850 - Replaced BAT_Cluster__c to  BAT_ClusterName__c
                       16.01.2021/Souvik Dinda/US#346313 - Added logic to dynamically check the AccountSource and store in a set for dynamic pointConditionName formation. 
                       21.05.2021/Souvik Dinda/US#451955-Modified method to accomodate records for Point value 0 for all the markets.
                       26.07.2022/Rama Akella/Bug#1078354 - Made the method parameterized with countrySet to optimize the for loop.
                       02.08.2022/Rama Akella/Bug#1078354 - Updated the query to retrieve 'Global' metadata along with the market metadata 
    *********************************************************************************************************/
    public static void fetchRetailerPointTableMetadata(Set<String> countrySet){
    if(mapOfConditionToRecords.isEmpty() && pointValueMap.isEmpty()){
        
        /*
        for (BAT_RetailerPointTable__mdt metadata: [select id, BAT_ConditionName__c, BAT_PointValue__c,
                                                    BAT_FieldAPIName__c,BAT_FieldLabel__c,BAT_ObjectName__c, BAT_AnonimoPointsAssignmentGLoPOS__c, BAT_CountryName__c,
                                                    BAT_Model__c, BAT_ClusterName__c, BAT_AccountSource__c, BAT_CouponCode__c
                                                    FROM BAT_RetailerPointTable__mdt where (BAT_CountryName__c in :countrySet or BAT_CountryName__c = :BAT_ConstantsUtility.GL_COUNTRY_CODE) order by BAT_ObjectName__c Desc,BAT_FieldAPIName__c desc]) 
        { */
        List<BAT_RetailerPointDirectory__c> metadataList = [SELECT Id, BAT_ConditionName__c, BAT_PointValue__c, BAT_FieldAPIName__c, BAT_FieldLabel__c, BAT_ObjectName__c, BAT_AnonimoPointsAssignmentGLoPOS__c, BAT_CountryName__c, BAT_Model__c, BAT_ClusterName__c, BAT_AccountSource__c, BAT_CouponCode__c
                                                   FROM BAT_RetailerPointDirectory__c 
                                                   WHERE (BAT_CountryName__c IN :countrySet OR BAT_CountryName__c = :BAT_ConstantsUtility.GL_COUNTRY_CODE)
                                                   ORDER BY BAT_ObjectName__c DESC, BAT_FieldAPIName__c DESC];
        for (BAT_RetailerPointDirectory__c metadata: metadataList) 
        {
            System.debug('>>ConditionName' + metadata.BAT_ConditionName__c);
            //US#451955-Changed the condition to accomodate records with Point Value 0 and above.
            if(metadata.BAT_PointValue__c != null && metadata.BAT_FieldLabel__c == null 
               && metadata.BAT_FieldAPIName__c == null && metadata.BAT_ObjectName__c == null && metadata.BAT_ClusterName__c == null)
            {
                pointValueMap.put(metadata.BAT_ConditionName__c, String.ValueOf(metadata.BAT_PointValue__c));  
                //US#116614 - Added to store the Model names which needs specific Points other than the usual Point System according to the country
                if(metadata.BAT_Model__c != null && metadata.BAT_CountryName__c != null){
                    modelNameSet.add(metadata.BAT_CountryName__c + BAT_ConstantsUtility.STR_COLON + metadata.BAT_Model__c);
                }
                //Souvik Dinda/US#346313 - Added logic to dynamically check the AccountSource and store in a set.
                if(metadata.BAT_AccountSource__c != null && metadata.BAT_CountryName__c != null){
                    accSourceNameSet.add(metadata.BAT_CountryName__c + BAT_ConstantsUtility.STR_COLON + metadata.BAT_AccountSource__c);
                }
                  if(metadata.BAT_CouponCode__c != null && metadata.BAT_CountryName__c != null){
                    couponCodeSet.add(metadata.BAT_CountryName__c + BAT_ConstantsUtility.STR_COLON + metadata.BAT_CouponCode__c.split(BAT_ConstantsUtility.HYPHEN)[0]);
                }
            }       
            //the else if will ensure cluster with 0 points are added into the pointvaluemap
            else if(metadata.BAT_ClusterName__c !=null ){
                pointValueMap.put(metadata.BAT_ConditionName__c, String.ValueOf(metadata.BAT_PointValue__c)); 
                
                 if(metadata.BAT_Model__c != null && metadata.BAT_CountryName__c != null){
                    modelNameSet.add(metadata.BAT_CountryName__c + BAT_ConstantsUtility.STR_COLON + metadata.BAT_Model__c);
                }
                //Souvik Dinda/US#346313 - Added logic to dynamically check the AccountSource and store in a set.
                if(metadata.BAT_AccountSource__c != null && metadata.BAT_CountryName__c != null){
                    accSourceNameSet.add(metadata.BAT_CountryName__c + BAT_ConstantsUtility.STR_COLON + metadata.BAT_AccountSource__c);
                }
                 if(metadata.BAT_CouponCode__c != null && metadata.BAT_CountryName__c != null){
                    couponCodeSet.add(metadata.BAT_CountryName__c + BAT_ConstantsUtility.STR_COLON + metadata.BAT_CouponCode__c.split(BAT_ConstantsUtility.HYPHEN)[0]);
                }
            }
            
            //US#451955-Changed the condition to accomodate records with Point Value 0 which are needed for Reason generation in Point object.
            if(metadata.BAT_PointValue__c!= null && metadata.BAT_PointValue__c == 0
              && metadata.BAT_FieldLabel__c != null && metadata.BAT_FieldAPIName__c != null && metadata.BAT_ObjectName__c != null){
                if(!mapOfConditionToRecords.containsKey(metadata.BAT_ConditionName__c))
                {
                    system.debug('TestingmapOfConditionToRecords'+mapOfConditionToRecords);
                    //mapOfConditionToRecords.put(metadata.BAT_ConditionName__c ,new List<BAT_RetailerPointTable__mdt>());
                    mapOfConditionToRecords.put(metadata.BAT_ConditionName__c ,new List<BAT_RetailerPointDirectory__c>());
                }
                mapOfConditionToRecords.get(metadata.BAT_ConditionName__c).add(metadata); 
                   system.debug('TestingmapOfConditionToRecords1'+mapOfConditionToRecords);
            }
            if(metadata.BAT_CouponCode__c != null){
                if(!mapOfCouponCodeConditions.containsKey(metadata.BAT_ConditionName__c))
                {
                    //mapOfCouponCodeConditions.put(metadata.BAT_ConditionName__c ,new List<BAT_RetailerPointTable__mdt>());
                    mapOfCouponCodeConditions.put(metadata.BAT_ConditionName__c ,new List<BAT_RetailerPointDirectory__c>());
                }
                mapOfCouponCodeConditions.get(metadata.BAT_ConditionName__c).add(metadata);
                
                couponCodePicklistValuesMap.put(metadata.BAT_CouponCode__c.split(BAT_ConstantsUtility.HYPHEN)[1],metadata.BAT_CouponCode__c.split(BAT_ConstantsUtility.HYPHEN)[0]);
            }
        }
      }     
    } 
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : fetchExternalAssetSourceConfiguration
    * @returns       : void
    * @params        : Country Set from Asset Trigger Handler
    * @description   : [All Market] Method used to fetch the Custom Metdata BAT_ExternalAssetSourceConfiguration__mdt.
    * @changeHistory : 04.11.2019 / Rajesh/ Created Method
                     : 20.04.2021/ Souvik Dinda/US#457163: Logic to populate assetSourceProfileNameMap for checking the profile name of the asset created per country.
    *********************************************************************************************************/
     public static  Map<String,BAT_ExternalAssetSourceConfiguration__mdt> fetchExternalAssetSourceConfiguration(){
        Map<String,BAT_ExternalAssetSourceConfiguration__mdt> countryToAssetSourceMap = new  Map<String,BAT_ExternalAssetSourceConfiguration__mdt>();
        for (BAT_ExternalAssetSourceConfiguration__mdt  metadata: [select id, MasterLabel , BAT_AssetSource__c,
                                                                    BAT_IsCaseRequired__c,BAT_DefaultGLOAccount__c,  
                                                                    BAT_IsCaseRequiredOnUpdate__c,BAT_IntegrationUserName__c,
                                                                    BAT_Profiles__c
                                                                    FROM BAT_ExternalAssetSourceConfiguration__mdt ])
        {
            countryToAssetSourceMap.put(metadata.MasterLabel,metadata);
            if(metadata.BAT_Profiles__c != null){
                Set<String> profileNameSet = new Set<String>(metadata.BAT_Profiles__c.split(BAT_ConstantsUtility.COMMA_STR));
                assetSourceProfileNameMap.put(metadata.MasterLabel, profileNameSet);
            }
        }
               return countryToAssetSourceMap;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGloAnonymoDetails
    * @returns       : void
    * @description   : [IT GR ES Marketa] Method used to fetch the Custom Metdata BAT_DefaultRetailerPointCriteria__mdt.
    * @changeHistory : 15.11.2019 / Rajesh/ Created Method
                       5th Feb,2021 / Akshata Rajmane / US#387269: Added field BAT_DefaultVuseAccount__c to query
    *********************************************************************************************************/
    public static  Map<String,BAT_DefaultRetailerPointCriteria__mdt> getGloAnonymoDetails(){
        Map<String,BAT_DefaultRetailerPointCriteria__mdt> countryBasedGloAccMap= new  Map<String,BAT_DefaultRetailerPointCriteria__mdt>();
        for (BAT_DefaultRetailerPointCriteria__mdt metadata: [select id, MasterLabel , BAT_UserProfiles__c,
                                                                    BAT_RewardProfile__c,BAT_DefaultGLOAccount__c,BAT_DefaultVuseAccount__c 
                                                                    FROM BAT_DefaultRetailerPointCriteria__mdt])
        {
            countryBasedGloAccMap.put(metadata.MasterLabel,metadata);
        }
               return countryBasedGloAccMap;
    }
    
     /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getAccountsofAssets 
    *@ returns:        List<Account> : Accounts of Assets
    *@ params:         List<Asset> : Assets of trigger.new
    *@description:     [All Markets] Method to return Account of assets in 'trigger.new'
    *@changeHistory:   08.04.2019/Shreeyanshu/Created the method
               09/08/2019 / Souvik Dinda / US#34105: Added  FirstName and LastName to be retrieved from account.
               21.08.2019/Tejaswi Nissankula/Added 'PersonMobilePhone' fied in account query
               17/01/2020/Edwin Resendiz/ Removed inner query to avoid SOQL rows limit.
    ************************************************************************************************************************************/
    public static List<Account> getAccountsofAssets(List<Asset> assets){
        Set<Id> setAccountId = new Set<Id>();
        List<Account> lstAccounts = new List<Account>();
        
        //Adding Account Ids of Assets in a set
        for(Asset objAssetRec : assets){           
            if(objAssetRec.AccountId != null){
                setAccountId.add(objAssetRec.AccountId);
            }
        }  
        //Integer to store number of rows remaining through SOQL query in current context
        Integer numberOfRowsRemaining = Limits.getLimitQueryRows() - Limits.getQueryRows();
        
        //Querying Account records from the account ids stored in setAccountId
        if(!setAccountId.isEmpty()){
            lstAccounts = [Select Id,PersonMobilePhone,BAT_THPStatus__c,BAT_VapeStatus__c,Brand_House__c,Country__c,RecordTypeId,Is_Trialist__c, FirstName, LastName,PersonEmail,Registration_Permission__c From Account Where Id IN: setAccountId LIMIT: numberOfRowsRemaining];
        }
        return lstAccounts;
    }

    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getAssetsOfAccount 
    *@ returns:        List<AggregateResult> : AggrateResult
    *@ params:         List<Account> lstAccounts : Accounts of getAccountsofAssets
    *@description:     [All Markets] Method to return counts of the assets by Brand
    *@changeHistory:
    *[PL] 25.08.2020/ Mallik Balla/ Bug Fix #268389 - changed the parameters from ID, AggregateResult to String, AggregateResult & Modified to set the key as accountID+:+brand
    ************************************************************************************************************************************/
    public static Map<String, AggregateResult> getAssetsOfAccount(List<Account> lstAccounts) {
        Map<String, AggregateResult> mapAggregates = new  Map<String, AggregateResult>();
        List<Id> lstAccountIds = new List<Id>();
        List<AggregateResult> lstAssetCounts = new List<AggregateResult>();
        Id accountId;
        String brand;
        if(!lstAccounts.isEmpty()){
            for(Account acc : lstAccounts) {
                lstAccountIds.add(acc.Id);
            }
            lstAssetCounts = [SELECT COUNT(Id) assets, 
                            AccountId accountId,
                            BAT_Brand__c brand
                            FROM Asset 
                            WHERE AccountId=:lstAccountIds AND First_Device__c = TRUE
                            GROUP BY ROLLUP (AccountId, BAT_Brand__c)];
            for(AggregateResult agg : lstAssetCounts) {
                accountId = (Id) agg.get(BAT_ConstantsUtility.ASSET_AGGREGATE_ACCOUNTID);
                brand = (String) agg.get(BAT_ConstantsUtility.ASSET_AGGREGATE_BRAND);
                if(String.isNotEmpty(brand)){
                    mapAggregates.put(accountId+BAT_ConstantsUtility.STR_COLON+brand, agg);//25.08.2020/ Mallik Balla/ Bug Fix #268389  - Modified to set the key as accountID+:+brand
                }
            }
        }
        return mapAggregates;
    }

     /************************************************************************************************************************************
    *@ author:         ITC  
    *@ method:         getAllExistingAssets 
    *@ returns:        Map<Id, List<Asset>>
    *@ params:         List<Account> lstAccounts
    *@description:     [IT] Method to return assets by AccountId
    *@changeHistory:    2.10.2023//Chirag Kalra// Created the Method
   
    ************************************************************************************************************************************/
    public static Map<Id, List<Asset>> getAllExistingAssets(List<Account> lstAccounts) {
        List<Id> lstAccountIds = new List<Id>();
        Map<Id, List<Asset>> accountIdWithAssetMap = new Map<Id, List<Asset>>();
        List<Asset> assetList = new List<Asset>();
        if(!lstAccounts.isEmpty()){
            for(Account acc : lstAccounts) {
                lstAccountIds.add(acc.Id);
            }
            assetList = [SELECT   Id,BAT_Brand__c, AccountId FROM Asset  WHERE AccountId=:lstAccountIds];
            
        }
        for(Asset assetRec:assetList  ){
            if(accountIdWithAssetMap.containsKey(assetRec.Id)){
                accountIdWithAssetMap.get(assetRec.Id).add(assetRec);

            }
            else{
                List<Asset> assetMapList = new List<Asset>();
                assetMapList.add(assetRec) ;
                accountIdWithAssetMap.put(assetRec.AccountId,assetMapList);
            }
        }
        return accountIdWithAssetMap;
    }

    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getMapAssetOfAccounts 
    *@ returns:        Map<Id, List<Asset>> : Assets by AccountId
    *@ params:         Set<Id> : Accountids of Current Assets.
    *@description:     [All Markets] Method to return Map of the assets with account.
    *@changeHistory:   09/03/2020/ Rajesh Potla/ US#83887 : Changed getMapAssetOfAccounts method param from List<Account> to set<id>.
                        14-4-2022/ Praveen / US #844762/ PL - First device logic change/ Added the country set to check whether to consider brands for first device logic
    ************************************************************************************************************************************/
    public static Map<String, List<Asset>> getMapAssetOfAccounts(Set<Id> accountIdSet,Set<String> brandBasedDevicesCountries) {
        Map<String, List<Asset>> mapAssets = new Map<String, List<Asset>>();
        List<Asset> lstAllAssets = new List<Asset>();
        Integer numberOfRowsRemaining = Limits.getLimitQueryRows() - Limits.getQueryRows();
        
        if(!accountIdSet.isEmpty()) {
            
            lstAllAssets = [Select Id, 
                            First_Device__c,Type__c, 
                            BAT_Brand__c, Country__c,
                            AccountId From Asset 
                            WHERE Type__c =:BAT_ConstantsUtility.ASSET_TYPE_SOLD
                            AND First_Device__c =: BAT_ConstantsUtility.BOOLEANTRUE  
                            AND AccountId=:accountIdSet LIMIT : numberOfRowsRemaining];
            for(Asset objAsset : lstAllAssets) {
                List<Asset> currentAssets = new List<Asset>();
                String key = brandBasedDevicesCountries.contains(objAsset.Country__c) ? objAsset.AccountId + objAsset.BAT_Brand__c: objAsset.AccountId;
                if(!mapAssets.containsKey(key)){
                    currentAssets.add(objAsset);
                    mapAssets.put(key, currentAssets);
                } else {
                    currentAssets = mapAssets.get(key);
                    currentAssets.add(objAsset);
                    mapAssets.put(key, currentAssets);
                }
            }
        }

        return mapAssets;
    }

    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         isSandbox 
    *@ returns:        boolean
    *@ params:         void
    *@description:     [All Markets] Method to return boolean if code is running in sandbox
    *@changeHistory:   02.05.2019/Akshata Rajmane/Created the method
    ************************************************************************************************************************************/
    public static Boolean isSandbox() {
        return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
    }


    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         ownStoreOrderUpdate @future
    *@ returns:        void
    *@ params:         Id
    *@description:     [All Markets] US#:16274, BUGFIX #20836 Update Order Status to 'Complete', once set it creates the Asset automatically 
                       from Order Trigger Handler. Reason for making this method future, as we many objects 
                       getting inserted/updated from ownStore portal in one thread which may cause Too many SOQLs.
    *@changeHistory:   03.05.2019/Sudaif Haider/Created the method
    ************************************************************************************************************************************/
    @future
    public static void ownStoreOrderUpdate(Id newOrderId){
        List<Order> newOrderList = [Select Id,Status from Order where Id = :newOrderId];
        if(!newOrderList.isEmpty()){
            Order ord = newOrderList.get(0);
            ord.Status = BAT_ConstantsUtility.COMPLETE_STR ;
            update ord;
        }
    }
    /************************************************************************************************************************************
    *@author:         Deloitte  
    *@method:         isNEAPortalProfile 
    *@returns:        boolean
    *@params:         string
    *@description:    [NEA]: US#27175 method check the profile of current user,if its any of NEA portal profile return True
    *@changeHistory:  26.06.2019/Mohit Maghanani/Created the method
    ************************************************************************************************************************************/
    public static Boolean isNEAPortalProfile (string currentProfileName){
        Set<String> neaCountrySet = new set<String>{BAT_ConstantsUtility.DK_STR,BAT_ConstantsUtility.SE_STR,BAT_ConstantsUtility.NL_STR};
        if(profileNameSetForNEAPortal.isEmpty()) {
            for(All_Countries_Profile_Configuration__mdt profileNameMetaData : [select MasterLabel from All_Countries_Profile_Configuration__mdt 
                                                                                where BAT_Type__c = : BAT_ConstantsUtility.BAT_NEA_PORTAL_PROFILE_TYPE 
                                                                                and BAT_Country__c IN :neaCountrySet]){
                                                                                    profileNameSetForNEAPortal.add(profileNameMetaData.MasterLabel);
                                                                                }
        }
        if(profileNameSetForNEAPortal.contains(currentProfileName)){
            return true;
        }
        return false;
    }
    /************************************************************************************************************************************
    *@author:         Deloitte  
    *@method:         runOnce
    *@returns:        boolean
    *@params:         void
    *@description:    method will set static boolean variable value to true if trigger is called multiple times ,
                      which will skip the code execution.
    *@changeHistory:   08.05.2019/ Akshata Rajmane/Created the method
    ************************************************************************************************************************************/
    public static boolean skipTriggerRun(){
        if(!skipTriggerRun){
            skipTriggerRun = true;
            return false;
        }else{
            return skipTriggerRun;
        }
    }
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         stampDateTimeOnConsentChange 
*@ returns:        Void
*@ params:         String objName : API name of the object for which the method will be called
           Set<String> countrySet : Country code of the records
           List<SObject> updatedRecord : List of records to be updated
           Map<ID, SObject> oldSObjectMap : Map of record with previous values. 
*@description:     [All Markets] On change of consent chekbox on Account or Lead, the methos stamps date and time on respective date time field.
*@changeHistory:   30.05.2019/DE :Sprint16 : 13295 Abhishek Kashyap/Created the method
                   10.12.2019/CA: Sprint-2: US #64691/Osheen Sahajpal/Updating the condition to make it work on record creation.
                   10/08/2020/ Akshata Rajmane /FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes
                 23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields 
                 21.10.2021/Idrees Ali/MY-Vuse:US#738037 - Rectified duplicate if checks in 'stampDateTimeOnConsentChange' method
                 Idrees Ali / PT Glo : Sprint 1 : US #890804 - Extended below logic for PT too as consent date should be updated for both create and update
                 24.03.2021/Pratishtha Pathak//ZA : Sprint 99 : Bypass BAT_IsOnCreate__c for ZA in update logic
                 30.05.2022/Idrees Ali/ENH:US#950373 - Vuse UK Modi - Added field type logic to consider not only Date/Time but also Date type fields
                 10.08.2022/Anna Gomez/ENH-IT: US#1068152 - Added logic to allow Consent Date field update to null
                 14.09.2022/ Debasis Maharana / BUG#1104167 I added the for loop because if we keep calling getFieldType() within the two for loops, then it is becoming n-squared time complexity.
************************************************************************************************************************************/
    public static void stampDateTimeOnConsentChange(String objName, Set<String> countrySet, List<SObject> updatedRecord, Map<ID, SObject> oldSObjectMap){
        List<BAT_ConsentStructure__mdt> consentList = new List<BAT_ConsentStructure__mdt>();
        //Abhishek Kashyap/DE :Sprint16 : 13295 The query gets all the consent field API names, respective date/time field API names and country code from the metadata.
        /* FR:Sprint 3 : US#302771 : Added new fields in the query :BAT_ConsentFieldValue__c,BAT_IsOnCreate__c */
        consentList = [Select BAT_ConsentDateTimeField__c,BAT_ConsentStatusField__c,BAT_ConsentFieldValue__c,BAT_IsOnCreate__c,BAT_ConsentField__c,BAT_UpdateToNull__c, MasterLabel,BAT_Object__c From BAT_ConsentStructure__mdt Where MasterLabel In: countrySet And BAT_Object__c =: objName];
        Map<String,BAT_CountryRegionConfiguration__mdt> countryRegionNEAMap = new Map<String,BAT_CountryRegionConfiguration__mdt>();
          for(BAT_CountryRegionConfiguration__mdt neaCountryRegion : [select id,DeveloperName from BAT_CountryRegionConfiguration__mdt 
                                                                               where BAT_Region__c =: BAT_ConstantsUtility.NEA_STR]){
                   if(!countryRegionNEAMap.containsKey(neaCountryRegion.DeveloperName)){
                      countryRegionNEAMap.put(neaCountryRegion.DeveloperName,neaCountryRegion); 
                   }
            }
        // 14.09.2022/ Debasis Maharana / BUG#1104167 I added the for loop because if we keep calling getFieldType() within the two for loops, then it is becoming n-squared time complexity.
        Map<String, String> fieldType = new Map<String, String>();
        for(BAT_ConsentStructure__mdt consentMdtObj : consentList){
            fieldType.put(String.valueOf(consentMdtObj.BAT_ConsentDateTimeField__c),String.valueOf(Schema.getGlobalDescribe() 
                                        .get(objName)
                                        .getDescribe()
                                        .fields
                                        .getMap()
                                        .get(String.valueOf(consentMdtObj.BAT_ConsentDateTimeField__c))
                                        .getDescribe()
                                        .getType()));
        }

       //Abhishek Kashyap/DE :Sprint16 : 13295 This loop iterates on the list of Account/Lead records which are being updated to check for change in consent fields
        for(SObject updatedObj : updatedRecord){
            //Abhishek Kashyap/DE :Sprint16 : 13295 This loop iterates on the list of metadata records and provide API names which is required to be used with Account/Lead records
            for(BAT_ConsentStructure__mdt consentObj : consentList){
                String consentFieldType =  fieldType.get(consentObj.BAT_ConsentDateTimeField__c);
                //Abhishek Kashyap/DE :Sprint16 : 13295 This condition checks whether the Account/Lead record is of the country listed in the metadata or not and whether their consent fields have changed or not
                /* FR:Sprint 3 : US#302771 : added on create check to identify the update*/
                //Pratishtha Pathak//ZA : Sprint 99 : Bypass BAT_IsOnCreate__c for ZA in update logic
                if(oldSObjectMap!=null && ((!consentObj.BAT_IsOnCreate__c && String.valueOf(updatedObj.get(BAT_ConstantsUtility.COUNTRY))!= BAT_ConstantsUtility.COUNTRY_ZA) || (String.valueOf(updatedObj.get(BAT_ConstantsUtility.COUNTRY))== BAT_ConstantsUtility.COUNTRY_ZA)) && !countryRegionNEAMap.containsKey(String.valueOf(updatedObj.get(BAT_ConstantsUtility.COUNTRY))) && 
                   updatedObj.get(BAT_ConstantsUtility.COUNTRY) == consentObj.MasterLabel && 
                   updatedObj.get(consentObj.BAT_ConsentField__c) != oldSObjectMap.get(updatedObj.Id).get(consentObj.BAT_ConsentField__c)){
                       //Abhishek Kashyap/DE :Sprint16 : 13295 If the consent fields have changed then their respective date/time fields are set with latest time stamp.
                       /* FR:Sprint 3 : US#302771 : added if condition of field value to byapss this for other markets
                            if the consent updated to the field value mentioned in the metadata code will update the respective consent optin or 
                            or opt out date time field mentioned in the metadata*/
                       if(String.isBlank(consentObj.BAT_ConsentFieldValue__c))
                       {
                           //Abhishek Kashyap/DE :Sprint16 : 13295 If the consent fields have changed then their respective date/time fields are set with latest time stamp.
                           //30.05.2022/Idrees Ali/ENH:US#950373 - Vuse UK Modi - Added field type logic to consider not only Date/Time but also Date type fields
                           if(String.isNotBlank(consentFieldType) && consentFieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATETIME_STR))
                               updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, datetime.now());
                           else
                               updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, Date.today());
                       }
                       else if(String.valueOf(updatedObj.get(consentObj.BAT_ConsentField__c)) == String.valueOf(consentObj.BAT_ConsentFieldValue__c))
                       {
                           if(String.isNotBlank(consentFieldType) && consentFieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATETIME_STR))
                               updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, datetime.now());
                           //10.08.2022/Anna Gomez/ENH-IT: US#1068152 - Added logic to allow Consent Date field update to null
                           else if(consentObj.BAT_UpdateToNull__c)
                                updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, null);
                           else
                               updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, Date.today());
                       }
            
                   }/*FR:Sprint 3 : US#302771 :  else if will execute only for the create scenario*/
                    //30.05.2022/Idrees Ali/ENH:US#950373 - Vuse UK Modi - Added field type logic to consider not only Date/Time but also Date type fields
                else if(oldSObjectMap ==null && consentObj.BAT_IsOnCreate__c && String.valueOf(updatedObj.get(consentObj.BAT_ConsentField__c)) == String.valueOf(consentObj.BAT_ConsentFieldValue__c)){
                    if(String.isNotBlank(consentFieldType) && consentFieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATETIME_STR))
                        updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, datetime.now());
                    else
                        updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, Date.today());
                }
                // Sprint 2 - added as part of NEA user story 25769
                //Idrees Ali / PT Glo : Sprint 1 : US #890804 - Extended below logic for PT too as consent date should be updated for both create and update
                //Idrees Ali/ENH-CA: US#821197 - Added CA check for VUSE_ITCAN consent field to allow consent date to be updated for both create and update when value is TRUE
                //Ishita Kotian / SE Moor : US #1004483 - Added functionality for Last Consent Date being updated with current datetime even if the consent is opted out for Sweden Market
                //Akshata Rajmane / UAT Bug #1028411 : Added condition for SE to work it for last consent date update on false consent
                if((countryRegionNEAMap.containsKey(String.valueOf(updatedObj.get(BAT_ConstantsUtility.COUNTRY))) || (updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.COUNTRY_PT)||
                   (updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.COUNTRY_CA_STR && consentObj.BAT_ConsentField__c.equalsIgnoreCase(BAT_ConstantsUtility.IsVuseOptInEmailCommunication_API_Name))) && 
                   (oldSObjectMap == null || (oldSObjectMap!=null && updatedObj.get(consentObj.BAT_ConsentField__c) != oldSObjectMap.get(updatedObj.Id).get(consentObj.BAT_ConsentField__c))) && 
                   (updatedObj.get(consentObj.BAT_ConsentField__c) == true ||(updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.SE_STR 
                   && consentObj.BAT_ConsentDateTimeField__c == BAT_ConstantsUtility.LASTCONSENTDATE ))){
                   /*if((countryRegionNEAMap.containsKey(String.valueOf(updatedObj.get(BAT_ConstantsUtility.COUNTRY))) || (updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.COUNTRY_PT)||
                   (updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.COUNTRY_CA_STR && consentObj.BAT_ConsentField__c.equalsIgnoreCase(BAT_ConstantsUtility.IsVuseOptInEmailCommunication_API_Name))) && 
                   (oldSObjectMap == null || (oldSObjectMap!=null && updatedObj.get(consentObj.BAT_ConsentField__c) != oldSObjectMap.get(updatedObj.Id).get(consentObj.BAT_ConsentField__c))) && 
                   updatedObj.get(consentObj.BAT_ConsentField__c) == true && (consentObj.BAT_Object__c.equalsIgnoreCase(BAT_ConstantsUtility.ACCOUNT_STR) && consentObj.BAT_ConsentField__c==BAT_ConstantsUtility.EMAILOPTOUT && consentObj.BAT_ConsentDateTimeField__c == BAT_ConstantsUtility.LASTCONSENTDATE && !(updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.SE_STR ||updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.DK_STR))){ 
                       /*if((countryRegionNEAMap.containsKey(String.valueOf(updatedObj.get(BAT_ConstantsUtility.COUNTRY))) || (updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.COUNTRY_PT)||
                   (updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.COUNTRY_CA_STR && consentObj.BAT_ConsentField__c.equalsIgnoreCase(BAT_ConstantsUtility.IsVuseOptInEmailCommunication_API_Name))) && 
                   (oldSObjectMap == null  && 
                   (updatedObj.get(consentObj.BAT_ConsentField__c) == true ||(updatedObj.get(BAT_ConstantsUtility.COUNTRY) == BAT_ConstantsUtility.SE_STR 
                   && consentObj.BAT_ConsentDateTimeField__c == BAT_ConstantsUtility.LASTCONSENTDATE )))){*/
                       system.debug('checkingupdated'+updatedObj.get(consentObj.BAT_ConsentField__c));
                        system.debug('checkconsentObj'+consentObj);
                       updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, datetime.now());
                       system.debug('checking'+updatedObj.put(consentObj.BAT_ConsentDateTimeField__c, datetime.now()));
                       // NEA - Sprint 3-added as part of US # 31846
                       if(oldSObjectMap!=null && 
                          String.valueOf(updatedObj.get(BAT_ConstantsUtility.BAT_LastModifiedSource_FieldAPI)) == BAT_ConstantsUtility.BAT_NEA_LASTMODIFIEDSOURCE_1to1Portal && 
                          String.valueOf(updatedObj.get(consentObj.BAT_ConsentStatusField__c)) != BAT_ConstantsUtility.ORAL_STATUS_TRIALIST &&
                          String.valueOf(updatedObj.get(consentObj.BAT_ConsentStatusField__c)) != BAT_ConstantsUtility.VYPE_STATUS_CONSUMER){
                              updatedObj.put(consentObj.BAT_ConsentStatusField__c, BAT_ConstantsUtility.ORAL_VYPE_STATUS);
                          }
                       
                   }
                
            }
        }
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : generateRandomNumber
    * @returns       : String 
    * @params        : String noOfDigit
    * @description   :  Used to generate the Random Number
    * @changeHistory : 11.06.2019 / Rajesh Potla/ created the method
    
    *********************************************************************************************************/
    public static String generateRandomNumber(String noOfDigit){
        String OTP = BAT_ConstantsUtility.BLANK;
        OTP =String.valueOf((integer)(Math.ceil(Math.random()*9)));
        for(integer j = 1; j<Integer.valueOf(noOfDigit); j++) {
            OTP += String.valueOf((integer)(Math.ceil(Math.random()*9)));
        }
        return OTP;
    }
    /************************************************************************************************************************************
        *@ author:         Deloitte  
        *@ method:         getProductAndRangeList 
        *@ returns:        List<Product2>
        *@ params:         Set<String> countrySet
        *@description:     [All Markets] 
        *@changeHistory:   Osheen - Created this method to fetch Product Details
    ************************************************************************************************************************************/    
    public static List<Product2> getProductAndRangeList(String country){
        List<Product2> productAndRangeList = [Select Name, Range__c, id, country__c, Brand__c, recordType.DeveloperName,eCommerce_Name__c from product2 where country__c = :country AND  Range__c!=null 
                                           AND (recordType.DeveloperName = :BAT_ConstantsUtility.RANGE_RECTYPE OR recordType.DeveloperName = :BAT_ConstantsUtility.PRODUCT_RECTYPE)
                                           AND IsActive=true ORDER BY BAT_Sort__c NULLS LAST,Name];
        return productAndRangeList;
    }
    /************************************************************************************************************************************
        *@ author:         Deloitte  
        *@ method:         getPriceBookEntryList 
        *@ returns:        List<PriceBookEntry>
        *@ params:         String country
        *@description:     [All Markets] 
        *@changeHistory:   Osheen - Created this method to fetch PricebookEntries
                           07.05.2020/Tejaswi Nissankula/NEA:US#124550:Added Pricebook2.Channel__c filter to make sure the query returns only 1:1 Portal 
                          related pricebook entries.
    ************************************************************************************************************************************/
    public static List<PriceBookEntry> getPriceBookEntryList(String country){
        List<PriceBookEntry> priceBookEntryList = [Select Id, Product2Id, Pricebook2Id, Pricebook2.Country__c from pricebookentry where Pricebook2.Country__c = :country and isActive = true and Pricebook2.Channel__c INCLUDES (:BAT_ConstantsUtility.BAT_NEA_PRICEBOOK_CHANNEL_1to1Portal)];
        return priceBookEntryList;
    }
    /************************************************************************************************************************************
        *@ author:         Deloitte  
        *@ method:         getPicklistValues 
        *@ returns:        sObject objectApi, string fieldApi
        *@ params:         
        *@description:     [All Markets] 
        *@changeHistory:   Sudaif - NEA US#25780 Created this method to fetch Source picklist Values from Object and Field Passed
                           
    ************************************************************************************************************************************/
    public static List <String> getPicklistValues(sObject objectApi, string fieldApi) {
              List <String> allOptions = new list <String> ();
              // Get the object type of the SObject.
              Schema.sObjectType objType = objectApi.getSObjectType();
             // Describe the SObject using its object type.
              Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
             // Get a map of fields for the SObject
              Map <String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
              List <Schema.PicklistEntry> values =
              fieldMap.get(fieldApi).getDescribe().getPickListValues();
              for (Schema.PicklistEntry a: values) {
               allOptions.add(a.getValue());
              }
              allOptions.sort();
              return allOptions;
         }
         
    /************************************************************************************************************************************
        *@ author:         Deloitte  
        *@ method:         createOrder 
        *@ returns:        Order
        *@ params:         Order parentOrder, PricebookEntry parentPricebookEntry
        *@description:     [All Markets] 
        *@changeHistory:   Osheen - Created this method to return Order object for insertion
                           
    ************************************************************************************************************************************/
    public static Order createOrder(Account parentAccount, Id recordTypeId, Id pricebookId, Decimal orderTotal, Boolean isGift, String source, String sourceSpecification, Boolean isTrial){
        Order newOrder = new Order();
        newOrder.RecordTypeId = recordTypeId;
        newOrder.AccountId = parentAccount.Id;
        newOrder.Country__c = parentAccount.Country__c;
        newOrder.Status = BAT_ConstantsUtility.BAT_ORDER_STATUS_CREATED;
        newOrder.EffectiveDate = Date.today();
        newOrder.Order_Total__c = orderTotal;
        newOrder.BAT_IsGift__c = isGift;
        newOrder.Order_Source__c = source;
        newOrder.BAT_SourceSpecification__c = sourceSpecification;
        newOrder.pricebook2Id = pricebookId; 
        if(isTrial){  newOrder.Type = BAT_ConstantsUtility.BAT_ORDER_TYPE_TRIAL;
        }
        return newOrder;
    }
    
    /************************************************************************************************************************************
        *@ author:         Deloitte  
        *@ method:         createOrderItem 
        *@ returns:        OrderItem
        *@ params:         Order parentOrder, PricebookEntry parentPricebookEntry
        *@description:     [All Markets] 
        *@changeHistory:   Osheen - Created this method to return OrderItem object for insertion
                           
    ************************************************************************************************************************************/
     public static OrderItem createOrderItem(Order parentOrder, PricebookEntry parentPricebookEntry){
        OrderItem newItem = new OrderItem();
        newItem.Product2Id = parentPricebookEntry.Product2Id;
        newItem.PricebookEntryId = parentPricebookEntry.Id;
        newItem.Quantity = BAT_ConstantsUtility.DECIMAL_ONE;
        newItem.UnitPrice = parentPricebookEntry.UnitPrice;
        newItem.Country__c = parentOrder.Country__c;
        newItem.OrderId = parentOrder.Id;
        return newItem;
    }
    
    /*********************************************************************************
    @Author       : Deloitte
    @Method       : createPointRecord
    @Returns      : void
    @Params       : String rewardprofile , Asset object , point value
    @Description  : create instance of BAT_Point__c
    @ChangeHistory: 18/06/2019/ SOuvik Dinda /created the method
    *******************************************************************************/
    public static BAT_Point__c createPointRecord(String rewardProfile,String reason,Decimal pointValue)
    {
        BAT_Point__c point = new BAT_Point__c();
        point.Reward_Profile__c = rewardProfile;
        point.Reason__c=reason;
        point.Value__c = pointValue ;
        return point;
    }
    
    /*********************************************************************************
    @Author       : Deloitte
    @Method       : generateReasonField
    @Returns      : void
    @Params       : Asset object , List metadata  record , map of id,Account
    @Description  : Generatereasonfield using fields in custom metadata
    @ChangeHistory: 18/06/2019 /Souvik Dinda /created the method
                    07/03/2023 /Hariharan Pillai/ Added condition when AccId is null
    *******************************************************************************/
    //public static String generateReasonField(Asset assetRec,List<BAT_RetailerPointTable__mdt> dataList,Map<Id,Account> accountsMap,string Scenario)
    public static String generateReasonField(Asset assetRec,List<BAT_RetailerPointDirectory__c> dataList,Map<Id,Account> accountsMap,string Scenario)
    {
        String reasonValue = BAT_ConstantsUtility.EMPTY_STRING;
          System.debug('data List ' +dataList );
        for (BAT_RetailerPointDirectory__c matadata: dataList) {
          
            SObjectField fieldApiName = null;
            Object val = null;
            // Check Meta Data object Match with Asset or not, if Match add the reason values.
            if (matadata.BAT_ObjectName__c == BAT_ConstantsUtility.ASSET_STR) {
                if (String.isNotBlank(matadata.BAT_FieldLabel__c)) {
                    reasonValue += matadata.BAT_FieldLabel__c + BAT_ConstantsUtility.SINGLE_SPACE;
                }
                fieldApiName = getSobjectFieldApiName(matadata.BAT_ObjectName__c, matadata.BAT_FieldAPIName__c);
                Schema.DisplayType fielddataType = fieldApiName.getDescribe().getType();
                if(fielddataType == Schema.DisplayType.Date){
                    val = assetRec.get(fieldApiName);
                    Date datval = Date.valueOf(val);
                    val = datval.format();     
                }else{
                    val = assetRec.get(fieldApiName);
                }
                reasonValue += val + BAT_ConstantsUtility.SEMI_COLON + BAT_ConstantsUtility.SINGLE_SPACE;
                // Check Meta Data object Match with Account or not, if Match add the reason values.
            }else if (matadata.BAT_ObjectName__c == BAT_ConstantsUtility.ACCOUNT) {
                if (String.isNotBlank(matadata.BAT_FieldLabel__c)) {
                    reasonValue += String.ValueOf(matadata.BAT_FieldLabel__c) + BAT_ConstantsUtility.SINGLE_SPACE;
                }
                fieldApiName = getSobjectFieldApiName(matadata.BAT_ObjectName__c, matadata.BAT_FieldAPIName__c);
                if(assetRec.AccountId !=null){
                    val = accountsMap.get(assetRec.AccountId).get(fieldApiName);
                }
                else{
                    val = BAT_ConstantsUtility.BAT_ACCOUNTNOTLINKED;
                }
                reasonValue += String.ValueOf(val);
            }
        }
        reasonValue += Scenario;
        return reasonValue;
    }
   /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : byPassFlagToSetLeadStatusToLost
    * @returns       : void
    * @params        : boolean
    * @description   : [IT] Method used to update the BAT_BypassFlag__c from Custom setting BAT_BypassValidationSetting__c.
    * @changeHistory : 11.07.2019 / Ushabala Kanduru /Bug#32423 [IT]created the method Bug#32423
                     : 30.08.2019/Tejaswi Nissankula/Added privacyConsentFlagSet flag as part of Bug#44227.When this flag is 
                     true we will let uses's update the privacy Consent fields on Account.This is set to true during the lead 
                     converstion logic(BAT_ConvertLeadController).
    *********************************************************************************************************/
     public static void byPassFlagToSetLeadStatusToLost(boolean leadStatusToLostflagset,boolean privacyConsentFlagSet){
     
        BAT_BypassValidationSetting__c byPassFlagSetting = BAT_BypassValidationSetting__c.getOrgDefaults();
        if(byPassFlagSetting.id != null && (leadStatusToLostflagset != BypassFlagSetting.BAT_ByPassLeadStatusToLostValidation__c || 
         privacyConsentFlagSet != BypassFlagSetting.BAT_ByPassPrivacyConsentFlags__c)){     
            BypassFlagSetting.BAT_ByPassLeadStatusToLostValidation__c = leadStatusToLostflagset;
            BypassFlagSetting.BAT_ByPassPrivacyConsentFlags__c = privacyConsentFlagSet;
            update byPassFlagSetting;
        }
    }
/************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getValidAccountSource 
    *@ returns:        List<BAT_PortalAccountSourceConfiguration__mdt>
    *@ params:         String country
    *@description:     [All Markets] - Used to receive valid Account Source values per country
    *@changeHistory:   04-07-2019/Osheen Sahajpal/Created this method
    ************************************************************************************************************************************/
    public static List<BAT_PortalAccountSourceConfiguration__mdt> getValidAccountSource(String country){
        List<BAT_PortalAccountSourceConfiguration__mdt> validAccountSourceList = [SELECT Id, 
                                                                                 Label, 
                                                                                 MasterLabel, 
                                                                                 BAT_Country__c,
                                                                                 BAT_FieldValueAPI__c,
                                                                                 BAT_FieldValueLabel__c,
                                                                                 BAT_Sequence__c
                                                                          FROM BAT_PortalAccountSourceConfiguration__mdt
                                                                          WHERE BAT_Country__c = :country
                                                                          ORDER BY BAT_Sequence__c
                                                                         ];
        return validAccountSourceList;
    }

    
    /********************************************************************************************************
    * @ author:          Deloitte  
    * @ method:          createChatterPost 
    * @ returns:         FeedItem
    * @ params:          Id parentId, String body
    * @description:      Method returns the FeedItem object to show Chatter Notifications.
    * @changeHistory:    10-07-2019/Osheen Sahajpal/NEA: Sprint-4: US#31481/Created the method
    *********************************************************************************************************/
    public static FeedItem createChatterPost(Id parentId, String body){
        FeedItem chatterPost = new FeedItem();
        chatterPost.ParentId = parentId;
        chatterPost.Body = body;
        return chatterPost;
    }
    
    /********************************************************************************************************
    * @ author:          Deloitte  
    * @ method:          getAllQueues 
    * @ returns:         Map<String,Id>
    * @ params:          null
    * @description:      Method returns a map of developerName to Id of all the queues required for Email-to-Case.
    * @changeHistory:    12-07-2019/Osheen Sahajpal/NEA: Sprint-4: US#31478/Created the method
    *********************************************************************************************************/
    public static Map<String,Id> getAllQueues(){
        Map<String,Id> mapQueueNameToId = new Map<String,Id>();
        List<Group> listAllGroups = [SELECT Id, Name, Type, DeveloperName FROM Group WHERE Type = 'Queue'];
        for(Group g : listAllGroups){
            mapQueueNameToId.put(g.DeveloperName,g.Id);
            system.debug('mapQueueNameToId'+mapQueueNameToId);
        }
        return mapQueueNameToId;
    }
    
    /********************************************************************************************************
    * @ author:          Deloitte  
    * @ method:          getEmailToCaseConfig 
    * @ returns:         Map<String,List<BAT_EmailToCaseConfiguration__mdt>>
    * @ params:          Set<String> setQueueName
    * @description:      Method returns a map of developerName to BAT_EmailToCaseConfiguration List 
    *                    of the queues required for Email-to-Case.
    * @changeHistory:    12-07-2019/Osheen Sahajpal/NEA: Sprint-4: US#31478/Created the method
    *********************************************************************************************************/
   
    /*public static Map<String,List<BAT_EmailToCaseConfiguration__mdt>> getEmailToCaseConfig(Set<String> setQueueName){
        Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapQueueToCaseFields = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        List<BAT_EmailToCaseConfiguration__mdt> listEmailToCaseConfig = [SELECT Id,
                                                                                BAT_FieldAPI__c,
                                                                                BAT_FieldValue__c,
                                                                                BAT_SourceQueueAPI__c
                                                                         FROM BAT_EmailToCaseConfiguration__mdt
                                                                         WHERE BAT_SourceQueueAPI__c IN :setQueueName];
        for(BAT_EmailToCaseConfiguration__mdt emailToCaseConfig : listEmailToCaseConfig){
            if(!mapQueueToCaseFields.containsKey(emailToCaseConfig.BAT_SourceQueueAPI__c)){
                mapQueueToCaseFields.put(emailToCaseConfig.BAT_SourceQueueAPI__c,new List<BAT_EmailToCaseConfiguration__mdt>());
            }
            mapQueueToCaseFields.get(emailToCaseConfig.BAT_SourceQueueAPI__c).add(emailToCaseConfig);
        }
        return mapQueueToCaseFields;
    }*/
      /********************************************************************************************************
    * @ author:          Deloitte  
    * @ method:          getEmailToCaseConfig 
    * @ returns:         Map<String,List<BAT_EmailToCaseConfiguration__mdt>>
    * @ params:          Set<String> setQueueName
    * @description:      Method returns a map of developerName to BAT_EmailToCaseConfiguration List 
    *                    of the queues required for Email-to-Case.
    * @changeHistory:    12-07-2019/Osheen Sahajpal/NEA: Sprint-4: US#31478/Created the method
                                        13.12.2022/Idrees Ali/ ENH- Sprint 120 - US#1080293 - Modified the logic to return wrapper class
    *********************************************************************************************************/
   public static emailToCaseConfigWrapper getEmailToCaseConfig(Set<String> setQueueName){
        Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapQueueToCaseFields = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapOfSkillBasedConfigDetails = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        List<String> stagingQueuesList = new List<String>();
        mapQueueToCaseFields = email2CaseWrapper.mapQueueToCaseFields;
        mapOfSkillBasedConfigDetails = email2CaseWrapper.mapOfSkillBasedConfigDetails;
        stagingQueuesList = email2CaseWrapper.stagingQueuesList;
        List<BAT_EmailToCaseConfiguration__mdt> listEmailToCaseConfig = [SELECT Id,
                                                                                BAT_FieldAPI__c,
                                                                                BAT_FieldValue__c,
                                                                                BAT_SourceQueueAPI__c,BAT_SkillBasedRoutingKeywords__c
                                                                         FROM BAT_EmailToCaseConfiguration__mdt
                                                                         WHERE BAT_SourceQueueAPI__c IN :setQueueName];
        for(BAT_EmailToCaseConfiguration__mdt emailToCaseConfig : listEmailToCaseConfig){
            if(String.isBlank(emailToCaseConfig.BAT_SkillBasedRoutingKeywords__c)){
                if(!mapQueueToCaseFields.containsKey(emailToCaseConfig.BAT_SourceQueueAPI__c)){
                    mapQueueToCaseFields.put(emailToCaseConfig.BAT_SourceQueueAPI__c,new List<BAT_EmailToCaseConfiguration__mdt>());
                }
                mapQueueToCaseFields.get(emailToCaseConfig.BAT_SourceQueueAPI__c).add(emailToCaseConfig);
            }
            else{
                
                if(!mapOfSkillBasedConfigDetails.containsKey(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[0])){
                    mapOfSkillBasedConfigDetails.put(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[0],new List<BAT_EmailToCaseConfiguration__mdt>());
                }
                mapOfSkillBasedConfigDetails.get(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[0]).add(emailToCaseConfig);
                
               
                
            }
        }
        return email2CaseWrapper;
    }
    
    /********************************************************************************************************
    * @ author:          Deloitte  
    * @ method:          getEmailToCaseConfig 
    * @ returns:         Map<String,List<BAT_EmailToCaseConfiguration__mdt>>
    * @ params:          Set<String> setQueueName
    * @description:      Method returns a map of developerName to BAT_EmailToCaseConfiguration List 
    *                    of the queues required for Email-to-Case.
    * @changeHistory:    12-07-2019/Osheen Sahajpal/NEA: Sprint-4: US#31478/Created the method
                                        13.12.2022/Idrees Ali/ ENH- Sprint 120 - US#1080293 - Modified the logic to return wrapper class
    *********************************************************************************************************/
   /* public static emailToCaseConfigWrapper getEmailToCaseConfig1(Set<String> setQueueName){
        Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapQueueToCaseFields = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapOfSkillBasedConfigDetails = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        List<String> stagingQueuesList = new List<String>();
        mapQueueToCaseFields = email2CaseWrapper.mapQueueToCaseFields;
        mapOfSkillBasedConfigDetails = email2CaseWrapper.mapOfSkillBasedConfigDetails;
        stagingQueuesList = email2CaseWrapper.stagingQueuesList;
        List<BAT_EmailToCaseConfiguration__mdt> listEmailToCaseConfig = [SELECT Id,
                                                                                BAT_FieldAPI__c,
                                                                                BAT_FieldValue__c,
                                                                                BAT_SourceQueueAPI__c,BAT_SkillBasedRoutingKeywords__c
                                                                         FROM BAT_EmailToCaseConfiguration__mdt
                                                                         WHERE BAT_SourceQueueAPI__c IN :setQueueName];
        for(BAT_EmailToCaseConfiguration__mdt emailToCaseConfig : listEmailToCaseConfig){
            if(String.isBlank(emailToCaseConfig.BAT_SkillBasedRoutingKeywords__c)){
                if(!mapQueueToCaseFields.containsKey(emailToCaseConfig.BAT_SourceQueueAPI__c)){
                    mapQueueToCaseFields.put(emailToCaseConfig.BAT_SourceQueueAPI__c,new List<BAT_EmailToCaseConfiguration__mdt>());
                }
                mapQueueToCaseFields.get(emailToCaseConfig.BAT_SourceQueueAPI__c).add(emailToCaseConfig);
            }
            else{
                if(!mapOfSkillBasedConfigDetails.containsKey(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[0])){
                    mapOfSkillBasedConfigDetails.put(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[0],new List<BAT_EmailToCaseConfiguration__mdt>());
                }
                mapOfSkillBasedConfigDetails.get(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[0]).add(emailToCaseConfig);
                if(!stagingQueuesList.contains(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[1])){
                    stagingQueuesList.add(emailToCaseConfig.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON)[1]);
                }
            }
        }
        return email2CaseWrapper;
    }*/
    
    /********************************************************************************************************
    * @ author:          Deloitte  
    * @ method:          getChatterPostMessage 
    * @ returns:         Map<String,BAT_GlobalChatterPostConfiguration__mdt>
    * @ params:          String eventType
    * @description:      Method returns the list of Chatter messages to be displayed on user feed
    * @changeHistory:    15-07-2019/Osheen Sahajpal/NEA: Sprint-4: US#31481/Created the method
                         26-05-2021/Dipika Gupta/ES: Sprint-2: US#537688/Added new field BAT_CaseOriginatedChannel__c in query
    *********************************************************************************************************/
    public static Map<String,BAT_GlobalChatterPostConfiguration__mdt> getChatterPostMessage(String eventType){
        Map<String,BAT_GlobalChatterPostConfiguration__mdt> mapCountryToChatterMessages = new Map<String,BAT_GlobalChatterPostConfiguration__mdt>();
        List<BAT_GlobalChatterPostConfiguration__mdt> listChatterMessage = [SELECT BAT_Country__c,
                                                                                  BAT_EventType__c,
                                                                                  BAT_Message__c,BAT_CaseOriginatedChannel__c
                                                                           FROM BAT_GlobalChatterPostConfiguration__mdt
                                                                           WHERE BAT_EventType__c =:eventType];
        for(BAT_GlobalChatterPostConfiguration__mdt chatterMessage : listChatterMessage){
            if(!mapCountryToChatterMessages.containsKey(chatterMessage.BAT_Country__c)){
                mapCountryToChatterMessages.put(chatterMessage.BAT_Country__c,chatterMessage);
            }
        }
        return mapCountryToChatterMessages;
    }
    
/************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         getBusinessHours 
*@ returns:        Map<String, Id>
*@ params:         String
*@description:     [All Markets] Configuration for countries to fetch Business Hours defined for them.
*@changeHistory:   17/07/2019 / Souvik Dinda / Created method.               
************************************************************************************************************************************/
    public static Map<String, Id> getBusinessHours(){
        Map<String, Id> businessHourIdConfigMap = new Map<String, Id>();   
        Map<String, Id> businessHoursPerCountryMap = new Map<String, Id>();
        
        Set<String> businessHourName = new Set<String>();
        List<BAT_BusinessHoursConfiguration__mdt> businessHoursConfigList = [SELECT MasterLabel, BAT_BusinessHoursName__c
                                                                             FROM BAT_BusinessHoursConfiguration__mdt];
        for(BAT_BusinessHoursConfiguration__mdt businessHoursConfig : businessHoursConfigList){
            businessHourName.add(businessHoursConfig.BAT_BusinessHoursName__c);
        }
        if(!businessHourName.isEmpty()){
            List<BusinessHours> businessHourList = [SELECT Id, Name
                                                    FROM BusinessHours
                                                    WHERE Name IN: businessHourName];
            
            for(BusinessHours businessHour : businessHourList){
                businessHourIdConfigMap.put(businessHour.Name, businessHour.Id);
            }
        }
        if(!businessHourIdConfigMap.isEmpty()){
            for(BAT_BusinessHoursConfiguration__mdt businessHours : businessHoursConfigList){
                if(businessHourIdConfigMap.containsKey(businessHours.BAT_BusinessHoursName__c)){
                  businessHoursPerCountryMap.put(businessHours.MasterLabel, businessHourIdConfigMap.get(businessHours.BAT_BusinessHoursName__c));
               }
            }   
        }
        
        return businessHoursPerCountryMap;
    }
    
/************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         getCaseAgeInHours 
*@ returns:        Map<String, String>
*@ params:         String
*@description:     [All Markets] Converting date/time to hours for calculating Case Age.
*@changeHistory:   17/07/2019 / Souvik Dinda / Created method.               
************************************************************************************************************************************/
    public static Integer getCaseAgeInHours(DateTime dateOpen, DateTime dateClose, Id businessHourId){
        Long caseAgeHours = Math.abs(BusinessHours.diff(businessHourId,dateOpen,dateClose)/1000/60/60);
        return Integer.valueOf(caseAgeHours);
    }
/************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         getLeadAccountBrandStatusMap 
*@ returns:        Map<String, String>
*@ params:         String
*@description:     [PL] 25.06.2020/ Mallik Balla/ US#176027 : gets the lead and account brand value status fields from the metadata : BAT_LeadAccountBrandToStatusFieldValue__mdt
*@changeHistory:   [PL] 25.06.2020/ Mallik Balla/ US#176027 : Created method.               
************************************************************************************************************************************/
public static Map<String,BAT_LeadAccountBrandToStatusFieldValue__mdt> getLeadAccountBrandStatusMap(){
    if(brandToStatusFieldAndValueMap == null || (brandToStatusFieldAndValueMap != null && !brandToStatusFieldAndValueMap.isEmpty())){
      Map<String,BAT_LeadAccountBrandToStatusFieldValue__mdt> brandStatusMdt = new Map<String,BAT_LeadAccountBrandToStatusFieldValue__mdt>();
      for(BAT_LeadAccountBrandToStatusFieldValue__mdt eachRecord:[Select MasterLabel, BAT_LeadStatusField__c, BAT_LeadStatusValue__c, BAT_AccountStatusField__c, BAT_AccountStatusValue__c From BAT_LeadAccountBrandToStatusFieldValue__mdt Limit 100]){
          brandStatusMdt.put(eachRecord.MasterLabel,eachRecord);
      }
      brandToStatusFieldAndValueMap = brandStatusMdt;
      }
      return brandToStatusFieldAndValueMap;
}

/************************************************************************************************************************************
* @author        : Deloitte
* @method Name   : setLeadStatusField
* @returns       : void
* @params        : Lead, Account
* @description   : [176027 - All Markets] To Update the brand specific status fields on lead, account
* @changeHistory : 10.06.2019/Abhishek KAshyap/Created the method in BAT_AccountTriggerHandler
                   25.06.2020/Mallik Balla/Created the method in BAT_Utilities and made it generic so that it fetches the field update
                   information from the metadata - BAT_LeadAccountBrandToStatusFieldValue__mdt.
                   Added two new records from the metadata - for VELO, LYFT
************************************************************************************************************************************/
public static void setLeadAccountStatusField(Lead leadObj, Account accObj){
  Map<String,BAT_LeadAccountBrandToStatusFieldValue__mdt> brandStatusMdt = BAT_Utilities.getLeadAccountBrandStatusMap();
  if(brandStatusMdt!= null && !brandStatusMdt.isEmpty()){     
    for(String brandString:brandStatusMdt.KeySet()){
      if(leadObj!= null && String.isNotBlank(leadObj.Brand_House__c) && leadObj.Brand_House__c.ContainsIgnoreCase(brandString)){
            leadObj.put(brandStatusMdt.get(brandString).BAT_LeadStatusField__c,brandStatusMdt.get(brandString).BAT_LeadStatusValue__c);
        }
      if(accObj!= null && String.isNotBlank(accObj.Brand_House__c) && accObj.Brand_House__c.ContainsIgnoreCase(brandString)){
          accObj.put(brandStatusMdt.get(brandString).BAT_AccountStatusField__c,brandStatusMdt.get(brandString).BAT_AccountStatusValue__c);
      }
    }
  }
  if(leadObj!= null){
  leadObj.Status = BAT_ConstantsUtility.CONVERTED;
}  
}  

   /********************************************************************************************************
* @author        : Deloitte
    * @method Name   : updateProductInterestAndLeadRecords
    * @returns       : List<BAT_ProductInterest__c>
    * @params        : List<Account>, Set<ID>
    * @description   : [PL:US#176027] This method updates Product Interest records associated with Lead to Account during before insert
    *                   and Account fields during after insert.
    * @changeHistory : [PL] 25.06.2020/ Mallik Balla/ US#176027 :Created the method
    *********************************************************************************************************/
    public static List<BAT_ProductInterest__c> updateProductInterestAndLeadRecords (List<Account> lstAccounts, Set<ID> setLeads){
      Map<ID, Account> mapPLAccs = new Map<ID, Account>();
      Map<ID, List<BAT_ProductInterest__c>> mapLeadIdPIs = new Map<ID, List<BAT_ProductInterest__c>>();
      Map<ID, BAT_ProductInterest__c> mapPIsToUpdate = new Map<ID, BAT_ProductInterest__c>();
      if(lstAccounts != null && !lstAccounts.isEmpty() && setLeads != null && !setLeads.isEmpty()){
          for(BAT_ProductInterest__c objPI : [SELECT Id, BAT_Lead__c, BAT_Account__c 
                                              FROM BAT_ProductInterest__c
                                              WHERE BAT_Lead__c IN :setLeads]){
              if(mapLeadIdPIs.containsKey(objPI.BAT_Lead__c)){
                mapLeadIdPIs.get(objPI.BAT_Lead__c).add(objPI);
              }
              else{
                mapLeadIdPIs.put(objPI.BAT_Lead__c, new List<BAT_ProductInterest__c>{objPI});
              }
          }
          for(Account objAcc : lstAccounts){
          if(objAcc.Related_Lead__c != null && mapLeadIdPIs.containsKey(objAcc.Related_Lead__c)){//Update Product Interest records on after update Account records
            for(BAT_ProductInterest__c objPI : mapLeadIdPIs.get(objAcc.Related_Lead__c)){
              if(objAcc.Related_Lead__c.equals(objPI.BAT_Lead__c)){
                  objPI.BAT_Account__c = objAcc.Id;
                  mapPIsToUpdate.put(objPI.ID, objPI);
              }
            }
        }
    }
  }
      return mapPIsToUpdate.values();
}

    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : generateInvitationLink
* @returns       : void
* @params        : void
* @description   : AZ: Sprint3: US#43961: AZ - Admin - Survey Invitation Links on Salesforce
* @changeHistory : 28.08.2019/Varun Kochar/Created the method
*********************************************************************************************************/
    public static void generateInvitationLinkOnAccountCreation(List<Account> accList){
        List<SurveyInvitation> sInvitations = new List<SurveyInvitation>();
        String trialistRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.RECORDTYPE_TRAILLIST).getRecordTypeId();
        String consumerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.ACC_RECTYPE_DIRECTCON).getRecordTypeId();
        Map<String, BAT_EnableMarketSurveyInvitations__mdt> mapOfTrialistSurveyAndEnableMarketSurveyInvitations = new Map<String, BAT_EnableMarketSurveyInvitations__mdt>();
        Map<String, BAT_EnableMarketSurveyInvitations__mdt> mapOfConsumerSurveyAndEnableMarketSurveyInvitations = new Map<String, BAT_EnableMarketSurveyInvitations__mdt>();
        Set<String> setOfSurveyNames = new Set<String>();
        Map<String, Map<String,Survey>> mapOfCountryAndRecordtypeSurvey = new Map<String, Map<String,Survey>>();
        for(BAT_EnableMarketSurveyInvitations__mdt countrySurveyDataObj : [SELECT BAT_TrialistSurveyName__c,BAT_SurveyName__c, BAT_CommunityName__c, BAT_CommunityProfileNames__c , DeveloperName from BAT_EnableMarketSurveyInvitations__mdt where BAT_TrialistSurveyName__c!= Null AND BAT_SurveyName__c!= Null]){
            if(String.isNotBlank(countrySurveyDataObj.BAT_TrialistSurveyName__c)){            
                mapOfTrialistSurveyAndEnableMarketSurveyInvitations.put(countrySurveyDataObj.BAT_TrialistSurveyName__c, countrySurveyDataObj);
                setOfSurveyNames.add(countrySurveyDataObj.BAT_TrialistSurveyName__c);
            }
            if(String.isNotBlank(countrySurveyDataObj.BAT_SurveyName__c)){
                mapOfConsumerSurveyAndEnableMarketSurveyInvitations.put(countrySurveyDataObj.BAT_SurveyName__c, countrySurveyDataObj);
                setOfSurveyNames.add(countrySurveyDataObj.BAT_SurveyName__c);
            }
        }
        if(!setOfSurveyNames.isEmpty()){
            for(Survey surveyObj : [SELECT Id, Name from Survey where name IN : setOfSurveyNames]){
                if(mapOfTrialistSurveyAndEnableMarketSurveyInvitations.containskey(surveyObj.Name)){
                    if(surveyObj.name.equalsIgnoreCase(mapOfTrialistSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).BAT_TrialistSurveyName__c)){
                        Map<String,Survey> mapOfRecordtypeIdAndSurvey =  new Map<String,Survey>();
                        mapOfRecordtypeIdAndSurvey.put(trialistRecordTypeId, surveyObj);
                        if(!mapOfCountryAndRecordtypeSurvey.containsKey(mapOfTrialistSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).DeveloperName)){
                            mapOfCountryAndRecordtypeSurvey.put(mapOfTrialistSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).DeveloperName, mapOfRecordtypeIdAndSurvey);
                        }
                        else{
                             mapOfCountryAndRecordtypeSurvey.get(mapOfTrialistSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).DeveloperName).put(trialistRecordTypeId, surveyObj);
                        }
                    }
                }
                if(mapOfConsumerSurveyAndEnableMarketSurveyInvitations.containskey(surveyObj.Name)){
                    if(surveyObj.name.equalsIgnoreCase(mapOfConsumerSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).BAT_SurveyName__c)){
                        Map<String,Survey> mapOfRecordtypeIdAndSurvey =  new Map<String,Survey>();
                        mapOfRecordtypeIdAndSurvey.put(consumerRecordTypeId, surveyObj);
                        if(!mapOfCountryAndRecordtypeSurvey.containsKey(mapOfConsumerSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).DeveloperName)){
                            mapOfCountryAndRecordtypeSurvey.put(mapOfConsumerSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).DeveloperName, mapOfRecordtypeIdAndSurvey);
                        }
                        else{
                             mapOfCountryAndRecordtypeSurvey.get(mapOfConsumerSurveyAndEnableMarketSurveyInvitations.get(surveyObj.Name).DeveloperName).put(consumerRecordTypeId, surveyObj);
                        }
                    }
                }
            }
        }
        if(!mapOfCountryAndRecordtypeSurvey.isEmpty()){
            Network communityID = [SELECT Id from Network where name = :BAT_ConstantsUtility.Surveys LIMIT 1];
            for(Account currentRecord : accList){
                if(mapOfCountryAndRecordtypeSurvey.containsKey(currentRecord.Country__c) && mapOfCountryAndRecordtypeSurvey.get(currentRecord.Country__c).containsKey(currentRecord.RecordtypeID)){
                    sInvitations.add(BAT_Utilities.createSurveyInvitation(mapOfCountryAndRecordtypeSurvey.get(currentRecord.Country__c).get(currentRecord.RecordtypeID).Name +'-'+ currentRecord.FirstName+currentRecord.LastName, mapOfCountryAndRecordtypeSurvey.get(currentRecord.Country__c).get(currentRecord.RecordtypeID).Id, communityID.ID ,currentRecord.personContactID, false ));
                }
            }
        }
        
        insert sInvitations;
    }
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeAccounts 
*@ returns:        List<Account>
*@ params:         List<Account>
*@description:     [All Markets] Logic to anonymize Accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
                   06/12/2019/ Souvik Dinda/ US#47980 - Bifurcating anonymization logic for Romania.
           29/06/2020/Tejaswi Nissankula/US#136698 : Added required anonymize fields for ID
           24/06/2020/ Dipika Gupta/ US#135383 - Added fields for Poland Anonymisation.
           14/10/2020/ Sandeep Joshi/ US#284782 - Added fields for South Africa Anonymisation in a new if loop for ZA.
           05/10/2020/ Rama Akella/ US#280983 - Added additional fields required for anonymization (FR)
           5/11/2020/ Dipika Gupta/ US#295637  - Added conditions for C Anonymisation.
           2nd Feb,2021 / Akshata Rajmane / US #386649 : GR - Admin Portal - Anonymise Account
           14/01/2021/Idrees Ali/US#340701- Added External Session Id for anonymization
        6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
        14th April,2021/Abhishek Kashyap/ BUG-486428-478408 - Issue with zip code population when account is created via CIAM Integration for a existing partially anonymized account
           27.04.2021/ Allada yeshwanth / BUG: #506606 / calling updateEmailandPhone Method to stamp the the values of email and phone into custom fields or external fields
           12.05.2021/Idrees Ali/US#505984 - Avalanche - Admin Portal - Anonymise Account
        22nd April, 2021/Abhishek Kashyap/US-543158-RO - Anonymization in the to be architecture - update
        10/06/2021/ Akshata Rajmane / US #738065 : MY Vuse - Admin Portal - Anonymise Account
        //08/09/2022/ Chetan Patil/ US#1121760 - Added  fields  for Slovenia anonymization (SI)
        //12/02/2022/ Hariharan Pillai/ Bug #1297646 - Added custom PersonMobilePhone__c field to be anonymized
        //24.08.2023/Idrees Ali/ US#1335464- Added Changes to anonymise email for SE Accounts when certain crietria are met
        ************************************************************************************************************************************/
    public static List<Account> anonymizeAccounts(List<Account> accountList){
        Set<String> countrySet = new Set<String>(); //stores the set of countries that are for anonymization
        for(Account account:accountList){
            /*system.debug('LK Line after 3198'+account.BAT_ConsentDate__c);
            system.debug('LK Line after privacySnapshotDeletionParentIds'+snapshotWrapper.privacySnapshotDeletionParentIds);
            system.debug('LK Line after 3198'+account.id);
            system.debug('LK Line after 3198'+account.BAT_AMPLastConsentDate__c);*/
            if(account.Country__c != BAT_ConstantsUtility.COUNTRY_CZ){
                //24.08.2023/Idrees Ali/ US#1335464- Added Changes to anonymise email for SE Accounts when certain crietria are met
                if((account.Country__c != BAT_ConstantsUtility.COUNTRY_SE && account.Country__c != BAT_ConstantsUtility.DK_STR) || 
                   ((account.Country__c == BAT_ConstantsUtility.COUNTRY_SE ||account.Country__c == BAT_ConstantsUtility.DK_STR) && !snapshotWrapper.privacySnapshotDeletionParentIds.isEmpty() && snapshotWrapper.privacySnapshotDeletionParentIds.contains(account.Id) )){
                    account.PersonEmail = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL; // added constant Varible
                     
                }
                account.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                account.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
            }else if(account.Country__c == BAT_ConstantsUtility.COUNTRY_CZ){
                    account.PersonEmail = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL; // added constant Varible
                       /*Integer yearOfBirth=account.PersonBirthdate.year();
                       account.PersonBirthdate=Date.newInstance(yearOfBirth,1,1);
                      // account.BAT_ExternalCustomerId4__c = BAT_ConstantsUtility.EMPTY_STRING;
                       //account.BAT_ExternalCustomerID5__c = BAT_ConstantsUtility.EMPTY_STRING;
                       //account.BillingStreet = BAT_ConstantsUtility.EMPTY_STRING;
                       account.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                       account.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                       account.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
                       //account.BillingStreet = BAT_ConstantsUtility.EMPTY_STRING;*/
                       
                
            }
            //Added for IT as part of US#340701
            //12.05.2022/Turbasu Ghosh/US#918330- Added Salutation for IT
            account.BAT_ExternalSessionId__c = BAT_ConstantsUtility.EMPTY_STRING;  
            account.BillingStreet = BAT_ConstantsUtility.EMPTY_STRING;
            account.Registration_Permission__c = false;
            account.Submit_Surveys_Permission__c = false;
            account.Trial_Information_Permission__c = false;
            account.External_Information_Systems_Permission__c = false;
            account.Generic_Permission__c = false;
            account.BAT_isVypeOptInMobileTextWhatsApp__c = false;
            account.BAT_isVypeOptInEmailCommunication__c = false;
            account.BAT_IsGloOptInEmailCommunication__c = false;
            account.BAT_IsGloOptInMobileTextWhatsApp__c = false;
            account.Loyalty_Completed_Survey__c = false;
            account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
            //SPRINT 3: US:15497 DE is Anonymise logic for the updated records both manually and via integration.
            //18/04/2019/ Abhishek Kashyap/ US - 19460, DE-Market, Updated account category status field when account gets anonymised.
            if(account.Country__c ==BAT_ConstantsUtility.COUNTRY_DE_STR ){
                if(!String.isBlank(account.BAT_OralStatus__c)){
                    account.BAT_OralStatus__c = BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR;
                }
                if(!String.isBlank(account.BAT_CombustibleStatus__c)){
                    account.BAT_CombustibleStatus__c = BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR;
                }
                if(!String.isBlank(account.BAT_THPStatus__c)){
                    account.BAT_THPStatus__c = BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR;
                }
                if(!String.isBlank(account.BAT_VapeStatus__c)){
                    account.BAT_VapeStatus__c = BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR;
                }
            }
            account.BAT_Is_Anonymised__c = true;
            account.BAT_OldEmailAddress__c = BAT_ConstantsUtility.EMPTY_STRING;
            account.BAT_IsVypeFirstDevice__c =false;
            account.BAT_CallAllowedForThisConsumer__c = false;
            account.BAT_IsLuckyStrikePersonalDataHandling__c = false;
            account.BAT_IsLuckyStrikeCommunityMember__c = false;
            account.BAT_IsLuckyStrikeOptInEmailCommunication__c = false;
            account.BAT_IsLuckyStrikeOptInMobileTextWhatsApp__c = false;
            account.BAT_IsPallMallPersonalDataHandling__c = false;
            account.BAT_IsPallMallCommunityMember__c = false;
            account.BAT_IsPallMallOptInEmailCommunication__c = false;
            account.BAT_IsPallMallOptInMobileTextWhatsApp__c = false;
            account.BAT_IsVypePersonalDataHandling__c = false;
            account.BAT_IsVypeCommunityMember__c = false;
            account.BAT_IsVypeOptInEmailCommunication__c = false;
            account.BAT_IsVypeOptInMobileTextWhatsApp__c = false;
            account.BAT_IsEPOKPersonalDataHandling__c = false;
            account.BAT_IsEPOKCommunityMember__c = false;
            account.BAT_IsEPOKOptInEmailCommunication__c     = false;
            account.BAT_IsEPOKOptInMobileTextWhatsApp__c = false;
            account.Registration_Permission__c = false;
            account.BAT_IsGloOptInEmailCommunication__c = false;
            account.BAT_IsGloCommunityMember__c = false;
            account.BAT_IsGloOptInMobileTextWhatsApp__c = false;
            //NEA/US#25783 - Added Consent fields to anonymize.                                 
            account.BAT_IsEPOKOptInPostal__c   =  false;
            account.BAT_EPOKMarketResearchAuthorization__c   =  false;
            account.BAT_EPOKLastCompletedOrderDate__c   =  null;
            account.BAT_EPOKLastConsentOptInDate__c   =  null;
            account.BAT_IsVypeOptInPostal__c   =  false;
            account.BAT_VypeMarketResearchAuthorization__c   =  false;
            account.GoVype_Last_Completed_Order_Date__c   =  null;
            account.BAT_VypeLastConsentOptInDate__c   =  null;
            account.BAT_IsLyftOptInEmailCommunication__c   =  false;
            account.BAT_IsLyftOptInMobileTextWhatsApp__c   =  false;
            account.BAT_IsLyftOptInPostal__c   =  false;
            account.BAT_LyftMarketResearchAuthorization__c   =  false;
            account.BAT_LyftExternalCompaniesAuthorization__c   =  false;
            account.BAT_LyftTrialFeedbackAuthorization__c   =  false;
            account.BAT_LyftLastCompletedOrderDate__c   =  null;
            account.BAT_LyftLastConsentOptInDate__c   =  null;
            account.BillingState = BAT_ConstantsUtility.EMPTY_STRING;
            account.BillingPostalCode = BAT_ConstantsUtility.EMPTY_STRING;
            account.BillingCountry = BAT_ConstantsUtility.EMPTY_STRING;
            if(account.Country__c ==BAT_ConstantsUtility.COUNTRY_AT_STR){
                account.BAT_IsLyftPersonalDataHandling__c = false;
                account.BAT_IsLyftCommunityMember__c = false;
                account.BAT_IsLyftOptInEmailCommunication__c = false;
                account.BAT_IsLyftOptInMobileTextWhatsApp__c = false;
            }
            
            //Start of US#4397 
            account.IsPostal_Opt_Out__c = true;
            account.PersonHasOptedOutOfEmail = true;
            account.IsMobile_Opt_Out__c = true;
            //End of US#4397
            account.ShippingStreet = BAT_ConstantsUtility.EMPTY_STRING; // Added for UK BUG#5525
            //Starts-- added for UK Bug#5525 by Usha 09/01/2019
            //Added by Roopa N/US#405880: RO - Bypassed ShippingCity updating to blank for RO
            if(account.Country__c != BAT_ConstantsUtility.COUNTRY_RO){
                account.ShippingCity  = BAT_ConstantsUtility.EMPTY_STRING; 
            }
            account.ShippingState  = BAT_ConstantsUtility.EMPTY_STRING; 
            account.ShippingCountry  = BAT_ConstantsUtility.EMPTY_STRING; 
            account.ShippingPostalCode = BAT_ConstantsUtility.EMPTY_STRING;
            //Ends*
            account.BAT_ConsentDate__c = null; //UK/BUGFIX/#21199/May 6th,2019/PrinceChawla/
            account.BAT_IsVeloOptInEmailCommunication__c = false;
            account.BAT_IsVeloOptInMobileTextSocialMedia__c = false;
            //MX Sprint 1: US:33838 Added Country Check for Salutation
            //12.05.2021/Idrees Ali/US#505984- Added DE Country and Ecommerce Velo - EU check for Salutation
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_MX_STR || 
               (account.Country__c == BAT_ConstantsUtility.DE_STR && account.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE)){  
                   account.Salutation = null;
               }
            //12.05.2021/Idrees Ali/US#505984- Added DE Country and Ecommerce Velo - EU check for Velo Personal data handling consent flag
            if(account.Country__c == BAT_ConstantsUtility.DE_STR && account.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE){  
                account.BAT_IsVeloPersonalDataHandling__c = false;
            }
            //16.02.2022/Rajeswari Nidamanuri//US #893452-PT Glo - Admin Portal - Anonymise Account
            //13.06.2022/Akshata Rajmane // UAT CR - removing salutation and person bithdate for SE and DK
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_ID || account.Country__c == BAT_ConstantsUtility.COUNTRY_PT || account.Country__c == BAT_ConstantsUtility.SE_STR || account.Country__c == BAT_ConstantsUtility.DK_STR ){
                account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
                account.National_ID__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.PersonBirthdate = null;
            }
            // 16/11/2023/US:1521043/Lalit/SE/DK - Admin Portal - Anonymise Account
            //17/01/2024/ Mayank Verma/ US - 1612796/ SE/DK-Market, Updated BAT_IsLyftOptInPostal__c(Moor Email opt out) field to 'TRUE' when account gets anonymised.
            if(account.Country__c == BAT_ConstantsUtility.SE_STR || account.Country__c == BAT_ConstantsUtility.DK_STR ){
                account.BAT_AMPEmailOptOut__c = true;
                account.External_Customer_ID3__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_IsLyftOptInPostal__c   =  true;
            }
            //30/06/2022/Rajeswari Nidamanuri/ US #1029822 - CH - Admin Portal - Anonymise Account
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_CH){
               account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
               account.National_ID__c = BAT_ConstantsUtility.EMPTY_STRING;
               account.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
               account.PersonBirthdate = null;
               account.Birth_Date__c = null;
               account.BillingCity = BAT_ConstantsUtility.EMPTY_STRING; 
               account.Postal_Code__c = BAT_ConstantsUtility.EMPTY_STRING;
               account.BAT_ExternalCustomerID5__c = BAT_ConstantsUtility.EMPTY_STRING;
               account.BAT_VapeConsumerSince__c = null;
               account.BAT_OralConsumerSince__c = null;
               account.BAT_DE_GloLastCompletedOrderDate__c = null;
               account.BAT_THPConsumerSince__c = null;
               account.BAT_FMCLastCompletedOrderDate__c = null;
               account.BAT_FMCConsumerSince__c = null;
               account.Email__c = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL;
            }
            
            //18/02/2025 Sagnik Ray/  GR#1996961 - Velo ACCOUNT  Integration - SHOPIFY ->Mulesoft -> CRM  (Forward)
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_GR)
			{
				account.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
    			account.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
				account.Birth_Date__c= null;
                //account.Gender__c= null;
				account.Email__c = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL;
				account.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalCustomerId4__c = BAT_ConstantsUtility.BLANK_STR;
				account.Registration_Permission__c = false;
				account.Generic_Permission__c = false;
				account.BAT_IsOptInPhoneAuthorization__c = false;
				account.BAT_IsOptInWhatsAppAuthorization__c = false;
			}
            
            //05/10/2020/ Rama Akella/ US#280983 - Added additional fields required for anonymization (FR)
            //10/06/2021/ Akshata Rajmane / US #738065 : MY Vuse - Admin Portal - Anonymise Account
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_FR || account.Country__c == BAT_ConstantsUtility.COUNTRY_MY) {
                account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
                account.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
                account.PersonBirthdate = null;
                account.BAT_OldEmailAddress__c = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL;
                account.BAT_Company__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_IsOptInPhoneAuthorization__c  =  false;
                account.External_Customer_Id__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalSubscriberId__c = BAT_ConstantsUtility.EMPTY_STRING;
            }
            //15/05/2023/ Chirag Kalra / US #1345992 : Added Field to Anonymize for FR
            if(account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR)) {
                account.BAT_VeloFeedbackCallAuthorization__c = false;
             
               
            }
             //hima---
            /*if(account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT)) {
             account.Brand_House__c = '';
               
            }*/
            //08/09/2022/ Chetan Patil/ US#1121760 - Added  fields  for Slovenia anonymization (SI)
            if(account.Country__c == BAT_ConstantsUtility.Country_SI){
                account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
                account.Birth_Date__c = null;
                account.PersonBirthdate = null;
                account.BAT_CommunicationStatus__c = BAT_ConstantsUtility.NONCONTACTABLE_STR; 
                account.BAT_CommunicationStatusUpdateDate__c = Date.today();
                account.Postal_Code__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Email__c = account.PersonEmail;//SI: Added as part of Bug #1176653
            }
               //30-04-2023-Varaprasad sada-1702044-AL - Lead & Account Anonymization
               //30-04-2023-Varaprasad sada-1701460- BA - Lead and Account Anonymization
               //30-04-2023-Varaprasad sada-1702324- MK - Lead & Account Anonymization
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_AL||account.Country__c == BAT_ConstantsUtility.COUNTRY_BA||account.Country__c == BAT_ConstantsUtility.COUNTRY_MK){
                account.Birth_Date__c = null;
                account.PersonBirthdate = null;
                account.BAT_CommunicationStatus__c = BAT_ConstantsUtility.NONCONTACTABLE_STR; 
                account.BAT_CommunicationStatusUpdateDate__c = Date.today();
                account.Gender__c = null;   
                account.BAT_ProfilingConsent__c  = false;
            }

           //24/06/2020/ Dipika Gupta/ US#135383 - Added fields for Poland Anonymisation.
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_PL){
            account.BAT_IsOptInPhoneAuthorization__c  =  false; 
            account.BAT_IsOptInSocialMedia__c =  false;
            account.BAT_ExternalCustomerID5__c = BAT_ConstantsUtility.EMPTY_STRING;
            account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
            }
            //5/11/2020/ Dipika Gupta/ US#295637  - Added fields for CZ Anonymisation.
            //12/02/2022/ Hariharan Pillai/ Bug #1297646 - Added custom PersonMobilePhone__c field to be anonymized
            //*28th March,2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization*/
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || account.Country__c == BAT_ConstantsUtility.COUNTRY_SK) {
                //account.PersonMobilePhone = account.PersonMobilePhone+ BAT_ConstantsUtility.DOT +BAT_ConstantsUtility.ANONYMOUS_DATA;
                //account.PersonMobilePhone__c = account.PersonMobilePhone__c+ BAT_ConstantsUtility.DOT +BAT_ConstantsUtility.ANONYMOUS_DATA;
               account.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
               account.PersonMobilePhone__c = BAT_ConstantsUtility.EMPTY_STRING;
               account.BAT_AnonymizeDate__c = Date.today();
                account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_IsOptInPhoneAuthorization__c  =  false; 
                account.BAT_IsOptInSocialMedia__c =  false;
                account.BAT_ExternalCustomerID5__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Legacy_ID__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BillingCity = BAT_ConstantsUtility.EMPTY_STRING;
                account.Postal_Code__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalSubscriberId5__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                account.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
            }
            //Pranideep 1915019 ES - SHOPIFY Velo ACCOUNT Anonymization
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_ES) 
            {
                account.BAT_IsOptInPhoneAuthorization__c  =  false;
                account.BAT_IsOptInPhoneAuthorization__c= false;
				account.Generic_Permission__c= false;
                account.BAT_ExternalCustomerId4__c= BAT_ConstantsUtility.BLANK_STR;
                account.Birth_Date__c= null;
                account.Gender__c= BAT_ConstantsUtility.BLANK_STR;
                
            }
            
             //Pranideep 1925574 HR - New Glo Website Account Creation, Account update & Account Deletion from website
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_HR) 
            {
                account.BAT_IsOptInPhoneAuthorization__c  =  false;
                account.AccountSource = BAT_ConstantsUtility.EMPTY_STRING;                
                account.BAT_ProfilingConsent__c = false;
                account.BAT_IsOptInPhoneAuthorization__c= false;
				account.Generic_Permission__c= false;
                
            }
            // US #1035808 - CZ - MultiCategory - Account anonymisation on Salesforce || Bug#1060733 - below code only run when last modified source is eCommerce
            if(callFromAccountTrigger && account.Country__c == BAT_ConstantsUtility.COUNTRY_CZ && account.Last_Modified_Source__c !=null && account.Last_Modified_Source__c == BAT_ConstantsUtility.ATH_ECOMMERCE){
                isAccountLastModifiedSourceECommerce = true;
                account.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                account.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                account.PersonMobilePhone = null;
                account.PersonMobilePhone__c = null;
                account.PersonEmail = account.id + BAT_ConstantsUtility.ANONYMOUS_EMAIL;
            }
            
            
            //Starts-- External_Customer_Id fields - by Usha for US#:3601
            //Shipping address on Order is only being used by UK market, that is why it is not configurable for other market currently.
            if(account.Country__c != BAT_ConstantsUtility.COUNTRY_RO &&  account.Country__c != BAT_ConstantsUtility.COUNTRY_CZ && account.Country__c != BAT_ConstantsUtility.COUNTRY_SK && account.Country__c != BAT_ConstantsUtility.UK_STR){
                account.BillingCity = BAT_ConstantsUtility.EMPTY_STRING;
                account.External_Customer_Id__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.External_Customer_ID2__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.External_Customer_ID3__c = BAT_ConstantsUtility.EMPTY_STRING;
                //Starts-- Added ExternalSUbscriberId4 and all four ExternalSubscriberIds fields - by Sudaif for US #13844 04/02/2019
                account.BAT_ExternalCustomerId4__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalSubscriberId__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalSubscriberId2__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalSubscriberId3__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalSubscriberId4__c = BAT_ConstantsUtility.EMPTY_STRING;
            }
                if(account.Country__c != BAT_ConstantsUtility.COUNTRY_RO &&  account.Country__c != BAT_ConstantsUtility.COUNTRY_CZ && account.Country__c != BAT_ConstantsUtility.COUNTRY_SK){
                account.PersonMobilePhone = null;
                account.PersonMobilePhone__c = null;
                account.BAT_FormattedMobile__c = null; // Added as part of Bug#461672 - anonymizing this field as part of global anonymization process for all markets
            }
            //22nd April, 2021/Abhishek Kashyap/US-543158-RO-Added logic to bypass the block if anonymization is triggered from button.
            if(!BAT_ConstantsUtility.IS_ANONYMIZE_ACCOUNT_BUTTON_FLAG && account.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
                   account.PersonMobilePhone = BAT_ConstantsUtility.EMPTY_STRING;
                   account.PersonMobilePhone__c = BAT_ConstantsUtility.EMPTY_STRING;
                   account.PersonOtherPhone = BAT_ConstantsUtility.EMPTY_STRING;
                   account.BAT_FormattedMobile__c = BAT_ConstantsUtility.EMPTY_STRING;
                   account.Phone_Verified__c = false;
                   account.BAT_BypassMobileVerification__c = true;
            }
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
                //Added for all the fields on layout
                account.Email_verified__c = false;
                account.Member_get_Member_Code__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.MgM_Counter__c = BAT_ConstantsUtility.ZERO;
                account.Skip_Repurchase_Lock__c = false;
                account.Wrong_Phone_Number__c = false;
                account.Preferred_Tobacconist_Shop__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Last_Call_Type__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Member_get_Member_Promotional_Code__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Age_verified__c = false;
                account.PersonHasOptedOutOfFax = false;
                //US#417298 - Updating below fields to true for RO Anonymization
                account.PersonDoNotCall = true;
                account.SMS_Opt_Out__c = true;
                account.PersonHasOptedOutOfEmail = true;
                account.AccountSource = BAT_ConstantsUtility.EMPTY_STRING;
                //END US#417298
        //6th April,2021/Abhishek Kashyap/US-466621-Avoid Account Source from getting blank for partial anonymization
                //account.AccountSource = BAT_ConstantsUtility.EMPTY_STRING;
                account.Store_ID__c = BAT_ConstantsUtility.EMPTY_STRING;
                //account.BAT_BypassMobileVerification__c = false; // Commented as part of RO - US#417298 - This field need not to be updated in Partial Anonymization
                account.BAT_EmailVerificationStatus__c = BAT_ConstantsUtility.EMAILVERIFICATION_STATUS_BYPASSED;//Added as part of RO US#417298
                //Commenting below fields for RO Anonymization as part of US#417298
                /*account.Category__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Brand__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Variant__c = BAT_ConstantsUtility.EMPTY_STRING;*/
                //END US#417298
                account.Sector__c = BAT_ConstantsUtility.EMPTY_STRING;
                //Added by Roopa N/US#405880: RO - Added required fields for RO Anonymization  
                account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
                account.External_Customer_ID3__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalCustomerID5__c = BAT_ConstantsUtility.EMPTY_STRING;
                account.Email__c = account.PersonEmail; // Added as part of Bug Fix #456834
                //14th April,2021/Abhishek Kashyap/ BUG-486428-Anonymizing Postal_Code__c to prevent BillingPostalCode population whenever RO anonymized account is reregistered.
                account.Postal_Code__c = BAT_ConstantsUtility.EMPTY_STRING;
                //02/01/2024/Mayank/1568353/RO - creating new Profiling consent on consumer account 
                account.BAT_ProfilingConsent__c  = false;
                                
            }
            //Ends-- External_Customer_Id fields - by Usha for US#:3601
            //14/10/2020/ Sandeep Joshi/ US#284782 - Added fields for South Africa Anonymisation in a new if loop for ZA.
            //09/11/2021/ Pratishtha Pathak/ US#736498 - ZA - Velo/Glo - Account - Opt-in and out/ additional fields are marked FALSE in addition to the existing logic
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_ZA){
                account.Salutation = BAT_ConstantsUtility.EMPTY_STRING;
                account.BAT_ExternalCustomerID5__c = BAT_ConstantsUtility.EMPTY_STRING;
            }
            //BIRTH DATE ANONYMIZATION
            Integer yearOfBirth;
            //Added a null check - by Prince for Bug#: 3263
            if(account.Birth_Date__c !=  null){
                yearOfBirth = account.Birth_Date__c.year();
                account.Birth_Date__c = Date.newInstance(yearOfBirth,1,1);
               
            }
            /*28th March,2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization*/
             if(account.Birth_Date__c !=  null && String.isNotBlank(account.Country__c) && 
                (account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) || 
                      account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SK))){
                account.PersonBirthdate=account.Birth_Date__c;
             
                
                //account.PersonBirthdate=Date.newInstance(yearOfBirth,1,1);*/
            }
            
            /*2nd Feb,2021 / Akshata Rajmane / US #386649 : GR - Admin Portal - Anonymise Account*/
            if(account.Country__c == BAT_ConstantsUtility.COUNTRY_CY){
                account.BAT_IsOptInPhoneAuthorization__c  =  false; 
                account.BAT_IsOptInWhatsAppAuthorization__c = false;
                account.PersonBirthdate = null;
            }
            //19/4/2022 | Praveen | bug #973418 |UK - Salesforce Data Retention
            if(account.Country__c == BAT_ConstantsUtility.UK_STR){
                account.PersonBirthdate = null;                
                account.Email__c = account.PersonEmail;             
                account.Birth_Date__c = null;    
                account.Gender__c = null;    
            }
            //14/10/2024 | Chirag | US #1855607 || RS - New Glo Website Account Creation, Account update, Account Delete
            if(account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RS)){
                account.AccountSource = BAT_ConstantsUtility.EMPTY_STRING;                
                account.BAT_ProfilingConsent__c = false;             
            }
            System.debug('-=11'+ account.Country__c);
          /*  //12/03/2024 - Chirag Kalra 1635176 UA - FMC Lead Anonymization
            if(account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA)){
                account.FMC_Newsletter_Commercial_Authorization__c= false;
                account.FMC_Opt_In_Mobile_Text_WhatsApp__c= false;
                
            }*/
            //add the countries in countrySet
            countrySet.add(account.Country__c);
        }
        //Calling the updateEmailAndPhoneMethod to stamp the standard Field values in Custom Fields
        BAT_Utilities.updateEmailAndPhone(accountList,null,countrySet);
        //Workitem - 8593 Setting flag to true to exempt trigger run
        BAT_ConstantsUtility.isTriggerBypassed = true;
       BAT_ConstantsUtility.isAnonymized = true;
        
        
        return accountList;
    }
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedAssets
*@ returns:        List<Asset>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Assets of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
                                14/01/2021/Idrees Ali/US#340701- Added Related Account Email for anonymization
************************************************************************************************************************************/
    public Static List<Asset> anonymizeRelatedAssets(list<Id> accountIds){
        
        List<asset> assetsToUpdate = [select Id,AccountName__c, account.Country__c FROM Asset WHERE AccountId IN :accountIds];
        
        for(Asset asset:assetsToUpdate){
            asset.AccountName__c = BAT_ConstantsUtility.EMPTY_STRING;
            asset.BAT_RelatedAccount__c = BAT_ConstantsUtility.EMPTY_STRING;
                           
        }    
        return assetsToUpdate;
    }
    
   /************************************************************************************************************************************
*@ author:         ITC  
*@ method:         delinkRelatedAssetswithaccount
*@ returns:        List<Asset>
*@ params:         List<Id>
*@description:     [All Markets] Logic to delink the relationship- related Assets of accounts when it runs from BAT_AutoAnonymizeAccountBatch
29/12/2023/Shanmuga/US#1586072- IT GLO - Automated anonymization on Account (related Asset)-delinking the Asset-Account
************************************************************************************************************************************/
 
    public Static List<Asset> DelinkRelatedAssets(list<Id> accountIds){
        List<asset> assetsToUpdate = [select Id,AccountName__c, account.Country__c,AccountId,ContactId FROM Asset WHERE AccountId IN :accountIds];
        
        for(Asset asset:assetsToUpdate){
            asset.AccountId=null;
               asset.ContactId=null;
             
           
       }   
        return assetsToUpdate;
    }
    
    
    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         anonymizeRelatedCases
    *@ returns:        List<Case>
    *@ params:         List<Id>
    *@description:     [All Markets] Logic to anonymize related Cases of accounts. 
    *@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
                       21-07-2020/ Akshata Rajmane / ID: Sprint-4: US#226705 / added fields for indonesia
                       05/10/2020/ Rama Akella/ US#280983 - Added additional fields required for anonymization (FR)
                       12.05.2021/Idrees Ali/US#505984 - Avalanche - Admin Portal - Anonymise Account
                       03/4/2023 | Praveen | bug #973418 |UK - Salesforce Data Retention
    ************************************************************************************************************************************/
    public Static List<Case> anonymizeRelatedCases(list<Id> accountIds){
        
        List<case> casesToUpdate =[SELECT Id,AccountName__c,AccountEmail__c,Description,Address__c,Phone_Number__c,
                                   Email__c,First_Name__c,Last_Name__c,Country__c,BAT_CaseOriginatedChannel__c, AccountId, 
                                   Account.FirstName, Account.LastName, Account.PersonEmail, Account.PersonMobilePhone
                                   FROM Case WHERE AccountId IN :accountIds];
        
        for(Case cs :casesToUpdate){
            cs.AccountName__c = BAT_ConstantsUtility.EMPTY_STRING;
            cs.AccountEmail__c = BAT_ConstantsUtility.EMPTY_STRING;
            cs.Address__c = BAT_ConstantsUtility.ANONYMOUS_DATA;
            cs.Description = (cs.Country__c == BAT_ConstantsUtility.UK_STR) ? cs.Description:BAT_ConstantsUtility.EMPTY_STRING;
            //Added below ID changes as part of US#226705 : Anonymization of case
            //US#280983 - Added additional fields required for anonymization (FR)
            //RO - US#417298 - Added Country RO to execute below logic for RO Anonymization
            //12.05.2021/Idrees Ali/US#505984 - Enabled below logic for EU anonymization
            if(cs.Country__c == BAT_ConstantsUtility.COUNTRY_ID || cs.Country__c == BAT_ConstantsUtility.COUNTRY_FR || cs.Country__c == BAT_ConstantsUtility.COUNTRY_RO ||
               (cs.Country__c == BAT_ConstantsUtility.DE_STR && cs.BAT_CaseOriginatedChannel__c == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE)){
                cs.First_Name__c =  BAT_ConstantsUtility.ANONYMOUS_DATA;
                cs.Last_Name__c =  BAT_ConstantsUtility.ANONYMOUS_DATA;
                cs.Email__c =  BAT_ConstantsUtility.EMPTY_STRING;
                cs.Phone_Number__c =  BAT_ConstantsUtility.ANONYMOUS_DATA;
            }
            //US #1035808 - CZ - MultiCategory - Account anonymisation on Salesforce || Bug#1060733 AC5b : For CZ market below code only run when it call from account trigger and last modified source eCommerce
            if(callFromAccountTrigger && isAccountLastModifiedSourceECommerce && cs.Country__c == BAT_ConstantsUtility.COUNTRY_CZ ){
                cs.First_Name__c = (cs.First_Name__c == null || cs.First_Name__c.trim() == '' ) ? cs.Account.FirstName : cs.First_Name__c;
                cs.Last_Name__c = (cs.Last_Name__c == null || cs.Last_Name__c.trim() == '' ) ? cs.Account.LastName : cs.Last_Name__c;
                cs.Email__c = (cs.Email__c == null || cs.Email__c.trim() == '' ) ? cs.Account.PersonEmail : cs.Email__c;
            }
            //Added as part of US#461730
            if(cs.Country__c == BAT_ConstantsUtility.COUNTRY_RO)
            {
                cs.SuppliedEmail = BAT_ConstantsUtility.EMPTY_STRING;
            }
            //END US#461730   
        }
        return casesToUpdate;
    }  
/************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         anonymizeRelatedBrandProfiles
    *@ returns:        List<BAT_BrandProfile__c>
    *@ params:         List<Id>
    *@description:     [RO] Logic to anonymize related Brand Profiles of accounts. 
    *@changeHistory:   22nd Mar,2021/ Roopa N / RO : Sprint 3: US#417298 /Created the method
    ************************************************************************************************************************************/
    public Static List<BAT_BrandProfile__c> anonymizeRelatedBrandProfiles(list<Id> accountIds){
        
        List<BAT_BrandProfile__c> brandProfilesToUpdate =[SELECT Id,BAT_Account__c,BAT_ExternalID__c,BAT_Country__c
                                                          FROM BAT_BrandProfile__c WHERE BAT_Account__c IN :accountIds];        
        for(BAT_BrandProfile__c bp : brandProfilesToUpdate){
            if(bp.BAT_Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RO)){
                bp.BAT_ExternalID__c =  BAT_ConstantsUtility.EMPTY_STRING;
                bp.BAT_Status__c = 'Inactive';
            }
        } 
        return brandProfilesToUpdate;
    }       
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedServeys
*@ returns:        List<Survey_Information__c>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Survey Informations of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
************************************************************************************************************************************/
    public Static List<Survey_Information__c> anonymizeRelatedServeys(list<Id> accountIds){
        
        List<Survey_Information__c> surveysToUpdate =new List<Survey_Information__c>();
        
       for(Survey_Information__c surveyInfo :[SELECT Id,Account__c  FROM Survey_Information__c WHERE Account__c IN :accountIds]){
            surveyInfo.Account__c = null;
            surveysToUpdate.add(surveyInfo);
        } 
        return surveysToUpdate;
    }   
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedEvents
*@ returns:        List<Event>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Events of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
************************************************************************************************************************************/         
    public Static List<Event> anonymizeRelatedEvents(list<Id> accountIds){
        
        List<Event> eventsToUpdate =[SELECT Id,WhatId,Subject,Description,Outcome__c,Sentiment__c,Result__c FROM Event WHERE WhatId IN :accountIds];
        for(Event event : eventsToUpdate){
            event.Subject = BAT_ConstantsUtility.ANONYMOUS_DATA; // added constant varible
            event.Description = BAT_ConstantsUtility.EMPTY_STRING;
            event.Outcome__c = null;
            event.Result__c = BAT_ConstantsUtility.ANONYMOUS_RESULT; // added constant varible
            event.Sentiment__c = BAT_ConstantsUtility.EMPTY_STRING;
        }       
        return eventsToUpdate;
    }
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedTasks
*@ returns:        List<Task>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Tasks of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
************************************************************************************************************************************/         
    public Static List<Task> anonymizeRelatedTasks(list<Id> accountIds){
        
        List<Task> tasksToUpdate =[SELECT Id,WhatId,Subject,Description,Outcome__c,Sentiment__c,Result__c FROM Task WHERE WhatId IN :accountIds];
        for(Task task : tasksToUpdate){
            task.Subject = BAT_ConstantsUtility.ANONYMOUS_DATA; // added constant varible.
            task.Description = BAT_ConstantsUtility.EMPTY_STRING;
            task.Outcome__c = null;
            task.Result__c = BAT_ConstantsUtility.ANONYMOUS_RESULT; // added constant varible
            task.Sentiment__c = BAT_ConstantsUtility.EMPTY_STRING;
        }     
        return tasksToUpdate;
    }   
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizaRelatedLeads
*@ returns:        List<Lead>
*@ params:         List<Account>
*@description:     [All Markets] Logic to anonymize related Leads of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
************************************************************************************************************************************/              
    public Static List<Lead> anonymizaRelatedLeads(List<Account> accountList){
        Set<Id> leadIds = new Set<Id>();
        List<Lead> leadsToAnonymize = new List<Lead>();
        for(Account account : accountList){
            if(account.Related_Lead__c != null){
                Lead lead = new Lead();
                lead.id = account.Related_Lead__c;
                lead.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                lead.Street  = BAT_ConstantsUtility.EMPTY_STRING;
                lead.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                lead.Email = account.id +BAT_ConstantsUtility.ANONYMOUS_EMAIL;
                lead.MobilePhone = BAT_ConstantsUtility.ANONYMOUS_DATA;
                // US #1035808 - CZ - MultiCategory - Account anonymisation on Salesforce || Bug#1060733 : CZ market requested for mobilephone to be blank 
                if(callFromAccountTrigger && isAccountLastModifiedSourceECommerce && (account.Country__c == BAT_ConstantsUtility.COUNTRY_CZ)){
                    lead.Salutation = null;
                    lead.MobilePhone = null;
                    lead.BAT_ExternalSubscriberId5__c = null;
                    leadIds.add(account.Related_Lead__c);
                }
                lead.Registration_Permission__c = false;
                lead.Submit_Surveys_Permission__c = false;
                lead.Trial_Information_Permission__c = false;
                lead.External_Systems_Information_Permission__c = false;
                lead.Generic_Permission__c = false;
                lead.BAT_isVypeOptInEmailCommunication__c = false;
                lead.BAT_isVypeOptInMobileTextWhatsApp__c = false;
                lead.BirthDate__c=account.Birth_Date__c;
                leadsToAnonymize.add(lead);
            }
        }
        // US #1035808 - CZ - MultiCategory - Account anonymisation on Salesforce || delete all private snapshot
        List<ContentDocument> delPrivacyDocs = new List<ContentDocument>();
        if(leadIds != null && !leadIds.isEmpty()){
            delPrivacyDocs = deleteLeadPrivacySanpshots((new List<Id>(leadIds)));
        }
        if(delPrivacyDocs != null && !delPrivacyDocs.isEmpty()){
             delete delPrivacyDocs;
        }
        return leadsToAnonymize;
    }
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedIndividuals
*@ returns:        List<Individual>
*@ params:         List<Account>
*@description:     [All Markets] Logic to anonymize related individuals of accounts. 
*@changeHistory:   22-07-2022/ Sonal Srivastava / CH: Sprint-3: US#1076739/Created the method 
************************************************************************************************************************************/
    public Static List<Individual> anonymizeRelatedIndividuals(List<Account> accountList){
        List<Individual> individualsToAnonymize = new List<Individual>();
        for(Account account : accountList){
            if(account.PersonIndividualId != null){
                Individual individual = new Individual();
                individual.id = account.PersonIndividualId;
                individual.LastName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                individual.FirstName = BAT_ConstantsUtility.ANONYMOUS_DATA;
                individualsToAnonymize.add(individual);
            }
        }
        return individualsToAnonymize;
    }
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedOpportunity
*@ returns:        List<Opportunity>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Opportunities of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
************************************************************************************************************************************/                   
    public Static List<Opportunity> anonymizeRelatedOpportunity(list<Id> accountIds){
        
        List<Opportunity> opportunitiesToUpdate =[SELECT Id,account.Is_Trialist__c,Name,ByPassAssetFilter__c FROM Opportunity WHERE AccountId IN :accountIds];
        for(Opportunity oppty : opportunitiesToUpdate){
            if(oppty.account.Is_Trialist__c){
                oppty.Name = BAT_ConstantsUtility.ANONYMOUS_TRIAL_NAME + account.Id; // added constant varible
                oppty.ByPassAssetFilter__c = true;
            }
        }
        return opportunitiesToUpdate;
    }   
    
    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedOrders
*@ returns:        List<Order>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Orders of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
                   06/12/2019 / Souvik Dinda/ US#47980 - Bifurcating logic for Romania
                   29/06/2020/Tejaswi Nissankula/US#136698 : Added ID Country check for shipping and billing related fields
                   24/06/2020/ Dipika Gupta/ US#135383 - Added fields for Poland Anonymisation.
                   5/11/2020/ Dipika Gupta/ US#295637  - Added conditions for CZ Anonymisation.
                   24.07.2020/Edwin Resendiz/Bug #225170 - Added first name and Last name billing to RO.
                    14/10/2020/ Sandeep Joshi/ US#284782 - Added South Africa Anonymisation ZA country check in OR condition in two existing if loop                   
                   05/10/2020/ Rama Akella/ US#280983 - Added additional fields required for anonymization (FR)
                   :11.03.2021/Akshata Rajmane/Bug#443536:Billing Address are not blank on the order after Account Anonymisation
                   12.05.2021/Idrees Ali/US#505984 - Avalanche - Admin Portal - Anonymise Account
                    10/06/2021/ Akshata Rajmane / US #738065 : MY Vuse - Admin Portal - Anonymise Account
                   //12.05.2022/Turbasu Ghosh/US#918330- Added IT Country check
************************************************************************************************************************************/                   
    public Static List<Order> anonymizeRelatedOrders(list<Id> accountIds){
        List<Order> OrdersToUpdate =[SELECT Id,Phone__c,
                                            Shipping_First_Name__c,Shipping_Last_Name__c,
                                            ShippingCity,ShippingStreet,ShippingState,AccountId,
                                            account.Country__c,account.AccountSource,Billing_First_Name__c,Billing_Last_Name__c,
                                            BillingCountry,BillingPostalCode,BillingStreet,BillingState,BillingCity,
                                            ShippingPostalCode,ShippingCountry
                                            FROM Order WHERE AccountId IN :accountIds];
        for(Order order : OrdersToUpdate){
            order.Phone__c = null;
            order.Shipping_First_Name__c = BAT_ConstantsUtility.EMPTY_STRING;
            order.Shipping_Last_Name__c = BAT_ConstantsUtility.EMPTY_STRING;
            order.ShippingStreet = BAT_ConstantsUtility.EMPTY_STRING;
            //12.05.2022/Turbasu Ghosh/US#918330- Added IT Country check
            if(order.account.Country__c != BAT_ConstantsUtility.COUNTRY_RO || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_FR  || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_IT){
                order.ShippingCity = BAT_ConstantsUtility.EMPTY_STRING;
            }
            order.ShippingState = BAT_ConstantsUtility.EMPTY_STRING;
            order.ShippingPostalCode = BAT_ConstantsUtility.EMPTY_STRING;
            order.ShippingCountry = BAT_ConstantsUtility.EMPTY_STRING;
            //14/10/2020/ Sandeep Joshi/ US#284782 - Added South Africa Anonymisation ZA country check in OR condition in below if loop
           //12.05.2021/Idrees Ali/US#505984 - Added below logic for EU Order anonymisation
            //10/06/2021/ Akshata Rajmane / US #738065 : MY Vuse - Admin Portal - Anonymise Account
            //12.05.2022/Turbasu Ghosh/US#918330- Added IT Country check
            if(order.account.Country__c == BAT_ConstantsUtility.COUNTRY_IT || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_MX_STR || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_ID || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_MY 
            || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_PL || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_ZA || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_FR
            || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_SK || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_GR ||(order.account.Country__c == BAT_ConstantsUtility.DE_STR && order.account.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE)){
                order.Billing_First_Name__c = BAT_ConstantsUtility.EMPTY_STRING;
                order.Billing_Last_Name__c = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingStreet = BAT_ConstantsUtility.EMPTY_STRING;
            }
            //14/10/2020/ Sandeep Joshi/ US#284782 -  Added South Africa Anonymisation ZA country check in OR condition in below if loop                
            //24/06/2020/ Dipika Gupta/ US#135383 - Added fields for Poland Anonymisation.
            //11.03.2021/Akshata Rajmane/Bug#443536:Billing Address are not blank on the order after Account Anonymisation
           //12.05.2021/Idrees Ali/US#505984 - Added below logic for EU Order anonymisation
           //16/02/2021/Rajeswari Nidamanuri/US #893452 :PT Glo - Admin Portal - Anonymise Account- related order updated
           //12.05.2022/Turbasu Ghosh/US#918330- Added IT Country check
           //30/06/2022/Rajeswari/US #1029822 : CH - Admin Portal - Anonymise Account - related order updated
            if(order.account.Country__c == BAT_ConstantsUtility.COUNTRY_IT || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_ID || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_PL || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_ZA
            || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_FR  || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_MY ||order.account.Country__c==BAT_ConstantsUtility.COUNTRY_PT||order.account.Country__c == BAT_ConstantsUtility.COUNTRY_CH||
             order.account.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_SK|| order.account.Country__c == BAT_ConstantsUtility.COUNTRY_GR || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_CY || (order.account.Country__c == BAT_ConstantsUtility.DE_STR && order.account.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE)){
                order.BillingState = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingPostalCode = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingCountry = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingCity = BAT_ConstantsUtility.EMPTY_STRING;
            }
            //11.03.2021/Akshata Rajmane/Bug#443536:Billing Address are not blank on the order after Account Anonymisation
            //10/06/2021/ Akshata Rajmane / US #738065 : MY Vuse - Admin Portal - Anonymise Account
            //16/02/2021/Rajeswari Nidamanuri/US #893452 :PT Glo - Admin Portal - Anonymise Account - related order updated
            //12.05.2022/Turbasu Ghosh/US#918330- Added IT Country check
            //30/06/2022/Rajeswari/US #1029822 : CH - Admin Portal - Anonymise Account - related order updated 
            if(order.account.Country__c == BAT_ConstantsUtility.COUNTRY_IT || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_RO 
            || order.account.Country__c == BAT_ConstantsUtility.COUNTRY_MY || order.account.Country__c==BAT_ConstantsUtility.COUNTRY_PT||order.account.Country__c == BAT_ConstantsUtility.COUNTRY_CH) {
                order.Billing_First_Name__c = BAT_ConstantsUtility.EMPTY_STRING;
                order.Billing_Last_Name__c = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingCountry = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingPostalCode = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingStreet = BAT_ConstantsUtility.EMPTY_STRING;
                order.BillingState = BAT_ConstantsUtility.EMPTY_STRING;
            }
        }
        
        return OrdersToUpdate;
    } 
 /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedContactPoints
*@ returns:        List<ContactPointTypeConsent>
*@ params:         List<Id>
*@description:     [All Markets] Logic to update related contactPointTypeConsents of accounts. 
*@changeHistory:   30-06-2022/Rajeswari Nidamanuri/ CH: Sprint-2: US#1029822/Created the method
************************************************************************************************************************************/                   
   public Static List<ContactPointTypeConsent> anonymizeRelatedContactPoints(list<Id> accountIds){
        
        List<ContactPointTypeConsent> contactPointsToUpdate =[SELECT Id,BAT_Account__c,Name,PrivacyConsentStatus,BAT_Channel__c,BAT_Country__c FROM ContactPointTypeConsent WHERE BAT_Account__c IN :accountIds];
        for(ContactPointTypeConsent consent: contactPointsToUpdate){
            if(consent.BAT_Country__c == BAT_ConstantsUtility.COUNTRY_CH && consent.PrivacyConsentStatus!=BAT_ConstantsUtility.ConsentStatus_OptOut){
                    consent.PrivacyConsentStatus = BAT_ConstantsUtility.ConsentStatus_OptOut;
                }
               
            }
        return contactPointsToUpdate;
    }   
     /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         deletePrivacySanpshots
*@ returns:        List<ContentDocument>
*@ params:         List<Account>,List<Id>
*@description:     [All Markets] Logic to anonymize related Orders of accounts. 
*@changeHistory:   10-09-2019/ Rajesh Potla / ENH: Sprint-28: US#34217/Created the method
                   11-12-2020/ Kushagra Jain /Bug #353988:Updated the method to fix  ContentDocumentLink requires a filter by a single Id error
                   08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account - Refined list to prevent any duplicates
************************************************************************************************************************************/                   
        public Static List<ContentDocument> deletePrivacySanpshots(List<id> accountids){
        List<ContentDocument> documents = new List<ContentDocument>();
        List<ContentDocument> uniqueDocuments = new List<ContentDocument>();
        if(!accountids.isEmpty()){
        for(ContentDocumentLink cdl : [SELECT id, ContentDocumentId  
                                       FROM ContentDocumentLink 
                                       WHERE LinkedEntityID IN :accountids]){
                                           documents.add(new ContentDocument(ID = cdl.ContentDocumentId));
                                       }
        }
        if(!documents.isEmpty()){
            for(ContentDocument doc : documents){
                if(uniqueDocuments.isEmpty() || !uniqueDocuments.contains(doc)){
                    uniqueDocuments.add(doc);
                }
            }
        }
        return uniqueDocuments;
    }
    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createBulkTask
    * @returns       : task
    * @params        : String subject, Date dueDate, String priority,String callType, String comments, Id userId
    * @description   : Create tasks from Generate Bulk Task Tab.
    * @changeHistory : 11.09.2019/ Souvik Dinda / US#34846 Created the method.
    *********************************************************************************************************/ 

    public static List<Task> createBulkTask(List<Id> accountIdList, String subject, Date dueDate, String priority,
                                                 String callType, String comments, Id userId)
    {
        List<Task> taskList = new List<Task>();
        for(Id accountId : accountIdList){
            Task newTask = new Task();
            newTask.Subject = subject;
            newTask.WhatId = accountId;
            newTask.ActivityDate = dueDate;
            newTask.Call_Type__c = callType;
            newTask.OwnerId = userId;
            newTask.Priority = priority;
            newTask.Description = comments;
            taskList.add(newTask);
        }
        return taskList;
    }
    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         deleteLeadPrivacySanpshots
    *@ returns:        List<ContentDocument>
    *@ params:         List<Id>, LeadIds
    *@description:     This method is to return privacy snapshots associated with the given list of lead records 
    *@changeHistory:   10-01-2019/ Satya Nalluri / BUG #48839/Created the method
    ************************************************************************************************************************************/                   
    public Static List<ContentDocument> deleteLeadPrivacySanpshots(List<id> leadids){
    List<ContentDocument> documents = new List<ContentDocument>();
    if(!leadids.isEmpty()){
        for(ContentDocumentLink cdl : [SELECT id, ContentDocumentId  
                                          FROM ContentDocumentLink 
                                           WHERE LinkedEntityID IN :leadids]){ documents.add(new ContentDocument(ID = cdl.ContentDocumentId));
                                           }
    }   
     return documents;
    } 
    
    /************************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getRecordTypeDeveloperName
    * @returns       : Map of case recordtypes
    * @params        : String objectname
    * @description   : Returns recordtype map.
    * @changeHistory : 26.09.2019/ Satya Nalluri / US#44705 Created the method.
    *********************************************************************************************************/ 

    public static Map<String, String> getRecordTypeDeveloperName(String ObjectName) {
            
            Schema.DescribeSObjectResult objTypesDesc = Schema.getGlobalDescribe().get(objectName).getDescribe();
            List<Schema.RecordTypeInfo> lstRT = objTypesDesc .getRecordTypeInfos();
            Map<String, String>  rtMap  = new Map<String, String>();
            for(Schema.RecordTypeInfo rt : lstRT){
                rtMap.put(rt.getRecordTypeId(), rt.getDeveloperName());
            }
            return rtMap;
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : getDuplicateLeadsbyCountry
* @returns       : Map<LeadPhoneDuplicatesCountry__mdt>
* @params        : Set<string>
* @description   : [All Market] : Retrieves LeadPhoneDuplicatesCountry custom metadata records based on country 
* @changeHistory : 13.08.2019 / Tejaswi Nissankula / created the method
                   22-Oct-2020/ Roopa N/ CZ: Sprint2: US#290314 - Added new field "BAT_IsAccountMobileCheck__c" to Query
                   21.06.2021 || Allada Yeshwanth || PL || PBI: #538696 || Added BAT_DuplicateMobileCheckEnabledProfiles__c in the query
                   22.06.2022 || Sonal Srivastava || CH : 1035486 || Added BAT_FMCBrandOptions__c metadata field to be querried

*********************************************************************************************************/
    
    public static Map<string,LeadPhoneDuplicatesCountry__mdt> getDuplicateLeadsbyCountry(Set<string> countrySet){
        
        Map<string,LeadPhoneDuplicatesCountry__mdt> duplicateLeadCountryMap = new Map<string,LeadPhoneDuplicatesCountry__mdt>();
        if(!countrySet.isEmpty()){
            for(LeadPhoneDuplicatesCountry__mdt rec : [SELECT ID,MasterLabel,
                                                              DeveloperName,BAT_isDuplicateMobileAllowed__c ,
                                                              BAT_DuplicateMobileCheckEnabledProfiles__c,
                                                              BAT_DuplicateControllingField__c,
                                                              BAT_DuplicateControllingFieldValue__c,
                                                              BAT_IsBrandCheckRequired__c ,
                                                              BAT_IsAccountBrandMobileCheck__c,
                                                              BAT_IsAccountMobileCheck__c,
                                                              BAT_FMCBrandOptions__c
                                                              FROM LeadPhoneDuplicatesCountry__mdt 
                                                              where MasterLabel In: countrySet]){
                    duplicateLeadCountryMap.put(rec.MasterLabel,rec);                                                      
            }
            
        }
        return duplicateLeadCountryMap;
      }        
    
/********************************************************************************************************
* @author        : Deloitte
* @method Name   : globalMarketDuplicateCheckSetting
* @returns       : defineMarket
* @params        : Set<string>,List<string>
* @description   : [All Market] : Retrieves globalMarketDuplicateCheckSetting custom metadata records based on country and object
* @changeHistory : 22.08.2019 / Tejaswi Nissankula / created the method

*********************************************************************************************************/
    
    public static defineMarket globalMarketDuplicateCheckSetting(Set<string> countrySet,List<string> objectNameList){
        
    Boolean isUCCAB = false;
        if(!countrySet.isEmpty()){
            for(BAT_GlobalMarketDuplicateCheckSetting__mdt rec : [SELECT ID,MasterLabel,
                                                              BAT_ObjectName__c,
                                                              BAT_IsBrandDependent__c,
                                                              BAT_IsEmailDependent__c,
                                                              BAT_IsPhoneDependent__c
                                                              FROM BAT_GlobalMarketDuplicateCheckSetting__mdt 
                                                              where MasterLabel In: countrySet AND
                                                              BAT_ObjectName__c In : objectNameList]){
        if(rec.BAT_IsBrandDependent__c && rec.BAT_IsPhoneDependent__c){
          isUCCAB = true;
                    return new defineMarket(isUCCAB); 
        }
            }
            
        }
        return new defineMarket(isUCCAB);
        
    }  

  /********************************************************************************************************
* @author        : Deloitte
* @InnerclassName: defineMarket
* @description   : [All Market]used to define market based on records in BAT_GlobalMarketDuplicateCheckSetting__mdt
          custom metadata type
* @changeHistory : 26.08.2019 / Tejaswi Nissankula/ created the method

*********************************************************************************************************/
    public class defineMarket{
       public Boolean isUCCAB;
       
     public defineMarket(boolean isUCCAB){
            this.isUCCAB = isUCCAB;
        }
        
     } 

    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : getAccountSourceConfigDetails
* @returns       : List<BAT_AccountSourceConfiguration__mdt>
* @params        : none
* @description   : [All Market] : Retrieves AccountSourceConfiguration custom metadata type records
* @changeHistory : 12.09.2019 / Tejaswi Nissankula / created the method
                 : 16.01.2020/Tejaswi Nissankula/ Added BAT_UserName__c field in query bug #76248

*********************************************************************************************************/
    
    public static List<BAT_AccountSourceConfiguration__mdt> getAccountSourceConfigDetails(){
        
        List<BAT_AccountSourceConfiguration__mdt> accountSourceConfigList = new List<BAT_AccountSourceConfiguration__mdt>();
        for(BAT_AccountSourceConfiguration__mdt rec : BAT_AccountSourceConfiguration__mdt.getAll().values()){
                    accountSourceConfigList.add(rec);                                                      
            }
        return accountSourceConfigList;
    }
    
/********************************************************************************************************
* @author        : Deloitte
* @method Name   : isGenericPermissionRequired
* @returns       : Boolean isGenericPermissionRequired;
* @params        : SObject objectRecord
* @description   : [All Market] : returns the Generic_Permission__c Value for the record.
* @changeHistory : 23.09.2019/Osheen Sahajpal/Created the method
*********************************************************************************************************/
    public static Boolean isGenericPermissionRequired(SObject objectRecord){
        Boolean isGenericPermissionRequired = false;
        Map <String, Schema.SObjectField> sObjectFieldMap = objectRecord.getSobjectType().getDescribe().fields.getMap();
        Boolean isVypeOptInEmailCommunication = Boolean.valueOf(objectRecord.get(BAT_ConstantsUtility.IsVypeOptInEmailCommunication_API_Name));
        Boolean isVypeOptInMobileTextWhatsApp = Boolean.valueOf(objectRecord.get(BAT_ConstantsUtility.IsVypeOptInMobileTextWhatsApp_API_Name));
        if(sObjectFieldMap.containsKey(BAT_ConstantsUtility.IsVypeOptInEmailCommunication_API_Name) 
            && sObjectFieldMap.containsKey(BAT_ConstantsUtility.IsVypeOptInMobileTextWhatsApp_API_Name)
        ){
            if(isVypeOptInEmailCommunication || isVypeOptInMobileTextWhatsApp){ 
                isGenericPermissionRequired = true;
            } else {
                isGenericPermissionRequired = false;
            }
        }
        return isGenericPermissionRequired;
    }
    
 /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : containsIgnoreCaseCheck
    * @returns       : void
    * @params        : set<string>,string
    * @description   : [UCCAB(UA,KZ)]Method to check contains and ignore case of set of strings
                      
    * @changeHistory : 27.09.2019/Tejaswi Nissankula/Created the method
    *********************************************************************************************************/
    public static boolean containsIgnoreCaseCheck(set<string> accountSourceSet, string valueToValidate){

       if(accountSourceSet != null && !accountSourceSet.isEmpty() && string.isNotBlank(valueToValidate)){
            for(string value: accountSourceSet){
                if(value.containsIgnoreCase(valueToValidate)){
                    return true;
                }
            }
        }
        return false;

    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : loadEntryCodeCheckConfigMetadata
    * @returns       : Map<String, BAT_EntryCodeCheckConfiguration__mdt>
    * @params        : 
    * @description   : [All Markets]Method to load BAT_EntryCodeCheckConfiguration__mdt in a map.
    * @changeHistory : 15.11.2019/Souvik Dinda/US#34462 - Created the method
                     :  26.04.2021/Souvik Dinda/US#494440: Introduced a new Map to store Country and Asset Sources from BAT_ExternalAssetSourceConfiguration__mdt for checking asset sources more than one for a market.
    *********************************************************************************************************/
    public static Map<String, BAT_EntryCodeCheckConfiguration__mdt> loadEntryCodeCheckConfigMetadata(){
        Map<String, BAT_EntryCodeCheckConfiguration__mdt> entryCodeCheckMap = new Map<String, BAT_EntryCodeCheckConfiguration__mdt>();
        for(BAT_EntryCodeCheckConfiguration__mdt entryCodeCheckConfig : [SELECT MasterLabel, BAT_AssetType__c,
                                                                        BAT_BrandNotIn__c, BAT_UsernameToBypass__c, BAT_AssetSourceFieldNameToBypass__c,
                                                                         BAT_AssetSourceValueToBypass__c
                                                                        FROM BAT_EntryCodeCheckConfiguration__mdt]){
                                                                           entryCodeCheckMap.put(entryCodeCheckConfig.MasterLabel, entryCodeCheckConfig);
                                                                           if(entryCodeCheckConfig.BAT_AssetSourceValueToBypass__c != null){
                                                                                entryCodeCheckAssetSourceMap.put(entryCodeCheckConfig.MasterLabel, new Set<String>(entryCodeCheckConfig.BAT_AssetSourceValueToBypass__c.split(BAT_ConstantsUtility.COMMA_STR)));
                                                                            }     
            
        }
        return entryCodeCheckMap;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : loadGDPRReportFieldsMap
    * @returns       : Map<String, BAT_GDPRReportFields__mdt>
    * @params        : 
    * @description   : [All Markets]Method to load BAT_GDPRReportFields__mdt in map.
    * @changeHistory : 22.11.2019/Souvik Dinda/US#34462 - Created the method
    *********************************************************************************************************/
    public static Map<String, List<BAT_GDPRReportFields__mdt>> loadGDPRReportFieldsMap(){
        Map<String, List<BAT_GDPRReportFields__mdt>> gdprReportFieldsMap = new Map<String, List<BAT_GDPRReportFields__mdt>>();
        List<BAT_GDPRReportFields__mdt> gdprReportFieldsList = [SELECT MasterLabel, BAT_Country__c,
                                                                        BAT_FieldAPI__c, BAT_ObjectName__c,
                                                                        BAT_SectionName__c, BAT_Sequence__c
                                                                        FROM BAT_GDPRReportFields__mdt
                                                                        WHERE BAT_Country__c != null
                                                                        AND BAT_ObjectName__c != null
                                                                        ORDER BY BAT_Sequence__c asc];
        
        for(BAT_GDPRReportFields__mdt gdprReportField : gdprReportFieldsList){
            if(!gdprReportFieldsMap.containsKey(gdprReportField.BAT_Country__c)){
                   gdprReportFieldsMap.put(gdprReportField.BAT_Country__c, new List<BAT_GDPRReportFields__mdt>());
                }
                gdprReportFieldsMap.get(gdprReportField.BAT_Country__c).add(gdprReportField);
        }
        return gdprReportFieldsMap;
    }
      /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getConsentDateUpdateConfig
    * @returns       : Map<String, List<BAT_ConsentDateUpdateConfiguration__mdt>>
    * @params        : 
    * @description   : [RO]Method to load BAT_ConsentDateUpdateConfiguration__mdt in map.
    * @changeHistory : 27.11.2019/Rajesh Potla/US#47996- Created the method
                       5th April,2021/Roopa N/RO:US#461730 - Added field in metadata query
    *********************************************************************************************************/
    public static Map<String, List<BAT_ConsentDateUpdateConfiguration__mdt>> getConsentDateUpdateConfig(){
        Map<String, List<BAT_ConsentDateUpdateConfiguration__mdt>> consentDateUpdateConfigMap = new Map<String, List<BAT_ConsentDateUpdateConfiguration__mdt>>();
       // Preparing map of Fieldapi names to be considered with country value as key.
       //Added BAT_IsUpdate__c field to the below query as part of US#461730
        for(BAT_ConsentDateUpdateConfiguration__mdt consentRecord : BAT_ConsentDateUpdateConfiguration__mdt.getAll().values() ){
          if(!consentDateUpdateConfigMap.containsKey(consentRecord.MasterLabel)){
             consentDateUpdateConfigMap.put(consentRecord.MasterLabel, new List<BAT_ConsentDateUpdateConfiguration__mdt>());
           }
           consentDateUpdateConfigMap.get(consentRecord.MasterLabel).add(consentRecord);
        }
         return consentDateUpdateConfigMap;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getLeadValidationBypassConfig
    * @returns       : Map<String, BAT_LeadBypassValidationRules__mdt>
    * @params        : 
    * @description   : [All Market] Method to load BAT_LeadBypassValidationRules__mdt in map. This has market
                        specific usernames for which lead validations will be bypassed during creation. 
    * @changeHistory : 02.12.2019/Souvik Dinda/US#57151- Created the method
                     : 24.04.2020/Tejaswi Nissankula/KZ:Glo: US#116546 - Added BAT_BrandAndStatus__c,BAT_Source__c 
                       fields in query.
                       05.03.2021/Souvik Dinda/US#382068: Added BAT_Profile__c to getLeadValidationBypassConfig() SOQL query.
    *********************************************************************************************************/
    public static Map<String, BAT_LeadBypassValidationRules__mdt> getLeadValidationBypassConfig(){
        Map<String, BAT_LeadBypassValidationRules__mdt> leadBypassValidationConfig = new Map<String, BAT_LeadBypassValidationRules__mdt>();
        for(BAT_LeadBypassValidationRules__mdt leadBypassValidationRecord : [SELECT MasterLabel,BAT_Country__c,
                                                                BAT_Username__c,BAT_BrandAndStatus__c,BAT_Source__c,
                                                                BAT_Profile__c
                                                                FROM BAT_LeadBypassValidationRules__mdt]){
                              leadBypassValidationConfig.put(leadBypassValidationRecord.MasterLabel, leadBypassValidationRecord);
           
        }
        return leadBypassValidationConfig;
    }
    
     /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getCaseEmailActivityTrackConfig
    * @returns       : Map<String, BAT_LeadBypassValidationRules__mdt>
    * @params        : 
    * @description   : [All Market] Method to load BAT_CaseEmailActivityTrackingConfig__mdt in map. This has market
                        specific email activity type tracking along with field to be updated in case. 
    * @changeHistory : 03.12.2019/Souvik Dinda/US#56983- Created the method
    *********************************************************************************************************/
    public static Map<String, BAT_CaseEmailActivityTrackingConfig__mdt> getCaseEmailActivityTrackConfig(){
        Map<String, BAT_CaseEmailActivityTrackingConfig__mdt> caseEmailActivityMap = new Map<String, BAT_CaseEmailActivityTrackingConfig__mdt>();
        for(BAT_CaseEmailActivityTrackingConfig__mdt caseEmailActivityRecord : [SELECT MasterLabel, BAT_TargetField__c,BAT_TargetFieldValue__c,BAT_OldFieldValue__c
                                                                FROM BAT_CaseEmailActivityTrackingConfig__mdt]){
                              caseEmailActivityMap.put(caseEmailActivityRecord.MasterLabel, caseEmailActivityRecord);
           
        }
        return caseEmailActivityMap;
      }
   
/********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getAutomaticAnonymizationConfig
    * @returns       : Map<string,BAT_AutomaticAnonymizationConfiguration__mdt>
    * @params        : 
    * @description   : [All Market] Method to return BAT_AutomaticAnonymizationConfiguration__mdt List. 
    * @changeHistory : 04.12.2019/Rajesh Potla/US#47997- Created the method
                       5th April,2021/Roopa N/RO:US#461730 - Added field in metadata query
            16th April, 2021/Abhishek Kashyap/US-225171-Added fields to query to check if order, asset or case history deletion is requird or not
            //24 Jan 2023: ENH: #1278719: adding new field in the query BAT_NotRequiredInBatch__c
    *********************************************************************************************************/
    public static Map<string,BAT_AutomaticAnonymizationConfiguration__mdt> getAutomaticAnonymizationConfig(){
        Map<string,BAT_AutomaticAnonymizationConfiguration__mdt> automaticAnonymizationConfigMap= new Map<string,BAT_AutomaticAnonymizationConfiguration__mdt>();
        //Added BAT_IsUpdate__c field to the below query as part of US#461730
        for(BAT_AutomaticAnonymizationConfiguration__mdt autoAnonymizedCountry : BAT_AutomaticAnonymizationConfiguration__mdt.getAll().values() )
        {
            automaticAnonymizationConfigMap.put(autoAnonymizedCountry.MasterLabel,autoAnonymizedCountry);
        }        
        return automaticAnonymizationConfigMap;
      }
    
     /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : deletePersonAccHistory
    * @returns       : void
    * @params        : Set<Id>, Id
    * @description   : [All Market] Method to delete person account history when user having BAT_PersonAccountHistoryDeletionPermission
                        permission set. This will be triggered through anonymize account method.
    * @changeHistory : 06/12/2019 / Souvik Dinda/ US#47980 - Created the method
            16th April, 2021/Abhishek Kashyap/US-225171-Updated the method signature to include asset, order and case history for deletion
            30th June,2022/Rajeswari/US-1029822-Added logic for consenthistory deletion
    *********************************************************************************************************/
    @future
    public static void deletePersonAccHistory (Set<Id> accHistoryDeleteIdSet, Id userId, Set<Id> orderHistoryDeleteIdSet,Set<Id> consentsHistoryDeleteIdSet,Set<Id> assetHistoryDeleteIdSet, Set<Id> caseHistoryDeleteIdSet){
        List<PermissionSetAssignment> personAccDeletionPermList = new List<PermissionSetAssignment>();
        List<AccountHistory> accountHistoryList = new List<AccountHistory>();
        List<OrderHistory> orderHistoryList = new List<OrderHistory>();
        List<ContactPointTypeConsentHistory> consentHistoryList = new List<ContactPointTypeConsentHistory>();
        List<AssetHistory> assetHistoryList = new List<AssetHistory>();
        List<CaseHistory> caseHistoryList = new List<CaseHistory>();
        personAccDeletionPermList = [SELECT Id
                                     FROM PermissionSetAssignment
                                     WHERE PermissionSet.Name =: BAT_ConstantsUtility.PERSON_ACC_HISTORY_DELETE_PERMISSION
                                     AND AssigneeId =: userId];
        if(personAccDeletionPermList.size() > 0){
            if(!accHistoryDeleteIdSet.isEmpty()){
                accountHistoryList = [SELECT Id FROM AccountHistory WHERE AccountId IN: accHistoryDeleteIdSet];
            }
        //16th April, 2021/Abhishek Kashyap/US-225171-Quering the histories if respective ID Set is not empty
            if(!orderHistoryDeleteIdSet.isEmpty()){
                orderHistoryList = [SELECT Id FROM OrderHistory WHERE OrderId IN: orderHistoryDeleteIdSet];  
            }
        //30th June,2022/Rajeswari / US-1029822 - CH - Admin Portal - Anonymise Account
            if(!consentsHistoryDeleteIdSet.isEmpty()){
                consentHistoryList = [SELECT Id FROM ContactPointTypeConsentHistory WHERE ContactPointTypeConsentId IN: consentsHistoryDeleteIdSet];  
            }
            if(!assetHistoryDeleteIdSet.isEmpty()){
                assetHistoryList = [SELECT Id FROM AssetHistory WHERE AssetId IN: assetHistoryDeleteIdSet];  
            }
            if(!caseHistoryDeleteIdSet.isEmpty()){
                caseHistoryList = [SELECT Id FROM CaseHistory WHERE CaseId IN: caseHistoryDeleteIdSet];  
            }
        }
    //16th April, 2021/Abhishek Kashyap/US-225171-Deleting histories if available.
        if(!accountHistoryList.isEmpty()){ 
            Database.delete(accountHistoryList,false);
                }
        if(!orderHistoryList.isEmpty()){ 
            Database.delete(orderHistoryList,false);
                }
        if(!consentHistoryList.isEmpty()){ 
            Database.delete(consentHistoryList,false);
                }
        if(!assetHistoryList.isEmpty()){ 
            Database.delete(assetHistoryList,false);
                }
        if(!caseHistoryList.isEmpty()){ 
            Database.delete(caseHistoryList,false);
                }
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : deleteLeadHistory
    * @returns       : void
    * @params        : Id, String
    * @description   : [All Market] Method to delete lead history when user having BAT_PersonAccountHistoryDeletionPermission
                        permission set. This will be triggered through anonymizeLead method in BAT_AnonymizeLeadController.
    * @changeHistory : 10/06/2020 / Rama Akella/ US#281008 - Created the method
    *********************************************************************************************************/
    @future
    public static void deleteLeadHistory(Set<Id> leadHistoryDeleteIdSet, String userId){
        List<PermissionSetAssignment> personAccDeletionPermList = new List<PermissionSetAssignment>();
        personAccDeletionPermList = [SELECT Id
                                     FROM PermissionSetAssignment
                                     WHERE PermissionSet.Name =: BAT_ConstantsUtility.PERSON_ACC_HISTORY_DELETE_PERMISSION
                                     AND AssigneeId =: userId];
        if(personAccDeletionPermList.size() > 0){
            if(leadHistoryDeleteIdSet!=null && !leadHistoryDeleteIdSet.isEmpty() ){
                List<LeadHistory> leadHistoryList = [SELECT Id FROM LeadHistory
                                                        WHERE LeadId in :leadHistoryDeleteIdSet];  
                if(leadHistoryList != null && !leadHistoryList.isEmpty()){ 
                    Database.delete(leadHistoryList,true);
                }
            }
        }
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGloVypeCounterConfig
    * @returns       : Map<String,BAT_MgmGloVypeCounterConfig__mdt>
    * @params        : 
    * @description   : [All Market] Method to return BAT_AutomaticAnonymizationConfiguration__mdt List. 
    * @changeHistory : 04.12.2019/Rajesh Potla/US#47997- Created the method
                       05.11.2020/Souvik Dinda/US#296128 - Added new fields in the getGloVypeCounterConfig() method : BAT_GloMGMPromotionalCodeFieldName__c and BAT_VypeMGMPromotionalCodeFieldName__c.
    *********************************************************************************************************/
    public static Map<String,BAT_MgmGloVypeCounterConfig__mdt> getGloVypeCounterConfig(){
        Map<String,BAT_MgmGloVypeCounterConfig__mdt> gloVypeCounterConfigMap= new Map<String,BAT_MgmGloVypeCounterConfig__mdt>();
        for(BAT_MgmGloVypeCounterConfig__mdt metaDataRecord: BAT_MgmGloVypeCounterConfig__mdt.getAll().values())
        {
            gloVypeCounterConfigMap.put(metaDataRecord.MasterLabel,metaDataRecord);
        }        
        return gloVypeCounterConfigMap;
      }
          

    
     /********************************************************************************************************
* @author        : Deloitte
* @method Name   : globalSearhCriteriaConfigWrtCtry
* @returns       : List<BAT_GlobalSearchCriteriaConfiguration__mdt>
* @params        : userCountry
* @description   : [All Market] Method used to retrieve the metadata records which defines search criteria 
                    for each country
* @changeHistory : 17.05.2019 / Tejaswi Nissankula / created the method
                   7th Sep,2020/Abhishek Kashyap/ENH-US-266132-SE lyft >> own store portal update

*********************************************************************************************************/
     public static List<BAT_GlobalSearchCriteriaConfiguration__mdt> globalSearhCriteriaConfigWrtCtry(string userCountry){
        //retrieve the metadata records which defines search criteria for each country
        //7th Sep,2020/Abhishek Kashyap/ENH-US-266132-Added BAT_GetRelatedSurvey__c, BAT_GetRelatedOrder__c fields to the query.
        List<BAT_GlobalSearchCriteriaConfiguration__mdt> globalSearchCriteriaList = new List<BAT_GlobalSearchCriteriaConfiguration__mdt>();
       for(BAT_GlobalSearchCriteriaConfiguration__mdt rec: [Select BAT_FindInAllFields__c,BAT_FindInEmailFields__c,BAT_FindInNameFields__c,
                                                            BAT_FindInPhoneFields__c,BAT_FindInSidebarFields__c,BAT_Country__c,
                                                            BAT_MinDigitsOfMobileNumber__c,BAT_ObjectScope__c, BAT_MinNumberofDigitsWithCountryCode__c,
                                                            BAT_PreDefinedPhoneFormat__c, BAT_GetRelatedSurvey__c, BAT_GetRelatedOrder__c
                                    From  BAT_GlobalSearchCriteriaConfiguration__mdt Where BAT_Country__c =: userCountry]){
            globalSearchCriteriaList.add(rec);
        }
        return globalSearchCriteriaList;
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : getAccountToCaseMappingConfig
* @returns       : Map<string,List<BAT_AccountToCaseMappingConfiguration__mdt>>
* @params        : 
* @description   : [All Market] Method to return BAT_AccountToCaseMappingConfiguration__mdt map. 
* @changeHistory : 08.03.2020/Idrees Ali Jabalpurwala/US#93279- Created the method
*********************************************************************************************************/
    public static Map<String, List<BAT_AccountToCaseMappingConfiguration__mdt>> getAccountToCaseMappingConfig(){        
        Id recordTypeId;
        Map<String, List<BAT_AccountToCaseMappingConfiguration__mdt>> accToCaseConfigMap = new Map<String, List<BAT_AccountToCaseMappingConfiguration__mdt>>();
        for(BAT_AccountToCaseMappingConfiguration__mdt accTocaseMappingConfigRec : [Select MasterLabel,
                                                                      BAT_Market__c, BAT_RecordType__c,
                                                                      BAT_SourceField__c,BAT_TargetField__c
                                                                      from BAT_AccountToCaseMappingConfiguration__mdt])                                                                     
        {
            if(!accToCaseConfigMap.containsKey(accTocaseMappingConfigRec.BAT_Market__c)){
                accToCaseConfigMap.put(accTocaseMappingConfigRec.BAT_Market__c, new List<BAT_AccountToCaseMappingConfiguration__mdt>{});
            }
            accToCaseConfigMap.get(accTocaseMappingConfigRec.BAT_Market__c).add(accTocaseMappingConfigRec);
            if(!String.isBlank(accTocaseMappingConfigRec.BAT_RecordType__c)){
                recordTypeId = BAT_Utilities.getRecTypeIdByDevName(BAT_ConstantsUtility.CASE_STR,accTocaseMappingConfigRec.BAT_RecordType__c);
                recordTypeSet.add(recordTypeId);
            }     
        }        
        return accToCaseConfigMap;
    } 
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : caseFieldUpdateBasedOnMapping
* @returns       : void
* @params        : Case[] newCase,Map<String,list<BAT_AccountToCaseMappingConfiguration__mdt>> AccCaseDetailsMap,Boolean updateFlag
* @description   : [All Market] Method to stamp consumer details on case according to BAT_AccountToCaseMappingConfiguration__mdt
* @changeHistory : 08.03.2020/Idrees Ali Jabalpurwala/US#93279- Created the method
                    14.02.2021/Idrees Ali Jabalpurwala/US#756326- Optimised the method
*********************************************************************************************************/
    
    public static List<Case> caseFieldUpdateBasedOnMapping(Set<Id> contactIdSet,Case[] newCase,Map<String,list<BAT_AccountToCaseMappingConfiguration__mdt>> accToCaseConfigMap){
        System.debug('bjs_caseFieldUpdateBasedOnMapping() called..!');
        String searchQuery = BAT_ConstantsUtility.SELECT_STRING;
        List<Case> updatedCaseList = new List<Case>();
        Map<Id,Account> sourceAccountMap = new Map<Id,Account>();
        ID retailerRecordTypeId = getRetailerRecordTypeId();
        for(List<BAT_AccountToCaseMappingConfiguration__mdt> caseMapRec : accToCaseConfigMap.values()){
            for (BAT_AccountToCaseMappingConfiguration__mdt c : caseMapRec){
                if(!searchQuery.containsIgnoreCase(c.BAT_SourceField__c)){
                    searchQuery += c.BAT_SourceField__c + BAT_ConstantsUtility.ATH_COMMA; 
                }
            }
        }
        searchQuery += BAT_ConstantsUtility.ACCOUNT_WHERE_CLAUSE_ON_PERSONCONTACTID;
        for(Account accRec : (List<Account>)Database.query(searchQuery)){
            sourceAccountMap.put(accRec.PersonContactId,accRec);
        }
        for(Case caseRec : newCase){                  
            if(accToCaseConfigMap.containsKey(caseRec.Country__c)){
                for(BAT_AccountToCaseMappingConfiguration__mdt caseMapRec : accToCaseConfigMap.get(caseRec.Country__c)){                    
                    if((!String.isBlank(caseMapRec.BAT_RecordType__c) && recordTypeSet.contains(caseRec.RecordTypeId)) || String.isBlank(caseMapRec.BAT_RecordType__c) ){                        
                        if(sourceAccountMap.containsKey(caseRec.ContactId) && String.isBlank(String.valueOf(caseRec.get(caseMapRec.BAT_TargetField__c)))){
                            Account sourceAccRec = sourceAccountMap.get(caseRec.ContactId);
                            caseRec.put(caseMapRec.BAT_TargetField__c,sourceAccRec.get(caseMapRec.BAT_SourceField__c) );
                        }
                    }
                }
                updatedCaseList.add(caseRec);
            }  
        }
        System.debug('bjs_updatedCaseList.size = '+ updatedCaseList.size()+ ', and updatedCaseList = '+ updatedCaseList);
        return updatedCaseList;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : storeDetails
    * @returns       : Map<string,Store__c>
    * @params        : set<string>,string
    * @description   : [All Market] Method used to retrieve the store records based on store code received .
    * @changeHistory : 07.01.2020 / Tejaswi Nissankula / created the method
    * @changeHistory : 20.02.2020 / Idrees Ali Jabalpurwala / Added BAT_Inactive__c field in SOQL as per US#79008
    *                  Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Changed the signature of the method, to acceptset of country as parameter.
    *********************************************************************************************************/  
    public static Map<string,Store__c> storeDetails(set<string> storeCode,set<String> country){
        Map<String,Store__c> storeMap = new Map<String,Store__c>();
       for(Store__c rec: [select Id,Store_Name__c,Store_code__c,
                                 City__c,Region__c,Country__c,BAT_Inactive__c
                                 from Store__c 
                                 where 
                                 Store_Code__c IN : storeCode and 
                                 Country__c IN : country and BAT_Inactive__c = false]){
            storeMap.put(rec.Store_code__c,rec);
                                    
        }
        return storeMap;
    }
    
      
 /********************************************************************************************************
* @author        : Deloitte
* @method Name   : fetchGloFirstDeviceConfiguration
* @returns       : Map<String, BAT_GloFirstDeviceExcludeConfiguration__mdt>
* @params        : 
* @description   : [All]Method to load BAT_GloFirstDeviceExcludeConfiguration__mdt in map.
* @changeHistory : 09.03.2019/Rajesh Potla/US#83887- Created the method
*********************************************************************************************************/
    public static Map<String, BAT_GloFirstDeviceExcludeConfiguration__mdt> fetchGloFirstDeviceConfiguration(){
       Map<String, BAT_GloFirstDeviceExcludeConfiguration__mdt> gloFirstDeviceExcludeConfigMap = new Map<String, BAT_GloFirstDeviceExcludeConfiguration__mdt>();
        //Fetching all metadata records
        for(BAT_GloFirstDeviceExcludeConfiguration__mdt record : [Select MasterLabel
                                                                  from BAT_GloFirstDeviceExcludeConfiguration__mdt])
        {
            //Preparing a map of country with metadata record.
            gloFirstDeviceExcludeConfigMap.put(record.MasterLabel,record);
        }        
        return gloFirstDeviceExcludeConfigMap;
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : fetchOriginatedByConfiguration
* @returns       : Map<String, BAT_OrderOriginatedAutoPopulateConfig__mdt>
* @params        : Set of Country String.
* @description   : [All]Method to load BAT_OrderOriginatedAutoPopulateConfig__mdt in map.
* @changeHistory : 24.03.2020/Rajesh Potla/US#95229- Created the method
*********************************************************************************************************/
    
     public static Map<String, BAT_OrderOriginatedAutoPopulateConfig__mdt> fetchOriginatedByConfiguration(Set<String> countryNameSet){
        Map<String, BAT_OrderOriginatedAutoPopulateConfig__mdt> originatedByMap = new Map<String, BAT_OrderOriginatedAutoPopulateConfig__mdt>();
        //Fetch metadata records based on countryName set param.
        for(BAT_OrderOriginatedAutoPopulateConfig__mdt record : [Select MasterLabel,BAT_OwnerProfile__c,BAT_AccountBrandHouse__c,BAT_CurrentUserProfile__c,BAT_CriteriaEvaluationDays__c 
                                                         From BAT_OrderOriginatedAutoPopulateConfig__mdt Where MasterLabel IN: countryNameSet])
        {
            originatedByMap.put(record.MasterLabel,record);
        }        
        return originatedByMap;
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : getAccountsByEvaluationDaysCriteria
* @returns       : Map<String, string>
* @params        : Set of Accountids, map of BAT_OrderOriginatedAutoPopulateConfig__mdt metadta
* @description   : [All]Method to load Accountid along with Originated by id to set in map.
* @changeHistory : 24.03.2020/Rajesh Potla/US#95229- Created the method
*********************************************************************************************************/
    
   public static Map<String, String> getAccountsByEvaluationDaysCriteria(Set<String> accountIdSet,Map<String, BAT_OrderOriginatedAutoPopulateConfig__mdt> originatedByConfigMap){
   Map<String, string> accountIdWithOriginatedMap = new Map<String, string>();
   if(!accountIdSet.isEmpty()){
      // Fetching Opportunities having account in accountid set and owner is active.
      for(Opportunity opp: [Select id,ownerid,accountId,Account.Brand_House__c,country__c,closeDate,Owner_Profile_Name__c from Opportunity
                            where accountid IN :accountIdSet AND owner.isActive = true])
                           
      {
        // Checking Opportunity End Date has passed BAT_CriteriaEvaluationDays__c days 
        // Account brandhouse as per the mentioned value of BAT_AccountBrandHouse__c.
        //Opportunity owner equals to BAT_OwnerProfile__c   
        if(originatedByConfigMap.containskey(opp.country__c) && opp.closeDate!= null && originatedByConfigMap.get(opp.country__c).BAT_CriteriaEvaluationDays__c != null && 
            (opp.closeDate.daysBetween(System.Today()) < originatedByConfigMap.get(opp.country__c).BAT_CriteriaEvaluationDays__c) && 
            String.isNotBlank(originatedByConfigMap.get(opp.country__c).BAT_OwnerProfile__c) && opp.Owner_Profile_Name__c == originatedByConfigMap.get(opp.country__c).BAT_OwnerProfile__c &&
            String.isNotBlank(originatedByConfigMap.get(opp.country__c).BAT_AccountBrandHouse__c) && opp.Account.Brand_House__c.contains(originatedByConfigMap.get(opp.country__c).BAT_AccountBrandHouse__c) ){
          accountIdWithOriginatedMap.put(opp.accountid, opp.ownerid);
        }
          
      }
      
   }
     return accountIdWithOriginatedMap; 
  }
   /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getBlackListEnabledCountryDetails
    * @returns       : set<String>
    * @params        : 
    * @description   : [All]Method to load blacklist feature enabled countries in set.
    * @changeHistory : 27.04.2020/Tejaswi Nissankula/US#104691- Created the method
    *********************************************************************************************************/
        
     public static set<String> getBlackListEnabledCountryDetails(){
        Set<string> countrySet = new set<String>();
        for(BAT_EnableBlacklistConfiguration__mdt record : [Select MasterLabel
                                                         From BAT_EnableBlacklistConfiguration__mdt])
        {
            countrySet.add(record.MasterLabel);
        }        
        return countrySet;
    }
     /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : pointConditionName
    * @returns       : String
    * @params        : String modelName
    * @description   : [All]US#116614 - Dynamic code block to separate the action name based on models configured for country to have separate points system mentioned in BAT_RetailerPointTable__mdt.
            If Model field is blank, then the generic point system will follow as per the country
            In future based on Model, rest of the constants will remain as it and only the Model will replace.
    * @changeHistory : 28.04.2020/Souvik Dinda/Created the method.
                       05.10.2020/Saurabh Sharma/ Added cluster as parameter and modified if and else logic
                       to get condition name with or without cluster 
                       15.02.2021/ Akshata Rajmane/ US#390850 : GR - POS Agent - Reward Points calculation
                       12.07.2021/ Dipika Gupta/US 555967- If country is spain and brand is not blank, add brand in point condition
                        14.11.2022/ Idrees Ali /ENH:Sprint-118:SEA:US #1139217- SEA (IT) Admin - Flexible reward scheme management - Added logic for handling null pointer exception
                       incase no records matching condition name were found. Also, to compare with universal map and formulate condition name until suitable match is found
    *********************************************************************************************************/
    public static String getPointConditionName (String country, String modelName, String conditionName, String cluster, String brandName){
        String pointConditionName = BAT_ConstantsUtility.EMPTY_STRING;
        
        if(!modelNameSet.isEmpty() && modelNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + modelName) && (String.isNotBlank(cluster))){
            pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + modelName.deleteWhitespace() + conditionName
                +BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace();
            //Added logic to check if above condition name exists in universal map. If Not, construct condition name without model and compare until suitable match is found
            if(country == BAT_ConstantsUtility.COUNTRY_IT && !mapOfConditionToRecords.isEmpty() && !mapOfConditionToRecords.containsKey(pointConditionName)){
                pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName
                    +BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace();
                //Added logic to check if above condition name exists in universal map. If Not, construct condition name without model and cluster name
                if(!mapOfConditionToRecords.containsKey(pointConditionName)){
                    pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName;
                }
            }   
        }
        else if(!modelNameSet.isEmpty() && modelNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + modelName) && String.isBlank(cluster)){
            pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + modelName.deleteWhitespace() + conditionName;
             //Added logic to check if above condition name exists in universal map. If Not, construct condition name without model 
            if(country == BAT_ConstantsUtility.COUNTRY_IT && !mapOfConditionToRecords.isEmpty() && !mapOfConditionToRecords.containsKey(pointConditionName)){
                pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName;
            }
        }
        else if(!modelNameSet.isEmpty()  && !modelNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + modelName) && String.isNotBlank(cluster)){
            pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName
                                 +BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace();
        
        }
        else if((country.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR) || country.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CY)
                 || country.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ES)) && String.isNotBlank(brandName)){
            pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT  + BAT_ConstantsUtility.UNDERSCORE +brandName+conditionName;
        }
        else{
            pointConditionName = country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT +conditionName;   
        }
        return pointConditionName;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getEmailVerificationConfig
    * @returns       : Map<string,BAT_EmailValidationConfiguration__mdt>
    * @params        : 
    * @description   : [All Market] Method to return BAT_EmailValidationConfiguration__mdt List. 
    * @changeHistory : 28.01.2020/Souvik Dinda/US#71390- Created the method
                       13.10.2020/Allada Yeshwanth/ - added BAT_IsBypassDisabled__c,BAT_Bypass_Disabled_Profiles__c in the query
    *********************************************************************************************************/
    public static Map<String, BAT_EmailValidationConfiguration__mdt> getEmailValidationConfig(){
        Map<String, BAT_EmailValidationConfiguration__mdt> emailValidationConfigMap = new Map<String, BAT_EmailValidationConfiguration__mdt>();
        for(BAT_EmailValidationConfiguration__mdt emailValidationConfig : [Select MasterLabel,
                                                                           BAT_DuplicateEmailErrorMessage__c, BAT_WrongEmailFormatMessage__c,
                                                                           BAT_EmailEmptyErrorMessage__c, BAT_EmailChangedErrorMessage__c,
                                                                           BAT_IsOnlyEmailVerificationEnabled__c, BAT_ScopeOfRecordTypesOnAccount__c,
                                                                           BAT_IsBypassDisabled__c,BAT_BypassDisabledProfiles__c,BAT_IsVerifyDisabled__c
                                                                           from BAT_EmailValidationConfiguration__mdt])
        {
            emailValidationConfigMap.put(emailValidationConfig.MasterLabel,emailValidationConfig);
        }        
        return emailValidationConfigMap;
      }
      
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : setDefaultPrivacyDetailsConfig
    * @returns       : Map<string,String>
    * @params        : String, String, Lead, Account
    * @description   : [All Market] Method to get Privacy Details as per market for Legal Text against the 
                        consent fields.
    * @changeHistory : 15.06.2020/Souvik Dinda/US#138738- Created the method
                       17.09.2020 - Anna Gomez(Deloitte) Bug#283098 - Bulkify method
                       13.01.2021/Rama Akella / US#357618 - Added condition to update Map based on profile names  
    *********************************************************************************************************/  
    public static void setDefaultPrivacyDetailsConfig(String objectName, List<Lead> leadList, List<Account> accountList){
        Map<String, String> defaultPrivacyDetailsConfigMap = new Map<String, String>();
        Set<String> countriesSet = new Set<String>();
        String loggedInProfileName = getProfileName();
        if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
            for(Account accountRec : accountList){
                countriesSet.add(accountRec.Country__c);
            }
        } else if(objectName == BAT_ConstantsUtility.STANDARD_LEAD_STR) {
            for(Lead leadRec: leadList){
                countriesSet.add(leadRec.Country__c);
            }
        }
        
        if(!countriesSet.isEmpty()) {
            for(BAT_DefaultPrivacyDetailsConfiguration__mdt record : [SELECT MasterLabel,BAT_APIName__c,
                                                                      BAT_Country__c,BAT_DefaultValue__c,BAT_ProfileName__c 
                                                                      FROM BAT_DefaultPrivacyDetailsConfiguration__mdt 
                                                                      WHERE BAT_Country__c IN: countriesSet
                                                                      AND BAT_ObjectName__c =: objectName order by BAT_Sequence__c]) {
              //Added condition to update Map based on profile names 
              if(record.BAT_ProfileName__c == null) {              
                  defaultPrivacyDetailsConfigMap.put(record.BAT_APIName__c,record.BAT_DefaultValue__c);                                                          
              } else if(record.BAT_ProfileName__c != null && record.BAT_ProfileName__c ==loggedInProfileName ) {
                  defaultPrivacyDetailsConfigMap.put(record.BAT_APIName__c,record.BAT_DefaultValue__c);
              }
                 
            }
            
            if(!defaultPrivacyDetailsConfigMap.isEmpty()) {
                if(objectName == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                    for(Account accountRec : accountList){
                        for(String apiName : defaultPrivacyDetailsConfigMap.keySet()){
                            accountRec.put(apiName, defaultPrivacyDetailsConfigMap.get(apiName));
                        }
                    }
                } else if(objectName == BAT_ConstantsUtility.STANDARD_LEAD_STR) {
                    for(Lead leadRec: leadList){
                        for(String apiName : defaultPrivacyDetailsConfigMap.keySet()){
                            leadRec.put(apiName, defaultPrivacyDetailsConfigMap.get(apiName));
                        }
                    }
                }
            }
        }
    } 
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getleadBypassAssignmentRuleConfig
    * @returns       : Map<string,BAT_LeadBypassAssignmentRule__mdt>
    * @params        : 
    * @description   : [All Market] Method to return BAT_LeadBypassAssignmentRule__mdt Map. 
    * @changeHistory : 16.06.2020/Tejaswi Nissankula/US#139252- Created the method
    *********************************************************************************************************/
    public static Map<String, BAT_LeadBypassAssignmentRule__mdt> getleadBypassAssignmentRuleConfig(){
        Map<String, BAT_LeadBypassAssignmentRule__mdt> leadBypassAssignConfigMap = new Map<String, BAT_LeadBypassAssignmentRule__mdt>();
        for(BAT_LeadBypassAssignmentRule__mdt leadBypassAssignConfig : [Select MasterLabel from BAT_LeadBypassAssignmentRule__mdt])
        {
            leadBypassAssignConfigMap.put(leadBypassAssignConfig.MasterLabel,leadBypassAssignConfig);
        }        
        return leadBypassAssignConfigMap;
      }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getMarketsWithoutDeviceSustitution
    * @returns       : Set<String>
    * @params        : 
    * @description   : [All Market] Method to get countries of the markets without sustitution 
            consent fields.
    * @changeHistory : 10.08.2020/ Edwin Resendiz- Bug #226357- Created the method
    *********************************************************************************************************/ 
    public static Set<String> getMarketsWithoutDeviceSustitution() {
        Set<String> setDevicesSustitution = new Set<String>();
        for(BAT_MarketsWithoutDeviceSubstitution__mdt objMarket : [SELECT Id, Label, BAT_CountryValue__c FROM BAT_MarketsWithoutDeviceSubstitution__mdt]) {
            if(objMarket != null) {
                setDevicesSustitution.addAll(objMarket.BAT_CountryValue__c.split(','));
            }
        }    
        return setDevicesSustitution;
    }
    
     /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getCaseOriginConfiguration
    * @returns       : Map<string,BAT_CaseOriginConfiguration__mdt>
    * @params        : 
    * @description   : [ZA Market] Method to return BAT_CaseOriginConfiguration__mdt List. 
    * @changeHistory : 05.11.2020/Sandeep Joshi/US#318445- Created the method
    
    *********************************************************************************************************/
    public static Map<String,BAT_CaseOriginConfiguration__mdt> getCaseOriginConfiguration(){
        Map<String,BAT_CaseOriginConfiguration__mdt > caseOriginConfigMap = new Map<String,BAT_CaseOriginConfiguration__mdt >();
        for( BAT_CaseOriginConfiguration__mdt CaseOriginConfiguration : [Select MasterLabel,BAT_TargetFieldAPIName__c,BAT_TargetFieldValue__c                                                                           
                                                                           from BAT_CaseOriginConfiguration__mdt])
        {
            caseOriginConfigMap.put(CaseOriginConfiguration.MasterLabel,CaseOriginConfiguration);
        }        
        return caseOriginConfigMap;
      }
  /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGlobalRestrictedProfileMapping
    * @returns       : Map<String,BAT_RestrictedProfile__mdt> 
    * @params        : 
    * @description   : [Global] Method to return BAT_RestrictedProfile__mdt List. 
    * @changeHistory : 27.11.2020/Nida Abshar Khan/US#314624- Created the method
    **********************************************************************************************************/    
    public static Map<String,BAT_UserCategoryConfiguration__mdt> getGlobalRestrictedProfileMapping(){
        
        Map<String,BAT_UserCategoryConfiguration__mdt> globalRestrictedProfileMappingMap = new Map<String,BAT_UserCategoryConfiguration__mdt>();
        
        try{
            List<BAT_UserCategoryConfiguration__mdt> globalRestrictedPRofileMappingList =[Select developerName,masterLabel,BAT_Country__c, BAT_FieldValue__c,BAT_FieldAPI__c, BAT_RestrictedProfileName__c from BAT_UserCategoryConfiguration__mdt where BAT_Country__c = 'Default'];
            for(BAT_UserCategoryConfiguration__mdt configRecord : globalRestrictedPRofileMappingList){
                if(!globalRestrictedProfileMappingMap.containsKey(configRecord.masterLabel)){
                    globalRestrictedProfileMappingMap.put(configRecord.masterLabel,configRecord);
                }
            }
        }
        catch(Exception Ex) { 
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_UTILITIES_CLASS,BAT_ConstantsUtility.GETGLOBALRESTRICTEDPROFILEMAPPING);            
        }
        
        return globalRestrictedProfileMappingMap; 
  }
  
  /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getAccountWithUpdateMGMCounter
    * @returns       : Map<Id, Account>
    * @params        : 
    * @description   : [All Market] Method to increment the counter when the Member_get_Member_Promotional_Code__c is populated for the current account.
    * @changeHistory : 04.12.2020/Souvik Dinda/Created the method.
    *                    07.10.2022/Idrees Ali/ US #1124347 - GR- Vuse MGM Enabling Mechanism - Added New If block to allow mgm counter upgrade for vype promo code field usage too
                     : 03.06.2022/ Debasis Maharana /Bug#1016791 / Added extra validation for 'Member_get_Member_Promotional_Code__c' to avoide null pointer exception
    *********************************************************************************************************/ 
    public static Map<Id, Account> getAccountWithUpdateMGMCounter(List<Account> mgmAccountList){
        Map<String, List<Account>> mgmCodeToAccountMap = new Map<String, List<Account>>();
        Map<Id, Account> mgmAccountWithUpdatedCounterMap = new Map<Id, Account>();
        List<Account> updateList = new List<Account>();
        try{
            for(Account mgmAccount: mgmAccountList){
                if(String.isNotBlank(mgmAccount.Member_get_Member_Promotional_Code__c) && mgmAccount.Member_get_Member_Promotional_Code__c.substring(0,3) == BAT_ConstantsUtility.MEMBERSHIP_CODE_ACC){
                    if(!mgmCodeToAccountMap.containsKey(mgmAccount.Member_get_Member_Promotional_Code__c)){
                        mgmCodeToAccountMap.put(mgmAccount.Member_get_Member_Promotional_Code__c, new List<Account>());
                    }
                mgmCodeToAccountMap.get(mgmAccount.Member_get_Member_Promotional_Code__c).add(mgmAccount);
              }
                  if(String.isNotBlank(mgmAccount.BAT_MemberGetMemberVypePromotionalCode__c) && mgmAccount.BAT_MemberGetMemberVypePromotionalCode__c.substring(0,3) == BAT_ConstantsUtility.MEMBERSHIP_CODE_ACC){
                    if(!mgmCodeToAccountMap.containsKey(mgmAccount.BAT_MemberGetMemberVypePromotionalCode__c)){
                        mgmCodeToAccountMap.put(mgmAccount.BAT_MemberGetMemberVypePromotionalCode__c, new List<Account>());
                    }
                    mgmCodeToAccountMap.get(mgmAccount.BAT_MemberGetMemberVypePromotionalCode__c).add(mgmAccount);
                }
            }
            
            List<Account> accountList = new List<Account>();
            
            if(!mgmCodeToAccountMap.isEmpty()){
                accountList = [Select id,Country__c, Mgm_Counter__c, Member_get_Member_code__c From Account Where isPersonAccount = true 
                               AND Member_get_Member_code__c IN: mgmCodeToAccountMap.keySet()];
            }
            
            for(Account accountRec: accountList){
                accountRec.MgM_Counter__c++;
                //ENH/Magento Board/Bug:814078: Updated the MGM Counter of Parent Account before child Account for IT to avoid integration clashes.
                if(accountRec.Country__c == BAT_ConstantsUtility.COUNTRY_IT)
                {
                    updateList.add(accountRec);    
                }
                else{
                mgmAccountWithUpdatedCounterMap.put(accountRec.Id, accountRec);
            }
        }
        //ENH/Magento Board/Bug:814078: Updated the MGM Counter of Parent Account before child Account for IT to avoid integration clashes.
        if(!updateList.isEmpty())
        {
            Database.SaveResult[] updateResults = database.update(updateList,false); 
            BAT_Utilities.createErrorLogs(updateResults,BAT_ConstantsUtility.BAT_UTILITIES_CLASS, BAT_ConstantsUtility.GET_ACCOUNT_WITH_UPDATE_MGMCOUNTER);
        }
    }
        catch(Exception ex){
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_UTILITIES_CLASS, BAT_ConstantsUtility.GET_ACCOUNT_WITH_UPDATE_MGMCOUNTER); 
        }
        return mgmAccountWithUpdatedCounterMap;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getContactableConsentConfiguration
    * @returns       : Map<string,List<BAT_ContactableConsentConfiguration__mdt>>
    * @params        : 
    * @description   : [All Market] Method to return BAT_ContactableConsentConfiguration__mdt Map. 
    * @changeHistory : 14.12.2020/Akshata Rajmane/US#- Created the method
    *********************************************************************************************************/
    public static Map<String, List<BAT_ContactableConsentConfiguration__mdt>> getContactableConsentConfiguration(){
        Map<String,List<BAT_ContactableConsentConfiguration__mdt>> mapOfConsentConfig = new Map<String, List<BAT_ContactableConsentConfiguration__mdt>>();
        for(BAT_ContactableConsentConfiguration__mdt rec : [Select MasterLabel,BAT_ConsentFieldAPIName__c,BAT_DestinationValue__c,BAT_Country__c  
                                                            from BAT_ContactableConsentConfiguration__mdt])
        {
            if(!mapOfConsentConfig.ContainsKey(rec.BAT_Country__c))
            {
                mapOfConsentConfig.put(rec.BAT_Country__c,new List<BAT_ContactableConsentConfiguration__mdt>());
            }
            mapOfConsentConfig.get(rec.BAT_Country__c).add(rec);
        }        
        return mapOfConsentConfig;
      }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : updateConsumersContactableStatus
    * @returns       : List<Account> ,Map<Id,Account>
    * @params        : 
    * @description   : [All Market] Method is used to stamp the contactable consumers based on consent fields
    *                  mentioned in metadata. 
    * @changeHistory : 14.12.2020/Akshata Rajmane/US#276709- Created the method
    *********************************************************************************************************/
    public static void updateConsumersContactableStatus(List<Account> newRecs , Map<Id,Account> oldMap){
        Map<String,List<BAT_ContactableConsentConfiguration__mdt>> mapOfConsentConfig = new Map<String, List<BAT_ContactableConsentConfiguration__mdt>>();
        //get the consent configuration based on country
        mapOfConsentConfig = getContactableConsentConfiguration();
        for(Account acc : newRecs)
        {
            //boolean variable to store the contactable value
            Boolean isContactable = false;
            if(!mapOfConsentConfig.isEmpty() && mapOfConsentConfig.containsKey(acc.Country__c))
            {
                /* code will check if the any consent mentioned in metadata is true then it will set the contactalble 
                status as 'Contactable' otherwise it will be 'Non Contactable' and will also stamp
                BAT_CommunicationStatusUpdateDate__c as system.now() date */
                for(BAT_ContactableConsentConfiguration__mdt config : mapOfConsentConfig.get(acc.Country__c))
                {
                    isContactable = (isContactable || (config.BAT_DestinationValue__c == Boolean.valueOf(acc.get(config.BAT_ConsentFieldAPIName__c))));
                                      System.debug('isContactable'+isContactable );
                                       System.debug('config.BAT_DestinationValue__c'+config.BAT_DestinationValue__c);
                                       System.debug('Booleancheck'+Boolean.valueOf(acc.get(config.BAT_ConsentFieldAPIName__c)));
                }
                System.debug('isContactable'+isContactable );
                acc.BAT_CommunicationStatus__c = isContactable ? BAT_ConstantsUtility.CONTACTABLE_STR : BAT_ConstantsUtility.NONCONTACTABLE_STR;
                 System.debug('acc.BAT_CommunicationStatus__c'+acc.BAT_CommunicationStatus__c);
                if(oldMap == null ||(oldMap != null && !oldMap.isEmpty() && oldMap.containsKey(acc.id) &&
                                     acc.BAT_CommunicationStatus__c != oldMap.get(acc.id).BAT_CommunicationStatus__c))
                {
                    acc.BAT_CommunicationStatusUpdateDate__c = System.now();
                }
            }
        }
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getAssetAssociationConditions
    * @returns       : void
    * @params        : Set<String> country
    * @description   : [IT] Get metadata records for BAT_GlobalAutoAssetAssociationConfig__mdt
    * @changeHistory : 13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Created method
    *********************************************************************************************************/
    public static void getAssetAssociationConditions(Set<String> country){
        List<BAT_GlobalAutoAssetAssociationConfig__mdt> listAssociationConditions = new List<BAT_GlobalAutoAssetAssociationConfig__mdt>();
        AssetAssociationConditionsWrapper wrapObj = new AssetAssociationConditionsWrapper();
        for(BAT_GlobalAutoAssetAssociationConfig__mdt metaRec : [SELECT BAT_Country__c, BAT_FieldEntryCondition__c, BAT_FieldValue__c,BAT_NotNull__c,BAT_ProfileEntryCondition__c
                                                                 FROM BAT_GlobalAutoAssetAssociationConfig__mdt
                                                                 WHERE BAT_Country__c IN :country ]){
                                                                     if(metaRec.BAT_NotNull__c){
                                                                         if(!assetAssociateWrap.listNotNullFields.containsKey(metaRec.BAT_Country__c)){
                                                                             assetAssociateWrap.listNotNullFields.put(metaRec.BAT_Country__c, new List<string>());
                                                                         }
                                                                         assetAssociateWrap.listNotNullFields.get(metaRec.BAT_Country__c).add(metaRec.BAT_FieldEntryCondition__c);
                                                                     }
                                                                     
                                                                     if(String.isNotBlank(metaRec.BAT_ProfileEntryCondition__c)){
                                                                         assetAssociateWrap.listProfileEntryConditions = metaRec.BAT_ProfileEntryCondition__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON);
                                                                     }
                                                                     
                                                                     if(String.isNotBlank(metaRec.BAT_FieldValue__c)){
                                                                        if(!assetAssociateWrap.mapExpectedValueCondition.containsKey(metaRec.BAT_Country__c)){
                                                                            assetAssociateWrap.mapExpectedValueCondition.put(metaRec.BAT_Country__c,new Map<String,String>());
                                                                        }
                                                                         if(!assetAssociateWrap.mapExpectedValueCondition.get(metaRec.BAT_Country__c).containsKey(metaRec.BAT_FieldEntryCondition__c)){
                                                                                assetAssociateWrap.mapExpectedValueCondition.get(metaRec.BAT_Country__c).put(metaRec.BAT_FieldEntryCondition__c,metaRec.BAT_FieldValue__c);
                                                                         }
                                                                     }
                                                                 }
        
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name   : AssetAssociationConditionsWrapper
    * @description   : [IT] Class to get the mandatory check list for auto association of Account to Asset
    * @changeHistory : 13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Created the class
    *********************************************************************************************************/
    public class AssetAssociationConditionsWrapper{
        public Map<String,List<String>> listNotNullFields = new Map<String,List<String>>();
        public Map<String,Map<String,String>> mapExpectedValueCondition = new Map<String,Map<String,String>>();
        public List<String> listProfileEntryConditions = new List<String>();
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : associateAssetWithAccount
    * @returns       : void
    * @params        : List<Account> newAccountList, Map<Id,Account> oldMap
    * @description   : [IT] Auto Associate Asset to Account on conditions 
    * @changeHistory : 13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Created method
    *********************************************************************************************************/
   public static void associateAssetWithAccount(List<Account> newAccountList, Map<Id,Account> oldMap){
        //Set to add account countries
        system.debug('testnewAccountList'+newAccountList);
        Set<String> setCountries = new Set<String>();
        //List to validate not null fields
        List<Boolean> listIsNotNull = new List<Boolean>();
        //List to validate expected value in the field
        List<Boolean> listIsExpectedValue = new List<Boolean>();
        //Set to add account Id's
        Set<Id> accountIdSet = new Set<Id>();
        //Creating country set - start
        for(Account accRec : newAccountList){
            setCountries.add(accRec.Country__c);
        }//Loop - End
        //method to get mandatory conditions to validate
        getAssetAssociationConditions(setCountries);    
        //Map of country to list of not null validation check fields
        Map<String,List<String>> mapCountryToNotNullFields = assetAssociateWrap.listNotNullFields;
        //Map of country to expected value map fields
        Map<String,Map<String,String>> mapCountryToExpectedValueCondition = assetAssociateWrap.mapExpectedValueCondition;
        //List of Profile Entry conditions
        List<String> listProfileEntryConditions = assetAssociateWrap.listProfileEntryConditions;
        //supporting lists to cater country vise checks - start
        List<String> listNotNullFields;
        Map<String,String> mapExpectedValueCondition;
        //supporting lists to cater country vise checks - End
        try{
            system.debug('testnewAccountList2'+newAccountList);
            for(Account accRec : newAccountList){
                if(accRec.Registration_Permission__c <> oldMap.get(accRec.Id).Registration_Permission__c && 
                   listProfileEntryConditions.contains(getProfileName())){
                       //not null field list of current country
                       if(mapCountryToNotNullFields <> null && !mapCountryToNotNullFields.isEmpty() && mapCountryToNotNullFields.containsKey(accRec.Country__c)){
                           listNotNullFields = mapCountryToNotNullFields.get(accRec.Country__c);
                       }
                       
                       //expected value map of current country
                       if(mapCountryToExpectedValueCondition <> null && !mapCountryToExpectedValueCondition.isEmpty() && mapCountryToExpectedValueCondition.containsKey(accRec.Country__c)){
                           mapExpectedValueCondition = mapCountryToExpectedValueCondition.get(accRec.Country__c);
                       }
                       //Validation if field is not null - Start
                       if(listNotNullFields <> null && !listNotNullFields.isEmpty()){
                           for(String field : listNotNullFields){
                               if(accRec.get(field) <> null){
                                   listIsNotNull.add(true);
                               }else{
                                   listIsNotNull.add(false);
                               }
                           }
                       }// if - End
                       
                       //Validating if field has the expected value - start
                       if(mapExpectedValueCondition <> null && !mapExpectedValueCondition.isEmpty()){
                           for(String field : mapExpectedValueCondition.keySet()){
                               if(mapExpectedValueCondition.get(field).equalsIgnoreCase(BAT_ConstantsUtility.TRUE_STRING) || mapExpectedValueCondition.get(field).equalsIgnoreCase(BAT_ConstantsUtility.FALSE_STRING)){
                                   if(accRec.get(field) == Boolean.valueOf(mapExpectedValueCondition.get(field))){
                                       listIsExpectedValue.add(true);
                                   }else{
                                       listIsExpectedValue.add(false);
                                   }
                               }else{
                                   if(accRec.get(field) == mapExpectedValueCondition.get(field)){
                                       listIsExpectedValue.add(true);
                                   }else{
                                       
                                       listIsExpectedValue.add(false);
                                   }
                               }
                           }
                       }//If - End
                       
                       //collecting accounts that match the mandatory checks - start
                       if(!listIsNotNull.isEmpty() && !listIsExpectedValue.isEmpty() && !listIsNotNull.contains(false) && !listIsExpectedValue.contains(false)){
                       
                           accountIdSet.add(accRec.Id);
                     
                    }//If - End
                   }//If - End
            }//Loop - End
            
            //Updating asset with its respective accounts
            updateAccountOnAsset(accountIdSet,mapCountryToExpectedValueCondition.keySet());
        }catch(Exception ex){
            createLog(ex,BAT_ConstantsUtility.BAT_UTILITIES_CLASS,BAT_ConstantsUtility.IT_ASSOCIATEASSET_METHOD);
        }
    }
    
     /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : updateAccountOnAsset
    * @returns       : void
    * @params        : Set<Id> accountIdSet
    * @description   : [IT] Auto Associate Asset to Account on conditions 
    * @changeHistory : 13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Created method
                     : 09.05.2023/ Debasis Maharana / BUG#1370423 / Update was not happening because asset id was not assigned before asset update.
    *********************************************************************************************************/
    public static void updateAccountOnAsset(Set<Id> accountIdSet, Set<String> countrySet){
        List<Asset> assetToUpdate =null;
        if(accountIdSet <> null && !accountIdSet.isEmpty()){
            List<Asset> listRelatedAssetPerCondition = [SELECT Id,BAT_RelatedAccount__c, AccountId FROM Asset WHERE Country__c IN :countrySet AND BAT_RelatedAccount__c IN :accountIdSet];
            if(listRelatedAssetPerCondition <> null && !listRelatedAssetPerCondition.isEmpty()){
                for(Asset assetRec : listRelatedAssetPerCondition){
                    if(accountIdSet.contains(assetRec.BAT_RelatedAccount__c)){
                        assetToUpdate = new List<Asset>();
                        Asset asset= new Asset();
                        asset.id=assetRec.id;
                        asset.AccountId = assetRec.BAT_RelatedAccount__c;
                        assetToUpdate.add(asset);
                    }
                }
                Database.update(assetToUpdate);
            }
        }
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getCountriesBasedOnRegion
    * @returns       : List<BAT_CountryRegionConfiguration__mdt>
    * @params        : String regionName
    * @description   : [All Market] Method is used to fetch countries based on users region
    * @changeHistory : 21.01.2021/Allada yeshwanth/Created the method
    *********************************************************************************************************/
    
    public static List<BAT_CountryRegionConfiguration__mdt> getCountriesBasedOnRegion(String regionName){
        List<BAT_CountryRegionConfiguration__mdt> countryList = new List<BAT_CountryRegionConfiguration__mdt>();
        if(String.isNotBlank(regionName)){
            countryList = [Select Id,DeveloperName from BAT_CountryRegionConfiguration__mdt where BAT_Region__c = :regionName];
        }
        return countryList;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name    : GlobalFieldUpdateWrapper
    * @description   : [GLOBAL] Class to get field and conditions for field updates
    * @changeHistory : 21.01.2021/Osheen Sahajpal/ENH:Sprint-71:SRB:US #217575:created the class.
    *********************************************************************************************************/
    public class GlobalFieldUpdateWrapper{
        public Map<String,Map<String,BAT_GlobalUpdateFieldMapping__mdt>> mapCountryToFieldMapping = new Map<String,Map<String,BAT_GlobalUpdateFieldMapping__mdt>>();
        public String stringFieldsToQuery;
        public Map<String,String> mapCountryToCriteria = new Map<String,String>();
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGlobalFieldMappingConfig
    * @returns       : Boolean
    * @params        : Set<String> setCountries, String objectName, string purpose
    * @description   : [GLOBAL] Method to get field update configurations
    * @changeHistory : 21.01.2021/Osheen Sahajpal/ENH:Sprint-71:SRB:US #217575:created the method.
                     : 13.12.2021/ Allada Yeshwanth /ENH:Sprint-94:ZA #823193 / passed new purpose parameter to fetch global field update metadata
    *********************************************************************************************************/
    public static Boolean getGlobalFieldMappingConfig(Set<String> setCountries, String objectName, String purpose){
        //list of field mapping metadata record
        List<BAT_GlobalUpdateFieldMapping__mdt> listFieldMappingConfig;
        //list of fields
        List<String> listFieldString = new List<String>();
        
        //Querying field configs when set of countries are provided
        if(setCountries <> null && !setCountries.isEmpty()){
            listFieldMappingConfig = [SELECT BAT_Country__c, BAT_CustomCriteria__c, BAT_isCriteriaRecord__c,
                                             BAT_FieldAPIName__c, BAT_Value__c, BAT_IsBoolean__c,BAT_ObjectName__c 
                                      FROM BAT_GlobalUpdateFieldMapping__mdt 
                                      WHERE BAT_Country__c IN :setCountries AND BAT_ObjectName__c = :objectName AND BAT_Purpose__c = :purpose ];
        }else{
            //Querying field configs when set of countries are not provided
            listFieldMappingConfig = [SELECT BAT_Country__c, BAT_CustomCriteria__c, BAT_isCriteriaRecord__c,
                                             BAT_FieldAPIName__c, BAT_Value__c, BAT_IsBoolean__c 
                                      FROM BAT_GlobalUpdateFieldMapping__mdt 
                                      WHERE BAT_ObjectName__c = :objectName AND BAT_Purpose__c = :purpose LIMIT :limits.getLimitQueryRows()];
        }
        
        if(listFieldMappingConfig <> null && !listFieldMappingConfig.isEmpty()){
            for(BAT_GlobalUpdateFieldMapping__mdt metaRec : listFieldMappingConfig){
                //Getting custom criteria for where clause
                if(metaRec.BAT_isCriteriaRecord__c && String.isNotBlank(metaRec.BAT_CustomCriteria__c) && !globalFieldUpdateWrap.mapCountryToCriteria.containsKey(metaRec.BAT_Country__c)){
                   globalFieldUpdateWrap.mapCountryToCriteria.put(metaRec.BAT_Country__c,metaRec.BAT_CustomCriteria__c);
                }
                //Getting Country wise field API's
                if(String.isNotBlank(metaRec.BAT_FieldAPIName__c)){
                    listFieldString.add(metaRec.BAT_FieldAPIName__c);
                    if(!globalFieldUpdateWrap.mapCountryToFieldMapping.containsKey(metaRec.BAT_Country__c)){
                        globalFieldUpdateWrap.mapCountryToFieldMapping.put(metaRec.BAT_Country__c,new Map<String,BAT_GlobalUpdateFieldMapping__mdt>());
                    }
                    globalFieldUpdateWrap.mapCountryToFieldMapping.get(metaRec.BAT_Country__c).put(metaRec.BAT_FieldAPIName__c,metaRec);
                }
                
            }
            //Getting field string for object query
            globalFieldUpdateWrap.stringFieldsToQuery = String.join(listFieldString,',');
        }
        //returning true if filed mapping is available
        if(globalFieldUpdateWrap.mapCountryToFieldMapping <> null && !globalFieldUpdateWrap.mapCountryToFieldMapping.isEmpty()){
               return true;
        }else{
               return false;
        }
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getLiveChatTranscriptAnonyConfig
    * @returns       : Map<String,BAT_LiveChatTranscriptAnonymizeConfig__mdt>
    * @params        : 
    * @description   : [All Market] Method to return BAT_LiveChatTranscriptAnonymizationConfi__mdt List. 
    * @changeHistory : 28.10.2020/Saurabh Sharma/US#287284- Created the method
    *********************************************************************************************************/
    public static Map<String,BAT_LiveChatTranscriptAnonymizeConfig__mdt> getLiveChatTranscriptAnonyConfig(){
        
        Map<String,BAT_LiveChatTranscriptAnonymizeConfig__mdt> mapLiveChatTranscriptAnonymize = new Map<String,BAT_LiveChatTranscriptAnonymizeConfig__mdt>();
        try{
            
           List<BAT_LiveChatTranscriptAnonymizeConfig__mdt> liveChatTranscriptAnoList= [select BAT_ChatButtonName__c, BAT_Criteria__c, BAT_MonthsToAnonymize__c, BAT_Country__c, 
                                                                                         masterLabel from BAT_LiveChatTranscriptAnonymizeConfig__mdt LIMIT :Limits.getLimitQueryRows()];  
            
            for(BAT_LiveChatTranscriptAnonymizeConfig__mdt configRecord : liveChatTranscriptAnoList){
                if(!mapLiveChatTranscriptAnonymize.containsKey(configRecord.masterLabel)){
                    mapLiveChatTranscriptAnonymize.put(configRecord.masterLabel,configRecord);
                }
            }
            
        }
            catch(Exception Ex) { 
                BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_UTILITIES_CLASS,BAT_ConstantsUtility.GETLIVECHATTRANSCRIPTANONYMIZECONFIG);
        }
        
        return mapLiveChatTranscriptAnonymize;
        
    }
        
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGlobalFieldAnonymizeMapping
    * @returns       : Map<String,BAT_GlobalFieldAnonymizationMapping__mdt>
    * @params        : (String objectName)
    * @description   : [All Market] Method to return BAT_GlobalFieldAnonymizationMapping__mdt List. 
    * @changeHistory : 28.10.2020/Saurabh Sharma/US#287284- Created the method
    **********************************************************************************************************/
    public static Map<String,List<BAT_GlobalFieldAnonymizationMapping__mdt>> getGlobalFieldAnonymizeMapping(String objectName){
        
        Map<String,List<BAT_GlobalFieldAnonymizationMapping__mdt>> globalFieldAnonymizeMappingMap = new Map<String,List<BAT_GlobalFieldAnonymizationMapping__mdt>>();
        
        try{
            List<BAT_GlobalFieldAnonymizationMapping__mdt> globalFieldAnonymizeMappingList = [Select BAT_FieldAPIName__c, BAT_Value__c, BAT_ObjectName__c, BAT_Country__c,BAT_IsBoolean__c, 
                                                                                             masterLabel from BAT_GlobalFieldAnonymizationMapping__mdt where BAT_ObjectName__c=: objectName 
                                                                                             LIMIT :Limits.getLimitQueryRows()];  
            
            for(BAT_GlobalFieldAnonymizationMapping__mdt configRecord : globalFieldAnonymizeMappingList){
                if(!globalFieldAnonymizeMappingMap.containsKey(configRecord.BAT_Country__c)){
                    globalFieldAnonymizeMappingMap.put(configRecord.BAT_Country__c,new List<BAT_GlobalFieldAnonymizationMapping__mdt>());
                }
                globalFieldAnonymizeMappingMap.get(configRecord.BAT_Country__c).add(configRecord);
            }
        
        }
        catch(Exception Ex) { 
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_UTILITIES_CLASS,BAT_ConstantsUtility.GETGLOBALANONYMIZEMAPPING);            
        }
        
        return globalFieldAnonymizeMappingMap; 
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getRecordLockUnlockConfig
    * @returns       : Map<string,BAT_RecordLockUnlockConfiguration__mdt>
    * @params        : 
    * @description   : [RO]: Sprint1:US#405873 - Method to load BAT_RecordLockUnlockConfiguration__mdt in map. 
    * @changeHistory : 18th Feb,2021/Roopa N/Created the Method
    *********************************************************************************************************/
    public static Map<string,List<BAT_RecordLockUnlockConfiguration__mdt>> getRecordLockUnlockConfig(){
        Map<string,List<BAT_RecordLockUnlockConfiguration__mdt>> recordLockUnlockConfigMap= new Map<string,List<BAT_RecordLockUnlockConfiguration__mdt>>();
        for(BAT_RecordLockUnlockConfiguration__mdt accountCountry : [Select MasterLabel, BAT_LockValue__c, BAT_UnlockValue__c, BAT_ObjectName__c, 
                                                                      BAT_FieldAPIName__c, BAT_LockLabel__c, BAT_UnlockLabel__c, BAT_LockConfirmationLabel__c,
                                                                      BAT_UnlockConfirmationLabel__c from BAT_RecordLockUnlockConfiguration__mdt])
        {
            if(recordLockUnlockConfigMap.containsKey(accountCountry.MasterLabel)){
                recordLockUnlockConfigMap.get(accountCountry.MasterLabel).add(accountCountry);
            }
            else{
                recordLockUnlockConfigMap.put(accountCountry.MasterLabel, new List<BAT_RecordLockUnlockConfiguration__mdt>{accountCountry});
            }
            
        }        
        return recordLockUnlockConfigMap;
      }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getCaseRelatedTasks
    * @returns       : Map<ID,boolean>
    * @params        : Set<Id>,Set<String>
    * @description   : [RO] Method is used to return true if tasks exists with same subject against a case
    * @changeHistory : 12th Mar,2021/Roopa N/Sprint2 : US#428478: Created the method
    *********************************************************************************************************/    
    public static Map<ID,boolean> getCaseRelatedTasks(Set<Id> setCaseIds,set<String> setSubjects){
        set<ID> caseRelatedTasks = new set<ID>();
        List<Task> listCaseRelatedTasks;
        if(Schema.sObjectType.Task.fields.WhatId.isAccessible()){
            listCaseRelatedTasks = [SELECT Id,WhatId FROM Task WHERE WhatId IN :setCaseIds and Subject IN :setSubjects];
        }
        if(listCaseRelatedTasks != null){
            for(Task t : listCaseRelatedTasks){
                caseRelatedTasks.add(t.WhatId);
            }
        }
        Map<Id,boolean> fetchcaseIds = new Map<Id,boolean>();
        for(Id t : setCaseIds){
            boolean flag= caseRelatedTasks.contains(t) ? true : false;
            fetchcaseIds.put(t,flag);
        }
        return fetchcaseIds;
    }
/********************************************************************************************************
    @author        : Deloitte
    @method Name   : callReverseAPIBatchContext
    @returns : void
    @params :  jsonrequeststring . jsonconfigstring
    @description : [Global] this method does the api call
    @changeHistory: 2nd April, 2020/Abhishek Kashyap/BUG-468283-Created the method without @future to fire reverse Integration in Batch context
            26th May, 2021/Abhishek Kashyap/BUG:538533-RO-Automatic full anonymization scenario fail
    *********************************************************************************************************/
    
    public static void callReverseAPIBatchContext(String requestJsonMapping,String apiConfigJson,String objectName,String country,String headerJson){
        try{
            system.debug('==requestJsonMapping=='+requestJsonMapping);
            system.debug('==apiConfigJson=='+apiConfigJson);
            system.debug('==objectName=='+objectName);
            system.debug('==country=='+country);
            system.debug('==headerJson=='+headerJson);
            ///to store success codes available
            List<String> successResponseCodes = new List<String>(); 
            HttpResponse responseObj;
            //header map to store header mappings
            Map<String,Object> headerMap = (Map<String,Object>) Json.deserializeUntyped(headerJson);
            //generating new http request 
            BAT_ApigeeAuthProviderConfig__mdt apiConfig = (BAT_ApigeeAuthProviderConfig__mdt) Json.deserialize(apiConfigJson ,BAT_ApigeeAuthProviderConfig__mdt.class);            
            system.debug('==apiConfig=='+apiConfig);
            //if to get the success codes in list
            if(!String.isBlank(apiConfig.BAT_SuccessResponseCode__c)){
                successResponseCodes = apiConfig.BAT_SuccessResponseCode__c.split(BAT_ConstantsUtility.BAT_SEMICOLON_STR);
                }system.debug('==successResponseCodes=='+successResponseCodes);
            //generate the http instance
            if(!String.isBlank(apiConfig.BAT_RequestEndpoint__c))
            {
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                //set the endpoint
                request.setEndpoint(apiConfig.BAT_RequestEndpoint__c);
                //set the request method 
                request.setMethod(apiConfig.BAT_RequestMethod__c);
                request.setHeader(BAT_ConstantsUtility.CONTENT_TYPE, BAT_ConstantsUtility.APPLICATION_TYPE);
                //set the headers
                for(String headerKey : headerMap.keySet())
                {
                    request.setHeader(headerKey, String.valueOf(headerMap.get(headerKey)));
                }
                //set request json in body 
                request.setBody(requestJsonMapping);system.debug('==request=='+request);
                responseObj = http.send(request);  
            }           
            BAT_Integration_Log_DE__c integrationLog = new BAT_Integration_Log_DE__c();
            integrationLog.Object_Type__c = objectName;
            integrationLog.Request_Details__c = requestJsonMapping;
            integrationLog.BAT_Country__c = country;
            integrationLog.Response_Details__c =String.isBlank(apiConfig.BAT_RequestEndpoint__c)? 'External Ids are blank' : BAT_ConstantsUtility.AUTH_CODE_PARAM+BAT_ConstantsUtility.SINGLE_SPACE
            +BAT_ConstantsUtility.STR_CHAR_HYPHEN+responseObj.getStatusCode()+BAT_ConstantsUtility.BAT_SEMICOLON_STR+responseObj.getBody();
            integrationLog.Status__c = responseObj != null && successResponseCodes.contains(String.valueOf(responseObj.getStatusCode()))?
            BAT_ConstantsUtility.COMPLETED : BAT_ConstantsUtility.SMS_FAILED;
            if(Schema.sObjectType.BAT_Integration_Log_DE__c.Fields.Object_Type__c.isCreateable()){
        //26th May, 2021/Abhishek Kashyap/BUG:538533-RO-Added log objects to the list to insert integration logs post callouts, to avoid uncommited work callout error
                BAT_ReverseAPICallHandler.batchContextIntegrationLogList.add(integrationLog);
            }
        }
        catch(Exception ex){
        //28th May, 2021/Abhishek Kashyap/BUG:538533-RO-Added log objects to the list to insert integration logs post callouts, to avoid uncommited work callout error
        Apex_Log__c apexLog = new Apex_Log__c();
        apexLog.Class_Name__c = BAT_ConstantsUtility.REVERSE_API_CLASS_NAME; 
        apexLog.Exception__c =ex.getStackTraceString()+'\n'+ex.getMessage()+'\n'+ex.getCause();
        apexLog.Method_Name__c = BAT_ConstantsUtility.REVERSE_API_METHOD_NAME;
        BAT_ReverseAPICallHandler.batchContextApexLogList.add(apexLog);
    }
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : updateEmailAndPhone
    * @returns       : void
    * @params        : List<Account>,Map<Id,Account>,Set<String>
    * @description   : To stamp Mobile and Email fields that were previously stamped by metadata (BAT_UK_Account_WF_PopulateCustomerAccountEmailRule, BAT_Account_WF_AccountMobilePhoneAlignment)
    * @changeHistory : 08.04.2021/ Allada Yeshwanth/ Created Method
                       27.04.2021 / Allada Yeshwanth / bug: #506606 / modified the condition to stamp blank values also into custom fields
    *********************************************************************************************************/
    public static void updateEmailAndPhone(List<Account> TriggerNew, Map<Id,Account> TriggerOldMap, set<String> countrySet){
        set<String> phoneAlignCountrySet = new Set<String>();
        set<String> emailAlignCountrySet = new Set<String>();
        if(!countrySet.isEmpty()){
            for(BAT_AccountMobileEmailAlignmentConfig__mdt rec : [Select MasterLabel,BAT_IsAlignEmail__c,BAT_IsAlignMobile__c from BAT_AccountMobileEmailAlignmentConfig__mdt where MasterLabel in :countrySet]){
                if(rec.BAT_IsAlignMobile__c){
                    phoneAlignCountrySet.add(rec.MasterLabel);
                }
                if(rec.BAT_IsAlignEmail__c){
                    emailAlignCountrySet.add(rec.MasterLabel);
                }
            }
        }
        
        for(Account acc : TriggerNew){
            
            if(!phoneAlignCountrySet.isEmpty()){
                acc.PersonMobilePhone__c = (phoneAlignCountrySet.contains(acc.country__c)) ? 
                                        ((TriggerOldMap == null || String.isBlank(acc.PersonMobilePhone) || acc.PersonMobilePhone != TriggerOldMap.get(acc.Id).PersonMobilePhone) ? 
                                        acc.PersonMobilephone : acc.PersonMobilePhone__c) : 
                                        acc.PersonMobilePhone__c ;
            }
            
            if(!emailAlignCountrySet.isEmpty()){
                acc.Email__c = (emailAlignCountrySet.contains(acc.country__c)) ? 
                            ((TriggerOldMap == null || String.isBlank(acc.PersonEmail) || acc.PersonEmail != TriggerOldMap.get(acc.Id).PersonEmail) ? 
                            acc.PersonEmail : acc.Email__c): 
                            acc.Email__c ;
            }
            //ENH || US: # 537698 || Allada Yeshwanth || ISSUE 1 GDPR || MAIL Subject -   Sprint 82 - PL UAT Details (UAT Timelines 06/7 - 12/07)
            if(acc.Country__c == BAT_ConstantsUtility.COUNTRY_PL && TriggerOldMap == null && String.isBlank(acc.PersonMobilePhone)){
                acc.PersonOtherPhone = BAT_ConstantsUtility.BLANK_STR;
            }
            
        }
        
    }
    
   /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getPicklistLabels
    * @returns       : Map<String,String>
    * @params        : sObject objectApi, string fieldApi
    * @description   : To create a map of picklist label and value
    * @changeHistory : 19.04.2021/ Idrees Ali/ Created Method
    *********************************************************************************************************/
    public static Map<String,String> getPicklistLabels(sObject objectApi, string fieldApi) {
        
        Map<String,String> allOptions = new Map<String,String> ();
        Schema.sObjectType objType = objectApi.getSObjectType();
        Schema.DescribeSObjectResult objDescribe;
        Map <String, Schema.SObjectField> fieldMap = new Map <String, Schema.SObjectField>();
        // Describe the SObject using its object type.
        if(objType!= null){
            objDescribe = objType.getDescribe();
        }
        // Get a map of fields for the SObject
        if(objDescribe != null){
            fieldMap = objDescribe.fields.getMap();
        }
        List <Schema.PicklistEntry> values = fieldMap.get(fieldApi).getDescribe().getPickListValues();
        if(values!= null && !values.isEmpty()){
            for (Schema.PicklistEntry a: values) {
                allOptions.put(a.getLabel(),a.getValue());
            }
        }
        return allOptions;
    }
    /********************************************************************************************************
    @ author:        Deloitte  
    @ method:        callReverseAPI 
    @ returns:       void
    @ params:        String, String, String
    @description:    This method calls callReverseApi method and passes the records for those countries having record in BAT_EnableCountryForReverseAPI__mdt
    @changeHistory:  20th April,2021/Abhishek Kashyap/US-225171-Created the method
    *********************************************************************************************************/
    public static void callReverseAPI(String eventString, String objectName, String countryApiName){
        //set of country to check reverse API is enable for country
        Set<String> countryEnabledSet = new Set<String>();
        //List to save the list of eligible record 
        List<sObject> listOfEligibleRecords = new List<sObject>();
        // Sameer Ranjan || US #1154667 for version 2 reverse integration 
        List<sObject> listOfEligibleRecordsV2 = new List<sObject>();
        //get the enabled country from metadata
        countryEnabledSet = BAT_ReverseAPIUtility.checkCountryEnabled();
        //US#530277 : Stop Outbound call for Retailer record Type
        ID retailerRecordTypeId = getRetailerRecordTypeId();
        BAT_Utilities.getUserDetailsGlobal();//1947819
        for(sObject eachRecord : Trigger.New){
            if(!objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) || (objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) && eachRecord.get('RecordTypeId') != retailerRecordTypeId)){
            String country = (String)eachRecord.get(countryApiName);
            //this if will check the criteria and mapping records are present for that country or not also this country is enabled for reverse API or not
                if(!countryEnabledSet.isEmpty() && countryEnabledSet.contains(country))
                {
                    listOfEligibleRecords.add(eachRecord);
                }
                // Sameer Ranjan || US #1154667 for version 2 reverse integration 
                if(!countryEnabledSet.isEmpty() && countryEnabledSet.contains(country + BAT_ConstantsUtility.COUNTRY_SUFFIX)){
                    listOfEligibleRecordsV2.add(eachRecord);
                }
            }
        }
        //If the list is not empty, reverse integration is executed and CallReverseAPI is called
        if(!listOfEligibleRecords.isEmpty()){
            //integer variable created to remove the non multibrand markets
            Integer i =0;
            //map to store brand name as key and account as value
            Map<string,Sobject> brandAccountMap = new  Map<string,Sobject>();
            //Cloning the existing variable as we can not use the same variable for remove method
            List<sobject> listOfEligibleRecordsClone = new  List<sobject>();
            listOfEligibleRecordsClone.addAll(listOfEligibleRecords);
            //Get the spilt brand country names from metadata
            Set<String> splitBrandCountries = new Set<String>();
            if(eventString.equalsIgnoreCase(BAT_ConstantsUtility.EVENT_DELETE)){
                // Sameer Ranjan -> US #1154667 - Added filter criteria to make sure not retrieve version 2 records 
                for(BAT_ReverseAPIJsonMapping__mdt rec : [select BAT_Country__c from BAT_ReverseAPIJsonMapping__mdt where BAT_EventType__c =: eventString AND BAT_ObjectName__c =:objectName AND BAT_IsSplitBrandHouse__c=true AND BAT_EnableCountryForReverseAPI__c = null]){
                    splitBrandCountries.add(rec.BAT_Country__c);
                }
            }
            for(Sobject obj: listOfEligibleRecordsClone){
                String country = (String)obj.get(countryApiName);
                if(splitBrandCountries.contains(country) && eventString.equalsIgnoreCase(BAT_ConstantsUtility.EVENT_DELETE)&& (objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) && obj.get('RecordTypeId') != retailerRecordTypeId)){
                     String accountBrandsString = (String)obj.get(BAT_ConstantsUtility.FIELD_LEGACYBRANDHOUSE);
                    if(accountBrandsString.contains(BAT_ConstantsUtility.SEMI_COLON)){
                        // multibrand accounts will be removed
                        listOfEligibleRecords.remove(i);
                        String objId = (String)obj.get(BAT_ConstantsUtility.BAT_ID);
                        for(String accBrand: accountBrandsString.split(BAT_ConstantsUtility.SEMI_COLON)){
                            //objId is also added as key if there are multiple records for same country
                            brandAccountMap.put(accBrand+BAT_ConstantsUtility.UNDERSCORE+objId,obj);
                        }
                    }
                }
                i++;
            }
            
            for(String brand: brandAccountMap.keySet()){
                list<Sobject> eligibleRecordList = new List<Sobject>();
                Sobject tempAccount = brandAccountMap.get(brand);
                tempAccount.put(BAT_ConstantsUtility.FIELD_LEGACYBRANDHOUSE,brand.split(BAT_ConstantsUtility.UNDERSCORE)[0]);
                eligibleRecordList.add(tempAccount);
                
                //setting below variable to false for allowing multiple calls on same records
                BAT_ReverseAPIUtility.skipAPICallRun = false;
                BAT_ReverseAPICallHandler apiHandlerInstance = new BAT_ReverseAPICallHandler();
                apiHandlerInstance.CallReverseAPI(eventString, objectName, countryApiName,eligibleRecordList, null);
            }
            system.debug('listOfEligibleRecords--'+listOfEligibleRecords);
            //other markets without multibrand split logic 
            if(!listOfEligibleRecords.isEmpty()){
                BAT_ReverseAPICallHandler apiHandler = new BAT_ReverseAPICallHandler();
                apiHandler.CallReverseAPI(eventString, objectName, countryApiName, listOfEligibleRecords, null);
            }
        }
        // Sameer Ranjan || US #1154667 for version 2 reverse integration 
        if(!listOfEligibleRecordsV2.isEmpty()){
            BAT_ReverseAPICallHandlerV2.MethodParameters apiHandlerMethodParameters = new BAT_ReverseAPICallHandlerV2.MethodParameters(); 
            apiHandlerMethodParameters.eventType = eventString;
            apiHandlerMethodParameters.objectName = objectName;
            apiHandlerMethodParameters.countryAPI = countryApiName;
            apiHandlerMethodParameters.listOfEligibleRecords = listOfEligibleRecordsV2;
            apiHandlerMethodParameters.oldMap = Trigger.oldMap;
            BAT_ReverseAPICallHandlerV2 apiHandler = new BAT_ReverseAPICallHandlerV2(); 
            apiHandler.CallReverseAPI(apiHandlerMethodParameters);
        }
    }
    
    /********************************************************************************************************
    @ author:        Deloitte  
    @ method:        getUserDetailsGlobal 
    @ returns:       void
    @ params:          
    @description:    This method sets the global User object with the details of the loggedin user if not already set
    @changeHistory:  20th April,2021/Abhishek Kashyap/US-225171-Created the method
    *********************************************************************************************************/
    public static void getUserDetailsGlobal(){
        if(loggedInUserObject == null || loggedInUserObject.Id != UserInfo.getUserId()){
            loggedInUserObject =[select Id,Name,Country__c,ProfileId,Profile.Name, Profile_Name__c, Store_ID_User__c,city,Bypass_Validation_Rule__c,Username,BAT_Brand__c,LanguageLocaleKey, User_type__c, BAT_BypassTrialCreation__c, BAT_AccountSource__c, UserRole.Name from User where Id=:UserInfo.getUserId()];
        }
    }
    
    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getPersonContactId 
    *@ returns:        Map<Id, Account>
    *@ params:         String recordId
    *@description:     Global method to get person contact details for CampaignMember contactId.
    *@changeHistory:   01/06/2021/ Souvik Dinda/ US#525787 - Created the method.
    ************************************************************************************************************************************/
    public static Map<Id, Account> getPersonContactDetails (String recordId){
        Map<Id,Account> accountRec = new Map<Id,Account>();
        for(Account accRec: [Select Id,PersonContactId from Account where Id = :recordId]){
            accountRec.put(accRec.Id, accRec);
        }
        return accountRec;
    }
    
     /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getOwnStorePortalFilterCriteriaConfig 
    *@ returns:        Map<String, List<BAT_OwnStorePortalFilterCriteria__mdt>>
    *@ params:         
    *@description:     To fetch BAT_OwnStorePortalFilterCriteria__mdt configurations for different operations based on action names.
    *@changeHistory:   01/06/2021/ Souvik Dinda/ US#525787 - Created the method.
    ************************************************************************************************************************************/
    public static Map<String, List<BAT_OwnStorePortalFilterCriteria__mdt>> getOwnStorePortalFilterCriteriaConfig (){
        Map<String, List<BAT_OwnStorePortalFilterCriteria__mdt>> ownStorePortalFilterCriteriaMap = new Map<String, List<BAT_OwnStorePortalFilterCriteria__mdt>>();
        User userDetails = getUserDetails();
        List<BAT_OwnStorePortalFilterCriteria__mdt> filterCriteriaList = [Select DeveloperName,BAT_AccountRecordTypeAPI__c, 
                                                                          BAT_RecordTypeAPI__c, BAT_DisplayType__c,BAT_FieldAPIName__c,
                                                                          BAT_FilterName__c,BAT_ObjectAPIName__c,BAT_Sequence__c,
                                                                          BAT_QuickActionName__c, MasterLabel
                                                                          from BAT_OwnStorePortalFilterCriteria__mdt 
                                                                          Where MasterLabel =:userDetails.Country__c
                                                                          Order by BAT_Sequence__c asc
                                                                          LIMIT : Limits.getLimitQueries()];
        
        for(BAT_OwnStorePortalFilterCriteria__mdt ownMdt :  filterCriteriaList){
            if(!ownStorePortalFilterCriteriaMap.containsKey(ownMdt.BAT_QuickActionName__c)){
                ownStorePortalFilterCriteriaMap.put(ownMdt.BAT_QuickActionName__c, new List<BAT_OwnStorePortalFilterCriteria__mdt>());
            }
            ownStorePortalFilterCriteriaMap.get(ownMdt.BAT_QuickActionName__c).add(ownMdt);
        }
        return ownStorePortalFilterCriteriaMap;
    }
    
    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         getOwnStorePortalFilterCriteriaConfig 
    *@ returns:        Map<String, List<BAT_OwnStorePortalFormConfiguration__mdt>>
    *@ params:         
    *@description:     To fetch BAT_OwnStorePortalFormConfiguration__mdt configurations for different operations based on action names.
    *@changeHistory:   01/06/2021/ Souvik Dinda/ US#525787 - Created the method.
    ************************************************************************************************************************************/
    public static List<BAT_OwnStorePortalFormConfiguration__mdt> getOwnStorePortalFormConfig (String country, String objectName){
        List<BAT_OwnStorePortalFormConfiguration__mdt> ownStorePortalFormConfigList = new List<BAT_OwnStorePortalFormConfiguration__mdt>();
        ownStorePortalFormConfigList = [Select DeveloperName,BAT_DefaultValue__c, BAT_FieldLabel__c,BAT_FieldAPI__c,
                                                                          BAT_PrepopulateDefaultValue__c,BAT_RecordTypeAPI__c,BAT_SectionName__c,
                                                                          Sequence__c
                                                                          from BAT_OwnStorePortalFormConfiguration__mdt 
                                                                          Where Country__c =:country
                                                                             AND BAT_Object__c =:objectName
                                                                          Order by Sequence__c asc
                                                                          LIMIT : Limits.getLimitQueries()];
        
        
        return ownStorePortalFormConfigList;
    }
    
    /********************************************************************************************************
    @ author:        Deloitte  
    @ method:        getProfileNameMap
    @ returns:       void
    @ params:          
    @description:    This method sets the profileNameMap with the details of Profile details if not already set
    @changeHistory:  18.06.2021/Anna Gomez/Bug#563880/UserTriggerHandler optimization to avoid SOQL101
    *********************************************************************************************************/
    public static void getProfileNameMap(){
        if(profileNameMap ==  null || profileNameMap.isEmpty()){
            profileNameMap =  new Map<Id,Profile>([SELECT ID,Name FROM Profile LIMIT 1000]);
        }
    }
    
    /*********************************************************************************
    *@Author        : Deloitte
    *@method        : createTaskList
    *@returns       : List<Task>
    *@params        : BAT_CaseTaskCreationConfiguration__mdt caseTaskCreateConfig,Case caseRec, List<Task> taskToBeInserted
    *@description   : Method to get List of Task to be inserted based on the BAT_CaseTaskCreationConfiguration__mdt values to be set on Task.
    *@changeHistory : 18.06.2021/Souvik Dinda/ US#487564 - Created the method.
    *******************************************************************************/      

    public static List<Task> createTaskList(BAT_CaseTaskCreationConfiguration__mdt caseTaskCreateConfig,Case caseRec, List<Task> taskToBeInserted){
        
        if(caseRec != null && caseTaskCreateConfig != null){
            Task newTask = new Task();  
            newTask.Subject = caseTaskCreateConfig.BAT_TaskSubject__c;
            newTask.OwnerId = caseRec.OwnerId;
            newTask.WhatId = caseRec.Id;
            newTask.BAT_Country__c = caseTaskCreateConfig.BAT_Country__c;
            newTask.Priority = caseTaskCreateConfig.BAT_TaskPriority__c;
            newTask.Status = caseTaskCreateConfig.BAT_TaskStatus__c;
            if(caseTaskCreateConfig.BAT_TaskOffsetCriteriaFieldName__c != null && caseTaskCreateConfig.BAT_TaskOffsetDays__c != null){
                newTask.ActivityDate = Date.valueOf(caseRec.get(caseTaskCreateConfig.BAT_TaskOffsetCriteriaFieldName__c)) + Integer.valueOf(caseTaskCreateConfig.BAT_TaskOffsetDays__c);
            }
            taskToBeInserted.add(newTask);
        }
        return taskToBeInserted;
    }
    
     /*********************************************************************************
    *@Author        : Deloitte
    *@method        : createIntegrationLog
    *@returns       : BAT_Integration_Log_DE__c
    *@params        : objectname, requestMap, requestApiConfig, country, responseObj
    *@description   : Create an Integration Log object using the params and return the refernce
    *@changeHistory : 01.07.2021/Allada Yeshwanth/ US#525503 - Created the method.
    *******************************************************************************/      
    
    public static BAT_Integration_Log_DE__c createIntegrationLog(String objectname, String requestMap, BAT_ApigeeAuthProviderConfig__mdt requestApiConfig,String country,HttpResponse responseObj){
        
        
        List<String> successResponseCodes = new List<String>(); 
        if(!String.isBlank(requestApiConfig.BAT_SuccessResponseCode__c)){
            successResponseCodes = requestApiConfig.BAT_SuccessResponseCode__c.split(BAT_ConstantsUtility.BAT_SEMICOLON_STR);
        }
        
        
        BAT_Integration_Log_DE__c integrationLog = new BAT_Integration_Log_DE__c();
        integrationLog.Object_Type__c = objectname;
        integrationLog.Request_Details__c = requestMap;
        integrationLog.BAT_Country__c = country;
        integrationLog.Response_Details__c =String.isNotBlank(requestApiConfig.BAT_RequestEndpoint__c) && responseObj != null ?
            BAT_ConstantsUtility.AUTH_CODE_PARAM+BAT_ConstantsUtility.SINGLE_SPACE+BAT_ConstantsUtility.STR_CHAR_HYPHEN+responseObj.getStatusCode()
            +BAT_ConstantsUtility.BAT_SEMICOLON_STR+responseObj.getBody():BAT_ConstantsUtility.EXTERNALID_ERROR;
        integrationLog.Status__c = responseObj != null && successResponseCodes.contains(String.valueOf(responseObj.getStatusCode()))?
            BAT_ConstantsUtility.COMPLETED : BAT_ConstantsUtility.SMS_FAILED;
        return integrationLog;
    }
  /********************************************************************************************************
  * @author        : Deloitte
  * @Class Name    : AssetHyperCareConfigWrapper
  * @description   : [All Markets] wrapper class for Asset Hypercare task configuration
  * @changeHistory : 02.07.2021/Roopa/ENH: Sprint-82: US #364007: Created the method
  *********************************************************************************************************/
    public class AssetHyperCareConfigWrapper{
        //Map to store country verses the BAT_AssetHyperCareConfiguration__mdt
        public Map<String, List<BAT_AssetHyperCareConfiguration__mdt>> mapCountryToHyperCareConfig = new Map<String, List<BAT_AssetHyperCareConfiguration__mdt>>();
        //Map to store queue configurations
        public Set<String> setAssignedQueueNames = new Set<String>();
  }
    
  /********************************************************************************************************
  * @author        : Deloitte
  * @method Name   : getAssetHyperCareConfigs
  * @returns       : AssetHyperCareConfigWrapper
  * @params        : Set<String> countrySet
  * @description   : [All Markets] method to get BAT_AssetHyperCareConfiguration__mdt records
  * @changeHistory : 02.07.2021/Roopa/ENH: Sprint-82: US #364007: Created the method
  *********************************************************************************************************/
    public static AssetHyperCareConfigWrapper getAssetHyperCareConfigs(Set<String> countrySet){
        //Wrapper object for Hypercare task configuration
        AssetHyperCareConfigWrapper assetConfigWrapperObj = new AssetHyperCareConfigWrapper();
        List<BAT_AssetHyperCareConfiguration__mdt> listHyperCareConfigs = [SELECT BAT_Country__c,BAT_TaskOffsetDays__c,BAT_TaskSubject__c,
                                                                  BAT_AssignToQueue__c,BAT_AssigneeGroupName__c
                                                                  FROM BAT_AssetHyperCareConfiguration__mdt where BAT_Country__c IN: countrySet
                                                                  ORDER BY BAT_TaskOffsetDays__c];
                                                                 
        if(listHyperCareConfigs <> null && !listHyperCareConfigs.isEmpty()){
            //Setting up Hypercare task configuration - Start
            for(BAT_AssetHyperCareConfiguration__mdt hyperCareconfig : listHyperCareConfigs){
                if(assetConfigWrapperObj.mapCountryToHyperCareConfig <> null && !assetConfigWrapperObj.mapCountryToHyperCareConfig.containskey(hyperCareconfig.BAT_Country__c)){
                    assetConfigWrapperObj.mapCountryToHyperCareConfig.put(hyperCareconfig.BAT_Country__c, new List<BAT_AssetHyperCareConfiguration__mdt>());
                }
                if(assetConfigWrapperObj.mapCountryToHyperCareConfig.containskey(hyperCareconfig.BAT_Country__c)){
                    assetConfigWrapperObj.mapCountryToHyperCareConfig.get(hyperCareconfig.BAT_Country__c).add(hyperCareconfig);
                }
                if(String.isNotBlank(hyperCareconfig.BAT_AssigneeGroupName__c)){
                    assetConfigWrapperObj.setAssignedQueueNames.add(hyperCareconfig.BAT_AssigneeGroupName__c);
                }
            }//Loop - End
        }
        
        return assetConfigWrapperObj;
    }
    
     /********************************************************************************************************
  * @author        : Deloitte
  * @method Name   : getQueueConfigs
  * @returns       : Map<String,QueueSObject>
  * @params        : Set<String> setQueueNames
  * @description   : [All Markets] method to get queue configs
  * @changeHistory : 02.07.2021/Roopa/ENH: Sprint-82: US #364007: Created the method
  *********************************************************************************************************/
    public static Map<String,QueueSObject> getQueueConfigs(Set<String> setQueueNames){
        //Map of Queue Name verses the Queue config
        Map<String,QueueSObject> mapQueueNametoQueue = new Map<String,QueueSObject>();
        List<QueueSObject> listQueues = [Select id,QueueId,queue.Name from QueueSobject where SobjectType =: BAT_ConstantsUtility.TASK_STR and queue.Name In :setQueueNames];
        if(listQueues <> null && !listQueues.isEmpty()){
            //Setting up queue config - Start
            for(QueueSObject queueRecord : listQueues){
                mapQueueNametoQueue.put(queueRecord.queue.Name,queueRecord);
            }//Loop - End
        }
        
        return mapQueueNametoQueue;
    }  
    
 /************************************************************************************************************************************
    *@author        :Deloitte  
    *@method        :getQueueConfigs
    *@returns       :Map<Id,Group>
    *@description   :This method is used to create map of queue Id's VS queue Record
    *@changeHistory :12.12.2022/Idrees Ali /Created the method
    ************************************************************************************************************************************/
    public static Map<Id,Group> getQueueConfigs(){
        Map<Id,Group> mapOfAllQueues = new Map<Id,Group>();
        List<Group> listAllGroups = [SELECT Id, Name, Type, DeveloperName FROM Group WHERE Type = :BAT_ConstantsUtility.QUEUE_STR];
        for(Group g : listAllGroups){
            mapOfAllQueues.put(g.Id,g);
        }
        return mapOfAllQueues;
    }
    
    /********************************************************************************************************
  * @author        : Deloitte
  * @Class Name    : emailToCaseConfigWrapper
  * @description   : [All Markets] wrapper class for BAT_EmailToCaseConfiguration__mdt
  * @changeHistory : 13.12.2022/Idrees Ali/ ENH- Sprint 120 - US#1080293: Created the method
  *********************************************************************************************************/
    public class emailToCaseConfigWrapper{
        //Map to store country verses the BAT_EmailToCaseConfiguration__mdt
        public Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapQueueToCaseFields = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        //Map to store queue configurations
        public Map<String,List<BAT_EmailToCaseConfiguration__mdt>> mapOfSkillBasedConfigDetails = new Map<String,List<BAT_EmailToCaseConfiguration__mdt>>();
        //List to store all staging queues
        public List<String> stagingQueuesList = new List<String>();
  }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getExternalCustomerIdMapping
    * @returns       : List<BAT_ExternalCustomerIdMapping__mdt>
    * @params        : Set<Countires>
    * @description   : [All Market] Method to retrive BAT_ExternalCustomerIdMapping__mdt metadata records
    * @changeHistory : 18.08.2021/ Allada Yeshwanth / US: #540266 || Created the method
    *********************************************************************************************************/
    public static List<BAT_ExternalCustomerIdMapping__mdt> getExternalCustomerIdMapping(set<String> countryList){
        if(!countryList.isEmpty()){
            return [Select Id,BAT_Country__c , BAT_BrandHouse__c ,BAT_ExternalIdField__c from BAT_ExternalCustomerIdMapping__mdt where BAT_Country__c in :countryList];
        }
        else{
            return [Select Id,BAT_Country__c , BAT_BrandHouse__c ,BAT_ExternalIdField__c from BAT_ExternalCustomerIdMapping__mdt];
        }
    }
   
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : updateConsentToFalsePostLeadConversion
    * @returns       : void
    * @params        : List<Lead> convertedLeadList,Map<String, List<BAT_ContactableConsentConfiguration__mdt>> mapOfConsentConfig
    * @description   : [All Market] Method to mark the consents as false for converted Leads 
    * @changeHistory : 13.07.2021/Idrees Ali/US#- Created the method
    *********************************************************************************************************/
    public static void updateConsentToFalsePostLeadConversion(List<Lead> convertedLeadList,Map<String, List<BAT_ContactableConsentConfiguration__mdt>> mapOfConsentConfig){
        for(Lead leadRec : convertedLeadList){
            if(!mapOfConsentConfig.isEmpty() && mapOfConsentConfig.containsKey(BAT_ConstantsUtility.BAT_GLOBAL_STR)){
                for(BAT_ContactableConsentConfiguration__mdt consentRec : mapOfConsentConfig.get(BAT_ConstantsUtility.BAT_GLOBAL_STR)){
                    leadRec.put(consentRec.BAT_ConsentFieldAPIName__c,consentRec.BAT_DestinationValue__c);
                }
            }
        }
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createRewardProfilePointsForLeads
    * @returns       : 
    * @params        : List<Lead>, Set<Country>
    * @description   : ENH: Sprint 88 : US: #708711 Method to insert points for QR code leads conversion
    * @changeHistory : 24.09.2021 / Allada Yeshwanth / created method
                       21.10.2021/Rama Akella/Bug#773419/Optimized code by passing List<Lead> as parameter instead of Map<rewardProfileId,List<Lead>>
    *********************************************************************************************************/
    public static void createRewardProfilePointsForLeads(List<Lead> convertedLeads, List<lead> sameOwnerLeadList, Set<String> countrySet){  //Bug IT#1036900 - Added argument List<lead> sameOwnerLeadList to the method
        List<BAT_Point__c> pointToInsertList = new List<BAT_Point__c>();
        Map<String,BAT_LeadConversionPointsConfig__mdt> rewardPointConfigMtd = new Map<String,BAT_LeadConversionPointsConfig__mdt>();
        rewardPointConfigMtd = getLeadRewardPointConfigMtd(countrySet);
        if(!rewardPointConfigMtd.isEmpty()){ 
            if(!convertedLeads.isEmpty()){              
            for(Lead leadRec : convertedLeads){
                    BAT_Point__c pointRecord = new BAT_Point__c();
                    pointRecord.Reward_Profile__c = leadRec.Reward_Profile__c;
                    pointRecord.Reason__c = BAT_ConstantsUtility.BAT_IT_LEAD + BAT_ConstantsUtility.STR_COLON + 
                        BAT_ConstantsUtility.SINGLE_SPACE + leadRec.Name + BAT_ConstantsUtility.SEMI_COLON + 
                        BAT_ConstantsUtility.SINGLE_SPACE + BAT_ConstantsUtility.DATE_STR + BAT_ConstantsUtility.STR_COLON + 
                        BAT_ConstantsUtility.SINGLE_SPACE + System.now().format(BAT_ConstantsUtility.DATEMONTHYEARFORMAT); 
                    pointRecord.Value__c = rewardPointConfigMtd.get(leadRec.Country__c).BAT_Point__c;
                    pointToInsertList.add(pointRecord);               
            }
        } 
        //Bug IT#1036900 - Added logic for assigning 0 points 
            if(!sameOwnerLeadList.isEmpty()){
            for(Lead leadRec : sameOwnerLeadList){
                    BAT_Point__c pointRecord = new BAT_Point__c(); 
                    pointRecord.Reward_Profile__c = leadRec.Reward_Profile__c;
                    pointRecord.Reason__c = BAT_ConstantsUtility.BAT_IT_LEAD + BAT_ConstantsUtility.STR_COLON + 
                        BAT_ConstantsUtility.SINGLE_SPACE + leadRec.Name + BAT_ConstantsUtility.SEMI_COLON + 
                        BAT_ConstantsUtility.SINGLE_SPACE + BAT_ConstantsUtility.DATE_STR + BAT_ConstantsUtility.STR_COLON + 
                        BAT_ConstantsUtility.SINGLE_SPACE + System.now().format(BAT_ConstantsUtility.DATEMONTHYEARFORMAT); 
                    pointRecord.Value__c = BAT_ConstantsUtility.DOUBLE_ZERO;
                    pointToInsertList.add(pointRecord);               
                }
            }
        }     
        if(!pointToInsertList.isEmpty()){                      
            try{
                insert pointToInsertList;
            }catch(Exception ex){
                Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = BAT_ConstantsUtility.BAT_UTILITIES_CLASS, Exception__c = ex.getMessage(),
                                                      Method_Name__c = BAT_ConstantsUtility.CREATEREWARDPROFILEPOINTSFORLEADSMETHOD);
                insert apexLog;
            }
        }
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getLeadRewardPointConfigMtd
    * @returns       : Map<Country,BAT_LeadConversionPointsConfig__mdt>
    * @params        : Set<Country>
    * @description   : ENH: Sprint 88 : US: #708711 Method to fetch lead conversion points metadata records
    * @changeHistory : 24.09.2021 / Allada Yeshwanth / created method
    *********************************************************************************************************/    
    public static Map<String,BAT_LeadConversionPointsConfig__mdt> getLeadRewardPointConfigMtd(Set<String> countrySet){
        Map<String,BAT_LeadConversionPointsConfig__mdt> returnMap = new Map<String,BAT_LeadConversionPointsConfig__mdt>();
            for(BAT_LeadConversionPointsConfig__mdt rec : [Select BAT_Country__c,BAT_Point__c from BAT_LeadConversionPointsConfig__mdt where BAT_Country__c in :countrySet]){
                returnMap.put(rec.BAT_Country__c,rec);
            }
        return returnMap;
        
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getNewLeadRecordTypeId
    * @returns       : Id
    * @params        : None
    * @description   : ENH: Sprint 88 : US: #708711 Method to fetch "New" lead Record Type Id
    * @changeHistory : 24.09.2021 / Allada Yeshwanth / created method
    *********************************************************************************************************/
    public static Id getNewLeadRecordTypeId(){
        if(NewLeadRecordTypeId == null){
            NewLeadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.LEAD_RECORDTYPE_NEW).getRecordTypeId();
        }
        return NewLeadRecordTypeId;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGlobalMappingConfig
    * @returns       : Map<String,mdt>
    * @params        : None
    * @description   : fetch new custom metadata mapping records
    * @changeHistory : 29.10.2021 / Akshata Rajmane / created method
    *********************************************************************************************************/
    public static Map<String, BAT_GlobalMappingConfiguration__mdt> getGlobalMappingConfig(){
       Map<String, BAT_GlobalMappingConfiguration__mdt> mappingMeta = new Map<String,BAT_GlobalMappingConfiguration__mdt>();
       for(BAT_GlobalMappingConfiguration__mdt mdt : [select id ,developerName, BAT_ExpectedValueInField__c,BAT_ObjectName__c,
                                                     BAT_SourceFieldAPIName__c from BAT_GlobalMappingConfiguration__mdt])
       {
          mappingMeta.put(mdt.DeveloperName , mdt); 
       }
       return mappingMeta;
    }
/********************************************************************************************************
* @author        : Deloitte
* @method Name   : createPortalUsersAndRewardProfiles
* @returns       : void
* @params        : String
* @description   : ENH: Sprint 91 : [CZ] : US: #731385 Method to create Portal Users and RewardProfile
* @changeHistory : 29th Oct,2021/Roopa N/ Created the method.
12.01.2022/Rama Akella / US#731385/ CZ: Added the missed code
13.01.2022/Allada yeshwanth/US #778833 / updated the code to make it metadata driven.
*********************************************************************************************************/
     @future
    public static void createPortalUsersAndRewardProfiles(Set<Id> contactIdSet){
        Map<String,BAT_AutomaticUserCreationFromContact__mdt> countryAutomaticUserCreationMtdMap = BAT_Utilities.getAutomaticUserCreationMtd();
        if(!countryAutomaticUserCreationMtdMap.isEmpty() && !contactIdSet.isEmpty()){
            
            List<Contact> contactList = [Select Id,FirstName,LastName,Email,Account.Country__c,Account.Name,CreatedById,AccountId from Contact 
                                         where Id IN :contactIdSet];
            Map<String,UserRole> userRoleMap = new Map<String,UserRole>();
            Map<String,Profile> profileMap = new Map<String,Profile>();
            for(BAT_AutomaticUserCreationFromContact__mdt metaRec : countryAutomaticUserCreationMtdMap.values()){
                userRoleMap.put(metaRec.BAT_RoleName__c,new UserRole());
                profileMap.put(metaRec.BAT_ProfileName__c,new Profile());
            }
            for(UserRole userRoleRec : [SELECT Id, Name FROM UserRole WHERE Name In :userRoleMap.keySet()]){
                userRoleMap.put(userRoleRec.Name,userRoleRec);
            }
            for(Profile profileRec : [SELECT Id, Name   FROM Profile WHERE Name In :profileMap.keySet()]){
                profileMap.put(profileRec.Name,profileRec);
            }
            List<User> userToBeInserted = new List<User>();
            Set<Id> userIdSet = new Set<Id>();
            List<BAT_CreateRewardProfileForUser__e> createRewardProfile = new List<BAT_CreateRewardProfileForUser__e>();       
            Integer len = 4;
            String str = string.valueof(Math.abs(Crypto.getRandomLong()));
            String randomNumber = str.substring(0, len);
            if(!contactList.isEmpty()){
                for(Contact eachContact : contactList){
                    Integer aliasLenght = eachContact.FirstName.length() > 4 ? 4 : eachContact.FirstName.length();
                    User newUser = new User();
                    newUser.FirstName = eachContact.FirstName;
                    newUser.LastName = eachContact.LastName;
                    newUser.Alias = eachContact.FirstName.substring(0,aliasLenght) + randomNumber;
                    newUser.Email = eachContact.Email;
                    newUser.Username = eachContact.Email;
                    newUser.ProfileId = profileMap.get(countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_ProfileName__c).Id;
                    newUser.IsActive = true;
                    newUser.ContactId = eachContact.Id;
                    newUser.TimeZoneSidKey = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_TimeZone__c;
                    newUser.LocaleSidKey = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_Locale__c;
                    newUser.LanguageLocaleKey = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_Language__c;
                    newUser.CurrencyIsoCode = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_CurrencyISOCode__c;  
                    newUser.DefaultCurrencyIsoCode = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_DefaultCurrencyISOCode__c;
                    newUser.EmailEncodingKey = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_EmailEncodingCode__c;
                    newUser.Country__c = eachContact.Account.Country__c;
                    newUser.BAT_Brand__c = countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_Brand__c;
                    if(!Test.isRunningTest()){
                        newUser.UserRoleId = UserRoleMap.get(countryAutomaticUserCreationMtdMap.get(eachContact.Account.Country__c).BAT_RoleName__c).Id;
                    }
                    userToBeInserted.add(newUser);
                }
            }
           
            if(!userToBeInserted.isEmpty()){
                Database.SaveResult[] insertedUserList = database.insert(userToBeInserted,false);
                for(Database.SaveResult sr : insertedUserList){
                    if(sr.isSuccess()){
                        createRewardProfile.add(new BAT_CreateRewardProfileForUser__e(BAT_UserId__c =sr.getId()));
                    }
                }            
            } 
            if(!createRewardProfile.isEmpty()){
                EventBus.publish(createRewardProfile);
            }
        }
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getCountrySetToBypassObsoleteAsset
    * @returns       : Set<String>
    * @params        : none
    * @description   : Returns set<Countries> for which the duplicate Asset name error be bypassed 
    * @changeHistory : 25.11.2021/Allada yeshwanth/ US : #741230 / Created the method
    *********************************************************************************************************/    
    public static Set<String> getCountrySetToBypassObsoleteAsset(){
        Set<String> toBypassCountrySet = new Set<String>();
        toBypassCountrySet.add(BAT_ConstantsUtility.COUNTRY_IT);
        toBypassCountrySet.add(BAT_ConstantsUtility.COUNTRY_ES);
        toBypassCountrySet.add(BAT_ConstantsUtility.COUNTRY_GR);
        toBypassCountrySet.add(BAT_ConstantsUtility.COUNTRY_CY);
        return toBypassCountrySet;
    }
    
   
    /********************************************************************************************************
    * @author        : ITC
    * @method Name   : getbrandprofileAnonymisationMapping
    * @returns       : Map<String,List<BAT_BrandProfileAnonymization__mdt>>
    * @params        : none
    * @description   : Returns Map<String,List<BAT_BrandProfileAnonymization__mdt>> from custom metadata
    * @changeHistory : 11-07-2024/US #1703189 / Created the method
    *********************************************************************************************************/
 public static Map<String,List<BAT_BrandProfileAnonymization__mdt>> getbrandprofileAnonymisationMapping(){
     List<BAT_BrandProfileAnonymization__mdt> brandprofileAnonymisationList = [Select MasterLabel,BAT_ObjectName__c,BAT_FieldAPIName__c,BAT_FieldValue__c,BAT_Country__c,BAT_FieldType__c,BAT_MappingValue__c,BAT_IsAnonymized__c  FROM BAT_BrandProfileAnonymization__mdt];
 for(BAT_BrandProfileAnonymization__mdt batch: brandprofileAnonymisationList){
        if (!brandprofileAnonymisationMap .containsKey(batch.BAT_Country__c)) {
            brandprofileAnonymisationMap .put(batch.BAT_Country__c, new List<BAT_BrandProfileAnonymization__mdt>());
        }
        brandprofileAnonymisationMap .get(batch.BAT_Country__c).add(batch);
    }
     
        return brandprofileAnonymisationMap ;
     
 }
    
        /********************************************************************************************************
    * @author        : ITC
    * @method Name   : storebeforeanonymization
    * @returns       : String
    * @params        : List<SObject> sobjectlist, String usercountry
    * @description   : Returns String containing the stamped anonymised values for sobjects into JSON String
    * @changeHistory : 11-07-2024/US #1703189 / Created the method
    *********************************************************************************************************/  
 public static String storebeforeanonymization(List<SObject> sobjectlist, String usercountry){
             String Storejsonmapping='';
       
        Map<String, List<BAT_BrandProfileAnonymization__mdt>> fieldMappings = getBrandProfileAnonymisationMapping();

        List<BAT_BrandProfile__c> profilesToUpdate = new List<BAT_BrandProfile__c>();

        for (SObject sobj : sobjectlist) {
           Map<String, Object> profileMap = new Map<String, Object>();

            List<BAT_BrandProfileAnonymization__mdt> objectMappings = fieldMappings.get(usercountry);

            for (BAT_BrandProfileAnonymization__mdt mapping : objectMappings) {
                 if(!mapping.BAT_MappingValue__c){
                 
                     profileMap.put(mapping.BAT_FieldAPIName__c, sobj.get(mapping.BAT_FieldAPIName__c));}
                
            }
            if (!profileMap.isEmpty()) {
                Storejsonmapping = JSON.serialize(profileMap);
            }
        }
        
            return Storejsonmapping;
       
    }


    /********************************************************************************************************
    * @author        : ITC
    * @method Name   : anonymizebrandprofile
    * @returns       : Map<String,sObject>
    * @params        : Set<Id> accIdSet, String usercountry, String objectName
    * @description   : Returns Map<String,sObject> containing the stamped anonymised values for sobjects for brandprofile anonymization
    * @changeHistory : 11-07-2024/US #1703189 / Created the method    
*********************************************************************************************************/      
public static Map<String, SObject> anonymizeBrandProfile (Set<Id> accIdSet, String usercountry, String objectName) {
    Map<String, Schema.SObjectField> fieldMap = Schema.describeSObjects(new List<String>{BAT_ConstantsUtility.BRAND_PROFILE_OBJECT_API_NAME})[0].fields.getMap();
    String allFields = String.join(new List<String>(fieldMap.keySet()), ',');
    String storemappingvalue='';
    String query = BAT_ConstantsUtility.SELECT_STRING + allFields + BAT_ConstantsUtility.QUERY_WHERE_CONDITION_BRANDPROFILE;
    List<SObject> sobjectlist = Database.query(query);
     
    if(String.isNotBlank(usercountry) && 
        usercountry.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_DE_STR)){
     storemappingvalue=storebeforeanonymization(sobjectlist,usercountry);
        }

    brandprofileAnonymisationMap = getbrandprofileAnonymisationMapping();
    Map<String, SObject> anonymisedRecordMap = new Map<String, SObject>();
    Datetime now = Datetime.now();
    
    Map<String, Object> profileMap = new Map<String, Object>();

    for (SObject objAnonyRec : sobjectlist) {
        Map<String, Object> fieldAnonymizationMap = new Map<String, Object>();

      
        for (BAT_BrandProfileAnonymization__mdt metaRec : brandprofileAnonymisationMap.get(usercountry)) {
                  
            if(metaRec.BAT_FieldType__c!=null){
            if (metaRec.BAT_FieldType__c.equalsIgnoreCase(BAT_ConstantsUtility.BOOLEAN_TYPE)) {
                fieldAnonymizationMap.put(metaRec.BAT_FieldAPIName__c, false);
            } else if (metaRec.BAT_FieldType__c.equalsIgnoreCase(BAT_ConstantsUtility.DATETIME_STR) && metaRec.BAT_IsAnonymized__c) {
                fieldAnonymizationMap.put(metaRec.BAT_FieldAPIName__c, now);
            } else if (metaRec.BAT_FieldType__c.equalsIgnoreCase(BAT_ConstantsUtility.TEXTAREA_STR) && metaRec.BAT_MappingValue__c) {
                fieldAnonymizationMap.put(metaRec.BAT_FieldAPIName__c,storemappingvalue);
            } else{
               fieldAnonymizationMap.put(metaRec.BAT_FieldAPIName__c, String.valueOf(metaRec.BAT_FieldValue__c)); 
            }
         }
            

        for (String fieldAPIName : fieldAnonymizationMap.keySet()) {
            objAnonyRec.put(fieldAPIName, fieldAnonymizationMap.get(fieldAPIName));
        }

        anonymisedRecordMap.put(String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.BAT_ID)), objAnonyRec);
        }
    }
    BAT_ConstantsUtility.isBrandprofileAnonymized = true;
    return anonymisedRecordMap;
}

    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getGlobalAnonymisationMapping
    * @returns       : Map<String,List<BAT_GlobalAnonymisationMapping__mdt>>
    * @params        : none
    * @description   : Returns Map<String,List<BAT_GlobalAnonymisationMapping__mdt>> from custom metadata
    * @changeHistory : 08-12-2021/Idrees Ali/US #756326 / Created the method
    *********************************************************************************************************/    
    public static Map<String,List<BAT_GlobalAnonymisationMapping__mdt>> getGlobalAnonymisationMapping(){
        //Map<String,List<BAT_GlobalAnonymisationMapping__mdt>> globalAnonymisationMap = new Map<String,List<BAT_GlobalAnonymisationMapping__mdt>>();
        for(BAT_GlobalAnonymisationMapping__mdt batch: [Select MasterLabel,BAT_ObjectName__c,BAT_FieldAPIName__c,BAT_FieldType__c,BAT_FieldValue__c 
                                                        FROM BAT_GlobalAnonymisationMapping__mdt]){
                 String keyStr = batch.MasterLabel + BAT_ConstantsUtility.STR_COLON + batch.BAT_ObjectName__c;
                 if(!globalAnonymisationMap.containsKey(keyStr)){
                        globalAnonymisationMap.put(keyStr,new List<BAT_GlobalAnonymisationMapping__mdt>());
                 }
                        globalAnonymisationMap.get(keyStr).add(batch);
         }
        return globalAnonymisationMap;
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : genericFieldAnonymisationPopulationMethod
    * @returns       : Map<String,sObject>
    * @params        : String objectName,List<sObject> sobjectRecordsList
    * @description   : Returns Map<String,sObject> containing the stamped anonymised values for sobjects
    * @changeHistory : 08-12-2021/Idrees Ali/US #756326 / Created the method
    *                : 18-Jan-2024/BJSURAJ/US: #1602116/Added Country Check
    *********************************************************************************************************/    
    public static Map<String,sObject> genericFieldAnonymisationPopulationMethod(String objectName,List<sObject> sobjectRecordsList){
        String str = BAT_ConstantsUtility.BLANK;
        String fieldValue = BAT_ConstantsUtility.BLANK;
        // 28th March, 2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization */      
        String birthdateFieldName = BAT_ConstantsUtility.BirthDate_CZ_SK; 
        String externalSubscriberId5 =BAT_ConstantsUtility.BAT_subscriberExternalId5;
        String externalSubscriberId4 =BAT_ConstantsUtility.BAT_subscriberExternalId4;
        String externalcustomerId5 =BAT_ConstantsUtility.BAT_customerExternalId5;
        
        globalAnonymisationMap = getGlobalAnonymisationMapping();
        Map<String,sObject> anonymisedRecordMap =  new Map<String,sObject>();
        system.debug('Testingleaddd'+sobjectRecordsList);
        system.debug('TestingobjectName'+objectName);
            for(sObject objAnonyRec : sobjectRecordsList){
                //18-Jan-2024/BJSURAJ/US: #1602116
                if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.OBJECT_SURVEYTAKER)){
                    str = String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.SURVEYTAKER_COUNTRY));
                     system.debug('Testingstr'+str);
                }
                 //1703189-DE - multicategory Loyalty program - Anonymisation starts--
                else if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.BRAND_PROFILE_OBJECT_API_NAME)){
                    str = String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.BRAND_PROFILE_COUNTRY_API_NAME));
                }
                 //1703189-DE - multicategory Loyalty program - Anonymisation ends--
                 else{
                    str = String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.COUNTRY));
                }
                    
                // 28th March, 2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization */
                if(System.isBatch() && objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_LEAD_STR) && 
                    objAnonyRec.get(birthdateFieldName) != null && 
                    (str.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) || str.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SK))) {
                      system.debug('Testingstr1'+str);
                        Date birthDate = (Date)objAnonyRec.get(birthdateFieldName);
                        birthDate = Date.newInstance(birthDate.year(), 1, 1);
                        objAnonyRec.put(birthdateFieldName, birthDate);
                    }
                if (System.isBatch() && (objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_LEAD_STR) || 
                                          objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR))&& 
                    (objAnonyRec.get(externalSubscriberId5) != null ||objAnonyRec.get(externalSubscriberId4) != null 
                     ||(objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR))&&objAnonyRec.get(externalcustomerId5) != null) && 
                    (str.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) || str.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SK))) {
                        
                        String idBlank = (String) objAnonyRec.get(externalSubscriberId5);
                        idBlank = BAT_ConstantsUtility.EMPTY_STRING;
                        objAnonyRec.put(externalSubscriberId5, idBlank);
                        
                        String idBlankone = (String) objAnonyRec.get(externalSubscriberId4);
                        idBlankone = BAT_ConstantsUtility.EMPTY_STRING;
                        objAnonyRec.put(externalSubscriberId4, idBlank);
                        
                        String idBlanktwo = (String) objAnonyRec.get(externalcustomerId5);
                        idBlanktwo = BAT_ConstantsUtility.EMPTY_STRING;
                        objAnonyRec.put(externalcustomerId5, idBlank);
                    }
                //09.July.2024/varaprasad sada / US#1771605-SE - Salesforce Data Retention Policy - Account (part2)
                if(System.isBatch() &&objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR)&&String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.COUNTRY))==BAT_ConstantsUtility.COUNTRY_SE&&isNoOrders(String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.ID_STR)))){
                    BAT_AnonymizeAccountController.anonymizeAccount((Account)objAnonyRec,true);
                }       
                //09.July.2024/varaprasad sada / US#1771605-SE - Salesforce Data Retention Policy - Account (part2)
                if(System.isBatch() &&objectName.equalsIgnoreCase(BAT_ConstantsUtility.ORDER_STR)&&String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.COUNTRY))==BAT_ConstantsUtility.COUNTRY_SE&&isRecentOrder(String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.ID_STR)),String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.BAT_ACCOUNTID_STR)))){
                   String accId = (String) objAnonyRec.get(BAT_ConstantsUtility.BAT_ACCOUNTID_STR);
                    system.debug('==accid=='+accId);
                   Account acc= BAT_AnonymizeAccountController.getAccount(accId);
                    BAT_AnonymizeAccountController.anonymizeAccount(acc,true);
                }               
                if(globalAnonymisationMap.containsKey(str + BAT_ConstantsUtility.STR_COLON + objectName )){
                    for(BAT_GlobalAnonymisationMapping__mdt metaRec : globalAnonymisationMap.get(str + BAT_ConstantsUtility.STR_COLON + objectName)){
                        if(!String.isBlank(metaRec.BAT_FieldValue__c) && metaRec.BAT_FieldValue__c.contains(BAT_ConstantsUtility.STR_COLON) && metaRec.BAT_FieldType__c.equalsIgnoreCase(BAT_ConstantsUtility.STRING_STR)){
                            String keyStr = str + BAT_ConstantsUtility.STR_COLON + objectName;
                            if(!keyStr.equalsIgnoreCase(BAT_ConstantsUtility.SE_COLON_LEAD_STR) || 
                               (keyStr.equalsIgnoreCase(BAT_ConstantsUtility.SE_COLON_LEAD_STR) && system.isBatch() && objAnonyRec.get(BAT_ConstantsUtility.EMAILOPTOUT_FIELDAPINAME_STR) == true && objAnonyRec.get(BAT_ConstantsUtility.LASTEMAILDATE_FIELDAPINAME_STR) == null && objAnonyRec.get(BAT_ConstantsUtility.LASTCONSENTDATE) == null)){
                                   fieldValue = String.valueOf(objAnonyRec.get(metaRec.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON).get(0))) + String.valueOf(metaRec.BAT_FieldValue__c.split(BAT_ConstantsUtility.STR_COLON).get(1));
                                   objAnonyRec.put(metaRec.BAT_FieldAPIName__c, fieldValue);
                               }
                        }else if(metaRec.BAT_FieldType__c.equalsIgnoreCase(BAT_ConstantsUtility.STRING_STR)){
                            objAnonyRec.put(metaRec.BAT_FieldAPIName__c, String.valueOf(metaRec.BAT_FieldValue__c));
                        }else if(metaRec.BAT_FieldType__c.equalsIgnoreCase(BAT_ConstantsUtility.BOOLEAN_TYPE)){
                            objAnonyRec.put(metaRec.BAT_FieldAPIName__c, Boolean.valueOf(metaRec.BAT_FieldValue__c));
                        }
                    }
                    anonymisedRecordMap.put(String.valueOf(objAnonyRec.get(BAT_ConstantsUtility.BAT_ID)),objAnonyRec);
                    System.debug('LKP 6002 '+anonymisedRecordMap.values());
                }
            }
        return anonymisedRecordMap;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getTrialProductConfig
    * @params        : Set<String> countrySet
    * @returns       : Map<String,BAT_TrialProductsConfig__mdt> prodCodeTrialProdConfigMap
    * @description   : Returns Map<String,BAT_TrialProductsConfig__mdt> containing the product SKU and respective Metadata
    * @changeHistory : 10-12-2021/Allada yeshwanth/US #823193 / Created the method
    *********************************************************************************************************/    
    public static Map<String,BAT_TrialProductsConfig__mdt> getTrialProductConfig(Set<String> countrySet){
        Map<String,BAT_TrialProductsConfig__mdt> prodCodeTrialProdConfigMap = new Map<String,BAT_TrialProductsConfig__mdt>();
        for(BAT_TrialProductsConfig__mdt trailProdConfigRec : [Select BAT_Brand__c,BAT_Country__c,BAT_OldStatusValue__c,BAT_ProductCodes__c,BAT_StatusFieldAPIName__c,BAT_StatusValue__c from BAT_TrialProductsConfig__mdt where BAT_Country__c IN :countrySet]){
            if(String.isNotblank(trailProdConfigRec.BAT_ProductCodes__c)){
                for(String SKU : trailProdConfigRec.BAT_ProductCodes__c.split(BAT_ConstantsUtility.SEMI_COLON)){
                    prodCodeTrialProdConfigMap.put(SKU,trailProdConfigRec);
                }
            }
        }
        return prodCodeTrialProdConfigMap;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getNewLeadRecordTypeId
    * @returns       : Id
    * @params        : None
    * @description   : ENH: Sprint 96 : US: #530277 Method to fetch Retailer Record Type Id only once in a single transaction
    * @changeHistory : 24.01.2022 / Idrees Ali / created method
    *********************************************************************************************************/
    public static Id getRetailerRecordTypeId(){
        if(retailerRecordTypeId == null){
            retailerRecordTypeId = getRecTypeIdByDevName(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR,BAT_ConstantsUtility.BAT_RETAILERRECORDTYPEID);
        }
        return retailerRecordTypeId;
    }
    
    /********************************************************************************************************
    * @method Name   : getAutomaticUserCreationMtd
    * @params        : 
    * @returns       : Map<String,BAT_AutomaticUserCreationFromContact__mdt>
    * @description   : Returns Automatic user creation metadata
    * @changeHistory : 13.01.2022/Allada yeshwanth/US #778833 / Created the method
    *********************************************************************************************************/ 
    
    public static Map<String,BAT_AutomaticUserCreationFromContact__mdt> getAutomaticUserCreationMtd(){
        Map<String,BAT_AutomaticUserCreationFromContact__mdt> countryAutomaticUserCreationMtdMap = new Map<String,BAT_AutomaticUserCreationFromContact__mdt>();
        
        for(BAT_AutomaticUserCreationFromContact__mdt metaRec : [Select Id,BAT_AccountName__c,BAT_Brand__c,BAT_Country__c,BAT_CurrencyISOCode__c,BAT_DefaultCurrencyISOCode__c,
                                                                 BAT_EmailEncodingCode__c,BAT_Language__c,BAT_Locale__c,BAT_ProfileName__c,BAT_RoleName__c,BAT_TimeZone__c
                                                                 from BAT_AutomaticUserCreationFromContact__mdt]){
                                                                     countryAutomaticUserCreationMtdMap.put(metaRec.BAT_Country__c,metaRec);
                                                                 }
        
        return countryAutomaticUserCreationMtdMap;
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name    : BAT_AssetTriggerHandler
    * @description   : Sharing the record access of a device to tobacconist
    * @changeHistory : 14.09.2022/samekala@deloitte.com/ ENH || US #1134232|| 1062578: Asset Owner should be the selected Tobacconist
                     : 5.1.2023/Chetan Patil || Bug#1225538 || Fixed the Apex exception that prevented us from performing an operation on an inactive user.
                     : 09.05.2023 / Debasis Maharana / BUG#1370422 || Fixed exception- Attempt to de-reference a null object
    *********************************************************************************************************/
    @future
    public static void shareRecordAccess(Set<Id> assetIds, Set<Id> rewardProfileIds) {
       try{
            if(rewardProfileIds.isEmpty() || assetIds.isEmpty()){
                return;
            }
            List<Asset> assetRecords = [ SELECT Id,Selling_Reward_Profile__c,OwnerId FROM Asset WHERE Id IN :assetIds];
            List<AssetShare> assetShares = new List<AssetShare>();
            AssetShare shareAsset;
            Map<Id,BAT_Reward_Profile__c> rewardProfilesRecords = new Map<Id,BAT_Reward_Profile__c>([SELECT Id,User__c,User__r.IsActive  
                                                                                                    FROM BAT_Reward_Profile__c 
                                                                                                    WHERE Id IN :rewardProfileIds]);
            for(Asset objRec : assetRecords){
                shareAsset = new AssetShare();
                if(rewardProfilesRecords.containsKey(objRec.Selling_Reward_Profile__c)     
                && rewardProfilesRecords.get(objRec.Selling_Reward_Profile__c).User__c != null     
                && objRec.ownerId != rewardProfilesRecords.get(objRec.Selling_Reward_Profile__c).User__c  
                && rewardProfilesRecords.get(objRec.Selling_Reward_Profile__c).User__r != null     
                && rewardProfilesRecords.get(objRec.Selling_Reward_Profile__c).User__r.IsActive){
                    shareAsset.AssetId = objRec.Id;
                    shareAsset.UserOrGroupId = rewardProfilesRecords.get(objRec.Selling_Reward_Profile__c).User__c;
                    shareAsset.AssetAccessLevel = 'edit';
                    shareAsset.RowCause = 'Manual';
                    assetShares.add(shareAsset);
                }
            }
            if(assetShares != null && !assetShares.isEmpty()){
                insert assetShares;
            }    
       } catch(Exception ex){
            BAT_Utilities.createLog(ex,BAT_ConstantsUtility.BAT_UTILITIES_CLASS, BAT_ConstantsUtility.SHARE_RECORD_ACCESS); 
       } 
    }

    /************************************************************************************************
    @ Author: Deloitte
    @ Method: getApiConfigMeta
    @ Description: Get REST API Configuration
    @ retuns: BAT_IntegrationEndpointConfiguration__mdt
    @ params: String eventType
    @ Change history: 26/09/2022/Vamsi Ramineni/Created the Method
                     GLOBAL/US #1105804/Privacy Snapshot creation for Account
    *********************************************************************************************************************************/
    public Static BAT_IntegrationEndpointConfiguration__mdt getApiConfigMeta(String eventType){
        BAT_IntegrationEndpointConfiguration__mdt integrationRecMdt = [Select MasterLabel,BAT_NamedCredential__c,BAT_QueryParams__c,BAT_RequestEndpoint__c,BAT_RequestMethod__c,BAT_SuccessCode__c from BAT_IntegrationEndpointConfiguration__mdt where DeveloperName=:eventType LIMIT 1];
        return integrationRecMdt;
        
    }

     /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         concatenateBrandHouseForIntegration
    *@ returns:        void
    *@ params:         sObject newObjectRecord, sObject oldObjectRecord, String loggedInUserProfileName
    *@description:     This method is used to concatenate brandhouse during patch request since integration cannot do a get call as per ITT rules
    *@changeHistory:   09.06.2022/Idrees Ali/ ENH - Sprint 113 - US#1119472:CZ & SK - VELO Acclimatization
                       19.05.2023/Chirag Kalra / ENH - Sprint 130 - US#1131916:ZA || Duplicate Records in CRM
    ************************************************************************************************************************************/                   
    public static void concatenateBrandHouseForIntegration(sObject newObjectRecord, sObject oldObjectRecord, String loggedInUserProfileName, String loggedInUserUserName) {
       // List<String> countryList = new List<String>{BAT_ConstantsUtility.COUNTRY_CZ,BAT_ConstantsUtility.COUNTRY_SK,BAT_ConstantsUtility.COUNTRY_FR,BAT_ConstantsUtility.COUNTRY_ZA,BAT_ConstantsUtility.COUNTRY_SE,BAT_ConstantsUtility.COUNTRY_DK,BAT_ConstantsUtility.COUNTRY_GR}; //US#1131916:Added ZA country to Brand Concatination Logic//US#1621675 Added GR country to Brand Concatination Logic 
       List<String> countryList = new List<String>(BAT_ConstantsUtility.BRANDHOUSE_CONCATENATION.split(BAT_ConstantsUtility.SEMI_COLON));
            List<String> newBrandList = new List<String>();
        String newBrand = BAT_ConstantsUtility.BLANK;
        if(!countryList.isEmpty() && countryList.contains(String.valueOf(newObjectRecord.get(BAT_ConstantsUtility.COUNTRY))) && (loggedInUserProfileName == BAT_ConstantsUtility.INTEGARTION_USER ||  (loggedInUserUserName.equalsIgnoreCase(BAT_ConstantsUtility.MARKETINGUSER) && String.valueOf(newObjectRecord.get(BAT_ConstantsUtility.COUNTRY)).equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR) )) && String.isNotBlank(String.valueOf(oldObjectRecord.get(BAT_ConstantsUtility.FIELD_BRANDHOUSE))))
        {
            if(String.isNotBlank(String.valueOf(newObjectRecord.get(BAT_ConstantsUtility.FIELD_BRANDHOUSE)))){
                newBrandList = String.valueOf(newObjectRecord.get(BAT_ConstantsUtility.FIELD_BRANDHOUSE)).split(BAT_ConstantsUtility.SEMI_COLON);
            }
            if(!newBrandList.isEmpty()){
                for(String str : newBrandList){
                    if(!String.valueOf(oldObjectRecord.get(BAT_ConstantsUtility.FIELD_BRANDHOUSE)).contains(str)){
                        newBrand += str + BAT_ConstantsUtility.SEMI_COLON ;
                    }
                }
            }
            if(String.isNotBlank(newBrand)){
                newObjectRecord.put(BAT_ConstantsUtility.FIELD_BRANDHOUSE , oldObjectRecord.get(BAT_ConstantsUtility.FIELD_BRANDHOUSE) + BAT_ConstantsUtility.SEMI_COLON + newBrand);
            }
            else{
                newObjectRecord.put(BAT_ConstantsUtility.FIELD_BRANDHOUSE , oldObjectRecord.get(BAT_ConstantsUtility.FIELD_BRANDHOUSE));
            }
        }
    }
    
     /************************************************************************************************************************************
    *@ author:         ITC 
    *@ method:         concatenateBrandHouseForIntegration
    *@ returns:        void
    *@ params:         sObject newObjectRecord, sObject oldObjectRecord, String loggedInUserProfileName
    *@description:     This method is used to concatenate brand in the Activation Preference object BAT_ExistingConsumer during patch request since integration cannot do a get call as per ITT rules
    *@ticket:           1687170-UK SF <> EEP Integration - Additional data fields on integration for ACTIVATIONPREFERENCE object-ExistingConsumer concatenation--    
************************************************************************************************************************************/                   
    public static void concatenatecustomForIntegration(sObject newObjectRecord, sObject oldObjectRecord, String loggedInUserProfileName, String loggedInUserUserName, String usercountry) {
    String newObjectName = newObjectRecord.getSObjectType().getDescribe().getName();
       
    List<BAT_BrandConcatenation__mdt> lstbrand = new List<BAT_BrandConcatenation__mdt>();
    Map<String, List<BAT_BrandConcatenation__mdt>> brandcountry = new Map<String, List<BAT_BrandConcatenation__mdt>>();

    lstbrand = [SELECT id, MasterLabel, BAT_Country__c, BAT_FieldName__c, BAT_ObjectName__c FROM BAT_BrandConcatenation__mdt WHERE MasterLabel = :usercountry AND BAT_ObjectName__c = :newObjectName];
    for(BAT_BrandConcatenation__mdt bc : lstbrand){
        if (!brandcountry.containsKey(bc.MasterLabel)) {
            brandcountry.put(bc.MasterLabel, new List<BAT_BrandConcatenation__mdt>());
        }
        brandcountry.get(bc.MasterLabel).add(bc);
    }
    if (!brandcountry.isEmpty() && brandcountry.containsKey(usercountry) && loggedInUserProfileName == BAT_ConstantsUtility.INTEGARTION_USER) {
        for (BAT_BrandConcatenation__mdt bc : brandcountry.get(usercountry)) {
            String fieldNames = String.valueOf(bc.BAT_FieldName__c);             
                 List<String> fieldNameList =fieldNames.split(',');
                
            for(String fieldName : fieldNameList) {
                 fieldName = fieldName.trim();
                if (String.isNotBlank(String.valueOf(oldObjectRecord.get(fieldName)))){
                    String newBrand = BAT_ConstantsUtility.BLANK;
                    List<String> newBrandList= new list<String>();
                    if(String.isNotBlank(String.valueOf(newObjectRecord.get(fieldName)))){
                    newBrandList = String.valueOf(newObjectRecord.get(fieldName)).split(BAT_ConstantsUtility.SEMI_COLON);
                    }
                    for (String str : newBrandList) {
                        if (!String.valueOf(oldObjectRecord.get(fieldName)).contains(str)) {
                            newBrand += str + BAT_ConstantsUtility.SEMI_COLON;
                        }
                    }

                    if (String.isNotBlank(newBrand)) {
                        newObjectRecord.put(fieldName, oldObjectRecord.get(fieldName) + BAT_ConstantsUtility.SEMI_COLON + newBrand);
                    } else {
                        newObjectRecord.put(fieldName, oldObjectRecord.get(fieldName));
                    }
                }
            }
        }
    }
}

    
    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name    : BAT_AccountTriggerHandler/BAT_LeadTriggerHandler
    * @description   : Update the BAT_ISSynchroniseinMC__c field based on Country and MarketingCloud
    * @changeHistory : 30.08.2022/samekala@deloitte.com/ US#1049237
    *                : 01.09.2022/Turbasu Ghosh / US #1028107/ Product Backlog Item 1028107: Global: All Markets: To include Synchronisation field on Lead to synchronise data correctly on Marketing Cloud
    *********************************************************************************************************/
    public static void updateSynchroniseField(sObject newRecord, sObject oldRecord) {
       
        List<String> countryList = new List<String>{BAT_ConstantsUtility.COUNTRY_KZ,BAT_ConstantsUtility.COUNTRY_UA,
            BAT_ConstantsUtility.COUNTRY_BG,BAT_ConstantsUtility.COUNTRY_AZ};
                if((Trigger.isInsert && oldRecord == null) || (oldRecord != null && String.isNotBlank((String)oldRecord.get(BAT_ConstantsUtility.COUNTRY)) && (String)oldRecord.get(BAT_ConstantsUtility.COUNTRY) != (String)newRecord.get(BAT_ConstantsUtility.COUNTRY)))
                newRecord.put(BAT_ConstantsUtility.SYNCHRONISE_IN_MC,countryList.contains((String)newRecord.get(BAT_ConstantsUtility.COUNTRY)) ?  false : true);
        }
    
     /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name   : marketingCloudMetadataWrapper
    * @description   : [IT] Class to get the mandatory check list for marketingCloudMetadataWrapper
    * @changeHistory : 14.09.2022/Idrees Ali/ US#1070502:IT | GH | Glo | lterative solution for Reach system using SFMC
    *********************************************************************************************************/
    public class marketingCloudMetadataWrapper{
        public Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> countryFieldMappingMap = new Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> ();
        public Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> countryCriteriaMap = new Map<String, List<BAT_MarketingMandatoryFieldCriteria__mdt>> ();
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name   : fetchMarketingCloudMeta
    * @description   : [IT] Method to create SFMC related criteria map and JSON field mapping maps
    * @changeHistory :  14.09.2022/Idrees Ali/ US#1070502:IT | GH | Glo | lterative solution for Reach system using SFMC
    *********************************************************************************************************/
    public static marketingCloudMetadataWrapper fetchMarketingCloudMeta (String objectName, String eventType) {
        List< BAT_MarketingMandatoryFieldCriteria__mdt > hm_LIST = [SELECT DeveloperName, FieldName__c,
                                                                    ObjectName__c, RequiredTextValue__c,BAT_EventType__c,BAT_IsFieldCriteriaRecord__c,BAT_IsFieldMappingRecord__c,BAT_KeyName__c
                                                                    FROM BAT_MarketingMandatoryFieldCriteria__mdt where objectName__c = :objectName
                                                                    and BAT_EventType__c = :eventType];         
        
        for(BAT_MarketingMandatoryFieldCriteria__mdt hm: hm_LIST){
            String countryStr = hm.DeveloperName.split('_')[0];
            String keyStr = hm.DeveloperName.split('_')[0] + BAT_ConstantsUtility.STR_COLON + objectName;
            if(hm.ObjectName__c == objectName){
                system.debug('Testingobj=='+objectName);
                if(hm.BAT_IsFieldCriteriaRecord__c){
                    system.debug('Testingobj2=='+hm.BAT_IsFieldCriteriaRecord__c);
                    if(!marketingCloudWrapper.countryCriteriaMap.containsKey(keyStr)){
                        marketingCloudWrapper.countryCriteriaMap.put(keyStr, new List<BAT_MarketingMandatoryFieldCriteria__mdt>());
                 
                    }
                    system.debug('TestingmarketingCloudWrapper=='+marketingCloudWrapper);
                    marketingCloudWrapper.countryCriteriaMap.get(keyStr).add(hm);
                }
            }
            if(hm.BAT_IsFieldMappingRecord__c){
                if(!marketingCloudWrapper.countryFieldMappingMap.containsKey(countryStr)){
                    marketingCloudWrapper.countryFieldMappingMap.put(countryStr, new List<BAT_MarketingMandatoryFieldCriteria__mdt>());
        
                }
                marketingCloudWrapper.countryFieldMappingMap.get(countryStr).add(hm);
              
            }
        }
        system.debug('marketingCloudWrapper=='+marketingCloudWrapper);
        return marketingCloudWrapper;
    }

    /************************************************************************************************************************************
*@ author:         Deloitte  
*@ method:         anonymizeRelatedSurvey
*@ returns:        List<Survey>
*@ params:         List<Id>
*@description:     [All Markets] Logic to anonymize related Survey of accounts. 
*@changeHistory:   11-10-2022/ Chetan Patil/ Sprint-SIT: Bug#1164007/Created the method

************************************************************************************************************************************/
    public Static void anonymizeRelatedSurveyInvitation (list<Id> ParticipantIds,list<Id> AccountIds){
        Set<Id> SurveyIds = new Set<Id>();
        List<SurveySubject> surveySubList = new List<SurveySubject>();
        List<SurveyInvitation> surveysToUpdate = [SELECT Id,Name,SurveyId,(select id, Name from SurveySubjects)  FROM SurveyInvitation WHERE ParticipantId IN :ParticipantIds];        
        for(SurveyInvitation surveyInv : surveysToUpdate){
            surveyInv.name= BAT_ConstantsUtility.ANONYMOUS_DATA;
            SurveyIds.add(surveyInv.SurveyId);
            for(SurveySubject surveySubObj : surveyInv.SurveySubjects){
                SurveySubject obj = new SurveySubject(Id=surveySubObj.Id,Name=BAT_ConstantsUtility.ANONYMOUS_DATA);
                surveySubList.add(obj);
            }
        } 
        if(!surveysToUpdate.isEmpty())
        update surveysToUpdate;
        if(!surveySubList.isEmpty())
        update surveySubList;
        List<BAT_SurveyInvitation__c> surveysInvToUpdates = new List<BAT_SurveyInvitation__c>();
        String query='SELECT BAT_Account__c, BAT_InvitationLink__c, BAT_Lead__c, Name, Id FROM BAT_SurveyInvitation__c where ';
        
        if(AccountIds!=null){
            query= query+'BAT_Account__c IN :AccountIds ';
        }
        else{
            query= query+'BAT_Lead__c IN:ParticipantIds';
        }
        for(BAT_SurveyInvitation__c si:database.query(query)){
            si.Name = BAT_ConstantsUtility.ANONYMOUS_DATA;
            surveysInvToUpdates.add(si);
        }
        if(!surveysInvToUpdates.isEmpty())
        update surveysInvToUpdates;
        
        List<SurveyResponse> SurveyResponseList = new List<SurveyResponse>();
        SurveyResponseList = [SELECT SurveyId, Name, Id FROM SurveyResponse where SurveyId in : SurveyIds];
        if(!SurveyResponseList.isEmpty())
            delete SurveyResponseList;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : checkRfmSegmentValues
    * @returns       : void
    * @params        : List<Lead>
    * @description   : [All Markets] #1120605 : Changed BAT_RFM_Segment__c to Multi-Select picklist
                        Picklist should allow to select up to three values but limit to one per category. So one Lead can have  THP-New, Vape-Lost, Oral-Loyal customers but in opposite having THP-New, THP-Lost, Oral-Lost should not be allowed. 
    * @changeHistory : 17.10.2022/Swaraj Ray/Created the method
    *                  30.01.2023/Swaraj Ray/ BAT#1257012 - Updated the method to have custom validation for the new Segments values
    *********************************************************************************************************/ 
    public static void checkRfmSegmentValues (sObject[] records, sObject objectApi){
        
        //getting number of unique brands
        Integer noOfUniqueBrands;
        Set<String> rfmPickListValues= new Set<String>();
        Schema.sObjectType objType = objectApi.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Map <String, Schema.SObjectField> fieldMap = new Map <String, Schema.SObjectField>();
        fieldMap = objDescribe.fields.getMap();
        List <Schema.PicklistEntry> values = fieldMap.get(BAT_ConstantsUtility.RFM_SEGMENT_FIELD).getDescribe().getPickListValues();
        for( Schema.PicklistEntry pickListVal : values){
            string label = pickListVal.getLabel();
            String strPickValBrand = '';
            if(objDescribe.getLabel() == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                strPickValBrand = label.substring(0,label.lastIndexOf(BAT_ConstantsUtility.HYPHEN));
            }// if sObject other than Account
            else{
                strPickValBrand = pickListVal.getLabel().substringBefore(BAT_ConstantsUtility.HYPHEN);
            }
            if(!rfmPickListValues.contains(strPickValBrand)){
                rfmPickListValues.add(strPickValBrand);
            }
        }
        
        //As new brands can be added to the picklist, we need keep it dynamic to understand what are the unique brands in picklist
        noOfUniqueBrands = rfmPickListValues.size();
        if(!records.isEmpty()){
            Set<String> selectedRfmBrands = new Set<String>();
            for(sObject currentRecord: records){ 
                String rfmSegmentValues = '';
                if(currentRecord.get(BAT_ConstantsUtility.RFM_SEGMENT_FIELD) != NULL){
                   rfmSegmentValues = currentRecord.get(BAT_ConstantsUtility.RFM_SEGMENT_FIELD).toString();
                }
                if(String.isNotBlank(rfmSegmentValues)){
                    List<String> rfmSegments = rfmSegmentValues.split(BAT_ConstantsUtility.SEMI_COLON);
                    //If the number of values selected are more than number of unique brands that means already more than 2 values are selected //per brand for any or all brands.
                    if(rfmSegments.size() > noOfUniqueBrands){
                        currentRecord.addError(Label.BAT_RFMSegmentMultiSelectError);
                    }
                    else{
                        for(String strRfmValue:rfmSegments){

                            if(objDescribe.getLabel() == BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
                                if(!selectedRfmBrands.contains(strRfmValue.substring(0,strRfmValue.lastIndexOf(BAT_ConstantsUtility.HYPHEN)))){
                                    selectedRfmBrands.add(strRfmValue.substring(0,strRfmValue.lastIndexOf(BAT_ConstantsUtility.HYPHEN)));
                                }
                                else{
                                    currentRecord.addError(Label.BAT_AccSegmentMultiSelectError);
                                }
                            }// if sObject other than Account
                            else{
                                    //If a value is selected for a particular brand, need to see other values
                                if(!selectedRfmBrands.contains(strRfmValue.substringBefore(BAT_ConstantsUtility.HYPHEN))){
                                    selectedRfmBrands.add(strRfmValue.substringBefore(BAT_ConstantsUtility.HYPHEN));
                                }
                                else{
                                    currentRecord.addError(Label.BAT_RFMSegmentMultiSelectError);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /********************************************************************************************************
    @ author:        Deloitte  
    @ method:        callReverseAPIForsObjectRecords 
    @ returns:       void
    @ params:        String, String, String
    @description:    This method calls callReverseApi method and passes the records for those countries having record in BAT_EnableCountryForReverseAPI__mdt
    @changeHistory:  21.10.2022/Idrees Ali/US-1070693-Created the method
    *********************************************************************************************************/
    public static void callReverseAPIForsObjectRecords(String eventString, String objectName, String countryApiName,List<sObject> eligibleRecords ){
        //set of country to check reverse API is enable for country
        Set<String> countryEnabledSet = new Set<String>();
        //List to save the list of eligible record 
        List<sObject> listOfEligibleRecords = new List<sObject>();
        //get the enabled country from metadata
        countryEnabledSet = BAT_ReverseAPIUtility.checkCountryEnabled();
        //US#530277 : Stop Outbound call for Retailer record Type
        ID retailerRecordTypeId = getRetailerRecordTypeId();
        
        for(sObject eachRecord : eligibleRecords){
            if(!objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) || (objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) && eachRecord.get('RecordTypeId') != retailerRecordTypeId)){
                String country = (String)eachRecord.get(countryApiName);
                //this if will check the criteria and mapping records are present for that country or not also this country is enabled for reverse API or not
                if(!countryEnabledSet.isEmpty() && countryEnabledSet.contains(country))
                {
                    listOfEligibleRecords.add(eachRecord);
                }
            }
        }
        //If the list is not empty, reverse integration is executed and CallReverseAPI is called
        if(!listOfEligibleRecords.isEmpty()){
            BAT_ReverseAPICallHandler apiHandler = new BAT_ReverseAPICallHandler(); 
            apiHandler.CallReverseAPI(eventString, objectName, countryApiName, listOfEligibleRecords, null);
        }
    }

    /********************************************************************************************************
    @ author:        Deloitte  
    @ method:        createApexLog 
    @ returns:       void
    @ params:        String, String, String
    @description:    This method creates Apex Exception Logs
    *@changeHistory :21st October, 2022 / Swaraj Ray  /Created the method
    *********************************************************************************************************/
    
    public static void createApexLog(String ClassName, String ErrorString){
        Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = ClassName , Exception__c = ErrorString);
        insert apexLog;
    }

    /********************************************************************************************************
    @ author:        Deloitte  
    @ method:        createIntegrationLog 
    @ returns:       BAT_Integration_Log_DE__c
    @ params:        String, String, String
    @description:    This method creates Apex Integration Exception Logs
    *@changeHistory :21st October, 2022 / Swaraj Ray  /Created the method
    *********************************************************************************************************/
    
    public static BAT_Integration_Log_DE__c createIntegrationLog(String requestDetails, String responseDetails, String status){
        BAT_Integration_Log_DE__c integrationLog = new BAT_Integration_Log_DE__c(Request_Details__c = requestDetails , Response_Details__c = responseDetails, Status__c = status);
        return integrationLog;
    }
    
    /************************************************************************************************************************************
    *@author        :Deloitte  
    *@method        :getOrderItems
    *@returns       :Map<Id,Set<String>>
    *@description   :This method is used to create map of Orders with their product's brand
    *@changeHistory :31st October, 2022 / Swaraj Ray /Created the method
    ************************************************************************************************************************************/
    public static Map<Id,Set<String>> getOrderItems(map<id,Order> mapOfOrders){
        
        Map<Id,Set<String>> orderItemsMap = new Map<Id,Set<String>>();
        List<OrderItem> currentOrderItems = [SELECT ID, OrderId,Product2.Brand__c from OrderItem WHERE OrderId IN :mapOfOrders.keySet()];
            // creates a Map to store all the brands for an Order
            if(currentOrderItems.size() > 0 && !currentOrderItems.isEmpty()){      
                for(OrderItem oi : currentOrderItems){
                    
                    if(orderItemsMap.containsKey(oi.OrderId)){
                        orderItemsMap.get(oi.OrderId).add(oi.Product2.Brand__c);
                    } else {
                        orderItemsMap.put(oi.OrderId, new Set<String>{oi.Product2.Brand__c});
                    }
                }
            }
        return orderItemsMap;
    }
    /************************************************************************************************************************************
    *@author        :Deloitte  
    *@method        :fetchConditionNameOnTheBasisOfCouponCode
    *@returns       :String country, String modelName, String conditionName, String cluster, String couponCode, String accountSource
    *@description   :This method is used to check if the condition name(with coupon code parameter) exists in the metadata or not.
                    Incase it doesnt exists, it will go with the non-coupon code parameter point records
    *@changeHistory :14.11.2022 / Idrees Ali /Created the method
    ************************************************************************************************************************************/
    public static String fetchConditionNameOnTheBasisOfCouponCode (String country, String modelName, String conditionName, String cluster, String couponCode, String accountSource){
        String completeConditionName = BAT_ConstantsUtility.BLANK_STR;
        //Below If check works if the account source is not blank and a match is found on the basis of three params cluster,model,coupon code and account source
        if(!String.isBlank(accountSource) && accSourceNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + accountSource)){
            //Below condition checks if coupon code and model are included in the metadata or not
            if(!couponCodeSet.isEmpty() && couponCodeSet.contains(country + BAT_ConstantsUtility.STR_COLON + couponCode) && !modelNameSet.isEmpty() && modelNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + modelName)){
                completeConditionName = !String.isBlank(cluster) ? country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + modelName.deleteWhitespace() + conditionName + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + accountSource.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode :
                country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + modelName.deleteWhitespace()  + conditionName + BAT_ConstantsUtility.UNDERSCORE + accountSource.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode;
                system.debug('completeConditionName==' + completeConditionName);
                //Universal map checks if the above created condition is present in the metadata If Not, it will go with other param checks
                system.debug('mapOfCouponCodeConditions==' + mapOfCouponCodeConditions);
                if(mapOfCouponCodeConditions.containsKey(completeConditionName)){
                    return completeConditionName;
                }
                else{
                    completeConditionName = !String.isBlank(cluster) ? country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + accountSource.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode :
                    country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName + BAT_ConstantsUtility.UNDERSCORE + accountSource.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode;
                    system.debug('completeConditionName2==' + completeConditionName);
                    if(mapOfCouponCodeConditions.containsKey(completeConditionName)){
                        return completeConditionName;
                    }
                    
                }
            }  
        }
        //Below If check works if the account source is blank 
        else if(!couponCodeSet.isEmpty() && couponCodeSet.contains(country + BAT_ConstantsUtility.STR_COLON + couponCode) && !modelNameSet.isEmpty() && modelNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + modelName)){
            completeConditionName = !String.isBlank(cluster) ? country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + modelName.deleteWhitespace() + conditionName + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode :
            country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + modelName.deleteWhitespace()  + conditionName + BAT_ConstantsUtility.UNDERSCORE + couponCode;
            system.debug('completeConditionName==' + completeConditionName);
            system.debug('mapOfCouponCodeConditions==' + mapOfCouponCodeConditions);
            if(mapOfCouponCodeConditions.containsKey(completeConditionName)){
                return completeConditionName;
            }
            else{
                completeConditionName = !String.isBlank(cluster) ? country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode :
                country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName + BAT_ConstantsUtility.UNDERSCORE + couponCode;
                system.debug('completeConditionName2==' + completeConditionName);
                if(mapOfCouponCodeConditions.containsKey(completeConditionName)){
                    return completeConditionName;
                }
                
            }
        }
        //Below condition works if couponcode is present but model doesn't exist in metadata
        else if(!couponCodeSet.isEmpty() && couponCodeSet.contains(country + BAT_ConstantsUtility.STR_COLON + couponCode) && !modelNameSet.isEmpty() && !modelNameSet.contains(country + BAT_ConstantsUtility.STR_COLON + modelName)){
            completeConditionName = !String.isBlank(cluster) ? country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER + BAT_ConstantsUtility.UNDERSCORE + cluster.deleteWhitespace() + BAT_ConstantsUtility.UNDERSCORE + couponCode :
            country + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + conditionName + BAT_ConstantsUtility.UNDERSCORE + couponCode;
            system.debug('completeConditionName2==' + completeConditionName);
            if(mapOfCouponCodeConditions.containsKey(completeConditionName)){
                return completeConditionName;
            }
            
        }
        return BAT_ConstantsUtility.NO_MATCH_FOUND_STR;
    }   
    
    /**
     * @description : US#1043064 - Method Trigger from order trigger when status is change to refunded or canceled by consumer
     * @author Sameer Ranjan (sameranjan@deloitte.com) | 07-19-2022
     * @param setOfCZOrderIds
     * @changeHistory : Bug #1142345 - Added logic to consider vype and vuse brand same
     **/
    @future
    public static void orderRefundedOrCanceledStatus(Set<Id> setOfCZOrderIds){
        try{
            Parameters methodParameters = new Parameters();
            methodParameters.filterBrands = new Set<String>();
            methodParameters.filterBrands.add(BAT_ConstantsUtility.PRODUCT_BRAND_VUSE);
            methodParameters.filterBrands.add(BAT_ConstantsUtility.PRODUCT_BRAND_VELO);
            methodParameters.filterBrands.add(BAT_ConstantsUtility.PRODUCT_BRAND_GLO);
            methodParameters.filterBrands.add(BAT_ConstantsUtility.PRODUCT_BRAND_VYPE);
            methodParameters.accountIds = new Set<Id>();
            methodParameters.currentOrderIds = new Set<Id>();
            methodParameters.countryValues = new Set<String>();
            Map<Id, Order> mapOfOrders = new Map<Id, Order>([SELECT Id, AccountId, Account.Brand_House__c, Country__c
                                                             FROM Order
                                                             WHERE Id IN:setOfCZOrderIds]);
            for (Order each : mapOfOrders.values()){
                if (each.AccountId != null){
                    methodParameters.accountIds.add(each.AccountId);
                }
                if (!String.isBlank(each.Country__c)){
                    methodParameters.countryValues.add(each.Country__c);
                }
                methodParameters.currentOrderIds.add(each.Id);
            }
            methodParameters.mapOfOrders = mapOfOrders;
            ReturnParameters returncheckExistingOrderStatus = checkExistingOrderStatus(methodParameters);
            ReturnParameters returncheckcheckExistingAssets = checkExistingAsset(methodParameters);
            List<Account> accountRecordsUpdate = new List<Account>();
            List<Asset> assetRecordUpdate = new List<Asset>();
            Set<Id> checkduplicateAccountId = new Set<Id>();
            Set<Id> checkduplicateAssetId = new Set<Id>();
            for (Order each : mapOfOrders.values()){
                if (returncheckExistingOrderStatus.orderIdWithBrand.containsKey(each.Id)){
                    for (String eachBrand : returncheckExistingOrderStatus.orderIdWithBrand.get(each.Id)){
                        methodParameters = new Parameters();
                        methodParameters.each = each;
                        methodParameters.eachBrand = eachBrand;
                        methodParameters.accountRecordsUpdate = accountRecordsUpdate;
                        methodParameters.assetRecordUpdate = assetRecordUpdate;
                        methodParameters.orderIdWithAccountInfo = returncheckExistingOrderStatus.orderIdWithAccountInfo;
                        methodParameters.checkduplicateAccountId = checkduplicateAccountId;
                        methodParameters.checkduplicateAssetId = checkduplicateAssetId;
                        methodParameters.returncheckcheckExistingAssets = returncheckcheckExistingAssets;
                        methodParameters.returncheckExistingOrderStatus = returncheckExistingOrderStatus;
                        methodParameters.mapOfOrders = mapOfOrders;
                        checkBrand(methodParameters);
                    }
                }
            }
            BAT_ConstantsUtility.isTriggerBypassed = true;
            if (accountRecordsUpdate != null && !accountRecordsUpdate.isEmpty()){
                update accountRecordsUpdate;
            }
            if (assetRecordUpdate != null && !assetRecordUpdate.isEmpty()){
                update assetRecordUpdate;
            }
        } catch (Exception ex){
            //Creating Apex log for the Exception
            Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = 'BAT_Utilities', Exception__c = ex.getMessage(), Method_Name__c = 'orderRefundedOrCanceledStatus');
            insert apexLog;
        }
    }

    private static void checkBrand(Parameters passingParameters){
        Parameters methodParameters = new Parameters();
        methodParameters.currentOrderId = passingParameters.each.Id;
        methodParameters.accountRecordsUpdate = passingParameters.accountRecordsUpdate;
        methodParameters.brandName = passingParameters.eachBrand;
        methodParameters.checkduplicateAccountId = passingParameters.checkduplicateAccountId;
        methodParameters.checkduplicateAssetId = passingParameters.checkduplicateAssetId;
        methodParameters.assetRecordUpdate = passingParameters.assetRecordUpdate;
        methodParameters.orderIdWithAccountInfo = passingParameters.orderIdWithAccountInfo;
        methodParameters.orderIdWithAssetInfo = passingParameters.returncheckcheckExistingAssets.orderIdWithAssetInfo;
        methodParameters.mapOfExitingAccountCheck = passingParameters.returncheckExistingOrderStatus.mapOfExitingAccountCheck;
        methodParameters.mapOfExistingAssetCheck = passingParameters.returncheckcheckExistingAssets.mapOfExistingAssetCheck;
        if (!passingParameters.returncheckExistingOrderStatus.mapOfExitingAccountCheck.containsKey(passingParameters.eachBrand) && !passingParameters.returncheckcheckExistingAssets.mapOfExistingAssetCheck.containsKey(passingParameters.eachBrand)){
            methodParameters.condition = 1;
            accountAndAssetUpdate(methodParameters);
            return;
        }
        if (passingParameters.returncheckExistingOrderStatus.mapOfExitingAccountCheck.containsKey(passingParameters.eachBrand) && !passingParameters.returncheckcheckExistingAssets.mapOfExistingAssetCheck.containsKey(passingParameters.eachBrand)){
            methodParameters.condition = 2;
            accountAndAssetUpdate(methodParameters);
            return;
        }
        if (!passingParameters.returncheckExistingOrderStatus.mapOfExitingAccountCheck.containsKey(passingParameters.eachBrand) && passingParameters.returncheckcheckExistingAssets.mapOfExistingAssetCheck.containsKey(passingParameters.eachBrand)){
            methodParameters.condition = 3;
            accountAndAssetUpdate(methodParameters);
            return;
        }
        if (passingParameters.returncheckExistingOrderStatus.mapOfExitingAccountCheck.containsKey(passingParameters.eachBrand) && passingParameters.returncheckcheckExistingAssets.mapOfExistingAssetCheck.containsKey(passingParameters.eachBrand)){
            methodParameters.condition = 4;
            accountAndAssetUpdate(methodParameters);
            return;
        }
    }
    private static void accountAndAssetUpdate(Parameters methodParameters){
        Account acc;
        List<Asset> assetRecords;
        if (methodParameters.orderIdWithAccountInfo.containsKey(methodParameters.currentOrderId)){
            acc = methodParameters.orderIdWithAccountInfo.get(methodParameters.currentOrderId);
            addingAccountIntoList(acc, methodParameters);
        }
        if (methodParameters.orderIdWithAssetInfo.containsKey(methodParameters.currentOrderId)){
            assetRecords = methodParameters.orderIdWithAssetInfo.get(methodParameters.currentOrderId);
            addingAssetIntoList(assetRecords, methodParameters);
        }
        // For Vuse
        if (acc != null && methodParameters.brandName == BAT_ConstantsUtility.PRODUCT_BRAND_VUSE){
            vuseBrandAccountUpdate(methodParameters, acc);
        }
        // For Velo
        if (acc != null && methodParameters.brandName == BAT_ConstantsUtility.PRODUCT_BRAND_VELO){
            veloBrandAccountUpdate(methodParameters, acc);
        }
        // For Glo
        if (acc != null && methodParameters.brandName == BAT_ConstantsUtility.PRODUCT_BRAND_GLO){
            gloBrandAccountUpdate(methodParameters, acc);
        }
        // Asset Record Update
        if (assetRecords != null && (methodParameters.brandName == BAT_ConstantsUtility.PRODUCT_BRAND_VUSE || methodParameters.brandName == BAT_ConstantsUtility.PRODUCT_BRAND_GLO)){
            for(Asset each : assetRecords){
                each.Status = BAT_ConstantsUtility.BAT_ASSET_RETURNED;
                each.BAT_PromotionName__c = null;
            }
        }
    }

    private static void addingAccountIntoList(Account acc, Parameters methodParameters){
        if (acc.Id != null && methodParameters.checkduplicateAccountId.add(acc.Id)){
            methodParameters.accountRecordsUpdate.add(methodParameters.orderIdWithAccountInfo.get(methodParameters.currentOrderId));
        }
    }

    private static void addingAssetIntoList(List<Asset> assetRecords, Parameters methodParameters){
        for(Asset each : assetRecords){
            if (each.Id != null && methodParameters.checkduplicateAssetId.add(each.Id)){
                methodParameters.assetRecordUpdate.add(each);
            }
        }
    }

    private static void vuseBrandAccountUpdate(Parameters methodParameters, Account acc){
        if (methodParameters.condition == 1){
            acc.BAT_VapeStatus__c = BAT_ConstantsUtility.PROSPECT;
            acc.GoVype_Last_Completed_Order_Date__c = null;
            acc.BAT_VapeConsumerSince__c = null;
        }
        if (methodParameters.condition == 2){
            acc.BAT_VapeConsumerSince__c = Date.valueOf(methodParameters.mapOfExitingAccountCheck.get(methodParameters.brandName).BAT_OrderCompletedDate__c);
        }
        if (methodParameters.condition == 3){
            acc.GoVype_Last_Completed_Order_Date__c = null;
            acc.BAT_VapeConsumerSince__c = methodParameters.mapOfExistingAssetCheck.get(methodParameters.brandName).PurchaseDate;
        }
        if (methodParameters.condition == 4){
            acc.BAT_VapeConsumerSince__c = pickOlderDate(methodParameters.mapOfExistingAssetCheck.get(methodParameters.brandName).PurchaseDate, Date.valueOf(methodParameters.mapOfExitingAccountCheck.get(methodParameters.brandName).BAT_OrderCompletedDate__c));
        }
    }

    private static void veloBrandAccountUpdate(Parameters methodParameters, Account acc){
        if (methodParameters.condition == 1){
            acc.BAT_OralStatus__c = BAT_ConstantsUtility.PROSPECT;
            acc.BAT_EPOKLastCompletedOrderDate__c = null;
            acc.BAT_OralConsumerSince__c = null;
        }
        if (methodParameters.condition == 2){
            acc.BAT_OralConsumerSince__c = Date.valueOf(methodParameters.mapOfExitingAccountCheck.get(methodParameters.brandName).BAT_OrderCompletedDate__c);
        }
        if (methodParameters.condition == 3){
            acc.BAT_EPOKLastCompletedOrderDate__c = null;
            acc.BAT_OralConsumerSince__c = methodParameters.mapOfExistingAssetCheck.get(methodParameters.brandName).PurchaseDate;
        }
        if (methodParameters.condition == 4){
            acc.BAT_OralConsumerSince__c = pickOlderDate(methodParameters.mapOfExistingAssetCheck.get(methodParameters.brandName).PurchaseDate, Date.valueOf(methodParameters.mapOfExitingAccountCheck.get(methodParameters.brandName).BAT_OrderCompletedDate__c));
        }
    }

    private static void gloBrandAccountUpdate(Parameters methodParameters, Account acc){
        if (methodParameters.condition == 1 && acc != null){
            acc.BAT_THPStatus__c = BAT_ConstantsUtility.PROSPECT;
            acc.BAT_DE_GloLastCompletedOrderDate__c = null;
            acc.BAT_THPConsumerSince__c = null;
        }
        if (methodParameters.condition == 2 && acc != null){
            acc.BAT_THPConsumerSince__c = Date.valueOf(methodParameters.mapOfExitingAccountCheck.get(methodParameters.brandName).BAT_OrderCompletedDate__c);
        }
        if (methodParameters.condition == 3 && acc != null){
            acc.BAT_DE_GloLastCompletedOrderDate__c = null;
            acc.BAT_THPConsumerSince__c = methodParameters.mapOfExistingAssetCheck.get(methodParameters.brandName).PurchaseDate;
        }
        if (methodParameters.condition == 4 && acc != null){
            acc.BAT_THPConsumerSince__c = pickOlderDate(methodParameters.mapOfExistingAssetCheck.get(methodParameters.brandName).PurchaseDate, Date.valueOf(methodParameters.mapOfExitingAccountCheck.get(methodParameters.brandName).BAT_OrderCompletedDate__c));
        }
    }

    @TestVisible
    private static date pickOlderDate(Object compare1, Object compare2){
        Date firstDate1 = Date.valueOf(compare1);
        Date firstDate2 = Date.valueOf(compare2);
        if (firstDate1 > firstDate2){
            return firstDate2;
        }
        return firstDate1;
    }

    private static ReturnParameters checkExistingOrderStatus(Parameters methodParameters){
        ReturnParameters returnInfo = new ReturnParameters();
        Map<Id, Set<String>> orderIdWithBrand = new Map<Id, Set<String>>();
        returnInfo.orderIdWithAccountInfo = new Map<Id, Account>();
        List<OrderItem> listOfOrderItem = [SELECT Id, Order.Status, OrderId, Order.AccountId, Product2.Product_Brand__c, Order.BAT_OrderCompletedDate__c, Order.Account.Brand_House__c, Order.Account.Status__c, Order.Account.GoVype_Last_Completed_Order_Date__c
                                           FROM OrderItem
                                           WHERE Order.AccountId IN:methodParameters.accountIds AND Product2.Product_Brand__c IN:methodParameters.filterBrands AND Country__c IN:methodParameters.countryValues AND (Order.Status = :BAT_ConstantsUtility.COMPLETE_STR OR OrderId IN:methodParameters.currentOrderIds)
                                           ORDER BY Order.BAT_OrderCompletedDate__c
                                           LIMIT 10000];
        Set<String> brandWithAccountId = new Set<String>();
        String brandName;
        for (OrderItem each : listOfOrderItem){
            brandName = changeBrandValue(each.Product2.Product_Brand__c);
            if (methodParameters.filterBrands.contains(brandName) && methodParameters.currentOrderIds.contains(each.OrderId)){
                brandWithAccountId.add(brandName + ':' + each.Order.AccountId);
            }
            if (methodParameters.filterBrands.contains(brandName) && methodParameters.currentOrderIds.contains(each.OrderId) && !orderIdWithBrand.containskey(each.OrderId)){
                orderIdWithBrand.put(each.OrderId, (new Set<String>{ brandName }));
            }
            if (methodParameters.filterBrands.contains(brandName) && methodParameters.currentOrderIds.contains(each.OrderId) && orderIdWithBrand.containskey(each.OrderId)){
                orderIdWithBrand.get(each.OrderId).add(brandName);
            }
            if (methodParameters.currentOrderIds.contains(each.OrderId) && !returnInfo.orderIdWithAccountInfo.containsKey(each.OrderId)){
                returnInfo.orderIdWithAccountInfo.put(each.OrderId, (new Account(Id = each.Order.AccountId, Brand_House__c = each.Order.Account.Brand_House__c)));
            }
        }
        returnInfo.orderIdWithBrand = orderIdWithBrand;
        Map<String, Order> exitingOrderWithCompleteStatus = new Map<String, Order>();
        for (OrderItem each : listOfOrderItem){
            brandName = changeBrandValue(each.Product2.Product_Brand__c);
            String brandWithAccountIdCheck = brandName + ':' + each.Order.AccountId;
            if (!methodParameters.currentOrderIds.contains(each.OrderId) && brandWithAccountId.contains(brandWithAccountIdCheck) && each.Order.Status == BAT_ConstantsUtility.COMPLETE_STR && !exitingOrderWithCompleteStatus.containsKey(each.Product2.Product_Brand__c)){
                exitingOrderWithCompleteStatus.put(brandName, (new Order(BAT_OrderCompletedDate__c = each.Order.BAT_OrderCompletedDate__c)));
            }
        }
        returnInfo.mapOfExitingAccountCheck = exitingOrderWithCompleteStatus;
        return returnInfo;
    }

    private static String changeBrandValue(String val){
        if(val == BAT_ConstantsUtility.PRODUCT_BRAND_VYPE){
            return BAT_ConstantsUtility.PRODUCT_BRAND_VUSE;
        }
        return val;
    }
    private static ReturnParameters checkExistingAsset(Parameters methodParameters){
        ReturnParameters returnInfo = new ReturnParameters();
        Map<Id, List<Asset>> orderIdWithAssetInfo = new Map<Id, List<Asset>>();
        List<Asset> listOfAssetRecords = [SELECT Id, Status, BAT_RelatedOrder__c, AccountId,BAT_RelatedOrder__r.AccountId, BAT_Brand__c, PurchaseDate
                                          FROM Asset
                                          WHERE AccountId IN:methodParameters.accountIds AND Country__c IN:methodParameters.countryValues AND Status = :BAT_ConstantsUtility.ACTIVE_STR AND BAT_Brand__c IN:methodParameters.filterBrands
                                          ORDER BY PurchaseDate
                                          LIMIT 10000];
        Set<String> brandWithAccountId = new Set<String>();
        Map<Id, String> currentOrderWithBrandInfo = new Map<Id, String>();
        for (Asset each : listOfAssetRecords){
            if(each.BAT_Brand__c == BAT_ConstantsUtility.PRODUCT_BRAND_VYPE){
                each.BAT_Brand__c = BAT_ConstantsUtility.PRODUCT_BRAND_VUSE;
            }
            if (!methodParameters.currentOrderIds.contains(each.BAT_RelatedOrder__c)){
                brandWithAccountId.add(each.BAT_Brand__c + ':' + each.AccountId);
            }
            if(methodParameters.currentOrderIds.contains(each.BAT_RelatedOrder__c) && orderIdWithAssetInfo.containskey(each.BAT_RelatedOrder__c)){
                orderIdWithAssetInfo.get(each.BAT_RelatedOrder__c).add(new Asset(Id = each.Id));
            }
            if (methodParameters.currentOrderIds.contains(each.BAT_RelatedOrder__c) && !orderIdWithAssetInfo.containskey(each.BAT_RelatedOrder__c)){
                orderIdWithAssetInfo.put(each.BAT_RelatedOrder__c, (new List<Asset>{(new Asset(Id = each.Id))}));
            }
        }
        returnInfo.orderIdWithAssetInfo = orderIdWithAssetInfo;
        Map<String, Asset> exitingAssetWithActiveStatus = new Map<String, Asset>();
        for (Asset each : listOfAssetRecords){
            String brandWithAccountIdCheck = each.BAT_Brand__c + ':' + each.AccountId;
            if (!methodParameters.currentOrderIds.contains(each.BAT_RelatedOrder__c) && brandWithAccountId.contains(brandWithAccountIdCheck) && each.Status == BAT_ConstantsUtility.ACTIVE_STR && !exitingAssetWithActiveStatus.containsKey(each.BAT_Brand__c)){
                exitingAssetWithActiveStatus.put(each.BAT_Brand__c, each);
            }
        }
        returnInfo.mapOfExistingAssetCheck = exitingAssetWithActiveStatus;
        return returnInfo;
    }

    private class Parameters{
        Id currentOrderId;
        List<Account> accountRecordsUpdate;
        String brandName;
        List<Asset> assetRecordUpdate;
        Integer condition;
        Set<Id> accountIds;
        Set<Id> currentOrderIds;
        Set<String> filterBrands;
        Map<Id, Account> orderIdWithAccountInfo;
        Map<Id, List<Asset>> orderIdWithAssetInfo;
        Map<String, Order> mapOfExitingAccountCheck;
        Map<String, Asset> mapOfExistingAssetCheck;
        Set<Id> checkduplicateAccountId;
        Set<Id> checkduplicateAssetId;
        Order each;
        String eachBrand;
        ReturnParameters returncheckcheckExistingAssets;
        ReturnParameters returncheckExistingOrderStatus;
        Map<Id, Order> mapOfOrders;
        Set<String> countryValues;
    }

    private class ReturnParameters{
        Map<Id, List<Asset>> orderIdWithAssetInfo;
        Map<Id, Set<String>> orderIdWithBrand;
        Map<String, Order> mapOfExitingAccountCheck;
        Map<String, Asset> mapOfExistingAssetCheck;
        Map<Id, Account> orderIdWithAccountInfo;
    }

    /************************************************************************************************************************************
    *@author        :Deloitte  
    *@method        :getAccountBrandHouseAssignDetails
    *@returns       :List<BAT_AccountBrandHouseAssignment__mdt>
    *@description   :This method is used to get the records from BAT_AccountBrandHouseAssignment__mdt metadata
    *@changeHistory :19th December, 2022 / Rahul Upadhyay /Created the method
    ************************************************************************************************************************************/
    public static List<BAT_AccountBrandHouseAssignment__mdt> getAccountBrandHouseAssignDetails(String country, String accountSource, String lastModifiedSource){
        
        List<BAT_AccountBrandHouseAssignment__mdt> lstAccountBrandHouse = new List<BAT_AccountBrandHouseAssignment__mdt>();
        for(BAT_AccountBrandHouseAssignment__mdt rec : [SELECT 
                                                            MasterLabel,BAT_AccountSource__c,BAT_BrandAllowed__c,
                                                            BAT_Country__c, BAT_FieldAPIName__c, BAT_LastModifiedSource__c,BAT_CurrentBrandHouse__c
                                                        FROM 
                                                            BAT_AccountBrandHouseAssignment__mdt
                                                        WHERE 
                                                            BAT_Country__c = :country AND BAT_AccountSource__c = :accountSource AND BAT_LastModifiedSource__c = :lastModifiedSource]){
                lstAccountBrandHouse.add(rec);                                                      
            }
        return lstAccountBrandHouse;
    } 

    /************************************************************************************************************************************
    *@author        :Deloitte  
    *@method        :getLeadBrandHouseAssignDetails
    *@returns       :List<BAT_LeadBrandHouseAssignment__mdt>
    *@description   :This method is used to get the records from BAT_LeadBrandHouseAssignment__mdt metadata
    *@changeHistory :19th December, 2022 / Rahul Upadhyay /Created the method
    ************************************************************************************************************************************/
    public static List<BAT_LeadBrandHouseAssignment__mdt> getLeadBrandHouseAssignDetails(String country, String leadSource, String lastModifiedSource){
        
        List<BAT_LeadBrandHouseAssignment__mdt> lstLeadBrandHouse = new List<BAT_LeadBrandHouseAssignment__mdt>();
        for(BAT_LeadBrandHouseAssignment__mdt rec : [SELECT 
                                                            MasterLabel,BAT_LeadSource__c,BAT_BrandAllowed__c,
                                                            BAT_Country__c, BAT_FieldAPIName__c, BAT_LastModifiedSource__c,BAT_CurrentBrandHouse__c
                                                    FROM 
                                                        BAT_LeadBrandHouseAssignment__mdt
                                                    WHERE 
                                                            BAT_Country__c = :country AND BAT_LeadSource__c = :leadSource AND BAT_LastModifiedSource__c = :lastModifiedSource]){
                lstLeadBrandHouse.add(rec);                                                      
            }
        return lstLeadBrandHouse;
    }    
    /***********************************************************************************************************
    @ author:          Deloitte  
    @ method:          generateCSVBlob 
    @ returns:         BLob
    @ params:          String objectName,List<sObject> lstObjectRecords
    * @description:    This function generates the csv blob file based on the object and the list of records passed.
    * @changeHistory:  Mangesh - Added Header Comments
    * 06.02.2023/ Idrees Ali/ US#1285878: Data Archival Process - Discrepancy with regard to Field Values & Throttling mechanism Redesign
    *********************************************************************************************************/
    public static Blob generateCSVBlob(String objectName,List<sObject> lstObjectRecords){
        String finalCsv = BAT_ConstantsUtility.EMPTY_STRING;

        //Generating the header
        Map<String, Schema.SObjectType> global_describe = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> object_fields_map = global_describe.get(objectName).getDescribe().fields.getMap();
        Map<String,String> fieldApiToFieldType = new Map<String,String>();
        
        String strHeader = BAT_ConstantsUtility.EMPTY_STRING;
        for(String strFieldName:object_fields_map.keyset()){
            Schema.DisplayType fieldType = object_fields_map.get(strFieldName).getDescribe().getType();
            fieldApiToFieldType.put(strFieldName,String.valueOf(fieldType));
            /*Added below logic inorder to add Live chat transcript record's body to the last column as the field value was spreading 
             * to various field name columns in the backup file*/
            if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT) && strFieldName.equalsIgnoreCase(BAT_ConstantsUtility.BODY_STR)){
                continue;
            }
            strHeader += strFieldName.capitalize() + BAT_ConstantsUtility.COMMA_STR;
        }
        if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT)){
            strHeader += BAT_ConstantsUtility.BODY_STR;
        }
        strHeader.removeEnd(BAT_ConstantsUtility.COMMA_STR);
        strHeader += BAT_ConstantsUtility.ATH_NextLine;
        
        finalCsv += strHeader;
        
        //Generating Csv string;
        //Adding records to the csv
        for(sObject sObj:lstObjectRecords){
            for(String strFieldName:object_fields_map.keyset()){
                if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT) && strFieldName.equalsIgnoreCase(BAT_ConstantsUtility.BODY_STR)){
                    continue;
                }
                //strCsvRecords += String.valueOf(sObj.getSObject(objectName).get(strFieldName));
                String strFieldValue=null;
                try{
                    strFieldValue = getFieldValue(strFieldName,sObj,fieldApiToFieldType);
                }catch(Exception e){}
                if(strFieldValue!=null){
                    finalCsv += strFieldValue;
                }
                
                finalCsv += BAT_ConstantsUtility.COMMA_STR;
            }
            /*Added below logic inorder to add Live chat transcript record's body to the last column as the field value was spreading 
             * to various field name columns in the backup file*/
            if(objectName.equalsIgnoreCase(BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT)){
                String strFieldValue = getFieldValue(BAT_ConstantsUtility.BODY_STR,sObj,fieldApiToFieldType);
                if(strFieldValue!=null){
                    finalCsv += strFieldValue;
                }
            }
            finalCsv.removeEnd(BAT_ConstantsUtility.COMMA_STR);
            finalCsv += BAT_ConstantsUtility.ATH_NextLine;   
        }
        
        //Generating blob 
        Blob finalBlob = Blob.valueOf(finalCsv);
        
        return finalBlob;
    }  
    
    /***********************************************************************************************************
    @ author:          Deloitte  
    @ method:          getFieldValue 
    @ returns:         String
    @ params:          String fieldAPIName,sObject sObj
    * @description:    This function gets the value of the field based on the api name, if fild not accessible, returns null
    * @changeHistory:  Mangesh - Added Header Comments
    * 06.02.2023/ Idrees Ali/ US#1285878: Data Archival Process - Discrepancy with regard to Field Values & Throttling mechanism Redesign
    *********************************************************************************************************/
    private static String getFieldValue(String fieldAPIName,sObject sObj,Map<String,String> fieldApiToFieldType){
        String fieldType = BAT_ConstantsUtility.BLANK_STR;
        if(!fieldApiToFieldType.isEmpty() && fieldApiToFieldType.containsKey(fieldAPIName)){
            fieldType = fieldApiToFieldType.get(fieldAPIName);
        }
        if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.STRING_STR)){
            return String.valueOf(sObj.get(fieldAPIName));
        }
        else if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.BOOLEAN_TYPE)){
            Boolean fieldValue = Boolean.valueOf(sObj.get(fieldAPIName));
            if(fieldValue == true)
                return BAT_ConstantsUtility.TRUE_STRING;
            else
                return BAT_ConstantsUtility.FALSE_STRING;    
        }
        else if( fieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATETIME_STR)){
             if(sObj.get(fieldAPIName) != null){
                DateTime dateValue = DateTime.valueOf(sObj.get(fieldAPIName));
                String formattedDate = dateValue.format(BAT_ConstantsUtility.FORMAT_DATETIME_STR);
                return formattedDate.deleteWhitespace();
            }
            else {
                return BAT_ConstantsUtility.BLANK_STR;
            }
        }
        else if(fieldType.equalsIgnoreCase(BAT_ConstantsUtility.DATE_STR)){
             if(sObj.get(fieldAPIName) != null){
                Date dateValue = Date.valueOf(sObj.get(fieldAPIName));
                return String.valueOf(dateValue).deleteWhitespace();
            }
            else{
                return BAT_ConstantsUtility.BLANK_STR;
            }
        }
        else{
            try {
                return String.valueOf(sObj.get(fieldAPIName));
            } catch  (Exception ex) {
                return null;
            }
        }      
    }
    
    /****************************************************************************************************
  * @author        : Deloitte
  * @Class Name    : createDynamicQueries
  * @description   : creates dynamic queries for sObjects
  * @changeHistory : 18.01.2023/Swaraj Ray/ #1142557 - ZA - Data Archival Process
  *********************************************************************************************************/
    public static String createDynamicQueries(String objectName){
        string query = BAT_ConstantsUtility.SELECTSTRING;
        string fieldsToQueryString = '';
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
        query += fieldsToQueryString + BAT_ConstantsUtility.ASSET_SYNC_BATCH_SOQLFROM + objectName  + BAT_ConstantsUtility.WHERE_STR;
        return query;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getNewsLetterSubscriberLeadRecordTypeId
    * @returns       : Id
    * @params        : None
    * @description   : ENH: Sprint 124 : US: #1217511 Method to fetch "Newsletter Subscriber" lead Record Type Id
    * @changeHistory : 22.02.2023 / Rahul Upadhyay / created method
    *********************************************************************************************************/
    public static Id getNewsLetterSubscriberLeadRecordTypeId(){
        if(NewLeadRecordTypeId == null){
            NewLeadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.NEWSLETTER_SUBSCRIBER).getRecordTypeId();
        }
        return NewLeadRecordTypeId;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : getQueueConfigsLiveChat
    * @returns       : Map<String,QueueSObject>
    * @params        : String setQueueNames
    * @description   : [All Markets] method to get queue configs
    * @changeHistory : 03.07.2023/Rahul Upadhyay/ENH: Sprint-125: US #1188291: Created the method
    *********************************************************************************************************/
    public static Map<String,QueueSObject> getQueueConfigsLiveChat(String setQueueNames){
        //Map of Queue Name verses the Queue config
        Map<String,QueueSObject> mapQueueNametoQueue = new Map<String,QueueSObject>();
        List<QueueSObject> listQueues = [Select id,QueueId,queue.Name from QueueSobject where (SobjectType = :BAT_ConstantsUtility.LIVECHATTRANSCRIPTOBJECT OR SobjectType = :BAT_ConstantsUtility.CASE_STR) and queue.Name = :setQueueNames];
        if(listQueues <> null && !listQueues.isEmpty()){
            //Setting up queue config - Start
            for(QueueSObject queueRecord : listQueues){
                mapQueueNametoQueue.put(queueRecord.queue.Name,queueRecord);
            }//Loop - End
        }
        
        return mapQueueNametoQueue;
    }
    
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : intiateReverseApiFromBatchV2
    * @returns       : void
    * @params        : BAT_IntegrationUtilityV2.RequestInfo requestInfo
    * @description   : [All Markets] method to make synchronous http callout when source is a batch
    * @changeHistory : 15.03.2023/Idrees Ali/ENH: Sprint-125: US #1317478: Created the method
    *********************************************************************************************************/
    public static void intiateReverseApiFromBatchV2(BAT_IntegrationUtilityV2.RequestInfo requestInfo){
        String url = BAT_CalloutHandler.urlConcatenateWithParams(requestInfo.endPoint, requestInfo.params);
        BAT_CalloutHandler.RequestInfo reqinfo = new BAT_CalloutHandler.RequestInfo();
        reqinfo.endPoint = url;
        reqinfo.body = requestInfo.body;
        reqinfo.method = requestInfo.method;
        reqinfo.header = requestInfo.header;
        BAT_CalloutHandler calloutHelper = new BAT_CalloutHandler(reqinfo);
        HttpResponse response = calloutHelper.httpCallOut();
        
        BAT_Integration_Log_DE__c integrationLog = new BAT_Integration_Log_DE__c();
        integrationLog.Object_Type__c = requestInfo.objectName;
        integrationLog.Request_Details__c = requestInfo.body;
        integrationLog.BAT_Country__c = requestInfo.country;
        if (requestInfo.header != null){
            integrationLog.BAT_RequestHeader__c = JSON.serialize(requestInfo.header);
        }
        integrationLog.BAT_RequestURL__c = url;
        integrationLog.BAT_Attempts__c = 0;
        integrationLog.BAT_RecordId__c = requestInfo.recordId;
        integrationLog.BAT_Version__c = BAT_ConstantsUtility.NUMERIC_VALUE_2_STR;
        integrationLog.BAT_ApigeeAPIDeveloperName__c = requestInfo.apigeeMetadataRecordDevelopName;
        integrationLog.BAT_RequestMethod__c = requestInfo.method;
        integrationLog.Response_Details__c = String.isNotBlank(url)  && response != null ? BAT_ConstantsUtility.AUTH_CODE_PARAM + BAT_ConstantsUtility.SINGLE_SPACE + BAT_ConstantsUtility.STR_CHAR_HYPHEN + response.getStatusCode() + BAT_ConstantsUtility.BAT_SEMICOLON_STR + response.getBody() : BAT_ConstantsUtility.EXTERNALID_ERROR;
        integrationLog.Response_Details__c = integrationLog.Response_Details__c.deleteWhitespace();
        integrationLog.Status__c = response != null && requestInfo.successResponseCodes.contains(String.valueOf(response.getStatusCode())) ? BAT_ConstantsUtility.COMPLETED : BAT_ConstantsUtility.SMS_FAILED;
        if(Schema.sObjectType.BAT_Integration_Log_DE__c.Fields.Object_Type__c.isCreateable()){
            batchContextIntegrationLogList.add(integrationLog);
        }
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name   : REWCodeWrapper
    * @description   : [UCCAB] Class to get the mandatory check list for REWCodeWrapper
    * @changeHistory : 24.03.2023/Idrees Ali/ENH: Sprint-126:  [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
    *********************************************************************************************************/
    public class REWCodeWrapper{
        public Map<String,BAT_DefaultRewProfilePointsConfiguration__mdt> defaultrewProfilePointsConfigMap = new Map<String, BAT_DefaultRewProfilePointsConfiguration__mdt>();
        public Map<string,string> rewProfileOwnerConfigMap = new Map<string,string>();     
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : fetchREWCodeCofiguration
    * @returns       : REWCodeWrapper
    * @params        : none
    * @description   : method to fetch metadata config related to reward profile generation for UCCAB
    * @changeHistory : 24.03.2023/Idrees Ali/ENH: Sprint-126:  [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
                       17.04.2023/Saurabh Sharma/ Bug #1356909, removed BAT_IsLogicToWorkOnInsert__c check for UA bug fix.                  
    *********************************************************************************************************/
    public static REWCodeWrapper fetchREWCodeCofiguration(){
        
        REWCodeWrapper rewCodeWrapObj = new REWCodeWrapper();
        //retrieve the rewardProfile Owner Configuration records based on country
        for(BAT_RewardProfileOwnerConfiguration__mdt rec: BAT_RewardProfileOwnerConfiguration__mdt.getAll().values() ){
                                                              rewCodeWrapObj.rewProfileOwnerConfigMap.put(rec.BAT_Country__c, rec.BAT_OwnerUserName__c);
                                                          }
        //retrieve the default rewardProfile points Configuration records based on country
        for(BAT_DefaultRewProfilePointsConfiguration__mdt rec: BAT_DefaultRewProfilePointsConfiguration__mdt.getAll().values() ){
                                                                   rewCodeWrapObj.defaultRewProfilePointsConfigMap.put(rec.DeveloperName, rec);
                                                               }
        return rewCodeWrapObj;
    }
    /********************************************************************************************************
    * @author        : Deloitte
    * @method Name   : createRewardProfileRecordForUCCAB
    * @returns       : BAT_Reward_Profile__c
    * @params        : Account currentRecord, Map<String,BAT_DefaultRewProfilePointsConfiguration__mdt> defaultRewProfilePointsConfigMap,
    *                  Map<String,Id> userNameMap, Map<string,string> rewProfileOwnerToUsernameConfigMap
    * @description   : [UCCAB] method to generate a reward profile record for countries enabled via BAT_DefaultRewProfilePointsConfiguration__mdt
    * @changeHistory : 24.03.2023/Idrees Ali/ENH: Sprint-126:  [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
                       28.04.2023/Saurabh Sharma/ Added Safe navigation operator to prevent null pointer issue
    *********************************************************************************************************/
    public static BAT_Reward_Profile__c createRewardProfileRecordForUCCAB(Account currentRecord, Map<String,BAT_DefaultRewProfilePointsConfiguration__mdt> defaultRewProfilePointsConfigMap,Map<String,Id> userNameMap, Map<string,string> rewProfileOwnerToUsernameConfigMap){
        BAT_Reward_Profile__c rewProfile = new BAT_Reward_Profile__c();
        String rewareProfileRecordTypeId = Schema.SObjectType.BAT_Reward_Profile__c.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.REWARDPROFILE_TYPE_CONSUMER).getRecordTypeId();
        rewProfile.Name = currentRecord.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + currentRecord.LastName;
        rewProfile.recordtypeId = rewareProfileRecordTypeId;
        
        rewProfile.BAT_ConsumerIdentifier__c = currentRecord.Id;
        //validate the points record exist based on country in DefaultrewProfilePointsConfiguration custom metatdata type
        if(!defaultRewProfilePointsConfigMap.isEmpty() &&
           defaultRewProfilePointsConfigMap.containsKey(currentRecord.country__c)){
               rewProfile.Total_Points__c = defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_TotalPoints__c;
               rewProfile.Pending_Points__c = defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_PendingPoints__c;
               rewProfile.Redeem_Points__c = defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_RedeemPoints__c;
               // start as apart of 10254
               if(String.isNotBlank(defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_MGMCodeAPIName__c) && !defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_IsRandomMGMCodeToBeGenerated__c){
                   SObjectField fieldApiName = getSobjectFieldApiName(BAT_ConstantsUtility.ACCOUNT, defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_MGMCodeAPIName__c);
                   if(fieldApiName != null){
                       rewProfile.Member_get_Member_Code__c = String.valueOf(currentRecord.get(fieldApiName))?.remove(BAT_ConstantsUtility.PLUS_SIGN); //Added Safe nav operator
                   }
               }
               else if(defaultRewProfilePointsConfigMap.get(currentRecord.country__c).BAT_IsRandomMGMCodeToBeGenerated__c){
                   rewProfile.Member_get_Member_Code__c = !String.isBlank(currentRecord.Member_get_Member_Code__c) ? currentRecord.Member_get_Member_Code__c : BAT_ConstantsUtility.BLANK_STR;
               }
               // end 10254
           }
        rewProfile.Profile__c = BAT_ConstantsUtility.ATH_CONSUMER;
        rewProfile.Email__c = currentRecord.PersonEmail;
        rewProfile.Phone__c = currentRecord.PersonMobilePhone;
        rewProfile.Country__c = currentRecord.Country__c;
        rewProfile.MgM_Counter__c = BAT_ConstantsUtility.ZERO;
        //Validate the account owner is of profile "BAT Social Seller Lover UA" or "BAT Team Leader UA"
        if(currentRecord.Owner_Profile__c == BAT_ConstantsUtility.PROFILE_TEAM_LEADER_UA ||
           currentRecord.Owner_Profile__c == BAT_ConstantsUtility.PROFILE_SS_LOVER_UA){
               rewProfile.Associated_Social_Seller_User__c = currentRecord.OwnerId;
           }
        //Validate the country record exist in RewardProfile Owner Configuration Metatdata
        if(!userNameMap.isEmpty() && userNameMap.containsKey(rewProfileOwnerToUsernameConfigMap.get(currentRecord.Country__c))){
            rewProfile.OwnerId = userNameMap.get(rewProfileOwnerToUsernameConfigMap.get(currentRecord.Country__c));
        }
        return rewProfile;
    }

    /********************************************************************************************************
    * @author        : Deloitte
    * @Class Name   : privacySnapshotDeletionWrapper
    * @description   : [SE] Class to get the mandatory check list for privacySnapshotDeletionWrapper
    * @changeHistory : 08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account
    *********************************************************************************************************/
    public class privacySnapshotDeletionWrapper{
        public Boolean bypassSnapshotCriteria = true ;
        public List<id> privacySnapshotDeletionParentIds = new List<id>();
    }
    
    /************************************************************************************************************************************
    *@ author:         Deloitte  
    *@ method:         checkCriteriaforSnapshotDeletion
    *@ returns:        privacySnapshotDeletionWrapper
    *@ params:         Account accountRec
    *@description:     This method is to return wrapper to differentiate condition for SE and non-SE markets
    *@changeHistory:   08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account
    ************************************************************************************************************************************/                   
    public Static privacySnapshotDeletionWrapper checkCriteriaforSnapshotDeletion(Account accountRec){
        snapshotWrapper.bypassSnapshotCriteria = (accountRec.Country__c == BAT_ConstantsUtility.COUNTRY_SE ||accountRec.Country__c == BAT_ConstantsUtility.DK_STR) ? false : true;
        if(!snapshotWrapper.bypassSnapshotCriteria && accountRec.PersonHasOptedOutOfEmail == true && accountRec.BAT_IsLyftOptInEmailCommunication__c == false 
           && ((accountRec.BAT_ConsentDate__c == null && accountRec.BAT_AMPLastConsentDate__c==null) || accountRec.BAT_ConsentDate__c <= accountRec.CreatedDate ||accountRec.BAT_AMPLastConsentDate__c<= accountRec.CreatedDate)
           && (accountRec.BAT_LyftLastConsentOptInDate__c == null || accountRec.BAT_LyftLastConsentOptInDate__c <= accountRec.CreatedDate) ){
               snapshotWrapper.privacySnapshotDeletionParentIds.add(accountRec.id);
               if(accountRec.Related_Lead__c != null){
                   snapshotWrapper.privacySnapshotDeletionParentIds.add(accountRec.Related_Lead__c);
               }
           }
        return snapshotWrapper;
    } 
    
    //CZ Loyalty 
    public static void callReverseAPI(String eventString, String objectName, String countryApiName, list<Account> newAccountlist, String brandHouse, String oldAccountId){
        //set of country to check reverse API is enable for country
        Set<String> countryEnabledSet = new Set<String>();
        //List to save the list of eligible record 
        List<sObject> listOfEligibleRecords = new List<sObject>();
        // Sameer Ranjan || US #1154667 for version 2 reverse integration 
        List<sObject> listOfEligibleRecordsV2 = new List<sObject>();
        //get the enabled country from metadata
        countryEnabledSet = BAT_ReverseAPIUtility.checkCountryEnabled();
        //US#530277 : Stop Outbound call for Retailer record Type
        ID retailerRecordTypeId = getRetailerRecordTypeId();
        
        for(sObject eachRecord : newAccountlist){
            if(!objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) || (objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) && eachRecord.get('RecordTypeId') != retailerRecordTypeId)){
            String country = (String)eachRecord.get(countryApiName);
            //this if will check the criteria and mapping records are present for that country or not also this country is enabled for reverse API or not
                if(!countryEnabledSet.isEmpty() && countryEnabledSet.contains(country))
                {
                    listOfEligibleRecords.add(eachRecord);
                }
                // Sameer Ranjan || US #1154667 for version 2 reverse integration 
                if(!countryEnabledSet.isEmpty() && countryEnabledSet.contains(country + BAT_ConstantsUtility.COUNTRY_SUFFIX)){
                    listOfEligibleRecordsV2.add(eachRecord);
                }
            }
        }
        //If the list is not empty, reverse integration is executed and CallReverseAPI is called
        if(!listOfEligibleRecords.isEmpty()){
            //integer variable created to remove the non multibrand markets
            Integer i =0;
            //map to store brand name as key and account as value
            Map<string,Sobject> brandAccountMap = new  Map<string,Sobject>();
            //Cloning the existing variable as we can not use the same variable for remove method
            List<sobject> listOfEligibleRecordsClone = new  List<sobject>();
            listOfEligibleRecordsClone.addAll(listOfEligibleRecords);
            //Get the spilt brand country names from metadata
            Set<String> splitBrandCountries = new Set<String>();
            if(eventString.equalsIgnoreCase(BAT_ConstantsUtility.EVENT_DELETE)){
                // Sameer Ranjan -> US #1154667 - Added filter criteria to make sure not retrieve version 2 records 
                for(BAT_ReverseAPIJsonMapping__mdt rec : [select BAT_Country__c from BAT_ReverseAPIJsonMapping__mdt where BAT_EventType__c =: eventString AND BAT_ObjectName__c =:objectName AND BAT_IsSplitBrandHouse__c=true AND BAT_EnableCountryForReverseAPI__c = null]){
                    splitBrandCountries.add(rec.BAT_Country__c);
                }
            }
            for(Sobject obj: listOfEligibleRecordsClone){
                String country = (String)obj.get(countryApiName);
                if(splitBrandCountries.contains(country) && eventString.equalsIgnoreCase(BAT_ConstantsUtility.EVENT_DELETE)&& (objectName.equalsIgnoreCase(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR) && obj.get('RecordTypeId') != retailerRecordTypeId)){
                     String accountBrandsString = (String)obj.get(BAT_ConstantsUtility.FIELD_LEGACYBRANDHOUSE);
                    if(accountBrandsString.contains(BAT_ConstantsUtility.SEMI_COLON)){
                        // multibrand accounts will be removed
                        listOfEligibleRecords.remove(i);
                        String objId = (String)obj.get(BAT_ConstantsUtility.BAT_ID);
                        for(String accBrand: accountBrandsString.split(BAT_ConstantsUtility.SEMI_COLON)){
                            //objId is also added as key if there are multiple records for same country
                            brandAccountMap.put(accBrand+BAT_ConstantsUtility.UNDERSCORE+objId,obj);
                        }
                    }
                }
                i++;
            }
            
            for(String brand: brandAccountMap.keySet()){
                list<Sobject> eligibleRecordList = new List<Sobject>();
                Sobject tempAccount = brandAccountMap.get(brand);
                tempAccount.put(BAT_ConstantsUtility.FIELD_LEGACYBRANDHOUSE,brand.split(BAT_ConstantsUtility.UNDERSCORE)[0]);
                eligibleRecordList.add(tempAccount);
                
                //setting below variable to false for allowing multiple calls on same records
                BAT_ReverseAPIUtility.skipAPICallRun = false;
                BAT_ReverseAPICallHandler apiHandlerInstance = new BAT_ReverseAPICallHandler();
                apiHandlerInstance.CallReverseAPI(eventString, objectName, countryApiName,eligibleRecordList, null);
            }
            //other markets without multibrand split logic 
            if(!listOfEligibleRecords.isEmpty()){
                BAT_ReverseAPICallHandler apiHandler = new BAT_ReverseAPICallHandler();
                apiHandler.CallReverseAPI(eventString, objectName, countryApiName, listOfEligibleRecords, null);
            }
        }
        // Sameer Ranjan || US #1154667 for version 2 reverse integration 
        if(!listOfEligibleRecordsV2.isEmpty()){
            BAT_ReverseAPICallHandlerV2.MethodParameters apiHandlerMethodParameters = new BAT_ReverseAPICallHandlerV2.MethodParameters(); 
            apiHandlerMethodParameters.eventType = eventString;
            apiHandlerMethodParameters.objectName = objectName;
            apiHandlerMethodParameters.countryAPI = countryApiName;
            apiHandlerMethodParameters.listOfEligibleRecords = listOfEligibleRecordsV2;
            apiHandlerMethodParameters.oldMap = Trigger.oldMap;
            BAT_ReverseAPICallHandlerV2 apiHandler = new BAT_ReverseAPICallHandlerV2(); 
            apiHandler.CallReverseAPI(apiHandlerMethodParameters);
        }
    }
        /************************************************************************************************************************************
    *@ author:         ITC  
    *@ method:         checkDuplicateAssetSinglePayload
    *@ returns:        void
    *@ params:         Asset[] newAssets
    *@description:     This method checks if duplicate assets are being sent in a single payload.
    *@changeHistory:   5.12.2023/Chirag Kalra/ US#1575248:UA - Prohibit creation devices with same number in one payload (SP145)
    ************************************************************************************************************************************/       

    public static void checkDuplicateAssetSinglePayload(Asset[] newAssets) {
        Set<String> uniqueNames = new Set<String>();
       // Set<String> duplicateNames = new Set<String>();

        for (Asset assetRecord : newAssets) {
            if (uniqueNames.contains(assetRecord.Name)) {
                
                 assetRecord.addError(system.label.BAT_AssetRegistrationDuplicateSamePayload);
            } else {
                uniqueNames.add(assetRecord.Name);
            }
            
        }

      
    }
    @InvocableMethod(label='Retrieve Campaigns by IDs' description='Returns the campaigns based on the provided IDs')
    public static List<Campaign> retrieveCampaignsByIds(List<List<Id>> campaignIds) {
        // Query campaigns based on the provided IDs
       // List<Campaign> campaigns = [SELECT Id, Name, StartDate FROM Campaign WHERE Id IN :campaignIds];
        
      //  return campaigns;
        return null;
    }
     
    /************************************************************************************************************************************
    *@ author:         ITC  
    *@ method:         updateContactPointTypeConsent
    *@ returns:        void
    *@ params:         newMap,objectName
    *@description:     This method is updating the ContactPointTypeConsent records under Lead and Account
    *@changeHistory:   28.02.2024/Varaprasad Sada/US#1637513-RS HR SI - Multicategory consents update + profiling consent (CRM Only)
    ************************************************************************************************************************************/       

    Public static void updateContactPointTypeConsent(Map<ID, Sobject> newMap,String objectName){
        List < ContactPointTypeConsent > listConPointConsent = new List< ContactPointTypeConsent >();
        if(objectName==BAT_ConstantsUtility.LEAD_STR){
            Map<Id,Lead>newLeadMap =new map<Id,Lead>([SELECT ID,Generic_Permission__c FROM LEAD WHERE ID IN :newMap.keySet()]);
            listConPointConsent=[SELECT Id, Name,BAT_Country__c, BAT_Channel__c, BusinessBrandId,BusinessBrand.Name, BAT_Account__c,BAT_Lead__c, PrivacyConsentStatus FROM ContactPointTypeConsent WHERE BAT_Lead__c IN: newLeadMap.keySet()];
            if(listConPointConsent.size()>0){
                for(ContactPointTypeConsent cp : listConPointConsent){
                    cp.PrivacyConsentStatus=newLeadMap.get(cp.BAT_Lead__c).Generic_Permission__c? System.label.BAT_OptIn:System.label.BAT_OptOut;
                }
            }
        }
        else if(objectName==BAT_ConstantsUtility.STANDARD_ACCOUNT_STR){
            Map<Id,Account>newAccountMap =new map<Id,Account>([SELECT ID,Generic_Permission__c FROM Account WHERE ID IN :newMap.keySet()]);
            
            listConPointConsent=[SELECT Id, Name,BAT_Country__c, BAT_Channel__c, BusinessBrandId,BusinessBrand.Name, BAT_Account__c,BAT_Lead__c, PrivacyConsentStatus FROM ContactPointTypeConsent WHERE BAT_Account__c IN: newAccountMap.keySet()];
            if(listConPointConsent.size()>0){
                for(ContactPointTypeConsent cp : listConPointConsent){
                    cp.PrivacyConsentStatus=newAccountMap.get(cp.BAT_Account__c).Generic_Permission__c? System.label.BAT_OptIn:System.label.BAT_OptOut;
                }
            }
            
        }
        update listConPointConsent;
        BAT_ReverseAPIUtility.skipAPICallRun=true;
    }
    
    /************************************************************************************************************************************
    *@ author:         ITC  
    *@ method:         getAccountFromBrandProfile
    *@ returns:        Map<Account,List<BAT_BrandProfile__c>>
    *@ params:         Set<id> accountIdSet, BAT_BrandProfile__c[] updatedBrandProfile
    *@description:     This method is returning accounts on the basis of Brand Profiles
    *@changeHistory:   15.03.2024/Chirag Kalra/US#1646801-RO - Consumer status & Brand House update scenarios
    ************************************************************************************************************************************/ 
    
    //Modified by-Mohan Banoth-23.01.2025
    /*Added BAT_OralStatus__c field in below query*/
    
     public static Map<Account,List<BAT_BrandProfile__c>> getAccountFromBrandProfile(Set<id> accountIdSet, BAT_BrandProfile__c[] updatedBrandProfile){
        Map<Account,List<BAT_BrandProfile__c>> mapAccountListOfBrandProfile =  new Map<Account,List<BAT_BrandProfile__c>>();
        List<Account> listAccounts = new List<Account>();
        if(accountIdSet != null){
             listAccounts = [SELECT id,Brand_House__c,BAT_THPStatus__c, BAT_CombustibleStatus__c, BAT_VapeStatus__c, BAT_OralStatus__c from Account where id in :accountIdSet];
        }
        if(updatedBrandProfile!=null){
            for( BAT_BrandProfile__c brandProfileRecord : updatedBrandProfile){
                for(Account accountRecord: listAccounts){
                    if(brandProfileRecord.BAT_Account__c == accountRecord.Id){
                        if(!mapAccountListOfBrandProfile.containsKey(accountRecord)){
                           mapAccountListOfBrandProfile.put(accountRecord,new List<BAT_BrandProfile__c>());
                            
                        }
                        mapAccountListOfBrandProfile.get(accountRecord).add(brandProfileRecord);
                        break;
                            
                    }
                }
                
            }
        }
        
        return mapAccountListOfBrandProfile;
    }
     /************************************************************************************************************************************
    *@ author:         ITC  
    *@ method:         FMCSourcesCheck
    *@ returns:        Boolean
    *@ params:         oldmapbrandhouse,newmapbrandhouses
    *@description:     This method is returning true or false if the brand house have the any value Glo,FMC,Velo
    *@changeHistory:   02/04/2023/Varaprasad sada/US:1652524- UA FMC Account Creation and Updation from CRM to Shopify (Glo, Velo, OGO)
    ************************************************************************************************************************************/  

 /*   Public static Boolean FMCSourcesCheck(String oldBrandHouse,String newBrandHouse){
        List<String>lstOldBrandHouse=oldBrandHouse.split(';');
        List<String>lstNewBrandHouse=newBrandHouse.split(';');
        system.debug('==lstOldBrandHouse=='+lstOldBrandHouse);
         system.debug('==lstNewBrandHouse=='+lstNewBrandHouse);
        for(string s :BAT_ConstantsUtility.FMC_Sources){
             system.debug('==!lstOldBrandHose.contains(s)=='+!lstOldBrandHouse.contains(s));
         system.debug('==lstNewBrandHose.contains(s)=='+lstNewBrandHouse.contains(s));
            if(!lstOldBrandHouse.contains(s)&&lstNewBrandHouse.contains(s)){
            return true;
            }
        }
        return false;
    }*/
    
  /*  public static Map<BAT_BrandProfile__c,Account> getAccountFromBrandProfile(Set<id> accountIdSet, BAT_BrandProfile__c[] updatedBrandProfile){
        Map<BAT_BrandProfile__c, Account> mapBrandProfileIdAccount = new Map<BAT_BrandProfile__c,Account>();
        List<Account> listAccounts = new List<Account>();
        if(accountIdSet != null){
             listAccounts = [SELECT id,Brand_House__c,BAT_THPStatus__c, BAT_CombustibleStatus__c, BAT_VapeStatus__c from Account where id in :accountIdSet];
        }
        if(updatedBrandProfile!=null){
            for( BAT_BrandProfile__c brandProfileRecord : updatedBrandProfile){
                for(Account accountRecord: listAccounts){
                    if(brandProfileRecord.BAT_Account__c == accountRecord.Id){
                        mapBrandProfileIdAccount.put(brandProfileRecord,accountRecord);
                        break;
                    }
                }
                
            }
        }
        
        return mapBrandProfileIdAccount;
    }*/
     /************************************************************************************************************************************
    *@ author:         ITC  
    *@ method:         getBundleLogoMap
    *@ returns:        Map<string,BAT_BundleLogoPaths__c>
    *@ params:         userCountry
    *@description:     This method is returning map of Bundle Logo paths from custom setting
    *@changeHistory:   02/04/2023/Varaprasad sada/US:1652524- UA FMC Account Creation and Updation from CRM to Shopify (Glo, Velo, OGO)
    ************************************************************************************************************************************/  
     Public static Map<string,BAT_BundleLogoPaths__c> getBundleLogoMap(String userCountry){
         Map<string,BAT_BundleLogoPaths__c> logoMap = new Map<string,BAT_BundleLogoPaths__c>();
         for(BAT_BundleLogoPaths__c logoRecord: [SELECT id,BAT_BundleBrand__c ,BAT_Country__c,BAT_ImagePath__c from BAT_BundleLogoPaths__c where BAT_Country__c =:userCountry ]){
             if(!logoMap.containsKey(logoRecord.BAT_BundleBrand__c)){
                 logoMap.put(logoRecord.BAT_BundleBrand__c,logoRecord);
             }
         }
         if(logoMap !=null && !logoMap.isEmpty()){
             return logoMap;
         }
         return null;
     }
    
    //Chirag start
    public class MyPickListInfo
   {
        public String validFor;
   }

public static Map<String, List<String>> getFieldDependencies(String objectName, String controllingField, String dependentField)
{
    Map<String, List<String>> controllingInfo = new Map<String, List<String>>();

    Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);

    Schema.DescribeSObjectResult describeResult = objType.getDescribe();
    Schema.DescribeFieldResult controllingFieldInfo = describeResult.fields.getMap().get(controllingField).getDescribe();
    Schema.DescribeFieldResult dependentFieldInfo = describeResult.fields.getMap().get(dependentField).getDescribe();

    List<Schema.PicklistEntry> controllingValues = controllingFieldInfo.getPicklistValues();
    List<Schema.PicklistEntry> dependentValues = dependentFieldInfo.getPicklistValues();

    for(Schema.PicklistEntry currControllingValue : controllingValues)
    {
        System.debug('ControllingField: Label:' + currControllingValue.getLabel());
        controllingInfo.put(currControllingValue.getLabel(), new List<String>());
    }

    for(Schema.PicklistEntry currDependentValue : dependentValues)
    {
        String jsonString = JSON.serialize(currDependentValue);

        MyPickListInfo info = (MyPickListInfo) JSON.deserialize(jsonString, MyPickListInfo.class);

        String hexString = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();

        System.debug('DependentField: Label:' + currDependentValue.getLabel() + ' ValidForInHex:' + hexString + ' JsonString:' + jsonString);

        Integer baseCount = 0;

        for(Integer curr : hexString.getChars())
        {
            Integer val = 0;

            if(curr >= 65)
            {
                val = curr - 65 + 10;
            }
            else
            {
                val = curr - 48;
            }

            if((val & 8) == 8)
            {
                System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 0].getLabel());
                controllingInfo.get(controllingValues[baseCount + 0].getLabel()).add(currDependentValue.getLabel());
            }
            if((val & 4) == 4)
            {
                System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 1].getLabel());
                controllingInfo.get(controllingValues[baseCount + 1].getLabel()).add(currDependentValue.getLabel());                    
            }
            if((val & 2) == 2)
            {
                System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 2].getLabel());
                controllingInfo.get(controllingValues[baseCount + 2].getLabel()).add(currDependentValue.getLabel());                    
            }
            if((val & 1) == 1)
            {
                System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 3].getLabel());
                controllingInfo.get(controllingValues[baseCount + 3].getLabel()).add(currDependentValue.getLabel());                    
            }

            baseCount += 4;
        }            
    } 

    System.debug('ControllingInfo: ' + controllingInfo);

    return controllingInfo;
}
    
   //chirag End
   //09.July.2024/varaprasad sada / US#1771605-SE - Salesforce Data Retention Policy - Account (part2)
    Public static Boolean isNoOrders(Id accId){
        List<Order>lstord=new List<Order>();
        lstord=[Select Id from order where AccountId=:accId];
        if(lstord.size()==0){
           return true; 
        }
        return false;
        
    }
    //31.July.2024/varaprasad sada / US#1771605-SE - Salesforce Data Retention Policy - Account (part2)
    Public static Boolean isRecentOrder(Id orderId,Id accId){
        List<Order>lstord=new List<Order>();
        lstord=[Select Id from order where AccountId=:accId ORDER BY createddate DESC LIMIT 1];
        if(orderId==lstord[0].Id){
           return true; 
        }
        return false;
    }
    //24.10.2024/Varaprasad Sada/US# 1829230-IT | Request for integration flow from Teleperformance to CRM for Predictive Model
        public static String convertTextToJSON(String inputText) {
            // Remove the curly braces from the input
            inputText = inputText.replaceAll('[{}]', '');
            // Split by comma to get individual key-value pairs
            List<String> keyValuePairs = inputText.split(',');
            // Prepare a Map to hold the key-value pairs
            Map<String, Object> jsonMap = new Map<String, Object>();
    
            for (String pair : keyValuePairs) {
                List<String> keyValue = pair.split(':');
                if (keyValue.size() == 2) {
                    String key = keyValue[0].trim();
                    String value = keyValue[1].trim().replaceAll('"', '');
                       jsonMap.put(key, value);
    
                }
            }
     
            // Convert the Map to JSON
            return JSON.serialize(jsonMap);
        }
 
/********************************************************************************************************
* @author        : ITC
* @method Name   : isAccountAnonymised
* @returns       : Boolean
* @params        : String accId
* @description   : 30.10.2024/Varaprasad sada/US#1889165-IT - Prevent M2 customers from registering assets that are already linked to an account
*****************************************************************************************************************/
    public static boolean isAccountAnonymised(string accId){

        Account acc =[select id,Country__c,BAT_Is_Anonymised__c,LastName from account where ID=:accid];

        
        return acc.BAT_Is_Anonymised__c;
    }
}