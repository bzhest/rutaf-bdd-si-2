package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ValueType {

    REF_COUNTRY("RefCountry"),
    REF_REGION("RefRegion"),
    REF_RISK_SCORING_RANGE("RefRiskScoringRange"),
    REF_RISK_CATEGORY("RefRiskCategory"),
    REF_ACTIVITY_TYPE("RefActivityType"),
    REF_QUESTIONNAIRE_CATEGORY("RefQuestionnaireCategory");

    private final String name;
}
