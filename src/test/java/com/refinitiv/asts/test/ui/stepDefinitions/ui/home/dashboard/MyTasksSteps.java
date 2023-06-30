package com.refinitiv.asts.test.ui.stepDefinitions.ui.home.dashboard;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.pageActions.home.dashboard.MyTaskPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DashboardItemData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.DdOrdersData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.Assertions;
import org.testng.SkipException;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.DashboardApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DISPLAYED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.NOT;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.pageActions.home.dashboard.MyTaskPage.RECORD_NAME;
import static com.refinitiv.asts.test.ui.pageActions.home.dashboard.MyTaskPage.*;
import static com.refinitiv.asts.test.ui.pageActions.home.dashboard.MyTaskPage.TYPE;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.Integer.parseInt;
import static java.util.Arrays.asList;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.assertj.core.api.Assertions.assertThat;

public class MyTasksSteps extends BaseSteps {

    private final MyTaskPage myTaskPage;
    private final ScenarioCtxtWrapper context;
    private final static String ASSIGNED_ACTIVITIES = "Assigned Activities";
    private final static String ITEMS_TO_APPROVE = "Items To Approve";
    private final static String ITEMS_TO_REVIEW = "Items To Review";
    private final static String THIRD_PARTY_FOR_RENEWAL = "Third-party for Renewal";
    private final static String DUE_DILIGENCE_ORDERS = "Due Diligence Orders";
    private final static String PENDING_ORDERS_FOR_APPROVAL = "Pending Orders For Approval";

    public MyTasksSteps(ScenarioCtxtWrapper context) {
        this.context = context;
        myTaskPage = new MyTaskPage(this.driver, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public DashboardItemData dashboardItemEntry(Map<String, String> entry) {
        return DashboardItemData.builder()
                .thirdPartyName(getThirdPartyName())
                .activityName(entry.get(ACTIVITY_NAME))
                .questionnaireName(entry.get(QUESTIONNAIRE_NAME))
                .description(entry.get(DESCRIPTION))
                .questionnaireDescription(entry.get(QUESTIONNAIRE_DESCRIPTION))
                .dueDate(getDate(entry.get(DUE_DATE)))
                .questionnaireDueDate(getDate(entry.get(QUESTIONNAIRE_DUE_DATE)))
                .renewalDate(entry.get(RENEWAL_DATE))
                .assignedTo(entry.get(ASSIGNED_TO))
                .reviewerName(entry.get(REVIEWER_NAME))
                .responsibleParty(entry.get(RESPONSIBLE_PARTY))
                .renewalAssignee(entry.get(RENEWAL_ASSIGNEE))
                .status(entry.get(STATUS))
                .questionnaireStatus(entry.get(QUESTIONNAIRE_STATUS))
                .type(entry.get(TYPE))
                .recordName(getRecordName(entry.get(RECORD_NAME)))
                .reviewer(entry.get(REVIEWER))
                .build();
    }

    private String getThirdPartyName() {
        ThirdPartyData supplierData =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        return supplierData.getName();
    }

    private String getDate(String date) {
        return nonNull(date) ? getDateAfterTodayDate(REACT_FORMAT, parseInt(
                date.replace(TODAY, EMPTY))) : null;
    }

    private String getRecordName(String entry) {
        return nonNull(entry) ? (String) context.getScenarioContext().getContext(entry) : null;
    }

    @When("User clicks on assigned activity with name {string}")
    public void clickAssignedActivity(String name) {
        myTaskPage.clickActivityRow(name);
    }

    @When("User clicks on assigned activity for created Third-party with name reference {string}")
    public void clickAssignedActivityNameReference(String nameReference) {
        String thirdPartyName =
                (String) this.context.getScenarioContext().getContext(ContextConstants.THIRD_PARTY_NAME);
        String recordName = (String) context.getScenarioContext().getContext(nameReference);
        myTaskPage.clickRowForThirdParty(thirdPartyName, recordName);
    }

    @When("User clicks on assigned activity for created third-party")
    public void clickAssignedActivityForCreatedThirdParty() {
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        clickAssignedActivity(thirdPartyData.getName());
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on assigned activity with name {string} for created third-party")
    public void clickAssignedActivityWithNameForCreatedThirdParty(String activityName) {
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        myTaskPage.clickActivityRowWithNames(thirdPartyData.getName(), activityName);
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on record {string} for created third-party")
    public void clickItemToReviewForCreatedThirdParty(String itemToReview) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        myTaskPage.clickLastPageIfDisplayed();
        myTaskPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) this.context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        String thirdPartyName = thirdPartyData.getName();
        myTaskPage.clickRowForThirdParty(thirdPartyName, itemToReview);
    }

    @When("User clicks first activity for third-party {string}")
    public void clickActivitiesForThirdParty(String thirdPartyName) {
        if (thirdPartyName.equals(ContextConstants.THIRD_PARTY_NAME)) {
            thirdPartyName = (String) this.context.getScenarioContext().getContext(ContextConstants.THIRD_PARTY_NAME);
        }
        myTaskPage.clickActivityRow(thirdPartyName);
    }

    @When("^User selects Items to Review (Activity|Screening|Questionnaire)$")
    public void selectItemsToReviewActivity(String option) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        myTaskPage.clickItemToReviewOptions();
        myTaskPage.selectItemsToReviewDropDown(option);
    }

    @When("User selects first Due Diligence Order")
    public void selectDueDiligenceOrder() {
        myTaskPage.clickFirstDueDiligenceOrder();
    }

    @When("User selects first Item to Approve")
    public void selectItemToApprove() {
        myTaskPage.clickFirstItemToApprove();
    }

    @When("User selects created Due Diligence Order")
    public void selectCreatedDueDiligenceOrder() {
        String orderId = (String) context.getScenarioContext().getContext(ORDER_ID);
        myTaskPage.clickActivityRow(orderId);
    }

    @When("^User clicks '(.*)' widget$")
    public void clickWidgetWithName(String widgetName) {
        myTaskPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        switch (widgetName) {
            case ASSIGNED_ACTIVITIES:
                myTaskPage.clickAssignedActivities();
                break;
            case ITEMS_TO_APPROVE:
                myTaskPage.clickItemsToApprove();
                break;
            case ITEMS_TO_REVIEW:
                myTaskPage.clickItemToReview();
                break;
            case THIRD_PARTY_FOR_RENEWAL:
                myTaskPage.clickThirdPartyForRenewalWidget();
                break;
            case DUE_DILIGENCE_ORDERS:
                myTaskPage.clickDueDiligence();
                break;
            case PENDING_ORDERS_FOR_APPROVAL:
                myTaskPage.clickPendingOrderForApproval();
                break;
            default:
                throw new IllegalArgumentException(widgetName + " is widget name is not expected");
        }
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User selects My Tasks tab")
    public void selectMyTasksTab() {
        myTaskPage.selectMyTasksTab();
    }

    @When("Users clicks {string} dashboard table column header")
    public void clickDashboardTableColumnHeader(String columnName) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        myTaskPage.clickOnTableColumn(myTaskPage.getFromDictionaryIfExists(columnName));
    }

    @When("Users clicks first My Tasks table page")
    public void clickFirstDashboardTablePage() {
        myTaskPage.clickFirstPageIfDisplayed();
    }

    @When("User clicks Activity from 'Pending Order for Approval' table")
    public void clickPendingOrderForApprovalTab() {
        String orderId = (String) context.getScenarioContext().getContext(ORDER_ID);
        myTaskPage.clickActivityRow(orderId);
    }

    @When("User hovers over {string} widget")
    public void hoverOverWidget(String widgetName) {
        myTaskPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        myTaskPage.hoverOverWidget(widgetName);
    }

    @Then("^Dashboard (Assigned Activities|Items To Approve|Items To Review|Due Diligence Orders|Third-party for Renewal|Pending Orders For Approval) table is displayed with column names$")
    public void otherNameTableIsDisplayedWithColumnNames(String tableName, DataTable dataTable) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(myTaskPage.getTableColumnNameList())
                .as("%s table is not displayed expected column names", tableName)
                .isEqualTo(dataTable.asList());
    }

    @Then("^Assigned Activity for third-party (is displayed|is not displayed)$")
    public void assignedActivityIsDisplayed(String state) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        ThirdPartyData supplier = (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        if (state.contains(NOT)) {
            assertThat(myTaskPage.isActivityDisplayed(supplier.getName()))
                    .as("Assigned Activity for supplier: '%s' is still displayed", supplier.getName())
                    .isFalse();
        } else {
            assertThat(myTaskPage.isActivityDisplayed(supplier.getName()))
                    .as("Assigned Activity for supplier: '%s' is not displayed", supplier.getName())
                    .isTrue();
        }
    }

    @Then("^Items to Review table (contains|doesn't contain) activity$")
    public void itemsToReviewTableContainsActivity(String activityState, DashboardItemData expectedResult) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        myTaskPage.clickLastPageIfDisplayed();
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        List<DashboardItemData> actualResult = myTaskPage.getItemsToReviewTableRows(activityState.equals(CONTAINS));
        if (activityState.equals(CONTAINS)) {
            assertThat(actualResult)
                    .as("Activity Information modal doesn't contain expected details")
                    .usingRecursiveComparison().ignoringExpectedNullFields().asList().contains(expectedResult);
        } else {
            assertThat(actualResult)
                    .as("Activity Information modal doesn't contain expected details")
                    .usingRecursiveComparison().ignoringExpectedNullFields().asList().doesNotContain(expectedResult);
        }

    }

    @Then("^Items to Review table (contains|doesn't contain) activities$")
    public void itemsToReviewTableContainsActivities(String activityState, List<DashboardItemData> expectedResult) {
        myTaskPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<DashboardItemData> actualResult = myTaskPage.getAllItemsToReviewTableRows(activityState.equals(CONTAINS));
        if (activityState.equals(CONTAINS)) {
            assertThat(actualResult)
                    .as("Activity Information modal doesn't contain expected details")
                    .usingRecursiveComparison().ignoringExpectedNullFields().asList().containsAll(expectedResult);
        } else {
            assertThat(actualResult)
                    .as("Activity Information modal doesn't contain expected details")
                    .usingRecursiveComparison().ignoringExpectedNullFields().asList()
                    .doesNotContainAnyElementsOf(expectedResult);
        }
    }

    @Then("Status column has {string} status values")
    public void verifyStatusColumnValues(String expectedStatus) {
        for (String actualStatus : myTaskPage.getItemsToApproveStatusTableColumnNameList()) {
            assertThat(actualStatus)
                    .as("Status column displays unexpected text")
                    .isEqualTo(expectedStatus);
        }
    }

    @Then("OnlyFor Renewal status is displayed {string}")
    public void forRenewalStatusIsDisplayed(String expectedStatus) {
        for (String actualStatus : myTaskPage.getSupplierForRenewalStatusTableColumnNameList()) {
            assertThat(actualStatus)
                    .as("Renewal 'Status' column displays unexpected text")
                    .isEqualTo(expectedStatus);
        }
    }

    @Then("Items To Review widget's counter displays sum of all items")
    public void itemsToReviewWidgetSCounterDisplaysExpectedCount() {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        myTaskPage.clickFirstPageIfDisplayed();
        selectItemsToReviewActivity(ACTIVITY);
        int expectedCount = myTaskPage.getTableRowCount();
        selectItemsToReviewActivity(QUESTIONNAIRE);
        expectedCount += myTaskPage.getTableRowCount();
        selectItemsToReviewActivity(SCREENING);
        expectedCount += myTaskPage.getTableRowCount();
        assertThat(myTaskPage.getItemsToReviewCounter()).
                as("Items To Review widget's counter doesn't display expected count")
                .isEqualTo(expectedCount);
    }

    @Then("Third-party for Renewal widget's counter displays expected count")
    public void thirdPartyForRenewalWidgetSCounterDisplaysExpectedCount() {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        int expectedCount = myTaskPage.getTableRowCount();
        assertThat(myTaskPage.getThirdPartyForRenewalCounter()).
                as("Third-party for Renewal widget's counter doesn't display expected count")
                .isEqualTo(expectedCount);
    }

    @Then("^Third-party for Renewal table (contains|doesn't contain) third-party$")
    public void thirdPartyForRenewalTableContainsThirdParty(String thirdPartyState, DashboardItemData expectedResult) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        ThirdPartyData supplierData =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        if (thirdPartyState.equals(CONTAINS)) {
            assertThat(myTaskPage.isActivityDisplayed(supplierData.getName()))
                    .as("Third-party for Renewal: '%s' is not displayed", supplierData.getName())
                    .isTrue();
        } else {
            assertThat(myTaskPage.isActivityDisplayed(supplierData.getName()))
                    .as("Third-party for Renewal: '%s' is displayed", supplierData.getName())
                    .isFalse();
        }
    }

    @Then("^Dashboard table is (not displayed|displayed)$")
    public void thirdPartyForRenewalTableIsNotDisplayed(String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.isDashboardTableDisplayed())
                    .as("Dashboard table is displayed")
                    .isFalse();
        } else {
            assertThat(myTaskPage.isDashboardTableDisplayed())
                    .as("Dashboard table is not displayed")
                    .isTrue();
        }
    }

    @Then("{string} table displays records sorted by {string} in {string} order")
    public void tableDisplaysRecordsSortedByInOrder(String tableName, String columnName, String sortOrder) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        List<String> valuesList = myTaskPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder(tableName, columnName, sortOrder, DATE_OF_INCORPORATION_FORMAT, valuesList, true);
    }

    @Then("Due Diligence Orders count is as expected for logged in user")
    public void ddOrdersCountIsAsExpected() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int expectedCount = getAssignedDDOrders(userName).size();
        assertThat(myTaskPage.getDDOrdersWidgetCounter())
                .as("Orders count is incorrect")
                .isEqualTo(expectedCount)
                .isEqualTo(myTaskPage.getTableRowCount());
    }

    @Then("Dashboard Due Diligence Orders widget counter contains {int} count")
    public void dashboardDueDiligenceOrderRequestWidgetCounterContainsCount(int expectedCount) {
        assertThat(myTaskPage.getDDOrdersWidgetCounter())
                .as("Pending Orders For Approval widget count is unexpected")
                .isEqualTo(expectedCount);
    }

    @Then("Due Diligence Orders requested by User are displayed in table")
    public void ddOrdersAreDisplayedInTable() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        List<DdOrdersData.DdOrderDashboard> expectedOrders = getAssignedDDOrders(userName);
        List<DdOrdersData.DdOrderDashboard> actualOrders = myTaskPage.getAllDdOrdersTable();
        assertThat(actualOrders).usingRecursiveComparison().ignoringCollectionOrder()
                .as("Actual orders are not equal to expected ones")
                .isEqualTo(expectedOrders);
    }

    @Then("Counter for Items to Approve is displayed")
    public void isCounterForItemsToApproveDisplayed() {
        assertThat(myTaskPage.getWidgetItemsToApproveCounter())
                .as("Items to Approve widget counter is not displayed!")
                .isNotNull();
        context.getScenarioContext()
                .setContext(ITEMS_TO_APPROVE_COUNTER, myTaskPage.getWidgetItemsToApproveCounter());
    }

    @Then("Activity is excluded from Items to Approve counter")
    public void isExpectedNumberOfItemsDisplayedForItemsToApprove() {
        String previousNumberOfItems = (String) context.getScenarioContext().getContext(ITEMS_TO_APPROVE_COUNTER);
        String expectedNumberOfItems = String.valueOf(Integer.parseInt(previousNumberOfItems) - 1);
        String actualNumberOfItems = myTaskPage.getWidgetItemsToApproveCounter();
        assertThat(actualNumberOfItems)
                .as("Activity is not excluded from Items to Approve counter!")
                .isEqualTo(expectedNumberOfItems);
    }

    @Then("Last {int} Activities are excluded from Assigned Activities counter")
    public void activityIsExcludedFromAssignedActivities(int count) {
        int previousNumberOfItems = (int) context.getScenarioContext().getContext(ASSIGNED_ACTIVITIES_COUNTER);
        int expectedNumberOfItems = previousNumberOfItems - count;
        myTaskPage.waitUntilAssignedActivitiesCounterRefreshed();
        int actualNumberOfItems = myTaskPage.getAssignedActivitiesCounter();
        assertThat(actualNumberOfItems)
                .as("Activity are not excluded from Assigned Activities counter!")
                .isEqualTo(expectedNumberOfItems);
    }

    @Then("Counter for Pending Orders For Approval is displayed")
    public void isCounterForPendingOrdersForApprovalDisplayed() {
        assertThat(myTaskPage.getWidgetPendingOrdersForApprovalCounter())
                .as("Pending Orders For Approval widget counter is not displayed")
                .isNotNull();
        context.getScenarioContext()
                .setContext(PENDING_ORDERS_FOR_APPROVAL_COUNTER, myTaskPage.getWidgetPendingOrdersForApprovalCounter());
    }

    @Then("Counter for Assigned Activities is displayed")
    public void counterForAssignedActivitiesIsDisplayed() {
    assertThat(myTaskPage.getAssignedActivitiesCounter())
                .as("Assigned Activities widget counter is not displayed")
                .isGreaterThanOrEqualTo(0);
        context.getScenarioContext()
                .setContext(ASSIGNED_ACTIVITIES_COUNTER, myTaskPage.getAssignedActivitiesCounter());
    }

    @Then("Activity is excluded from Pending Orders For Approval counter")
    public void isExpectedNumberOfItemsDisplayedForPendingOrdersForApproval() {
        String previousNumberOfItems =
                (String) context.getScenarioContext().getContext(PENDING_ORDERS_FOR_APPROVAL_COUNTER);
        String expectedNumberOfItems = String.valueOf(Integer.parseInt(previousNumberOfItems) - 1);
        String actualNumberOfItems = myTaskPage.getWidgetPendingOrdersForApprovalCounter();
        assertThat(actualNumberOfItems)
                .as("Activity is not excluded from Items to Approve counter")
                .isEqualTo(expectedNumberOfItems);

    }

    @Then("Dashboard of Internal Users is displayed with the following tabs")
    public void dashboardOfInternalUsersIsDisplayedWithTheFollowingTabs(List<String> expectedTabs) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(myTaskPage.getDashboardTabs())
                .as("Dashboard of Internal Users tabs are unexpected")
                .isEqualTo(expectedTabs);
    }

    @Then("My Tasks tabs is displayed with the following widget")
    public void myTasksTabsIsDisplayedWithTheFollowingWidget(List<String> expectedWidgets) {
        assertThat(myTaskPage.getDashboardWidgets())
                .as("Dashboard widgets are unexpected")
                .isEqualTo(expectedWidgets);
    }

    @Then("^Dashboard \"((.*))\" widget is (disabled|enabled)$")
    public void dashboardItemsToApproveWidgetIsDisabled(String widget, String widgetState) {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        if (widgetState.equals(DISABLED)) {
            assertThat(myTaskPage.isWidgetDisabled(widget)).as("%s widget is not disabled", widget).isTrue();
        } else {
            assertThat(myTaskPage.isWidgetEnabled(widget)).as("%s widget is not enabled", widget).isTrue();
        }
    }

    @Then("^Dashboard Assigned Activities widget is (disabled|enabled)$")
    public void dashboardAssignedActivitiesWidgetIsEnabled(String widgetState) {
        boolean result = myTaskPage.isAssignedActivitiesWidgetDisabled();
        if (widgetState.equals(DISABLED)) {
            assertThat(result).as("Assigned Activities widget is not disabled").isTrue();
        } else {
            assertThat(result).as("Assigned Activities widget is not enabled").isFalse();
        }
    }

    @Then("^Dashboard Due Diligence Orders widget is (disabled|enabled)$")
    public void dashboardDueDiligenceOrderRequestWidgetIsDisabled(String widgetState) {
        boolean result = myTaskPage.isDueDiligenceOrderWidgetDisabled();
        if (widgetState.equals(DISABLED)) {
            assertThat(result).as("Due Diligence Order Request widget is not disabled").isTrue();
        } else {
            assertThat(result).as("Due Diligence Order Request widget is not enabled").isFalse();
        }
    }

    @Then("Dashboard Pending Orders For Approval widget counter displayed with expected count")
    public void dashboardPendingOrdersForApprovalWidgetCounterDisplayedWithExpectedCount() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int expectedCount = getOrderForApproval(userName).getPayload().getPageInformation().getTotalRecords();
        assertThat(Integer.parseInt(myTaskPage.getWidgetPendingOrdersForApprovalCounter().replace(COMMA, EMPTY)))
                .as("Pending Orders For Approval widget count is unexpected")
                .isEqualTo(expectedCount);
    }

    @Then("Dashboard Assigned Activities widget counter displayed with expected count")
    public void dashboardAssignedActivitiesWidgetCounterDisplayedWithExpectedCount() {
        myTaskPage.waitWhilePreloadProgressbarIsDisappeared();
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int expectedCount = getAssignedActivities(userName).getPayload().getPageInformation().getTotalRecords();
        assertThat(myTaskPage.getAssignedActivitiesCounter())
                .as("Pending Orders For Approval widget count is unexpected")
                .isEqualTo(expectedCount);
    }

    @Then("^(?:Pending Due Diligence Order|Due Diligence Order) is (displayed in|removed from) the list$")
    public void isPendingDueDiligenceOrderRemoved(String orderState) {
        String orderId = (String) context.getScenarioContext().getContext(ORDER_ID);
        boolean isDisplayed = orderState.contains(DISPLAYED.toLowerCase());
        assertThat(myTaskPage.isDueDiligenceOrderDisplayed(orderId))
                .as("Due Diligence Order is not %s table", orderState)
                .isEqualTo(isDisplayed);
    }

    @Then("Skip Assigned Activities creation if already exists")
    public void checkAssignedActivities() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int activitiesCount = getAssignedActivities(userName).getPayload().getPageInformation().getTotalRecords();
        if (activitiesCount > 0) {
            throw new SkipException(String.format("Activities already exist for user %s", userName));
        }
    }

    @Then("Skip Items to Approve creation if already exists")
    public void checkItemsToApprove() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int itemsToApproveCount = getItemsToApprove(userName).getPayload().getPageInformation().getTotalRecords();
        int itemsToReviewCount = getItemsToReview(userName).getPayload().getPageInformation().getTotalRecords();
        if (itemsToApproveCount > 0 && itemsToReviewCount > 0) {
            throw new SkipException(String.format("Items to Approve already exist for user %s", userName));
        }
    }

    @Then("Skip Orders to Approve creation if already exists")
    public void checkOrdersToApprove() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int ordersToApproveCount = getOrderForApproval(userName).getPayload().getPageInformation().getTotalRecords();
        if (ordersToApproveCount > 0) {
            throw new SkipException(String.format("Orders to Approve already exist for user %s", userName));
        }
    }

    @Then("Skip DD Orders creation if already exists")
    public void checkDashboardDDOrders() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int assignedDDOrdersCount = getAssignedDDOrders(userName).size();
        if (assignedDDOrdersCount > 0) {
            throw new SkipException(String.format("Assigned DD Orders already exist for user %s", userName));
        }
    }

    @Then("Skip Screening items to review creation if already exists")
    public void checkScreeningItemsToReview() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int screeningItemsToReview =
                getScreeningItemsToReview(userName).getPayload().getPageInformation().getTotalRecords();
        if (screeningItemsToReview > 0) {
            throw new SkipException(String.format("Screening Items to Review already exist for user %s", userName));
        }
    }

    @Then("Skip Questionnaire items to review creation if already exists")
    public void checkQuestionnaireItemsToReview() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int questionnaireItemsToReview =
                getQuestionnaireItemsToReview(userName).getPayload().getPageInformation().getTotalRecords();
        if (questionnaireItemsToReview > 0) {
            throw new SkipException(String.format("Questionnaire Items to Review already exist for user %s", userName));
        }
    }

    @Then("Skip Third-party for Renewal creation if already exists")
    public void checkThirdPartyForRenewal() {
        String userName = ((UserData) this.context.getScenarioContext().getContext(USER_DATA)).getUsername();
        int thirdPartyForRenewalCount =
                getThirdPartyForRenewal(userName).getPayload().getPageInformation().getTotalRecords();
        if (thirdPartyForRenewalCount > 0) {
            throw new SkipException(String.format("Third-parties for Renewal already exist for user %s", userName));
        }
    }

    @Then("^Dashboard Due Diligence Orders widget (is|is not) in clicked color$")
    public void dashboardDueDiligenceOrdersWidgetIsInClickedColor(String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.getDueDiligenceOrdersColor())
                    .as("Dashboard Due Diligence Orders widget color is unexpected")
                    .isEqualTo(DASHBOARD_GREY.getColorRgba());
        } else {
            assertThat(myTaskPage.getDueDiligenceOrdersColor())
                    .as("Dashboard Due Diligence Orders widget color is unexpected")
                    .isEqualTo(DARK_BLUE.getColorRgba());
        }
    }

    @Then("^Dashboard Items To Approve widget (is|is not) in clicked color$")
    public void dashboardItemsToApproveWidgetIsInClickedColor(String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.getItemsToApproveColor())
                    .as("Dashboard Items To Approve widget color is unexpected")
                    .isEqualTo(DASHBOARD_GREY.getColorRgba());
        } else {
            assertThat(myTaskPage.getItemsToApproveColor())
                    .as("Dashboard Items To Approve widget color is unexpected")
                    .isEqualTo(DARK_BLUE.getColorRgba());
        }
    }

    @Then("^Dashboard Items To Review widget (is|is not) in clicked color$")
    public void dashboardItemsToReviewWidgetIsInClickedColor(String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.getItemsToReviewColor())
                    .as("Dashboard Items To Review widget color is unexpected")
                    .isEqualTo(DASHBOARD_GREY.getColorRgba());
        } else {
            assertThat(myTaskPage.getItemsToReviewColor())
                    .as("Dashboard Items To Review widget color is unexpected")
                    .isEqualTo(DARK_BLUE.getColorRgba());
        }
    }

    @Then("^Dashboard Third-party for Renewal widget (is|is not) in clicked color$")
    public void dashboardThirdPartyForRenewalWidgetIsInClickedColor(String state) {
        myTaskPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.contains(NOT)) {
            assertThat(myTaskPage.getThirdPartyForRenewalColor())
                    .as("Dashboard Third-party for Renewal widget color is unexpected")
                    .isEqualTo(DASHBOARD_GREY.getColorRgba());
        } else {
            assertThat(myTaskPage.getThirdPartyForRenewalColor())
                    .as("Dashboard Third-party for Renewal widget color is unexpected")
                    .isEqualTo(DARK_BLUE.getColorRgba());
        }
    }

    @Then("^Dashboard Pending Orders for Approval widget (is|is not) in clicked color$")
    public void dashboardPendingOrdersForApprovalWidgetIsInClickedColor(String state) {
        myTaskPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (state.contains(NOT)) {
            assertThat(myTaskPage.getPendingOrdersForApprovalColor())
                    .as("Dashboard Pending Orders for Approval widget color is unexpected")
                    .isEqualTo(DASHBOARD_GREY.getColorRgba());
        } else {
            assertThat(myTaskPage.getPendingOrdersForApprovalColor())
                    .as("Dashboard Pending Orders for Approval widget color is unexpected")
                    .isEqualTo(DARK_BLUE.getColorRgba());
        }
    }

    @Then("^Dashboard Assigned Activities widget (is|is not) in clicked color$")
    public void dashboardAssignedActivitiesWidgetIsInClickedColor(String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.getAssignedActivitiesColor())
                    .as("Assigned Activities widget color is unexpected")
                    .isEqualTo(DASHBOARD_GREY.getColorRgba());
        } else {
            assertThat(myTaskPage.getAssignedActivitiesColor())
                    .as("Assigned Activities widget color is unexpected")
                    .isEqualTo(DARK_BLUE.getColorRgba());
        }
    }

    @Then("Dashboard table name is {string}")
    public void dashboardTableNameIs(String expectedResult) {
        assertThat(myTaskPage.getDashboardTableName())
                .as("Dashboard table name is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("^Dashboard widget chevron (is|is not) displayed$")
    public void dashboardWidgetChevronIsDisplayed(String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.isDashboardWidgetChevronDisplayed())
                    .as("Dashboard widget chevron is displayed")
                    .isFalse();
        } else {
            assertThat(myTaskPage.isDashboardWidgetChevronDisplayed())
                    .as("Dashboard widget chevron is not displayed")
                    .isTrue();
        }
    }

    @Then("Dashboard drop-down option {string} is selected")
    public void dashboardDropDownOptionIsSelected(String expectedResult) {
        assertThat(myTaskPage.getItemToReviewSelectedOption())
                .as("Selected Dashboard drop-down option is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Dashboard drop-down options are expected")
    public void dashboardDropDownOptionsAreExpected(List<String> expectedResult) {
        myTaskPage.clickItemToReviewOptions();
        assertThat(myTaskPage.getItemToReviewOptions())
                .as("Dashboard drop-down options are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("Dashboard selected drop-down option is highlighted with grey color")
    public void dashboardSelectedDropDownOptionIsHighlightedWithGreyColor() {
        assertThat(myTaskPage.getSelectedOptionBackground())
                .as("Selected drop-down option is not highlighted")
                .isEqualTo(DASHBOARD_DROP_DOWN_GREY.getColorRgba());
    }

    @Then("Dashboard table message {string} is displayed")
    public void dashboardTableMessageIsDisplayed(String expectedResult) {
        assertThat(myTaskPage.getDashboardTableMessage())
                .as("Dashboard table message is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("My Tasks {string} widget is in disabled color")
    public void myTasksWidgetIsInDisabledColor(String widgetName) {
        assertThat(myTaskPage.getWidgetColor(widgetName))
                .as("%s widget color is unexpected", widgetName)
                .isEqualTo(DASHBOARD_DISABLED_GREY.getColorRgba());
    }

    @Then("^Dashboard \"((.*))\" widget chevron (is not|is) displayed$")
    public void dashboardWidgetChevronIsNotDisplayed(String widgetName, String state) {
        if (state.contains(NOT)) {
            assertThat(myTaskPage.isDashboardWidgetChevronDisplayed(widgetName))
                    .as("Dashboard %s widget chevron is displayed", widgetName)
                    .isFalse();
        } else {
            assertThat(myTaskPage.isDashboardWidgetChevronDisplayed(widgetName))
                    .as("Dashboard %s widget chevron is not displayed", widgetName)
                    .isTrue();
        }
    }

    @Then("Dashboard Due Diligence Order table contains only expected order's statuses")
    public void dashboardDueDiligenceOrderTableContainsOnlyExpectedOrderSStatuses() {
        List<String> expectedStatuses = asList("New", "In Progress", "On Hold");
        List<String> unexpectedStatuses = asList("Save As Draft", "Pending", "Declined to Order",
                                                 "Cancelled with Charges", "Cancelled without Charges", "Completed");
        List<String> actualResult = myTaskPage.getAllOrdersStatuses();
        assertThat(actualResult).as("Due Diligence Order statuses are unexpected")
                .containsAnyElementsOf(expectedStatuses)
                .doesNotContainAnyElementsOf(unexpectedStatuses);
    }

    @Then("Assigned activities widget column Status contains expected values")
    public void assignedActivitiesWidgetColumnStatusContains() {
        List<String> expected = List.of("Not Started", "In Progress", "Deferral", "Waiting");
        List<String> notExpected = List.of("Done", "Completed");
        List<String> actual = myTaskPage.getAllAssignedActivities().stream()
                .map(DashboardItemData::getStatus)
                .collect(Collectors.toList());
        Assertions.assertThat(actual)
                .as("Actual statuses list doesn't contain expected ones")
                .containsAnyElementsOf(expected);
        Assertions.assertThat(actual)
                .as("Actual statuses list contain not expected ones")
                .doesNotContain(notExpected.toArray(String[]::new));
    }

    @Then("Dashboard Items To Review table contains only expected questionnaire's statuses")
    public void dashboardItemsToReviewTableContainsOnlyExpectedQuestionnaireStatuses() {
        List<String> expectedStatuses = asList("Submitted", "In Review", "Revision Submitted");
        List<String> actualResult = myTaskPage.getAllQuestionnaireStatuses();
        assertThat(actualResult).as("Due Diligence Order statuses are unexpected")
                .containsAnyElementsOf(expectedStatuses);
    }

}
