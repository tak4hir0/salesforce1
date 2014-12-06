global class PPExecutePaymentRequest extends PPRequest {
	// The pay key that identifies the payment for which you 
	// want to retrieve details. This is the pay key returned in the 
	// PayResponse message.
	global String PayKey { get;	set; }
	
	// (Required) The type of action.
    global String ActionType {get; set;}
    
    // Constructor
	global PPExecutePaymentRequest() {
		ApiName = PPStaticRes.EXECUTE_PAYMENT_API;
		ActionType = PPStaticRes.PAY_ACTION;
		PayKey = '';
	}
	
	global PPExecutePaymentRequest(String CommonRequestParametersObjectName){
		ApiName = PPStaticRes.EXECUTE_PAYMENT_API;
		ActionType = PPStaticRes.PAY_ACTION;
		PayKey = '';
		PPCommonRequestParameters commonRequestParameters = new PPCommonRequestParameters(CommonRequestParametersObjectName);
        // set request envelope fields
        setRequestEnvelopeParams(commonRequestParameters.Language, commonRequestParameters.DetailLevel);
	}
	
	
	global override void setRequestEnvelopeParams(String language, String detailLevelCode) {
		super.setRequestEnvp(language, detailLevelCode);
	}
	
	public override void getRequestParams(Map<String, String> requestParams) {
		if (Null != requestParams) {
			super.setCommonRequestParams(requestParams);
			if (Null != PayKey && 0 != PayKey.length())		
    			requestParams.put(PPStaticRes.PAY_KEY, PayKey);
    			
    		if (Null != ActionType && 0 != ActionType.length())
            	requestParams.put(PPStaticRes.ACTION_TYPE, ActionType);
		}
	}
}