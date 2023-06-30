package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum RoleType {

    PEP_ROLE("PEP Role"),
    POSITION("Position");

    private final String type;
}
