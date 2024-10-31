public with sharing class UserProfileNameController {
    @AuraEnabled
    public static String userProfileName() {
        return CurrentUserProfileNameSelector.getCurrentUserProfileName();
    }
}