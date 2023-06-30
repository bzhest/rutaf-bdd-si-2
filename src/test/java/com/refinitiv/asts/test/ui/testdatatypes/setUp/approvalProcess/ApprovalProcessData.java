package com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess;

import com.refinitiv.asts.test.ui.api.model.approvalProcess.ApproverProcessRules;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.Approvers;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ApprovalProcessData {

    private String name;
    private String description;
    private String type;
    private String status;
    private ApproverProcessRules approverProcessRules;
    private Approvers approvers;

}
