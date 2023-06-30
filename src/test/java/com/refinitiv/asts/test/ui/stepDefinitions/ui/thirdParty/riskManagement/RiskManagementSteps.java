package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.riskManagement;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.AppApi;
import com.refinitiv.asts.test.ui.api.DashboardApi;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.riskManagement.AdHocActivity;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.RiskManagementPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ActivityInformationDisplayPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.*;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.AssertionsForClassTypes;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.RiskManagementPage.ATTACHMENT;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.RiskManagementPage.DESCRIPTION;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.RiskManagementPage.NAME;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.riskManagement.RiskManagementPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.Integer.parseInt;
import static java.lang.String.format;
import static java.util.Arrays.asList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.Assert.assertTrue;

public class RiskManagementSteps extends BaseSteps {

    private String activityName;

    private final RiskManagementPage riskManagementPage;

    public RiskManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.riskManagementPage = new RiskManagementPage(this.driver, this.context, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public RiskManagementItemData riskManagementItem(Map<String, String> entry) {
        return new RiskManagementItemData().setName(entry.get(NAME))
                .setStatus(entry.get(STATUS))
                .setOverallRiskScore(entry.get(OVERALL_RISK_SCORE))
                .setInitiatedBy(entry.get(INITIATED_BY))
                .setStartDate(updateDate(entry.get(START_DATE)))
                .setLastUpdate(updateDate(entry.get(LAST_UPDATE)));
    }

    @DataTableType
    @SuppressWarnings("unused")
    public RiskRemediationMediaCheckData riskRemediationMediaCheckTable(Map<String, String> entry) {
        return new RiskRemediationMediaCheckData().setSource(entry.get(SOURCE))
                .setSearchTerm(entry.get(SEARCH_TERM))
                .setTagAsRedFlagRecord(entry.get(TAG_AS_RED_FLAG_RECORD))
                .setRedFlagDate(entry.get(RED_FLAG_DATE));
    }

    @DataTableType
    @SuppressWarnings("unused")
    public RiskRemediationWorldCheckData riskRemediationWorldCheckTable(Map<String, String> entry) {
        return new RiskRemediationWorldCheckData().setSource(entry.get(SOURCE))
                .setSearchTerm(entry.get(SEARCH_TERM))
                .setTagAsRedFlagRecord(entry.get(TAG_AS_RED_FLAG_RECORD))
                .setReferenceId(entry.get(RiskManagementPage.REFERENCE_ID))
                .setRedFlagDate(entry.get(RED_FLAG_DATE));
    }

    @DataTableType
    @SuppressWarnings("unused")
    public RiskRemediationQuestionnaireData riskRemediationQuestionnaireTable(Map<String, String> entry) {
        return new RiskRemediationQuestionnaireData().setQuestionnaireName(entry.get(QUESTIONNAIRE_NAME))
                .setQuestion(entry.get(QUESTION))
                .setAnswer(entry.get(ANSWER))
                .setAttachment(entry.get(ATTACHMENT))
                .setAssignee(entry.get(ASSIGNEE))
                .setDateSubmitted(entry.get(DATE_SUBMITTED));
    }

    @DataTableType
    @SuppressWarnings("unused")
    public RiskRemediationCustomFieldsData riskRemediationCustomFieldsTable(Map<String, String> entry) {
        return new RiskRemediationCustomFieldsData().setCustomField(entry.get(CUSTOM_FIELD))
                .setValue(entry.get(RiskManagementPage.VALUE));
    }

    @DataTableType
    @SuppressWarnings("unused")
    public WorkflowActivityTableData activityTableEntry(Map<String, String> entry) {
        return new WorkflowActivityTableData()
                .setName(entry.get(NAME))
                .setStatus(entry.get(STATUS))
                .setFinalAssessment(entry.get(FINAL_ASSESSMENT))
                .setOverallRiskScore(entry.get(OVERALL_RISK_SCORE))
                .setInitiatedBy(entry.get(INITIATED_BY))
                .setStartDate(updateTodayDate(entry.get(START_DATE)))
                .setLastUpdate(updateTodayDate(entry.get(LAST_UPDATE)));
    }

    private String updateTodayDate(String date) {
        return nonNull(date) ? getTodayDate(REACT_FORMAT) : null;
    }

    private String getTagAsRedFlagRecord(String tagAsRedFlagRecordReference) {
        return context.getScenarioContext().isContains(tagAsRedFlagRecordReference) ?
                (String) context.getScenarioContext().getContext(tagAsRedFlagRecordReference) :
                tagAsRedFlagRecordReference;
    }

    private String updateDate(String date) {
        if (nonNull(date)) {
            return getDateAfterTodayDate(REACT_FORMAT, parseInt(date.replace(TODAY, StringUtils.EMPTY)));
        }
        return null;
    }

    @When("User opens previously created Ad-Hoc Acvtivity")
    public void openPreviouslyCreatedAdHocActivity() {
        riskManagementPage.openCreatedAdHocActivity();
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared(5);
    }

    @When("User clicks on Risk Management tab")
    public void clickOnRiskManagementTab() {
        riskManagementPage.clickOnRiskManagementTab();
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(riskManagementPage.isRiskManagementTabSelected())
                .as("Risk management tab is not selected")
                .isTrue();
    }

    @When("User clicks Third-Party Risk Management {string} button")
    public void clickOnButtonWithName(String buttonName) {
        if (buttonName.equals(CANCEL)) {
            riskManagementPage.clickRiskManagementCancelButton();
        } else {
            riskManagementPage.clickOnButtonWithName(buttonName);
        }
    }

    @When("User fills in {string} drop-down with {string}")
    public void fillInDropDown(String dropDownName, String value) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (context.getScenarioContext().isContains(value)) {
            Object contextValue = context.getScenarioContext().getContext(value);
            value = contextValue instanceof String ? (String) contextValue : ((UserData) contextValue).getFirstName();
        }
        riskManagementPage.fillInDropDown(dropDownName, value);
    }

    @When("User clears value for dropdown {string}")
    public void clearDropDownValue(String dropDownName) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        riskManagementPage.clearDropDown(dropDownName);
    }

    @When("^User opens (?:World-Check|Media-Check?) Screening records link \"(.*)\"?")
    public void openWorldCheckScreeningRecordLink(String record) {
        String link = (String) context.getScenarioContext().getContext(record);
        driver.get(link);
    }

    @Then("{string} dropdown contains all Internal Active users")
    public void checkDropdownContainsActiveUsers(String dropdownName) {
        List<String> allActiveUsers = AppApi.getAllActiveInternalUsers("%s %s (%s)");
        riskManagementPage.clickDropdown(dropdownName);
        List<String> usersInDropDown = riskManagementPage.getDropDownOptions().stream()
                .filter(option -> !option.equals(DROPDOWN_PLACEHOLDER))
                .map(getAllActiveUsersWithParentheses())
                .collect(Collectors.toList());
        assertThat(allActiveUsers)
                .as("Drop-down doesn't contain all active users!")
                .containsAll(usersInDropDown);
        riskManagementPage.clickDropdown(dropdownName);
    }

    @Then("^\"(.*)\" dropdown (displayed|not displayed) on Activity Information page on Risk Management tab$")
    public void checkDropdownIsDisplayedOnAddActivityPage(String dropdownName, String state) {
        if (state.contains(NOT)) {
            assertThat(riskManagementPage.isDropdownDisplayed(dropdownName))
                    .as("Dropdown %s is displayed on Activity Information page on Risk Management tab")
                    .isFalse();
        } else {
            assertThat(riskManagementPage.isDropdownDisplayed(dropdownName))
                    .as("Dropdown %s is not displayed on Activity Information page on Risk Management tab")
                    .isTrue();
        }

    }

    @When("User fills in Assignee drop-down with {string}")
    public void fillInAssigneeDropDown(String value) {
        if (context.getScenarioContext().isContains(value)) {
            Object contextValue = context.getScenarioContext().getContext(value);
            value = contextValue instanceof String ? (String) contextValue : ((UserData) contextValue).getFirstName();
        }
        riskManagementPage.fillInDropDown(ActivityInformationDisplayPage.ASSIGNEE, value);
    }

    @When("User fills in {string} field with {string}")
    public void fillInActivityNameField(String fieldName, String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
        }
        switch (fieldName) {
            case ACTIVITY_NAME:
                riskManagementPage.fillInActivityNameField(value);
                context.getScenarioContext().setContext(AD_HOC_ACTIVITY_CONTEXT_NAME, value);
                break;
            case DESCRIPTION:
                riskManagementPage.fillInDescriptionField(value);
                break;
            default:
                throw new IllegalArgumentException("Activity Field Name: " + fieldName + " is unexpected!");
        }
    }

    @When("User selects {string} date for Due Date field")
    public void selectDueDate(String dueDate) {
        riskManagementPage.openDueDateDateSelection();
        riskManagementPage.selectDueDate(parseInt(dueDate.replace(TODAY, StringUtils.EMPTY)));
    }

    @When("User clicks on added Ad Hoc Activity in Ad Hoc Activity table")
    public void clickOnAddedActivity() {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        riskManagementPage.closeAlertIconIfDisplayed();
        activityName = (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME);
        riskManagementPage.clickOnActivityRowWithName(activityName);
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("^User clicks on (Delete|Edit) button for Ad Hoc Activity with name \"(.*)\" in Ad Hoc Activity table$")
    public void clickOnActionButtonForAdHocActivityWithNameInAdHocActivityTable(String actionIcon,
            String activityName) {
        if (context.getScenarioContext().isContains(activityName)) {
            activityName = (String) context.getScenarioContext().getContext(activityName);
        }
        riskManagementPage.clickOnActionButtonActivityRowWithName(activityName, actionIcon);
    }

    @When("User clicks on the newly created Ad Hoc Activity with name {string}")
    public void clickOnTheNewlyCreatedAdHocActivityWithName(String activityName) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        riskManagementPage.clickOnAdHocActivityName(activityName);
    }

    @When("User clicks Reviewers edit button for user {string}")
    public void clickReviewersEditButtonForUser(String reviewerName) {
        riskManagementPage.clickEditReviewer(reviewerName);
    }

    @When("User clicks Reviewers delete button for user {string}")
    public void clickReviewersDeleteButtonForUser(String reviewerName) {
        riskManagementPage.clickDeleteReviewer(reviewerName);
    }

    @When("^User clicks Reviewers edit mode (Cancel|Done) button$")
    public void clickReviewersEditModeButton(String buttonName) {
        riskManagementPage.clickReviewerEditModeButton(buttonName);
    }

    @When("^User clicks (Done|Cancel) button in Activity Reviewers section$")
    public void clickOnReviewerAddButton(String button) {
        if (button.equals(DONE)) {
            riskManagementPage.clickOnDoneReviewerButton();
        } else {
            riskManagementPage.clickOnCancelReviewerButton();
        }

    }

    @When("User clicks Ad Hoc Activity Save button")
    public void clickOnAddButtonInSection() {
        riskManagementPage.clickOnAdHocActivitySaveButton();
    }

    @When("User clears Activity Information fields")
    public void clearActivityInformationFields(List<String> fieldsList) {
        fieldsList.forEach(riskManagementPage::clearField);
    }

    @When("User clicks workflow with name {string} and status {string} on Risk Management tab")
    public void isWorkflowDisplayedWithDetails(String name, String status) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (name.equals(VALUE_TO_REPLACE)) {
            name = (String) this.context.getScenarioContext().getContext(WORKFLOW_NAME_CONTEXT);
        }
        riskManagementPage.clickOnWorkflow(name, status);
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks {string} button for Risk Management Ad Hoc activity row with name {string}")
    public void clickButtonForAdHocActivityRow(String buttonName, String rowName) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        riskManagementPage.clickOnAdHocRowButton(buttonName, rowName);
    }

    @When("User clicks Risk Remediation {string} tab")
    public void clickRiskRemediationTab(String tabName) {
        riskManagementPage.clickRiskRemediationTab(tabName);
    }

    @When("User clicks Risk Remediation Media check {string} column")
    public void clickRiskRemediationMediaCheckColumn(String columnName) {
        riskManagementPage.clickRiskRemediationMediaCheckColumn(columnName);
    }

    @When("User clicks Risk Remediation World-Check {string} column")
    public void clickRiskRemediationWorldCheckColumn(String columnName) {
        riskManagementPage.clickRiskRemediationWorldCheckColumn(columnName);
    }

    @When("User clicks Risk Remediation Custom Fields {string} column")
    public void clickRiskRemediationCustomFieldsColumn(String columnName) {
        riskManagementPage.clickRiskRemediationCustomFieldsColumn(columnName);
    }

    @When("User clicks on Media Check Risk Remediation record {string}")
    public void clickMediaCheckRiskRemediationRecord(String record) {
        riskManagementPage.clickMediaCheckRiskRemediationRecord(getTagAsRedFlagRecord(record));
        context.getScenarioContext().setContext(SELECTED_RECORD_NAME, getTagAsRedFlagRecord(record));
    }

    @SuppressWarnings("unchecked")
    @When("User clicks on World-Check Risk Remediation record {string}")
    public void clickWorldCheckRiskRemediationRecord(String record) {
        if (record.contains(REFERENCE)) {
            Map<String, String> selectedScreeningResults =
                    (Map<String, String>) context.getScenarioContext().getContext(SCREENING_SELECTED_RESULTS_CONTEXT);
            record = selectedScreeningResults.get(record);
        }
        riskManagementPage.clickWorldCheckRiskRemediationRecord(getTagAsRedFlagRecord(record));
    }

    @When("^User saves (?:World-Check|Media-Check?) Risk Remediation record \"(.*)\" URL in context$")
    public void saveAdHocActivityIdFromURLInContext(String record) {
        String currentUrl = driver.getCurrentUrl();
        context.getScenarioContext().setContext(record, currentUrl);
    }

    @When("User clicks on Custom Fields Risk Remediation record {string}")
    public void clickCustomFieldsRiskRemediationRecord(String record) {
        String customFieldIndex = record.substring(21);
        record = (String) context.getScenarioContext()
                .getContext(CUSTOM_FIELD_NAME_NUMBER_CONTEXT + customFieldIndex);
        riskManagementPage.clickCustomFieldsRiskRemediationRecord(record);
    }

    @When("User retrieves Media Check article id for record {string}")
    public void getArticleId(String record) {
        String thirdPartyId = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String articleId = DashboardApi.getMediaCheckArticleId(thirdPartyId, getTagAsRedFlagRecord(record));
        String articleIdWithUTFEncode = articleId.replace(VERTICAL_BAR, UTF_VERTICAL_BAR);
        context.getScenarioContext().setContext(ARTICLE_ID, articleIdWithUTFEncode);
    }

    @When("User clicks Media Check Risk Remediation back button")
    public void clickBackButton() {
        riskManagementPage.clickMediaCheckDetailsBackButton();
    }

    @When("User clicks Risk Remediation breadcrumb")
    public void clickBreadcrumb() {
        riskManagementPage.clickRiskRemediationBreadcrumb();
    }

    @When("User clicks {string} breadcrumb Back icon")
    public void clickBreadcrumbBackIcon(String section) {
        riskManagementPage.clickRiskRemediationBreadcrumbBackIcon(section);
    }

    @When("User clicks Questionnaire Risk Remediation {string} column")
    public void clickQuestionnaireRiskRemediationColumn(String columnName) {
        riskManagementPage.clickQuestionnaireRiskRemediationColumn(columnName);
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on Questionnaire Risk Remediation record {string}")
    public void clickQuestionnaireRiskRemediationRecord(String record) {
        riskManagementPage.clickQuestionnaireRiskRemediationRecord(record);
    }

    @When("User adds Ad Hoc activity with Activity Type {string}, assignee {string}, status {string} via API")
    public void addAdHocActivityWithActivityTypeAndStatusViaAPI(String activityType, String assignee, String status) {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        UserData userData = getUserCredentialsByRole(assignee);
        AdHocActivity activity = AdHocActivity.defaultValues();
        AdHocActivity.Assignee assigneeUser = new AdHocActivity.Assignee()
                .setEmail(userData.getUsername())
                .setName(String.format("%s %s", userData.getFirstName(), userData.getLastName()));
        activity.setAssignee(assigneeUser).setStatus(status).getActivityType().setName(activityType);
        WorkflowApi.createAdHocActivityForThirdParty(thirdPartyId, activity);
        context.getScenarioContext().setContext(AD_HOC_ACTIVITY_CONTEXT_NAME, activity.getName());
    }

    @Then("Workflow table is displayed with the next headers and details for the triggered workflow")
    public void isWorkflowDisplayedWithDetails(List<WorkflowActivityTableData> expectedData) {
        SoftAssertions softAssert = new SoftAssertions();
        softAssert.assertThat(riskManagementPage.getWorkflowTableHeaders())
                .as("Workflow Table headers are unexpected")
                .isEqualTo(asList(NAME, STATUS, FINAL_ASSESSMENT, OVERALL_RISK_SCORE, INITIATED_BY, START_DATE,
                                  LAST_UPDATE));
        softAssert.assertThat(riskManagementPage.getWorkflowActivityTableRows())
                .as("Workflow Table data is unexpected")
                .containsAll(expectedData);
        softAssert.assertAll();
    }

    @Then("Ad Hoc Activity {string} modal is displayed")
    public void isModalWithNameDisplayed(String modalName) {
        assertThat(riskManagementPage.isActivityPageWithNameDisplayed(modalName)).as(
                        "Add Activity modal is not displayed!")
                .isTrue();
    }

    @Then("Ad Hoc Activity {string} modal is not displayed")
    public void isAddActivityModalNotDisplayed(String modalName) {
        assertThat(riskManagementPage.isActivityPageWithNameDisplayed(modalName)).as("Add Activity modal is displayed!")
                .isFalse();
    }

    @Then("^Risk Management \"((.*))\" button is displayed$")
    public void isButtonWithNameDisplayed(String buttonName) {
        assertThat(riskManagementPage.isButtonWithNameDisplayed(buttonName))
                .as(buttonName + " button is not displayed!").isTrue();
    }

    @Then("^Next (?:Add|Edit?) Activity modal (?:text input field\\(s\\)|drop-down\\(s\\)?) is\\(are\\) required$")
    public void isDropDownRequired(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> {
            softAssert.assertTrue(riskManagementPage.isFieldRequired(name), name + " field is not required!");
            softAssert.assertTrue(riskManagementPage.isRedAsteriskDisplayed(name),
                                  name + " field is not marked with red asterisk!");
            softAssert.assertAll();
        });
    }

    @Then("Error message 'This field is required' is displayed for the next fields")
    public void isErrorMessageDisplayed(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> {
            softAssert.assertTrue(riskManagementPage.isErrorMessageDisplayed(name),
                                  name + " field 'This field is required' error message field is not displayed!");
            softAssert.assertTrue(riskManagementPage.doesFieldHaveErrorAttribute(name),
                                  name + " field is not marked with error border!");
        });
        softAssert.assertAll();
    }

    @Then("Risk Management {string} table shows {string} message")
    public void isAvailableDataMessageDisplayed(String section, String message) {
        assertThat(riskManagementPage.getEmptyTableText(section))
                .as("Risk Management %s table does not show %s message!", section, message).isEqualTo(message);
    }

    @Then("Added Ad Hoc Activity is displayed in Ad Hoc Activity table")
    public void isAddedAdHocActivityDisplayed() {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        activityName = (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME);
        assertThat(riskManagementPage.isAdHocActivityDisplayed(activityName))
                .as("Added Ad Hoc Activity is not displayed!").isTrue();
    }

    @Then("Added Ad Hoc Activity is displayed in Ad Hoc Activity table with status {string}")
    public void isAddedAdHocActivityWithStatusDisplayed(String status) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        activityName = (String) context.getScenarioContext().getContext(AD_HOC_ACTIVITY_CONTEXT_NAME);
        assertThat(riskManagementPage.isAdHocActivityWithStatusDisplayed(activityName, status))
                .as("Added Ad Hoc Activity is not displayed!").isTrue();
    }

    @Then("Reviewers Table is not displayed")
    public void isReviewersTableDisplayed() {
        assertThat(riskManagementPage.isReviewersTableDisplayed()).as("Reviewers Table is displayed!")
                .isFalse();
    }

    @Then("Assigned Reviewer {string} is displayed in Reviewers table")
    public void isReviewerDisplayedInReviewersTable(String reviewerName) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(riskManagementPage.getReviewerName())
                .as("Reviewer is not expected!").isEqualTo(reviewerName);
    }

    @Then("Ad Hoc Activities table contains the following columns")
    public void adHocActivitiesTableContainsTheFollowingColumns(List<String> expectedColumns) {
        assertThat(riskManagementPage.getActivityTableColumns())
                .as("Ad Hoc Activities table columns are unexpected").isEqualTo(expectedColumns);
    }

    @Then("Ad Hoc Activity Information modal fields should be in correct state")
    public void adHocActivityInformationModalFieldsShouldBeInCorrectState(DataTable table) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions soft = new SoftAssertions();
        table.asMap(String.class, String.class).forEach((field, attribute) -> {
            boolean isFieldEnabled = riskManagementPage.isFieldEnabled((String) field);
            if (attribute.equals(DISABLED)) {
                soft.assertThat(isFieldEnabled).as(field + " is enabled").isFalse();
            } else {
                soft.assertThat(isFieldEnabled).as(field + " is disabled").isTrue();
            }
        });
        soft.assertAll();
    }

    @Then("Ad Hoc Activity table sorted by {string} field in {string} order")
    public void adHocActivityTableSortedByField(String columnName, String sortOrder) {
        List<String> valuesList = riskManagementPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("Ad Hoc Activity", columnName, sortOrder, REACT_FORMAT, valuesList, false);
    }

    @Then("Risk Management page is displayed")
    public void riskManagementPageIsDisplayed() {
        assertTrue(riskManagementPage.isPageLoaded(), "Risk Management page is not displayed");
    }

    @Then("Ad Hoc Activity with name {string} is created")
    public void adHocActivityWithNameIsCreated(String activityName) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue(riskManagementPage.isAdHocActivityDisplayed(activityName),
                   "Ad Hoc Activity with Name " + activityName + " is not displayed");
    }

    @Then("Risk Management Ad Hoc table is displayed with the next details")
    public void riskManagementAdHocTableIsDisplayedWithTheNextDetails(List<RiskManagementItemData> expectedResult) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(riskManagementPage.getAdHocActivityTableRows())
                .as("Ad Hoc table is unexpected")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedResult);
    }

    @Then("^Risk Management Ad Hoc activity with name \"(.*)\" has icon (Edit|Delete)$")
    public void checkTableActivityHasEditDeleteIcons(String activityName, String iconName) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(riskManagementPage.checkTableActivityHasEditDeleteIcons(activityName, iconName))
                .as("Icon %s is not displayed", iconName)
                .isTrue();
    }

    @Then("^Risk Management Ad Hoc activity \"(.*)\" icon (Edit|Delete) is (displayed|hidden)$")
    public void checkTableActivityIconIsHidden(String activityName, String iconName, String buttonState) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        boolean isDisplayed = buttonState.equalsIgnoreCase(DISPLAYED);
        if (context.getScenarioContext().isContains(activityName)) {
            activityName = (String) context.getScenarioContext().getContext(activityName);
        }
        assertThat(riskManagementPage.isActivityIconDisplayed(activityName, iconName))
                .as("Icon %s is not %s", iconName, buttonState)
                .isEqualTo(isDisplayed);
    }

    @Then("Risk Management Ad Hoc table contains the next details")
    public void riskManagementAdHocTableContainsWithTheNextDetails(List<RiskManagementItemData> expectedResult) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(riskManagementPage.getAdHocActivityTableRows())
                .as("Ad Hoc table is unexpected")
                .containsAll(expectedResult);
    }

    @Then("Risk Management Ad Hoc Activity has correct URL")
    public void checkRiskManagementAdHocActivityHasCorrectURL() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        String adhocActivityId = (String) context.getScenarioContext().getContext(ACTIVITY_ID);
        String expectedUrl =
                URL + Pages.THIRD_PARTY + SLASH + thirdPartyId + format(Pages.AD_HOC_ACTIVITY, adhocActivityId);
        assertThat(driver.getCurrentUrl().replaceAll(HTTPS, HTTP))
                .as("Ad Hoc activity URL is incorrect")
                .isEqualTo(expectedUrl);
    }

    @Then("^Risk Management Ad Hoc table \"((.*))\" button (displayed|disabled) for each row$")
    public void riskManagementAdHocTableButtonDisplayed(String buttonName, String buttonState) {
        if (buttonState.equalsIgnoreCase(DISPLAYED)) {
            assertThat(riskManagementPage.areAdHocActivityButtonsDisplayed(buttonName))
                    .as("Ad Hoc table {string} button is not displayed")
                    .isTrue();
        } else {
            assertThat(riskManagementPage.areAdHocActivityButtonsEnabled(buttonName))
                    .as("Ad Hoc table {string} button is not disabled")
                    .isFalse();
        }

    }

    @Then("Ad Hoc Activity Information fields should have correct state")
    public void activityInformationStatusFieldShouldBeNotEditable(DataTable fields) {
        SoftAssertions soft = new SoftAssertions();
        fields.asMap(String.class, String.class)
                .forEach((field, state) -> {
                    if (state.equals(DISABLED)) {
                        soft.assertThat(
                                        riskManagementPage.isAdhocActivityFieldEnabled((String) field))
                                .as(field + " is enabled")
                                .isFalse();
                    } else {
                        soft.assertThat(riskManagementPage.isAdhocActivityFieldEnabled((String) field))
                                .as(field + " is disabled")
                                .isTrue();
                    }
                });
        soft.assertAll();
    }

    @Then("Risk Remediation Media Check table is displayed with columns")
    public void areRiskRemediationMediaCheckTableColumnsDisplayed(List<String> expectedColumns) {
        List<String> actualColumns = riskManagementPage.getRiskRemediationMediaCheckTableColumns();
        assertThat(actualColumns).as("Expected Risk Remediation columns are not displayed!").isEqualTo(expectedColumns);
    }

    @Then("Risk Management Risk Remediation section has tabs")
    public void areRiskRemediationTabsCorrect(List<String> expectedTabs) {
        List<String> actualTabs = riskManagementPage.getRiskRemediationTabs();
        assertThat(actualTabs).as("Risk Remediation tabs are incorrect").isEqualTo(expectedTabs);
    }

    @Then("^Risk Management (?:Risk Remediation|Questionnaire?) section message \"((.*))\" is displayed if table is empty$")
    public void riskRemediationMessageIsDisplayedIfTableIsEmpty(String expectedMessage) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (riskManagementPage.getRowsCount() == 0) {
            assertThat(riskManagementPage.getEmptyTableMessage())
                    .as("Empty table message is unexpected")
                    .isEqualTo(expectedMessage);
        } else {
            assertThat(riskManagementPage.isEmptyTableMessageDisplayed())
                    .as("Empty table message is displayed")
                    .isFalse();
        }
    }

    @Then("^Risk Management sections are (not displayed|displayed)$")
    public void areRiskManagementSectionsDisplayed(String state, List<String> riskManagementSections) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions soft = new SoftAssertions();
        riskManagementSections.forEach(section -> {
            boolean isSectionDisplayed = riskManagementPage.isRiskManagementSectionDisplayed(section);
            if (state.contains(NOT)) {
                soft.assertThat(isSectionDisplayed)
                        .as("Risk Management section '%s' is displayed", section)
                        .isFalse();
            } else {
                soft.assertThat(isSectionDisplayed)
                        .as("Risk Management section '%s' is mot displayed", section)
                        .isTrue();
            }
        });
        soft.assertAll();
    }

    @Then("^Risk Management \"((.*))\" section (is|is not) expanded$")
    public void isRiskManagementSectionExpanded(String riskManagementSection, String state) {
        riskManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        boolean isSectionExpanded = riskManagementPage.isRiskManagementSectionExpanded(riskManagementSection);
        if (state.contains(NOT)) {
            assertThat(isSectionExpanded)
                    .as("Risk Management section '%s' is expanded", riskManagementSection)
                    .isFalse();
        } else {
            assertThat(isSectionExpanded)
                    .as("Risk Management section '%s' is mot expanded", riskManagementSection)
                    .isTrue();
        }
    }

    @Then("Risk Remediation World Check table is displayed with columns")
    public void areRiskRemediationWorldCheckTableColumnsDisplayed(List<String> expectedColumns) {
        List<String> actualColumns = riskManagementPage.getRiskRemediationWorldCheckTableColumns();
        assertThat(actualColumns).as("Expected Risk Remediation columns are not displayed!").isEqualTo(expectedColumns);
    }

    @Then("Risk Remediation Questionnaire table is displayed with columns")
    public void areRiskRemediationQuestionnaireTableColumnsDisplayed(List<String> expectedColumns) {
        List<String> actualColumns = riskManagementPage.getRiskRemediationQuestionnaireTableColumns();
        assertThat(actualColumns).as("Expected Risk Remediation columns are not displayed!").isEqualTo(expectedColumns);
    }

    @Then("Risk Remediation Custom Fields table is displayed with columns")
    public void areRiskRemediationCustomFieldsTableColumnsDisplayed(List<String> expectedColumns) {
        List<String> actualColumns = riskManagementPage.getRiskRemediationCustomFieldsTableColumns();
        assertThat(actualColumns).as("Expected Risk Remediation columns are not displayed!").isEqualTo(expectedColumns);
    }

    @Then("Media check Risk Remediation table is displayed with next details")
    public void checkRiskRemediationMediaCheckTableValues(
            List<RiskRemediationMediaCheckData> expectedValues) {
        List<RiskRemediationMediaCheckData> updatedExpectedValues = new ArrayList<>();
        expectedValues.forEach(
                value -> value.setTagAsRedFlagRecord(getTagAsRedFlagRecord(value.getTagAsRedFlagRecord())));
        if (expectedValues.stream().anyMatch(values -> values.getRedFlagDate().contains(TODAY))) {
            updatedExpectedValues = expectedValues.stream().filter(value -> value.getRedFlagDate().contains(TODAY))
                    .map(record -> record.setRedFlagDate(getTodayDate(REACT_FORMAT))).collect(Collectors.toList());
        }
        List<RiskRemediationMediaCheckData> actualValues =
                riskManagementPage.getRiskRemediationMediaCheckTableData();
        assertThat(actualValues).as("Risk Remediation table contains not expected values")
                .hasSameElementsAs(updatedExpectedValues);
    }

    @SuppressWarnings("unchecked")
    @Then("World-Check Risk Remediation table is displayed with next details")
    public void checkRiskRemediationWorldCheckTableValues(
            List<RiskRemediationWorldCheckData> expectedValues) {
        Map<String, String> selectedScreeningResults =
                (Map<String, String>) context.getScenarioContext().getContext(SCREENING_SELECTED_RESULTS_CONTEXT);
        Map<String, String> selectedReferenceIdResults =
                (Map<String, String>) context.getScenarioContext().getContext(SCREENING_REFERENCE_IDS_CONTEXT);
        expectedValues.forEach(
                value -> value.setTagAsRedFlagRecord(
                        nonNull(selectedScreeningResults.get(value.getTagAsRedFlagRecord())) ?
                                selectedScreeningResults.get(value.getTagAsRedFlagRecord()) :
                                value.getTagAsRedFlagRecord()));
        expectedValues.forEach(
                value -> value.setReferenceId(nonNull(selectedReferenceIdResults.get(value.getReferenceId())) ?
                                                      selectedReferenceIdResults.get(value.getReferenceId()) :
                                                      value.getReferenceId()));
        expectedValues.forEach(value -> value.setRedFlagDate(
                value.getRedFlagDate().contains(TODAY) ? getTodayDate(REACT_FORMAT) : value.getRedFlagDate()));
        List<RiskRemediationWorldCheckData> actualValues =
                riskManagementPage.getRiskRemediationWorldCheckTableData();
        actualValues.forEach(value -> value.setReferenceId(value.getReferenceId().substring(9)));
        assertThat(actualValues).as("Risk Remediation table contains not expected values")
                .hasSameElementsAs(expectedValues);
    }

    @Then("Risk Remediation Questionnaire table is displayed with next details")
    public void checkRiskRemediationQuestionnaireTableValues(List<RiskRemediationQuestionnaireData> expectedValues) {
        List<RiskRemediationQuestionnaireData> updatedExpectedValues = new ArrayList<>();
        if (expectedValues.stream().anyMatch(values -> values.getDateSubmitted().contains(TODAY))) {
            updatedExpectedValues = expectedValues.stream().filter(value -> value.getDateSubmitted().contains(TODAY))
                    .map(record -> record.setDateSubmitted(getTodayDate(REACT_FORMAT))).collect(Collectors.toList());
        }
        List<RiskRemediationQuestionnaireData> actualValues =
                riskManagementPage.getRiskRemediationQuestionnaireTableData();
        assertThat(actualValues).as("Risk Remediation table contains not expected values")
                .containsExactlyInAnyOrderElementsOf(updatedExpectedValues);
    }

    @Then("Risk Remediation Custom Fields table is displayed with next details")
    public void checkRiskRemediationCustomFieldsTableValues(List<RiskRemediationCustomFieldsData> expectedValues) {
        expectedValues.forEach(value -> {
            String customFieldIndex = value.getCustomField().substring(21);
            value.setCustomField((String) context.getScenarioContext()
                    .getContext(CUSTOM_FIELD_NAME_NUMBER_CONTEXT + customFieldIndex));
        });
        List<RiskRemediationCustomFieldsData> actualValues =
                riskManagementPage.getRiskRemediationCustomFieldsTableData();
        assertThat(actualValues).as("Risk Remediation table contains not expected values")
                .isEqualTo(expectedValues);
    }

    @Then("Media check Risk Remediation table is sorted by {string} in {string} order")
    public void checkRiskRemediationMediaCheckSorting(String columnName, String order) {
        List<String> valuesList = riskManagementPage.getRiskRemediationMediaCheckColumnValues(columnName);
        tableIsSortedByInOrder("Risk Remediation Media Check", columnName, order, REACT_FORMAT, valuesList, false);
    }

    @Then("World check Risk Remediation table is sorted by {string} in {string} order")
    public void checkRiskRemediationWorldCheckSorting(String columnName, String order) {
        List<String> valuesList = riskManagementPage.getRiskRemediationWorldCheckColumnValues(columnName);
        tableIsSortedByInOrder("Risk Remediation World-Check", columnName, order, REACT_FORMAT, valuesList, false);
    }

    @Then("Custom Fields Risk Remediation table is sorted by {string} in {string} order")
    public void checkRiskRemediationCustomFieldsSorting(String columnName, String order) {
        List<String> valuesList = riskManagementPage.getRiskRemediationCustomFieldsColumnValues(columnName);
        tableIsSortedByInOrder("Risk Remediation World-Check", columnName, order, REACT_FORMAT, valuesList, false);
    }

    @Then("Risk Remediation breadcrumb is displayed")
    public void checkRiskRemediationBreadcrumbIsDisplayed() {
        AssertionsForClassTypes.assertThat(riskManagementPage.isRiskRemediationBreadcrumbDisplayed()).as(
                "Risk Remediation breadcrumb is not displayed").isTrue();
    }

    @Then("Risk Remediation {string} tab is displayed")
    public void checkRiskRemediationTabIsDisplayed(String tabName) {
        assertThat(riskManagementPage.isRiskRemediationTabDisplayed(tabName)).as(
                "Risk Remediation tab %s is not displayed", tabName).isTrue();
    }

    @Then("Media check Risk Remediation Source column is sorted in next order")
    public void checkSourceColumnSorting(List<String> expectedSortOrder) {
        String sourceColumn = "Source";
        List<String> valuesList = riskManagementPage.getRiskRemediationMediaCheckColumnValues(sourceColumn);
        assertThat(valuesList).as("Source column is not sorted in expected order").isEqualTo(expectedSortOrder);
    }

    @Then("World-Check Risk Remediation Source column is sorted in next order")
    public void checkWorldCheckSourceColumnSorting(List<String> expectedSortOrder) {
        String sourceColumn = "Source";
        List<String> valuesList = riskManagementPage.getRiskRemediationWorldCheckColumnValues(sourceColumn);
        assertThat(valuesList).as("Source column is not sorted in expected order").isEqualTo(expectedSortOrder);
    }

    @Then("Risk Remediation Questionnaire table displays No Available Data")
    public void isRiskRemediationQuestionnaireNoAvailableDataDisplayed() {
        assertThat(riskManagementPage.isRiskRemediationQuestionnaireNoAvailableDataDisplayed()).as(
                "No Available Data is not displayed").isTrue();
    }

    @Then("Questionnaire Risk Remediation Question column has default sorting")
    public void checkQuestionColumnDefaultOrder(List<String> expectedOrder) {
        String questionColumn = "Question";
        List<String> valuesList = riskManagementPage.getQuestionnaireRiskRemediationColumnValues(questionColumn);
        assertThat(valuesList).as("Question column is not sorted in expected order").isEqualTo(expectedOrder);
    }

    @Then("Questionnaire Risk Remediation table is sorted by {string} in {string} order")
    public void checkQuestionnaireRiskRemediationSorting(String columnName, String order) {
        riskManagementPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> valuesList = riskManagementPage.getQuestionnaireRiskRemediationColumnValues(columnName);
        tableIsSortedByInOrder("Questionnaire Risk Remediation", columnName, order, REACT_FORMAT, valuesList, false);
    }

}
