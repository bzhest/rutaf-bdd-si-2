package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class ProcessRuleRequest {

    private String name;
    private String description;
    private String type;
    private String status;
    private ApproverProcessRules[] approverProcessRules;
    private Approvers[] approvers;

}
