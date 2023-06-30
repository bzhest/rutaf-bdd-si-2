package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.config.Config;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.Endpoints;
import com.refinitiv.asts.test.ui.api.WorkflowApi;
import com.refinitiv.asts.test.ui.api.model.Reference;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.api.model.approvalProcess.ObjectsItem;
import com.refinitiv.asts.test.ui.api.model.organisation.allOrganisationData.OrganizationPayload;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.DataProvider;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.Colors;
import com.refinitiv.asts.test.ui.pageActions.setUp.ReviewProcessPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.ThirdPartyInformationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.reviewProcess.ReviewProcessDataAPI;
import com.refinitiv.asts.test.ui.utils.data.ui.ReviewProcessDTO;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildReviewProcessRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.Endpoints.ORGANISATION_GET;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getFirstActiveUsers;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.deleteProcessRule;
import static com.refinitiv.asts.test.ui.api.WorkflowApi.getProcessRules;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.DashboardConstants.INDUSTRY_TYPE;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.ProcessRuleTypes.REVIEW;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.ENORMOUS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.setUp.workflowManagement.workflow.ReviewerPage.REVIEWER;
import static com.refinitiv.asts.test.ui.utils.DateUtil.REACT_FORMAT;
import static io.cucumber.messages.internal.com.google.common.base.Strings.isNullOrEmpty;
import static java.lang.String.format;
import static java.util.Arrays.stream;
import static java.util.Objects.nonNull;
import static java.util.UUID.randomUUID;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang.WordUtils.capitalizeFully;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertTrue;

public class ReviewProcessSteps extends BaseSteps {

    public static final String NO_AVAILABLE_DATA = "NO AVAILABLE DATA";
    public static final String RULE_REVIEWER = "Rule Reviewer";
    private final ReviewProcessPage reviewProcessPage;
    private final ThirdPartyInformationPage thirdPartyPage;
    private final List<String> processesNamesToDelete = new ArrayList<>();

    public ReviewProcessSteps(ScenarioCtxtWrapper context) {
        super(context);
        reviewProcessPage = new ReviewProcessPage(driver, context);
        thirdPartyPage = new ThirdPartyInformationPage(driver, context, translator);
    }

    private List<String> getExpectedDropDownOptions(String dropDownName) {
        switch (dropDownName) {
            case "Activity Owner":
            case "Default Reviewer":
                return getFirstActiveUsers(20, INTERNAl_USER_TYPE).stream()
                        .filter(user -> user.getUsername() != null)
                        .map(user -> format(USER_FIRST_LAST_USERNAME_WITH_NEW_LINE, user.getFirstName(),
                                            user.getLastName(),
                                            user.getUsername()))
                        .collect(Collectors.toList());
            case "Activity Owner Department":
                return getMyOrganizationFullDetails(Endpoints.DEPARTMENT + ORGANISATION_GET)
                        .stream().filter(OrganizationPayload.ObjectsItem::getActive)
                        .map(OrganizationPayload.ObjectsItem::getName)
                        .collect(toList());
            case "Activity Owner Division":
                return getMyOrganizationFullDetails(Endpoints.DIVISION + ORGANISATION_GET)
                        .stream().filter(OrganizationPayload.ObjectsItem::getActive)
                        .map(OrganizationPayload.ObjectsItem::getName)
                        .collect(toList());
            case "Activity Owner Group":
                return ConnectApi.getListOfActiveUserGroups().stream()
                        .map(group -> group.replace(DOUBLE_SPACE, SPACE).trim())
                        .collect(toList());
            case "Third-party Region":
                return getAllAvailableRegions().stream()
                        .map(RegionCountryRequest.RegionObject::getName).collect(Collectors.toList());
            case "Third-party Country":
                return ConnectApi.getCountries().getReferences().stream()
                        .map(Reference::getDescription).collect(Collectors.toList());
            case "Third-party Industry Type":
                List<String> industryTypeList =
                        stream(getRefDataPayload(getValueType(capitalizeFully(INDUSTRY_TYPE)).get_id()).getListValues())
                                .map(value -> nonNull(value.getName()) ? value.getName() : value.getDescription())
                                .collect(toList());
                industryTypeList.removeAll(Collections.singleton(null));
                return industryTypeList;
            default:
                throw new IllegalArgumentException("Drop-down type: " + dropDownName + " is unexpected");
        }
    }

    @When("User navigates to Review Process page")
    public void navigateToReviewProcessPage() {
        reviewProcessPage.navigateToReviewProcessPage();
        reviewProcessPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to Review Process Add page")
    public void navigateToReviewProcessAddPage() {
        reviewProcessPage.navigateToAddReviewProcessPage();
        reviewProcessPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User navigates to open {string} existing Review Process page")
    public void navigateToExistingReviewProcessPage(String endpoint) {
        String processId = (String) context.getScenarioContext().getContext(REVIEW_PROCESSES_ID);
        reviewProcessPage.navigateToReviewProcessPage(SLASH + processId + endpoint);
        reviewProcessPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User creates Review Process with {string} via API")
    public void createReviewProcessAPI(String reviewProcessReference) {
        ReviewProcessDataAPI reviewProcessData =
                new JsonUiDataTransfer<ReviewProcessDataAPI>(DataProvider.REVIEW_PROCESS_API).getTestData()
                        .get(reviewProcessReference)
                        .getDataToEnter();
        if (reviewProcessData.getName().isEmpty()) {
            reviewProcessData.setName(AUTO_TEST_NAME_PREFIX + randomUUID());
            context.getScenarioContext().setContext(REVIEW_PROCESS_NAME, reviewProcessData.getName());
        }
        reviewProcessData.getReviewers().setEmail(Config.get().value(reviewProcessData.getReviewers().getEmail()));
        context.getScenarioContext().setContext(REVIEW_PROCESSES_ID, WorkflowApi.postReviewProcessRule(
                buildReviewProcessRequest(reviewProcessData)).getId());
        processesNamesToDelete.add(reviewProcessData.getName());
        context.getScenarioContext().setContext(REVIEW_PROCESSES_NAMES_LIST, processesNamesToDelete);
    }

    @When("User creates {int} Review Processes with {string} via API")
    public void createReviewProcessesWithViaAPI(int count, String dataReference) {
        for (int i = 0; i < count; i++) {
            createReviewProcessAPI(dataReference);
        }
    }

    @When("^User clicks \"(Edit|Delete|View)\" for created Review Process")
    public void clickEditOrDeleteForReview(String actionButton) {
        ReviewProcessData context = (ReviewProcessData) this.context.getScenarioContext().getContext(REVIEW_PROCESS);
        switch (actionButton) {
            case EDIT:
                reviewProcessPage.clickEditReviewProcess(context.getReviewProcessName());
                break;
            case DELETE:
                reviewProcessPage.clickDeleteReviewProcess(context.getReviewProcessName());
                break;
            case VIEW:
                reviewProcessPage.clickReviewProcessName(context.getReviewProcessName());
                break;
            default:
                throw new IllegalArgumentException(actionButton + " is incorrect argument");
        }
    }

    @When("User clicks Review Process form Add Reviewer button")
    public void clickAddReviewButton() {
        reviewProcessPage.clickAddReviewButton();
    }

    @When("User removes Reviewers block {string}")
    public void removeReviewBlock(String blockNumber) {
        reviewProcessPage.removeReviewerBlock(blockNumber);
    }

    @When("^User clicks '(?:Add|Edit?) Review Process' \"(Save|Cancel)\" button")
    public void clickAddReviewProcessModalButton(String buttonType) {
        reviewProcessPage.clickReviewProcessButton(buttonType);
    }

    @When("User clicks 'Add Review Process' button")
    public void clickAddReviewProcessButton() {
        reviewProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        reviewProcessPage.clickReviewProcessButton();
        reviewProcessPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User fills Add Review Process form with {string} data")
    public void fillReviewProcessForm(String reviewProcessReference) {
        ReviewProcessData reviewerProcessData =
                new JsonUiDataTransfer<ReviewProcessData>(DataProvider.REVIEW_PROCESS).getTestData()
                        .get(reviewProcessReference)
                        .getDataToEnter();
        if (isNullOrEmpty(reviewerProcessData.getReviewProcessName())) {
            reviewerProcessData.setReviewProcessName(AUTO_TEST_NAME_PREFIX + randomUUID());
        }

        this.context.getScenarioContext().setContext(REVIEW_PROCESS, reviewerProcessData);
        this.context.getScenarioContext().setContext(REVIEW_PROCESS_NAME, reviewerProcessData.getReviewProcessName());
        processesNamesToDelete.add(reviewerProcessData.getReviewProcessName());
        context.getScenarioContext().setContext(REVIEW_PROCESSES_NAMES_LIST, processesNamesToDelete);
        reviewProcessPage.fillInMainBlock(reviewerProcessData);
        reviewProcessPage.selectDefaultReviewer(reviewerProcessData.getDefaultReviewer());
    }

    @When("User fills in Review Process Name {string}")
    public void userFillsInReviewProcessName(String name) {
        reviewProcessPage.fillInName(name);
    }

    @When("User fills in Review Process Default Reviewer {string}")
    public void userFillsInReviewProcessDefaultReviewer(String defaultReviewer) {
        reviewProcessPage.selectDefaultReviewer(defaultReviewer);
    }

    @When("User fills Add Review Process - Review block form with {string} data")
    public void fillReviewProcessReviewBlockForm(String reviewProcessReference) {
        ReviewProcessData reviewerProcessData =
                new JsonUiDataTransfer<ReviewProcessData>(DataProvider.REVIEW_PROCESS).getTestData()
                        .get(reviewProcessReference)
                        .getDataToEnter();
        reviewProcessPage.fillInReviewerBlock(reviewerProcessData);
    }

    @When("User adds {int} Review Process rules with data {string}")
    public void userAddsReviewProcessRulesWithData(int ruleCount, String reviewProcessReference) {
        for (int i = 1; i < ruleCount; i++) {
            reviewProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
            fillReviewProcessReviewBlockForm(reviewProcessReference);
            clickAddReviewButton();
        }
    }

    @When("User fills in Review Process Add Rule For input {string} data")
    public void fillReviewProcessReviewActivityOwner(String addRuleFor) {
        reviewProcessPage.fillInAddRuleFor(addRuleFor);
    }

    @When("User fills Add Review Process form with already created Review Process name with {string} data")
    public void fillReviewProcessFormWithAlreadyCreatedName(String referenceData) {
        ReviewProcessData oldData =
                (ReviewProcessData) this.context.getScenarioContext().getContext(REVIEW_PROCESS);
        ReviewProcessData newData =
                new JsonUiDataTransfer<ReviewProcessData>(DataProvider.REVIEW_PROCESS).getTestData()
                        .get(referenceData)
                        .getDataToEnter();
        ObjectsItem reviewItem = getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW)
                .getObjects()
                .stream()
                .filter(review -> !review.getName().equals(oldData.getReviewProcessName()))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("There is no Review Processes in table"));
        newData.setReviewProcessName(reviewItem.getName());
        String description = AUTO_TEST_NAME_PREFIX + randomUUID();
        newData.setDescription(description);
        oldData.setDescription(description);
        reviewProcessPage.fillInMainBlock(newData);
        reviewProcessPage.selectDefaultReviewer(newData.getDefaultReviewer());
        reviewProcessPage.fillInReviewerBlock(newData);
        if (context.getScenarioContext().isContains(referenceData)) {
            this.context.getScenarioContext().setContext(NEW_REVIEW_NAME, newData.getReviewProcessName());
        } else {
            this.context.getScenarioContext().setContext(OLD_REVIEW_NAME, newData.getReviewProcessName());
        }
        this.context.getScenarioContext().setContext(REVIEW_PROCESS, newData);
    }

    @When("User clears Review Process required fields")
    public void cleanUpReviewProcessRequiredFields() {
        reviewProcessPage.deleteAllSelectedOptionsFromDropdown();
        reviewProcessPage.clearProcessNameInput();
        reviewProcessPage.clearDefaultReviewerInput();
    }

    @When("User clears Review Process Name required fields")
    public void cleanUpReviewProcessName() {
        reviewProcessPage.clearProcessNameInput();
    }

    @When("^User selects in (?:Review Process|Add Reviewer?) Add Rules For dropdown value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueInAddRulesForDropDown(String value, int ruleNumber) {
        reviewProcessPage.selectValueInAddRulesForDropDown(value, ruleNumber);
    }

    @When("^User selects in (?:Review Process|Add Reviewer?) (?:.*?) Value dropdown value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueInActivityOwnerDropDown(String value, int ruleNumber) {
        reviewProcessPage.selectValueInActivityOwnerDD(value, ruleNumber);
    }

    @When("^User selects in Review Process Reviewer dropdown value \"((.*))\" for rule with number (\\d+)$")
    public void selectValueInReviewerDropDown(String value, int ruleNumber) {
        reviewProcessPage.selectValueInReviewerDropDown(value, ruleNumber);
    }

    @When("User clicks Review Process Edit button")
    public void clickReviewProcessEditButton() {
        reviewProcessPage.clickEditButton();
    }

    @When("User hovers Review Process Edit button")
    public void hoverReviewProcessEditButton() {
        reviewProcessPage.hoverEditButton();
    }

    @When("User clicks Review Process {string} Active checkbox")
    public void clickReviewProcess(String state) {
        reviewProcessPage.selectActiveCheckbox(state);
    }

    @When("User deletes all Review Processes with name prefix generated by auto tests via API")
    public void deleteAllReviewProcessesWithNamePrefixGeneratedByAutoTestsViaAPI() {
        getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW).getObjects()
                .forEach(rule -> {
                    if (rule.getName().startsWith(AUTO_TEST_NAME_PREFIX)) {
                        deleteProcessRule(rule.getId());
                    }
                });
    }

    @When("User deletes all Review Processes via API")
    public void deleteAllReviewProcessesViaAPI() {
        getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW).getObjects()
                .forEach(rule -> deleteProcessRule(rule.getId()));
        context.getScenarioContext().setContext(CREATE_DELETED_PROCESS, true);
    }

    @When("User clicks {string} for first Review Process")
    public void clickForFirstReviewProcess(String buttonName) {
        switch (buttonName) {
            case EDIT:
            case DELETE:
                reviewProcessPage.clickTableButton(buttonName);
                break;
            case VIEW:
                reviewProcessPage.clickReviewProcess();
                break;
            default:
                throw new IllegalArgumentException(buttonName + " is incorrect argument");
        }
        reviewProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks Review Process breadcrumb button")
    public void clickReviewProcessBreadcrumbButton() {
        reviewProcessPage.clickReviewProcessBreadcrumb();
    }

    @When("User clicks on Reviewer Process {string} Reviewer Method")
    public void clickOnReviewerProcessReviewerMethod(String methodName) {
        reviewProcessPage.clickReviewerMethod(methodName.replace(SPACE, EMPTY));
    }

    @When("User selects first option for Review Process from {string} drop-down")
    public void userSelectsFirstOptionForReviewProcessFromDropDown(String ruleFor) {
        reviewProcessPage.clickRuleValueInputButton(ruleFor);
        String firstOption = reviewProcessPage.getDropDownOptions().get(0);
        firstOption = firstOption.contains(StringUtils.LF) ? firstOption.split(StringUtils.LF)[0] : firstOption;
        context.getScenarioContext().setContext(RULE_VALUE, firstOption);
        reviewProcessPage.selectRuleValue(ruleFor, firstOption);
    }

    @When("User hovers {string} button for first Review Process")
    public void userHoversEditButtonForFirstReviewProcess(String buttonName) {
        reviewProcessPage.hoverTableButton(buttonName);
    }

    @Then("User should see created Review Process by name")
    public void checkReviewProcessWasCreated() {
        String reviewProcessName = (String) this.context.getScenarioContext().getContext(REVIEW_PROCESS_NAME);
        reviewProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        checkReviewProcessDisplayed(EMPTY, reviewProcessName);
    }

    @Then("User should not see created Review Process by {string} name reference")
    public void checkReviewProcessWasDeleted(String nameReference) {
        String name = (String) this.context.getScenarioContext().getContext(nameReference);
        checkReviewProcessDisplayed(NOT, name);
    }

    @Then("^User (should|should not) see created Review Process by \"((.*))\" name")
    public void checkReviewProcessDisplayed(String state, String name) {
        if (state.contains(NOT)) {
            assertThat(reviewProcessPage.getReviewProcessByName(name))
                    .as(format("Review process with name '%s' was found", name))
                    .isNull();
        } else {
            assertThat(reviewProcessPage.getReviewProcessByName(name))
                    .as(format("Review process with name '%s' was not found", name))
                    .isNotNull();
        }
    }

    @Then("^Review Process with \"((.*))\" name (is not|is) created$")
    public void checkReviewProcessCreated(String name, String state) {
        List<ObjectsItem> objects = getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW).getObjects();
        if (state.contains(NOT)) {
            for (ObjectsItem approvalProcess : objects) {
                if (approvalProcess.getName().equals(name)) {
                    throw new SkipException(name + " already exists!");
                }
            }
        } else {
            assertThat(objects.stream().anyMatch(thirdParty -> thirdParty.getName().equals(name)))
                    .as("Review Process with name: %s is not created", name)
                    .isTrue();
            context.getScenarioContext().setContext(REVIEW_PROCESS_NAME, null);
        }
    }

    @Then("User shouldn't find Review Process by description")
    public void checkReviewProcessByDescriptionWasntFound() {
        ReviewProcessData context = (ReviewProcessData) this.context.getScenarioContext().getContext(REVIEW_PROCESS);
        assertThat(reviewProcessPage.getReviewProcessByDescription(context.getDescription()))
                .as("Review process with description '%s' was found", context.getReviewProcessName())
                .isNull();
    }

    @Then("User should see created Review Process on the top of the list")
    @SuppressWarnings("unchecked")
    public void checkReviewProcessIsOnTheTopOfTheList() {
        reviewProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<ReviewProcessDTO> reviewProcessList =
                (List<ReviewProcessDTO>) this.context.getScenarioContext().getContext(REVIEW_PROCESSES_LIST);
        ReviewProcessData reviewProcessData =
                (ReviewProcessData) this.context.getScenarioContext().getContext(REVIEW_PROCESS);

        if (reviewProcessList != null) {
            assertThat(reviewProcessList.get(0).getName().getText())
                    .as("Created Review Process status is not shown on the top of the list")
                    .isEqualTo(reviewProcessData.getReviewProcessName());
        } else {
            assertThat(reviewProcessPage.getAllReviewerProcesses().get(0).getName().getText())
                    .as("Created Review Process status is not shown on the top of the list")
                    .isEqualTo(reviewProcessData.getReviewProcessName());
        }

    }

    @Then("^Modal '(?:Add|Edit?) review process' button \"(Save|Cancel)\" is displayed")
    public void checkGeneralInformationButtonNotDisplayed(String buttonType) {
        assertThat(reviewProcessPage.isReviewProcessButtonDisplayed(buttonType))
                .as(buttonType + " button is not displayed")
                .isTrue();
    }

    @Then("Review process modal should have Main block fields")
    public void checkReviewProcessMainBlockHasFields(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asList().forEach(text -> soft.assertThat(reviewProcessPage.isReviewProcessMainBlockFieldDisplayed(text))
                .as("Field '" + text + "' isn't shown")
                .isTrue());
        soft.assertAll();
    }

    @Then("Review process modal should have Default Reviewer block fields")
    public void checkReviewProcessDefaultReviewerBlockHasFields(DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asList().forEach(
                text -> soft.assertThat(reviewProcessPage.isReviewProcessDefaultReviewerBlockFieldDisplayed(text))
                        .as("Field '" + text + "' isn't shown")
                        .isTrue());
        soft.assertAll();
    }

    @Then("Review process modal should have fields for Reviewer block {string}")
    public void checkReviewProcessReviewerBlockHasFields(String reviewBlock, DataTable table) {
        SoftAssertions soft = new SoftAssertions();
        table.asList()
                .forEach(text -> soft
                        .assertThat(reviewProcessPage.isReviewProcessReviewerBlockFieldDisplayed(reviewBlock, text))
                        .as("Field '" + text + "' isn't shown")
                        .isTrue());
        soft.assertAll();
    }

    @Then("Review process modal should not have fields for Reviewer block {string}")
    public void checkReviewProcessReviewerBlockHasNotFields(String reviewBlock, DataTable table) {
        SoftAssert soft = new SoftAssert();
        table.asList()
                .forEach(text -> soft
                        .assertFalse(reviewProcessPage.isReviewProcessReviewerBlockFieldDisplayed(reviewBlock, text),
                                     "Field '" + text + "' is shown"));
        soft.assertAll();
    }

    @Then("Review Process Toast message is displayed with text")
    public void reviewProcessToastMessageIsDisplayedWithText(List<String> expectedToastMessage) {
        String actualToastMessage = thirdPartyPage.getAlertIconText();
        assertThat(actualToastMessage).as("Alert Icon is not displayed")
                .isNotNull();
        ReviewProcessData reviewProcessData =
                (ReviewProcessData) this.context.getScenarioContext().getContext(REVIEW_PROCESS);
        expectedToastMessage
                .forEach(text -> {
                             if (text.contains(VALUE_TO_REPLACE)) {
                                 text = text.replace(VALUE_TO_REPLACE, reviewProcessData.getReviewProcessName());
                             }
                             assertThat(actualToastMessage).as("Alert Icon text is unexpected")
                                     .contains(text);
                         }
                );
        thirdPartyPage.closeToastMessageIfDisplayed();
    }

    @Then("^Add Review button should be (enabled|disabled|invisible)$")
    public void addReviewButtonShouldBeDisplayed(String state) {
        if (state.equals(ENABLED)) {
            assertThat(reviewProcessPage.isAddButtonIsActive())
                    .as("Add Review button is not enabled")
                    .isTrue();
        } else if (state.equals(DISABLED)) {
            assertThat(reviewProcessPage.isAddButtonIsActive())
                    .as("Add Review button is not disabled")
                    .isFalse();
        } else {
            assertThat(reviewProcessPage.isAddButtonIsDisplayed())
                    .as("Add Review button is not invisible")
                    .isFalse();
        }
    }

    @Then("Error message 'This field is required' is displayed for the next fields on Review Process form")
    public void isErrorMessageDisplayed(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name ->
                                   softAssert.assertTrue(reviewProcessPage.isErrorMessageDisplayed(name),
                                                         "'This field is required' error message field is not displayed for field " +
                                                                 name));
        softAssert.assertAll();
    }

    @Then("Default Reviewer field contains all Internal Active users in the system")
    public void checkDefaultReviewerAllInternalUsers() {
        List<String> allInternalActiveUsers = getExpectedDropDownOptions(DEFAULT_REVIEWER);
        allInternalActiveUsers.add(DROPDOWN_PLACEHOLDER);
        reviewProcessPage.clickDropDownDefaultReviewer();
        List<String> actualResult = reviewProcessPage.getDropDownOptions();
        assertThat(allInternalActiveUsers)
                .as("Default Reviewer drop-down doesn't contain all active users")
                .containsAll(actualResult);
        reviewProcessPage.clickDropDownDefaultReviewer();
    }

    @Then("Rule Reviewer field contains only Internal Active users in the system")
    public void checkRuleReviewerOnlyInternalUsers() {
        List<String> allInternalActiveUsers = getExpectedDropDownOptions(DEFAULT_REVIEWER);
        allInternalActiveUsers.add(DROPDOWN_PLACEHOLDER);
        reviewProcessPage.clickRuleReviewerInputButton();
        List<String> actualResult = reviewProcessPage.getDropDownOptions();
        assertThat(allInternalActiveUsers)
                .as("Rule Reviewer drop-down doesn't contain only active users")
                .containsAll(actualResult);
        reviewProcessPage.clickRuleReviewerInputButton();
    }

    @Then("Review Process {string} drop-down contains expected values")
    public void checkDropDownInternalUsers(String ruleFor) {
        List<String> expectedResult = getExpectedDropDownOptions(ruleFor);
        reviewProcessPage.clickRuleValueInputButton(ruleFor);
        List<String> actualResult = reviewProcessPage.getDropDownOptions();
        actualResult.remove(DROPDOWN_PLACEHOLDER);
        assertThat(actualResult)
                .as("%s drop-down values are unexpected", ruleFor)
                .isEqualTo(expectedResult);
        reviewProcessPage.clickRuleValueInputButton(ruleFor);
    }

    @Then("Add Reviewer tab 'Add Rules For' dropdown contains for rule with number {int}")
    public void checkValuesAddRulesForDropDown(int ruleNumber, List<String> expectedValues) {
        reviewProcessPage.clickDropDownAddRulesFor(ruleNumber);
        List<String> valuesInDropDown = reviewProcessPage.getDropDownOptions();
        assertThat(valuesInDropDown)
                .as("Add Rules For drop-down doesn't contain expected values: " + expectedValues)
                .containsAll(expectedValues);
    }

    @Then("^(ADD REVIEW PROCESS|Edit) Review Process page is (displayed|disappeared)$")
    public void editReviewProcessModalAppeared(String pageName, String pageState) {
        reviewProcessPage.waitWhilePreloadProgressbarIsDisappeared();
        boolean shouldBeDisplayed = pageState.equals(DISPLAYED.toLowerCase());
        assertThat(reviewProcessPage.isModalDisplayed(pageName))
                .as("Edit Review Process modal doesn't appear")
                .isEqualTo(shouldBeDisplayed);
    }

    @Then("Created Review Process status is {string}")
    public void createdReviewProcessIs(String expectedStatus) {
        ReviewProcessData reviewProcessData =
                (ReviewProcessData) this.context.getScenarioContext().getContext(REVIEW_PROCESS);
        assertThat(reviewProcessPage.getStatusText(reviewProcessData.getReviewProcessName())).as(
                        "Edit Review Process modal doesn't appear")
                .isEqualTo(expectedStatus);
    }

    @Then("^Review Process fields are (enabled|disabled)$")
    public void reviewProcessFieldsAreEnabledAndEditable(String state, List<String> fieldsList) {
        SoftAssertions softAssert = new SoftAssertions();
        fieldsList.forEach(field -> {
                               if (state.equals(ENABLED)) {
                                   softAssert.assertThat(reviewProcessPage.isReviewProcessFieldEnabled(field))
                                           .as(field + " field is not enabled")
                                           .isTrue();
                               } else {
                                   softAssert.assertThat(reviewProcessPage.isReviewProcessFieldEnabled(field))
                                           .as(field + " field is not disabled")
                                           .isFalse();
                               }
                           }
        );
        softAssert.assertAll();
    }

    @Then("Review Process overview page is displayed")
    public void reviewProcessOverviewPageIsDisplayed() {
        reviewProcessPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(reviewProcessPage.isReviewProcessOverviewPageDisplayed())
                .as("Review Process overview page is not displayed")
                .isTrue();
    }

    @Then("Review Process 'Add Review Process' button is displayed")
    public void isAddReviewProcessButtonDisplayed() {
        assertThat(reviewProcessPage.isAddReviewProcessButtonDisplayed())
                .as("Review Process overview page is not displayed")
                .isTrue();
    }

    @Then("^(Active|Inactive|All) Review Processes are displayed or empty table$")
    public void activeReviewProcessesAreDisplayedOrEmptyTable(String status) {
        List<String> expectedTableList;
        switch (status.toLowerCase()) {
            case ACTIVE:
            case INACTIVE:
                expectedTableList = getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW).getObjects()
                        .stream()
                        .filter(process -> process.getStatus().equals(status))
                        .map(ObjectsItem::getName)
                        .limit(10)
                        .collect(Collectors.toList());
                break;
            case TestConstants.ALL:
                expectedTableList = getProcessRules(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, REVIEW).getObjects()
                        .stream()
                        .map(ObjectsItem::getName)
                        .limit(10)
                        .collect(Collectors.toList());
                break;
            default:
                throw new IllegalArgumentException(status + " status is not allowed");
        }
        if (expectedTableList.isEmpty()) {
            reviewProcessesEmptyTableMessageIsDisplayed(NO_AVAILABLE_DATA);
        } else {
            assertThat(reviewProcessPage.getAllReviewerProcessesNames())
                    .as("Review Process table values are unexpected")
                    .isEqualTo(expectedTableList);
        }

    }

    @Then("Review Processes empty table message {string} is displayed")
    public void reviewProcessesEmptyTableMessageIsDisplayed(String expectedMessage) {
        assertThat(reviewProcessPage.getEmptyTableMessage())
                .as("Review Processes empty table message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Review Process table control buttons are displayed for each record")
    public void reviewProcessTableButtonIsDisplayedForEachRecord() {
        SoftAssertions softAssertions = new SoftAssertions();
        reviewProcessPage.getAllReviewerProcessesNames().forEach(
                reviewProcess -> {
                    softAssertions.assertThat(reviewProcessPage.isDeleteReviewProcessButtonDisplayed(reviewProcess))
                            .as("Review Process %s Delete button is not displayed", reviewProcess)
                            .isTrue();
                    softAssertions.assertThat(reviewProcessPage.isEditReviewProcessButtonDisplayed(reviewProcess))
                            .as("Review Process %s Edit button is not displayed", reviewProcess)
                            .isTrue();
                }

        );
        softAssertions.assertAll();
    }

    @Then("Review Process table displays groups sorted by {string} in {string} order")
    public void reviewProcessTableDisplaysGroupsSortedByInOrder(String sortedBy, String order) {
        reviewProcessPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> valuesList = reviewProcessPage.getListValuesForColumn(sortedBy);
        tableIsSortedByInOrder("Review Process", sortedBy, order, REACT_FORMAT, valuesList, false);
    }

    @Then("Review Process view page edit button is displayed")
    public void reviewProcessViewPageEditButtonIsDisplayed() {
        assertThat(reviewProcessPage.isEditButtonDisplayed())
                .as("Review Process view page edit button is not displayed")
                .isTrue();
    }

    @Then("Review Process breadcrumb {string} is displayed")
    public void reviewProcessBreadcrumbIsDisplayed(String expectedText) {
        if (expectedText.contains(REVIEW_PROCESS_NAME)) {
            expectedText = expectedText.replace(REVIEW_PROCESS_NAME,
                                                (String) context.getScenarioContext().getContext(REVIEW_PROCESS_NAME));
        }
        assertThat(reviewProcessPage.getBreadcrumbText())
                .as("Review Process breadcrumb is unexpected")
                .isEqualTo(expectedText.toUpperCase());
    }

    @Then("Review Process Reviewer Method options are displayed")
    public void reviewProcessReviewerMethodOptionsAreDisplayed(List<String> expectedOptions) {
        assertThat(reviewProcessPage.getReviewerMethods())
                .as("Reviewer Method options are unexpected")
                .isEqualTo(expectedOptions);
    }

    @Then("Review Process form page is displayed with populated data")
    public void reviewProcessFormPageIsDisplayedWithPopulatedData() {
        ReviewProcessData expectedResult = (ReviewProcessData) context.getScenarioContext().getContext(REVIEW_PROCESS);
        assertThat(reviewProcessPage.getReviewerProcessDetails())
                .as("Reviewer Method options are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Reviewer Process {string} Reviewer Method is selected")
    public void reviewerProcessReviewerMethodIsSelected(String expectedResult) {
        assertThat(reviewProcessPage.getSelectedReviewerMethod())
                .as("Selected Reviewer Method is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("^Review Process field \"((.*))\" (is|is not) required$")
    public void reviewProcessFieldIsRequired(String fieldName, String state) {
        int elementPosition = 1;
        if (fieldName.equals(RULE_REVIEWER)) {
            elementPosition = 2;
            fieldName = REVIEWER;
        }
        if (state.contains(NOT)) {
            assertThat(reviewProcessPage.getInputFieldIndicator(fieldName, elementPosition))
                    .as("Review Process field %s contains required indicator", fieldName)
                    .isNull();
        } else {
            assertThat(reviewProcessPage.getInputFieldIndicator(fieldName, elementPosition))
                    .as("Review Process field %s doesn't contain required indicator", fieldName)
                    .isEqualTo(REQUIRED_INDICATOR);
        }
    }

    @Then("Review Process Reviewer dropdown contains values")
    public void reviewProcessReviewerDropdownContainsValues(List<String> expectedResult) {
        assertThat(reviewProcessPage.getRuleReviewers())
                .as("Review Process Reviewer dropdown values are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Review Process form contains {int} numerated rules")
    public void reviewProcessFormContainsNumeratedRules(int numberLimit) {
        List<Integer> expectedResult = IntStream.rangeClosed(1, numberLimit).boxed().collect(Collectors.toList());
        assertThat(reviewProcessPage.getRuleNumbers())
                .as("Review Process rule numbers are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Review Process selects option is displayed {string} drop-down")
    public void reviewProcessSelectsOptionIsDisplayedDropDown(String ruleFor) {
        String selectedOption = (String) context.getScenarioContext().getContext(RULE_VALUE);
        assertThat(reviewProcessPage.getRuleValues(ruleFor))
                .as("Review Process %s drop-down value is unexpected", ruleFor)
                .containsOnly(selectedOption);
    }

    @Then("First Review Process {string} button color is expected")
    public void firstReviewProcessButtonColorIsExpected(String buttonName) {
        String actualColor = reviewProcessPage.getTableButtonColor(buttonName);
        String expectedColor;
        switch (buttonName) {
            case EDIT:
                expectedColor = Colors.REACT_BLUE.getColorRgba();
                break;
            case DELETE:
                expectedColor = Colors.REACT_RED.getColorRgba();
                break;
            default:
                throw new IllegalArgumentException(buttonName + " is incorrect argument");
        }
        assertThat(actualColor)
                .as("%s button color is unexpected", buttonName)
                .isEqualTo(expectedColor);
    }

    @Then("Review Process form {string} field max length is {string} symbols")
    public void reviewProcessFormFieldMaxLengthIsSymbols(String fieldName, String expectedLength) {
        assertThat(reviewProcessPage.getInputMaxLength(fieldName))
                .as("Field %s max length is unexpected", fieldName)
                .isEqualTo(expectedLength);
    }

}
