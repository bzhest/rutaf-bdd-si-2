package com.refinitiv.asts.test.ui.api.model.approvalProcess;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class ApproverProcessRules {

    private String rule;
    private String method;
    private UsersList[] approvers;
    private String[] coverage;

}
