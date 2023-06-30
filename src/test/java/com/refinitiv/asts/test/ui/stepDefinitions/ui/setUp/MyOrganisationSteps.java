package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.RegionCountryRequest;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.PaginationPage;
import com.refinitiv.asts.test.ui.pageActions.setUp.MyOrganisationPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.MyOrganisation;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.SkipException;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.MY_ORGANISATION;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.enums.Status.INACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.setUp.MyOrganisationPage.*;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static java.lang.String.format;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.apache.commons.lang3.RandomStringUtils.randomNumeric;
import static org.assertj.core.api.Assertions.assertThat;

public class MyOrganisationSteps extends BaseSteps {

    private static final String INPUT_FIELD = "input";
    private final MyOrganisationPage myOrganisationPage;
    private final PaginationPage paginationPage;
    private int previousPhoneCount;

    public MyOrganisationSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.myOrganisationPage = new MyOrganisationPage(this.driver);
        this.paginationPage = new PaginationPage(this.driver, context);
    }

    private MyOrganisation getMyOrganisation(String organisationReference) {
        MyOrganisation departmentData = new JsonUiDataTransfer<MyOrganisation>(MY_ORGANISATION).getTestData()
                .get(organisationReference).getDataToEnter();
        if (VALUE_TO_REPLACE.equals(departmentData.getName())) {
            departmentData.setName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getRegion())) {
            departmentData.setRegion(getAvailableRegionNames().get(0));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getCountry())) {
            departmentData.setCountry(
                    getAvailableCountriesForRegion(getRegionIdByName(departmentData.getRegion())).get(0));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getState())) {
            departmentData.setState(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getDateCreated())) {
            departmentData.setDateCreated(getTodayDate(REACT_FORMAT));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getLocalName())) {
            departmentData.setLocalName(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getPhoneNumber())) {
            departmentData.setPhoneNumber(randomNumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getFax())) {
            departmentData.setFax(randomNumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getDescription())) {
            departmentData.setDescription(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getAddressLine())) {
            departmentData.setAddressLine(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getCity())) {
            departmentData.setCity(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getZip())) {
            departmentData.setZip(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }
        if (VALUE_TO_REPLACE.equals(departmentData.getStatus())) {
            departmentData.setState(AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10));
        }

        return departmentData;
    }

    @When("User navigates to My Organisation page")
    public void navigateToMyOrganisationPage() {
        myOrganisationPage.navigateToMyOrganisationPage();
    }

    @When("User clicks My Organisation {string} tab")
    public void clicksMyOrganisationTab(String tabName) {
        myOrganisationPage.clickTab(tabName);
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks My organisation Add New button")
    public void clickMyOrganisationAddNewButton() {
        myOrganisationPage.clickAddNewButton();
    }

    @When("User populates Division input fields {string}")
    public void populatedDivisionInputFields(String divisionReference) {
        MyOrganisation divisionData = getMyOrganisation(divisionReference);
        myOrganisationPage.fillInDivisionFields(divisionData);
        if (context.getScenarioContext().isContains(divisionReference)) {
            divisionData.setLastUpdate(getTodayDate(REACT_FORMAT));
            context.getScenarioContext().setContext(NEW_ORGANISATION_NAME, divisionData.getName());
        } else {
            context.getScenarioContext().setContext(OLD_ORGANISATION_NAME, divisionData.getName());
        }
        context.getScenarioContext().setContext(divisionReference, divisionData);
    }

    @When("User populates Department input fields {string}")
    public void populateDepartmentInputFields(String departmentReference) {
        MyOrganisation departmentData = getMyOrganisation(departmentReference);
        myOrganisationPage.fillInDepartmentFields(departmentData);
        if (context.getScenarioContext().isContains(departmentReference)) {
            departmentData.setLastUpdate(getTodayDate(REACT_FORMAT));
            context.getScenarioContext().setContext(NEW_ORGANISATION_NAME, departmentData.getName());
        } else if (!context.getScenarioContext().isContains(OLD_ORGANISATION_NAME)) {
            context.getScenarioContext().setContext(OLD_ORGANISATION_NAME, departmentData.getName());
        }
        context.getScenarioContext().setContext(departmentReference, departmentData);
    }

    @When("User populates External Organisation input fields {string}")
    public void populateExternalOrganisationInputFields(String externalOrganisationReference) {
        MyOrganisation externalOrganisationData = getMyOrganisation(externalOrganisationReference);
        myOrganisationPage.fillInExternalOrganisationFields(externalOrganisationData);
        if (context.getScenarioContext().isContains(externalOrganisationReference)) {
            externalOrganisationData.setLastUpdate(getTodayDate(REACT_FORMAT));
            context.getScenarioContext().setContext(NEW_ORGANISATION_NAME, externalOrganisationData.getName());
        } else if (!context.getScenarioContext().isContains(OLD_ORGANISATION_NAME)) {
            context.getScenarioContext().setContext(OLD_ORGANISATION_NAME, externalOrganisationData.getName());
        }
        context.getScenarioContext().setContext(externalOrganisationReference, externalOrganisationData);
    }

    @When("User populates Entity input fields {string}")
    public void populateEntityInputFields(String entityReference) {
        myOrganisationPage.closeAlertIconIfDisplayed();
        MyOrganisation entityData = getMyOrganisation(entityReference);
        myOrganisationPage.fillInEntityFields(entityData);
        if (context.getScenarioContext().isContains(entityReference)) {
            entityData.setLastUpdate(getTodayDate(REACT_FORMAT));
            context.getScenarioContext().setContext(NEW_ORGANISATION_NAME, entityData.getName());
        } else if (!context.getScenarioContext().isContains(OLD_ORGANISATION_NAME)) {
            context.getScenarioContext().setContext(OLD_ORGANISATION_NAME, entityData.getName());
        }
        context.getScenarioContext().setContext(entityReference, entityData);
    }

    @When("User populates My Organisation input fields {string}")
    public void populateMyOrganisationInputFields(String organisationReference) {
        MyOrganisation organisationData = getMyOrganisation(organisationReference);
        myOrganisationPage.fillInOrganisationFields(organisationData);
        context.getScenarioContext().setContext(organisationReference, organisationData);
        context.getScenarioContext().setContext(MY_ORGANISATION_SHOULD_REVERT_FLAG, true);
    }

    @When("User clears all Division page fields")
    public void clearAllDivisionPageFields() {
        myOrganisationPage.clearAllDivisionFields();
    }

    @When("User clears all Department page fields")
    public void clearAllDepartmentPageFields() {
        myOrganisationPage.clearAllDepartmentFields();
    }

    @When("User clears all External Organisation page fields")
    public void clearAllExternalOrganisationPageFields() {
        myOrganisationPage.clearAllExternalOrganisationFields();
    }

    @When("User clears all Entity page fields")
    public void clearAllEntityPageFields() {
        myOrganisationPage.clearAllEntityFields();
    }

    @When("User clicks My organisation page {string} button")
    public void clickMyOrganisationPageButton(String buttonType) {
        switch (buttonType) {
            case SAVE:
                myOrganisationPage.clickSaveButton();
                break;
            case SAVE_AND_NEW:
                myOrganisationPage.clickSaveAndNewButton();
                break;
            case CANCEL:
            case CLOSE:
                myOrganisationPage.clickCancelButton();
                break;
            case EDIT:
                myOrganisationPage.clickEditPageButton();
                break;
            case BACK:
                myOrganisationPage.clickBackButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @When("^User clicks (edit|delete|on) created organisation with reference \"((.*))\"$")
    public void clicksTableButtonForOrganisation(String buttonType, String organisationReference) {
        MyOrganisation divisionData = (MyOrganisation) context.getScenarioContext().getContext(organisationReference);
        clicksTableButtonForOrganisationWithName(buttonType, divisionData.getName());
    }

    @When("^User clicks (edit|delete|on) created organisation with name \"((.*))\"$")
    public void clicksTableButtonForOrganisationWithName(String buttonType, String name) {
        while (!myOrganisationPage.isRowWithNameDisplayed(name) && paginationPage.isNextPageButtonActive()) {
            paginationPage.clickNextPageButton();
            myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
        }
        if (buttonType.equals(EDIT.toLowerCase())) {
            myOrganisationPage.clickEditButton(name);
        } else if (buttonType.equals(DELETE.toLowerCase())) {
            myOrganisationPage.clickDeleteButton(name);
        } else if (buttonType.equals(ON.toLowerCase())) {
            myOrganisationPage.clickOnOrganisation(name);
        } else {
            throw new IllegalArgumentException("Unsupported button type " + buttonType);
        }
    }

    @When("User clicks on {string} My Organisation column")
    public void clickOnMyOrganisationColumn(String columnName) {
        myOrganisationPage.clickOnColumnWithName(columnName);
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks My Organisation edit icon")
    public void clickMyOrganisationEditIcon() {
        myOrganisationPage.clickEditIcon();
    }

    @When("User clears My Organisation {string} field")
    public void clearMyOrganisationField(String fieldName) {
        myOrganisationPage.clearInputField(fieldName);
    }

    @When("User clears My Organisation Phone Number")
    public void clearMyOrganisationPhoneNumber() {
        myOrganisationPage.clearLastPhoneNumber();
    }

    @When("User fills in My Organisation Phone Number {string}")
    public void fillInMyOrganisationPhoneNumber(String phoneNumber) {
        myOrganisationPage.fillsInPhoneNumber(phoneNumber);
    }

    @When("User clicks My Organisation Add icon for Phone Number")
    public void clickMyOrganisationAddIconForPhoneNumber() {
        previousPhoneCount = myOrganisationPage.getPhoneCount();
        myOrganisationPage.clickAddPhoneButton();
    }

    @When("User deletes all My Organisation Phone Numbers")
    public void deleteAllMyOrganisationPhoneNumbers() {
        myOrganisationPage.deleteAllPhones();
    }

    @When("User adds {int} My Organisation Phone Number\\(s)")
    public void addMyOrganisationPhoneNumber(int phoneNumbersCount) {
        fillInMyOrganisationPhoneNumber(randomNumeric(10));
        for (int i = 1; i < phoneNumbersCount; i++) {
            clickMyOrganisationAddIconForPhoneNumber();
            fillInMyOrganisationPhoneNumber(randomNumeric(10));
        }
    }

    @Then("^My Organisation \"((.*))\" modal is (displayed|disappeared)$")
    public void myOrganisationModalIsDisplayed(String modalName, String modalState) {
        myOrganisationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (modalState.equals(DISPLAYED.toLowerCase())) {
            assertThat(myOrganisationPage.isModalWithNameDisplayed(modalName))
                    .as("%s modal is not displayed", modalName)
                    .isTrue();
        } else {
            assertThat(myOrganisationPage.isModalWithNameDisappeared(modalName))
                    .as("%s modal is not disappeared", modalName)
                    .isTrue();
        }

    }

    @Then("^All expected buttons are active and displayed for (add|edit|view) modal$")
    public void allExpectedButtonsAreActiveAndDisplayed(String modalType) {
        SoftAssert softAssert = new SoftAssert();
        if (modalType.equals(VIEW.toLowerCase())) {
            softAssert.assertTrue(myOrganisationPage.isEditModalButtonDisplayed(), "Edit button is not displayed");
        } else {
            softAssert.assertTrue(myOrganisationPage.isCancelButtonEnabled(), "Cancel button is not enabled");
            softAssert.assertTrue(myOrganisationPage.isSaveButtonEnabled(), "Save button is not enabled");
            if (modalType.equals(ADD.toLowerCase())) {
                softAssert.assertTrue(myOrganisationPage.isSaveAndNewButtonEnabled(),
                                      "Save and New button is not enabled");
            } else {
                softAssert.assertFalse(myOrganisationPage.isSaveAndNewButtonDisplayed(),
                                       "Save and New button is displayed");
            }
        }
        softAssert.assertAll();
    }

    @Then("{string} My Organisation blank text field is displayed")
    public void divisionNameBlankTextFieldIsDisplayed(String fieldName) {
        assertThat(myOrganisationPage.getTextFieldValue(fieldName))
                .as("%s is not blank", fieldName)
                .isNull();
    }

    @Then("Region blank drop-down field is displayed")
    public void regionBlankDropDownFieldIsDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertNull(myOrganisationPage.getTextFieldValue(REGION),
                              "Region Name is not blank");
        softAssert.assertFalse(myOrganisationPage.isRequiredIndicatorDisplayedForField(REGION),
                               "Required indicator is displayed");
        softAssert.assertAll();
    }

    @Then("Country blank drop-down field is displayed")
    public void countryBlankDropDownFieldIsDisplayed() {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertNull(myOrganisationPage.getTextFieldValue(COUNTRY),
                              "Country Name is not blank");
        softAssert.assertFalse(myOrganisationPage.isRequiredIndicatorDisplayedForField(COUNTRY),
                               "Required indicator is displayed");
        softAssert.assertAll();
    }

    @Then("^My Organisation with provided \"((.*))\" details( is | is not )displayed$")
    public void myOrganisationWithProvidedDetailsDisplayed(String organisationReference, String assertionState) {
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
        MyOrganisation organisationData =
                (MyOrganisation) context.getScenarioContext().getContext(organisationReference);
        List<MyOrganisation> allDisplayedOrganisations = myOrganisationPage.getAllDisplayedOrganisations();
        if (assertionState.contains(IS_NOT)) {
            assertThat(allDisplayedOrganisations).as("Organisation is displayed").asList()
                    .doesNotContain(organisationData);
        } else {
            assertThat(allDisplayedOrganisations).as("Organisation is not displayed").asList()
                    .contains(organisationData);
        }
    }

    @Then("^My Organisation with provided \"((.*))\" details (is not|is) created$")
    public void myOrganisationWithProvidedDetailsNotCreated(String organisationReference, String state) {
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
        MyOrganisation organisationData = getMyOrganisation(organisationReference);
        List<MyOrganisation> allDisplayedOrganisations = myOrganisationPage.getAllDisplayedOrganisations();
        if (state.contains(NOT)) {
            for (MyOrganisation organisation : allDisplayedOrganisations) {
                if (organisationData.getName().equals(organisation.getName())) {
                    throw new SkipException(organisation.getName() + " already exists!");
                }
            }
        } else {
            assertThat(allDisplayedOrganisations.stream()
                               .anyMatch(organisation -> organisation.getName().equals(organisationData.getName())))
                    .as("Organisation with name: %s is not created", organisationData.getName())
                    .isTrue();
        }
    }

    @Then("Division modal is displayed with provided {string} details")
    public void divisionModalIsDisplayedWithProvidedDetails(String organisationReference) {
        MyOrganisation organisationData =
                (MyOrganisation) context.getScenarioContext().getContext(organisationReference);
        MyOrganisation actualModalData = new MyOrganisation()
                .setName(myOrganisationPage.getTextFieldValue(DIVISION_NAME))
                .setCountry(myOrganisationPage.getTextFieldValue(COUNTRY))
                .setRegion(myOrganisationPage.getTextFieldValue(REGION));
        assertThat(actualModalData).as("Division modal is unexpected").usingRecursiveComparison()
                .ignoringFields("dateCreated", "lastUpdate", "status")
                .isEqualTo(organisationData);
    }

    @Then("Region drop-down field is displayed with expected values")
    public void regionDropDownFieldIsDisplayedWithExpectedValues() {
        List<String> allAvailableRegionNames = getAllAvailableRegions().stream().map(
                RegionCountryRequest.RegionObject::getName).collect(Collectors.toList());
        assertThat(allAvailableRegionNames).as("Region drop-down options are not expected").usingRecursiveComparison()
                .ignoringCollectionOrder()
                .isEqualTo(myOrganisationPage.getRegionDropDownOptions(allAvailableRegionNames.size()));
        myOrganisationPage.clickInputFieldImage(REGION);
    }

    @Then("Country drop-down field is displayed with expected values")
    public void countryDropDownFieldIsDisplayedWithExpectedValues() {
        List<String> allAvailableCountryNames = getAllAvailableCountries().stream().map(
                RegionCountryRequest.RegionObject::getName).collect(Collectors.toList());
        assertThat(myOrganisationPage.getCountryDropDownOptions(allAvailableCountryNames.size())).as(
                        "Country drop-down options are not expected")
                .usingRecursiveComparison()
                .ignoringCollectionOrder()
                .isEqualTo(allAvailableCountryNames);
        myOrganisationPage.clickInputFieldImage(COUNTRY);
    }

    @Then("Error message {string} in red color is displayed near {string} My Organisation modal field")
    public void errorMessageInRedColorIsDisplayedNearMyOrganisationModalField(String errorMessage, String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(myOrganisationPage.isFieldInvalidAriaDisplayed(fieldName),
                              fieldName + " field doesn't display invalid aria");
        softAssert.assertEquals(myOrganisationPage.getErrorMessageText(fieldName), errorMessage,
                                fieldName + " error message is not displayed");
        softAssert.assertTrue(myOrganisationPage.getErrorMessageColor(fieldName).contains(REACT_RED.getColorRgba()),
                              fieldName + " error message is not red");
        softAssert.assertAll();
    }

    @Then("My Organisation with name {string} is displayed")
    public void myOrganisationWithNameIsDisplayed(String organisationName) {
        assertThat(myOrganisationPage.isRowWithNameDisplayed(organisationName))
                .as("My Organisation with name %s is not displayed", organisationName).isTrue();
    }

    @Then("{string} My Organisation text field required indicator is displayed")
    public void requiredDepartmentNameTextFieldIndicatorIsDisplayed(String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(myOrganisationPage.isRequiredIndicatorDisplayedForField(fieldName),
                              "Required indicator is not displayed");
        softAssert.assertEquals(myOrganisationPage.getRequiredIndicatorColor(fieldName), REACT_RED.getColorRgba(),
                                "Required indicator is not red");
        softAssert.assertAll();
    }

    @Then("Department modal is displayed with provided {string} details")
    public void departmentModalIsDisplayedWithProvidedDetails(String organisationReference) {
        myOrganisationPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        MyOrganisation organisationData =
                (MyOrganisation) context.getScenarioContext().getContext(organisationReference);
        MyOrganisation actualModalData = new MyOrganisation()
                .setName(myOrganisationPage.getTextFieldValue(DEPARTMENT_NAME))
                .setCountry(myOrganisationPage.getTextFieldValue(COUNTRY))
                .setRegion(myOrganisationPage.getTextFieldValue(REGION))
                .setStatus(myOrganisationPage.getStatus());
        assertThat(actualModalData).as("Department modal is unexpected").usingRecursiveComparison()
                .ignoringFields("dateCreated", "lastUpdate")
                .isEqualTo(organisationData);
    }

    @Then("External Organisation modal is displayed with provided {string} details")
    public void externalOrganisationModalIsDisplayedWithProvidedDetails(String organisationReference) {
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
        MyOrganisation organisationData =
                (MyOrganisation) context.getScenarioContext().getContext(organisationReference);
        MyOrganisation actualModalData = new MyOrganisation()
                .setName(myOrganisationPage.getTextFieldValue(EXTERNAL_ORGANISATION_NAME))
                .setCountry(myOrganisationPage.getTextFieldValue(COUNTRY))
                .setRegion(myOrganisationPage.getTextFieldValue(REGION))
                .setStatus(myOrganisationPage.getStatus());
        assertThat(actualModalData).as("External Organisation modal is unexpected").usingRecursiveComparison()
                .ignoringFields("dateCreated", "lastUpdate")
                .isEqualTo(organisationData);
    }

    @Then("Entity modal is displayed with provided {string} details")
    public void entityModalIsDisplayedWithProvidedDetails(String entityReference) {
        MyOrganisation entityData =
                (MyOrganisation) context.getScenarioContext().getContext(entityReference);
        MyOrganisation actualModalData = new MyOrganisation()
                .setName(myOrganisationPage.getTextFieldValue(ENTITY_NAME))
                .setCountry(myOrganisationPage.getTextFieldValue(COUNTRY))
                .setRegion(myOrganisationPage.getTextFieldValue(REGION))
                .setStatus(myOrganisationPage.getStatus());
        assertThat(actualModalData).as("Entity modal is unexpected").usingRecursiveComparison()
                .ignoringFields("dateCreated", "lastUpdate")
                .isEqualTo(entityData);
    }

    @Then("^Active checkbox is (checked|unchecked)$")
    public void activeCheckboxIsChecked(String checkboxState) {
        String expectedStatus = checkboxState.equals(CHECKED) ? ACTIVE.getStatus() : INACTIVE.getStatus();
        assertThat(myOrganisationPage.getStatus()).as("Active status is unexpected")
                .isEqualTo(expectedStatus);
    }

    @Then("My Organisation table displayed with columns")
    public void myOrganisationTableDisplayedWithColumns(List<String> expectedResult) {
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(myOrganisationPage.getTableColumnNames())
                .as("My Organisation table columns are unexpected").isEqualTo(expectedResult);
    }

    @Then("Add New My Organisation button is displayed")
    public void addNewMyOrganisationButtonIsDisplayed() {
        assertThat(myOrganisationPage.isAddNewButtonDisplayed())
                .as("Add New My Organisation button is not displayed").isTrue();
    }

    @Then("My Organisation table is sorted by {string} in {string} order")
    public void myOrganisationTableIsSortedByInOrder(String columnName, String sortOrder) {
        List<String> valuesList = myOrganisationPage.getListValuesForColumn(columnName.toUpperCase());
        tableIsSortedByInOrder("My Organisation", columnName, sortOrder, REACT_FORMAT, valuesList, true);
    }

    @Then("All My Organisation fields are uneditable")
    public void allMyOrganisationFieldsAreUneditable(List<String> fieldList) {
        SoftAssert softAssert = new SoftAssert();
        fieldList.forEach(field -> softAssert.assertTrue(myOrganisationPage.isFieldInputUneditable(field),
                                                         format("My Organisation field %s is editable", field)));
        softAssert.assertAll();
    }

    @Then("My Organisation table control buttons are displayed for each record")
    public void myOrganisationTableControlButtonsAreDisplayedForEachRecord() {
        SoftAssert softAssert = new SoftAssert();
        myOrganisationPage.getListValuesForColumn(NAME.toUpperCase()).forEach(
                record -> {
                    softAssert.assertTrue(myOrganisationPage.isEditButtonDisplayed(record),
                                          format("Edit button for %s is not displayed", record));
                    softAssert.assertTrue(myOrganisationPage.isDeleteButtonDisplayed(record),
                                          format("Delete button for %s is not displayed", record));
                });
        softAssert.assertAll();
    }

    @Then("My Organisation page contains following fields")
    public void myOrganisationPageContainsFollowingFields(List<String> expectedFields) {
        myOrganisationPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(myOrganisationPage.getMyOrganisationFields()).usingRecursiveComparison()
                .ignoringCollectionOrder()
                .as("My Organisation page fields are unexpected").isEqualTo(expectedFields);
    }

    @Then("The Organisation Name is set to {string}")
    public void theOrganisationNameIsSetTo(String expectedOrganisationName) {
        assertThat(myOrganisationPage.getMyOrganisationName())
                .as("The Organisation Name is unexpected").contains(expectedOrganisationName);
    }

    @Then("My Organisation Edit icon is displayed")
    public void myOrganisationEditIconIsDisplayed() {
        assertThat(myOrganisationPage.isEditIconDisplayed())
                .as("My Organisation Edit icon is not displayed").isTrue();
    }

    @Then("My Organisation tabs are displayed")
    public void myOrganisationTabsAreDisplayed(List<String> expectedTabs) {
        assertThat(myOrganisationPage.getMyOrganisationTabs()).usingRecursiveComparison()
                .ignoringCollectionOrder()
                .as("My Organisation tabs are unexpected").isEqualTo(expectedTabs);
    }

    @Then("My Organisation input fields are displayed")
    public void myOrganisationInputFieldsAreDisplayed(List<String> fieldList) {
        SoftAssert softAssert = new SoftAssert();
        fieldList.forEach(field -> softAssert.assertTrue(myOrganisationPage.isInputFieldDisplayed(field),
                                                         format("My Organisation input field %s is not displayed",
                                                                field)));
        softAssert.assertAll();
    }

    @Then("My Organisation is displayed with provided {string} details")
    public void myOrganisationIsDisplayedWithProvidedDetails(String organisationReference) {
        MyOrganisation expectedData =
                (MyOrganisation) context.getScenarioContext().getContext(organisationReference);
        assertThat(myOrganisationPage.getMyOrganisationDetails()).usingRecursiveComparison()
                .ignoringExpectedNullFields()
                .as("My Organisation details are unexpected").isEqualTo(expectedData);
    }

    @Then("^My Organisation Add icon for Phone Number is (disabled|enabled)$")
    public void myOrganisationAddIconForPhoneNumberIsDisabled(String iconState) {
        if (iconState.equals(DISABLED)) {
            assertThat(myOrganisationPage.isAddPhoneButtonDisabled())
                    .as("My Organisation Add icon for Phone Number is not disabled").isTrue();
        } else {
            assertThat(myOrganisationPage.isAddPhoneButtonDisabled())
                    .as("My Organisation Add icon for Phone Number is not enabled").isFalse();
        }
    }

    @Then("My Organisation Add icon for Phone Number field is displayed")
    public void myOrganisationAddIconForPhoneNumberFieldIsDisplayed() {
        assertThat(myOrganisationPage.isAddPhoneButtonDisplayed())
                .as("My Organisation Add icon for Phone Number field is not displayed").isTrue();
    }

    @Then("My Organisation additional Phone Number input is displayed")
    public void myOrganisationAdditionalPhoneNumberInputIsDisplayed() {
        assertThat(myOrganisationPage.getPhoneCount())
                .as("My Organisation additional Phone Number input is not displayed")
                .isEqualTo(previousPhoneCount + 1);
    }

    @Then("My Organisation displays {int} Phone Number\\(s)")
    public void myOrganisationDisplaysPhoneNumber(int expectedCount) {
        assertThat(myOrganisationPage.getPhoneCount())
                .as("My Organisation Phone Number count is unexpected")
                .isEqualTo(expectedCount);
    }

    @Then("My Organisation each Phone Number contains remove icon")
    public void myOrganisationEachPhoneNumberContainsRemoveIcon() {
        assertThat(myOrganisationPage.isRemoveIconDisplayed(myOrganisationPage.getPhoneCount()))
                .as("Not all My Organisation phone contains remove icon")
                .isTrue();
    }

    @Then("^My Organisation Phone Number (field|input) contains \"(.*)\"$")
    public void myOrganisationPhoneNumberContains(String fieldType, String expectedValue) {
        String actualValue = fieldType.equals(INPUT_FIELD) ?
                myOrganisationPage.getMyOrganisationInputValue(PHONE_NUMBER) :
                myOrganisationPage.getMyOrganisationFieldValue(PHONE_NUMBER);
        if (expectedValue.isEmpty()) {
            assertThat(actualValue).as("My Organisation Phone Number contains doesn't contain expected value")
                    .isNull();
        } else {
            assertThat(actualValue).as("My Organisation Phone Number contains doesn't contain expected value")
                    .contains(expectedValue);
        }
    }

    @Then("My Organisation No Match Found message is displayed if table is empty")
    public void myOrganizationNoMatchFoundMessageIsDisplayedIfTableIsEmpty() {
        if (myOrganisationPage.getAllDisplayedOrganisations().isEmpty()) {
            assertThat(myOrganisationPage.isNoMatchFoundMessageDisplayed())
                    .as("No Match Found message is displayed")
                    .isTrue();
        }
    }

}
