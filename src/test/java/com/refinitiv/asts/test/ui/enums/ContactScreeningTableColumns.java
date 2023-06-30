package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum ContactScreeningTableColumns {

    NAME(getInstance().getValue("associatedParties.filter.nameColumn").toUpperCase()),
    COUNTRY_OF_LOCATION(getInstance().getValue("associatedParties.filter.countryOfLocationColumn").toUpperCase()),
    TYPE(getInstance().getValue("associatedParties.filter.typeColumn").toUpperCase()),
    MATCH_STRENGTH(getInstance().getValue("associatedParties.filter.matchStrength").toUpperCase()),
    DATA_PROVIDER(getInstance().getValue("associatedParties.filter.dataProvider").toUpperCase()),
    REFERENCE_ID(getInstance().getValue("associatedParties.filter.referenceId").toUpperCase()),
    RESOLUTION(getInstance().getValue("associatedParties.filter.resolution").toUpperCase());

    private final String columnName;

    public static List<String> getColumnNames() {
        return Stream.of(ContactScreeningTableColumns.values())
                .map(ContactScreeningTableColumns::getColumnName)
                .collect(Collectors.toList());
    }
}
