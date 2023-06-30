package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty;

import com.google.common.collect.ImmutableMap;
import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.ApiRequestBuilder;
import com.refinitiv.asts.test.ui.api.ConnectApi;
import com.refinitiv.asts.test.ui.api.model.ReferencesResponse;
import com.refinitiv.asts.test.ui.api.model.thirdParty.Address;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ObjectsItem;
import com.refinitiv.asts.test.ui.api.model.thirdParty.ThirdPartyFilterRequest;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.SearchSectionPage;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.ThirdPartyOverviewPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.ThirdPartyData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.ApiRequestBuilder.*;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getIndustryTypes;
import static com.refinitiv.asts.test.ui.api.ConnectApi.isThirdPartyNotFound;
import static com.refinitiv.asts.test.ui.api.SIPublicApi.*;
import static com.refinitiv.asts.test.ui.constants.APIConstants.SAME_DIVISION;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.DISPLAYED;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.NOT;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COLOR;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE_TO_REPLACE;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.enums.Colors.getColorRgbaFromHex;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.util.Arrays.asList;
import static java.util.Collections.reverseOrder;
import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static java.util.stream.Collectors.toList;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class ThirdPartyOverviewSteps extends BaseSteps {

    private static final ImmutableMap<String, String> SORT_FIELD = new ImmutableMap.Builder<String, String>()
            .put("Name", "name")
            .put("Industry Type", "industryType")
            .put("Country", "address.country")
            .put("Status", "status")
            .put("Risk Tier", "riskLevel")
            .put("Date Created", "createTime")
            .put("Last Update", "updateTime")
            .put("Screening Status (WC & Custom WL)", "overallStatus")
            .build();
    private static final ImmutableMap<String, String> SORT_ORDER = new ImmutableMap.Builder<String, String>()
            .put("ASC", "+")
            .put("DESC", "-")
            .build();
    public static final String NO_RESULTS = "No Results";
    public static final String UNRESOLVED = "Unresolved";
    public static final String POSSIBLE = "Possible";
    public static final String NEW = "NEW";
    public static final String NO_MATCH_FOUND = "NO MATCH FOUND";
    private final ThirdPartyOverviewPage thirdPartyOverviewPage;
    private final SearchSectionPage searchPage;

    public ThirdPartyOverviewSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.thirdPartyOverviewPage = new ThirdPartyOverviewPage(this.driver, this.context);
        searchPage = new SearchSectionPage(this.driver);
    }

    private List<ObjectsItem> updateResponseToUiFormat(List<ObjectsItem> objects) {
        ReferencesResponse industryTypes = getIndustryTypes();
        ReferencesResponse countries = ConnectApi.getCountries();
        return objects.stream().map(thirdParty -> thirdParty.setAddress(getAddress(thirdParty, countries))
                        .setCreateTime(thirdParty.getCreateTime() instanceof String ?
                                               updateDateFormat(PUBLIC_API_DATE_FORMAT, REACT_FORMAT,
                                                                (String) thirdParty.getCreateTime()) :
                                               getDateFromEpochMilli(((Double) thirdParty.getCreateTime()).longValue(),
                                                                     SI_UI_DATE_FORMAT))
                        .setUpdateTime(thirdParty.getUpdateTime() instanceof String ?
                                               updateDateFormat(PUBLIC_API_DATE_FORMAT, REACT_FORMAT,
                                                                (String) thirdParty.getUpdateTime()) :
                                               nonNull(thirdParty.getUpdateTime()) ?
                                                       getDateFromEpochMilli(((Double) thirdParty.getUpdateTime()).longValue(),
                                                                             REACT_FORMAT) : null)
                        .setOverallStatus(nonNull(thirdParty.getOverallStatus()) ?
                                                  thirdParty.getOverallStatus()
                                                          .replace(NO_RESULTS, NO_RESULTS.toUpperCase())
                                                          .replace(UNRESOLVED, UNRESOLVED.toUpperCase())
                                                          .replace(POSSIBLE, POSSIBLE.toUpperCase()).toUpperCase() :
                                                  null)
                        .setIndustryType(getIndustryTypeDescription(thirdParty.getIndustryType(), industryTypes))
                        .setName(thirdParty.getName().trim())
                        .setRiskLevel(thirdParty.getRiskLevel().isEmpty() ? null : thirdParty.getRiskLevel()))
                .collect(Collectors.toList());
    }

    private Address getAddress(ObjectsItem thirdParty, ReferencesResponse countries) {
        return new Address().setCountry(countries.getReferences().stream()
                                                .filter(industryType -> industryType.getCode()
                                                        .equals(thirdParty.getAddress().getCountry())).findAny()
                                                .orElseThrow(() -> new RuntimeException("Address was not found"))
                                                .getDescription());
    }

    private String getIndustryTypeDescription(Object industryTypeCode, ReferencesResponse industryTypes) {
        return isNull(industryTypeCode) ? null : industryTypes.getReferences().stream()
                .filter(industryType -> industryType.getCode().equals(industryTypeCode)).findAny()
                .orElseThrow(() -> new RuntimeException("Industry Type was not found"))
                .getDescription();
    }

    private List<String> getSortedExpectedNames(List<ThirdPartyData> expectedResult) {
        String pvalue = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_SEARCH_TERM);
        ThirdPartyFilterRequest request = getThirdPartyNameFilterRequest(ApiRequestBuilder.NAME,
                                                                         ApiRequestBuilder.LIKE,
                                                                         pvalue);
        List<ObjectsItem> filteredThirdParties = getFilteredThirdParties(request, SAME_DIVISION, FIFTY);
        expectedResult.forEach(expectedThirdParty -> {
            String createTime = (String) filteredThirdParties.stream().
                    filter(thirdParty -> thirdParty.getName().equals(expectedThirdParty.getName())).
                    findFirst().
                    orElseThrow(() -> new RuntimeException(
                            String.format("Third-party %s was not found", expectedThirdParty.getName()))).
                    getCreateTime();
            try {
                expectedThirdParty.setCreateTime(
                        getLongFromDateString(createTime.replace(UTC_ZERO, Z), API_DATE_FORMAT));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        });
        expectedResult.sort(reverseOrder(new ThirdPartyData.ThirdPartyComparator()));
        return expectedResult.stream().map(ThirdPartyData::getName).collect(toList());
    }

    private List<String> getThirdPartiesListAPIResponse(UserData userData) {
        List<String> apiThirdPartiesList;
        if (nonNull(this.context.getScenarioContext().getContext(THIRD_PARTY_SEARCH_TERM))) {
            ThirdPartyFilterRequest.CriteriaItem userCriteriaItem = getCriteriaItem(ApiRequestBuilder.SUPPLIER_MANAGER,
                                                                                    ApiRequestBuilder.EQUAL,
                                                                                    userData.getUsername());
            String pvalue = (String) this.context.getScenarioContext().getContext(THIRD_PARTY_SEARCH_TERM);
            ThirdPartyFilterRequest.CriteriaItem searchCriteriaItem = getCriteriaItem(ApiRequestBuilder.NAME,
                                                                                      ApiRequestBuilder.LIKE,
                                                                                      pvalue);
            apiThirdPartiesList = getFilteredThirdParties(
                    getThirdPartyNameFilterRequest(asList(userCriteriaItem, searchCriteriaItem)), ALL.toUpperCase(),
                    TEN)
                    .stream().map(ObjectsItem::getName)
                    .collect(toList());
        } else {
            apiThirdPartiesList = getFilteredThirdParties(
                    getThirdPartyNameFilterRequest(ApiRequestBuilder.SUPPLIER_MANAGER,
                                                   ApiRequestBuilder.EQUAL,
                                                   userData.getUsername()), ALL.toUpperCase(), TEN)
                    .stream().map(ObjectsItem::getName)
                    .collect(toList());
        }
        return apiThirdPartiesList;
    }

    @When("User navigates to Third-party page")
    public void navigateToThirdPartyOverviewPage() {
        thirdPartyOverviewPage.navigateToThirdPartyPage();
    }

    @When("User opens previously created Third-party")
    public void openPreviouslyCreatedThirdParty() {
        thirdPartyOverviewPage.openCreatedThirdParty();
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User opens Third-party with name {string}")
    public void openThirdPartyWithName(String name) {
        thirdPartyOverviewPage.openThirdParty(name);
        thirdPartyOverviewPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks Add Third-party button")
    public void clickAddThirdParty() {
        thirdPartyOverviewPage.clickOnAddThirdPartyButton();
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User deletes third-party saved in context")
    public void deleteThirdParty() {
        clickDeleteButtonOnThirdPartyWithNameFromContext();
        thirdPartyOverviewPage.clickOnConfirmDeleteThirdPartyButton();
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
        assertFalse("Confirmation Dialog is still displayed", thirdPartyOverviewPage.isConfirmationDialogDisplayed());
    }

    @When("User opens third-party creation form")
    public void openThirdPartyCreationForm() {
        ThirdPartyOverviewPage thirdPartyOverviewPage = new ThirdPartyOverviewPage(driver, context);
        thirdPartyOverviewPage.navigateToThirdPartyPage();
        thirdPartyOverviewPage.clickOnAddThirdPartyButton();
        thirdPartyOverviewPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
    }

    @When("User clicks third-party with name {string}")
    public void clickOnThirdPartyWithName(String thirdPartyName) {
        thirdPartyOverviewPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        thirdPartyOverviewPage.clickOpenThirdPartyWithName(thirdPartyName);
    }

    @When("User clicks third-party with reference {string}")
    public void clickOnThirdPartyWithReference(String thirdPartyReference) {
        String thirdPartyName = (String) context.getScenarioContext().getContext(thirdPartyReference);
        thirdPartyOverviewPage.clickOpenThirdPartyWithName(thirdPartyName);
    }

    @When("User clicks on created third-party")
    public void clickOnThirdPartyWithNameFromContext() {
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyOverviewPage.clickOpenThirdPartyWithName(thirdPartyData.getName());
    }

    @When("User clicks on third-party {string}")
    public void clickOnThirdPartyWithNameFromInput(String thirdPartyName) {
        thirdPartyOverviewPage.clickOpenThirdPartyWithName(thirdPartyName);
    }

    @When("User clicks 'Edit' button on created third-party")
    public void clickEditButtonOnThirdPartyWithNameFromContext() {
        ThirdPartyData thirdPartyData = (ThirdPartyData) context.getScenarioContext().getContext(
                THIRD_PARTY_DATA_CONTEXT);
        thirdPartyOverviewPage.clickEditButtonOnThirdParty(thirdPartyData.getName());
    }

    @When("User clicks 'Delete' button on created third-party")
    public void clickDeleteButtonOnThirdPartyWithNameFromContext() {
        thirdPartyOverviewPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyOverviewPage.clickDeleteThirdPartyWithName(thirdPartyData.getName());
    }

    @When("User clicks 'Delete' button on third-party name {string}")
    public void clickDeleteButtonOnThirdPartyWithNameFromInput(String thirdPartyName) {
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyOverviewPage.clickDeleteThirdPartyWithName(thirdPartyName);
    }

    @When("User deletes {int} previously created Third-parties with similar name")
    public void deletePreviouslyCreatedSimilarNameThirdParties(int numberOfThirdPartiesToDelete) {
        for (int i = 0; i < numberOfThirdPartiesToDelete; i++) {
            thirdPartyOverviewPage.clickDeleteThirdPartyWithSimilarName(numberOfThirdPartiesToDelete - i);
            thirdPartyOverviewPage.clickOnConfirmDeleteThirdPartyButton();
            thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
        }
    }

    @Then("^Third Party (Bank Details|General Information|Address) section fields are shown according to table$")
    public void addNameMandatoryTextFieldIsDisplayed(String section, DataTable dataTable) {
        SoftAssertions soft = new SoftAssertions();
        dataTable.asMap(String.class, String.class).forEach((field, state) -> soft.assertThat(
                        thirdPartyOverviewPage.isThirdPartySectionFieldDisplayed(section, (String) field))
                .as("Field %s is not in '%s' state", field, state)
                .isEqualTo(DISPLAYED.toLowerCase().equals(state)));
        soft.assertAll();
    }

    @When("User deletes Third-party with name {string}")
    public void deleteThirdPartyWithName(String name) {
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
        thirdPartyOverviewPage.clickDeleteThirdPartyWithName(name);
    }

    @When("User searches third-party with name {string}")
    public void searchThirdPartyByName(String thirdPartyName) {
        if (thirdPartyName.equals(VALUE_TO_REPLACE)) {
            thirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
        }
        searchPage.searchItem(thirdPartyName);
    }

    @When("User searches created third-party")
    public void searchThirdPartyFromContext() {
        ThirdPartyData thirdPartyData = (ThirdPartyData) this.context.getScenarioContext()
                .getContext(THIRD_PARTY_DATA_CONTEXT);
        searchPage.searchItem(thirdPartyData.getName());
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User searches third-party by reference {string}")
    public void searchThirdPartyFromReference(String thirdPartyReference) {
        String thirdPartyName = (String) this.context.getScenarioContext()
                .getContext(thirdPartyReference);
        searchPage.searchItem(thirdPartyName);
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks 'Advance Search' link")
    public void clickAdvanceSearchLink() {
        thirdPartyOverviewPage.navigateToAdvanceSearch();
    }

    @When("Users clicks {string} column in Third-party Overview table header")
    public void clickColumnInThirdPartyOverviewTableHeader(String columnName) {
        thirdPartyOverviewPage.clickColumnHeader(columnName);
    }

    @When("User copies Third-party ID from the URL and saves it in context")
    public void getThirdPartyIdFromUrlAndSaveToContext() {
        context.getScenarioContext().setContext(THIRD_PARTY_ID, thirdPartyOverviewPage.getThirdPartyIdFromUrl());
    }

    @Then("Third-party {string} does not appear in the Third-party Overview table")
    public void thirdPartyDoesNotAppearInTheThirdPartyTable(String thirdPartyReference) {
        String thirdPartyName = (String) context.getScenarioContext().getContext(thirdPartyReference);
        assertTrue("Third-party with name: " + thirdPartyName + " still appears in the Third-party Overview table",
                   thirdPartyOverviewPage.isThirdPartyWithNameDisappeared(thirdPartyName));
    }

    @Then("Third-party with reference {string} is displayed in Third-party overview table")
    public void thirdPartyReferenceIsDisplayed(String thirdPartyReference) {
        String thirdPartyName = (String) context.getScenarioContext().getContext(thirdPartyReference);
        thirdPartyIsDisplayed(thirdPartyName);
    }

    @Then("Third-party with name {string} is displayed in Third-party overview table")
    public void thirdPartyIsDisplayed(String thirdPartyName) {
        if (thirdPartyName.equals(VALUE_TO_REPLACE)) {
            thirdPartyName = (String) context.getScenarioContext().getContext(THIRD_PARTY_NAME);
        }
        assertTrue("Third-party with name: " + thirdPartyName + " is not displayed",
                   thirdPartyOverviewPage.isThirdPartyWithNameDisplayed(thirdPartyName));
    }

    @Then("Created third-party is displayed in Third-party overview table")
    public void createdThirdPartyIsDisplayed() {
        ThirdPartyData thirdPartyData =
                (ThirdPartyData) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyIsDisplayed(thirdPartyData.getName());
    }

    @Then("Third-party should have status {string}")
    public void checkThirdPartyStatus(String status) {
        ThirdPartyData thirdPartyData = (ThirdPartyData) this.context.getScenarioContext()
                .getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyOverviewPage.waitRowsNumberAppearance(0);
        assertThat(thirdPartyOverviewPage.isThirdPartyOnListHasStatus(thirdPartyData.getName(), status))
                .as("Third-party doesn't have expected status")
                .isTrue();
    }

    @Then("Third-party name {string} should have status {string}")
    public void checkThirdPartyNameWithStatus(String name, String status) {
        thirdPartyOverviewPage.waitRowsNumberAppearance(0);
        assertEquals("Third-party doesn't have expected status", status,
                     thirdPartyOverviewPage.getThirdPartyByName(name).getStatus().getText());
    }

    @Then("Third-party Overview tab is loaded")
    public void informationTabIsLoaded() {
        assertThat(thirdPartyOverviewPage.isPageLoaded()).as("Third-party Overview tab is not displayed").isTrue();
    }

    @Then("Third-party Overview header {string} should be displayed")
    public void checkThirdPartyHeaderIsDisplayed(String header) {
        assertThat(thirdPartyOverviewPage.isHeaderWithTextDisplayed(header))
                .as("Third-party Overview header is not displayed").isTrue();
    }

    @Then("^Add Third-party button should be (displayed|invisible)$")
    public void checkThirdPartyButtonIsDisplayed(String state) {
        assertThat(thirdPartyOverviewPage.isAddThirdPartyButtonDisplayed())
                .as("Add Third-party button is not %s", state).isEqualTo(state.equalsIgnoreCase(DISPLAYED));
    }

    @Then("Third-party Overview table should be displayed")
    public void checkThirdPartyTableIsDisplayed() {
        assertThat(thirdPartyOverviewPage.isTableDisplayed())
                .as("Add Third-party button is not displayed").isTrue();
    }

    @Then("Third-party Table Column {string} is displayed")
    public void thirdPartyScreeningStatusIsDisplayed(String columnName) {
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
        assertTrue("Third-party Table column: " + columnName + " is not displayed",
                   thirdPartyOverviewPage.isThirdPartyColumnDisplayed(columnName));
    }

    @Then("Third-party Table columns are displayed")
    public void thirdPartyTableColumnsAreDisplayed(List<String> columnNames) {
        columnNames.forEach(this::thirdPartyScreeningStatusIsDisplayed);
    }

    @Then("Third-party Overview table displays {int} third-parties sorted by {string} in {string} order")
    public void thirdPartyTableDisplaysThirdPartiesSortedBy(int usersCount, String sortedBy, String sortOrder) {
        thirdPartyOverviewPage.waitWhilePreloadProgressbarIsDisappeared();
        List<ObjectsItem> expectedList =
                updateResponseToUiFormat(
                        getAllThirdParties(usersCount, SORT_FIELD.get(sortedBy), SORT_ORDER.get(sortOrder)));
        List<ObjectsItem> actualList = thirdPartyOverviewPage.getThirdPartiesListFullDetails();
        assertThat(actualList).usingRecursiveFieldByFieldElementComparatorIgnoringFields("id", "iwOgmStatus",
                                                                                         "managerDivisions",
                                                                                         "supplierManager",
                                                                                         "userDivisions")
                .as("Table is not sorted according to " + sortedBy + " in " + sortOrder + " order")
                .isEqualTo(expectedList);
    }

    @Then("Advanced Search link should be displayed")
    public void checkAdvancedSearchLinkIsDisplayed() {
        assertThat(thirdPartyOverviewPage.isAdvancedSearchIsDisplayed())
                .as("Advanced Search link is not displayed").isTrue();
    }

    @Then("Created third-party does not exist")
    public void createdThirdPartyDoesNotExist() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_ID);
        assertTrue("Created third-party exists", isThirdPartyNotFound(thirdPartyId));
    }

    @Then("Third-party Table Column {string} is between {string} and {string} columns")
    public void thirdPartyTableColumnIsBetweenAndColumns(String columnName, String beforeColumn, String afterColumn) {
        thirdPartyOverviewPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(thirdPartyOverviewPage.isColumnBetween(columnName, beforeColumn, afterColumn))
                .as("Third-party Table Column %s is between %s and %s columns", columnName, beforeColumn,
                    afterColumn)
                .isTrue();
    }

    @Then("The Risk Tier column displays the Risk Tier of each third-party")
    public void theRiskTierColumnDisplaysTheRiskTierOfEachThirdParty() {
        Map<String, String> riskTierColors = getRiskColors();
        thirdPartyOverviewPage.getAllThirdParties()
                .forEach(thirdParty ->
                                 assertThat(thirdPartyOverviewPage.getRiskTierColumnValueCssValue(thirdParty, COLOR))
                                         .as("Risk Tier color is incorrect")
                                         .isEqualTo(getColorRgbaFromHex(
                                                 riskTierColors.get(thirdParty.getRiskTier().getText()))));
    }

    @Then("The Edit button is displayed and enabled for each third-party")
    public void theEditButtonIsDisplayedAndEnabledForEachThirdParty() {
        SoftAssert softAssert = new SoftAssert();
        thirdPartyOverviewPage.getAllThirdParties()
                .forEach(thirdParty -> {
                    softAssert.assertTrue(thirdPartyOverviewPage.isElementDisplayed(thirdParty.getEdit()),
                                          "The Edit button is not displayed");
                    softAssert.assertTrue(thirdPartyOverviewPage.isElementEnabled(thirdParty.getEdit()),
                                          "The Edit button is not enabled");
                });
        softAssert.assertAll();
    }

    @Then("Edit buttons are not displayed for third-parties")
    public void editButtonsAreNotDisplayed() {
        assertThat(thirdPartyOverviewPage.getEditButtonsList())
                .as("Edit buttons are displayed")
                .isEmpty();
    }

    @Then("The Delete button is displayed and enabled for each third-party which could be deleted")
    public void theDeleteButtonIsDisplayedAndEnabledForEachThirdPartyWhichCouldBeDeleted() {
        SoftAssert softAssert = new SoftAssert();
        thirdPartyOverviewPage.getAllThirdParties()
                .forEach(thirdParty -> {
                    if (thirdPartyOverviewPage.getElementText(thirdParty.getStatus()).equals(NEW)) {
                        softAssert.assertTrue(thirdPartyOverviewPage.isElementDisplayed(thirdParty.getDelete()),
                                              "The Delete button is not displayed");
                        softAssert.assertTrue(thirdPartyOverviewPage.isElementEnabled(thirdParty.getDelete()),
                                              "The Delete button is not enabled");
                    } else {
                        softAssert.assertFalse(thirdPartyOverviewPage.isElementDisplayed(thirdParty.getDelete()),
                                               "The Delete button is displayed");
                    }
                });
        softAssert.assertAll();
    }

    @Then("The Delete button is not displayed for each third-party")
    public void theDeleteButtonIsDisplayed() {
        SoftAssertions softAssert = new SoftAssertions();
        thirdPartyOverviewPage.getAllThirdParties()
                .forEach(thirdParty -> softAssert.assertThat(
                                thirdPartyOverviewPage.isElementDisplayed(thirdParty.getDelete()))
                        .as("The Delete button is displayed")
                        .isFalse());
        softAssert.assertAll();
    }

    @Then("^Third-party overview (contains|does not contain) \"((.*))\" third-party$")
    public void thirdPartyOverviewContainsThirdParty(String state, String thirdPartyReference) {
        ThirdPartyData thirdPartyData =
                new JsonUiDataTransfer<ThirdPartyData>(THIRD_PARTY).getTestData().get(thirdPartyReference)
                        .getDataToEnter();
        List<ObjectsItem> filteredThirdParties = getFilteredThirdParties(
                getThirdPartyNameFilterRequest(ApiRequestBuilder.NAME, ApiRequestBuilder.LIKE,
                                               thirdPartyData.getName()), SAME_DIVISION, TEN);
        if (state.contains(NOT)) {
            if (!filteredThirdParties.isEmpty()) {
                throw new SkipException(thirdPartyData.getName() + " already exists!");
            }
        } else {
            assertThat(filteredThirdParties).
                    as("Third-party with name: %s is not created", thirdPartyData.getName())
                    .isNotEmpty();
            this.context.getScenarioContext().setContext(THIRD_PARTY_ID, null);
        }

    }

    @Then("^Third-party overview table (contains|does not contains) records with Name in relevancy order sorted by creation time$")
    public void thirdPartyOverviewTableContainsRecordsWithNameInRelevancyOrder(String state,
            List<ThirdPartyData> expectedData) {
        List<String> expectedNames = expectedData.stream().map(ThirdPartyData::getName).collect(toList());
        if (state.contains(NOT)) {
            assertThat(thirdPartyOverviewPage.getAllThirdPartiesNames())
                    .as("Third-party overview table contains unexpected Third-parties")
                    .doesNotContainAnyElementsOf(
                            expectedNames);
        } else {
            List<String> allThirdPartiesNames = thirdPartyOverviewPage.getAllThirdPartiesNames();
            for (String name : thirdPartyOverviewPage.getAllThirdPartiesNames()) {
                if (!expectedNames.contains(name)) {
                    allThirdPartiesNames.remove(name);
                }
            }
            expectedNames = getSortedExpectedNames(expectedData);
            assertThat(allThirdPartiesNames)
                    .as("Third-party overview table contains unexpected Third-parties order")
                    .isEqualTo(expectedNames);
        }
    }

    @Then("Third-party Overview {string} message is displayed")
    public void thirdPartyOverviewMessageIsDisplayed(String expectedMessage) {
        assertThat(thirdPartyOverviewPage.getEmptyTableMessage()).
                as("Third-party overview table message is unexpected")
                .isEqualTo(expectedMessage);
    }

    @Then("Third-party overview table is displayed with assigned to the user")
    public void checkAllThirdPartiesCreatedByCurrentManager() {
        UserData userData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        List<String> apiThirdPartiesList = getThirdPartiesListAPIResponse(userData);
        if (apiThirdPartiesList.isEmpty()) {
            thirdPartyOverviewMessageIsDisplayed(NO_MATCH_FOUND);
        } else {
            assertThat(apiThirdPartiesList).as("Not all Third-parties assigned to current user")
                    .containsAll(thirdPartyOverviewPage.getAllThirdPartiesNames());
        }
    }

    @Then("Third-party should have Screening Status {string}")
    public void checkThirdPartyScreeningStatus(String screeningStatus) {
        ThirdPartyData thirdPartyData = (ThirdPartyData) this.context.getScenarioContext()
                .getContext(THIRD_PARTY_DATA_CONTEXT);
        thirdPartyOverviewPage.waitRowsNumberAppearance(0);
        assertEquals("Third-party doesn't have expected Screening Status", screeningStatus,
                     thirdPartyOverviewPage.getThirdPartyByName(thirdPartyData.getName()).getScreeningStatus()
                             .getText());
    }

    @Then("Third-party name {string} should have Screening Status {string}")
    public void checkThirdPartyNameScreeningStatus(String name, String screeningStatus) {
        thirdPartyOverviewPage.waitRowsNumberAppearance(0);
        assertEquals("Third-party doesn't have expected Screening Status", screeningStatus,
                     thirdPartyOverviewPage.getThirdPartyByName(name).getScreeningStatus().getText());
    }

}
