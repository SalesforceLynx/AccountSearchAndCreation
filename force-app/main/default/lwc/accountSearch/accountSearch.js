import { LightningElement, track } from 'lwc';
import searchAccountsByName from '@salesforce/apex/AccountService.searchAccountsByName';


const COLUMNS = [
        { label: 'Account Name', fieldName:'Name__c'},
        { label: 'Billing Country', fieldName:'BillingCountry__c'},
        { label: 'Number of Contacts', fieldName:'Contact_Count_c__c'},
        { label: 'Number of Open Opportunities', fieldName:'Number_of_Open_Opportunities_c__c'}
    ];

export default class AccountSearchForm extends LightningElement {

    @track columns = COLUMNS;
    @track accountsList;
    searchName;

    handleSearchName(event) {
        this.searchName = event.target.value;
    }


    handleSearch() {
        let params;
        params = this.searchName;
        console.log("params: "+params);
        
        
    searchAccountsByName({accName: params})
    .then(result => {
            this.accountsList = result;
            console.log("result: "+result);
    })
    .catch( error=>{
        this.accountsList = null;
    });

    }

}