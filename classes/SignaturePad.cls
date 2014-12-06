global with sharing class SignaturePad {
    
    @RemoteAction
    global static Boolean save(String bodyStr) {
        Boolean result = false;
        
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = 'signature';
        messageInput.messageSegments.add(textSegment);
        ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
        mentionSegment.id = UserInfo.getUserId();
        messageInput.messageSegments.add(mentionSegment);
        textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = '';
        messageInput.messageSegments.add(textSegment);
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = messageInput;
        
        // POST FILE_FEED_ITEM
        ConnectApi.NewFileAttachmentInput fileIn = new ConnectApi.NewFileAttachmentInput();
        fileIn.title ='signature'; 
        fileIn.description = '';
        Input.attachment = fileIn;
        string contentType = 'image/png';
        ConnectApi.BinaryInput feedBinary = new ConnectApi.BinaryInput(EncodingUtil.base64Decode(bodyStr.subString(bodyStr.indexOf(',') + 1, bodyStr.length())), contentType, 'signature.png');
        
        // PARAMETERS(communityId, feedType, subjectId, input,filebody);
        ConnectApi.ChatterFeeds.postFeedItem(null, ConnectApi.FeedType.Record, '003E000000I8hyt', Input, feedBinary);
        
        System.debug('***');

        return result;
    }
    
}