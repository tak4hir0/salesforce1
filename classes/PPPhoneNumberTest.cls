/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class PPPhoneNumberTest {

    static testMethod void testPPPhoneNumber() {
        PPPhoneNumber ppPhone = new PPPhoneNumber();
        ppPhone.countryCode = '91';
        ppPhone.extension = '4445';
        ppPhone.phoneNumber = '2537683';
        System.assert('91'.equals(ppPhone.countryCode));
        System.assert('4445'.equals(ppPhone.extension));
        System.assert('2537683'.equals(ppPhone.phoneNumber));
        System.assertNotEquals('91', ppPhone.extension);
        System.assertNotEquals('91', ppPhone.phoneNumber);
        System.assertNotEquals('4445', ppPhone.countryCode);
    }
    
    static testMethod void testpopulateAttributes() {
        PPPhoneNumber ppPhone = new PPPhoneNumber();
        ppPhone.countryCode = '91';
        ppPhone.extension = '4445';
        ppPhone.phoneNumber = '2537683';
        Map<String, String> receiverParams = new Map<String, String>();
        ppPhone.populateAttributes(receiverParams, '');
        
        // Assertion
        System.assert(receiverParams.get(PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.COUNTRY_CODE).equals('91'));
        System.assert(receiverParams.get(PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.PHONE_NUMBER).equals('2537683'));
        System.assert(receiverParams.get(PPStaticRes.PHONE + PPStaticRes.DOT + PPStaticRes.EXTENSION).equals('4445'));
    }
}