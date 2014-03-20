trigger converted on Lead (after update) {
    
    Map<Id, Id> ids = new Map<Id, Id>();
    
    for(Lead l : Trigger.new){
        if(l.isConverted){
            ids.put(l.Id, l.ConvertedContactId);
        }
    }
    
    if(ids.size() > 0){
        List<Account__c> accs = [Select Id, Lead__c From Account__c Where Lead__c in:ids.keySet()];
    
        for(Account__c acc : accs){
            acc.Contact__c = ids.get(acc.Lead__c);
        }
    
        update accs;
    }

}