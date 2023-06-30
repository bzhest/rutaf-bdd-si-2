package com.refinitiv.asts.test.ui.stepDefinitions.ui.preferences;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload;
import com.refinitiv.asts.test.ui.enums.Languages;
import com.refinitiv.asts.test.ui.pageActions.preferences.InternalUserPreferencesPage;
import com.refinitiv.asts.test.ui.stepDefinitions.BaseStepDef;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp.userManagement.RoleManagementSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.ZERO;
import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.DmsApi.postFile;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DATE_CREATED;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.enums.Colors.REACT_RED;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.ui.pageActions.PaginationPage.*;
import static com.refinitiv.asts.test.utils.FileUtil.getCreatedFile;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;

public class InternalUserPreferencesSteps extends BaseSteps {

    private final InternalUserPreferencesPage preferencesPage;

    public InternalUserPreferencesSteps(ScenarioCtxtWrapper context) {
        super(context);
        preferencesPage = new InternalUserPreferencesPage(this.driver, this.translator);
    }

    @When("User navigates to Preferences page")
    public void navigateToPreferencesPage() {
        preferencesPage.navigateToPreferencesPage();
    }

    @When("User clicks Save preferences button")
    public void clickSavePreferencesButton() {
        if (!preferencesPage.isSaveButtonDisabled()) {
            preferencesPage.clickSaveButton();
        }
    }

    @When("User updates First Name Personal Details with value random name")
    public void updateFirstNamePersonalDetailsWithValueRandomName() {
        context.getScenarioContext().setContext(USER_INITIAL_FIRST_NAME, preferencesPage.getFirstName());
        String randomFirstName = AUTO_REMAINED_NAME_PREFIX + randomAlphanumeric(10);
        preferencesPage.fillInFirstName(randomFirstName);
        context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, randomFirstName);
    }

    @When("User updates First Name Personal Details with value random {int} characters name")
    public void updateFirstNamePersonalDetails(int nameLength) {
        String randomFirstName = randomAlphanumeric(nameLength);
        preferencesPage.fillInFirstName(randomFirstName);
        context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, randomFirstName);
    }

    @When("User updates First Name Personal Details with value {string}")
    public void updateFirstNamePersonalDetails(String name) {
        String randomValue = randomAlphanumeric(4);
        preferencesPage.fillInFirstName(name + randomValue);
        context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, randomValue);
    }

    @When("User updates First Name Personal Details with previous value")
    public void updateFirstNamePersonalDetailsWithPreviousValue() {
        String previousFirstName = (String) context.getScenarioContext().getContext(USER_INITIAL_FIRST_NAME);
        preferencesPage.fillInFirstName(previousFirstName);
    }

    @When("User updates Last Name Personal Details with value random name")
    public void updateLastNamePersonalDetailsWithValueRandomName() {
        String randomLastName = AUTO_REMAINED_NAME_PREFIX + randomAlphanumeric(10);
        preferencesPage.fillInLastName(randomLastName);
        context.getScenarioContext().setContext(USER_EDITED_LAST_NAME, randomLastName);
    }

    @When("User updates Position Personal Details with value random name")
    public void updatePositionPersonalDetailsWithValueRandomName() {
        String randomPosition = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
        preferencesPage.fillInPosition(randomPosition);
        context.getScenarioContext().setContext(USER_EDITED_POSITION, randomPosition);
    }

    @When("User uploads photo for user via API")
    public void uploadPhotoForUserViaAPI() {
        String fileName = "TestFileName.png";
        String mimeType = "image/png";
        String userFirstName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        List<UserData> userList =
                getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload().getData().stream()
                        .filter(user -> user.getStatus().equals(ACTIVE.getStatus()) &&
                                user.getFirstName().equals(userFirstName)).collect(Collectors.toList());
        Attachment attachment =
                postFile(getCreatedFile(fileName), mimeType).getPayload().setDateUploaded(null).setIsFinal(null);
        UserAppApiPayload.UserPayload userPayload =
                getUserDataById(userList.get(0).getId()).getPayload().setAvatar(attachment);
        updateUser(userPayload);
        context.getScenarioContext().setContext(USER_EDITED_PHOTO, attachment);
    }

    @When("User sets up role {string} for user with firstname {string} via API")
    public void setUpRoleForUserViaAPI(String roleName, String userFirstName) {
        UserData foundUser = getUsers(USERS_ITEMS_PER_PAGE, ZERO, DESC, DATE_CREATED).getPayload().getData().stream()
                .filter(user -> {
                    if (user.getFirstName() != null) {
                        return user.getStatus().equals(ACTIVE.getStatus()) &&
                                user.getFirstName().equals(userFirstName);
                    }
                    return false;
                }).collect(Collectors.toList()).get(0);

        if (roleName.equals(USER_ROLE_TITLE)) {
            roleName = new RoleManagementSteps(context).getLastUserRoleTitleFromContext();
        }

        String finalRoleName = roleName;
        UserAppApiPayload.UserPayload.Role roleItem =
                getAllRolesInJson(ENORMOUS_ITEMS_PER_PAGE, DEFAULT_PAGE, DEFAULT_SORT, DEFAULT_SORT_BY).getPayload()
                        .stream()
                        .filter(role -> role.getName().equals(finalRoleName))
                        .collect(Collectors.toList())
                        .get(0);
        UserAppApiPayload.UserPayload.Role newRoleToApply =
                new UserAppApiPayload.UserPayload.Role().setActive(roleItem.getActive()).setName(roleItem.getName())
                        .set_id(roleItem.get_id());
        UserAppApiPayload.UserPayload initialPayload = getUserDataById(foundUser.getId()).getPayload();
        context.getScenarioContext().setContext(USER_PAYLOAD, initialPayload);
        updateUser(initialPayload.setRole(newRoleToApply));
    }

    @When("User clicks Email Notification")
    public void clickEmailNotification() {
        preferencesPage.clickOnEmailNotification();
        context.getScenarioContext()
                .setContext(USER_SELECTED_EMAIL_NOTIFICATION, preferencesPage.isEmailNotificationOnSelected());
    }

    @When("User clears First Name")
    public void clearFirstName() {
        preferencesPage.clearFirstName();
    }

    @When("User sets up language via API")
    public void selectLanguage() {
        String envLanguage = BaseStepDef.getConfigProp().getProperty("language");
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        UserAppApiPayload userDataByEmail = getUserDataByEmail(userTestData.getUsername());
        String languageToReplace = Languages.valueOf(envLanguage.toUpperCase()).getApiCode();
        String currentLanguage = userDataByEmail.getPayload().getLanguagePreference().getLanguageId();
        if (!languageToReplace.equals(currentLanguage)) {
            updateUser(userDataByEmail.getPayload().setLanguagePreference(
                    new UserAppApiPayload.UserPayload.LanguagePreference().setLanguageId(languageToReplace)));
            context.getScenarioContext().setContext(IS_LANGUAGE_CHANGED, YES);
            preferencesPage.navigateToPreferencesPage();
            preferencesPage.waitNewLanguageIsApplied();
        }
    }

    @When("User sets up default language via API")
    public void setUpDefaultLanguage() {
        String defaultLanguage = Languages.EN.getApiCode();
        UserData userTestData = (UserData) context.getScenarioContext().getContext(USER_DATA);
        UserAppApiPayload userDataByEmail = getUserDataByEmail(userTestData.getUsername());
        String currentLanguage = userDataByEmail.getPayload().getLanguagePreference().getLanguageId();
        if (!defaultLanguage.equals(currentLanguage)) {
            updateUser(userDataByEmail.getPayload().setLanguagePreference(
                    new UserAppApiPayload.UserPayload.LanguagePreference().setLanguageId(defaultLanguage)));
        }
    }

    @When("User clears Last Name")
    public void clearLastName() {
        preferencesPage.clearLastName();
    }

    @When("^User turns (Off|On) Email Notification$")
    public void turnOffEmailNotification(String buttonState) {
        if (buttonState.equals(ON) && !preferencesPage.isEmailNotificationOnSelected() ||
                buttonState.equals(OFF) && preferencesPage.isEmailNotificationOnSelected()) {
            preferencesPage.clickOnEmailNotification();
            preferencesPage.waitForEmailNotificationButtonState(buttonState);
        }
    }

    @When("User uploads Personal Details {string} photo")
    public void uploadPersonalDetailsPhoto(String fileName) {
        preferencesPage.uploadPhoto(fileName);
        preferencesPage.waitWhilePreloadProgressbarIsDisappeared();
        context.getScenarioContext().setContext(UPLOADED_FILE_NAME, fileName);
    }

    @When("User saves current user name")
    public void saveCurrentUserName() {
        context.getScenarioContext().setContext(USER_INITIAL_FIRST_NAME, preferencesPage.getFirstName());
    }

    @When("User fills in Language value {string}")
    public void fillInLanguageValue(String language) {
        preferencesPage.fillInLanguage(language);
        context.getScenarioContext().setContext(CHANGED_LANGUAGE, true);
        context.getScenarioContext()
                .setContext(CHANGED_LANGUAGE_USER_DATA, context.getScenarioContext().getContext(USER_DATA));
    }

    @Then("System Setting Date Format is {string}")
    public void systemSettingDateFormatIs(String expectedDateFormat) {
        assertEquals("System Setting Date Format is unexpected", expectedDateFormat,
                     preferencesPage.getDateFormatValue());
    }

    @Then("My Preferences page is displayed")
    public void myPreferencesPageIsDisplayed() {
        assertThat(preferencesPage.isPageLoaded()).as("My Preferences page is not loaded").isTrue();
    }

    @Then("Personal Details section required field {string} is enabled")
    public void personalDetailsSectionRequiredFieldIsEnabled(String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(preferencesPage.getPersonalDetailsFieldText(fieldName).contains(REQUIRED_INDICATOR),
                              fieldName + " input field is not required");
        softAssert.assertTrue(preferencesPage.isPersonalDetailsFieldEnabled(fieldName),
                              fieldName + " input field is not enabled");
        softAssert.assertAll();
    }

    @Then("Personal Details section field {string} is enabled")
    public void personalDetailsSectionFieldIsEnabled(String fieldName) {
        assertThat(preferencesPage.isPersonalDetailsFieldEnabled(fieldName))
                .as(fieldName + " input field is not enabled").isTrue();
    }

    @Then("Personal Details section photo placeholder is enabled")
    public void personalDetailsSectionPhotoPlaceholderIsEnabled() {
        assertThat(preferencesPage.isPhotoPlaceholderEnabled())
                .as("Photo placeholder input field is not enabled").isTrue();
    }

    @Then("System Setting Date Format is disabled")
    public void systemSettingDateFormatIsDisabled() {
        assertThat(preferencesPage.isSystemSettingsDateFormatFieldEnabled())
                .as("System Setting Date Format is not disabled").isFalse();
    }

    @Then("System Setting Email Notification is displayed")
    public void systemSettingEmailNotificationIsDisplayed() {
        assertThat(preferencesPage.isSystemSettingsEmailNotificationDisplayed())
                .as("System Setting Email Notification is not displayed").isTrue();
    }

    @Then("^My Preferences page Save button is (disabled|enabled)$")
    public void myPreferencesPageSaveButtonIsDisabled(String buttonState) {
        preferencesPage.waitWhilePreloadProgressbarIsDisappeared();
        if (buttonState.equals(DISABLED)) {
            assertThat(preferencesPage.isSaveButtonDisabled())
                    .as("My Preferences page Save button is not disabled").isTrue();
        } else {
            assertThat(preferencesPage.isSaveButtonDisabled())
                    .as("My Preferences page Save button is not enabled").isFalse();
        }
    }

    @Then("First Name Personal Details contains expected value")
    public void firstNamePersonalDetailsContainsExpectedValue() {
        String expectedFirstName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        assertThat(preferencesPage.getFirstName()).as("First Name Personal Details doesn't contain expected value")
                .isEqualTo(expectedFirstName);
    }

    @Then("Last Name Personal Details contains expected value")
    public void lastNamePersonalDetailsContainsExpectedValue() {
        String expectedUserLastName = (String) context.getScenarioContext().getContext(USER_EDITED_LAST_NAME);
        assertThat(preferencesPage.getLastName()).as("Last Name Personal Details doesn't contain expected value")
                .isEqualTo(expectedUserLastName);
    }

    @Then("Position Personal Details contains expected value")
    public void positionPersonalDetailsContainsExpectedValue() {
        String expectedPosition = (String) context.getScenarioContext().getContext(USER_EDITED_POSITION);
        assertThat(preferencesPage.getPosition()).as("Position Personal Details doesn't contain expected value")
                .isEqualTo(expectedPosition);
    }

    @Then("Personal Details section photo is displayed")
    public void personalDetailsSectionPhotoIdDisplayed() {
        String expectedPhoto = (String) context.getScenarioContext().getContext(UPLOADED_FILE_NAME);
        context.getScenarioContext().setContext(USER_EDITED_PHOTO, preferencesPage.getAvatarImageUiPath());
        assertThat(preferencesPage.isAvatarMatchedWithExpectedImage(expectedPhoto))
                .as("Personal Details photo is not correct")
                .isTrue();
    }

    @Then("Email Notification is clicked")
    public void emailNotificationIsClicked() {
        boolean expectedEmailNotificationPosition =
                (boolean) context.getScenarioContext().getContext(USER_SELECTED_EMAIL_NOTIFICATION);
        assertThat(preferencesPage.isEmailNotificationOnSelected()).as("Email Notification status is unexpected")
                .isEqualTo(expectedEmailNotificationPosition);
    }

    @Then("Personal Details Upload Photo link is displayed")
    public void personalDetailsUploadPhotoLinkIsDisplayed() {
        assertThat(preferencesPage.isUploadPhotoLinkDisplayed()).as(
                        "Personal Details Upload Photo link is not displayed")
                .isTrue();
    }

    @Then("Error message {string} in red color is displayed near User Preferences fields")
    public void errorMessageInRedColorIsDisplayedNearProfileFields(String errorMessage, List<String> expectedFields) {
        SoftAssert softAssert = new SoftAssert();
        expectedFields.forEach(field -> {
            softAssert.assertTrue(preferencesPage.isFieldInvalidAriaDisplayed(field),
                                  "Input field invalid aria is not displayed");
            softAssert.assertEquals(preferencesPage.getErrorMessage(field), errorMessage,
                                    "Input field error message is not displayed");
            softAssert.assertEquals(preferencesPage.getErrorMessageElementCSS(field, COLOR),
                                    REACT_RED.getColorRgba(), "Input field error message is not red");
        });
        softAssert.assertAll();
    }

    @Then("Preference Page doesn't contain Password field")
    public void preferencePageDoesNotContainPasswordField() {
        assertThat(preferencesPage.isPasswordElementDisplayed())
                .as("Password element is displayed")
                .isFalse();
    }

    @Then("Preferences field {string} is not required")
    public void personalDetailsSectionFieldIsNotRequired(String fieldName) {
        assertThat(preferencesPage.getPersonalDetailsFieldText(fieldName)).as("Field %s is required")
                .doesNotContain(REQUIRED_INDICATOR);
    }

    @Then("Preferences Language drop-down contains {string} value")
    public void preferencesLanguageDropDownContainsValue(String expectedValue) {
        preferencesPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(preferencesPage.getLanguageValue()).as("Unexpected Language drop-down value")
                .isEqualTo(expectedValue);
    }

}
