package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SecondaryFieldType {

    REGISTEREDIN("SFCT_6"),
    LOCATION("SFCT_3"),
    POB("SFCT_4"),
    NATIONALITY("SFCT_5");

    private final String typeId;
}
