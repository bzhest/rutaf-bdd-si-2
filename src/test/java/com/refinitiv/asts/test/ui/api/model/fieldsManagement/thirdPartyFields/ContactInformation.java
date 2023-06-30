package com.refinitiv.asts.test.ui.api.model.fieldsManagement.thirdPartyFields;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ContactInformation {
    FieldStates phoneNumber;
    FieldStates fax;
    FieldStates website;
    FieldStates email;

    public static ContactInformation setDefault() {
        return new ContactInformation()
                .setPhoneNumber(FieldStates.unsetRequired())
                .setFax(FieldStates.unsetRequired())
                .setWebsite(FieldStates.unsetRequired())
                .setEmail(FieldStates.unsetRequired());
    }

    public static ContactInformation setAllFieldsRequired() {
        return new ContactInformation()
                .setPhoneNumber(FieldStates.setRequired())
                .setFax(FieldStates.setRequired())
                .setWebsite(FieldStates.setRequired())
                .setEmail(FieldStates.setRequired());
    }

    public static ContactInformation setAllFieldsInactive() {
        return new ContactInformation()
                .setPhoneNumber(FieldStates.unsetActive())
                .setFax(FieldStates.unsetActive())
                .setWebsite(FieldStates.unsetActive())
                .setEmail(FieldStates.unsetActive());
    }

}
