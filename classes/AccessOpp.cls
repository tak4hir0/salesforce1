public without sharing class AccessOpp {
    
    public List<Opportunity> opps {
        get{
            return [Select Id, Name From Opportunity Where Name =: 'Edge SLA'];
        }
        set{}
    }
    
    public List<Account__c> accs {
        get{
            return [Select Id, Opp__r.Name, OppName__c From Account__c Where Id = :'a2BE0000000PK4vMAG'];
        }
        set{}
    }
}