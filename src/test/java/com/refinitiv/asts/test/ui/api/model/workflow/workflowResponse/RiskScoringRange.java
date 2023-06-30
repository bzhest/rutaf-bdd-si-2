package com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class RiskScoringRange {

    private String min;
    private String max;
    private String name;
    private String id;

}