package com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class WorkflowReviewerApproverData {

    String addRulesFor;
    String activityOwner;
    String reviewer;
    String reviewerMethod;

}
