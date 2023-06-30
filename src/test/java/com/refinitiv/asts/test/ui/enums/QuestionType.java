package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

@Getter
@RequiredArgsConstructor
public enum QuestionType {

    BOOLEAN("Boolean"),
    CHECKBOX("Checkbox"),
    CURRENCY("Currency"),
    TEXT("Text"),
    NUMBER("Number"),
    DATE("Date"),
    MULTIPLE_CHOICE("Multiple Choice"),
    HEADING("Heading"),
    MULTI_SELECT("MultiSelect"),
    SINGLE_SELECT("SingleSelect"),
    TEXT_ENTRY_PLUS("TextEntryPlus"),
    ENHANCED_TEXT_ENTRY_PLUS("EnhancedTextEntryPlus");

    private final String name;

    private static final Map<String, QuestionType> stringMap = Arrays.stream(values())
            .collect(Collectors.toMap(QuestionType::getName, value -> value));

    public static QuestionType getQuestionType(String sector) {
        return stringMap.get(sector);
    }
}
