public with sharing class PR {

    public PR(){
        PageReference pr = ApexPages.currentPage();
        System.assert(false);
        System.debug('***: ' + pr);
        System.debug('***: ' + pr.getHeaders());
        System.debug('***: ' + pr.getParameters());        
        System.debug('***: ' + String.valueOf(URL.getSalesforceBaseURL()) + pr.getUrl());
    }
}