//The top class needs to be global as this need to be accessible for API call
global with sharing class ClonePage {
    
    private Clone cc=new Clone();
    
    //New Parent Record ID for API call
    private string newParentRecordID; 

    public Integer numberOfItems {get;private set;}
    
    public Boolean hasChildRecords {get;private set;}

    private Map<String,String> chidlObjAPIName_FieldAPIName {get;private set;}

    private string fieldsNames{get;private set;}
    
    //Parent record id
    private string recordId;
    
    //Parent object API name
    private string objName;
    
    //selected child objects
    public String[] objects {
        get {
            if (objects == null)
                objects = new String[]{};
            return objects;
        }
        set;    
    }
   
    //Constructor
    public ClonePage(){ 
        chidlObjAPIName_FieldAPIName = new Map<String,String>{};
        this.recordId = apexpages.currentPage().getParameters().get('id');
        objname=cc.returnAPIObjectName(this.recordId);
        getItems();  
    }
      
    //Clone parent and selected child objects, redirect to the new parent record page after cloning
    public pagereference chainClone() {
        fieldsNames = '';
        for(string s: objects) {            
            String objAPIName=cc.getAllChildObjNames(objname, this.recordid).get(s);            
            if(objAPIName == 'Note' || objAPIName == 'Attachment') {
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ParentId =\'' + String.escapeSingleQuotes(this.recordID) + '\'';
                SObject result = Database.query(queryString); 
                if((Integer)result.get('total')>0)
                    fieldsNames = fieldsNames + objAPIName + ',';
            }
            else {
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ' + String.escapeSingleQuotes(cc.chidlObjAPIName_FieldAPIName.get(objAPIName)) + '=\'' + String.escapeSingleQuotes(this.recordID) + '\'';
                SObject result = Database.query(queryString);
                if((Integer)result.get('total')>0)
                    fieldsNames = fieldsNames + objAPIName + ',';                   
            }
        }
        
        list<String> selectedChildObjAPINames=New list<String>();
        if(fieldsNames.length()>0) {
            for(String childObjAPIName:fieldsNames.split(',')) 
                selectedChildObjAPINames.add(childObjAPIName);
        }
        
        
        PageReference pr = new PageReference('/'+cc.startsClone(this.recordid,selectedChildObjAPINames));             
        return pr;
    }

    
    //Populate child object checkbox/picklist on the vf page
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
    
        Map<string,string> childFieldsName = cc.getAllChildObjNames(objname,this.recordId);
        
        Map<String, Schema.SObjectType> gd = Schema.getglobalDescribe();
        SObjectType sot = gd.get(cc.returnAPIObjectName(this.recordID));

        Map<String,Schema.SObjectField> fieldsNameValue = sot.getDescribe().fields.getMap();
        
        for(String objLabel :childFieldsName.keyset()) {
            String objAPIName = childFieldsName.get(objLabel);              
            List<Note> notes=new list<Note>();
            List<Attachment> attachments=new list<Attachment>();
    
            //Check note and attachment obj
            if(objAPIName == 'Note') {
                notes = [select id from Note where parentid = :this.recordid];
                if(notes.size() > 0)
                    options.add(new SelectOption('Note','Note'));
            } else if(objAPIName == 'Attachment') {
                attachments = [select id from Attachment where parentid = :this.recordid];
                if(attachments.size() > 0)
                    options.add(new SelectOption('Attachment', 'Attachment'));
            }
            else {
                system.debug('objAPIName:'+objAPIName);
                //system.debug('chidlObjAPIName_FieldAPIName.get(objAPIName):'+chidlObjAPIName_FieldAPIName.get(objAPIName));
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ' + String.escapeSingleQuotes(cc.chidlObjAPIName_FieldAPIName.get(objAPIName)) + '=\'' + String.escapeSingleQuotes(this.recordID) + '\'';
                SObject result = Database.query(queryString);
                if((Integer)result.get('total') > 0)
                    options.add(new SelectOption(objLabel,objLabel));               
            }
        }
        
        //Visualforce page use these to manage its elements on the UI
        if(options.size() > 0) {
            hasChildRecords = true;
            numberOfItems = options.size();
        }

        return options;
    }
}