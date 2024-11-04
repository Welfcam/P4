//Requête SOQL pour récupérer le nom du profil de l'utilisateur actif
public with sharing class CurrentUserProfileNameSelector {
    
    public static String getCurrentUserProfileName() {
        Id profileId= userinfo.getProfileId();
        return [Select Name from Profile where Id=:profileId].Name;
    }
}

