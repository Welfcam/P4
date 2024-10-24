public with sharing class OpportunityLineItemSelector {
    public static List<OpportunityLineItem> getOppLineItemByOpportunityId(Id opportunityId) {
        return [SELECT Product2.Name, Quantity, PricebookEntry.UnitPrice, TotalPrice, Product2.QuantityInStock__c FROM OpportunityLineItem WHERE OpportunityId = :opportunityId];
    }
}