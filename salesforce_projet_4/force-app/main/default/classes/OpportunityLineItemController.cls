public with sharing class OpportunityLineItemController {
    @AuraEnabled(Cacheable=true)
    public static List<OpportunityLineItem> getOpportunityLineItem(Id opportunityId) {
        return OpportunityLineItemSelector.getOppLineItemByOpportunityId(opportunityId);
    }
}