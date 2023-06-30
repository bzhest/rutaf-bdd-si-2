package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ScreeningProfileHeaderColumns {

    NAME("Name"),
    COUNTRY_OF_REGISTRATION("Country of Registration"),
    COUNTRY_OF_LOCATION("Country of Location"),
    MATCH_STRENGTH("Match Strength"),
    REFERENCE_ID("Reference ID"),
    DATA_PROVIDER("Data Provider"),
    LAST_SCREENING_DATE("Last Screening Date"),
    CREATED_BY("Created By"),
    LAST_UPDATED_BY("Last Updated By");

    private final String columnName;
}
