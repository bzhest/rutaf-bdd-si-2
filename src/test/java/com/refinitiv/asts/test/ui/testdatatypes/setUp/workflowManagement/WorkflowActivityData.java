package com.refinitiv.asts.test.ui.testdatatypes.setUp.workflowManagement;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Data
@Accessors(chain = true)
public class WorkflowActivityData {

    private String activityType;
    private String activityName;
    private String description;
    private List<String> assessment;
    private Boolean isUserAssignee;
    private String assignee;
    private Boolean pendingForAssignment;
    private String status;
    private String riskArea;
    private String attachments;
    private String dueIn;
    private String scopeType;
    private String scope;

    public static WorkflowActivityData newInstance(WorkflowActivityData data) {
        return new WorkflowActivityData()
                .setActivityName(data.getActivityName())
                .setActivityType(data.getActivityType())
                .setDescription(data.getDescription())
                .setAssessment(Objects.nonNull(data.getAssessment()) ? new ArrayList<>(data.getAssessment()) : null)
                .setIsUserAssignee(data.getIsUserAssignee())
                .setAssignee(data.getAssignee())
                .setPendingForAssignment(data.getPendingForAssignment())
                .setStatus(data.getStatus())
                .setRiskArea(data.getRiskArea())
                .setAttachments(data.getAttachments())
                .setDueIn(data.getDueIn());
    }

}
