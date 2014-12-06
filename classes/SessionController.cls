public with sharing class SessionController {
    public Account acc;
    
    public Account getAcc() {
        if(System.currentPageReference().getParameters().get('id') != null){
            this.acc = [SELECT Id, Name FROM Account WHERE id = : System.currentPageReference().getParameters().get('id')];
        }
        return this.acc; 
    } 

    
    public SessionController(){
        this.acc = new Account(Name='session');
    }
    
    public PageReference showPage1st(){
        PageReference p = Page.page1st;
        p.setRedirect(true);
        p.getParameters().put('id', this.acc.Id);
        
        return p;
    }
    
    public PageReference showPage2nd(){
        if(acc.Id == null){
            insert acc;
        }
        
        PageReference p = Page.page2nd;
        p.setRedirect(true);
        p.getParameters().put('id', this.acc.Id);

        return p;
    }

    public PageReference showPage3rd(){
        PageReference p = Page.page3rd;
        p.setRedirect(true);
        p.getParameters().put('id', this.acc.Id);
        
        return p;
    }
}