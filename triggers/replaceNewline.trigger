trigger replaceNewline on Account (before insert, before update) {
    for(Account acc : Trigger.New){
        if(String.isNotBlank(acc.Description)){
            acc.NoNewLine__c = acc.Description.replaceAll('\r\n', ' ');
        }
    }
}