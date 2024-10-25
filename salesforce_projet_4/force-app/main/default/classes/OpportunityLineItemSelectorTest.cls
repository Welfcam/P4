@IsTest
private class OpportunityLineItemSelectorTest {

    @isTest
    static void testOppProd() {
        Opportunity testOpp = TestDataFactory.createDataTest();
        Test.startTest();
        List<OpportunityLineItem> results = OpportunityLineItemSelector.getOppLineItemByOpportunityId(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(3, results.size(), 'Should return 3 Opportunity Product');
    }

}