package com.refinitiv.asts.test.ui.testdatatypes.setUp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.refinitiv.asts.test.ui.utils.DateUtil;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.SI_UI_LOCAL_DATE_FORMAT;
import static org.apache.commons.lang3.StringUtils.LF;
import static org.apache.commons.lang3.StringUtils.SPACE;

@Data
@Accessors(chain = true)
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserRoleData {

    private String _id;
    private boolean deleted;
    private String name;
    private String description;
    private String active;
    private String supplierInformationCreate;
    private String supplierInformationEdit;
    private String supplierInformationDelete;
    private String supplierInformationRead;
    private String contactsCreate;
    private String contactsEdit;
    private String contactsDelete;
    private String contactsRead;
    private String contractsCreate;
    private String contractsEdit;
    private String contractsDelete;
    private String contractsRead;
    private String relationshipCreate;
    private String relationshipEdit;
    private String relationshipDelete;
    private String relationshipRead;
    private String activitiesCreate;
    private String activitiesEdit;
    private String activitiesDelete;
    private String activitiesRead;
    private String bankDetailsCreate;
    private String bankDetailsEdit;
    private String bankDetailsDelete;
    private String bankDetailsRead;
    private String configureOverallRiskYes;
    private String activityRollbackYes;
    private String externalUserManagementYes;
    private String onboardingRenewalYes;
    private String relatedFilesAdd;
    private String relatedFilesDownload;
    private String relatedFilesDelete;
    private String thirdPartyStatusYes;
    private String riskReportYes;
    private String dashboardYes;
    private String thirdPartyReportYes;
    private String activityReportYes;
    private String questionnaireReportYes;
    private String dueDiligenceOrderReportYes;
    private String workflowReportYes;
    private String userManagementYes;
    private String myOrganisationYes;
    private String questionnaireManagementYes;
    private String workflowManagementYes;
    private String screeningManagement;
    private String approvalProcessYes;
    private String reviewProcessYes;
    private String fieldsManagementYes;
    private String countryChecklistYes;
    private String valueManagementYes;
    private String emailManagementYes;
    private String dueDiligenceOrderManagementYes;
    private String announcementBanner;
    private String orderReportCreate;
    private String orderReportEdit;
    private String orderReportRead;
    private String orderReportDecline;
    private String orderReportApprove;
    private String enableScreeningYes;
    private String manageResolutionTypeYes;
    private String ongoingScreeningYes;
    private String changeSearchCriteriaYes;
    private String createDate;
    private String updateDate;
    private String bulkProcessing;
    private String bitSightSearch;
    private String businessOverviewSearch;

    @JsonProperty("active")
    private void setActiveStatus(boolean isActive) {
        active = isActive ? ACTIVE.getStatus() : INACTIVE.getStatus();
    }

    @JsonProperty("createDate")
    private void setRoleCreateDate(long date) {
        createDate = DateUtil.getDateFromEpochMilli(date, SI_UI_LOCAL_DATE_FORMAT);
    }

    @JsonProperty("updateDate")
    private void setRoleUpdateDate(long date) {
        updateDate = DateUtil.getDateFromEpochMilli(date, SI_UI_LOCAL_DATE_FORMAT);
    }

    @JsonProperty("description")
    private void setRoleDescription(String roleDescription) {
        if (!roleDescription.isEmpty()) {
            description = roleDescription.replace(LF, SPACE);
        } else {
            description = null;
        }
    }

    public UserRoleData(String name, String status) {
        this.name = name;
        this.active = status;
    }

}
