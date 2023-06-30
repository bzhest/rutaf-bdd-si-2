package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum BankDetailsFields {

    BANK_NAME(getInstance().getValue("thirdPartyInformation.bankDetails.bankName"), "Bank Name"),
    ACCOUNT_NO(getInstance().getValue("thirdPartyInformation.bankDetails.accountNo"), "Account No."),
    BRANCH_NAME(getInstance().getValue("thirdPartyInformation.bankDetails.branchName"), "Branch Name"),
    ADDRESS_LINE(getInstance().getValue("thirdPartyInformation.bankDetails.addressLine"), "Address Line"),
    CITY(getInstance().getValue("thirdPartyInformation.bankDetails.city"), "City"),
    COUNTRY(getInstance().getValue("thirdPartyInformation.bankDetails.country"), "Country");

    private final String name;
    private final String defaultName;
}
