package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

@Getter
@RequiredArgsConstructor
public enum ThirdPartyInformationSectors {
    ADDRESS("Address"),
    BANK_DETAILS("Bank Details"),
    SCREENING_CRITERIA("Screening Criteria"),
    THIRD_PARTY_SEGMENTATION("Third-party Segmentation"),
    OTHER_INFORMATION("Other Information"),
    DESCRIPTION("DESCRIPTION");

    private final String name;

    private static final Map<String, ThirdPartyInformationSectors> stringMap = Arrays.stream(values())
            .collect(Collectors.toMap(ThirdPartyInformationSectors::getName, value -> value));

    public static ThirdPartyInformationSectors getThirdPartyInformationSection(String sector) {
        return stringMap.get(sector);
    }
}
