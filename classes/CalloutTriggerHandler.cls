public with sharing class CalloutTriggerHandler{

    @future(callout=true)
    public static void callout(){
        try {
            List<Log__c> ls = new List<Log__c>();

            HttpRequest req = new HttpRequest();
            //req.setEndpoint('https://www.google.com');
            req.setEndpoint('http://tak4hir01.appspot.com/sms/api/');
            req.setHeader('Content-Length',String.valueOf(req.getBody().length()));
            req.setTimeout(120000);
            req.setMethod('GET');
        
            Http http = new Http();
            HTTPResponse res = http.send(req);
            
            ls.add(new Log__c(Response__c=res.getBody()));
            insert ls;
            
        } catch (Exception e){
            insert new Log__c(Response__c=e.getStackTraceString());
        }
    }
}