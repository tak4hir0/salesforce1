@isTest 
private class DataUtil {
    static testmethod void testLoadData() {
        // Load the test accounts from the static resource
        List<sObject> ls = Test.loadData(Account.sObjectType, 'Acc');
        //List<sObject> ls2 = Test.loadData(Contact.sObjectType, 'Con');
        // Verify that all 3 test accounts were created

        //List<sObject> results = [Select Name From Account];
		//System.debug('***' + results.size());
        
        for(Contact a : [Select AccountId From Contact]){
        	System.debug('***: ' + a.AccountId);
        }
        
        // Get first test account
/*
        Account a1 = (Account)ls[0];
        String acctName = a1.Name;
        System.debug(acctName);
*/
        // Perform some testing using the test records
    }
}