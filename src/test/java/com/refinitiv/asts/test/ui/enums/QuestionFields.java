package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum QuestionFields {

    QUESTION("Question"),
    HELP_TEXT("Help Text");

    private final String field;
}
