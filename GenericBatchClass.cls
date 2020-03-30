global class GenericBatchClass implements Database.Batchable<SObject>, Database.Stateful {
    global static String SOQL ;
    global final String sObjField;
    global  String fieldValue;

    global GenericBatchClass(string Query,string OField, string Fvalue) {

        SOQL = Query;
        sObjField = OField;
        fieldValue = Fvalue;

    }
    global  Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(SOQL);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> sObjList){
        
            for(sObject obj : sObjList){
                obj.put(sObjField,fieldValue);
            }
            update sObjList;

        
    } 
    global void finish(Database.BatchableContext BC){
      
    }
        /**
    *  @description:  a static method to execute this batch. It is used mostly to test the batch in developer console. 
    */
    global static void runNow(string Query,string OField, string Fvalue){
        GenericBatchClass btch = new GenericBatchClass(Query,OField,Fvalue);
        Database.executebatch(btch);
    }
}