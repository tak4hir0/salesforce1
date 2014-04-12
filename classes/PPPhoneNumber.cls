global class PPPhoneNumber {

	// (Required) Telephone country code
    global String countryCode {get; set;}

    //(Required) Telephone number
    global String phoneNumber {get; set;}
    
    // (Optional) Telephone extension code
	global String extension {get; set;}
	
	// Constructor
    global PPPhoneNumber() {
        countryCode = '';
        phoneNumber = '';
        extension = '';
    }
    
    public void populateAttributes(Map<String, String> receiverParams, String receiverTag) {
    	if (Null != receiverParams) {
    		if (Null != countryCode && 0 != countryCode.length()) 
    			receiverParams.put(receiverTag + PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.COUNTRY_CODE, countryCode );
    		if (Null != phoneNumber && 0 != phoneNumber.length()) 
    			receiverParams.put(receiverTag + PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.PHONE_NUMBER, phoneNumber );
    		if (Null != extension && 0 != extension.length()) 
    			receiverParams.put(receiverTag + PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.EXTENSION, extension );
    	}
    }
}