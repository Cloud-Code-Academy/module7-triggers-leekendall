trigger AccountTrigger on Account (before insert) {
    
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
