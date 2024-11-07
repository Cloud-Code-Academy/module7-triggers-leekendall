trigger OpportunityTrigger on Opportunity (before update, before delete) {
    
    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            
            // Q7
            Set<Id> accIds = new Set<Id>();
            for (Opportunity opp : Trigger.new) {
                accIds.add(opp.AccountId);                
            }

            Map<Id, Account> accMap = new Map<Id, Account> ([SELECT Id, (SELECT Id FROM Contacts WHERE Title = 'CEO') FROM Account WHERE Id IN :accIds]);
            
            for (Opportunity opp : Trigger.new) {
                // Q5
                if (opp.Amount <= 5000) {
                    opp.addError('Opportunity amount must be greater than 5000');
                }

                // Q7
                opp.Primary_Contact__c = accMap.get(opp.AccountId)?.Contacts[0].Id;
            } 
        }
        when BEFORE_DELETE {
            
            // Q6
            Set<Id> accIds = new Set<Id>();
            for (Opportunity opp : Trigger.old) {
                accIds.add(opp.AccountId);
            }

            Map<Id, Account> accsMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accIds]);
            
            for (Opportunity opp : Trigger.old) {
                if (opp.StageName == 'Closed Won' && accsMap.get(opp.AccountId).Industry == 'Banking') {
                    opp.addError('Cannot delete closed opportunity for a banking account that is won');
                }
            }
        }
    }
}