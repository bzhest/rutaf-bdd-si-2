package com.refinitiv.asts.test.ui.api.model.fieldsManagement.thirdPartyFields;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class BankDetails {

    FieldStates name;
    FieldStates accountNo;
    FieldStates branchName;
    FieldStates addressLine;
    FieldStates city;
    FieldStates country;

    public static BankDetails setDefault() {
        return new BankDetails()
                .setName(FieldStates.unsetRequired())
                .setAddressLine(FieldStates.unsetRequired())
                .setAccountNo(FieldStates.unsetRequired())
                .setBranchName(FieldStates.unsetRequired())
                .setCity(FieldStates.unsetRequired())
                .setCountry(FieldStates.unsetRequired());
    }

    public static BankDetails setRequiredBankNameAndAccountFields() {
        return new BankDetails()
                .setName(FieldStates.setRequired())
                .setAddressLine(FieldStates.unsetRequired())
                .setAccountNo(FieldStates.setRequired())
                .setBranchName(FieldStates.unsetRequired())
                .setCity(FieldStates.unsetRequired())
                .setCountry(FieldStates.unsetRequired());
    }

    public static BankDetails setAllFieldsInactive() {
        return new BankDetails()
                .setName(FieldStates.unsetActive())
                .setAddressLine(FieldStates.unsetActive())
                .setAccountNo(FieldStates.unsetActive())
                .setBranchName(FieldStates.unsetActive())
                .setCity(FieldStates.unsetActive())
                .setCountry(FieldStates.unsetActive());
    }


}
