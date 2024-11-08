//Test de la méthode getOpportunityLineItem du controller
@isTest
private class OpportunityLineItemControllerTest {

    //Test avec 3 opportunités produit
    @isTest
    static void test3OppProd() {
        Pricebook2 testPriceBook = TestDataFactory.createTestPriceBook();
        List<Product2> testProductsList = TestDataFactory.createTestProductList();
        List<PricebookEntry> testPricebookEntryList = TestDataFactory.createPriceBookEntryList(testProductsList, testPriceBook);
        Opportunity testOpp = TestDataFactory.createOpportunitytest(testPriceBook);
        List<OpportunityLineItem> testOppProd = TestDataFactory.createOppLineItemTest(testProductsList, testOpp, testPricebookEntryList, 3);
        Test.startTest();
        List<OpportunityLineItem> results = OpportunityLineItemController.getOpportunityLineItem(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(3, results.size(), 'Should return 3 Opportunity Product');
        Assert.areEqual('Produit 1', results[0].Product2.Name, 'Should return "Produit 1"');
        Assert.areEqual(4, results[2].Quantity, 'Should return 4');
    }

    //Test avec 1 opportunité produit
    @isTest
    static void test1OppProd() {
        Pricebook2 testPriceBook = TestDataFactory.createTestPriceBook();
        List<Product2> testProductsList = TestDataFactory.createTestProductList();
        List<PricebookEntry> testPricebookEntryList = TestDataFactory.createPriceBookEntryList(testProductsList, testPriceBook);
        Opportunity testOpp = TestDataFactory.createOpportunitytest(testPriceBook);
        List<OpportunityLineItem> testOppProd = TestDataFactory.createOppLineItemTest(testProductsList, testOpp, testPricebookEntryList, 1);
        Test.startTest();
        List<OpportunityLineItem> results = OpportunityLineItemController.getOpportunityLineItem(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(1, results.size(), 'Should return 1 Opportunity Product');
    }

    //Test avec aucune opportunité produit    
    @isTest
    static void testNoOppProd() {
        Pricebook2 testPriceBook = TestDataFactory.createTestPriceBook();
        List<Product2> testProductsList = TestDataFactory.createTestProductList();
        List<PricebookEntry> testPricebookEntryList = TestDataFactory.createPriceBookEntryList(testProductsList, testPriceBook);
        Opportunity testOpp = TestDataFactory.createOpportunitytest(testPriceBook);
        List<OpportunityLineItem> testOppProd = TestDataFactory.createOppLineItemTest(testProductsList, testOpp, testPricebookEntryList, 0);
        Test.startTest();
        List<OpportunityLineItem> results = OpportunityLineItemController.getOpportunityLineItem(testOpp.Id);
        Test.stopTest();
        Assert.areEqual(0, results.size(), 'Should return 0 Opportunity Product');
    }
}    