package com.refinitiv.asts.test.ui.api.model.metricsActivities;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ActivityItem {

    private String supplierCountry;
    private Long dueDate;
    private String responsibleParty;
    private String supplierIntegrityID;
    private String assigneeEmail;
    private List<String> division;
    private Double completionTime;
    private String responsiblePartyEmail;
    private String reviewerEmail;
    private List<Object> reviewerGroup;
    private Double riskScore;
    private String initiatedBy;
    private String workflowID;
    private String supplierName;
    private Object lastUpdatedBy;
    private String approverEmail;
    private String activityName;
    private List<Object> approverGroup;
    private String reviewer;
    private String riskTier;
    private String lastUpdatedByEmail;
    private String activityID;
    private String activitySource;
    private String supplierStatus;
    private String reviewStatus;
    private String assignee;
    private Long activationDate;
    private String activityType;
    private List<String> reviewerDivision;
    private String status;
    private Long lastUpdate;

}