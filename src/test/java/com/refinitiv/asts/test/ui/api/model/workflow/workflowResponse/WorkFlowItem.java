package com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class WorkFlowItem {

    private Object indicator;
    private String description;
    private Long updateTime;
    private String type;
    private RiskScoringRange riskScoringRange;
    private String workflowGroupId;
    private String createBy;
    private Object versionId;
    private List<WorkflowGroupsItem> workflowGroups;
    private Long createTime;
    private List<WorkflowComponentsItem> workflowComponents;
    private String name;
    private Object action;
    private Object userEmail;
    private Object overallRiskScore;
    private String id;
    private Boolean finalVersion;
    private String status;

}