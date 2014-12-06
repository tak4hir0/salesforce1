@RestResource(urlMapping='/FieldCase/*')
global with sharing class RESTCaseController {
    
/*
Creating REST APIs using Apex REST - developer.force.com
https://developer.salesforce.com/page/Creating_REST_APIs_using_Apex_REST
*/
        
    @HttpGet
    global static List<Case> getOpenCases() {
        String companyName = RestContext.request.params.get('companyName');
        Account company = [ Select ID, Name, BillingState from Account where Name = :companyName];
    
        List<Case> cases = [SELECT Id, Subject, Status, OwnerId, Owner.Name from Case WHERE AccountId =: company.Id];
        return cases;
    
    }
    
    @HttpDelete
    global static String deleteOldCases() {
        String companyName = RestContext.request.params.get('companyName');
        Account company = [ Select ID, Name, BillingState from Account where Name = :companyName];
    
        List<Case> cases = [SELECT Id, Subject, Status, OwnerId, Owner.Name from Case WHERE AccountId =: company.Id AND Status = 'Closed'];
        delete cases;
    
        return 'Closed Cases Deleted';
    }
    
    @HttpPatch
    global static String updateCase(String caseId, String caseStatus, String caseNote) {
        Case companyCase = [SELECT Id, Subject, Status, Description from Case WHERE Id =: caseId];
    
        companyCase.Status = caseStatus;
        companyCase.Description += '/n/n';
        companyCase.Description += caseNote;
        update companyCase;
    
        return 'Case Updated';
    }
    
    /*
    @HttpPut
    global static String updateCase(RestRequest req) {
        String companyName = req.params.get('companyName');
        Account company = [ Select ID, Name, Type, BillingState from Account where Name = :companyName];
        
        Attachment a = new Attachment();
        a.ParentId = company.Id;
        a.Name = 'test.png';
        a.Body = req.requestBody;
        
        insert a;
        
        return 'Attachment added';
    }
    */
    
    /*
    @HttpPost
    global static String createNewCase(String companyName, String caseType) {
        System.debug('COMPANY: '+companyName);
        System.debug('CASE TYPE: '+caseType);
        return 'Done';
    }
    */
    
    @HttpPost   
    global static String createNewCase(String companyName, String caseType) {
        System.debug('COMPANY: '+companyName);
        System.debug('CASE TYPE: '+caseType);

        List<Account> company = [Select ID, Name, BillingState from Account where Name = :companyName];
        //List<Support_Member__c> support;

        if(company.size() > 0) {
            //support = [SELECT ID, User__c, Name, User__r.Email from Support_Member__c WHERE Support_State__c = :company[0].BillingState LIMIT 1];
        }
        
        //List<Support_Documentation__c> doc = [SELECT ID from Support_Documentation__c WHERE Type__c = :caseType ORDER BY CreatedDate ASC LIMIT 1];
        /*
        if(company.size() == 0 || support.size() == 0 || doc.size() == 0) {
            return 'No support data exists for this problem';
        }
        */

        Case c = new Case();
        c.OwnerId = UserInfo.getUserId();//support[0].User__c;
        c.AccountId = company[0].Id;
        c.Subject = caseType + ' for '+companyName;
        c.Status = 'Open';
        insert c;

        //TODO sendEmail(companyName, 'geetsj0hn@gmail.com', doc[0].Id, support[0].Name, support[0].User__r.Email);

        return 'Submitted case to '+ UserInfo.getUserName() +' for '+companyName+'.  Confirmation sent to geetsj0hn@gmail.com';
    }
}