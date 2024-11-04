import { LightningElement, api, wire, track} from 'lwc';
import getOpportunityLineItem from '@salesforce/apex/OpportunityLineItemController.getOpportunityLineItem';
import userProfileName from '@salesforce/apex/CurrentUserProfileNameController.userProfileName';
import labels from './labels';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { RefreshEvent } from 'lightning/refresh';

export default class OpportunityProductViewer extends NavigationMixin(LightningElement) {
    @api recordId;
    opportunityProducts;
    labels = labels;
    wiredOppLineItemResult;
    error;
    alertMessage;
    emptyTable;
    isAdmin = false;
    isLoading = false;

    //Liste des colonnes pour le profil System Administrator
    columnsAdmin = [
        { label : labels.Product_Name, fieldName: 'Name', type: 'text',},
        { label : labels.Quantity, fieldName: 'Quantity', type: 'number', cellAttributes: { alignment: 'left', class: { fieldName: 'format'} }},
        { label : labels.Unit_Price, fieldName: 'UnitPrice', type: 'currency', cellAttributes: { alignment: 'left' }},
        { label : labels.Total_Price, fieldName: 'TotalPrice', type: 'currency', cellAttributes: { alignment: 'left' }},
        { label : labels.Quantity_in_stock, fieldName: 'Stock', type: 'number', cellAttributes: { alignment: 'left' }},
        {
            type: 'button-icon', label: labels.Delete, typeAttributes: { // bouton Supprimer
                name: 'Delete',
                title: labels.Delete,
                value: 'delete',
                iconName:'utility:delete'
            }
        },

        {
            type: 'button', label: labels.See_Product, typeAttributes: { //bouton Voir Produit
                label: labels.See_Product,
                name: 'See Product',
                title: labels.See_Product,
                value: 'seeProduct',
                iconName: 'utility:preview',
                iconPosition: 'left',
                variant: 'brand'
            }
        }
    ];

    //Liste des colonnes pour les profils qui ne sont pas System Administrator    
    columnsStandard = [
        { label : labels.Product_Name, fieldName: 'Name', type: 'text',},
        { label : labels.Quantity, fieldName: 'Quantity', type: 'number', cellAttributes: { alignment: 'left', class: { fieldName: 'format'} }},
        { label : labels.Unit_Price, fieldName: 'UnitPrice', type: 'currency', cellAttributes: { alignment: 'left' }},
        { label : labels.Total_Price, fieldName: 'TotalPrice', type: 'currency', cellAttributes: { alignment: 'left' }},
        { label : labels.Quantity_in_stock, fieldName: 'Stock', type: 'number', cellAttributes: { alignment: 'left' }},
        {
            type: 'button-icon', label: labels.Delete, typeAttributes: { // bouton Supprimer
                name: 'Delete',
                title: labels.Delete,
                value: 'delete',
                iconName:'utility:delete'
            }
        },
    ];

    //Permet de déterminer si l'utilisateur est administrateur ou non pour adapter l'affichage
    isAdminUser() {
        userProfileName()
        .then(result => {
            if(result == 'System Administrator') {
                this.isAdmin = true;
            }
        })
        .catch(error2 => {
            this.error = error2;
        })
    };

    //Récupère les Opportunités Produits liées à l'opportunité active
    @wire(getOpportunityLineItem, { opportunityId: '$recordId'})
    wiredOpportunityLineItem (result) {
        this.wiredOppLineItemResult = result;
        this.isAdminUser();
        //S'il y a 1 ou + Opportunités Produit le tableau est affiché
        if (result.data) {
            if(result.data.length>0) {
                this.error = undefined;
                this.emptyTable = undefined;
                this.alertMessage = undefined;
                this.opportunityProducts = [];
                //les données sont applaties de façon à pouvoir accéder aux champs des objets reliés aux opportunités produits
                result.data.forEach(line => {
                    let oppProd = {};
                    oppProd.Id = line.Id;
                    oppProd.Name = line.Product2.Name;
                    oppProd.ProdId = line.Product2.Id;
                    oppProd.Quantity = line.Quantity;
                    oppProd.UnitPrice = line.PricebookEntry.UnitPrice;
                    oppProd.TotalPrice = line.TotalPrice;
                    oppProd.Stock = line.Product2.QuantityInStock__c;
                    this.opportunityProducts.push(oppProd);
                    //si une Opportunité Produit a une quantité supérieure au stock disponible, un message d'alerte est affiché
                    if(line.Quantity > line.Product2.QuantityInStock__c) {
                        oppProd.format = 'slds-text-color_error slds-text-title_bold slds-theme_shade slds-theme_alert-texture';
                        this.alertMessage = labels.Quantity_alert;
                    }
                });
            //s'il n'y a pas d'Opportunités Produits reliées à l'Opportunité, un message informatif s'affiche    
            } else {
                this.opportunityProducts = undefined;
                this.error = undefined;
                this.emptyTable = labels.No_Opp_Prod;
            }
        //s'il y a une erreur lors du chargement des Opportunités Produit, un message d'erreur s'affiche    
        } else {
            this.opportunityProducts = undefined;
            this.error = labels.Opp_Prod_List_Error;
            this.emptyTable = undefined;
        }
        this.isLoading = false;
    };

    //Gestion du clic sur le bouton rafraîchir pour mettre à jour la datatable
    handleRefresh() {
        refreshApex(this.wiredOppLineItemResult);
    }

    //Gestion des clics sur les boutons 'Supprimer' et 'Voir Produit'
    handleRowAction(event) {
        const oppProdId = event.detail.row.Id;
        const relatedProductId = event.detail.row.ProdId;
        const actionName = event.detail.action.name;
        if (actionName === 'See Product') {
            this.handleSeeProduct(relatedProductId);
        } else if (actionName === 'Delete') {
            this.isLoading = true;
            this.handleDelete(oppProdId);
        }
    };

    //Redirection vers la page Produit en cliquant sur le bouton 'Voir Produit'
    handleSeeProduct(relatedProductId) {
        this[NavigationMixin.Navigate] ({
            type: "standard__recordPage",
            attributes: {
                recordId: relatedProductId, 
                objectApiName: "Product2",
                actionName: "view",
            },
        });
    }

    //Suppression d'une ligne du tableau d'opportunité produits en cliquant sur le bouton "Supprimer"
    handleDelete(oppProdId) {
        deleteRecord(oppProdId)
            .then(result => {
                refreshApex(this.wiredOppLineItemResult);
                this.refreshRelatedList();
            })
            .catch(error => {
                this.error = error;
            })   
    }

    //Rafraichit la related list Produit lorsque le tableau est modifié
    refreshRelatedList() {
        this.dispatchEvent(new RefreshEvent());
    }
}