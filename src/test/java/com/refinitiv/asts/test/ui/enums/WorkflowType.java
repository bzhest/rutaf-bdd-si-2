package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum WorkflowType {

    ONBOARDING("Onboarding"),
    FOR_RENEWAL("For Renewal"),
    RENEWAL("Renewal");

    private final String type;
}
