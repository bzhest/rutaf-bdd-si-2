package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.thirdPartyInformation;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.TestConstants;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.enums.SecondaryFieldType;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.OtherNameSectionPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.OtherName;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.getContactOtherNameSearchId;
import static com.refinitiv.asts.test.ui.api.AppApi.getCountriesNamesList;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getOtherNameSearchId;
import static com.refinitiv.asts.test.ui.api.ConnectApi.getTenantFlagResponse;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COLOR;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.OTHER_NAME;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.stepDefinitions.ui.CommonSteps.COLON;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.SI_MAIN_SCREENING_DATE_FORMAT;
import static com.refinitiv.asts.test.ui.utils.wc1.CaseDataBuilder.getOtherNameCaseSecondaryFieldValue;
import static java.util.Comparator.naturalOrder;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.*;

public class OtherNamesSteps extends BaseSteps {

    private final OtherNameSectionPage otherNameSectionPage;

    public OtherNamesSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.otherNameSectionPage = new OtherNameSectionPage(this.driver, this.context, translator);
    }

    @When("User clicks on {string}")
    public void clickOn(String otherNameButton) {
        otherNameSectionPage.clickOn(otherNameButton);
    }

    @When("User clears {string}")
    public void clearField(String elementName) {
        otherNameSectionPage.clearInputField(elementName);
    }

    @When("User clicks clear {string} Other Name field")
    public void clickClearOtherNameField(String elementName) {
        otherNameSectionPage.clickOnInputField(elementName);
        otherNameSectionPage.clickOnClearDropDown(elementName);
    }

    @When("User creates random {int} characters other name")
    public void randomOtherNameValue(int number) {
        String name = RandomStringUtils.randomAlphabetic(number);
        context.getScenarioContext().setContext(THIRD_PARTY_OTHER_NAME, name);
    }

    @When("User fills in Name field value {string}")
    public void inputNameFieldWithValue(String inputString) {
        if (inputString.equals(RANDOM_GENERATED_STRING)) {
            inputString = (String) context.getScenarioContext().getContext(THIRD_PARTY_OTHER_NAME);
        }
        otherNameSectionPage.fillNameField(inputString);
    }

    @When("User selects Name type {string}")
    public void editNameTypeFieldWithValue(String inputString) {
        otherNameSectionPage.fillNameTypeField(inputString);
    }

    @And("User edits {string} field with value {string}")
    public void editFieldWithValue(String countryType, String inputString) {
        otherNameSectionPage.selectCountry(countryType, inputString);
    }

    @When("User creates Other name {string}")
    public void createOtherName(String otherNameReference) {
        final GenericTestData<OtherName> otherNameTestData =
                new JsonUiDataTransfer<OtherName>(OTHER_NAME).getTestData().get(otherNameReference);
        this.context.getScenarioContext().setContext(OTHER_NAME_DATA, otherNameTestData);
        otherNameSectionPage.fillNameField(otherNameTestData.getDataToEnter().getName());
        otherNameSectionPage.fillNameTypeField(otherNameTestData.getDataToEnter().getType());
        otherNameSectionPage.clickOn(OTHER_NAME_ADD_SAVE_BUTTON);
        otherNameIsCreated(otherNameTestData.getDataToEnter().getName());
        String otherNameSearchId =
                getOtherNameSearchId((String) context.getScenarioContext().getContext(THIRD_PARTY_ID),
                                     otherNameTestData.getDataToEnter().getName());
        this.context.getScenarioContext().setContext(OTHER_NAME_ID, otherNameSearchId);
        logger.info("Other name '" + otherNameTestData.getDataToEnter().getName() + "' added successful");
        logger.info("Other name Search ID: " + otherNameSearchId);
    }

    @When("User creates Other name {string} for Associated Party")
    public void createOtherNameForContact(String otherNameReference) {
        final GenericTestData<OtherName> otherNameTestData =
                new JsonUiDataTransfer<OtherName>(OTHER_NAME).getTestData().get(otherNameReference);
        this.context.getScenarioContext().setContext(OTHER_NAME_DATA, otherNameTestData);
        otherNameSectionPage.fillNameField(otherNameTestData.getDataToEnter().getName());
        otherNameSectionPage.fillNameTypeField(otherNameTestData.getDataToEnter().getType());
        otherNameSectionPage.clickOn(OTHER_NAME_ADD_SAVE_BUTTON);
        String contactId = (String) context.getScenarioContext().getContext(CONTACT_ID);
        String contactOtherNameSearchId =
                getContactOtherNameSearchId(contactId, otherNameTestData.getDataToEnter().getName());
        context.getScenarioContext().setContext(OTHER_NAME_ID, contactOtherNameSearchId);
        logger.info("Contact Other name '" + otherNameTestData.getDataToEnter().getName() + "' added successful");
        logger.info("Other name Search ID: " + contactOtherNameSearchId);
    }

    @When("User opens screening results for {string} Other name")
    public void openScreeningResultsForOtherName(String otherName) {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        otherNameSectionPage.clickScreenOtherNameScreenIcon(otherName);
    }

    @When("User clicks on Screen Other Name Button for {string} name")
    public void clickOnScreenOtherNameButtonForName(String otherName) {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        otherNameSectionPage.clickScreenOtherNameScreenIcon(otherName);
    }

    @When("User clicks on Edit Other Name Button for {string} name")
    public void clickOnEditOtherNameButtonForName(String otherName) {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        otherNameSectionPage.clickEditOtherNameButton(otherName);
    }

    @When("User clicks on Delete Other Name Button for {string} name")
    public void clickOnDeleteOtherNameButton(String otherName) {
        otherNameSectionPage.clickDeleteOtherNameButton(otherName);
    }

    @When("^User clicks \"(Cancel|Proceed)\" on Delete Other Name modal window$")
    public void clickButtonOnDeleteOtherNameModal(String buttonType) {
        switch (buttonType) {
            case (CANCEL):
                otherNameSectionPage.clickDeleteOtherNameModalCancelButton();
                break;
            case (PROCEED):
                otherNameSectionPage.clickDeleteOtherNameModalProceedButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("User creates Other Name for contract as {string}")
    public void createOtherNameContract(String otherNameContract) {
        final GenericTestData<OtherName> otherNameTestData =
                new JsonUiDataTransfer<OtherName>(OTHER_NAME).getTestData().get(otherNameContract);
        this.context.getScenarioContext().setContext(OTHER_NAME_DATA, otherNameTestData);
        otherNameSectionPage.fillInInputField(NAME, otherNameTestData.getDataToEnter().getName());
        otherNameSectionPage.fillInInputField(NAME_TYPE, otherNameTestData.getDataToEnter().getType());
        otherNameSectionPage.clickOn(OTHER_NAME_ADD_SAVE_BUTTON);
        otherNameSectionPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks on Other name Check Type {string}")
    public void clickOnCheckType(String checkType) {
        otherNameSectionPage.clickCheckTypeCheckbox(checkType);
    }

    @When("User clicks on media check Other Names screening record on position {int}")
    public void selectMediaCheckScreeningRecordForOnPosition(int record) {
        otherNameSectionPage.clickOnMediaCheckRecord(record);
    }

    @When("User selects other name group {int}")
    public void selectOtherNameGroup(int groupIndex) {
        otherNameSectionPage.selectOtherNameGroup(groupIndex);
    }

    @When("User hovers to Other Name Group field")
    public void hoverToOtherNameGroupField() {
        otherNameSectionPage.hoverToOtherNameGroup();
    }

    @When("User hovers to Other Name groups dropdown {int}")
    public void hoverToGroupsDropDown(int groupIndex) {
        otherNameSectionPage.hoverToOtherNameGroupsDropDown(groupIndex);
    }

    @When("User hovers WC Screening Other Name {string} Type {string} icon")
    public void hoverWCScreeningTypeIcon(String name, String type) {
        otherNameSectionPage.scrollIntoViewWCOtherNameRecord(name, type);
        otherNameSectionPage.hoversOverWCScreeningOtherNameType(name, type);
    }

    @Then("^\"((.*))\" for other name is (displayed|disappeared)$")
    public void elementForOtherNameIsDisplayed(String elementName, String elementState) {
        if (elementState.equals(DISPLAYED.toLowerCase())) {
            assertTrue(elementName + " is not displayed",
                       otherNameSectionPage.isOtherNameElementDisplayed(elementName));
        } else {
            assertTrue(elementName + " is not disappeared",
                       otherNameSectionPage.isOtherNameElementDisappeared(elementName));
        }
    }

    @Then("Add Name mandatory text field is displayed")
    public void addNameMandatoryTextFieldIsDisplayed() {
        assertTrue("Name field input is not displayed", otherNameSectionPage.isInputFieldWithNameDisplayed(NAME));
        assertTrue("Name field doesn't contain required field '*' indicator",
                   otherNameSectionPage.isRequireIndicatorDisplayed(NAME));
    }

    @Then("^(?:Add|Edit) Name Type mandatory drop-down field is displayed with list$")
    public void addNameTypeMandatoryDropDownFieldIsDisplayed(List<String> expectedDropDownValues) {
        assertTrue("Name type input field is not displayed",
                   otherNameSectionPage.isInputFieldWithNameDisplayed(NAME_TYPE));
        assertTrue("Name type field doesn't contain required field '*' indicator",
                   otherNameSectionPage.isRequireIndicatorDisplayed(NAME_TYPE));
        otherNameSectionPage.clickOnOpenDropDown(NAME_TYPE);
        assertEquals("Name Type drop-down list doesn't contains expected values",
                     expectedDropDownValues, otherNameSectionPage.getDropDownListValues(NAME_TYPE));
        otherNameSectionPage.clickCloseDropDown(NAME_TYPE);
    }

    @Then("^(?:Add|Edit) \"((.*))\" drop-down field is displayed with list of countries from WC1$")
    public void addDropDownFieldIsDisplayedWithListOfCountriesFromWC(String countryType) {
        SoftAssertions softAssert = new SoftAssertions();
        List<String> expectedDropDownValues = getCountriesNamesList();
        softAssert.assertThat(otherNameSectionPage.isInputFieldWithNameDisplayed(countryType))
                .as(countryType + " input field is not displayed")
                .isTrue();
        softAssert.assertThat(otherNameSectionPage.isDropDownForFieldWithNameDisplayed(countryType))
                .as(countryType + " field drop-down button is not displayed")
                .isTrue();
        otherNameSectionPage.clickOnOpenDropDown(countryType);
        softAssert.assertThat(otherNameSectionPage.getDropDownListValues(countryType))
                .as(countryType + " drop-down list doesn't contains expected values").isEqualTo(expectedDropDownValues);
        otherNameSectionPage.clickCloseDropDown(countryType);
        softAssert.assertAll();
    }

    @Then("Error message {string} in red color is displayed near {string}")
    public void errorMessageInRedColorIsDisplayedNearField(String message, String fieldName) {
        assertTrue(fieldName + " field doesn't display invalid aria",
                   otherNameSectionPage.isFieldInvalidAriaDisplayed(fieldName));
        assertEquals(fieldName + " error message is not displayed",
                     otherNameSectionPage.getInputFieldErrorText(fieldName), message);
        assertEquals(fieldName + " error message is not red",
                     REACT_RED.getColorRgba(), otherNameSectionPage.getErrorMessageElementCSS(fieldName, COLOR));
    }

    @Then("Optional {string} is not highlighted")
    public void optionalIsNotHighlighted(String fieldName) {
        assertFalse(fieldName + " is highlighted", otherNameSectionPage.isFieldInvalidAriaDisplayed(fieldName));
    }

    @Then("Other Name table is displayed with column names")
    public void otherNameTableIsDisplayedWithColumnNames(DataTable dataTable) {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> actualColumnNames = otherNameSectionPage.getOtherNamesTableColumnNames();
        List<String> expectedColumnNames = dataTable.asList();
        assertEquals("Other Name table is not displayed expected column names",
                     expectedColumnNames, actualColumnNames);

    }

    @Then("Other Name table contains expected values")
    public void otherNameTableContainsExpectedValues(List<String> expectedColumnValues) {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> actualColumnValues = otherNameSectionPage.getOtherNamesTableColumnValues();
        String todayDate = getTodayDate(REACT_FORMAT);
        expectedColumnValues = expectedColumnValues.stream().map(s -> s.replace(REACT_FORMAT, todayDate))
                .collect(Collectors.toList());
        assertEquals("Other Name table is not displayed expected column values",
                     expectedColumnValues, actualColumnValues);
    }

    @Then("Edit Other Name button is displayed in the Other Names section after each record")
    public void editOtherNameButtonIsDisplayedInTheOtherNamesSectionAfterEachRecord() {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        List<String> otherNames = otherNameSectionPage.getOtherNameColumnValuesList(NAME);
        otherNames.forEach(
                otherName -> assertTrue(" Edit Other Name button is not displayed for name '" + otherName + "'",
                                        otherNameSectionPage.isEditButtonDisplayed(otherName)));
    }

    @Then("Screening Other Name button is displayed in the Other Names section after each record")
    public void screeningOtherNameButtonIsDisplayedInTheOtherNamesSectionAfterEachRecord() {
        List<String> otherNames = otherNameSectionPage.getOtherNameColumnValuesList(NAME);
        SoftAssert softAssert = new SoftAssert();
        otherNames.forEach(
                otherName -> softAssert.assertTrue(otherNameSectionPage.isScreeningButtonDisplayed(otherName),
                                                   "Screening Other Name button is not displayed for name '" +
                                                           otherName + "'"));
        softAssert.assertAll();
    }

    @Then("Delete Other Name button is displayed in the Other Names section after each record")
    public void deleteOtherNameButtonIsDisplayedInTheOtherNamesSectionAfterEachRecord() {
        otherNameSectionPage.waitWhileLoadingImageIsDisappeared();
        List<String> otherNames = otherNameSectionPage.getOtherNameColumnValuesList(NAME);
        otherNames.forEach(
                otherName -> assertTrue("Delete Other Name button is not displayed for name '" + otherName + "'",
                                        otherNameSectionPage.isDeleteButtonDisplayed(otherName)));
    }

    @Then("The Other name is deleted from table")
    @SuppressWarnings("unchecked")
    public void theOtherNameIsDeletedFromTable() {
        final GenericTestData<OtherName> otherNameTestData =
                (GenericTestData<OtherName>) context.getScenarioContext().getContext(OTHER_NAME_DATA);
        assertTrue("Other name '" + otherNameTestData.getDataToEnter().getName() + "' is still displayed",
                   otherNameSectionPage.isOtherNameRowDisappeared(otherNameTestData.getDataToEnter().getName()));
    }

    @Then("Other name {string} is created")
    public void otherNameIsCreated(String otherName) {
        otherNameSectionPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (otherName.equals(RANDOM_GENERATED_STRING)) {
            String nameValue = (String) context.getScenarioContext().getContext(THIRD_PARTY_OTHER_NAME);
            if (nameValue.length() > 250) {
                otherName = nameValue.substring(0, 250);
            } else {
                otherName = nameValue;
            }
        }
        assertTrue("Other name '" + otherName + "' is not created",
                   otherNameSectionPage.isOtherNameRowPresent(otherName));
    }

    @Then("Field {string} for other name is empty")
    public void fieldForOtherNameIsEmpty(String fieldName) {
        assertEquals(fieldName + " input is not empty",
                     StringUtils.EMPTY, otherNameSectionPage.getInputFieldValue(fieldName));
    }

    @Then("Other Name field {string} contains value {string}")
    public void otherNameFieldContainsValue(String fieldName, String expectedValue) {
        otherNameSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals(fieldName + " doesn't match expected",
                     expectedValue, otherNameSectionPage.getInputFieldValue(fieldName));
    }

    @Then("Selected Name type {string} is disabled")
    public void selectedNameTypeIsDisabled(String selectedOption) {
        otherNameSectionPage.clickOnOpenDropDown(NAME_TYPE);
        assertTrue(selectedOption + " option is not disabled",
                   otherNameSectionPage.isDropDownOptionWithTextDisabled(selectedOption));
        otherNameSectionPage.clickCloseDropDown(NAME_TYPE);
    }

    @Then("WC1 case contains {string} provided {string} for {string} {string} other name secondary field")
    public void wcCaseContainsProvidedOtherNameSecondaryField(String expectedSecondaryField, String secondaryFieldName,
            String resultsFor, String otherName) {
        String actualSecondaryField = getOtherNameCaseSecondaryFieldValue(context, otherName, resultsFor,
                                                                          SecondaryFieldType.valueOf(secondaryFieldName)
                                                                                  .getTypeId());
        assertEquals("WC1 other name case secondary field doesn't match expected ",
                     expectedSecondaryField, actualSecondaryField);
    }

    @Then("Other Name Check Type checkbox fields are displayed with options")
    public void otherNameCheckTypeCheckboxFieldsAreDisplayedWithOptions(List<String> expectedResult) {
        List<String> actualResult = otherNameSectionPage.getCheckTypeOptions();
        assertThat(actualResult).as("Other Name Check Type checkbox fields are not expected").isEqualTo(expectedResult);
    }

    @Then("Other Name Check Type is checked")
    public void checkTypeIsCheckedOnTheFollowingList(List<String> checkTypes) {
        SoftAssert soft = new SoftAssert();
        checkTypes.forEach(text -> soft.assertTrue(otherNameSectionPage.isCheckTypeChecked(text),
                                                   "Other Name Check Type '" + text + "' isn't checked"));
        soft.assertAll();
    }

    @Then("Other Name Check Type {string} is disabled")
    public void checkTypeIsDisabled(String checkType) {
        assertThat(otherNameSectionPage.isCheckTypeDisabled(checkType)).as("Other Name Check Type %s is not disabled",
                                                                           checkType).isTrue();
    }

    @Then("Check Type label {string} is displayed when API return {string}")
    public void checkTypeLabelIsDisplayed(String checkTypeLabel, String tenantKey) {
        Map<String, Boolean> mapTenantFlagResponse = getTenantFlagResponse();
        assertEquals("Check type is displayed incorrectly", mapTenantFlagResponse.get(tenantKey),
                     otherNameSectionPage.isCheckTypeLabelDisplayed(checkTypeLabel));
    }

    @Then("{string} check type is selected when API return {string}")
    public void checkTypeIsSelected(String checkTypeName, String tenantFlagKey) {
        Map<String, Boolean> mapTenantFlagKey = getTenantFlagResponse();
        assertEquals("Check type is displayed incorrectly", mapTenantFlagKey.get(tenantFlagKey),
                     otherNameSectionPage.isCheckTypeIsSelected(checkTypeName));
    }

    @Then("Delete Other Name modal window contains text")
    public void deleteOtherNameModalWindowIsOpened(DataTable dataTable) {
        String expectedText = dataTable.asList().get(0);
        assertThat(otherNameSectionPage.getDeleteOtherNameModalBodyText()).as(
                "Delete Other Name modal windows is not opened").isEqualTo(expectedText);
    }

    @Then("Delete Other Name modal window is opened")
    public void deleteOtherNameModalWindowIsOpened() {
        assertThat(otherNameSectionPage.isDeleteOtherNameModalOpened()).as(
                "Delete Other Name modal windows is not opened").isTrue();
    }

    @Then("Delete Other Name modal window is closed")
    public void deleteOtherNameModalWindowIsClosed() {
        assertThat(otherNameSectionPage.isDeleteOtherNameModalClosed()).as(
                "Delete Other Name modal windows is not closed").isTrue();
    }

    @Then("Other Name table is sorted by Date Created in ascending order")
    public void otherNameTableSorterByDateCreatedInAscendingOrder() {
        List<Date> valuesList = otherNameSectionPage.getDateCreatedListValues();
        assertThat(valuesList).as("Other Name table is not sorter by Date Created in ascending order")
                .isSortedAccordingTo(naturalOrder());
    }

    @Then("Screen Other Name Button is not displayed")
    public void screenOtherNameButtonForNameIsNotDisplayed() {
        assertFalse("Screen Other Name Button is still displayed",
                    otherNameSectionPage.isScreenOtherNameScreenIconIsDisplay());
    }

    @Then("These fields from Other Name section are enabled")
    public void verifyTheFiledIsEnabled(DataTable dataTable) {
        SoftAssert soft = new SoftAssert();
        dataTable.asList().forEach(fieldName -> soft.assertTrue(otherNameSectionPage.isFieldEnabled(fieldName),
                                                                String.format("%s field is disabled", fieldName)));
        soft.assertAll();
    }

    @Then("^\"((.*))\" Check type is (checked|unchecked)$")
    public void checkTypeIsChecked(String checkTypeName, String expectedResult) {
        if (TestConstants.CHECKED.equals(expectedResult)) {
            assertTrue("Check Type checkbox is unchecked", otherNameSectionPage.isCheckTypeIsSelected(checkTypeName));
        } else {
            assertFalse("Check Type checkbox is checked", otherNameSectionPage.isCheckTypeIsSelected(checkTypeName));
        }
    }

    @Then("^\"((.*))\" Check type is (enabled|disabled)$")
    public void checkTypeIsEnabled(String checkTypeName, String expectedResult) {
        if (TestConstants.ENABLED.equals(expectedResult)) {
            assertTrue("Check Type checkbox is disabled",
                       otherNameSectionPage.isCheckboxCheckTypeEnabled(checkTypeName));
        } else {
            assertFalse("Check Type checkbox is enabled", otherNameSectionPage.isFieldEnabled(checkTypeName));
        }
    }

    @Then("Other Name Groups field is displayed with default value {string}")
    public void otherNameGroupsFieldIsDisplayedWithDefaultValue(String groupValue) {
        assertTrue("Default value in Groups field is not correct",
                   otherNameSectionPage.isOtherNameGroupNameDisplayed(groupValue));
    }

    @Then("Other Name Group tooltip {string} is displayed")
    public void groupTooltipIsDisplayed(String groupToolTip) {
        assertThat(otherNameSectionPage.getOtherNameGroupTooltip()).as(
                        "Expected Group Tooltip is not displayed")
                .isEqualTo(groupToolTip);
    }

    @Then("Other Name Groups field value is {string}")
    public void otherNameGroupsFieldValue(String groupValue) {
        assertTrue("Groups field value is not correct",
                   otherNameSectionPage.isOtherNameGroupNameDisplayed(groupValue));
    }

    @Then("Other Name {string} field is not blank")
    public void otherNameGroupsFieldIsNotBlank(String groupsName) {
        assertNotNull(groupsName + " is blank", otherNameSectionPage.getOtherNameGroupsValue());
    }

    @Then("Other Name Groups field is disabled")
    public void otherNameGroupsIsDisabled() {
        assertThat(otherNameSectionPage.isOtherNameGroupsFieldDisabled())
                .as("Other Name Groups field is enabled").isTrue();
    }

    @Then("Other Name Groups dropdown tooltip {string} is displayed")
    public void groupsDropDownTooltipIsDisplayed(String groupDropDownToolTip) {
        assertThat(otherNameSectionPage.getOtherNameGroupsDropDownTooltip()).as(
                        "Expected Other Name Group Drop down Tooltip is not displayed")
                .isEqualTo(groupDropDownToolTip);
    }

    @Then("Associated Organisation Other Name Groups field value is default to {string}")
    public void associatedOrgOtherNameGroupsFieldValueIsDefaultTo(String groupValue) {
        assertThat(otherNameSectionPage.getGroupsValue()).as("Default value is incorrect").isEqualTo(groupValue);
    }

    @Then("Icon screening results for {string} Other name is disappeared")
    public void iconScreeningOtherNameIsDisappeared(String otherName) {
        assertTrue("Icon screening results for  Other name is displayed",
                   otherNameSectionPage.isIconScreeningOtherNameElementDisappeared(otherName));
    }

    @Then("Associated Party Other Names screening date has value {string}")
    public void screeningSectionDisplaysLastScreeningDateEmpty(String expectedText) {
        otherNameSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        assertEquals("Associated Party Other Names Screening section displays date", expectedText,
                     otherNameSectionPage.getOtherNameLastScreeningDateText());
    }

    @Then("Associated Party Other Names screening result displays No available data")
    public void isNoAvailableDataMessageDisplayed() {
        assertTrue("Associated Party Other Names screening result is not displays No available data",
                   otherNameSectionPage.isOtherNameNoMatchFoundMessageDisplayed());
    }

    @Then("Associated Party Other Names OGS Toggle is disable")
    public void associatedOgsToggleIsDisable() {
        assertTrue("Associated Party Other Names OGS Toggle is not disable",
                   otherNameSectionPage.isOtherNameOGSToggleDisable());
    }

    @Then("Associated Party Other Names Screening section displays Last Screening Date message with date in format: {string}")
    public void associatedScreeningSectionDisplaysLastScreeningDateInFormat(String date) {
        otherNameSectionPage.waitWhilePreloadProgressbarIsDisappeared();
        String lastScreeningDate = "LAST SCREENING DATE";
        String formattedDate = date.replace(SI_MAIN_SCREENING_DATE_FORMAT, getTodayDate(SI_MAIN_SCREENING_DATE_FORMAT));
        String expectedText = lastScreeningDate + COLON + SPACE + formattedDate;
        assertEquals("Associated Party Other Names Screening section displays unexpected text", expectedText,
                     otherNameSectionPage.getOtherNameLasScreeningDateText());
    }

}
