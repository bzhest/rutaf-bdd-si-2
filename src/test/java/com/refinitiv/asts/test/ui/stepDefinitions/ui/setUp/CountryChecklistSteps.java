package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.api.model.countryChecklist.CountyChecklistRequest;
import com.refinitiv.asts.test.ui.constants.ContextConstants;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.setUp.CountryChecklistPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.countryChecklist.CountryChecklistData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.buildCountyChecklistRequest;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.APIConstants._ID;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.COUNTRY_CHECKLIST;
import static com.refinitiv.asts.test.ui.enums.Colors.*;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.DEFAULT_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.ENORMOUS_ITEMS_PER_PAGE;
import static com.refinitiv.asts.test.ui.pageActions.setUp.CountryChecklistPage.NAME;
import static com.refinitiv.asts.test.ui.pageActions.setUp.CountryChecklistPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.SORTING_FORMAT;
import static com.refinitiv.asts.test.ui.utils.DateUtil.getTodayDate;
import static java.util.UUID.randomUUID;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;

public class CountryChecklistSteps extends BaseSteps {

    public static final String ICON_PATH = "/ui/setUp/countryChecklist/img/%s.png";
    public static String countryChecklistNameContextWithNumber;

    private final CountryChecklistPage countryChecklistPage;
    private int methodCallsNumber = 0;

    public CountryChecklistSteps(ScenarioCtxtWrapper context) {
        super(context);
        countryChecklistPage = new CountryChecklistPage(this.driver, this.translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public CountryChecklistData providerEntry(Map<String, String> entry) {
        return CountryChecklistData.builder()
                .listName(entry.get(NAME))
                .alertType(entry.get(ALERT))
                .status(entry.get(STATUS))
                .dateCreated(entry.get(DATE_CREATED))
                .lastUpdate(entry.get(LAST_UPDATE))
                .build();
    }

    @When("User creates Country Checklist {string} via API")
    public void createCountryChecklistViaAPI(String alertTypeReference) {
        CountryChecklistData countryChecklistData =
                new JsonUiDataTransfer<CountryChecklistData>(COUNTRY_CHECKLIST)
                        .getTestData()
                        .get(alertTypeReference)
                        .getDataToEnter();
        if (countryChecklistData.getListName().equals(VALUE_TO_REPLACE)) {
            countryChecklistData.setListName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        CountyChecklistRequest countryChecklistRequest = buildCountyChecklistRequest(countryChecklistData);
        ConnectApi.postCountryChecklist(countryChecklistRequest);
        if (methodCallsNumber == 0) {
            this.context.getScenarioContext()
                    .setContext(COUNTRY_CHECKLIST_NAME_CONTEXT, countryChecklistData.getListName());
        } else {
            countryChecklistNameContextWithNumber = COUNTRY_CHECKLIST_NAME_CONTEXT_WITHOUT_NUMBER + methodCallsNumber;
            this.context.getScenarioContext()
                    .setContext(countryChecklistNameContextWithNumber, countryChecklistData.getListName());
        }
        int contextNumber = methodCallsNumber++;
        this.context.getScenarioContext()
                .setContext(COUNTRY_CHECKLIST_CONTEXT_NUMBER, contextNumber);
    }

    @When("User clicks Country Checklist in Set Up menu")
    public void clickCountryChecklistMenu() {
        countryChecklistPage.clickCountryChecklistMenu();
    }

    @When("User clicks Add List Name button")
    public void clickAddListNameBtn() {
        countryChecklistPage.clickAddListNameBtn();
    }

    @When("User populates List Name field with {string}")
    public void fillInListName(String name) {
        if (name.equals(VALUE_TO_REPLACE)) {
            name = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
        }
        if (name.equals(EXISTING)) {
            String newlyCreatedChecklist =
                    (String) context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
            name = getCountryChecklistsList(ENORMOUS_ITEMS_PER_PAGE, _ID, DESC).stream()
                    .filter(checklist -> !checklist.getListName().equals(newlyCreatedChecklist)).findFirst()
                    .orElseThrow(() -> new IllegalStateException("No Country Checklist exists")).getListName()
                    .replaceAll(DOUBLE_SPACE, SPACE);
        }
        countryChecklistPage.fillInName(name);
        if (!name.contains(CANCEL.toLowerCase())) {
            this.context.getScenarioContext().setContext(COUNTRY_CHECKLIST_NAME_CONTEXT, name);
        }
    }

    @When("User selects {string} alert type")
    public void chooseAlertType(String type) {
        countryChecklistPage.tickAlertType(type);
    }

    @When("User populates alert message with {string}")
    public void fillInAlertMsg(String msg) {
        countryChecklistPage.fillInAlertMsg(msg);
        this.context.getScenarioContext().setContext(COUNTRY_CHECKLIST_ALERT_MESSAGE_CONTEXT, msg);
    }

    @When("User clicks Save and Assign button")
    public void clickSaveAndAssignCountryBtn() {
        countryChecklistPage.clickSaveAndAssignCountryBtn();
    }

    @When("User selects Country {string} from {string} list")
    public void chooseCountryInList(String country, String list) {
        if (list.equals(SELECTED_COUNTRIES)) {
            countryChecklistPage.chooseCountryInList(country,
                                                     translator.getValue("setUp.countryChecklist.selectedCountries"));
        } else {
            countryChecklistPage.chooseCountryInList(country,
                                                     translator.getValue("setUp.countryChecklist.availableCountries"));
        }

    }

    @When("User clicks {string} move button")
    public void clickMoveToBtn(String direction) {
        countryChecklistPage.moveCountryToList(direction);
    }

    @When("User clicks Save button for assigning Country")
    public void clickSaveBtn() {
        countryChecklistPage.clickSaveButton();
    }

    @When("User clicks Save button for edit assigning Country")
    public void clickEditSaveBtn() {
        countryChecklistPage.clickEditSaveButton();
    }

    @When("User clicks Cancel Assign Country List Name form")
    public void clickCancelButtonForAssigningCountry() {
        countryChecklistPage.clickCancelButton();
    }

    @When("User clicks Cancel Assign Country button")
    public void clickCancelAssignCountryButton() {
        countryChecklistPage.clickCancelAssignCountryButton();
    }

    @When("^User clicks (edit|delete|assign) button for country checklist \"((.*))\"$")
    public void clickButtonForCountryChecklist(String buttonType, String checklistName) {
        countryChecklistPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (checklistName.equals(VALUE_TO_REPLACE)) {
            checklistName = (String) context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
        }
        if (buttonType.equals(EDIT.toLowerCase())) {
            countryChecklistPage.clickEditButton(checklistName);
        } else if (buttonType.equals(DELETE.toLowerCase())) {
            countryChecklistPage.clickDeleteButton(checklistName);
        } else {
            countryChecklistPage.clickAssignButton(checklistName);
        }
    }

    @When("User navigates Country Checklist page")
    public void navigateCountryChecklistPage() {
        countryChecklistPage.navigateToCountryChecklistPage();
    }

    @When("User saves existing Country Checklist id")
    public void saveCountryCheckListId() {
        String alreadyExistingCheckListName =
                getCountryChecklistsList(ENORMOUS_ITEMS_PER_PAGE, _ID, DESC).stream()
                        .findFirst()
                        .orElseThrow(() -> new IllegalStateException("No Country Checklist exists")).getListName()
                        .replaceAll(DOUBLE_SPACE, SPACE);
        String checklistId = ConnectApi.getCountryChecklistId(alreadyExistingCheckListName);
        context.getScenarioContext().setContext(ContextConstants.COUNTRY_CHECKLIST_ID, checklistId);
    }

    @When("User opens Country Checklist page {string}")
    public void navigateCountryChecklistSpecificPage(String page) {
        if (page.contains(TestConstants.COUNTRY_CHECKLIST_ID)) {
            String countryChecklistId =
                    (String) context.getScenarioContext().getContext(ContextConstants.COUNTRY_CHECKLIST_ID);
            countryChecklistPage.navigateToSpecificPage(String.format(page, countryChecklistId));
        } else {
            countryChecklistPage.navigateToSpecificPage(page);
        }

    }

    @When("User clicks {string} Country Checklist column header")
    public void clickOnColumn(String column) {
        countryChecklistPage.clickOnColumn(column);
    }

    @When("User clicks on Country Checklist {string}")
    public void clickOnCountryChecklist(String checklistName) {
        if (checklistName.equals(VALUE_TO_REPLACE)) {
            checklistName = (String) context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
        }
        countryChecklistPage.clickOnCountryChecklist(checklistName);
    }

    @When("User clicks view Edit Country Checklist button")
    public void clickViewEditButton() {
        countryChecklistPage.clickViewEditButton();
    }

    @When("User clears Country Checklist {string} field")
    public void clearField(String fieldName) {
        countryChecklistPage.clearField(fieldName);
    }

    @When("^User (?:checks|unchecks?) Active Country Checklist checkbox$")
    public void tickActiveCheckBox() {
        countryChecklistPage.tickActiveCheckBox();
    }

    @When("User searches Country Checklist with name {string}")
    public void searchCountryChecklist(String countryChecklist) {
        if (countryChecklist.equals(VALUE_TO_REPLACE)) {
            countryChecklist = (String) context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
        } else if (countryChecklist.equals(NOT_EXISTING)) {
            countryChecklist =
                    getCountryChecklistsList(ENORMOUS_ITEMS_PER_PAGE, _ID, DESC).stream()
                            .map(CountryChecklistData::getListName)
                            .findFirst()
                            .orElseThrow(() -> new RuntimeException("Country Checklist Name is not found")) +
                            randomUUID();
        }
        countryChecklistPage.searchCountryChecklist(countryChecklist.toLowerCase());
    }

    @When("User deletes all Country Checklists with name prefix generated by auto tests via API")
    public void deleteAllCountryChecklistsWithNamePrefixGeneratedByAutoTestsViaAPI() {
        getCountryChecklistsList(ENORMOUS_ITEMS_PER_PAGE, _ID, DESC).forEach(countryChecklist -> {
            if (countryChecklist.getListName().startsWith(AUTO_TEST_NAME_PREFIX)) {
                deleteCountryChecklist(countryChecklist.getCountryChecklistId());
            }
        });
    }

    @Then("{string} details page is displayed")
    public void isDetailsPageDisplayed(String page) {
        assertThat(countryChecklistPage.isDetailsPageDisplayed(countryChecklistPage.getFromDictionaryIfExists(page)))
                .as(page + " is not displayed!").isTrue();
    }

    @Then("Country Checklist Active checkbox is ticked")
    public void isListNameActiveCheckboxChecked() {
        assertThat(countryChecklistPage.isCountryChecklistActiveCheckboxChecked())
                .as("Active checkbox is not ticked").isTrue();
    }

    @Then("Country {string} is moved to {string} list")
    public void isCountryDisplayedInList(String country, String list) {
        String countryColumn =
                list.equals(SELECTED_COUNTRIES) ? translator.getValue("setUp.countryChecklist.selectedCountries") :
                        translator.getValue("setUp.countryChecklist.availableCountries");
        assertThat(countryChecklistPage.isCountryDisplayedInList(country, countryColumn))
                .as("Country " + country + " is not displayed in " + countryColumn)
                .isTrue();
    }

    @Then("Country {string} is displayed with values")
    public void countryChecklistIsDisplayedWithValues(String checklistName, CountryChecklistData expectedResult) {
        if (expectedResult.getStatus().equals("setUp.countryChecklist.activeStatus")) {
            expectedResult.setStatus(translator.getValue("setUp.countryChecklist.activeStatus"));
        }
        if (checklistName.equals(VALUE_TO_REPLACE)) {
            checklistName = (String) context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
            expectedResult.setListName(checklistName);
        }
        expectedResult.setDateCreated(getTodayDate(expectedResult.getDateCreated()));
        if (expectedResult.getLastUpdate() != null) {
            expectedResult.setLastUpdate(getTodayDate(expectedResult.getLastUpdate()));
        }
        CountryChecklistData actualResult = countryChecklistPage.getAllFieldsValues(checklistName);
        assertThat(actualResult)
                .as("Country Checklist is not displayed with expected values").isEqualTo(expectedResult);
    }

    @Then("Country Checklist page is loaded")
    public void countryChecklistPageIsLoaded() {
        countryChecklistPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(countryChecklistPage.isPageLoaded()).as("Country Checklist page is not loaded").isTrue();
    }

    @Then("Country Checklist Alert Type {string} is ticked")
    public void countryChecklistAlertTypeIsTicked(String option) {
        assertThat(countryChecklistPage.isCountryChecklistAlertTypeTicked(option))
                .as("Country Checklist Alert Type %s is not ticked", option)
                .isTrue();
    }

    @Then("Country Checklist Alert Type list id displayed with colored options")
    public void countryChecklistAlertTypeListIdDisplayedWithColoredOptions(List<String> options) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertEquals(countryChecklistPage.getAlertTypeOptions(), options,
                                "Checklist Alert Type list is unexpected");
        softAssert.assertEquals(countryChecklistPage.getAlertTypeFontColor(INFORMATIONAL),
                                COUNTRY_CHECKLIST_BLUE.getColorRgba(),
                                "Informational font color is unexpected");
        softAssert.assertEquals(countryChecklistPage.getAlertTypeFontColor(CAUTION), ORANGE.getColorRgba(),
                                "Caution font color is unexpected");
        softAssert.assertEquals(countryChecklistPage.getAlertTypeFontColor(WARNING), REACT_RED.getColorRgba(),
                                "Warning font color is unexpected");
        softAssert.assertTrue(countryChecklistPage.isCountryChecklistImageCorrect(ICON_PATH, INFORMATIONAL),
                              "Informational icon is unexpected");
        softAssert.assertTrue(countryChecklistPage.isCountryChecklistImageCorrect(ICON_PATH, CAUTION),
                              "Caution icon is unexpected");
        softAssert.assertTrue(countryChecklistPage.isCountryChecklistImageCorrect(ICON_PATH, WARNING),
                              "Warning icon is unexpected");
        softAssert.assertAll();
    }

    @Then("Country Checklist {string} button is displayed")
    public void countryChecklistButtonIsDisplayed(String buttonText) {
        assertThat(countryChecklistPage.isButtonWithTextDisplayed(buttonText))
                .as("Button %s is not displayed", buttonText).isTrue();
    }

    @Then("Assign Country {string} button is displayed")
    public void assignCountryButtonIsDisplayed(String buttonText) {
        if (buttonText.equals(CANCEL) || buttonText.equals(SAVE)) {
            assertThat(countryChecklistPage.isAssignCountryButtonWithTextDisplayed(buttonText))
                    .as("Button %s is not displayed", buttonText).isTrue();
        } else {
            assertThat(countryChecklistPage.isButtonWithIconDisplayed(buttonText))
                    .as("Button %s is not displayed", buttonText).isTrue();
        }
    }

    @Then("Available Countries Container contains all the countries in the system")
    public void availableCountriesContainerContainsAllTheCountriesInTheSystem() {
        List<String> allAvailableCountryNames = getAllAvailableCountries().stream().map(
                RegionCountryRequest.RegionObject::getName).collect(Collectors.toList());
        assertThat(countryChecklistPage.getAvailableCountriesOptions())
                .as("Available Countries Container options are not expected")
                .usingRecursiveComparison()
                .ignoringCollectionOrder()
                .isEqualTo(allAvailableCountryNames);
    }

    @Then("Selected Countries Container is displayed")
    public void selectedCountriesContainerIsDisplayed() {
        assertThat(countryChecklistPage.isSelectedCountriesContainerDisplayed())
                .as("Selected Countries Container is not displayed").isTrue();
    }

    @Then("Country Checklist option is not displayed")
    public void countryChecklistOptionIsNotDisplayed() {
        assertThat(countryChecklistPage.isCountryChecklistOptionDisplayed())
                .as("Country Checklist option is displayed").isFalse();
    }

    @Then("For each Country Checklist record in the list controls buttons should be displayed")
    public void forEachCountryChecklistRecordInTheListControlsButtonsShouldBeDisplayed() {
        SoftAssertions soft = new SoftAssertions();
        soft.assertThat(countryChecklistPage.areEditButtonsDisplayedForEachRow())
                .as("Not all edit buttons are displayed").isTrue();
        soft.assertThat(countryChecklistPage.areDeleteButtonsDisplayedForEachRow())
                .as("Not all delete buttons are displayed").isTrue();
        soft.assertThat(countryChecklistPage.areAssignButtonsDisplayedForEachRow())
                .as("Not all assign buttons are displayed").isTrue();
        soft.assertAll();
    }

    @Then("^Country Checklist \"((.*))\" required (blank|populated) field is displayed$")
    public void countryChecklistRequiredBlankFilledFieldIsDisplayed(String fieldName, String state) {
        SoftAssertions softAssert = new SoftAssertions();
        if (state.equals(BLANK)) {
            softAssert.assertThat(countryChecklistPage.getTextFieldValue(fieldName))
                    .as(fieldName + " is not blank")
                    .isEmpty();
        } else {
            softAssert.assertThat(countryChecklistPage.getTextFieldValue(fieldName))
                    .as(fieldName + " is blank")
                    .isNotEmpty();
        }
        softAssert.assertThat(countryChecklistPage.isRequiredIndicatorDisplayedForField(fieldName))
                .as("Required indicator is not displayed")
                .isTrue();
        softAssert.assertThat(countryChecklistPage.getRequiredIndicatorColor(fieldName))
                .as("Required indicator is not red")
                .isEqualTo(REACT_RED.getColorRgba());
        softAssert.assertAll();
    }

    @Then("Country Checklist Name is saved in the system")
    public void countryChecklistNameIsSavedInTheSystem() {
        List<String> allCountryChecklistCountriesList =
                getCountryChecklistsList(ENORMOUS_ITEMS_PER_PAGE, _ID, DESC).stream()
                        .map(CountryChecklistData::getListName)
                        .collect(Collectors.toList());
        assertThat(allCountryChecklistCountriesList)
                .as("Country Checklist Name is not saved in the system")
                .asList().contains(this.context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT));
    }

    @Then("Country Checklist {string} field is highlighted in red")
    public void isFieldHighlightedRed(String fieldName) {
        assertThat(countryChecklistPage.isFieldBorderRed(fieldName)).as("%s field is not highlighted in red", fieldName)
                .isTrue();
    }

    @Then("Error message {string} is displayed for Country Checklist {string} field")
    public void isErrorMessageDisplayed(String message, String fieldName) {
        SoftAssertions soft = new SoftAssertions();
        soft.assertThat(countryChecklistPage.getFieldMessage(fieldName)).as("%s is not displayed for field %s", message,
                                                                            fieldName);
        soft.assertThat(countryChecklistPage.isFieldMessageRed(fieldName)).as("Message color is not red").isTrue();
        soft.assertAll();
    }

    @Then("^Country Checklist \"((.*))\" is (displayed|not displayed)$")
    public void isCountryChecklistDisplayed(String checklistName, String state) {
        if (checklistName.equals(VALUE_TO_REPLACE)) {
            checklistName = (String) context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
        }
        if (state.equals(DISPLAYED.toLowerCase())) {
            assertThat(countryChecklistPage.isCountryCheckListDisplayed(checklistName)).as(
                    "Country Checklist %s is not displayed", checklistName).isTrue();
        } else {
            assertThat(countryChecklistPage.isCountryCheckListDisplayed(checklistName)).as(
                    "Country Checklist %s is displayed", checklistName).isFalse();
        }
    }

    @Then("Country Checklist {string} populated with {string}")
    public void isListNameValueExpected(String fieldName, String value) {
        if (value.equals(COUNTRY_CHECKLIST_NAME_CONTEXT)) {
            value = (String) this.context.getScenarioContext().getContext(COUNTRY_CHECKLIST_NAME_CONTEXT);
        } else if (value.equals(COUNTRY_CHECKLIST_ALERT_MESSAGE_CONTEXT)) {
            value = (String) this.context.getScenarioContext().getContext(COUNTRY_CHECKLIST_ALERT_MESSAGE_CONTEXT);
        }
        assertThat(countryChecklistPage.getTextFieldValue(fieldName)).as("%s field is not populated with value %s",
                                                                         fieldName, value).isEqualTo(value);
    }

    @Then("Country Checklist table with headers is displayed")
    public void tableWithHeaders(DataTable headers) {
        List<String> expectedHeaders = headers.asList();
        List<String> actualHeaders = countryChecklistPage.getTableHeaders();
        assertThat(actualHeaders).as("Expected Country Checklist headers are not displayed")
                .isEqualTo(expectedHeaders);
    }

    @Then("Add Country Checklist button is displayed")
    public void checkAddListNameButtonIsDisplayed() {
        assertThat(countryChecklistPage.isAddListNameButtonDisplayed()).as("Add List button is not displayed").isTrue();
    }

    @Then("Table is sorted by default according to Date Created in DESC order")
    public void checkDefaultTableSorting() {
        List<CountryChecklistData> checklists =
                getCountryChecklistsList(DEFAULT_ITEMS_PER_PAGE, CREATE_TIME, DESC);
        List<String> expectedChecklistNames =
                checklists.stream().map(CountryChecklistData::getListName).collect(Collectors.toList());
        List<String> actualCheckListNames = countryChecklistPage.getListValuesForColumn(NAME.toUpperCase());
        assertThat(actualCheckListNames).as(
                        "Country Checklists are not sorted by default according to Date Created in DESC order")
                .isEqualTo(expectedChecklistNames);
    }

    @Then("{string} Country Checklist column is sorted in {string} order")
    public void checkColumnSorting(String columnName, String sortOrder) {
        List<String> valuesList = countryChecklistPage.getListValuesForColumn(columnName.toUpperCase());
        tableIsSortedByInOrder("Country Checklist", columnName, sortOrder, SORTING_FORMAT, valuesList, false);
    }

    @Then("{string} message is displayed for Country Checklist table")
    public void checkTableMessageIsDisplayed(String message) {
        assertThat(countryChecklistPage.getTableMessage()).as("%s message is not displayed", message)
                .isEqualTo(message);
    }

    @Then("Current URL contains endpoint {string}")
    public void currentURLContainsEndpoint(String expectedEndpoint) {
        String currentUrl = driver.getCurrentUrl();
        assertThat(currentUrl)
                .as("URL don't contains endpoint '%s'", expectedEndpoint)
                .endsWith(expectedEndpoint);
    }

}
