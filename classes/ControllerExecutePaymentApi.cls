public class ControllerExecutePaymentApi {
	
    public PPExecutePaymentRequest ExecutePaymentRequest 	{get;set;}
    public PPExecutePaymentResponse ExecutePaymentResponse	{get;set;} 
    public PPResponseEnvelope RespEnvp 						{get;set;}

    public string MainMessage     							{get;set;} 
    public String payKey									{get;set;}
    
 	public String CommonParametersObjName					{get;set;}
    public String APICredentialObjName						{get;set;}
    
	public string SuccessMessage					{get;set;}
    public Boolean IsDisplay 						{get;set;}
  	public Boolean IsErr									{get;set;}
    
    public ControllerExecutePaymentApi(){
    	
        ExecutePaymentResponse = new PPExecutePaymentResponse();
    }

	public pagereference ExecutePayment(){
        PageReference page = null;
        MainMessage = '';
        IsErr = false;
        IsDisplay = false;
        ExecutePaymentRequest = new PPExecutePaymentRequest(CommonParametersObjName);
        ExecutePaymentRequest.PayKey = paykey;
        // create the Adaptive Toolkit object instance w/ API Credentials
        PPAdaptiveToolkit toolkit = new PPAdaptiveToolkit(APICredentialObjName);
        try {
	        System.Debug(Logginglevel.INFO, '==>Request' + ExecutePaymentRequest);
        	ExecutePaymentResponse = toolkit.executePayment(ExecutePaymentRequest );
    	    System.Debug(Logginglevel.INFO, '==>response' + ExecutePaymentResponse);
            RespEnvp = ExecutePaymentResponse.getResponseEnvelope();
            System.debug('===========>Ack' + RespEnvp);
            
            System.debug(ExecutePaymentResponse);			
			IsDisplay = true;
			RespEnvp = ExecutePaymentResponse.ResponseEnvelope;
        	if( ExecutePaymentResponse.PaymentExecStatus.equalsIgnoreCase('Created') ) {
        		//Page = toolkit.commitpayment(PayResponse.payKey);
        		SuccessMessage = 'Payment Created - <a href=' + toolkit.BaseAPIProfile.getPayPalLoginPage() 
        				+  '_ap-payment&paykey=' + payKey + '>click to approve</a> payKey - ' + payKey; 
			} else if( ExecutePaymentResponse.PaymentExecStatus.equalsIgnoreCase('Completed') ) {
        		//Page = new pagereference(request.returnUrl); 
        		SuccessMessage = 'Payment Completed - payKey - ' + payKey; 
            } else {
            	IsDisplay = true;
            	RespEnvp = ExecutePaymentResponse.getResponseEnvelope();
            	MainMessage = 'Payment Execution Status returned from server is - ' + ExecutePaymentResponse.PaymentExecStatus;
    		}
    		
        }catch(PPFaultMessageException ex) {
			System.debug('PPFaultMessageException =>' + ex);
			IsDisplay = true;
			RespEnvp = ex.ResponseEnvelope;
    		List<PPErrorData> errList = ex.ErrorList;
			for( PPErrorData err: errList ){
                MainMessage += err.ErrorId + ' : ' + err.Message + '<br>';
			}
       }catch(System.Exception e){
			System.debug('System.Exception =>' + e);
        	MainMessage = e.getMessage();
       } 
        return page;
	}
             
}