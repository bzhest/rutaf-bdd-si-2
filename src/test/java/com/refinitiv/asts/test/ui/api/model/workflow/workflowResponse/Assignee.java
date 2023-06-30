package com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class Assignee {

    private Object userGroupId;
    private Object processed;
    private Boolean emailed;
    private Boolean notified;
    private String name;
    private Object updateTime;
    private String type;
    private String email;
    private String status;

}