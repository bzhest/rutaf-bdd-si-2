package com.refinitiv.asts.test.api.dto.references.response;

import lombok.Data;

@Data
public class WorkflowGroupResponseDTO {

    private String workflowGroupId;
    private Object lastUpdated;
    private Boolean deleted;
    private Object dateCreated;
    private String workflowGroupName;
    private Boolean status;

}
