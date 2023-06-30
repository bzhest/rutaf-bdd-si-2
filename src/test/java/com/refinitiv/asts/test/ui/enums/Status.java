package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Status {

    ACTIVE("Active"),
    INACTIVE("Inactive");

    private final String status;

}
