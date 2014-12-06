@RestResource(urlMapping='/SpheroController/*')
global with sharing class SpheroController {
    @HttpPost
        global static void create(String spheroName, String bucks) {
            SpheroController.handleSpheroMessage(spheroName, bucks);
        }
    
    public static void handleSpheroMessage(String spheroName, String bucks) {
        Sphero_Message__c sm = new Sphero_Message__c();
        sm.Sphero_Name__c = spheroName;
        sm.Bucks__c = bucks;
        insert sm;
    }
}