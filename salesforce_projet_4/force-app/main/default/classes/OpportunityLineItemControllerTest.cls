@isTest
private class OpportunityLineItemControllerTest {

    @isTest
    static void testOppProdController() {
        Opportunity testOpp = TestDataFactory.createDataTest();
        Test.startTest();
        List<OpportunityLineItem> results = OpportunityLineItemController.getOpportunityLineItem(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(3, results.size(), 'Should return 3 Opportunity Product');
    }
}