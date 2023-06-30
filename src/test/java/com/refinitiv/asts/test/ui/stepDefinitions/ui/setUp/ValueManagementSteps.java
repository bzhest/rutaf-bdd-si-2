package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.api.model.valueManagement.RefDataResponse;
import com.refinitiv.asts.test.ui.api.model.valueManagement.Value;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.ValueTypeName;
import com.refinitiv.asts.test.ui.pageActions.setUp.ValueManagementPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.ValueData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.text.DecimalFormat;
import java.text.Normalizer;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getTenantFeatureManagement;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.getRiskScoreEngineReference;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CURRENCY;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.VALUE;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.ORGANISATION_SIZE;
import static com.refinitiv.asts.test.ui.enums.ValueTypeName.*;
import static com.refinitiv.asts.test.ui.pageActions.setUp.ValueManagementPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.DATE_OF_INCORPORATION_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static java.util.Arrays.stream;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.Assert.assertEquals;

public class ValueManagementSteps extends BaseSteps {

    private final ValueManagementPage valueManagementPage;
    private final List<String> valueNamesToDelete = new ArrayList<>();
    private String from;
    private String to;

    public ValueManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        valueManagementPage = new ValueManagementPage(this.driver, this.context, this.translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public ValueData attachmentEntry(Map<String, String> entry) {
        return new ValueData().setValue(updateValueName(entry.get(ValueManagementPage.VALUE.toUpperCase())))
                .setDateCreated(updateDate(entry.get(DATE_CREATED.toUpperCase())))
                .setLastUpdate(updateDate(entry.get(LAST_UPDATED.toUpperCase())))
                .setName(updateValueName(entry.get(ValueManagementPage.NAME.toUpperCase())))
                .setScoringRange(updateScoringRange(entry.get(SCORING_RANGE.toUpperCase())));
    }

    private String updateDate(String date) {
        if (nonNull(date)) {
            return getTodayDate(date);
        }
        return null;
    }

    private String updateValueName(String valueName) {
        if (nonNull(valueName) && valueName.contains(VALUE_TO_REPLACE)) {
            return (String) context.getScenarioContext().getContext(valueName);
        }
        return valueName;
    }

    private String updateScoringRange(String scoringRange) {
        if (nonNull(scoringRange)) {
            return scoringRange.replace(FROM, from).replace(TO, to);
        }
        return null;
    }

    private List<Double> getListOfRiskScoringRangesThatMatchCondition(RefDataResponse riskRanges,
            Function<Value, Double> func) {
        return Arrays.stream(riskRanges.getListValues()).map(func).collect(Collectors.toList());
    }

    private List<String> getListOfDoubleValuesInSetRange(double min, double max) {
        DecimalFormat df = new DecimalFormat("#.##");
        List<String> listValues = new ArrayList<>();
        while (min <= max) {
            listValues.add(df.format(min));
            min = Double.parseDouble(df.format((min + 0.1)));
        }
        return listValues;
    }

    @When("User opens Value Management page")
    public void clickValueManagement() {
        valueManagementPage.clickValueManagementTab();
    }

    @When("User navigates to Value Management page")
    public void navigateToValueManagement() {
        valueManagementPage.navigateToValueManagement();
    }

    @When("User navigates to 'Value Management' activity type")
    public void openActivityType() {
        String activityTypeId = (String) context.getScenarioContext().getContext(ACTIVITY_TYPE_ID);
        valueManagementPage.navigateToValueManagementActivityType(activityTypeId);
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks {string} value")
    public void clickOnValue(String fieldName) {
        valueManagementPage.clickItem(fieldName);
        context.getScenarioContext().setContext(VALUE_CATEGORY_ID, getValueType(fieldName));
    }

    /**
     * Method retrieves a list of all existing Risk Scoring Ranges via API
     * Removes all booked ranges
     * Fills in first vacant Risk Scoring Range to Add modal
     * Throws NoSuchElementException if no available ranges are left
     */
    @When("User fills in Risk Scoring Range using API")
    public void fillInRiskScoringRange() {
        double minPossible = 0;
        double maxPossible = 5;
        RefDataResponse valueType = (RefDataResponse) context.getScenarioContext().getContext(VALUE_CATEGORY_ID);
        RefDataResponse riskRanges = getRefDataPayload(valueType.get_id());
        List<String> testValues = getListOfDoubleValuesInSetRange(minPossible, maxPossible);
        List<Double> listOfMinValues = getListOfRiskScoringRangesThatMatchCondition(riskRanges, Value::getMin);
        List<Double> listOfMaxValues = getListOfRiskScoringRangesThatMatchCondition(riskRanges, Value::getMax);

        IntStream.range(0, listOfMinValues.size())
                .mapToObj(i -> getListOfDoubleValuesInSetRange(listOfMinValues.get(i), listOfMaxValues.get(i)))
                .forEach(testValues::removeAll);

        if (testValues.size() == 0) {
            throw new IllegalArgumentException(
                    "New Risk Scoring Range cannot be added due to no available free ranges are left");
        } else {
            from = testValues.get(0);
            to = testValues.get(0);
            valueManagementPage.setRiskScoringRange(from, to);
        }
    }

    @When("User fills in Risk Scoring Ranges from {string} to {string}")
    public void fillInRiskScoringRangesFromTo(String from, String to) {
        valueManagementPage.setRiskScoringRange(from, to);
    }

    @When("User creates {string} {string} via API")
    public void createValueViaAPI(String valueType, String valueReference) {
        Value valueData = new JsonUiDataTransfer<Value>(VALUE).getTestData().get(valueReference).getDataToEnter();
        ValueTypeName value = ValueTypeName.get(valueType);
        if (nonNull(getRefDataId(valueData.getName(), getValueType(valueType).get_id()))) {
            logger.info(valueType + " value management data " + valueData.getName() + " is already created");
        } else {
            postRefData(value.getName(), value.getType(), valueData);
            logger.info(valueType + " value management data " + valueData.getName() + " was created");
        }
    }

    @When("User updates Activity Type {string} with following assessments via API")
    public void updateActivityTypeWithFollowingAssessmentsViaAPI(String activityType,
            List<String> assessmentList) {
        RefDataResponse refDataPayload = getRefDataPayload(getValueTypeId(ACTIVITY_TYPE));
        Value activityValue = stream(refDataPayload.getListValues())
                .filter(activity -> activity.getName().equals(activityType)).findFirst()
                .orElseThrow(() -> new RuntimeException("Activity type '" + activityType + "' wasn't found"));
        List<String> actualAssessmentList =
                activityValue.getAssessments().stream().map(Value.Assessment::getName).collect(Collectors.toList());
        assessmentList.forEach(assessment -> {
            if (actualAssessmentList.contains(assessment)) {
                logger.info("Assessment with name " + assessment + " is exist");
            } else {
                activityValue.getAssessments().add(new Value.Assessment().setName(assessment));
            }
        });
        postRefData(ACTIVITY_TYPE.getName(), ACTIVITY_TYPE.getType(), activityValue);
        logger.info(ACTIVITY_TYPE + " value management data " + activityValue.getName() + " was updated");
    }

    @When("^User clicks (Cancel|Add New|Add) button for Value$")
    public void clickButtonForValue(String buttonName) {
        switch (buttonName) {
            case CANCEL:
                valueManagementPage.clickCancelButton();
                break;
            case ADD_NEW:
                valueManagementPage.clickAddNewButton();
                break;
            case ADD:
                valueManagementPage.clickAddIconButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonName + " is unexpected");
        }
    }

    @When("User clicks Value Management {string} column")
    public void clickValueManagementColumn(String columnName) {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        valueManagementPage.clickColumnName(columnName);
    }

    @When("User populates Value Names text area with Names")
    public void populateValueNameTextAreaWithNames(List<String> namesList) {
        namesList.forEach(name -> {
            String valueReference = name;
            name = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10).toUpperCase();
            valueNamesToDelete.add(name);
            context.getScenarioContext().setContext(valueReference, name);
            context.getScenarioContext().setContext(VALUES_TO_DELETE, valueNamesToDelete);
            valueManagementPage.fillInValueName(name);
            valueManagementPage.clickEnter();
        });
    }

    @When("User fills in Value name {string}")
    public void fillInValueName(String valueName) {
        if (context.getScenarioContext().isContains(valueName)) {
            valueName = (String) context.getScenarioContext().getContext(valueName);
        }
        if (nonNull(valueName) && valueName.contains(VALUE_TO_REPLACE)) {
            String valueReference = valueName;
            valueName = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10).toUpperCase();
            valueNamesToDelete.add(valueName);
            context.getScenarioContext().setContext(valueReference, valueName);
            context.getScenarioContext().setContext(VALUES_TO_DELETE, valueNamesToDelete);
        }
        if (valueName.isEmpty()) {
            valueManagementPage.clearValueName();
        } else {
            valueManagementPage.clearAndFillInValueName(valueName);
        }
    }

    @When("User clicks {string} Value Management button")
    public void clickValueManagementButton(String button) {
        valueManagementPage.clickButton(valueManagementPage.getFromDictionaryIfExists(button));
    }

    @When("^User clicks (Edit|Delete) button for \"((.*))\" Value Row$")
    public void clickButtonForValueManagementRow(String buttonType, String valueName) {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (valueName.contains(VALUE_TO_REPLACE)) {
            valueName = (String) context.getScenarioContext().getContext(valueName);
        } else if (valueName.equals(RISK_SCORING_RANGE_IN_USE)) {
            valueName = (String) context.getScenarioContext().getContext(RISK_SCORING_RANGE_IN_USE);
        }
        switch (buttonType) {
            case EDIT:
                valueManagementPage.clickEditButtonForRow(valueName);
                break;
            case DELETE:
                valueManagementPage.clickDeleteButtonForRow(valueName);
                break;
            default:
                throw new IllegalArgumentException("Incorrect button: " + buttonType);
        }
    }

    @When("User fills in Assessment field on position {int} value {string}")
    public void fillInAssessmentFieldOnPositionValue(int fieldPosition, String value) {
        valueManagementPage.fillInAssessment(fieldPosition, value);
    }

    @When("User adds {int} Assessment fields with name {string}")
    public void addAssessmentFields(int count, String name) {
        for (int i = 1; i <= count; i++) {
            String nameReference = name + i;
            valueManagementPage.clickAddIconButton();
            fillInAssessmentFieldOnPositionValue(i, nameReference);
        }
    }

    @When("^User creates (\\d+) Add-Ons values with name \"((.*))\" and (on|off) Active checkbox$")
    public void createAddOns(int count, String name, String checkboxState) {
        for (int i = 1; i <= count; i++) {
            String nameReference = name + i;
            valueManagementPage.clickAddNewButton();
            fillInValueName(nameReference);
            if (checkboxState.equalsIgnoreCase(ON)) {
                valueManagementPage.clickActiveCheckbox();
            }
            valueManagementPage.clickButton(SAVE);
        }
    }

    @When("^User creates (\\d+) Risk Scoring Range values with name \"((.*))\"$")
    public void createRiskScoringRanges(int count, String name) {
        for (int i = 1; i <= count; i++) {
            String nameReference = name + i;
            valueManagementPage.clickAddNewButton();
            fillInValueName(nameReference);
            fillInRiskScoringRange();
            valueManagementPage.clickButton(SAVE);
        }
    }

    @When("User clicks Assessment field on position {int} close icon")
    public void clickAssessmentFieldOnPositionCloseIcon(int fieldPosition) {
        valueManagementPage.clickCloseAssessmentField(fieldPosition);
    }

    @When("User clicks Value management active checkbox")
    public void clickValueManagementActiveCheckbox() {
        valueManagementPage.clickActiveCheckbox();
    }

    @When("User clicks value {string} breadcrumb")
    public void clickValueBreadcrumb(String valuePage) {
        valueManagementPage.clickBreadcrumb(valuePage);
    }

    @When("User deletes all values in the Value Management table")
    public void deleteAllValuesInTheValueManagementTable() {
        valueManagementPage.deleteAllValuesInTable();
    }

    @When("User clicks Risk Model drop down")
    public void clickRiskModelDropDown() {
        valueManagementPage.clickRiskModelDropDown();
    }

    @When("User selects risk model {string} from dropdown")
    public void selectRiskModelFromDropDown(String value) {
        valueManagementPage.selectFromRiskModelDropDown(value);
    }

    @When("User clicks Apply Risk Model button")
    public void clickApplyRiskModelButton() {
        valueManagementPage.clickApplyRiskModelButton();
    }

    @When("User clicks Risk Model Cancel button")
    public void clickRiskModelCancelButton() {
        valueManagementPage.clickRiskModelCancelButton();
    }

    @When("User selects medium color in Risk Scoring Range")
    public void userSelectsAnyColorInRiskScoringRange() {
        valueManagementPage.clickRiskScoringColorButton();
        valueManagementPage.selectMiddleRiskScoringColor();
    }

    @When("User saves Activity type id to context")
    public void saveActivityTypeIdToContext() {
        String activityTypeId = getValueTypeId(ACTIVITY_TYPE);
        context.getScenarioContext().setContext(ACTIVITY_TYPE_ID, activityTypeId);
    }

    @Then("Add Value Management modal is displayed")
    public void addModalIsDisplayed() {
        assertThat(valueManagementPage.isAddModalDisplayed())
                .as("Add Modal is not displayed")
                .isTrue();
    }

    @Then("{string} Risk Scoring Range is displayed in grid")
    public void isAddedRiskScoringRangeDisplayed(String name) {
        if (name.contains(VALUE_TO_REPLACE)) {
            name = (String) context.getScenarioContext().getContext(name);
        }
        assertThat(valueManagementPage.isRiskScoringRangeDisplayed(name)).as(name + " Risk Scoring Range is not added!")
                .isTrue();
    }

    @Then("Value Management {string} overview page is displayed")
    public void valueOverviewPageIsDisplayed(String pageName) {
        assertThat(valueManagementPage.isValueOverviewPageDisplayed(pageName))
                .as("Value Management %s overview page is not displayed", pageName)
                .isTrue();
    }

    @Then("Value Management overview page is displayed")
    public void valueManagementOverviewPageIsDisplayed() {
        assertThat(valueManagementPage.isPageLoaded()).as("Value Management overview page is not displayed")
                .isTrue();
    }

    @Then("{string} container contains all values in the system")
    public void containerContainsAllValuesInTheSystem(String containerName) {
        List<String> expectedValues;
        if (containerName.equals(CURRENCY) || getTenantFeatureManagement().isDisableDynamicRiskScoringEngine()) {
            expectedValues = stream(getRefDataPayload(getValueType(containerName).get_id()).getListValues())
                    .map(value -> nonNull(value.getName()) ? value.getName() : value.getDescription())
                    .collect(Collectors.toList());
        } else {
            expectedValues =
                    getRiskScoreEngineReference(containerName.toLowerCase().replace(StringUtils.SPACE, DASH))
                            .getData().stream()
                            .map(value -> nonNull(value.getName()) ? value.getName() : value.getDescription())
                            .collect(Collectors.toList());
        }
        expectedValues.removeAll(Collections.singleton(null));
        assertThat(valueManagementPage.getValuesContainerList())
                .as("%s container doesn't contain all values", containerName)
                .isEqualTo(expectedValues);
    }

    @Then("Value table contains all default values")
    public void valueTableContainsAllDefaultValues(List<String> expectedValues) {
        assertThat(valueManagementPage.getValuesList())
                .as("Value table doesn't contain all default values")
                .containsAll(expectedValues);
    }

    @Then("Value {string} container contains all default values")
    public void valueContainerContainsAllDefaultValues(String containerName, List<String> expectedValues) {
        if ((!ORGANISATION_SIZE.getName().equals(containerName) && !COMPANY_TYPE.getName().equals(containerName)) &&
                !getTenantFeatureManagement().isDisableDynamicRiskScoringEngine()) {
            expectedValues = getRiskScoreEngineReference(containerName.toLowerCase().replace(StringUtils.SPACE, DASH))
                    .getData().stream()
                    .map(value -> nonNull(value.getName()) ? value.getName().replace(DOUBLE_SPACE, SPACE).trim() :
                            value.getDescription().replace(DOUBLE_SPACE, SPACE).trim())
                    .collect(Collectors.toList());
        }
        assertThat(valueManagementPage.getValuesContainerList())
                .as("Value container doesn't contain all default values")
                .isEqualTo(expectedValues);
    }

    @Then("All expected Value Management Overview buttons are displayed")
    public void allExpectedValueManagementOverviewButtonsAreDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(valueManagementPage.isCancelButtonDisplayed(), "Cancel button is not displayed");
        softAssert.assertTrue(valueManagementPage.isCancelButtonActive(), "Cancel button is not active");
        softAssert.assertAll();
    }

    @Then("^Value \"((.*))\" is (active|inactive)$")
    public void valueIsNotSelected(String valueName, String state) {
        if (valueName.contains(VALUE_TO_REPLACE)) {
            valueName = (String) context.getScenarioContext().getContext(valueName);
        }
        if (state.equals(ACTIVE)) {
            assertThat(valueManagementPage.isValueActive(valueName)).as("Value %s is inactive", valueName)
                    .isTrue();
        } else {
            assertThat(valueManagementPage.isValueActive(valueName)).as("Value %s is active", valueName)
                    .isFalse();
        }
    }

    @Then("Value Management Container are sorted in alphabetical order")
    public void valueManagementContainerAreSortedInAlphabeticalOrder() {
        assertThat(valueManagementPage.getValuesList())
                .as("Value Management Container are not sorted in alphabetical order")
                .isSorted();
    }

    @Then("Value Management table displayed with columns")
    public void valueManagementTableDisplayedWithColumns(List<String> expectedColumns) {
        assertThat(valueManagementPage.getColumnNames())
                .as("Value Management table columns are unexpected")
                .isEqualTo(expectedColumns);
    }

    @Then("For each Value Management record edit button should be displayed")
    public void forEachValueManagementRecordEditButtonShouldBeDisplayed() {
        assertThat(valueManagementPage.isEditButtonDisplayedForEachRow())
                .as("Edit button is not displayed for each Value Management record")
                .isTrue();
    }

    @Then("Value Management record edit button should be displayed only for Values")
    public void valueManagementRecordEditButtonShouldBeDisplayed(List<String> exceptList) {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssert = new SoftAssertions();
        List<String> allValuesList = valueManagementPage.getListValuesForFirstColumn();
        allValuesList.forEach(value -> {
            boolean isDisplayed = valueManagementPage.isEditButtonDisplayedForRow(value);
            boolean expectedResult = exceptList.contains(value);
            softAssert.assertThat(isDisplayed)
                    .as("Edit button state unexpected for %s", value)
                    .isEqualTo(expectedResult);
        });
        softAssert.assertAll();
    }

    @Then("For each Value Management record delete button should be displayed")
    public void forEachValueManagementRecordDeleteButtonShouldBeDisplayed() {
        assertThat(valueManagementPage.isDeleteButtonDisplayedForEachRow())
                .as("Delete button is not displayed for each Value Management record")
                .isTrue();
    }

    @Then("^For each Value Management record (delete|edit) button should be displayed except values$")
    public void forEachValueManagementRecordButtonShouldBeEnabledExceptValues(String buttonType,
            List<String> exceptList) {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        SoftAssertions softAssert = new SoftAssertions();
        List<String> allValuesList = valueManagementPage.getListValuesForFirstColumn();
        allValuesList.forEach(value -> {
            boolean isDisplayed = buttonType.equals(DELETE.toLowerCase()) ?
                    valueManagementPage.isDeleteButtonDisplayedForRow(value) :
                    valueManagementPage.isEditButtonDisplayedForRow(value);
            boolean expectedResult = !exceptList.contains(value);
            softAssert.assertThat(isDisplayed)
                    .as("Button %s state unexpected for %s", buttonType, value)
                    .isEqualTo(expectedResult);
        });
        softAssert.assertAll();
    }

    @Then("Region table contains all the Regions in the system")
    public void regionTableContainsAllTheRegionsInTheSystem() {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> expectedList = getListOfNamesForValueManagementType(getValueTypeId(REGION));
        assertThat(valueManagementPage.getTableRowNames())
                .as("Region table doesn't contain all the Regions in the system")
                .usingRecursiveComparison()
                .ignoringCollectionOrder()
                .isEqualTo(expectedList);
    }

    @Then("Value Management table is sorted by {string} field in {string} order")
    public void tableIsSortedByFieldInOrder(String columnName, String sortOrder) {
        valueManagementPage.waitForAngularPageIsLoaded();
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> valuesList = valueManagementPage.getListValuesForColumn(columnName);
        tableIsSortedByInOrder("Value Management", columnName, sortOrder, DATE_OF_INCORPORATION_FORMAT, valuesList,
                               false);
    }

    @Then("{string} Value Management Button is displayed")
    public void addNewValueManagementButtonIsDisplayed(String buttonText) {
        assertThat(valueManagementPage.getAddValueManagementButtonText())
                .as("%s Value Management Button is not displayed", buttonText)
                .isEqualTo(buttonText);
    }

    @Then("^Value Management \"((.*))\" button is (enabled|disabled)$")
    public void valueManagementButtonEnabled(String buttonName, String state) {
        if (state.equals(ENABLED)) {
            assertThat(valueManagementPage.isValueManagementButtonDisabled(buttonName))
                    .as("%s Value Management Button is disabled", buttonName)
                    .isFalse();
        } else {
            assertThat(valueManagementPage.isValueManagementButtonDisabled(buttonName))
                    .as("%s Value Management Button is enabled", buttonName)
                    .isTrue();
        }
    }

    @Then("^Value Management table (contains|does not contain) values$")
    public void valueManagementTableContainsValues(String state, List<ValueData> expectedValues) {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<ValueData> valueTableData = valueManagementPage.getValueTableData();
        if (state.contains(NOT)) {
            assertThat(valueTableData)
                    .as("Value Management table contains values")
                    .doesNotContainAnyElementsOf(expectedValues);
        } else {
            assertThat(valueTableData)
                    .as("Value Management table does not contain values")
                    .containsAll(expectedValues);
        }
    }

    @Then("^Value with name \"((.*))\" is (displayed|invisible)$")
    public void valueWithNameIsDisplayed(String valueName, String state) {
        valueManagementPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (valueName.contains(VALUE_TO_REPLACE)) {
            valueName = (String) context.getScenarioContext().getContext(valueName);
        } else if (valueName.equals(RISK_SCORING_RANGE_IN_USE)) {
            valueName = (String) context.getScenarioContext().getContext(RISK_SCORING_RANGE_IN_USE);
        }
        List<String> valuesList = valueManagementPage.getListValuesForFirstColumn();
        if (state.equals(INVISIBLE)) {
            assertThat(valuesList)
                    .as("Value Management table contains value")
                    .doesNotContain(valueName);
        } else {
            assertThat(valuesList)
                    .as("Value Management table does not contain value")
                    .contains(valueName);
        }
    }

    @Then("Error message {string} in red color is displayed near Value name input")
    public void errorMessageInRedColorIsDisplayedNearName(String errorMessage) {
        if (errorMessage.contains(VALUE_TO_REPLACE)) {
            errorMessage = errorMessage.replace(VALUE_TO_REPLACE,
                                                (String) context.getScenarioContext().getContext(VALUE_TO_REPLACE));
        }
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(valueManagementPage.getErrorMessage(), errorMessage,
                                "Name field error message is not displayed");
        softAssert.assertEquals(valueManagementPage.getErrorMessageElementCSS(COLOR),
                                REACT_RED.getColorRgba(), "Input field error message is not red");
        softAssert.assertAll();
    }

    @Then("Add Value modal contains all expected elements")
    public void addModalContainsAllExpectedElements() {
        String expectedNoticeText = "Each value should be separated by its own line.";
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(valueManagementPage.isValueNameInputDisplayed(),
                              "Value Name input field is not displayed");
        softAssert.assertFalse(valueManagementPage.isValueManagementButtonDisabled(CANCEL),
                               "Value modal Cancel button is not enabled");
        softAssert.assertTrue(valueManagementPage.isValueManagementButtonDisabled(SAVE),
                              "Value modal Save button is not disabled");
        softAssert.assertEquals(valueManagementPage.getModalNotice(), expectedNoticeText,
                                "Value modal Notice is not expected");
        softAssert.assertAll();

    }

    @Then("Edit Value modal contains all expected elements")
    public void editModalContainsAllExpectedElements() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(valueManagementPage.isValueNameInputDisplayed(),
                              "Value Name input field is not displayed");
        softAssert.assertFalse(valueManagementPage.isValueManagementButtonDisabled(CANCEL),
                               "Value modal Cancel button is not enabled");
        softAssert.assertTrue(valueManagementPage.isValueManagementButtonDisabled(SAVE),
                              "Value modal Save button is not enabled");
        softAssert.assertAll();
    }

    @Then("^(?:Add|Edit?) Risk Scoring Range modal contains all expected elements$")
    public void addRiskScoringModalContainsAllExpectedElements() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(valueManagementPage.isRiskScoringNameInputDisplayed(),
                              "Risk Scoring Range Name input field is not displayed");
        softAssert.assertTrue(valueManagementPage.isRiskScoringFromDisplayed(),
                              "Risk Scoring Range From input field is not displayed");
        softAssert.assertTrue(valueManagementPage.isRiskScoringToDisplayed(),
                              "Risk Scoring Range To input field is not displayed");
        softAssert.assertFalse(valueManagementPage.isValueManagementButtonDisabled(CANCEL),
                               "Value modal Cancel button is not enabled");
        softAssert.assertFalse(valueManagementPage.isValueManagementButtonDisabled(SAVE),
                               "Value modal Save button is not enabled");
        softAssert.assertTrue(valueManagementPage.isRequiredFieldSymbolDisplayed(RISK_SCORING_RANGE_NAME),
                              "Risk Scoring Range Name field required symbol is not displayed");
        softAssert.assertTrue(valueManagementPage.isRequiredFieldSymbolDisplayed(FROM),
                              "From field required symbol is not displayed");
        softAssert.assertTrue(valueManagementPage.isRequiredFieldSymbolDisplayed(TO),
                              "To field required symbol is not displayed");
        softAssert.assertAll();
    }

    @Then("Add Activity Type modal contains all expected elements")
    public void addActivityTypeModalContainsAllExpectedElements() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(valueManagementPage.isValueNameInputDisplayed(),
                              "Activity Type Name input field is not displayed");
        softAssert.assertFalse(valueManagementPage.isValueManagementButtonDisabled(CANCEL),
                               "Value modal Cancel button is not enabled");
        softAssert.assertFalse(valueManagementPage.isValueManagementButtonDisabled(SAVE),
                               "Value modal Save button is not enabled");
        softAssert.assertTrue(valueManagementPage.isRequiredFieldSymbolDisplayed(ACTIVITY_TYPE_NAME),
                              "Activity Type Name field required symbol is not displayed");
        softAssert.assertTrue(valueManagementPage.isAddIconDisplayed(),
                              "Add Activity Type modal Add icon button is not displayed");
        softAssert.assertAll();
    }

    @Then("^(?:Add|Edit?) Add-Ons modal contains all expected elements$")
    public void addAddOnsModalContainsAllExpectedElements() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(valueManagementPage.isValueNameInputDisplayed(),
                              "Add-On Name input field is not displayed");
        softAssert.assertTrue(valueManagementPage.isRequiredFieldSymbolDisplayed(ADD_ONS_NAME),
                              "Add-Ons Name field required symbol is not displayed");
        softAssert.assertTrue(valueManagementPage.isValueManagementButtonDisplayed(CANCEL),
                              "Value modal Cancel button is not displayed");
        softAssert.assertTrue(valueManagementPage.isValueManagementButtonDisplayed(SAVE),
                              "Value modal Save button is not displayed");
        softAssert.assertTrue(valueManagementPage.isActiveCheckboxDisplayed(),
                              "Add-Ons modal Active checkbox is not displayed");
        softAssert.assertAll();
    }

    @Then("User verifies each region contains countries according to Region List")
    public void verifyEachRegionContainsExpectedCountries() {
        SoftAssertions softAssert = new SoftAssertions();
        List<String> regions = getAllAvailableRegions().stream().map(
                RegionCountryRequest.RegionObject::getName).collect(Collectors.toList());
        regions.forEach(region -> {
            clickOnValue(region);
            List<String> countriesInRegion = getAvailableCountriesForRegion(getRegionIdByName(region));
            List<String> selectedCountries = valueManagementPage.getSelectedCountriesOptions();
            List<String> availableCountries = valueManagementPage.getAvailableCountriesOptions();
            Comparator<String> naturalOrderIgnoringLetterAccents = (o1, o2) -> {
                o1 = Normalizer.normalize(o1, Normalizer.Form.NFD);
                o2 = Normalizer.normalize(o2, Normalizer.Form.NFD);
                return o1.compareTo(o2);
            };
            softAssert.assertThat(selectedCountries)
                    .as("Selected Countries Container options are from region %s", region)
                    .usingRecursiveComparison().ignoringCollectionOrder()
                    .isEqualTo(countriesInRegion);
            softAssert.assertThat(availableCountries)
                    .as("Available Countries Container options contains values from region %s", region)
                    .doesNotContainAnyElementsOf(countriesInRegion);
            softAssert.assertThat(selectedCountries)
                    .as("Selected Countries are not sorted in ASC order")
                    .isSortedAccordingTo(naturalOrderIgnoringLetterAccents);
            softAssert.assertThat(availableCountries)
                    .as("Available Countries are not sorted in ASC order")
                    .isSortedAccordingTo(naturalOrderIgnoringLetterAccents);
            softAssert.assertThat(valueManagementPage.getBreadcrumbText())
                    .as("Value Management breadcrumb is expected")
                    .isEqualTo(String.format("VALUE MANAGEMENT / REGION / %s", region.toUpperCase()));
            clickValueManagementButton(CANCEL);
        });
        softAssert.assertAll();
    }

    @Then("Value field validation message {string} is displayed")
    public void valueFieldValidationMessageIsDisplayed(String expectedText) {
        assertThat(valueManagementPage.getFieldValidationMessage())
                .as("Value field validation message is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("^Value Management Add icon is (disabled|enabled|invisible)$")
    public void valueManagementAddIconIsDisabled(String state) {
        if (state.equals(DISABLED)) {
            assertThat(valueManagementPage.isAddIconDisabled())
                    .as("Value Management Add icon is not disabled")
                    .isTrue();
        } else if (state.equals(ENABLED)) {
            assertThat(valueManagementPage.isAddIconDisabled())
                    .as("Value Management Add icon is not enabled")
                    .isFalse();
        } else {
            assertThat(valueManagementPage.isAddIconDisplayed())
                    .as("Value Management Add icon is displayed")
                    .isFalse();
        }
    }

    @Then("Value Management Assessment field contains close icon for {int} field")
    public void valueManagementAssessmentFieldContainsCloseIcon(int fieldIndex) {
        assertThat(valueManagementPage.isAssessmentCloseIconDisplayed(fieldIndex))
                .as("Value Management Assessment field does not contain close icon")
                .isTrue();
    }

    @Then("Value management Assessment field is invisible")
    public void valueManagementAssessmentFieldIsInvisible() {
        assertThat(valueManagementPage.isAssessmentFieldDisplayed())
                .as("Assessment field is displayed")
                .isFalse();
    }

    @Then("^Value Management (contains|does not contain) \"((.*))\" \"((.*))\" value$")
    public void valueManagementContainsValue(String state, String valueType, String valueReference) {
        Value valueData = new JsonUiDataTransfer<Value>(VALUE).getTestData().get(valueReference).getDataToEnter();
        Value[] listValues = getRefDataPayload(getValueType(valueType).get_id()).getListValues();
        if (state.contains(NOT)) {
            for (Value value : listValues) {
                if (valueData.getName().equals(value.getName()) || (nonNull(valueData.getListValues()) &&
                        valueData.getListValues().get(0).getName().equals(value.getName()))) {
                    throw new SkipException(valueData.getName() + " already exists!");
                }
            }
        } else {
            assertThat(getRefDataId(valueData.getName(), getValueType(valueType).get_id()))
                    .as("%s value management data %s is not exist", valueType, valueData.getName())
                    .isNotNull();
        }
    }

    @Then("Value Management table does not contain records")
    public void valueManagementTableDoesNotContainRecords(List<String> expectedElements) {
        assertThat(valueManagementPage.getTableRowNames())
                .as("Value Management table contains unexpected records")
                .doesNotContainAnyElementsOf(expectedElements);
    }

    @Then("Value Management table contain records in order")
    public void valueManagementTableContainRecordsInOrder(List<String> expectedElements) {
        assertThat(valueManagementPage.getTableRowNames())
                .as("Value Management table does not contain unexpected records")
                .isEqualTo(expectedElements);
    }

    @Then("Value Management message {string} is displayed")
    public void valueManagementMessageIsDisplayed(String expectedMessage) {
        assertThat(valueManagementPage.getEmptyTableMessage())
                .as("Empty table message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Value Management message {string} is displayed if table is empty")
    public void valueManagementMessageIsDisplayedIsTableIsEmpty(String expectedMessage) {
        if (valueManagementPage.getRowsCount() == 0) {
            assertThat(valueManagementPage.getEmptyTableMessage())
                    .as("Empty table message is unexpected")
                    .isEqualTo(expectedMessage);
        } else {
            assertThat(valueManagementPage.isEmptyTableMessageDisplayed())
                    .as("Empty table message is displayed")
                    .isFalse();
        }
    }

    @Then("Risk Model drop down is displayed")
    public void isRiskModelDropDownDisplayed() {
        assertThat(valueManagementPage.isRiskModelDropDownDisplayed()).as("Risk Model drop down is not displayed")
                .isTrue();
    }

    @Then("Risk Model Drop down list is displayed with values")
    public void riskModelDropDownListIsDisplayedWithValues(DataTable dataTable) {
        List<String> expectedOptions = dataTable.asList();
        assertEquals(valueManagementPage.getRiskModelDropDownOptions(), expectedOptions,
                     "Risk Model Drop down list is not displayed with expected values");
    }

    @Then("Risk model {string} is displayed")
    public void isRiskModelDisplayed(String model) {
        assertThat(valueManagementPage.getRiskModel())
                .as("Risk model is incorrect")
                .isEqualTo(model);
    }

    @Then("Previous selected Risk Model {string} is displayed")
    public void isPreviouslyAppliedRiskModelDisplayed(String riskModel) {
        assertThat(valueManagementPage.getRiskModel()).as("Previous risk model is not displayed").isEqualTo(riskModel);
    }

    @Then("Apply Risk Model button is displayed")
    public void isApplyRiskModelButtonDisplayed() {
        assertThat(valueManagementPage.isApplyRiskModelButtonDisplayed()).as("Risk Model Apply button is not displayed")
                .isTrue();
    }

    @Then("Risk Model Cancel button is displayed")
    public void isRiskModelCancelButtonDisplayed() {
        assertThat(valueManagementPage.isRiskModelCancelButtonDisplayed()).as(
                        "Risk Model Cancel button is not displayed")
                .isTrue();
    }

    @Then("Activity Type Name field is disabled")
    public void isActivityTypeNameFieldIsDisabled() {
        assertThat(valueManagementPage.isActivityTypeNameFieldDisabled()).as(
                        "Activity Type Name field is enabled")
                .isTrue();
    }

}
