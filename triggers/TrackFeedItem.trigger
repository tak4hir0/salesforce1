trigger TrackFeedItem on FeedItem (before insert) {
    //TODO bulkfy
    FeedItem fi = Trigger.new[0];
    if(fi != null){
        CalloutTriggerHandler.calloutChatter(JSON.serialize(fi));
    }
}