public with sharing class AccountService {
     
    @AuraEnabled
    public static List<Account__x> searchAccountsByName(String accName) {
        List<Id> AccsX_Ids = new List<Id>();
        List<String> stringify = new List<String>();
        String QueryStr = 'SELECT ID, Name__c, Website__c, BillingCountry__c, Contact_Count_c__c, Number_of_Open_Opportunities_c__c From Account__x ';
        accName = '\'%' + accName + '%\'';
       
        if(!String.isBlank(accName)){        
            QueryStr = QueryStr + ' WHERE Name__c LIKE ' + accName;
        }

        System.debug(QueryStr);
        List<Account__x> accountsList = Database.query(QueryStr);
        
        if(accountsList.isEmpty()) {
            System.debug('No Record Found..');
        }

        return accountsList;
       
    }

    @AuraEnabled
    public static List<Account__x> searchAccountsByWebsite(String webAddr) {
        List<Id> AccsX_Ids = new List<Id>();
        List<String> stringify = new List<String>();
        String QueryStr = 'SELECT ID, Name__c, Website__c, BillingCountry__c, Number_of_Open_Opportunities_c__c From Account__x ';
        List<String> url = webAddr.split('\\.');
        webAddr = url[1];
        webAddr = '\'%' + webAddr + '%\'';
       
        if(!String.isBlank(webAddr)){        
            QueryStr = QueryStr + ' WHERE Website__c LIKE ' + webAddr ;
        }

        System.debug('QueryStr: '+QueryStr);
        List<Account__x> accountsList = Database.query(QueryStr);
        
        if(accountsList.isEmpty()) {
            System.debug('No Record Found..');
        }

        return accountsList;
       
    }


    
}


