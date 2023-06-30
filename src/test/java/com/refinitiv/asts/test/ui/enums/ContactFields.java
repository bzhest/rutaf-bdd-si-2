package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum ContactFields {

    PHONE_NUMBER(getInstance().getValue("addThirdParty.contact.phoneNumber"), "Phone Number"),
    FAX(getInstance().getValue("addThirdParty.contact.fax"), "Fax"),
    WEBSITE(getInstance().getValue("addThirdParty.contact.website"), "Website"),
    EMAIL_ADDRESS(getInstance().getValue("addThirdParty.contact.email"), "Email Address");

    private final String name;
    private final String defaultName;
}
