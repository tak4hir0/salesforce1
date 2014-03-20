public class OAuthTwitterSampleController {

    public OAuthTwitterSampleController(ApexPages.StandardController controller) {

    }

    private OAuth oa;
    public String status { get; set; }
    
    private OAuth oa2;
    public String status2 { get; set; }

    public OAuthTwitterSampleController() {
        oa = OAuth.newInstance('Twitter');
        oa2 = OAuth.newInstance('Tumblr');
        
        String hoge;
        hoge.length();
        
        System.debug('***: ' + oa);
    }

    public PageReference init() {
        PageReference p = Page.OAuthTwitterSample;
        p.setRedirect(true);
        if (oa.isCompleteUrl()) {
            oa.complete();
        } else if (!oa.hasToken()) {
            p = oa.authorization();
        } else {
            p = null;
        }
        return p;
    }

    public OAuthJSON getFeed() {
        OAuthJSON json = null;
        try {
            HttpResponse res = null;
            String body = null;
            if (!System.currentPageReference().getParameters().containsKey('@test')) {
                res = oa.get('https://api.twitter.com/1.1/statuses/home_timeline.json');
                body = res.getBody();
                
                System.debug('***body: ' + body);
                
            } else {
                body = '[]';
            }
            if (body != null && body != '') {
                json = OAuthJSON.newInstance(body);
            }
        } catch (OAuthException e) {
        }
        return json;
    }
    
     public OAuthJSON getFeed2() {
        OAuthJSON json = null;
        try {
            HttpResponse res = null;
            String body = null;
            if (!System.currentPageReference().getParameters().containsKey('@test')) {
//                res = oa2.get('http://api.tumblr.com/v2/user/dashboard');
                res = oa2.get('https://api.twitter.com/1.1/statuses/home_timeline.json');
                body = res.getBody();
                
                System.debug('***body: ' + body);
                
            } else {
                body = '[]';
            }
            if (body != null && body != '') {
                json = OAuthJSON.newInstance(body);
            }
        } catch (OAuthException e) {
        }
        return json;
    }

    public PageReference post() {
        if (status == null || status == '') return null;
        HttpRequest req = new HttpRequest();
        req.setEndPoint('https://api.twitter.com/1.1/statuses/update.json');
        req.setMethod('POST');
        req.setBody('status=' + EncodingUtil.urlEncode(status, 'UTF-8'));
        try {
            if (!System.currentPageReference().getParameters().containsKey('@test')) {
                oa.rest(req);
            }
            status = '';
        } catch (OAuthException e) {
        }
        return null;      
    }
}