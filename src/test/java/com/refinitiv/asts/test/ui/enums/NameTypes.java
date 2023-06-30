package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum NameTypes {

    AKA("ALIASES"),
    LANG_VARIATION("ALTERNATE SPELLING"),
    LOW_QUALITY_AKA("LOW QUALITY ALIAS(ES)"),
    NATIVE_AKA("NATIVE CHARACTER NAME(S)"),
    PRIMARY("PRIMARY");

    private final String name;
}