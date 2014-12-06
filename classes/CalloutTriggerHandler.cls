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
    
    @future(callout=true)
    public static void callout2(){
        try {
            HttpRequest req = new HttpRequest();
            
            String query = 'http://immense-plains-1883.herokuapp.com/td.foo.bar?json=';
            
            JSONGenerator gen = JSON.createGenerator(true);

            gen.writeStartObject();
            
            gen.writeStringField('action', 'callout');
            gen.writeNumberField('user', 2);
            
            gen.writeEndObject();
            
            //System.debug('***: ' + EncodingUtil.urlEncode(gen.getAsString(), 'UTF-8'));
            
            req.setEndpoint(query + EncodingUtil.urlEncode(gen.getAsString(), 'UTF-8'));
           
            req.setTimeout(120000);
            req.setMethod('GET');
        
            Http http = new Http();
            HTTPResponse res = http.send(req);
            
            insert new Log__c(Response__c=res.getBody());
            
        } catch (Exception e){
            insert new Log__c(Response__c=e.getStackTraceString());
        }
    }
    
    @future(callout=true)
    public static void calloutChatter(String val){
        try {
            HttpRequest req = new HttpRequest();
            
            String query = 'http://immense-plains-1883.herokuapp.com/td.chatter.feeditem?json=';
            req.setEndpoint(query + EncodingUtil.urlEncode(val, 'UTF-8'));
           
            req.setTimeout(120000);
            req.setMethod('GET');
            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            
            insert new Log__c(Response__c=res.getBody());
            
        } catch (Exception e){
            insert new Log__c(Response__c=e.getStackTraceString());
        }
    }
}