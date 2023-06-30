package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum GroupFields {

    GROUP_NAME("Group name"),
    GROUP_NAME_UPPER_CAMEL_CASE("Group Name"),
    DESCRIPTION("Description"),
    STATUS("Status"),
    DATE_CREATED("Date Created"),
    LAST_UPDATE("Last Update");

    private final String field;

}