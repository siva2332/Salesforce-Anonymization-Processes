/*********************************************************************************************************************************
@ Class:          BAT_ConstantsUtility
@ Version:        1.0
@ Author:         Neha Lund
@ Purpose:        General utiliPROMO_CODEty class for Constants and SOQLs accross all apex
----------------------------------------------------------------------------------------------------------------------------------
@ Change history: 15.08.2018 /
                  12/04/2019/US-13171, Abhishek Kashyap/ Added/Updated constants for case record types for DE
                  19/04/2019/US-19460, Abhishek Kashyap/For DE added the variable, 'eCom Deleted' for all category (THP, Vape, Oral, Combustible)
                  17/06/2019/Abhishek Kashyap/ Added string for goecodescheduler job and cron expression for once a day at midnight
                  09/08/2019 / Souvik Dinda / US34105-Added two new constants.
                  16/07/2019/US-31478, Osheen Sahajpal/ Added constant which are used for Email-to-Case Configurations
                  17/07/2019/US-35139, Osheen Sahajpal/ Added constant for Order Type Trial
                  04.07.2019/Abhishek Kashyap/US - 20647 / Added String for Austria country code
                  29/07/2019/Divya Eduvulapati/US-34394/Added string for LYFT case queue
                  11/09/2019/ Souvik Dinda / US#34846 Added 7 new constants for Bulk Task Generation
                  09/08/2019/Abhishek Kashyap/ Added string for Brand "Velo" and initial of english language
                  10/09/2019/US-44080(MX), Osheen Sahajpal/Added constants to build exact match query
                  16/10/2019/ Souvik Dinda/ US#53388 Added new lead source "Own Retail Store" and recordtype "BAT_OwnRetailLead"
                  17/10/2019/ Rajesh Potla/ US#48270 Added New action name for Replaced asset.
                  07/11/2019/Satya Nalluri/US#52717 Added new constants to build Lead and account forms
                  22/11/2019 /Souvik Dinda/ US#34615 Added OrderItem for GDPR Report query.
                  26/11/2019/ Souvik Dinda/ US#34462 Added to bypass SAP UA user for entry code valition
                  04/12/2019/ Souvik Dinda/ Added error message when user having Case deletion permission set is going for other market record
                  deletion.
                  06/12/2019/ Souvik Dinda/ US#47980 - Added constant for Permission Set for Person Account History Delete.
                  30/12/2019/ Edwin Resendiz/ Added contant to fix the Buf #71539 to check the product name ePen3 or ePen 3 
                  17/01/2020/ Edwin Resendiz/ Added contant to AggregateResult  #74903  
                  30/01/2020/ Souvik Dinda/ US#71390: Added constants for Email Verification
                  11.03.2020/ Idrees Ali Jabalpurwala/ US#93279 Variables for caseFieldUpdateBasedOnMapping() method to store Dynamic Query Strings
                  16/03/2020/ Souvik Dinda/ As part of ForceReviewer report, added final keyword to all the constants which were under violation.
                  31/03/2020/ Rajesh Potla/ Modified as part of Force reviewer violation Removing Hardcoded Strings.
                  24/04/2020/Tejaswi Nissankula/KZ:Glo:US#116546 : Added string variables for '#',':','&'. 
                  28/04/2020/Souvik Dinda/ US#116614 - Added 4 new constants for Point creation based on Asset registation/replacement
                  to make generic strings and allow Model to be adjusted in future.
                  14/05/2020/Bug#123022-SatyaNalluri-Created variable'Mulesoft_Integration_IT_UserName' to refer IT mulesoft user name while registering device
                  18May, 2020/Abhishek Kashyap/US-71391, Email Verification - Lead - Community - Verify Email after Existing Mobile Verification, Added constants.
                  18/05/2020/Tejaswi Nissankula/Bug#125977: Added ACC_SELECTQUERY,BAT_ACC_LEAD_EMAIL_COMPARE_STR and updated variable BAT_ACC_LEAD_PHONE_COMPARE_STR
                  19/06/2020/Tejaswi Nissankula/Bug:171565 : Added variable QUERY_SURVEY_ActiveVersionId
                  26.05.2020/Tejaswi Nissankula/ID : US#136708 : Added country variable for ID
                  26.06.2020/Akshata Rajmane /ID : US#136603 : added fields for reverse Integration
                 22nd May, 2020/Satya Nalluri/Bug#129733, Added action name to get the resepctive record from Retailer point table. 
                 21.05.2020 / Rajeev Arya /US #71365 : Added a constant  for temporary Email field for Account Email Verification.
                 26/05/2020/Edwin Resendiz/Bug #37674- Added Range constant to Range__c from UK custom metadata
                 17/06/2020/SOuvik Dinda/ US#135292 - Added a new picklist value in BAT_EmailVerificationStatus__c field.
                25.06.2020/ Mallik Balla/ US#176027 : Modified the classes -to add query modifier constants for the leads
                26.06.2020/Akshata Rajmane /ID : US#136603 : added fields for reverse Integration
                  23.03.2020/ Souvik Dinda/ Added constants as a part of ForceReviewer changes.
                  25.08.2020/ Osheen Sahajpal /RO:Sprint-60:US #225174:Added batch class name and method name for Apex log creation
                  27Th Aug, 2020/Abhishek Kashyap/ENH_227912,RO - Update logic for account anonymization
                  03-09-2020/ Souvik Dinda/ US #225174 - Added 2 new constants for logging error from BAT_Utilities class.
        7th Sep,2020/Abhishek Kashyap/ENH-US-266132-SE lyft >> own store portal update
        14-10-2020/Sandeep Joshi/ZA:sprint 2:US #284782-Added ZA Country Constants for code Usage.  
        //21-10-2020/Sandeep Joshi/ZA:sprint 2:US #298182 Added Brand Check Constant for code usage.
        //23-10-2020/sandeep joshi/ZA:sprint 3 Added constant for use in code         
    27th Oct, 2020/Abhishek Kashyap/ Added constants as part of 285430  
05.10.2020/Saurabh Sharma/ Added CLUSTER Constant for  US227850 IT/ES reward point Changes
                  13.10.2020/Saurabh Sharma/ Added IT_LANGUAGE_LOCALE_KEY for US283178 for Snapshot PDF Localisation
          30.10.2020/ Mallik Balla/ Bug #314845 - PL - Added STR_YOURCHOICE value for brand house comparision   
            21.10.2020/Allada Yeshwanth US: #298162 / Added Variable for Consure registration screen form
                  30.10.2020/ Mallik Balla/ Bug #314845 - PL - Added STR_YOURCHOICE value for brand house comparision
                  28.10.2020/Saurabh Sharma/US#287284, Added Constants for liveChat transcript anonymization
                  27.11.2020/Nida Abshar Khan/US#314624, Added Constants for Restricted Profile Automation
                  04.12.2020/Souvik Dinda/US#306018 - Added new constant for method getAccountWithUpdateMGMCounter() in BAT_Utilities.
                  11.12.2020/Souvik Dinda/US#301630-Constant for BAT Read Only profile.
                  14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
                  14.2.2021/Akshata Rajmane/GR : Sprint 2: US#410472 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic 
                  16th Feb, 2021 / Akshata Rajmane / US #392555 : GR - Technical Setup - CRM Int Dependency: Automatic Consumer Status Update
                 12.1.2020/Dipika Gupta/Bug#376762 -Constant for Mulesoft Integration User
                 14.1.2021/Idrees Ali/US#340701 Idrees Ali -Constants for IT Portal
                 12.1.2020/Dipika Gupta/Bug#376762 -Constant for Mulesoft Integration User
                  22.01.2021/Anna Gomez/US#380193: Added constant for SK Country
                  21.01.2021/Osheen Sahajpal/ENH:Sprint-71:SRB:US #217575:Supporting methods for Auto Account Update Batch
                  : 12.03.2021/ Akshata Rajmane/ bug#444837 :Reverse integration for multi-brand consumers: Added logic to pass multiple fields in URL
        17March,2021/Abhishek Kashyap/US#434292-RO-Added a variable to save purged email string when the flow is called form EmailVerificationComponent.
                  12.04.2020/Osheen Sahajpal/ENH: Sprint:76: US#160407:Supporting variables for UA-sputnik
                09.05.2021 /Akshata Rajmane / US#505672 : Avalanche - Technical Setup - Duplication Rule Logic
                  :26.04.2021/Souvik Dinda/US#494440: Added constant for eCommerce-Vuse Order source.
                  :18.05.2021/Souvik Dinda/US#414410 - Added constant for searching the Auth Provider and JSON Request construction for Notification to Marketing Cloud.
                  :04.06.2021/Souvik Dinda/US#525787 - Added constants for handling Apex logs related to UK Own Store Portal
                  :04.06.2021/Anna Gomez/Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
                  :18.06.2021/Souvik Dinda/US#487564 - Added constants for Substitution Case on Product Case Form.
                  :04.06.2021/Anna Gomez/Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
                  :01.07.2021/Allada Yeshwanth/ US:#525503 - Added constants for Asset Sync batch
                   02.07.2021/Roopa/ENH: Sprint-82: US #364007: Added supporting variables for Hypercare tasks
                   12.07.2021|| US: #596866 || Kushagra Jain || Support : Sprint 83 || Added Varibles for Privacy Snapshot Generation logic
                   08.07.2021|| US: #537702 || Allada Yeshwanth || ENH : Sprint 83 || Added Varibles for handling Error Log
                   12.07.2021|| US: #596866 || Kushagra Jain || Support : Sprint 83 || Added Varibles for Privacy Snapshot Generation logic
                   27-07-2021/Dipika/ENH US #604136 Sprint-84: Added constants for batch query and class name 
                   28.07.2021 || Allada Yeshwanth || US:#580301 || Added Constants
                   18.08.2021/ Allada Yeshwanth / US: #540266 || Added Constants
                   24.08.2021 / Allada Yeshwanth / US#618417 / Added Constants
                   23.08.2021 / Allada Yeshwanth / US: #550795 / Added Constants
                   03.09.2021 / Allada Yeshwanth / US: #725107 / Added Constants
                   01st Sep,2021/Roopa N/ENH US #708704 Sprint-87: Added constants for batch class name 
                   US: #708711 // Allada Yeshwanth // add new parameter to ATH_LEADQUERY1
                   //US: #708711 / Allada Yeshwanth / Added Constants
                   24.08.2021 / Allada Yeshwanth / US#618417 / Added Constants
                   18.08.2021/ Allada Yeshwanth / US: #540266 || Added Constants
                   19-10-2021/Osheen Sahajpal/ENH: Sprint-90: US-764232: Added new platform event type for NHS
                   //27-Oct-2021/ Allada Yeshwanth /ENH US#74119/Added Constants
                   //29.10.2021 / Allada Yeshwanth / US : #731279 / Created the constants
                   //15.11.2021 / Allada Yeshwanth / Added constants as  part of US# 708320
                   //11.11.2021 / Allada Yeshwanth / #736568 / Added Constants
                   //17.11.2021 || Allada Yeshwanth || US : #402606 || Added Constants
                   //25.11.2021 || Turbasu Ghosh || US : #774313 || Added Constants
                   //25.11.2021 || Allada yeshwanth || US : #741230 || Added Constants
                   //10.12.2021 || Allada Yeshwanth || US : #823193 || Added Contants
                   //06.01.2021/Osheen Sahajpal/ENH: Sprint-96: US#834941: event type created for ES MGM Code sync
                   //18.01.2022 || Idrees Ali || US : #726704 || Added Contants for BAT Retailer with Device - SK
                   //25.11.2021 || Allada yeshwanth || US : #741230 || Added Constants
                   //10.12.2021 || Allada Yeshwanth || US : #823193 || Added Contants
                   //06.01.2021/Osheen Sahajpal/ENH: Sprint-96: US#834941: event type created for ES MGM Code sync
                   //18.01.2022 || Idrees Ali || US : #726704 || Added Contants for BAT Retailer with Device - SK
                   //28.02.2022 /Saurabh Sharma/ Bug 906429: Constant for GR cluster
                   //23.02.2022/ Anna Gomez / Bug#904990 - Constant for Mulesoft Integration User IT
                   //28.02.2022 /Saurabh Sharma/ Bug 906429: Constant for GR cluster 
                   //04-04-2022/Turbasu Ghosh / Bug #905783 - 865425- Anonymized in Salesforce, request is not sent to Mulesoft/Added leadPlatformEventFlag- Avoid trigger run if lead is anonymized send platform event 
                   //20.04.2022/Debasis Maharana/Bug #960850- Added Email__c field to avoide future exception
                   //24.05.2022/ Debasis Maharana/ Bug#960851 / Removed sub-query to avoide 'Aggregate query has too many rows for direct assignment, use FOR loop' this exception
                   //23.06.2022/Praveen/ Added a string as part of US#998471
                   //27.07.2022/Rama Akella / Bug#1078354/ Added a set to hold 'Anonimo' Accounts
                   //11.08.2022/Turbasu Ghosh /Added a string as part of US#1065540 
                   //04.07.2022/Osheen Sahajpal/CH: Sprint-2: US #1031431: Supporting variable for ContactPointTypeConsent Object
                   //27.07.2022/Rama Akella / Bug#1078354/ Added a set to hold 'Anonimo' Accounts
                   //01.09.2022/Turbasu Ghosh/US #1028107: Global: All Markets: To include Synchronisation field on Lead to synchronise data correctly on Marketing Cloud
                   //15.09.2022/samekala@deloitte.com/Bug#1134232 Sharing the Access to Tobacconist When the record is created by BAT Glo Corner -IT profile
                   //26.09.2002/Vamsi Ramineni/ US #1105804 : Gloabl : ALL Markets : Added Azure API Constants
                   //14.11.2022/ Sameer Ranjan / US #1173773 : Added supporting constant variables  
                   //14.11.2022/Anna Gomez/US:#1153646: CZ-Device registration logic change - Added constants
                   //01.12.2022/ Saurabh Sharma/ ENH:Sprint-119:US #961238- UK - Vuse Webeyez Salesforce - live chat triggering, Added Constant
                   //12.02.2022/ Idrees Ali/ ENH:Sprint-119:US #1135211- glo DE - Loyalty - Qualtrics to Loyalty Trigger - Added constants
                   //13.12.2022/Rahul Upadhyay/US:#1199173 : UK - Brand House field population/update - Added constants
                   //12.01.2023 / Swaraj Ray /BAT#1142557 - ZA - Data Archival Process 
                   //06.02.2023/ Rama Akella/ Bug#1293078: Added constant for 'FIELD_CUSTOM_VALIDATION_EXCEPTION'
                   //06.02.2023/ Idrees Ali/ US#1285878: Data Archival Process - Added constants for Discrepancy with regard to Field Values & Throttling mechanism Redesign
                   //1 Mar 2023/ Praveen/ US #1284980/  IT - Glo Sharpend API integration from 3rd Party Retail to SF (QR code) - part2
                   //02.03.2023/Idrees Ali/ENH: Sprint-125:US#1228423-IT | glo | Point assignment to retailer if customer joins Loyalty || Added Constants
                   //06.03.2023 / Saurabh Sharma / Bug #1322086 / created constant for duplicate value exception for try catch error handling
                   //07.03.2023 / Hariharan Pillai / US #1199876 / String No Account Linked
                   //6th March, 2023 / Swaraj Ray / US #1280522 / 
                   //24.03.2023/Idrees Ali/ENH: Sprint-126:  [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
                   //03.04.2023/Saurabh Sharma/ US#1043059, resolvedSelfLookupOnChildRecords method reference added.
                    //11 May, 2023/ Chirag Kalra/ US-1339519, FR,  Added custom CSS classes as constant .
                    //25.05.2023/Lalit Kumar/US#1390835:CZ - Retailer w/ device glo HYPER X2 air reward logic
                   //09.06.2023/Lalit Kumar/US#1277382 / ES Espacio Expertus Integration
                   //21.06.2023/Varaprasad Sada/US#1324896/CH Dunhill Integration - Consumer Account Deletion
                   //21.12.2023/ShanmugaPriyan/US: #1591514- IT GLO | Asset update from Sharpend
*********************************************************************************************************************************/
 

public with sharing class BAT_ConstantsUtility {
    /*** BAT_AccountTriggerHandler - BEGIN *******************************************************************************/
    public final static String STR_YOURCHOICE        = 'Yourchoice';//30.10.2020/ Mallik Balla/ Bug #314845 - PL - Added STR_YOURCHOICE value for brand house comparision
    public final static String ATH_ECOMMERCE        = 'eCommerce';
    public final static String ATH_CONSUMER         = 'Consumer';
    public final static String ATH_PROSPECT         = 'Prospect';
    public final static String ATH_GUEST            = 'Guest'; //Added by Roopa N. as part of [ID]: US#227057
    public final static List<String> countries      = new List<String>{'KZ', 'RO'};
    public final static String ATH_LEADQUERY1       = 'SELECT Email,BAT_IsVeloOptInEmailCommunication__c,BAT_IsVeloOptInMobileTextSocialMedia__c, ownerId,MobilePhone,Brand_House__c,Status,IsConverted,ConvertedAccount.Related_Lead__c,Reward_Profile__r.User__c,Name,LeadSource,';
    public final static String ATH_COMMA            =  ', ';
    public final static String ATH_LEADQUERY2       = ' Owner.Type, Id from Lead';
    public final static String ATH_LEADEMAILCLAUSE  = ' where Email IN '; 
    public final static String ATH_LEADCOUNTRYCLAUSE = ' AND Country__c IN ';
    public final static String ATH_LEADEMAILCOUNTRYCLAUSE = ' AND (( Country__c IN ';//[PL] 25.06.2020/ Mallik Balla/ US#176027 : Added for the modified query for the leads
    public final static String ATH_LEADEMAILBRANDCOUNTRYCLAUSE = ' ) OR (Country__c IN ';//[PL] 25.06.2020/ Mallik Balla/ US#176027 : Added for the modified query for the leads
    public final static String ATH_LEADClOSEBRACKETS = ' )) ';//[PL] 25.06.2020/ Mallik Balla/ US#176027 : Added for the modified query for the leads
    public final static String STR_MULESOFT_INTEGRATION_USER = 'mulesoft_integration_user';//[PL] 26.06.2020/ Mallik Balla/ US#176027 : Added to check if the logged in user contains integration in name.    
public final static String STR_MULESOFT_INTEGRATION_USER_PL = 'mulesoft_integration_user_pl%';//[PL] 26.06.2020/ Mallik Balla/ US#176027 : Added to check if the logged in user contains integration in name.    
    public final static String STR_BRAND_AMBASSADORS = 'Brand Ambassadors';//[PL] 26.06.2020/ Mallik Balla/ US#128056 : Constant for Brand Ambassador for Lead Source
    public final static String STR_HOSTESS = 'Hostess';//[PL] 26.06.2020/ Mallik Balla/ US#128056 : Constant for Hostess for Lead Source
    public final static String ATH_LEADBRANDCLAUSE = ' AND Brand_house__c IN '; 
     // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts -
    public final static String ATH_LEADBRANDCLAUSEINCLUDES = ' AND Brand_house__c INCLUDES ';
     // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic ends -
    public final static String WHERE_CLAUSE  = ' where '; 
    public final static String IN_CLAUSE  = ' IN'; 
    public final static String ATH_LEADEMOBILECLAUSE  = ' OR MobilePhone IN ';//Added as part of US37833 
    public final static String ATH_LEADCONVERTEDCLAUSE = ' AND isConverted = false limit 50000';
    public final static String ATH_SOURCE           = 'eCommerce';
    /* Added by Prince Chawla for UK US#12067 */
    public final static String ATH_EXTERNALSUBSCRIBERID = 'BAT_ExternalSubscriberId__c';
    public final static String ATH_EXTERNALSUBSCRIBER2ID = 'BAT_ExternalSubscriberID2__c';
    public final static String ATH_EXTERNALSUBSCRIBER3ID = 'BAT_ExternalSubscriberID3__c';
    /* Added by Prince Chawla for UK US#12067 */
    /*Starts by Prince Chawla for UK US#16274*/
    public final static String OWNSTOREPORTAL = 'Own Store Portal'; 
    public final static String USERNAME_OWNSTORE = 'Own Store Portal'; 
    public final static String CREATENEWTRIAL = 'Create New Trialist';
    public final static String CREATENEWCONSUMER = 'Create New Consumer';
    public final static String RANGE_RECTYPE  = 'Range';
    public final static String OWNSTORETRIAL = 'Trial';
    /*Ends by Prince Chawla for UK US#16274*/

    public final static String ATH_Class            =  'BAT_AccountTriggerHandler';
    public final static String OTH_Class            =  'BAT_OrderTriggerHandler';
    public final static String ATH_NextLine         = '\n';
    public final static String ATH_DUPLICATE        = 'checkDuplicateAccount';
    public final static String ORDER_SUBMISSION_STATUS= 'Submit';
    public final static String ORDER_SHIPPED_STATUS= 'Shipped';//KZ:Glo:US#104700 
    public final static String BAT_CRM_UK_USER = 'Digital Manager';
    public final static String PAY_METHOD_UK = '14-Day Trial (for Vype ePen 3 only)';
    public final static String PAYMENTMETHOD_DAY14TRIAL = '14-Day Trial (for Vype ePen 3 only)';
    public final static STring ACC_STATUS_TRIALIST = 'Trialist';
    public final static String COUNTRY_BG = 'BG';//Added as part of US#3056
    /*Added by Shreeyanshu on 14-12-2018: DE: Sprint 3: US#3400*/
    public final static String ATH_RECTYPEDE        = 'BAT_New_Order_DE';//US#3400
    public final static String SUBMITTED_STR        = 'Submitted'; //US#3400
    public final static String DECON_STR = 'DE'; //US#3400
    
    /*Added by Rajeswari N on 25/05/2022 : CZ : Enh|Sprint105|CZ/SK - restriction for the fields in retailer w/ device platforms*/
     public final static String HostessCode_STR = 'BAT_HostessCode__c';
    
    /*Added by Shreeyanshu on 08/02/2019: For Class "BAT_RecordVerification_DE"*/
    public final static String LEAD_STATUS_IN_PROGRESS_STR = 'In progress';
    public final static String DMLERROR_STR = 'DMLError';
    public final static String RECORDERROR_STR = 'RecordError';
    public final static String SUCCESS_STR = 'Success';
    
     // 1454597 CZ - multicategory loyalty program - CRM & M2 
     public final Static String CONSUMER_RecordtypeID = 'Direct Consumer'; 
     public final Static String ACCOUNT_MERGE_CUSTOM_SETTING = 'BAT_AccountmergeCZ'; 
    
  
    // CZ loyality
    /*Starts 2636- Added by Prince on Oct 25th,2018 for US#:2636 */
    public final Static String CONSUMER_STR = 'Direct Consumer'; 
    public final Static String OWN_STORE_STR = 'Own Stores';
    public final Static String UnitedKindom_STR = 'United Kingdom';
    public final Static String UK_STR = 'UK';
    public final Static String STANDARD_ACCOUNT_STR = 'Account';
    public final Static String ACCOUNT_FIELD_MOBILEPHONE = 'PersonMobilePhone';//Added as part of US11122
    public final Static String ACCOUNT_FIELD_HOMEPHONE = 'PersonOtherPhone';//Added as part of US11122
    public final static string ACCOUNT_FIELD_ISPERSONACCOUNT = 'IsPersonAccount';//Added as part of US11122
    public final static string FIELD_BRANDHOUSE = 'Brand_House__c';//Added as part of 37556
    public final static string FIELD_EXISTINGCONSUMER = 'BAT_ExistingConsumer__c';
    public final Static String COMPLETE_STR = 'Complete'; //US#4879
    public final Static String ORDER_STR = 'Order';
    public final Static String ASSET_STR = 'Asset';
    public final Static String CASE_STR = 'Case';
    public final Static String SURVEY_STR = 'Survey_Information__c';
    public final Static String EVENT_STR = 'Event';
    public final Static String TASK_STR = 'Task';
    public final Static String OPPORTUNITY_STR = 'Opportunity';
    public final Static String ACTIVE_STR = 'Active';
    public final Static String INACTIVE_STR = 'Inactive'; // Added by Roopa N for RO - US#411211
    /*Ends 2636- Added by Prince on Oct 25th,2018 for US#:2636 */
    public final Static String DEVICES_STR = 'Devices'; //US#4879
    public final Static String DISPVITI_STR = 'Dispositivi'; //US#4879
     // Closed Queues Starts//hima 1444323  start
    public final Static String Closed_Queue_Velo_UK='BAT_Closed_Case_Velo_Queue_UK';
     public final Static String Closed_Queue_10M_UK='BAT_Closed_Case_10M_Queue_UK';
     public final Static String Closed_Queue_VIP_UK='BAT_Closed_Case_VIP_Queue_UK';
     public final Static String Closed_Queue_Vuse_UK='BAT_Closed_Case_Vuse_Queue_UK';
    // Closed Queues Ends//
    //  // Closed Queues Starts//hima 1410617  start
    public final Static String Closed_Queue_Velo_FR='BAT_Closed_Case_Velo_Queue_FR';
     public final Static String Closed_Queue_10M_FR='BAT_Closed_Case_10M_Queue_FR';
     public final Static String Closed_Queue_VIP_FR='BAT_Closed_Case_VIP_Queue_FR';
     public final Static String Closed_Queue_Vuse_FR='BAT_Closed_Case_Vuse_Queue_FR';
    // Closed Queues Ends//
    // old Queues Starts//
    public final Static String Open_Queue_Velo_UK='BAT_UK_EmailCaseVeloQueue';
     public final Static String Open_Queue_10M_UK='BAT_UK_EmailCase10MotivesQueue';
     public final Static String Open_Queue_VIP_UK='BAT_UK_EmailCaseVIPQueue';
     public final Static String Open_Queue_Vuse_UK='BAT_UK_EmailCaseVuseQueue';
     
    public final Static String Case_Open='Case (';
    public final Static String Case_Label=')has been responded to reopened';
    
    // old Queues Ends// hima 1444323  start ends
  
    /*Starts 2636- Added by Prince on Oct 31st,2018 for US#:3262 */
    public final Static String BUYER_STR = 'Buyer';
    public final Static String DAY14RT_STR = '14Day';
    public final Static String LEAD_STR = 'Lead';
    public final Static String LEAD_FIELD_MOBILEPHONE = 'MobilePhone';//Added as part of US11122
    public final Static String LEAD_FIELD_HOMEPHONE = 'Phone';//Added as part of US11122
    public final Static String DUPLICATE_STR = 'Duplicate';
    /*Ends 2636- Added by Prince on Oct 31st,2018 for US#:3262 */
    /*Starts 2584- Added by Prince on Jan18th,2019 for US#2584 / US#2585 */
    public final Static String EPEN3_STR = 'ePen3';// Bug #71539 
    public final Static String EPEN_3_STR = 'ePen 3';// Bug #71539  
    public final static String SUNDAY = 'Sunday';
    public final static String SATURDAY ='Saturday';
    public final static String DATE_FORMAT = 'EEEE';
    public final Static String EPEN3Sub_STR = 'ePen3 Day-4 Hypercare Call';
    public final Static String DAY4_STR = 'Day-4';
    public final Static String OPEN_STR = 'Open';
    public final Static String HYPHEN = '-';
    public final Static String HYPHEN_WITH_BOTHSIDE_SPACE = ' - ';
    /*Ends 2584- Added by Prince on Jan18th,2019 for US#2584 */
    /*Starts 2584- Added by Prince on Feb25th,2019 for US#9156 */
    public final Static String RANGE_EPEN2 = 'ePen2';
    public final Static String RANGE_EPEN_2 = 'ePen 2';
    public final Static String RANGE_EPEN3 = 'ePen3';
    /*Ends 2584-   Added by Prince on Feb25th,2019 for US#9156 */
   /*** BAT_AccountTriggerHandler - BEGIN *******************************************************************************/
    public static boolean LTH_LEADCONVERT = false;
    public final static String ASSET_TYPE_SOLD = 'Sold';
    public final static String DE_STR = 'DE';
    public final static String DEFAULT_STR = 'Default';
    public final static String NAME_STR = 'Name';
    public final static String MEMBERSHIP_CODE_ACC = 'ACC';
    public final static String MEMBERSHIP_CODE_REW = 'REW';
    //Account set to hold anonimo accounts 
    public final static Set<String> ANONIMO_ACCOUNT_SET = new Set<String>{'GLO ANONIMO','GLO REGALO','VUSE ANONIMO'};
    public final static String ACCOUNT_GLO_ANONIMO =  'GLO ANONIMO';
    public final static String ACCOUNT_GLO_REGALO =   'GLO REGALO'; 
    public final static String TRIAL_STAGE_CLOSED_WON =  'Closed Won';
    public final static String TRIAL_STAGENAME_CLOSED_WON =  'Closed Won';
    public final static String TRIAL_DEVICE_RETURNED =   'Yes'; 
    public final static String COUNTRY_IT = 'IT';
    public final static String COUNTRY_AZ = 'AZ';
    public final static String IN_TRIAL ='In Trial';
    public final static String GLO_STORE ='BAT Glo Store';
    public final static String FLAGSHIP ='BAT Flagship';
    public final static String TEAM_LEADER='BAT Team Leader';
    public final static String AREA_MANAGER='BAT Area Manager';
    public final static String CUSTOMER_SERVICE='BAT Customer Service';
    public final static String SPONSORSHIP='BAT Sponsorship';

    public static String TOBACCONIST ='Tobacconist';
    public static String GLO_CORNER='Glo Corner';
    public static String GLO_DEVICE='GLO Device';
    //PL: US #169252 - Added by Chiranjeevi Srinivas
    public static String SOURCE_CARECENTER='Care Center';
    public static String SOURCE_FLAGSHIP='Flagship';
    public static String SOURCE_POP_UP_STORE='Pop Up Store';
    public static String SOURCE_SPONSORSHIP='Sponsorship';
    public static String SOURCE_SS='Social Seller Personal Connection';
    public static String SOURCE_CC='Contact Center';
    public static String SOURCE_GLO_SHOP='Glo Store';
    public static String SOURCE_REACH ='Reach'; //added by Idrees Ali as part of US#340701
    public static String ECOMM_GOVYPE_STR = 'eCommerce - govype';
    public static String ECOMM_10M_STR = 'eCommerce - 10M';
    public static String ECOMM_VIP_STR = 'eCommerce - VIP';
    public static String ECOMM_LYFT_STR = 'eCommerce - Lyft'; // added By Sudaif for US 14927
    public static String ECOMM_GLO_STR = 'eCommerce - Glo'; // added by Souvik D. for US#26291
    public static String STR_ECOMM_GLO = 'eCommerce - glo'; // added by Mallik Balla for US# 254833 : PL
    public static String ECOMM_VUSE_STR = 'eCommerce - vuse'; 
    Public final static String ECOMM_VELO_STR = 'eCommerce - Velo'; // added by Rahul for US #1199173 : UK
    public static String ORDER_ECOMMERCE = 'Ecommerce';// added by Souvik D. for US#26291
    public static String RECORDTYPE_TRAILLIST= 'Trialist';
    public static String WEBSITE_DUNHILL = 'Website - Dunhill';// added by Varaprasad Sada for US#1324896--Sprint-133
    public static String DUNHILL = 'DUNHILL';// added by Varaprasad Sada for US#1324896--Sprint-133
    
    public static String ACC_RECTYPE_DIRECTCON = 'Direct_Consumer';
    public static String ACC_RECTYPE_GUEST = 'BAT_Guest'; //Added by Roopa N. as part of [ID]: US#227057
    public static String ACC_RECTYPE_UK14Day = 'UK14Day';
    //Added by Usha as prt of US: #13592
    Public final static String EQUALS = 'EQUALS';
    Public final static String NOTEQUALS = 'NOTEQUALS';
    Public final static String ORAL_STATUS = 'BAT_OralStatus__c';
    Public final static String VAPE_STATUS = 'BAT_VapeStatus__c';
    //16th Feb, 2021 / Akshata Rajmane / US #392555 : GR - Technical Setup - CRM Int Dependency: Automatic Consumer Status Update
    Public final static String THP_STATUS = 'BAT_THPStatus__c';
    //Added as part of US#5997
    public final static string ID_PARAM='Id';
    public final static string TITLE_PARAM='title';
    public final static string FORWARD_SLASH='/';
    public final static string SHARING_PRIVACY='P';
    //End of US#5997
    /*** BAT_AssetTriggerHandler ****/

    public final static string BAT_ASSET_TRIGGER_HANDLER ='BAT_AssetTriggerHandler';
    public final static String ON_BEFORE_UPDATE = 'OnBeforeUpdate';
    public final static String GENERATE_TASK_ON_CONSUMER = 'generateTasksOnConsumer_SEA';
    public final static String SOLD_DEVICE_CODE_ENTRY = 'Sold_Device_Code_Entry';
    /***BAT_OpportunityTriggerHandler ****
    *@Date : 20.11.2018 
    *  
    */
    public final static String TRIAL_STAGE_INTRIAL = 'In trial';
    public final static String TRIAL_STAGE_ENDED = 'Trial Ended';

     public final static String TRIAL_STAGENAME_INTRIAL = 'In trial';
     public final static String TRIAL_STAGENAME_ENDED = 'Trial Ended';
     public final static String TRIAL_STAGENAME_LOST = 'Closed Lost';
     public final static String TRIAL_STAGENAME_OPEN ='Open';
     public final static String TRIAL_STAGE_WON = 'Closed Won';
     public final static String TRIAL_STAGE_LOST = 'Closed Lost';
     public final static String ASSET_STATUS_ACTIVE = 'Active';
     public final static String ASSET_TYPE_TRIAL = 'Trial';
     public final static String LOVER_STR = 'Lover';
     public final static String PASSIONATE_STR = 'Passionate';
     public final static String MESSAGE_STR = 'Could you take a look?';
     public final static String BAT_CUSTOMER_SERVICE_LIKE = '%BAT Customer Service%';
     public final static String TASK_NUMBER_STR = 'tasknumber';

     public final static String ACCOUNT_IS_MINE = 'Account_Is_Mine__c';
     public final static String INSTALL_DATE = 'InstallDate';

     /***BAT_LeadTriggerHandler ****
     *@Date : 26.11.2018
     *
     */
     public final static String DYNAMIC_QUERY='SELECT Email__c,Postal_Codes__c,Country__c FROM BAT_Agent_App_User__c WHERE Agent__c=true AND Country__c IN : countries AND Postal_Codes__c LIKE';
     public final static String STR_PERNCENTAGE_WITHESCAPESEQ = '\'%';
     public final static String STR_PERNCENTAGE_LASH_WITHESCAPESEQ = '%\'';
     public final static String LASH_STR = '/';
     public final static String CHAR_P ='P';
     public final static String COMMA_STR = ',';
     public final static String ID_STR = 'Id';
     public final static String COUNTRY_HR = 'HR';
     public final static String COUNTRY_RS = 'RS';
     public final static String COUNTRY_KZ = 'KZ';
     public final static String COUNTRY_UA = 'UA';
     public final static String COUNTRY_ID = 'ID';//Added as part of US#136708
     public final static String COUNTRY_FR = 'FR';//Added as part of US#281014
     public final static String PROFILE_FLAGSHIP_HR = 'BAT Flagship - HR';
     public final static String PROFILE_FLAGSHIP_RS = 'BAT Flagship - RS';
     public final static String PROFILE_TL_KZ = 'BAT Team Leader - KZ';
     public final static String PROFILE_SS_KZ = 'BAT Social Seller Lover - KZ';
     public final static String PROFILE_BAT_CUSTOMER_SERVICE = 'BAT Customer Service';
     //PL: US #169252 - Added by Chiranjeevi Srinivas
     public final static String PROFILE_BAT_CUSTOMER_SERVICE_PL = 'BAT Customer Service - PL';
     //CZ: US:#296149 - Added by Allada Yeshwanth
     public final static String PROFILE_BAT_CUSTOMER_SERVICE_CZ = 'BAT Customer Service - CZ';
     //IT: US:#1134232 - Added by samekala@deloitte.com
     public final static String PROFILE_BAT_GLO_CORNER_IT = 'BAT Glo Corner - IT';
     public final static String LEAD_STATUS_ICON_GREEN = '/resource/Green_Circle';
     public final static String LEAD_STATUS_ICON_BLUE= '/resource/Blue_Circle';
     public final static String LEAD_STATUS_ICON_RED = '/resource/Red_Circle';
     public final static String LEAD_STATUS_ICON_YELLOW ='/resource/Yellow_Circle' ;

     public final static String LEAD_CONTACTED_SUCCESSFULLY   = 'Contacted successfully';
     public final static String LEAD_CONTACTED_UNSUCCESSFULLY = 'Contacted unsuccessfully';
     public final static String LEAD_CONTACTED_OPENED_NOT_CONTACTED   = 'Opened/not contacted';
     public final static String LEAD_CONTACTED_ASSIGNED_NEW = 'Assigned/new';
     public final static String DOMAINANNOTATION = '@';
     public final static String LEAD_AWARE = 'Aware';
     public final static String LEAD_LOST = 'Lost';
     public final static String LEAD_FR = 'Lead-FR';
    
   
     
     public final static String LEAD_UNAWARE = 'Unaware';
     public final static String LEAD_TO_SEND = 'To Send';
     public final static String LEAD_MASSIVE_UPDATE = 'Lead Massive Update';
     public final static String LEAD_ALREADY_SENT = 'Already Sent';
     public final static String LEAD_ANONYMOUS = 'anonymous';
     public final static String LEAD_ACC = 'ACC';
     public final static String LEAD_REW = 'REW';
     public final static String PROFILE_BAT_SOCIAL_SELLER_LOVER = '%BAT Social Seller Lover%';
     public final static String POSTAL_CODE_CONTAINER_API_NAME = 'Postal_Code_Container__c';
     public final static String LEADSOURCE_ECOMMERCE = 'eCommerce';
     public final static String LEADSOURCE_OWNRETAILSTORE = 'Own Retail Store';
     public final static String LEAD_OWNRETAILSTORE_RECTYPE = 'BAT_OwnRetailLead';
     public final static String UNIT_TEST = 'Unit.Test';
     public final static String PDF_EXTENSION = '.pdf';
     public final static String PDF_FILETYPE = 'PDF';
     public final static String PRIVACYSNAPSHOT_TITLE = '%Privacy Snapshot%';
     public final static String TASK_OPEN_STATUS = 'Open';
     public final static String ORDER_ID = 'OrderId';
     public final static String TASK_NUMBER = 'tasknumber';
     public final static String SOCIAL_SELLER_TYPE1 = 'Type1';
    
    /***BAT_OrderTriggerHandler ****
    *@Date : 27.02.2019
    *  
    */
    public final static String ORDER_SEMICOLON    = ';';
    /***BAT_OrderItemTriggerHandler ****
    *@Date : 26.11.2018 
    *  
    */
    public final static String ORDERITEM_MD_FLOW_DELETION = 'DeletionItemInBundle';
    public final static String PRODUCT_FAMILY_BUNDLE = 'Bundle';
    public final static String PRODUCT_FAMILY_DEVICES = 'Devices';
    public final static String PRODUCT_FAMILY_CONSUMABLES = 'Consumables';
    
    public final static String CONTACTED_UNSUCCESSFULLY ='Contacted unsuccessfully';
    public final static String CONTACTED_SUCCESSFULLY_NOT_AVAILABLE ='Contacted successfully - Not available at the moment';
    public final static String CONTACTED_SUCCESSFULLY ='Contacted successfully - Available for meeting';
        
    public final static String SS_PERSONAL_CONN='Social Seller Personal Connection';
    public final static String TRIAL_ENDED ='Trial Ended';
    public final static String CLOSED_WON ='Closed Won';
    public final static String CLOSED_LOST ='Closed Lost';
    public final static String NO='No';
    
    public final static String IT='IT';
    public final static String LOST='Lost';

    
    public final static String SOLD_DEVICE = 'Sold Devices'; 
    public final static String CREATED_LEAD = 'Created lead'; 
    public final static String CONVERTED_LEAD ='Converted lead';
    public final static String TRIAL_ENDED_WITH_PURCHASE = 'Trial ended with purchase';
    public final static String TRIAL_ENDED_WITHOUT_PURCHASE = 'Trial ended without purchase';
    public final static String STATUS_ON ='On';
    public final static String SS_LOVER = 'BAT Social Seller Lover';
    public final static String STR_HOSTESS_PROFILE = 'BAT Hostess';
    public final static String SS_PASSIONATE = 'BAT Social Seller Passionate';
    public final static String BATSADMIN = 'BAT System Administrator';
    public final static String GLOSTORERO = 'BAT Glo Store - RO'; //Added as part of Bug#505391
    public final static String FLAGSHIPRO = 'BAT Flagship - RO'; //Added as part of Bug#505391
    public final static String SADMIN = 'System Administrator';
    public final static String SAP_CPI_USERNAME_UK = 'sapci_integration_user_uk@bat.com'; //Added as part of Bug fix #781027 for US #748337
    public final static String POS_AGENT_PROFILE = 'BAT POS Agent';//Added as part of US25038
    public final static String SOURCE_POS_AGENT = 'POS Agent';//Added as part of US25038
    
    public final static String SOLD = 'Sold';
    public final static String CONVERTED = 'Converted';
    //public static String CLOSED_WON = 'Closed Won';
    //public static String CLOSED_LOST = 'Converted';
    public final static String COUNTRY_GR='GR';
    public final static String COUNTRY_CY='CY';
    public final static String COUNTRY_PT='PT';
    public final static Integer QUANTITY_ONE = 1;

    /******BAT_CASE_TRIGGERHANDLER */
    public final static String CASE_SUBSTITUTED='Substituted';

    /*******VIEWSURVEYCONTROLLER */
    public final static String LOYALTY_SURVEY='Loyalty';


    public final static List<String> ORDER_PLACED_LABEL_LIST = new List<String>{'Submit', 'Submitted'};
    public final static String COUNTRY_RO = 'RO';
    public final static String FLOW_REPURCHASE_LOCK_LABEL = 'checkRepurchaseLock';
    
    /***BAT_UserTrigger ****
    *@Date : 26.11.2018
    *
    */
    public final static String SYSTEM_ADMIN = 'System Administrator';
    public final static string INTEGARTION_USER ='Integration User';
    public final static String USERLICENSE_SALESFORCE = 'Salesforce';
    public final static String USERLICENSE_PARTNER_COMMUNITY = 'Partner Community';
    public final static String GROUPTYPE_REGULAR = 'Regular';
    public final static string INTEGRATION_USER_UPPER_CASE ='INTEGRATION USER';
    

    /***Work Item 2798
     *@Date : 06.12.2018 
     *  
     */
    public final static String HYPERCARE_MANAGEMENT_DELETE_TASK =   'DeleteFutureTasks';
    public final static String HYPERCARE_MANAGEMENT_DELETE_EVENT =   'DeleteFutureEvents';
    public final static String HYPERCARE_MANAGEMENT_ADD_EVENT =   'AddFutureEvents';
    public final static String HYPERCARE_MANAGEMENT_ADD_TASK =   'AddFutureTasks';
    

    public final static String GLO_STORE_PROFILE = 'Glo Store';
    public final static String SOURCE_GLO_STORE = 'GloStore';
    
    /* Work Item 6079
     * Date: 25/01/2019
     */
     
   Public final static String ACCESS_TOKEN      = 'accessToken';
   Public final static String REQ_POST          =  'POST';
   Public final static String BLANK             =  '';
   Public final static String COUNTRY           =  'Country__c';
   Public final static String CONTENT_TYPE      =  'Content-type';
   Public final static String APPLICATION_TYPE  = 'application/json';
   Public final static String AUTHORIZATION     = 'Authorization';
   Public final static String BEARER            =        'Bearer ';
   Public final static String CLIENT_ID         =        'clientId';
   Public final static String CLIENT_SECRET     =        'clientSecret';
   Public final static String ACCOUNT           =        'Account';
   Public final static String LEAD              =        'Lead';
   Public final static String LEAD_ID           =         'ID';
   Public final static String LEAD_Email        =         'Email';
   Public final static String ACCPERSONEMAIL    =         'PersonEmail';
   Public final static String PERSONCONTACTID   =         'PersonContactID';
   Public final static String FIRSTNAME         =         'firstName';
   Public final static String SPLIT             =        '_';
   
     /* Work Item 
     * Date: 19/03/2019
     * Constant variables for sendSMS webservice call
     */
   Public final static String TO            = 'to';
   Public final static String BODY          = 'body';
   Public final static String SMSType_PhoneVerification       = 'Phone Verification'; 
   Public final static String SMS_SUCCESS   = 'Success'; 
   Public final static String SMS_FAILED    = 'Failed'; 
   Public final static String SMS_UNKNOWN   = 'UNKNOWN';
   Public final static String ENCODING  = 'encoding';
   Public final static String UNICODE   = 'UNICODE';
   Public final static String LONGMESSAGEMAXPARTS   = 'longMessageMaxParts';
   Public final static Integer MSGPARTS = 10;
   Public final static String VERIFICATION_CODE_NAME = 'OTP code for:'; 
   Public final static String NO_OF_DIGITS_OTP = '4'; 
   Public final static String Six_Digit_Random_Number = '6';
   Public final static String BULK_SMS_NAMED_CREDS = 'callout:BAT_Bulk_SMS_Settings_Sandbox';
   Public final static String VERIFICATION_PLACEHOLDER = '{BAT_MobileVerificationCode__c.BAT_VerificationCode__c}';
   Public final static String SMS_FROM   = 'from';
   Public final static String SMS_TYPE  = 'type';
   Public final static String SMS_TYPE_ALPHANUMERIC   = 'ALPHANUMERIC'; 
   Public final static String SMS_ADDRESS  = 'address';
   Public final static String GL_COUNTRY_CODE  = 'GL';
   Public final static String COUNTRY_CODE  = 'countryCode';
   Public final static String SMS_STATUS = 'status';
   Public final static String SMS_BODY_PLACEHOLDER = 'BODY PLACEHOLDER';
   Public final static String SMS_MOBILE_PLACEHOLDER = 'MOBILE PLACEHOLDER';
   Public final static String SMS_ADDRESS_PLACEHOLDER = 'ADDRESS PLACEHOLDER';
   Public final static String NUMBER_STR = 'Number';
   Public final static String FIELD_NAME_STR = 'FieldName';
   Public final static String START_OBJECT_STR = 'StartObject';
   Public final static String END_OBJECT_STR = 'EndObject';
   Public final static String START_ARRAY_STR = 'StartArray';
   Public final static String END_ARRAY_STR = 'EndArray';
   Public final static String REQUEST_HEADER_DEDUPLICATIONID_PARAM = '?deduplication-id=';
   Public final static String INTEGRATION_UTILITY_CLASS_NAME = 'BAT_IntegrationUtility';
   Public final static String GENERATE_JSON_BODY_METHOD_NAME = 'generateJSONbody';
   Public final static String SEND_APIGEE_MESSAGE_METHOD_NAME = 'sendApigeeMessage';

   Public final static String BATCH_QUERY = 'SELECT ID FROM BAT_MobileVerificationCode__c Where BAT_ValidTo__c<:todayDate';
    /***Work Item 5996
     *@Date : 01.01.2019 
     *Added By Sudaif  
     */
    public final static String ANONYMOUS_DATA = 'anonymous';
    public final static String ANONYMOUS_EMAIL = '@bat.anonymous'; 
    public final static String ANONYMIZE_LEAD_CONTROLLER_CLASS = 'BAT_AnonymizeLeadController';
    public final static String GENERATE_ANONYMIZE_FILE_METHOD = 'generateAnonymizationFile (UPDATE)';
    public final static String DELETE_PRIVACY_SNAPSHOT_METHOD = 'deletePrivacySnapshot';
    
    /***Work Item 5994
     *@Date : 01.01.2019 
     *Added By Abhinav  
     */
    public final static String PROSPECT = 'Prospect';
    public final static String DIRECT_CONSUMER = 'Direct Consumer'; 
    public final static String CONVERT_LEAD_METHOD = 'convertLead';
    public final static String AUTOMATIC_LEAD_CONVERSION_CLASS = 'BAT_AutomaticLeadConversion';
    
    /***Work Item 5998
     *@Date : 01.01.2019 
     *Added By Abhinav  
     */
    public final static String POSTAL_CODE_API_NAME = 'Postal_Code__c';
    public final static String RANGE_TAR_API_NAME = 'Range_TAR__c';
    public final static String LEAD_CONTACTED_MESSAGE = 'Contacted successfully - Available for meeting';
    /***Work Item 14728 / CH3260817
     *@Date : 03.27.2019 
     *LEAD_CONTACTED_SUCCESS_MESSAGE Added By Chiranjeevi Srinivas V  
     */
    public final static String LEAD_CONTACTED_SUCCESS_MESSAGE = 'Risponde alla telefonata, disponibile ad incontro';
    public final static String CONVERT_LEAD_CONTROLLER_CLASS = 'BAT_ConvertLeadController';
    
    /***Work Item 14869
     * @Date : 02.05.2019
     * Added by Souvik D.
     */
    public final static String LEAD_CONTACTED_API_NAME = 'Lead_Contacted__c';
    public final static String MEETING_RESULT_API_NAME = 'Meeting_Result__c';
    
    /***Work Item 34846
     * @Date : 10.09.2019
     * Added by Souvik D.
     */
    public final static String TASK_CALL_TYPE_API_NAME = 'Call_Type__c';
    public final static String TASK_PRIORITY_API_NAME = 'Priority';
    
    /***********String as part of 6201****************/
     public final static String LEAD_SOURCE_MASSIVE_UPDATE='Lead Massive Update';
     public final static String ASSIGNMENT_NOTIFICATION='To Send';
     public final static String USER_ROLE_TEAM_LEAD='Team Leader';
     public final static String PROFILE_SYS_ADMIN_UA='BAT System Administrator - UA';
 public final static String PROFILE_AREA_MANG_UA='BAT Area Manager - UA';    
 public final static String PROFILE_TEAM_LEADER_UA='BAT Team Leader - UA';
     public final static String PROFILE_SS_LOVER_UA = 'BAT Social Seller Lover - UA';//Added as part of US8206
     public final static Integer ZERO = 0;//Added as part of US8206
     public final static String REWARDPROFILE_TYPE_CONSUMER = 'BAT_Consumer';//Added as part of US8206
     public final static String AREA_MANGER='Area Manager';
     public final static String PROFILE_SYS_ADMIN_KZ='BAT System Administrator - KZ';
     public final static String AM='AM';
     public final static String USER_ROLE_TEAM_PERSON='Team Person';

    
    /************************/
    
    //added Constant varibles - workItem 6008
    /**BAT_OrderSubmissionController Begin*******************/
    
    public final static String ORDER_CREATE_STATUS                 ='Create';  
    public final static String ORDER_PROCESSING_STATUS             ='Processing';
    public final static String ORDER_ACTUAL_STATUS_IN_ERRORMESSAGE ='%status%';
    public final static String BAT_INVOICE_MANAGEMENT_CONTROLLER = 'BAT_InvoiceManagementController';
    
    /**BAT_OrderSubmissionController End*******************/

    /**BAT_DeviceRegistration Begin*******************/ //- workitem 6005
    
    public final static String CASE_STATUS_CLOSED      ='Closed';
   
    /**BAT_DeviceRegistration End*******************/
    
    public final static String ERROR_STRING='ERROR: ';
    public final static String SPECIAL_STRING_D='%d%';
    
    /**************Class names begin*****************************/
   public final static String BAT_DEVICE_REG_CLASS ='BAT_DeviceRegistration';
   public final static String BAT_ORDER_ITEM_HANDLER_CLASS='BAT_OrderItemTriggerHandler';
   public final static String BAT_ANONYMIZED_ACCOUNT_CONTROLLER='BAT_AnonymizeAccountController';
   public final static String BAT_ANONYMIZED_ACCOUNT_BATCH='BAT_AnonymizeAccountBatch';
   public final static String BAT_ORDER_SUBMISSION_CONTROLLER='BAT_OrderSubmissionController';
   public final static String BAT_ORDER_TRIGGER_HANDLER='BAT_OrderTriggerHandler'; 
   public final static String BAT_LEAD_TRIGGER_HANDLER='BAT_LeadTriggerHandler';
   public final static String BAT_INTEGRATION_LOG_HANDLER_CLASS='BAT_IntegrationLogTriggerHandler';
   public final static String BAT_OPP_TRIGGER_HANDLER = 'BAT_OpportunityTriggerHandler';
   public final static String BAT_SURVEY_INVITEGENERATION_CLASS = 'BAT_GenerateSurveyInvitationController'; // US#8399 Configurable Manual Surveys - Flow A by Souvik D.
   public final static String BAT_BULK_TASK_GENERATION_CLASS = 'BAT_GenerateTaskFromReportController'; //US#34846 Added by Souvik D.
   public final static String BAT_CASETRIGGERHANDLER_CLASS = 'BAT_CaseTriggerHelperNB'; //US#44705 Added by Satya Nalluri.
   
   /**************Class names end*****************************/
   
   /******************Method Names begin************************/
      public final static String BAT_DEVICE_REG_Method ='registerDevice';
      public final static String BAT_BUNDLE_AND_CREATE_METHOD='checkBundleAndCreateItems';
      public final static String ANONYMIZE_ACCOUNT_METHOD='anonymizeAccount';
      public final static String GET_ACCOUNT_METHOD='getAccount'; //Added as ForceReviewer change
      public final static String ANONYMIZE_LEAD_METHOD = 'anonymizeLead';
      public final static String GET_LEAD_METHOD = 'getLead'; //Added as ForceReview change
      public final static String GENERATE_ANONYMIZE_FILE_INSERT='generateAnonymizationFile (INSERT)';
      public final static String GENERATE_ANONYMIZE_FILE_UDATE='generateAnonymizationFile (UPDATE)';
      public final static String DELET_PRIVACY_SNAPSHOT='deletePrivacySnapshot';
      public final static String SUBMIT_ORDER='submitOrder';
      public final static String CONSUMER_STATUS_UK_PAYMENT='consumerStatusUkPayment';
      public final static String STR_CHAR_HYPHEN ='-';
      public final static String EMPTY_STRING = '';
      public final static String SINGLE_SPACE = ' ';
      public final static String DECREASE_PRODUCT_STOCK='decreaseProductStock';
      public final static String GENERATE_ASSET_FOR_DEVICE='generateAssetForDevice';
      public final static String ONBEOFRE_INSERT = 'OnBeforeInsert';
      public final static String ONAFTER_INSERT = 'OnAfterInsert';
      public final static String ONAFTER_UPDATE = 'OnAfterUpdate';
      public final static String GENERATE_PRIVACY_SNAPSHOT_PDF= 'generatePrivacySnapShotPDF';
      public final static String GENERATE_TASKSFOR_HYPERCAREBASIC= 'generateTaskForHyperCareBasic';
      public final static String MANAGE_HYPERCARE= 'manageHypercare';
      public final static String CHECK_DEVICE_NUMBER_ON_ACTIVATION='checkDeviceNumberOnActivation';
      public final static String CHECK_CONSUMBLE_FOR_BUNDLE='checkConsumablesForBundle';
      public final static String CHECK_ORDER_VALID_SUBMIT='checkOrderValidForSubmit';
      public final static String CHECK_DEVICE_QUANTITY='checkDeviceQuantity';
      public final static String CHECK_BUNDLE_QUANTITY='checkBundleProductQty';
      public final static String ON_BEFORE_INSERT='OnBeforeInsert';
      public final static String ON_BEFORE_DELETE='OnBeforeDelete';
      public final static String ON_AFTER_INSERT='OnAfterInsert';
      public final static String GENERATE_TASKS_ON_LEAD_NOTCOVERED = 'generateTasksOnLeadNotCovered_SEA_IT';
      public final static String CREATE_TASK_FOR_REPURCHASE = 'createTaskForRepurchaseDate';
      public final static String GENERATE_TASK_ON_TRIAL = 'generateTasksOnTrial_SEA';
      public final static String GENERATE_TASK_ON_AGENT = 'generateTasksOnAgent_SEA';
      public final static String BAT_SURVEY_INVITEGENERATION_GETACCOUNT = 'getAccount';// US#8399 Configurable Manual Surveys - Flow A by Souvik D.
      public final static String BAT_SURVEY_INVITEGENERATION_GETSURVEYDETAILS = 'getSurveyDetailsAndConfig';// US#8399 Configurable Manual Surveys - Flow A by Souvik D.
      public final static String BAT_SURVEY_INVITEGENERATION_GETCOMMUNITYID = 'getCommunityId';// US#8399 Configurable Manual Surveys - Flow A by Souvik D.
      public final static String BAT_BULK_TASK_GENERATION_GETTASKCONFIG = 'getBulkTaskGenerationConfig';//US#34846 Added by Souvik D.
      public final static String BAT_BULK_TASK_GENERATION_GETACCOUNTIDS = 'getAccountIdsFromReport';//US#34846 Added by Souvik D.
      public final static String BAT_BULK_TASK_GENERATION_CREATETASK = 'generateTask';//US#34846 Added by Souvik D.
      public final static String BAT_BULK_TASK_GENERATION_ISVALIDUSER = 'validateEmailAgainstUser';//US#34846 Added by Souvik D
   
      public final static String BAT_CASETRIGGERHANDLER_DELETECASE = 'deleteBouncedEmailcase'; //US#44705 Added by Satya Nalluri.
      public final static String RESOLVEDSELFLOOKUPONCHILDRECORDS = 'resolvedSelfLookupOnChildRecords'; //US#1043059, method reference added by Saurabh Sharma.
   /********************Method name end************************************/

   /**************Record Types Name Begin*********************/
      public final static String RECORD_TYPE_SOCIAL_Seller='Social Seller Sale';
   /****************Record Types Name End*******************/

   /****************Sobject Name Begin***************************/
      public final static String SOBJECT_ORDER='Order';
   /****************Sobject Name End**************************/
   
    // added as part of 31486
    Public final static String ORAL_VYPE_STATUS = 'Subscriber';
    public final static String VYPE_STATUS_CONSUMER = 'Consumer';
    public final static String ORAL_STATUS_TRIALIST   =  'Trialist';
   
     /**BAT_AnonymizeAccountController **/ // workItem 6003
     public final static String ANONYMOUS_RESULT = 'No Answer';
     public final static String ANONYMOUS_SENTIMENT = 'Neutral';
     public final static String ANONYMOUS_TRIAL_NAME = 'Trial -';
     public final static String SPECIAL_CHAR_PERCENTAGE = '%';
     public final static String ACCOUNT_NAME = 'Nome:';
     public final static String ACCOUNT_EMAIL = 'Email:';
     public final static String ACCOUNT_PHONE = 'Telefono:';
     public final static String ACCOUNT_DATE_BIRTH = 'Data di nascita:';
     public final static String ACCOUNT_GENDER = 'Sesso:';
     public final static String ACCOUNT_STATUS = 'Stato:';
     public final static String DOUBLE_SPACE = '   ';
     public final static String CONTENT_TYPE_TEXTPLAIN = 'text/plain';
     public final static String TYPE_TEXT = 'txt';
     //workitem-8593
     public static boolean isTriggerBypassed = false;
     public static boolean isAnonymized = false;
    public static boolean isForwardAnonymizedBypassDelete = false;
   //1703189-DE - multicategory Loyalty program - Anonymisation starts--
    public static boolean isBrandprofileAnonymized = false;
   //1703189-DE - multicategory Loyalty program - Anonymisation ends--
     public final static String RECORD_TYPE_SOCIAL_SELLER_ON_ORDER = 'Social_Seller_Sale';
     public final static String ORDER_STATUS_SUBMITTED = 'Submitted';
    public final static String ORDER_STATUS_SUBMIT = 'Submit';
     public final static String SELECT_ID = 'SELECT id';
     public final static String FROM_ACCOUNT = 'FROM Account WHERE Id IN';
     public final static String BOOLEAN_TYPE = 'Boolean';
     public final static String MULTI_PICKLIST_TYPE = 'MultiPicklist';//1947819
     public final static String HYPHEN_QUERY = '%-%';
     //workitem-6015
     public final static Double DOUBLE_ZERO = 0.0;
     public final static Integer NUMBER_HUNDRED = 100;
     public final static Integer NUMBER_TWO = 2;
     public final static String DATE_FORMAT_DDMMYY = 'dd/MM/yy';
     //workitem-6014
     public final static String SEMI_COLON = ';';
     public final static String GREATER_THAN_OPERATOR = '>';
     public final static String LESS_THAN_OPERATOR = '<';
     public final static String N_TRIAL = 'nTrial';
     public final static String N_LEAD = 'nLead';
     public final static String N_ASSEST = 'nAsset';
     public final static String GROUP_BY_OWNER = 'group by Owner.Name, OwnerId HAVING Count(Id) ';
     public final static String ASSET_AGGREGATE_QUERY1 = 'SELECT Count(Id) nAsset,Owner.Name,OwnerId ';
     public final static String LEAD_AGGREGATE_QUERY1 = 'SELECT Count(Id) nLead,Owner.Name,OwnerId ';
     public final static String TRIAL_AGGREGATE_QUERY1 = 'SELECT Count(Id) nTrial,Owner.Name,OwnerId ';
     public final static String OWNER_ID_STR = 'OwnerId';
     public final static String ASSET_AGGREGATE_QUERY2 = 'FROM Asset WHERE Owner_Profile__c =\'';
     public final static String LEAD_AGGREGATE_QUERY2 = 'FROM Lead WHERE Owner_Profile__c =\'';
     public final static String TRIAL_AGGREGATE_QUERY2 = 'FROM Opportunity WHERE Owner_Profile__c =\'';
     public final static String QUERY_APOSTROPHE= '\'';
     public final static String COUNTRY_CLAUSE = 'AND Country__c=\'';
     public final static String QUERY_SURVEY_ActiveVersionId = ' AND ActiveVersionId != null';//Added as part of bug:171565
     public final static String TYPE_CLAUSE = 'AND Type__c=\'';
     public final static String STATUS_CLAUSE = 'AND Status=\'';
     public final static String STAGENAME_CLAUSE = 'AND StageName=\'';
     public final static String SUCCESS = 'success';
     public final static String ERROR = 'error';
     public final static String EMAIL_STR = 'EMAIL';
     public final static String STRING_STR = 'String';
     public final static String TEXTAREA_STR = 'TEXTAREA';
     public final static String DATETIME_STR = 'DATETIME';
     public final static String PHONE_STR= 'PHONE';
     public final static String BIRTH_DATE_API_STR = 'BirthDate__c';
     public final static String DATE_STR = 'DATE';
     public final static String PICKLIST_STR = 'PICKLIST';
     public final static String SOMETHING_ERROR_MESG = 'Something went wrong when submitting the order:';
    //Added for Germany Market
    public final static String VALID = 'Valid';
    public final static String NOT_CHECKED= 'Not checked';
    public final static String INVALID= 'Invalid';
    public final static String IN_PROGRESS = 'In progress';
    public final static String COMPLETED = 'Completed';
    // Namespaces for Soap Envelope 
    public final static String soapNS = 'http://www.w3.org/2003/05/soap-envelope';
    public final static String serviceNS = 'http://www.myservice.com/services/MyService/';
    public final static String v = 'http://www.postdirekt.de/schema/af/data/v_1_1';
    public final static String ser = 'http://service.v_1_1.direct.af.postdirekt.de/';
    public final static String wsse = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd';
    public final static String wsu = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd';
    
    //Added for integration 
    public final static String ENVELOPE_STR = 'Envelope';
    public final static String V_STR = 'v';
    public final static String SOAP_STR = 'soap';
    public final static String SER_STR = 'ser';
    public final static String SCHEMALOCATION_STR = 'SchemaLocation';
    public final static String HEADER_STR = 'Header';
    public final static String SECURITY_STR = 'Security';
    public final static String WSSE_STR = 'wsse';
    public final static String USERNAMETOKEN_STR = 'UsernameToken';
    public final static String WSUID_STR = 'wsu:Id';
    public final static String WSUID = '0fd17cd5-8b41-4201-8eaa-f03d4a77e06a';
    public final static String  XMLNS_WSU_STR = 'xmlns:wsu';
    public final static String  XMLNS_WSSE_STR = 'xmlns:wsse';
    public final static String USERNAME_STR = 'Username';
    public final static String PASSWORD_STR ='Password';
    public final static String TYPE_STR ='Type';
    public final static String TYPE_URL = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText';
    public final static String BODY_STR = 'Body';
    public final static String PROCESSDATA_STR = 'processData';
    public final static String CONFIGNAME_STR = 'configName';
    public final static String  INRECORD_STR = 'inRecord';
    public final static String NAMEITEM_STR = 'NameItem';
    public final static String VORNAME_STR = 'Vorname';
    
    public final static String ADRITEM_STR= 'AdrItem';
    public final static String HAUANSCHRIFT_STR = 'Hausanschrift';
    public final static String HAUSNR_STR = 'Hausnr';
    public final static String STRASSE_STR = 'Strasse';
    public final static String PLZ_STR = 'Plz';
    public final static String ORT_STR = 'Ort';
    public final static String BUNDESLAND_STR = 'Bundesland';
    public final static String LAND_STR = 'Land';
    public final static String POST_STR = 'POST';
    public final static String CONTENT_TYPE_STR = 'Content-Type';
    
    public final static String TEXT_XML_STR = 'text/xml';
    public final static String STATUSITEM_STR = 'StatusItem';
    public final static String STATUSCODE_STR ='StatusCode';
    public final static String MOV_STR = 'MOV';
    public final static String NEW_LEAD_DE_STR = 'New_Lead_DE';
    public final static String BLANK_STR = '';
    public final static String MOV = 'MOV';
    public final static String PDC = 'PDC';
    public final static String BAT_CRM_DE_USER = 'CRM Executive';
    public final static String LEAD_DE_STATUS_LOST = 'Lost';
    public final static String LEAD_DE_STATUS_NEW_NOTVERIFIED = 'New/Not Verified';
    public final static String LEAD_DE_STATUS_VERIFIED = 'Verified';
    public final static String LEAD_DE_STATUS_GUIDED_TRIAL = 'Guided Trial';
    public final static String LEAD_DE_STATUS_GUIDED_TRIAL_SURVEY = 'Guided Trial Survey';
    public final static String ACCOUNT_DE_TYPE_TRIALIST = 'Trialist';
    public final static String ACCOUNT_DE_TYPE_DIRECT_CONSUMER = 'Direct_Consumer';
    
    public final static String UNDERSCORE= '_';
    public final static String PERCENTAGE = '%';
    public final static String PDF ='.pdf';
    public final static String P_STR = 'P';
    
    // POST DEPLOYMENT SCRIPT VARIABLES FOR DE
    public final static String BAT_TWO_HOUR_REASSIGNMENT = 'Two Hour Reassignment';
    public final static String BAT_TWO_HOUR_REASSIGNMENT_CRON1 = '0 0 0';
    public final static String BAT_TWO_HOUR_REASSIGNMENT_CRON2 = ' ? * *';  
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN = 'Schedule for every 5 minutes';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON1= '0 00 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON2= '0 05 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON3= '0 10 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON4= '0 15 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON5= '0 20 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON6= '0 25 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON7= '0 30 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON8= '0 35 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON9= '0 40 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON10= '0 45 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON11= '0 50 * * * ?';
    public final static String BAT_SCHEDULE_FOR_EVERY_5_MIN_CRON12= '0 55 * * * ?';
    public final static String BAT_SCHEDULED_TWICE_A_DAY = 'Scheduled to run twice a day';
    public final static String BAT_SCHEDULED_TWICE_A_DAY_CRON1 = '0 0 11/12 * * ?';
    public final static String BAT_PENDING_LEAD_REASSIGNMENT = 'PendingLeadReassignment';
    public final static String BAT_PENDING_LEAD_REASSIGNMENT_CRON1 = '0 0 8 * * ? *';
    public final static String BAT_SCHEDULE_DELETE_BATCH = 'Schedule deleteBatch';
    public final static String BAT_SCHEDULE_DELETE_BATCH_CRON1 = '0 0 23 * * ? *';
    public final static String BAT_SCHEDULE_REWARD_PROFILE = 'Schedule rewardProfileBatch';
    public final static String BAT_SCHEDULE_REWARD_PROFILE_CRON1 = '0 0 0 1 * ? *';
    public final static String BAT_STR_1= '1';
    public final static String BAT_STR_2= '2';
    public final static String BAT_STR_3= '3';
    public final static String BAT_STR_4= '4';
    public final static String BAT_STR_5= '5';
    public final static String BAT_STR_6= '6';
    public final static String BAT_STR_7= '7';
    public final static String BAT_STR_8= '8';
    public final static String BAT_STR_9= '9';
    public final static String BAT_STR_10= '10';
    public final static String BAT_STR_11= '11';
    public final static String BAT_STR_12= '12';
    

    public final static String BAT_SEMICOLON_STR = ';';
    public final static String COUNTRY_DE_STR = 'DE';
    public final static String BAT_STATUS_REPORT = 'Status Report ';
    public final static String BAT_RETAILER_CSV = ' Retailer.csv';
    public final static String BAT_SOCIAL_SELLER_CSV = ' Social Seller.csv';
    public final static String BAT_STR_MINUS_1 = '-1';
    public final static String BAT_REWARD_REPORT = 'Reward Report ';
    public final static String BAT_STR_0 = '0';
    public final static String BAT_STR_200 = '200';
    public final static String BAT_PRODUCT_ASSIGNED = 'Product Assigned';
    public final static String BAT_GLO_GUIDE = 'Glo Guide';
    public final static String BAT_FIX = 'Fix';
    public final static String BAT_SURVEY_URL_STR1 = '?id=';
    public final static String BAT_SURVEY_URL_STR2 = '&cId=';
    public final static String BAT_SURVEY_URL_STR3 = '&caId=';
    public final static String BAT_SURVEY_URL_STR4 = '&accId=';
    public final static String BAT_SURVEY_URL_STR5 = '&leadId=';
    public final static String BAT_CONTACT_OBJ = 'Contact';
    public final static String BAT_NONE = 'None';
  //12/04/2019/US-13171, Abhishek Kashyap/Updated the variable with new case recordtype name for THP/Glo for DE
    public final static String BAT_CASE_THP_RECORDTYPE_DE = 'BAT_Case_THP';
    public final static String COUNTRY_MX_STR = 'MX';//Added as part of US 33838 
      
    public final static String BAT_CASE_RECORDTYPE_DE = 'BAT Case DE';
    public final static String BAT_LEAD_RECORDTYPE_DE = 'New Lead DE';
    public final static String LEAD_RECORDTYPE_NEW = 'New';//Added as part of US11122
    public final static string RECORDTYPEID ='RecordTypeId';//Added as partof US11122
    public final static String BAT_UNIT_TEST = 'Unit.Test';
    public final static String BAT_ID = 'Id';
    public final static String BAT_TITLE = 'title';
    public final static String BAT_TRIAL_HYPHEN = 'Trial - ';
    public final static String TRIAL_DEVICE_RETURNED_DAMAGED = 'Yes - Damaged';
    public final static String BAT_ASSET_RETURNED = 'Returned';
    public final static String BAT_ASSET_RETURNED_STR_HYPHEN = '- Returned - ';
    public final static String BAT_ORDER_STATUS_CREATED = 'Created';
    public final static String BAT_ACCOUNTID_STR = 'AccountId';
    public final static String BAT_SUMAMOUNT_STR = 'sumAmount';
    public final static String TRIAL_STAGE_OPEN ='Open';
    public final static String SELECT_STR = '---Select---';
 
    public final static String JANUARY_STR = 'January';
    public final static String FEBURARY_STR = 'February';
    public final static String FEBRUARY_STR = 'February';
    public final static String MARCH_STR = 'March';
    public final static String APRIL_STR = 'April';
    public final static String MAY_STR = ' May';
    public final static String JUNE_STR = 'June';
    public final static String JULY_STR = 'July';
    public final static String AUGUST_STR = 'August';
    public final static String SEPTEMBER_STR = 'September';
    public final static String OCTOBER_STR = 'October';
    public final static String NOVEMBER_STR = 'November';
    public final static String DECEMBER_STR = 'December';
    public final static String PHONE_VERIFIED_API_NAME ='Phone_Verified__c';
    public final static String BYPASSMOBILEVERIFICATION_API_NAME ='BAT_BypassMobileVerification__c';
    //Added as part of US37556
    //updated PersonMobilePhone__c to PersonMobilePhone as part of bug#125977
    public final static String BAT_ACC_LEAD_PHONE_COMPARE_STR = ' AND PersonMobilePhone =: leadMobilePhone';
    public final static String BAT_ACC_LEAD_EMAIL_COMPARE_STR = ' AND personemail =: leadEmail';//Added as part of bug#125977
    public final static String DEVICE_RETURNED_NO = 'No';
    public final static String BAT_BRAND_HOUSE_GLO = 'Glo';
    public final static String BAT_BRAND_HOUSE_VYPE = 'Vype';
    public final static String BAT_BRAND_HOUSE_VUSE = 'Vuse';
    public final static String BAT_BRAND_HOUSE_ZONNIC = 'Zonnic';
    public final static String BAT_BRAND_CODE_VYPE = 'VYP';
    public final static String BAT_SUFFIX_FAKE = '-F'; 
    public final static String BAT_BRAND_HOUSE_FMC = 'FMC';
    //
    //02.02.2024/ Reema Meher/ #1625729 - SE Lead Conversion and Forward Anonymisation  
    public final static String BAT_BRAND_HOUSE_LYFT = 'Lyft';
    //public final static String BAT_BRAND_HOUSE_LYFT = 'LYFT';
     public final static String BAT_BRAND_HOUSE_Lundgrens = 'Lundgrens';
     public final static String BAT_BRAND_HOUSE_Moor = 'Moor';
     public final static String BAT_BRAND_HOUSE_Lab = 'Lab';
     public final static String BAT_BRAND_HOUSE_lyftsw = 'lyftsw';
    public final static String BAT_BRAND_HOUSE_PALLMALL = 'Pall Mall';
    public final static String BAT_BRAND_HOUSE_LUCKY = 'Lucky';
    public final static String VYPE_DEVICE_STR = 'Vype';
    public final static String VUSE_DEVICE_STR = 'Vuse';
    public final static String BAT_BRAND_HOUSE_AMP = 'AMP';
      //Added as part of CZ Lohyalty by Reema
    public final static String VELO_DEVICE_STR = 'Velo';
    public final static String COMBUSTIBLE_DEVICE_STR = 'Combustible';
    public final static String EPOKLYFT_DEVICE_STR = 'Epok/Lyft Status';
    public final static String TASK_STATUS_COMPLETED = 'Completed';
    public final static String STANDARD_CONTACT_STR = 'Contact';
    public final static String LEAD_CREATE_ACTION = 'Lead Creation';
    public final static String ASSET_REGISTRATION_ACTION = 'Asset Registration';
    public final static String ASSET_REASSIGN_ACTION ='Asset Reassign';
    public final static String ASSET_CREATED_FROM_CASE_ACTION = 'Asset_From_Case';
    public final static String BAT_CONSUMER_RECORDTYPE = 'BAT_Consumer';
    public final static String ASSET_AUTONUMBER = '000000';

    // added as part of US8207
     public final static String SMSTYPE_MGM = 'MGM';
     public final static String MGM_REWARD_CODE = '<mgm_code>';
     public final static String REWARPROFILE_TRIGGERHANDLER_CLASS = 'BAT_RewardProfileTriggerHandler';
     public final static String SEND_MESSAGE_METHOD ='sendMessage';
     public final static String PHONE_NUMBER = 'Phone Number :';
     public final static String ERROR_STATUS = 'Status';

     //US-13916: to move the headers into metadata
     public final static String INVOICE_HEADER = 'Invoice';
     public final static String RECEIPT_HEADER = 'Receipt';
     public final static String PAGE_TYPE      = 'pageType';
     //As part of the  10254.
     public final static String PLUS_SIGN = '+';
     public final static String SMSTYPE_REDEM = 'Redeemable';     
     public final static String NORMAL_STR = 'Normal';  
    public static final String OPEN_PARENTHESIS_STR = '(';
    public static final String CLOSED_PARENTHESIS_STR = ')';
    //BAT_GLOBALSEARCHCONTROLER
    public static final String SOSL_FIND_STR = 'FIND \'';
    public static final String SOSL_ALLFIELDS_STR = '\' IN ALL FIELDS RETURNING ';
    public static final String SOSL_EMAIL_STR = '\' IN EMAIL FIELDS RETURNING ';
    public static final String SOSL_NAME_STR = '\' IN NAME FIELDS RETURNING ';
    public static final String SOSL_PHONE_STR = '\' IN PHONE FIELDS RETURNING ';
    public static final String SOSL_SIDEBAR_STR = '\' IN SIDEBAR FIELDS RETURNING '; 
    public static final string WILDCARD_STAR ='*';//Added as part of US19191
    public static final string SOSL_WHERE =' where ';//Added as part of US19191
    public static final string SOSL_LIKE =' like ';//Added as part of US19191
     //process builder converted to trigger
     //Process Builder - BAT Asset: give points test
    public final static String ACTION_NAME_1 = 'IT_RewardProfile_Tobacconist'; 
    public final static String ACTION_NAME_2 = 'IT_RewardProfile_GloStore';
    public final static String ACTION_NAME_3 = 'IT_SellingRewardProfile_GloStore'; 
    public final static String ACTION_NAME_4 = 'CaseSubstitution_Reward'; //Added as part of US24705 by Souvik D.
    public final static String ACTION_NAME_5 = 'Global_RewardProfile_Tobacconist';
    public final static String ACTION_NAME_6 = 'Global_SellingRewardProf_Eq_RewardProf';
    public final static String ACTION_NAME_7 = 'Global_SellingRewardProfile';
    public final static String ACTION_NAME_8 = '_SellingClonedWebAsset';//Added as part of Bug129733
    public final static String ACTION_NAME_REWARDPROFILE_POSAGENT = 'IT_RewardProfile_POSAgent';//Added as part of US23928
    public final static String ACTION_NAME_SELLINGREWARDPROFILE_POSAGENT = 'IT_SellingRewardProfile_POSAgent';//Added as part of US23928
    public final static String ASSET_GENERIC_ACTION_NAME_FOR_POINT = '_SellingRewardProfile'; //Added as part of US116614
    public final static String ASSET_SF_CONDITION_FOR_POINT = '_SFAsset'; //Added as part of US116614
    public final static String ASSET_CLONE_CONDITION_FOR_POINT = '_AssetClone'; //Added as part of US116614
    public final static String ASSET_WEB_CONDITION_FOR_POINT = '_WebAsset'; //Added as part of US116614
    public final static String ASSET_GENERIC_ACTION_NAME_FOR_CLUSTER = '_Cluster'; //Added as part of US227850
    public final static string STR_COLON = ':'; //Added as part of US116614
    public final static String TOBACCONIST_NO_APP= 'Member Get Member';
    public final static String REWARD_PROFILE_GLO='Glo'; //Added as part of US48488 
    public final static String REWARD_PROFILE_POS='POS'; // Added as part of US48488 
    public final static String STR_CLONE = 'CLONE';//Added as part of US48270 by Rajesh.
    public final static String TYPE_1 = 'Type 1';
    public final static String TYPE_2 = 'Type 2';
    public final static String TYPE_3 = 'Type 3';
    public final static String SCENARIO_1 = ' S1';
    public final static String SCENARIO_2 = ' S2';
    public final static String SCENARIO_3 = ' S3';//Added as part of US48270 by Rajesh.
  public final static String SCENARIO_3A = ' S3A';
    public final static String SCENARIO_3B = ' S3B';
    public final static String SCENARIO_4 = ' S4';
    public final static String SCENARIO_5 = ' S5';
    public final static String RETAILER_PROFILE= 'BAT_Retailer';
    public final static String NOT_ANSWERED = 'Non risponde alla telefonata';
    public final static String CONTACTED_NOT_AVAILABEL_FOR_MEETING = 'Risponde alla telefonata, ma al momento non disponibile a incontro';
   //14069
    public static final set<string> SEA_COUNTRY = new set<String>{'IT','PT','GR'};
     //added as part of US#5397
    public static final String SELECT_ACCOUNT_ID ='select id,PersonContactId';
    public static final String QUERY_WHERE_CONDITION = 'from Account where (Id IN :accountIdSet OR PersonContactId IN :personContactIdSet) and Country__c IN :countrySet';
    public static final String QUERY_WHERE_CONDITION_ACCOUNT = ' from Account where Id IN : accIdSet';
    //1703189-DE - multicategory Loyalty program - Anonymisation starts--
    public static final String QUERY_WHERE_CONDITION_BRANDPROFILE = ' FROM BAT_BrandProfile__c WHERE BAT_Account__c IN :accIdSet';
   //1703189-DE - multicategory Loyalty program - Anonymisation ends--
    public static final String QUERY_WHERE_CONDITION_LEAD = ' from Lead where Id IN : leadIdSet';
    public static final String SELECTSTRING = 'SELECT ';
    public static final String QUERY_LEAD = 'Id,Brand_House__c,BAT_OralStatus__c,Country__c';
    public static final String QUERY_ACCOUNT = 'Id,Brand_House__c,BAT_OralStatus__c,personMobilePhone,Country__c';
    public static final String OWNER_STR ='Owner';
    public static final String OWNER_DOT_STR = 'Owner.';
    public static final String TASK_TRIGGER_NAME ='BAT_TaskTrigger';
    public static final String TASK_ON_BEFORE_EVENT ='On Before Insert';
    public static final String TASK_ON_BEFORE_UPDATE_EVENT ='On Before Update';
    // ending US#5397
    /*Added by Usha on 24/04/2019: For Class "BAT_GlobalSearchController"*/
    public final static String BAT_VAPECATEGORY = 'Vape';
    public final static String BAT_ORALCATEGORY = 'Oral';
    public final static String ACTION_PRODUCT= 'AddProduct';
    public final static String ACTION_PRODUCTINTEREST= 'AddProductInterest';
    public final static String PRODUCT_RECTYPE ='Product';//UK US:#16278
    
      /*Added by Sudaif for UK US #16274*/ 
     public static final String BAT_OWNSTORE_PRICEBOOK_UK = 'Own Store Pricebook UK';

    public static final String BULK_SMS_NAMED_CREDS_PROD = 'callout:BAT_Bulk_SMS_Settings_Production';
    public static final String LEAD_MEETING_RESULT_SUCCESSFUL = 'Meeting successful'; //Added by Souvik D. for US#14869 Lead conversion improvement
    public static final String FREETRIAL = 'FREETRIAL'; //Added by Usha for US:13592
    public static final String Surveys = 'Surveys'; //UK US#16275/Neha
    public final static String Relation_Type = 'ToAddress';
    public final static String BAT_DE_Glo_Email_Case_Queue_STR = 'BAT_DE_Glo_Email_Case_Queue';
    public final static String BAT_DE_Vype_Email_Case_Queue_STR = 'BAT_DE_Vype_Email_Case_Queue';
    public final static String BAT_DE_None_With_Dash = '--- None ---';
   
    //12/04/2019/US-13171, Abhishek Kashyap/Added the variable with new case recordtype name for Vype for DE
    public final static String BAT_CASE_Vype_RECORDTYPE_DE = 'BAT_Case_Vype';
    //19/04/2019/US-19460, Abhishek Kashyap/For DE added the variable, 'eCom Deleted' for all category (THP, Vape, Oral, Combustible)
    public final static String BAT_Account_eComDeleted_DE_STR = 'eCom Deleted';
    public final static String BAT_BRAND_HOUSE_EPOK = 'EPOK';
    
    //16-05-2019 Nancy: Added the value for order status to avoid hardcoding
    public final static string BAT_OrderStatus_Refunded = 'Refunded';
    //US #1043064 : Sameer Ranjan
    public final static string BAT_ORDER_STATUS_CANCELED = 'Canceled';
    public final static String BAT_OrderRT_ECOMMERCE = 'Ecommerce';
    // added as part of 25784
    public static final String NEA_STR = 'NEA';
    /******Added by Osheen Sahajpal - US-22549, 22705, 22707 - Personal Authorization check fields*******/
    public static final String DK_STR = 'DK';
    public static final String SE_STR = 'SE';
    public static final String NL_STR = 'NL';
    public static final String BAT_CRM_NEA_USER_STR = 'Digital Manager - NEA';
    public static final String BAT_LastModifiedSource_FieldAPI = 'Last_Modified_Source__c';
    
    //26.10.2023/Lalit/US-1520627, SE/DK - AMP :added set of NEA profile 
    public static final set<string> NEA_PROFILE_SET=new set<string>{'BAT BI & Analytics User - NEA','BAT Careline Manager - NEA','BAT CRM Digital Manager - NEA'};
        
    //added as part of 27175
    public final static String BAT_NEA_LASTMODIFIEDSOURCE_1to1Portal = '1:1 Portal';
    public final static String BAT_NEA_PRICEBOOK_CHANNEL_1to1Portal = '1:1 Personnel';
    public final static String BAT_NEA_PORTAL_PROFILE_TYPE = 'Portal';
    //Added for NEA US Sprint2 #25780 
    public final static String NEA_PORTAL_CLASSS ='BAT_NEAAccountCreationController';
    public final static String NEA_PORTAL_METHOD = 'addProductInterest';
    //NEA:Sprint2:US#25770/June20th,2019/Used in OrderTriggerHandler
    public static final String SOURCE_WHERE_CONDITION = 'from Account where Id IN :accIdSet' ;
    //NEA:Sprint2:US#25772/25773/June21st,2019/User in BAT_NEAAccountCreationController
    public final static String SECTION_CONSUMER_DETAILS = 'CONSUMER DETAILS'; 
    public final static String SECTION_VYPE_CONSENT = 'VYPE CONSENT';
    public final static String SECTION_LYFT_CONSENT = 'LYFT CONSENT';
    public final static String SECTION_EPOK_CONSENT = 'EPOK CONSENT';
    public final static String SECTION_HIDDEN_FIELDS = 'HIDDEN FIELDS';
    //NEA:Sprint3:US#25775/July1st,2019/Used in BAT_NEAAccountCreationController
    public final static Double DECIMAL_ONE = 1.00;
    public static boolean BYPASS_ORDERITEM_TRIGGER = false;
    //NEA:Sprint-4:US#31478/Used for Email-to-Case Field stamping
    public final static String BAT_CASE_GeneralEnquiry_RECORDTYPE = 'BAT_GeneralEnquiry';
    public final static String BAT_Case_OwnerIdAPI = 'OwnerId';
    public final static String BAT_GROUP_STR = 'Group';
    public final static String BAT_INCOMING_EMAIL_EVENT = 'Incoming Email';
    public final static String BAT_REPLACE_STRING_CaseNumber = '{{CaseNumber}}';
    public final static String BAT_EMAIL_MESSAGE_TRIGGER = 'BAT_EmailMessageTrigger';
    public final static String BAT_ON_AFTER_INSERT_EVENT = 'On After Insert';
    
    //Cases status added by Souvik D.
    public final static String CASE_STATUS_CLOSED_STR = 'Closed';
    //NEA:Sprint-4:US#35139/String for order-type = trial
    public final static String BAT_ORDER_TYPE_TRIAL = 'Trial';
    //06/06/2019/Abhishek Kashyap/US-20938/Added string for EPOK case queue
    public final static String BAT_DE_EPOK_Email_Case_Queue_STR = 'BAT_DE_EPOKEmailCaseQueue';
    //29/07/2019/Divya Eduvulapati/US-34394/Added string for LYFT case queue
    public final static String BAT_AT_LYFT_Email_Case_Queue_STR = 'BAT_AT_LYFTEmailCaseQueue';
    public final static String LOCATION_STR = 'location';
    public final static String LAT_STR = 'lat';
    public final static String LNG_STR = 'lng';
    public final static String ADDRESS_STR = '#address#';
    //07/06/2019/Abhishek Kashyap/ US-20938/ For DE added the variable for EPOK recordtype on Case
    public final static String BAT_CASE_EPOK_RECORDTYPE_DE = 'BAT_Oral';
    //17/06/2019/Abhishek Kashyap/ Added string for goecodescheduler job and cron expression for once a day at midnight
    public final static String BAT_SCHEDULE_UpdateGeoCodeScheduler = 'Schedule BAT_BatchToUpdateGeocodes Batch';
    public final static String BAT_SCHEDULE_UpdateGeoCodeScheduler_CRON = '0 0 * * * ? *';
    //Platform event constant variables
    public static final String EVENT_CREATE = 'CREATE';
    public static final String EVENT_UPDATE = 'UPDATE';
    public static final String EVENT_DELETE = 'DELETE';
    public static final String STANDARD_LEAD_STR = 'Lead';
    //04.07.2019/Abhishek Kashyap/US - 20647 / Added String for Austria country code
    public final static String COUNTRY_AT_STR = 'AT';
    /******Added by Ushabala Kanduru | US #39009 ******/
    public static final String BAT_EXECUTIVE_DE = 'BAT Executive - DE';
    public static final String BAT_EXECUTIVE_AT = 'BAT Executive - AT';
    //09/08/2019/Abhishek Kashyap/ Added string for Brand "Velo" and initial of english language
    public final static String BAT_BRAND_HOUSE_VELO = 'Velo';
    public static final String USER_LANGUAGE_ENGLISH = 'en';
    //28/08/2019 Mohit Maghanani Added to use in profile for lead/account mobile validation code
    public final static String PROFILE_SYS_ADMIN_MX = 'BAT System Administrator - MX';
    //29/10/2019/Rajesh/US-53692 Added string to Store Case status and Record type for Case creation
    public final static String CASE_DEVICE_REGISTRATION = 'Device Registration';
    public final static String CASE_BAT_Case_Device_Registration = 'BAT_Case_Device_Registration';
    public final static String CASE_SOURCE_WEBSITE = 'Website';

    public final static String OTH_CONSUMER = 'Consumer';
    //24.04.2020/Tejaswi Nissankula/KZ:Glo:US#116546 - Start
    public final static string STR_HASH = '#';
    public final static string STR_AMPERSAND = '&';
    //24.04.2020/Tejaswi Nissankula/KZ:Glo:US#116546 - End
    
    //10-09-2019/Osheen Sahajpal/MX:US-44080-Added constants to create exact match query
    public final static String QUERY_EQUALTO = '=';
    public final static String QUERY_OR = 'OR';
    //10-09-2019/Osheen Sahajpal/MX:US-44080-End
    public static boolean isProdInterestRecInserted = false; 
    public static boolean isVeloLeadConvertedToTrailist = false;
    //14/10/2019/Osheen Sahajpal/ES:Sprint-1/US-49279 Added string to Store Related_Lead__r.Name string for privacy snapshot.
    public static String ATH_RELATED_LEAD_NAME_API = 'Related_Lead__r.Name';
    public static String ATH_RELATED_LEAD_API = 'Related_Lead__c';
    public static String ATH_RELATED_LEAD_BRANDHOUSE_API = 'Related_Lead__r.Brand_House__c';
    public static String COUNTRY_ES = 'ES';
    //06-10-2020/Mallik Balla/PL:US-134684-Added Constants for Field Match    
    public static String COUNTRY_PL = 'PL';
    //24-09-2019/Osheen Sahajpal/MX:US-47032-Added Constants for Field Match
    public final static String IsVypeOptInEmailCommunication_API_Name = 'BAT_IsVypeOptInEmailCommunication__c';
    public final static String IsVypeOptInMobileTextWhatsApp_API_Name = 'BAT_IsVypeOptInMobileTextWhatsApp__c';
    public final static boolean BOOLEANTRUE = true; 
    public final static boolean BOOLEANFALSE = false;
    public final static String BAT_FLAGSHIP_MX = 'BAT Flagship - MX';
    public final static String BAT_MX_LASTMODIFIEDSOURCE_OwnKiosks = 'Own Kiosks';
    
    //28/08/2019 Satya Nalluri Added to use in profile check for lead/account to show customform
    public final static String PROFILE_FlagShip_MX = 'BAT Flagship - MX';
    public final static String SECTION_CONSENT = 'Consentimiento';
    public final static String SECTION_CONSUMER_BRAND_DETAILS ='Detalles de Marca del Consumidor';
    public final static String SECTION_CONSUMER_ADDRESS_DETAILS ='Dirección del Consumidor';
    public final static String SECTION_ORDER_DETAILS ='detalle de la orden';
    public final static String SECTION_CONSUMER_CONSENT_DETAILS ='Consentimiento';
    public final static String SECTION_CONSUMER_DETAILS_MX = 'Detalles del Consumidor';
    public final static String SECTION_LYFT_CONSENT_MX = 'Consentimiento Lyft';
    public final static String SECTION_SYSTEM_INFORMATION ='Información de Sistema';
    
    public final static String SECTION_LEAD_DETAILS = 'Detalles de Candidato';
    public final static String SECTION_LEAD_BRANDSTATUS = 'Status de Candidato';
    public final static String SECTION_LEAD_CONSENTDETAILS = 'Consentimiento';
    public final static String SECTION_LEAD_ADDRESSDETAILS = 'Dirección de Candidato';
    public final static String SECTION_LEAD_SYSTEMINFORMATION = 'Información de Sistema';
    
    //65227 : Salesforce Marketing Cloud User
    Public static String MARKETINGUSER = 'integrationuser_marketingcloud@bat.com';
    
    public final static String ORDERITEM_STR = 'OrderItem'; //US#34462 - Added to use standard object name
    public final static String SAP_CPI_INTEGRATION_USER_UA = 'SAP CPI Integration User UA'; //US#34462 Added to bypass SAP UA user for entry code valition
    public final static String CASE_DELETE_ERROR = 'You are not allowed to delete this record!';
    public final static String CASE_DELETION_PERMISSION_SET = 'BAT_Case_Deletion_Permission';
    public final static String PERSON_ACC_HISTORY_DELETE_PERMISSION = 'BAT_PersonAccountHistoryDeletionPermission';
    public final static String RO_LANGUAGE_LOCALE_KEY = 'ro';
    public final static String IT_LANGUAGE_LOCALE_KEY = 'it'; //US283178 pdf Localisation
    //67108: Added Canada market string for code usage.
    public final static String COUNTRY_CA_STR = 'CA';
    public static string Mulesoft_Integration_UserName ='mulesoft_integration_user@bat.com';
    // Bug # Add key variable to mapAggregates fro, BAT utilities
    public final static String ASSET_AGGREGATE_ASSETS = 'assets';
    public final static String ASSET_AGGREGATE_ACCOUNTID = 'accountId';
    public final static String ASSET_AGGREGATE_BRAND = 'brand';
    
    //Added for Email Verification
    public final static String VALID_CATCHALL = 'Valid_CatchAll';
    public final static String EMAILVERIFICATION_STATUS_VERIFIED = 'Verified';
    public final static String EMAILVERIFICATION_STATUS_INVALID = 'Invalid';
    public final static String EMAILVERIFICATION_STATUS_BYPASSED = 'Bypassed';
    public final static String TEMPORARY_EMAIL_FIELD_API = 'BAT_VerifiedEmail__c';
    public final static String EMAIL_VERIFIED_FIELD_API = 'Email_verified__c';
    public final static String EMAIL_VERIFICATION_STATUS_FIELD_API = 'BAT_EmailVerificationStatus__c';
    public final static String ACCOUNT_TEMP_EMAIL_FIELD_API = 'Email__c';
    public final static String EMAILVERIFICATION_STATUS_VALIDDOMAIN = 'Verified domain only';
    
    //13-03-2020/Akshaya Sarvesh/Force Reviewer Changes
   public final static String LEAD_CONVERSION_QUERY = 'Select id,MobilePhone,Country__c,Brand_House__c,isConverted,BAT_THPStatus__c from Lead where Country__c != null and Country__c IN : uccabcountrySet and Brand_house__c !=null and mobilePhone != null and MobilePhone IN : phnNumberSet and isConverted = false';
   public final static String LEAD_STR1 = 'lead';   
   public final static String OBJ_QUERY1 = 'select id,Brand_House__c from ';
   public final static String OBJ_QUERY2 = ' = \'';
   public final static String OBJ_QUERY3 = '\' AND country__c=\'';
   public final static String DATE_STR1 = '; Date: ';
   public final static String ACCOUNT_STR = 'Account: ';
   public final static String SI_STR = 'si';
   public final static String RETURN_STR = 'Return';
   public final static String HTML_CODE = '<table style="margin-left: 20%; font-size: 18px; color: rgb(0, 0, 0);border: 1px solid black;"><tbody style="text-align: left;"><tr><th>First Name</th><th>Last Name</th><th>Status</th></tr>';
   public final static String HTML_TAG1 = '<tr><td>'; 
   public final static String HTML_TAG2 = '</td><td>';
   public final static String HTML_TAG3 = '</td></tr></tbody></table>';
   public final static String ACC_QUERY1 = 'SELECT Id,PersonMobilePhone__c,PersonEmail,Country__c,Brand_house__c,status__c,PersonMobilePhone,';
   public final static String ACC_QUERY2 = 'Trial_Information_Permission__c,Generic_Permission__c,BAT_IsVypeOptInEmailCommunication__c, BAT_IsVypeOptInMobileTextWhatsApp__c,Submit_Surveys_Permission__c FROM Account';
   public final static String ACC_QUERY3 = ' WHERE Country__c =: leadCountry';
   public final static String ACC_SELECTQUERY ='SELECT Id,Country__c, Brand_House__c FROM Account';//Added as part of Bug#125977
   public final static String READ_STR = 'Read';
   public final static String ACC_QUERY4 = 'SELECT Id, PersonMobilePhone, PersonEmail,Country__c,Brand_House__c FROM Account WHERE Country__c!= null AND Country__c IN: strCountrySet AND ';
   public final static String ANONYMOUS_IT = '@anonymous.it';
   public final static String MOBILE_PHONE = '300000000';
   public final static String ADDRESS_QUERY1 = 'BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, ';
   public final static String ADDRESS_QUERY2 = 'Street, City, State, PostalCode, Country, ';
   public final static String ISCONVERTED_FALSE = ' AND isConverted = False ';
   public final static String LEAD_RECORDTYPEDE = ' AND Recordtype.Name =\'New Lead DE\' ';
   public final static String SOQL_QUERYSTR1 = 'Select Id, Name,';
   public final static String SOQL_QUERYSTR2 = 'Address_Verification_Status_DE__c, Address_Verification_Date_DE__c, Reference_Request_ID_DE__c From ';
   public final static String SOQL_QUERYSTR3 = ' where Country__c =\'DE\' ';
   public final static String LEAD_QUERY = 'AND Address_Verification_Status_DE__c =: verificationStatus';
   public final static String CLASS_NAME = 'BAT_AddressVerification_DE';
   public final static String METHOD_NAME = 'submitLeadsForAddressVerification';
   
    //US#79530 - Hyper GRATIS string
    public static String HYPER_GRATIS ='Hyper GRATIS';
     //US#85982 - Hyper String
     public static String HYPER = 'Hyper';
    //BUG-83933/Abhishek Kashyap/Added query strings for survey.
    public final static String SURVEY_QUERY = 'Select Id,Name From Survey WHERE ';
    public final static String CREATEDBY = 'CreatedBy';
    public final static String DOT = '.';
    public final static String REGION = 'BAT_Region__c';
    //US#93279 Added by Idrees Ali for caseFieldUpdateBasedOnMapping() method to store Dynamic Query Strings
    public final static String SELECT_STRING = 'SELECT ';
    public final static String ACCOUNT_WHERE_CLAUSE_ON_PERSONCONTACTID = 'PersonContactId FROM Account Where PersonContactId IN: contactIdSet AND RecordTypeId != : retailerRecordTypeId AND LastName != \'anonymous\'';

    //Bug#123022-SatyaNalluri-Created variable to refer IT mulesoft user name while registering device
    public static string Mulesoft_Integration_IT_UserName = 'mulesoft_integration_user_it@bat.com';
    
    //ENH: US#71391 - Custom metadata fields used for Apigee Auth Provider Configuration.
    public static final String APIGEE_CUSTOM_MDT_NAME = 'BAT_ApigeeAuthProviderConfig__mdt'; 
    public static final String APIGEE_CONFIG_FIELD_CALLBACK_URL = 'BAT_CallbackURL__c';
    public static final String APIGEE_CONFIG_FIELD_PROVIDER_NAME = 'BAT_AuthProviderName__c';
    public static final String APIGEE_CONFIG_FIELD_AUTHTOKEN_URL = 'BAT_AccessTokenURL__c';
    public static final String APIGEE_CONFIG_FIELD_CLIENT_ID = 'BAT_ClientId__c';
    public static final String APIGEE_CONFIG_FIELD_CLIENT_SECRET = 'BAT_ClientSecret__c';
    public static final String APIGEE_CONFIG_FIELD_SCOPE = 'BAT_Scope__c';
    public static final String APIGEE_CONFIG_FIELD_AUTHORIZATIONKEY = 'BAT_AuthorizationKey__c';
    public static final String APIGEE_CONFIG_FIELD_USE_JSON = 'BAT_UseJSON__c';
    //1830001-DE - multicategory Loyalty - Asset Lookup starts--//
    public static final String UNIQUE_IDENTIFICATION_KEY_STR='BAT_UniqueIdentificationKey__c';
    public static final String UNIQUE_IDENTIFICATION_KEY_VALUE='Asset-DE';
      //1830001-DE - multicategory Loyalty - Asset Lookup ends--//
    //ENH: US#71391 - Names of parameters to be set in HTTP Request while carrying out a callout through APEX
    //and setting a redirect URL while authenticating the user
    //These paramters are configured for client credentials type authentication
    public static final String CLIENT_ID_PARAM = 'client_id';
    public static final String CLIENT_SECRET_PARAM = 'client_secret';
    public static final String SCOPE_PARAM = 'scope';
    public static final String GRANT_TYPE_CLIENT_CREDS = 'client_credentials';
    public static final String RESOURCE_CALLBACK = '/services/authcallback/';
    public static final String DEFAULT_TOKEN_TYPE = 'BearerToken';
    public static final String ENCODING_XML = 'application/x-www-form-urlencoded;charset=UTF-8';
    public static final String ENCODING_JSON = 'application/json';
    public static final String DUMMY_CODE = '999';
    public static final String GRANT_TYPE_PARAM = 'grant_type';
    public static final String CONTENT_LENGTH_PARAM = 'Content-Length';
    public static final String AUTH_STATE_PARAM = 'state';
    public static final String AUTH_CODE_PARAM = 'code';
    public static final String ITEMS_STRING = 'Items';
    public static String APIGEE_EMAIL_VERIFICATION_NAME ='BAT_ApigeeAuthProvider';
    public static String APIGEE_MOBILE_VERIFICATION_NAME ='BAT_ApigeeAuthProviderSMS';
    
    public static final String STATUS_VALIDITY = 'ResponseCode';
    public static final String EMAIL_VERIFICATION_CONTROLLER = 'BAT_EmailVerificationController';
    public static final String EMAIL_VALIDATION_THROUGH_EXTERNAL_API = 'emailValidationThroughExternalAPI';
    public final static String TRUE_STRING = 'true';//Added as part of SE:Lyft Kitchen : US121527
    
    //Added as part of ForceReviewer report- To remove hard coded values.
    public final static String CHATTER_STRING = 'Chatter';
    public final static String EMPTYVAL_STRING = 'empty';
    public final static String NONE_STRING = 'none';
    public final static String FALSE_STRING = 'false';
    public final static String ANONYMOUS_STRING = 'Anonymous';
    public final static String SURVEYWITHQUESTIONRESPONSES_STRING = 'Survey with Questions and Responses';
    public final static String TRUEWITHCASESENSITIVE_STRING = 'True';
    public final static String SELECTOPTION_STRING = '--SELECT--';
    public final static String FALSEWITHCASESENSITIVE_STRING = 'False';
    public final static String SURVEYCSS_STRING = '#survey_container{margin: 10px}';
    public final static String EDIT_STRING = 'Edit';
    public final static String FEEDITEMMESSAGE_STRING = 'Could you take a look?';
    public final static String GENERATE_PRIVACY_SNAPSHOT_PDF_FUTURE = 'generatePrivacySnapShotPDF (future)';
    public final static String INVOICE_PDF_STRING = 'Invoice.pdf';
    public final static String RECEIPT_PDF_STRING = 'Receipt.pdf';
    public final static String FAKEUSERID_STRING = 'fakeUserId';
    public final static String GUEST_STRING = 'Guest';
    public final static String NORESPONSE_STRING = 'NO RESPONSE';
    public final static String NONEUPPERCASE_STRING = 'NONE';
    public final static String MULTI_SELECT_VERTICAL = 'Multi-Select--Vertical';
    public final static String SINGLE_SELECT_VERTICAL = 'Single Select--Vertical';
    public final static String FREETEXT_STRING = 'Free Text';
    public final static String FREETEXT_SINGLE_ROW_VISIBLE = 'Free Text - Single Row Visible';
    public final static String SINGLE_SELECT_HORIZONTAL = 'Single Select--Horizontal';

   public final static String USERNAME_ITGLO = 'testglo1@test.batdev';
   public final static String USERNAME_ITPOS = 'testpos1@test.batdev';
   public final static String SUCCESS_LABEL = 'SUCCESS';
   
   //Added for fix of ForceReviewer Violation '@AuraEnabled does not have proper error handling'
     public final static String GET_ACCOUNT_INPUT_FIELDS_METHOD = 'getAccountInputFields';
     public final static String FIND_PRODUCT_RANGE_METHOD = 'findProductRange';
     public final static String UPDATE_ACCOUNT_METHOD= 'updateAccount';
     public final static String ADD_ORDER_AND_ORDERITEM_METHOD= 'addOrderAndOrderItem';
     public final static String CREATE_VALID_ACC_SOURCE_VALUES_METHOD='createValidAccountSourceValues';
     public final static String BAT_NEW_BUTTON_OVERRIDE = 'BAT_NewButtonOverride';
     public final static String GET_REC_TYPE_ID = 'getRecTypeId';
     public final static String FETCH_REC_TYPE_VALUES_METHOD = 'fetchRecordTypeValues';
     public final static String BAT_NEW_TRIAL_CONTROLLER = 'BAT_NewTrialController';
     public final static String CHECK_DEVICES_METHOD = 'checkDevices';
     public final static String BAT_OWN_STORE_CONTROLLER = 'BAT_OwnStoreController';
     public final static String CHANGE_ACC_STATUS_METHOD = 'changeAccStatus';
     public final static String FETCH_SURVEY_DE_METHOD= 'fetchSurveyForGermany';
     public final static String BAT_TAKE_SURVEY_CONTROLLER_DE = 'BAT_TakeSurveyController_DE';
     public final static String LIGHTNING_SELF_REGISTER_CONTROLLER = 'LightningSelfRegisterController';
     public final static String SELF_REGISTER = 'selfRegister';
     public final static String GET_EXTRA_FIELDS_METHOD = 'getExtraFields';
     public final static String SET_EXPERIENCE_ID_METHOD = 'setExperienceId';
     public final static String GET_ACC_STATUS_METHOD = 'getAccStatus';
     
    public final static String GET_ALL_REPORT_MAP_STR = 'getAllReportMap';
    public final static String BULK_GENERATE_TASK_CONFIG = 'countryBasedBulkGenerateTaskConfig';
    public final static String IS_DIRECT_CONSUMER_METHOD = 'isOnlyDirectConsumerProfile';
    public final static String KPI_CONTROLLER_CLASS = 'BAT_KPI_Controller';
    public final static String GET_KPI_METHOD ='getKPI';
    public final static String UPDATE_KPI_METHOD = 'updateUserKPI';
    public final static String LIGHTNING_SEND_EMAIL_CLASS = 'BAT_LightningSendEmailButton_DE';
    public final static String SEND_MAIL_METHOD = 'sendMailMethod';
    public final static String LOGGEDIN_USRINFO_METHOD = 'getLoggedInUserInfo';
    public final static String DEFAULT_TO_ADRESS_METHOD = 'getDefaultToAddress';
    public final static String LOG_ACTIVITY_CONTROLLER_CLASS = 'BAT_LogActivityController';
    public final static String LOG_ACTIVITY_FROM_ACCOUNT_METHOD = 'logActivityFromAccount';
    public final static String LOG_ACTIVITY_FROM_LEAD_METHOD = 'logActivityFromLead';
    
    public final static String APIGEE_REVERSE_API_NAME ='BAT_ReverseAPIProvider';
    public final static String REVERSE_API_CLASS_NAME ='BAT_ReverseAPICallHandler';
    public final static String REVERSE_API_METHOD_NAME ='BAT_CallReverseAPI';
    public final static String REVERSE_API_ACCOUNT_DELETE_CONFIG = 'BAT_ReverseAPIForAccountDelete';
    public final static String FROM_STR = ' FROM ';
    public final static String sObjectString = ' Where ID IN: idSet';
    public final static String THIRDTIME_BUYER = 'Third Time Buyer';
    public final static String FIRSTTIME_BUYER = 'First Time Buyer';
    public final static String SECONDTIME_BUYER = 'Second Time Buyer';

    //27.11.2020/Nida Abshar Khan/ US 314624, value for BAT_UserCategory__c field
    public static String UNRESTRICTED = 'Unrestricted';
    
    public static String TOUR_PLAN_TRIGGER = 'BAT_TourPlanTrigger';
    //15June,2020/Abhishek Kashyap/US#134073-Added string for Queue
    public static String QUEUE_STR = 'Queue';
    public static String HOLIDAY_STR = 'Holiday';
    public static String ORDER_SOURCE_BRAND_AMBASSADOR ='Brand Ambassador';
    public static String APIGEE_REVERSE_ORDER_API_NAME ='BAT_ReverseAPIOrderProvider';
    
    //26/05/2020/Edwin Resendiz/Bug #37674- Added Range constant to Range__c from UK custom metadata
    public static final String FIELD_TO_COMPARE_RANGE ='Range__c';
    
    //25.08.2020/ Osheen Sahajpal /RO:Sprint-60:US #225174:Added batch class name and method name for Apex log creation
    public static final String EXECUTE_STR = 'execute';
    public static final String ACTIVATED_STATUSCODE = 'A';
    public static final String DELETEOLDACCOUNTBATCH_COUNTRYFILTER = '(Country__c = \'';
    public static final String DELETEOLDACCOUNTBATCH_DATEFILTER = '\' AND createdDate >= ';
    public static final String DELETEOLDACCOUNTBATCH_CONSENTFILTER = ' <= ';
    public static final String DELETEOLDACCOUNTBATCH_ANDLOGIC = '\' AND ';
    public static final String DELETEOLDACCOUNTBATCH_RECORDTYPEFILTER = 'RecordType.DeveloperName = \'';
    public static final String UPDATE_ORDER_TO_DRAFT_METHOD = 'updateOrderStatusToDraft';
    public static final String BAT_UTILITIES_CLASS = 'BAT_Utilities';
    
    //27Th Aug, 2020/Abhishek Kashyap/ENH_227912,RO - Update logic for account anonymization
    //25th April, 2021/Abhishek Kashyap/Bug-567747-Updated the query string, to get the account fields required to trigger rev int for RO accounts with Orders to sync consent updates
    public final static String QUERY_ID_ACCOUNTID_FROM_ORDER = 'Select Id, AccountId, Country__c, Account.BAT_ExternalCustomerID5__c, Account.BillingCity, Account.BillingState, Account.External_Customer_ID3__c, Account.FirstName, Account.Gender__c, Account.LastName, Account.PersonBirthdate, Account.PersonEmail, Account.PersonMobilePhone, Account.Brand_House__c From Order Where ';
    public final static String ACCOUNTID_IN = ' AccountId In : accountList ';
    public final static String CREATEDDATE_GREATER_THAN = ' CreatedDate >=';
    public final static String AND_STRING = ' And ';
    public final static String OR_STRING = ' OR ';
    public final static String COUNTRY_STRING_WITHOUT_BRACKET = 'Country__c = \'';
    
    //7th Sep,2020/Abhishek Kashyap/ENH-US-266132-SE lyft >> own store portal update
    public final static String ACCOUNT_C_STRING = ' Account__c ';
    public final static String IN_ACCOUNT_ID_SET=' In :setAccId ';
    public final static String SURVEY_TAKER_STRING = 'SurveyTaker__c';
    public final static String ORDER_BY_STRING = ' Order By ';
    public final static String CREATEDDATE_STRING = ' CreatedDate ';
    public final static String DESC_STRING = 'DESC';
    public final static String LIMIT_STRING = ' Limit ';
    
     //14-10-2020/Sandeep Joshi/ZA:sprint 2:US #284782-Added ZA Country Constants for code Usage.    
    public static String COUNTRY_ZA = 'ZA';
    
      //21-10-2020/Sandeep Joshi/ZA:sprint 2:US #298182 Added Brand Check Constant for code usage.    
    public final static String TWISP_DEVICE_STR = 'Twisp';
    
    //23-10-2020/sandeep joshi/ZA:sprint 3 Added constant for use in code
    public final static String ZAPORTALPROFILENAME = 'BAT 1:1 Portal User - ZA';
        public final static String ACTIVATIONS = 'Activations';
    //27th Oct, 2020/Abhishek Kashyap/ Added constants as part of 285430
    public final static String CREATERECORDFORMCONTROLLER_STR = 'BAT_CreateRecordFormController';
    public final static String SAVERECORS_STR = 'saveRecords';

    //added by Allada Yeshwanth for CZ Market
    public final static String INTERNATIONAL_MOBILE_VALIDATION_REC_NAME = 'Global';
    public final static String COUNTRY_CZ = 'CZ';
    // Added by Roopa for CZ : Sprint 2: US#290302 
    public final static String NONCONVERTED_LEAD_QUERY = 'Select id,MobilePhone,Country__c,Brand_House__c,isConverted from Lead where Country__c != null and Country__c IN : uniquePhnNumCountrySet and Brand_house__c !=null and mobilePhone != null and MobilePhone IN : mobileNumberSet and isConverted = false';
    // Added by Akshata for GR : Sprint 2: US#410472 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic 
    public final static String NONCONVERTED_UNIQUE_MOBILE_EMAIL_LEAD_QUERY = 'Select id,MobilePhone,Country__c,Brand_House__c,isConverted from Lead where Country__c != null and Country__c IN : uniquePhnNumCountrySet and Brand_house__c !=null and mobilePhone != null and Email != null and (MobilePhone IN : mobileNumberSet OR Email IN: emailSet) and isConverted = false';
    //21.10.2020/Allada Yeshwanth US: #298162 
    public final static string BAT_REGISTERCONSUMERCONFIG_MTD = 'BAT_ConsumerRegistrationScreenConfig__mdt';
    public final static string BAT_OBJECTNAME = 'BAT_ObjectName__c';
    public final static string BAT_SECTIONORDER = 'BAT_SectionOrder__c';
    public final static string BAT_COLUMNORDER = 'BAT_ColumnOrder__c';
    public final static string BAT_ORDERASC = ' asc ';
    public final static string BAT_NOTEQUALSTR = ' != ';
    public final static string BAT_PRODUCT_STR = 'Product2Id';
    public final static string LEFT_STR = 'Left';
    public final static string RIGHT_STR = 'Right';
    public final static string CHECKBOX_STR = 'checkbox';
    public final static string BAT_LASTNAME_STR = 'LastName';
    public final static string BATPARTNER_STR = 'BAT Partners';
    public final static string RANGE_EPOD = 'epod';
    public final static string RANGE_EPEN = 'epen';
    public final static String queryFieldsRegistrationForm =  'BAT_Country__c,BAT_FieldLabel__c,BAT_FieldName__c,BAT_FieldType__c,BAT_Column__c,BAT_ISFieldReadOnly__c,BAT_ObjectName__c,BAT_SectionOrder__c,BAT_ColumnOrder__c,BAT_SectionName__c,BAT_LegalText__c,BAT_isRequired__c,BAT_LegalTextAPINAME__c,BAT_LegalTextLong__c ' ;//chirag


    
    //28.10.2020/Dipika Gupta US: #297077 Added constants for batch 
    public final static String REWARDSTATUS_STR = 'To be Confirmed';
    public final static String CREATEREWARDBATCHQUERY_STR = 'SELECT Id,Reward_Profile__c,Value__c FROM BAT_Point__c WHERE Reward_Profile__c IN: listRewardProfiles';
    public final static String CREATEREWARDBATCHWHERECLAUSE_STR = ' AND CreatedDate = LAST_N_MONTHS:1';
    
    public final static String REWARDPROFILEBATCHQUERY_STR = 'SELECT ID FROM BAT_Reward_Profile__c Where Country__c =\'CZ\'';
    
    public final static String REWARDOBJECT_STR = 'BAT_Reward__c';  

    //28.10.2020 // Allada Yeshwanth // sprint 3 CZ //US:300982
    public final static String RETAILERWITHDEVICECZ = 'BAT Retailer with Device - CZ';
    public final static string REGISTRATIONCONSUMERFORMCONTROLLER_STR = 'BAT_RegisterConsumerFormController';
    public final static String SAVEDETAILSMETHODNAME_STR = 'saveDetails';
    public final static String ACCOUNTFIRSTNAME = 'FirstName';
    public final static string AGEVERIFIEDAPINAME = 'Age_verified__c';
    public final static string REGISTERPERMISSIONAPINAME = 'Registration_Permission__c';
    public final static string SUBMITSURVEYPERMISSIONAPINAME = 'Submit_Surveys_Permission__c';
    public final static string TEXT_STR = 'Text';
    public final static string BAT_COUNTRY = 'BAT_Country__c';
     public final static string MERGEAPINAME = 'BAT_Ismerge__c';
    
    //14.12.2021/Pratishtha Pathak US: #530277
    public final static string BAT_RETAILERRECORDTYPEID = 'Retailer';

    //28.10.2020/Dipika Gupta US: #295643  Added constants for auto anonymize Lead batch 
    //1837992--Added BirthDate__c field in the query
    public final static String AUTOANONYMIZELEADBATCHQUERY_STR = 'SELECT id,LastName,FirstName,Country__c,Email,MobilePhone,BirthDate__c FROM Lead where ';
    
    
    public static String GETGLOBALRESTRICTEDPROFILEMAPPING = 'getGlobalRestrictedProfileMapping';
    public static String GET_ACCOUNT_WITH_UPDATE_MGMCOUNTER = 'getAccountWithUpdateMGMCounter';
    
    //IT: US:#1134232 - Added by samekala@deloitte.com
    public static String SHARE_RECORD_ACCESS = 'shareRecordAccess';
    
   //14.01.2021/Idrees Ali/ US#340701- Updated the beow query to include all account fields
   //20.04.2022/Debasis Maharana/Bug #960850- Added Email__c field to avoide future exception
    public final static String AUTOANONYMIZEACCOUNTBATCHQUERY_STR =  'SELECT id,LastName,FirstName,Country__c,PersonEmail,Email__c,PersonMobilePhone,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Related_Lead__c,LastModifiedDate,Month_24_Anonymize_Countdown__c,Registration_Permission__c,External_Information_Systems_Permission__c,Submit_Surveys_Permission__c,Trial_Information_Permission__c,Birth_Date__c,Generic_Permission__c, is_trialist__c,Gender__c,Status__c,BAT_Is_Anonymised__c,BAT_CombustibleStatus__c,BAT_OralStatus__c,BAT_THPStatus__c,BAT_VapeStatus__c,BAT_IsEPOKOptInEmailCommunication__c,BAT_IsEPOKOptInMobileTextWhatsApp__c,BAT_IsEPOKOptInPostal__c,BAT_EPOKMarketResearchAuthorization__c,BAT_EPOKLastCompletedOrderDate__c,BAT_EPOKLastConsentOptInDate__c,BAT_IsVypeOptInEmailCommunication__c,BAT_IsVypeOptInMobileTextWhatsApp__c,BAT_IsVypeOptInPostal__c,BAT_VypeMarketResearchAuthorization__c,GoVype_Last_Completed_Order_Date__c,BAT_VypeLastConsentOptInDate__c,BAT_IsLyftOptInEmailCommunication__c,BAT_IsLyftOptInMobileTextWhatsApp__c,BAT_IsLyftOptInPostal__c,BAT_LyftMarketResearchAuthorization__c,BAT_LyftExternalCompaniesAuthorization__c,BAT_LyftTrialFeedbackAuthorization__c,BAT_LyftLastCompletedOrderDate__c, BAT_LyftLastConsentOptInDate__c,External_Customer_Id__c,'+
                                                                     'External_Customer_ID3__c,BAT_ExternalCustomerId4__c,BAT_ExternalSubscriberId__c,BAT_ExternalSubscriberId3__c,BAT_ExternalSubscriberId4__c,Email_verified__c, Member_get_Member_Code__c, MgM_Counter__c, Skip_Repurchase_Lock__c,Wrong_Phone_Number__c, Preferred_Tobacconist_Shop__c, Last_Call_Type__c, Member_get_Member_Promotional_Code__c,Age_verified__c, PersonHasOptedOutOfFax, PersonDoNotCall, SMS_Opt_Out__c, PersonHasOptedOutOfEmail, AccountSource, Store_ID__c, BAT_BypassMobileVerification__c, Category__c, Brand__c, Variant__c, Sector__c FROM Account where ';

    //11.12.2020/Souvik Dinda/US#301630-Constant for BAT Read Only profile
    public static final String READ_ONLY_PROFILE = 'BAT Read Only';
    
     //ENH Sprint 68 : US#276707 :Global Consent Userstory
    public final static String CONTACTABLE_STR ='Contactable';
    public final static String NONCONTACTABLE_STR ='Non Contactable';
    
    //12.1.2020/Dipika Gupta/Bug#376762 -Constant for Mulesoft Integration User
    public static final String MULESOFT_INTEGRATION_USER_NAME = 'Mulesoft Integration User';
    
    //12.01.2021/Idrees Ali Jabalpurwala/US#340701
    public final static String SECTION_ASSET_DETAILS = 'Dettagli Dispositivo'; 
    public final static String CREATE_ASSET_CONTROLLER_CLASS ='BAT_AssetRegistrationFormController';
    public final static String CREATE_ASSET_CONTROLLER_GETASSETINPUTFIELD = 'getAssetInputFields';
    public final static String CREATE_RECORD_FORM_CONTROLLER_UPDATELINKEDASSET_STR = 'updateLinkedAsset';
    public final static String CREATE_RECORD_FORM_CONTROLLER_CHECKDUPLICATEACCOUNTEXISTENCE_STR = 'checkDuplicateAccountExistence';
    public final static String IT_GLOSTOREASSETURL_STR = '/GLOItalia/s/asset/Asset/';
    public final static String IT_POSAGENTASSETURL_STR = '/POSItalia/s/recordlist/Asset/';
    public final static String IT_ASSOCIATEASSET_METHOD = 'associateAssetWithAccount';
    public final static String IT_PICKLIST_BLANKVALUE = '--Nessuno--';
    public final static String IT_COUPONCODEFIELD_APINAME = 'BAT_CouponCode__c';
    
    //22.01.2021/Anna Gomez/US#380193: Added for SK Market
    public final static String COUNTRY_SK = 'SK';
    //18.05.2022/Rama Akella/US#868497: Added country set for CZ and SK
    public final static Set<String> COUNTRY_CZ_SK = new Set<String>{'CZ','SK'};
    //21.01.2021/Osheen Sahajpal/ENH:Sprint-71:SRB:US #217575:Supporting methods for Auto Account Update Batch
    public final static String ACCOUNTUPDATEBATCH_QUERY1 = 'SELECT Id,Country__c,';
    public final static String ACCOUNTUPDATEBATCH_QUERY2 = ' FROM Account WHERE ';
    public final static String ACCOUNTUPDATEBATCH_WHERECLAUSE2 = 'Country__c IN :fieldString';
    public static final String BAT_UPDATEACCOUNTBATCH = 'BAT_AutoAccountUpdateBatch';
    public static final String BAT_UPDATEACCOUNTBATCHSCHEDULE = 'BAT_AutoAccountUpdateBatchSchedule';
    
    //28.10.2020/Saurabh Sharma/US#287284, Update logic for liveChat transcript anonymization
    public final static String LIVECHAT_PII_DELETE_QUERY1 = 'SELECT Id, Name, Body, LiveChatButton.DeveloperName FROM LiveChatTranscript WHERE ';
    public static String LIVECHATTRANSCRIPTOBJECT = 'LiveChatTranscript';
    public static String GETLIVECHATTRANSCRIPTANONYMIZECONFIG = 'getLiveChatTranscriptAnonyConfig';
    public static String GETGLOBALANONYMIZEMAPPING = 'getGlobalFieldAnonymizeMapping';
    public static String ANONYMIZECHATTRANSCRIPTBATCH = 'BAT_AnonymizeLiveChatTranscriptBatch';
    public static String ANONYMIZECHATTRANSCRIPTBATCHSCHEDULE = 'BAT_AnonymizeChatTranscriptBatchSchedule';

    //12.03.2021/ Akshata Rajmane/ bug#444837 :Reverse integration for multi-brand consumers: Added logic to pass multiple fields in URL
    public static String EXTERNALID_ERROR = 'Blank External ID in Delete Call';
    //17March,2021/Abhishek Kashyap/US#434292-RO-Added a variable to save purged email string when the flow is called form EmailVerificationComponent.
    public static String purgedEmailString = '';
    //24thMarch/Abhishek Kasyap/BUG#457315- 419648 - Issues with Order Update Integration 
    public final static String GLOCIRCLE_STR = 'GloCircle';
    //26th March/Abhishek Kashyap/US#393708-RO - Technical Setup - Reverse Integration for CIAM Account and FMC/ GloCircle Brand Profile
    public final static String BRAND_PROFILE_OBJECT_API_NAME = 'BAT_BrandProfile__c';
    public final static String BRAND_PROFILE_COUNTRY_API_NAME = 'BAT_Country__c';
    //12.04.2020/Osheen Sahajpal/ENH: Sprint:76: US#160407:Supporting variables for UA-sputnik
    public static final String WHERE_STR = ' WHERE ';
    public static final String SUPPORTINGFIELDPLACEHOLDER = '<<SupportingField>>';
    //16th April/Abhishek Kashyap/Bug-489937-Added constant for customer service ro
    public final static String PROFILE_BAT_CUSTOMER_SERVICE_RO = 'BAT Customer Service - RO';

    //09.05.2021 /Akshata Rajmane / US#505672 : Avalanche - Technical Setup - Duplication Rule Logic
    public final static String EU_ACCOUNT_SOURCE = 'eCommerce - Velo EU';
    public final static String EU_REGION_SUFFIX = 'EU';
    public final static String DEEU_REGION_STR = 'DEEU';
    
    //US#414410 - Added constant for searching the Auth Provider and JSON Request construction for Notification to Marketing Cloud
    public static final String KEYWORD_NOTIFICATION = 'Notification';
    public static final String KEYWORD_MOBILENUMBER = 'mobileNumbers';
    public static final String KEYWORD_SUBSCRIBE = 'Subscribe';
    public static final String KEYWORD_RESUBSCRIBE = 'Resubscribe';
    public static final String KEYWORD_STR = 'keyword';
    
    //US#525787 - Added constants for handling Apex logs related to UK Own Store Portal
    public static final String BAT_GLOBALSEARCHCONTROLLER_CLASS = 'BAT_GlobalSearchController';
    public static final String BAT_ADDCAMPAIGNMEMBER_METHOD = 'addCampaignMember';
    public static final String BAT_GETCAMPAIGNLIST_METHOD = 'getListOfCampaign';
    public static final String BAT_GETCAMPAIGNANDSUBCAMPAIGN_METHOD = 'getCampaignAndSubCampaign';
    //22nd April, 2021/Abhishek Kashyap/US-543158-RO - Anonymization in the to be architecture - update
    public static Boolean IS_ANONYMIZE_ACCOUNT_BUTTON_FLAG = false;
    
    //US#487564 - Added constants for Substitution Case on Product Case Form
    public static final String NEWASSETSCREEN_STR = 'NewAssetScreen';
    public static final String BAT_CREATECASEFORMCONTROLLER_CLASS = 'BAT_CreateCaseFormController';
    public static final String BAT_GETCASEFORMCONFIG_METHOD = 'getCaseFormConfig';
    public static final String BAT_GETCASEDETAILS_METHOD = 'getCaseDetails';
    public static final String BAT_GETFIELDVALUESMAP_METHOD = 'getFieldValuesMap';
    public static final String INSERT_EVENT_NAME = 'INSERT';
    public static final String UPDATE_EVENT_NAME = 'UPDATE';
    public static final String BAT_CREATETASKFORCASES_METHOD = 'createTaskForCases';
    public static final String BAT_UPDATEACCOUNTRECORDTYPE_METHOD = 'updateAccountRecordType';
    public static final String BAT_UPDATEEXISTINGASSETTRACKEREVENT_TRIGGER = 'BAT_UpdateExistingAssetTrackerEvent';
    public static final String PRODUCT_CASE_RECORDTYPE = 'BAT_ProductCase';
    public static final String CASE_TO_BE_SUBSTITUED_STR = 'To be substituted';
    public static final String SHIPPING_STR = 'Shipping';
    //US:#525503 - Added constants for Asset Sync batch
    public static final String ASSET_SYNC_BATCH_ORDERBY = ' Order by CreatedDate Asc ';
    public static final String ASSET_SYNC_BATCH_LIMIT = ' Limit 1000';
    public static final String ASSET_SYNC_BATCH_FROMASSETWHERE = ' From Asset where ';
    public static final String ASSET_SYNC_BATCH_CLASS = 'BAT_AssetIntegrationBatch';
    public static final String ASSET_SYNC_BATCH_CLASSFINISH = 'Finish';
    public static final String BAT_REWARD_PROFILE_STR = 'BAT_Reward_Profile__c';
    public static final String ASSET_SYNC_BATCH_ASSETCOUNT = 'assetCount';
    public static final String ASSET_SYNC_BATCH_SUBQUERYSELECT = ',( Select ';
    public static final String ASSET_SYNC_BATCH_SOQLFROM = ' From ';
    public static final String BAT_CHILDOBJ_CASESSTR = 'Cases';
    public static final String BAT_CHILDOBJ_ORDERSTR = 'Orders';
    public static final String BAT_CHILDOBJ_REWARDPROFILESTR = 'Reward_Profiles__r';
    public static final String ASSET_SYNC_BATCH_LIMIT1 = ' Limit 1 ';
    public static Boolean isAssetIntegration = false;
    public static Integer ASSET_SYNC_BATCH_ABBREVIATELENGTH = 13100;
    
    //02.07.2021/Roopa/ENH: Sprint-82: US #364007: Supporting variables for Hypercare tasks
    public static final String ASSET_HYPERCARETASK_METHOD = 'createHyperCareTask';
    
    //US: #537702 || Allada Yeshwanth || ENH : Sprint 83 || Varibles for handling Error Log
    public static final String MOBILE_VERIFICATION_CONTROLLER = 'BAT_MobileVerificationController';
    public static final String MOBILE_VERIFICATION_CONTROLLER_UPDATEMOBILE = 'updateMobileNumber';
    public static final String BAT_PROFILE_PLHOSTESS = 'BAT Hostess - PL';
    
    //13.07.2021/Idrees Ali/Sprint-82: US #443357:Lead Conversion - Mark Consent Fields as Opt Out once Lead is Converted and Account is created
    public static final String BAT_GLOBAL_STR = 'Global';
    
   //27-07-2021/Dipika/ENH US #604136 Sprint-84: GLOBAL - Compliance - Auto de-activation of User
   //public static final String BAT_INACTIVEUSERQUERY = 'Select id, IsActive, Profile.Name, lastLoginDate from User where  Profile.Name NOT IN: setProfileNames AND isActive=true AND lastLoginDate <= : filterDate';//comenting this query, and updated one is below one ==>identity==> "30-Aug-2023/BJSURAJ/ENH US #1335414"
      
   public static final String BAT_INACTIVEUSERQUERYFORTEST = 'SELECT ID,isActive FROM User Where UserName=:userNameString';
   public static final String BAT_USERDEACTIVATIONBATCH = 'BAT_UserDeActivationBatch';

   public static final String BAT_DEFAULTADMINGROUPNAME = 'BAT_DefaultMarketAdmins';
   public static final String BAT_AUTOMATEDUSERNAME = 'automated.deploy@bat.com';
   public static final String BAT_UserDeactivationEmailTemplate = 'BAT_UserDeactivationEmailTemplate';
   public static final String BAT_UserNameText = '{!User.Name}' ;
   public static final String BAT_UserCountText = '{UserCount}';

   //28.07.2021 || Allada Yeshwanth || US:#580301 || Added Constants
    public static final String MGMCODE_UNIQUECODE_APIRECORD = 'Account-MGMSync-UPDATE';
    public static final String CHANNEL_STR = 'channel';
    public static final String MGMCODE_STR = 'mgmCode';
    public static final String M2INTEGRATIONCOMPLETED = 'M2 Integration Completed';
    public static final String BAT_MGMINTEGRATIONBATCH = 'BAT_MGMIntegrationBatch';
    public static final String BATCH_EXECUTEMETHOD = 'Execute';
    public static final String BAT_MGMINTEGRATIONBATCH_STARTQUERY = 'Select Id,Country__c,Member_get_Member_Code__c from Account where (BAT_IntegrationStatus__c = \'Integration Required\' and Country__c In :countrySet and Member_get_Member_Code__c != null)';
    public static Boolean isMGMIntegration = false;
    
    //18.08.2021/ Allada Yeshwanth / US: #540266 || Added Constants
    public static final String NOTEQUALTONULL = ' != null';
    public static final String BAT_MGMINTEGRATIONBATCH_BRANDHOUSEINCLUDES = 'Brand_House__c Includes ';
    public static final String BAT_MGMINTEGRATIONBATCH_STARTQUERY_PART1 = 'Select Id,Country__c,Member_get_Member_Code__c,Brand_House__c,'; 
    public static final String BAT_MGMINTEGRATIONBATCH_STARTQUERY_PART2 = ' from Account where BAT_IntegrationStatus__c = \'Integration Required\' AND  Member_get_Member_Code__c != null AND ('; 

    public static final String BAT_MGMMANAGER_CLASS = 'BAT_MemberGetMemberManager';
    public static final String BAT_UPDATEMGMCOUNTER_METHOD = 'updateMemberGetMemberCounter';

    //23.08.2021 / Allada Yeshwanth / US: #550795 / Added Constants
    public static final String BAT_CONTENTDOCUMENTLINKTRIGGERHANDLER_CLASSNAME = 'BAT_ContentDocumentLinkTriggerHelperNB';
    public static final String BAT_CONTENTDOCUMENTLINKTRIGGERHANDLER_CREATEDEVICEIMAGESMETHOD = 'createDeviceImages';
    public static final String BAT_ACCOUNTID_IDENTIFIER = '001';

    //24.08.2021 / Allada Yeshwanth / US#618417 / Added Constants.
    public static final String BAT_CACHEPARTITIONTYPE = 'local.CampaignStorage';
    public static final String BAT_CACHEMAPKEY_CAMPIGNID = 'campaignIds';
    public static final String BAT_CACHEMAPKEY_PRODUCTLIST = 'productList';
 
    
    //24.02.2021 / Pratishtha Pathak / US #794905 / Added Constants
    public static final String BAT_DELETEDEVICEIMAGES = 'deleteDeviceImages';
    public static final String BAT_CONTENTDOCUMENTSTRIGGERHANDLER_CLASSNAME = 'BAT_ContentDocumentsTriggerHelperNB';
    
    //03.09.2021 / Allada Yeshwanth / US: #725107 / Added Constants
    public static final String LEAD_SOURCE_NEWSLEETERVELO = 'Newsletter - Velo';
    public static final String BAT_AUTODELETIONBATCH = 'BAT_AutoDeletionBatch';//Added as part of US #708704
    public static final String BATCHSELECTQUERY = 'SELECT id FROM ';//Added as part of US #708704
    
    //14.09.2021 / Idrees Ali / US: #383791 / Added Constants
    public static final String BAT_VUSEUKCHATBUTTONNAME_STR = 'Live_Chat_govype_UK';
    //01.11.2021 / Allada yeshwanth / US : #718128 / Added Constants
    public static final String BAT_VUSEFRCHATBUTTONNAME_STR = 'BAT_FR_LiveChatVype';

    //28.09.2021/Akshata Rajmane/added country for MY
    public static final String COUNTRY_MY = 'MY';
    
    //28.06.2022/Rajeswari/added country for CH
    public static final String COUNTRY_CH = 'CH';
    public static final String ConsentStatus_OptOut = 'OptOut';
    
    //Added as  part of US# 708320
    public final static String QRCODE = 'QRCode';
    public final static String BAT_GLOBALCOMMUNITYPROFILE = 'BAT Global Community Profile';
    public final static String BAT_IT_LEAD = 'Contatto';
    //15.11.2021 / Allada Yeshwanth / Added as  part of US# 708320
    public final static String BAT_IT_POSAGENTPROFILE = 'BAT POS Agent - IT';
    //END US# 708320

    //US: #708711 / Allada Yeshwanth / Added Constants
    public final static String CREATEREWARDPROFILEPOINTSFORLEADSMETHOD = 'createRewardProfilePointsForLeads';
    public final static String DATEMONTHYEARFORMAT = 'dd/MM/YYYY';
    
    //17.10.2021 / Anna Gomez / Bug#739959 / Added Constants
    public final static String BAT_GLOBAL_ADMIN = 'BAT Global Administrator';

    //05.10.2021 / Roopa N / US : #711523 / Created the variables
    //24.05.2022/ Debasis Maharana/ Bug#960851 / Removed sub-query to avoide 'Aggregate query has too many rows for direct assignment, use FOR loop' this exception
    public final static string BAT_MANAGEOBSELETEPRODUCTBATCH_CLASSNAME = 'BAT_ManageObseleteProductBatch';
    public final static String BAT_MANAGEOBSELETEPRODUCTBATCH_STARTQUER_PART1 = 'Select id from Account where Country__c IN : countriesSet AND (BAT_THPStatus__c = \'';
    public final static String BAT_MANAGEOBSELETEPRODUCTBATCH_STARTQUER_PART2 = '\' OR BAT_VapeStatus__c = \'';
    public final static String BAT_MANAGEOBSELETEPRODUCTBATCH_STARTQUER_PART3 = '\') LIMIT : BAT_LIMITQUERYROWS';
    public static Boolean isManageObselteProductBatch = false;
    
    //19-10-2021/Osheen Sahajpal/ENH: Sprint-90: US-764232: Added new platform event type for NHS
    public final static String EVENT_NHS = 'NHS';

    //27-Oct-2021/ Allada Yeshwanth /ENH US#74119/Added Constants
    public final static String BAT_DELETECASECONTROLLER_CLASSNAME = 'BAT_DeleteCaseController';
    public final static String BAT_DELETECASECONTROLLER_DELETECASEMETHOD = 'deleteCase';

    //29.10.2021 / Allada Yeshwanth / US : #731279 / Created the constants
    public final static String BAT_ADDCAMPAIGNMEMBERBATCH_CLASSNAME = 'BAT_AddCampaignMemberBatch';
    public final static string BAT_ADDCAMPAIGNMEMBERBATCH_ORDERQUERYPART1 = 'Select Id,Account.PersonContactId,Country__c from Order where Account.BAT_Is_Anonymised__c = false AND ';

     //11.11.2021 / Allada Yeshwanth / #736568 / Added Constants
    public final static String BAT_OTH_REVERTACCOUNTSTATUSONORDERRETURN = 'revertAccountStatusOnOrderReturn';

    //17.11.2021 || Allada Yeshwanth || US : #402606 || Added Constants
    public final static string BAT_DATETIMEFORMAT = 'MM/dd/yyyy HH:mm:ss';
    
    public static boolean MGM_COUNTER = false;
    public final static String BAT_CREATEREWARDPROFILEEVENTTRIGGER = 'BAT_CreateRewardProfileEvent';
    public final static String BAT_UTILITIES_CLASSNAME = 'BAT_Utilities';
    public final static String BAT_CREATEUSERSANDREWARPROFILES_METHODNAME = 'createPortalUsersAndRewardProfiles';
    
    //25.11.2021 || Turbasu Ghosh || US : #774313 || Added Constants
    public final static string BAT_THPSTATUS_DEVICETRIALIST = 'Device Trialist';
    public final static string BAT_THPSTATUS_STICKTRIALIST = 'Stick Trialist'; 
    
    //25.11.2021 || Allada yeshwanth || US : #741230 || Added Constants
    public final static string BAT_ASSETSTATUSOBSOLETE = 'Obsolete';
    public final static string BAT_ASSETNAMEIDENTIFIERONPOINT = 'Device';
    public final static string BAT_ASTTRIGHANDLER_REDUCEPOINTSMETHOD = 'reduceRewardPointsOnAssetObselete';

    //08.12.2021/Idrees Ali/US #756326: ENH: UK - Salesforce Data Retention Policy
    public final static String BAT_GLOBAL_DATA_RETENTION_BATCH = 'BAT_GlobalDataRetentionBatch';
    public final static String BATCH_COUNTRY_FILTER = '( (Country__c =\'';
    public final static String BATCH_AND_FILTER = '\' AND ';
    public final static String BATCH_COUNTRY_FILTER_WITH_OR = ' OR (Country__c =\'';
    public final static String ACCOUNT_PERSONCONTACTID_APINAME = 'PersonContactId';
    public final static String ORDER_STATUS_APINAME = 'Status';
    public static boolean isLeadAnonymized = false;
    //04-04-2022/Turbasu Ghosh / Bug #905783 / Added leadPlatformEventFlag- Avoid trigger run if lead is anonymized send platform event
    public static boolean leadPlatformEventFlag = false;
    
    //10.12.2021 || Allada Yeshwanth || US : #823193 || Added Contants
    public final static string BAT_UPDATEACCOUNTSTATUSONTRIALDEVICEMETHOD = 'updateAccountStatusOnTrialDeviceAddition';
    public final static string BAT_GLOBALFIELDUPDATEPURPOSE_GENERALUPDATE = 'General Field Update';
    public final static string BAT_ACCOUNTSTATUSUPDATEBATCH = 'BAT_AccountStatusUpdateBatch';

    //06.01.2021/Osheen Sahajpal/ENH: Sprint-96: US#834941: event type created for ES MGM Code sync
    public final static String EVENT_MGM = 'MGM';
    
    //18.01.2022 || Idrees Ali || US : #726704 || Added Contants
    public final static String RETAILERWITHDEVICESK = 'BAT Retailer with Device - SK'; 
       
    //17.02.2022 || US: #765434 || UK - CRM - Engagement Consent Opt Out - Salesforce and integration logic
    public final static String LEADUPDATEBATCH_QUERY2 = ' FROM Lead WHERE ';
    public static final String BAT_UPDATELEADBATCH = 'BAT_AutoLeadUpdateBatch';
    public static final String BAT_UPDATELEADBATCHSCHEDULE = 'BAT_AutoLeadUpdateBatchSchedule';

    //22.02.2022 || Idrees Ali || US : #894854 || Added Constants for BAT_TrialCreationForm
    public final static String TRIALCREATIONFORMCONTROLLER_STR = 'BAT_TrialCreationFormController'; 
    public final static Integer BAT_PT_TRIALCLOSINGDAYS = 15;
    public final static String BAT_TRIAL_ANONYMISATION_BATCH_STR = 'BAT_TrialistAnonymizationBatch';
    public final static String BAT_TRIALANONYMISATIONBATCH_QUERY1_STR = 'Country__c = \'PT\' AND createdDate < :specificHours AND AccountSource = \'Reach\' AND '; 
    public final static String BAT_TRIALANONYMISATIONBATCH_QUERY2_STR = 'Registration_Permission__c = false AND IsPersonAccount = true AND Is_Trialist__c = true'; 
    public final static String BAT_TRIALANONYMISATIONBATCH_QUERY3_STR = ' AND LastName != \'Anonymous\''; 
    public final static String BAT_TRIALANONYMISATIONBATCH_QUERY4_STR = ' AND BAT_ExternalSessionId__c = null'; 
    public final static String BAT_POSSHOPPTPROFILENAME_STR = 'BAT POS Shop - PT';
    public final static String BAT_GLOCOACHPTPROFILENAME_STR = 'BAT Glo Coach - PT';
    public final static String BAT_TRIALCLOSINGACTION_STR = 'TrialClosing_Reward';
    public final static String BAT_TRIALOPENINGACTION_STR = 'TrialOpening_Reward';
    public final static String BAT_POSSHOPKEY_STR = 'POSSHOP';
    public final static String BAT_TRIALOPENEDSCENARIO_STR = ' Trial created';
    public final static String BAT_TRIALCLOSEDSCENARIO_STR = ' Trial closed';
    public final static String BAT_CREATEPOINTSONOPENINGTRIALMETHOD_STR = 'createPointsOnOpeningTrial';
    public final static String BAT_UPDATETRIALISTONTRIALCLOSURE_STR = 'updateTrialistOnTrialClosure';
    public final static String BAT_ONLY1ACTIVETRIALEPERACCOUNT_STR = 'Apenas 1 teste ativo por conta';
    
    
    //23.02.2022/ Anna Gomez / Bug#904990 - Constant for Mulesoft Integration User IT
    public static final String MULESOFT_INTEGRATION_USER_IT = 'Mulesoft Integration User IT';
    
    //01.06.2022/ Anna Gomez / US#985716 - Constant for Mulesoft Integration User IT
    public static final String MULESOFT_INTEGRATION_USER_CZ = 'Mulesoft Integration User CZ';

    //28.02.2022 /Saurabh Sharma/ Bug 906429: Constant for GR cluster 
    public static final String HELLAS_CLUSTER_STR = 'Hellas';

    //02.03.2022 /Praveen /US 765434
    public static boolean BAT_UPDATEACCOUNTBATCH_BYPASSED = false;
    public static boolean BAT_UPDATELEADBATCH_BYPASSED = false;
    
    //7.4.2022/Praveen/ US: 897350
    public final static String BAT_BATCH_ACC_COUNTRY = 'Country__c=\'';
    public final static String BAT_BATCH_ACC_COMMON_CONDITION = 'Month_24_Anonymize_Countdown__c = 0 AND IsPersonAccount = true AND BAT_Is_Anonymised__c = false';
    
    //19.04.202/Idrees Ali/ ENH-CA : US#821197 - Added constant for Vuse_ITCAN consent field
    public final static String IsVuseOptInEmailCommunication_API_Name = 'BAT_IsVuseOptInEmailCommunication__c';
    
    //26-04-2022/ Idrees Ali / ENH:Sprint-104:US#877908, Adding UK Email2case queue names str
    public final static String BAT_UK_10M_Email_Case_Queue_STR = 'BAT_UK_EmailCase10MotivesQueue';
    public final static String BAT_UK_Vype_Email_Case_Queue_STR = 'BAT_UK_EmailCaseVuseQueue';
    public final static String BAT_UK_Velo_Email_Case_Queue_STR = 'BAT_UK_EmailCaseVeloQueue';
    public final static String BAT_UK_VIP_Email_Case_Queue_STR = 'BAT_UK_EmailCaseVIPQueue';
    public final static String BAT_AGEVERFICATION_KEYWORD1_STR = 'Age verification';
    public final static String BAT_AGEVERFICATION_KEYWORD2_STR = 'driving license';
    public final static String BAT_AGEVERFICATION_KEYWORD3_STR = 'passport';
    public final static String BAT_AGEVERFICATION_KEYWORD4_STR = 'identification';
    public final static String BAT_AGEVERFICATION_KEYWORD5_STR = 'verify';
    public final static String BAT_AGEVERFICATION_KEYWORD6_STR = 'years old';
    public final static String BAT_AGEVERFICATION_KEYWORD7_STR = 'proof of age';
    
    //Salesforce Data Retention Policy - Cases : US 778532
    public final static String CASEUPDATEBATCH_QUERY2 = ' FROM Case WHERE ';
    public final static String BAT_AUTOCASEUPDATEBATCH = 'BAT_AutoCaseUpdateBatch';

    //07.06.2022 /Akshata Rajmane / Bug #1028411 : Added variable for last consent date field
    public final static String  LASTCONSENTDATE= 'BAT_ConsentDate__c';
    public final static String  EMAILOPTOUT= 'PersonHasOptedOutOfEmail';


    //08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account
    public final static String COUNTRY_SE = 'SE';

    //11.08.2022/Turbasu Ghosh
    public final static String PRIVACYSNAPSHOTQUERY_STR = 'Select Id,ContentDocumentId from ContentDocumentLink where LinkedEntityId IN (Select Id from ';   
    //29.06.2022 /Idrees Ali / US#990429 : Added variable for IT Reward Point Update
    public final static String  ACCOUNT_ANONIMO= 'ANONIMO';
    //US#1044706 - CH - Technical Setup - Automatic Consumer Status Update - Added country set for Brand status check
     Public final static Set<String> CountryOrderCompleteSet = new Set<String>{'GR','MY','PT','CH','RS'};
     public final static Set<String> CountryOrderSubmitSet = new Set<String>{'RO'};
    //04.07.2022/Osheen Sahajpal/CH: Sprint-2: US #1031431: Supporting variable for ContactPointTypeConsent Object
    public final static string BAT_CONTACTPOINTTYPECONSENT_API = 'ContactPointTypeConsent';
    //06.07.2022 || US: #1031317 || CH - Admin Portal - Consent Custom UI - Added Constants 
    public final static String BAT_CH_PERSONALDATAAUTH = 'Personal Data Authorization';
    public final static String BAT_CH_CONSENTOPTIN = 'OptIn';
    //07.07.2022/Rajeswari N / CH:Sprint-2:US #1044706:to get current brandhouse map based on country and countryset based asset on order
     Public final static Set<String> countryBrandHouseSet = new Set<String>{'GR','PL','RO','CH'};
     Public final static Set<String> countryOrderAssetSet = new Set<String>{'CA','PL','MY','CH'};
     Public final static Set<String> fmcBrandSet = new Set<String>{'KENT','LUCKY STRIKE','Parisienne'};
     Public final static String BRAND  =  'BAT_Brand__c';
     Public final static Set<String> countryBrandVeloSet = new Set<String>{'PL','CH'};
    //21.07.2022/Rajeswari N/US - 1063244 - Populate external order ID on subscription - method name reference
     Public final static String BAT_OnAfterInsert = 'OnAfterInsert';
     //28.07.2022/Sonal Srivastava/US - 1080646 - CH - Admin/Careline Portal - Populate External Customer 5 and IsActive Checkbox
    Public final static String BAT_RESPONSESPLITCODE = 'code -201;';
    Public final static String BAT_REPLACEID = '"id"';
    Public final static String BAT_REPLACEB2C = '"b2CId"';
    Public final static String BAT_RESPONSESTRINGID = '\"id\":';
    public final static string FIELD_LEGACYBRANDHOUSE = 'Legacy_Brand_DE__c';
    //01.09.2022/Turbasu Ghosh/US #1028107: Global: All Markets: To include Synchronisation field on Lead to synchronise data correctly on Marketing Cloud
    public static String SYNCHRONISE_IN_MC ='BAT_IsSynchroniseinMC__c';
    
    //14.09.2022/Idrees Ali/ US#1070502:IT | GH | Glo | lterative solution for Reach system using SFMC
    public final static String  PROFILENAME_STR = 'ProfileName';
    public final static String  EVENTDATE_STR = 'EventDate';
    public final static String  CLIENT_ID_V2 = 'client_id';
    public final static String  CLIENT_SECRET_V2 = 'client_secret';
    public final static String  GRANT_TYPE_V2 = 'grant_type';
    public final static String  CLIENT_CREDS_V2 = 'client_credentials';
    public final static String  ACCESS_TOKEN_V2 = 'access_token';
    public static String SOURCE_NEWOFFLINEREGISTRATION ='New Offline Registration';
       //US#1591514-IT GLO | Asset update from Sharpend starts//
    public static String SE_Sources = System.Label.BAT_IT_SharpendSources;
    //US#1591514-IT GLO | Asset update from Sharpend ends//
    //1621675-GR- Velo News letter Subscription Integration -Mulesoft -> CRM  from brochure webpage- starts // 
    public static String BRANDHOUSE_CONCATENATION = System.Label.BAT_BrandHouseConcatenation;
     //1621675-GR- Velo News letter Subscription Integration -Mulesoft -> CRM  from brochure webpage- ends // 
    public static String Clone_Description = System.Label.BAT_IT_OldAssetDescription;
    //1687170-UK SF <> EEP Integration - Additional data fields on integration  starts--
    public static String ACTIVATIONPREFERENCEBRAND_CONCATENATION = System.Label.BAT_ActivationPreferenceConcatenation;
    public static String SOURCE_SE_HOSTESS ='SE - Hostess';
    public static String SOURCE_SEPOPUP_PERMIUM ='SE - Popup Premium';
    public static String SOURCE_SEPOPUP_LIGHT ='SE - Popup Light';
    public static String SOURCE_SETOBACCONIST ='SE - Tobacconist';
// US #1043064 : Added Product Brands for building Refunded/Canceled order logic
    public final static String PRODUCT_BRAND_VUSE = 'Vuse';
    public final static String PRODUCT_BRAND_VELO = 'Velo';
    public final static String PRODUCT_BRAND_GLO = 'Glo';
    // CZ/SK || US #1043064 - CZ - MultiCategory - Roll Back Consumer & Asset Details When Order is Refunded/Canceled || Bug #1142345
    public final static String PRODUCT_BRAND_VYPE = 'Vype';
    // US #1043059 : Constant value use to remvoed from External_Order_Line_Item_Id__c field value on orderlineitem object
    public final static String CZ_BATSTORE = 'CZ-BATstore-';
    //15.09.2022/Hariharan Pillai/ US #1017045
    public final static String UA_ACCOUNTCONSENTSYNC ='BAT_UA_AccountConsentSync';
    public final static String UA_ACCOUNTCONSENTSYNCQUERYPARAM ='?activityStatus=';
    public final static String GETMETHOD_STR ='GET';
    public final static String UNSUBSCRIBED ='UNSUBSCRIBED';
    public final static String SPAM ='SPAM';
    public final static String ACCOUNTCONSENTSYNCBATCH ='BAT_AccountConsentSyncBatch';
    public final static String CALLCONSENTSYNCAPI_METHOD_STR ='callConsentSyncAPI';
    

    //7.09.2022/Sameer Ranjan/ US #1124454: Added split charcter 
    public static string SPLIT_CHARACTER = ':Split:';
    //26.09.2002/Vamsi Ramineni/ US #1105804 : Gloabl : ALL Markets : Added Azure API Constants
    public final static String AZURE_FILE_API_NAMED_CREDENTIAL ='BAT_AzureIntegration';
    public final static String AZURE_TOKEN_PROVIDER = 'BAT_AzureAuthProvider';
    public final static String PRIVACY_SNAPSHOT_FILENAME_TEST = 'PrivacySnapshot_2020:07:26-09:47:11.pdf';
    public static Boolean Invoke_Account_generatePrivacySnapShotPDF = false;
    public static Boolean Invoke_Lead_generatePrivacySnapShotPDF = false;

    //19th October, 2022 / Swaraj Ray / US #1120605 - PL - CRM - RFM Segment in SF per brand (S117)
    public static String RFM_SEGMENT_FIELD = 'BAT_RFM_Segment__c';
    //Added by Chetan as prt of US: #1121760
    public final static String COUNTRY_SI = 'SI';
    //Added by Suman as prt of US: #1702001
    public final static String COUNTRY_AL = 'AL';
    public final static String COUNTRY_BA = 'BA';
    public final static String COUNTRY_MK = 'MK';

    //Swaraj Ray - #1164131 - CRM : Trigger 1 : Creation of New order  | YOTPO Consent Sync
    public static String EMAIL_W_UNDERSCORE = '_Email_';
    public static String APPKEY = 'appkey';
    public static String SECRET = 'secret';
    public static String CHANNEL = 'channel';
    public static String SALESFORCE = 'Salesforce';
    public static String CONTENTTYPE = 'Content-Type';
    public static String APPLICATIONJSON = 'application/json';
    public static String SUCCESS_CODES = '200,201';
    public static String UNSUBSCRIBE_API_CALL = '/unsubscribe';
    public static String RESUBSCRIBE_API_CALL = '/resubscribe';
    public static String YOTPO_CONSENT_CALLOUT = 'callout:BAT_ZA_YotpoConsent';
    public static String BEARER_TOKEN = 'Bearer {!$Credential.OAuthToken}';
    public static String YOTPO_HANDLER_CLASSNAME = 'BAT_YotpoConsentIntegrationHandler';
    public static String YOTPO_QUEUUEABLE_CLASSNAME = 'BAT_YotpoQueueableClass';
    public static String RESPONSE_CODE = ' Reponse Code: ';
    public static String BRANDNAME_STR = ' BrandName: ';
    public static String INSERT_STR = 'Insert';
    public static String UPDATE_STR = 'Update';
    public static String CONSENT_VALUE = ' Consent Opt In: ';
    public static String EVENT_TYPE_STR = ' Event: ';
    public static String ONE_STR = '1';
    public static String EMAILLIST_STR = 'emailList';
    public static String REFERENCE_STR = ' Reference: ';
    
    //31st October, 2022 / Rahul Upadhyay / US #1063204 - IT | glo | New Glo Corner partner community form to check existing customers
    public static String IT_PHONE_CODE = '+39';
    public static String EXISTING_CUSTOMER_CONTROLLER = 'BAT_batExistingCustomerVerificationCntlr';
    public static String GET_CUSTOMER_METHOD = 'getCustomer';
    public static String AURA_HANDLER_EXCEPTION = 'Unhandled exception occured. Please check the log record for more details';

    //14.11.2022/ Idrees Ali /ENH:Sprint-118:SEA:US #1139217- SEA (IT) Admin - Flexible reward scheme management- Added Strings
    public final static String RETAILER_POINT_QUERY_PART2_STR = 'BAT_RetailerPointDirectory__c where (BAT_MetadataSyncStatus__c = \'To be Synced\' OR BAT_MetadataSyncStatus__c = \'Sync Failed\')';
    //public final static String RETAILER_POINT_METADATA_NAME_STR = 'BAT_RetailerPointTable__mdt';
    public final static String RETAILER_POINT_METADATA_NAME_STR = 'BAT_RetailerPointDirectory__c';
    public final static String SYNC_STATUS_COMPLETED_STR = 'Sync Completed';
    public final static String SYNC_STATUS_FAILED_STR = 'Sync Failed';
    public final static String SYNC_STATUS_TO_BE_SYNCED_STR = 'To be Synced';
    public final static String NO_MATCH_FOUND_STR = 'No Match Found';
    public final static String BAT_DEPLOYCUSTOMMETADATABATCHNAME_STR = 'BAT_DeployCustomMetadataBatch';
    //14.11.2022/ Sameer Ranjan / Added as part of US #1173773
    public final static String MODEL = 'Model';
    public final static String ERROR_MESSAGE = 'ErrorMessage';
    public final static String BAT_ENABLED_ASSET_CUSTOM_VALIDATION_RULE_API_NAME = 'BAT_EnabledAssetBeforeTriggerCustomValidationRule';
    
    //14.11.2022/Anna Gomez/US#1153646: CZ-Device registration logic change - Added constants
    public final static String ASSET_MODEL_HYPERX2 = 'Hyper X2';
    public final static String ASSET_MODEL_HYPERUNIQ = 'Hyper+ UNIQ';
    // 26.02.2024 || Lalit || US#1637978 & US#1657444 || CZ- 3rd device registration for "Hyper Pro"
    public final static String ASSET_MODEL_HYPERPRO = 'Hyper Pro';
    public final static String ASSET_MODEL_VUSEPRO = 'Vuse Pro';
     public final static String ASSET_MODEL_VUSEGORELOAD = 'Vuse Go Reload';
    
    //25.05.2023/Lalit Kumar/US#1390835:CZ - Retailer w/ device glo HYPER X2 air reward logic - Added constants and Asset status
    public final static String ASSET_MODEL_HYPERX2AIR = 'Hyper X2 air';
    Public final static Set<String> ASSET_STATUS_SET = new Set<String>{'Obsolete'};
    public final static String ASSET_MODEL_EPEN = 'Epen';
    public final static String ASSET_MODEL_EPOD = 'Epod';
    public final static String ASSET_MODEL_EPOD2 = 'Epod 2';
       
    //1133000 - Global Data Archival Process 
    public final static String HH_MM_A ='hh_mm_a';
    public final static String DD_MM_YYYY ='dd-MMM-yyyy';
    public final static String CAMPAIGN_MEMBER ='CampaignMember';
    public final static String PRODUCT_INTEREST ='BAT_ProductInterest__c';

    //18.01.2023/ Rahul Upadhyay/ Bug#1275288: RO-use - Email2Case/ Contact Us Auto-Response Emails
    public final static String MEDIUM = 'Medium';
    public final static String WEB = 'Web';
    public final static String BAT_SETCASEAUTORESPONSERULE = 'setCaseAutoResponseRule';
    
    //12.02.2022/ Idrees Ali/ ENH:Sprint-119:US #1135211- glo DE - Loyalty - Qualtrics to Loyalty Trigger
    public final static String QUALTRICS_SURVEY_RESPONSE_OBJ_STR = 'qualtrics__Survey_Response__c';

    //01.12.2022/ Saurabh Sharma/ ENH:Sprint-119:US #961238- UK - Vuse Webeyez Salesforce - live chat triggering
    public final static String CASE_TYPE = 'Website Issue';
    public final static String CASE_CREATED_FROM_CHAT = 'Case created after chat';
    public final static String CASE_CREATED_FROM_CHATDESC = 'Case description to be added';     
    
    //04.01.2023/ Sonal Srivastava/ ENH:Sprint 121: US #1212980- FR - Update to VELO Trial 
    public final static String PROMO_CODE = 'TESTEZVELO';
    //26.10.2023/Lalit/US-1539359, SE/DK - Logic to update Prospect status to trialist if order total is zero 
    public final static String SE_DK_PROMO_CODE = 'TESTEZAMP';
    
    //05.01.2023/ Idrees Ali/ ENH:Sprint 121: US #1247393- UK customer care - Customer Care Skill Based Routing 
    public final static String SKILL_BASED_L1_QUEUE_STR = 'BAT_UK_L1_EmailCaseAndChatQueue';
    public final static String SKILL_BASED_L2_QUEUE_STR = 'BAT_UK_L2_EmailCaseAndChatQueue';
	
    //04.03.2025/ Deepankar Naik/ Sprint 177: US #2021604- CA Records Deletion Batch to be rescheduled
    public static final String BAT_GENERIC_ACCOUNT_BATCH = 'BAT_GenericParentChildDeleteBatch';
    
    //12.01.2023 / Swaraj Ray /BAT#1142557 - ZA - Data Archival Process
    public static final String CASE_ID = 'CaseId';
    public static final String CASE_ID_IN = ' CASEID IN: sObjectdeletionRecordsIdSet';
    public static final String ORDER_ID_IN = ' ORDERID IN: sObjectdeletionRecordsIdSet';
    
    public static final String ACCOUNT_ID = 'ACCOUNTID';
    public static final String ACCOUNT_ID_IN = ' ACCOUNTID IN: sObjectdeletionRecordsIdSet';
    public final static String BAT_UK_VUSE_LIVECHATWEBEYEZ_CASE_QUEUE_STR = 'BAT Live Chat UK Vuse Webeyez Queue';
    //10.01.2023/ Sameer Ranjan/US #1154667 - Constant variable
    public final static String COUNTRY_SUFFIX = '_v2';
    public final static String JSON_CONSTATTRIBUTE = '_JSONConstAttribute';
    public final static String QUESTION_MARK = '?';
    public final static String REVERSE_API_VERSION_TWO_CLASS = 'BAT_IntegrationUtilityV2';
    public final static String REVERSE_API_VERSION_TWO_METHOD_NAME = 'callReverseAPI';
    public final static String MAP_STR = 'Map';
    public final static String FROM_SOBJECT_FIELD_STR = 'From sObject Field';
    public final static String LIST_STR = 'List';
    public final static String STATIC_VALUE_STR = 'Static Value';
    public final static String CUSTOM_ATTRIBUTES_CUSTOM_SETTING_STR = 'BAT_CustomAttributesReverseAPI__c';
    public final static String EXTENSION_ATTRIBUTES_CUSTOM_SETTING_STR = 'BAT_ExtensionAttributes__c';
    public final static String NUMERIC_VALUE_1_STR = '1';
    public final static String NUMERIC_VALUE_2_STR = '2';
    public final static String SOBJECT_FIELD_STR = 'sObjectField';
    public final static String BAT_RETRYCALLOUTBATCH_CONFIG = 'BAT_RetryCalloutBatch';
    public final static String LEAD_LAST_MOPDIFED_SOURCE_API_NAME = 'BAT_LastModifiedSource__c';
    public final static String DO_NOT_MAKE_CALLOUT = 'DoNotMakeCallout';
    public final static String NULL_STRING = 'null';

    //18.01.2023/ Rahul Upadhyay/ US#1186638: DE - G4C - Registration Email and Lead 
    public final static String G4C = 'G4C';
    
    //06.02.2023/Rama Akella/ Bug#1293078: Exception handling for Validation Rules 
    public final static String VALIDATION_EXCEPTION = 'FIELD_CUSTOM_VALIDATION_EXCEPTION';
    
    //06.02.2023/ Idrees Ali/ US#1285878: Data Archival Process - Discrepancy with regard to Field Values & Throttling mechanism Redesign
    public final static String BAT_GLOBALDATARETENTIONBATCH_CURRENTOBJ_STR = 'BAT_GlobalDataRetentionBatch_CurrentObject_';
    public final static String BAT_GLOBALDATARETENTIONBATCH_UPCOMINGOBJ_STR = 'BAT_GlobalDataRetentionBatch_UpcomingObject_';
    public final static String FORMAT_DATETIME_STR = 'yyyy-MM-dd h:mm:ss a';

    //07.02.2023/ Sameer Ranjan/US #1032013 - IT - New Field in CRM db: 'CHANNEL' 
    public final static String BAT_CANNEL_IDENTIFIER_BATCH = 'BAT_ChannelIdentifierBatch';

    public final static String LEAD_REGISTRATION_FORM_CONTROLLER = 'BAT_LeadRegistrationFormController';
    public final static String CREATE_KIOSKS_LEAD_METHOD = 'createKiosksLead';
    public final static String NEWSLETTER_SUBSCRIBER = 'BAT_NewsletterSubscriber';
    //1 Mar 2023/ Praveen/ US #1284980/  IT - Glo Sharpend API integration from 3rd Party Retail to SF (QR code) - part2
    public final static String BAT_ACCOUNT_SOURCE = '3rd Party ECRM Tool';
    
    //02.03.2023/Idrees Ali/ENH: Sprint-125:US#1228423-IT | glo | Point assignment to retailer if customer joins Loyalty || Added Constants
    public final static List<String> supportedLoyaltySubsAccountSources  = new List<String>{'Reach','New Offline Registration'};
    public static String LOYALITY_ACCOUNT_SOURCES = System.Label.BAT_LoyaltyAccountSources;
        public final static String BAT_LOYALTY_REWARD_SCHEME_STR = 'Loyalty';
    public final static String ACCOUNT_NAME_REASON_STR = 'Account:';
    public final static String BAT_ASSIGNLOYALTYPOINTSMETHOD_STR = 'assignPointsForLoyaltySubscription';
    public final static String BAT_LOYALTY_REWARD_SCHEME_REASON_STR = '- Punti Registrazione Loyalty';
    
    // 08.11.2023/Varaprasad Sada/US#1510010/UA - Esputnik API (Multibrand)
        public final static Map<String,string> supportedEsputnikAccountSources  = new Map<String,string>{'eCommerce - Multibrand'=>'eCommerce - Multibrand',
                                                                                                     'eCommerce - Glo'=>'eCommerce - Glo',
                                                                                                     'eCommerce - Velo'=>'eCommerce - Velo',
                                                                                                     'Flagship'=>'Flagship',
                                                                                                     'GloStore'=>'GloStore'};
  //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update
  public final static String BAT_ANOANYMIZING_RO_CIAM_ACCOUNTS= 'anonymizingRoCIAM_Accounts';
    public final static String BAT_UPDATE_THE_OLD_RO_ACCOUNTS= 'updatetheOldROAccounts';

    // 6th March, 2023 // Swaraj Ray // US #1280522
    public final static String COLOR_FIELDAPINAME = 'Colour__c';
    public final static String GENDER_FIELDAPINAME = 'Gender__c';
    public final static String MODEL_FIELDAPINAME = 'BAT_Model__c';
    public final static String SOURCE_OF_BUSINESS_FIELDAPINAME = 'BAT_SourceOfBusiness__c';
    public final static String AVG_CONSUMPTION_FIELDAPINAME = 'BAT_DailyAvgConsumptionPREVIOUSPRODUT__c';
    public final static String REASON_FOR_GLO_FIELDAPINAME = 'BAT_ReasonWhyYouAreChosingGLO__c';
    public final static String SURVEY_TAKEN_SECTION_NAME_STR = 'Questionario';
    public final static String ACCOUNT_SECTION_NAME_STR = 'Dati Personali';
    public final static String ASSET_SECTION_NAME_STR = 'Dispositivo';
    
    // 14 March 2023 || Sameer Ranjan || US #1300695 Bug #1329208 || Constant Variables
    public final static String CLASSNAME_LIVECHATTRANSCRIPTTRIGGERHANDLER = 'BAT_LiveChatTranscriptTriggerHandler';
    
    //23.03.2023/Idrees Ali/US#1272527-UA - Generate REW-CODE in any type of accounts in CRM - Created Constants
    public final static String HASHING_ALGORITHM_STR = 'MD5';
    public final static String DATE_TIME_FORMAT_STR = 'yyyy-MM-dd HH:mm:ss.SSS';
    //27.03.2023/Sameer Ranjan/US #1326044 IT Vuse | Monthly batch for anonymizing non-contactable Leads older than 3 months
    public final static String ANONYMIZE_NONCONTACTABLE_LEAD_BATCH = 'BAT_AnonymizeNonContactableLeadbatch';
    public final static String PREFIX_CONFIG = 'Config-';
    public final static String ATTHERATE_ANONYMOUS_DOT = '@anonymous.';
    
    //6 April 2023 || Sameer Ranjan || US 1335492 SE - Automated update last email date field || Added constants
    public final static String BAT_INDIVIDUALEMAILRESULTTRIGGERHANDLER = 'BAT_IndividualEmailResultTriggerHelperNB';
    //14.04.2023/Praveen/ US #1360439 - IT - Glo - Charging station landing page - consents
    public final static String CHARGING_STATION = 'Charging Station';
    public final static String WEB_LEAD_FORM = 'Web Lead Form';
    
    //18.04.2023/Idrees Ali/ US #1335464 - SE- Exclude email from the account / lead anonymization process 
    public final static String EMAILOPTOUT_FIELDAPINAME_STR = 'HasOptedOutOfEmail';
    public final static String LASTEMAILDATE_FIELDAPINAME_STR = 'BAT_LastEmailDate__c';
    public final static String SE_COLON_LEAD_STR = 'SE:Lead';

    //25.04.2023/Anna Gomez/ENH: US#1334594: Added custom field identifier constant for FLS check for Asset object custom fields
    public final static String CUSTOMFIELD_IDENTIFIER = '__c';
    //11 May, 2023/ Chirag Kalra/ US-1339519, FR,  Added custom CSS classes as constant .
    public final static String PRIVACYSNAPSHOT_SECTIONITEM_GLOBAL = 'sectionItem';
    public final static String PRIVACYSNAPSHOT_SECTIONITEM_FR = 'sectionItemFR';
    //06.03.2023 / Saurabh Sharma / Bug #1322086 / created constant for duplicate value exception for try catch error handling
    public final static String DUPLICATE_VALUE_EXCEPTION_STR = 'DUPLICATE_VALUE';
    
    //07.03.2023 / Hariharan Pillai / US #1199876 / String No Account Linked
    public final static String BAT_ACCOUNTNOTLINKED = 'Account Not Linked';
    
    // 09.06.2023 US: #1277382 ES Espacio Expertus Integration 
    public final static String ACCOUNT_SOURCE_EXPERTUS = 'Expertus';
    public final static String ACCOUNT_QUERY = 'Select Id,Name, AccountSource From Account where Id =:';
    public final static String ACCOUNT_QUERY1 = 'accId Limit 1';
    public final static String ACCOUNT_QUERY2 = 'relatedId Limit 1';
    //1478017
    public final static String JSON_CUSTOMERATTRIBUTE = '_JSONCustomerAttribute';
    public final static String JSON_ADDRESSATTRIBUTE = '_JSONAddressAttribute';
    public final static String ADDRESSES = 'addresses';
    public final static String CUSTOMER = 'customer';
    public final static String NOTE = 'note';
    public final static String HEADER = 'header';


     //12 june/ Hima Bindu/US-1383967,PT-Dashboard Retailer Improvement
    public final static String DASHBOARDFORCURRENTMONTH_PT = 'BAT Retailer Portal PT Current Month';
    public final static String EXCEPETION_ERROR = 'unknown access';

    
    //22June, 2023/ Chirag Kalra/ US-1383949, PT,  Added Control Panel Object API Name .
         public static String   CONTROL_PANEL_STR ='BAT_ControlPanel__c';
          public static String   ALLUSERS_STR ='AllUsers';
         public static String   SHARETYPE_I_STR ='I';
         
         //July 17th 869908/ Sushma /PL - Salesforce Data Retention Policy - Account 
        
         public final static String ACCOUNT_ORDER_QUERY = 'SELECT Id, AccountId, Account.External_Customer_ID2__c, Account.BAT_ExternalCustomerId4__c  FROM Order WHERE AccountId IN:accountIdSet  AND Country__c=:country AND RecordType.DeveloperName = \'Ecommerce\' AND Account.Country__c =:country AND  (Account.External_Customer_ID2__c!=\'\' OR Account.BAT_ExternalCustomerId4__c!=\'\') AND CreatedDate < LAST_N_DAYS:731';
public final static String ACCOUNT_POSTRANSACTIONS_QUERY = 'SELECT Id, BAT_ConsumerId__c, BAT_Createddate__c, BAT_ConsumerId__r.BAT_ExternalCustomerID5__c FROM BAT_PosTransactions__x  WHERE BAT_ConsumerId__c IN:accountIdSet AND BAT_Country__c =:country AND BAT_Createddate__c < LAST_N_DAYS: 731  ';
public final static String ACCOUNT_CASE_QUERY = 'SELECT Id, AccountId FROM Case WHERE AccountId IN:accountIdSet   AND Country__c =:country AND Origin IN (\'Email\',\'Online Chat\',\'Telephone\') AND Account.Country__c =:country AND CreatedDate < LAST_N_DAYS:731';
public final static String ACCOUNT_ASSET_QUERY = 'SELECT Id, AccountId FROM Asset WHERE AccountId IN:accountIdSet  AND  Account.Country__c =:country AND CreatedDate < LAST_N_DAYS:731';
public final static String ACCOUNT_BRANDPROFILE_QUERY = 'SELECT Id, BAT_Account__c, BAT_Account__r.Country__c,  BAT_Country__c, BAT_TouchpointName__c,  BAT_LastActivatedDate__c ,CreatedDate, BAT_Account__r.External_Customer_ID2__c, BAT_Account__r.BAT_ExternalCustomerId4__c, BAT_Account__r.BAT_ExternalCustomerID5__c FROM BAT_BrandProfile__c WHERE BAT_Account__c IN:accountIdSet AND BAT_TouchpointName__c IN (\'eCommerce - Velo\',\'eCommerce - Glo\',\'eSmoking Club\') AND BAT_Account__r.Country__c =:country AND BAT_Country__c =:country AND  BAT_LastActivatedDate__c < LAST_N_DAYS:731';
  
        public static String ESMOKING_CLUB_STR = 'eSmoking Club';
        public static String BRANDPROFILE1 = 'BAT_BrandProfile1';
        public static String BRANDPROFILE2 = 'BAT_BrandProfile2';
        public static String POSTRANSACTIONS1 = 'BAT_PosTransactions1';
        public static String POSTRANSACTIONS2 = 'BAT_PosTransactions2';
    //20July 2023/BJSURAJ/Dunhill-Integration US
    public final static String INTEGRATIONPROFILE = 'Integration User';
    public final static String MARKETINGPERMISSION = 'Marketing Permission_';
    public final static String BRANDGLO = 'Glo';
    public final static String PERSONALDATAAUTHORIZATION = 'Personal Data Authorization';
    public final static String COUNTRYCH = 'CH';
    public final static String BRANDDUNHILL = 'Dunhill';
    public final static String CONSENTSOBJECT = 'ContactPointTypeConsent';
    public final static String CONSENTSBATCHCLASS = 'BAT_CreateContactPointTypeConsentBatch';
    public final static String PRIVACYCONSENTSTATUS = 'OptOut';
    public final static String BAT_ContactPointTypeConsentHandlerCLASS = 'BAT_ContactPointTypeConsentHelperNB';
    
    //2Aug 2023/BJSURAJ/US: #1429885 || PT-ES ACCOUNT ID DUMMY CREATION
    public final static String GLOANONIMOACCOUNTNAME = 'Glo Anonimo';
    public final static String BAT_UpdateAssetWithAccountBatchCLASS = 'BAT_UpdateAssetWithAccountBatch';
    
    //11/08/2023 /US: #1461187  ||PT EXPERTUS- CONSUMER CONSENT REVERSE FEEDBACK
     public final static String CUSTOMERATTRIBUTE = 'custom_attributes';
    //07.08.2023/Hima/ ENH:Sprint 137: US #1453108- UK  Skill Based Routing 
    public final static String SKILL_BASED_HIGHPRIORITY = 'BAT_High_Priority_Queue_UK';
    
    //24/Aug/2023/BJSURAJ/US:#1335412
    public final static String BAT_PrivacySnapshotBackupBatchCLASS = 'BAT_PrivacySnapshotBackupBatch';
    
    //05-Sept-2023/BJSURAJ/ENH:Sprint-138:US #1335414
    public final static String STR_KZ = 'KZ';
    public static final String BAT_INACTIVEUSERQUERY = 'Select id, IsActive, Profile.Name, lastLoginDate from User where  Profile.Name NOT IN: setProfileNames AND isActive=true';
    
    //05-Sept-2023/BJSURAJ/US: #1335387 - KZ -  anonymization of all KZ accounts from CRM
    public final static String Month24AnonymizeCountdownIsZero = 'Month_24_Anonymize_Countdown__c = 0';
    public final static String Month24AnonymizeCountdownIsNull = 'Month_24_Anonymize_Countdown__c = null'; 
    
    //30-Sept-2023/BJSURAJ/US: #1478892 - CZ/SK - new data retention - Cases
    public static final String OBJECTEMAILMESSAGE = 'EmailMessage';

//15-Oct-2023/Chirag Kalra/ US:1511578 - UA - MB API create user integration Shopify
    public final static String ACC_SOURCE_INT_SHOPIFY = 'Integration Shopify';
    public final static String ACC_SOURCE_API_NAME = 'AccountSource';
    
    //27-Oct-2023/BJSURAJ/US: #1520643 - SE/DK- Technical Setup - Lead Conversion Logic 
    public final static String COUNTRY_DK = 'DK';
    public final static String ECOMMERCE_AMP = 'eCommerce - AMP';
    public final static String NO_REWARD = 'No reward';//INC0664033
    public final static String Noreward = 'Noreward';//INC0664033
    
    //22-Nov-2023/BJSURAJ/US: #866029 - CA - Account and Data Deletion
    public final static String COUNTRY_CA = 'CA';
     //5-dec-2023 /himabindu 1410617-UK/FR- "Resolved" & "Closed" cases to be in closed queue list
    public final static String CASE_STATUS_RESLOVED ='Resolved';
    
    //18-Jan-2024/BJSURAJ/US: #1602116 - IT | Old Case and SurveyTaker__c records anonymization flow
    public final static String OBJECT_SURVEYTAKER = 'SurveyTaker__c';
    public final static String SURVEYTAKER_COUNTRY = 'BAT_Country__c';
    public final static String SURVEYTAKER_COUNTRY2 = 'BAT_BAT_Country__c';
     
    // 28th March, 2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization      
    public final static String BirthDate_CZ_SK = 'BirthDate__c';
    public final static String BAT_subscriberExternalId5 = 'BAT_ExternalSubscriberId5__c';
    public final static String BAT_subscriberExternalId4 = 'BAT_ExternalSubscriberID4__c';
    // public final static String BAT_customerExternalId4 = 'BAT_ExternalSubscriberId5__c';
    public final static String BAT_customerExternalId5 = 'BAT_ExternalCustomerID5__c';
    
    //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update
    public static List<String> CIAM_Sources = new List<String>{'eCommerce - Glo','eCommerce - Vuse','eCommerce - Velo','OneUP'};
    public static List<String> Not_CIAM_Sources = new List<String>{'Retailer','Hostess', '1to1'};
        
    //27.02.2024/Chirag Kalra/ US #1607214 - SK - Extension of retailer´s portal for hungarian phone numbers
    public static String HUNGARY_COUNTRYCODE = '+36';
    public static String SK_COUNTRYCODE = '+421';
    
    //28.02.2024/Varaprasad Sada/US#1637513-RS HR SI - Multicategory consents update + profiling consent (CRM Only)
     public final static Set<String> COUNTRY_SET_RS_HR_SI = new Set<String>{'RS','HR','SI','BA','AL','MK'};
    //07.10.2022/Idrees Ali/ US #1124347 - GR- Vuse MGM Enabling Mechanism
    public static final String VERSION2_HEADER_STR = 'version2';

    //15.03.2024/Chirag Kalra/US#1646801-RO - Consumer status & Brand House update scenarios
    public static final String ONEUP_TOUCHPOINTNAME = 'OneUp';
    public static final String PACKCODE_KENT = 'Kent';
    public static final String PACKCODE_ROTHMANS = 'Rothmans';
    public static final String PACKCODE_PALLMALL = 'PallMall';
    
    //02/04/2023/Varaprasad sada/US:1652524- UA FMC Account Creation and Updation from CRM to Shopify (Glo, Velo, OGO)
    public final static string BRANDHOUSE = 'Brand_House__c';
    public static List<String> FMC_Sources = new List<String>{'Glo','Velo','FMC'};
    
    //12.04.2024/varaprasad sada/US#1678137-ES / PT Expertus integration - Keep first asset source creation.
    public static String ASSERT_SOURCES = System.Label.BAT_AssetSources;
     //10.04.2024/Chirag Kalra/US - 1680227, CA - Confirm Logic of VELO (Zonnic) Email Opt In
    public final static String PROFILE_SYS_ADMIN_CA='BAT System Administrator - CA';
    
    //23/05/2024/Varaprasad sada/us#1676180-CA-MuleSoft configuration changes - Reverse integration to CA Zonnic and Vuse (INC0784170)
    public final static string VELO_OPT_IN_EMAIL_COMMUNICATION = 'BAT_IsVeloOptInEmailCommunication__c';
    public final static string VUSE_ITCAN_OPT_IN_EMAIL_COMMUNICATION = 'BAT_IsVuseOptInEmailCommunication__c';
    
    //09.July.2024/varaprasad sada / US#1771605-SE - Salesforce Data Retention Policy - Account (part2)
    public final static String PERSON_BIRTHDATE = 'PersonBirthdate';
    public final static String AMP_EMAILOPTOUT = 'BAT_AMPEmailOptOut__c';
    public final static String SHIPPING_ADDRESS = 'ShippingAddress';
    public final static String MOOR_EMAIL_OPT_OUT= 'BAT_IsLyftOptInPostal__c';
    public final static String EXTERNAL_CUSTOMER_ID3='External_Customer_ID3__c';
    public final static String EXTERNAL_CUSTOMER_ID4='BAT_ExternalCustomerId4__c';
    public final static String LOYALTY_PLATFORM_STR = 'Loyalty Platform';
     // start  Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\
        public static Boolean isBrandProfileUpdate  = false;
     // end Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\

    // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update\
    public static Boolean isCZloyalty  = false;
    //09/07/2024/Varaprasad sada/us# 1744353 -RO - update of the anonymization script part 2
     // 1764639-IT | Reverse integration flow with batch anonymization starts//
        public static Boolean isReverseanonymized  = false;
     // 1764639-IT | Reverse integration flow with batch anonymization ends//
    public static final String DELETEOLDACCOUNTBATCH_ORDERSTARTDATE = '\' AND EffectiveDate >= ';
    public final static String CUSTOMER_SERVICE_ZA = 'BAT Customer Service - ZA';
     public final static String CARELINE_MANAGER_ZA = 'BAT Careline Manager - ZA';
    //1829230--start
    public static string TP_RESPONSE_CODE200='code -200;';
    public static string TP_RESPONSE_BP='BP';
    public static string TP_RESPONSE_CLUSTER='CLUSTER';
    public static string TP_RESPONSE_ResultType='ResultType';
    public static string TP_RESPONSE_SCORE='SCORE';//1829230-end
    //1947819
     public final Static String CONSUMER_DEVICE_STR = 'BAT_ConsumerDevice__c';
     
     
     // MIAW variables , Messaging Channel Developer Names
    public static final String VUSE_UK_MSGCHANNELNAME = 'MIAW_UK';
    public static final String VUSE_FR_MSGCHANNELNAME = 'MIAW_FR';
    public static final String  MIAW_CHAT_STATUS  = 'Ended';


}