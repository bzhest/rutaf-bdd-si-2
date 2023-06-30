package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum AdvanceSearchResultsFields {

    THIRD_PARTY_NAME("Third-party Name"),
    INDUSTRY_TYPE("Industry Type"),
    COUNTRY("Country"),
    THIRD_PARTY_STATUS("Third-party Status"),
    RISK_MODEL("Risk Model"),
    RISK_TIER("Risk Tier"),
    DATE_CREATED("Date Created"),
    LAST_UPDATED("Last Update"),
    SCREENING_STATUS("Screening Status");

    private final String name;

}
