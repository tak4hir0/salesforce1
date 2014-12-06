trigger Callout on Account (after update) {
    for(Account a : Trigger.new){
        CalloutTriggerHandler.callout();
    }
}