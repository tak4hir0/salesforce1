global class PPReceiver {
	// (Required) Amount to be credited to the receiver's account.
    global Decimal Amount {get; set;}

    //(Required) Receiver's email address.
    global String Email {get; set;}
    
    // (Optional) Whether this receiver is the primary receiver, which makes the
	// payment a chained payment. You can specify at most one primary receiver.
	// Omit this field for simple and parallel payments.
	global Boolean Primary {get; set;}
	
	// (Optional) The invoice number for the payment. This field is only used in 
	// the Pay API operation. it is ignored in all other Adaptive Payment APIs.
    global String InvoiceId {get; set;}
    
    // (Optional) The payment type for the payment.
	global String PaymentType {get; set;} 
	
	// (Optional) The payment subtype for the payment.
	global String PaymentSubType {get; set;} 
	
	// (Optional) Receiver's phone number - either email or phone must be set
	global PPPhoneNumber Phone {get; set;} 
	
    
    // Constructor
    global PPReceiver() {
        Amount = 0.0;
        Email = '';
        Primary = Null;
        InvoiceId = '';
        PaymentType = '';
        Phone = Null;
    }
    
    public void populateAttributes(Map<String, String> receiverParams, String receiverTag) {
    	if (Null != receiverParams) {
    		if (Null != Email && 0 != Email.length()) 
    		receiverParams.put(receiverTag + PPStaticRes.EMAIL, Email);
    		
    		if (0 < Amount)
    		receiverParams.put(receiverTag + PPStaticRes.AMOUNT, String.valueOf(Amount));
    			
    		if (Null != InvoiceId && 0 != InvoiceId.length())
    			receiverParams.put(receiverTag + PPStaticRes.INVOICE_ID, InvoiceId);
    			
    		if (Null != Primary) {
    			if (true == Primary)
    				receiverParams.put(receiverTag + PPStaticRes.PRIMARY, PPStaticRes.STRING_TRUE);
            	else 
    				receiverParams.put(receiverTag + PPStaticRes.PRIMARY, PPStaticRes.STRING_FALSE);
			}
			
			if (Null != PaymentType && 0 != PaymentType.length())
				receiverParams.put(receiverTag + PPStaticRes.PAYMENT_TYPE, PaymentType);
			if (Null != PaymentSubType && 0 != PaymentSubType.length())
				receiverParams.put(receiverTag + PPStaticRes.PAYMENT_SUB_TYPE, PaymentSubType);
			if (Null != Phone) {
			 	Phone.populateAttributes(receiverParams, receiverTag);
			}
    	}
    }
    
    public void parseAttributes(Map<String, String> receiverParams, String prefixTag) {
    	String tag = prefixTag + PPStaticRes.AMOUNT;
	    if (receiverParams.containsKey(tag)) {
        	String amountStr = receiverParams.remove(tag);
        	if (Null != amountStr)
        		Amount = Decimal.valueOf(amountStr);
	    }
	    
        tag = prefixTag + PPStaticRes.EMAIL;
        if (receiverParams.containsKey(tag))
        	Email = receiverParams.remove(tag);
        
        tag = prefixTag + PPStaticRes.INVOICE_ID;
        if (receiverParams.containsKey(tag))
        	InvoiceId = receiverParams.remove(tag);
        	
        tag = prefixTag + PPStaticRes.PRIMARY;
        if (receiverParams.containsKey(tag)) {
        	String primaryStr = receiverParams.remove(tag);
        	if (Null != primaryStr) {
        		if (primaryStr.equalsIgnoreCase(PPStaticRes.STRING_TRUE))
        			Primary = true;
        		else if (primaryStr.equalsIgnoreCase(PPStaticRes.STRING_FALSE))
         			Primary = false;
        	}
        }
        tag = prefixTag + PPStaticRes.PAYMENT_TYPE;
        if (receiverParams.containsKey(tag))
        PaymentType = receiverParams.remove(tag);
        
        tag = prefixTag + PPStaticRes.PAYMENT_SUB_TYPE;
        if (receiverParams.containsKey(tag))
        PaymentSubType = receiverParams.remove(tag);
        
        tag = prefixTag + PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.PHONE_NUMBER;
        if (receiverParams.containsKey(tag)) {
        	Phone = new PPPhoneNumber();
           	Phone.phoneNumber = receiverParams.remove(tag);
           	tag = prefixTag + PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.COUNTRY_CODE;
           	if (receiverParams.containsKey(tag)) 
           		Phone.countryCode = receiverParams.remove(tag);
           	tag = prefixTag + PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.EXTENSION;
           	if (receiverParams.containsKey(tag)) 
           		Phone.extension = receiverParams.remove(tag);
        }
    }
}