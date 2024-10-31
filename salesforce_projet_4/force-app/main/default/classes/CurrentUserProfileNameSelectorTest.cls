
@isTest
private class CurrentUserProfileNameSelectorTest {

    @isTest
    public static void testGetCurrentUserProfileName() {
        
        //Profile testProfile = new Profile();
        Profile commercialProfile = [SELECT Id FROM Profile WHERE Name = 'Custom: Sales Profile' LIMIT 1];
        
        User testUser = new User();
        testUser.LastName = 'Test Last Name';
        testUser.Alias = 'TestA';
        testUser.Email = 'testest@test.com';
        testUser.Username = 'ethgwsrgwrd@test.com';
        testUser.CommunityNickname = 'Test Nickname';
        testUser.EmailEncodingKey = 'UTF-8';
        testUser.TimeZoneSidKey = 'Europe/Paris';
        testUser.isActive = true;
        testUser.LocaleSidKey = 'fr_FR';
        testUser.LanguageLocaleKey = 'en_US';
        //testUser.Profile = new Profile();
        //testUser.Profile.Name = 'Custom: Sales Profile';
        testUser.ProfileId = commercialProfile.Id;
        
        insert testUser;
        Test.startTest();
        String result = CurrentUserProfileNameSelector.getCurrentUserProfileName();
        Test.stopTest();
        Assert.areEqual('Custom: Sales Profile', result, 'Should return Custom: Sales Profile');
    }
}