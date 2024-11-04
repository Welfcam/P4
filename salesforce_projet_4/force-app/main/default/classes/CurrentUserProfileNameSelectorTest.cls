@isTest(SeeAllData=true)
private class CurrentUserProfileNameSelectorTest {

    @isTest
    public static void testGetCurrentUserProfileNameSales() {
       
        Profile commercialProfile = [SELECT Id FROM Profile WHERE Name = 'Custom: Sales Profile' LIMIT 1];
       
        System.assertNotEquals(null, commercialProfile, 'Le profil personnalisé "Custom: Sales Profile" doit exister.');

        User testUser = new User(
            LastName = 'Test Last Name',
            Alias = 'TestA',
            Email = 'testest@test.com',
            Username = 'test_username183798174083@test.com',
            CommunityNickname = 'TestNickname',
            EmailEncodingKey = 'UTF-8',
            TimeZoneSidKey = 'Europe/Paris',
            isActive = true,
            LocaleSidKey = 'fr_FR',
            LanguageLocaleKey = 'en_US',
            ProfileId = commercialProfile.Id
        );
       
        insert testUser;
       
        Test.startTest();
            System.runAs(testUser) {
                String result = CurrentUserProfileNameSelector.getCurrentUserProfileName();
                System.assertEquals('Custom: Sales Profile', result, 'Should return Custom: Sales Profile.');
            }
        Test.stopTest();
    }

    @isTest
    public static void testGetCurrentUserProfileNameAdmin() {

        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];

        User testUser2 = new User(
            LastName = 'Test Last Name',
            Alias = 'TestA',
            Email = 'testest@test.com',
            Username = 'test_username6876878@test.com',
            CommunityNickname = 'TestNickname',
            EmailEncodingKey = 'UTF-8',
            TimeZoneSidKey = 'Europe/Paris',
            isActive = true,
            LocaleSidKey = 'fr_FR',
            LanguageLocaleKey = 'en_US',
            ProfileId = adminProfile.Id
        );

        insert testUser2;

        Test.startTest();
            System.runAs(testUser2) {
                String result = CurrentUserProfileNameSelector.getCurrentUserProfileName();
                System.assertEquals('System Administrator', result, 'Should return System Administrator');
            }
        Test.stopTest();

    }
}