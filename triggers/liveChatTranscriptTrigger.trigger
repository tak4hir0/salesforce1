trigger liveChatTranscriptTrigger on LiveChatTranscript (before Insert) {
    for(LiveChatTranscript lct : Trigger.new) {
        lct.Email__c = 'tkawabata@uhuru.jp';
        //lct.OrcerNumber__c = lct.Body.substring(0, 50);
        lct.OrcerNumber__c = lct.LiveChatButtonId;
        
    }
}