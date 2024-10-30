@isTest
public class TestDataFactory {
    
    //Création d'un Pricebook de test
    public static Pricebook2 createTestPriceBook() {
        Pricebook2 testPriceBook = new Pricebook2(Name='Pricebook Test', IsActive=true);
        insert testPriceBook;
        return testPriceBook;
    }

    //Création de 5 produits de test
    public static List<Product2> createTestProductList() {

        List<Product2> testProductsList = new List<Product2>();
        testProductsList.add(new Product2(Name='Produit 1', QuantityInStock__c=50));
        testProductsList.add(new Product2(Name='Produit 2', QuantityInStock__c=75));
        testProductsList.add(new Product2(Name='Produit 3', QuantityInStock__c=100));
        testProductsList.add(new Product2(Name='Produit 4', QuantityInStock__c=150));
        testProductsList.add(new Product2(Name='Produit 5', QuantityInStock__c=200));

        insert testProductsList;
        return testProductsList;
    }

    //Création de Pricebook entries (standard et priceBook test)
    public static List<PricebookEntry> createPriceBookEntryList(List<Product2> testProductsList, Pricebook2 testPriceBook) {

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
        return pbeList;
    }

    //Création d'une Opportunité test
    public static Opportunity createOpportunitytest(Pricebook2 testPriceBook) {
        Opportunity testOpp = new Opportunity (
            Name='Test Opp',
            StageName='Prospecting',
            CloseDate=System.today().addMonths(1),
            Pricebook2Id = testPriceBook.Id
            );

        insert testOpp;
        return testOpp;
    }

    //Création d'Opportunités produits test (max 5)
    public static List<OpportunityLineItem> createOppLineItemTest(List<Product2> testProductsList, Opportunity testOpp, List<PricebookEntry> pbeList, Integer nbOfOppProdMax5) {
        List<OpportunityLineItem> testOppProd = new List<OpportunityLineItem>();
        for(Integer i=0; i<nbOfOppProdMax5; i++) {
            testOppProd.add(new OpportunityLineItem(
                Product2Id = testProductsList[i].Id,
                OpportunityId = testOpp.Id,
                Quantity = i+2,
                UnitPrice = pbeList[i].UnitPrice
            ));
        }

        insert testOppProd;
        return testOppProd;
    }
}    