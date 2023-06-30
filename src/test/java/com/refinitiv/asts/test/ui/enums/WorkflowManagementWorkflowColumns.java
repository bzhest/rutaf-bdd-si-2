package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum WorkflowManagementWorkflowColumns {

    WORKFLOW_NAME(getInstance().getValue("workflowManagement.workflow.workflowName"), "WORKFLOW NAME"),
    WORKFLOW_TYPE(getInstance().getValue("workflowManagement.workflow.workflowType"), "WORKFLOW TYPE"),
    DATE_CREATED(getInstance().getValue("workflowManagement.workflow.dateCreated"), "DATE CREATED"),
    LAST_UPDATED(getInstance().getValue("workflowManagement.workflow.lastUpdated"), "LAST UPDATED"),
    STATUS(getInstance().getValue("workflowManagement.workflow.status"), "STATUS");

    private final String name;
    private final String defaultName;
}

