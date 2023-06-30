package com.refinitiv.asts.test.ui.api.model.metricsActivities;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MetricsActivitiesResponse {

    private Payload payload;
    private String message;
    private String statusCode;

}