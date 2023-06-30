package com.refinitiv.asts.test.ui.api.model.workflowGroup;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class WorkflowGroupRequest {

    private String name;
    private boolean status;

}
