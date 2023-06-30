package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum UserFields {

    FIRST_NAME(getInstance().getValue("user.firstName"), "First Name"),
    LAST_NAME(getInstance().getValue("user.lastName"), "Last Name"),
    USERNAME(getInstance().getValue("user.userName"), "Username"),
    USER_NAME(getInstance().getValue("user.user_Name"), "User Name"),
    ORGANISATION(getInstance().getValue("user.organization"), "Organisation"),
    USER_TYPE(getInstance().getValue("user.userType"), "User Type"),
    ROLE(getInstance().getValue("user.role"), "Role"),
    STATUS(getInstance().getValue("user.status"), "Status"),
    SINGLE_SIGN_ON(getInstance().getValue("user.singleSignOn"), "Single Sign On"),
    EMAIL(getInstance().getValue("user.email"), "Email"),
    POSITION(getInstance().getValue("user.position"), "Position"),
    GROUP(getInstance().getValue("user.group"), "Group"),
    SUPERIOR(getInstance().getValue("user.superior"), "Superior"),
    ENTITY(getInstance().getValue("user.entity"), "Entity"),
    EXTERNAL_ORGANISATION(getInstance().getValue("user.externalOrganization"), "External Organisation"),
    DEPARTMENT(getInstance().getValue("user.department"), "Department"),
    THIRD_PARTY(getInstance().getValue("user.thirdParty"), "Third-party"),
    DEFAULT_BILLING_ENTITY(getInstance().getValue("user.defaultBillingEntity"), "Default Billing Entity"),
    OTHER_BILLING_ENTITY(getInstance().getValue("user.otherBillingEntity"), "Other Billing Entity"),
    DIVISION(getInstance().getValue("user.division"), "Division"),
    FROM(getInstance().getValue("user.from"), "From"),
    TO(getInstance().getValue("user.to"), "To"),
    TIME(getInstance().getValue("user.to"), "Time"),
    LANGUAGE(getInstance().getValue("questionnaire.language"), "Language");

    private final String name;
    private final String defaultName;

}
