public with sharing class DownloadFiles {
    
    public ContentDocumentLink file {get;set;}
    
    public DownloadFiles(){
        //String selectedId = '069E0000000mJ1Z';
        //ContentDocumentId = '069D00000000so2'
        //this.file = [SELECT ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink WHERE ContentDocumentId = :selectedId];
    }
}