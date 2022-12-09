import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import searchAccountsByWebsite from '@salesforce/apex/AccountService.searchAccountsByWebsite';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';


const COLUMNS = [
    { label: 'Account Name', fieldName:'Name__c'},
    { label: 'Website', fieldName:'Website__c'}
];

export default class CreateAccount extends NavigationMixin(LightningElement)  {

    @api objectApiName;
    @track isShowModal = false;
    @track columns = COLUMNS;
    @track accountsList;
    
    
    fields = [NAME_FIELD, WEBSITE_FIELD];  
    accountName = NAME_FIELD;
    accountWebsite = WEBSITE_FIELD;
    
    get disableButton(){
        return this.accountsList == null ? true : false;
    }

    handleReset() {
        this.accountsList = null;
    }

    handleSubmit(event){
        event.preventDefault();       
      
        let params = this.template.querySelector(`lightning-input-field[data-name="${this.accountWebsite}"`).value; 
        console.log("params: "+JSON.stringify(params));

        searchAccountsByWebsite({webAddr: params})
        .then(result => {
            this.accountsList = result;
            console.log("result: "+result);
        })
        .catch( error=>{
            this.accountsList = null;
            this.handleSuccess(event);
            
        });

     }

    handleSuccess(event) {
        const an = this.template.querySelector(`lightning-input-field[data-name="${this.accountName}"`).value;
        const fields = event.detail.fields;
        
        if(an !== null){
        const evt = new ShowToastEvent({
            title: 'Account created',
            message: 'Account '+ '"'+ an + '" was created: ',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        
        this.template.querySelector('lightning-record-edit-form').submit(fields);  
        this.handleReset();
        
    }
    
}
    closeModal() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            },
        });
    }
}

