public class List2Con {
    // ApexPages.StandardSetController must be instantiated
    // for standard list controllers
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, Name FROM Account]));
            }
            return setCon;
        }
        set;
    }

    // Initialize setCon and return a list of records
    public List<Account> getAccounts() {
        return (List<Account>) setCon.getRecords();
    }
}