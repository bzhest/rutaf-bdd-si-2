package com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class WorkflowGroup {

    private Integer number;
    private String name;

}