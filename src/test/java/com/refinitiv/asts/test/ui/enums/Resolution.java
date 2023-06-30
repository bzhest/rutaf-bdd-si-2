package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Resolution {

    POSITIVE(0, 0),
    POSSIBLE(1, 1),
    FALSE(2, 4),
    UNRESOLVED(3, 2),
    UNSPECIFIED(3, 3);

    private final int resolutionPosition;
    private final int priority;
}
