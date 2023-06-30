package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ObjectsItem;
import com.refinitiv.asts.test.ui.constants.APIConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.ApprovalProcessPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.approvalProcess.ApprovalProcessDetailsData;
import com.refinitiv.asts.test.ui.utils.data.ui.ApprovalProcessDTO;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;
import org.openqa.selenium.WebElement;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildProcessRuleRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.deleteProcessRule;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getProcessRules;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.APPROVAL_PROCESS;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.APPROVAL;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.ENORMOUS_ITEMS_PER_PAGE;
import static java.util.Arrays.stream;
import static java.util.UUID.randomUUID;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertTrue;

public class ApprovalProcessSteps extends BaseSteps {

    public static final String ADD_RULES_FOR = "Add Rules For";
    public static final String APPROVAL_PROCESS_NAME = "Approval Process Name";
    public static final String ACTIVITY_OWNER = "Activity Owner";
    public static final String RULE_VALUE = "Rule Value";
    public static final String APPROVAL_METHOD = "Approver Method";
    private static final String ALREADY_EXISTING_NAME = "alreadyExistingName";
    private static final String CANCEL_UPDATE = "CANCEL";
    private static final String ADDED = "ADDED";
    private static final String UPDATED = "UPDATED";
    private static final String INTERNAL_ACTIVE_USERS = "internal active users";
    private static final String ACTIVE_USER_GROUPS = "active user groups";
    private static final String DEPARTMENTS = "all departments in the system";
    private static final String DIVISIONS = "all divisions in the system";
    private static final String COUNTRIES = "all countries in the system";
    private static final String REGIONS = "all regions in the system";
    private static final String INDUSTRY_TYPES = "all industry types in the system";
    public static final String APPROVER = "Approver";
    public static final String DEFAULT_APPROVER = "Default Approver";
    private static final String STATUS = "Status";

    private final ApprovalProcessPage approvalProcessPage;
    private final SearchSectionPage searchPage;

    public ApprovalProcessSteps(ScenarioCtxtWrapper context) {
        super(context);
        approvalProcessPage = new ApprovalProcessPage(driver);
        searchPage = new SearchSectionPage(driver);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ApprovalProcessDetailsData approvalProcessDetailsEntry(Map<String, String> entry) {
        return ApprovalProcessDetailsData.builder()
                .approvalProcessName(entry.get(APPROVAL_PROCESS_NAME))
                .defaultApprover(entry.get(DEFAULT_APPROVER))
                .description(entry.get(DESCRIPTION))
                .status(entry.get(STATUS))
                .build();
    }

    @When("User clicks Approval Process in Set Up menu")
    public void clickCountryChecklistMenu() {
        approvalProcessPage.clickApproverProcessMenu();
        approvalProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks Approval process header link")
    public void clickApprovalProcessHeaderLink() {
        approvalProcessPage.clickApprovalProcessHeader();
    }

    @When("User navigates to Approval Process overview page")
    public void navigateToApprovalProcessPage() {
        approvalProcessPage.navigateToApprovalProcessPage();
    }

    @When("User clicks 'Delete' button for Approval Process with name {string}")
    public void clickDeleteButtonForApprovalProcessWithName(String processName) {
        if (processName.equals(VALUE_TO_REPLACE)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        }
        approvalProcessPage.clickOnDeleteButton(processName);
    }

    @When("User clicks on Approval process with name {string} on overview page")
    public void clickOnApprovalProcessWithName(String processName) {
        if (processName.equals(VALUE_TO_REPLACE)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        }
        approvalProcessPage.clickOnApprovalProcessWithName(processName);
    }

    @When("User creates Approval Process with {string} via API")
    public void createApprovalProcessAPI(String approvalProcessReference) {
        ApprovalProcessData approvalProcessData =
                new JsonUiDataTransfer<ApprovalProcessData>(APPROVAL_PROCESS).getTestData()
                        .get(approvalProcessReference)
                        .getDataToEnter();
        if (approvalProcessData.getName().isEmpty()) {
            approvalProcessData.setName(AUTO_TEST_NAME_PREFIX + randomUUID());
            context.getScenarioContext()
                    .setContext(APPROVAL_PROCESS_NAME_CONTEXT, approvalProcessData.getName());
        }
        approvalProcessData.getApprovers().setEmail(Config.get().value(approvalProcessData.getApprovers().getEmail()));
        stream(approvalProcessData.getApproverProcessRules().getApprovers())
                .forEach(approver -> stream(approver.getUsers())
                        .forEach(user -> {
                            String email = Config.get().value(user.getEmail());
                            user.setEmail(email);
                        }));
        approvalProcessData.getApproverProcessRules().setCoverage(
                stream(approvalProcessData.getApproverProcessRules().getCoverage())
                        .map(coverage -> coverage.equals(USER_GROUP_ID_CONTEXT) ?
                                (String) context.getScenarioContext().getContext(USER_GROUP_ID_CONTEXT) :
                                Config.get().value(coverage))
                        .toArray(String[]::new));
        WorkflowApi.postApprovalProcessRule(buildProcessRuleRequest(approvalProcessData));
    }

    @When("User searches approval process with name {string}")
    public void searchApprovalProcess(String processName) {
        if (processName.equals(VALUE_TO_REPLACE)) {
            processName = getProcessRules(100, 0, APPROVAL)
                    .getObjects().stream().map(ObjectsItem::getName).findFirst()
                    .orElse("No Approval Process were found!");
            this.context.getScenarioContext().setContext(EXISTING_APPROVAL_PROCESS, processName);
        } else if (processName.equals(APPROVAL_PROCESS_NAME_CONTEXT)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        }
        approvalProcessPage.searchApprovalProcess(processName);
    }

    @When("User searches not existing approval process")
    public void searchNotExistingApprovalProcess() {
        String processName = getProcessRules(100, 0, APPROVAL)
                .getObjects().stream().map(ObjectsItem::getName).findFirst()
                .orElse("No Approval Process were found!");
        processName = processName + randomUUID();
        searchPage.searchItem(processName);
    }

    @When("User selects approval process with name {string}")
    public void selectApprovalProcess(String processName) {
        if (processName.equals(APPROVAL_PROCESS_NAME_CONTEXT)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        }
        searchApprovalProcess(processName);
        logger.info("Search for approval process: " + processName);
        approvalProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        approvalProcessPage.clickSelectApprovalProcess();
    }

    @When("User click approval process button {string}")
    public void clickApprovalProcessButton(String button) {
        approvalProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        approvalProcessPage.clickApprovalProcessButton(button);
    }

    @When("User clicks Add Approval Process button")
    public void clickAddApprovalProcessButton() {
        approvalProcessPage.clickAddApprovalProcessButton();
    }

    @When("User fills in Approval Process Name with {string}")
    public void fillInApprovalProcessNameField(String name) {
        if (name.equals(VALUE_TO_REPLACE)) {
            name = AUTO_TEST_NAME_PREFIX + randomUUID();
        }
        if (name.equals(ALREADY_EXISTING_NAME)) {
            String processName = Objects.requireNonNull(approvalProcessPage.getAllApprovalProcessesWithinSetUpContext()
                                                                .stream().map(ApprovalProcessDTO::getProcessName)
                                                                .findFirst().orElse(null)).getText();
            approvalProcessPage.fillInApprovalProcessNameField(processName);
            context.getScenarioContext().setContext(APPROVAL_PROCESS_NAME_CONTEXT, name);
        } else if (name.toUpperCase().contains(CANCEL_UPDATE)) {
            approvalProcessPage.fillInApprovalProcessNameField(name);
            context.getScenarioContext().setContext(APPROVAL_PROCESS_UPDATED_NAME_CONTEXT, name);
        } else {
            approvalProcessPage.fillInApprovalProcessNameField(name);
            context.getScenarioContext().setContext(APPROVAL_PROCESS_NAME_CONTEXT, name);
        }
    }

    @When("User selects in Approval Process Default Approver dropdown value {string}")
    public void selectValueInDefaultApproverDropDown(String value) {
        approvalProcessPage.selectValueInDefaultApproverDropDown(value);
    }

    @When("^User selects in (?:Approval Process|Add Approver?) Add Rules For dropdown value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueInAddRulesForDropDown(String value, int ruleNumber) {
        approvalProcessPage.selectValueInAddRulesForDropDown(value, ruleNumber);
    }

    @When("^User selects in (?:Approval Process|Add Approver?) Approver dropdown value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueInApproverDropDown(String value, int ruleNumber) {
        approvalProcessPage.selectValueInApproverDropDown(value, ruleNumber);
    }

    @When("User selects in Add Approver Approver dropdown {int} values for rule with number {int}")
    public void selectValueInApproverDropDown(int valuesNumber, int ruleNumber) {
        List<String> selectedValues = approvalProcessPage.selectValueInApproverDropDown(valuesNumber, ruleNumber);
        this.context.getScenarioContext().setContext(APPROVAL_PROCESS_SELECTED_VALUES, selectedValues);
    }

    @When("^User selects in (?:Approval Process|Add Approver?) \"((.*))\" Value dropdown value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueInActivityOwnerDropDownValue(String dropDownType, String value, int ruleNumber) {
        approvalProcessPage.selectValueInActivityOwnerDD(dropDownType, value, ruleNumber);
    }

    @When("^User selects in (?:Approval Process|Add Approver|Add Reviewer?) from dropdown \"((.*))\" value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueFromDropdown(String dropdownLabel, String value, int ruleNumber) {
        approvalProcessPage.selectValueFromDropdown(dropdownLabel, value, ruleNumber);
    }

    @When("^User selects rule value \"((.*))\" for rule \"((.*))\" with number (\\d+)$")
    public void selectValueInActivityOwnerDropDown(String ruleValue, String rule, int ruleNumber) {
        approvalProcessPage.selectAddRuleForValueFromDropdown(ruleValue, rule, ruleNumber);
    }

    @When("^User selects in (?:Approval Process|Add Approver?) \"((.*))\" Value dropdown (\\d+) values for rule with number (\\d+)$")
    public void selectValueInActivityOwnerDropDown(String dropDownType, int valuesNumber, int ruleNumber) {
        List<String> selectedValues =
                approvalProcessPage.selectValueInActivityOwnerDD(dropDownType, valuesNumber, ruleNumber);
        this.context.getScenarioContext().setContext(APPROVAL_PROCESS_SELECTED_VALUES, selectedValues);
    }

    @When("^User selects (?:Approval Process|Add Approver?) Approver Method radio button \"((.*))\" for rule with number (\\d+)$")
    public void selectApproverMethod(String method, int ruleNumber) {
        approvalProcessPage.clickApproverMethod(method, ruleNumber);
    }

    @When("User clicks Approval Process Add button")
    public void clickAddButton() {
        approvalProcessPage.clickAddButton();
    }

    @When("User clicks Approval Process Remove button for rule with number {int}")
    public void clickRemoveButton(int ruleNumber) {
        approvalProcessPage.clickRemoveButton(ruleNumber);
    }

    @When("User clicks Approval Process {string} button")
    public void clickButtonWithName(String name) {
        approvalProcessPage.clickButtonWithName(name);
    }

    @When("User clicks Edit button for created Approval Process")
    public void clickEditButtonForCreatedApprovalProcess() {
        String processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        approvalProcessPage.clickEditButtonForApprovalProcess(processName);
    }

    @When("User clicks Edit button on Approval Process details page")
    public void clickEditButtonOnApprovalProcessDetailsPage() {
        approvalProcessPage.clickOnEditApprovalProcessButton();
    }

    @When("User clears Approval Process Default Approver dropdown")
    public void clearDefaultApproverDropDown() {
        approvalProcessPage.clearDefaultApproverDropDown();
    }

    @When("^User (checks|unchecks) 'Active' checkbox on Approval Process page$")
    public void checkActiveCheckbox(String state) {
        if ((approvalProcessPage.isActiveCheckboxChecked() && state.equals(UNCHECKS)) ||
                (!approvalProcessPage.isActiveCheckboxChecked() && state.equals(CHECKS))) {
            approvalProcessPage.clickActiveCheckbox();
        }
    }

    @When("User clicks first Approval Process")
    public void clickFirstApprovalProcess() {
        approvalProcessPage.clickFirstApprovalProcessName();
    }

    @When("User deletes all Approval Processes with name prefix generated by auto tests via API")
    public void deleteAllApprovalProcessesWithNamePrefixGeneratedByAutoTestsViaAPI() {
        getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, APPROVAL).getObjects()
                .forEach(rule -> {
                    if (rule.getName().startsWith(AUTO_TEST_NAME_PREFIX)) {
                        deleteProcessRule(rule.getId());
                    }
                });
    }

    @Then("Approval Process Overview page is displayed")
    public void isApprovalProcessOverviewPageDisplayed() {
        assertTrue("Approval Process Header is not displayed!",
                   approvalProcessPage.isApprovalProcessOverviewPageDisplayed());
    }

    @Then("'Add Existing Approval Process' page title should be {string}")
    public void pageElementsShouldBeVisible(String sectionTitle) {
        assertThat(approvalProcessPage.getPageTileValue()).as("Page title is incorrect").contains(sectionTitle);
    }

    @Then("'Add Existing Approval Process' table contains columns")
    public void checkTableColumnsName(DataTable data) {
        List<String> expectedColumns = data.asList();
        List<String> actualColumns = approvalProcessPage.getTableColumns();
        assertThat(actualColumns).as("Columns are unexpected").isEqualTo(expectedColumns);
    }

    @Then("Search item {string} is shown")
    public void searchItemShouldBeShown(String processName) {
        if (processName.equals(VALUE_TO_REPLACE)) {
            processName = (String) this.context.getScenarioContext().getContext(EXISTING_APPROVAL_PROCESS);
        } else if (processName.equals(REVIEW_PROCESS_NAME)) {
            processName = (String) this.context.getScenarioContext().getContext(REVIEW_PROCESS_NAME);
        }
        assertThat(approvalProcessPage.getFirstApprovalProcessName())
                .as("Approval Process '%s' wasn't found", processName)
                .isEqualTo(processName);
    }

    @Then("Approval Process page button {string} should be visible")
    public void buttonShouldBeVisible(String button) {
        Assert.assertTrue(approvalProcessPage.buttonShouldBeVisible(button));
    }

    @Then("Approval Process item modal window should be closed")
    public void modalShouldBeInvisible() {
        Assert.assertFalse(approvalProcessPage.isModalWindowVisible());
    }

    @Then("Activity process record should have next fields")
    public void verifyActivityProcessItemHasFields(DataTable data) {
        approvalProcessPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(approvalProcessPage.getApprovalProcessFieldTitles())
                .as("Fields are unexpected")
                .containsAll(data.asList());
    }

    @Then("Approval Process {string} modal is displayed")
    public void isModalWithNameDisplayed(String modalName) {
        assertThat(approvalProcessPage.isModalWithNameDisplayed(modalName))
                .as(modalName + " modal is not displayed!").isTrue();
    }

    @Then("Approval process drop-down {string} becomes required")
    public void isDropDownWithNameRequired(String dropDownName) {
        approvalProcessPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(approvalProcessPage.isDropDownWithNameRequired(dropDownName))
                .as(dropDownName + " drop-down is not required").isTrue();
    }

    @Then("Error message {string} in red color is displayed near {string} approval process field")
    public void errorMessageIsDisplayedOnApprovalProcessField(String errorMessage, String fieldName) {
        String processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        errorMessage = String.format(errorMessage, processName);
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(approvalProcessPage.isFieldInvalidAriaDisplayed(fieldName),
                              fieldName + " field doesn't display invalid aria");
        softAssert.assertEquals(approvalProcessPage.getErrorMessageText(fieldName), errorMessage,
                                errorMessage + " error message is not displayed");
        softAssert.assertTrue(
                approvalProcessPage.getErrorMessageElementCSS(fieldName, COLOR).equals(REACT_RED.getColorRgba()),
                fieldName + " error message is not red");
        softAssert.assertAll();
    }

    @Then("Approval Process Add button becomes enabled")
    public void isAddButtonEnabled() {
        assertThat(approvalProcessPage.isAddButtonEnabled()).as("Add button is not enabled!").isTrue();
    }

    @Then("Approval Process {string} field for rule with number {int} is displayed")
    public void isDropDownDisplayedForRuleWithNumber(String dropDownName, int ruleNumber) {
        switch (dropDownName) {
            case ADD_RULES_FOR:
                assertThat(approvalProcessPage.isAddRulesForDropDownDisplayed(ruleNumber)).as(
                        "Add Rules For field is not displayed!").isTrue();
                break;
            case ACTIVITY_OWNER:
                assertThat(approvalProcessPage.isActivityOwnerDropDownDisplayed(ruleNumber)).as(
                        "Activity Owner field is not displayed!").isTrue();
                break;
            case RULE_VALUE:
                assertThat(approvalProcessPage.isRuleValueDropDownDisplayed(ruleNumber)).as(
                        "Rule Value field is not displayed!").isTrue();
                break;
            case APPROVER:
                assertThat(approvalProcessPage.isApproverDropDownDisplayed(ruleNumber)).as(
                        "Approver field is not displayed!").isTrue();
                break;
            case APPROVAL_METHOD:
                assertThat(approvalProcessPage.isApproverMethodDisplayed(ruleNumber)).as(
                        "Approver Method field is not displayed!").isTrue();
                break;
            default:
                throw new IllegalArgumentException("Drop-down - " + dropDownName + " is unknown!");
        }

    }

    @Then("Approval Process Remove button is displayed for rule with number {int} is displayed")
    public void isRemoveButtonForRuleDisplayed(int ruleNumber) {
        assertThat(approvalProcessPage.isRemoveButtonDisplayedForRule(ruleNumber)).as(
                "Remove button is not displayed!").isTrue();
    }

    @Then("Approval Rule with number {int} is not displayed")
    public void isRuleDisplayed(int ruleNumber) {
        assertThat(approvalProcessPage.isAddRulesForDropDownDisplayed(ruleNumber)).as(
                "Rule is still displayed!").isFalse();
    }

    @Then("Added Approval Process is displayed on top of Overview table")
    public void isAddedApprovalProcessDisplayedOnTopOverview() {
        approvalProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        approvalProcessPage.closeAlertIconIfDisplayed();
        String processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        String processNameOnTop =
                approvalProcessPage.getAllApprovalProcessesWithinSetUpContext().get(0).getProcessName().getText();
        assertThat(processNameOnTop).as("Approval Process is not displayed in Overview table!").isEqualTo(processName);
    }

    @Then("Approval Process {string} is displayed in Overview table")
    public void isAddedApprovalProcessDisplayedInOverview(String processName) {
        if (processName.equalsIgnoreCase(ADDED)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        }
        List<String> processNamesList = approvalProcessPage.getAllApprovalProcessesWithinSetUpContext().stream()
                .map(test -> test.getProcessName().getText()).collect(Collectors.toList());
        assertThat(processNamesList.contains(processName)).as("Approval Process is not displayed in Overview").isTrue();
    }

    @Then("Approval Process {string} is not displayed in Overview table")
    public void isAddedApprovalProcessNotDisplayedInOverview(String processName) {
        if (processName.equalsIgnoreCase(UPDATED)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_UPDATED_NAME_CONTEXT);
        } else if (processName.equalsIgnoreCase(ADDED)) {
            processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        }
        List<String> processNamesList = approvalProcessPage.getAllApprovalProcessesWithinSetUpContext().stream()
                .map(ApprovalProcessDTO::getProcessName)
                .map(WebElement::getText).collect(Collectors.toList());
        assertThat(processNamesList.contains(processName)).as("Approval Process is displayed in Overview")
                .isFalse();
    }

    @Then("Add Approver tab 'Add Rules For' dropdown contains for rule with number {int}")
    public void checkValuesAddRulesForDropDown(int ruleNumber, List<String> expectedValues) {
        approvalProcessPage.clickDropDownAddRulesFor(ruleNumber);
        List<String> usersInDropDown = approvalProcessPage.getDropDownValues();
        assertThat(usersInDropDown)
                .as("Add Rules For drop-down doesn't contain expected values: " + expectedValues)
                .containsAll(expectedValues);
    }

    @Then("'Default Approver' Approver section has +Add button")
    public void checkApproverAddButtonIsDisplayed() {
        assertThat(approvalProcessPage.isApproverAddButtonDisplayed())
                .as("+Add button for Approval section is not displayed")
                .isTrue();
    }

    @Then("^\"((.*))\" dropdown contains all \"((.*))\" for rule with number (\\d+)$")
    public void checkActivityOwnerDDContainsActiveUsers(String dropDownType, String valueType, int ruleNumber) {
        List<String> valuesList;
        switch (valueType.toLowerCase()) {
            case INTERNAL_ACTIVE_USERS:
                valuesList = getAllActiveInternalUsersStream(APIConstants.DESC)
                        .map(user -> String.format("%s %s", user.getFirstName(), user.getLastName())
                                .trim().replaceAll(MULTI_SPACE_REGEX, SPACE))
                        .collect(Collectors.toList());
                break;
            case ACTIVE_USER_GROUPS:
                valuesList = ConnectApi.getListOfActiveUserGroups().stream()
                        .map(group -> group.trim().replaceAll(MULTI_SPACE_REGEX, SPACE))
                        .collect(Collectors.toList());
                break;
            case DEPARTMENTS:
                valuesList = getAllDepartments();
                break;
            case DIVISIONS:
                valuesList = getAllDivisions();
                break;
            case COUNTRIES:
                valuesList = getListOfNamesForValueManagementType(getValueTypeId(COUNTRY));
                break;
            case REGIONS:
                valuesList = getListOfNamesForValueManagementType(getValueTypeId(REGION));
                break;
            case INDUSTRY_TYPES:
                valuesList = getListOfNamesForValueManagementType(getValueTypeId(INDUSTRY_TYPE));
                break;
            default:
                throw new IllegalArgumentException(valueType + " is not existing Add Rules For value type!");
        }
        approvalProcessPage.clickDropDownActivityOwner(dropDownType, ruleNumber);
        List<String> valuesInDropDown = approvalProcessPage.getDropDownValues();
        valuesInDropDown.remove(valuesInDropDown.get(valuesInDropDown.size() - 1));
        assertThat(valuesList)
                .as("Drop-down doesn't contain all active " + valueType)
                .containsAll(valuesInDropDown);
        approvalProcessPage.clickDropDownActivityOwner(dropDownType, ruleNumber);
    }

    @Then("^(?:Approval Process|Add Approver?) \"((.*))\" Value dropdown contains added values for rule with number (\\d+)$")
    @SuppressWarnings("unchecked")
    public void checkActivityOwnerDDContainsValues(String dropDownType, int ruleNumber) {
        List<String> expectedValues =
                (List<String>) this.context.getScenarioContext().getContext(APPROVAL_PROCESS_SELECTED_VALUES);
        List<String> actualValues = approvalProcessPage.getActivityOwnerDDValues(dropDownType, ruleNumber);
        assertThat(actualValues)
                .as("Drop-down doesn't contain expected values: " + expectedValues)
                .containsAll(expectedValues);
    }

    @Then("Approver dropdown contains expected values for rule with number {int}")
    public void approverDropdownContainsExpectedValuesForRuleWithNumber(int ruleNumber, DataTable dataTable) {
        List<String> actualValues = approvalProcessPage.getApproverDDValues(ruleNumber);
        assertThat(actualValues)
                .as("Drop-down doesn't contain expected values")
                .containsAll(dataTable.asList());
    }

    @Then("List of Approval Processes is opened")
    public void isApprovalProcessListOpened() {
        assertThat(approvalProcessPage.isApprovalProcessListOpened())
                .as("Approval Processes list is not displayed!")
                .isTrue();
    }

    @Then("No Approval Process Available message is displayed")
    public void isNoApprovalProcessMsgDisplayed() {
        assertThat(approvalProcessPage.isNoApprovalProcessMsgDisplayed())
                .as("No Approval Process Available message is not displayed!")
                .isTrue();
    }

    @Then("Approval Process item should not be saved")
    public void approvalProcessItemShouldNotBeSaved() {
        String processName = (String) this.context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
        assertThat(getProcessRules(100, 0, APPROVAL)
                           .getObjects()
                           .stream()
                           .filter(c -> c.getName().equals(processName))
                           .count())
                .isZero();
    }

    @Then("Approval Process display page is displayed with values")
    public void approvalProcessDisplayPageIsDisplayedWithValues(ApprovalProcessDetailsData expectedResult) {
        ApprovalProcessDetailsData actualResult = approvalProcessPage.getApprovalProcessFieldValues();
        if (expectedResult.getApprovalProcessName().equals(VALUE_TO_REPLACE)) {
            String approvalProcessName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME);
            expectedResult.setApprovalProcessName(approvalProcessName);
        }
        assertThat(actualResult)
                .as("Approval Process expected values are different from actual ones")
                .usingRecursiveComparison().ignoringExpectedNullFields()
                .isEqualTo(expectedResult);
    }

    @Then("Approval Process is displayed in Overview table with data")
    public void approvalProcessIsDisplayedInOverviewTableWithData(ApprovalProcessDetailsData expectedResult) {
        if (expectedResult.getApprovalProcessName().equalsIgnoreCase(VALUE_TO_REPLACE)) {
            String processName = (String) context.getScenarioContext().getContext(APPROVAL_PROCESS_NAME_CONTEXT);
            expectedResult.setApprovalProcessName(processName);
        }
        List<ApprovalProcessDetailsData> approvalProcessesList =
                approvalProcessPage.getAllApprovalProcessesWithinSetUpContext()
                        .stream()
                        .map(approvalProcess -> ApprovalProcessDetailsData.builder()
                                .approvalProcessName(
                                        approvalProcessPage.getElementText(approvalProcess.getProcessName()))
                                .description(approvalProcessPage.getElementText(approvalProcess.getDescription()))
                                .status(approvalProcessPage.getElementText(approvalProcess.getStatus()))
                                .build())
                        .collect(Collectors.toList());
        assertThat(approvalProcessesList)
                .as("Approval Process is not displayed in Overview")
                .contains(expectedResult);
    }

    @Then("^Approval Process with \"((.*))\" name (is not|is) created$")
    public void checkApprovalProcessCreated(String name, String state) {
        List<ObjectsItem> objects = getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, APPROVAL).getObjects();
        if (state.contains(NOT)) {
            for (ObjectsItem approvalProcess : objects) {
                if (approvalProcess.getName().equals(name)) {
                    throw new SkipException(name + " already exists!");
                }
            }
        } else {
            assertThat(objects.stream().anyMatch(thirdParty -> thirdParty.getName().equals(name)))
                    .as("Approval Process with name: %s is not created", name)
                    .isTrue();
            context.getScenarioContext().setContext(APPROVAL_PROCESS_NAME_CONTEXT, null);
        }
    }

}
