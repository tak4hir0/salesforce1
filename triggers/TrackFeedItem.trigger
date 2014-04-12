trigger TrackFeedItem on FeedItem (before insert) {
    for(FeedItem fi : Trigger.new){
        if(fi.Body.indexOf('#anonymous') != -1){
            fi.CreatedById = '005E0000001mpeI';            
        }
        System.debug('***feedItem:' + fi);
    }
}