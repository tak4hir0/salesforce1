global class CalloutBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {

    global CalloutBatch() {
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('***: ' + 'start');

        return Database.getQueryLocator('Select Id, Name From Account');
    }
    
    global void execute(Database.BatchableContext bc, Account[] targets){
        List<Log__c> ls = new List<Log__c>();
        try {
            for(Account a : targets){
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://www.google.com');
                req.setMethod('GET');
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
                System.debug('***' + res.getBody());   
            }
        } catch (Exception e){
            Log__c l = new Log__c(Response__c=e.getStackTraceString());
            ls.add(l);
        }
        
        insert ls;

    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('***: ' + 'finish');
    }
}