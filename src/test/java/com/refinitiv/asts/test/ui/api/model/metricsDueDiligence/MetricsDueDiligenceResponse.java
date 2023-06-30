package com.refinitiv.asts.test.ui.api.model.metricsDueDiligence;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MetricsDueDiligenceResponse {

    private Payload payload;
    private String message;
    private String statusCode;

}