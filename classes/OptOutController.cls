public without sharing class OptOutController {

    public OptOutController(ApexPages.StandardController controller) {
        this.um = [Select Name, Email__c, WishWEBContents__c, WishAccounts__c, WishSeminarEvent__c, WishExam__c From UniqueMail__c Where Id=: ApexPages.currentPage().getParameters().get('id')];   
        this.logs =  String.valueOf(this.um);
    }
    
    public UniqueMail__c um{get;set;}
    public String logs{get;set;}
    
    public PageReference save(){
        update um;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, '保存しました。'));
        
        return null;
    }
    
}