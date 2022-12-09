@isTest
public with sharing class AccountServiceTest {

    class Mock extends ExternalAccounts{
       final List<Account__x> xRecs;

       Mock(List<Account__x> xRecs){
          this.xRecs = xRecs;
       }
  
       protected override List<SObject> passThrough(List<SObject> records){
          return records;
       }
    }

    @TestSetup
    static void makeData(){
        List<Account> xAl = new List<Account>();
        xAl.add(
            new Account(
                Name = 'Account1',
                Website = 'www.account1.com'
                //ExternalId = 'x002w0000199L89AAE'
            )
        );

        insert xAl;
        
    }

    @isTest()
    static void testAccountSearchAndCreate() {

        List<Account__x > mockRecords = new List<Account__x >();
     
        List<Account> xAccount = [Select Name, Website From Account];

     //TODO: It is not writeable. To make it work, I may need to go through documentation. 
     //The quick internet example didn't worked for me. Poor me. 
     Account__x mock1 = new Account__x();
    // mock1.Name__c = xAccount[0].Name;
    // mock1.Website__c = xAccount[0].Website;

     
     mockRecords.add(mock1);
     
     ExternalAccounts.setMock(new Mock(mockRecords));
     ExternalAccounts.records(mockRecords);

     Test.startTest();
        AccountService.searchAccountsByName(mock1.Name__c);
        AccountService.searchAccountsByWebsite(mock1.Website__c);
     Test.stopTest();

  
     //System.assertEquals('Account1', String.valueOf(AccountService.searchAccountsByName(mock1.Name__c)));

    }

}

