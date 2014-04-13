global class Tumbling implements Database.Batchable<SOBJECT>, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id From FeedItem');
    }
    
    global void execute(Database.BatchableContext BC, List<SOBJECT> scope){
        Tumblr.call();
    }
    
    global void finish(Database.BatchableContext BC){
    }
    
}