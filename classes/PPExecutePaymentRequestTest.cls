@isTest
private class PPExecutePaymentRequestTest {

    static testMethod void testGetRequestParamsOne() {
		PPExecutePaymentRequest execPaymentRequest = new PPExecutePaymentRequest();
		execPaymentRequest.PayKey = 'AP12345';
		execPaymentRequest.setRequestEnvelopeParams('language', 'detailLevelCode');
		Map<String, String> params = new Map<String, String>();
		execPaymentRequest.getRequestParams(params);
		
		// Assertion
		System.assert(params.get(PPStaticRes.PAY_KEY).equals('AP12345'));
		System.assert(params.get(PPStaticRes.ACTION_TYPE).equals('PAY'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.ERROR_LANGUAGE).equals('language'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.DETAIL_LEVEL_CODE).equals('detailLevelCode'));
	}	
	
	static testMethod void testGetRequestParamsTwo() {
		PPExecutePaymentRequest execPaymentRequest = new PPExecutePaymentRequest();
		execPaymentRequest.PayKey = 'AP12345';
		execPaymentRequest.setRequestEnvelopeParams('language', '');
		
		Map<String, String> params = new Map<String, String>();
		execPaymentRequest.getRequestParams(params);
		
		// Assertion
		System.assert(params.get(PPStaticRes.PAY_KEY).equals('AP12345'));
		System.assert(params.get(PPStaticRes.ACTION_TYPE).equals('PAY'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.ERROR_LANGUAGE).equals('language'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.DETAIL_LEVEL_CODE).equals('ReturnAll'));
	}
	static testMethod void testGetRequestParamsThree() {
		PPExecutePaymentRequest execPaymentRequest = new PPExecutePaymentRequest();
		execPaymentRequest.PayKey = 'AP12345';
		execPaymentRequest.setRequestEnvelopeParams('', 'detailLevelCode');
		Map<String, String> params = new Map<String, String>();
		execPaymentRequest.getRequestParams(params);
		
		// Assertion
		System.assert(params.get(PPStaticRes.PAY_KEY).equals('AP12345'));
		System.assert(params.get(PPStaticRes.ACTION_TYPE).equals('PAY'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.DETAIL_LEVEL_CODE).equals('detailLevelCode'));
	}
	static testMethod void testGetRequestParamsFour() {
		 // test cases for 3_TOKEN Credentials
		PPCommonRequestParameters__c t1 = new PPCommonRequestParameters__c(  ApplicationName__c='DUMMY-APP',CurrencyCode__c='USD',DetailLevel__c='ReturnAll',FeePayer__c='SENDER',Language__c='en_US', name='test' );
		insert t1;
		PPExecutePaymentRequest execPaymentRequest = new PPExecutePaymentRequest('test');
		execPaymentRequest.PayKey = 'AP12345';
		execPaymentRequest.ActionType = 'PAY_PRIMARY';
		Map<String, String> params = new Map<String, String>();
		execPaymentRequest.getRequestParams(params);
		
		// Assertion
		System.assert(params.get(PPStaticRes.PAY_KEY).equals('AP12345'));
		System.assert(params.get(PPStaticRes.ACTION_TYPE).equals('PAY_PRIMARY'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.ERROR_LANGUAGE).equals('en_US'));
	}	
}