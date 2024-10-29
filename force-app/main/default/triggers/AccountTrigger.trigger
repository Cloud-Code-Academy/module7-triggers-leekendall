trigger AccountTrigger on Account (before insert) {
    
    for (Account acc : Trigger.new) {
        if (acc.Type == null) {
            acc.Type = 'Prospect';
        }

        acc.BillingStreet = acc.ShippingStreet ?? null;
        acc.BillingCity = acc.ShippingCity ?? null;
        acc.BillingState = acc.ShippingState ?? null;
        acc.BillingPostalCode = acc.ShippingPostalCode ?? null;
        acc.BillingCountry = acc.ShippingCountry ?? null;
    }
}
