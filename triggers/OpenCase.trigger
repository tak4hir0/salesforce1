trigger OpenCase on EmailMessage (before insert) {
    Set<Id> ids = new Set<Id>();
    for(EmailMessage em : Trigger.new){
        if(em.Incoming){
            ids.add(em.ParentId);
        }
    }
    
    if(ids.size() > 0){
        List<Case> cs = [Select Id, Status From Case Where Id in: ids];
        for(Case c : cs){
            c.Status = 'New';
        }
        
        update cs;
    }    
}