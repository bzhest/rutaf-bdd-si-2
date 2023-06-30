package com.refinitiv.asts.test.ui.api.model.fieldsManagement.thirdPartyFields;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class Address {

    FieldStates addressLine;
    FieldStates city;
    FieldStates country;
    FieldStates postalCode;
    FieldStates region;
    FieldStates province;

    public static Address setDefault() {
        return new Address()
                .setAddressLine(FieldStates.unsetRequired())
                .setCity(FieldStates.unsetRequired())
                .setPostalCode(FieldStates.unsetRequired())
                .setProvince(FieldStates.unsetRequired())
                .setRegion(FieldStates.unsetRequired())
                .setCountry(FieldStates.setDefaultRequired());
    }

    public static Address setActiveCityAndRegionFields() {
        return new Address()
                .setAddressLine(FieldStates.unsetActive())
                .setCity(FieldStates.unsetRequired())
                .setPostalCode(FieldStates.unsetActive())
                .setProvince(FieldStates.unsetActive())
                .setRegion(FieldStates.unsetRequired())
                .setCountry(FieldStates.setDefaultRequired());
    }

    public static Address setRequiredCityAndRegionFields() {
        return new Address()
                .setAddressLine(FieldStates.unsetRequired())
                .setCity(FieldStates.setRequired())
                .setPostalCode(FieldStates.unsetRequired())
                .setProvince(FieldStates.unsetRequired())
                .setRegion(FieldStates.setRequired())
                .setCountry(FieldStates.setDefaultRequired());
    }

    public static Address setAllFieldsInactiveExceptDefaultRequired() {
        return new Address()
                .setAddressLine(FieldStates.unsetActive())
                .setCity(FieldStates.unsetActive())
                .setPostalCode(FieldStates.unsetActive())
                .setProvince(FieldStates.unsetActive())
                .setRegion(FieldStates.unsetActive())
                .setCountry(FieldStates.setDefaultRequired());
    }

}
