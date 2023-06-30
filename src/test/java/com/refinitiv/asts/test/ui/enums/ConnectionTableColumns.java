package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Getter
@RequiredArgsConstructor
public enum ConnectionTableColumns {

    LINKED_INDIVIDUALS("LINKED RECORD"),
    CONNECTION("CONNECTION"),
    TYPE("TYPE"),
    CATEGORY("CATEGORY");

    private final String name;

    public static List<String> getConnectionColumnNames() {
        return Stream.of(ConnectionTableColumns.values())
                .map(ConnectionTableColumns::getName)
                .collect(Collectors.toList());
    }
}