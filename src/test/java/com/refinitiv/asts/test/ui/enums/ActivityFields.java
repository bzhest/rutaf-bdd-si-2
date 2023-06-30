package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ActivityFields {

    NAME("Name"),
    TYPE("Type"),
    ASSIGNED_TO("Assigned To"),
    DUE_DATE("Due Date"),
    STATUS("Status");

    private final String name;

}
