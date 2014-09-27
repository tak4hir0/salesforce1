global class FeedItemCreator implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful{
    
    global Integer summary;
    
    global FeedItemCreator() {
        summary = 0;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('***: ' + 'start');

        return Database.getQueryLocator('select Id, Body from FeedItem');
    }
    
    global void execute(Database.BatchableContext bc, FeedItem[] targets){
        
        for(FeedItem fi : targets){
            ConnectApi.ChatterFeeds.postComment(null, '0D5E000001Qp8CIKAZ', String.valueOf(summary++));
        }
        
        try {
            
        } catch (Exception e){
            //Database.executeBatch(new UpdateAccountFields(q,e,f,v), 5); 
            /*
            Log__c l = new Log__c(Response__c=e.getStackTraceString());
            ls.add(l);
            */
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('***: ' + 'finish');
    }
}