package com.refinitiv.asts.test.ui.pageActions.setUp.userManagement;

import com.mysql.jdbc.StringUtils;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.PageElementNames;
import com.refinitiv.asts.test.ui.enums.UserRoleFields;
import com.refinitiv.asts.test.ui.pageActions.BasePage;
import com.refinitiv.asts.test.ui.pageActions.ConfirmationWindowPage;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement.RoleFormPO;
import com.refinitiv.asts.test.ui.pageObjects.setUp.userManagement.RoleTablePO;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserRoleData;
import com.refinitiv.asts.test.ui.utils.i18n.LanguageConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.USER_ROLE_DESCRIPTION;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.ADD_ROLE_PATH;
import static com.refinitiv.asts.test.ui.constants.Pages.USER_ROLE_PATH;
import static com.refinitiv.asts.test.ui.constants.Pages.VIEW_ROLE_PATH;
import static com.refinitiv.asts.test.ui.constants.Pages.EDIT_ROLE_PATH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.UserRoleFields.BULK_PROCESSING;
import static com.refinitiv.asts.test.ui.enums.UserRoleFields.*;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static java.lang.String.format;
import static org.openqa.selenium.By.xpath;
import static org.openqa.selenium.support.ui.ExpectedConditions.invisibilityOfElementLocated;
import static org.openqa.selenium.support.ui.ExpectedConditions.visibilityOfElementLocated;

public class UserManagementRolePage extends BasePage<UserManagementRolePage> {

    private final RoleFormPO userRolePO;
    private final RoleTablePO userRoleTablePO;
    private final SearchSectionPage searchPage;
    private final PaginationPage paginationPage;
    private final ConfirmationWindowPage confirmationWindowPage;

    public UserManagementRolePage(WebDriver driver, ScenarioCtxtWrapper context, LanguageConfig translator) {
        super(driver, context, translator);
        userRolePO = new RoleFormPO(driver);
        userRoleTablePO = new RoleTablePO(driver, translator);
        searchPage = new SearchSectionPage(driver);
        confirmationWindowPage = new ConfirmationWindowPage(driver);
        paginationPage = new PaginationPage(driver, context);
        this.get();
    }

    @Override
    protected ExpectedCondition<UserManagementRolePage> getPageLoadCondition() {
        return null;
    }

    @Override
    protected String getPageTitle() {
        return null;
    }

    @Override
    public boolean isPageLoaded() {
        return true;
    }

    @Override
    public void load() {

    }

    public void openUserRolePage() {
        driver.get(URL + USER_ROLE_PATH);
    }

    public void navigateToUserManagementAddRolePage() {
        driver.get(URL + ADD_ROLE_PATH);
    }

    public void navigateToUserManagementViewRolePage(String roleId) {
        driver.get(URL + format(VIEW_ROLE_PATH, roleId));
    }

    public void navigateToUserManagementEditRolePage(String roleId) {
        driver.get(URL + format(EDIT_ROLE_PATH, roleId));
    }

    public void clickAddNewRoleButton() {
        clickOn(userRoleTablePO.getAddNewRoleButton(), waitLong);
    }

    public void clickDeactivateButton() {
        clickOn(waitShort.until(visibilityOfElementLocated(userRoleTablePO.getDeactivateRoleButton())));
    }

    public boolean isDeactivateButtonDisplayed() {
        return isElementDisplayed(userRoleTablePO.getDeactivateRoleButton());
    }

    public void clickDeleteButton(String roleName) {
        if (roleName.equals(SYSTEM_ADMINISTRATOR)) {
            throw new IllegalArgumentException(format("%s role cannot be deleted", roleName));
        }
        clickOn(xpath(format(userRoleTablePO.getDeleteRoleButton(), roleName)));
    }

    public void fillAddRoleHeader(UserRoleData roleData) {
        fillRoleName(roleData.getName());
        fillRoleDescription(roleData.getDescription());
        if ((roleData.getActive().equals(ACTIVE.getStatus()) && !isActiveCheckboxChecked()) ||
                (roleData.getActive().equals(INACTIVE.getStatus()) && isActiveCheckboxChecked())) {
            tickActiveCheckbox();
        }
    }

    public void editRoleHeader(UserRoleData roleData) {
        fillRoleName(roleData.getName());
        fillRoleDescription(roleData.getDescription());
    }

    public void fillRoleName(String name) {
        waitShort.until(visibilityOfElementLocated(userRolePO.getNameField()));
        clearInputAndEnterField(userRolePO.getNameField(), name);
    }

    public void fillRoleDescription(String description) {
        clearInputAndEnterField(userRolePO.getDescriptionField(), description);
        this.context.getScenarioContext().setContext(USER_ROLE_DESCRIPTION, description);
    }

    public void editThirdPartyBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getToggleButton(), CONFIGURE_OVERALL_RISK.getField(),
                            roleData.getConfigureOverallRiskYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ACTIVITY_ROLLBACK.getField(),
                            roleData.getActivityRollbackYes());
        selectReactCheckbox(userRolePO.getToggleButton(), EXTERNAL_USER_MANAGEMENT.getField(),
                            roleData.getExternalUserManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ONBOARDING_RENEWAL.getField(),
                            roleData.getOnboardingRenewalYes());
    }

    public void fillThirdPartyBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getCreateCheckbox(), THIRD_PARTY_INFORMATION.getField(),
                            roleData.getSupplierInformationCreate());
        selectReactCheckbox(userRolePO.getEditCheckbox(), THIRD_PARTY_INFORMATION.getField(),
                            roleData.getSupplierInformationEdit());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), THIRD_PARTY_INFORMATION.getField(),
                            roleData.getSupplierInformationDelete());
        selectReactCheckbox(userRolePO.getCreateCheckbox(), ASSOCIATED_PARTIES.getField(),
                            roleData.getContactsCreate());
        selectReactCheckbox(userRolePO.getEditCheckbox(), ASSOCIATED_PARTIES.getField(), roleData.getContactsEdit());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), ASSOCIATED_PARTIES.getField(),
                            roleData.getContactsDelete());
        selectReactCheckbox(userRolePO.getCreateCheckbox(), CONTRACTS.getField(), roleData.getContractsCreate());
        selectReactCheckbox(userRolePO.getEditCheckbox(), CONTRACTS.getField(), roleData.getContractsEdit());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), CONTRACTS.getField(), roleData.getContractsDelete());
        selectReactCheckbox(userRolePO.getCreateCheckbox(), RELATIONSHIP.getField(),
                            roleData.getRelationshipCreate());
        selectReactCheckbox(userRolePO.getEditCheckbox(), RELATIONSHIP.getField(), roleData.getRelationshipEdit());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), RELATIONSHIP.getField(),
                            roleData.getRelationshipDelete());
        selectReactCheckbox(userRolePO.getCreateCheckbox(), ACTIVITIES.getField(), roleData.getActivitiesCreate());
        selectReactCheckbox(userRolePO.getEditCheckbox(), ACTIVITIES.getField(), roleData.getActivitiesEdit());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), ACTIVITIES.getField(), roleData.getActivitiesDelete());
        selectReactCheckbox(userRolePO.getCreateCheckbox(), BANK_DETAILS.getField(), roleData.getBankDetailsCreate());
        selectReactCheckbox(userRolePO.getEditCheckbox(), BANK_DETAILS.getField(), roleData.getBankDetailsEdit());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), BANK_DETAILS.getField(), roleData.getBankDetailsDelete());
        selectReactCheckbox(userRolePO.getReadCheckbox(), BANK_DETAILS.getField(), roleData.getBankDetailsRead());
        selectReactCheckbox(userRolePO.getToggleButton(), CONFIGURE_OVERALL_RISK.getField(),
                            roleData.getConfigureOverallRiskYes());
        selectReactCheckbox(userRolePO.getToggleButton(), EXTERNAL_USER_MANAGEMENT.getField(),
                            roleData.getExternalUserManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ONBOARDING_RENEWAL.getField(),
                            roleData.getOnboardingRenewalYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ACTIVITY_ROLLBACK.getField(),
                            roleData.getActivityRollbackYes());
        selectReactCheckbox(userRolePO.getAddCheckbox(), RELATED_FILES.getField(), roleData.getRelatedFilesAdd());
        selectReactCheckbox(userRolePO.getDownloadCheckbox(), RELATED_FILES.getField(),
                            roleData.getRelatedFilesDownload());
        selectReactCheckbox(userRolePO.getDeleteCheckbox(), RELATED_FILES.getField(),
                            roleData.getRelatedFilesDelete());
    }

    public void fillReportsBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getToggleButton(), THIRD_PARTY_STATUS.getField(),
                            roleData.getThirdPartyStatusYes());
        selectReactCheckbox(userRolePO.getToggleButton(), RISK_REPORT.getField(), roleData.getRiskReportYes());
        selectReactCheckbox(userRolePO.getToggleButton(), DASHBOARD.getField(), roleData.getDashboardYes());

        selectReactCheckbox(userRolePO.getToggleButton(), THIRD_PARTY_REPORT.getField(),
                            roleData.getThirdPartyReportYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ACTIVITY_REPORT.getField(),
                            roleData.getActivityReportYes());
        selectReactCheckbox(userRolePO.getToggleButton(), QUESTIONNAIRE_REPORT.getField(),
                            roleData.getQuestionnaireReportYes());
        selectReactCheckbox(userRolePO.getToggleButton(), DUE_DILIGENCE_ORDER_REPORT.getField(),
                            roleData.getDueDiligenceOrderReportYes());
        selectReactCheckbox(userRolePO.getToggleButton(), WORKFLOW_REPORT.getField(),
                            roleData.getWorkflowReportYes());
    }

    public void fillDataProviderBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getToggleButton(), ENABLE_SCREENING.getField(),
                            roleData.getEnableScreeningYes());
        selectReactCheckbox(userRolePO.getToggleButton(), MANAGE_RESOLUTION_TYPE.getField(),
                            roleData.getManageResolutionTypeYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ONGOING_SCREENING.getField(),
                            roleData.getOngoingScreeningYes());
        selectReactCheckbox(userRolePO.getToggleButton(), UserRoleFields.CHANGE_SEARCH_CRITERIA.getField(),
                            roleData.getChangeSearchCriteriaYes());
        selectReactCheckbox(userRolePO.getToggleButton(), BIT_SIGHT_SEARCH.getField(),
                            roleData.getBitSightSearch());
        selectReactCheckbox(userRolePO.getToggleButton(), BUSINESS_OVERVIEW_SEARCH.getField(),
                            roleData.getBitSightSearch());
    }

    public void fillSetUpBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getToggleButton(), USER_MANAGEMENT.getField(),
                            roleData.getUserManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), MY_ORGANISATION.getField(),
                            roleData.getMyOrganisationYes());
        selectReactCheckbox(userRolePO.getToggleButton(), QUESTIONNAIRE_MANAGEMENT.getField(),
                            roleData.getQuestionnaireManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), WORKFLOW_MANAGEMENT.getField(),
                            roleData.getWorkflowManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), SCREENING_MANAGEMENT.getField(),
                            roleData.getScreeningManagement());
        selectReactCheckbox(userRolePO.getToggleButton(), APPROVAL_PROCESS.getField(),
                            roleData.getApprovalProcessYes());
        selectReactCheckbox(userRolePO.getToggleButton(), REVIEW_PROCESS.getField(),
                            roleData.getReviewProcessYes());
        selectReactCheckbox(userRolePO.getToggleButton(), FIELDS_MANAGEMENT.getField(),
                            roleData.getFieldsManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), COUNTRY_CHECKLIST.getField(),
                            roleData.getCountryChecklistYes());
        selectReactCheckbox(userRolePO.getToggleButton(), VALUE_MANAGEMENT.getField(),
                            roleData.getValueManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), EMAIL_MANAGEMENT.getField(),
                            roleData.getEmailManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), DUE_DILIGENCE_ORDER_MANAGEMENT.getField(),
                            roleData.getDueDiligenceOrderManagementYes());
        selectReactCheckbox(userRolePO.getToggleButton(), ANNOUNCEMENT_BANNER.getField(),
                            roleData.getAnnouncementBanner());
    }

    public void fillDueDiligenceOrderBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getCreateOrderReportCheckbox(), ORDER_REPORT.getField(),
                            roleData.getOrderReportCreate());
        selectReactCheckbox(userRolePO.getEditOrderReportCheckbox(), ORDER_REPORT.getField(),
                            roleData.getOrderReportEdit());
        selectReactCheckbox(userRolePO.getReadOrderReportCheckbox(), ORDER_REPORT.getField(),
                            roleData.getOrderReportRead());
        selectReactCheckbox(userRolePO.getDeclineOrderReportCheckbox(), ORDER_REPORT.getField(),
                            roleData.getOrderReportDecline());
        selectReactCheckbox(userRolePO.getApproveOrderReportCheckbox(), ORDER_REPORT.getField(),
                            roleData.getOrderReportApprove());
    }

    public void fillBulkProcessingBlock(UserRoleData roleData) {
        selectReactCheckbox(userRolePO.getToggleButton(), BULK_PROCESSING.getField(),
                            roleData.getBulkProcessing());
    }

    public void tickActiveCheckbox() {
        clickOn(userRolePO.getActiveCheckbox());
    }

    public void clickSubmitFormButton() {
        clickOn(userRolePO.getSubmitFormButton());
    }

    public void clickCancelFormButton() {
        clickOn(userRolePO.getCancelFormButton());
    }

    public void clickBackButton() {
        clickOn(userRolePO.getRoleManagementBackButton());
    }

    public void clickEditFormButton() {
        clickOn(userRolePO.getEditFormButton());
        waitShort.until(invisibilityOfElementLocated(userRolePO.getEditFormButton()));
    }

    public String getRoleFormText() {
        waitLong.until(visibilityOfElementLocated(xpath(userRolePO.getRoleFormWindow())));
        return getElementText(xpath(userRolePO.getRoleFormWindow()));
    }

    public boolean isRoleFormClosed(String formName) {
        return isElementDisappeared(waitShort, xpath(format(userRolePO.getRoleFormWindowName(), formName)));
    }

    public void clickDeleteRole(String roleName) {
        clickOn(xpath(format(userRoleTablePO.getDeleteRoleButton(), roleName)), waitLong);
        confirmationWindowPage.clickConfirmModalButton();
    }

    public void clickEditRole(String roleName) {
        clickOn(waitLong.until(
                visibilityOfElementLocated(xpath(format(userRoleTablePO.getEditRoleButton(), roleName)))));
    }

    public void selectRole(String roleName) {
        By roleCheckbox = xpath(format(userRoleTablePO.getRoleCheckbox(), roleName));
        if (!isReactCheckboxChecked(roleCheckbox)) {
            clickOn(roleCheckbox);
        }
    }

    public void unSelectRole(String roleName) {
        By roleCheckbox = xpath(format(userRoleTablePO.getRoleCheckbox(), roleName));
        if (isReactCheckboxChecked(roleCheckbox)) {
            clickOn(roleCheckbox);
        }
    }

    public void searchAndOpenRole(String roleName) {
        int count = 1;
        int maxTries = 3;
        searchPage.searchItem(roleName);
        while (count++ <= maxTries) {
            try {
                clickOn(waitShort.until(
                        visibilityOfElementLocated(By.xpath(format(userRoleTablePO.getRoleName(), roleName)))));
                break;
            } catch (TimeoutException exception) {
                searchPage.searchItem(roleName);
            }
        }
    }

    public String getDateCreatedForRole(String roleName) {
        int count = 1;
        int maxTries = 3;
        while (count++ <= maxTries) {
            try {
                return waitMoment
                        .until(visibilityOfElementLocated(
                                xpath(format(userRoleTablePO.getDateCreatedField(), roleName))))
                        .getText();
            } catch (TimeoutException exception) {
                searchPage.searchItem(roleName);
            }
        }
        throw new TimeoutException("Couldn't get date created for role " + roleName);
    }

    public String getLastUpdateDateForRole(String roleName) {
        int count = 1;
        int maxTries = 3;
        while (count++ <= maxTries) {
            try {
                return waitMoment
                        .until(visibilityOfElementLocated(
                                xpath(format(userRoleTablePO.getLastUpdateField(), roleName))))
                        .getText();
            } catch (TimeoutException exception) {
                searchPage.searchItem(roleName);
            }
        }
        throw new TimeoutException("Couldn't get last update for role " + roleName);
    }

    public String getStatusForRole(String roleName) {
        int count = 1;
        int maxTries = 3;
        while (count++ <= maxTries) {
            try {
                return waitMoment
                        .until(visibilityOfElementLocated(xpath(format(userRoleTablePO.getStatusField(), roleName))))
                        .getText();
            } catch (TimeoutException exception) {
                searchPage.searchItem(roleName);
            }
        }
        throw new TimeoutException("Couldn't get status for role " + roleName);
    }

    public String getBreadcrumbText() {
        return getElementText(userRolePO.getBreadcrumbs());
    }

    public void clickOnTableColumn(String columnName) {
        clickOn(xpath(format(userRoleTablePO.getRoleTableColumn(), columnName)));
        searchPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    public void selectCheckboxesOnSupplierBlock(List<String> fieldNames) {
        fieldNames.forEach(field -> {
                               tickFieldCheckbox(userRolePO.getCreateCheckbox(), field);
                               tickFieldCheckbox(userRolePO.getEditCheckbox(), field);
                               tickFieldCheckbox(userRolePO.getDeleteCheckbox(), field);
                           }
        );
    }

    public void selectAllCheckboxesOnRelatedFiles() {
        tickFieldCheckbox(userRolePO.getAddCheckbox(), RELATED_FILES.getField());
        tickFieldCheckbox(userRolePO.getDownloadCheckbox(), RELATED_FILES.getField());
        tickFieldCheckbox(userRolePO.getDeleteCheckbox(), RELATED_FILES.getField());
    }

    public void selectAllCheckboxesOnOrderReport() {
        tickFieldCheckbox(userRolePO.getCreateOrderReportCheckbox(), ORDER_REPORT.getField());
        tickFieldCheckbox(userRolePO.getEditOrderReportCheckbox(), ORDER_REPORT.getField());
        tickFieldCheckbox(userRolePO.getReadOrderReportCheckbox(), ORDER_REPORT.getField());
        tickFieldCheckbox(userRolePO.getDeclineOrderReportCheckbox(), ORDER_REPORT.getField());
        tickFieldCheckbox(userRolePO.getApproveOrderReportCheckbox(), ORDER_REPORT.getField());
    }

    public void clickToggleButton(String fieldName) {
        tickFieldCheckbox(userRolePO.getToggleButton(), fieldName);
    }

    public String getCheckboxValueOnRolePage(String roleName, String columnName) {
        if (roleName.equals(ORDER_REPORT.getField())) {
            return getCheckBoxValueOnOrderReport(columnName);
        }
        boolean isChecked;
        switch (columnName) {
            case DELETE:
                isChecked = isReactCheckboxChecked(userRolePO.getDeleteCheckbox(), roleName);
                break;
            case CREATE:
                isChecked = isReactCheckboxChecked(userRolePO.getCreateCheckbox(), roleName);
                break;
            case EDIT:
                isChecked = isReactCheckboxChecked(userRolePO.getEditCheckbox(), roleName);
                break;
            case READ:
                isChecked = isReactCheckboxChecked(userRolePO.getReadCheckbox(), roleName);
                break;
            case ADD:
                isChecked = isReactCheckboxChecked(userRolePO.getAddCheckbox(), RELATED_FILES.getField());
                break;
            case DOWNLOAD:
                isChecked = isReactCheckboxChecked(userRolePO.getDownloadCheckbox(), RELATED_FILES.getField());
                break;
            case TOGGLE:
                isChecked = isReactCheckboxChecked(userRolePO.getToggleButton(), roleName);
                break;
            default:
                throw new IllegalArgumentException(
                        format("Checkbox '%s' element is not found for %s", columnName, roleName));
        }
        return isChecked ? PageElementNames.CHECKED : UNCHECKED;
    }

    private String getCheckBoxValueOnOrderReport(String columnName) {
        boolean isChecked;
        switch (columnName) {
            case CREATE:
                isChecked = isReactCheckboxChecked(userRolePO.getCreateOrderReportCheckbox(), ORDER_REPORT.getField());
                break;
            case EDIT:
                isChecked = isReactCheckboxChecked(userRolePO.getEditOrderReportCheckbox(), ORDER_REPORT.getField());
                break;
            case READ:
                isChecked = isReactCheckboxChecked(userRolePO.getReadOrderReportCheckbox(), ORDER_REPORT.getField());
                break;
            case DECLINE:
                isChecked = isReactCheckboxChecked(userRolePO.getDeclineOrderReportCheckbox(), ORDER_REPORT.getField());
                break;
            case APPROVE:
                isChecked = isReactCheckboxChecked(userRolePO.getApproveOrderReportCheckbox(), ORDER_REPORT.getField());
                break;
            default:
                throw new IllegalArgumentException(format("Checkbox locator '%s' is not found", columnName));
        }
        return isChecked ? PageElementNames.CHECKED : UNCHECKED;
    }

    public boolean isCheckBoxOnOrderReportEditable(String roleName, String columnName) {
        switch (columnName) {
            case CREATE:
                return isCheckboxEditable(userRolePO.getCreateOrderReportCheckbox(), roleName);
            case EDIT:
                return isCheckboxEditable(userRolePO.getEditOrderReportCheckbox(), roleName);
            case READ:
                return isCheckboxEditable(userRolePO.getReadOrderReportCheckbox(), roleName);
            case DECLINE:
                return isCheckboxEditable(userRolePO.getDeclineOrderReportCheckbox(), roleName);
            case APPROVE:
                return isCheckboxEditable(userRolePO.getApproveOrderReportCheckbox(), roleName);
            default:
                throw new IllegalArgumentException(
                        format("Checkbox locator '%s' is not found for %s", columnName, roleName));
        }
    }

    public boolean isCheckBoxOnThirdPartyBlockEditable(String roleName, String columnName) {
        switch (columnName) {
            case CREATE:
                return isCheckboxEditable(userRolePO.getCreateCheckbox(), roleName);
            case EDIT:
                return isCheckboxEditable(userRolePO.getEditCheckbox(), roleName);
            case DELETE:
                return isCheckboxEditable(userRolePO.getDeleteCheckbox(), roleName);
            case READ:
                return isCheckboxEditable(userRolePO.getReadCheckbox(), roleName);
            case ADD:
                return isCheckboxEditable(userRolePO.getAddCheckbox(), roleName);
            case DOWNLOAD:
                return isCheckboxEditable(userRolePO.getDownloadCheckbox(), roleName);
            case TOGGLE:
                return isCheckboxEditable(userRolePO.getToggleButton(), roleName);
            default:
                throw new IllegalArgumentException(
                        format("Checkbox locator '%s' is not found for %s", columnName, roleName));
        }
    }

    public UserRoleData getCreatedDataFromRole() {
        return new UserRoleData()
                .setName(getAttributeValue(userRolePO.getRoleNameText(), VALUE))
                .setDescription(getElementText(userRolePO.getRoleDescriptionText()))
                .setActive(
                        isReactCheckboxChecked(userRolePO.getActiveCheckbox()) ? PageElementNames.CHECKED : UNCHECKED)
                .setSupplierInformationCreate(
                        getCheckboxValueOnRolePage(THIRD_PARTY_INFORMATION.getField(), CREATE))
                .setSupplierInformationEdit(getCheckboxValueOnRolePage(THIRD_PARTY_INFORMATION.getField(), EDIT))
                .setSupplierInformationDelete(
                        getCheckboxValueOnRolePage(THIRD_PARTY_INFORMATION.getField(), DELETE))
                .setSupplierInformationRead(getCheckboxValueOnRolePage(THIRD_PARTY_INFORMATION.getField(), READ))
                .setContactsCreate(getCheckboxValueOnRolePage(ASSOCIATED_PARTIES.getField(), CREATE))
                .setContactsEdit(getCheckboxValueOnRolePage(ASSOCIATED_PARTIES.getField(), EDIT))
                .setContactsDelete(getCheckboxValueOnRolePage(ASSOCIATED_PARTIES.getField(), DELETE))
                .setContactsRead(getCheckboxValueOnRolePage(ASSOCIATED_PARTIES.getField(), READ))
                .setContractsCreate(getCheckboxValueOnRolePage(CONTRACTS.getField(), CREATE))
                .setContractsEdit(getCheckboxValueOnRolePage(CONTRACTS.getField(), EDIT))
                .setContractsDelete(getCheckboxValueOnRolePage(CONTRACTS.getField(), DELETE))
                .setContractsRead(getCheckboxValueOnRolePage(CONTRACTS.getField(), READ))
                .setRelationshipCreate(getCheckboxValueOnRolePage(RELATIONSHIP.getField(), CREATE))
                .setRelationshipEdit(getCheckboxValueOnRolePage(RELATIONSHIP.getField(), EDIT))
                .setRelationshipDelete(getCheckboxValueOnRolePage(RELATIONSHIP.getField(), DELETE))
                .setRelationshipRead(getCheckboxValueOnRolePage(RELATIONSHIP.getField(), READ))
                .setActivitiesCreate(getCheckboxValueOnRolePage(ACTIVITIES.getField(), CREATE))
                .setActivitiesEdit(getCheckboxValueOnRolePage(ACTIVITIES.getField(), EDIT))
                .setActivitiesDelete(getCheckboxValueOnRolePage(ACTIVITIES.getField(), DELETE))
                .setActivitiesRead(getCheckboxValueOnRolePage(ACTIVITIES.getField(), READ))
                .setBankDetailsCreate(getCheckboxValueOnRolePage(BANK_DETAILS.getField(), CREATE))
                .setBankDetailsEdit(getCheckboxValueOnRolePage(BANK_DETAILS.getField(), EDIT))
                .setBankDetailsDelete(getCheckboxValueOnRolePage(BANK_DETAILS.getField(), DELETE))
                .setBankDetailsRead(getCheckboxValueOnRolePage(BANK_DETAILS.getField(), READ))
                .setConfigureOverallRiskYes(
                        getCheckboxValueOnRolePage(CONFIGURE_OVERALL_RISK.getField(), TOGGLE))
                .setExternalUserManagementYes(
                        getCheckboxValueOnRolePage(EXTERNAL_USER_MANAGEMENT.getField(), TOGGLE))
                .setOnboardingRenewalYes(getCheckboxValueOnRolePage(ONBOARDING_RENEWAL.getField(), TOGGLE))
                .setActivityReportYes(getCheckboxValueOnRolePage(ACTIVITY_ROLLBACK.getField(), TOGGLE))
                .setActivityRollbackYes(getCheckboxValueOnRolePage(ACTIVITY_ROLLBACK.getField(), TOGGLE))
                .setRelatedFilesAdd(getCheckboxValueOnRolePage(RELATED_FILES.getField(), ADD))
                .setRelatedFilesDownload(getCheckboxValueOnRolePage(RELATED_FILES.getField(), DOWNLOAD))
                .setRelatedFilesDelete(getCheckboxValueOnRolePage(RELATED_FILES.getField(), DELETE))
                .setThirdPartyStatusYes(getCheckboxValueOnRolePage(THIRD_PARTY_STATUS.getField(), TOGGLE))
                .setRiskReportYes(getCheckboxValueOnRolePage(RISK_REPORT.getField(), TOGGLE))
                .setDashboardYes(getCheckboxValueOnRolePage(DASHBOARD.getField(), TOGGLE))
                .setThirdPartyReportYes(getCheckboxValueOnRolePage(THIRD_PARTY_REPORT.getField(), TOGGLE))
                .setActivityReportYes(getCheckboxValueOnRolePage(ACTIVITY_REPORT.getField(), TOGGLE))
                .setQuestionnaireReportYes(getCheckboxValueOnRolePage(QUESTIONNAIRE_REPORT.getField(), TOGGLE))
                .setDueDiligenceOrderReportYes(
                        getCheckboxValueOnRolePage(DUE_DILIGENCE_ORDER_REPORT.getField(), TOGGLE))
                .setWorkflowReportYes(getCheckboxValueOnRolePage(WORKFLOW_REPORT.getField(), TOGGLE))
                .setUserManagementYes(getCheckboxValueOnRolePage(USER_MANAGEMENT.getField(), TOGGLE))
                .setMyOrganisationYes(getCheckboxValueOnRolePage(MY_ORGANISATION.getField(), TOGGLE))
                .setQuestionnaireManagementYes(
                        getCheckboxValueOnRolePage(QUESTIONNAIRE_MANAGEMENT.getField(), TOGGLE))
                .setWorkflowManagementYes(getCheckboxValueOnRolePage(WORKFLOW_MANAGEMENT.getField(), TOGGLE))
                .setScreeningManagement(getCheckboxValueOnRolePage(SCREENING_MANAGEMENT.getField(), TOGGLE))
                .setApprovalProcessYes(getCheckboxValueOnRolePage(APPROVAL_PROCESS.getField(), TOGGLE))
                .setReviewProcessYes(getCheckboxValueOnRolePage(REVIEW_PROCESS.getField(), TOGGLE))
                .setFieldsManagementYes(getCheckboxValueOnRolePage(FIELDS_MANAGEMENT.getField(), TOGGLE))
                .setCountryChecklistYes(getCheckboxValueOnRolePage(COUNTRY_CHECKLIST.getField(), TOGGLE))
                .setValueManagementYes(getCheckboxValueOnRolePage(VALUE_MANAGEMENT.getField(), TOGGLE))
                .setEmailManagementYes(getCheckboxValueOnRolePage(EMAIL_MANAGEMENT.getField(), TOGGLE))
                .setDueDiligenceOrderManagementYes(
                        getCheckboxValueOnRolePage(USER_MANAGEMENT.getField(), TOGGLE))
                .setAnnouncementBanner(getCheckboxValueOnRolePage(ANNOUNCEMENT_BANNER.getField(), TOGGLE))
                .setOrderReportCreate(getCheckboxValueOnRolePage(ORDER_REPORT.getField(), CREATE))
                .setOrderReportEdit(getCheckboxValueOnRolePage(ORDER_REPORT.getField(), EDIT))
                .setOrderReportRead(getCheckboxValueOnRolePage(ORDER_REPORT.getField(), READ))
                .setOrderReportDecline(getCheckboxValueOnRolePage(ORDER_REPORT.getField(), DECLINE))
                .setOrderReportApprove(getCheckboxValueOnRolePage(ORDER_REPORT.getField(), APPROVE))
                .setEnableScreeningYes(getCheckboxValueOnRolePage(ENABLE_SCREENING.getField(), TOGGLE))
                .setManageResolutionTypeYes(
                        getCheckboxValueOnRolePage(MANAGE_RESOLUTION_TYPE.getField(), TOGGLE))
                .setOngoingScreeningYes(getCheckboxValueOnRolePage(ONGOING_SCREENING.getField(), TOGGLE))
                .setChangeSearchCriteriaYes(
                        getCheckboxValueOnRolePage(UserRoleFields.CHANGE_SEARCH_CRITERIA.getField(), TOGGLE))
                .setBitSightSearch(getCheckboxValueOnRolePage(BIT_SIGHT_SEARCH.getField(), TOGGLE))
                .setBulkProcessing(getCheckboxValueOnRolePage(BULK_PROCESSING.getField(), TOGGLE))
                .setBusinessOverviewSearch(getCheckboxValueOnRolePage(BUSINESS_OVERVIEW_SEARCH.getField(), TOGGLE));
    }

    public List<UserRoleData> getRolesList() {
        return IntStream.rangeClosed(1, driver.findElements(userRoleTablePO.getTableRow()).size())
                .mapToObj(this::getRoleRowDetails).collect(Collectors.toList());
    }

    public List<String> getRolesListValuesForColumn(String columnName) {
        return IntStream.rangeClosed(1, driver.findElements(userRoleTablePO.getTableRow()).size())
                .mapToObj(i -> getRoleRowValue(i, columnName)).collect(Collectors.toList());
    }

    public UserRoleData getRoleRowDetails(int roleNo) {
        return new UserRoleData().setName(getRoleRowValue(roleNo, UserRoleFields.NAME.getField().toUpperCase()))
                .setActive(getRoleRowValue(roleNo, UserRoleFields.STATUS.getField().toUpperCase()));
    }

    private String getRoleRowValue(int roleNo, String columnName) {
        List<String> headers = getElementsText(userRoleTablePO.getTableColumnHeader());
        int columnNameIndex = headers.indexOf(columnName.toUpperCase()) + 2;
        String text = getElementText(xpath(format(userRoleTablePO.getRoleTableRowValue(), roleNo, columnNameIndex)));
        return StringUtils.isNullOrEmpty(text) ? null : text;
    }

    public List<UserRoleData> getAllRolesList() {
        List<UserRoleData> userRoleDataList = new ArrayList<>();
        if (!paginationPage.isNextPageButtonActive()) {
            userRoleDataList.addAll(getRolesList());
            return userRoleDataList;
        }
        paginationPage.selectMaxRowsPerPage();
        waitWhilePreloadProgressbarIsDisappeared();
        userRoleDataList.addAll(getRolesList());
        while (paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButton();
            waitWhilePreloadProgressbarIsDisappeared();
            userRoleDataList.addAll(getRolesList());
        }
        return userRoleDataList;
    }

    public List<String> getColumnNames() {
        return getElementsNonBlankTexts(userRoleTablePO.getTableColumnHeader());
    }

    public List<String> getRoleSections() {
        return getElementsText(userRolePO.getFormPageSections());
    }

    public boolean isCheckboxEditable(String checkboxLocator, String fieldName) {
        return !Boolean.parseBoolean(getAttributeValue(xpath(format(checkboxLocator, fieldName)), ARIA_DISABLED));
    }

    public boolean isRoleResultsFilteredByKeyword(String keyWord) {
        List<WebElement> allRolesName = driver.findElements(userRoleTablePO.getTableRowsNameValues());
        return allRolesName.stream().allMatch(role -> role.getText().toLowerCase().contains(keyWord.toLowerCase()));
    }

    public boolean isRoleDisplayedOnTable(String roleName) {
        List<WebElement> rows = driver.findElements(userRoleTablePO.getTableRow());
        for (int row = 0; row < rows.size(); row++) {
            WebElement createdRoleRow = rows.get(row).findElements(userRoleTablePO.getTableRowsNameValues()).get(row);
            if (createdRoleRow.getText().equals(roleName)) {
                return true;
            }
        }
        return false;
    }

    public boolean isRoleFirstInTable(String roleName) {
        List<WebElement> rows = driver.findElements(userRoleTablePO.getTableRow());
        return rows.get(0).findElement(userRoleTablePO.getTableRowsNameValues()).getText().equals(roleName);
    }

    public boolean isDeleteButtonDisplayedOnTable(String roleName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(userRoleTablePO.getDeleteRoleButton(), roleName)));
    }

    public boolean isEditButtonDisplayedOnTable(String roleName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(userRoleTablePO.getEditRoleButton(), roleName)));
    }

    public boolean isCheckboxDisplayedOnTable(String roleName) {
        return isElementDisplayed(waitMoment,
                                  xpath(format(userRoleTablePO.getRoleCheckbox(), roleName)));
    }

    public boolean isCheckboxDisabledOnTable(String roleName) {
        return isElementAttributeContains(xpath(format(userRoleTablePO.getRoleCheckbox(), roleName)), CLASS, DISABLED);
    }

    public boolean isAddNewRoleButtonVisible() {
        return isElementDisplayed(waitShort, userRoleTablePO.getAddNewRoleButton());
    }

    public boolean isEditButtonDisplayedOnForm() {
        return isElementDisplayed(waitMoment, userRolePO.getEditFormButton());
    }

    public boolean isActiveCheckboxChecked() {
        return isReactCheckboxChecked(userRolePO.getActiveCheckbox());
    }

    public boolean isToggleButtonSwitchedOn(String fieldName) {
        return isReactCheckboxChecked(xpath(format(userRolePO.getToggleButton(), fieldName)));
    }

    public String getRoleManagementHeader() {
        return getElementText(userRoleTablePO.getRoleManagementHeader());
    }

    public boolean isRoleCheckboxChecked(String roleName) {
        By roleCheckbox = xpath(format(userRoleTablePO.getRoleCheckbox(), roleName));
        return isReactCheckboxChecked(roleCheckbox);
    }

    public boolean isRoleCheckboxEnabled(String roleName) {
        By roleCheckbox = xpath(format(userRoleTablePO.getRoleCheckbox(), roleName));
        return isReactFieldEnabled(roleCheckbox);
    }

    public void hoverOverRoleCheckbox(String roleName) {
        By roleCheckbox = xpath(format(userRoleTablePO.getRoleCheckbox(), roleName));
        hoverOverElement(roleCheckbox);
    }

    public void hoverOverRoleDeleteButton(String roleName) {
        By deleteButton = xpath(format(userRoleTablePO.getDeleteRoleButton(), roleName));
        hoverOverElement(deleteButton);
    }

    public String getDeleteButtonColor(String roleName) {
        By deleteButton = xpath(format(userRoleTablePO.getDeleteRoleButton(), roleName));
        return getCssValue(deleteButton, COLOR);
    }

    public boolean isSubmitRoleButtonDisplayed() {
        return isElementDisplayed(userRolePO.getSubmitFormButton());
    }

    public boolean isCancelRoleButtonDisplayed() {
        return isElementDisplayed(userRolePO.getCancelFormButton());
    }

    public boolean isSectionExpanded(String section) {
        return Boolean.parseBoolean(
                getAttributeValue(xpath(format(userRolePO.getSectionButton(), section)), ARIA_EXPANDED));
    }

    public void clickCollapseExpandSection(String section) {
        clickOn(xpath(format(userRolePO.getSectionButton(), section)));
    }

    public boolean isAccessRightPresent(String rightName) {
        return isElementDisplayed(waitMoment, xpath(format(userRolePO.getRightWithName(), rightName)));
    }

}