public with sharing class CurrentUserProfileNameController {
    @AuraEnabled
    public static String userProfileName() {
        return CurrentUserProfileNameSelector.getCurrentUserProfileName();
    }
}