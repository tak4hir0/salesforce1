global class ChatterMining implements Database.Batchable<SObject>,Database.Stateful,Database.AllowsCallouts {

    global ChatterMining() {
    }
    
    private String accessKey;
    private String termId;
    private String endpoint;
    private Map<String, String> volumes;
    private Map<String, String> valueTypes;  
    
    private final String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
    private final String ser = 'http://services.soap.valuecardservice.com';
    private final String xsd = 'http://dto.soap.valuecardservice.com/xsd';
    private final String ax22 = 'http://dto.soap.valuecardservice.com/xsd';
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        /*
        ValueCardService__c vcs = ValueCardService__c.getValues('deposit');
        this.accessKey = vcs.accessKey__c;
        this.termId = vcs.termId__c;
        this.endpoint = vcs.endpoint__c;
        */
        
        this.volumes = new Map<String, String>();
        this.valueTypes = new Map<String, String>();
        
        return Database.getQueryLocator('Select Id, Body From FeedItem limit 100');
    }
    
    global void execute(Database.BatchableContext bc, FeedItem[] items){
        List<Mining__c> ms = new List<Mining__c>();
        
        for (FeedItem item : items) {
            try {
                // Send the request
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint('http://jlp.yahooapis.jp/MAService/V1/parse?appid=dj0zaiZpPWJlZFZmeFFBUnVtTCZkPVlXazlVMWxoVHpaTk5qUW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MTk-&results=ma,uniq&uniq_filter=9%7C10&sentence=' + EncodingUtil.urlEncode(item.Body, 'UTF-8'));

                //response
                Dom.Document resDoc;
                if(Test.isRunningTest()){
                    resDoc = new Dom.Document();
                    String result = '<?xml version="1.0" encoding="UTF-8" ?><ResultSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:yahoo:jp:jlp" xsi:schemaLocation="urn:yahoo:jp:jlp http://jlp.yahooapis.jp/MAService/V1/parseResponse.xsd"><ma_result><total_count>8</total_count><filtered_count>8</filtered_count><word_list><word><surface>庭</surface><reading>にわ</reading><pos>名詞</pos></word><word><surface>に</surface><reading>に</reading><pos>助詞</pos></word><word><surface>は</surface><reading>は</reading><pos>助詞</pos></word><word><surface>二羽</surface><reading>にわ</reading><pos>名詞</pos></word><word><surface>ニワトリ</surface><reading>にわとり</reading><pos>名詞</pos></word><word><surface>が</surface><reading>が</reading><pos>助詞</pos></word><word><surface>いる</surface><reading>いる</reading><pos>動詞</pos></word><word><surface>。</surface><reading>。</reading><pos>特殊</pos></word></word_list></ma_result><uniq_result><total_count>8</total_count><filtered_count>4</filtered_count><word_list><word><count>1</count><surface>いる</surface><reading/><pos>動詞</pos></word><word><count>1</count><surface>ニワトリ</surface><reading/><pos>名詞</pos></word><word><count>1</count><surface>二羽</surface><reading/><pos>名詞</pos></word><word><count>1</count><surface>庭</surface><reading/><pos>名詞</pos></word></word_list></uniq_result></ResultSet>';
                    resDoc.load(result);    
                } else {
                    Http http = new Http();
                    HttpResponse res = http.send(req);    
                    resDoc = res.getBodyDocument();
                }
                
                /*
                dom.XmlNode resEnvelope = resDoc.getRootElement();
                dom.XmlNode resBody = resEnvelope.getChildElement('Body', soapNS);
                String resultCode = resBody.getChildElement('depositResponse', ser).getChildElement('return', ser).getChildElement('resultCode', ax22).getText();
                */
                
                //c.resultCode__c = resultCode;
                //c.errorMessage__c = resBody.getChildElement('depositResponse', ser).getChildElement('return', ser).getChildElement('errorMessage', ax22).getText();
                //c.depositResult__c = resDoc.toXmlString();
                
                /*
                if(resultCode == '200'){
                    //c.isDeposit__c = true;
                    //c.valueDeposit__c = Integer.valueOf(resBody.getChildElement('depositResponse', ser).getChildElement('return', ser).getChildElement('valueDeposit', ax22).getText());
                }
                */
                
                ms.add(new Mining__c(ChatterID__c=item.Id, Log__c=resDoc.toXmlString()));
            
            } catch (Exception e) {
                //c.resultCode__c = 'Exception';
                //c.depositResult__c = e.getMessage() + '/' + e.getStackTraceString();    
            }
        }
        
        Database.upsert(ms, Mining__c.Fields.ChatterID__c, false);
    }
    
    global void finish(Database.BatchableContext bc){
        // ToDo メール送信
        /*
        Messaging.SingleEmailMessage eMail = new Messaging.SingleEmailMessage();

        eMail.setToAddresses(new String[] {'tkawabata@uhuru.jp'});
        eMail.setReplyTo('tkawabata@uhuru.jp');
        eMail.setSenderDisplayName('ChatterMining Results');
        eMail.setSubject('ChatterMining Results');
        
        AsyncApexJob aaj = [SELECT ApexClassId,CompletedDate,CreatedById,CreatedDate,ExtendedStatus,Id,JobItemsProcessed,JobType,LastProcessed,LastProcessedOffset,MethodName,NumberOfErrors,ParentJobId,Status,TotalJobItems FROM AsyncApexJob Where Id=:bc.getJobId()];
        eMail.setPlainTextBody(String.valueOf(aaj));
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {eMail});
        */
    }
}