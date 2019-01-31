/*
	Description - Populate field on Account named "Number of Contacts" with number of child contacts 
	Author - Nidhiraj IR
*/

trigger ContactCountTrigger on Contact (After insert, After delete, After undelete, After Update) {
    Set<Id> parentIdsSet = new Set<Id>();
    List<Account> accountListToUpdate = new List<Account>();
    IF(Trigger.IsAfter){
	//Handling Insert,Undelete and update Scenario
        IF(Trigger.IsInsert || Trigger.IsUndelete  || Trigger.isUpdate){
            FOR(Contact c : Trigger.new){
                if(c.AccountId!=null){   
                   parentIdsSet.add(c.AccountId);
                   If(Trigger.isUpdate){
                       if(Trigger.oldMap.get(c.Id).AccountId != c.AccountId){
                          parentIdsSet.add(Trigger.oldMap.get(c.Id).AccountId);
                       }
                    }
                }
            }
        }
		// Delete Scenario
        IF(Trigger.IsDelete){
            FOR(Contact c : Trigger.Old){
                if(c.AccountId!=null){   
                   parentIdsSet.add(c.AccountId); 
                }
            }
        }
    }

    List<Account> accountList = new List<Account>([Select id ,Name, Number_of_Contacts__c, (Select id, Name From Contacts) from Account Where id in:parentIdsSet]);
    FOR(Account acc : accountList){
        List<Contact> contactList = acc.Contacts;
        acc.Number_of_Contacts__c = contactList.size();
        accountListToUpdate.add(acc);
    }
    try{
        update accountListToUpdate;
    }catch(System.Exception e){
        
    }
}
