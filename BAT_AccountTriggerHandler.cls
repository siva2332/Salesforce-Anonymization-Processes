/********************************************************************************************************
* @author        : Deloitte
* @class         : BAT_AccountTriggerHandler
* @testClass     : TestClass_BAT_AccountTriggerHandler
* @description   : [All Markets]Class to handle business logic for trigger execution on Account object
* @createdDate   : 02/03/2018
* @lastModified
Date          : 30/05/2019
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the class
06.02.2019/Tejaswi Nissankula/Code Optimization
03.04.2019/Tejaswi Nissankula/Verifing mobile number change during the insertion/updation of record
04.04.2019/akshata Rajmane /added method to valdiate mobile formats wrt country
06.04.2019/Salman Khan/US# 10254:Create reward profile on device registration for KZ.
07.04.2019/Salman Khan/US#10256 : bypass the Member get member code validation.
04.04.2019/akshata Rajmane /added method to valdiate mobile formats wrt country.
08.04.2019/Satya Nalluri/Implemented US #12008 
19.04.2019/Tejaswi Nissankula/Assigne Owner as integration user for all HR hypercare tasks.
20.05.2019/ Neha Lund: 23701: To remove "+" from Mobile number 
06/04/2019 - US# 10254 - Create reward profile on device registration for KZ.
07/04/2019 - US#10256 - bypass the Member get member code validation.
01.04.2019/Abhishek Kashyap/Added functionality for DE market under before update to update GLO,VYPE,Pall Mall, Lucky Strike and EPOK 
concent date time field whenever respective checkbox is updated.
: 2nd April 2019/Nancy Thangamani/ Commented the lines of code specific for DE to assign the value of custom mobile field to standard one: US:16244
24.04.2019/Abhishek Kashyap/ BUG - 20177, DE, Added logic to check for blacklisted details and likewise prevent account creation/Update.
25.04.2019/Abhishek Kashyap/ US - 20271, DE, Updated the code to update timestamp on BAT_VypePersonalDataHandlingLastUpdAt__c,
BAT_GloPersonalDataHandlingLastUpdAt__c when BAT_IsVypePersonalDataHandling__c, Registration_Permission__c gets updated respectively.
06/04/2019 - US# 10254 - Create reward profile on device registration for KZ.
07/04/2019 - US#10256 - bypass the Member get member code validation.
18.04.2019/Shreeyanshu Kumar/Added method 'accountPrivacyConsentFlagUpdate'
23.04.2019/Shreeyanshu Kumar/Added method 'createTrialOnTrialistUpdate'
29.04.2019/Shreeyanshu Kumar/IT-Vype: BUG#20121:Updated method 'createTrialOnTrialistUpdate'
08.05.2019/Shreeyanshu Kumar/IT-Vype: US#20399:Updated method 'checkExistingLeadToUpdateAccount' which is renamed from 'bypassDuplicationRule'
31.05.2019/Tejaswi Nissankula/When POS Agent user is creating Account ,then flow the account source data from -
-user's Account source field if it is not blank else set the value as "POS Agent" (US25038)
30.05.2019/Abhishek Kashyap/DE :Sprint16 : 13295 Refactored the code for updating date time fields if corresponding consent field is updated
29.08.2019/Varun Kochar/AZ: Sprint3: US#43961: AZ - Admin - Survey Invitation Links on Salesforce
04.07.2019/Abhishek Kashyap/US - 20647 / Updated checkForPotentialDuplicateAccounts Updated the query, duplicate check string and added condition to mark accounts as potential duplicates for Austria if they have same combination of DOB and Zip Code
06.12.2019/Abhishek Kashyap/ US# 37563 UCCAB Multi - Brand House on Lead and Consumer, Refactored the code to apply validations for Brand House..
4.08.1993/Tejaswi Nissankula/[UA,KZ]When a Integration user/Non Integration user is trying to insert an account with mobile number,brand house
and if we have a lead in system with same mobile number and brand house as account then throw error to non intergration user to convert lead instead
of creating new account where as for integration user update the status of lead to "Converted".[US37833]
16.08.2019/Ushabala Kanduru/DE :BUG#41278 : Updated the code to update timestamp on 'BAT_IsVypeOptInEmailCommunication__c' when 
-Last Vype Opt In Email and Last Vype Opt out Email communication fields are updated.
20.08.2019/Tejaswi Nissankula/As part of US37847,we need to insert consumer reward profile record for Glo/velo 
accounts when Glo asset is associated.So we replaced Status__c with BAT_THPStatus__c .[UA,KZ]
28.08.2019/Abhishek Kashyap/BUG - 43449, added logic to skip trial creation for velo accounts
28.08.2019/Abhishek Kashyap/US - 37814, Added logic to create product interest for Velo trialists.
10.09.2019/ Rajesh Potla / US#34217 Added Logic to Anonymize Accounts based on field BAT_Is_Anonymised__c
12.09.2019/Tejaswi Nissankula/Removed AccountSourceConfiguration Custom metadata query and moved to constructor.
20.09.2019/Abhishek Kashyap/Optimized code to restrict brand house validations to fire only for person account record types only.
09.10.2019/Abhishek Kashyap/Updated the method to populate Related Lead field on Account and to update status field on lead based on brand
30.09.2019/Satya Nalluri/ BUG#48839: Method to handle Deletion of privacy snapshot records logic of account
09.10.2019/Abhishek Kashyap/Updated the method to populate Related Lead field on Account and to update status field on lead based on brand
1.10.2019/Ushabala Kanduru/Bug#47228: Update Last Vype Opt In Email and Last Vype Opt out Email communication fields only when those are null
10.10.2019/Abhsihek Kashyap/BUG - 52631, Restricted users from creating account of brand not avalilable for them.
4.10.2019/Abhishek Kashyap/BUG-53290, updating brand specific status fields on lead when an account with different brand house but with same mobile is inserted.
04.11.2019/Abhishek Kashyap/BUG - 57659,UCCAB Added fix to prevent multiple product interest creation during account update on order generation
18.10.2019/Ushabala Kanduru/BUG-55227, Added revertIncorrectAccountStatusFieldChanges method to prevent incorrect brand status field update for UCCAB
27.11.2019/Rajesh Potla//US#47996 Added logic to capture Consent field for RO.
27.11.2019/Neha Lund/BUG-65227, to update newsletter flag based on email opt out flag of Account unsubscribed from Marketing Cloud
09/12/2019 / Souvik Dinda/ US#47980 - Added logic for person account history deletion on anonymization.
17/12/2019/ Souvik Dinda/ Added as part of Sprint 34 to have name of privacy snapshot with Roman Timezone
for Roaman accounts/leads.
16.12.2019/Abhishek Kashyap/CA-64327-Added logic to populate VapeConsumerSince Date
19.12.2019/Osheen Sahajpal/CA: Sprint-2: Bug #71548: Updated code to fix privacy snapshot generation issue on Update
20.12.2019/Abhishek Kashyap/US-64690, CA - Admin Portal - Logic for Vape Consumer Status, updated revertIncorrectAccountStatusFieldChanges method.
01.03.2020/ Tejaswi Nissankula/[MX] Stamping user's store detail on Account record : US#60604
16.01.2020/Tejaswi Nissankula/As part of MX Vend Integration Bug#76248,Auto Lead conversion in salesforce should happen when user create an Account from MX Vend with Account Source as Own Kiosks and Login user is MuleSoft Integration user.
23/01/2020/Satya Nalluri/Bug-78625 Updating the generic permission to false in order to prevent duplicate emails triggered from both lead and account during Marketing Cloud journey for UK market
25/02/2020/Kushagra Jain/Changed Alignment of the class by Condensing Multiple lines in single line keeping logic intact.
07.04.2020/Tejaswi Nissankula/[SE]#US#110377 Set the BAT_ExternalSubscriberId4__c on account duirng lead conversion
14.04.2020/Tejaswi Nissankula/KZ-Glo:US#104695/Added logic to flow External Subscriber 2 data from lead to person account on auto Glo lead conversion when eCommerce Glo account is inserted/updated .
14.04.2020/Tejaswi Nissankula/KZ-GLo:US#107514 When THPStatus of Glo lead is 'Subscriber' then set newly inserted different brandhouse(Velo) acc's THPStatus value to 'Subscriber'.
28/02/2020 /Satya Nalluri /Bug - 59589 Modified method 'updateConsumerSinceDate' method to make the consumer since date population logic using custom metadata.
07/04/2020/Tejaswi Nissankula/[SE]#US#110377 Set the BAT_ExternalSubscriberId4__c on account duirng lead conversion
15.04.2020/Tejaswi Nissankula/[Bug#114834]Added logic for 
and EPOK brandhouse to fix the issue related to person account duplicate rule in method "UpdateAccountBrandStatusFields"
22 April,2020/Abhishek Kashyap/US - 107490- CRM - KZ GLO: Bypass global email duplicate check on Lead and Account for UCCAB
03.05.2020/Prince Chawla/[Bug#115521]- Avoided SObject row does not allow errors in method generatePrivacySnapShotPDF
26.05.2020/Tejaswi Nissankula/ ES-Glo:US#120789 : Added logic to flow the external subscriber 2 data from Glo lead to glo account when acc is created/updated from eCommerce-Glo
05.06.2020/Edwin Resendiz/Bug #141927 - Add validation to remove IT country of the MGM code checking.
20/05/2020/Satya Nalluri//Bug #128431/ Added null check for personEmail in 'removeNonConvertedDuplicateLead' method  to handle null pointer in case if the Accounts are being loaded by Integration user or system administrator whith out populating person email
26.05.2020/Tejaswi Nissankula/ ES-Glo:US#120789 : Added logic to flow the external subscriber 2 data from Glo lead to glo account when acc is created/updated from eCommerce-Glo
15.06.2020/Souvik Dinda/US#138738 - Added method to populate privacy field text configured in BAT_DefaultPrivacyDetailsConfiguration__mdt
against the consent fields as per the market.
22.06.2020/Edwin Resendiz/Bug #124628 - List has no rows for assignment to Sobject generatePrivacySnapShotPDF
21.05.2020 / Rajeev Arya /US #71365 : Added logic to check the difference between the verified and changed Email Address before saving record.
12/03/2020/Akshaya Sarvesh/Added braces after If statements as part of Force Reviewer violation
16/03/2020/Akshaya Sarvesh/Modified as part of Force reviewer violation Removing Hardcoded Strings.
23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
30.06.2020/Tejaswi Nissankula/ID : US#144638 : Added logic to stamp today's date on Last Consent Date when Velo Consents fields are updated on existing account or when an new account is created. 
:15/07/2020 /Tejaswi Nissankula/ID : US#141111: Added logic to flow External Subscriber 4 Id from lead to account on auto lead conversion process .Setting the Velo consent flags to false on auto lead conversion process.
24.07.2020/Roopa N/[ID] : US#227057: Added UpdateAccountRecordtypeOralStatusFieldChanges method to Update Account Recordtype when Oral Status is Changed
29.07.2020/Roopa N/[ID] : Bug#249597: Added logic to update Account Consent Fields to "False" when Lead consent fields are "True" while lead conversion process
05-Aug-2020/Roopa N/[ID] : US# 256630: Added logic to update Account Recordtype to Direct Consumer when Oral Status is Consumer.
22.07.2020 - Anna Gomez(Deloitte) Bug#228140 - Replace BAT_Utilities.getProfileName() with user.Profile.Name to resolve SOQL query error and take BAT_Utilities.isNEAPortalProfile() out of for loop and use isNEAPortalUser boolean attribute
19 June,2020/Dipika Gupta/US#135371-PL - Technical Setup - Consent Structure on Lead
[PL] 25.06.2020/ Mallik Balla/ US#176027 :   - PL - Technical Setup - Automatic Lead Conversion 
[PL] 2.07.2020/ Mallik Balla/ US#128832 :Bypass the Account Duplicate rule for PL such that the Account is allowed to convert if the source is from Integration
03.07.2020/Dipika/PL 152410/ Delete task according to Task subject given in metadata
16.07.2020/Chiranjeevi Srinivas/ PL: US #169252 - Defaulted Care Center as Account Source for Customer Service PL
17 Sep 2020 - Anna Gomez(Deloitte) Bug#283098 - Place BAT_Utilities.setDefaultPrivacyDetailsConfig() outside of for loop to resolve SOQL query error
22.09.2020 - Anna Gomez(Deloitte) Bug#284828: ID - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber
24.09.2020 - Edwin Resendiz - Add isblank condition to personMobilePhone
10/08/2020/ Akshata Rajmane /FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes
23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields 
30.10.2020/ Mallik Balla/ Bug #314845 - PL - Updated the method - UpdateAccountBrandStatusFields() to revert the THP/Vape/Oral Statuses to Blank only if Brand House doesn't contain Yourchoice
These status values will be sent from Yourchoice integration system while creating/updating an account
16/10/2020/Sandeep Joshi/US#287199: Added Country check for ZA in two IF Loops of method removeNonConvertedDuplicateLead so that code will run as expected for South Africa  as well.
[ZA] 17.10.2020/ Sandeep Joshi/ US# 287199 : added IF loop to check lead Country if ZA then call method convertSubscriberToAccount for stamping required lead field values to respective account field values.
Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Populate Store lookup on Account for given Store Id.
11/11/2020/Rama Akella/US#317429: Added FR country check in the method 'removeNonConvertedDuplicateLead' to make the automatic lead conversion for duplicate leads logic work for all FR profiles. 
11/11/2020/ Rama Akella/ Bug#326148/ FR/ Added the logic in the method 'removeNonConvertedDuplicateLead' to set the privacy consents false for a converted lead
19.10.2020/Dipika Gupta/US#292087/Added logic for CZ when eCommerce account is inserted with existing phone number on lead, convert lead to person account
21-Oct-2020/Roopa N/US#290302 & 290314/ CZ - Bypass global email duplicate check on Lead and Account for CZ
21-Oct-2020/Roopa N/US#290302/ CZ - When a Non Integration user is trying to insert an account with mobile number and if we have a lead in system with same mobile number then throw error to non integration user to convert lead instead of creating new account
28.10.2020/Allada Yeshwanth/US:300982/Added Retailer with device bypass when the portal user tries to insert account and then convert lead.
US #296149: 05.11.2020/Allada Yeshwanth - Defaulted Care Center as Account Source for Customer Service CZ
[CZ] 06.11.2020/ Allada Yeshwanth/ US#301020 : added setphoneonlyCountries To bypass Lead duplicate rule with Same Email
06.11.2020/Souvik Dinda/ US#296128 - Added a new field BAT_MemberGetMemberVypePromotionalCode__c for checking the Vype Promotional code during Account registration for IT/ES.
19.11.2020 - Edwin Resendiz - Bug 333265 - Removed UA criterial of if condition byPassDuplicateRules from OnBeforeInsert method.
24/11/2020/Rama Akella/Added new metadata BAT_BypassDataLoadConfiguartion__mdt to bypass automatic lead conversion during data load activity
14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
15.02.2021/Akshata Rajmane/US#410470 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic
07.01.2021/Akshata Rajmane/US#365821 : PL - D2C/Hostess - Hypercare Task creation logic update
13.01.2021/Idrees Ali/US#340701 : IT - Enabled selective choosing of account source values using BAT_isPreferenceRequired__c.
13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Calling associateAssetWithAccount for auto asset generation 
03.02.2021/Rama Akella/US#103007: AZ- Updated logic to create Hyper Care tasks on after insert
13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Calling associateAssetWithAccount for auto asset generation
:05.03.2021/Akshata Rajmane/Bug #431672 :GR - Lead not getting converted
08.03.2021 / Akshata Rajmane/ GR - Lead conversion based on updated duplication logic (email OR phone)
11.03.2021 / Akshata Rajmane / #bug 443449 :Error during Lead conversion for the Flagship profile      
13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Calling associateAssetWithAccount for auto asset generation
02.02.2021/Rama Akella/ENH:Sprint-72: UK: US#300776: Removing the references of Generic_Permission__c for UK since the field is no longer in use for UK market
03.02.2021/Rama Akella/US#103007: AZ- Updated logic to create Hyper Care tasks on after insert
13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Calling associateAssetWithAccount for auto asset generation
15.02.2021/Osheen Sahajpal/ENH:Sprint-73:HRV:US#309143:Assigning owner with particular user type
18th Feb,20201/Abhishek Kashyap/US-405628, Updated UpdateAccountBrandStatusFields, Added logic to update Combustible Status field if Brand House contains FMC
22nd Feb,2021/Roopa N/RO: US# 405881/ Added !String.isblank check
01.03.2021/Idrees Ali/US#382068 : Added IT country check and prepopulation logic for birthdate & gender to enable Auto-lead conversion incase of IT glo Reach
17th March,20201/Abhishek Kashyap/US#434292-RO - Technical Setup - Duplicate error shown on Email Verification Screen
22.03.2021/ Akshata Rajmane/ Bug#455945 : Bypassed member get member promotional code validation for greece market
23rd Mar,2021/Roopa N/RO: US#447210- Update Account Recordtype from Trialist to Direct Consumer upon online registration(when Integration sends External Customer ID 5/External Customer ID 3 value)
24th Mar,2021/Roopa N/RO: Bug#457454 - Updated logic to Anonymize related brandprofiles in Account Anonymization via CIAM Integration.
24th Mar,2021/Roopa N/RO : US#445129 - Added logic to update Is Anonymized field to False for Partially Anonymized Accounts when External Customer ID 5/ External Customer ID 3 is passing from Integration.
5th April,2021/Roopa N/RO: US#461730 - Added logic to update Account's Last Consent Date & Month 24 Anonymize Date based on update of consents
6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
08.04.2021/ Allada Yeshwanth/ Converted field update workflows to triggers
13.04.2021 /Dipika / #449349 : Lead Conversion Logic added condition for PL
14th April,2021/Abhishek Kashyap/ BUG-486567-466400 - Birthdate updated via Reverse Integration is not syncing back to CIAM
15.04.2021/Anna Gomez/Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
16th April, 2021/Abhishek Kashyap/US-225171-RO - Anonymized personal data visible in Orders
20th April,2021/Roopa N/RO :US#489095 -When partially anonymized account is re-registering again with same mobile number by GloStore/Flagship profile users then update append account's Brand House with Glo & THP status to prospect.
09.05.2021 /Akshata Rajmane / US#505672 : Avalanche - Technical Setup - Duplication Rule Logic
11-05-2021/Idrees Ali/Avalanche Velo - US#505673 - Updated query and added extra DEEU in OR filter
25.05.2021 / Idrees Ali / Avalanche-US#511371 / Added Account Source field in updateConsumerSinceDate method to the meta query and blank check for account Source in if condition
25.05.2021/ Allada Yeshwanth/ US: #525000/  Moved  UpdateAccountBrandStatusFields before removeNonCOnvertedDuplicateLeads and added isBefore check for chanign the lead owner or account owner
17th June,2021/Abhishek Kashyap/US-562099-RO - Reconsenting - CRM ENH - To update Month 24 Anonymize Date field on Account
13.04.2021 /Dipika / #449349 : Lead Conversion Logic added condition for PL 
15.04.2021/Anna Gomez/Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
16th April, 2021/Abhishek Kashyap/US-225171-RO - Anonymized personal data visible in Orders
20 May,2021/Abhishek Kashyap/US-451955-ES - Reach Tobbaconist Spain glo
15.06.2021 / Allada Yeshwanth /#563957 Optimization Activity / Added Entry Check to filter the records only if the duplicate identifier has been changed
13.07.2021/Idrees Ali/Sprint-82: US #443357:Lead Conversion - Mark Consent Fields as Opt Out once Lead is Converted and Account is created; Removed manual consent opt out checks for FR and ID
30.07.2021/Dipika/ENH : US#541023 - bypass asset on automatic opportunity
//US: #708711 // Allada Yeshwanth // add logic to give points for IT retailers whose QR code leads are auto converted
// 04.10.2021 / Allada yeshwanth / #709734 / Adding Mobile Auto Convert for RS 
18th Oct,2021/Roopa N/US #748337/ ENH: Sprint 90: UK - Age verification flag consistency (phase 2): multibrand scenario 
21.10.2021/Rama Akella/Bug#773419/IT - Reverted changes of US#708711 so as to add reward points only when Account THP status changes to 'Consumer'
23rd Sep,2021/Roopa N/ENH : Sprint 88: US#712489 - UK - Updating PersonHasOptedOutOfEmail, IsMobile_Opt_Out__c to true when BAT_IsBlacklisted__c is true
// US# 708320 // Allada Yeshwanth // added logic to change the owner of lead when getting converted by POS AGET OR GLO Store users of IT. This is to Avoid Error from Database.convertLead
// 01.12.2021 / Turbasu Ghosh // US : #753842 // HR - glo.hr Integration - Scenario 1: New Consumer (glo.hr --> CRM)  // Lead conversion logic to be added to work on Mobile match  for HR
//06.12.2021 / Turbasu Ghosh // Bug#823567 / Adding Country_HR for Lead conversion logic to be added to work on Mobile match  for HR
15.12.2021/Idrees Ali/ US#756326:Added logic to allow account related fields to be stamped on Related child case record before anonymisation as part of Data Retention Policy 
// 07.01.2022 / Allada yeshwanth  / #728622 / Adding Country_SK for Automatic Lead conversion in updateLeadOnInsertOrUpdateOfIntegratedAcc method
// 13.01.2022/ Allada yeshwanth/ BUG : #864204: -- adding SK account to setPhoneOnlyCountries to bypass error.
// 01.02.2022/ Idrees Ali/ BUG : #870405: -- Updated the If block in to check brand specific status change to consumer for MGM counter 
// 13.02.2022/Idrees Ali/US#893500 : Added PT country check to bypass retain account owner
//21.02.2022 Praveen Mundinamani | 804167 | KZ - National ID Validation Rule | Modified checkIfMemberGetMemberExists method to reuse the Account query to avoid SOQL limit.
//Bug 933568 : KZ bypass nationalId validation check if lead is converting to Account
//22.03.2022/Rama Akella/KZ/ US#804167: LeadscheckExistingLeadToUpdateAccount - Bypassing the duplicate National ID validation for converted
//19.04.2022 / Turbasu Ghosh / US#884781 /DE - CRM - Consumer order details section - Prospect since date stamp
//8/05/2022 /Aditi Sharma / US866026 CZ - Salesforce Data Retention Policy - Account
//11.05.2022 / Sonal Srivastava / US#778528  /  Added batch check to avoid trigger run for account anonymization that is already done via Global Data Retention batch(Data Retention US)        
18.05.2022/Rama Akella/US#868497:SK- Added SK to update Month_24_Anonymize_Date__c based on Last Modified Date
//23.05.2022 / Sonal Srivastava / Bug# 1011375 || Added country check for FR,UK and CZ -- to exclude cases of these countries to be anonymised
31.05.2022/Rama Akella/US#866027: HR - Update Month_24_Anonymize_Date__c based on consents for Data Retention - Account
09.08.2022/Anna Gomez/ Bug#1092764:IT - Update QRCode Reward Logic on Account update to Consumer without Asset
//Sep5th,2022 - Bug - 1123458/Rajeswari N- CRM-Account source populated incorrectly when account is saved in CRM - updated assignAccountSource method
01.09.2022/Sameer Ranjan/ US #1035808 - CZ - MultiCategory - Account anonymisation on Salesforce || Bug#1060733 - Preventing Privacy snap shot creation when account will delete from eCommerce 
//10-08-2022/Anna Gomez/ENH-IT: US#1068152 - Added logic to populate Loyalty Opt Out Date based on Loyalty Completed Survey field 
14.09.2022/Anna Gomez/ Bug#1132293: IT - Removing REACH filter as IT Account registration also flows from REACH 
//31Aug/samekala@deloitte.com/US#1028107 :Global: All Markets: To include Synchronisation field on Account to synchronise data correctly on Marketing Cloud
13 Sep 2022/ Praveen/US#1122532 / SI - Technical Setup - Duplicate Rule Logic on Person Account
26.09.2022/Vamsi Ramineni/US #1105804/Global - Privacy Snapshot creation for Account 
19.10.2022/Swaraj Ray/US #1120605/PL - CRM - RFM Segment in SF per brand (S117)
10.Nov 2022: Praveen: US #1136793 : SI - Account - Data Retention Policy    
18.05.2022/Rama Akella/US#868497:SK- Added SK to update Month_24_Anonymize_Date__c based on Last Modified Date  
31.01.2023/Idrees Ali/ Sprint 122 - US#1154669 - FR-Velo- Added below logic to handle partial/full anonymisation of account when it is being deleted from ecommerce owing to ITT Integration model changes
07.02.2023/Anna Gomez/ Bug#1294165: UA - Adding UA Country to populate PersonBirthDate field when Birth_Date__c is populated
1 Mar 2023/ Praveen/ US #1284980/  IT - Glo Sharpend API integration from 3rd Party Retail to SF (QR code) - part2
02.03.2023/Idrees Ali/ENH: Sprint-125:US#1228423-IT | glo | Point assignment to retailer if customer joins Loyalty || Added Method
23.03.2023 /Idrees Ali/Created the method - [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
3 Apr 2023: US #897350 : UK: Added 3 years 1 day for anonymization date
21.04.2023 / Debasis Maharana / UA -Bug#1368955 /Reward code generation is totally dependent on time stamp, so it creates duplicate codes, so I added a random string before encryption.  
15.05.2023/ Chirag Kalra/ US-1339519, FR,  Added BAT_VeloFeedbackCallAuthorization__c,BAT_VeloOptOutDateLastFeedback__c for Anonymization 
21.06.2023/Varaprasad Sada/US#1324896/CH Dunhill Integration - Consumer Account Deletion
21.07.2023/Varaprasad Sada/US#1294646/RO-newsletter vuse.ro & newsletter glo.ro
29.09.2023/Lalit / US:#1503391|| HR|SI - DATA RETENTION POLICY -Account
10.01.2023/Shanmuga/US:#1498757||RO - reconsent from site
26.10.2023/Lalit/US-1520627, SE/DK - AMP Last Consent Date field Update Logic 
22.Nov.2023/BJSURAJ/ #1520643/SE/DK- Technical Setup - Lead Conversion Logic// added SE/DK country check
23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update
19.12.2023/BJSURAJ/US: #1582604 - IT GLO - Asset&Account Source should not be updated
23.12.2023/ShanmugaPriyan/US: #1591514- IT GLO | Asset update from Sharpend
05.July.2024/Varaprasad Sada/US: #1769553-FR - Enable Campaign object (CRM & INT)
*********************************************************************************************************/
public class BAT_AccountTriggerHandler{
    
    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    private Id currentNetworkId = System.Network.getNetworkId();
    private Map<String,Id> recordTypeDevNameMap;
    private Map<String,String> countryCurrencyMap = new Map<String, String>();
    private static String trialistRecordTypeId = null;
    //C Z loyality
    public static boolean isMergeAccount = false;
    // for account merge CZ, stop recursion 
    public static boolean mergeCZ = true;
    public String oldPhoneNumber='';
    public String strBrandHouse='';
    //cz loyalty
    public string oldAccountid='';
    // public string  olriginalMobileNumber='';
    // public Set<ID> accountsToUpdateloyality = new Set<ID>();
    public BAT_AccountMerge__c mergeSetting = new BAT_AccountMerge__c();
    // CZ loyality
    public static User user;
    public static List<User> userList = new List<User>(); 
    public static Set<String> accSourceSet = new Set<String>();
    public static Map<string,BAT_AccountSourceConfiguration__mdt> accSourceUserNameMap = new Map<string,BAT_AccountSourceConfiguration__mdt>();
    //Constants used in method "generatePrivacySnapShotPDF"
    public final static String STR_UnitTest = BAT_COnstantsUtility.BAT_UNIT_TEST;
    public final static String STR_UnderScore = BAT_COnstantsUtility.UNDERSCORE;
    public final static String STR_Id = BAT_COnstantsUtility.BAT_ID;
    public final static String STR_Title = BAT_COnstantsUtility.BAT_TITLE;
    public final static String STR_ForwardSlash = BAT_COnstantsUtility.FORWARD_SLASH;
    public final static String STR_P = BAT_COnstantsUtility.P_STR;
    public final static String STR_PDF = BAT_COnstantsUtility.PDF;
    public final static String STR_NextLine = BAT_COnstantsUtility.ATH_NextLine;
    private static boolean isSnapShotGenerated = false;
    private static List<BAT_TaskDeletionCountryConfiguration__mdt> taskDeletionConfiguration = new List<BAT_TaskDeletionCountryConfiguration__mdt>();
    private static Set<String> taskDeletionCountries = new Set<String>();
    private static map<String,BAT_TaskDeletionCountryConfiguration__mdt> mapTaskDeletionConfiguration = new map<String,BAT_TaskDeletionCountryConfiguration__mdt>();
    public static Set<String> regionsSet = new Set<String>();
    public static Boolean bypassGenerateInvitationLinkOnAccountCreation = false;
    public static Boolean bypassLeadConversion = false;
    public static String consumerRecordTypeId = null;
    //US#47996 - Using map to hold country against list of metadata values.                
    private static Map<String, List<BAT_ConsentDateUpdateConfiguration__mdt>> consentDateUpdateConfigMap= new Map<String, List<BAT_ConsentDateUpdateConfiguration__mdt>>();
    private static Map<String,BAT_AutomaticAnonymizationConfiguration__mdt> automaticAnonymizationConfigMap = new Map<String,BAT_AutomaticAnonymizationConfiguration__mdt>();
    //Constructor Call
    //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : variable to store the integration user id for PL country
    public static ID integrationUserID;
    //US:530277 || Pratishtha Pathak || Querying retailer record Type.
    public static ID retailerRecordTypeId = BAT_Utilities.getRetailerRecordTypeId();
    //804167 | KZ - National ID Validation Rule - this variable used to collect all the National Ids of KZ in both insert and update
    public static Map<String,Set<String>> mapCountryNationalId = new Map<String,Set<String>>();
    //KZ bypass nationalId validation check if lead is converting to Account
    public static Set<Id> leadsToBypassNationalIdValidation = new Set<Id>(); 
    public static List<Id> accIdsToAnonymizecases = new List<Id>();
    //23.03.2023 /Idrees Ali- [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM- Instantiating inner class
    public static BAT_Utilities.REWCodeWrapper rewCodeWrapObj = new BAT_Utilities.REWCodeWrapper();
    //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update-
    public static Boolean isROAnonymizing  = true;
    //1498757 RO - reconsent from site starts -------//
    public static Boolean isConsentChanged  = false;
   //1498757 RO - reconsent from site ends -------//
   //1703189-DE - multicategory Loyalty program - Anonymisation starts--
    Map<String,sObject> anonymisedRecordMap = new Map<String,sObject>();
    //1703189-DE - multicategory Loyalty program - Anonymisation ends--
    // Bug 1785965-{Support-INC0900118}- Asset updates points issue
     public static Boolean isRegistrationPermissionChanged  = false;

     public Set<String> sharpend_sources = new Set<String> (BAT_ConstantsUtility.SE_Sources.split(BAT_ConstantsUtility.SEMI_COLON));
    /********************************************************************************************************
* @author        : Deloitte
* @constructor
Name          : BAT_AccountTriggerHandler
* @params        : Boolean - determine the trigger context,Integer - maintain the size of account records
* @Description   : [All Markets]Constructor is used to maintain the account recordtype map and currencycode
map
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the constructor 
13/03.2019/Herin Dedhia/5977-Added code to delete tasks when Trial Permission flag is set to False.                 
31.05.2019/Tejaswi Nissankula/Added BAT_AccountSource__c field in user query .This field is used 
to set accountsource on account when POS Agent is creating account(US25038)                 
12.09.2019/Tejaswi Nissankula/Add AccountSourceConfiguration Custom metadata query (accSourceSet).
06/04/2020/Satya Nalluri/Change in constructor/Resolves Too Many SOQL/Added an Empty check on the list that only makes it fire when constuctor runs for the first time.
24/11/2020/Rama Akella/Added new metadata BAT_BypassDataLoadConfiguartion__mdt to bypass automatic lead conversion during data load activity
*********************************************************************************************************/
    public BAT_AccountTriggerHandler(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
        recordTypeDevNameMap = new Map<String,Id> ();
        for(RecordTypeInfo info: Schema.Account.SobjectType.getDescribe().getRecordTypeInfos()){
            recordTypeDevNameMap.put(info.getDeveloperName(), info.getRecordTypeId());
        }
        //Fetch user details
        //Added BAT_AccountSource__c field in query as part of US25038
        //Added Store_ID_User__c in query as part of MX:US#60604 
        //06/04/2020/Satya Nalluri/Resolves Too Many SOQL/Added an Empty check on the list that only makes it fire when constuctor runs for the first time.
        BAT_Utilities.getUserDetailsGlobal();
        user = BAT_Utilities.loggedInUserObject;
        //Fetching metadata records to 
        for(BAT_BypassDataLoadConfiguartion__mdt eachRecord : BAT_BypassDataLoadConfiguartion__mdt.getAll().values()) {
            if(user.Username == eachRecord.BAT_Username__c && eachRecord.BAT_IsActive__c) {
                bypassLeadConversion = true; 
            }
        }
        //Creating currency code map
        for(CountryToCurrency__mdt currentItem: CountryToCurrency__mdt.getAll().values()){//chirag
            countryCurrencyMap.put(currentItem.MasterLabel, currentItem.Currency__c);
        }
        //5977-Fetch Countries for Task Deletion
        for(BAT_TaskDeletionCountryConfiguration__mdt currentRecord :[SELECT BAT_Country__c,       BAT_ObjectName__c,BAT_TaskSubject__c,BAT_UseTaskSubject__c,BAT_FieldName__c FROM BAT_TaskDeletionCountryConfiguration__mdt WHERE BAT_ObjectName__c =: BAT_ConstantsUtility.STANDARD_ACCOUNT_STR]){
            taskDeletionCountries.add(currentRecord.BAT_Country__c);  
            mapTaskDeletionConfiguration.put(currentRecord.BAT_Country__c,currentRecord) ;              
        }
        
        trialistRecordTypeId = recordTypeDevNameMap.get(BAT_ConstantsUtility.RECORDTYPE_TRAILLIST);
        consumerRecordTypeId = recordTypeDevNameMap.get(BAT_ConstantsUtility.ACC_RECTYPE_DIRECTCON);
        
        if(accSourceSet.isEmpty()){
            for(BAT_AccountSourceConfiguration__mdt source : BAT_Utilities.getAccountSourceConfigDetails()){
                accSourceSet.add(source.MasterLabel);
                accSourceUserNameMap.put((source.MasterLabel).toLowercase(),source);//Add as part of Bug#76248
            }
        }
        if(consentDateUpdateConfigMap.isEmpty()){
            consentDateUpdateConfigMap = BAT_Utilities.getConsentDateUpdateConfig();
        }
        if(automaticAnonymizationConfigMap.isEmpty()){
            automaticAnonymizationConfigMap = BAT_Utilities.getAutomaticAnonymizationConfig();
        }
        rewCodeWrapObj = BAT_Utilities.fetchREWCodeCofiguration();
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : OnBeforeInsert
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to handle Before Insert logic of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
24.04.2019/Abhishek Kashyap/ BUG - 20177, DE, Added logic to check for blacklisted details and likewise prevent account creation.
18.04.2019/Shreeyanshu Kumar/ Added 'accountPrivacyConsentFlagUpdate' method call
08.05.2019/Shreeyanshu Kumar/Added 'checkExistingLeadToUpdateAccount' method call
12.06.2019/Tejaswi Nissankula/Assign reward profile of POS Agent profile to account's reward profile (US23928)
20.06.2018/Osheen/NEA US#22549, 22705, 22707, Personal Authorization consent wil be by default 'True'  
26.06.2018/Mohit/NEA US #27175 Update Last_Modified_Source__c as '1:1 Portal 
15.07.2019/Divya Eduvulapati/US-21140/Added logic to check for blacklisted details and likewise prevent account creation of AT and DE markets.
18.10.2019/Ushabala Kanduru/BUG-55227, Added revertIncorrectAccountStatusFieldChanges method to prevent incorrect brand status field update for UCCAB
02.12.2019/Rajesh Potla/US#47996 - Adding logic to populate Consent date based on the field name configured in the metadata "BAT_ConsentDatePopulationConfiguration__mdt"
01/03/2020/ Tejaswi Nissankula/[MX] Stamping user's store detail on Account record : US#60604
22 April,2020/Abhishek Kashyap/US - 107490- CRM - KZ GLO: Bypass global email duplicate check on Lead and Account for UCCAB
15.06.2020/Souvik Dinda/US#138738 - Added method to populate privacy field text configured in BAT_DefaultPrivacyDetailsConfiguration__mdt
against the consent fields as per the market.
22 April,2020/Abhishek Kashyap/US - 107490- CRM - KZ GLO: Bypass global email duplicate check on Lead and Account for UCCAB
21 May, 2020/Rajeev(Deloitte)/US #71365 : Reset the field value of verified email to blank only for Non Admin and Non Integration profile users
30.06.2020/Tejaswi Nissankula/ID : US#144638 : Added logic to stamp today's date on Last Consent Date on creation of account
24.07.2020/Roopa N/[ID] : US#227057: Added UpdateAccountRecordtypeOralStatusFieldChanges method to Update Account Recordtype when Oral Status is Changed
22 July 2020 - Anna Gomez(Deloitte) Bug#228140 - Replace BAT_Utilities.getProfileName() with user.Profile.Name to resolve SOQL query error and take BAT_Utilities.isNEAPortalProfile() out of for loop and use isNEAPortalUser boolean attribute
19.06.2020 / Dipika Gupta/ PL US#135371: Update Last Consent Date when consent fields are ticked
16.07.2020/Chiranjeevi Srinivas/ PL: US #169252 - Defaulted Care Center as Account Source for Customer Service PL                                               
16/03/2020/Akshaya Sarvesh/Modified as part of Force reviewer violation Removing Hardcoded Strings.
10/08/2020/ Akshata Rajmane /FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes
23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields 
17 Sep 2020 - Anna Gomez(Deloitte) Bug#283098 - Place BAT_Utilities.setDefaultPrivacyDetailsConfig() outside of for loop to resolve SOQL query error 
22.09.2020 - Anna Gomez(Deloitte) Bug#284828: ID - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber 
Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Populate Store lookup on Account for given Store Id.
21-Oct-2020/Roopa N/US#290302 & 290314/ CZ - Bypass global email duplicate check on Lead and Account for CZ
18.10.2020/ Souvik Dinda/ Bug#304246 - Bypassed MX from Member Get Member Promotional Code check as the MGM Codes are populated via Integration.
06.11.2020/Souvik Dinda/ US#296128 - Added a new field BAT_MemberGetMemberVypePromotionalCode__c for checking the Vype Promotional code during Account registration for IT/ES.
24/11/2020/Rama Akella/Added new metadata BAT_BypassDataLoadConfiguartion__mdt to bypass automatic lead conversion during data load 
19.11.2020/Edwin Resendiz - Bug 333265 - Removed UA criterial of if condition.
26.11.2020/Souvik Dinda/US#305464 Added logic for stamping BAT_MGMCodeGenerationDate__c based on BAT_IsMGMOptIn__c checkbox only when its true.
24/11/2020/Rama Akella/Added new metadata BAT_BypassDataLoadConfiguartion__mdt to bypass automatic lead conversion during data load activity
14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
25Feb/Abhishek Kashyap/US#405626-RO - Technical Setup - Gmail verification check for offline acounts
08.04.2021 || Allada Yeshwanth || BUG: #402351 || Moved Wf to triggers
14/04/2021 : Akshata Rajmane : Commented consent date stamping code and moved it to custom metadata : BAT_ConsentStructure__mdt
18.07.2022/Rajeswari N/ US - 1071202 - CH - Admin Portal - Defaulting isActive Checkbox to false
26.7.2022/Praveen/US #1021835/ IT | Unique mobile phone number for Accounts/Leads
//31Aug/samekala@deloitte.com/US#1028107 :Global: All Markets: To include Synchronisation field on Account to synchronise data correctly on Marketing Cloud
26.09.2022/Pratishtha Pathak/ US - 1134404 - SI - Age verified is true when country is SI and Age is greater than 18
19.10.2022/Swaraj Ray/US #1120605 - Called the BAT_Utilities.checkRfmSegmentValues() to enforce RFM segment validation
10.Nov 2022: Praveen: US #1136793 : SI - Account - Data Retention Policy  
18.05.2022/Rama Akella/US#868497:SK- Added SK to update Month_24_Anonymize_Date__c based on Last Modified Date
3 Apr 2023: US #897350 : UK: Added 3 years 1 day for anonymization date 
18.04.2023/Idrees Ali /US#866028 - Added for AZ country for salesforce data retention - Account             
*********************************************************************************************************/
    public void OnBeforeInsert(Account[] newAccount){
        try{
            String strProfileName = BAT_Utilities.getProfileName();
            List<BAT_Reward_Profile__c> rewardProfile = new List<BAT_Reward_Profile__c>();
            List<Account> accountToAssign = new List<Account>();
            List<Account> memberCodeAccounts = new List<Account>();
            // added varibale as part of NEA story US# 25769
            Set<String> countrySet = new Set<String>();
            //24.04.2019/Abhishek Kashyap/ BUG - 20177, DE, Added logic to check for blacklisted details and likewise prevent account creation.
            List<Account> accountsToCheckForBlackList = new List<Account>();
            //Getting the set of markets for which the Blacklist feature is enabled from the Blacklist Configuration metadata
            Set<String> blackListMarketsSet = new Set<String>();
            Map<string,Store__c> storeMap = new Map<string,Store__c>();
            //Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Created store Id set.
             //1777324--HR - store code analysis
            Set<String> storeCodeSet = new Set<String>();
            //#1787833 - IT Vuse&Velo | Account's "BAT_OralConsumerSince__c"/"BAT_VapeConsumerSince__c" populating logics
          //  Set<String> sharpend_sources = new Set<String> (BAT_ConstantsUtility.SE_Sources.split(BAT_ConstantsUtility.SEMI_COLON));
           
            //Added as part of MX:US#60604 
            //Retrieving store details of MX flagship user
            if(user!= null && 
               user.Country__c == BAT_ConstantsUtility.COUNTRY_MX_STR &&
               string.isNotBlank(user.Store_ID_User__c)){
                   //Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Updated the Utilities method signature to accept Set as parameter
                   storeMap = BAT_Utilities.storeDetails(new set<string>{user.Store_ID_User__c},new Set<String>{user.Country__c});
               }
            //End of MX:US#60604 
            //18.10.2019/Ushabala Kanduru/BUG-55227, Method to prevent incorrect brand status field update for UCCAB
            revertIncorrectAccountStatusFieldChanges(newAccount, null);
            for (BAT_EnableBlacklistConfiguration__mdt countries:BAT_EnableBlacklistConfiguration__mdt.getAll().values())
            {
                blackListMarketsSet.add(countries.Label);
            }
            //24.07.2020/Roopa N/[ID] : US#227057: Method to Update Account Recordtype when Oral Status is Changed
            UpdateAccountRecordtypeOralStatusFieldChanges();   
             
            //02.02.2024/ Reema Meher/ #1625729 - SE Lead Conversion and Forward Anonymisation   
            for (Account newAccountObj: newAccount){
                
                //19th Oct, 2022/Swaraj Ray/Work item: 1120605: Allow only one RFM Segment Per brand - Updated to call the generic method.
                BAT_Utilities.checkRfmSegmentValues(newAccount,new Account());       
                
                //Finds DE and AT accouts and adds them to the accountsToCheckForBlackList list.
                
                
                //22 April,2020/Abhishek Kashyap/US - 107490, UCCAB - Bypassed email duplicate rule for UCCAB Leads
                //19.11.2020/Edwin Resendiz - Bug 333265 - Removed UA criterial of if condition.
                //21-Oct-2020/Roopa N/US#290302 & 290314/ CZ - Bypass global email duplicate check on Lead and Account for CZ
                //24-01-2022/Idrees Ali/Bug#872765 - SK- Bypass global email duplicate check on Lead and Account for SK
                if(newAccountObj.Country__c == BAT_ConstantsUtility.COUNTRY_KZ || newAccountObj.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || newAccountObj.Country__c == BAT_ConstantsUtility.COUNTRY_SK){
                    newAccountObj.BAT_BypassAccountDuplicateRule__c = true;
                }
               //13.09.2024/Suman Avula/ US - 1825184 - UA - RAV / SDAV update
               if(String.isNotBlank(newAccountObj.Country__c) && newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA)){
                   if(newAccountObj.BAT_Self_Declared_AV__c != true){
                       newAccountObj.BAT_Self_Declared_AV__c = true;   
                   }
                   if(newAccountObj.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || newAccountObj.BAT_OralStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || newAccountObj.BAT_CombustibleStatus__c == BAT_ConstantsUtility.ATH_CONSUMER){
                      newAccountObj.BAT_Robust_AV__c = true; 
                  }   
                }
                //02.02.2024/ Reema Meher/ #1625729 - SE Lead Conversion and Forward Anonymisation   
                
                if (newAccountObj.Country__c == BAT_ConstantsUtility.COUNTRY_SE &&
                    newAccountObj.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_AMP))
                {
                    newAccountObj.BAT_Actives_Status__c = BAT_ConstantsUtility.ATH_PROSPECT;
                }
                //18.07.2022/Rajeswari N/ US - 1071202 - CH - Defaulting isActive Checkbox from True to false
                if(newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH) && newAccountObj.IsActive_DE__c){
                    newAccountObj.IsActive_DE__c = false;
                }
                
                //CH: Splitbrand brand issue fix - Need a reference field for delete
                if(newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)){
                    newAccountObj.Legacy_Brand_DE__c = newAccountObj.Brand_House__c;   
                }
                //26.09.2022/Pratishtha Pathak/ US - 1134404 - SI - Age verified is true when country is SI and Age is greater than 18
                //25.04.2024/Suman Avula/ US - 1702001 - AL/MK/BA - Age verified is true when country is AL and Age is greater than 18
                //  if(newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SI) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AL) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_BA) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MK)){
                if(newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AL) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_BA) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MK) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RO)){
                    if(newAccountObj.Age__c != null && newAccountObj.Age__c >= 18){
                        newAccountObj.Age_verified__c = true;
                    }
                }
                if (blackListMarketsSet.contains(newAccountObj.Country__c)) {
                    newAccountObj.BAT_IsGeocodeUpdateRequired__c = true;
                    
                    accountsToCheckForBlackList.add(newAccountObj);
                }
                /* 09.05.2021 /Akshata Rajmane / US#505672 : Avalanche - Technical Setup - Duplication Rule Logic
PersonDepartment field will be populated for EU market which is being used as identifier in new and old duplicate rules*/
                if(newAccountObj.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE)
                {
                    newAccountObj.PersonDepartment = BAT_ConstantsUtility.EU_ACCOUNT_SOURCE;
                }
                 //#1787833 - IT Vuse&Velo | Account's "BAT_OralConsumerSince__c"/"BAT_VapeConsumerSince__c" populating logics
                if(newAccountObj.Country__c != null && newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_IT) && newAccountObj.AccountSource !=null && sharpend_sources.contains(newAccountObj.AccountSource.trim()) && newAccountObj.Registration_Permission__c ){
                    if(newAccountObj.BAT_OralStatus__c!=null && newAccountObj.BAT_OralStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER)){
                        newAccountObj.BAT_OralConsumerSince__c = System.Today();
                    }
                    if(newAccountObj.BAT_VapeStatus__c!=null && newAccountObj.BAT_VapeStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER)){
                        newAccountObj.BAT_VapeConsumerSince__c = System.Today();
                    }
                    
                }
                
                //added  as part of NEA story US# 25769
                countrySet.add(newAccountObj.Country__c);
                //For UA/KZ,When user has dual brand,we are holding the value of brand house selected in mobile verifcation screen in PersonTitle field, 
                //as the value on brand house field is overwritten by the default logic of brand house field when create event is fired from lightning component.
                //bug#54528
                if(string.isNotBlank(newAccountObj.country__c) &&
                   (newAccountObj.country__c == BAT_ConstantsUtility.Country_UA || 
                    newAccountObj.country__c == BAT_ConstantsUtility.Country_KZ )&& 
                   string.isNotBlank(newAccountObj.PersonTitle) && 
                   string.isBlank(newAccountObj.Brand_House__c)){
                       newAccountObj.Brand_House__c = newAccountObj.PersonTitle;
                       newAccountObj.PersonTitle = null;
                   }
                //Added as part of MX:US#60604
                //Stamp MX  user store details on Account. 
                //1777324--HR - store code analysis--Added HR country condition
                if(!storeMap.isEmpty() && string.isNotBlank(user.Store_ID_User__c) && storeMap.containsKey(user.Store_ID_User__c)){
                    newAccountObj.Store__c = storeMap.get(user.Store_ID_User__c).Id;
                    newAccountObj.Store_ID__c = storeMap.get(user.Store_ID_User__c).Store_code__c;
                }
                //End of MX:US#60604 
                //10th April,2020/Prince Chawla/BUG-#113033- KZ Issue with order submission.
                /*Populate PersonMobilePhone__c as workflow to populate Custom PersonMobilePhone__c
                -was already deactivated for #109844 and the duplicate rule was enabled for detecting duplicate mobile on Accounts.
                -But KZ is using PersonMobilePhone__c for their calculation in code, so as a temporary fix
                -in production adding this below line. Later, will open a backlog to replace
                -the reference of Custom mobile phone to standard mobile phone.*/
                //Added CH country check to stamp PersonMobilePhone value to PersonMobilePhone__c so that PersonMobilePhone__c can be used under quick action layouts .
                if(String.isNotBlank(newAccountObj.Country__c) && (newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA) 
                                                                   || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH) || ((newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.DE_STR) && newAccountObj.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE))) && newAccountObj.PersonMobilePhone != null){
                                                                       newAccountObj.PersonMobilePhone__c = newAccountObj.PersonMobilePhone;
                                                                   }
                //Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Filled storeCodeSet with given Store Id.
                //1777324--HR - store code analysis added HR coutry condition
                if(String.isNotBlank(newAccountObj.Country__c) &&(newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ZA)  || newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR))
                   && String.isNotBlank(newAccountObj.Store_ID__c)){
                       storeCodeSet.add(newAccountObj.Store_ID__c);
                   }
                //US#305464 Added logic for stamping BAT_MGMCodeGenerationDate__c based on BAT_IsMGMOptIn__c checkbox only when its true
                if(newAccountObj.Country__c != BAT_ConstantsUtility.COUNTRY_MX_STR && newAccountObj.BAT_IsMGMOptIn__c){
                    newAccountObj.BAT_MGMCodeGenerationDate__c = Datetime.now();
                }
                if(newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT)){
                    //Allada Yeshwanth || Triggeroptimization Activity || Moved WF(BAT_Account_WF_UpdateAnonymize12) to Trigger
                    if(newAccountObj.Month_12_Profiling_Deletion_Date__c == null )
                    {
                        newAccountObj.Month_12_Profiling_Deletion_Date__c = newAccountObj.createdDate != null ? newAccountObj.createdDate.date().AddMonths(12) : System.Today().addMonths(12);
                    }
                    
                    //Allada Yeshwanth || Triggeroptimization Activity || Moved WF(BAT_Account_WF_UpdateAnonymize24) to Trigger
                    if(newAccountObj.Month_24_Anonymize_Date__c == null)
                    {
                        newAccountObj.Month_24_Anonymize_Date__c = newAccountObj.createdDate != null ? newAccountObj.createdDate.date().AddMonths(24) : System.Today().addMonths(24);
                    }
                    //IT unique phone number
                    if(String.isNotBlank(newAccountObj.PersonMobilePhone) && (strProfileName.equalsIgnoreCase(BAT_ConstantsUtility.CUSTOMER_SERVICE) || strProfileName.equalsIgnoreCase(BAT_ConstantsUtility.BATSADMIN) || strProfileName.equalsIgnoreCase(BAT_ConstantsUtility.FLAGSHIP))){
                        BAT_MobileVerificationController.countryBasedMobileErrorMessage(BAT_ConstantsUtility.COUNTRY_IT);
                        Boolean unique = BAT_MobileVerificationController.validateMobileFormatwrtCountry(newAccountObj.PersonMobilePhone,BAT_ConstantsUtility.STANDARD_ACCOUNT_STR,BAT_ConstantsUtility.ACCOUNT_FIELD_MOBILEPHONE,BAT_ConstantsUtility.BLANK,BAT_ConstantsUtility.COUNTRY_IT);
                        if(!unique && String.isNotBlank(BAT_MobileVerificationController.duplicatePhnNumErrorMessage)){
                            newAccountObj.addError(BAT_MobileVerificationController.duplicatePhnNumErrorMessage);
                        } 
                    }
                }
                
                //Allada Yeshwanth || Triggeroptimization Activity || Moved WF(BAT_UK_Account_WF_UpdatePostalCodeRule) to Trigger || BUG: #402351
                if(String.isBlank(newAccountObj.ShippingPostalCode) && String.isNotBlank(newAccountObj.Postal_Code__c) 
                   && (newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR)))
                {
                    newAccountObj.ShippingPostalCode = newAccountObj.Postal_Code__c;
                }
                
                //804167 | KZ - National ID Validation Rule | Get all the National Ids of KZ accounts
                if(!user.Bypass_Validation_Rule__c && String.IsNotBlank(newAccountObj.National_ID__c) && newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) && !mapCountryNationalId.containsKey(newAccountObj.Country__c)){
                    mapCountryNationalId.put(newAccountObj.Country__c,new set<String>());
                }
                if(mapCountryNationalId.containsKey(newAccountObj.Country__c)){
                    mapCountryNationalId.get(newAccountObj.Country__c).add(newAccountObj.National_ID__c);
                }
                //30Aug/Samekala@deloitte.com/US#1049237 : Global: All Markets: To include Synchronisation field on Account/Contacts to synchronise data correctly on Marketing Cloud
                BAT_Utilities.updateSynchroniseField(newAccountObj , null);
                
                //Add as part of UK:US#1199173/Brand House field population/update
                //13.12.2022/Rahul Upadhyay/ Stamp Brand House for UK market during Lead creation
                if(String.isNotBlank(newAccountObj.Country__c) && (newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR))){
                    if((String.isNotBlank(newAccountObj.AccountSource))){                
                        for(BAT_AccountBrandHouseAssignment__mdt metaRec: BAT_Utilities.getAccountBrandHouseAssignDetails(newAccountObj.Country__c, newAccountObj.AccountSource, newAccountObj.Last_Modified_Source__c)){
                            newAccountObj.Brand_House__c =  metaRec.BAT_BrandAllowed__c;
                        }
                    }
                }
                //End of UK:US#1199173
            }
            //08.04.2021 || Allada Yeshwanth || BUG: #402351
            BAT_Utilities.updateEmailAndPhone(newAccount,null,countrySet);
            //Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Populated storeMap from storeDetails method. The map has Store Id to Store mapping
            if(!storeCodeSet.isEmpty()){
                storeMap = BAT_Utilities.storeDetails(storeCodeSet,countrySet);
            }
            
            //US#138738 added for populating privacy details against the consent fields.
            //Bug#283098 - Placed outside of for loop to resolve SOQL query error
            BAT_Utilities.setDefaultPrivacyDetailsConfig(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR, null, newAccount);
            
            // added as part of NEA story US# 25769
            /* FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes*/
            /* 23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields */
            if(!countrySet.isEmpty() && !newAccount.isEmpty()){
                BAT_Utilities.stampDateTimeOnConsentChange(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR, countrySet, newAccount, null);
            }
            
            /*** Added by Osheen Sahajpal - US-22549, 22705, 22707 - Personal Authorization check ***/
            Map<String,BAT_DefaultConsentConfiguration__mdt> mapCountryToPersonalAuthValue = new Map<String,BAT_DefaultConsentConfiguration__mdt>();
            String personalAuthorizationFieldAPI;
            Boolean personalAuthorizationFieldValue;
            Set<String> setAccountCountry = new Set<String>();
            //fethching country of current records and adding in setAccountCountry
            for(Account accRec : newAccount){
                setAccountCountry.add(accRec.Country__c);
                //Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Populate Store lookup on Account for given Store Id.
                if(String.isNotBlank(accRec.Country__c) && (accRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ZA) || accRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR))
                   && !storeMap.isEmpty() && storeMap.containsKey(accRec.Store_ID__c)){
                       accRec.Store__c = storeMap.get(accRec.Store_ID__c).Id;
                   }
            }
            //fetching metadata records which has label similar to current records' country
            for(BAT_DefaultConsentConfiguration__mdt metadataRecord : [SELECT Id, MasterLabel, BAT_FieldAPIName__c, BAT_PersonalAuthorization__c 
                                                                       FROM BAT_DefaultConsentConfiguration__mdt
                                                                       WHERE MasterLabel IN :setAccountCountry]){
                                                                           mapCountryToPersonalAuthValue.put(metadataRecord.MasterLabel,metadataRecord);
                                                                       }
            
            //Calls the method to check blacklisted name, email or domain and prevents creation of account for DE.
            if(!accountsToCheckForBlackList.isEmpty()){
                checkForBlacklistAccounts(accountsToCheckForBlackList);
            }
            
            //25.05.2021/ Allada Yeshwanth/ US: #525000/  Moved  UpdateAccountBrandStatusFields before removeNonCOnvertedDuplicateLeads
            //Method to validate brand-email duplicates to update Brand Status fields - Glo,Vype on Account
            UpdateAccountBrandStatusFields(newAccount);
            
            //This flag ensures that auto lead conversion methods execute only if the account is created via integration
            //Added condition to bypass auto lead conversion during data load activity 
            if(!BAT_ConstantsUtility.LTH_LEADCONVERT && !bypassLeadConversion){
                removeNonConvertedDuplicateLead(newAccount,null);
                updateLeadOnInsertOrUpdateOfIntegratedAcc(newAccount,Trigger.isInsert,Trigger.isUpdate);
            }
            //Enhacement Sprint 17 US#10888
            validateMobileNumberFormat(newAccount, null); //call mobile format validation
            BAT_Utilities.verifyMobileNumberAndEmailChange(newAccount, null, BAT_ConstantsUtility.STANDARD_ACCOUNT_STR, user); //Added as part of US11122
            updateAccountBillingCountry(newAccount, null);
            //DE:Sprint4 - 3352: This method is used to check Potential Duplicate for Accounts.
            checkForPotentialDuplicateAccounts(newAccount, null);
            
            //IT Vype: 19586
            //Bug : 59859 / Satya Nalluri/28-02-2020 - Passing Account country set as param to reduce number of Iterations
            updateConsumerSinceDate(newAccount, setAccountCountry, null);
            
            rewardProfile = [SELECT Id, profile__c
                             FROM BAT_Reward_Profile__c
                             WHERE User__c =: userinfo.getUserId() LIMIT 1
                            ];
            //Bug-228140: Take BAT_Utilities.isNEAPortalProfile() out of for loop and use isNEAPortalUser boolean attribute
            Boolean isNEAPortalUser = String.isNotBlank(user.Profile.Name) ? BAT_Utilities.isNEAPortalProfile(user.Profile.Name) : false;
            for(Account currentRecord: newAccount){
                //US#71365 - Reset the field value of verified email to blank only for Non Admin and Non Integration profile users
                if(user.Profile.Name != NULL && (!user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.SYSTEM_ADMIN) &&
                                                 !user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER))){
                                                     currentRecord.Email__c = BAT_ConstantsUtility.BLANK;
                                                 }
                
                // REWARD - insert logic to populate Reward profile for glo store if it does not exist yet
                //VSTS: change 23701
                if(!String.isBlank(currentRecord.PersonMobilePhone)){
                    currentRecord.BAT_FormattedMobile__c = currentRecord.PersonMobilePhone.replace(BAT_ConstantsUtility.PLUS_SIGN, BAT_ConstantsUtility.BLANK);
                }
                //19-08-2019/MX:Sprint-1: Added by Osheen Sahajpal to map Custom Birthdate field with Person BirthDate
                if(currentRecord.PersonBirthDate <> null){
                    currentRecord.Birth_Date__c = currentRecord.PersonBirthDate;
                }
                
                //30-08-2019/MX:Sprint-2: Added by Osheen Sahajpal to reverse map Custom Birthdate field with Person BirthDate
                if(currentRecord.Birth_Date__c <> null && currentRecord.PersonBirthDate == null){
                    currentRecord.PersonBirthDate = currentRecord.Birth_Date__c;
                }
                if(currentRecord.Reward_Profile__c == null && !currentRecord.Convert__c && !rewardProfile.isEmpty()){   
                    if(rewardProfile[0].profile__c == BAT_ConstantsUtility.SOURCE_GLO_SHOP){
                        currentRecord.Reward_Profile__c = rewardProfile[0].id;
                    }
                    //Added as part of US23928
                    else if(rewardProfile[0].profile__c == BAT_ConstantsUtility.SOURCE_POS_AGENT){currentRecord.Reward_Profile__c = rewardProfile[0].id;
                                                                                                 }
                    //End of US23928
                }
                
                if(currentRecord.IsPersonAccount){
                    if(!currentRecord.Convert__c){
                        accountToAssign.add(currentRecord);
                    }
                }
                //Check Trialist flag if the record type is Trialist
                //19.08.2019/Abhishek Kashyap/US-37814, added check to not to set is trialist if brand house is Velo
                if(String.isNotBlank(trialistRecordTypeId) 
                   && currentRecord.RecordTypeId == trialistRecordTypeId 
                   && ((currentRecord.Country__c != BAT_ConstantsUtility.Country_KZ && currentRecord.Country__c != BAT_ConstantsUtility.Country_UA) 
                       ||(String.isNotBlank(currentRecord.Brand_House__c)  && !currentRecord.Brand_House__c.equals(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)))){
                           currentRecord.Is_Trialist__c = true;
                       }
                //US#296128 - Added a new field BAT_MemberGetMemberVypePromotionalCode__c for verifying the correspoding Member_get_Member_Code__c existence.
                if(currentRecord.IsPersonAccount &&
                   (currentRecord.Member_get_Member_Promotional_Code__c != null || currentRecord.BAT_MemberGetMemberVypePromotionalCode__c != null) &&
                   currentRecord.Country__c != BAT_ConstantsUtility.Country_MX_STR || (String.isNotEmpty(currentRecord.National_ID__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_KZ))){
                       memberCodeAccounts.add(currentRecord);
                   }
                //Setting currency code value
                if(countryCurrencyMap.containsKey(currentRecord.Country__c)){
                    currentRecord.CurrencyIsocode = countryCurrencyMap.get(currentRecord.Country__c);
                }
                //PL: US #169252: 16.07.2020/Chiranjeevi Srinivas - Defaulted Care Center as Account Source for Customer Service PL
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_PL)){
                    if(strProfileName.containsIgnoreCase(BAT_ConstantsUtility.PROFILE_BAT_CUSTOMER_SERVICE_PL)){
                        currentRecord.AccountSource = BAT_ConstantsUtility.SOURCE_CARECENTER;
                    }                    
                }
                //CZ: US #296149: 05.11.2020/Allada Yeshwanth - Defaulted Care Center as Account Source for Customer Service CZ
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ)){
                    if(strProfileName.containsIgnoreCase(BAT_ConstantsUtility.PROFILE_BAT_CUSTOMER_SERVICE_CZ)){
                        currentRecord.AccountSource = BAT_ConstantsUtility.SOURCE_CARECENTER;
                    }                    
                }
                //UK US: 16271 to update Shippingcity with BAT_city on Account edit page for own store portal.  
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR)){
                    currentRecord.BAT_City__c = currentRecord.ShippingCity;
                    //16268 - Populate Default Values for Own Store Portal
                    //228140 - Replaced BAT_Utilities.getProfileName() with user.Profile.Name to resolve SOQL query error
                    if(String.isNotBlank(user.Profile.Name) && user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.OWN_STORE_STR)){
                        currentRecord.AccountSource = BAT_ConstantsUtility.OWNSTOREPORTAL;
                        currentRecord.Registration_Permission__c = true;
                        if(currentRecord.PersonHasOptedOutOfEmail){
                            currentRecord.PersonHasOptedOutOfEmail = false;
                        }else{
                            currentRecord.PersonHasOptedOutOfEmail = true;
                        }
                        if(currentRecord.IsMobile_Opt_Out__c){
                            currentRecord.IsMobile_Opt_Out__c = false;
                        }else{
                            currentRecord.IsMobile_Opt_Out__c = true;
                        }
                    }
                    //Added as part of US#712489
                    if(currentRecord.BAT_IsBlacklisted__c){
                        if(!currentRecord.PersonHasOptedOutOfEmail){
                            currentRecord.PersonHasOptedOutOfEmail = true;
                        }
                        if(!currentRecord.IsMobile_Opt_Out__c){
                            currentRecord.IsMobile_Opt_Out__c = true;
                        }
                    }//END US#712489
                    
                    //US #897350 : UK: Added 3 years 1 day for anonymization date 
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        currentRecord.Month_24_Anonymize_Date__c = currentRecord.createdDate != null ? currentRecord.createdDate.date().addYears(3).adddays(1) : System.Today().addYears(3).adddays(1);
                    }
                }
                //US #829216 - Added for ZA country for salesforce data retention - Account
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ZA)){
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        currentRecord.Month_24_Anonymize_Date__c = currentRecord.createdDate != null ? currentRecord.createdDate.date().addYears(3).adddays(1) : System.Today().addYears(3).adddays(1);
                    } 
                }
                
                //US #778528  - Added for FR country for salesforce data retention - Account
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR)){
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        currentRecord.Month_24_Anonymize_Date__c = currentRecord.createdDate != null ? currentRecord.createdDate.date().addYears(3).adddays(1) : System.Today().addYears(3).adddays(1);
                    } 
                }
                
                //US #1136793 : SI - Account - Data Retention Policy
                //Lalit / US:#1503391|| HR|SI - DATA RETENTION POLICY -Account
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SI) || currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR)){
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)
                       && !currentRecord.Trial_Information_Permission__c && !currentRecord.External_Information_Systems_Permission__c && !currentRecord.Generic_Permission__c && !currentRecord.Submit_Surveys_Permission__c){
                           currentRecord.Month_24_Anonymize_Date__c = System.Today();
                       }
                }
                //US#868497: Added SK to update Month_24_Anonymize_Date__c based on Last Modified Date
                if(BAT_ConstantsUtility.COUNTRY_CZ_SK.contains(currentRecord.Country__c)){
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c) && String.isBlank(currentRecord.BAT_ExternalCustomerID5__c)){
                        currentRecord.Month_24_Anonymize_Date__c = currentRecord.LastModifiedDate != null ? currentRecord.LastModifiedDate.date().addYears(3).adddays(1) : System.Today().addYears(3).adddays(1);
                    }                
                }
                //US#866028 - Added for AZ country for salesforce data retention - Account
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AZ)){
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        currentRecord.Month_24_Anonymize_Date__c = currentRecord.createdDate != null ? currentRecord.createdDate.date().addYears(10).adddays(1) : System.Today().addYears(10).adddays(1);
                    } 
                }
                
                /*** Added by Osheen Sahajpal - US-22549, 22705, 22707 - Personal Authorization check ***/
                //fetch 'Personal Authorization' field API name and values from Metadata and update current records
                if(mapCountryToPersonalAuthValue.containsKey(currentRecord.Country__c)){
                    personalAuthorizationFieldAPI = mapCountryToPersonalAuthValue.get(currentRecord.Country__c).BAT_FieldAPIName__c;
                    personalAuthorizationFieldValue = mapCountryToPersonalAuthValue.get(currentRecord.Country__c).BAT_PersonalAuthorization__c;
                    currentRecord.put(personalAuthorizationFieldAPI,personalAuthorizationFieldValue);
                }
                /*Update Last_Modified_Source__c as '1:1 Portal'whenever NEA portal user create account record 
*Added for NEA US #27175 by Mohit Maghanani*/
                //Bug-228140: Take BAT_Utilities.isNEAPortalProfile() out of for loop and use isNEAPortalUser boolean attribute
                if(isNEAPortalUser){
                    currentRecord.Last_Modified_Source__c = BAT_ConstantsUtility.BAT_NEA_LASTMODIFIEDSOURCE_1to1Portal; 
                }
                /*MX/Sprint-3/Osheen Sahajpal/US-47032: Updating Generic Permission field for MX based on 
                 BAT_IsVypeOptInEmailCommunication__c and BAT_IsVypeOptInMobileTextWhatsApp__c*/
                if(String.isNotBlank(currentRecord.Country__c) &&  currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MX_STR)){
                    currentRecord.Generic_Permission__c = BAT_Utilities.isGenericPermissionRequired(currentRecord);
                }
                //US#47996 - logic to Populate consent date.
                //RO: US#461730 - Removed the logic from here and added it in separate method "" to call it on both before insert & before update events
                ////US#47997 - Populating Month_24_Anonymize_Date__c field based on which automatic anonymization takes place.
                //RO: US# 461730 - Removed the logic from here and added it in separate method "" to call it on both before insert & before update events
                
            }
            updateAccountConsentDateAndAnonymizeDate(newAccount, null); //Added as part of RO:US#461730
            if (!memberCodeAccounts.isEmpty()) {
                checkIfMemberGetMemberExists(memberCodeAccounts);
            }
            assignAccountSource(accountToAssign);
            //Commented LeadConvert flag and added in afterinsert as part of US44355
            //BAT_ConstantsUtility.LTH_LEADCONVERT = false;
            BAT_Utilities.checkDeviceForTrial(null, newAccount);
            system.debug('TestinguserProfileName'+user.Profile.Name);
            system.debug('TestinguserCountry'+user.Country__c);
            system.debug('TestingnewAccount'+newAccount);
            //IT Vype
            //added as a part of US#1205658 to bypass account brand house validation via metadata for RO portal users
            // Added as part of US#1714478 to bypass account brand house validation via Integration user RO for passing brand house default as Other
            if((!user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.FLAGSHIPRO) &&
                !user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.GLOSTORERO))){
                    validateAccountBrandHouse(newAccount, null);  
                }
            //IT-Vype: Sprint3: US#20399
            checkExistingLeadToUpdateAccount(newAccount, null);
            //Method to validate brand-email duplicates to update Brand Status fields - Glo,Vype on Account
            //25.05.2021/ Allada Yeshwanth/ US: #525000/ Running it before removeNonConvertedDuplicateLead
            //UpdateAccountBrandStatusFields(newAccount);
            //IT-Vype: Sprint1: US#16646: Calling method to update Vype privacy consent flags
            accountPrivacyConsentFlagUpdate(newAccount);
            //update status 
            copyTHPStatusToStatus();
            //Bug#284828: ID - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber 
            formatAccountMobile(newAccount);
            //14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
            BAT_Utilities.updateConsumersContactableStatus(newAccount ,null);
            //25Feb/Abhishek Kashyap/US#405626-RO - Technical Setup - Gmail verification check for offline acounts
            purgePersonEmailAccount(newAccount, null, BAT_ConstantsUtility.BLANK, BAT_ConstantsUtility.BLANK);
            
            //23.03.2023 /Idrees Ali/Created the method - [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
            generateREWCode(rewCodeWrapObj,newAccount);
            
        }catch(Exception ex){for(Account accRec: newAccount){
            system.debug('++ex.getMessage() '+ex.getMessage());
            system.debug('++ex '+ex);
            system.debug('bjs_ex '+ex.getStackTraceString());
            system.debug('bjs_ex '+ex.getLineNumber());
            accRec.addError(ex.getMessage());
        }
                            }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : OnAfterInsert
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to handle After Insert logic of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
08.02.2019/Tejaswi Nissankula/Code Optimization
28.08.2019/Abhishek Kashyap/BUG - 43449, added logic to skip trial creation for velo accounts
23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
03.02.2021/Rama Akella/ Calling the method generateTaskForHyperCareBasic to create tasks on after Insert 
26.09.2022/Vamsi Ramineni/US #1105804/Global - Privacy Snapshot creation for Account
*********************************************************************************************************/
    
    public void OnAfterInsert(Account[] newAccount) {
        try {
            // create hypercare tasks on after insert
            generateTaskForHyperCareBasic(newAccount,null);
            // US:6079 - Invoke marketing cloud onboarding journey
            BAT_Utilities.invokeHypercareJourney(trigger.New, BAT_ConstantsUtility.ACCOUNT,
                                                 BAT_ConstantsUtility.PERSONCONTACTID, BAT_ConstantsUtility.ACCPERSONEMAIL, BAT_ConstantsUtility.FIRSTNAME,BAT_ConstantsUtility.EVENT_CREATE);
            //Verifico che se il Person Account ÃƒÆ’Ã‚Â¨ di tipo Trialist allora viene creata un Opportunity per il Trial
            String profileName = user.Profile.Name;
            List<Opportunity> opportunityToAdd = new List<Opportunity>();
            Set<Id> accountIds = new Set<Id> ();
            List<Account> defaultSurveyDirectConsumerAccounts = new List<Account>();
 
           
            //23.03.2023 /Idrees Ali- [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
            List<BAT_Reward_Profile__c> consumerRewardProfilesToBeInserted = new List<BAT_Reward_Profile__c>();
            Map<String,Id> userNameMap = new Map<String,Id>();
            if(!rewCodeWrapObj.rewProfileOwnerConfigMap.values().isEmpty()){
                for(user userRec: [select Id, username from user where isActive = true AND Username IN: rewCodeWrapObj.rewProfileOwnerConfigMap.values()]){
                    userNameMap.put(userRec.username, userRec.Id);
                }
            }
            for (Account currentRecord: newAccount){
                //Added for AZ :US#44415
                //This condition will filter Account for default survey creation when an Account is created directly instead of converting via lead
                if((currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER && currentRecord.recordtypeId.equals(consumerRecordTypeId))
                   || (currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_PROSPECT && currentRecord.recordtypeId.equals(trialistRecordTypeId))){
                       defaultSurveyDirectConsumerAccounts.add(currentRecord);
                   }
                
                
                
                //28.08.2019/Abhishek Kashyap/BUG - 43449, added logic to skip trial creation for velo accounts
                //22.02.2022/Idrees Ali/ US#894854 - PT Glo - added logic to bypass automatic trial creation for REACH Trial scenario for PT
                if(String.isNotBlank(trialistRecordTypeId) 
                   && currentRecord.RecordTypeId == trialistRecordTypeId 
                   && !profileName.containsIgnoreCase(BAT_ConstantsUtility.SS_PASSIONATE) 
                   && currentRecord.Country__c != BAT_ConstantsUtility.Country_PT
                   && ((currentRecord.Country__c != BAT_ConstantsUtility.Country_KZ && currentRecord.Country__c != BAT_ConstantsUtility.Country_UA )
                       || (String.isNotBlank(currentRecord.Brand_House__c) && !currentRecord.Brand_House__c.equals(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)))){
                           Opportunity trialOpty = new Opportunity();
                           trialOpty.Name = BAT_ConstantsUtility.ASSET_TYPE_TRIAL + ' - ' + currentRecord.FirstName + ' ' + currentRecord.LastName;
                           trialOpty.CloseDate = Date.Today().addDays(30);
                           if(String.isNotBlank(currentRecord.Passionate_Owner__c)){
                               trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_INTRIAL;
                               trialOpty.Start_Date__c = System.today();
                               trialOpty.CloseDate = System.today() + 15;
                               trialOpty.Trial_Ended_Date__c = System.today() + 15;
                               /*@AuthorLuca Proietti Nicolai 26/10/2018
                               *Assign Correct Country for Agent App Opportunity*/
                               trialOpty.Country__c = currentRecord.Country__c;
                           }else{
                               if(currentRecord.Country__c == BAT_ConstantsUtility.COUNTRY_DE_STR){
                                   trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_INTRIAL;
                               }else{
                                   trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_OPEN;
                               }
                           }
                           trialOpty.AccountId = currentRecord.Id;
                           opportunityToAdd.add(trialOpty);
                       }
                //US:530277||Pratishtha Pathak || Generate Privacy snapshot for countries and specific GR retailerRcordtype accounts
                if(String.isNotBlank(currentRecord.Country__c) && 
                   (!currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR) || (currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR) && currentRecord.RecordTypeId == retailerRecordTypeId))){
                       accountIds.add(currentRecord.Id);  
                   }
                //23.03.2023 /Idrees Ali- [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
                if(!rewCodeWrapObj.rewProfileOwnerConfigMap.isEmpty() && rewCodeWrapObj.rewProfileOwnerConfigMap.containsKey(currentRecord.Country__c)){
                    BAT_Reward_Profile__c rewardProRec = BAT_Utilities.createRewardProfileRecordForUCCAB(currentRecord,rewCodeWrapObj.defaultRewProfilePointsConfigMap,userNameMap,rewCodeWrapObj.rewProfileOwnerConfigMap);
                    consumerRewardProfilesToBeInserted.add(rewardProRec);
                }
                
            }
            //Added for AZ :US#43961: AZ - Admin - Survey Invitation Links on Salesforce
            if(!BAT_AccountTriggerHandler.bypassGenerateInvitationLinkOnAccountCreation){
                if(!defaultSurveyDirectConsumerAccounts.isEmpty()){
                    BAT_Utilities.generateInvitationLinkOnAccountCreation(defaultSurveyDirectConsumerAccounts);
                }
            }
            //This flag ensures that auto lead conversion methods execute only if the account is created via integration
            if(!BAT_ConstantsUtility.LTH_LEADCONVERT){
                removeNonConvertedDuplicateLead(newAccount,null);
                updateLeadOnInsertOrUpdateOfIntegratedAcc(newAccount,Trigger.isInsert,Trigger.isUpdate);//Added as part of US44355
            }
            
            //Added Null check before DML operation as part of ForceReviewer changes.
            if(!opportunityToAdd.isEmpty()){
                BAT_Utilities.setBypassOpportunityAssetMandateValidationFlag(true);
                insert opportunityToAdd;
                BAT_Utilities.setBypassOpportunityAssetMandateValidationFlag(false);
            }
            if(!consumerRewardProfilesToBeInserted.isEmpty()){
                insert consumerRewardProfilesToBeInserted;
            }
            if(!System.isBatch()){
                // Defect 10693 : Added recursion check on inserting Account. 
                isSnapShotGenerated = true;
                if((!Test.isRunningTest() && !accountIds.isEmpty()) || (Test.isRunningTest() && BAT_ConstantsUtility.Invoke_Account_generatePrivacySnapShotPDF == true)){
                    List<List<Id>> acctLists = (List<List<Id>>) BAT_ListsUtil.doPartitions(new List<Id>(accountIds),Integer.valueOf(System.Label.BAT_PrivacySnapShotsFutureRecordsNumber) , List<List<Id>>.class);
                    for(List<Id> acctIds : acctLists){
                        generatePrivacySnapShotPDF(acctIds);   
                    } 
                }
            }
            BAT_ConstantsUtility.LTH_LEADCONVERT = false;
        }catch(Exception ex){ for(Account accRec: newAccount){
            system.debug('++ex.getMessage() '+ex.getMessage());
            system.debug('++ex '+ex);
            accRec.addError(ex.getMessage());
            Integer lineNumber = ex.getLineNumber();
            System.debug('Exception Line Number: ' + lineNumber);
        }
                            }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : OnBeforeUpdate
* @returns       : void
* @params        : List<Account>,Map<Id,Account>
* @description   : [All Markets]Method to handle Before Update logic of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
24.04.2019/Abhishek Kashyap/ BUG - 20177, DE, Added logic to check for blacklisted details and likewise prevent account creation.
25.04.2019/Abhishek Kashyap/ US - 20271, DE, Updated the code to update timestamp on BAT_VypePersonalDataHandlingLastUpdAt__c, 
BAT_GloPersonalDataHandlingLastUpdAt__c when BAT_IsVypePersonalDataHandling__c, Registration_Permission__c gets updated respectively.
15.07.2019/Divya Eduvulapati/ US-21140, AT, Added logic to check for blacklisted details and likewise prevent account creation of DE and AT markets.
16.08.2019/Ushabala Kanduru/DE :BUG#41278 : Updated the code to update timestamp on 'BAT_IsVypeOptInEmailCommunication__c' when 
-Last Vype Opt In Email and Last Vype Opt out Email communication fields are updated.
19.08.2019/Abhishek Kashyap/US-37814, added check to not to set is trialist if brand house is Velo
12.09.2019/Tejaswi Nissankula/Removed AccountSourceConfiguration Custom metadata query and moved to constructor.
18.10.2019/Ushabala Kanduru/BUG-55227, Added revertIncorrectAccountStatusFieldChanges method to prevent incorrect brand status field update for UCCAB
12th Nov,2019/Abhishek Kashyap/US - 55227, Calling the method only for non-uccab accounts as for uccab status changes has been taken care as part of revertIncorrectAccountStatusFieldChanges() method
02.12.2019/Rajesh Potla/US#47996 - Adding logic to populate Consent date based on the field name configured in the metadata "BAT_ConsentDatePopulationConfiguration__mdt"
30.06.2020/Tejaswi Nissankula/ID : US#144638 : Added logic to stamp today's date on Last Consent Date when Velo Consents fields are 
updated on existing account
24.07.2020/Roopa N/[ID] : US#227057: Added UpdateAccountRecordtypeOralStatusFieldChanges method to Update Account Recordtype when Oral Status is Changed
19.06.2020 / Dipika Gupta/ PL US#135371: Update Last Consent Date when consent fields are ticked
10/08/2020/ Akshata Rajmane /FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes
23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields 
22.09.2020 - Anna Gomez(Deloitte) Bug#284828: ID - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber 
19.06.2020 / Dipika Gupta/ PL US#135371: Update Last Consent Date when consent fields are ticked
22.09.2020 - Anna Gomez(Deloitte) Bug#284828: ID - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber
18.10.2020/ Souvik Dinda/ Bug#304246 - Bypassed MX from Member Get Member Promotional Code check as the MGM Codes are populated via Integration.
26.11.2020/Souvik Dinda/US#305464 Added logic for stamping BAT_MGMCodeGenerationDate__c based on BAT_IsMGMOptIn__c checkbox only when its true.
14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
25Feb/Abhishek Kashyap/US#405626-RO - Technical Setup - Gmail verification check for offline acounts
14th April,2021/Abhishek Kashyap/ BUG-486567-466400 - Birthdate updated via Reverse Integration is not syncing back to CIAM
14/04/2021 : Akshata Rajmane : Commented consent date stamping code and moved it to custom metadata : BAT_ConsentStructure__mdt
15.04.2021/Anna Gomez/Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
25.05.2021/ Allada Yeshwanth/ US: #525000/  Moved  UpdateAccountBrandStatusFields before removeNonCOnvertedDuplicateLeads
18th Oct,2021/Roopa N/US #748337/ ENH: Sprint 90: UK - Age verification flag consistency (phase 2): multibrand scenario 
// 01.02.2022/ Idrees Ali/ BUG : #870405: -- Updated the If block in to check brand specific status change to 'consumer' for MGM counter 
//31Aug/samekala@deloitte.com/US#1028107 :Global: All Markets: To include Synchronisation field on Account to synchronise data correctly on Marketing Cloud
//26.09.2022/Pratishtha Pathak/ US - 1134404 - SI - Age verified is true when country is SI and Age is greater than 18
19.10.2022/Swaraj Ray/US #1120605 - Called the BAT_Utilities.checkRfmSegmentValues() to enforce RFM segment validation
10.Nov 2022:Praveen : US#1136793: SI - Account - Data Retention Policy
18.05.2022/Rama Akella/US#868497: SK - Update Month_24_Anonymize_Date__c based on Last Modified Date
17.04.2023/Saurabh Sharma/ Bug #1356909 added generate rew code on before update for UA
//15.05.2023/Chirag Kalra/ US #1345992 introduce new consent field 'Velo feedback calls'.  Updating last feedback opt in and optout date fields
19.12.2023/BJSURAJ/US: #1582604 - IT GLO - Asset&Account Source should not be updated
*********************************************************************************************************/
    
    public void OnBeforeUpdate(Account[] updatedAccount, Map<ID,Account> oldAccountMap, Map<ID,Account> newAccountMap) {
        try {
            List<Account> memberCodeAccounts = new List<Account>();
            //12th Nov,2019/Abhishek Kashyap/US - 55227, Created a new list to hold only non UCCAB accounts
            List<Account> nonUccabAccountList = new List<Account>();
            //Divya Eduvulapati/blackListMarketsSet contains markets for which the Blacklist feature is enabled
            Set<String> blackListMarketsSet = new Set<String>();
            //Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
            List<Account> mgmAccountList = new List<Account>();
            //BAT_AccountMerge__c mergeSetting = new BAT_AccountMerge__c();
            
            //Bug#1356909, list initialized to store updated status of account
            List<Account> updatedStatusAccountList = new List<Account>();
            // CZ: US#1454597: CZ - multicategory loyalty program - CRM & M2
            Map<String, BAT_AccountMerge__c> mergeSettings = BAT_AccountMerge__c.getAll();
            mergeSetting = mergeSettings.get(BAT_ConstantsUtility.ACCOUNT_MERGE_CUSTOM_SETTING);
            
            //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update
            List<String>roEmailPhone = new List<String>();
            //1777324--HR - store code analysis--start
            Set<String> storeCodeSet = new Set<String>();
            Map<string,Store__c> storeMap = new Map<string,Store__c>();
            //1777324--HR - store code analysis-end
            //18.10.2019/Ushabala Kanduru/BUG-55227, Method to prevent incorrect brand status field update for UCCAB
            revertIncorrectAccountStatusFieldChanges(updatedAccount, oldAccountMap);
            //24.07.2020/Roopa N/[ID] : US#227057: Method to Update Account Recordtype when Oral Status is Changed
            UpdateAccountRecordtypeOralStatusFieldChanges();
            
            //19th Oct, 2022/Swaraj Ray/Work item: 1120605: Allow only one RFM Segment Per brand - Updated to call the generic method
            BAT_Utilities.checkRfmSegmentValues(updatedAccount,new Account());
            //12th Nov,2019/Abhishek Kashyap/US - 55227, Adding non UCCAB accounts to the list
            for(Account eachAccount : updatedAccount){
                
                //CH: Splitbrand brand issue fix - Need a reference field for delete
                if(eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)){
                    eachAccount.Legacy_Brand_DE__c = eachAccount.Brand_House__c;   
                }
       
                
                 // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update starts\
              if(String.isNotBlank(user.Country__c) && 
                user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_DE_STR) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && oldAccountMap.get(eachAccount.Id).Brand_House__c!=eachAccount.Brand_House__c &&  oldAccountMap.get(eachAccount.Id).BAT_LoyaltyOptin__c!= eachAccount.BAT_LoyaltyOptin__c){
                    eachAccount.BAT_LoyaltyOptin__c = oldAccountMap.get(eachAccount.Id).BAT_LoyaltyOptin__c;
                    // start Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\
                    BAT_ConstantsUtility.isBrandProfileUpdate=true;
                    // end  Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\

                }
                
                  // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update ends\
                /* 28th March, 2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization */
                Integer yearOfBirth;
                
                if (System.isBatch() && eachAccount.Birth_Date__c != null && String.isNotBlank(eachAccount.Country__c) && 
                    (eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) || 
                     eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SK))) {
                         // Assigning eachAccount's Birth_Date__c to PersonBirthdate
                         yearOfBirth = eachAccount.Birth_Date__c.year();
                         eachAccount.Birth_Date__c = Date.newInstance(yearOfBirth, 1, 1);
                         eachAccount.PersonBirthdate = eachAccount.Birth_Date__c;
                     }
                /* 28th March, 2024 / Reema Meher / US #1672536 : CZ/SK - Full Account/Lead anonymization */
                
                
                //end cz/sk
                
                // CZ Loyality starts//
                // CZ: making isMergeAccount to true for US#1454597: CZ - multicategory loyalty program - CRM & M2
                RecordType directConsumerRecordType = BAT_Utilities.getDirectConsumerRecordType();
                if(String.isNotBlank(eachAccount.Country__c) &&
                   eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) && 
                   mergeCZ){
                       if (String.isNotBlank(eachAccount.Country__c) &&
                           eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) && directConsumerRecordType.Id==eachAccount.RecordTypeId
                           && isPhoneNumberAlreadyPresent(eachAccount.PersonMobilePhone, eachAccount.Id) && !oldAccountMap.get(eachAccount.Id).PersonMobilePhone.equals(eachAccount.PersonMobilePhone) && isEmailAlreadyPresent(eachAccount.PersonEmail, eachAccount.Id) 
                           || (mergeSetting != null && mergeSetting.BAT_Ismerge__c)) 
                       {
                           isMergeAccount = true;
                           mergeCZ=false;
                            // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update\
                            BAT_ConstantsUtility.isCZloyalty=true;
                            // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update ends\
                           
                           if (mergeSetting != null  ) {
                               mergeSetting.BAT_Accountid__c = eachAccount.Id;
                               mergeSetting.BAT_Ismerge__c=false;
                               update mergeSetting;
                               
                           }
                           
                       }
                       
                       else if(String.isNotBlank(eachAccount.Country__c) && eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ)  && directConsumerRecordType.Id==eachAccount.RecordTypeId
                               && isPhoneNumberAlreadyPresent(eachAccount.PersonMobilePhone, eachAccount.Id) && !oldAccountMap.get(eachAccount.Id).PersonMobilePhone.equals(eachAccount.PersonMobilePhone) && !isEmailAlreadyPresent(eachAccount.PersonEmail, eachAccount.Id))
                       {
                           isMergeAccount = false;
                           eachAccount.AccountNumber = '0';
                           eachAccount.SicDesc='';
                           mergeCZ=false;
                            // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update\
                            BAT_ConstantsUtility.isCZloyalty=true;
                            // 1687020 -DE - multicategory Loyalty program - Consent and personal information Update ends\
                           eachAccount.addError(System.Label.BAT_CZAccountDuplicateEmailErrorMessage);   
                       }
                       
                       // CZ Loyality start//
                       // CZ: making BAT_Ismerge__c to true for US#1454597: CZ - multicategory loyalty program - CRM & M2
                       if ((String.isNotBlank(eachAccount.Country__c) 
                            && eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) && directConsumerRecordType.Id==eachAccount.RecordTypeId)
                           && (!isPhoneNumberAlreadyPresent(eachAccount.PersonMobilePhone,eachAccount.Id)) 
                           && (!oldAccountMap.get(eachAccount.Id).PersonMobilePhone.equals(eachAccount.PersonMobilePhone))) {    
                               eachAccount.AccountNumber = '0';
                               eachAccount.SicDesc=''; 
                               isMergeAccount = false;
                               mergeCZ=false;
                           }    
                       
                   }
                
                // CZ Loyality ends//
                //1498757 RO - reconsent from site starts by Shanmuga-------//
                if (String.isNotBlank(eachAccount.Country__c) && eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RO)) {
                    updateLastConsentDate(eachAccount, oldAccountMap);
                }
                //1498757 RO - reconsent from site ends by shanmuga-------//
                //1655412-CA-Zonnic Marketing consent timestamp starts--//
                if (user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && user.Country__c != null && user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_CA) && oldAccountMap.get(eachAccount.Id).BAT_IsVeloOptInEmailCommunication__c!=eachAccount.BAT_IsVeloOptInEmailCommunication__c)
                {
                    eachAccount.BAT_VeloEmailOptinLastUpdatedDate__c=System.now();
                }
                //1655412-CA-Zonnic Marketing consent timestamp ends--//
                //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update--start
                if (String.isNotBlank(eachAccount.Country__c) && eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RO)) {
                    if(eachAccount.BAT_ExternalCustomerID5__c!=null&&BAT_ConstantsUtility.CIAM_Sources.contains(eachAccount.AccountSource)&&!BAT_ConstantsUtility.Not_CIAM_Sources.contains(eachAccount.AccountSource)){//Us-1506330
                        if(eachAccount.PersonEmail!=null){
                            roEmailPhone.add(eachAccount.PersonEmail);
                        }
                        if(eachAccount.PersonMobilePhone!=null){
                            roEmailPhone.add(eachAccount.PersonMobilePhone);
                        }
                    }//1506330--End
                }
                if(String.isNotBlank(eachAccount.Country__c) 
                   && eachAccount.Country__c != BAT_ConstantsUtility.COUNTRY_UA 
                   && eachAccount.Country__c != BAT_ConstantsUtility.COUNTRY_KZ){
                       nonUccabAccountList.add(eachAccount);
                   }
                if(String.isNotBlank(eachAccount.Country__c) 
                   && eachAccount.Country__c != BAT_ConstantsUtility.COUNTRY_UA 
                   && eachAccount.Country__c != BAT_ConstantsUtility.COUNTRY_KZ){
                       nonUccabAccountList.add(eachAccount);
                   }
                //10th April,2020/Prince Chawla/BUG-#113033- KZ Issue with order submission.
                /*Populate PersonMobilePhone__c as workflow to populate Custom PersonMobilePhone__c
-was already deactivated for #109844 and the duplicate rule was enabled for detecting duplicate mobile on Accounts.
-But KZ is using PersonMobilePhone__c for their calculation in code, so as a temporary fix
-in production adding this below line. Later, will open a backlog to replace
-the reference of Custom mobile phone to standard mobile phone.*/
                //Added CH country check to stamp PersonMobilePhone value to PersonMobilePhone__c so that PersonMobilePhone__c can be used under quick action layouts .
                if(String.isNotBlank(eachAccount.Country__c) && (eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA) 
                                                                 || eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) || eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)  || (eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.DE_STR) && eachAccount.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE)) 
                   && eachAccount.PersonMobilePhone != null){
                       eachAccount.PersonMobilePhone__c = eachAccount.PersonMobilePhone;
                   }
                //US#305464 Added logic for stamping BAT_MGMCodeGenerationDate__c based on BAT_IsMGMOptIn__c checkbox only when its true
                if(eachAccount.Country__c != BAT_ConstantsUtility.COUNTRY_MX_STR 
                   && oldAccountMap.get(eachAccount.Id).BAT_IsMGMOptIn__c != eachAccount.BAT_IsMGMOptIn__c
                   && eachAccount.BAT_IsMGMOptIn__c){
                       eachAccount.BAT_MGMCodeGenerationDate__c = Datetime.now();
                   }
                
                //804167 | KZ - National ID Validation Rule  | Get all the National Ids of KZ accounts
                if(!user.Bypass_Validation_Rule__c && String.IsNotBlank(eachAccount.National_ID__c) && eachAccount.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) && !mapCountryNationalId.containsKey(eachAccount.Country__c)){
                    mapCountryNationalId.put(eachAccount.Country__c,new set<String>());
                }
                if(mapCountryNationalId.containsKey(eachAccount.Country__c) && String.IsNotBlank(eachAccount.National_ID__c)){
                    mapCountryNationalId.get(eachAccount.Country__c).add(eachAccount.National_ID__c);
                }
                //30Aug/Samekala@deloitte.com/US#1049237 : Global: All Markets: To include Synchronisation field on Account/Contacts to synchronise data correctly on Marketing Cloud
                BAT_Utilities.updateSynchroniseField(eachAccount , oldAccountMap.get(eachAccount.Id));
                //09.06.2022/Idrees Ali/ ENH - Sprint 113 - US#1119472:CZ & SK - VELO Acclimatization
                BAT_Utilities.concatenateBrandHouseForIntegration(eachAccount,oldAccountMap.get(eachAccount.Id), String.valueOf(user.Profile.Name),user.Username);
            }
       
            //12th Nov,2019/Abhishek Kashyap/US - 55227, Calling the method only for non-uccab accounts as for uccab status 
            //changes has been taken care as part of revertIncorrectAccountStatusFieldChanges() method
            if(!nonUccabAccountList.isEmpty()){
                checkAccountStatusUpdate(nonUccabAccountList, oldAccountMap);
            }
            //1666626--IT | Vuse privacy consents migration to multicategory privacy consents (Leads/Accounts)
            if(user.Country__c != null && user.Country__c==BAT_ConstantsUtility.Country_IT)
            {
                accountPrivacyConsentFlagUpdate(updatedAccount);
            }
            updateAccountBillingCountry(updatedAccount, oldAccountMap);
            updateAccountRecordtype(updatedAccount, oldAccountMap); // Added as part of RO:US#445129
            updateAccountConsentDateAndAnonymizeDate(updatedAccount, oldAccountMap); //Added as part of RO:US#461730
            //25.05.2021/ Allada Yeshwanth/ US: #525000/  Moved  UpdateAccountBrandStatusFields before removeNonCOnvertedDuplicateLeads
            //Method to validate brand-email duplicates to update Brand Status fields - Glo,Vype on Account
            UpdateAccountBrandStatusFields(updatedAccount);
            //Added as part of UCCAB to populate the related Lead and owner on account
            if(!BAT_ConstantsUtility.LTH_LEADCONVERT){
                removeNonConvertedDuplicateLead(updatedAccount,oldAccountMap);
                updateLeadOnInsertOrUpdateOfIntegratedAcc(updatedAccount,Trigger.isInsert,Trigger.isUpdate);
            }
            //Enhacement Sprint 17 US#10888
            validateMobileNumberFormat(updatedAccount, oldAccountMap); //call mobile format validation
            BAT_Utilities.verifyMobileNumberAndEmailChange(updatedAccount, oldAccountMap, BAT_ConstantsUtility.STANDARD_ACCOUNT_STR, user); //Added as part of US11122
            checkForPotentialDuplicateAccounts(updatedAccount, oldAccountMap);
            //Abhishek Kashyap/ countrySet keeps country code of all updated accounts.
            Set<String> countrySet = new Set<String>();
            String trialistRecordTypeId = recordTypeDevNameMap.get('Trialist');
            //Getting the set of markets for which the Blacklist feature is enabled from the Blacklist Configuration metadata
            for (BAT_EnableBlacklistConfiguration__mdt countries:BAT_EnableBlacklistConfiguration__mdt.getAll().values())
            {
                blackListMarketsSet.add(countries.Label);
            }
            
            //24.04.2019/Abhishek Kashyap/ BUG - 20177, DE, Added logic to check for blacklisted details and likewise prevent account update.
            List<Account> accountsToCheckForBlackList = new List<Account>();
            //Finds DE and AT accounts and adds them to the accountsToCheckForBlackList list.
            for(Account newAccountObj: updatedAccount){   
                if(blackListMarketsSet.contains(newAccountObj.Country__c))
                {
                    accountsToCheckForBlackList.add(newAccountObj);
                }
                //Abhishek Kashyap/DE :Sprint16 : 13295 Adds Account country code to the set 
            //1777324--HR - store code analysis--start
                countrySet.add(newAccountObj.Country__c);
               
                if(String.isNotBlank(newAccountObj.Country__c) && newAccountObj.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR) 
                   && String.isNotBlank(newAccountObj.Store_ID__c) && newAccountObj.Store_ID__c!= oldAccountMap.get(newAccountObj.id).Store_ID__c){
                       storeCodeSet.add(newAccountObj.Store_ID__c);
                   }
               
            }
          
            if(!storeCodeSet.isEmpty()){
                storeMap = BAT_Utilities.storeDetails(storeCodeSet,countrySet);
            }

            for(Account accRec : updatedAccount){
                
                //Nov 6th, 2020/Abhishek Kashyap/ZA:318652 - Populate Store lookup on Account for given Store Id.
                if(String.isNotBlank(accRec.Country__c) &&  accRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR)
                   && !storeMap.isEmpty() && storeMap.containsKey(accRec.Store_ID__c)){
                       accRec.Store__c = storeMap.get(accRec.Store_ID__c).Id;
                   }
            }    //1777324 --HR - store code analysis-------ended
              
            //08.04.2021 || Allada Yeshwanth || BUG: #402351
            BAT_Utilities.updateEmailAndPhone(updatedAccount,null,countrySet);
            //Abhishek Kashyap/DE :Sprint16 : 13295 Checks if the countrySet and updatedAccount is not empty
            if(!countrySet.isEmpty() && !updatedAccount.isEmpty()){
                //IT Vype: 19586
                //Satya Nalluri/ 28-02-2020 / Bug : 59859 - Passing Account country set as param to reduce number of Iterations
                updateConsumerSinceDate(updatedAccount, countrySet, oldAccountMap);
                //Abhishek Kashyap/DE :Sprint16 : 13295 stampDateTimeOnConsentChange updates concent structure datetime fields when corresponding consent checkbox is changed
                /* FR : US#281098 : Update last Consent Date Field :extended this logic to include the france changes*/
                /* 23/10/2020/ Akshata Rajmane /FR : US#302771 : FR - Admin Portal - Logic of Additional Date Timestamp Consent Fields */
                BAT_Utilities.stampDateTimeOnConsentChange(BAT_ConstantsUtility.STANDARD_ACCOUNT_STR, countrySet, updatedAccount, oldAccountMap);
            }
            //Calls the method to check blacklisted name, email or domain and prevents updation of account for DE.
            if(!accountsToCheckForBlackList.isEmpty()){
                checkForBlacklistAccounts(accountsToCheckForBlackList);
            }
            for(Account currentRecord: updatedAccount){             
                //VSTS: change 23701
                if(currentRecord.PersonMobilePhone != oldAccountMap.get(currentrecord.Id).PersonMobilePhone){
                    
                    if(!String.isBlank(currentRecord.PersonMobilePhone)){
                        currentRecord.BAT_FormattedMobile__c = currentRecord.PersonMobilePhone.replace(BAT_ConstantsUtility.PLUS_SIGN, BAT_ConstantsUtility.BLANK);
                    }else{
                        currentRecord.BAT_FormattedMobile__c = currentRecord.PersonMobilePhone;
                    }
                }
                //19-08-2019/MX:Sprint-1: Added by Osheen Sahajpal to map Custom Birthdate field with Person BirthDate
                if(currentRecord.PersonBirthDate <> null && currentRecord.PersonBirthDate != oldAccountMap.get(currentrecord.Id).PersonBirthDate){
                    currentRecord.Birth_Date__c = currentRecord.PersonBirthDate;
                }
                
                //30-08-2019/MX:Sprint-2: Added by Osheen Sahajpal to reverse map Custom Birthdate field with Person BirthDate
                //14th April,2021/Abhishek Kashyap/ BUG-486567-Updating PersonBirthDate whenever Birth_Date__c changes.
                //Bug#1294165: UA - Adding UA Country to populate PersonBirthDate field when Birth_Date__c is populated
                if(currentRecord.Birth_Date__c <> null && currentRecord.Birth_Date__c != oldAccountMap.get(currentrecord.Id).Birth_Date__c && (currentRecord.PersonBirthDate == null || currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RO) || currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA))){
                    currentRecord.PersonBirthDate = currentRecord.Birth_Date__c;
                }
                //Added by Varun for US 6481 for Germany market
                if(oldAccountMap.get(currentRecord.Id).Country__c== BAT_ConstantsUtility.COUNTRY_DE_STR
                   && (oldAccountMap.get(currentRecord.Id).BillingStreet!= newAccountMap.get(currentRecord.Id).BillingStreet
                       || oldAccountMap.get(currentRecord.Id).BillingCity!= newAccountMap.get(currentRecord.Id).BillingCity
                       || oldAccountMap.get(currentRecord.Id).BillingState!= newAccountMap.get(currentRecord.Id).BillingState
                       || oldAccountMap.get(currentRecord.Id).BillingCountry!= newAccountMap.get(currentRecord.Id).BillingCountry
                       || oldAccountMap.get(currentRecord.Id).BillingPostalCode!= newAccountMap.get(currentRecord.Id).BillingPostalCode) )
                {
                    currentRecord.BAT_IsGeocodeUpdateRequired__c = true;
                    if(oldAccountMap.get(currentRecord.Id).Address_Verification_Status_DE__c == BAT_ConstantsUtility.VALID){
                        currentRecord.Address_Verification_Status_DE__c = BAT_ConstantsUtility.NOT_CHECKED; 
                    }
                }
                
                //19.08.2019/Abhishek Kashyap/US-37814, added check to not to set is trialist if brand house is Velo
                if (String.isNotBlank(trialistRecordTypeId) 
                    && currentRecord.RecordTypeId == trialistRecordTypeId 
                    && oldAccountMap.get(currentRecord.Id).RecordTypeId != trialistRecordTypeId 
                    && ((currentRecord.Country__c != BAT_ConstantsUtility.Country_KZ && currentRecord.Country__c != BAT_ConstantsUtility.Country_UA) 
                        || (String.isNotBlank(currentRecord.Brand_House__c) && !currentRecord.Brand_House__c.equals(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)))) {
                            currentRecord.Is_Trialist__c = true;
                        }
                /*Update Last_Modified_Source__c when Account Source is changed, then old value of 
*AccountSource will be there the Last Modified Source, Account Source will get the new Value.
*Added for UK US #12067 by Prince Chawla*/
                //Added change for updating Last_Modified_Source__c by Idrees Ali Jabalpurwala
                //Optimized as part of US#712489 - updated below if condition to add more logic for UK
                if(String.isNotBlank(currentRecord.country__c) && 
                   currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR)){
                       if(String.isNotBlank(currentRecord.AccountSource) &&
                          !accSourceSet.isEmpty() &&
                          accSourceSet.contains(currentRecord.AccountSource) && 
                          !currentRecord.AccountSource.equalsIgnoreCase(oldAccountMap.get(currentRecord.Id).AccountSource)){
                              currentRecord.Last_Modified_Source__c = oldAccountMap.get(currentRecord.Id).AccountSource;
                          } 
                       //Added as part of US#748337
                       //Added as part of Bug fix #781027 for US #748337 - Added Username "SAP CPI Integration User UK" check to below if condition 
                       if(user.Profile.Name != null && (user.Username.containsIgnoreCase(BAT_ConstantsUtility.SAP_CPI_USERNAME_UK) || user.Profile.Name != BAT_ConstantsUtility.SADMIN) && currentRecord.IsPersonAccount && 
                          oldAccountMap.get(currentRecord.Id).Age_verified__c && 
                          oldAccountMap.get(currentRecord.Id).Age_verified__c != currentRecord.Age_verified__c){
                              currentRecord.Age_verified__c = true;
                              system.debug('currentRecord'+currentRecord.Age_verified__c);
                          }
                       //END US#748337
                    
                       //Bug -1890318 - UK - "Email Verified" field should not be updated to "False" once it has been marked as "True" in CRM starts//
                       if(user.Profile.Name != null && (user.Username.containsIgnoreCase(BAT_ConstantsUtility.SAP_CPI_USERNAME_UK) || user.Profile.Name != BAT_ConstantsUtility.SADMIN) && currentRecord.IsPersonAccount && 
                     	(oldAccountMap.get(currentRecord.Id).Email_verified__c && oldAccountMap.get(currentRecord.Id).Email_verified__c != currentRecord.Email_verified__c)){
                        currentRecord.Email_verified__c = true;  
                    }
                      // Bug -1890318 ends--//
                       
                       //Added as part of US#712489
                       if(currentRecord.BAT_IsBlacklisted__c){
                           if(!currentRecord.PersonHasOptedOutOfEmail){
                               currentRecord.PersonHasOptedOutOfEmail = true;
                           }
                           if(!currentRecord.IsMobile_Opt_Out__c){
                               currentRecord.IsMobile_Opt_Out__c = true;
                           } 
                       }//END US#712489
                       //US #897350 : UK: Added 3 years 1 day for anonymization date 
                       if(!oldAccountMap.isEmpty() && (oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c || oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c || oldAccountMap.get(currentRecord.Id).External_Customer_ID3__c != currentRecord.External_Customer_ID3__c || oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c) && String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                           currentRecord.Month_24_Anonymize_Date__c = currentRecord.createdDate.date().addYears(3).adddays(1);
                       }
                       if(!oldAccountMap.isEmpty() && 
                          ((oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c && String.isNotBlank(currentRecord.External_Customer_Id__c)) ||
                           (oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c && String.isNotBlank(currentRecord.External_Customer_ID2__c)) || 
                           (oldAccountMap.get(currentRecord.Id).External_Customer_ID3__c != currentRecord.External_Customer_ID3__c && String.isNotBlank(currentRecord.External_Customer_ID3__c)) ||
                           (oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c && String.isNotBlank(currentRecord.BAT_ExternalCustomerId4__c)))){
                               currentRecord.Month_24_Anonymize_Date__c = Null;
                           }
                       
                   }
                //US#1136793: SI - Account - Data Retention Policy 
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SI)){                     
                }
                //US#1136793: SI - Account - Data Retention Policy 
                //Lalit / US:#1503391|| HR|SI - DATA RETENTION POLICY -Account
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SI) ||         currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR)){                    
                    if((String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c))
                       && (!currentRecord.Trial_Information_Permission__c && !currentRecord.External_Information_Systems_Permission__c && !currentRecord.Generic_Permission__c && !currentRecord.Submit_Surveys_Permission__c)){                        
                           currentRecord.Month_24_Anonymize_Date__c = System.Today();                      
                       }
                    if(!oldAccountMap.isEmpty() && 
                       ((oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c && String.isNotBlank(currentRecord.External_Customer_Id__c)) ||
                        (oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c && String.isNotBlank(currentRecord.External_Customer_ID2__c)) || 
                        (oldAccountMap.get(currentRecord.Id).External_Customer_ID3__c != currentRecord.External_Customer_ID3__c && String.isNotBlank(currentRecord.External_Customer_ID3__c)) ||
                        (oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c && String.isNotBlank(currentRecord.BAT_ExternalCustomerId4__c)) ||
                        (oldAccountMap.get(currentRecord.Id).Trial_Information_Permission__c != currentRecord.Trial_Information_Permission__c && currentRecord.Trial_Information_Permission__c==true) ||
                        (oldAccountMap.get(currentRecord.Id).External_Information_Systems_Permission__c != currentRecord.External_Information_Systems_Permission__c && currentRecord.Trial_Information_Permission__c==true) ||
                        (oldAccountMap.get(currentRecord.Id).Generic_Permission__c != currentRecord.Generic_Permission__c && currentRecord.Generic_Permission__c==true) ||
                        (oldAccountMap.get(currentRecord.Id).Submit_Surveys_Permission__c != currentRecord.Submit_Surveys_Permission__c && currentRecord.Submit_Surveys_Permission__c==true) 
                       )){
                           currentRecord.Month_24_Anonymize_Date__c = Null;
                       }
                }
                //US#868497: SK - Update Month_24_Anonymize_Date__c based on Last Modified Date
                //Bug #1011463 || CZ || Updating Month_24_Anonymize_Date__c based on lastmodified date
                if(BAT_ConstantsUtility.COUNTRY_CZ_SK.contains(String.ValueOf(currentRecord.Country__c))){
                    if(String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c) && String.isBlank(currentRecord.BAT_ExternalCustomerID5__c)){
                        currentRecord.Month_24_Anonymize_Date__c = System.Today().addYears(3).adddays(1); 
                    }
                }
                //26.09.2022/Pratishtha Pathak/ US - 1134404 - SI - Age verified is true when country is SI and Age is greater than 18
                //25.04.2024/Suman Avula/ US - 1702001 - AL/MK/BA - Age verified is true when country is AL and Age is greater than 18
                // if(currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SI) || currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AL) || currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_BA) || currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MK)){
                if(currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AL) || currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_BA) || currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MK)){   
                    if(currentRecord.Age__c != null && currentRecord.Age__c >= 18){
                        currentRecord.Age_verified__c = true;
                    }
                }
                
                //13.09.2024/Suman Avula/ US - 1825184 - UA - RAV / SDAV update
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA)){
                  if((String.isNotBlank(oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c  && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c == BAT_ConstantsUtility.ATH_PROSPECT && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER) || 
                     (String.isNotBlank(oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c != currentRecord.BAT_OralStatus__c  && oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c == BAT_ConstantsUtility.ATH_PROSPECT && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.ATH_CONSUMER) ||
                     (String.isNotBlank(oldAccountMap.get(currentRecord.Id).BAT_CombustibleStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_CombustibleStatus__c != currentRecord.BAT_CombustibleStatus__c  && oldAccountMap.get(currentRecord.Id).BAT_CombustibleStatus__c == BAT_ConstantsUtility.ATH_PROSPECT && currentRecord.BAT_CombustibleStatus__c == BAT_ConstantsUtility.ATH_CONSUMER))
                  {
                     currentRecord.BAT_Robust_AV__c = true; 
                  }
                  if(currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || currentRecord.BAT_CombustibleStatus__c == BAT_ConstantsUtility.ATH_CONSUMER){
                      currentRecord.BAT_Robust_AV__c = true; 
                  }
               
                } 
              
                         
                //US#866028 - Added for AZ country for salesforce data retention - Account
                if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AZ)){
                    if(!oldAccountMap.isEmpty() && (oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c || oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c || oldAccountMap.get(currentRecord.Id).External_Customer_ID3__c != currentRecord.External_Customer_ID3__c || oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c) && String.isBlank(currentRecord.External_Customer_Id__c) && String.isBlank(currentRecord.External_Customer_ID2__c) && String.isBlank(currentRecord.External_Customer_ID3__c) && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        currentRecord.Month_24_Anonymize_Date__c = currentRecord.createdDate.date().addYears(10).adddays(1);
                    }
                    if(!oldAccountMap.isEmpty() && 
                       ((oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c && String.isNotBlank(currentRecord.External_Customer_Id__c)) ||
                        (oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c && String.isNotBlank(currentRecord.External_Customer_ID2__c)) || 
                        (oldAccountMap.get(currentRecord.Id).External_Customer_ID3__c != currentRecord.External_Customer_ID3__c && String.isNotBlank(currentRecord.External_Customer_ID3__c)) ||
                        (oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c && String.isNotBlank(currentRecord.BAT_ExternalCustomerId4__c)))){
                            currentRecord.Month_24_Anonymize_Date__c = Null;
                        } 
                }
                /*Update Last_Modified_Source__c as '1:1 Portal'whenever NEA portal user update account record 
*Added for NEA US #27175 by Mohit Maghanani*/
                if(BAT_Utilities.isNEAPortalProfile(user.Profile.Name)){
                    currentRecord.Last_Modified_Source__c = BAT_ConstantsUtility.BAT_NEA_LASTMODIFIEDSOURCE_1to1Portal; 
                }
                //MX: US #54898 - Update Last_Modified_Source__c as 'Own Kiosks' when flagship users update account record
                if(user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.BAT_FLAGSHIP_MX)){currentRecord.Last_Modified_Source__c = BAT_ConstantsUtility.BAT_MX_LASTMODIFIEDSOURCE_OwnKiosks;
                                                                                            }
                //Verifico se uno dei flag della privacy Ã¨ stato aggiornato, in modo da comunicare tramite il campo Privacy_Permission_Changed__c 
                //ad Heroku che deve essere inviata una mail al cliente
                if( oldAccountMap.get(currentRecord.id).Submit_Surveys_Permission__c != currentRecord.Submit_Surveys_Permission__c 
                   || oldAccountMap.get(currentRecord.id).Generic_Permission__c != currentRecord.Generic_Permission__c 
                   || oldAccountMap.get(currentRecord.id).Trial_Information_Permission__c != currentRecord.Trial_Information_Permission__c 
                   || oldAccountMap.get(currentRecord.id).External_Information_Systems_Permission__c != currentRecord.External_Information_Systems_Permission__c){
                       currentRecord.Privacy_Permission_Changed__c = true;
                   }
                //US#296128 - Added a new field BAT_MemberGetMemberVypePromotionalCode__c for verifying the correspoding Member_get_Member_Code__c existence.
                if(currentRecord.IsPersonAccount 
                   && ((currentRecord.Member_get_Member_Promotional_Code__c != null && 
                        currentRecord.Member_get_Member_Promotional_Code__c != oldAccountMap.get(currentRecord.id).Member_get_Member_Promotional_Code__c) ||
                       (currentRecord.BAT_MemberGetMemberVypePromotionalCode__c != null && 
                        currentRecord.BAT_MemberGetMemberVypePromotionalCode__c != oldAccountMap.get(currentRecord.id).BAT_MemberGetMemberVypePromotionalCode__c)) && 
                   currentRecord.Country__c != BAT_ConstantsUtility.Country_KZ
                   && currentRecord.Country__c != BAT_ConstantsUtility.Country_MX_STR || 
                   (currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_KZ) && String.IsNotBlank(currentRecord.National_ID__c) && currentRecord.National_ID__c != oldAccountMap.get(currentRecord.id).National_ID__c)){
                       memberCodeAccounts.add(currentRecord);
                   }
                //UK US: 16271 to update Shippingcity with BAT_city on Account edit page for own store portal.  
                if(oldAccountMap.get(currentRecord.id).BAT_City__c != currentRecord.BAT_City__c){  currentRecord.ShippingCity = currentRecord.BAT_City__c;
                                                                                                }
                //US #12008 Populating Consumer Date and Lost date values into Account when an account status is changed. 
                //20.7.2020/Rama Akella/Bug#173682: Bypassing for PL
                if(oldAccountMap.get(currentRecord.Id).Status__c != currentRecord.status__c && currentRecord.status__c == BAT_ConstantsUtility.ATH_CONSUMER && currentRecord.country__c != BAT_ConstantsUtility.Country_PL){
                    currentRecord.Consumer_Date_Time__c = system.now();
                    currentRecord.Consumer_Date__c = Date.Today();
                }
                if ((oldAccountMap.get(currentRecord.Id).Status__c != currentRecord.status__c && currentRecord.status__c == BAT_ConstantsUtility.LOST) ||
                    (oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.LOST)) {
                        currentRecord.Lost_Date__c = Date.today();
                    }
                //Added as part of BUG#41278 to update timestamp on 'BAT_IsVypeOptInEmailCommunication__c' 
                //when Last Vype Opt In Email and Last Vype Opt out Email communication fields are updated.
                //1.10.2019/Ushabala Kanduru/Bug#47228: Update Last Vype Opt In Email and Last Vype Opt out Email communication fields only when those are null
                if (currentRecord.BAT_IsVypeOptInEmailCommunication__c != oldAccountMap.get(currentRecord.Id).BAT_IsVypeOptInEmailCommunication__c){
                    if(!currentRecord.BAT_IsVypeOptInEmailCommunication__c && currentRecord.BAT_VypeLastEmailCommunicationOptOutDate__c == null){
                        currentRecord.BAT_VypeLastEmailCommunicationOptOutDate__c = datetime.now();
                    }else if(currentRecord.BAT_IsVypeOptInEmailCommunication__c && currentRecord.BAT_VypeLastEmailCommunicationOptInDate__c == null){
                        currentRecord.BAT_VypeLastEmailCommunicationOptInDate__c = datetime.now();
                    }
                }
                //15.05.2023/Chirag Kalra/ US #1345992 introduce new consent field 'Velo feedback calls'.  Updating last feedback opt in and optout date fields
                if (currentRecord.BAT_VeloFeedbackCallAuthorization__c != oldAccountMap.get(currentRecord.Id).BAT_VeloFeedbackCallAuthorization__c && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR) ){
                    if(!currentRecord.BAT_VeloFeedbackCallAuthorization__c){
                        currentRecord.BAT_VeloOptOutDateLastFeedback__c = datetime.now();
                    }else if(currentRecord.BAT_VeloFeedbackCallAuthorization__c){
                        currentRecord.BAT_VeloOptInDateLastFeedback__c = datetime.now();
                    }
                }
                //26.10.2023/Lalit/US-1520627, SE/DK - AMP Last Consent Date field Update Logic 
                if((currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SE) || currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.DK_STR))
                   && (BAT_ConstantsUtility.NEA_PROFILE_SET.contains(user.Profile.Name)|| user.Profile.Name==BAT_ConstantsUtility.INTEGRATIONPROFILE)
                   && (!currentRecord.BAT_AMPEmailOptOut__c && oldAccountMap.get(currentRecord.Id).BAT_AMPEmailOptOut__c)){
                       currentRecord.BAT_AMPLastConsentDate__c = System.now(); 
                   } 
                /*MX/Sprint-3/Osheen Sahajpal/US-47032: Updating Generic Permission field for MX based on 
BAT_IsVypeOptInEmailCommunication__c and BAT_IsVypeOptInMobileTextWhatsApp__c*/
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MX_STR) && 
                   (currentRecord.BAT_IsVypeOptInEmailCommunication__c != oldAccountMap.get(currentRecord.Id).BAT_IsVypeOptInEmailCommunication__c ||
                    currentRecord.BAT_IsVypeOptInMobileTextWhatsApp__c != oldAccountMap.get(currentRecord.Id).BAT_IsVypeOptInMobileTextWhatsApp__c)){
                        
                        currentRecord.Generic_Permission__c = BAT_Utilities.isGenericPermissionRequired(currentRecord);
                    }
                
                //Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
                // 01.02.2022/ Idrees Ali/ BUG : #870405: -- Updated the If block in to check brand specific status change to consumer for MGM counter 
                /*if(((String.isNotBlank(currentRecord.Status__c) && currentRecord.Status__c != oldAccountMap.get(currentRecord.Id).Status__c)||
                    (String.isNotBlank(currentRecord.BAT_THPStatus__c) && currentRecord.BAT_THPStatus__c != oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c) ||
                    (String.isNotBlank(currentRecord.BAT_VapeStatus__c) && currentRecord.BAT_VapeStatus__c != oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c )) &&
                   ((currentRecord.Country__c != BAT_ConstantsUtility.COUNTRY_IT && currentRecord.Country__c != BAT_ConstantsUtility.COUNTRY_GR && currentRecord.Country__c != BAT_ConstantsUtility.COUNTRY_CY &&
                     (currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || 
                      currentRecord.Status__c == BAT_ConstantsUtility.ATH_CONSUMER) &&
                     (String.isNotBlank(currentRecord.Member_get_Member_Promotional_Code__c)||
                      String.isNotBlank(currentRecord.BAT_MemberGetMemberVypePromotionalCode__c))) ||
                    (currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT) &&  (currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.ATH_CONSUMER ||currentRecord.Status__c == BAT_ConstantsUtility.ATH_CONSUMER) && String.isNotBlank(currentRecord.BAT_MemberGetMemberVypePromotionalCode__c)))) {
                     */  
				 if(((String.isNotBlank(currentRecord.Status__c) && currentRecord.Status__c != oldAccountMap.get(currentRecord.Id).Status__c)||
                    (String.isNotBlank(currentRecord.BAT_THPStatus__c) && currentRecord.BAT_THPStatus__c != oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c) ||
                    (String.isNotBlank(currentRecord.BAT_VapeStatus__c) && currentRecord.BAT_VapeStatus__c != oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c )) &&
                   ((currentRecord.Country__c != BAT_ConstantsUtility.COUNTRY_IT && currentRecord.Country__c != BAT_ConstantsUtility.COUNTRY_GR && currentRecord.Country__c != BAT_ConstantsUtility.COUNTRY_CY &&
                     (currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.ATH_CONSUMER || 
                      currentRecord.Status__c == BAT_ConstantsUtility.ATH_CONSUMER) &&
                     (String.isNotBlank(currentRecord.Member_get_Member_Promotional_Code__c)||
                      String.isNotBlank(currentRecord.BAT_MemberGetMemberVypePromotionalCode__c))) ||
                    (currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT) &&  (currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.ATH_CONSUMER ||currentRecord.Status__c == BAT_ConstantsUtility.ATH_CONSUMER) && String.isNotBlank(currentRecord.BAT_MemberGetMemberVypePromotionalCode__c)) ||
                    //1883832-UA - Add to CRM account field Member get Member Promotional Code Velo starts//
					(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA) && String.isNotBlank(currentRecord.BAT_MemberGetMemberVeloPromotionalCode__c)) && String.isNotBlank(currentRecord.Status__c) && String.isNotBlank(currentRecord.BAT_OralStatus__c))) {		
 				
                
                
						mgmAccountList.add(currentRecord);
                        system.debug('TestingmgmAccountlist'+mgmAccountList);
                    }               
                
                //Add as part of UK:US#1199173/Brand House field population/update
                //13.12.2022/Rahul Upadhyay/ Stamp Brand House for UK market during Lead updation
                if(String.isNotBlank(currentRecord.Country__c) && (currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR)) && (String.isNotBlank(currentRecord.Brand_House__c))){
                    for(BAT_AccountBrandHouseAssignment__mdt metaRec: BAT_Utilities.getAccountBrandHouseAssignDetails(currentRecord.Country__c, currentRecord.AccountSource, currentRecord.Last_Modified_Source__c)){
                        if((currentRecord.Last_Modified_Source__c != oldAccountMap.get(currentRecord.Id).Last_Modified_Source__c)
                           && (!currentRecord.Brand_House__c.contains(metaRec.BAT_BrandAllowed__c))
                          ){
                              currentRecord.Brand_House__c += BAT_ConstantsUtility.SEMI_COLON+metaRec.BAT_BrandAllowed__c;
                          }
                    }
                }
                //End of UK:US#1199173
                /*31.01.2023/Idrees Ali/ Sprint 122 - US#1154669 - FR-Velo- Added below logic to handle partial/full anonymisation of account
                    when it is being deleted from ecommerce owing to ITT Integration model changes */
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.ECOMM_VUSE_STR)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).External_Customer_Id__c) && oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c 
                   && String.isBlank(currentRecord.External_Customer_Id__c) && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                       if(!String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                           if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR)){
                               if (currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() > 1){
                                   currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.VUSE_DEVICE_STR);
                               }
                               else{
                                   currentRecord.Brand_House__c = BAT_ConstantsUtility.BLANK_STR;
                               }
                           }
                       }
                       else{
                           currentRecord.BAT_Is_Anonymised__c = true;
                       }
                   }
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_FR) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) &&  String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.ECOMM_VELO_STR)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c) && oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c 
                   && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                       if(!String.isBlank(currentRecord.External_Customer_Id__c)){
                           if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)){
                               if (currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() > 1){
                                   currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO);
                               }
                               else{
                                   currentRecord.Brand_House__c = BAT_ConstantsUtility.BLANK_STR;
                               }
                           }
                       }
                       else{
                           currentRecord.BAT_Is_Anonymised__c = true;
                       }
                   }
                  //Suman Avula US#1985054: CE - Change to SF consumer data anonymization in DE
                    if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.DE_STR) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                    && ((!String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR) || (
                        !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c != currentRecord.BAT_VapeStatus__c  && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)|| (
                        !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c != currentRecord.BAT_OralStatus__c  && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)))                  
                    {
                     List<String>brandHouseValues = new List<String>();
                     
                     if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() >= 1){
                         brandHouseValues = currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                         if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                             
                             brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO));
                             currentRecord.External_Customer_ID2__c = BAT_ConstantsUtility.BLANK_STR;
                         }                                
                         if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR) && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                             brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VUSE_DEVICE_STR));
                             currentRecord.External_Customer_Id__c = BAT_ConstantsUtility.BLANK_STR;
                         }
                         if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                             brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VELO_DEVICE_STR));
                             currentRecord.BAT_ExternalCustomerId4__c = BAT_ConstantsUtility.BLANK_STR;
                         }
                       }
                      if(brandHouseValues.size()==0){
                         currentRecord.BAT_Is_Anonymised__c = true;  
                         currentRecord.Brand_House__c = BAT_ConstantsUtility.BLANK_STR;
                      }
                      if(brandHouseValues.size()>0){
                         currentRecord.Brand_House__c = String.join(BrandHouseValues,';'); 
                         currentRecord.LastName = oldAccountMap.get(currentRecord.Id).LastName;
                         currentRecord.FirstName = oldAccountMap.get(currentRecord.Id).FirstName;
                         currentRecord.PersonEmail = oldAccountMap.get(currentRecord.Id).PersonEmail;
                      }
                   }
                   //END OF US#1154669
                //RS Account Anonymization from Ecommerce - glo
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_RS) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.STR_ECOMM_GLO)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c) && oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c 
                   && String.isBlank(currentRecord.External_Customer_ID2__c) && currentRecord.BAT_THPStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)){
                       if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)){
                             currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO);
                            
                        }
                       if(currentRecord.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BLANK_STR)){
                           currentRecord.BAT_Is_Anonymised__c = true;
                           
                       }
                       
                       
                   }
                //Suman Avula US#1889121 CH Account Anonymization from Ecommerce - glo
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)
                   && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)
                   && String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.STR_ECOMM_GLO)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerID5__c)
                   && currentRecord.BAT_THPStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)){
                       if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)){
                          System.debug('currentRecord user by pass'+currentRecord);
                           user.Bypass_Validation_Rule__c = true; 
                           System.debug('user by pass'+user.Bypass_Validation_Rule__c);
                           currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO);
							
 							
                        }
                       
                       if(currentRecord.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BLANK_STR)){
                          currentRecord.BAT_Is_Anonymised__c = true;
                           		currentrecord.BAT_LoyaltyOptin__c= false;
                           System.debug('currentRecord user by pass11'+currentRecord);
                       }
                        user.Bypass_Validation_Rule__c = false; 
    
                   }
                
                 //Pranideep 1915019 ES - SHOPIFY Velo ACCOUNT Anonymization
                     if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ES)
                        && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)
                        && !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c)
                        && !String.isBlank(oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c)
                        && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
        
                               if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR)){
                                   
                                   currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.VELO_DEVICE_STR);
                                    
                                    
                                }
                               
                               if(currentRecord.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BLANK_STR)){
                                        currentRecord.BAT_Is_Anonymised__c = true;

                               }
                              
            
                           }
                  //Pranideep 1925574 HR - New Glo Website Account Creation, Account update & Account Deletion from website ACCOUNT Anonymization
                     if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR)
                        && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)
                        && !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c)
                        //&& !String.isBlank(oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c)
                        && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
        
                               if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)){
                                   
                                    currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO);
                                    
                                    
                                }
                               
                               if(currentRecord.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BLANK_STR)){
                                        currentRecord.BAT_Is_Anonymised__c = true;

                               }
                             
            
                           }
                
                //19/02/2025 Sagnik Ray: GR#1996961 Added logic
                if(!String.isBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR)
                        && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)
                   		&& !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c)
                  		&& currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){						
        
                               if(String.isNotBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR))
                               		{
                                   currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.VELO_DEVICE_STR);
                                    }
                               
                               if(currentRecord.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BLANK_STR))
                               		{
                                        currentRecord.BAT_Is_Anonymised__c = true;

                               		}
            
                           }
                //End
                
                //Chirag Kalra UK 10 M
                 if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.ECOMM_VUSE_STR)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).External_Customer_Id__c) && oldAccountMap.get(currentRecord.Id).External_Customer_Id__c != currentRecord.External_Customer_Id__c 
                   && String.isBlank(currentRecord.External_Customer_Id__c) && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                    if(!String.isBlank(currentRecord.External_Customer_ID2__c)|| !String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        if(!String.isBlank(currentRecord.External_Customer_ID2__c)){
                            currentRecord.BAT_VapeStatus__c = oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c;
                        }
                        
                        if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR)){
                            if (currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() > 1){
                                currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.VUSE_DEVICE_STR);
                            }
                            else{
                                currentRecord.Brand_House__c = BAT_ConstantsUtility.BLANK_STR;
                            }

                    }
                }
                    else{
                        currentRecord.BAT_Is_Anonymised__c = true;
                    }
                       
                } 
                   

                   if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.ECOMM_10M_STR)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c) && oldAccountMap.get(currentRecord.Id).External_Customer_ID2__c != currentRecord.External_Customer_ID2__c 
                   && String.isBlank(currentRecord.External_Customer_ID2__c) && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                    if(!String.isBlank(currentRecord.External_Customer_ID__c) || !String.isBlank(currentRecord.BAT_ExternalCustomerId4__c)){
                        if(!String.isBlank(currentRecord.External_Customer_ID__c)){
                            currentRecord.BAT_VapeStatus__c = oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c;
                        }

                    }
                    else{
                        currentRecord.BAT_Is_Anonymised__c = true;
                    }
                   }

                   if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR) && (user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)||user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.SADMIN) ) && String.isNotBlank(currentRecord.Last_Modified_Source__c) && currentRecord.Last_Modified_Source__c.equalsIgnoreCase(BAT_ConstantsUtility.ECOMM_LYFT_STR)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c) && oldAccountMap.get(currentRecord.Id).BAT_ExternalCustomerId4__c != currentRecord.BAT_ExternalCustomerId4__c 
                   && String.isBlank(currentRecord.BAT_ExternalCustomerId4__c) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                    if(!String.isBlank(currentRecord.External_Customer_ID2__c)|| !String.isBlank(currentRecord.External_Customer_ID__c)){
                       
                        
                        if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR)){
                            if (currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() > 1){
                                currentRecord.Brand_House__c = currentRecord.Brand_House__c.remove(BAT_ConstantsUtility.VELO_DEVICE_STR);
                            }
                            else{
                                currentRecord.Brand_House__c = BAT_ConstantsUtility.BLANK_STR;
                            }

                    }
                }
                    else{
                        currentRecord.BAT_Is_Anonymised__c = true;
                    }
                }
                //21.06.2023/Varaprasad Sada/Sprint-133--US#1324896/CH Dunhill Integration - Consumer Account Deletion
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                   && String.isNotBlank(currentRecord.AccountSource) && currentRecord.AccountSource.equalsIgnoreCase(BAT_ConstantsUtility.WEBSITE_DUNHILL) && currentRecord.Brand__c.containsIgnoreCase(BAT_ConstantsUtility.DUNHILL)
                   && !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c != currentRecord.BAT_VapeStatus__c 
                   && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                       List<String>brandHouseValues = new List<String>();
                       if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() >= 1){
                           brandHouseValues = currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                           if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)){         
                               brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO));
                           }                                
                           if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR)){         
                               brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VUSE_DEVICE_STR));
                           }
                           if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VYPE_DEVICE_STR)){         
                               brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VYPE_DEVICE_STR));
                           }
                           
                       }
                       if(brandHouseValues.size()==0){
                           currentRecord.BAT_Is_Anonymised__c = true;  
                           currentRecord.Brand_House__c=BAT_ConstantsUtility.BLANK_STR;
                       }
                       if(brandHouseValues.size()>0){
                           currentRecord.Brand_House__c=String.join(BrandHouseValues,';'); 
                       }
                       
                   }
                // 16/11/2023/US:1521043/Lalit/SE/DK - Admin Portal - Anonymise Account
                // 16/11/2023/US:1521043/Lalit/SE/DK - Admin Portal - Anonymise Account
                if(String.isNotBlank(currentRecord.Country__c) && (currentRecord.Country__c == BAT_ConstantsUtility.SE_STR || currentRecord.Country__c == BAT_ConstantsUtility.DK_STR ) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                   && ((!String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_Actives_Status__c) && oldAccountMap.get(currentRecord.Id).BAT_Actives_Status__c != currentRecord.BAT_Actives_Status__c && currentRecord.BAT_Actives_Status__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR) || (
                       !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c != currentRecord.BAT_OralStatus__c  && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)))                  
                {
                    List<String>brandHouseValues = new List<String>();
                    
                    if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() >= 1){
                        brandHouseValues = currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_AMP) && currentRecord.BAT_Actives_Status__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_AMP));
                            currentRecord.BAT_AMPEmailOptOut__c = true;
                        }                                
                        
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VELO_DEVICE_STR));
                        }
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase()) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            Integer index = BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase());
                            if (index != -1) {
                                brandHouseValues.remove(index);
                            }   
                        }
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lundgrens) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lundgrens));
                        }
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Moor) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Moor));
                        }
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lab) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lab));
                        }
                        
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_lyftsw) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_lyftsw));
                        }
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VELO_DEVICE_STR));
                        }
                    }
                    if(brandHouseValues.size()==0){
                        currentRecord.BAT_Is_Anonymised__c = true;  
                        currentRecord.Brand_House__c=BAT_ConstantsUtility.BLANK_STR;
                    }
                    if(brandHouseValues.size()>0){
                        currentRecord.Brand_House__c=String.join(BrandHouseValues,';'); 
                    }
                }
                //Reema //ADO 1470586 CZ Loyalty Account Anonymization CZ End Market Status update for THP Status and Vype Status on Brand House Value GLO, Velo and VYPE 08292023
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                   && ((!String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR) || (
                       !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c != currentRecord.BAT_VapeStatus__c  && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)
                       || (
                           !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_OralStatus__c != currentRecord.BAT_OralStatus__c  && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)))                  
                {
                    List<String>brandHouseValues = new List<String>();
                    
                    if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() >= 1){
                        brandHouseValues = currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                            
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO));
                        }                                
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR) && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VUSE_DEVICE_STR));
                        }
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VELO_DEVICE_STR) && currentRecord.BAT_OralStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VELO_DEVICE_STR));
                        }
                    }
                    if(brandHouseValues.size()==0){
                        currentRecord.BAT_Is_Anonymised__c = true;  
                        currentRecord.Brand_House__c=BAT_ConstantsUtility.BLANK_STR;
                    }
                    /* if(brandHouseValues.size()>0){
system.debug('printing brandhouse'+brandHouseValues.size());
currentRecord.Brand_House__c=String.join(BrandHouseValues,';'); 
}*/
                }
                
                //End OF US#1324896
                //ADO 1470586 fix ES End Market Status update for THP Status and Vype Status on Brand House Value GLO and VYPE 08292023
                if(String.isNotBlank(currentRecord.Country__c) && currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ES) && user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                   && ((!String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR) || (
                       !String.isBlank(oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c) && oldAccountMap.get(currentRecord.Id).BAT_VapeStatus__c != currentRecord.BAT_VapeStatus__c  && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR)))                  
                {
                    List<String>brandHouseValues = new List<String>();
                    
                    if(!String.isBlank(currentRecord.Brand_House__c) && currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON).size() >= 1){
                        brandHouseValues = currentRecord.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){
                            
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO));
                        }                                
                        if(currentRecord.Brand_House__c.containsIgnoreCase(BAT_ConstantsUtility.VUSE_DEVICE_STR) && currentRecord.BAT_VapeStatus__c == BAT_ConstantsUtility.BAT_Account_eComDeleted_DE_STR){         
                            brandHouseValues.remove(BrandHouseValues.indexOf(BAT_ConstantsUtility.VUSE_DEVICE_STR));
                        }
                    }
                    if(brandHouseValues.size()==0){
                        currentRecord.BAT_Is_Anonymised__c = true;  
                        currentRecord.Brand_House__c=BAT_ConstantsUtility.BLANK_STR;
                    }
                    if(brandHouseValues.size()>0){
                        currentRecord.Brand_House__c=String.join(BrandHouseValues,';'); 
                    }
                }
                //Bug #1356909 ,  populating the accountlist with account where mgm is blank and THP status is consumer  
                if (oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c &&  
                    currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER && 
                    String.isBlank(currentRecord.Member_get_Member_Code__c)){
                        updatedStatusAccountList.add(currentRecord);
                    }
                
            }                
            if (!memberCodeAccounts.isEmpty()) {checkIfMemberGetMemberExists(memberCodeAccounts);
                                               }
            //IT Vype
            //added as a part of US#1205658 to bypass account brand house validation via metadata for RO portal users
            // Added as part of US#1714478 to bypass account brand house validation via Integration user RO for passing brand house default as Other
            if((!user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.FLAGSHIPRO) &&
                !user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.GLOSTORERO)) &&
               (user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_RO) && 
                !user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER ))){
                    validateAccountBrandHouse(updatedAccount, oldAccountMap);   
                }
            //IT Vype:-Sprint 1(14798)-Bypass duplication rule when person account is getting updated to add brand for which lead exists
            checkExistingLeadToUpdateAccount(updatedAccount, oldAccountMap);
            //Method to validate brand-email duplicates to update Brand Status fields - Glo,Vype on Account
            //25.05.2021/ Allada Yeshwanth/ US: #525000/ Running this method before removeNonConvertedDuplicateLeads
            //UpdateAccountBrandStatusFields(updatedAccount);
            //update status 
            copyTHPStatusToStatus();
            //Bug#284828: ID - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber 
            formatAccountMobile(updatedAccount);
            //14.12.2020/Akshata Rajmane/US#276709 : Global - Introduce Global Classification section in Account Object
            BAT_Utilities.updateConsumersContactableStatus(updatedAccount, oldAccountMap);
            //25Feb/Abhishek Kashyap/US#405626-RO - Technical Setup - Gmail verification check for offline acounts
            //Removing duplicate code for mgm counter increase on consumer account
            if(!mgmAccountList.isEmpty()) {
                BAT_MemberGetMemberManager.updateMemberGetMemberCounter(mgmAccountList);
            }
            purgePersonEmailAccount(updatedAccount, oldAccountMap, BAT_ConstantsUtility.BLANK, BAT_ConstantsUtility.BLANK);           
            updateAccountUponDeAnonymization(updatedAccount, oldAccountMap); // Added as part of RO - US#445129
            
            //Bug#348985: Resolve ApexException BAT_OrderTrigger: SOQL101
            
            //Bug#1356909/Saurabh Sharma/ added generate rew code on before update for UA 
            generateREWCode(rewCodeWrapObj,updatedStatusAccountList);
            if( user.Country__c != null && user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_IT )){
                updateConsumerStatus(updatedAccount,oldAccountMap);//2.10.2023 Added condition for IT market to update status only when registration permission is true.
            }
            //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update--start
            if(!roEmailPhone.isEmpty()&&BAT_AccountTriggerHandler.isROAnonymizing){//1506330
                BAT_AccountTriggerHandler.isROAnonymizing=false;
                anonymizingRoCIAM_Accounts(updatedAccount,roEmailPhone);
            }//-End
        }catch(Exception ex){ for(Account accRec: updatedAccount){
            accRec.addError(ex.getMessage());
            Integer lineNumber = ex.getLineNumber();
            System.debug(' at line ' + lineNumber + ': ' + ex.getMessage());
        }
                            }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : OnAfterUpdate
* @returns       : void
* @params        : List<Account>,Map<Id,Account>
* @description   : [All Markets]Method to handle After Update logic of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
08.02.2019/Tejaswi Nissankula/Code Optimization
08.03.2019/Tejaswi Nissankula/US8206 code changes:creates a reward profile for type
consumer when status gets changed to consumer for account
30.05.2019 Added logic to check for existing reward profile while creating.
13.03.2019/Herin Dedhia/US-5977 Added code to Delete Tasks if Trial Permission flag is updated to false
23.04.2019/Shreeyanshu Kumar/Added 'createTrialOnTrialistUpdate' method call
14.08.2019/Tejaswi Nissankula/Extended the method 'removeNonConvertedDuplicateLead' execution to UA and KZ
20.08.2019/Tejaswi Nissankula/As part of US37847,we need to insert consumer reward profile record for Glo/velo 
accounts when Glo asset is associated.So we replaced Status__c with BAT_THPStatus__c .[UA,KZ]
28.08.2019/Abhishek Kashyap/US - 37814, Added logic to create product interest for Velo trialists.
28.08.2019/Abhishek Kashyap/BUG - 43449, added logic to skip trial creation for velo accounts
10.09.2019/ Rajesh Potla / US#34217 Added Logic to Anonymize Accounts based on field BAT_Is_Anonymised__c
12.09.2019/Tejaswi Nissankula/Removed AccountSourceConfiguration Custom metadata query and moved to constructor.
04.11.2019/Abhishek Kashyap/BUG - 57659,UCCAB Added fix to prevent multiple product interest creation during account update on order generation
18.10.2019/ Varun Kochar / ES :  Sprint 1 : US#48414 Added Logic to convert lead
09/12/2019 / Souvik Dinda/ US#47980 - Added logic for person account history deletion on anonymization.
19.12.2019/Osheen Sahajpal/CA: Sprint-2: Bug #71548: Updated code to fix privacy snapshot generation issue
23.03.2020/Tejaswi Nissankla/ Added Null check before DML operation as part of ForceReviewer changes.
5.11.2020/Dipika Gupta/ CZ 295637 if RetailPrivacySnapshot is true, do not delete privacy snapshot
13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Calling associateAssetWithAccount for auto asset generation
15th April,2020/Abhishek Kashyap/Bug-487779-478408 - Brand Profile status is not reset to Inactive after receiving Delete event from CIAM Integration
16th April, 2021/Abhishek Kashyap/US-225171-RO - Anonymized personal data visible in Orders
18th June, 2021/Dipika Gupta/Optimization nested for loop 
21.10.2021/Rama Akella/Bug#773419/IT: Create reward points for reward profile only when Account THP Status changes to 'Consumer'
5 July 2022/ Prasad V/ US #991107 [IT] glo | New reward schema for QRCode Leads collection/conversion (Mid June) || Bug #1040984 || Bug #1036900
15.12.2021/Idrees Ali/ US#756326:Added logic to allow account related fields to be stamped on Related child case record before anonymisation as part of Data Retention Policy 
08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account
09.08.2022/Anna Gomez/ Bug#1092764:IT - Update QRCode Reward Logic on Account update to Consumer without Asset
14.09.2022/Anna Gomez/ Bug#1132293: IT - Removing REACH filter as IT Account registration also flows from REACH
26.09.2022/Vamsi Ramineni/US #1105804/Global - Privacy Snapshot creation for Account
02.03.2023/Idrees Ali/ENH: Sprint-125:US#1228423-IT | glo | Point assignment to retailer if customer joins Loyalty || Added Method
17.04.2023/Saurabh Sharma/ Bug #1356909, removed BAT_IsLogicToWorkOnInsert__c = false for UA rew code bug fix
23.12.2023/ShanmugaPriyan/US: #1591514- IT GLO | Asset update from Sharpend
*********************************************************************************************************/
    public void OnAfterUpdate(Account[] updatedAccount, Map<ID,Account> oldAccountMap, Map<ID,Account> newAccountMap) {
        try {
            List<Opportunity> opportunityToAdd = new List<Opportunity>();
            String profileName = user.Profile.Name;
            List<Id> accountOptyIds = new List<Id>();
            Map<Id,List<Opportunity>> mapAccountIdToOpptyToCloseList = new Map<Id,List<Opportunity>>();
            
            List<Opportunity> opptyToUpdateList = new List< Opportunity>();
            Set<Id> accountIds = new Set<Id>();
            Map<String,List<String>> marketfieldApiMap = new Map<String,List<String>>();
            //19-12-2019/Osheen Sahajpal/CA: Sprint-2: Bug #71548: Removed initialization of list
            List<String> lstFieldApi;
            List<BAT_Reward_Profile__c> rewardProfileList = new List<BAT_Reward_Profile__c>();
            Map<string,string> rewProfileOwnerConfigMap = new Map<string,string>();
            Set<String> countrySet = new set<String>();
            Set<String> userNameSet = new set<String>();
            Map<String,Id> userNameMap = new Map<String,Id>();
            Set<Id> personAccountForTaskDeletion = new Set<Id>();
            Set<Id> accountsForTaskDeletion = new Set <Id>();
            map<Id,Set<String>> mapPersonAccountSubject = new map<Id,Set<String>> ();
            map<Id,Set<String>> mapAccountSubject = new map<Id,Set<String>> ();
            Map<Id,Account> modifiedAccountMap = new Map<Id,Account>();
            List<Account> accUpdatedList = new List <Account>();
            Map<String,BAT_DefaultRewProfilePointsConfiguration__mdt> defaultrewProfilePointsConfigMap = new Map<String, BAT_DefaultRewProfilePointsConfiguration__mdt>();
            Map<Id,BAT_Reward_Profile__c> acctIdWithRPMap = new Map<Id,BAT_Reward_Profile__c>();
            Set<id> accIdSet = new set<id>();
           //19-12-2019/Osheen Sahajpal/CA: Sprint-2: Bug #71548: Making the country set for using it in Privacy Snapshot string query
            Set<String> accCountrySet = new Set<String>();
            List<Account> accsToAnonymize = new List<Account>();
            List<Id> accidsToAnonymize = new List<Id>();
            List<Lead> relatedLeadList = new List<Lead>();
            List<Lead> sameOwnerLeadList = new List<Lead>();
            List<ID> gloConsumerAccountIds = new List<ID>();
            Set<String> convertedLeadCountrySet = new Set<String>();
            //5.11.2020/Dipika Gupta/ CZ 295637 create account list for privacy snapshot
            List<Id> accIdsToDeletePrivacySnapshotAnonymize = new List<Id>();
            //28.08.2019/Abhishek Kashyap/US - 37814, List for product interest.
            List<BAT_ProductInterest__c> listProductInterest = new List<BAT_ProductInterest__c>();
            List<Account> defaultSurveyDirectConsumerAccounts = new List<Account>();
            //US#1591514-IT GLO | Asset update from Sharpend starts//
          //  Set<String> sharpend_sources = new Set<String> (BAT_ConstantsUtility.SE_Sources.split(BAT_ConstantsUtility.SEMI_COLON));
            //US#1591514-IT GLO | Asset update from Sharpend ends//
            BAT_Utilities.byPassFlagToSetLeadStatusToLost(false,false);//Added as part of Bug#44227
            BAT_Utilities.invokeHypercareJourney(trigger.New, BAT_ConstantsUtility.ACCOUNT,BAT_ConstantsUtility.PERSONCONTACTID, 
                                                 BAT_ConstantsUtility.ACCPERSONEMAIL, BAT_ConstantsUtility.FIRSTNAME,BAT_ConstantsUtility.EVENT_UPDATE);
            //15.12.2021/Idrees Ali/ Added below collections to allow account related fields to be stamped on Related child case record before anonymisation as part of Data Retention Policy 
            Set<Id> contactIdSet = new Set<Id>();
            Set<Id> accountIdsforassetpoint = new Set<Id>();
            List<Asset> relatedAssets = new list<Asset>();
            List<Asset> assetsToUpdate = new List<Asset>();
            List<Case> caseToUpdateList = new List<Case>();
        // starts Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on second registration from different website\
            List<BAT_BrandProfile__c> relatedbrandprofile = new list<BAT_BrandProfile__c>();
            List<BAT_BrandProfile__c> brandprofileToupdate = new list<BAT_BrandProfile__c>();
             set<id> accidsetbrandprofile= new set<id>();
            // end Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on second registration from different website\

            //10.04.2024/Chirag Kalra/US - 1680227, CA - Confirm Logic of VELO (Zonnic) Email Opt In
            List<Lead> leadToUpdateList = new List<Lead>();
            Map<String,List<BAT_AccountToCaseMappingConfiguration__mdt>> accToCaseMappingConfigMap = BAT_Utilities.getAccountToCaseMappingConfig();
            BAT_Utilities.privacySnapshotDeletionWrapper snapshotWrapper = new BAT_Utilities.privacySnapshotDeletionWrapper();                               
            for(Account currentRecord: updatedAccount){
                //19-12-2019/Osheen Sahajpal/CA: Sprint-2: Bug #71548: Making the country set for using it in Privacy Snapshot string query
                accCountrySet.add(currentRecord.Country__c);
                //Added for AZ :US#44415
                //This condition will filter the records when an Account of RT Direct Consumer has THP Status as Consumer
                if(currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER 
                   && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != BAT_ConstantsUtility.ATH_CONSUMER 
                   && currentRecord.recordtypeId.equals(consumerRecordTypeId)){
                       defaultSurveyDirectConsumerAccounts .add(currentRecord);
                   }
                // start Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\
                 if(BAT_ConstantsUtility.isBrandProfileUpdate){
                    accidsetbrandprofile.add(currentRecord.id);
                }
                  // end Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\

                 //1703189-DE - multicategory Loyalty program - Anonymisation starts--
                if(String.isNotBlank(user.Country__c) && 
                    user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_DE_STR) && 
                    !currentRecord.BAT_LoyaltyOptin__c && oldAccountMap.get(currentRecord.Id).BAT_LoyaltyOptin__c!=currentRecord.BAT_LoyaltyOptin__c) {
              
                    accIdSet.add(currentRecord.id);
                    }  
                 //1703189-DE - multicategory Loyalty program - Anonymisation ends--
                 
                //US#1591514-IT GLO | Asset update from Sharpend starts//
                if(oldAccountMap.get(currentRecord.Id).Registration_Permission__c!=currentRecord.Registration_Permission__c && currentRecord.Registration_Permission__c && currentRecord.Country__c == BAT_ConstantsUtility.COUNTRY_IT &&(currentRecord.id!= null && currentRecord.AccountSource != null && sharpend_sources.contains(currentRecord.AccountSource.trim())))
                    
                    //US#1591514-IT GLO | Asset update from Sharpend ends//
                {
                    accountIdsforassetpoint.add(currentRecord.Id);
                }
                
                accountOptyIds.add(currentRecord.Id);
                countrySet.add(currentRecord.Country__c);
                //If Trial Feedback Authorization is set to False, delete all Tasks US-5977
                //3/07/2020/ Dipika Gupta/ PL US#152410/If metadata record tells not to use task subject
                //then store account or contact Id in list
                if(!taskDeletionCountries.isEmpty() && taskDeletionCountries.contains(currentRecord.Country__c) &&
                   oldAccountMap.get(currentRecord.Id).Trial_Information_Permission__c == TRUE &&
                   !currentRecord.Trial_Information_Permission__c){
                       if(currentRecord.IsPersonAccount == True){
                           //Maintaining Person Account records for task deletion
                           personAccountForTaskDeletion.add(currentRecord.PersonContactId);
                       }
                       //Maintaining Standard Account records for task deletion
                       accountsForTaskDeletion.add(currentRecord.Id);
                   }
                //3/07/2020/ Dipika Gupta/ PL US#152410/If metadata record tells use task subject
                //then create a map of account or contact Id and set of Subjects which has to be deleted
                if(!taskDeletionCountries.isEmpty() && taskDeletionCountries.contains(currentRecord.country__c) && 
                   mapTaskDeletionConfiguration.get(currentRecord.country__c).BAT_UseTaskSubject__c){
                       String fName = mapTaskDeletionConfiguration.get(currentRecord.country__c).BAT_FieldName__c;
                       if(fName != null && oldAccountMap.get(currentRecord.Id).get(fName) != currentRecord.get(fName) && currentRecord.get(fName) == false){
                           if(mapTaskDeletionConfiguration.get(currentRecord.country__c).BAT_TaskSubject__c != null){
                               String sublist = mapTaskDeletionConfiguration.get(currentRecord.country__c).BAT_TaskSubject__c.toLowerCase();
                               List<String> listSubject = sublist.split(';');
                               if(listSubject.size() > 0 ){
                                   if(currentRecord.IsPersonAccount == True){
                                       if(!mapPersonAccountSubject.containsKey(currentRecord.Id)){
                                           mapPersonAccountSubject.put(currentRecord.Id,new Set<String>());
                                       }
                                       mapPersonAccountSubject.get(currentRecord.Id).addAll(listSubject);
                                   }
                                   if(!mapAccountSubject.containsKey(currentRecord.Id)){
                                       mapAccountSubject.put(currentRecord.Id,new Set<String>());
                                   }
                                   mapAccountSubject.get(currentRecord.Id).addAll(listSubject);
                               }
                           }
                       }  
                   }
                /*Added the below logic for UK US #12067
Delete the lead for the UK only when only one of the external Ids are present on lead.
Update the lead if more than one external Id fields are populated, then update the lead and make respective-- 
External Id as blank (which was populated)*/
                //Added UA and KZ country check as part of US37833
                //ES : Sprint 2 : US 48414 : Added logic for spain to get updated Account in the list
                if(String.isNotBlank(currentRecord.country__c) && 
                   String.isNotBlank(currentRecord.AccountSource) &&
                   ((currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.UK_STR) &&
                     !accSourceSet.isEmpty() &&
                     accSourceSet.contains(currentRecord.AccountSource) &&
                     currentRecord.AccountSource.equalsIgnoreCase(oldAccountMap.get(currentRecord.Id).AccountSource)) ||
                    ((currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA) ||
                      currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) ||
                      currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ES)) &&
                     String.isNotBlank(currentRecord.Brand_House__c) && 
                     currentRecord.Brand_House__c != oldAccountMap.get(currentRecord.Id).Brand_House__c))){
                         accUpdatedList.add(currentRecord);
                     }
                System.debug('-=1' +currentRecord.country__c);
                System.debug('-=2' +currentRecord.Related_Lead__c);
                System.debug('-=3' +currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CA));
                System.debug('-=4' + currentRecord.BAT_IsVeloOptInEmailCommunication__c);
                System.debug('-=5' + oldAccountMap.get(currentRecord.Id).BAT_IsVeloOptInEmailCommunication__c);
                System.debug('-=6' +user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER));
                //10.04.2024/Chirag Kalra/US - 1680227, CA - Confirm Logic of VELO (Zonnic) Email Opt In
                /* if(currentRecord.country__c !=null && currentRecord.Related_Lead__c !=null && currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CA) && !System.isBatch() 
&& !currentRecord.BAT_IsVeloOptInEmailCommunication__c && oldAccountMap.get(currentRecord.Id).BAT_IsVeloOptInEmailCommunication__c && (user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)||user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.PROFILE_SYS_ADMIN_CA))){
*/
                //1711214-CA - LEADS VELO (Zonnic) Email Opt In to follow Accounts//
                if(currentRecord.country__c !=null && currentRecord.Related_Lead__c !=null && currentRecord.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CA) && !System.isBatch() 
                   && oldAccountMap.get(currentRecord.Id).BAT_IsVeloOptInEmailCommunication__c!=currentRecord.BAT_IsVeloOptInEmailCommunication__c && (user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)||user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.PROFILE_SYS_ADMIN_CA))){
                       Lead leadRecord = new Lead();
                       leadRecord.Id = currentRecord.Related_Lead__c;
                       leadRecord.BAT_IsVeloOptInEmailCommunication__c= currentRecord.BAT_IsVeloOptInEmailCommunication__c;
                       leadToUpdateList.add(leadRecord);
                       
                   }
            }
             //1703189-DE - multicategory Loyalty program - Anonymisation starts--
            if (!accIdSet.isEmpty()) {
            anonymisedRecordMap= BAT_Utilities.anonymizeBrandProfile (accIdSet,String.valueOf(user.Country__c) ,BAT_ConstantsUtility.BRAND_PROFILE_OBJECT_API_NAME );
            }
             //1703189-DE - multicategory Loyalty program - Anonymisation ends--
              if (!accountIdsforassetpoint.isEmpty()) {
                relatedAssets = [SELECT Id FROM Asset WHERE AccountId IN :accountIdsforassetpoint];
                assetsToUpdate.addAll(relatedAssets);
                //Bug 1785965-{Support-INC0900118}- Asset updates points issue starts--
               isRegistrationPermissionChanged= true;
                //Bug 1785965-{Support-INC0900118}- Asset updates points issue ends--
            }
            // start Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on second registration from different website\
                if(!accidsetbrandprofile.isEmpty()){
                relatedbrandprofile = [SELECT Id FROM BAT_BrandProfile__c WHERE BAT_Account__c IN :accidsetbrandprofile and BAT_TouchpointName__c=: BAT_ConstantsUtility.LOYALTY_PLATFORM_STR];
                brandprofileToupdate.addAll(relatedbrandprofile);   
            }
            // end Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on second registration from different website\

            if(!BAT_ConstantsUtility.LTH_LEADCONVERT){
                updateLeadOnInsertOrUpdateOfIntegratedAcc(updatedAccount,Trigger.isInsert,Trigger.isUpdate);
                //Added for 12067
                removeNonConvertedDuplicateLead(accUpdatedList,oldAccountMap);
            }
            //VSTS 4271-->Francesco Imperioli: New Change status on Trial for IT Market.
            if(!accountOptyIds.isEmpty()){
                //Created map of AccountId to List of Opportunity
                for(Opportunity opp : [SELECT id, AccountId, StageName, Country__c
                                       FROM Opportunity
                                       WHERE AccountId IN: accountOptyIds
                                       AND(StageName =: BAT_ConstantsUtility.TRIAL_STAGENAME_ENDED OR StageName =: BAT_ConstantsUtility.TRIAL_STAGENAME_LOST) LIMIT 50000
                                      ]){
                                          if(!mapAccountIdToOpptyToCloseList.containsKey(opp.AccountId)){
                                              mapAccountIdToOpptyToCloseList.put(opp.AccountId,new list<Opportunity>());                 
                                          }
                                          mapAccountIdToOpptyToCloseList.get(opp.AccountId).add(opp);                   
                                      }
            }
            //start of us8206 
            //retrieve the rewardProfile Owner Configuration records based on country
            //17.04.2023/Saurabh Sharma/ Bug #1356909, removed and BAT_IsLogicToWorkOnInsert__c = false for UA rew code bug fix
            for(BAT_RewardProfileOwnerConfiguration__mdt rec: [select BAT_Country__c, BAT_OwnerProfile__c, BAT_OwnerUserName__c,BAT_IsLogicToWorkOnInsert__c
                                                               from BAT_RewardProfileOwnerConfiguration__mdt
                                                               where BAT_Country__c IN: countrySet 
                                                              ]){
                                                                  rewProfileOwnerConfigMap.put(rec.BAT_Country__c, rec.BAT_OwnerUserName__c);
                                                                  userNameSet.add(rec.BAT_OwnerUserName__c);
                                                              }
            //retrieve the default rewardProfile points Configuration records based on country
            for(BAT_DefaultRewProfilePointsConfiguration__mdt rec: [select DeveloperName, BAT_MGMCodeAPIName__c, BAT_TotalPoints__c, BAT_RedeemPoints__c, BAT_PendingPoints__c,
                                                                    BAT_IsLogicToWorkOnInsert__c,BAT_MGMCodePrefix__c,BAT_IsRandomMGMCodeToBeGenerated__c from BAT_DefaultRewProfilePointsConfiguration__mdt
                                                                    where DeveloperName IN: countrySet
                                                                   ]){
                                                                       defaultRewProfilePointsConfigMap.put(rec.DeveloperName, rec);
                                                                   }
            if(!userNameSet.isEmpty()){
                for(user userRec: [select Id, username from user where isActive = true AND Username IN: userNameSet]){
                    userNameMap.put(userRec.username, userRec.Id);
                }
            }
            // End of us8206
            
            //DE: Check active duplicate records DE: Sprint4: 3352:
            updateDuplicateAccountsAtInactive(updatedAccount, oldAccountMap);
            String trialistRecordTypeId = recordTypeDevNameMap.get('Trialist');    
            for(Account currentRecord: updatedAccount){
                // added common condition in outer if loop as part of code optimizaion US#5997
                if(String.isNotBlank(trialistRecordTypeId) && currentRecord.RecordTypeId == trialistRecordTypeId){
                    //28.08.2019/Abhishek Kashyap/BUG - 43449, added logic to skip trial creation for velo accounts
                    //22.02.2022/Idrees Ali/ US#894854 - PT Glo - added logic to bypass automatic trial creation for REACH Trial scenario for PT
                    if(oldAccountMap.get(currentRecord.Id).RecordTypeId != trialistRecordTypeId 
                       && !profileName.containsIgnoreCase(BAT_ConstantsUtility.SS_PASSIONATE)
                       && currentRecord.Country__c != BAT_ConstantsUtility.Country_PT
                       && ((currentRecord.Country__c != BAT_ConstantsUtility.Country_UA && currentRecord.Country__c != BAT_ConstantsUtility.Country_KZ) 
                           || (currentRecord.Brand_House__c != null && !currentRecord.Brand_House__c.equals(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)))) {
                               Opportunity trialOpty = new Opportunity();
                               trialOpty.Name = BAT_ConstantsUtility.ASSET_TYPE_TRIAL + ' ' + BAT_ConstantsUtility.HYPHEN + ' ' + currentRecord.FirstName + ' ' + currentRecord.LastName;
                               trialOpty.CloseDate = Date.Today().addDays(30);
                               if(currentRecord.Country__c == BAT_ConstantsUtility.COUNTRY_DE_STR){
                                   trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_INTRIAL;
                               }else{
                                   trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_OPEN;
                               }
                               trialOpty.AccountId = currentRecord.Id;
                               //trialOpty.OwnerId = currentRecord.OwnerId;
                               opportunityToAdd.add(trialOpty);
                           }
                    
                    if(oldAccountMap.get(currentRecord.Id).Status__c != currentRecord.Status__c &&
                       currentRecord.Status__c == BAT_ConstantsUtility.ATH_CONSUMER){
                           //VSTS 4721-->Francesco Imperioli: New Change status on Trial for IT Market.
                           //elseif loop inside for loop removed  as part of code optimization US#5997
                           if(mapAccountIdToOpptyToCloseList.containsKey(currentRecord.Id)){
                               //Get Opportunity of Account record
                               for(Opportunity opptyToClose: mapAccountIdToOpptyToCloseList.get(currentRecord.Id)) {
                                   if((opptyToClose.Country__c != BAT_ConstantsUtility.Country_IT &&
                                       opptyToClose.StageName == BAT_ConstantsUtility.TRIAL_STAGENAME_ENDED) || (opptyToClose.Country__c == BAT_ConstantsUtility.Country_IT)){
                                           opptyToClose.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_CLOSED_WON;
                                           opptyToClose.ByPassAssetFilter__c = true;
                                           opptyToUpdateList.add(opptyToClose);
                                       }
                               }
                           }
                       }
                }
                //28.08.2019/Abhishek Kashyap/US - 37814, Added logic to create product interest for Velo trialists. 
                //04.11.2019/Abhishek Kashyap/BUG - 57659,UCCAB Added fix to prevent multiple product interest creation during account update on order generation
                if(currentRecord.IsPersonAccount 
                   && (currentRecord.Country__c == BAT_ConstantsUtility.COUNTRY_UA 
                       || currentRecord.Country__c == BAT_ConstantsUtility.COUNTRY_KZ)
                   
                   && !oldAccountMap.isEmpty()
                   && oldAccountMap.get(currentRecord.Id) != null
                   && String.isNotBlank(currentRecord.Brand_House__c)
                   && String.isNotBlank(oldAccountMap.get(currentRecord.Id).Brand_House__c)                       
                   //  && !oldAccountMap.get(currentRecord.Id).Brand_House__c.equals(currentRecord.Brand_House__c) 
                   && currentRecord.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)
                   //   && !oldAccountMap.get(currentRecord.Id).Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)
                   && BAT_ConstantsUtility.isVeloLeadConvertedToTrailist && !BAT_ConstantsUtility.isProdInterestRecInserted){
                       listProductInterest.add(new BAT_ProductInterest__c(Name = BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO,BAT_Account__c = currentRecord.Id,
                                                                          BAT_Country__c = currentRecord.Country__c,BAT_Status__c = BAT_ConstantsUtility.ASSET_TYPE_TRIAL));
                   }
                //start of US8206
                //validate the account belongs to country UA and of status Consumer 
                //As part of US37847,we need to insert consumer reward profile record for Glo/velo accounts when Glo asset is associated.
                //So we replaced Status__c with BAT_THPStatus__c
                //Assuming when we are associating glo asset to velo account ,the THP Status will be updated to consumer and brand house to glo
                Boolean isRecordToBeConsidered = false; 
                if(currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER &&
                   !rewProfileOwnerConfigMap.isEmpty() &&
                   rewProfileOwnerConfigMap.containsKey(currentRecord.country__c)){
                       isRecordToBeConsidered = true;  
                       // when account status changes from prospect to consumer ,insert reward profile record of type Consumer.
                       //Removed Prospect check on thp status to cover the scenario when user create a velo account and associate glo asset 
                       //then the thp status update to consumer from blank
                       if(oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != currentRecord.BAT_THPStatus__c ){
                           BAT_Reward_Profile__c rewProfile = new BAT_Reward_Profile__c();
                           rewProfile= BAT_Utilities.createRewardProfileRecordForUCCAB(currentRecord,defaultRewProfilePointsConfigMap,userNameMap,rewProfileOwnerConfigMap);
                           // Used accIdSet in soql to fetch existing reward profiles while new rewardprofile creation. 
                           acctIdWithRPMap.put(currentRecord.id, rewProfile);
                           accIdSet.add(currentRecord.id);
                       }
                       
                   } //End of US8206
                
                // When there is change in account record (Name,personMobilePhone,PersonEmail,Owner),the same should reflect in reward profile record associated to it
                if((isRecordToBeConsidered || currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_UA)) && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c == currentRecord.BAT_THPStatus__c &&
                   (oldAccountMap.get(currentRecord.Id).FirstName != currentRecord.FirstName ||
                    oldAccountMap.get(currentRecord.Id).LastName != currentRecord.LastName) ||
                   oldAccountMap.get(currentRecord.Id).PersonMobilePhone != currentRecord.PersonMobilePhone ||
                   oldAccountMap.get(currentRecord.Id).PersonEmail != currentRecord.PersonEmail ||
                   (oldAccountMap.get(currentRecord.Id).OwnerId != currentRecord.OwnerId && (currentRecord.Owner_Profile__c == BAT_ConstantsUtility.PROFILE_TEAM_LEADER_UA ||
                                                                                             currentRecord.Owner_Profile__c == BAT_ConstantsUtility.PROFILE_SS_LOVER_UA))){
                                                                                                 modifiedAccountMap.put(currentRecord.Id, currentRecord);
                                                                                             }
                //Bug#773419 - Storing all IT Consumer Account IDs in gloConsumerAccountIds
                if(currentRecord.country__c == BAT_ConstantsUtility.COUNTRY_IT && currentRecord.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER                  
                   && oldAccountMap.get(currentRecord.Id).BAT_THPStatus__c != BAT_ConstantsUtility.ATH_CONSUMER && currentRecord.Related_Lead__c != null){
                       gloConsumerAccountIds.add(currentRecord.ID);
                   } 
            }
            if(!gloConsumerAccountIds.isEmpty()){
                for(Account accRecord: [Select id,country__c,OwnerId,AccountSource,Related_Lead__c,Related_Lead__r.Name,Reward_Profile__r.User__c,Related_Lead__r.Reward_Profile__r.User__c,Related_Lead__r.Reward_Profile__c,Related_Lead__r.country__c,(Select id, Selling_Reward_Profile__c from Assets order by createdDate DESC Limit 1) 
                                        from Account where id in :gloConsumerAccountIds and Related_Lead__r.LeadSource = :BAT_ConstantsUtility.QRCODE                                
                                       ]){
                                           convertedLeadCountrySet.add(accRecord.country__c);
                                           
                                           //Bug#1092764:IT-Update QRCode Reward Logic on Account update to Consumer without Asset
                                           if(!accRecord.Assets.isEmpty()){
                                               for(Asset assetRec : accRecord.Assets){
                                                   // Bug#1036900, Bug #1040984 - Added logic for assigning 0 points if lead is converted to consumer by same tobacconist and by integration user
                                                   // Bug#1132293: IT - Removing REACH filter as IT Account registration also flows from REACH                                                 
                                                   if(accRecord.OwnerId != accRecord.Reward_Profile__r.User__c || 
                                                      (accRecord.OwnerId == accRecord.Reward_Profile__r.User__c && User.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                                                       && /*accRecord.AccountSource != BAT_ConstantsUtility.SOURCE_REACH && */
                                                       (assetRec.Selling_Reward_Profile__c == null || 
                                                        (assetRec.Selling_Reward_Profile__c != null && assetRec.Selling_Reward_Profile__c != accRecord.Reward_Profile__c)))){
                                                            relatedLeadList.add(accRecord.Related_Lead__r);
                                                        } 
                                                   else if(accRecord.OwnerId == accRecord.Reward_Profile__r.User__c){
                                                       sameOwnerLeadList.add(accRecord.Related_Lead__r);  
                                                   } 
                                               }
                                           } else {
                                               if(accRecord.OwnerId != accRecord.Reward_Profile__r.User__c || 
                                                  (accRecord.OwnerId == accRecord.Reward_Profile__r.User__c && User.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) 
                                                   /*&& accRecord.AccountSource != BAT_ConstantsUtility.SOURCE_REACH*/)){
                                                       relatedLeadList.add(accRecord.Related_Lead__r);
                                                   } 
                                               else if(accRecord.OwnerId == accRecord.Reward_Profile__r.User__c){
                                                   sameOwnerLeadList.add(accRecord.Related_Lead__r);  
                                               }
                                           }
                                       }
            }
            //Bug#773419 - Passing all qualifying related leads to create point records            
            if(!relatedLeadList.isEmpty() || !sameOwnerLeadList.isEmpty()){
                BAT_Utilities.createRewardProfilePointsForLeads(relatedLeadList, sameOwnerLeadList, convertedLeadCountrySet);
            }
            // Querying existing reward profiles.
            List<BAT_Reward_Profile__c> rpList = [select id, Name, Email__c, Phone__c, Associated_Social_Seller_User__c,
                                                  Country__c, BAT_ConsumerIdentifier__c
                                                  from BAT_Reward_Profile__c
                                                  where(BAT_ConsumerIdentifier__c IN: modifiedAccountMap.keySet() OR BAT_ConsumerIdentifier__c IN: accIdSet)
                                                  AND recordtype.DeveloperName =: BAT_ConstantsUtility.REWARDPROFILE_TYPE_CONSUMER
                                                 ];
            //Start of US8206
            if(!rpList.isEmpty()){
                for(BAT_Reward_Profile__c rewProfileRec: rpList){
                    // Skipping new reward profile creation if reward profile already exists for the same account.
                    if(accIdSet.contains(rewProfileRec.BAT_ConsumerIdentifier__c)){
                        acctIdWithRPMap.get(rewProfileRec.BAT_ConsumerIdentifier__c).id = rewProfileRec.id;
                    }
                    // Logic to modify Reward profile when parent account fields are modified.
                    if(modifiedAccountMap.containskey(rewProfileRec.BAT_ConsumerIdentifier__c)){
                        Account acc = modifiedAccountMap.get(rewProfileRec.BAT_ConsumerIdentifier__c);
                        rewProfileRec.Name = acc.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + acc.LastName;
                        rewProfileRec.Email__c = acc.PersonEmail;
                        rewProfileRec.Phone__c = acc.PersonMobilePhone;
                        //Validate the account owner is of profile "BAT Social Seller Lover UA" or "BAT Team Leader UA"
                        if(acc.Owner_Profile__c == BAT_ConstantsUtility.PROFILE_TEAM_LEADER_UA ||
                           acc.Owner_Profile__c == BAT_ConstantsUtility.PROFILE_SS_LOVER_UA){
                               rewProfileRec.Associated_Social_Seller_User__c = acc.OwnerId;
                           }else{
                               rewProfileRec.Associated_Social_Seller_User__c = null;
                           }
                        acctIdWithRPMap.put(rewProfileRec.BAT_ConsumerIdentifier__c, rewProfileRec);
                    }
                }
            }
            //End of US8206
            try{
                //Added Null check before DML operation as part of ForceReviewer changes.
                if(opptyToUpdateList != null && !opptyToUpdateList.isEmpty()){
                    update opptyToUpdateList;
                }
                if (!assetsToUpdate.isEmpty()) {
                    Database.update(assetsToUpdate);
                }
                // start Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\
                if (!brandprofileToupdate.isEmpty()) {
                   Database.update(brandprofileToupdate);
                    }
               // end Bug 1812647 -DE - multicategory Loyalty program -Reverse integrate on brand profile during second registration from different website on account\
                
                //30 July 2021/Dipika/ENH : US#541023 - bypass asset on automatic opportunity
                if(!opportunityToAdd.isEmpty()){
                    BAT_Utilities.setBypassOpportunityAssetMandateValidationFlag(true);
                    insert opportunityToAdd;
                    BAT_Utilities.setBypassOpportunityAssetMandateValidationFlag(false);
                }
                if(acctIdWithRPMap != null && !acctIdWithRPMap.isEmpty()){ //Added as part of US8206
                    upsert acctIdWithRPMap.values();
                }
                //1703189-DE - multicategory Loyalty program - Anonymisation starts-- 
               if(!anonymisedRecordMap.isEmpty()){
                  update anonymisedRecordMap.values();
               }
              //1703189-DE - multicategory Loyalty program - Anonymisation ends--
                //Added for AZ :US#44415
                if(!defaultSurveyDirectConsumerAccounts.isEmpty()){
                    BAT_Utilities.generateInvitationLinkOnAccountCreation(defaultSurveyDirectConsumerAccounts);
                }
                //28.08.2019/Abhishek Kashyap/US - 37814, Inserting product interest for Velo trialists.
                if(!listProductInterest.isEmpty()){
                    //Added as part of bug 44404 and US44267
                    List<Product2> veloProductRangeList = [select Id,Name from Product2 where RecordType.DeveloperName =: BAT_ConstantsUtility.RANGE_RECTYPE 
                                                           and Range__c =: BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO
                                                           and Country__c =: user.Country__c];
                    if(veloProductRangeList != null && !veloProductRangeList.isEmpty()){
                        for(BAT_ProductInterest__c rec : listProductInterest){
                            rec.BAT_ProductRange__c = veloProductRangeList[0].Id;
                        }
                    }
                    //End of US44267
                    insert listProductInterest;
                }
                //10.04.2024/Chirag Kalra/US - 1680227, CA - Confirm Logic of VELO (Zonnic) Email Opt In
                if(!leadToUpdateList.isEmpty()){
                    update leadToUpdateList;
                }
            }catch(Exception ex){ for(Account acc: updatedAccount){
                system.debug('++ex.getMessage() '+ex.getMessage());
                system.debug('++ex '+ex);
                acc.addError(ex.getMessage());
            }
                                }
            
            /*GENERATE PRIVACY SNAPSHOTS FOR ENABLED COUNTRY*/
            //Added by Usha US Sprint:6&7 UK:#9158 Object_Name__c field added which is added in custom Metadata 
            //19-12-2019/Osheen Sahajpal/CA: Sprint-2: Bug #71548: Updated query string to avoid hitting List data limit
            //11-05-2021/Idrees Ali/Avalanche Velo - US#505673 - Updated query and added extra DEEU in OR filter
            for(Privacy_Snapshot_Field__mdt LstFieldMdt: [SELECT Id, Market__c, Field_API__c,Object_Name__c
                                                          FROM Privacy_Snapshot_Field__mdt
                                                          WHERE Object_Name__c =: BAT_ConstantsUtility.STANDARD_ACCOUNT_STR
                                                          AND (Market__c IN :accCountrySet OR Market__c = :BAT_ConstantsUtility.DEFAULT_STR OR Market__c = :BAT_ConstantsUtility.DEEU_REGION_STR)
                                                         ]){
                                                             //RO - US# 405881 - Added !String.isBlank condition
                                                             if(!String.isblank(LstFieldMdt.Field_API__c)){
                                                                 
                                                                 if(!marketfieldApiMap.containsKey(LstFieldMdt.Market__c)){
                                                                     marketfieldApiMap.put(LstFieldMdt.Market__c, new List<String>());
                                                                 }
                                                                 marketfieldApiMap.get(LstFieldMdt.Market__c).add(LstFieldMdt.Field_API__c);
                                                             }
                                                         }
            
            //Added by Usha US Sprint:6&7 UK:#9158 optimized the code.Removed Country Check Hardcoding
            for(Account accRec: updatedAccount){
                if(accRec.BAT_Is_Anonymised__c && oldAccountMap.get(accRec.id).BAT_Is_Anonymised__c==false){
                    accsToAnonymize.add(accRec);
                    accidsToAnonymize.add(accRec.id);
                    if(accRec.Country__c != BAT_ConstantsUtility.UK_STR && accRec.Country__c != BAT_ConstantsUtility.COUNTRY_FR && accRec.Country__c != BAT_ConstantsUtility.COUNTRY_CZ && (accRec.country__c != BAT_ConstantsUtility.COUNTRY_SE && accRec.country__c != BAT_ConstantsUtility.DK_STR)){
                        accIdsToAnonymizecases.add(accRec.id);
                    }
                    //15.12.2021/Idrees Ali/ US#756326:Added logic to allow account related fields to be stamped on Related child case record before anonymisation as part of Data Retention Policy 
                    if(!accToCaseMappingConfigMap.isEmpty() && accToCaseMappingConfigMap.containsKey(accRec.Country__c)){
                        contactIdSet.add(accRec.PersonContactId);
                    }
                    //5.11.2020/Dipika Gupta/ CZ 295637 create account list for privacy 
                    snapshotWrapper = BAT_Utilities.checkCriteriaforSnapshotDeletion(accRec);
                    //08.08.2022/Idrees Ali/ US#859464:SE - Salesforce Data Retention Policy - Account
                    if(snapshotWrapper.bypassSnapshotCriteria == true){
                        if((profileName == BAT_constantsutility.INTEGARTION_USER ||( !automaticAnonymizationConfigMap.containsKey(accRec.Country__c)
                                                                                    || (automaticAnonymizationConfigMap.containsKey(accRec.Country__c) &&
                                                                                        !automaticAnonymizationConfigMap.get(accRec.Country__c).BAT_IsRetainPrivacySnapShot__c)))){
                                                                                            accIdsToDeletePrivacySnapshotAnonymize.add(accRec.id);
                                                                                        }
                    }else{
                        accIdsToDeletePrivacySnapshotAnonymize.addAll(snapshotWrapper.privacySnapshotDeletionParentIds);
                    }
                }    
                String marketStr;
                if(marketfieldApiMap.containsKey(accRec.country__c)){
                    marketStr = accRec.Country__c;
                }else{
                    marketStr = BAT_ConstantsUtility.DEFAULT_STR;
                }
                //Ends** US Sprint:6&7 UK:#9158 optimized the code. 
                //else loop removed  as part of code optimization US5997
                if(marketfieldApiMap.containsKey(marketStr)){
                    for(String fieldAPI: marketfieldApiMap.get(marketStr)){
                        /*ES: Sprint-1: US-49279: Added code to skip and replace non-direct Related_Lead__r.Name to
Related_Lead__c Field for Privacy Snapshot -- Start*/
                        fieldAPI = fieldAPI.equalsIgnoreCase(BAT_ConstantsUtility.ATH_RELATED_LEAD_NAME_API) ? BAT_ConstantsUtility.ATH_RELATED_LEAD_API : fieldAPI;
                        // ES: Sprint-1: US-49279 -- End
                        if((fieldAPI == BAT_ConstantsUtility.NAME_STR &&
                            (oldAccountMap.get(accRec.Id).FirstName != accRec.FirstName ||
                             oldAccountMap.get(accRec.Id).LastName != accRec.LastName)) ||
                           accRec.get(fieldAPI) != oldAccountMap.get(accRec.Id).get(fieldAPI)){
                               //US:530277||Pratishtha Pathak || Generate Privacy snapshot for countries and specific GR retailerRcordtype accounts
                               if((!accRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR) || 
                                   (accRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR) && accRec.RecordTypeId == retailerRecordTypeId)) && 
                                  // Preventing Privacy snap shot creation when account will delete from eCommerce 
                                  !(accRec.Last_Modified_Source__c !=null && accRec.Last_Modified_Source__c == BAT_ConstantsUtility.ATH_ECOMMERCE && accRec.Country__c == BAT_ConstantsUtility.COUNTRY_CZ && accRec.BAT_Is_Anonymised__c && oldAccountMap.get(accRec.Id).BAT_Is_Anonymised__c == false)
                                 ){
                                     accountIds.add(accRec.Id);
                                 }                
                           }
                    }
                }
                //28.02.2024/Varaprasad Sada/US#1637513-RS HR SI - Multicategory consents update + profiling consent (CRM Only)
                
                if(BAT_ConstantsUtility.COUNTRY_SET_RS_HR_SI.contains(accRec.Country__c) && oldAccountMap.get(accRec.Id).Generic_Permission__c!=accRec.Generic_Permission__c ){
                    BAT_Utilities.updateContactPointTypeConsent(newAccountMap,BAT_ConstantsUtility.STANDARD_ACCOUNT_STR); 
                }
            }
            //15.12.2021/Idrees Ali/ US#756326:Added logic to allow account related fields to be stamped on Related child case record before anonymisation as part of Data Retention Policy 
            if(!contactIdSet.isEmpty()){
                List<Case> caseList = [Select Id,First_Name__c,Last_Name__c,Phone_Number__c,Email__c,Country__c,ContactId from Case where ContactId IN : contactIdSet];
                if(!caseList.isEmpty()){
                    caseToUpdateList = BAT_Utilities.caseFieldUpdateBasedOnMapping(contactIdSet,caseList,accToCaseMappingConfigMap);
                }
            }
            //This method should not run while batch class is updating account records
            //Added !accountIds.isEmpty() as part of code optimization us#5997 
            //Method call to generate privacy Snapshot PDF
            // 07/08/2020/Rama Akella/Fix for order submission batch to avoid Snapshot generation more than once.
            if(System.isBatch() && !accountIds.isEmpty() && !isSnapShotGenerated){
                List<List<Id>> acctLists = (List<List<Id>>) BAT_ListsUtil.doPartitions(new List<Id>(accountIds), Integer.valueOf(System.Label.BAT_PrivacySnapShotsQueueableRecordsNumber), List<List<Id>>.class);
                BAT_PrivacySnapShotPDF_Queueable firstJob = new  BAT_PrivacySnapShotPDF_Queueable(new Set<Id>(acctLists[0]));
                BAT_PrivacySnapShotPDF_Queueable nextChainJob;
                nextChainJob = firstJob;
                for(Integer i =1 ; i < acctLists.size(); i++){
                    BAT_PrivacySnapShotPDF_Queueable  job = new BAT_PrivacySnapShotPDF_Queueable(new Set<Id>(acctLists.get(i)));
                    nextChainJob.setNextJob(job);
                    nextChainJob = job;
                }
                System.enqueueJob(firstJob);
                isSnapShotGenerated = true;
            }else if(!accountIds.isEmpty() && !isSnapShotGenerated && !System.isFuture()){
                if(!Test.isRunningTest() || (Test.isRunningTest() && BAT_ConstantsUtility.Invoke_Account_generatePrivacySnapShotPDF == true)){
                    List<List<Id>> acctLists = (List<List<Id>>) BAT_ListsUtil.doPartitions(new List<Id>(accountIds), Integer.valueOf(System.Label.BAT_PrivacySnapShotsFutureRecordsNumber), List<List<Id>>.class);
                    for(List<Id> acctIds : acctLists){
                        generatePrivacySnapShotPDF(acctIds);   
                    }
                    isSnapShotGenerated = true;   
                }
            }
            generateTaskForHyperCareBasic(updatedAccount, oldAccountMap); //Removed 3rd paramater (type : boolean),as this method is only called afterupdate US#5997
            manageHypercare(updatedAccount, oldAccountMap);
            //Delete all open tasks when Trial Feedback Authorization is set to False - US 5977 
            //03/07/2020/ Dipika Gupta/ PL US#152410/Pass map to delete Task so specific task will get deleted
            
            if(!accountsForTaskDeletion.isEmpty() || mapPersonAccountSubject.size() > 0){
                BAT_Utilities.deleteTasks(accountsForTaskDeletion, BAT_ConstantsUtility.STANDARD_ACCOUNT_STR,mapPersonAccountSubject);
            }
            if(!personAccountForTaskDeletion.isEmpty() || mapAccountSubject.size() > 0){
                BAT_Utilities.deleteTasks(personAccountForTaskDeletion, BAT_ConstantsUtility.STANDARD_CONTACT_STR,mapAccountSubject);
            }
            //IT-Vype: Sprint2: US#15157
            if(!BAT_AssetTriggerHandler.isTHPStatusRevertedToTrialist){
                createTrialOnTrialistUpdate(updatedAccount, oldAccountMap);
            }
            //ENH: Sprint-28: US#34217/Logic to Anonymize Accounts based on BAT_Is_Anonymised__c.
            //ENH: Sprint-105: US#778528/ Added batch check to avoid trigger run for account anonymization that is already done via Global Data Retention batch(Data Retention US)
            //ENH: Sprint -130:11 May, 2023/ Chirag Kalra/ US-1345992, FR,  Added BAT_VeloFeedbackCallAuthorization__c,BAT_VeloOptOutDateLastFeedback__c for Anonymization  
            if(!System.isBatch()){
                if(!accsToAnonymize.isEmpty() && !accidsToAnonymize.isEmpty()){
                    List<Account> accListToAnonimise = [SELECT id, LastName, FirstName, Country__c, PersonEmail, PersonMobilePhone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, Related_Lead__c,
                                                        Registration_Permission__c,External_Information_Systems_Permission__c,Submit_Surveys_Permission__c,
                                                        Trial_Information_Permission__c,Birth_Date__c,Generic_Permission__c, is_trialist__c,Gender__c,Status__c, BAT_Is_Anonymised__c,
                                                        BAT_CombustibleStatus__c,BAT_OralStatus__c,BAT_THPStatus__c,BAT_VapeStatus__c,
                                                        BAT_IsEPOKOptInEmailCommunication__c,BAT_IsEPOKOptInMobileTextWhatsApp__c,BAT_IsEPOKOptInPostal__c,  
                                                        BAT_EPOKMarketResearchAuthorization__c,BAT_EPOKLastCompletedOrderDate__c,BAT_EPOKLastConsentOptInDate__c,
                                                        BAT_IsVypeOptInEmailCommunication__c,BAT_IsVypeOptInMobileTextWhatsApp__c,BAT_IsVypeOptInPostal__c,
                                                        BAT_VypeMarketResearchAuthorization__c,GoVype_Last_Completed_Order_Date__c,BAT_VypeLastConsentOptInDate__c,  
                                                        BAT_IsLyftOptInEmailCommunication__c,BAT_IsLyftOptInMobileTextWhatsApp__c,BAT_IsLyftOptInPostal__c,  
                                                        BAT_LyftMarketResearchAuthorization__c,BAT_LyftExternalCompaniesAuthorization__c,
                                                        BAT_LyftTrialFeedbackAuthorization__c,BAT_LyftLastCompletedOrderDate__c, BAT_LyftLastConsentOptInDate__c,
                                                        External_Customer_Id__c, External_Customer_ID3__c,BAT_ExternalCustomerId4__c,BAT_ExternalSubscriberId__c,BAT_ExternalSubscriberId3__c,   BAT_ExternalSubscriberId4__c,
                                                        Email_verified__c, Member_get_Member_Code__c, MgM_Counter__c, Skip_Repurchase_Lock__c,
                                                        Wrong_Phone_Number__c, Preferred_Tobacconist_Shop__c, Last_Call_Type__c, Member_get_Member_Promotional_Code__c,
                                                        Age_verified__c, PersonHasOptedOutOfFax, PersonDoNotCall, SMS_Opt_Out__c, PersonHasOptedOutOfEmail, AccountSource,
                                                        Store_ID__c, BAT_BypassMobileVerification__c,  Category__c, Brand__c, Variant__c, Sector__c, PersonIndividualId, Last_Modified_Source__c ,BAT_VeloFeedbackCallAuthorization__c,BAT_VeloOptOutDateLastFeedback__c,
                                                        BAT_VeloOptInDateLastFeedback__c,BAT_AMPEmailOptOut__c
                                                        FROM Account where id IN :accidsToAnonymize];
                    BAT_Utilities.callFromAccountTrigger = true;
                    accListToAnonimise = BAT_Utilities.anonymizeAccounts(accListToAnonimise);                  
                    List<Asset> assetsToAnonymize = BAT_Utilities.anonymizeRelatedAssets(accidsToAnonymize);       
                    List<Case> casesToAnonymize = BAT_Utilities.anonymizeRelatedCases(accIdsToAnonymizecases);
                    List<BAT_BrandProfile__c> brandProfilesToAnonymize = BAT_Utilities.anonymizeRelatedBrandProfiles(accidsToAnonymize);// Added as part of RO - Bug#457454             
                    List<Survey_Information__c> surveysToAnonymize = BAT_Utilities.anonymizeRelatedServeys(accidsToAnonymize);
                    List<Event> eventsToAnonymize = BAT_Utilities.anonymizeRelatedEvents(accidsToAnonymize);
                    List<Task> tasksToAnonymize = BAT_Utilities.anonymizeRelatedTasks(accidsToAnonymize);
                    List<Lead> leadsToAnonymize= BAT_Utilities.anonymizaRelatedLeads(accListToAnonimise);
                    List<Individual> individualsToAnonymize= BAT_Utilities.anonymizeRelatedIndividuals(accListToAnonimise); 
                    List<Opportunity> oppsToAnonymize = BAT_Utilities.anonymizeRelatedOpportunity(accidsToAnonymize);
                    List<Order> ordersToAnonymize= BAT_Utilities.anonymizeRelatedOrders(accidsToAnonymize);
                    List<ContactPointTypeConsent> consentsPointsToAnonymize = BAT_Utilities.anonymizeRelatedContactPoints(accidsToAnonymize);
                    List<ContentDocument> PrivacyDocs = BAT_Utilities.deletePrivacySanpshots(accIdsToDeletePrivacySnapshotAnonymize);
                    
                    //Added Null check before DML operation as part of ForceReviewer changes.
                    //15.12.2021/Idrees Ali/ US#756326:Added logic to allow account related fields to be stamped on Related child case record before anonymisation as part of Data Retention Policy 
                    if(!caseToUpdateList.isEmpty()){ 
                        update caseToUpdateList;
                    }
                    if(accListToAnonimise != null && !accListToAnonimise.isEmpty()){ update accListToAnonimise;
                                                                                   }      
                    if(assetsToAnonymize != null && !assetsToAnonymize.isEmpty()){ update assetsToAnonymize; 
                                                                                 }                    
                    if(casesToAnonymize != null && !casesToAnonymize.isEmpty()){ update casesToAnonymize; 
                                                                               }
                    //Added as part of RO - Bug#457454
                    if(brandProfilesToAnonymize != null && !brandProfilesToAnonymize.isEmpty()){ update brandProfilesToAnonymize; 
                                                                                               }
                    if(surveysToAnonymize != null && !surveysToAnonymize.isEmpty()){ update surveysToAnonymize; 
                                                                                   }
                    if(eventsToAnonymize != null && !eventsToAnonymize.isEmpty()){ 
                        if(Schema.sObjectType.Event.isDeletable()  && !Test.isRunningTest()) { delete eventsToAnonymize; 
                                                                                             }
                        else { 
                            update eventsToAnonymize; 
                        }
                    }
                    
                    //Added Null check before DML operation as part of ForceReviewer changes.
                    if(tasksToAnonymize != null && !tasksToAnonymize.isEmpty()){
                        if(Schema.sObjectType.Task.isDeletable() && !Test.isRunningTest()){ delete tasksToAnonymize; 
                                                                                          }else {  
                                                                                              update tasksToAnonymize; 
                                                                                          }
                    }
                    
                    //Added Null check before DML operation as part of ForceReviewer changes.
                    if(leadsToAnonymize != null && !leadsToAnonymize.isEmpty()){ update leadsToAnonymize; 
                                                                               }
                    if(oppsToAnonymize != null && !oppsToAnonymize.isEmpty()){ update oppsToAnonymize; 
                                                                             }
                    if(ordersToAnonymize != null && !ordersToAnonymize.isEmpty()){ update ordersToAnonymize; 
                                                                                 }
                    if(consentsPointsToAnonymize != null && !consentsPointsToAnonymize.isEmpty()){ update consentsPointsToAnonymize; 
                                                                                                 }
                    if(individualsToAnonymize != null && !individualsToAnonymize.isEmpty()){ update individualsToAnonymize; 
                                                                                           }
                    if(PrivacyDocs != null && !PrivacyDocs.isEmpty()){ Delete PrivacyDocs; 
                                                                     }
                    //Added for US#47980
                    Set<Id> accHistoryDelIdSet = new Set<Id>();
                    //16th April, 2021/Abhishek Kashyap/US-225171-Declared sets of Order, Asset and Case
                    Set<Id> deleteRelatedOrderAccountIdSet = new Set<Id>();
                    Set<Id> deleteRelatedConsentsAccountIdSet = new Set<Id>();
                    Set<Id> deleteRelatedAssetAccountIdSet = new Set<Id>();
                    Set<Id> deleteRelatedCaseAccountIdSet = new Set<Id>();
                    for(Account anonymizedAccount: accListToAnonimise){
                        if(!automaticAnonymizationConfigMap.isEmpty()
                           && automaticAnonymizationConfigMap.containskey(anonymizedAccount.Country__c)&& automaticAnonymizationConfigMap.get(anonymizedAccount.Country__c).BAT_DeletePersonAccountHistory__c){
                               accHistoryDelIdSet.add(anonymizedAccount.Id);
                           }
                    }
                    //16th April, 2021/Abhishek Kashyap/US-225171-Populated the sets with Order IDs to delete history, derived by metadata
                    for(Order eachOrder:ordersToAnonymize){
                        String country = eachOrder.Account.Country__c;
                        if(!automaticAnonymizationConfigMap.isEmpty() && automaticAnonymizationConfigMap.containskey(country)
                           && automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedOrderHistory__c){
                               deleteRelatedOrderAccountIdSet.add(eachOrder.Id);
                           }
                    }
                    //30th June,2022/Rajeswari Nidamanuri/ US -1029822 - Populated the sets with consents IDs to delete history, derived by metadata
                    for(ContactPointTypeConsent eachContactPointTypeConsent:consentsPointsToAnonymize){
                        String country = eachContactPointTypeConsent.BAT_Country__c;
                        if(!automaticAnonymizationConfigMap.isEmpty() && automaticAnonymizationConfigMap.containskey(country)
                           && automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedConsentHistory__c){
                               deleteRelatedConsentsAccountIdSet.add(eachContactPointTypeConsent.Id);
                           }
                    }
                    //16th April, 2021/Abhishek Kashyap/US-225171-Populated the sets with Asset IDs to delete history, derived by metadata
                    for(Asset eachAsset:assetsToAnonymize){
                        String country = eachAsset.Account.Country__c;
                        if(!automaticAnonymizationConfigMap.isEmpty()
                           && automaticAnonymizationConfigMap.containskey(country)&& automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedAssetHistory__c){
                               deleteRelatedAssetAccountIdSet.add(eachAsset.Id);
                           }
                    }
                    //16th April, 2021/Abhishek Kashyap/US-225171-Populated the sets with Case IDs to delete history, derived by metadata
                    for(Case eachCase:casesToAnonymize){
                        String country = eachCase.Country__c;
                        if(!automaticAnonymizationConfigMap.isEmpty()
                           && automaticAnonymizationConfigMap.containskey(country)&& automaticAnonymizationConfigMap.get(country).BAT_DeleteRelatedCaseHistory__c){
                               deleteRelatedCaseAccountIdSet.add(eachCase.Id);
                           }
                    }
                    //16th April, 2021/Abhishek Kashyap/US-225171-restructured the method to delete Account, Order, Asset and Case history in single future call
                    if(!accHistoryDelIdSet.isEmpty() || !deleteRelatedOrderAccountIdSet.isEmpty() ||!deleteRelatedConsentsAccountIdSet.isEmpty()|| !deleteRelatedAssetAccountIdSet.isEmpty() || !deleteRelatedCaseAccountIdSet.isEmpty()){
                        BAT_Utilities.deletePersonAccHistory(accHistoryDelIdSet, user.Id, deleteRelatedOrderAccountIdSet,deleteRelatedConsentsAccountIdSet, deleteRelatedAssetAccountIdSet, deleteRelatedCaseAccountIdSet);
                    }
                }
            }
            //13.01.2021/Osheen Sahajpal/ENH: Sprint-70: IT: US #340701: Calling asset association for account method
            BAT_Utilities.associateAssetWithAccount(updatedAccount,oldAccountMap);
            //End of US#34217
            //02.03.2023/Idrees Ali/ENH: Sprint-125:US#1228423-IT | glo | Point assignment to retailer if customer joins Loyalty
            assignPointsForLoyaltySubscription(updatedAccount, oldAccountMap, newAccountMap);
        }catch(Exception ex){ for(Account accRec: updatedAccount){
            system.debug('++ex.getMessage() '+ex.getMessage());
            system.debug('++ex '+ex);
            accRec.addError(ex.getMessage());
        }
                            }
    }
    /*--------------------SERVICE METHODS START-----------------------------------*/
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : assignAccountSource
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to assign the account source depending on Profile of User on Before insert of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
: 31.05.2019/Tejaswi Nissankula/When POS Agent user is creating Account ,then flow the account source data from 
user's Account source field if it is not blank else set the value as "POS Agent" (US25038).Moved profile related
checks to custom metadata and get the account source from the same.
: Oct16th,2019 - MXENH-#52715/Prince Chawla -Bypassed it for MX, as below logic sets Flagship in the Account source from mdt.
Whenever Profile is Flagship and UserType is not GloCorner & validation rules are firing even for the accepted values of Account source in MX.  
18.06.2021/Dipika Gupta/Applied Gloabl Account Source query out for for loop
Sep5th,2022 - Bug - 1123458/Rajeswari N- Bypassed it for Ch, as below logic sets Contact Center in the Account source from mdt.
*********************************************************************************************************/
    
    @TestVisible private void assignAccountSource(List<Account> currentRecords){
        
        string profileName = user.Profile.Name;
        string country = user.Country__c;
        //Remove the country sufix from profilename
        if(string.isNotBlank(profileName) && string.isNotBlank(country) && profileName.contains(country) && !country.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_PL) && !country.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CZ)){//[PL] 03.07.2020/ Mallik Balla/ US# 128832 : For PL the values to be set are different from Global, so byapssing the concatinating check // Allada Yeshwanth extended for CZ Market
            profileName = profileName.substringBefore(BAT_ConstantsUtility.HYPHEN_WITH_BOTHSIDE_SPACE+country);
        }
        list<BAT_GlobalAccountSourceConfiguration__mdt> listGlobalAccSourceRec = [select BAT_ProfileName__c,BAT_DefaultObjectSource__c,
                                                                                  BAT_OtherSourceFromUser__c,BAT_ObjectName__c,
                                                                                  BAT_OtherSourceFromUserValue__c,BAT_Sequence__c ,
                                                                                  BAT_isPreferenceRequired__c,BAT_ProfilePreferredValue__c,
                                                                                  BAT_SourcePreferredValue__c    
                                                                                  from BAT_GlobalAccountSourceConfiguration__mdt 
                                                                                  where BAT_ObjectName__c =: BAT_ConstantsUtility.ACCOUNT 
                                                                                  AND BAT_ProfileName__c =:profileName
                                                                                  ORDER BY BAT_Sequence__c];
        for(Account currentRecord : currentRecords){
            //Oct16th,2019 - MXENH-#52715/Prince Chawla -Bypassed it for MX, as below logic sets Flagship in the Account source from mdt.
            //Sep5th,2022 - Bug - 1123458/Rajeswari N- Bypassed it for Ch, as below logic sets Contact Center in the Account source from mdt. 
            if(!currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MX_STR) && !currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)){
                for(BAT_GlobalAccountSourceConfiguration__mdt globalAccSourceRec :listGlobalAccSourceRec){
                    //Selective choosing of account source values for profiles using BAT_isPreferenceRequired__c field on meta records
                    if(globalAccSourceRec.BAT_isPreferenceRequired__c 
                       && user.Profile.Name == globalAccSourceRec.BAT_ProfilePreferredValue__c 
                       && !String.isBlank(globalAccSourceRec.BAT_SourcePreferredValue__c)){
                           currentRecord.AccountSource = globalAccSourceRec.BAT_SourcePreferredValue__c;
                           break;
                       }
                    //when we need to set account source from user related data (user type, account source) or with just profile name
                    else if(!globalAccSourceRec.BAT_isPreferenceRequired__c && ((string.isNotBlank(globalAccSourceRec.BAT_OtherSourceFromUser__c) && 
                                                                                 user.get(globalAccSourceRec.BAT_OtherSourceFromUser__c) == globalAccSourceRec.BAT_OtherSourceFromUserValue__c)
                                                                                || string.isBlank(globalAccSourceRec.BAT_OtherSourceFromUser__c))){
                                                                                    currentRecord.AccountSource = globalAccSourceRec.BAT_DefaultObjectSource__c;
                                                                                    break;
                                                                                }
                }
            }
        }
        
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : checkIfMemberGetMemberExists
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to check if Account already exist depending on member code on before 
insert/update of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
05.06.2020/Edwin Resendiz/Bug #141927 - Add validation to remove IT country of the MGM code checking.
06.11.2020/Souvik Dinda/ US#296128 - Added a new field BAT_MemberGetMemberVypePromotionalCode__c for checking the Vype Promotional code during Account registration for IT/ES.
22.03.2021/ Akshata Rajmane/ Bug#455945 : Bypassed validation for greece market
25.02.2022/ Praveen/ US# 804167: KZ - National ID Validation Rule | This method is used to get all the accounts/leads with matching National_Id__c to avoid creation of duplicate Nationation Id.
*********************************************************************************************************/
    
    @TestVisible private void checkIfMemberGetMemberExists(List<Account> accountList){
        List<Account> accountMembers = new List<Account>();
        List<Account> rewardMembers = new List<Account>();
        Set<String> accMemberCodes = new Set<String>();
        Set<String> rewMemberCodes = new Set<String>();
        Set<String> foundExistingAccountCodes = new Set<String>();
        Set<String> foundExistingRewardCodes = new Set<String>();
        Set<String> duplicateNationalIdAccounts = new Set<String>();
        for(Account account: accountList){
            //Bug #141927 validation to avoid IT accounts for MGM promotional code validation.
            //Bug#455945 : Bypassed validation for greece market
            Set<String> nonMGMCountries = new Set<String>{BAT_ConstantsUtility.COUNTRY_IT,BAT_ConstantsUtility.COUNTRY_GR,BAT_ConstantsUtility.COUNTRY_CY,BAT_ConstantsUtility.COUNTRY_KZ,BAT_ConstantsUtility.COUNTRY_HR};
                if(!nonMGMCountries.contains(account.Country__c)){
                    //US#296128 - Added check for BAT_MemberGetMemberVypePromotionalCode__c when consumer registered through Vype website
                    String subStr = BAT_ConstantsUtility.BLANK_STR;
                    if(account.Member_get_Member_Promotional_Code__c != null){
                        subStr = account.Member_get_Member_Promotional_Code__c.substring(0, 3);
                    }else{
                        subStr = account.BAT_MemberGetMemberVypePromotionalCode__c.substring(0, 3);
                    }
                    //If the membercode starts with ACC
                    if(subStr == BAT_ConstantsUtility.MEMBERSHIP_CODE_ACC){
                        //US#296128 - If consumer registered through Vype website, BAT_MemberGetMemberVypePromotionalCode__c will be populated
                        //and the account's BAT_MemberGetMemberVypePromotionalCode__c will checked against the Member_get_Member_code__c of other account.
                        if(account.Member_get_Member_Promotional_Code__c != null){
                            accMemberCodes.add(account.Member_get_Member_Promotional_Code__c);
                        }else{
                            accMemberCodes.add(account.BAT_MemberGetMemberVypePromotionalCode__c);  
                        }
                        accountMembers.add(account);    
                        //If member code start with REW
                    }else if(subStr == BAT_ConstantsUtility.MEMBERSHIP_CODE_REW){
                        rewMemberCodes.add(account.Member_get_Member_Promotional_Code__c);
                        rewardMembers.add(account);
                        //Throw error if member is none of the above - Bug #141927
                    }else{
                        account.addError(Label.Mgm_Invalid_Code);
                    }
                }
        }
        //US# 804167: KZ - National ID Validation Rule - Added the OR condition to get duplicate National Ids from Accounts
        if(!accMemberCodes.isEmpty() || (!mapCountryNationalId.isEmpty() && mapCountryNationalId.containsKey(BAT_ConstantsUtility.COUNTRY_KZ) && mapCountryNationalId.get(BAT_ConstantsUtility.COUNTRY_KZ) != null)){
            //Check if the account with Member Code exists
            for(Account account: [SELECT Id, Member_get_Member_code__c,Country__c,National_ID__c
                                  FROM Account
                                  WHERE (Member_get_Member_code__c IN: accMemberCodes OR (National_ID__c != NULL AND National_ID__c IN: mapCountryNationalId.get(BAT_ConstantsUtility.COUNTRY_KZ)))
                                  AND isPersonAccount = true
                                 ]){
                                     if(!account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ)){
                                         foundExistingAccountCodes.add(account.Member_get_Member_code__c);
                                     }
                                     if(String.isNotBlank(account.National_ID__c) && account.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ)){
                                         duplicateNationalIdAccounts.add(account.National_ID__c);
                                     }
                                 }
            for(Account account: accountMembers){
                if(!foundExistingAccountCodes.contains(account.Member_get_Member_Promotional_Code__c) &&
                   !foundExistingAccountCodes.contains(account.BAT_MemberGetMemberVypePromotionalCode__c)){
                       //Throw no customer exist error
                       account.addError(Label.Mgm_Account_not_found);
                   }
            }
        }
        if (!rewMemberCodes.isEmpty()) {
            //Check if the member code profiles exists
            for(BAT_Reward_Profile__c profile: [SELECT id, Mgm_Counter__c,
                                                Member_get_Member_code__c
                                                FROM BAT_Reward_Profile__c
                                                WHERE Member_get_Member_code__c IN: rewMemberCodes
                                               ]){
                                                   foundExistingRewardCodes.add(profile.Member_get_Member_code__c);
                                               }
            for(Account account: rewardMembers){
                if (!foundExistingRewardCodes.contains(account.Member_get_Member_Promotional_Code__c)){
                    //Throw no customer exist error
                    account.addError(Label.Mgm_Reward_Profile_not_found);
                }
            }
        }
        //Throw error to records
        if(!duplicateNationalIdAccounts.isEmpty()){
            for(Account account: accountList){
                if(duplicateNationalIdAccounts.contains(account.National_ID__c))
                    account.addError(Label.BAT_KZ_Account_NationalIdExistsErrorMessage);
            }
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : generatePrivacySnapShotPDF
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to generate PDF for privacy snapshots as attachment of the accountRecords and Push to Azure,
to enable this feature add your country row to Privacy_Snapshot_Permission__mdt on after 
insert/update account
* @changeHistory : 26.09.2022/Vamsi Ramineni/Created the method
GLOBAL/US #1105804/Privacy Snapshot creation for Account
*********************************************************************************************************/
    @future(callout = true)
    public static void generatePrivacySnapShotPDF(List<Id> triggerNew) {
        Map<String,Privacy_Snapshot_Permission__mdt> countryPermissionMap = new Map<String,Privacy_Snapshot_Permission__mdt>();
        Privacy_Snapshot_Permission__mdt permission = null;
        Set<String> countryList = new Set<String>();
        Set<String> profileSet = new set<String>();
        Map<Id,BAT_PrivacySnapshotRequests.FileAttach> accToFile = new Map<Id,BAT_PrivacySnapshotRequests.FileAttach>();
        Map<Id,Blob> mapIdToFileBlob = new Map<Id,Blob>();
        List<BAT_Integration_Log_DE__c> logs = new List<BAT_Integration_Log_DE__c>();
        List<Account> currentAccounts=[SELECT ID,Country__c,OwnerId,Owner_Profile__c,AccountSource ,Name
                                       FROM Account 
                                       WHERE ID in:triggerNew];
        Map<Id,Account> currAccMap = new Map<Id,Account>(currentAccounts);
        TimeZone tz = UserInfo.getTimeZone();
        TimeZone roTZ = Timezone.getTimeZone('Europe/Bucharest');
        for(Account accRec : currentAccounts){
            if(!String.isEmpty(accRec.Country__c)){
                countryList.add(accRec.Country__c);
            }
        }
        for(Privacy_Snapshot_Permission__mdt permissionRecord: [SELECT ID, MasterLabel, Document_Name__c, Owner_Profile__c, 
                                                                DeveloperName, BAT_DefaultUser__c FROM Privacy_Snapshot_Permission__mdt]){
                                                                    countryPermissionMap.put(permissionRecord.MasterLabel, permissionRecord);
                                                                    profileSet.add(permissionRecord.Owner_Profile__c);                                                       
                                                                }
        try{
            for(Account accRec: currentAccounts){
                if(!String.isBlank(accRec.country__c)){
                    String countryStr;
                    countryStr = accRec.country__c;
                    //Added String to populate it with EU in case the account source is ecommerce Velo EU
                    String avalancheRegionStr = BAT_ConstantsUtility.EMPTY_STRING;
                    if(String.isNotBlank(accRec.AccountSource) && accRec.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE){
                        avalancheRegionStr = BAT_ConstantsUtility.EU_REGION_SUFFIX;
                    }
                    countryStr = accRec.country__c + avalancheRegionStr;
                    if(countryPermissionMap.containsKey(countryStr)){
                        permission = countryPermissionMap.get(countryStr);
                    }
                    /*FOR UNIT TEST PURPOSE*/
                    Blob pdfTestBody = blob.valueOf(BAT_ConstantsUtility.UNIT_TEST);
                    String filenameTest = BAT_ConstantsUtility.PRIVACY_SNAPSHOT_FILENAME_TEST;
                    if(permission != null){
                        if(!String.isBlank(countryStr) && countryStr == BAT_ConstantsUtility.COUNTRY_RO){
                            tz = roTZ;
                        }
                        String pageTitle = permission.Document_Name__c + '_' + DateTime.Now().AddSeconds(tz.getOffset(DateTime.Now()) / 1000);
                        String title = accRec.Id + '_' + pageTitle;
                        title = title.replace(' ', '_');
                        String filename = title + BAT_ConstantsUtility.PDF_EXTENSION;
                        PageReference page_pdf = Page.BAT_Privacy_Snapshot_PDF;
                        page_pdf.getParameters().put(BAT_ConstantsUtility.ID_PARAM, accRec.Id);
                        Page_pdf.getParameters().put(BAT_ConstantsUtility.TITLE_PARAM,pageTitle);
                        Blob file = !Test.isRunningTest() ? page_pdf.getContent() : pdfTestBody;
                        BAT_PrivacySnapshotRequests.FileAttach fa= new BAT_PrivacySnapshotRequests.FileAttach();
                        fa.filename = !Test.isRunningTest() ? filename : filenameTest;
                        fa.file = EncodingUtil.base64Encode(file);
                        accToFile.put(accRec.Id, fa);
                        mapIdToFileBlob.put(accRec.Id,file);
                    }
                }
            }
            if(accToFile.size() > 0){
                for(Id accId : accToFile.keySet()){
                    Boolean isFileUploaded = new BAT_AzureFilesCalloutService(BAT_ConstantsUtility.AZURE_FILE_API_NAMED_CREDENTIAL ,BAT_ConstantsUtility.AZURE_TOKEN_PROVIDER).uploadPDFFile(currAccMap.get(accId).Country__c, accId ,mapIdToFileBlob.get(accId), accToFile.get(accId).filename);
                    System.debug('isFileUploaded: ' + accToFile.get(accId).filename + isFileUploaded);
                    BAT_Integration_Log_DE__c integrationLog = new BAT_Integration_Log_DE__c();
                    integrationLog.Object_Type__c = BAT_ConstantsUtility.STANDARD_ACCOUNT_STR;
                    if(!isFileUploaded){
                        String requestBody =  JSON.serializePretty(accToFile.get(accId));
                        Integer requestSize = requestBody.length();
                        Integer divideRequestBody = requestSize/2;
                        String requestBody1 = requestBody.substring(0,divideRequestBody);
                        String requestBody2 = requestBody.substring(divideRequestBody,requestSize);
                        integrationLog.Request_Details__c = requestBody1;
                        integrationLog.BAT_RequestDetails2__c = requestBody2;
                    }else{
                        integrationLog.Request_Details__c = accToFile.get(accId).filename;
                    }
                    integrationLog.Response_Details__c = String.valueOf(isFileUploaded);
                    integrationLog.BAT_Country__c = currAccMap.get(accId).Country__c;
                    integrationLog.BAT_Context__c = BAT_ConstantsUtility.GENERATE_PRIVACY_SNAPSHOT_PDF;
                    integrationLog.BAT_RecordId__c = accId;
                    integrationLog.Status__c = !isFileUploaded ? 'Failed' : 'Completed' ;
                    logs.add(integrationLog);
                }
            }
            if(!logs.isEmpty()){
                insert logs;
            }
        }catch(Exception ex){
            Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = BAT_ConstantsUtility.ATH_Class, Exception__c = ex.getMessage(),
                                                  Method_Name__c = BAT_ConstantsUtility.GENERATE_PRIVACY_SNAPSHOT_PDF);
            insert apexLog;
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : generatePrivacySnapShotPDF
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to generate PDF for privacy snapshots as attachment of the accountRecords,
to enable this feature add your country row to Privacy_Snapshot_Permission__mdt on after 
insert/update account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
08.02.2019/Tejaswi Nissankula/Code Optimization
01.03.2019/Shreeyanshu Kumar/Bug#10472
17/12/2019/ Souvik Dinda/ Added as part of Sprint 34 to have name of privacy snapshot with Roman Timezone
for Roaman accounts/leads.
//#115521-April30th,2020 - Avoided SObject row does not allow errors.
22.06.2020/Edwin Resendiz/Bug #124628 - List has no rows for assignment to Sobject generatePrivacySnapShotPDF
23.03.220/Tejaswi Nissanluka/ Added Null check before DML operation as part of ForceReviewer changes.
11.05.2021/Idrees Ali / Added an account source check as part of 505673 - Avalanche - Admin Portal - Account Privacy Snapshot
*********************************************************************************************************/
    /* @future(callout = true)
public static void generatePrivacySnapShotPDF(Set<Id> triggerNew, Id networkId) {
Map<String,Privacy_Snapshot_Permission__mdt> countryPermissionMap = new Map<String,Privacy_Snapshot_Permission__mdt>();
Map<String,Id> countryDefaultUsers = new Map<String,Id>();
Privacy_Snapshot_Permission__mdt permission = null;
Set<String> countryList = new Set<String>();
List<User> usersList = new List<User>();
Id defaultOwnerId = null;
Set<String> profileSet = new set<String>();//Added as part of code optmization US#5997
Map<String,Id> userNameToIdMap = new Map<String,Id>();//Created for UK US #9437
List<Account> currentAccounts=[SELECT ID,Country__c,OwnerId,Owner_Profile__c,AccountSource 
FROM Account 
WHERE ID in:triggerNew];
List<ContentVersion> filesToInsert=new List<ContentVersion>();
TimeZone tz = UserInfo.getTimeZone();
TimeZone roTZ = Timezone.getTimeZone('Europe/Bucharest');

Map<String,List<User>> profileUserMap= new Map<String,List<User>>();

for(BAT_CountryRegionConfiguration__mdt neaCountryRegion : [select id,DeveloperName,BAT_Region__c from BAT_CountryRegionConfiguration__mdt]){
if(!String.isEmpty(neaCountryRegion.BAT_Region__c)) {
regionsSet.add(neaCountryRegion.BAT_Region__c);
}
}
//Changes done for Bug 4625 By Sudaif.        
for(Account accRec : currentAccounts){
if(!String.isEmpty(accRec.Country__c)){
countryList.add(accRec.Country__c);
}
}
//Removed countryList filter inorder to fetch DEEU records also
for(Privacy_Snapshot_Permission__mdt permissionRecord: [SELECT ID, MasterLabel, Document_Name__c, Owner_Profile__c, 
DeveloperName, BAT_DefaultUser__c FROM Privacy_Snapshot_Permission__mdt]){
countryPermissionMap.put(permissionRecord.MasterLabel, permissionRecord);
profileSet.add(permissionRecord.Owner_Profile__c);
}
//Added Profile_Name__c IN :profileSet condition in query US#5997
usersList = [SELECT Id,ProfileId,Country__c,BAT_Region__c,UserName,Name,Profile_Name__c 
FROM User 
WHERE (Country__c IN:countryList OR BAT_Region__c =:regionsSet ) AND IsActive=true AND Profile_Name__c IN :profileSet ORDER BY UserName];

for(User uRec: usersList){
if(!countryDefaultUsers.containsKey(uRec.Profile_Name__c)){
countryDefaultUsers.put(uRec.Profile_Name__c, uRec.Id);
}
userNameToIdMap.put(uRec.userName, uRec.Id);
}

try{
for(Account accRec: currentAccounts){
if(!String.isBlank(accRec.country__c)){
String countryStr;
countryStr = accRec.country__c;
//Added String to populate it with EU in case the account source is ecommerce Velo EU
String avalancheRegionStr = BAT_ConstantsUtility.EMPTY_STRING;
if(String.isNotBlank(accRec.AccountSource) && accRec.AccountSource == BAT_ConstantsUtility.EU_ACCOUNT_SOURCE){
avalancheRegionStr = BAT_ConstantsUtility.EU_REGION_SUFFIX;
}
countryStr = accRec.country__c + avalancheRegionStr;
if(countryPermissionMap.containsKey(countryStr)){
permission = countryPermissionMap.get(countryStr);
}
//FOR UNIT TEST PURPOSE
Blob pdfTestBody = blob.valueOf(BAT_ConstantsUtility.UNIT_TEST);
if(permission != null){
ContentVersion attach = new ContentVersion();
if(!String.isBlank(countryStr) && countryStr == BAT_ConstantsUtility.COUNTRY_RO){
tz = roTZ;
}
attach.Title = permission.Document_Name__c + '_' + DateTime.Now().AddSeconds(tz.getOffset(DateTime.Now()) / 1000); //Replace here as part of US:4052

PageReference page_pdf = Page.BAT_Privacy_Snapshot_PDF;
page_pdf.getParameters().put(BAT_ConstantsUtility.ID_PARAM, accRec.Id);
Page_pdf.getParameters().put(BAT_ConstantsUtility.TITLE_PARAM, attach.Title);
attach.versionData = !Test.isRunningTest() ? page_pdf.getContent() : pdfTestBody;
attach.FirstPublishLocationId = accRec.Id;
attach.PathOnClient = BAT_ConstantsUtility.FORWARD_SLASH + attach.Title + BAT_ConstantsUtility.PDF_EXTENSION;
attach.SharingPrivacy = BAT_ConstantsUtility.SHARING_PRIVACY;
if(networkId != null){
attach.NetworkId = networkId;
}
//Optimised for UK US #9437 To assign the defaultOwnerId to the Default_User from Metadata
if(String.isNotBlank(permission.BAT_DefaultUser__c) && userNameToIdMap.containsKey(permission.BAT_DefaultUser__c)){
defaultOwnerId = userNameToIdMap.get(permission.BAT_DefaultUser__c);
}
//Assigning first user as Default owner that is coming - No modifications in the logic here.
else if(countryDefaultUsers.containsKey(permission.Owner_Profile__c)){
defaultOwnerId = countryDefaultUsers.get(permission.Owner_Profile__c);
}
//Assign attachment's owner as account owner if permission metadata doesn't have a correct profile name.
else{
defaultOwnerId = accRec.OwnerId;
}
if(defaultOwnerId != null) {
attach.OwnerId = defaultOwnerId;
}
filesToInsert.add(attach);
}
}
}

//Added Null check before DML operation as part of ForceReviewer changes.
if(filesToInsert != null && !filesToInsert.isEmpty()){
insert filesToInsert;
}
}catch(Exception ex){
//#115521-April30th,2020 - Avoided SObject row does not allow errors. 
//Creating Apex log for the Exception
Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = BAT_ConstantsUtility.ATH_Class, Exception__c = ex.getMessage(),
Method_Name__c = BAT_ConstantsUtility.GENERATE_PRIVACY_SNAPSHOT_PDF);
insert apexLog;
}
} */
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : generateTaskForHyperCareBasic
* @returns       : void
* @params        : List<Account>,Map<Id,Account>
* @description   : [All Markets]Method to generate task for hyperCare Management from customer care profiles. 
The method runs only on configured countries on after insert/update of account
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
30.01.2019/Tejaswi Nissankula/For country BG,assign the task owner based on login user's
user type and profile.
19.04.2019/Tejaswi Nissankula/The owner for all HR hypercare tasks should be Integration 
user(Careline team): US12839
23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
27.10.2020/Eswar Chaturvedula/ Populating Country field for task creation.
07.01.2021/Akshata Rajmane/US#365821 : PL - D2C/Hostess - Hypercare Task creation logic update
03.02.2021/Rama Akella/US#103007: AZ- Updated logic to create Hyper Care tasks on after insert
15.02.2021/Osheen Sahajpal/ENH:Sprint-73:HRV:US#309143:Assigning owner with particular user type
*********************************************************************************************************/
    
    public void generateTaskForHyperCareBasic(List<Account> triggerNew, Map<Id,Account> triggerOldMap){
        Set<String> country_SET = new Set<String>();
        Map<String, Set<String>> countryToMetaData_MAP = new Map<String, Set<String>>();
        List<Task> taskToAssign= new List<Task>();
        //US#365821 : to store queue names from the metadata
        Set<String> setQueueName = new Set<String>();
        Map<Id,Recordtype> recordtypesMap=new Map<Id,RecordType>([SELECT ID,DeveloperName 
                                                                  FROM RecordType 
                                                                  WHERE SObjectType='Account']);
        
        Map<String,user> userNameMap=new Map<String,user>();
        Map<String, List<Account_HyperCare_Configuration__mdt>> hypercareMap = new Map<String,List<Account_HyperCare_Configuration__mdt>>();
        List<Account_HyperCare_Configuration__mdt> configRecords = new List<Account_HyperCare_Configuration__mdt>();
        Set<Id> userSet =  new Set<Id>();
        Set<string> userNameSet = new Set<string>();
        Map<Id,User> userMap = new Map<Id,User>();
        //get ID of 'Trialist' record type of Account
        ID trialistRecordTypeId  = recordTypeDevNameMap.get(BAT_ConstantsUtility.RECORDTYPE_TRAILLIST);
        for(Account acc : triggerNew){
            userSet.add(acc.OwnerId);
            country_SET.add(acc.country__c);//Added as part of 2798
        }
        
        //Added country_SET in query as part of code optmization US#5997
        for(Account_HyperCare_Configuration__mdt hyperCareconfs: [SELECT Account_RecordType__c, Account_Status__c,BAT_StatusAPIName__c,
                                                                  Assignee_Group_Name__c, Country__c, Owner_Profile__c, Passionate_Trial__c,
                                                                  Task_offset_days__c, Task_subject__c, Task_Description__c, Owner_User_Type__c,
                                                                  BAT_AssignToQueue__c,BAT_OffsetDateAPIName__c
                                                                  FROM Account_HyperCare_Configuration__mdt where Country__c IN: country_SET
                                                                  ORDER BY Task_offset_days__c
                                                                 ]){
                                                                     if(!String.isBlank(hyperCareconfs.Assignee_Group_Name__c)){
                                                                         userNameSet.add(hyperCareconfs.Assignee_Group_Name__c);
                                                                     }
                                                                     configRecords = hypercareMap.containsKey(hyperCareconfs.Country__c) ? hypercareMap.get(hyperCareconfs.Country__c) : new List<Account_HyperCare_Configuration__mdt>();
                                                                     configRecords.add(hyperCareconfs);
                                                                     hypercareMap.put(hyperCareconfs.Country__c, configRecords);
                                                                     //US#365821 : store queue names in the set from the metadata
                                                                     if(hyperCareconfs.BAT_AssignToQueue__c && hyperCareconfs.Assignee_Group_Name__c != null){
                                                                         setQueueName.add(hyperCareconfs.Assignee_Group_Name__c);
                                                                     }
                                                                 }
        for(user userRec: [SELECT ID, Username, user_type__c, IsActive FROM User WHERE Id IN: userSet OR Username IN: userNameSet]){
            userNameMap.put(userRec.Username, userRec);
            userMap.put(userRec.Id, userRec);
        }
        
        //US#365821 : query the queue using set of queuename and store this in map 
        map<String,QueueSobject> mapGroup = new map<String,QueueSobject>();
        if(setQueueName.size() > 0){
            for(QueueSobject g: [Select id,QueueId,queue.Name from QueueSobject where SobjectType =: BAT_ConstantsUtility.TASK_STR and queue.Name In: setQueueName]){
                mapGroup.put(g.queue.Name,g);
            }
        }
        //GET CONFIG FOR COUNTRY
        for(HyperCare_Management__mdt hm : [SELECT MasterLabel, Flow__c
                                            FROM HyperCare_Management__mdt
                                            WHERE MasterLabel IN : country_SET]) {
                                                if(countryToMetaData_MAP.containsKey(hm.MasterLabel)) {
                                                    countryToMetaData_MAP.get(hm.MasterLabel).add(hm.Flow__c);
                                                }
                                                else {
                                                    countryToMetaData_MAP.put(hm.MasterLabel, new Set<String>{hm.Flow__c});    
                                                }
                                            }
        //End Work Item 2798
        ID hyperCareAccountRecordTypeID;
        for(Account a: triggerNew){
            if(hypercareMap.containsKey(a.Country__c)){
                for (Account_HyperCare_Configuration__mdt ahc: hypercareMap.get(a.Country__c)){
                    if(ahc.Account_RecordType__c != null){
                        hyperCareAccountRecordTypeID =  recordTypeDevNameMap.get(ahc.Account_RecordType__c);
                    }
                    if(String.isNotBlank(ahc.BAT_StatusAPIName__c) && 
                       String.isNotBlank(String.valueOf(a.get(ahc.BAT_StatusAPIName__c))) && 
                       String.valueOf(a.get(ahc.BAT_StatusAPIName__c)).equalsIgnoreCase(ahc.Account_Status__c) &&
                       a.Trial_Information_Permission__c == true &&
                       a.Passionate_Trial_Check__c == ahc.Passionate_Trial__c &&
                       ahc.Account_RecordType__c != null &&
                       a.RecordTypeID == hyperCareAccountRecordTypeID){
                           
                           //Added Trial_Informationz_Permission__c,PersonDoNotCall,Task_offset_days__c and countryToMetaData_MAP conditions in IF loop as part of US#2798
                           //VSTS 263163 - Populating Country field for task creation
                           // Updated logic to execute on after Insert of Account
                           if((triggerOldMap == null && a.get(ahc.BAT_StatusAPIName__c) == BAT_ConstantsUtility.PROSPECT && a.RecordTypeId == trialistRecordTypeId) || 
                              (triggerOldMap != null &&
                               (triggerOldMap.get(a.Id).get(ahc.BAT_StatusAPIName__c) != a.get(ahc.BAT_StatusAPIName__c) ||
                                (triggerOldMap.get(a.Id).get(ahc.BAT_StatusAPIName__c) == a.get(ahc.BAT_StatusAPIName__c) &&
                                 a.Trial_Information_Permission__c != triggerOldMap.get(a.Id).Trial_Information_Permission__c && !a.PersonDoNotCall &&
                                 countryToMetaData_MAP.containsKey(a.Country__c) && countryToMetaData_MAP.get(a.Country__c).size() > 0 &&
                                 countryToMetaData_MAP.get(a.Country__c).contains(BAT_ConstantsUtility.HYPERCARE_MANAGEMENT_ADD_TASK) && 
                                 (a.get(ahc.BAT_OffsetDateAPIName__c) != null && (a.get(ahc.BAT_OffsetDateAPIName__c) != null && 
                                                                                  ahc.Task_offset_days__c >= Date.today().daysBetween(Date.valueOf(a.get(ahc.BAT_OffsetDateAPIName__c))))))))){
                                                                                      Task t = new Task();
                                                                                      t.Subject = ahc.Task_Subject__c;
                                                                                      t.ActivityDate = a.get(ahc.BAT_OffsetDateAPIName__c) == null ? Date.valueOf(a.CreatedDate) + Integer.valueOf(ahc.Task_offset_days__c) :Date.valueOf(a.get(ahc.BAT_OffsetDateAPIName__c))+ Integer.valueOf(ahc.Task_offset_days__c);
                                                                                      t.WhatId = a.Id;
                                                                                      t.BAT_Country__c = a.Country__c;
                                                                                      t.Description = ahc.Task_Description__c;
                                                                                      boolean isUserTypeAvailable = false;
                                                                                      //ENH:Sprint-73:HRV:US#309143:Assigning owner with particular user type
                                                                                      if((a.Country__c == BAT_ConstantsUtility.COUNTRY_BG || a.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_HR)) && ahc.Owner_User_Type__c != null){
                                                                                          isUserTypeAvailable = true;
                                                                                      }
                                                                                      //SJ-2509 Changes -- Start
                                                                                      //As part of US3056 added Owner_User_Type__c field in IF and ELSE IF loop from Account_HyperCare_Configuration__mdt custom metadata type to assign task owner based on user type of login user(Social seller) for Country BG
                                                                                      if(((isUserTypeAvailable 
                                                                                           && ahc.Owner_User_Type__c == userMap.get(a.OwnerId).user_type__c) 
                                                                                          || (a.Country__c != BAT_ConstantsUtility.COUNTRY_BG &&
                                                                                              a.Country__c != BAT_ConstantsUtility.COUNTRY_HR)) 
                                                                                         && ahc.Owner_Profile__c != null 
                                                                                         && ahc.Owner_Profile__c.containsIgnoreCase(a.Owner_Profile__c)
                                                                                         && userMap.get(a.OwnerId).IsActive && !ahc.BAT_AssignToQueue__c) {
                                                                                             t.OwnerId = a.OwnerId;
                                                                                             taskToAssign.add(t);
                                                                                             
                                                                                         }else if(((isUserTypeAvailable && ahc.Owner_User_Type__c != userMap.get(a.OwnerId).user_type__c
                                                                                                    && ahc.Owner_Profile__c != null && ahc.Owner_Profile__c.containsIgnoreCase(a.Owner_Profile__c)) 
                                                                                                   || ((ahc.Owner_Profile__c == null || 
                                                                                                        !ahc.Owner_Profile__c.containsIgnoreCase(a.Owner_Profile__c))&& 
                                                                                                       ahc.Assignee_Group_Name__c != null) ||  !userMap.get(a.OwnerId).IsActive)
                                                                                                  && userNameMap.get(ahc.Assignee_Group_Name__c)!=null
                                                                                                  && userNameMap.get(ahc.Assignee_Group_Name__c).IsActive && !ahc.BAT_AssignToQueue__c){
                                                                                                      
                                                                                                      t.OwnerId = userNameMap.get(ahc.Assignee_Group_Name__c).Id;
                                                                                                      taskToAssign.add(t);
                                                                                                      
                                                                                                  }
                                                                                      //else if will assign the task to queue
                                                                                      else if(ahc.BAT_AssignToQueue__c){
                                                                                          t.OwnerId = mapGroup.get(ahc.Assignee_Group_Name__c).QueueId;
                                                                                          taskToAssign.add(t);
                                                                                      }
                                                                                      //SJ-2509 Changes -- End
                                                                                  }
                       }
                }
            }
        }
        try{
            //Added Null check before DML operation as part of ForceReviewer changes.
            if(taskToAssign != null && !taskToAssign.isEmpty()){
                insert taskToAssign;
            }
        }catch(Exception ex) {for(Account accRecord: triggerNew){
            system.debug('++ex.getMessage() '+ex.getMessage());
            system.debug('++ex '+ex);
            accRecord.addError(ex.getMessage());
        }
                             }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : checkAccountStatusUpdate
* @returns       : void
* @params        : List<Account>,Map<Id,Account>
* @description   : [All Markets]If Source is eCommerce and old status is consumer, new value is prospect then 
update status as Consumer.Method called from onBeforeUpdate of Account.
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
*                  21.06.2019/Ushabala Kanduru/Vape Status, THP status, Oral Status cannot be changed to Prospect
*                  once it is Consumer
*********************************************************************************************************/
    
    public void checkAccountStatusUpdate (List<Account> accounts, Map<Id, Account> accountMap){
        
        //process accounts 
        for(Account acc: accounts){ 
            //US#530277 : Bypass this method for Retailer record Type
            if(acc.RecordTypeId != retailerRecordTypeId){
                //if source is eCommerce and old value is Consumer and if we get Prospect as Source
                //Then update it as Consumer
                if(!String.isBlank(acc.AccountSource) && 
                   acc.AccountSource.equalsIgnoreCase(BAT_ConstantsUtility.ATH_ECOMMERCE) && 
                   !String.isBlank(acc.Status__c) && 
                   accountMap.get(acc.Id).Status__c == BAT_ConstantsUtility.ATH_CONSUMER && 
                   acc.Status__c == BAT_ConstantsUtility.ATH_PROSPECT && accountMap.get(acc.Id).Country__c!=BAT_ConstantsUtility.IT){
                       acc.Status__c = BAT_ConstantsUtility.ATH_CONSUMER;  
                   }
                //Added as part of Bug:30446-If the old value of BAT_VapeStatus__c/BAT_OralStatus__c/BAT_THPStatus__c is consumer 
                //and it cannot be changed to Prospect once it is Consumer
                if(!String.isBlank(acc.BAT_VapeStatus__c) && 
                   accountMap.get(acc.Id).BAT_VapeStatus__c == BAT_ConstantsUtility.ATH_CONSUMER && 
                   acc.BAT_VapeStatus__c == BAT_ConstantsUtility.ATH_PROSPECT ){
                       acc.BAT_VapeStatus__c = BAT_ConstantsUtility.ATH_CONSUMER;  
                   }
                if(!String.isBlank(acc.BAT_OralStatus__c) && 
                   accountMap.get(acc.Id).BAT_OralStatus__c == BAT_ConstantsUtility.ATH_CONSUMER && 
                   acc.BAT_OralStatus__c == BAT_ConstantsUtility.ATH_PROSPECT ){
                       acc.BAT_OralStatus__c = BAT_ConstantsUtility.ATH_CONSUMER;  
                   }
                if(!String.isBlank(acc.BAT_THPStatus__c) && 
                   accountMap.get(acc.Id).BAT_THPStatus__c == BAT_ConstantsUtility.ATH_CONSUMER && 
                   acc.BAT_THPStatus__c == BAT_ConstantsUtility.ATH_PROSPECT ){
                       acc.BAT_THPStatus__c = BAT_ConstantsUtility.ATH_CONSUMER;  
                   }
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : updateAccountBillingCountry
* @returns       : void
* @params        : List<Account>,Map<Id,Account>
* @description   : [RO,KZ]If Source is not eCommerce and billing country is not equal to country on Account
*                  Copy the Country to Billing Country.Method called from onBefore Insert/Update of Account.
* @changeHistory : 02.03.2018/Neha Lund/Created the method
*********************************************************************************************************/
    
    public void updateAccountBillingCountry (List<Account> accounts,Map<Id,Account> oldAccountMap){
        //process accounts 
        for(Account acc: accounts){      
            //if source is not eCommerce and Billing Country is not same as Country 
            if( (String.isBlank(acc.AccountSource) || !acc.AccountSource.equalsIgnoreCase(BAT_ConstantsUtility.ATH_ECOMMERCE))  &&
               acc.BillingCountry != acc.Country__c && BAT_ConstantsUtility.countries.contains(acc.Country__c)){  
                   acc.BillingCountry = acc.Country__c ;
               }
            //Added the below check to exclude MX - Bug #56860 /Prince Chawla/30Oct,2019.
            if(acc.IsPersonAccount && !acc.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MX_STR)){
                //[AA - 20180515 - START] Introducting CAP field to simplify Social Seller apps
                if((acc.Postal_Code__c != null 
                    && acc.BillingPostalCode == null) 
                   || (oldAccountMap!=null 
                       && acc.Postal_Code__c != oldAccountMap.get(acc.id).Postal_Code__c 
                       && acc.BillingPostalCode == oldAccountMap.get(acc.id).BillingPostalCode)){
                           acc.BillingPostalCode = acc.Postal_Code__c;
                       }
                
                if((acc.Postal_Code__c == null 
                    && acc.BillingPostalCode != null) 
                   || (oldAccountMap != null
                       && acc.BillingPostalCode != oldAccountMap.get(acc.id).BillingPostalCode 
                       && acc.Postal_Code__c == oldAccountMap.get(acc.id).Postal_Code__c)){
                           //Added for Bug 38704 to restrict the Billing Postal code to 10 digits
                           if(acc.BillingPostalCode.length() > 10){ acc.addError(Label.BAT_BillingPostalCodeErrorMessage);
                                                                  }
                           acc.Postal_Code__c = acc.BillingPostalCode;
                       }
            }
            //[AA - 20180515 - END]
            
        } 
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : removeNonConvertedDuplicateLead
* @returns       : void
* @params        : List<Account>,Map<ID,Account>
* @description   : [All Markets]If account is being created with the same email as of Lead then account 
creation shouldn't error out instead should be created and lead will be deleted.
Method called from onBeforeInsert of Account.
* @changeHistory : 02.03.2018/Francesco Imperioli/Created the method
: US 10154 02.01.2019/Sudaif Haider/Created Custom Metadata for Store Account Source to avoid hard coding.
:4.08.1993/Tejaswi Nissankula/[UA,KZ]When a Integration user/Non Integration user is trying to insert an 
account with mobile number,brand house and if we have a lead in system with same mobile number and brand house 
as account then throw error to non intergration user to convert lead instead of creating new account where as 
for integration user update the status of lead to "Converted".[US37833]
:12.09.2019/Tejaswi Nissankula/Removed AccountSourceConfiguration custom metadata query and moved to 
constructor.
:09.10.2019/Abhishek Kashyap/Updated the method to populate Related Lead field on Account and to update status
field on lead based on brand
:14.10.2019/Abhishek Kashyap/BUG-53290, updating brand specific status fields on lead when an account with 
different brand house but with same mobile is inserted.
:18.10.2019/ Varun Kochar / ES :  Sprint 2 : US#48414 Added Logic to convert lead
:25.10.2019/Satya Nalluri/Bug-48823, updated method to get account irrespective of case and added null check 
before account creation and lead conversion.
:16.01.2020/Tejaswi Nissankula/As part of MX Vend Integration Bug#76248,Auto Lead conversion in salesforce should happen when user create an Account from MX Vend with Account Source as Own Kiosks and Login user is MuleSoft Integration user.
:23/01/2020/Satya Nalluri/Bug-78625 Updating the generic permission to false in order to prevent duplicate emails triggered from both lead and account during Marketing Cloud journey for UK market
:07/04/2020/Tejaswi Nissankula/[SE]#US#110377 Set the BAT_ExternalSubscriberId4__c on account duirng lead conversion
: 20/05/2020/ Satya Nalluri/ //Bug #128431 Added null check for personEmail to handle null pointer in case if the Accounts are being loaded by Integration user or system administrator whith out populating person email 
16/03/2020/Akshaya Sarvesh/Modified as part of Force reviewer violation Removing Hardcoded Strings.Accounts are being loaded by Integration user or system administrator whith out populating person email
14.04.2020/Tejaswi Nissankula/KZ-Glo:US#107514 When THPStatus of Glo lead is 'Subscriber' then set newly inserted different brandhouse(Velo) acc's THPStatus value to 'Subscriber'.
26.05.2020/Tejaswi Nissankula/ ES-Glo:US#120789 : Added logic to flow the external subscriber 2 data from Glo lead to glo account when acc is created/updated from eCommerce-Glo
:15/07/2020 /Tejaswi Nissankula/ID : US#141111: Added logic to flow External Subscriber 4 Id from lead to account on auto lead conversion process .Setting the Velo consent flags to false on auto lead conversion process.
:29.07.2020/Roopa N/[ID] : Bug#249597: Added logic to update Account Consent Fields to "False" when Lead consent fields are "True" while lead conversion process
:16/10/2020/Sandeep Joshi/US#287199: Added Country check for ZA in two IF Loops so that code will run as expected for South Africa as well.
[ZA] 17.10.2020/ Sandeep Joshi/ US# 287199 : added IF loop to check lead Country if ZA then call method convertSubscriberToAccount for stamping required lead field values to respective account field values.
: 11/11/2020/Rama Akella/US#317429: Added FR country check to make the automatic lead conversion for duplicate leads logic work for all FR profiles. 
:11/11/2020/Rama Akella/Bug#326148/FR/Consents are set to false for a converted lead 
21-Oct-2020/Roopa N/US#290302/ CZ - When a Non Integration user is trying to insert an account with mobile number and if we have a lead in system with same mobile number then throw error to non integration user to convert lead instead of creating new account
:23/11/2020/Rama Akella/Bug#333082/FR/Added FR country check to run the logic to map converted lead fields to Account fields
:30/11/2020/Souvik Dinda/US#326287- Corrected the ATH_COMMA String with COMMA String from BAT_ConstantsUtility as it was introducing an extra space which was impacting the contains check when checked from a Set of values.
:15.02.2021/Akshata Rajmane/US#410470 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic
:05.03.2021/Akshata Rajmane/Bug #431672 :GR - Lead not getting converted
:8:03:2021 /Akshata Rajmane/GR - Lead conversion based on updated duplication logic (email OR phone)
:13.04.2021 /Dipika / #449349 : Lead Conversion Logic added condition for PL 
//25.05.2021/ Allada Yeshwanth/ US: #525000/ For DE Market Added isBefore Check before changing the owner of the lead and account. Changing the owner of the lead to current user if the lead owner is queue
:20 May,2021/Abhishek Kashyap/US-451955-ES - Reach Tobbaconist Spain glo
: 15.06.2021 / Allada Yeshwanth / #563957 Optimization Activity / Added Entry Check to filter the records only if the duplicate identifier has been changed
13.07.2021/Idrees Ali/Sprint-82: US #443357:Lead Conversion - Mark Consent Fields as Opt Out once Lead is Converted and Account is created; Removed manual consent opt out checks for FR and ID
28.09.2021/ Akshata Rajmane/ Added MY country check to map converted lead fields on Account
US: #708711 // Allada Yeshwanth // add logic to give points for IT retailers whose QR code leads are auto converte
// US# 708320 // Allada Yeshwanth // added logic to change the owner of lead when getting converted by POS AGET OR GLO Store users of IT. This is to Avoid Error from Database.convertLead
// 01.12.2021 / Turbasu Ghosh // US : #753842 // HR - glo.hr Integration - Scenario 1: New Consumer (glo.hr --> CRM)  // Lead conversion logic to be added to work on Mobile match  for HR
// 13.01.2022/ Allada yeshwanth/ BUG : #864204: -- adding SK account to setPhoneOnlyCountries to bypass error.
// 13.02.2022/Idrees Ali/US#893500 : Added PT country check to bypass retain account owner
// 13 Sep 2022/ Praveen/US#1122532 / SI - Technical Setup - Duplicate Rule Logic on Person Account
*********************************************************************************************************/
    public void removeNonConvertedDuplicateLead(List<Account> accounts,Map<ID,Account> oldAccountMap){
        Map<String, Account> integratedAccounts = new Map<String, Account>();
        Map<String, Account> nonIntegratedAccounts = new Map<String, Account>();
        Set<String> emailIDs = new Set<String>();
        Set<String> countries = new Set<String>();
        Set<String> setEmailOnlyCountries = new Set<String>();//[PL] 25.06.2020/ Mallik Balla/ US#176027 : Set which contains the leads to be fetched only on email basis
        Set<String> setPhoneOnlyCountries = new Set<String>();//[CZ] 06.11.2020/ Allada Yeshwanth/ US#301020 : To bypass Lead duplicate rule with Same Email
        Set<String> setEmailAndBrandCountries = new Set<String>();//[PL] 25.06.2020/ Mallik Balla/ US#176027 : Set which contains the leads to be fetched on email and bradn basis
        Set<String> brandHouseSet = new Set<String>();
        Set<String> uccabCountrySet = new Set<String>();
        Map<Id,Lead> mapLeadsToDelete = new Map<Id,Lead>(); //UK US #12067 
        Map<Id,Lead> mapLeadsToConvert = new Map<Id,Lead>();
        String leadFieldsAPI = BAT_ConstantsUtility.EMPTY_STRING;
        String queryString = BAT_ConstantsUtility.EMPTY_STRING;
        // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts -
        String brandHouseCondition=BAT_ConstantsUtility.EMPTY_STRING;
        String countrycondtn='';
        // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic ends -
        //[PL] 25.06.2020/ Mallik Balla/ US# 176027 - created variables to store PL leads and accounts -- starts
        List<Account> lstProductInterestAccs = new List<Account>();
        Set<ID> setProductInterestLeads = new Set<ID>();
        Map<String, Account> uniquePhnNumAccounts = new Map<String, Account>(); //Added for US#290302
        Set<String> uniquePhnNumCountrySet = new Set<String>(); //Added for US#290302
        Map<String, Account> uniqueEmailAccounts = new Map<String, Account>(); //US#410470 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic
        String leadQueryString = BAT_ConstantsUtility.EMPTY_STRING; //Added for US#290302
        //[PL] 25.06.2020/ Mallik Balla/ US# 176027 - created variables to store PL leads and accounts -- ends
        
        
        //Added below Set - To include few more eCommerce Account Source for Account.
        
        //Added below query to fetch the fields from MetaData dynamically.
        for(BAT_LeadConversionFieldConfiguration__mdt leadFields: BAT_LeadConversionFieldConfiguration__mdt.getAll().values()){
            leadFieldsAPI += leadFields.BAT_LeadFieldAPIName__c + BAT_ConstantsUtility.COMMA_STR;
        }
        //parse through accounts
        for(Account acc: accounts){
            // String accSource = acc.AccountSource; removed as part of code optimization US#5997 and used acc.AccountSource directly in if check 
            //Replaced accSourceSet with accSourceUserNameMap to validate the AccountSource value with Login user for MX.For remaining countries UserName will not be considered.
            //As part of MX Vend Integration Bug#76248,Auto Lead conversion in salesforce should happen when user create an Account from MX Vend with Account Source as Own Kiosks and Login user is MuleSoft Integration user.
            //Bug #128431 Added null check for personEmail to handle null pointer in case if the Accounts are being loaded by Integration user or system administrator whith out populating person email 
            //US#317429 Added FR country check to bypass account source validation
            if(!accSourceUserNameMap.isEmpty()
               && acc.country__c != BAT_ConstantsUtility.COUNTRY_UA 
               && acc.country__c != BAT_ConstantsUtility.COUNTRY_KZ
               //US#530277 : Bypass this method for Retailer record Type
               && acc.RecordTypeId != retailerRecordTypeId
               && ((Trigger.isInsert &&
                    (String.isNotBlank(acc.AccountSource) &&
                     String.isNotBlank(acc.PersonEmail) && 
                     ((accSourceUserNameMap.containsKey((acc.AccountSource).toLowercase()) &&
                       accSourceUserNameMap.get((acc.AccountSource).toLowercase())!= null &&
                       (string.isBlank(accSourceUserNameMap.get((acc.AccountSource).toLowercase()).BAT_UserName__c) || (string.isNotBlank(accSourceUserNameMap.get((acc.AccountSource).toLowercase()).BAT_UserName__c) &&
                                                                                                                        accSourceUserNameMap.get((acc.AccountSource).toLowercase()).BAT_UserName__c == UserInfo.getUserName()))) || (accSourceUserNameMap.containsKey((acc.Country__c).toLowercase()+' '+(acc.AccountSource).toLowercase())&&
                                                                                                                                                                                                                                     accSourceUserNameMap.get((acc.Country__c).toLowercase()+' '+(acc.AccountSource).toLowercase()).BAT_UserName__c == UserInfo.getUserName())))) ||
                   (Trigger.isUpdate && acc.Convert__c == false &&
                    String.isNotBlank(acc.Last_Modified_Source__c) &&
                    accSourceUserNameMap.containsKey((acc.Last_Modified_Source__c).toLowercase()) &&
                    accSourceUserNameMap.get((acc.Last_Modified_Source__c).toLowercase())!= null &&
                    (string.isBlank(accSourceUserNameMap.get((acc.Last_Modified_Source__c).toLowercase()).BAT_UserName__c) || (string.isNotBlank(accSourceUserNameMap.get((acc.Last_Modified_Source__c).toLowercase()).BAT_UserName__c) &&
                                                                                                                               accSourceUserNameMap.get((acc.Last_Modified_Source__c).toLowercase()).BAT_UserName__c == UserInfo.getUserName()))))){
                                                                                                                                   //add email of the account
                                                                                                                                   emailIDs.add(acc.PersonEmail);
                                                                                                                                   countries.add(acc.Country__c);
                                                                                                                                   // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts -
                                                                                                                                   countrycondtn=acc.Country__c;
                                                                                                                                   // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic ends -
                                                                                                                                   ////[PL] 25.06.2020/ Mallik Balla/ US#176027 : -- adding the value to the country sets --  starts
                                                                                                                                   // 13.01.2022/ Allada yeshwanth/ BUG : #864204: -- adding SK account to setPhoneOnlyCountries to bypass error.
                                                                                                                                   if(System.Label.BAT_EmailOnlyConfigCountries_PL.split(BAT_ConstantsUtility.SEMI_COLON).contains(acc.Country__c)){
                                                                                                                                       setEmailOnlyCountries.add(acc.Country__c);
                                                                                                                                   }else if(acc.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || acc.Country__c == BAT_ConstantsUtility.COUNTRY_SK){
                                                                                                                                       setPhoneOnlyCountries.add(acc.Country__c);
                                                                                                                                   }else{
                                                                                                                                       setEmailAndBrandCountries.add(acc.Country__c);
                                                                                                                                   }
                                                                                                                                   ////[PL] 25.06.2020/ Mallik Balla/ US#176027 : -- adding the value to the country sets --  ends
                                                                                                                                   integratedAccounts.put(acc.PersonEmail.toUpperCase(), acc);
                                                                                                                                   /* 14th Feb,2021 : Akshata : US #410472 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic
removed the formation of brand set for GR to remove brand dependency in lead query*/
                                                                                                                                   if(acc.Brand_House__c != null && acc.Country__c != BAT_ConstantsUtility.COUNTRY_GR && acc.Country__c != BAT_ConstantsUtility.COUNTRY_FR){
                                                                                                                                       //Added split to cover the account dual brand scenario
                                                                                                                                       List<string> brandHouseSubSet = acc.Brand_House__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON);
                                                                                                                                       brandHouseSet.addAll(brandHouseSubSet);
                                                                                                                                   }
                                                                                                                               }
            
            //Added as part of US37833
            //added as SI part of #1122532
            else if((String.isBlank(acc.AccountSource) || 
                     !BAT_Utilities.containsIgnoreCaseCheck(accSourceSet,acc.AccountSource)) &&
                    (acc.Country__c == BAT_ConstantsUtility.COUNTRY_UA || 
                     acc.Country__c == BAT_ConstantsUtility.COUNTRY_KZ || 
                     acc.Country__c == BAT_ConstantsUtility.COUNTRY_AL ||
                     acc.Country__c == BAT_ConstantsUtility.COUNTRY_BA ||
                     acc.Country__c == BAT_ConstantsUtility.COUNTRY_MK ||
                     acc.country__c == BAT_ConstantsUtility.COUNTRY_SI) && 
                    (oldAccountMap == null || 
                     (oldAccountMap != null && 
                      (acc.PersonMobilePhone != oldAccountMap.get(acc.id).PersonMobilePhone || 
                       acc.Brand_House__c != oldAccountMap.get(acc.id).Brand_House__c) &&
                      (string.isBlank(acc.Last_Modified_Source__c) || (string.isNotBlank(acc.Last_Modified_Source__c) &&
                                                                       !BAT_Utilities.containsIgnoreCaseCheck(accSourceSet,acc.Last_Modified_Source__c))) && user != null &&
                      string.isNotBlank(user.BAT_Brand__c) &&
                      user.BAT_Brand__c.contains(string.valueOf(acc.Brand_House__c))))){
                          nonIntegratedAccounts.put(acc.PersonMobilePhone,acc);
                          uccabCountrySet.add(acc.Country__c);
                          // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts -
                          countrycondtn=acc.Country__c;
                          // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic ends -
                      }//End of US37833
            // Added as part of US#290302
            //28.10.2020/Allada Yeshwanth/US:300982/Added Retailer with device bypass
            /* 14th Feb,2021 : Akshata : US #410472 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic
added condition for GR 
11.03.2021 / Akshata Rajmane / #bug 443449 :Error during Lead conversion for the Flagship profile 
added null check for person mobile phone*/
            /*13.04.2021 /Dipika / #449349 : Lead Conversion Logic
added condition for PL */
            //21.06.21 / Allada Yeshwanth / #538696 / reverting the #449349 changes
            // 04.10.21 / Allada Yeshwanth / #709734 / Adding Mobile Auto Conversion for RS
            // 01.12.2021 / Turbasu Ghosh // US : #753842 // HR - glo.hr Integration - Scenario 1: New Consumer (glo.hr --> CRM)  // Lead conversion logic to be added to work on Mobile match  for HR
            //US#530277 : Bypass this method for Retailer record Type
            else if((acc.RecordTypeId != retailerRecordTypeId) && (String.isBlank(acc.AccountSource) || 
                                                                   !BAT_Utilities.containsIgnoreCaseCheck(accSourceSet,acc.AccountSource)) &&
                    (((acc.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || acc.Country__c == BAT_ConstantsUtility.COUNTRY_RS) && 
                      ((oldAccountMap == null && user.profile.Name != BAT_ConstantsUtility.RETAILERWITHDEVICECZ) || 
                       (oldAccountMap != null && 
                        acc.PersonMobilePhone != oldAccountMap.get(acc.id).PersonMobilePhone
                        && user != null && user.profile.Name != BAT_ConstantsUtility.RETAILERWITHDEVICECZ &&
                        string.isNotBlank(user.BAT_Brand__c))))|| acc.Country__c == BAT_ConstantsUtility.COUNTRY_GR )){
                            // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts - 
                            countrycondtn=acc.Country__c; 
                            // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic ends -
                            if(acc.PersonMobilePhone != null)
                            {
                                uniquePhnNumAccounts.put(acc.PersonMobilePhone,acc);
                            }
                            uniquePhnNumCountrySet.add(acc.Country__c);
                            if(acc.Country__c == BAT_ConstantsUtility.COUNTRY_GR)
                            {
                                uniqueEmailAccounts.put(acc.PersonEmail,acc);
                            }
                            
                        }//End of US#290302
        }
        //Added as part of US37833
        //[UA,KZ]When a non Integration user is trying to insert an account and if we have a lead in system with same mobile number and brand house as account then user will get error to convert lead instead of creating new account.
        if(!nonIntegratedAccounts.isEmpty()){
            set<string> phnNumberSet = nonIntegratedAccounts.keySet();
            queryString = BAT_ConstantsUtility.LEAD_CONVERSION_QUERY;
            List<Lead> nonIntegratedleadList = new List<Lead>();
            if( phnNumberSet != null){
                nonIntegratedleadList = Database.query(queryString);
            }
            if(!nonIntegratedleadList.isEmpty()){
                for(lead rec : nonIntegratedleadList){
                    //Added as part of US37833
                    Account accLocal = nonIntegratedAccounts.get(rec.MobilePhone);
                    if((rec.country__c == BAT_ConstantsUtility.COUNTRY_UA || rec.country__c == BAT_ConstantsUtility.COUNTRY_KZ) && 
                       !String.isblank(rec.Brand_House__c) && string.valueOf(accLocal.Brand_House__c).contains(string.valueOf(rec.Brand_House__c))){
                           accLocal.addError(rec.Brand_House__c+BAT_ConstantsUtility.SINGLE_SPACE+Label.BAT_LeadAlreadyExistConvertIt);
                       }
                    //added as SI part of #1122532
                    if((rec.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_SI) || rec.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_AL) || rec.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_BA) || rec.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_MK)) && !String.isblank(rec.Brand_House__c)){
                        accLocal.addError(rec.Brand_House__c+BAT_ConstantsUtility.SINGLE_SPACE+Label.BAT_LeadAlreadyExistConvertIt);
                    }
                    //14.10.2019/Abhishek Kashyap/BUG-53290, updating brand specific status fields on lead when an account with different brand house but with same mobile is inserted.
                    else if(Trigger.isBefore 
                            && accLocal != null
                            && string.isNotBlank(accLocal.Brand_House__c) 
                            && string.isNotBlank(rec.Brand_House__c)
                            && !string.valueOf(accLocal.Brand_House__c).contains(string.valueOf(rec.Brand_House__c))){
                                If(rec.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)){
                                    if(rec.BAT_THPStatus__c == BAT_ConstantsUtility.STANDARD_LEAD_STR){
                                        accLocal.BAT_THPStatus__c = BAT_ConstantsUtility.STANDARD_LEAD_STR;
                                    }
                                    //When THPStatus of Glo lead is 'Subscriber' then set newly inserted different brandhouse(Velo) acc's THPStatus value to Subscriber as part of KZ#US#107514 by Tejaswi
                                    else if(rec.Country__c == BAT_ConstantsUtility.COUNTRY_KZ && rec.BAT_THPStatus__c == BAT_ConstantsUtility.ORAL_VYPE_STATUS){
                                        accLocal.BAT_THPStatus__c = BAT_ConstantsUtility.ORAL_VYPE_STATUS;
                                    }
                                }
                                else{
                                    accLocal.BAT_OralStatus__c = BAT_ConstantsUtility.STANDARD_LEAD_STR;
                                }
                            }
                }
            }
            
        }//End of US37833
        // Added as part of US#290302
        /*14th Feb,2021 : Akshata : US #410472 : GR Vuse - Technical Setup - Multi-Brand Lead Conversion Logic
added condition for GR 
11.03.2021 / Akshata Rajmane / #bug 443449 :Error during Lead conversion for the Flagship profile 
*/
        if(!uniquePhnNumAccounts.isEmpty() || !uniquePhnNumAccounts.isEmpty()){
            SET<String> emailSet = uniqueEmailAccounts.keySet();
            set<string> mobileNumberSet = uniquePhnNumAccounts.keySet();
            if(uniquePhnNumCountrySet.contains(BAT_ConstantsUtility.COUNTRY_GR) && !emailSet.isEmpty())
            {
                leadQueryString = BAT_ConstantsUtility.NONCONVERTED_UNIQUE_MOBILE_EMAIL_LEAD_QUERY;
            }
            else{
                leadQueryString = BAT_ConstantsUtility.NONCONVERTED_LEAD_QUERY;
            }
            List<Lead> uniquePhnNumleadList = new List<Lead>();
            if( mobileNumberSet != null){
                uniquePhnNumleadList = Database.query(leadQueryString);
            }
            if(!uniquePhnNumleadList.isEmpty()){
                for(lead ldRec : uniquePhnNumleadList){
                    Account dupAccount = uniquePhnNumAccounts.get(ldRec.MobilePhone);
                    /* 8:03:2021 /Akshata Rajmane/GR - Lead conversion based on updated duplication logic (email OR phone) */
                    if(ldRec.country__c == BAT_ConstantsUtility.COUNTRY_CZ || ((ldRec.country__c == BAT_ConstantsUtility.COUNTRY_PL || ldRec.country__c == BAT_ConstantsUtility.COUNTRY_GR) && dupAccount.Convert__c == false)){
                        dupAccount.addError(Label.BAT_LeadAlreadyExistConvertIt);
                    }
                }
            }  
        }// End of US#290302
        if(!integratedAccounts.isEmpty()){
            //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : fetching the integration user only if it's not already fetched before to assign ot to the owner of the account.
            if(setEmailOnlyCountries.contains(BAT_ConstantsUtility.COUNTRY_PL)
               && integrationUserID == null){
                   for(User intUser : [SELECT ID 
                                       FROM User 
                                       WHERE username LIKE :BAT_ConstantsUtility.STR_MULESOFT_INTEGRATION_USER_PL LIMIT 1]){
                                           integrationUserID = intUser.ID;
                                       }
               }
            queryString = BAT_ConstantsUtility.BLANK;
            queryString = BAT_ConstantsUtility.ATH_LEADQUERY1;
            List < Schema.FieldSetMember > leadFields = new List < Schema.FieldSetMember > ();
            List < Schema.FieldSetMember > accountFields = new List < Schema.FieldSetMember > ();
            
            leadFields = SObjectType.Lead.FieldSets.BAT_LeadIntegrationMapping.getFields();
            for(Schema.FieldSetMember fld: leadFields) {
                queryString += fld.getFieldPath() + BAT_ConstantsUtility.COMMA_STR;
            }
            //[PL] 25.06.2020/ Mallik Balla/ US# 176027 :  Refactored the code as duplicate field is being queried for leads, so adding a check before adding the leadFieldsAPI fields directly
            if(String.isNotEmpty(leadFieldsAPI)){
                for(String strLeadAPIField : leadFieldsAPI.split(BAT_ConstantsUtility.COMMA_STR)){
                    if(!queryString.contains(strLeadAPIField)){
                        queryString += strLeadAPIField+BAT_ConstantsUtility.COMMA_STR;
                    }
                }
            }
            /*Ends-- ExternalSubscriberId fields for UK US #12067*/
            queryString += BAT_ConstantsUtility.ATH_LEADQUERY2;
            queryString += BAT_ConstantsUtility.ATH_LEADEMAILCLAUSE + ': emailIDs';
            //[PL] 25.06.2020/ Mallik Balla/ US#176027 : Modified the query to include email only scenario -- starts
            queryString += BAT_ConstantsUtility.ATH_LEADEMAILCOUNTRYCLAUSE + ': setEmailOnlyCountries';
            queryString += BAT_ConstantsUtility.ATH_LEADEMAILBRANDCOUNTRYCLAUSE + ': setEmailAndBrandCountries';
            // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts -
            brandHouseCondition ='(';
            if(!brandHouseSet.isEmpty()){
                if(string.isNotBlank(countrycondtn) && countrycondtn == BAT_ConstantsUtility.COUNTRY_SE){
                    for (String brand : brandHouseSet) {
                        brandHouseCondition += '\'' + String.escapeSingleQuotes(brand) + '\',';
                    }
                    brandHouseCondition =brandHouseCondition.removeEnd(',') +')'  ;
                    queryString += BAT_ConstantsUtility.ATH_LEADBRANDCLAUSEINCLUDES + brandHouseCondition  + BAT_ConstantsUtility.ATH_LEADClOSEBRACKETS;
                }
                else{
                    queryString += BAT_ConstantsUtility.ATH_LEADBRANDCLAUSE  + ': brandHouseSet';
                    queryString += BAT_ConstantsUtility.ATH_LEADClOSEBRACKETS;
                }
            }
            // Bug 1625729 US1584186- SE/DK- Technical Setup - Lead Conversion Logic starts -
            
            else{
                queryString += BAT_ConstantsUtility.ATH_LEADClOSEBRACKETS;
            }
            //[PL] 25.06.2020/ Mallik Balla/ US#176027 : Modified the query to include email only scenario -- ends
            queryString += BAT_ConstantsUtility.ATH_LEADCONVERTEDCLAUSE;
            List<Lead> leadList = new List<Lead>();
            leadList = Database.query(queryString);
            Account acc;
            //List<Lead> leadListToUpdate = new List<Lead>();
            Id convertedLeadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('Converted').getRecordTypeId();
            if(!leadList.isEmpty()){
                set<string> duplicateAccSet = new set<string>();
                //Added account query to find any account exist with same email before inserting.
                if(Trigger.isBefore && Trigger.isInsert){
                    for(Account accRec: [select PersonEmail from Account 
                                         where Country__c!= null AND 
                                         Country__c =:countries AND 
                                         PersonEmail!=null AND 
                                         PersonEmail =: emailIDs]){
                                             duplicateAccSet.add(accRec.PersonEmail.toUpperCase());
                                         }
                }
                accountFields = SObjectType.Account.FieldSets.BAT_AccountIntegrationMapping.getFields();
                for(Lead ld: leadList){
                    ld.RecordTypeId = convertedLeadRecordTypeId;
                    acc =  integratedAccounts.get(ld.Email.toUpperCase());
                    //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : populate PL accounts and leads
                    //[ZA] 17.10.2020/ Sandeep Joshi/ US# 287199 : added IF loop to check lead Country if ZA then call 
                    //method convertSubscriberToAccount for stamping required lead field values to respective account field values.
                    if(ld.Country__c != null
                       && ld.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ZA) ){
                           if(Trigger.isInsert && Trigger.isBefore){
                               BAT_Utilities.convertSubscriberToAccount(acc, ld,BAT_ConstantsUtility.COUNTRY_ZA);
                           }
                       }
                    if(ld.Country__c != null
                       && ld.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_PL)){
                           lstProductInterestAccs.add(acc);
                           setProductInterestLeads.add(ld.ID);
                           //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Update Account records on before update of Account records
                           if(Trigger.isInsert && Trigger.isBefore){
                               BAT_Utilities.convertSubscriberToAccount(acc, ld,BAT_ConstantsUtility.COUNTRY_PL);
                           }
                       }//PL
                    //09.10.2019/Abhishek Kashyap/BUG - 49454, Bypassing duplicate rule on before events to facilitate account creation and lead conversion
                    //Add duplicateAccount check to avoid creating of duplicate account record with same email. 
                    if(acc != null){
                        if(Trigger.isBefore && 
                           (Trigger.isUpdate || 
                            (Trigger.isInsert &&
                             (duplicateAccSet.isEmpty() || (!duplicateAccSet.isEmpty() &&  !duplicateAccSet.contains(acc.PersonEmail.toUpperCase())))))){
                                 acc.BAT_BypassAccountDuplicateRule__c = true;
                             }
                        //09.10.2019/Abhishek Kashyap/Updated the method to populate Related Lead field on Account
                        if(String.isBlank(acc.Related_Lead__c) && Trigger.isBefore){
                            acc.Related_Lead__c = ld.Id;
                        }
                        //Logic for DE to consider brand of duplicate lead before deleting.
                        if (ld.country__c == BAT_ConstantsUtility.DE_STR) {
                            //Check if the lead with same brand exists then delete.                                                                                        
                            if((String.isNotBlank(ld.BAT_VapeStatus__c) && String.isNotBlank(acc.BAT_VapeStatus__c)) || (String.isNotBlank(ld.BAT_THPStatus__c) && String.isNotBlank(acc.BAT_THPStatus__c)) || (String.isNotBlank(ld.BAT_OralStatus__c) && String.isNotBlank(acc.BAT_OralStatus__c))){                                //If there are any lead with owner as user then assign the owner to account. If not no action
                                //Allada Yeshwanth || BUG: #525000   || Added isBefore check to make the owner is changed only in before context 
                                //                 added else condition to change the owner of the lead if the current owner is queue
                                if(trigger.isBefore){
                                    if(ld.ownerId.getsobjecttype() != Group.sobjecttype){
                                        //if owner is a user
                                        acc.ownerID = ld.ownerId;
                                    }
                                    else{
                                        //if owner is a queue
                                        ld.ownerId = userInfo.getUserId();
                                    }
                                }
                                integratedAccounts.put(ld.Email, acc);
                                //09.10.2019/Abhishek Kashyap/Updated the method to update status field on lead based on brand
                                //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Moved the code to the utility method.
                                BAT_Utilities.setLeadAccountStatusField(ld,null);
                                ld.recordTypeId = convertedLeadRecordTypeId; 
                                mapLeadsToConvert.put(ld.Id,ld);
                            }
                        }
                        /*Added the below logic for UK US #12067 and UK US#14375
*No two leads can exist with same email address.
*Either a lead or an PersonAccount can exist with the same email address - i.e. *either a customer can exist or a subscriber(Lead)
*When a customer registers for an account on eCommerce, if a Lead already exists in SF, *the Lead should always be deleted 
*regardless of whether the Lead is a subscriber to multiple eCom platforms before creating a Person Account*/
                        else if (ld.country__c == BAT_ConstantsUtility.UK_STR) {
                            /*UK US#14375, Logic to populate Lead Subscriber Ids to Account's Subscriber Id 
*when new account is getting registered.
*UK US#14375, Customer is getting registered with at least one of the sources, 
*therefore at least one of the customer Id should be populated before lead deletion*/
                            if(Trigger.isBefore){
                                //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Modified the utilities method to add the state check
                                BAT_Utilities.convertSubscriberToAccount(acc, ld,BAT_ConstantsUtility.UK_STR);
                            }
                            ld.OwnerId = acc.ownerId;
                            /*UK US#14375 If at least one of the Subscriber Id of Account is populated from Lead subscriber Ids 
*while conversion from subscriber (lead) to account.*/
                            //09.10.2019/Abhishek Kashyap/Updated the method to update status field on lead based on brand
                            //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Moved the code to the utility method.
                            BAT_Utilities.setLeadAccountStatusField(ld,null);
                            ld.recordTypeId = convertedLeadRecordTypeId; 
                            ld.HasOptedOutOfEmail = true;
                            mapLeadsToConvert.put(ld.Id,ld);
                        }
                        
                        //Added as part of US37833
                        //Added UA and KZ check to avoid deletion of lead US37833
                        else if(acc != null &&
                                (ld.country__c != BAT_ConstantsUtility.COUNTRY_UA && 
                                 ld.country__c != BAT_ConstantsUtility.COUNTRY_KZ)) {
                                     //[PL] 25.06.2020/ Mallik Balla/ US#176027 : Append lead's brand house values to account's brand house values -- starts
                                     if( trigger.isBefore){
                                         // 16.10.2020/sandeep Joshi/US#287199 : Addded ZA Country Check so that below code should execute for lead having country as ZA as well.
                                         // 05.03.2021/Akshata Rajmane/Bug #431672 :GR - Lead not getting converted
                                         if(String.isNotBlank(ld.Country__c) &&  (ld.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_PL) 
                                                                                  || ld.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_ZA)
                                                                                  || ld.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR))){
                                                                                      acc.BAT_BypassAccountDuplicateRule__c = true;//[PL] 2.07.2020/ Mallik Balla/ US#128832 :Bypass the Account Duplicate rule for PL such that the Account is allowed to convert if the source is from Integration
                                                                                      List<String> setLeadBrands = new List<String>();
                                                                                      if(String.isNotBlank(ld.Brand_House__c)){
                                                                                          setLeadBrands = ld.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                                                                                          if(!setLeadBrands.isEmpty()){
                                                                                              for(String strBrand : setLeadBrands){
                                                                                                  if(!acc.Brand_House__c.contains(strBrand)){
                                                                                                      acc.Brand_House__c+=BAT_ConstantsUtility.SEMI_COLON+strBrand;
                                                                                                  }
                                                                                              }
                                                                                          }
                                                                                      }
                                                                                      //[PL] 25.06.2020/ Mallik Balla/ US#176027 : If the current user is an integration user, set the integration user as the owner of the account -- starts
                                                                                      if(user != null){
                                                                                          if(String.isNotBlank(user.Username) && String.isNotBlank(User.Profile.Name)
                                                                                             && User.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER)
                                                                                             && user.Username.toLowercase().contains(BAT_ConstantsUtility.STR_MULESOFT_INTEGRATION_USER)){
                                                                                                 ld.ownerId = user.ID;
                                                                                                 acc.OwnerId = user.ID;
                                                                                             }
                                                                                          else if(String.isNotBlank(ld.Owner.type) && ld.Owner.type.equalsIgnoreCase(BAT_ConstantsUtility.QUEUE_STR)
                                                                                                  && integrationUserID != null){
                                                                                                      ld.ownerId = integrationUserID;
                                                                                                      acc.OwnerId = integrationUserID;
                                                                                                  }
                                                                                          else{
                                                                                              acc.OwnerId = ld.ownerId;
                                                                                          }
                                                                                      } 
                                                                                      //[PL] 25.06.2020/ Mallik Balla/ US#176027 : If the current user is an integration user, set the integration user as the owner of the account -- ends
                                                                                  }
                                         //[PL] 25.06.2020/ Mallik Balla/ US#176027 : Append lead's brand house values to account's brand house values -- ends
                                         // 16.10.2020/sandeep Joshi/US#287199 : Addded ZA Country Check to skip code which is assigning lead owner to account owner
                                         // 01.03.2021/Idrees Ali/US#382068 : Added IT country check to bypass retain account owner
                                         // 13.02.2022/Idrees Ali/US#893500 : Added PT country check to bypass retain account owner
                                         if(((ld.Country__c == BAT_ConstantsUtility.COUNTRY_IT || ld.Country__c == BAT_ConstantsUtility.COUNTRY_PT) && acc.AccountSource != BAT_ConstantsUtility.SOURCE_NEWOFFLINEREGISTRATION) || (ld.Country__c == BAT_ConstantsUtility.COUNTRY_ES && acc.AccountSource != BAT_ConstantsUtility.SOURCE_REACH) ){ 
                                             acc.ownerID = ld.ownerId;
                                         }
                                         else if(ld.Country__c != BAT_ConstantsUtility.COUNTRY_IT  && ld.Country__c != BAT_ConstantsUtility.COUNTRY_PT && ld.Country__c != BAT_ConstantsUtility.COUNTRY_MX_STR && ld.Country__c != BAT_ConstantsUtility.COUNTRY_PL && ld.Country__c != BAT_ConstantsUtility.COUNTRY_ZA ){ //[PL] 25.06.2020/ Mallik Balla/ US#176027 - Bypass this logic for PL country
                                             acc.ownerID = ld.ownerId;
                                         }
                                         if(ld.Country__c == BAT_ConstantsUtility.COUNTRY_ES){
                                             //Added String.isNotBlank check for Vape Status to avoid Attempt to de-references null object
                                             if(String.isNotBlank(acc.Brand_House__c)){
                                                 if(acc.Brand_House__c.contains(BAT_ConstantsUtility.VYPE_DEVICE_STR) &&  String.isNotBlank(acc.BAT_VapeStatus__c) && !acc.BAT_VapeStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER)){
                                                     acc.BAT_VapeStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                                                 }
                                                 //ES : Added null check for Bug 62493
                                                 if(acc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && String.isNotBlank(acc.BAT_THPStatus__c) && !acc.BAT_THPStatus__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER)){
                                                     acc.BAT_THPStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                                                 }
                                             }
                                         }
                                         //Added below logic as part of SE#US#110377 by Tejaswi
                                         //Set the BAT_ExternalSubscriberId4__c on account duirng lead conversion
                                         //Ishita Kotian / US#977915 Added code to mark Email Opt Out field on Lead as true on Lead conversion
                                         if(ld.Country__c == BAT_ConstantsUtility.SE_STR){
                                             if(String.isNotBlank(acc.Brand_House__c) && 
                                                (acc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase()) || acc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)) &&
                                                string.isNotBlank(ld.BAT_ExternalSubscriberID4__c)){
                                                    acc.BAT_ExternalSubscriberId4__c = ld.BAT_ExternalSubscriberID4__c;
                                                }
                                             ld.HasOptedOutOfEmail = true;
                                             mapLeadsToConvert.put(ld.Id,ld);
                                         }
                                         //End of US#110377
                                         //Added below ID changes as part of US#141111
                                         if(ld.Country__c == BAT_ConstantsUtility.COUNTRY_ID){
                                             //Added below ID changes as part of Bug#249597
                                             if((ld.BAT_IsVeloOptInEmailCommunication__c == true ||ld.BAT_IsVeloOptInMobileTextSocialMedia__c == true) && 
                                                (acc.BAT_IsVeloOptInEmailCommunication__c == false || acc.BAT_IsVeloOptInMobileTextSocialMedia__c == false))
                                             {
                                                 acc.BAT_IsVeloOptInEmailCommunication__c = false;
                                                 acc.BAT_IsVeloOptInMobileTextSocialMedia__c = false;
                                             } //End of Bug#249597
                                             acc.BAT_ExternalSubscriberId4__c = ld.BAT_ExternalSubscriberID4__c;
                                         }//End of US#141111
                                         // Added FR country check to map converted lead fields on Account
                                         if(ld.Country__c == BAT_ConstantsUtility.COUNTRY_FR) {
                                             BAT_Utilities.convertSubscriberToAccount(acc, ld,BAT_ConstantsUtility.COUNTRY_FR); 
                                         }
                                         // Added MY country check to map converted lead fields on Account
                                         if(ld.Country__c == BAT_ConstantsUtility.COUNTRY_MY) {
                                             BAT_Utilities.convertSubscriberToAccount(acc, ld,BAT_ConstantsUtility.COUNTRY_MY); 
                                         }
                                         // Added SK country check to map converted lead fields on Account
                                         if(ld.Country__c == BAT_ConstantsUtility.COUNTRY_PT) {
                                             BAT_Utilities.convertSubscriberToAccount(acc, ld,BAT_ConstantsUtility.COUNTRY_PT); 
                                         } 
                                         //Added IT check for US#382068 - IT Glo Reach to prepopulate bithdate and make Gender null
                                         //20 May,2021/Abhishek Kashyap/US-451955-ES Glo Reach to prepopulate bithdate and make Gender null
                                         if(((ld.Country__c == BAT_ConstantsUtility.COUNTRY_IT || ld.Country__c == BAT_ConstantsUtility.COUNTRY_PT)  && acc.AccountSource == BAT_ConstantsUtility.SOURCE_NEWOFFLINEREGISTRATION) || (ld.Country__c == BAT_ConstantsUtility.COUNTRY_ES && acc.AccountSource == BAT_ConstantsUtility.SOURCE_REACH)) {
                                             acc.PersonBirthdate =  acc.Birth_Date__c;
                                             ld.Gender__c = null;
                                             ld.Phone = null;
                                             //15.11.201 / Allada Yeshwanth / Added as  part of US# 708320 // to enable cross community lead conversion.
                                             if(user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.BAT_IT_POSAGENTPROFILE) || user.Profile.Name.equalsIgnoreCase(BAT_ConstantsUtility.GLO_STORE)){
                                                 ld.OwnerId = user.Id;
                                             }
                                         }   
                                     }
                                     if(!accountFields.isEmpty() && !leadFields.isEmpty()){ 
                                         for (Integer i = 0; i < leadFields.size() && i < accountFields.size() ; i++) {
                                             if (acc.get(accountFields[i].getFieldPath()) == null &&
                                                 ld.get(leadFields[i].getFieldPath()) != null
                                                ) {
                                                    //09.10.2019/Abhishek Kashyap/BUG - 49454, Mapping account and lead fields before account is inserted
                                                    if( Trigger.isBefore){
                                                        acc.put(accountFields[i].getFieldPath(), ld.get(leadFields[i].getFieldPath()));
                                                    }
                                                }
                                         }//loop_Ends.
                                     }
                                     integratedAccounts.put(ld.Email, acc);
                                     //Added the below map for UK US #12067
                                     //09.10.2019/Abhishek Kashyap/Updated the method to update status field on lead based on brand
                                     //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Moved the code to the utility method.
                                     BAT_Utilities.setLeadAccountStatusField(ld,null);
                                     ld.RecordTypeId = convertedLeadRecordTypeId;
                                     //ES : Sprint 2 : US 48414 : Logic to convert Lead when a Asset of certain brand is added to an Account
                                     if(ld.Country__c == BAT_ConstantsUtility.COUNTRY_ES){
                                         if(integratedAccounts.get(ld.Email).Brand_House__c.contains(ld.Brand_House__c)){
                                             //Added below if loop as part of ES-Glo:US#120789 
                                             if(Trigger.isBefore && string.isNotBlank(ld.Brand_House__c) && ld.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && string.isNotBlank(ld.BAT_ExternalSubscriberID2__c)){
                                                 Account localaccount = integratedAccounts.get(ld.Email);
                                                 localaccount.BAT_ExternalSubscriberID2__c = ld.BAT_ExternalSubscriberID2__c;
                                                 integratedAccounts.put(ld.Email, localaccount);    
                                             }//End of ES-Glo:US#120789 
                                             ld.status = BAT_ConstantsUtility.CONVERTED;
                                             mapLeadsToConvert.put(ld.Id,ld);
                                         }
                                     }
                                     else{
                                         mapLeadsToConvert.put(ld.Id,ld);
                                     }
                                 }
                    }
                }//loop_ends.
                //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Updates Product Interest records associated with Lead to Account during before insert
                if(Trigger.isInsert && Trigger.isAfter){
                    if(!lstProductInterestAccs.isEmpty() && !setProductInterestLeads.isEmpty()){
                        List<BAT_ProductInterest__c> lstPIsToUpdate = BAT_Utilities.updateProductInterestAndLeadRecords(lstProductInterestAccs,setProductInterestLeads);
                        if(lstPIsToUpdate != null && !lstPIsToUpdate.isEmpty()){
                            update lstPIsToUpdate;
                        }
                    }
                }
                List<Database.LeadConvert> leadConvertList = new List<Database.LeadConvert>();
                if(!mapLeadsToConvert.isEmpty()){
                    update mapLeadsToConvert.values();
                    // below logic used to perform the bulk lead conversion
                    for(Lead rec : mapLeadsToConvert.values()){
                        Database.LeadConvert leadConvert = new Database.LeadConvert();
                        leadConvert.setLeadId(rec.id);
                        leadConvert.setConvertedStatus(BAT_ConstantsUtility.CONVERTED);
                        leadConvert.setDoNotCreateOpportunity(true); 
                        if( integratedAccounts.containsKey(rec.Email.toUpperCase())){
                            leadConvert.setAccountId(integratedAccounts.get(rec.Email.toUpperCase()).id);}
                        leadConvertList.add(leadConvert);
                        System.debug('leadConvertListTest'+leadConvertList);
                    }//loop_ends.  
                }     
                if (!leadConvertList.isEmpty()) {
                    //09.10.2019/Abhishek Kashyap/BUG - 49454, Condition to ensure that method is executed for both before and after events.
                    if(!Trigger.isBefore){
                        BAT_ConstantsUtility.LTH_LEADCONVERT = true;
                    }
                    BAT_ConstantsUtility.isTriggerBypassed =  false;
                    Database.LeadConvertResult[] lcrList;
                    for(Integer i = 0; i <= leadConvertList.size()/100 ; i++){
                        list<Database.LeadConvert> tempList = new list<Database.LeadConvert>();
                        Integer startIndex = i*100;
                        Integer endIndex = ((startIndex+100) < leadConvertList.size()) ? startIndex+100: leadConvertList.size();
                        for(Integer j=startIndex;j<endIndex;j++){
                            tempList.add(leadConvertList[j]);
                            system.debug('tempListTest'+tempList);
                        }
                        //11.10.2019/Abhishek Kashyap/ Converting the Lead after Account is inserted
                        if(!tempList.isEmpty() && templist != null && (!Trigger.isBefore)){
                            lcrList = Database.convertLead(tempList, false);
                            system.debug('lcrListTest'+lcrList);
                            
                        }
                    }//loop_ends.
                    if(lcrList != null && !lcrList.isEmpty()){
                        for(Database.LeadConvertResult lcr : lcrList){
                            Lead localRec;        
                            if(lcr.getLeadId() != null && mapLeadsToConvert.containsKey(lcr.getLeadId())){
                                localRec = mapLeadsToConvert.get(lcr.getLeadId());
                            }
                            if(!lcr.isSuccess() && localRec != null){
                                for(Database.Error error : lcr.getErrors()){
                                    acc.addError(error.getMessage());
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : manageHypercare
* @returns       : void
* @params        : List<String>,Map<Id,Account>
* @description   : [All Markets]Account is created and gives consents for emails or/and phone calls.Tasks
/reminders/automatic emails in the system are associated to the account based on consent
triggers.Account withdraws a consent based on the pre-existing triggers, related prospective
emails/tasks/reminders are removed from the system from Metadata HyperCare_Management__mdt 
Flow_c domain : {DeleteFutureTasks, DeleteFutureEvents, AddFutureTasks, AddFutureEvents}
* @changeHistory : 07.11.2018/Simona Georgieva/Created the method/US#2798
08.02.2019/Tejaswi Nissankula/Code Optimization
23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
*********************************************************************************************************/
    
    public static void manageHypercare(List < Account > triggerNew, Map < Id, Account > triggerOldMap) {
        Set<String> country_SET = new Set<String>();
        Map<String, Set<String>> countryToMetaData_MAP = new Map<String, Set<String>>();
        List<Task> tasksToDelete_LIST = new List<Task>();
        List<Event> eventsToDelete_LIST = new List<Event>();
        Map<String,Set<Task>> tasksForAccount_MAP = new Map<String,Set<Task>>();
        Map<String,List<Event>> eventsForAccount_MAP = new Map<String,List<Event>>(); 
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        List<Opportunity> oppList = new List<Opportunity>();
        Set<String> accChanged = new Set<String>();
        List<String> metadataFlow_LIST = new List<String>{BAT_ConstantsUtility.HYPERCARE_MANAGEMENT_DELETE_TASK, BAT_ConstantsUtility.HYPERCARE_MANAGEMENT_DELETE_EVENT};
            
            
            //Creation set of country and account with privacy changed
            for(Account acc: triggerNew){
                country_SET.add(acc.country__c);
                if(acc.Trial_Information_Permission__c != triggerOldMap.get(acc.Id).Trial_Information_Permission__c){
                    accChanged.add(acc.Id);
                }
            }
        
        //Creation Map country -> to flow enabled
        for(HyperCare_Management__mdt hm: [SELECT MasterLabel, Flow__c
                                           FROM HyperCare_Management__mdt
                                           WHERE MasterLabel IN: country_SET
                                           AND Flow__c IN: metadataFlow_LIST
                                          ]){
                                              
                                              if(countryToMetaData_MAP.containsKey(hm.MasterLabel)){
                                                  countryToMetaData_MAP.get(hm.MasterLabel).add(hm.Flow__c);
                                              } else {
                                                  countryToMetaData_MAP.put(hm.MasterLabel, new Set<String>{hm.Flow__c});
                                              }
                                          }
        
        //If map of metadata is not empty the flow must evaluate the accounts
        if(!countryToMetaData_MAP.isEmpty()){
            //Get opportunities related changed accounts
            for(Opportunity oppRec: [SELECT Id, BAT_TriggerPb__c, Account.Trial_Information_Permission__c
                                     FROM Opportunity
                                     WHERE AccountId IN: accChanged
                                     AND Country__c IN: country_SET]){
                                         oppRec.BAT_TriggerPb__c = oppRec.Account.Trial_Information_Permission__c;
                                         oppList.add(oppRec);
                                     }
            //CHECK FOR TASKS
            for(Task t : [SELECT Id, Status,Call_Type__c,ActivityDate,
                          WhatId  FROM Task WHERE WhatId IN :triggerNew]){
                              if(t.ActivityDate >= Date.Today()) {                              
                                  if(tasksForAccount_MAP.containsKey(t.WhatId)){
                                      tasksForAccount_MAP.get(t.WhatId).add(t);
                                  }
                                  else{
                                      tasksForAccount_MAP.put(t.WhatId, new Set<Task>{t});
                                  }
                              }
                              //Added UK changes - When Task status is Open, call type is 'Day-4'.
                              //Added for UK US#2603 - by Usha on Feb 4th, 2019.
                              if(((BAT_ConstantsUtility.OPEN_STR).equals(t.Status)) && ((BAT_ConstantsUtility.DAY4_STR).equals(t.Call_Type__c))) {
                                  if(tasksForAccount_MAP.containsKey(t.WhatId)){
                                      tasksForAccount_MAP.get(t.WhatId).add(t);
                                  }
                                  else{
                                      tasksForAccount_MAP.put(t.WhatId, new Set<Task>{t});
                                  }
                              }
                          }
            //Get Events to delete.
            List<Event> eventsToDeleteCurr_LIST = [SELECT WhatId, Startdatetime, Activitydate
                                                   FROM Event
                                                   WHERE WhatId IN :triggerNew
                                                   AND Activitydate >= TODAY];
            
            for(Event e : eventsToDeleteCurr_LIST){
                if(eventsForAccount_MAP.containsKey(e.WhatId)){
                    eventsForAccount_MAP.get(e.WhatId).add(e);
                }
                else{
                    eventsForAccount_MAP.put(e.WhatId, new List<Event>{e});
                }
            }
            
            for (Account acc: triggerNew) {
                //Added UK changes - When field Hypercare Team-Do not Contact is checked,it fetches all the account records 
                //Added for UK US#2603 - by Usha on Feb 4th, 2019.
                //Get tasks to delete
                Boolean isHypercareDeleteTask = false;
                if (countryToMetaData_MAP.containsKey(acc.Country__c)) {
                    
                    if (countryToMetaData_MAP.get(acc.Country__c).contains(BAT_ConstantsUtility.HYPERCARE_MANAGEMENT_DELETE_TASK) &&
                        tasksForAccount_MAP.containsKey(acc.Id)) {
                            isHypercareDeleteTask = true;
                        }
                    
                    if (isHypercareDeleteTask &&
                        ((acc.Is_Do_Not_Contact__c && triggerOldMap.get(acc.Id).Is_Do_Not_Contact__c != acc.Is_Do_Not_Contact__c) ||
                         (!acc.Trial_Information_Permission__c && triggerOldMap.get(acc.Id).Trial_Information_Permission__c != acc.Trial_Information_Permission__c))) {
                             tasksToDelete_LIST.addAll(tasksForAccount_MAP.get(acc.Id));
                             isHypercareDeleteTask = false;
                             
                         }
                    if (!acc.Trial_Information_Permission__c &&
                        triggerOldMap.get(acc.Id).Trial_Information_Permission__c != acc.Trial_Information_Permission__c &&
                        countryToMetaData_MAP.get(acc.Country__c).contains(BAT_ConstantsUtility.HYPERCARE_MANAGEMENT_DELETE_EVENT) && eventsForAccount_MAP.containsKey(acc.Id)) {
                            eventsToDelete_LIST.addAll(eventsForAccount_MAP.get(acc.Id));
                        }
                    
                }
            } //loopEnds
            try {
                //Added Null check before DML operation as part of ForceReviewer changes.
                //Delete tasks
                if (tasksToDelete_LIST != null && !tasksToDelete_LIST.isEmpty()) {
                    //Added below Map to remove the duplicate Tasks in the list, to avoid exception.
                    Map < Id, Task > tasksToDelete_Map = new Map < Id, Task > (tasksToDelete_LIST);
                    delete tasksToDelete_Map.values();
                }
                //Delete Events
                if (eventsToDelete_LIST != null && !eventsToDelete_LIST.isEmpty()) {
                    delete eventsToDelete_LIST;
                }
                //Update Opportunities.
                if (oppList != null && !oppList.isEmpty()) {
                    update oppList;
                }
            } catch (Exception ex) { for (Account accRecord: triggerNew) {
                system.debug('++ex.getMessage() '+ex.getMessage());
                system.debug('++ex '+ex);
                accRecord.addError(ex.getMessage());
            }
                                   }
        }
    }
    
    /*********************************************************************************
@author Deloitte
@method checkForPotentialDuplicateAccounts
@returns void
@params  Batchable Context Object,List<Opportunity>
@description [DE] Sprint4: 3352: This method is used to check for Potential Duplicate Account
@changeHistory: 04.07.2019/Abhishek Kashyap/US - 20647 / Updated the query, duplicate check string and added condition to mark accounts as potential duplicates for Austria
:09.05.2021 /Akshata Rajmane / US#505672 : Avalanche - Technical Setup - Duplication Rule Logic: Added Account source check to bypass the logic    
*******************************************************************************/
    
    public void checkForPotentialDuplicateAccounts(Account[] newAccount, Map < Id, Account > oldAccountMap) {
        
        Set<Date> setBirthDate = new Set<Date>();
        Set<String> setPostalCode = new Set<String>();
        Set<String> setDuplicateStr = new Set<String>();
        Map<String,String> mapDuplicateCombination = new Map<String,String>();
        Set<String> setduplicateleadIds=new Set<String>();
        String strDuplicateCombination;
        List<Account> lstOldAccount = new List<Account>();
        Boolean isBooleanInsert;
        if(oldAccountMap!=null && oldAccountMap.keySet().size()>0){
            isBooleanInsert=false;
        }else{
            isBooleanInsert=true;
        }
        for(Account accRec: newAccount){
            //04.07.2019/Abhishek Kashyap/US - 20647 / Added condition to mark accounts as potential duplicates for Austria
            if ((accRec.Country__c == BAT_ConstantsUtility.COUNTRY_DE_STR || accRec.Country__c == BAT_ConstantsUtility.COUNTRY_AT_STR )&&
                (isBooleanInsert || (oldAccountMap.get(accRec.Id) != null &&
                                     (oldAccountMap.get(accRec.Id).Postal_Code__c != accRec.Postal_Code__c ||
                                      oldAccountMap.get(accRec.Id).Birth_Date__c != accRec.Birth_Date__c)))) {
                                          setBirthDate.add(accRec.Birth_Date__c);
                                          setPostalCode.add(accRec.Postal_Code__c);
                                          //04.07.2019/Abhishek Kashyap/US - 20647 / Updated strDuplicateCombination string and added country code to segregate  DE and AT records
                                          strDuplicateCombination = accRec.Country__c+string.valueOf(accRec.Birth_Date__c) + accRec.Postal_Code__c;
                                          setDuplicateStr.add(strDuplicateCombination);
                                      }
            
        }
        if(setDuplicateStr != null){
            //04.07.2019/Abhishek Kashyap/US - 20647 / Updated the query to fetch records of Austria along with Germany
            //09.05.2021 /Akshata Rajmane / US#505672 : Avalanche - Technical Setup - Duplication Rule Logic: Added Account source check to bypass the logic
            for (Account accRec: [Select Id, Country__c, Birth_Date__c, Postal_Code__c, Name, Brand_House__c from Account 
                                  Where Postal_Code__c != null AND Postal_Code__c IN: setPostalCode AND 
                                  Birth_Date__c IN: setBirthDate AND AccountSource !=: BAT_ConstantsUtility.EU_ACCOUNT_SOURCE AND
                                  (Country__C =: BAT_ConstantsUtility.COUNTRY_DE_STR OR Country__C =: BAT_ConstantsUtility.COUNTRY_AT_STR) AND Is_Duplicate_DE__c = False ORDER BY CreatedDate ASC]) {
                                      //04.07.2019/Abhishek Kashyap/US - 20647 / Updated strDuplicateCombination string and added country code to segregate  DE and AT records
                                      strDuplicateCombination = accRec.Country__c+string.valueOf(accRec.Birth_Date__c) + accRec.Postal_Code__c;
                                      if (setDuplicateStr.contains(strDuplicateCombination) && !mapDuplicateCombination.containsKey(strDuplicateCombination)) {
                                          mapDuplicateCombination.put(strDuplicateCombination, (String) accRec.Id + '%' + (String) accRec.Name);
                                      }
                                  }
            
            for(Account accRec: newAccount){
                //04.07.2019/Abhishek Kashyap/US - 20647 / Updated strDuplicateCombination string and added country code to segregate  DE and AT records
                strDuplicateCombination = accRec.Country__c+string.valueOf(accRec.Birth_Date__c) + accRec.Postal_Code__c;
                if (mapDuplicateCombination.containsKey(strDuplicateCombination)) {
                    accRec.Is_Duplicate_DE__c = true;
                    accRec.Potential_Duplicate_Of_Account_Info_DE__c = mapDuplicateCombination.get(strDuplicateCombination);
                }
            }
        }
    }
    
    /*********************************************************************************
@author Deloitte
@method updateDuplicateAccountsAtInactive
@returns void
@params  Account[] newAccount,Map<Id,Account> oldAccountMap
@description [DE] This method is used to Converts degrees to radians.
@changeHistory: 23.03.2020/Tejaswi Nissakula/ Added Null check before DML operation as part of ForceReviewer changes.
*******************************************************************************/
    public void updateDuplicateAccountsAtInactive(Account[] newAccount, Map<Id,Account> oldAccountMap) {
        
        Set<Id> setInactiveAccounts = new Set<Id>();
        Set<String> setInactiveAccountInfo = new Set<String >();
        Map<String,String > mapActiveAccountInfo = new Map<String,String>();
        Set<String> setPostalCode = new Set<String>();
        Set<String> accCountrySet = new Set<String>();
        for(Account accRec: newAccount){
            accCountrySet.add(accRec.Country__c);
            if(oldAccountMap != null && oldAccountMap.keySet().size() > 0 && accRec.Country__c == BAT_ConstantsUtility.COUNTRY_DE_STR){
                if(oldAccountMap.get(accRec.Id) != null) {
                    if(oldAccountMap.get(accRec.Id).IsActive_DE__c != accRec.IsActive_DE__c && accRec.IsActive_DE__c == False){
                        setInactiveAccounts.add(accRec.Id);
                        setPostalCode.add(accRec.Postal_Code__c);
                        setInactiveAccountInfo.add((String) accRec.Id + BAT_ConstantsUtility.PERCENTAGE + (String) accRec.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + (String) accRec.LastName);
                    }
                }
            }
        }
        //20.12.2019/Osheen Sahajpal/Added DE if-condition check to run query only when record is for DE to avoid 101 SOQL issue
        if(!accCountrySet.isEmpty() && accCountrySet.contains(BAT_ConstantsUtility.COUNTRY_DE_STR) && setInactiveAccounts != null){
            List<Account> lstAccountsToUpdate = new List<Account>();
            for(Account accRec: [Select Id, Potential_Duplicate_Of_Account_Info_DE__c, FirstName, LastName, Postal_Code__c From Account
                                 Where Potential_Duplicate_Of_Account_Info_DE__c IN: setInactiveAccountInfo AND IsActive_DE__c = True AND Postal_Code__c != null
                                 AND Postal_Code__c IN: setPostalCode AND Country__c =: BAT_ConstantsUtility.COUNTRY_DE_STR ORDER BY CreatedDate ASC]){
                                     if(mapActiveAccountInfo.containsKey(accRec.Potential_Duplicate_Of_Account_Info_DE__c)){
                                         accRec.Potential_Duplicate_Of_Account_Info_DE__c = mapActiveAccountInfo.get(accRec.Potential_Duplicate_Of_Account_Info_DE__c);
                                         lstAccountsToUpdate.add(accRec);
                                     }else{
                                         mapActiveAccountInfo.put(accRec.Potential_Duplicate_Of_Account_Info_DE__c, (String) accRec.Id + BAT_ConstantsUtility.PERCENTAGE + (String) accRec.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + (String) accRec.LastName);
                                         accRec.Is_Duplicate_DE__c = false;
                                         lstAccountsToUpdate.add(accRec);
                                     }
                                 }
            
            //Added Null check before DML operation as part of ForceReviewer changes.                   
            if (lstAccountsToUpdate != null && !lstAccountsToUpdate.isEmpty()) {
                update lstAccountsToUpdate;
            }
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : validateMobileNumberFormat
* @returns       : void
* @params        : List of new reocrds ,old map
* @description   : [All Market] Method used to generate map of coutry and respective list of mobile numbers 
use the to call utility method to validate mobile formats
* @changeHistory : 20.03.2019 /Akshata Rajmane / created the method

*********************************************************************************************************/
    public void validateMobileNumberFormat(Account[] newAccount, Map<Id,Account> oldAccountMap) {
        
        Map<String ,List<String>> mapOfCountryToMobileNums = new Map<String,List<String>>();
        Map<String, String> mapOfMobileToError = new Map<String,String>();
        Map<String,Account> mapOfMobileToAccount = new Map<String,Account>();
        for (Account account: newAccount) {
            //if contains the mobile number check and also before insert and before update checks
            if ((account.PersonMobilePhone != null && account.PersonMobilePhone != BAT_ConstantsUtility.BLANK) &&
                (oldAccountMap == null || (oldAccountMap != null &&
                                           account.LastName != null &&
                                           account.LastName != BAT_ConstantsUtility.ANONYMOUS_DATA &&
                                           oldAccountMap.containsKey(account.id) &&
                                           String.valueOf(account.PersonMobilePhone) != String.valueOf((oldAccountMap.get(account.id)).PersonMobilePhone)
                                          ))) {
                                              if (!mapOfCountryToMobileNums.containsKey(account.Country__c)) {
                                                  //put the country in map and initialise list,if map does not contain the country
                                                  mapOfCountryToMobileNums.put(account.Country__c, new List < String > ());
                                              }
                                              //put mobile number and lead to map
                                              mapOfMobileToAccount.put(String.valueOf(account.PersonMobilePhone), account);
                                              mapOfCountryToMobileNums.get(account.Country__c).add(String.valueOf(account.PersonMobilePhone));
                                          }
        }
        //if any value present in map , this will call utility method to validate the phone number with respective country code format
        if (!mapOfCountryToMobileNums.isEmpty()) {
            // call utility method to validate mobile numbers
            mapOfMobileToError = BAT_Utilities.validateMobileFormatwrtCountry(mapOfCountryToMobileNums);
            //not empty means there is error while validating mobile number
            if (!mapOfMobileToError.isEmpty()) {
                for (String mobileNum: mapOfMobileToError.keySet()) {
                    //get the lead from mobile to lead map and add error
                    mapOfMobileToAccount.get(mobileNum).addError(mapOfMobileToError.get(mobileNum));
                }
            }
        }
    }
    
    /*********************************************************************************
@author Deloitte
@method updateConsumerSinceDate
@returns void
@params  Account[] newAccount,Map<Id,Account> oldAccountMap
@description [DE] This method is used to Datestamp 'Consumer Since' fields on Account record
@changeHistory: 28.02.2020 /Satya Nalluri / Bug#59589 / Modified method to make the logic custom metadata driven
25.05.2021 / Idrees Ali / Avalanche-US#511371 / Added Account Source field to the meta query and blank check in if condition
//19.04.2022 / Turbasu Ghosh / US#884781 /DE - CRM - Consumer order details section - Prospect since date stamp         
*******************************************************************************/
    public void updateConsumerSinceDate(Account[] newAccount, Set<String> accCountrySet, Map < Id, Account > oldAccountMap) {        
        
        Map<String, List<BAT_ConsumerSinceDate__mdt>> consumerSinceDateUpdateMdt = new Map<String, List<BAT_ConsumerSinceDate__mdt>>();
        if(!accCountrySet.isEmpty()){
            //19.04.2022 / Turbasu Ghosh / DE - CRM - Prospect since date stamp/Added "BAT_IsProspect__c" in the query
            for(BAT_ConsumerSinceDate__mdt consumerSinceRec : [SELECT MasterLabel, BAT_ComparingField__c, BAT_Country__c, BAT_UpdateField__c, BAT_AccountSource__c,BAT_IsProspect__c FROM BAT_ConsumerSinceDate__mdt 
                                                               WHERE BAT_Country__c In :accCountrySet]){
                                                                   
                                                                   if(!consumerSinceDateUpdateMdt.containsKey(consumerSinceRec.BAT_Country__c))
                                                                   {
                                                                       consumerSinceDateUpdateMdt.put(consumerSinceRec.BAT_Country__c, new List<BAT_ConsumerSinceDate__mdt>{});                    
                                                                   }
                                                                   consumerSinceDateUpdateMdt.get(consumerSinceRec.BAT_Country__c).add(consumerSinceRec);
                                                                   
                                                               }       
        }
        if(consumerSinceDateUpdateMdt != null && !consumerSinceDateUpdateMdt.isEmpty()){
            for(Account accRec: newAccount ){
                //19.04.2022 / Turbasu Ghosh / DE - CRM - Added Prospect since date stamp
                if(String.isNotBlank(accRec.Country__c) && consumerSinceDateUpdateMdt.containsKey(accRec.Country__c)){
                    for(BAT_ConsumerSinceDate__mdt consumerSinceRec: consumerSinceDateUpdateMdt.get(accRec.Country__c)){
                        if(consumerSinceRec.BAT_IsProspect__c && (String.isBlank(consumerSinceRec.BAT_AccountSource__c) ||(!String.isBlank(consumerSinceRec.BAT_AccountSource__c) && accRec.AccountSource == consumerSinceRec.BAT_AccountSource__c)) &&
                           accRec.get(consumerSinceRec.BAT_ComparingField__c)!=null && (oldAccountMap == null || (oldAccountMap != null && accRec.get(consumerSinceRec.BAT_ComparingField__c)!= oldAccountMap.get(accRec.Id).get(consumerSinceRec.BAT_ComparingField__c)))&& 
                           accRec.get(consumerSinceRec.BAT_ComparingField__c) == BAT_ConstantsUtility.ATH_PROSPECT )
                        {system.debug('LK Line 4026');
                         accRec.Put(consumerSinceRec.BAT_UpdateField__c, DateTime.now()) ;
                        }
                        //25.05.2021 / Idrees Ali / Avalanche-US#511371 - Added Account Source check
                        else if(oldAccountMap != null && !consumerSinceRec.BAT_IsProspect__c && (String.isBlank(consumerSinceRec.BAT_AccountSource__c) ||(!String.isBlank(consumerSinceRec.BAT_AccountSource__c) && accRec.AccountSource == consumerSinceRec.BAT_AccountSource__c)) &&
                                accRec.get(consumerSinceRec.BAT_ComparingField__c)!=null && accRec.get(consumerSinceRec.BAT_ComparingField__c)!= oldAccountMap.get(accRec.Id).get(consumerSinceRec.BAT_ComparingField__c)&& 
                                accRec.get(consumerSinceRec.BAT_ComparingField__c) == BAT_ConstantsUtility.ATH_CONSUMER )
                        { system.debug('LK Line 4033');
                         accRec.Put(consumerSinceRec.BAT_UpdateField__c, date.Today()) ;
                        }
                    }               
                }
            }
        }
        
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : UpdateAccountBrandStatusFields
* @returns       : void
* @params        : List<Account> lstAccountsToUpdate
* @description   : 1.[All Markets] US#14787: IT-Sprint0: Method to update Brand Status fields - Glo,Vype on Account
2.[All Markets] Method to handle duplication check field
* @changeHistory : 03.28.2019/Shreeyanshu Kumar/Created the method
29.04.2019/Shreeyanshu Kumar/IT-Vype: BUG#20121: Updated to check 'BAT_ConvertLeadController.isUpdatedBrandStatusOnConverison' flag value before updating THP Status to trialist
13th Nov, 2019/Abhishek Kashyap/Updated condition to prevent status to change from lost to prospect if a lead of different brand is converted.
14.04.2020/Tejaswi Nissankula/KZ:Glo#US107514:Added 'Subscriber' not equal to check on THP Status to skip THPStatus update to empty when we have lead with same mobile number as account and THP Status as 'Subscriber' exists.
15.04.2020/Tejaswi Nissankula/Bug#114834:Added logic for LYFT and EPOK brandhouse to fix the issue related to person account duplicate rule
30.10.2020/ Mallik Balla/ Bug #314845 - PL - Revert the THP/Vape/Oral Statuses to Blank only if Brand House doesn't contain Yourchoice
These status values will be sent from Yourchoice integration system while creating/updating an account
16.12.2020/ Souvik Dinda/US#338720 - Added condition for Brand House "Vuse" for setting the Vape Status to Prospect if the Account has Vuse as brand.
18th Feb,20201/Abhishek Kashyap/US-405628, Added logic to update Combustible Status field if Brand House contains FMC
*********************************************************************************************************/
    public void UpdateAccountBrandStatusFields(Account[] lstAccountsToUpdate) {
        
        //Getting the recordType Id of 'Trialist' Record type of Account
        Id trialistRecordTypeId = recordTypeDevNameMap.get(BAT_ConstantsUtility.RECORDTYPE_TRAILLIST);
        
        //String for Duplicate check
        String strStatus;
        
        Set<String> setCountries = new Set < String > ();
        Map<String,BAT_BrandStatusUpdateConfiguration__mdt > mapcountryToUpdateBrandStatusmdt = new Map<String, BAT_BrandStatusUpdateConfiguration__mdt>();
        
        //Getting Countries of accounts in a set
        for (Account objAccRec: lstAccountsToUpdate) {
            setCountries.add(objAccRec.Country__c);
        }
        //Querying "BAT_BrandStatusUpdateConfiguration__mdt" custom metadata records for countries of accounts and objct type 'Account'
        List < BAT_BrandStatusUpdateConfiguration__mdt > lstUpdateBrandStatusmdt = [SELECT MasterLabel, BAT_Country__c, BAT_BrandStatusType__c, BAT_RecordTypeCheck__c
                                                                                    FROM BAT_BrandStatusUpdateConfiguration__mdt
                                                                                    WHERE BAT_Country__c IN: setCountries
                                                                                    AND BAT_Object__c =: BAT_ConstantsUtility.STANDARD_ACCOUNT_STR
                                                                                   ];
        //Getting all the metadata records in a map, mapped with 'country'
        for (BAT_BrandStatusUpdateConfiguration__mdt mdtUpdateBrandStatusRec: lstUpdateBrandStatusmdt) {
            if (!mapcountryToUpdateBrandStatusmdt.containsKey(mdtUpdateBrandStatusRec.BAT_Country__c)) {
                mapcountryToUpdateBrandStatusmdt.put(mdtUpdateBrandStatusRec.BAT_Country__c, mdtUpdateBrandStatusRec);
            }
        }
        for (Account objAccRec: lstAccountsToUpdate) {
            //US#530277 : Bypass this method for Retailer record Type
            if (String.isNotBlank(objAccRec.Country__c)) {
                if(objAccRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR) && objAccRec.RecordTypeId == retailerRecordTypeId){
                    objAccRec.BAT_CountryValue__c = objAccRec.Country__c + BAT_ConstantsUtility.SPLIT + objAccRec.RecordTypeId;
                }else{
                    objAccRec.BAT_CountryValue__c = objAccRec.Country__c;
                }
            }
            if(objAccRec.RecordTypeId != retailerRecordTypeId){
                //String to store unique value for duplication check
                strStatus = BAT_ConstantsUtility.BLANK;
                
                objAccRec.BAT_THPStatusValue__c = BAT_ConstantsUtility.BLANK;
                objAccRec.BAT_VapeStatusValue__c = BAT_ConstantsUtility.BLANK;
                
                //Checking if custom metadata defind for the Record's country
                if (mapcountryToUpdateBrandStatusmdt.containsKey(objAccRec.Country__c)) {
                    
                    //Getting Brand House values defined in custom metadata in a list
                    List < String > lstBrandTypes = mapcountryToUpdateBrandStatusmdt.get(objAccRec.Country__c).BAT_BrandStatusType__c.split(BAT_ConstantsUtility.COMMA_STR);
                    
                    //Checkin if Brand House contains Glo and then updating BAT_THPStatus__c based on record type of Account    
                    //13th Nov, 2019/Abhishek Kashyap/Updated condition to prevent status to change from lost to prospect if a lead of different brand is converted.
                    if (objAccRec.Brand_House__c != null && objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) 
                        && lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) 
                        && (objAccRec.BAT_THPStatus__c == null || (BAT_ConvertLeadController.isUpdatedBrandStatusOnConverison && objAccRec.BAT_THPStatus__c != BAT_ConstantsUtility.LEAD_LOST)) 
                        && objAccRec.BAT_THPStatus__c != BAT_ConstantsUtility.ATH_CONSUMER) {
                            if ((objAccRec.RecordTypeId == trialistRecordTypeId || objAccRec.Is_Trialist__c) && mapcountryToUpdateBrandStatusmdt.get(objAccRec.Country__c).BAT_RecordTypeCheck__c) {
                                objAccRec.BAT_THPStatus__c = BAT_ConstantsUtility.ACC_STATUS_TRIALIST;
                            } else {
                                objAccRec.BAT_THPStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                            }
                        }
                    //Making BAT_THPStatus__c null if Brand House does not contain Glo
                    //Added 'Subscriber' not equal to check on THP Status as part of US107514
                    //30.10.2020/ Mallik Balla/ Bug #314845 - PL - Revert the THP Status to Blank only if Brand House doesn't contain Yourchoice
                    else if (objAccRec.Brand_House__c == null || (objAccRec.Brand_House__c != null && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.STR_YOURCHOICE)) &&
                             objAccRec.BAT_THPStatus__c != null && objAccRec.BAT_THPStatus__c != BAT_ConstantsUtility.LEAD &&
                             objAccRec.BAT_THPStatus__c != BAT_ConstantsUtility.ORAL_VYPE_STATUS) {
                                 
                                 objAccRec.BAT_THPStatus__c = BAT_ConstantsUtility.EMPTY_STRING;
                             }
                    //Checkin if Brand House contains Vype and then updating BAT_VapeStatus__c
                    //Souvik Dinda/US#338720 - Added condition for Brand House "Vuse" for setting the Vape Status to Prospect
                    //07.07.2022/Rajeswari N - Bug #1061278 - removed vape status not to cosumer check to not update to prospect
                    if (objAccRec.Brand_House__c != null &&
                        ((objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.VYPE_DEVICE_STR) &&
                          lstBrandTypes.contains(BAT_ConstantsUtility.VYPE_DEVICE_STR))
                         || (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.VUSE_DEVICE_STR) &&
                             lstBrandTypes.contains(BAT_ConstantsUtility.VUSE_DEVICE_STR))) 
                        && (objAccRec.BAT_VapeStatus__c == null || BAT_ConvertLeadController.isUpdatedBrandStatusOnConverison)) {
                            objAccRec.BAT_VapeStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                        }
                    //02.02.2024/ Reema Meher/ #1625729 - SE Lead Conversion and Forward Anonymisation
                    
                    if (objAccRec.Brand_House__c != null &&
                        (
                            (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Moor) && lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Moor)) ||
                            (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase()) && lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase())) ||
                            (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lundgrens) && lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lundgrens)) ||
                            (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lab) && lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lab)) ||
                            (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_lyftsw) && lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_lyftsw))
                        ) &&
                        (objAccRec.BAT_OralStatus__c == null || BAT_ConvertLeadController.isUpdatedBrandStatusOnConverison)
                       ) {
                           objAccRec.BAT_OralStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                       }
                    
                    //
                    //Making BAT_VapeStatus__c null if Brand House does not contain Vype
                    //Added lstBrandTypes.containsCheck - on Jan09th,2019/Prince Chawla/#75251 - Excecute only if the Brand house metaData contain the brand house as Vype.    
                    //30.10.2020/ Mallik Balla/ Bug #314845 - PL - Revert the Vape Status to Blank only if Brand House doesn't contain Yourchoice
                    //07.07.2022/Rajeswari N/ Bug #1061278 - Ch - removed AND condition and replaced oR condition to check brandhouse has Vuse or Vype
                    else if ((lstBrandTypes.contains(BAT_ConstantsUtility.VYPE_DEVICE_STR) || lstBrandTypes.contains(BAT_ConstantsUtility.VUSE_DEVICE_STR)) && (objAccRec.Brand_House__c == null || (objAccRec.Brand_House__c != null && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.VYPE_DEVICE_STR) && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.VUSE_DEVICE_STR) && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.STR_YOURCHOICE)) &&
                                                                                                                                                                objAccRec.BAT_VapeStatus__c != null && objAccRec.BAT_VapeStatus__c != BAT_ConstantsUtility.LEAD)) {
                                                                                                                                                                    objAccRec.BAT_VapeStatus__c = BAT_ConstantsUtility.EMPTY_STRING;
                                                                                                                                                                }
                    //Checkin if Brand House contains Velo and then updating BAT_OralStatus__c 
                    //13th Nov, 2019/Abhishek Kashyap/Updated condition to prevent status to change from lost to prospect if a lead of different brand is converted.
                    if (objAccRec.Brand_House__c != null && ( (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO) &&
                                                               lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)) || 
                                                             (objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_EPOK) &&
                                                              lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_EPOK)))//[PL] 25.06.2020/ Mallik Balla/ US#176027 : Added EPOK for PL
                        && (objAccRec.BAT_OralStatus__c == null || (BAT_ConvertLeadController.isUpdatedBrandStatusOnConverison && objAccRec.BAT_OralStatus__c != BAT_ConstantsUtility.LEAD_LOST)) 
                        && objAccRec.BAT_OralStatus__c != BAT_ConstantsUtility.ATH_CONSUMER) {
                            if(objAccRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_GR)){//1617822 / Feb 1, 2024 / Added GR country check to update oral status to Consumer
                                
                                objAccRec.BAT_OralStatus__c = BAT_ConstantsUtility.ATH_CONSUMER;
                                objAccRec.BAT_OralConsumerSince__c = Date.today();
                            }
                            else{
                                objAccRec.BAT_OralStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                            }
                            
                        }
                    //Making BAT_OralStatus__c null if Brand House does not contain Velo
                    //Added on Jan09th,2019/Prince Chawla/#75251 - Excecute only if the Brand house metaData contain the brand house as Velo
                    //30.10.2020/ Mallik Balla/ Bug #314845 - PL - Revert the Oral Status to Blank only if Brand House doesn't contain Yourchoice
                    //02.02.2024/ Reema Meher/ #1625729 - SE Lead Conversion and Forward Anonymisation
                    else if (lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO) && (objAccRec.Brand_House__c == null || (objAccRec.Brand_House__c != null 
                                                                                                                                        && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO) && 
                                                                                                                                        !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Moor) && 
                                                                                                                                        !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase())&& 
                                                                                                                                        !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lundgrens) && 
                                                                                                                                        !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Lab) && 
                                                                                                                                        !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_lyftsw) && 
                                                                                                                                        
                                                                                                                                        !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.STR_YOURCHOICE)) 
                                                                                                   && objAccRec.BAT_OralStatus__c != null && objAccRec.BAT_OralStatus__c != BAT_ConstantsUtility.LEAD && (!objAccRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)||(objAccRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_CH)&& objAccRec.BAT_OralStatus__c != BAT_ConstantsUtility.ATH_CONSUMER)))) {
                                                                                                       objAccRec.BAT_OralStatus__c = BAT_ConstantsUtility.EMPTY_STRING;
                                                                                                   }
                    //18th Feb,20201/Abhishek Kashyap/US-405628, Added logic to update Combustible Status field if Brand House contains FMC
                    //07.07.2022/Rajeswari N/ Bug #1062181,CH - removed Combustible Status check to not equal consumer and added null check to not update Combustible Status to prospect if already status present
                    if (objAccRec.Brand_House__c != null && objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_FMC) &&
                        lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_FMC) && objAccRec.BAT_CombustibleStatus__c == null) {
                            objAccRec.BAT_CombustibleStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                        }
                    else if (lstBrandTypes.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_FMC) 
                             && (objAccRec.Brand_House__c == null 
                                 || (objAccRec.Brand_House__c != null && !objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_FMC)))
                             && objAccRec.BAT_CombustibleStatus__c != null) {
                                 objAccRec.BAT_CombustibleStatus__c = BAT_ConstantsUtility.EMPTY_STRING;
                             }//US-405628-end
                }
                //Updating BAT_THPStatusValue__c field based on BAT_THPStatus__c and adding the same to duplication check string
                if (objAccRec.Brand_House__c != null && objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)) {
                    objAccRec.BAT_THPStatusValue__c = BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO;
                    strStatus = BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO;
                }
                //Updating BAT_VapeStatusValue__c field based on BAT_VapeStatus__c and adding the same to duplication check string
                if (objAccRec.Brand_House__c != null && objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.VYPE_DEVICE_STR)) {
                    objAccRec.BAT_VapeStatusValue__c = BAT_ConstantsUtility.VYPE_DEVICE_STR;
                    strStatus += BAT_ConstantsUtility.VYPE_DEVICE_STR;
                }
                //Bug#114834:Added LYFT and EPOK brandhouses related logic as part of PersonAccount duplicate rule fix 
                //Updating strstatus variable based on Brand House value and adding the same to duplication check string
                if (objAccRec.Brand_House__c != null && objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT.toUppercase())) {
                    strStatus += BAT_ConstantsUtility.BAT_BRAND_HOUSE_LYFT;
                }
                //Bug#114834:Updating BAT_EpokLyftStatusValue__c field based on BAT_OralStatus__c and adding the same to duplication check string
                if (objAccRec.Brand_House__c != null && objAccRec.Brand_House__c.contains(BAT_ConstantsUtility.EPOKLYFT_DEVICE_STR)) {
                    objAccRec.BAT_EpokLyftStatusValue__c = String.valueOf(objAccRec.BAT_OralStatus__c);
                    strStatus += BAT_ConstantsUtility.EPOKLYFT_DEVICE_STR;
                }
                //End of PersonAccount duplicate rule fix related to LYFT and EPOK brandhouses
                //Updating BAT_CombustibleStatusValue__c field based on BAT_CombustibleStatus__c and adding the same to duplication check string
                if (String.isNotBlank(objAccRec.BAT_CombustibleStatus__c)) {
                    objAccRec.BAT_CombustibleStatusValue__c = String.valueOf(objAccRec.BAT_CombustibleStatus__c);
                    strStatus += BAT_ConstantsUtility.COMBUSTIBLE_DEVICE_STR;
                }
                //Bug#114834:Commented the below logic as part Person Account duplicate rule fix as below condition should hold brandhouse check 
                //instead of Oral status as this status used across mutiple brandhouse values 
                /*//Updating BAT_EpokLyftStatusValue__c field based on BAT_OralStatus__c and adding the same to duplication check string
if (String.isNotBlank(objAccRec.BAT_OralStatus__c)) {
objAccRec.BAT_EpokLyftStatusValue__c = String.valueOf(objAccRec.BAT_OralStatus__c);
strStatus += BAT_ConstantsUtility.EPOKLYFT_DEVICE_STR;
}*/
                //Updating BAT_CountryValue__c field based on Country__c
                /*if (String.isNotBlank(objAccRec.Country__c)) {
objAccRec.BAT_CountryValue__c = objAccRec.Country__c;
}*/
                //Setting the duplication check string 'strStatus' value in field 'BAT_ConsumerStatus__c'
                /*[PL] 25.06.2020/ Mallik Balla/ US# 128832: Added below condition to by-pass Duplicate Rule which is firing for Brand specific for Lead 
For PL, we're NOT setting the  BAT_ConsumerStatus__c field on Lead so that the duplicate Leads will be matched ONLY based on Email & Country */              
                if(String.isNotBlank(objAccRec.country__c) 
                   && !objAccRec.country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_PL)){
                       objAccRec.BAT_ConsumerStatus__c = strStatus;
                   }
            }
        }
    }
    /************************************************************************************************
@ Author: Deloitte
@ Method: checkForBlacklistAccounts
@ Description: DE: BUG - 20177, This method is used to check for blacklist accounts and prevent their creation or update.
@ retuns: N/A
@ params: Account[] accountList, List of accounts to be inserted or updated
@ Change history:24-04-2019: Abhishek Kashyap DE: BUG - 20177, Created the method.
10-07-2019: Divya Eduvulapati AT: US - 21140 ,Updated the method so that blacklist records will be checked against account records that belongs to same  country and displays the error in case of any match before insert/update of DE and AT Accounts.
*********************************************************************************************************************************/
    public void checkForBlacklistAccounts(Account[] accountList) {
        Set<String> blacklistedNames = new Set<String>();
        Set<String> blacklistedEmails = new Set<String>();
        Set<String> blacklistedEmailDomains= new Set<String>();
        // 26-02-2020/Osheen Sahajpal/ Added countrySet variable to have account countries to avoid 101 SOQL queries
        Set<String> countrySet = new Set<String>(); 
        String strName;
        String strNameforBlacklist;
        String strEmail;
        String strEDomain;
        // 26-02-2020/Osheen Sahajpal/ Added values countrySet to have account countries to avoid 101 SOQL queries
        for(Account accRec : accountList){
            countrySet.add(accRec.Country__c);
        }
        //Query to get all the records of Blacklist object
        // 26-02-2020/Osheen Sahajpal/ Updating Blacklist SOQL query to retrieve country specific records to avoid 101 SOQL queries
        List<Blacklist__c> lstblacklist = [Select Id, First_name__c, Last_Name__c, Email__c, Email_Domain__c,BAT_Country__c From Blacklist__c where BAT_Country__c IN :countrySet];
        if (!lstblacklist.isEmpty()) {
            //Checks for blacklisted names, emails and domain names and adds them to their respective lists.
            for (Blacklist__c blacklistRec: lstblacklist) {
                
                strName =(String.isBlank(blacklistRec.First_name__c)? '' : blacklistRec.First_name__c)  + (String.isBlank(blacklistRec.Last_Name__c)? '' : blacklistRec.Last_Name__c);
                if (!String.isBlank(strName)) {
                    //Appended Country code before blacklisted names
                    strName=blacklistRec.BAT_Country__c+strName;
                    blacklistedNames.add(strName.toUpperCase());
                }
                if (!String.isBlank(blacklistRec.Email__c)) {
                    //Appended Country code before blacklisted emails
                    strEmail=blacklistRec.BAT_Country__c+blacklistRec.Email__c;
                    blacklistedEmails.add(strEmail.toUpperCase());
                }
                if (!String.isBlank(blacklistRec.Email_Domain__c)) {
                    //Checks for '@' in domain name, if found, skips the character and adds the rest to the list, or else, adds domain name to the list.
                    if (blacklistRec.Email_Domain__c.contains(BAT_ConstantsUtility.DOMAINANNOTATION)) {
                        strEDomain=blacklistRec.Email_Domain__c.substringAfterLast(BAT_ConstantsUtility.DOMAINANNOTATION);
                        //Appended Country code before blacklisted emaildomains
                        strEDomain=blacklistRec.BAT_Country__c+strEDomain;
                        blacklistedEmailDomains.add(strEDomain.toUpperCase());
                    } else {
                        //Appended Country code before blacklisted emaildomains
                        strEDomain=blacklistRec.BAT_Country__c+blacklistRec.Email_Domain__c;
                        blacklistedEmailDomains.add(strEDomain.toUpperCase());
                    }
                }
            }
            if (!blacklistedNames.isEmpty() || !blacklistedEmails.isEmpty() || !blacklistedEmailDomains.isEmpty()) {
                for (Account accountRec: accountList) {
                    
                    //frames name by concatenating first and last names.
                    //Appended Country code before Acount Name,Acount Email and Acount EmailDomains for making code feasible to check against only the account's country related blacklist records.
                    strName =(String.isBlank( accountRec.FirstName)? '' : accountRec.FirstName)  + (String.isBlank(accountRec.LastName)? '' : accountRec.LastName);
                    strNameforBlacklist =accountRec.Country__c+(String.isBlank( accountRec.FirstName)? '' : accountRec.FirstName)  + (String.isBlank(accountRec.LastName)? '' : accountRec.LastName);
                    strEmail=accountRec.Country__c+accountRec.PersonEmail;
                    strEDomain=accountRec.Country__c+accountRec.PersonEmail.substringAfterLast(BAT_ConstantsUtility.DOMAINANNOTATION);
                    
                    //Checks whether the account contains a name, email or domain name listed in the blacklist object and if found then adds error to the record. 
                    if ((!String.isBlank(strName) && blacklistedNames.contains(strNameforBlacklist.toUpperCase())) 
                        || (!String.isBlank(accountRec.PersonEmail) && (blacklistedEmails.contains(strEmail.toUpperCase()) || blacklistedEmailDomains.contains(strEDomain.toUpperCase())))) {
                            accountRec.addError(system.label.BAT_Lead_Blacklist_Error_Message);
                        }
                }
            }
        }
        
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : validateAccountBrandHouse
* @returns       : void
* @params        : Account[] updatedAccount, Map<ID, Account> oldAccountMap
* @description   : This method is used for validating brand house values of Account before inserting and updating the record.
* @changeHistory : 05.29.2019/Gaurav Mehrishi/Updated the method to incorporate brand validations for community users
06.12.2019/Abhishek Kashyap/ US# 37563 UCCAB Multi - Brand House on Lead and Consumer, Refactored the code to apply validations for Brand House.
20.09.2019/Abhishek Kashyap/Optimized code to restrict brand house validations to fire only for person account record types only.
10.10.2019/Abhsihek Kashyap/BUG - 52631, Restricted users from creating account of brand not avalilable for them.
23.10.2019/Abhishek Kashyap/BUG - 55848, Streamlined validation flow and execution
*********************************************************************************************************/
    public void validateAccountBrandHouse(Account[] updatedAccount, Map <ID,Account> oldAccountMap) {
        List<Account> lstAccount = new List<Account>();
        Account objOldAcc;
        Boolean isValidationFailed = false;
        Map<String,BAT_BrandHouseValidation__mdt> accountValidationMap = new Map<String,BAT_BrandHouseValidation__mdt>();
        List<BAT_BrandHouseValidation__mdt> accountValidationList = [Select Label, BAT_BrandHouseMandatory__c, BAT_BrandHouseMandatoryMessageEN__c, BAT_BrandHouseMandatoryMessageLocal__c, 
                                                                     BAT_RestrictBrand__c, BAT_RestrictBrandMessageEN__c, BAT_RestrictBrandMessageLocal__c, 
                                                                     BAT_RestrictToUserBrand__c, BAT_RestrictToUserBrandMessageEN__c, BAT_RestrictToUserBrandMessageLocal__c,
                                                                     BAT_BrandAllowed__c
                                                                     from BAT_BrandHouseValidation__mdt];
        for(BAT_BrandHouseValidation__mdt accountValidationObj : accountValidationList){
            if(!accountValidationMap.containsKey(accountValidationObj.Label)){
                accountValidationMap.put(accountValidationObj.Label, accountValidationObj);
            }
        }
        for(Account accRec: updatedAccount){
            if(accountValidationMap.keySet().contains(accRec.Country__c) && ((oldAccountMap!=null && (accRec.Country__c != 'ES') && (accRec.Brand_House__c!=oldAccountMap.get(accRec.Id).Brand_House__c)) || oldAccountMap == null)){
                lstAccount.add(accRec);
            }
        }
        //20.09.2019/Abhishek Kashyap/Optimized code to restrict brand house validations to fire only for person account record types only.
        if (!lstAccount.isEmpty()){
            for (Account accRec: lstAccount) {
                if(!isValidationFailed 
                   && accountValidationMap.keySet().contains(accRec.Country__c) 
                   && accountValidationMap.get(accRec.Country__c).BAT_BrandHouseMandatory__c 
                   && string.isBlank(accRec.Brand_House__c)
                   && accRec.IsPersonAccount){
                       if(UserInfo.getLanguage().contains(BAT_ConstantsUtility.USER_LANGUAGE_ENGLISH)){
                           accRec.addError(accountValidationMap.get(accRec.Country__c).BAT_BrandHouseMandatoryMessageEN__c);
                           isValidationFailed = true;
                       }else{
                           accRec.addError(accountValidationMap.get(accRec.Country__c).BAT_BrandHouseMandatoryMessageLocal__c);
                           isValidationFailed = true;
                       }
                   }
                if(!isValidationFailed && accountValidationMap.keySet().contains(accRec.Country__c) && accountValidationMap.get(accRec.Country__c).BAT_RestrictBrand__c
                   && accRec.IsPersonAccount && !string.isBlank(accRec.Brand_House__c)){
                       for(String brandHouseString : accRec.Brand_House__c.split(BAT_ConstantsUtility.BAT_SEMICOLON_STR)){
                           if(UserInfo.getLanguage().contains(BAT_ConstantsUtility.USER_LANGUAGE_ENGLISH) && !accountValidationMap.get(accRec.Country__c).BAT_BrandAllowed__c.split(BAT_ConstantsUtility.COMMA_STR).contains(brandHouseString)){
                               accRec.addError(accountValidationMap.get(accRec.Country__c).BAT_RestrictBrandMessageEN__c);
                               isValidationFailed = true;
                           }else if(!UserInfo.getLanguage().contains(BAT_ConstantsUtility.USER_LANGUAGE_ENGLISH) && !accountValidationMap.get(accRec.Country__c).BAT_BrandAllowed__c.split(BAT_ConstantsUtility.COMMA_STR).contains(brandHouseString)){
                               accRec.addError(accountValidationMap.get(accRec.Country__c).BAT_RestrictBrandMessageLocal__c);
                               isValidationFailed = true;
                           }
                       }
                   }
                //10.10.2019/Abhsihek Kashyap/BUG - 52631, Restricted users from creating account of brand not avalilable for them.
                if(Trigger.isBefore 
                   && Trigger.isInsert 
                   && !isValidationFailed
                   && accountValidationMap.keySet().contains(accRec.Country__c) 
                   && accountValidationMap.get(accRec.Country__c).BAT_RestrictToUserBrand__c
                   && accRec.IsPersonAccount){
                       for(String brandHouseString : accRec.Brand_House__c.split(BAT_ConstantsUtility.BAT_SEMICOLON_STR)){
                           if(String.isBlank(user.BAT_Brand__c) 
                              || (!String.isBlank(user.BAT_Brand__c) 
                                  && !user.BAT_Brand__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON).contains(brandHouseString))){
                                      if(UserInfo.getLanguage().contains(BAT_ConstantsUtility.USER_LANGUAGE_ENGLISH)){
                                          accRec.addError(accountValidationMap.get(accRec.Country__c).BAT_RestrictToUserBrandMessageEN__c);
                                          isValidationFailed = true;
                                      }else if(!UserInfo.getLanguage().contains(BAT_ConstantsUtility.USER_LANGUAGE_ENGLISH)){
                                          accRec.addError(accountValidationMap.get(accRec.Country__c).BAT_RestrictToUserBrandMessageLocal__c);
                                          isValidationFailed = true;
                                      }
                                  }
                       }
                   }
                if (!isValidationFailed && !accountValidationMap.keySet().contains(accRec.Country__c) && user.BAT_Brand__c == BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE) {
                    
                    //For update
                    if (oldAccountMap != null && oldAccountMap.get(accRec.Id) != null) {
                        
                        objOldAcc = new Account();
                        objOldAcc = oldAccountMap.get(accRec.Id);
                        
                        //Retailers cannot add Brand House of Glo Type
                        if (objOldAcc.Brand_House__c == BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE && accRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)) {
                            
                            accRec.addError(system.label.BAT_Brand_House_Restrict_Glo);
                            isValidationFailed = true ;
                            //Retailers cannot remove Brand House Glo
                        } else if (objOldAcc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) &&
                                   objOldAcc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE) && !accRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)) {
                                       
                                       accRec.addError(system.label.BAT_Brand_House_Restrict_Glo_Removal);
                                       isValidationFailed = true;
                                   }
                        
                        //For Insert
                    } else {
                        //Retailers can only create Account with Brand House Vype
                        if (accRec.Brand_House__c != BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE) {
                            accRec.addError(system.label.BAT_Brand_House_Vype_Only);
                            isValidationFailed = true;
                        }
                    }
                    
                } else if (!isValidationFailed && !accountValidationMap.keySet().contains(accRec.Country__c) && user.BAT_Brand__c == BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) {
                    
                    //For update
                    if (oldAccountMap != null && oldAccountMap.get(accRec.Id) != null) {
                        
                        objOldAcc = new Account();
                        objOldAcc = oldAccountMap.get(accRec.Id);
                        
                        //This User cannot add Brand House of Vype Type
                        if (objOldAcc.Brand_House__c == BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO && accRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE)) {
                            
                            accRec.addError(system.label.BAT_Brand_House_Restrict_Vype);
                            isValidationFailed = true;
                            //This User cannot remove Brand House Vype
                        } else if (objOldAcc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE) && !accRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE)) {
                            
                            accRec.addError(system.label.BAT_Brand_House_Restrict_Vype_Removal);
                            isValidationFailed = true;
                        }
                        
                        //For Insert
                    } else {
                        //This User can only create Account with Brand House Glo
                        if (accRec.Brand_House__c != BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) {
                            accRec.addError(system.label.BAT_Brand_House_Glo_Only);
                            isValidationFailed = true;
                        }
                    }
                }
            }
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : checkExistingLeadToUpdateAccount
* @returns       : void
* @params        : Account[] updatedAccount, Map<ID, Account> oldAccountMap
* @description   : This method is used to bypass duplication rule when person account is getting updated to add brand for which lead exists.
: 22.03.2022/Rama Akella /KZ/ US#804167: Bypassing the duplicate National ID validation for converted Leads
*********************************************************************************************************/
    public void checkExistingLeadToUpdateAccount(Account[] updatedAccount, Map < ID, Account > oldAccountMap) {
        
        List<Account> lstAccount = new List<Account>();
        List<String> strEmails = new List<String>();
        set<String> strEmailCountrySet = new set<String>();
        Set<String> setCountries = new Set<String>();
        List<Lead> lstLeadsToUpdate = new List<Lead>();
        Map<String,List<Lead>> mapEmailToLeads = new Map<String,List<Lead>>();
        Map<String,BAT_BrandStatusUpdateConfiguration__mdt> mapcountryToUpdateBrandStatusmdt = new Map<String,BAT_BrandStatusUpdateConfiguration__mdt>();
        Set<String> duplicateNationalIdAccounts = new Set<String>();
        //Getting Countries of accounts in a set
        for (Account objAccRec: updatedAccount) {
            setCountries.add(objAccRec.Country__c);
        }
        //Querying "BAT_BrandStatusUpdateConfiguration__mdt" custom metadata records for countries for which different brand categories are present 
        List < BAT_BrandStatusUpdateConfiguration__mdt > lstUpdateBrandStatusmdt = [SELECT MasterLabel, BAT_CheckExistingLeadOrAccount__c, BAT_Country__c, BAT_BrandStatusType__c, BAT_RecordTypeCheck__c
                                                                                    FROM BAT_BrandStatusUpdateConfiguration__mdt
                                                                                    WHERE BAT_Country__c IN: setCountries
                                                                                    AND BAT_Object__c =: BAT_ConstantsUtility.STANDARD_ACCOUNT_STR
                                                                                   ];
        //Getting all the metadata records in a map, mapped with 'country'
        for (BAT_BrandStatusUpdateConfiguration__mdt mdtUpdateBrandStatusRec: lstUpdateBrandStatusmdt) {
            if (!mapcountryToUpdateBrandStatusmdt.containsKey(mdtUpdateBrandStatusRec.BAT_Country__c)) {
                mapcountryToUpdateBrandStatusmdt.put(mdtUpdateBrandStatusRec.BAT_Country__c, mdtUpdateBrandStatusRec);
            }
        }
        for (Account accRec: updatedAccount) {
            //Checking if metadata record exists for the country of the account record
            if (mapcountryToUpdateBrandStatusmdt.containsKey(accRec.Country__c) && accRec.IsPersonAccount) {
                //On Update of Brand House
                if (oldAccountMap == null || (oldAccountMap != null && (accRec.Brand_House__c != oldAccountMap.get(accRec.Id).Brand_House__c) ||
                                              (accRec.PersonEmail != oldAccountMap.get(accRec.Id).PersonEmail))) {
                                                  //Adding account in a separate list to minimize the iteration
                                                  lstAccount.add(accRec);
                                                  //adding emails to the list
                                                  //Added if condition to resolve Non selective query exception
                                                  if(accRec.PersonEmail !=null){
                                                      strEmailCountrySet.add(accRec.Country__c);
                                                      strEmails.add(accRec.PersonEmail);
                                                  }
                                              }
            }
        }
        if (!strEmails.isEmpty() || (!mapCountryNationalId.isEmpty() && mapCountryNationalId.containsKey(BAT_ConstantsUtility.COUNTRY_KZ) && mapCountryNationalId.get(BAT_ConstantsUtility.COUNTRY_KZ) != null)) {
            //Querying lead records with same emails in the system and storing in a map
            //US#804167: Bypassing the duplicate National ID validation for converted Leads
            for (Lead objLeadRec: [SELECT Id, Email, Country__c,National_ID__c,
                                   Brand_House__c 
                                   FROM Lead WHERE 
                                   (Country__c != null and 
                                    Country__c IN : strEmailCountrySet and
                                    Email != null and 
                                    Email IN: strEmails) OR (National_ID__c <> null AND National_ID__c =: mapCountryNationalId.get(BAT_ConstantsUtility.COUNTRY_KZ) AND Is_Converted__c = FALSE)]) {
                                        if (mapEmailToLeads.containsKey(objLeadRec.Email)) {
                                            mapEmailToLeads.get(objLeadRec.Email).add(objLeadRec);
                                        } else {
                                            mapEmailToLeads.put(objLeadRec.Email, new List < Lead > {
                                                objLeadRec
                                                    });
                                        }
                                        if(String.isNotBlank(objLeadRec.National_ID__c) && objLeadRec.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_KZ) && ((!leadsToBypassNationalIdValidation.isEmpty() && !leadsToBypassNationalIdValidation.contains(objLeadRec.Id)) || leadsToBypassNationalIdValidation.isEmpty())){
                                            duplicateNationalIdAccounts.add(objLeadRec.National_ID__c);
                                        }
                                    }
        }
        if (!lstAccount.isEmpty()) {
            //Iterating account list to fetch any account record which has email same as that of lead email and Brand house
            for (Account accRec: lstAccount) {
                //Checking if Lead exist with the same email
                if (mapEmailToLeads.containsKey(accRec.PersonEmail)) {
                    for (Lead leadRec: mapEmailToLeads.get(accRec.PersonEmail)) {
                        if (oldAccountMap != null &&
                            accRec.Brand_House__c != oldAccountMap.get(accRec.Id).Brand_House__c &&
                            null != leadRec.Brand_House__c &&
                            accRec.Brand_House__c.contains(leadRec.Brand_House__c) &&
                            accRec.PersonEmail == oldAccountMap.get(accRec.Id).PersonEmail) {
                                //Updating BAT_BypassDuplicateRule__c field to true to bypass duplication rule
                                accRec.BAT_BypassAccountDuplicateRule__c = True;
                            }
                        //Checking for the BAT_CheckExistingLead__c checkbox of metadata record
                        if ((oldAccountMap == null || (oldAccountMap != null && accRec.PersonEmail != oldAccountMap.get(accRec.Id).PersonEmail)) &&
                            mapcountryToUpdateBrandStatusmdt.get(accRec.Country__c).BAT_CheckExistingLeadOrAccount__c) {
                                //If Account's Brand is glo and existing lead is of Vype, updating vape status to Lead
                                if (string.isNotBlank(accRec.Brand_House__c) && accRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) &&
                                    string.isNotBlank(leadRec.Brand_House__c) && leadRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE)) {
                                        accRec.BAT_VapeStatus__c = BAT_ConstantsUtility.LEAD;
                                    }
                                //If Account's Brand is Vype and existing lead is of Glo, updating THP status to Lead
                                else if (string.isNotBlank(accRec.Brand_House__c) && accRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VYPE) &&
                                         string.isNotBlank(leadRec.Brand_House__c) && leadRec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)) {
                                             accRec.BAT_THPStatus__c = BAT_ConstantsUtility.LEAD;
                                         }
                            }
                    }
                }
            }
        }
        //Add error to account with duplicate national Id
        if(!duplicateNationalIdAccounts.isEmpty()){
            for(Account account: updatedAccount){
                if(duplicateNationalIdAccounts.contains(account.National_ID__c))
                    account.addError(Label.BAT_KZ_Account_NationalIdExistsErrorMessage);
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : accountPrivacyConsentFlagUpdate
* @returns       : void
* @params        : Account[] lstNewAccounts
* @description   : Updates Vype Privacy Consent flags of Account if the same for Glo is true while creating the lead
* @changeHistory : 18.04.2019/Shreeyanshu Kumar/Created the method
: //1 Mar 2023/ Praveen/ US #1284980/  IT - Glo Sharpend API integration from 3rd Party Retail to SF (QR code) - part2
: //1 Sep 2023/ Lalit/ US #1449657/  IT Vuse and glo consents during Account creation changes
*********************************************************************************************************/
    public void accountPrivacyConsentFlagUpdate(Account[] lstNewAccounts) {
        
        Set<String> setCountries = new Set<String>();
        Map<String,BAT_BrandStatusUpdateConfiguration__mdt> mapcountryToUpdateBrandStatusmdt = new Map<String,BAT_BrandStatusUpdateConfiguration__mdt>();
        
        //Adding countries of Assets in a set
        for (Account objAccRec: lstNewAccounts) {
            setCountries.add(objAccRec.Country__c);
        }
        //Getting BAT_BrandStatusUpdateConfiguration__mdt records for countries in setCountries for which BAT_UpdateVypePrivacyConsentFlags__c is true
        List < BAT_BrandStatusUpdateConfiguration__mdt > lstUpdateBrandStatusmdt = [SELECT MasterLabel, BAT_Country__c
                                                                                    FROM BAT_BrandStatusUpdateConfiguration__mdt
                                                                                    WHERE BAT_Object__c =: BAT_ConstantsUtility.STANDARD_ACCOUNT_STR
                                                                                    AND BAT_Country__c IN: setCountries
                                                                                    AND BAT_UpdateVypePrivacyConsentFlags__c = true
                                                                                   ];
        //Getting all the queried BAT_BrandStatusUpdateConfiguration__mdt records in a map, mapped with key as country
        
        if (!lstUpdateBrandStatusmdt.isEmpty()) {
            
            for (BAT_BrandStatusUpdateConfiguration__mdt mdtUpdateBrandStatusRec: lstUpdateBrandStatusmdt) {
                if (!mapcountryToUpdateBrandStatusmdt.containsKey(mdtUpdateBrandStatusRec.BAT_Country__c)) {
                    mapcountryToUpdateBrandStatusmdt.put(mdtUpdateBrandStatusRec.BAT_Country__c, mdtUpdateBrandStatusRec);
                }
            }
            
            for (Account objAccRec: lstNewAccounts) {
                
                //Checking if te functionality is expected for the lead record according to the BAT_BrandStatusUpdateConfiguration__mdt
                //US #1449657/  Bypassing Glo/Vype consent updatation for IT country
                if (mapcountryToUpdateBrandStatusmdt.containsKey(objAccRec.Country__c)) {
                    
                    //If Email and Marketing Research (Glo) is checked, then checking Email and Marketing Research (Vype)
                    //1 Mar 2023/ Praveen/ US #1284980/  IT - Glo Sharpend API integration from 3rd Party Retail to SF (QR code) - part2
                    //1666626--IT | Vuse privacy consents migration to multicategory privacy consents (Leads/Accounts)
                    if (objAccRec.Country__c !=BAT_ConstantsUtility.COUNTRY_IT && objAccRec.Generic_Permission__c && !objAccRec.BAT_IsVypeOptInEmailCommunication__c && (String.isNotBlank(objAccRec.AccountSource) && !objAccRec.AccountSource.equalsIgnoreCase(BAT_ConstantsUtility.BAT_ACCOUNT_SOURCE))) {
                        objAccRec.BAT_IsVypeOptInEmailCommunication__c = true;
                    }
                    //If Email and Marketing Research (Vype) is checked, then checking Email and Marketing Research (Glo)
                    else if (objAccRec.BAT_IsVypeOptInEmailCommunication__c && !objAccRec.Generic_Permission__c) {
                        objAccRec.Generic_Permission__c = true;
                    }
                    //If Calls and SMS Marketing Research (Glo) is checked, then checking Calls and SMS Marketing Research (Vype)
                    //1 Mar 2023/ Praveen/ US #1284980/  IT - Glo Sharpend API integration from 3rd Party Retail to SF (QR code) - part2
                    //1666626--IT | Vuse privacy consents migration to multicategory privacy consents (Leads/Accounts)
                    if (objAccRec.Country__c !=BAT_ConstantsUtility.COUNTRY_IT && objAccRec.Trial_Information_Permission__c && !objAccRec.BAT_IsVypeOptInMobileTextWhatsApp__c && (String.isNotBlank(objAccRec.AccountSource) && !objAccRec.AccountSource.equalsIgnoreCase(BAT_ConstantsUtility.BAT_ACCOUNT_SOURCE))) {
                        objAccRec.BAT_IsVypeOptInMobileTextWhatsApp__c = true;
                    }
                    //If Calls and SMS Marketing Research (Vype) is checked, then checking Calls and SMS Marketing Research (Glo)
                    else if (objAccRec.BAT_IsVypeOptInMobileTextWhatsApp__c && !objAccRec.Trial_Information_Permission__c) {
                        objAccRec.Trial_Information_Permission__c = true;
                    }
                }
            }
        }
    }
    
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : createTrialOnTrialistUpdate
* @returns       : void
* @params        : Account[] lstNewAccounts
* @description   : IT-Vype: Sprint2: US#15157: Create Trial for the accounts which got updated to Trialist through THP Status
* @changeHistory : 22.04.2019/Shreeyanshu Kumar/Created the method
: 22.08.2019/Tejaswi Nissankula/Added logic for UA and KZ to insert opportunity when is trailist is true
23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
*********************************************************************************************************/
    public void createTrialOnTrialistUpdate(Account[] lstNewAccounts, Map < ID, Account > oldAccountMap) {
        Set<String> setCountries = new Set<String>();
        Map<String,BAT_BrandStatusUpdateConfiguration__mdt> mapcountryToUpdateBrandStatusmdt = new Map<String,BAT_BrandStatusUpdateConfiguration__mdt>();
        List<Opportunity> opportunityToAdd = new List<Opportunity>();
        List<Account> lstAccountsForTrial = new List<Account>();
        Boolean isUCCAB = false;
        //Adding countries of Assets in a set
        for (Account objAccRec: lstNewAccounts) {
            setCountries.add(objAccRec.Country__c);
        }
        //Getting BAT_BrandStatusUpdateConfiguration__mdt records for countries in setCountries for which BAT_UpdateVypePrivacyConsentFlags__c is true
        List < BAT_BrandStatusUpdateConfiguration__mdt > lstUpdateBrandStatusmdt = [SELECT MasterLabel, BAT_Country__c
                                                                                    FROM BAT_BrandStatusUpdateConfiguration__mdt
                                                                                    WHERE BAT_Object__c =: BAT_ConstantsUtility.STANDARD_ACCOUNT_STR
                                                                                    AND BAT_Country__c IN: setCountries
                                                                                    AND BAT_StartTrialOnTrialistUpdate__c = true
                                                                                   ];
        //Added as part of US37833
        if(user != null && string.isNotBlank(user.Country__c)){
            BAT_Utilities.defineMarket marketResult = BAT_Utilities.globalMarketDuplicateCheckSetting(new set<string>{user.Country__c},new List<string>{BAT_ConstantsUtility.STANDARD_ACCOUNT_STR});
            isUCCAB = marketResult.isUCCAB;
        }
        //End of US37833
        if (!lstUpdateBrandStatusmdt.isEmpty() && !user.BAT_BypassTrialCreation__c) {
            
            //Getting all the queried BAT_BrandStatusUpdateConfiguration__mdt records in a map, mapped with key as country
            for (BAT_BrandStatusUpdateConfiguration__mdt mdtUpdateBrandStatusRec: lstUpdateBrandStatusmdt) {
                if (!mapcountryToUpdateBrandStatusmdt.containsKey(mdtUpdateBrandStatusRec.BAT_Country__c)) {
                    mapcountryToUpdateBrandStatusmdt.put(mdtUpdateBrandStatusRec.BAT_Country__c, mdtUpdateBrandStatusRec);
                }
            }
            for (Account objAccRec: lstNewAccounts) {
                
                //Checking if THP Status of an Account has been changed to 'Trialist'
                if (objAccRec.BAT_THPStatus__c != oldAccountMap.get(objAccRec.Id).BAT_THPStatus__c &&
                    (objAccRec.BAT_THPStatus__c == BAT_ConstantsUtility.ACC_STATUS_TRIALIST ||
                     (objAccRec.Is_Trialist__c != oldAccountMap.get(objAccRec.Id).Is_Trialist__c && objAccRec.Is_Trialist__c == true && isUCCAB)) &&
                    objAccRec.RecordTypeId == oldAccountMap.get(objAccRec.Id).RecordTypeId) {
                        //Creating new Opportunity record
                        Opportunity trialOpty = new Opportunity();
                        trialOpty.Name = BAT_ConstantsUtility.BAT_TRIAL_HYPHEN + objAccRec.FirstName + BAT_ConstantsUtility.SINGLE_SPACE + objAccRec.LastName;
                        trialOpty.CloseDate = Date.Today().addDays(30);
                        if (String.isNotBlank(objAccRec.Passionate_Owner__c)) {
                            trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_INTRIAL;
                            trialOpty.Start_Date__c = System.today();
                            trialOpty.CloseDate = System.today() + 15;
                            trialOpty.Trial_Ended_Date__c = System.today() + 15;
                        } else {
                            trialOpty.StageName = BAT_ConstantsUtility.TRIAL_STAGENAME_OPEN;
                        }
                        trialOpty.Country__c = objAccRec.Country__c;
                        trialOpty.AccountId = objAccRec.Id;
                        opportunityToAdd.add(trialOpty);
                        
                        lstAccountsForTrial.add(objAccRec);
                    }
            }
            try {
                //Added Null check before DML operation as part of ForceReviewer changes.
                //inserting new Opportunities
                if (opportunityToAdd != null && !opportunityToAdd.isEmpty()) {
                    insert opportunityToAdd;
                }
            } catch (Exception ex) { for (Account objAcc: lstAccountsForTrial) {
                system.debug('++ex.getMessage() '+ex.getMessage());
                system.debug('++ex '+ex);
                objAcc.addError(ex.getMessage());
            }
                                   }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : copyTHPStatusToStatus
* @returns       : void
* @params        : void
* @description   : AZ: Sprint2: US#35795: AZ - Multi - Update references of old status with THP Status in the Code
* @changeHistory : 2.08.2019/Akshata Rajmane/Created the method
*********************************************************************************************************/
    public void copyTHPStatusToStatus() {
        List<Account> newAcc = new List<Account>();
        Map<Id,Account> oldAcc = new Map<Id,Account>();
        newAcc = (List<Account>) trigger.new;
        if(trigger.oldMap != null){
            oldAcc = (Map<Id,Account>) trigger.oldMap;
        }
        Map<String,String> countryMdt = new Map<String,String>();
        //get the metadata records
        for(BAT_THPStatusGlobalSetting__mdt rec :[select MasterLabel,BAT_Country__c from BAT_THPStatusGlobalSetting__mdt])
        {
            if(!countryMdt.containsKey(rec.BAT_Country__c))
            {
                countryMdt.put(rec.BAT_Country__c,rec.MasterLabel);  
            }
        }
        for(Account acc : newAcc)
        {
            //if country is present in meta records then copy value of THP status to status
            if(countryMdt.containsKey(acc.Country__c) && !String.isBlank(acc.BAT_THPStatus__c))
            {
                if(oldAcc.isEmpty())
                {
                    acc.Status__c = acc.BAT_THPStatus__c;
                }else if(oldAcc.get(acc.id) != null && oldAcc.get(acc.id).BAT_THPStatus__c != acc.BAT_THPStatus__c){
                    acc.Status__c = acc.BAT_THPStatus__c;
                }
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : updateLeadOnInsertOrUpdateOfIntegratedAcc
* @returns       : void
* @params        : List<Account>,Boolean,Boolean
* @description   : [UCCAB(UA,KZ)]Method is used to convert non converted lead when brand house and mobile number of lead is same as
the account inserted/updated by intergration user.
* @changeHistory : 10.09.2019/Tejaswi Nissankula/Created the method
09.10.2019/Abhishek Kashyap/Updated the method to update status field on lead based on brand
10.10.2019/Abhishek Kashyap/bug - 52839, Updated the code to convert lead only after account is inserted
14.10.2019/Abhishek Kashyap/BUG-53290, updating brand specific status fields on lead when an account with different brand house but with same mobile is inserted.
14.04.2020/Tejaswi Nissankula/KZ-Glo:US#104695/Added logic to flow External Subscriber 2 data from lead to person account on auto Glo lead conversion when eCommerce Glo account is inserted/updated .
19.10.2020/Dipika Gupta/US#292087/Added logic for CZ when eCommerce account is inserted with existing phone number on lead, convert lead to person account 
08-Dec-2020/Roopa N/ Added acc.Convert__c == false to the condition to not execute automatic lead conversion logic while converting lead manually with last modified Source as eCommerce values.
:8:03:2021 /Akshata Rajmane/GR - Lead conversion based on updated duplication logic (email OR phone)
13.04.2021 /Dipika / #449349 : Lead Conversion Logic added condition for PL 
: 07.01.2022 / Allada yeshwanth  / #728622 / Adding Country_SK for Lead conversion
*********************************************************************************************************/
    public static void updateLeadOnInsertOrUpdateOfIntegratedAcc(List<Account> accounts,boolean isInsert,boolean isUpdate){
        List<Lead> uccabLeadList = new List<Lead>();
        Map<Id,Lead> mapLeadsToUpdate = new Map<Id,Lead>(); //Us#37833
        Map<String, Account> uccabIntegratedAccounts = new Map<String, Account>();//Added as part of Bug 43982
        Map<Id,Lead> updateLeadMap = new Map<Id,Lead>();
        set<string> uccabIntegratedAccCountrySet = new set<string>();
        List<Account> lstProductInterestAccs = new List<Account>();
        Set<ID> setProductInterestLeads = new Set<ID>();
        
        Map<String, Account> plEmailAccounts = new Map<String, Account>();
        //if account's accountsource is present in accSourceSet(which contains all integration user related account source set) then 
        //fill uccabIntegratedAccounts map.
        //Dipika Gupta/US#292087/if account is CZ, check Lead with existing phone number
        //08-Dec-2020/Roopa N/ Added acc.Convert__c == false to the condition to not execute automatic lead conversion logic while converting lead manually with last modified Source as eCommerce values.
        /*08.03.2021 / Akshata Rajmane/ GR - Lead conversion based on updated duplication logic (email OR phone) */
        /*13.04.2021 / Dipika/ PL - Lead conversion based on updated duplication logic ( phone) */
        //21.06.21 / Allada Yeshwanth / #538696 / Reverting the #449349 changes
        //04.10.2021 / Allada yeshwanth / US : #709734 / Adding Same Mobile Number Auto COnversion for RS
        //06.12.2021 / Turbasu Ghosh / #823567 / Adding Country_HR for Lead conversion
        // 07.01.2022 / Allada yeshwanth  / #728622 / Adding Country_SK for Lead conversion
        //  21.07.2023/Varaprasad Sada/US#1294646/RO-newsletter vuse.ro & newsletter glo.ro--added RO related logic
        //  22.Nov.2023/BJSURAJ/ #1520643/SE/DK- Technical Setup - Lead Conversion Logic// added SE/DK country check
        //  1648877  DE - Lead2account conversion--added by hima
        for(Account acc : accounts){
           
            if((acc.Country__c == BAT_ConstantsUtility.COUNTRY_UA || 
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_KZ ||
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || 
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_SK || 
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_RS ||
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_HR || 
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_GR ||
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_CY ||
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_RO ||
                (!Test.isRunningTest()&&acc.Country__c == BAT_ConstantsUtility.COUNTRY_FR) ||//1769553
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_DK ||
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_DE_STR ||
                acc.Country__c == BAT_ConstantsUtility.COUNTRY_SE) &&
               
               //US#530277 : Bypass this method for Retailer record Type
               (acc.RecordTypeId != retailerRecordTypeId) &&
               !accSourceSet.isEmpty() && acc.Convert__c == false &&
               ((isInsert &&
                 String.isNotBlank(acc.AccountSource) && 
                 BAT_Utilities.containsIgnoreCaseCheck(accSourceSet,acc.AccountSource)) ||
                (isUpdate &&
                 String.isNotBlank(acc.Last_Modified_Source__c) && BAT_Utilities.containsIgnoreCaseCheck(accSourceSet,acc.Last_Modified_Source__c)))){
                     uccabIntegratedAccounts.put(acc.PersonMobilePhone,acc);
                     uccabIntegratedAccCountrySet.add(acc.Country__c);
                     system.debug('uccabIntegratedAccountsTest'+uccabIntegratedAccounts);
                     system.debug('uccabIntegratedAccCountrySetTest'+uccabIntegratedAccCountrySet);
                     //US#1294646--start
                     //#1520643/BJSURAJ/added SE/DK country Check
                     if(acc.Country__c == BAT_ConstantsUtility.COUNTRY_RO || acc.Country__c == BAT_ConstantsUtility.COUNTRY_DK || 
                        acc.Country__c == BAT_ConstantsUtility.COUNTRY_SE){
                            plEmailAccounts.put(acc.PersonEmail,acc);
                            system.debug('plEmailAccountsTest'+plEmailAccounts);
                            //US#1294646--end
                        }
                 }
            
        }
        if(!uccabIntegratedAccounts.isEmpty()){
            //retrieve if any non converted lead present with account's mobile number
            //Added BAT_ExternalSubscriberID2__c in query as part of KZ#US#104695
            ////US#1294646--retrieve leads with the emails for RO
            //#1520643/BJSURAJ/added SE/DK country Check
            if(uccabLeadList.isEmpty()){
                uccabLeadList = [SELECT Id,Email,ownerId,
                                 MobilePhone,Brand_House__c,
                                 Country__c,
                                 BAT_ExternalSubscriberID2__c                                      
                                 from Lead where
                                 Country__c != null and 
                                 Country__c IN : uccabIntegratedAccCountrySet and
                                 ((MobilePhone != null and 
                                   MobilePhone In : uccabIntegratedAccounts.keySet()) OR (Email!=null  and Email In : plEmailAccounts.keySet() and (Country__c =:BAT_ConstantsUtility.COUNTRY_RO OR Country__c =: BAT_ConstantsUtility.COUNTRY_DK OR Country__c =: BAT_ConstantsUtility.COUNTRY_SE))) and
                                 isConverted = false];
            }
            system.debug('uccabLeadListTest'+uccabLeadList);
            //Dipika Gupta/US#292087/if account is CZ, brand house is not checked with User brand
            if(!uccabLeadList.isEmpty()){
                for(Lead rec : uccabLeadList){
                    //#1520643/BJSURAJ/added SE/DK country Check
                    if(uccabIntegratedAccounts.containsKey(rec.MobilePhone)||(plEmailAccounts.containsKey(rec.Email)&& (rec.Country__c==BAT_ConstantsUtility.COUNTRY_RO || rec.Country__c== BAT_ConstantsUtility.COUNTRY_DK || rec.Country__c== BAT_ConstantsUtility.COUNTRY_SE))){
                        //US#1294646--get the account if leads are not blank
                        Account localAcc =  plEmailAccounts.get(rec.Email)!=null?plEmailAccounts.get(rec.Email):uccabIntegratedAccounts.get(rec.MobilePhone);
                        system.debug('localAccTest'+localAcc);
                        //fill updateLeadMap to update the lead record type with converted and owner with login user. 
                        /*08.03.2021 / Akshata Rajmane/ GR - Lead conversion based on updated duplication logic (email OR phone) */
                        /*13.04.2021 / Dipika/ PL - Lead conversion based on updated duplication logic (phone) */
                        //21.06.2021 / Allada Yeshwanth / #538696 / Reversing the #449349 changes
                        // 04.10.2021 / Allada yeshwanth / #709734 / Adding Mobile Auto Convert for RS
                        //06.12.2021 / Turbasu Ghosh / #823567 / Adding Country_HR for Lead conversion
                        // 07.01.2022 / Allada yeshwanth  / #728622 / Adding Country_SK for Lead conversion
                        //#1520643/BJSURAJ/added SE/DK country Check
                        if(localAcc != null &&
                           (
                               (string.isNotBlank(localAcc.Brand_House__c) &&
                                string.isNotBlank(rec.Brand_House__c) &&
                                string.valueOf(localAcc.Brand_House__c).contains(string.valueOf(rec.Brand_House__c)) 
                               )  || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_CZ || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_RS || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_HR || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_SK ||
                               localAcc.country__c == BAT_ConstantsUtility.COUNTRY_GR || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_CY || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_RO || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_DK || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_SE||
                               localAcc.country__c == BAT_ConstantsUtility.COUNTRY_DE_STR || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_FR)//1769553
                           &&
                           user != null &&  string.isNotBlank(user.BAT_Brand__c) && (localAcc.country__c == BAT_ConstantsUtility.COUNTRY_GR || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_CY || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_CZ || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_RS || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_HR || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_SK || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_DK || localAcc.country__c == BAT_ConstantsUtility.COUNTRY_SE|| user.BAT_Brand__c.contains(string.valueOf(rec.Brand_House__c)))){                               //09.10.2019/Abhishek Kashyap/Updated the method to populate Related Lead field on Account
                               system.debug('localAccTestcheck'); 
                               if(Trigger.isBefore){
                                   localAcc.BAT_BypassAccountDuplicateRule__c = true;
                                   if(String.isBlank(localAcc.Related_Lead__c)){
                                       localAcc.Related_Lead__c = rec.Id;
                                   }
                                   //Added below logic as part of KZ#US#104695 by Tejaswi
                                   //Set the BAT_ExternalSubscriberID2__c on account duirng lead conversion
                                   if(localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_KZ && localAcc.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && 
                                      rec.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO) && 
                                      string.isNotBlank(rec.BAT_ExternalSubscriberID2__c)){
                                          localAcc.BAT_ExternalSubscriberID2__c = rec.BAT_ExternalSubscriberID2__c;
                                      }//End of US#104695
                                   if(Trigger.isUpdate && string.isNotBlank(localAcc.Last_Modified_Source__c) &&
                                      localAcc.Last_Modified_Source__c.containsIgnoreCase(BAT_ConstantsUtility.ECOMM_GLO_STR)){
                                          localAcc.OwnerId = userinfo.getUserId();    
                                      }
                               }
                               rec.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.CONVERTED).getRecordTypeId();
                               //09.10.2019/Abhishek Kashyap/Updated the method to update status field on lead based on brand
                               //[PL] 25.06.2020/ Mallik Balla/ US# 176027 : Moved the code to the utility method.
                               /* 08.03.2021 / Akshata Rajmane/ GR - Lead conversion based on updated duplication logic (email OR phone)
Added code update brandhouse on Account*/                            
                               /*28.09.2021/ Tanmoy Bardhan/ Bug 1144489/ CZ - Added Brand house concatenation logic for Account from Lead
during Lead convert */    
                               //US#1294646--added RO condition
                               //#1520643/BJSURAJ/added SE/DK country Check
                               if(rec.Country__c == BAT_ConstantsUtility.COUNTRY_GR || rec.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || rec.Country__c == BAT_ConstantsUtility.COUNTRY_CY||rec.Country__c == BAT_ConstantsUtility.COUNTRY_RO || rec.Country__c == BAT_ConstantsUtility.COUNTRY_SK || rec.country__c == BAT_ConstantsUtility.COUNTRY_DK || rec.country__c == BAT_ConstantsUtility.COUNTRY_DE_STR ){                                 
                                   List<String> setLeadBrands = new List<String>();
                                   if(String.isNotBlank(rec.Brand_House__c)){
                                       setLeadBrands = rec.Brand_House__c.split(BAT_ConstantsUtility.SEMI_COLON);
                                       system.debug('setLeadBrandsTest'+setLeadBrands); 
                                       if(!setLeadBrands.isEmpty()){
                                           for(String strBrand : setLeadBrands){
                                               if(!localAcc.Brand_House__c.contains(strBrand)){
                                                   localAcc.Brand_House__c+=BAT_ConstantsUtility.SEMI_COLON+strBrand;
                                               }
                                           }
                                       }
                                   }
                               }
                               BAT_Utilities.setLeadAccountStatusField(rec,null);
                               if(!Trigger.isBefore){
                                   //Dipika Gupta/US#292087/if account is CZ, add account and lead in list and set for updating product interest
                                   //Pratishtha Pathak/BUG: 865763 // adding condition for SK to get product interest on accounts after lead conversion
                                   if(localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_CZ || localAcc.Country__c == BAT_ConstantsUtility.COUNTRY_SK){
                                       lstProductInterestAccs.add(localAcc);
                                       setProductInterestLeads.add(rec.ID);
                                   }
                                   updateLeadMap.put(rec.Id,rec);
                               }
                           }
                        //14.10.2019/Abhishek Kashyap/BUG-53290, updating brand specific status fields on lead when an account with different brand house but with same mobile is inserted.
                        else if(Trigger.isBefore && localAcc != null
                                && string.isNotBlank(localAcc.Brand_House__c) && string.isNotBlank(rec.Brand_House__c)
                                && !string.valueOf(localAcc.Brand_House__c).contains(string.valueOf(rec.Brand_House__c))){
                                    If(rec.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)||
                                       rec.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)||
                                       rec.Brand_House__c.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VUSE)){ 
                                           localAcc.BAT_THPStatus__c = BAT_ConstantsUtility.STANDARD_LEAD_STR;
                                           system.debug('localAcc.BAT_THPStatus__cTest'+localAcc.BAT_THPStatus__c); 
                                       }
                                    else{
                                        localAcc.BAT_OralStatus__c = BAT_ConstantsUtility.STANDARD_LEAD_STR;
                                        system.debug('localAcc.BAT_THPStatus__cTestelse'+localAcc.BAT_OralStatus__c); 
                                    }
                                }
                    }
                }
            }
            //Dipika Gupta/US#292087/if account is CZ, update Account on Product interest related to Lead
            if(Trigger.isInsert && Trigger.isAfter
               && !lstProductInterestAccs.isEmpty() && !setProductInterestLeads.isEmpty()){
                   List<BAT_ProductInterest__c> lstPIsToUpdate = BAT_Utilities.updateProductInterestAndLeadRecords(lstProductInterestAccs,setProductInterestLeads);
                   if(lstPIsToUpdate != null && !lstPIsToUpdate.isEmpty()){
                       update lstPIsToUpdate;
                   }
               }
            if(!updateLeadMap.isEmpty()){
                BAT_ConstantsUtility.isTriggerBypassed = true;
                update updateLeadMap.values();
                system.debug('updateLeadMapTest'+updateLeadMap.values()); 
                //09.10.2019/Abhishek Kashyap/BUG - 49454, Condition to ensure that method is executed for both before and after events.
                BAT_ConstantsUtility.LTH_LEADCONVERT = true;
                BAT_ConstantsUtility.isTriggerBypassed =  false;
                List<Database.LeadConvert> leadConvertList = new List<Database.LeadConvert>();
                // below logic used to perform the bulk lead conversion
                for(Lead rec : updateLeadMap.values()){
                    Database.LeadConvert leadConvert = new Database.LeadConvert();
                    leadConvert.setLeadId(rec.id);
                    leadConvert.setConvertedStatus(BAT_ConstantsUtility.CONVERTED);
                    leadConvert.setDoNotCreateOpportunity(true);  
                    //US#1294646--start
                    if(rec.Country__c==BAT_ConstantsUtility.COUNTRY_RO){
                        leadConvert.setAccountId(plEmailAccounts.get(rec.Email).id);
                    } //US#1294646---end
                    else{
                        leadConvert.setAccountId(uccabIntegratedAccounts.get(rec.MobilePhone).id);  
                    }
                    leadConvertList.add(leadConvert);
                }
                if(!leadConvertList.isEmpty()){
                    Database.LeadConvertResult[] lcrList;
                    for(Integer i = 0; i <= leadConvertList.size()/100 ; i++){
                        list<Database.LeadConvert> tempList = new list<Database.LeadConvert>();
                        Integer startIndex = i*100;
                        Integer endIndex = ((startIndex+100) < leadConvertList.size()) ? startIndex+100: leadConvertList.size();
                        for(Integer j=startIndex;j<endIndex;j++){
                            tempList.add(leadConvertList[j]);
                        }
                        //10.10.2019/Abhishek Kashyap/bug - 52839, Updated the code to convert lead only after account is inserted
                        if(!tempList.isEmpty()){
                            lcrList = Database.convertLead(tempList, false);
                        }
                    } 
                    if(lcrList != null && !lcrList.isEmpty()){
                        for(Database.LeadConvertResult lcr : lcrList){
                            Lead localRec;
                            if(lcr.getLeadId() != null && updateLeadMap.containsKey(lcr.getLeadId())){
                                localRec = updateLeadMap.get(lcr.getLeadId());
                            }
                            if(!lcr.isSuccess() && localRec != null){
                                Account acc = uccabIntegratedAccounts.get(localRec.MobilePhone);
                                for(Database.Error error : lcr.getErrors()){
                                    acc.addError(error.getMessage());
                                }
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : OnBeforeDelete
* @returns       : void
* @params        : List<Account>
* @description   : [All Markets]Method to handle Deletion of privacy snapshot records logic of account
* @changeHistory : 09.30.2019/Satya Nalluri/Created the method
23.03.2020/Tejaswi Nissankula/ Added Null check before DML operation as part of ForceReviewer changes.
*********************************************************************************************************/
    
    public void OnBeforeDelete(Account[] deletedAccount) {
        List<Id> deletdAccountIds = new List<Id>();
        for(Account acc: deletedAccount){
            deletdAccountIds.add(acc.id);
        }
        if(!deletdAccountIds.isEmpty()){
            List<ContentDocument> delPrivacyDocs = BAT_Utilities.deletePrivacySanpshots(deletdAccountIds);
            
            //Added Null check before DML operation as part of ForceReviewer changes.
            if(delPrivacyDocs != null && !delPrivacyDocs.isEmpty()){
                delete delPrivacyDocs;
            }
        }
        //account merge
        //CZ loyality starts//
        //05.11.2023 /Reema Meher- [CZ] US#1454597-UA - CZ - multicategory loyalty program - CRM & M2
        mergeaccounts(deletedAccount);
        //CZ loyality ends//
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : revertIncorrectAccountStatusFieldChanges
* @returns       : void
* @params        : List<Account>, Map<Id,Account>
* @description   : [UCCAB]Method to prevent incorrect update of account brand status fields
* @changeHistory : 18.10.2019/Ushabala Kanduru/Created the method
20.12.2019/Abhishek Kashyap/US-64690, CA - Admin Portal - Logic for Vape Consumer Status
*********************************************************************************************************/
    public void revertIncorrectAccountStatusFieldChanges(Account[] updatedAccount, Map <ID,Account> oldAccountMap){
        List<Account> uccabAccountList = new List<Account>();
        //20.12.2019/Abhishek Kashyap/US-64690, Added a new list to save all CA accounts.
        List<Account> caAccountList = new List<Account>();
        //Creates a list of UCCAB Accounts
        
        for(Account eachAccount:updatedAccount){
            if(String.isNotBlank(eachAccount.Country__c) && (eachAccount.Country__c == BAT_ConstantsUtility.COUNTRY_UA || eachAccount.Country__c == BAT_ConstantsUtility.COUNTRY_KZ)){
                uccabAccountList.add(eachAccount);
            }
            //20.12.2019/Abhishek Kashyap/US-64690, Added condition to add CA accounts to the list.
            if(String.isNotBlank(eachAccount.Country__c) && eachAccount.Country__c == BAT_ConstantsUtility.COUNTRY_CA_STR){
                caAccountList.add(eachAccount);
            }
        }
        if(!uccabAccountList.isEmpty()){
            for(Account eachUccabAccount : uccabAccountList){
                //If THP Status is Blank then it can't be changed to Lost.
                if(((oldAccountMap == null && String.isNotBlank(eachUccabAccount.BAT_THPStatus__c))
                    ||(oldAccountMap != null && String.isBlank(oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c)))
                   &&((eachUccabAccount.BAT_THPStatus__c == BAT_ConstantsUtility.PROSPECT 
                       && String.isNotBlank(eachUccabAccount.Brand_House__c) 
                       && !eachUccabAccount.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO))
                      || eachUccabAccount.BAT_THPStatus__c == BAT_ConstantsUtility.LEAD_DE_STATUS_LOST)){
                          eachUccabAccount.BAT_THPStatus__c = BAT_ConstantsUtility.BLANK;
                      }
                //If Oral Status is Blank then it can't be changed to Lost.
                if(((oldAccountMap == null && String.isNotBlank(eachUccabAccount.BAT_OralStatus__c))
                    ||(oldAccountMap != null && String.isBlank(oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c)))
                   &&((eachUccabAccount.BAT_OralStatus__c == BAT_ConstantsUtility.PROSPECT 
                       && String.isNotBlank(eachUccabAccount.Brand_House__c) 
                       && !eachUccabAccount.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO))
                      || eachUccabAccount.BAT_OralStatus__c == BAT_ConstantsUtility.LEAD_DE_STATUS_LOST)){
                          eachUccabAccount.BAT_OralStatus__c = BAT_ConstantsUtility.BLANK;
                      }
                //If THP Status is Lead then it can't be changed to Blank/ Prospect/ Lost.
                if(oldAccountMap != null && oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c == BAT_ConstantsUtility.LEAD_STR 
                   && (String.isBlank(eachUccabAccount.BAT_THPStatus__c)
                       || (eachUccabAccount.BAT_THPStatus__c == BAT_ConstantsUtility.PROSPECT 
                           && String.isNotBlank(eachUccabAccount.Brand_House__c) 
                           && !eachUccabAccount.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO))
                       || eachUccabAccount.BAT_THPStatus__c == BAT_ConstantsUtility.LEAD_DE_STATUS_LOST)){
                           eachUccabAccount.BAT_THPStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c;
                       }
                //If Oral Status is Lead then it can't be changed to Blank/ Prospect/ Lost.
                if(oldAccountMap != null  && oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c == BAT_ConstantsUtility.LEAD_STR 
                   && ((String.isBlank(eachUccabAccount.BAT_OralStatus__c))
                       || (eachUccabAccount.BAT_OralStatus__c == BAT_ConstantsUtility.PROSPECT && String.isNotBlank(eachUccabAccount.Brand_House__c) 
                           && !eachUccabAccount.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)) || eachUccabAccount.BAT_OralStatus__c == BAT_ConstantsUtility.LEAD_DE_STATUS_LOST)){
                               eachUccabAccount.BAT_OralStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c;
                           }
                //If THP Status is Prospect then it can't be changed to Blank. It can only be changed to Lost.
                if(oldAccountMap != null 
                   && oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c == BAT_ConstantsUtility.PROSPECT 
                   && (String.isBlank(eachUccabAccount.BAT_THPStatus__c))){
                       eachUccabAccount.BAT_THPStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c;
                   }
                //If Oral Status is Prospect then it can't be changed to Blank. It can only be changed to Lost. 
                if(oldAccountMap != null 
                   && oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c == BAT_ConstantsUtility.PROSPECT 
                   && (String.isBlank(eachUccabAccount.BAT_OralStatus__c))){
                       eachUccabAccount.BAT_OralStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c;
                   }
                //If THP Status is Consumer then it can't be changed to Blank. It can only be changed to Lost/Prospect.
                if(oldAccountMap != null 
                   && oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c == BAT_ConstantsUtility.OTH_CONSUMER
                   && String.isBlank(eachUccabAccount.BAT_THPStatus__c)){
                       eachUccabAccount.BAT_THPStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c;
                   }
                //If Oral Status is Consumer then it can't be changed to Blank. It can only be changed to Lost/Prospect.
                if(oldAccountMap != null 
                   && oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c == BAT_ConstantsUtility.OTH_CONSUMER  && String.isBlank(eachUccabAccount.BAT_OralStatus__c)){
                       eachUccabAccount.BAT_OralStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c;
                   }
                //If THP Status is Lost, then it can't be changed to Blank. It can only be changed to Prospect.
                if(oldAccountMap != null 
                   && oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c == BAT_ConstantsUtility.LEAD_DE_STATUS_LOST && (String.isBlank(eachUccabAccount.BAT_THPStatus__c))){
                       eachUccabAccount.BAT_THPStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_THPStatus__c;
                   }
                //If Oral Status is Lost, then it can't be changed to Blank. It can only be changed to Prospect.
                if(oldAccountMap != null 
                   && oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c == BAT_ConstantsUtility.LEAD_DE_STATUS_LOST && (String.isBlank(eachUccabAccount.BAT_OralStatus__c))){
                       eachUccabAccount.BAT_OralStatus__c = oldAccountMap.get(eachUccabAccount.Id).BAT_OralStatus__c;
                   }
            }
        }
        //20.12.2019/Abhishek Kashyap/US-64690, Added logic to restrict update of vape status from consumer to trialist
        if(!caAccountList.isEmpty()){
            for(Account eachCaAccount : caAccountList){
                if(oldAccountMap != null && oldAccountMap.get(eachCaAccount.Id).BAT_VapeStatus__c == BAT_ConstantsUtility.OTH_CONSUMER
                   && (String.isBlank(eachCaAccount.BAT_VapeStatus__c) || eachCaAccount.BAT_VapeStatus__c == BAT_ConstantsUtility.ACC_STATUS_TRIALIST)){
                       eachCaAccount.BAT_VapeStatus__c = oldAccountMap.get(eachCaAccount.Id).BAT_VapeStatus__c;
                   }
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : UpdateAccountRecordtypeOralStatusFieldChanges
* @returns       : void
* @params        : No Params
* @description   : [ID] : US# 227057: Method to Update Account Recordtype when Oral Status is Changed
* @changeHistory : 24.07.2020/Roopa N/Created the method
05-Aug-2020/Roopa N/[ID] : US# 256630: Added logic to update Account Recordtype to Direct Consumer when Oral Status is Consumer.
*********************************************************************************************************/
    
    public void UpdateAccountRecordtypeOralStatusFieldChanges()
    {
        List<Account> newAccount = new List<Account>(); // List of Accounts to store new Accounts
        Map<Id,Account> oldAccountMap = new Map<Id,Account>(); // map of accounts to store old accounts
        Map<String,String> mapOfCoutnryToBrand = new Map<String,String>();
        for(BAT_GuestAccountRecordTypeConfiguration__mdt meta : BAT_GuestAccountRecordTypeConfiguration__mdt.getAll().values())
        {
            mapOfCoutnryToBrand.put(meta.MasterLabel , meta.BAT_BrandStatusAPIName__c);
        }
        newAccount = (List<Account>)trigger.new;
        //Added condition to add old accounts to Map
        if(trigger.oldMap != null)
            oldAccountMap = (Map<Id,Account>) trigger.oldMap;
        String GuestRecordTypeId = recordTypeDevNameMap.get(BAT_ConstantsUtility.ACC_RECTYPE_GUEST);   
        String consumerRecordTypeId = recordTypeDevNameMap.get(BAT_ConstantsUtility.ACC_RECTYPE_DIRECTCON);
        for(Account account: newAccount)
        {
            if(oldAccountMap.isEmpty())
            {
                //If Oral Status is Guest then Acccount Recordtype is updated to Guest
                if(String.isNotBlank(Account.Country__c) && mapOfCoutnryToBrand.containsKey(Account.Country__c) && 
                   String.isNotBlank(String.valueOf(account.get(mapOfCoutnryToBrand.get(account.Country__c)))) &&
                   account.get(mapOfCoutnryToBrand.get(Account.Country__c)) == BAT_ConstantsUtility.ATH_GUEST)
                {
                    account.RecordTypeId = GuestRecordTypeId;
                }
            }
            else
            {
                //If Oral Status is updated from "Guest" to "Prospect/Consumer" then Account Recordtype is updated to "Direct Consumer"
                if(String.isNotBlank(account.Country__c) && mapOfCoutnryToBrand.containsKey(Account.Country__c) 
                   && oldAccountMap.get(account.id) != null &&
                   oldAccountMap.get(account.id).get(mapOfCoutnryToBrand.get(Account.Country__c)) != null &&
                   oldAccountMap.get(account.id).get(mapOfCoutnryToBrand.get(Account.Country__c)) == BAT_ConstantsUtility.ATH_GUEST
                   && oldAccountMap.get(account.id).get(mapOfCoutnryToBrand.get(Account.Country__c)) != account.get(mapOfCoutnryToBrand.get(Account.Country__c)) 
                   && (account.get(mapOfCoutnryToBrand.get(Account.Country__c)) == BAT_ConstantsUtility.ATH_PROSPECT || account.get(mapOfCoutnryToBrand.get(Account.Country__c)) == BAT_ConstantsUtility.ATH_CONSUMER))
                {
                    account.RecordTypeId = consumerRecordTypeId;
                }           
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : updateAccountUponDeAnonymization
* @returns       : void
* @params        : 
* @description   : [RO] : US# 445129: Method to Update Is Anonymized field to False when Partially anonymized account rentering into SF via Integration
* @changeHistory : 24th Mar,2021/Roopa N/Created the method
Added logic to update Is Anonymized field to False for Partially Anonymized when External Customer ID 5/ External Customer ID 3 is passing from Integration.
5th April,2021/Roopa N/RO:US#461730 - Update Last consent date, Month 24 Anonymize Date when a partially anonymized account is re-registering again.
6th April,2021/Abhishek Kashyap/US-466621-RO - Technical Setup - Account Source refinement when partially anonymised account is re-registered
20th April,2021/Roopa N/RO :US#489095 -When partially anonymized account is re-registering again with same mobile number by GloStore/Flagship profile users then update append account's Brand House with Glo & THP status to prospect.
*********************************************************************************************************/
    public void updateAccountUponDeAnonymization(Account[] updatedAccount, Map <ID,Account> oldAccountMap)
    {
        List<String> lstFields = new List<String>();
        boolean isExecuting = false;
        //6th April,2021/Abhishek Kashyap/US-466621-RO-Map to save Profile vs Account Source value. 
        Map<String,String> profileToAccountSourceMap = new Map<String,String>();
        Map<String,BAT_DeAnonymizationMarketConfiguration__mdt> mapCountryToDeAnonymizeAccounts = new map<String,BAT_DeAnonymizationMarketConfiguration__mdt>();
        //6th April,2021/Abhishek Kashyap/US-466621-Added BAT_AccountSourceList__c, BAT_ProfileList__c fields having ; separated Account Source and profile lists
        for(BAT_DeAnonymizationMarketConfiguration__mdt rec: [SELECT MasterLabel,BAT_FieldToUpdate__c,BAT_FieldAPIName__c,BAT_ProfileList__c,
                                                              BAT_AccountSourceList__c, BAT_DaysToAnonymize__c,BAT_ExcludeProfileBrandHouseStatusUpdate__c
                                                              FROM BAT_DeAnonymizationMarketConfiguration__mdt]){
                                                                  mapCountryToDeAnonymizeAccounts.put(rec.MasterLabel,rec); 
                                                                  //6th April,2021/Abhishek Kashyap/US-466621-If each profile has it's corresponding Account source mentioned then the method is called and map is populated
                                                                  if(rec.BAT_ProfileList__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON).size() == rec.BAT_AccountSourceList__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON).size()){
                                                                      profileToAccountSourceMap.putAll(setProfileVsAccountSourceMap(rec.BAT_ProfileList__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON), rec.BAT_AccountSourceList__c.split(BAT_ConstantsUtility.ORDER_SEMICOLON)));
                                                                  }
                                                              }
        for(Account eachAccount : updatedAccount){ 
            if(mapCountryToDeAnonymizeAccounts.containsKey(eachAccount.Country__c)){
                lstFields = mapCountryToDeAnonymizeAccounts.get(eachAccount.Country__c).BAT_FieldAPIName__c.split(BAT_ConstantsUtility.COMMA_STR);
            }
            if(String.isNotBlank(eachAccount.Country__c) && mapCountryToDeAnonymizeAccounts.containsKey(eachAccount.Country__c) &&
               oldAccountMap != null && oldAccountMap.get(eachAccount.id) != null &&
               oldAccountMap.get(eachAccount.id).get(mapCountryToDeAnonymizeAccounts.get(eachAccount.Country__c).BAT_FieldToUpdate__c) == true
               && oldAccountMap.get(eachAccount.id).PersonMobilePhone != null && oldAccountMap.get(eachAccount.Id).PersonMobilePhone == eachAccount.PersonMobilePhone){
                   for(String apistr : lstFields){
                       if(oldAccountMap.get(eachAccount.id).get(apistr) == null && 
                          eachAccount.get(apistr) != null &&
                          oldAccountMap.get(eachAccount.id).get(apistr) != eachAccount.get(apistr)){
                              isExecuting = true;   
                              //6th April,2021/Abhishek Kashyap/US-466621-Assigning last modified source to accountsource if partially anonymized accounts are re-registered by Integration
                              eachAccount.AccountSource = eachAccount.Last_Modified_Source__c;
                          }
                   }
                   if(isExecuting){
                       eachAccount.put(mapCountryToDeAnonymizeAccounts.get(eachAccount.Country__c).BAT_FieldToUpdate__c,false);
                   }
                   //Added as part of RO:US#461730
                   if(eachAccount.BAT_Is_Anonymised__c == false && eachAccount.Registration_Permission__c == true 
                      && oldAccountMap.get(eachAccount.id).Registration_Permission__c != eachAccount.Registration_Permission__c
                      && eachAccount.BAT_ConsentDate__c == null)
                   {
                       eachAccount.BAT_ConsentDate__c = System.NOW();
                       eachAccount.Month_24_Anonymize_Date__c = Date.ValueOf(eachAccount.BAT_ConsentDate__c.addDays(Integer.ValueOf(mapCountryToDeAnonymizeAccounts.get(eachAccount.Country__c).BAT_DaysToAnonymize__c)));
                   }
               }
            //6th April,2021/Abhishek Kashyap/US-466621-Based on the User's logged in profile the source is assigned to Account Source for partially anonymized accounts
            if(oldAccountMap != null && oldAccountMap.get(eachAccount.Id).BAT_Is_Anonymised__c != eachAccount.BAT_Is_Anonymised__c
               && !eachAccount.BAT_Is_Anonymised__c && profileToAccountSourceMap.containsKey(user.Profile.Name) 
               && oldAccountMap.get(eachAccount.Id).PersonMobilePhone == eachAccount.PersonMobilePhone){
                   eachAccount.AccountSource = profileToAccountSourceMap.get(user.Profile.Name);
                   //Added as part of RO :US#489095
                   if(mapCountryToDeAnonymizeAccounts.get(eachAccount.Country__c).BAT_ExcludeProfileBrandHouseStatusUpdate__c != null
                      && !mapCountryToDeAnonymizeAccounts.get(eachAccount.Country__c).BAT_ExcludeProfileBrandHouseStatusUpdate__c.containsIgnoreCase(user.Profile.Name)){
                          if(String.isBlank(eachAccount.Brand_House__c)){
                              eachAccount.Brand_House__c = BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO;
                          }
                          else if(!eachAccount.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO))
                          {
                              eachAccount.Brand_House__c = eachAccount.Brand_House__c+BAT_ConstantsUtility.ORDER_SEMICOLON+BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO;
                          }
                          if(eachAccount.Brand_House__c != null && eachAccount.Brand_House__c.contains(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)
                             && eachAccount.BAT_THPStatus__c != BAT_ConstantsUtility.ATH_CONSUMER && eachAccount.BAT_THPStatus__c != BAT_ConstantsUtility.ATH_PROSPECT){
                                 eachAccount.BAT_THPStatus__c = BAT_ConstantsUtility.ATH_PROSPECT;
                             }
                      }//END US#489095
               }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : formatAccountMobile
* @returns       : void
* @params        : List<Account>
* @description   : [ID] Bug#284828 - Account: Formatted Mobile: To remove prefix zero from the PersonMobileNumber 
* @changeHistory : 22.09.2020 - Anna Gomez(Deloitte) - Created method
24.09.2020 - Edwin Resendiz - Add isblank condition to personMobilePhone
*********************************************************************************************************/
    public void formatAccountMobile(List<Account> accounts)
    {
        Map<String,BAT_AccountMobileFormattingConfiguration__mdt> formatMdtMap = new Map<String,BAT_AccountMobileFormattingConfiguration__mdt>();
        for(BAT_AccountMobileFormattingConfiguration__mdt formatMdt : [SELECT BAT_Country__c, BAT_DigitToBeReplacedWith__c, 
                                                                       BAT_DigitToReplace__c, BAT_PositionIndex__c 
                                                                       FROM BAT_AccountMobileFormattingConfiguration__mdt]){ 
                                                                           formatMdtMap.put(formatMdt.BAT_Country__c, formatMdt);
                                                                       }
        
        if(!formatMdtMap.isEmpty()){
            for(Account account : accounts){
                if(formatMdtMap.containsKey(account.Country__c)){
                    BAT_AccountMobileFormattingConfiguration__mdt mdt = formatMdtMap.get(account.Country__c);
                    if(!string.isBlank(account.PersonMobilePhone) && string.valueof(account.PersonMobilePhone.indexOf(mdt.BAT_DigitToReplace__c)).equals(mdt.BAT_PositionIndex__c)){
                        account.BAT_FormattedMobile__c = (account.PersonMobilePhone.substring(0, integer.valueof(mdt.BAT_PositionIndex__c)) + 
                                                          account.PersonMobilePhone.substring(integer.valueof(mdt.BAT_PositionIndex__c)).removeStart(mdt.BAT_DigitToReplace__c)).removeStart(BAT_ConstantsUtility.PLUS_SIGN);
                    }
                }
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : purgePersonEmailAccount
* @returns       : void
* @params        : List<Account>
* @description   : [RO] US#405626-RO - Technical Setup - Gmail verification check for offline acounts
* @changeHistory : 25Feb/Abhishek Kashyap/Created the method
*                   17th March,2020/Abhishek Kashyap/US#434292-RO-Added emailString and countryString parameters, to extend the func for duplicate 
*                   check from EmailVerification Screen.
*********************************************************************************************************/
    public static void purgePersonEmailAccount(List<Account> newAccountList, Map<Id,Account> oldAccountMap, String emailString, String countryString)
    {
        //List holds new accounts or accounts with changed PersonEmail field
        List<Account> emailChangedAccountList = new List<Account>();
        //Map to hold country vs list of domains and list of characters to be removed
        Map<String,DomainNameSpecialCharListWrapper> purgePersonEmailFieldMap = new Map<String,DomainNameSpecialCharListWrapper>();
        //loop starts
        //Added null check to cover the scenario when the method is called from EmailVerification Screen
        if(newAccountList != null){
            for(Account eachAccount : newAccountList){
                //Check to pull new accounts or accounts with changed PersonEmail field
                if((oldAccountMap == null && String.isNotBlank(eachAccount.PersonEmail))||
                   (String.isNotBlank(eachAccount.PersonEmail) 
                    && !eachAccount.PersonEmail.equalsIgnoreCase(oldAccountMap.get(eachAccount.Id).PersonEmail))){
                        emailChangedAccountList.add(eachAccount);
                    }
            }//loop ends
        }
        //Added check for Account list or emailString
        if(!emailChangedAccountList.isEmpty() || String.isNotBlank(emailString)){
            //Metadata query to get the config for the markets opted in to purge the PersonEmail field and save it on Email__c
            for(BAT_PurgePersonEmailField__mdt eachPurgePersonEmailField : [Select MasterLabel, BAT_DomainName__c, BAT_SpecialCharactersToRemove__c, BAT_DefaultDomain__c
                                                                            From BAT_PurgePersonEmailField__mdt]){
                                                                                //Adding values to the metadata
                                                                                purgePersonEmailFieldMap.put(eachPurgePersonEmailField.MasterLabel, 
                                                                                                             new DomainNameSpecialCharListWrapper(eachPurgePersonEmailField.BAT_DomainName__c.split(BAT_ConstantsUtility.COMMA_STR), eachPurgePersonEmailField.BAT_SpecialCharactersToRemove__c.split(BAT_ConstantsUtility.BLANK), eachPurgePersonEmailField.BAT_DefaultDomain__c));
                                                                            }
            //This condition purges email if comming in form EmailVerification screen and sets the purgedEmailString variable
            if(String.isNotBlank(emailString)){
                BAT_ConstantsUtility.purgedEmailString = purgeEmails(purgePersonEmailFieldMap, null, emailString,countryString);
            }
            //If the flow is called due to normal account creation, the method is called and Email__c field is set.
            for(Account eachAccount : emailChangedAccountList){
                eachAccount.Email__c = purgeEmails(purgePersonEmailFieldMap, eachAccount, BAT_ConstantsUtility.BLANK,BAT_ConstantsUtility.BLANK);
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @method Name   : purgeEmails
* @returns       : void
* @params        : Map<String,DomainNameSpecialCharListWrapper>, Account, String, String
* @description   : [RO] US#405626-RO - Technical Setup - Gmail verification check for offline acounts.
*                       US#434292-RO - Technical Setup - Duplicate error shown on Email Verification Screen  
*                   Extended the functionality for EmailVerificationController. If the Account is created normally then, the method has Metadata wrapper Map and Account
*                   Object. If the account is created by Partner User, then the purged email String is returned to fire duplicate check on 
*                   EmailVerification component. When from Email Verification Component the method takes Metadata wrapper Map, Email String and Country
*                   String as parameters.
* @changeHistory : 17March/Abhishek Kashyap/Created the method
*********************************************************************************************************/
    public static String purgeEmails(Map<String,DomainNameSpecialCharListWrapper> purgePersonEmailFieldMap, Account eachAccount, String emailString, String emailCountryString){
        //If account created normally, then assigning the Account object's personEmail, or else the email string form the email verification component.
        String personEmailString = (eachAccount != null?eachAccount.PersonEmail:emailString);
        //If account created normally, then assigning the Account object's Country, or else the Country form the email verification component.
        String countryString = (eachAccount != null?eachAccount.Country__c:emailCountryString);
        //List of string containing PersonEmail split by '@'
        List<String> splitPersonEmail = personEmailString.split(BAT_ConstantsUtility.DOMAINANNOTATION);
        //Extracting the domain name 
        String domainName = splitPersonEmail[splitPersonEmail.size()-1];
        //Extracting email id withod domain name
        String emailStringWithoutDomain = personEmailString.removeEnd(domainName);
        //Condition to check if the Market requires purging and the PersonEmail's domain is in the metadata record
        if(purgePersonEmailFieldMap.containsKey(countryString) 
           && purgePersonEmailFieldMap.get(countryString).domainList.contains(domainName)){
               
               //Iteration on the list of special characters to be removed
               for(String eachChar : purgePersonEmailFieldMap.get(countryString).specialCharList){
                   //Replacing the characters with BLANK i.e. ''
                   emailStringWithoutDomain = emailStringWithoutDomain.replace(eachChar, BAT_ConstantsUtility.BLANK);
               }
               if(String.isNotBlank(purgePersonEmailFieldMap.get(countryString).defaultDomain)){
                   domainName = purgePersonEmailFieldMap.get(countryString).defaultDomain;
               }
           }
        //Concatinating purged email without listed special characters and teh domain name and returning it.
        return emailStringWithoutDomain+domainName;
        
    }
    /********************************************************************************************************
* @author        : Deloitte
* @class Name    : DomainNameSpecialCharListWrapper
* @returns       : void
* @params        : List<Account>
* @description   : [RO] US#405626-RO - Technical Setup - Gmail verification check for offline acounts
* @changeHistory : 25Feb/Abhishek Kashyap/Created the wrapper class
*********************************************************************************************************/
    public class DomainNameSpecialCharListWrapper{
        //The List holds the domains to be purged
        public List<String> domainList{get;set;}
        //The list holds the special characters to be removed.
        public List<String> specialCharList{get;set;}
        //The String holds the default domain name to be appended.
        public String defaultDomain{get;set;}
        
        public DomainNameSpecialCharListWrapper(List<String> domainListFromMethod, List<String> specialCharListFromMethod, String defaultDomainMethod){
            domainList = domainListFromMethod;
            specialCharList = specialCharListFromMethod;
            defaultDomain = defaultDomainMethod;
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @class Name    : updateAccountRecordtype
* @returns       : void
* @params        : 
* @description   : [RO] US#447210-RO - Update Account Recordtype from Trialist to Direct Consumer upon online registration(when Integration sends External Customer ID 5/External Customer ID 3 value)  
* @changeHistory : 23rd Mar,2021/Roopa N//Created the method
*********************************************************************************************************/
    public void updateAccountRecordtype(Account[] updatedAccount, Map <ID,Account> oldAccountMap)
    {
        List<Account> accountList = new List<Account>(); 
        for(Account eachAccount:updatedAccount){
            if(String.isNotBlank(eachAccount.Country__c) && eachAccount.Country__c == BAT_ConstantsUtility.COUNTRY_RO){
                accountList.add(eachAccount);
            }
        }
        String trialistRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.RECORDTYPE_TRAILLIST).getRecordTypeId();   
        String dcRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(BAT_ConstantsUtility.ACC_RECTYPE_DIRECTCON).getRecordTypeId();
        if(!accountList.isEmpty()){
            for(Account account: accountList)
            {
                if(oldAccountMap != null && oldAccountMap.get(account.id) != null && String.isNotBlank(account.Country__c)  
                   && ((oldAccountMap.get(account.id).BAT_ExternalCustomerID5__c == null && account.BAT_ExternalCustomerID5__c != null) 
                       || (oldAccountMap.get(account.id).External_Customer_ID3__c == null && account.External_Customer_ID3__c != null))
                   && oldAccountMap.get(account.id).RecordTypeId == trialistRecTypeId){
                       account.RecordTypeId = dcRecordTypeId;
                   }                          
            }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @class Name    : updateAccountConsentDateAndAnonymizeDate
* @returns       : void
* @params        : 
* @description   : [RO] US#461730-RO - Update Account's "Last Consent Date" & "Month 24 Anonymize Date" on before updation of account based on consents   
* @changeHistory : 5th April,2021/Roopa N//Created the method - Removed the existing logic from before Insert event and added it in this method to call it on both before insert/before update events to avoid relogic
21st May, 2021/Abhishek Kashyap/RO-537494-RO CRM SIT - Cannot bulk upload consumer data
17th June,2021/Abhishek Kashyap/US-562099-RO - Reconsenting - CRM ENH - To update Month 24 Anonymize Date field on Account
*********************************************************************************************************/
    public void updateAccountConsentDateAndAnonymizeDate(Account[] updatedAccount, Map <ID,Account> oldAccountMap){
        for(Account currentRecord: updatedAccount){
            //US#47996 - logic to Populate consent date.
            if(consentDateUpdateConfigMap.containskey(currentRecord.Country__c) && !consentDateUpdateConfigMap.get(currentRecord.Country__c).isEmpty()
               && (oldAccountMap == null || (oldAccountMap != null 
                                             && currentRecord.Month_24_Anonymize_Countdown__c == 0 
                                             && !oldAccountMap.get(currentRecord.Id).BAT_Is_Anonymised__c
                                             && !currentRecord.BAT_Is_Anonymised__c))){
                                                 //Fetching all fields to be considered to populate consent date.
                                                 //21st May, 2021/Abhishek Kashyap/RO-537494-Removed Schema calls to resolve CPU timeout. Assuming the last consent date will be updated whenever consent checkboxes are changed.
                                                 /*String fieldType=BAT_ConstantsUtility.BLANK;
Schema.sObjectType entityType = currentRecord.getSObjectType();
String entityTypeStr = String.valueOf(entityType);
Boolean doesFieldExist = false;*/
                                                 for(BAT_ConsentDateUpdateConfiguration__mdt metadataRecord : consentDateUpdateConfigMap.get(currentRecord.Country__c)){
                                                     /*if(String.isNotBlank(metadataRecord.BAT_ConsentFields__c) && String.isNotBlank(metadataRecord.BAT_TargetField__c)
&& (oldAccountMap == null || (oldAccountMap != null
&& metadataRecord.BAT_IsUpdate__c))){
fieldType = (BAT_Utilities.doesFieldExist(entityTypeStr, metadataRecord.BAT_ConsentFields__c)?BAT_Utilities.getFieldType(metadataRecord.BAT_ConsentFields__c, BAT_ConstantsUtility.STANDARD_ACCOUNT_STR ):BAT_ConstantsUtility.BLANK);
}*/
                                                     //Checking field type is boolean and Consent field value is True.
                                                     if(currentRecord.get(metadataRecord.BAT_ConsentFields__c)== true 
                                                        && (oldAccountMap == null 
                                                            || (oldAccountMap != null && metadataRecord.BAT_IsUpdate__c && 
                                                                oldAccountMap.get(currentRecord.Id).get(metadataRecord.BAT_ConsentFields__c) != currentRecord.get(metadataRecord.BAT_ConsentFields__c)))){
                                                                    currentRecord.put(metadataRecord.BAT_TargetField__c , System.NOW());  
                                                                }
                                                 } 
                                             }
            ////US#47997 - Populating Month_24_Anonymize_Date__c field based on which automatic anonymization takes place.
            //17th June,2021/Abhishek Kashyap/US-562099-Removed Month_24_Anonymize_Countdown__c = 0 check to enable update of Month_24_Anonymize_Date__c whenever BAT_ConsentDate__c is updated.
            if(currentRecord.BAT_ConsentDate__c!=null && automaticAnonymizationConfigMap.containskey(currentRecord.Country__c) 
               && automaticAnonymizationConfigMap.get(currentRecord.Country__c).BAT_DaysToAnonymize__c!=null && 
               (oldAccountMap == null 
                || (oldAccountMap != null
                    && !currentRecord.BAT_Is_Anonymised__c
                    && currentRecord.BAT_ConsentDate__c != oldAccountMap.get(currentRecord.Id).BAT_ConsentDate__c
                    && automaticAnonymizationConfigMap.get(currentRecord.Country__c).BAT_IsUpdate__c))){
                        currentRecord.Month_24_Anonymize_Date__c = Date.ValueOf(currentRecord.BAT_ConsentDate__c.addDays(Integer.ValueOf(automaticAnonymizationConfigMap.get(currentRecord.Country__c).BAT_DaysToAnonymize__c)));
                    }
        }
    }
    /********************************************************************************************************
* @author        : Deloitte
* @class Name    : setProfileVsAccountSourceMap
* @returns       : Map<String,String>
* @params        : 
* @description   : [RO] US#466621-RO-Returns the map with profile to account source
* @changeHistory : 6th April,2021/Abhishek Kashyap/Created the method
*********************************************************************************************************/
    public Map<String,String> setProfileVsAccountSourceMap(List<String> profileList, List<String> accountSourceList){
        Integer index = 0;
        Map<String,String> profileToAccountSourceMap = new Map<String,String>();
        for(String eachProfile : profileList){
            profileToAccountSourceMap.put(eachProfile, accountSourceList[index]);
            index++;
        }
        return profileToAccountSourceMap;
    }
    /********************************************************************************************************
* @author        : ITC
* @method Name    : mergeAccounts
* @returns       : void
* @params        : String phoneNumber,Id currentRecordId
* @description   : [CZ] US#1454597-CZ - multicategory loyalty program - CRM & M2
* @changeHistory : 10.16.2023/Reema Meher/Created the method

*********************************************************************************************************/
    public void mergeAccounts(List<Account> lstOldAccounts) {
        // Map<String, List<Account>> mobileToAccountsMap = new Map<String, List<Account>>();
        // Collect the mobile numbers from the deleted Account records
        // List<String> newBrandList = new List<String>();
        Map<String, BAT_AccountMerge__c> mergeSettings = BAT_AccountMerge__c.getAll();
        List<BAT_AccountMerge__c> updateInfoList = BAT_AccountMerge__c.getall().values();
        Set<String> accountIdsToUpdateLoyalty = new Set<String>();
        for (BAT_AccountMerge__c updateInfo : updateInfoList) {
            accountIdsToUpdateLoyalty.add(updateInfo.BAT_Accountid__c);
        }
        string strId, strBrandHouse;
        Set<String> updatedMobileNumbers = new Set<String>();
        Map<String, Account> oldphoneNumMap = new Map<String, Account>();
        Map<Id, Account> oldMap = new Map<Id, Account>();
        for (Account updatedAccount : lstOldAccounts) {
            
            
            oldMap.put(updatedAccount.Id, updatedAccount);
            if (!String.isEmpty(updatedAccount.PersonMobilePhone)) {
                updatedMobileNumbers.add(updatedAccount.PersonMobilePhone);
                oldphoneNumMap.put(updatedAccount.PersonMobilePhone, updatedAccount);
                //   system.debug('oldphoneNumMap===='+oldphoneNumMap);
                //  system.debug('accountsToUpdateloyality===='+accountsToUpdateloyality);
                if(accountIdsToUpdateLoyalty.contains(updatedAccount.Id))
                {
                    oldPhoneNumber = getOriginalPhone(updatedAccount.Id);}              
                oldAccountid = updatedAccount.BAT_ExternalCustomerID5__c;
            }
            
            
        }
        // Query related records with the same mobile number
        List<Account> relatedAccounts = [
            SELECT Id, PersonMobilePhone,Brand_House__c
            FROM Account
            WHERE PersonMobilePhone IN :updatedMobileNumbers
            AND Id NOT IN :oldMap.keySet() AND Country__c='CZ' AND Brand_House__c!=null
        ];
        
        for(Account ac : relatedAccounts)
        { 
            String[] ar1 = oldphoneNumMap.get(ac.PersonMobilePhone).Brand_House__c.split(';');
            String[] ar2 = ac.Brand_House__c.split(';');
            Set<String> resultSet = new Set<String>(ar1);
            resultSet.addAll(ar2);
            
            List<String> concatenateList = new List<String>(resultSet);
            String res = String.join(concatenateList,';');
            
            mergeSetting = mergeSettings.get(BAT_ConstantsUtility.ACCOUNT_MERGE_CUSTOM_SETTING);
            if (mergeSetting != null) {
                mergeSetting.BAT_ResultingRecord__c = ac.Id;
                mergeSetting.BAT_Ismerge__c =true;
                update mergeSetting;
            }
            strId = ac.Id; 
            strBrandHouse = res;  
            oldAccountid = oldphoneNumMap.get(ac.PersonMobilePhone).BAT_ExternalCustomerID5__c;
            if(accountIdsToUpdateLoyalty.contains(ac.Id))
            {
                oldPhoneNumber = getOriginalPhone(ac.Id);}
            System.enqueueJob(new BAT_UpdatePrincipalAccountQueueable(strId, strBrandHouse,oldAccountid,oldPhoneNumber));
        }
    }
    
    private String getOriginalPhone(Id accountId) {
        List<AccountHistory> historyRecords = [
            SELECT OldValue
            FROM AccountHistory
            WHERE AccountId  = :accountId
            AND Field = 'PersonMobilePhone'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        
        if (!historyRecords.isEmpty()) {
            return String.valueOf(historyRecords[0].OldValue);
            
        }
        
        return null;
    }
    
    // CZ Loyality Ends//
    /********************************************************************************************************
* @author        : Deloitte
* @class Name    : assignPointsForLoyaltySubscription
* @returns       : void
* @params        : List<Account> updatedAccount, Map <ID,Account> oldAccountMap,Map <ID,Account> newAccountMap
* @description   : [IT] US#1228423-IT | glo | Point assignment to retailer if customer joins Loyalty
* @changeHistory : 02.03.2023 /Idrees Ali/Created the method
*********************************************************************************************************/
    private void assignPointsForLoyaltySubscription(List<Account> updatedAccount, Map <ID,Account> oldAccountMap,Map <ID,Account> newAccountMap){
        Set<Id> loyaltySubscribedAccountsId = new Set<Id>();
        List<BAT_Point__c> listToInsertPoint = new List<BAT_Point__c>();
        Map<String,String> pointValueMap = new Map<String,String>();
        List<String> supportedLoyaltySubsAccountSources = new List<String> (BAT_ConstantsUtility.LOYALITY_ACCOUNT_SOURCES.split(BAT_ConstantsUtility.SEMI_COLON));
        
        //  Map<String,List<BAT_RetailerPointTable__mdt>> mapOfConditionToRecords = new Map<String,List<BAT_RetailerPointTable__mdt>>();
        Map<String,List<BAT_RetailerPointDirectory__c>> mapOfConditionToRecords = new Map<String,List<BAT_RetailerPointDirectory__c>>();
        
        BAT_Point__c point = new BAT_Point__c();
        List<Account> accList = new List<Account>();
        
        //Below condition checks if the account in context satisfies conditiosn for availing loyalty points
        for(Account currentRecord: updatedAccount){
            /*if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT) && BAT_ConstantsUtility.supportedLoyaltySubsAccountSources.contains(currentRecord.AccountSource)
&& oldAccountMap.get(currentRecord.Id).Loyalty_Completed_Survey__c != currentRecord.Loyalty_Completed_Survey__c && currentRecord.Loyalty_Completed_Survey__c
&& oldAccountMap.get(currentRecord.Id).BAT_LoyaltyOptOutDate__c == null && currentRecord.BAT_LoyaltyOptOutDate__c == null){*/
            if(currentRecord.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.COUNTRY_IT) && supportedLoyaltySubsAccountSources.contains(currentRecord.AccountSource)
               && oldAccountMap.get(currentRecord.Id).Loyalty_Completed_Survey__c != currentRecord.Loyalty_Completed_Survey__c && currentRecord.Loyalty_Completed_Survey__c
               && oldAccountMap.get(currentRecord.Id).BAT_LoyaltyOptOutDate__c == null && currentRecord.BAT_LoyaltyOptOutDate__c == null){      
                   loyaltySubscribedAccountsId.add(currentRecord.Id);  
               }
        }
        //Querying accounts along with the asset having the oldest purchase date in order to assign points to retailer's RP  
        if(!loyaltySubscribedAccountsId.isEmpty()){
            accList = [Select id,Loyalty_Completed_Survey__c,FirstName,LastName,Name,LastModifiedDate,Country__c,(Select id,Selling_Reward_Profile__c,name,CreatedDate,AccountId,Country__c from Assets where Selling_Reward_Profile__c!= null AND BAT_Brand__c = :BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO AND PurchaseDate != NULL ORDER BY PurchaseDate,CreatedDate ASC LIMIT 1) from Account where Id IN :loyaltySubscribedAccountsId];
        }
        if(!accList.isEmpty()){
            
            BAT_Utilities.fetchRetailerPointTableMetadata(new Set<String>{BAT_ConstantsUtility.COUNTRY_IT});
            pointValueMap = BAT_Utilities.pointValueMap;
            mapOfConditionToRecords = BAT_Utilities.mapOfConditionToRecords;
            
            for(Account accRecord : accList){
                Map<Id,Account> accountsMap = new Map<Id,Account>();
                accountsMap.put(accRecord.Id, accRecord);
                if( accRecord.Assets.size() > 0){
                    for(Asset assetRec : accRecord.Assets){
                        //Building condition name for point scenario
                        String pointConditionName = BAT_ConstantsUtility.COUNTRY_IT + BAT_ConstantsUtility.ASSET_GENERIC_ACTION_NAME_FOR_POINT + BAT_ConstantsUtility.UNDERSCORE + BAT_ConstantsUtility.BAT_LOYALTY_REWARD_SCHEME_STR;
                        //Building Reason value for point scenario
                        String reason = BAT_Utilities.generateReasonField(assetRec,
                                                                          mapOfConditionToRecords.get(pointConditionName),accountsMap,BAT_ConstantsUtility.SINGLE_SPACE + BAT_ConstantsUtility.BAT_LOYALTY_REWARD_SCHEME_REASON_STR);
                        //Creating point record as per metadata
                        point = BAT_Utilities.createPointRecord(assetRec.Selling_Reward_Profile__c,reason,
                                                                Decimal.valueOf(pointValueMap.get(pointConditionName)));
                        listToInsertPoint.add(point);
                    }
                }
            }
            //Inserting point
            if(!listToInsertPoint.isEmpty()){
                Database.SaveResult[] pointRecordsInsertResult = Database.insert(listToInsertPoint, false);
                BAT_Utilities.createErrorLogs(pointRecordsInsertResult,BAT_ConstantsUtility.ATH_Class,BAT_ConstantsUtility.BAT_ASSIGNLOYALTYPOINTSMETHOD_STR);
            }
        }
    }
    //1498757 RO - reconsent from site starts -------//
    private void updateLastConsentDate(Account updatedAccount, Map<Id, Account> oldAccountMap) {
        Account oldAccount = oldAccountMap.get(updatedAccount.Id);
        if((oldAccount.PersonDoNotCall!=updatedAccount.PersonDoNotCall) ||(oldAccount.PersonHasOptedOutOfEmail!=updatedAccount.PersonHasOptedOutOfEmail) ||(oldAccount.SMS_Opt_Out__c!=updatedAccount.SMS_Opt_Out__c))
        {
            isConsentChanged=true;
        }
        if (user.Profile.Name.containsIgnoreCase(BAT_ConstantsUtility.INTEGARTION_USER) && user.Country__c != null && user.Country__c.equalsIgnoreCase(BAT_ConstantsUtility.Country_RO) && !isConsentChanged)
        {
            updatedAccount.BAT_ConsentDate__c=oldAccount.BAT_ConsentDate__c;
        }
        if (updatedAccount.Generic_Permission__c && updatedAccount.PersonDoNotCall && updatedAccount.PersonHasOptedOutOfEmail && updatedAccount.SMS_Opt_Out__c) {
            updatedAccount.Generic_Permission__c = false;
        }
        else if ((updatedAccount.Generic_Permission__c && !oldAccount.Generic_Permission__c) || (isConsentChanged && updatedAccount.Generic_Permission__c && !updatedAccount.PersonDoNotCall && !updatedAccount.PersonHasOptedOutOfEmail && !updatedAccount.SMS_Opt_Out__c)) {
            updatedAccount.BAT_ConsentDate__c = System.now();
        }
        else if ((updatedAccount.Generic_Permission__c) && (isConsentChanged &&(updatedAccount.PersonDoNotCall ||  updatedAccount.PersonHasOptedOutOfEmail || updatedAccount.SMS_Opt_Out__c))) {
            updatedAccount.BAT_ConsentDate__c = System.now();
        }
        else if ((updatedAccount.Generic_Permission__c) &&(isConsentChanged && (!updatedAccount.PersonDoNotCall || !updatedAccount.PersonHasOptedOutOfEmail || !updatedAccount.SMS_Opt_Out__c))) {
            updatedAccount.BAT_ConsentDate__c = System.now();
        }
    }
    
    
    //1498757 RO - reconsent from site ends-------//
    /********************************************************************************************************
* @author        : Deloitte
* @class Name    : generateREWCode
* @returns       : void
* @params        : BAT_Utilities.REWCodeWrapper rewCodeWrapObj , List<Account> newAccounts
* @description   : [UA] US#1272527-UA - Generate REW-CODE in any type of accounts in CRM
* @changeHistory : 23.03.2023 /Idrees Ali/Created the method
17.04.2023/Saurabh Sharma/ Bug #1356909, removed BAT_IsLogicToWorkOnInsert__c check for UA bug fix.
: 21.04.2023 / Debasis Maharana /UA- Bug#1368955 /Reward code generation is totally dependent on time stamp, so it creates duplicate codes, so I added a random string before encryption. 
*********************************************************************************************************/
    private void generateREWCode(  BAT_Utilities.REWCodeWrapper rewCodeWrapObj , List<Account> newAccounts){
        Map<String,BAT_DefaultRewProfilePointsConfiguration__mdt> defaultrewProfilePointsConfigMap = rewCodeWrapObj.defaultrewProfilePointsConfigMap;
        for(Account newAccRec : newAccounts){
            if(!defaultrewProfilePointsConfigMap.isEmpty() && defaultrewProfilePointsConfigMap.containsKey(newAccRec.Country__c) && defaultrewProfilePointsConfigMap.get(newAccRec.Country__c).BAT_IsRandomMGMCodeToBeGenerated__c){
                String incrementedString = newAccRec.Country__c + String.valueOf(Datetime.now().formatGMT(BAT_ConstantsUtility.DATE_TIME_FORMAT_STR)+Crypto.getRandomLong());
                Blob convertToMD5hash = Crypto.generateDigest(BAT_ConstantsUtility.HASHING_ALGORITHM_STR, Blob.valueOf(incrementedString));
                String hexDigest = EncodingUtil.convertToHex(convertToMD5hash);
                newAccRec.Member_get_Member_Code__c = defaultrewProfilePointsConfigMap.get(newAccRec.Country__c).BAT_MGMCodePrefix__c + BAT_ConstantsUtility.HYPHEN + String.valueOf(hexDigest.substring(0, 8).toUpperCase());
            }
        }       
    }
    /********************************************************************************************************
* @author        : ITC
* @method Name    : updateConsumerStatus
* @returns       : void
* @params        : Account[] updatedAccount, Map <ID,Account> oldAccountMap
* @description   : [IT] US#1486880-Update Status to Consumer only when Registration Permission is true
* @changeHistory : 2.10.2023/Chirag Kalra/Created the method

*********************************************************************************************************/
    public void updateConsumerStatus(Account[] updatedAccount, Map <ID,Account> oldAccountMap)
    {
        Map<Id,Set<String>> mapOfAccountIdAndAssetBrand = new  Map<Id,Set<String>>();
        Map<Id, List<Asset>> accountIdWithAssetMap = new Map<Id, List<Asset>>();
        if(!updatedAccount.isEmpty()){
            accountIdWithAssetMap  = BAT_Utilities.getAllExistingAssets(updatedAccount);
        }
        
        for(Account eachAccount:updatedAccount ){
            if(!accountIdWithAssetMap.isEmpty()  && accountIdWithAssetMap.get(eachAccount.Id)!=null && !accountIdWithAssetMap.get(eachAccount.Id).isEmpty() && eachAccount.Registration_Permission__c && 
               eachAccount.Registration_Permission__c!= oldAccountMap.get(eachAccount.Id).Registration_Permission__c && !eachAccount.BAT_Is_Anonymised__c && accountIdWithAssetMap.containsKey(eachAccount.Id)){
                   for(Asset assetRecord: accountIdWithAssetMap.get(eachAccount.Id)){
                       if(mapOfAccountIdAndAssetBrand.containsKey(eachAccount.Id)){
                           
                           mapOfAccountIdAndAssetBrand.get(eachAccount.Id).add(assetRecord.BAT_Brand__c);
                       }
                       else{
                           mapOfAccountIdAndAssetBrand.put(eachAccount.Id,new Set<String>{assetRecord.BAT_Brand__c});
                       }
                   }
                   
               }
        }
        if(!updatedAccount.isEmpty()){
            for(Account accountRecord :updatedAccount ){
                if(mapOfAccountIdAndAssetBrand.containsKey(accountRecord.Id)){
                    Set<String> listOfBrands = mapOfAccountIdAndAssetBrand.get(accountRecord.Id);
                    if(!listOfBrands.isEmpty()){
                        for(String Brand: listOfBrands){
                            if(Brand.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_GLO)||Brand.equalsIgnoreCase(BAT_ConstantsUtility.PRODUCT_BRAND_GLO)){
                                accountRecord.BAT_THPStatus__c= BAT_ConstantsUtility.ATH_CONSUMER;
                                accountRecord.BAT_THPConsumerSince__c = Date.today(); //added for updation of consumer since field US 1567429
                                
                            }
                            else if(Brand.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_VELO)){
                                accountRecord.BAT_OralStatus__c= BAT_ConstantsUtility.ATH_CONSUMER;
                                accountRecord.BAT_OralConsumerSince__c = Date.today();
                            }
                            else if(Brand.equalsIgnoreCase(BAT_ConstantsUtility.BAT_BRAND_HOUSE_Vype)||Brand.equalsIgnoreCase(BAT_ConstantsUtility.PRODUCT_BRAND_VUSE) ){
                                accountRecord.BAT_VapeStatus__c= BAT_ConstantsUtility.ATH_CONSUMER;
                                accountRecord.BAT_VapeConsumerSince__c = Date.today(); //added for updation of consumer since field US 1567429
                            }
                            if(accountRecord.Status__c!=null && !accountRecord.Status__c.equalsIgnoreCase(BAT_ConstantsUtility.ATH_CONSUMER)){
                                accountRecord.Status__c= BAT_ConstantsUtility.ATH_CONSUMER;
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    /********************************************************************************************************
* @author        : ITC
* @method Name    : isPhoneNumberAlreadyPresent
* @returns       : void
* @params        : String phoneNumber,Id currentRecordId
* @description   : [CZ] US#1454597-CZ - multicategory loyalty program - CRM & M2
* @changeHistory : 10.16.2023/Reema Meher/Created the method

*********************************************************************************************************/
    // CZ loyality Starts 
    public static boolean isPhoneNumberAlreadyPresent(String phoneNumber ,Id currentRecordId) {
        // Query to check if the phone number is already present in the database
        List<Account> existingAccounts = [
            SELECT Id
            FROM Account
            WHERE PersonMobilePhone = :phoneNumber AND Id!= :currentRecordId 
            LIMIT 1
        ];
        
        return !existingAccounts.isEmpty();
    }
    // CZ loyality Ends// 
    /********************************************************************************************************
* @author        : ITC
* @method Name    : isEmailAlreadyPresent
* @returns       : void
* @params        : String phoneNumber,Id currentRecordId
* @description   : [CZ] US#1454597-CZ - multicategory loyalty program - CRM & M2
* @changeHistory : 10.16.2023/Reema Meher/Created the method

*********************************************************************************************************/
    
    public static boolean isEmailAlreadyPresent(String email ,Id currentRecordId) {
        // Query to check if the phone number is already present in the database
        List<Account> existingAccounts = [
            SELECT Id
            FROM Account
            WHERE PersonEmail =:email AND Id!= :currentRecordId
            LIMIT 1
        ];      
        return !existingAccounts.isEmpty();
    }
    
    //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update--End
    
    public static void anonymizingRoCIAM_Accounts(Account[] updatedAccount,List<String>roEmailPhone){
        List<Account>lstROAcc =new List<Account>();
        Set<Id>accId = new Set<Id>();
        Set<Id>updatedAccIc = new Set<Id>();
        List<Account>getOldanonymizingAccounts = new List<Account>();
        List<Account>updateanonymizingAccounts = new List<Account>();
        Account actUpdate = new Account();
        lstROAcc=[SELECT id, LastName, FirstName, Country__c, PersonEmail, PersonMobilePhone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, Related_Lead__c,
                  Registration_Permission__c,External_Information_Systems_Permission__c,Submit_Surveys_Permission__c,
                  Trial_Information_Permission__c,Birth_Date__c,Generic_Permission__c, is_trialist__c,Gender__c,Status__c, BAT_Is_Anonymised__c,
                  BAT_CombustibleStatus__c,BAT_OralStatus__c,BAT_THPStatus__c,BAT_VapeStatus__c,
                  BAT_IsEPOKOptInEmailCommunication__c,BAT_IsEPOKOptInMobileTextWhatsApp__c,BAT_IsEPOKOptInPostal__c,  
                  BAT_EPOKMarketResearchAuthorization__c,BAT_EPOKLastCompletedOrderDate__c,BAT_EPOKLastConsentOptInDate__c,
                  BAT_IsVypeOptInEmailCommunication__c,BAT_IsVypeOptInMobileTextWhatsApp__c,BAT_IsVypeOptInPostal__c,
                  BAT_VypeMarketResearchAuthorization__c,GoVype_Last_Completed_Order_Date__c,BAT_VypeLastConsentOptInDate__c,  
                  BAT_IsLyftOptInEmailCommunication__c,BAT_IsLyftOptInMobileTextWhatsApp__c,BAT_IsLyftOptInPostal__c,  
                  BAT_LyftMarketResearchAuthorization__c,BAT_LyftExternalCompaniesAuthorization__c,
                  BAT_LyftTrialFeedbackAuthorization__c,BAT_LyftLastCompletedOrderDate__c, BAT_LyftLastConsentOptInDate__c,
                  External_Customer_Id__c, External_Customer_ID3__c,BAT_ExternalCustomerId4__c,BAT_ExternalSubscriberId__c,BAT_ExternalSubscriberId3__c,   BAT_ExternalSubscriberId4__c,
                  Email_verified__c, Member_get_Member_Code__c, MgM_Counter__c, Skip_Repurchase_Lock__c,
                  Wrong_Phone_Number__c, Preferred_Tobacconist_Shop__c, Last_Call_Type__c, Member_get_Member_Promotional_Code__c,
                  Age_verified__c, PersonHasOptedOutOfFax, PersonDoNotCall, SMS_Opt_Out__c, PersonHasOptedOutOfEmail, AccountSource,
                  Store_ID__c, BAT_BypassMobileVerification__c,  Category__c, Brand__c, Variant__c, Sector__c, PersonIndividualId, Last_Modified_Source__c ,BAT_VeloFeedbackCallAuthorization__c,BAT_VeloOptOutDateLastFeedback__c,
                  BAT_VeloOptInDateLastFeedback__c,BAT_AMPEmailOptOut__c
                  FROM Account
                  WHERE Country__c=:BAT_ConstantsUtility.COUNTRY_RO AND BAT_Is_Anonymised__c=false  AND (PersonEmail IN: roEmailPhone OR PersonMobilePhone IN:roEmailPhone) order by createddate desc];
        if(lstROAcc.size()>1){
            accId.add(lstROAcc[0].Id);
            lstROAcc.remove(0);
            for(Account acc:updatedAccount){
                updatedAccIc.add(acc.Id);
                if(!accId.contains(acc.id)){
                    actUpdate=acc.clone();
                    List<Account>currentROAccount = BAT_Utilities.anonymizeAccounts(new List<Account>{acc});
                } 
                
            }
            for(Account acc:lstROAcc){
                if(!updatedAccIc.contains(acc.Id)){
                    getOldanonymizingAccounts.add(acc);
                }
            }
            if(!getOldanonymizingAccounts.isEmpty()){
                updateanonymizingAccounts =BAT_Utilities.anonymizeAccounts(getOldanonymizingAccounts);
                anonymizingRoCIAM_AccountsFuture(updateanonymizingAccounts);  
            }
            if(!accId.isEmpty()&&actUpdate!=null){
                System.enqueueJob(new BAT_UpdateROAccountAnonymizeQueueable(accId, actUpdate));
            }
        }
    }
    //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update
    public static void anonymizingRoCIAM_AccountsFuture(List<Account> updateRoAnonymizingAccounts){
        try{
            if(updateRoAnonymizingAccounts.size()>0){
                Database.DMLOptions dml = new Database.DMLOptions();
                dml.DuplicateRuleHeader.AllowSave = true;
                Database.SaveResult[] sr = Database.update(updateRoAnonymizingAccounts, dml); 
                for(Database.SaveResult s:sr){
                    if(!s.isSuccess()) {
                        system.debug('Error =='+ s.getErrors()[0].getMessage());
                    }
                }
            } 
            
        }
        catch(Exception ex){
            Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = BAT_ConstantsUtility.ATH_Class, Exception__c = ex.getMessage(),
                                                  Method_Name__c = BAT_ConstantsUtility.BAT_ANOANYMIZING_RO_CIAM_ACCOUNTS);
            insert apexLog;
        }
    }
    //23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update
    public static void updatetheOldROAccounts(Set<Id>accIds,Account acc){
        List<Account>accupdate = new List<Account>();
        try{
            acc.Id=new List<Id>(accIds)[0];
            accupdate.add(acc);
            if(accupdate.size()>0){
                Database.DMLOptions dml = new Database.DMLOptions();
                dml.DuplicateRuleHeader.AllowSave = true;
                Database.SaveResult[] sr = Database.update(accupdate, dml); 
                for(Database.SaveResult s:sr){
                    if(!s.isSuccess()) {
                        system.debug('Error ==5987'+ s.getErrors()[0].getMessage());
                    }
                }
            } 
        }
        catch(Exception ex){
            Apex_Log__c apexLog = new Apex_Log__c(Class_Name__c = BAT_ConstantsUtility.ATH_Class, Exception__c = ex.getMessage(),
                                                  Method_Name__c = BAT_ConstantsUtility.BAT_UPDATE_THE_OLD_RO_ACCOUNTS);
            insert apexLog;
        }
        
    }//23.11.2023/Varaprasad Sada/US#1506330/RO - Account creation flow update-End
   
    
}