package com.refinitiv.asts.test.ui.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig.getInstance;

@Getter
@RequiredArgsConstructor
public enum WorkflowManagementGroupColumns {

    WORKFLOW_GROUP_NAME(getInstance().getValue("workflowManagement.group.workflowGroupName"), "WORKFLOW GROUP NAME"),
    STATUS(getInstance().getValue("workflowManagement.group.status"), "STATUS"),
    DATE_CREATED(getInstance().getValue("workflowManagement.group.dateCreated"), "DATE CREATED"),
    LAST_UPDATED(getInstance().getValue("workflowManagement.group.lastUpdated"), "LAST UPDATED");

    private final String name;
    private final String defaultName;

}
