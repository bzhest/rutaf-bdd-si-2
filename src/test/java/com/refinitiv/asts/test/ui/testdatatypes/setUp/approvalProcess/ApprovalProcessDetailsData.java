package com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ApprovalProcessDetailsData {

    private String approvalProcessName;
    private String defaultApprover;
    private String description;
    private String status;

}
