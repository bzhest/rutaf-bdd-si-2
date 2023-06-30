package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Getter
@RequiredArgsConstructor
public enum KeywordsTableColumns {

    KEYWORD("KEYWORD"),
    DESCRIPTION("DESCRIPTION"),
    COUNTRY("COUNTRY");

    private final String name;

    public static List<String> getKeywordColumnNames() {
        return Stream.of(KeywordsTableColumns.values())
                .map(KeywordsTableColumns::getName)
                .collect(Collectors.toList());
    }
}