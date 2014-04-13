global class PPExecutePaymentResponse extends PPResponse {

    
    // The status of the payment.
    global String PaymentExecStatus {get; set;}
    
    // Information about why a payment failed.
    public List<PPPayError> PayErrorList { get; set; }
    
    // Constructor
    global PPExecutePaymentResponse() {
        PayErrorList  = new List<PPPayError>();
        PaymentExecStatus = '';
    }
    
    global List<PPPayError> getErrorList() {
    	return PayErrorList;
    }
    
    global override PPResponseEnvelope getResponseEnvelope() {
    	return ResponseEnvelope;
    }
    
    public override void parseResponseParameters(Map<String, String> parameters) {
    	try {
	    	super.parseCommonParams(parameters);

	    	if (parameters.containsKey(PPStaticRes.PAYMENT_EXEC_STATUS))
	        	PaymentExecStatus = parameters.remove(PPStaticRes.PAYMENT_EXEC_STATUS);

    		Map<String, String> errorMap = null;
    		Integer errorNo = 0;
    		Boolean isMoreError = true;
    		while (isMoreError) {
				String errorTag = PPStaticRes.ERROR + PPStaticRes.OPENING_BRACKET + errorNo + PPStaticRes.CLOSING_BRACKET + PPStaticRes.DOT;
				
				/***********************************************************************************
					Response for receiver information is assumed to be in the format - 
					"error(o).Category=error&receiver(0).primary=false&
					receiver(0).Email=paypal@persistent.co.in&receiver.amount=111.11"
				***********************************************************************************/
				String receiverTag = PPStaticRes.RECEIVER + PPStaticRes.OPENING_BRACKET + errorNo + PPStaticRes.CLOSING_BRACKET + PPStaticRes.DOT;
				errorMap = PPUtils.getMapWithSpecificKeys(parameters, errortag);
				Map<String, String> tempMap = PPUtils.getMapWithSpecificKeys(parameters, receiverTag);
				set<String> keys = tempMap.keySet();
				for (String key : keys) {
					errorMap.put(key, tempMap.get(key));	
				}
				
				if (Null != errorMap && 0 != errorMap.size()) {
					PPPayError error = new PPPayError();
					error.parseAttributes(errorMap, errorTag, receiverTag);
					PayErrorList.add(error);
					errorNo++;
				} 
				else {
					isMoreError = false;
				}
    		}
    	}
    	catch (System.Exception e) {
    		System.Debug(Logginglevel.ERROR, 'PPPayResponse:parseResponseParameters() : ' + e);
    	}
    }
    
    
}