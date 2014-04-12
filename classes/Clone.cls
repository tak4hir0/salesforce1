//The top class needs to be global as this needs to be accessible for API call
global with sharing class Clone { 
   
   //New Parent Record ID for API call
   global string newParentRecordID {get;private set;}
   
	//test
    
    public class MyException extends Exception {}
    
    public Map<String,String> chidlObjAPIName_FieldAPIName = new Map<String,String>{};

   //standard constructor
   global Clone(){
		String hoge;
   }

   //quick clone constructor
   global Clone(String parentRecordID,List<String> childObjAPINames){
        newParentRecordID=startsClone(parentRecordID,childObjAPINames);
   }
   
   //excute clone and returns new parent record id
   public string startsClone(String parentRecordID,List<String> childObjAPINames){
        string fieldsNames=''; 

        //Loop through all child object names
        for(string objAPIName: childObjAPINames) {
            //Check if current child object has records linked with the parent record            
            //Handle Note and Attachement in different way as they use "ParentID" in the query
            if(objAPIName == 'Note' || objAPIName == 'Attachment') {
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ParentId =\'' + String.escapeSingleQuotes(parentRecordID) + '\'';
                SObject result = Database.query(queryString); 

                //Find note and attachment records, add note & attachment into the list
                if((Integer)result.get('total') > 0)
                    fieldsNames = fieldsNames + objAPIName + ',';
            }
            else {
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ' + String.escapeSingleQuotes(chidlObjAPIName_FieldAPIName.get(objAPIName)) + '=\'' + String.escapeSingleQuotes(parentRecordID) + '\'';
                SObject result = Database.query(queryString);                   

                //Find child object records linked with the parent record, add the child object API name into the list
                if((Integer)result.get('total') > 0)
                    fieldsNames = fieldsNames + objAPIName + ',';
            }
        }
        
        //Create Child Object API Name and creatable fields map
        Map<String, list<String>> objFields = New Map<String, list<String>>{};
        if(fieldsNames.length()>0) {
            //getCreatableFields(objAPIName) returns all creatable fields name for a given child obj API name        
            for(String objAPIName:fieldsNames.split(','))
                objFields.put(objAPIName,getCreatableFields(objAPIName));
            
        }

        //Clone parent record
        String newParentRecordID = cloneParentRecord(returnAPIObjectName(parentRecordID),getCreatableFields(returnAPIObjectName(parentRecordID)),parentRecordID);

        //Clone all selected child records
        for(String childObjAPIName:objFields.keySet())
            cloneChildRecords(childObjAPIName, objFields.get(childObjAPIName), returnAPIObjectName(parentRecordID), newParentRecordID,parentRecordID);

        return newParentRecordID;    
    }

    //Get all child object (which have records linked with the parent record) API name
    private void getFieldAPINames (String[] objects,String parentObjAPIName,String parentRecordID){
        string fieldsNames = '';
        for(string s: objects) {            
            String objAPIName=getAllChildObjNames(parentObjAPIName,parentRecordID).get(s);            
            if(objAPIName == 'Note' || objAPIName == 'Attachment') {
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ParentId =\'' + String.escapeSingleQuotes(parentRecordID) + '\'';
                SObject result = Database.query(queryString); 
                if((Integer)result.get('total')>0)
                    fieldsNames = fieldsNames + objAPIName + ',';
            }
            else {
                String queryString = 'select count(id) total from ' + String.escapeSingleQuotes(objAPIName) + ' where ' + String.escapeSingleQuotes(chidlObjAPIName_FieldAPIName.get(objAPIName)) + '=\'' + String.escapeSingleQuotes(parentRecordID) + '\'';
                SObject result = Database.query(queryString);
                if((Integer)result.get('total')>0)
                    fieldsNames = fieldsNames + objAPIName + ',';                   
            }
        }
    }

    //Clone all child records
    public void cloneChildRecords(String objAPIName, list<String> createableFields, String parentObjAPIName, string newParentRecordID, string parentRecordID){
        String fields = '';
        for(string s:createableFields)
            fields = fields + s + ',';

        fields=fields.substring(0, fields.lastIndexOf(','));

        String queryString = 'select ' + String.escapeSingleQuotes(fields) + ' from ' + String.escapeSingleQuotes(objAPIName) + ' where ' + String.escapeSingleQuotes(chidlObjAPIName_FieldAPIName.get(objAPIName)) + '=\'' + String.escapeSingleQuotes(parentRecordID) + '\'';
        list<SObject> result = Database.query(queryString);         
        list<SObject> copy = result.deepclone(false);       
        for(SObject obj :copy)
            obj.put(chidlObjAPIName_FieldAPIName.get(objAPIName), newParentRecordID);
        insert copy;
    }

    //Clone parent record and return new parent record ID
    public String cloneParentRecord(String objAPIName, List<String> createableFields,string parentRecordID) {
        String fields = '';
        for(string s:createableFields) {
            //Remove all contact mirror fields from person account
            if(s.contains('__pc') == false)
                fields = fields + s + ',';          
        }
        fields = fields.substring(0, fields.lastIndexOf(','));

        String queryString = 'select ' + String.escapeSingleQuotes(fields) + ' from ' + String.escapeSingleQuotes(objAPIName) + ' where id=\'' + String.escapeSingleQuotes(parentRecordID) + '\'';
        SObject result = Database.query(queryString);       
        Sobject copy = result.clone(false, true);
        insert copy;
        return copy.id ;
    }
       
    //Return the object API name for a given record
    public String returnAPIObjectName (string myRecordID){
        String objectName = '';
        
        String prefix = myRecordID.substring(0,3);
    
        Map<String, Schema.SObjectType> gd = Schema.getglobalDescribe();

        for(SObjectType s :gd.values()) {
            DescribeSObjectResult r = s.getDescribe();     
            if(r.getKeyPrefix()!=null) {
                if(r.getLocalName()!=null && r.getKeyPrefix().equals(prefix)) {
                    objectName=r.getLocalName();
                    break;
                } 
             }
        }        
        return objectName;
    }
    
    
    //Get all creatable fields for a given object
    public list<String> getCreatableFields(String objAPIName){
        Map<string,string> childFieldsName = new Map<string,string>{};
        
        Map<String, Schema.SObjectType> gd = Schema.getglobalDescribe();
        SObjectType sot = gd.get(objAPIName);
      
        //Get all non-creatable fields name except
        //Get the field tokens map
        Map<String, SObjectField> fields = new Map<String, SObjectField>{};
        if(sot.getDescribe().fields.getMap().keyset().size()>0)
            fields = sot.getDescribe().fields.getMap();
        
        //And drop those tokens in a List
        List<SObjectField> fieldtokens = fields.values();
        
        List<string> objectFields = new List<String>();
        
        for(SObjectField fieldtoken:fieldtokens) {
            DescribeFieldResult dfr = fieldtoken.getDescribe();
            
            if(dfr.isCreateable())
                objectFields.add(dfr.getLocalName());                       
        }
        
        return objectFields;
    }
    
    //Get all child object API names for a given parent object API name
    //return Map<object label,object local name>,
    public Map<string,string> getAllChildObjNames(String parentObj,String parentRecordID) {        
        Map<string,string> childFieldsName = new Map<string,string>{};        
        Map<String, Schema.SObjectType> gd = Schema.getglobalDescribe();
        SObjectType sot = gd.get(ParentObj);
       
       //Get all child fields
        Schema.DescribeSObjectResult fieldResult2 = sot.getDescribe();
        List<Schema.ChildRelationship> children = fieldResult2.getChildRelationships();
        for(Schema.ChildRelationship child:children) {
            //Exclude following objects
            if(child.getChildSObject().getDescribe().getLocalName() <> 'ProcessInstance' 
            && child.getChildSObject().getDescribe().getLocalName() <> 'ProcessInstanceHistory' 
            && child.getChildSObject().getDescribe().getLocalName() <> 'ContentVersion'
            && child.getChildSObject().getDescribe().getLocalName() <> 'ContentDocument'   
            && child.getChildSObject().getDescribe().getLocalName() <> 'ActivityHistory'
            && child.getChildSObject().getDescribe().getLocalName() <> 'OpenActivity'
            && child.getChildSObject().getDescribe().getLocalName() <> 'Event'
            && child.getChildSObject().getDescribe().getLocalName() <> 'Task'
            && child.getChildSObject().getDescribe().getLocalName() <> 'User'
            && child.getChildSObject().getDescribe().getLocalName() <> 'FeedComment'
            && child.getChildSObject().getDescribe().getLocalName() <> 'FeedPost'
            && child.getChildSObject().getDescribe().getLocalName() <> 'EntitySubscription'
            && child.getChildSObject().getDescribe().getLocalName() <> 'NoteAndAttachment'
            && child.getChildSObject().getDescribe().getLocalName() <> 'UserRole'
            && child.getChildSObject().getDescribe().getLocalName() <> 'Partner'
            && child.getChildSObject().getDescribe().getLocalName() <> 'CampaignMemberStatus'
        
            //Do not take parent record which is the same object
            && child.getChildSObject().getDescribe().getLocalName() <> returnAPIObjectName(parentRecordID)

            //exclude obj created for sharing purpose
            && child.getChildSObject().getDescribe().getLocalName() <> returnAPIObjectName(parentRecordID) + 'share'
            && child.getChildSObject().getDescribe().getLocalName().endsWith('__Share')==false

            //has to be creatable
            && child.getChildSObject().getDescribe().isCreateable() == true) {
                string a=string.valueof(child.getChildSObject().getdescribe().getLocalName());
                string b=string.valueof(child.getField());
                chidlObjAPIName_FieldAPIName.put(string.valueof(child.getChildSObject().getdescribe().getLocalName()), string.valueof(child.getField()));
                childFieldsName.put(child.getChildSObject().getDescribe().getLabel(), child.getChildSObject().getDescribe().getLocalName());
            }
        }

        return childFieldsName;
    }
}