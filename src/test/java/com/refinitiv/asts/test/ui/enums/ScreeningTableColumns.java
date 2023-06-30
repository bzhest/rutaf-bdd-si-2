package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum ScreeningTableColumns {

    NAME(getInstance().getValue("thirdPartyInformation.screening.columnName"), "NAME"),
    COUNTRY_OF_REGISTRATION(getInstance().getValue("thirdPartyInformation.screening.columnCountryOfRegistration"),
                            "COUNTRY OF REGISTRATION"),
    TYPE(getInstance().getValue("thirdPartyInformation.screening.columnType"), "TYPE"),
    MATCH_STRENGTH(getInstance().getValue("thirdPartyInformation.screening.columnMatchStrength"), "MATCH STRENGTH"),
    DATA_PROVIDER(getInstance().getValue("thirdPartyInformation.screening.columnDataProvider"), "DATA PROVIDER"),
    REFERENCE_ID(getInstance().getValue("thirdPartyInformation.screening.columnReferenceId"), "REFERENCE ID"),
    RESOLUTION(getInstance().getValue("thirdPartyInformation.screening.columnResolution"), "RESOLUTION");

    private final String columnName;
    private final String defaultColumnName;

    public static List<String> getColumnNames() {
        return Stream.of(ScreeningTableColumns.values())
                .map(ScreeningTableColumns::getColumnName)
                .collect(Collectors.toList());
    }
}
