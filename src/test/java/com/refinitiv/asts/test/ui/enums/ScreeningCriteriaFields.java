package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ScreeningCriteriaFields {

    SEARCH_TERM("Search Term"),
    COUNTRY_OF_LOCATION("Country of Location");

    private final String name;
}
