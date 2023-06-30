package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.dueDiligenceOrder;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.KeyPrincipleFormPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.KeyPrincipleData;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.KEY_PRINCIPLE;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.GeneralInformationFields.*;
import static com.refinitiv.asts.test.ui.pageActions.thirdParty.thirdPartyInformation.DueDiligenceOrderPage.*;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.assertj.core.api.Assertions.assertThat;

public class KeyPrincipleFormSteps extends BaseSteps {

    private final KeyPrincipleFormPage keyPrincipleFormPage;

    public KeyPrincipleFormSteps(ScenarioCtxtWrapper context) {
        super(context);
        keyPrincipleFormPage = new KeyPrincipleFormPage(this.driver, this.context, translator);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public KeyPrincipleData contactKeyPrincipleEntry(Map<String, String> entry) {
        return KeyPrincipleData.builder()
                .email(getEmail(entry.get(EMAIL.toUpperCase())))
                .fullName(getName(entry.get(KEY_PRINCIPAL_NAME.toUpperCase())))
                .isChecked(nonNull(entry.get(CHECKED)) ? Boolean.parseBoolean(entry.get(CHECKED)) : null)
                .title(entry.get(TITLE.getName()))
                .firstName(getName(entry.get(FIRST_NAME.getName())))
                .lastName(entry.get(LAST_NAME.getName()))
                .addressLine(entry.get(ADDRESS.toUpperCase()))
                .country(entry.get(COUNTRY.getName())).build();
    }

    private String getName(String name) {
        return nonNull(name) && name.contains(USER_EDITED_FIRST_NAME) ?
                name.replace(USER_EDITED_FIRST_NAME, (String) context.getScenarioContext()
                        .getContext(USER_EDITED_FIRST_NAME)) : name;
    }

    private String getEmail(String email) {
        return VALUE_TO_REPLACE.equals(email) ? (String) context.getScenarioContext().getContext(EMAIL_CONTEXT) :
                email;
    }

    @When("User opens Manage Key Principal page for previously created order")
    public void openKeyPrincipalForCreatedOrder() {
        keyPrincipleFormPage.openDDOrderManageKeyPrincipalPage();
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User fills Key Principle form data {string}")
    public void fillRequiredPrincipleFormData(String data) {
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        KeyPrincipleData keyPrincipleData = (new JsonUiDataTransfer<KeyPrincipleData>(KEY_PRINCIPLE)
                .getTestData().get(data))
                .getDataToEnter();
        this.context.getScenarioContext().setContext(KEY_PRINCIPLE_DATA, keyPrincipleData);
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        keyPrincipleFormPage.fillAllKeyPrincipleData(keyPrincipleData);
    }

    @When("User accepts Key Principle module window")
    public void acceptModuleWindow() {
        keyPrincipleFormPage.acceptDialog();
    }

    @When("User populates First Name for Key Principal with {string}")
    public void fillInFirstNameWithValue(String name) {
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        if (name.equals(USER_EDITED_FIRST_NAME)) {
            name = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
            context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, name);
        }
        keyPrincipleFormPage.fillInFirstNameWithValue(name);
    }

    @When("User populates Last Name for Key Principal with {string}")
    public void fillInLastNameWithValue(String name) {
        keyPrincipleFormPage.fillInLastNameWithValue(name);
    }

    @When("User selects Country {string} for Key Principal")
    public void chooseCountry(String country) {
        keyPrincipleFormPage.selectCountry(country);
    }

    @When("User clicks {string} button on Key Principal page")
    public void clickOnKeyPrincipalPageButton(String buttonText) {
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        keyPrincipleFormPage.clickOnButtonWithText(buttonText);
    }

    @When("User clicks Add to List Key Principle button")
    public void clicksAddToListKeyPrincipleButton() {
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
        keyPrincipleFormPage.closeAlertIconIfDisplayed();
        keyPrincipleFormPage.clickAddToListButton();
    }

    @When("User clicks edit button for key principal with First Name {string}")
    public void clickEditButtonForKeyPrincipalWithFirstName(String firstName) {
        keyPrincipleFormPage.clickEditButton(firstName);
        keyPrincipleFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks checkbox for key principal with First Name {string}")
    public void clickCheckboxForKeyPrincipalWithFirstName(String firstName) {
        if (firstName.equals(USER_EDITED_FIRST_NAME)) {
            firstName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        }
        keyPrincipleFormPage.clickCheckbox(firstName);
    }

    @When("User clicks Add Contact Key Principal button")
    public void clickCheckboxForQuestionnaire() {
        keyPrincipleFormPage.clickAddButton();
    }

    @Then("Manage Key Principal page is displayed")
    public void manageKeyPrincipalPageIsDisplayed() {
        assertThat(keyPrincipleFormPage.isPageLoaded()).as("Manage Key Principal page is not displayed").isTrue();
    }

    @Then("Manage Key Principal page Add New Contact section is displayed with the following fields")
    public void addNewContactSectionIsDisplayedWithTheFollowingFields(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> softAssert.assertTrue(keyPrincipleFormPage.isAddInputFieldDisplayed(name),
                                                         name + " field is not displayed"));
        softAssert.assertAll();
    }

    @Then("Manage Key Principal page Add New Contact section is displayed with the following required fields")
    public void addNewContactSectionIsDisplayedWithTheFollowingRequiredFields(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> {
            softAssert.assertTrue(keyPrincipleFormPage.isAddInputFieldDisplayed(name),
                                  name + " field is not displayed");
            softAssert.assertEquals(keyPrincipleFormPage.getAddFieldIndicator(name), REQUIRED_INDICATOR,
                                    name + " required indicator is not displayed");
        });
        softAssert.assertAll();
    }

    @Then("Manage Key Principal page Address section is displayed with the following fields")
    public void addressSectionIsDisplayedWithTheFollowingFields(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> softAssert.assertTrue(keyPrincipleFormPage.isAddressInputFieldDisplayed(name),
                                                         name + " field is not displayed"));
        softAssert.assertAll();
    }

    @Then("Manage Key Principal page Address section is displayed with the following required fields")
    public void addressSectionIsDisplayedWithTheFollowingRequiredFields(List<String> fieldNames) {
        SoftAssert softAssert = new SoftAssert();
        fieldNames.forEach(name -> {
            softAssert.assertTrue(keyPrincipleFormPage.isAddInputFieldDisplayed(name),
                                  name + " field is not displayed");
            softAssert.assertEquals(keyPrincipleFormPage.getAddressFieldIndicator(name), REQUIRED_INDICATOR,
                                    name + " required indicator is not displayed");
        });
        softAssert.assertAll();
    }

    @Then("Manage Key Principal page note {string} is displayed")
    public void manageKeyPrincipalPageNoteIsDisplayed(String noteText) {
        assertThat(keyPrincipleFormPage.getNote())
                .as("Manage Key Principal page note is not displayed")
                .isEqualTo(noteText);
    }

    @Then("Error message {string} in red color is displayed near Key Principal fields")
    public void errorMessageInRedColorIsDisplayedNearField(String errorMessage, List<String> highlightedFields) {
        SoftAssert softAssert = new SoftAssert();
        highlightedFields.forEach(text -> {
            softAssert.assertTrue(keyPrincipleFormPage.isFieldInvalidAriaDisplayed(text),
                                  "Input field invalid aria is not displayed");
            softAssert.assertEquals(keyPrincipleFormPage.getElementErrorMessage(text), errorMessage,
                                    "Input field error message is not displayed");
            softAssert.assertEquals(keyPrincipleFormPage.getErrorMessageElementCSS(text, COLOR),
                                    REACT_RED.getColorRgba(), "Input field error message is not red");
        });
        softAssert.assertAll();
    }

    @Then("Manage Key Principal table is not displayed")
    public void orderManageKeyPrincipalTableIsNotDisplayed() {
        assertThat(keyPrincipleFormPage.isKeyPrincipalTableDisplayed()).as("Manage Key Principal table is displayed")
                .isFalse();
    }

    @Then("Manage Key Principal table contains records")
    public void orderManageKeyPrincipalTableContainsRecords(List<KeyPrincipleData> expectedResult) {
        keyPrincipleFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(keyPrincipleFormPage.getKeyPrincipleTableValues())
                .as("Manage Key Principal table does not contain expected records")
                .usingRecursiveComparison()
                .isEqualTo(expectedResult);
    }

}
