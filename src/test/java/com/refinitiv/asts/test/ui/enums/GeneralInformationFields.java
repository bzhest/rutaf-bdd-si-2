package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum GeneralInformationFields {

    REFERENCE_NO(getInstance().getValue("thirdPartyInformation.generalInformation.referenceNo"), "Reference No"),
    REFERENCE_NUMBER(getInstance().getValue("thirdPartyInformation.generalInformation.referenceNumber"),
                     "Reference Number"),
    NAME(getInstance().getValue("thirdPartyInformation.generalInformation.name"), "Name"),
    COMPANY_TYPE(getInstance().getValue("thirdPartyInformation.generalInformation.companyType"), "Company Type"),
    ORGANISATION_SIZE(getInstance().getValue("thirdPartyInformation.generalInformation.organizationSize"),
                      "Organisation Size"),
    DATE_OF_INCORPORATION(getInstance().getValue("thirdPartyInformation.generalInformation.dateOfIncorporation"),
                          "Date of Incorporation"),
    RESPONSIBLE_PARTY(getInstance().getValue("thirdPartyInformation.generalInformation.responsibleParty"),
                      "Responsible Party"),
    WORKFLOW_GROUP(getInstance().getValue("thirdPartyInformation.generalInformation.workflowGroup"), "Workflow Group"),
    DIVISION(getInstance().getValue("thirdPartyInformation.generalInformation.division"), "Division"),
    CURRENCY(getInstance().getValue("thirdPartyInformation.generalInformation.currency"), "Currency"),
    INDUSTRY_TYPE(getInstance().getValue("thirdPartyInformation.generalInformation.industryType"), "Industry Type"),
    BUSINESS_CATEGORY(getInstance().getValue("thirdPartyInformation.generalInformation.businessCategory"),
                      "Business Category"),
    REVENUE(getInstance().getValue("thirdPartyInformation.generalInformation.revenue"), "Revenue"),
    LIQUIDATION_DATE(getInstance().getValue("thirdPartyInformation.generalInformation.liquidationDate"),
                     "Liquidation Date"),
    AFFILIATION(getInstance().getValue("thirdPartyInformation.generalInformation.affiliation"), "Affiliation"),
    TITLE(getInstance().getValue("thirdPartyInformation.generalInformation.title"), "Title"),
    COUNTRY(getInstance().getValue("thirdPartyInformation.generalInformation.country"), "Country"),
    FIRST_NAME(getInstance().getValue("thirdPartyInformation.generalInformation.firstName"), "First Name"),
    LAST_NAME(getInstance().getValue("thirdPartyInformation.generalInformation.lastName"), "Last Name"),
    MIDDLE_NAME(getInstance().getValue("thirdPartyInformation.generalInformation.middleName"), "Middle Name");

    private final String name;
    private final String defaultName;

}
