package com.refinitiv.asts.test.ui.api.model.metricsQuestionnaires;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MetricsQuestionnaireResponse {

    private Payload payload;
    private String message;
    private String statusCode;

}