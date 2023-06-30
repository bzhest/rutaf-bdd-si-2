package com.refinitiv.asts.test.ui.stepDefinitions.ui.login;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload;
import com.refinitiv.asts.test.ui.enums.Languages;
import com.refinitiv.asts.test.ui.pageActions.login.LoginPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.RandomStringUtils;

import java.util.List;

import static com.refinitiv.asts.test.ui.api.AppApi.getUserDataByEmail;
import static com.refinitiv.asts.test.ui.api.AppApi.updateUser;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.INVALID;
import static java.lang.System.getProperty;
import static org.apache.commons.text.WordUtils.capitalizeFully;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

public class LoginSteps extends BaseSteps {

    private final LoginPage loginPage;
    private String password;

    public LoginSteps(ScenarioCtxtWrapper context) {
        super(context);
        loginPage = new LoginPage(this.driver, this.context);
    }

    @Given("User launches RDDC Login page")
    public void userLaunchLoginPage() {
        loginPage.navigateToLoginPage();
    }

    @When("User {string} enters username and password")
    public void entersUsernameAndPassword(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        this.context.getScenarioContext().setContext(USER_DATA, userData);
        this.context.getScenarioContext().setContext(USER_REFERENCE, userReference);
        loginPage.loginUser(userData);
    }

    @When("User sets up default language via API for users")
    public void entersUsernameAndPassword(DataTable users) {
        users.asList().forEach(user -> {
            UserData userData = getUserCredentialsByRole(user);
            UserAppApiPayload userDataByEmail = getUserDataByEmail(userData.getUsername());
            String languageToReplace = Languages.EN.getApiCode();
            if (!userDataByEmail.getPayload().getLanguagePreference().getLanguageId().equals(languageToReplace)) {
                updateUser(userDataByEmail.getPayload().setLanguagePreference(
                        new UserAppApiPayload.UserPayload.LanguagePreference().setLanguageId(languageToReplace)));
            }
        });
    }

    @When("User fills {string} Username")
    public void inputUsername(String userName) {
        loginPage.fillInUserName(userName);
    }

    @When("User fills {string} Password")
    public void inputPassword(String password) {
        if (password.equals(PASSWORD_CONTEXT)) {
            password = (String) context.getScenarioContext().getContext(PASSWORD_CONTEXT);
        } else if (!password.equals(INVALID)) {
            UserData userData = getUserCredentialsByRole(password);
            password = userData.getPassword();
        }
        loginPage.fillInPassword(password);
    }

    @When("User fills email {string}")
    public void fillInEmail(String email) {
        loginPage.fillInUserName(email);
        context.getScenarioContext().setContext(DELETE_EMAIL_FLAG_CONTEXT, true);
        context.getScenarioContext().setContext(EMAIL_CONTEXT, email);
    }

    @When("User fills email {string} from context")
    public void fillInEmailFromContext(String emailReference) {
        loginPage.fillInUserName((String) context.getScenarioContext().getContext(emailReference));
    }

    @When("User fills email for user {string}")
    public void fillInEmailForUser(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        fillInEmail(userData.getUsername());
    }

    @When("User fills email for user {string} with upper and lower case")
    public void fillInEmailForUserWithDifferentCase(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        fillInEmail(capitalizeFully(userData.getUsername()));
    }

    @When("User fills Enter New Password field with value {string}")
    public void fillInNewPassword(String passwordReference) {
        password = passwordReference + RandomStringUtils.randomAlphanumeric(10);
        context.getScenarioContext().setContext(PASSWORD_CONTEXT, password);
        loginPage.fillInNewPassword(password);
    }

    @When("User fills Enter New Password field with value for user {string}")
    public void fillInNewPasswordForUser(String userReference) {
        UserData userData = getUserCredentialsByRole(userReference);
        password = userData.getPassword();
        loginPage.fillInNewPassword(password);
    }

    @When("User fills 'Confirm password' field")
    public void fillInConfirmPassword() {
        loginPage.fillInConfirmPassword(password);
    }

    @When("User clicks Sign In button")
    public void clicksSignInButton() {
        loginPage.clickSignInButton();
    }

    @When("User clicks 'Reset' password button")
    public void clickResetPasswordButton() {
        loginPage.clickResetButton();
    }

    @When("User clicks Forgot Password? button")
    public void clickForgotPasswordButton() {
        loginPage.clickForgotPasswordButton();
    }

    @When("User clicks 'Ok' button")
    public void clickOkButton() {
        loginPage.clickOkButton();
    }

    @When("User clicks Save Password button")
    public void clickSavePasswordButton() {
        loginPage.clickSaveButton();
    }

    @When("User clicks on 'Privacy Policy' link")
    public void clickOnPrivacyPolicyLink() {
        loginPage.clickPrivacyPolicyFooterLink();
    }

    @When("User fills {string} field with value {string}")
    public void fillConfirmPasswordFieldWithValue(String fieldName, String value) {
        loginPage.fillInInputField(fieldName, value);
    }

    @Then("^Error message is displayed with error text$")
    public void validateErrorMessageIsDisplayedWithErrorText(DataTable dataTable) {
        assertTrue("Error Message is not displayed", loginPage.isErrorMessageDisplayed());
        String expectedErrorText = dataTable.asList().get(0);
        String actualErrorText = loginPage.getErrorMessageText();
        assertEquals("Actual error message " + actualErrorText + " doesn't contain text '" + expectedErrorText + "'",
                     actualErrorText, expectedErrorText);
    }

    @Then("Login page is displayed")
    public void validateLoginPageIsDisplayed() {
        assertTrue("Login page is not displayed", loginPage.isPageLoaded());
    }

    @Then("Page form is displayed with text")
    public void validateMessagesIsShown(DataTable dataTable) {
        String formText = loginPage.getPageText();
        dataTable.asList().forEach(
                text -> assertTrue("Page form text '" + formText + "'doesn't contains expected '" + text + "' text",
                                   formText.contains(text)));
    }

    @Then("Info Modal is displayed with text")
    public void validateModalMessagesIsShown(DataTable dataTable) {
        String modalText = loginPage.getModalText();
        dataTable.asList().forEach(
                text -> assertTrue("Modal text '" + modalText + "' doesn't contains expected '" + text + "' text",
                                   modalText.contains(text)));
    }

    @Then("Message {string} is shown")
    public void validateMessageIsShown(String text) {
        assertTrue("Element with text " + text + " is not displayed", loginPage.isTextElementDisplayed(text));
    }

    @Then("Login page is loaded")
    public void validateLoginPageLoaded() {
        assertTrue("Login page is not loaded", loginPage.isPageLoaded());
    }

    @Then("Login page footer displayed with text")
    public void loginPageFooterDisplayedWithText(DataTable dataTable) {
        List<String> expectedText = dataTable.asList();
        String actualText = loginPage.getFooterText();
        expectedText.forEach(text -> assertTrue(
                "Login page footer text '" + actualText + "' doesn't contain expected '" + text + "'",
                actualText.contains(text)));
    }

    @Then("User should be redirected to {string}")
    public void userShouldBeRedirectedTo(String expectedUrl) {
        loginPage.switchToTab(1);
        assertThat(loginPage.getCurrentUrl()).as("User is not redirected to expected url").contains(expectedUrl);
    }

    @Then("Username fields contains validation message {string}")
    public void alertWithTextIsDisplayed(String expectedMessage) {
        assertEquals("Username fields doesn't contain validation message", expectedMessage,
                     loginPage.getUsernameValidationMessage());
    }

    @Then("Login input field with text {string} is displayed")
    public void loginInputFieldWithTextIsDisplayed(String fieldPlaceholder) {
        assertThat(loginPage.isInputFieldDisplayed(fieldPlaceholder)).as(
                "Login input field with text %s is not displayed", fieldPlaceholder).isTrue();
    }

    @Then("{string} fields contains validation message {string}")
    public void fieldsContainsValidationMessage(String fieldName, String expectedText) {
        assertThat(loginPage.getInputFieldValidationMessage(fieldName))
                .as("%s fields doesn't contain validation message %s", fieldName, expectedText)
                .isEqualTo(expectedText);
    }

    @Then("Error message should appear {string}")
    public void errorMessageShouldAppear(String expectedText) {
        assertThat(loginPage.getServerErrorMessage())
                .as("Error message is unexpected")
                .isEqualTo(expectedText);
    }

    @Then("Confirmation dialog is shown for user {string}")
    public void confirmationDialogIsShown(String userReference) {
        String userName = getUserCredentialsByRole(userReference).getUsername();
        assertThat(loginPage.isConfirmationDialogOpened(userName)).as("Confirmation dialog is not opened on login page")
                .isTrue();
    }

}
