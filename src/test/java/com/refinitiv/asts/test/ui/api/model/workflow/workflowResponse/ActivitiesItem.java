package com.refinitiv.asts.test.ui.api.model.workflow.workflowResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors(chain = true)
public class ActivitiesItem {

    private Object creatorEmail;
    private Object dueDate;
    private Object orderStatusDesc;
    private Object riskArea;
    private Integer dueIn;
    private Object reviewerProcessRules;
    private Object requiredForOnboarding;
    private Object pendingAssignment;
    private Object parentActivityId;
    private String id;
    private Object triggeredApproverProcessRule;
    private Object psaOrderId;
    private Boolean selected;
    private Object questionnaireIds;
    private Object standalone;
    private Object questionnaireDetails;
    private Object completeTime;
    private Object priority;
    private Object triggeredReviewProcessRule;
    private Boolean relevant;
    private Object assignedQuestionnaire;
    private String name;
    private Object overallRiskScore;
    private Assignee assignee;
    private Boolean branched;
    private WorkflowGroup workflowGroup;
    private Object startDate;
    private String status;
    private Object recommendedPsaProduct;
    private Object hasOverAllReviewer;
    private Object attachments;
    private List<ReviewProcessRulesItem> reviewProcessRules;
    private String description;
    private Object approvers;
    private Object orderStatus;
    private Object questionnaireId;
    private Boolean enabled;
    private Object updateBy;
    private List<ApproverProcessRulesItem> approverProcessRules;
    private Object updateEnabled;
    private Object matchedProcessRule;
    private Object selectedAssessment;
    private List<AssessmentsItem> assessments;
    private Object comments;
    private Object updateTime;
    private Object reviewer;
    private Object reviewers;
    private Object createBy;
    private Object createTime;
    private ActivityType activityType;
    private Boolean autoSelectDDRecommendScope;

}