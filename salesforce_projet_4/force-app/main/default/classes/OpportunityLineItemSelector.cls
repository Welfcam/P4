//Requête SOQL pour récupèrer les données concernant les Opportunités Produits reliée à l'Opportunité active
public with sharing class OpportunityLineItemSelector {
    public static List<OpportunityLineItem> getOppLineItemByOpportunityId(Id opportunityId) {
        return [SELECT Product2.Name, Product2.Id, Quantity, PricebookEntry.UnitPrice, TotalPrice, Product2.QuantityInStock__c FROM OpportunityLineItem WHERE OpportunityId = :opportunityId];
    }
}