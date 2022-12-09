public virtual inherited sharing class ExternalAccounts {
    public static List<SObject> records(List<SObject> records){
       return instance.passThrough(records);
    }

    static ExternalAccounts instance = new ExternalAccounts();
   
    @TestVisible 
    static void setMock(ExternalAccounts mock){ 
        instance = mock; 
    }

    protected virtual List<SObject> passThrough(List<SObject> records){
      return records;
   }

}



