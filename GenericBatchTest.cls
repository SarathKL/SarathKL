@isTest
private class GenericBatchTest {
    static testmethod void test() {
    List<Account> accList = new List<Account>();
    Id cusRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
    for (Integer i=0;i<150;i++) {
        Account ac = new Account(Name = 'Account ' + i, recordtypeid = cusRecordTypeId);
        accList.add(ac);
    }
    insert accList;
        string recName ='Customer';
    String qry = 'SELECT  Id,Enterprise_Account_Status__c  FROM  Account where recordtype.Name = \'' + recName + '\'';
    String field = 'Enterprise_Account_Status__c';
    String val ='Bronze';
	system.debug('qry--'+qry); 
        Test.startTest();
        GenericBatchClass.runNow(qry,field,val);
        Test.stopTest();
        Account[] accUpdatedList = [SELECT Id, Enterprise_Account_Status__c FROM Account];
        System.assert(accUpdatedList[0].Enterprise_Account_Status__c.Contains('Bronze'));
    }
}