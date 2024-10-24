@isTest
public class TestDataFactory {
    
    public static Opportunity createDataTest() {
        Pricebook2 testPriceBook = new Pricebook2(Name='Pricebook Test', IsActive=true);
        
        insert testPriceBook;

        List<Product2> testProductsList = new List<Product2>();
        testProductsList.add(new Product2(Name='Produit 1', QuantityInStock__c=50));
        testProductsList.add(new Product2(Name='Produit 2', QuantityInStock__c=75));
        testProductsList.add(new Product2(Name='Produit 3', QuantityInStock__c=100));
        testProductsList.add(new Product2(Name='Produit 4', QuantityInStock__c=150));
        testProductsList.add(new Product2(Name='Produit 5', QuantityInStock__c=200));
        
        insert testProductsList;

        Id pricebookId = Test.getStandardPricebookId();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        pbeList.add(new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=testProductsList[0].Id, UnitPrice=25000, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=testProductsList[1].Id, UnitPrice=25000, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=testProductsList[2].Id, UnitPrice=25000, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=testProductsList[3].Id, UnitPrice=25000, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=testProductsList[4].Id, UnitPrice=25000, IsActive=true));

        pbeList.add(new PricebookEntry(Pricebook2Id=testPriceBook.Id, Product2Id=testProductsList[0].Id, UnitPrice=99990, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=testPriceBook.Id, Product2Id=testProductsList[1].Id, UnitPrice=69900, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=testPriceBook.Id, Product2Id=testProductsList[2].Id, UnitPrice=82400, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=testPriceBook.Id, Product2Id=testProductsList[3].Id, UnitPrice=28990, IsActive=true));
        pbeList.add(new PricebookEntry(Pricebook2Id=testPriceBook.Id, Product2Id=testProductsList[4].Id, UnitPrice=26990, IsActive=true));

        insert pbeList;

        Opportunity testOpp = new Opportunity (
            Name='Test Opp',
            StageName='Prospecting',
            CloseDate=System.today().addMonths(1),
            Pricebook2Id = testPriceBook.Id
            );

        insert testOpp;

        List<OpportunityLineItem> testOppProd = new List<OpportunityLineItem>();
        testOppProd.add(new OpportunityLineItem(Product2Id = testProductsList[0].Id, OpportunityId = testOpp.Id, Quantity = 4, UnitPrice = pbeList[0].UnitPrice));
        testOppProd.add(new OpportunityLineItem(Product2Id = testProductsList[1].Id, OpportunityId = testOpp.Id, Quantity = 7, UnitPrice = pbeList[1].UnitPrice));
        testOppProd.add(new OpportunityLineItem(Product2Id = testProductsList[2].Id, OpportunityId = testOpp.Id, Quantity = 2, UnitPrice = pbeList[2].UnitPrice));

        insert testOppProd;
        return testOpp;
    }
}    