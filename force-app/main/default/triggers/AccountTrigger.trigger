trigger AccountTrigger on Account (before insert, after insert) {
    
    if (Trigger.isBefore) {
        
        for (Account acc : Trigger.new) {
            // Q1
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }

            // Q2
            acc.BillingStreet = acc.ShippingStreet ?? null;
            acc.BillingCity = acc.ShippingCity ?? null;
            acc.BillingState = acc.ShippingState ?? null;
            acc.BillingPostalCode = acc.ShippingPostalCode ?? null;
            acc.BillingCountry = acc.ShippingCountry ?? null;

            // Q3
            if (acc.Phone != null && acc.Website != null && acc.Fax != null) {
                acc.Rating = 'Hot';
            }
        }
    }   

    if (Trigger.isAfter) {
        // Q4
        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : Trigger.new) {
            contactsToInsert.add(new Contact(AccountId = acc.Id, LastName = 'DefaultContact', Email = 'default@email.com'));
        }
        insert contactsToInsert;
    }
}
