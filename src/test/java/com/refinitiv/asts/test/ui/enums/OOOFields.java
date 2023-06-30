package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum OOOFields {

    NAME("NAME"),
    DATE_TIME("DATE/TIME"),
    OLD_VALUE("OLD VALUE"),
    NEW_VALUE("NEW VALUE"),
    FROM("From");

    private final String name;
}
