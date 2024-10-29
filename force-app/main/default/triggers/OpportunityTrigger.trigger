trigger OpportunityTrigger on Opportunity (before update, after update) {

    if (Trigger.isBefore) {
        
        // Q5
        for (Opportunity opp : Trigger.new) {
            if (opp.Amount <= 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    if (Trigger.isAfter) {
        
    }
}