package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum RoleFields {

    NAME("Name"),
    DESCRIPTION("Description"),
    DATE_CREATED("Date Created"),
    LAST_UPDATE("Last Update"),
    STATUS("Status");

    private final String field;

}
