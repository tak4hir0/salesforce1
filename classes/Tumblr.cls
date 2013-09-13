global class Tumblr {
    webservice static void call(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://tak4hir0.tumblr.com/');
        req.setMethod('GET');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
    }
    
    webservice static void kick(){
        Database.executeBatch(new Tumbling(), 10);
    }
    
    static testmethod void myTest(){
        Tumblr.call();
    }
}