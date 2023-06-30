package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum QuestionnaireToBeAttachedFields {

    QUESTIONNAIRE_NAME("Questionnaire Name"),
    QUESTIONNAIRE_TYPE("Questionnaire Type"),
    ASSIGNEE("Assignee"),
    DATE_COMPLETED("Date Completed"),
    OVERALL_SCORE("Overall Score");

    private final String name;
}
