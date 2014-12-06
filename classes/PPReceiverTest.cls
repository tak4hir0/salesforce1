@isTest 
private class PPReceiverTest {
    static testMethod void testpopulateAttributes() {
        PPReceiver receiver = new PPReceiver();
        receiver.Amount = 123.00;
        receiver.Email = 'paypal@persistent.co.in';
        receiver.Primary = false;
        receiver.InvoiceId = '1223';
        receiver.PaymentType = 'GOODS';
        receiver.PaymentSubType = 'PAYROLL';
        PPPhoneNumber ppPhone = new PPPhoneNumber();
        ppPhone.countryCode = '91';
        ppPhone.extension = '4445';
        ppPhone.phoneNumber = '2537683';
        receiver.Phone = ppPhone;
        
        Map<String, String> receiverParams = new Map<String, String>();
        receiver.populateAttributes(receiverParams, '');
        
        // Assertion
        System.assert(receiverParams.get(PPStaticRes.AMOUNT).equals('123.0'));
        System.assert(receiverParams.get(PPStaticRes.EMAIL).equals('paypal@persistent.co.in'));
        System.assert(receiverParams.get(PPStaticRes.PRIMARY).equals('false'));
        System.assert(receiverParams.get(PPStaticRes.INVOICE_ID).equals('1223'));
        System.assert(receiverParams.get(PPStaticRes.PAYMENT_TYPE).equals('GOODS'));
        System.assert(receiverParams.get(PPStaticRes.PAYMENT_SUB_TYPE).equals('PAYROLL'));
        
        System.assert(receiverParams.get(PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.COUNTRY_CODE).equals('91'));
        System.assert(receiverParams.get(PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.PHONE_NUMBER).equals('2537683'));
        System.assert(receiverParams.get(PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.EXTENSION).equals('4445'));
        
    }
    
    static testMethod void testparseAttributes() {
        PPReceiver receiver  = new PPReceiver();
        Map<String, String> receiverParams = new Map<String, String>();
        receiverParams.put('receiverList.receiver.amount', '12212');
        receiverParams.put('receiverList.receiver.email', 'sonali@persistent.co.in');
        receiverParams.put('receiverList.receiver.primary', 'false');
        receiverParams.put('receiverList.receiver.invoiceId', '32342343');
        receiverParams.put('receiverList.receiver.paymentType', 'SERVICE');
        receiverParams.put('receiverList.receiver.paymentSubType', 'PAYROLL');
        receiverParams.put('receiverList.receiver.phone.countryCode', '91');
        receiverParams.put('receiverList.receiver.phone.extension', '4445');
        receiverParams.put('receiverList.receiver.phone.phoneNumber', '2537683');
        receiver.parseAttributes(receiverParams, 'receiverList.receiver.');
        
        // Assertion
        System.assert(receiver.Amount == 12212);
        System.assert(receiver.Email.equals('sonali@persistent.co.in'));
        System.assert(receiver.Primary == false);
        System.assert(receiver.InvoiceId.equals('32342343'));
        System.assert(receiver.PaymentType.equals('SERVICE'));
        System.assert(receiver.PaymentSubType.equals('PAYROLL'));
        System.assert( Null != receiver.Phone);
        System.assert(receiver.Phone.countryCode.equals('91'));
        System.assert(receiver.Phone.extension.equals('4445'));
        System.assert(receiver.Phone.phoneNumber.equals('2537683'));
        
    }
    
     static testMethod void testparseAttributesOne() {
        PPReceiver receiver  = new PPReceiver();
        Map<String, String> receiverParams = new Map<String, String>();
        receiverParams.put('receiverList.receiver.amount', '12212');
        receiverParams.put('receiverList.receiver.email', 'sonali@persistent.co.in');
        receiverParams.put('receiverList.receiver.primary', 'true');
        receiverParams.put('receiverList.receiver.invoiceId', '32342343');
        receiver.parseAttributes(receiverParams, 'receiverList.receiver.');
        
        // Assertion
        System.assert(receiver.Amount == 12212);
        System.assert(receiver.Email.equals('sonali@persistent.co.in'));
        System.assert(receiver.Primary == true);
        System.assert(receiver.InvoiceId.equals('32342343'));
    }
    static testMethod void testpopulateAttributesOne() {
        PPReceiver receiver = new PPReceiver();
        receiver.Amount = 123.00;
        receiver.Email = 'paypal@persistent.co.in';
        receiver.Primary = true;
        receiver.InvoiceId = '1223';
        Map<String, String> receiverParams = new Map<String, String>();
        receiver.populateAttributes(receiverParams, '');
        
         // Assertion
        System.assert(receiverParams.get(PPStaticRes.AMOUNT).equals('123.0'));
        System.assert(receiverParams.get(PPStaticRes.EMAIL).equals('paypal@persistent.co.in'));
        System.assert(receiverParams.get(PPStaticRes.PRIMARY).equals('true'));
        System.assert(receiverParams.get(PPStaticRes.INVOICE_ID).equals('1223'));
    }

}