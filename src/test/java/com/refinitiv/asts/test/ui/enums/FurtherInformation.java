package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum FurtherInformation {

    OWNERS("OWNERS"),
    RELEVANT_ASSOCIATES("RELEVANT ASSOCIATES"),
    RELATIVES("RELATIVES"),
    ADDITIONAL_COMMENTS("ADDITIONAL COMMENTS");

    private final String name;
}
