package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ScreeningProfileTabs {

    KEY_DATA("Key data"),
    ALIASES("Aliases"),
    FURTHER_INFORMATION("Further information"),
    KEYWORDS("Keywords"),
    CONNECTIONS("Connections"),
    SOURCES("Sources");

    private final String tabName;
}
