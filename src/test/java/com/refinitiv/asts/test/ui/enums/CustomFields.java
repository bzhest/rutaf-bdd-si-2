package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CustomFields {

    ACTIVE("Active"),
    INACTIVE("Inactive"),
    SAVED_AS_DRAFT("Saved As Draft");

    private final String status;

}


