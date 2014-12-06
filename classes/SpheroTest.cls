@isTest
public class SpheroTest{

    static testmethod void testSphero() {
    	//should result in a new sphero message
        SpheroController.create('rgb','128');
        List<Sphero_Message__c> messages = [Select Id, Name, Sphero_Name__c, Bucks__c From Sphero_Message__c where Sphero_Name__c = 'rgb'];
        System.assertEquals(1, messages.size());
    }
    
//    static testmethod void test_BadSphero() {
//        SpheroController.create('rgb-11111122222333334444455555','tmp36');
//       List<Sphero_Message__c> messages = [Select Id, Name, Sphero_Name__c, Bucks__c From Sphero_Message__c where Sphero_Name__c = 'rgb-11111122222333334444455555'];
//        System.assertNotEquals(1, messages.size());
//    }    
        
}