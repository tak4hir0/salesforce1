@isTest 
private class PPPreapprovalRequestTest {
	static testMethod void testGetRequestParams() {
        PPPreapprovalRequest request = new PPPreapprovalRequest();
        request.setRequestEnvelopeParams('en_US', '');
        System.assert(request.RequestEnvelope != Null);
        System.assert(request.RequestEnvelope.ErrorLanguage.equals('en_US'));
        System.assert(request.RequestEnvelope.DetailLevelCode.equals(PPStaticRes.DEFAULT_DETAIL_LEVEL_CODE));
        
        request.cancelUrl = 'https://c.ap1.visual.force.com/apex/CancelURL';
        request.returnUrl = 'https://c.ap1.visual.force.com/apex/ReturnURL';
        PPClientDetails clientDetails = new PPClientDetails();
        clientDetails.applicationId = 'myapp';
        clientDetails.ipAddress = '172.16.4.89';
        request.clientDetails = clientDetails;
        request.CurrencyCode = 'USD';
        request.DateOfMonth = 1;
        request.DayOfWeek = 'WEDNESDAY';
        request.EndingDate = DateTime.newInstance(2009, 10, 9);
        request.MaxAmountPerPayment = 10;
        request.MaxNumberOfPayments =  5;
        request.MaxNumberOfPaymentsPerPeriod = 1;
        request.maxTotalAmountOfAllPayment = 100;
        request.PaymentPeriod = 'DAILY';
        request.PinType = 'NOT_REQUIRED';
        request.StartingDate = DateTime.newInstance(2009, 9, 20);
     	request.IpnNotificationUrl = 'http:\\www.ipnURl';
     	request.Memo = 'Memo';
     	request.SenderEmail = 'sonali@persistent.co.in';
     	
     	System.assert(request.clientDetails != Null);
     	System.assert(request.clientDetails.IpAddress.equals('172.16.4.89'));
     	System.assert(request.clientDetails.applicationId.equals('myapp'));
     	System.assert(request.CurrencyCode.equals('USD'));
     	System.assert(request.DateOfMonth == 1);
     	System.assert(request.DayOfWeek.equals('WEDNESDAY'));
     	System.assert(request.EndingDate != Null);
     	System.assert(request.MaxAmountPerPayment == 10);
     	System.assert(request.MaxNumberOfPayments == 5);
     	System.assert(request.MaxNumberOfPaymentsPerPeriod == 1);
     	System.assert(request.PaymentPeriod.equals('DAILY'));
     	System.assert(request.PinType.equals('NOT_REQUIRED'));
     	System.assert(request.StartingDate != Null);
     	System.assert(request.IpnNotificationUrl.equals('http:\\www.ipnURl'));
     	System.assert(request.SenderEmail.equals('sonali@persistent.co.in'));
     	System.assert(request.Memo.equals('Memo'));
     	
     	
     	Map<String, String> params = new Map<String, String>();
		request.getRequestParams(params);
		
		System.assert(params.get(PPStaticRes.CLIENT_DETAILS + PPStaticRes.DOT + PPStaticRes.IP_ADDRESS).equals('172.16.4.89'));
		System.assert(params.get(PPStaticRes.CLIENT_DETAILS + PPStaticRes.DOT + PPStaticRes.APPLICATION_ID).equals('myapp'));
		System.assert(params.get(PPStaticRes.CANCEL_URL).equals('https://c.ap1.visual.force.com/apex/CancelURL'));
		System.assert(params.get(PPStaticRes.RETURN_URL).equals('https://c.ap1.visual.force.com/apex/ReturnURL'));
		System.assert(params.get(PPStaticRes.CURRENCY_CODE).equals('USD'));
		System.assert(params.get(PPStaticRes.IPN_NOTIFICATION_URL).equals('http:\\www.ipnURl'));
		System.assert(params.get(PPStaticRes.MEMO).equals('Memo'));
		System.assert(params.get(PPStaticRes.SENDER_EMAIL).equals('sonali@persistent.co.in'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.ERROR_LANGUAGE).equals('en_US'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.DETAIL_LEVEL_CODE).equals('ReturnAll'));
		System.assert(params.get(PPStaticRes.DATE_OF_MONTH).equals('1'));
		System.assert(params.get(PPStaticRes.DAY_OF_WEEK).equals('WEDNESDAY'));
		System.assert(params.get(PPStaticRes.ENDING_DATE).equals((DateTime.newInstance(2009, 10, 9)).format('yyyy-MM-dd')));
		System.assert(params.get(PPStaticRes.MAX_AMOUNT_PER_PAYMENT).equals('10'));
		System.assert(params.get(PPStaticRes.MAX_NUMBER_OF_PAYMENTS).equals('5'));
		System.assert(params.get(PPStaticRes.MAX_NUMBER_OF_PAYMENTS_PER_PERIOD).equals('1'));
		System.assert(params.get(PPStaticRes.MAX_TOTAL_AMOUNT_OF_ALL_PAYMENTS).equals('100'));
		System.assert(params.get(PPStaticRes.PAYMENT_PERIOD).equals('DAILY'));
		System.assert(params.get(PPStaticRes.PIN_TYPE).equals('NOT_REQUIRED'));
		System.assert(params.get(PPStaticRes.STARTING_DATE).equals(DateTime.newInstance(2009, 9, 20).format('yyyy-MM-dd')));
	}
	
	static testMethod void testGetRequestParams2() {
        // test cases for 3_TOKEN Credentials
		PPCommonRequestParameters__c t1 = new PPCommonRequestParameters__c(  ApplicationName__c='DUMMY-APP',CurrencyCode__c='USD',DetailLevel__c='ReturnAll',FeePayer__c='SENDER',Language__c='en_US', name='test' );
		insert t1;
		
		PPPreapprovalRequest request = new PPPreapprovalRequest('test', 'sonali@persistent.co.in');
		
        System.assert(request.RequestEnvelope != Null);
        System.assert(request.RequestEnvelope.ErrorLanguage.equals('en_US'));
        System.assert(request.RequestEnvelope.DetailLevelCode.equals(PPStaticRes.DEFAULT_DETAIL_LEVEL_CODE));
        
        request.cancelUrl = 'https://c.ap1.visual.force.com/apex/CancelURL';
        request.returnUrl = 'https://c.ap1.visual.force.com/apex/ReturnURL';
        request.CurrencyCode = 'USD';
        request.DateOfMonth = 1;
        request.DayOfWeek = 'WEDNESDAY';
        request.EndingDate = DateTime.newInstance(2009, 10, 9);
        request.MaxAmountPerPayment = 10;
        request.MaxNumberOfPayments =  5;
        request.MaxNumberOfPaymentsPerPeriod = 1;
        request.maxTotalAmountOfAllPayment = 100;
        request.PaymentPeriod = 'DAILY';
        request.PinType = 'NOT_REQUIRED';
        request.StartingDate = DateTime.newInstance(2009, 9, 20);
     	request.IpnNotificationUrl = 'http:\\www.ipnURl';
     	request.Memo = 'Memo';
     	
     	System.assert(request.clientDetails != Null);
     	System.assert(request.clientDetails.applicationId.equals('DUMMY-APP'));
     	System.assert(request.CurrencyCode.equals('USD'));
     	System.assert(request.DateOfMonth == 1);
     	System.assert(request.DayOfWeek.equals('WEDNESDAY'));
     	System.assert(request.EndingDate != Null);
     	System.assert(request.MaxAmountPerPayment == 10);
     	System.assert(request.MaxNumberOfPayments == 5);
     	System.assert(request.MaxNumberOfPaymentsPerPeriod == 1);
     	System.assert(request.PaymentPeriod.equals('DAILY'));
     	System.assert(request.PinType.equals('NOT_REQUIRED'));
     	System.assert(request.StartingDate != Null);
     	System.assert(request.IpnNotificationUrl.equals('http:\\www.ipnURl'));
     	System.assert(request.SenderEmail.equals('sonali@persistent.co.in'));
     	System.assert(request.Memo.equals('Memo'));
     	
     	
     	Map<String, String> params = new Map<String, String>();
		request.getRequestParams(params);
		
		System.assert(params.get(PPStaticRes.CLIENT_DETAILS + PPStaticRes.DOT + PPStaticRes.APPLICATION_ID).equals('DUMMY-APP'));
		System.assert(params.get(PPStaticRes.CANCEL_URL).equals('https://c.ap1.visual.force.com/apex/CancelURL'));
		System.assert(params.get(PPStaticRes.RETURN_URL).equals('https://c.ap1.visual.force.com/apex/ReturnURL'));
		System.assert(params.get(PPStaticRes.CURRENCY_CODE).equals('USD'));
		System.assert(params.get(PPStaticRes.IPN_NOTIFICATION_URL).equals('http:\\www.ipnURl'));
		System.assert(params.get(PPStaticRes.MEMO).equals('Memo'));
		System.assert(params.get(PPStaticRes.SENDER_EMAIL).equals('sonali@persistent.co.in'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.ERROR_LANGUAGE).equals('en_US'));
		System.assert(params.get(PPStaticRes.REQUEST_ENVELOPE + PPStaticRes.DOT + PPStaticRes.DETAIL_LEVEL_CODE).equals('ReturnAll'));
		System.assert(params.get(PPStaticRes.DATE_OF_MONTH).equals('1'));
		System.assert(params.get(PPStaticRes.DAY_OF_WEEK).equals('WEDNESDAY'));
		System.assert(params.get(PPStaticRes.ENDING_DATE).equals((DateTime.newInstance(2009, 10, 9)).format('yyyy-MM-dd')));
		System.assert(params.get(PPStaticRes.MAX_AMOUNT_PER_PAYMENT).equals('10'));
		System.assert(params.get(PPStaticRes.MAX_NUMBER_OF_PAYMENTS).equals('5'));
		System.assert(params.get(PPStaticRes.MAX_NUMBER_OF_PAYMENTS_PER_PERIOD).equals('1'));
		System.assert(params.get(PPStaticRes.MAX_TOTAL_AMOUNT_OF_ALL_PAYMENTS).equals('100'));
		System.assert(params.get(PPStaticRes.PAYMENT_PERIOD).equals('DAILY'));
		System.assert(params.get(PPStaticRes.PIN_TYPE).equals('NOT_REQUIRED'));
		System.assert(params.get(PPStaticRes.STARTING_DATE).equals(DateTime.newInstance(2009, 9, 20).format('yyyy-MM-dd')));
	}
}