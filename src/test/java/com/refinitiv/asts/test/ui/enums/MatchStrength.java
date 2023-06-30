package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum MatchStrength {

    EXACT(0), STRONG(1), MEDIUM(2), FUZZY(3);

    private final int priority;
}
