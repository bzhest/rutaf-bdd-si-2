package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.*;

@Getter
@RequiredArgsConstructor
public enum AddressFields {

    ADDRESS_LINE(getInstance().getValue("thirdPartyInformation.address.addressLine"), "Address Line"),
    CITY(getInstance().getValue("thirdPartyInformation.address.city"), "City"),
    ZIP_POSTAL_CODE(getInstance().getValue("thirdPartyInformation.address.zipCode"), "Code postal"),
    STATE_PROVINCE(getInstance().getValue("thirdPartyInformation.address.state"), "State/Province"),
    REGION(getInstance().getValue("thirdPartyInformation.address.region"), "Region"),
    COUNTRY(getInstance().getValue("thirdPartyInformation.address.country"), "Country");

    private final String name;
    private final String defaultName;
}
