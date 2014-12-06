public class FeedBodyParser {

  // use to extract the user id as a group
  // Put in double backslashes into regex because Apex doesn't recognize that its a regex 
  // actual regex is @\[[^\]]{4,}\]\(contact:(\w{15,18})\)
  public static final String MENTIONGROUPPATTERN = '@\\[[^\\]]{4,}\\]\\(user:(\\w{15,18})\\)';
  
  // use to extract the entire mention format 
  public static final String MENTIONPATTERN = '@\\[[^\\]]{4,}\\]\\(user:\\w{15,18}\\)';
  
  public class postTooLargeException extends Exception {}
  
  // used to store mentions extracted from the post
  public class Mention {
    public Integer groupStart { get; set; }  
    public Integer groupEnd   { get; set; }
    public String  text { get; set; }
  }
  
  // parse post text into a list of Mentions
  public static List<Mention> extractAllMentions(String post) {
    Pattern pat = Pattern.compile(MENTIONPATTERN);
    Matcher matcher = pat.matcher(post);
    List<Mention> mentions = new List<Mention>(); 
   
    while(matcher.find()) {
      Mention mention = new Mention();
      mention.text    = matcher.group(); // text of matched mention
      mention.groupStart  = matcher.start(); // position in string where mention starts
      mention.groupEnd = matcher.end() ;  // position after the last char of the mention
      mentions.add(mention);
    }
    
    return mentions;
  }
  
  // parse the post body, placing @mentions and text into the passed in 
  // segments list.  Works with both feed items and comments - just pass in the
  // segments that are assigned to the appropriate object.
  public static void buildSegments(String postText, List<ConnectApi.MessageSegmentInput> segments) {
    List<Mention> mentions = extractAllMentions(postText);        
       
    if (mentions.size() > 0) {
      System.debug('mention[0]' + mentions[0]);
      // the cursor is the char position inside post
      Integer cursor = 0;
      
      for (Mention mention: mentions) {               
        // cursor is maintained at the beginning of a mention or text segment by moving it one char past the current 
        // mention at every iteration of this loop.
        if (mention.groupStart > cursor) {
          // there is text between where the cursor is and the start of this mention so store the text first. 
          // we know there is text (and we're not at end of string) because there's a mention with a start point to the right
          // of the cursor.
          ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
          textSegment.text = postText.subString(cursor, mention.groupStart);
          segments.add(textSegment);    
        }   
          
        // next, store the mention 
        ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
        String temptxt = parseOneMention(mention.text);    
        mentionSegment.id = parseOneMention(mention.text);
        segments.add(mentionSegment);
                
        cursor = mention.groupEnd;   // move cursor 1 char past where this mention ended                    
      }
        
      // After the last mention, there may be a text segment
      if (cursor < postText.length()) {
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = postText.subString(cursor, postText.length());
        segments.add(textSegment); 
      }
    } else {
      // no mentions in the post, just store the whole post as a text segment.
      ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
      textSegment.text = postText;
      segments.add(textSegment);
    }
  }

  // parse the user id out of a string that has one mention in it and return it.
  public static String parseOneMention(String mentionStr) {
    Pattern pat = Pattern.compile(MENTIONGROUPPATTERN);
    Matcher matcher = pat.matcher(mentionStr);
    matcher.find();
    return matcher.group(1);
  }

  // returns a corresponding FeedItemInput which can be used to post a new feed item
  public static ConnectApi.FeedItemInput convertToFeedItemInput(String postText) {
    // failsafe - postText size should be controlled by browser.
    if (postText.length() > 2000) { throw new postTooLargeException('post too large'); }    
    
    ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
    feedItemInput.body = new ConnectApi.MessageBodyInput();
    buildSegments(postText, feedItemInput.body.messageSegments);
    return feedItemInput;
  }
}