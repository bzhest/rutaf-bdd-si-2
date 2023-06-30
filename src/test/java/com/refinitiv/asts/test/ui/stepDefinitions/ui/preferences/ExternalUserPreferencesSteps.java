package com.refinitiv.asts.test.ui.stepDefinitions.ui.preferences;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.Attachment;
import com.refinitiv.asts.test.ui.api.model.user.UserAppApiPayload;
import com.refinitiv.asts.test.ui.pageActions.preferences.ExternalUserPreferencesPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import lombok.SneakyThrows;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.stream.Collectors;

import static com.refinitiv.asts.test.ui.api.AppApi.*;
import static com.refinitiv.asts.test.ui.api.DmsApi.postFile;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DATE_CREATED;
import static com.refinitiv.asts.test.ui.constants.APIConstants.DESC;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.*;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.OFF;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.ON;
import static com.refinitiv.asts.test.ui.constants.TestConstants.AUTO_REMAINED_NAME_PREFIX;
import static com.refinitiv.asts.test.ui.constants.TestConstants.AUTO_TEST_NAME_PREFIX;
import static com.refinitiv.asts.test.ui.constants.TestConstants.DISABLED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.REQUIRED_INDICATOR;
import static com.refinitiv.asts.test.ui.enums.Status.ACTIVE;
import static com.refinitiv.asts.test.utils.FileUtil.getCreatedFile;
import static org.apache.commons.lang3.RandomStringUtils.randomAlphanumeric;
import static org.assertj.core.api.Assertions.assertThat;
import static org.testng.AssertJUnit.assertEquals;

public class ExternalUserPreferencesSteps extends BaseSteps {

    private final ExternalUserPreferencesPage preferencesPage;

    public ExternalUserPreferencesSteps(ScenarioCtxtWrapper context) {
        super(context);
        preferencesPage = new ExternalUserPreferencesPage(this.driver);
    }

    @When("External User navigates to Preferences page")
    public void navigateToPreferencesPage() {
        preferencesPage.navigateToPreferencesPage();
    }

    @When("External User clicks Save preferences button")
    public void clickSavePreferencesButton() {
        preferencesPage.clickSaveButton();
    }

    @When("External User updates First Name Personal Details with value random name")
    public void updateFirstNamePersonalDetailsWithValueRandomName() {
        context.getScenarioContext().setContext(USER_INITIAL_FIRST_NAME, preferencesPage.getFirstName());
        String randomFirstName = AUTO_REMAINED_NAME_PREFIX + randomAlphanumeric(10);
        preferencesPage.fillInFirstName(randomFirstName);
        context.getScenarioContext().setContext(USER_EDITED_FIRST_NAME, randomFirstName);
    }

    @When("External User updates First Name Personal Details with previous value")
    public void updateFirstNamePersonalDetailsWithPreviousValue() {
        String previousFirstName = (String) context.getScenarioContext().getContext(USER_INITIAL_FIRST_NAME);
        preferencesPage.fillInFirstName(previousFirstName);
    }

    @When("External User updates Last Name Personal Details with value random name")
    public void updateLastNamePersonalDetailsWithValueRandomName() {
        String randomLastName = AUTO_REMAINED_NAME_PREFIX + randomAlphanumeric(10);
        preferencesPage.fillInLastName(randomLastName);
        context.getScenarioContext().setContext(USER_EDITED_LAST_NAME, randomLastName);
    }

    @When("External User updates Position Personal Details with value random name")
    public void updatePositionPersonalDetailsWithValueRandomName() {
        String randomPosition = AUTO_TEST_NAME_PREFIX + randomAlphanumeric(10);
        preferencesPage.fillInPosition(randomPosition);
        context.getScenarioContext().setContext(USER_EDITED_POSITION, randomPosition);
    }

    @When("External User uploads photo for user via API")
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

    @When("External User clicks Email Notification")
    public void clickEmailNotification() {
        preferencesPage.clickOnEmailNotification();
        context.getScenarioContext()
                .setContext(USER_SELECTED_EMAIL_NOTIFICATION, preferencesPage.isEmailNotificationOnSelected());
    }

    @When("External User clears First Name")
    public void clearFirstName() {
        preferencesPage.clearFirstName();
    }

    @When("External User clears Last Name")
    public void clearLastName() {
        preferencesPage.clearLastName();
    }

    @When("^External User turns (Off|On) Email Notification$")
    public void turnOffEmailNotification(String buttonState) {
        if (buttonState.equals(ON) && !preferencesPage.isEmailNotificationTurnedOn() ||
                buttonState.equals(OFF) && preferencesPage.isEmailNotificationTurnedOn()) {
            preferencesPage.clickOnEmailNotification();
        }
    }

    @When("External User uploads Personal Details {string} photo")
    public void uploadPersonalDetailsPhoto(String fileName) {
        preferencesPage.uploadPhoto(fileName);
        context.getScenarioContext().setContext(UPLOADED_FILE_NAME, fileName);
    }

    @When("External User saves current user name")
    public void saveCurrentExternalUserName() {
        context.getScenarioContext().setContext(USER_INITIAL_FIRST_NAME, preferencesPage.getFirstName());
    }

    @Then("System Setting for External User Date Format is {string}")
    public void systemSettingDateFormatIs(String expectedDateFormat) {
        assertEquals("System Setting Date Format is unexpected", expectedDateFormat,
                     preferencesPage.getDateFormatValue());
    }

    @Then("My Preferences page for External User is displayed")
    public void myPreferencesPageIsDisplayed() {
        assertThat(preferencesPage.isPageLoaded()).as("My Preferences page is not loaded").isTrue();
    }

    @Then("Personal Details section required field {string} for External User is enabled")
    public void personalDetailsSectionRequiredFieldIsEnabled(String fieldName) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(preferencesPage.getPersonalDetailsFieldText(fieldName).contains(REQUIRED_INDICATOR),
                              fieldName + " input field is not required");
        softAssert.assertTrue(preferencesPage.isPersonalDetailsFieldEnabled(fieldName),
                              fieldName + " input field is not enabled");
        softAssert.assertAll();
    }

    @Then("Personal Details section field {string} for External User is enabled")
    public void personalDetailsSectionFieldIsEnabled(String fieldName) {
        assertThat(preferencesPage.isPersonalDetailsFieldEnabled(fieldName))
                .as(fieldName + " input field is not enabled").isTrue();
    }

    @Then("Personal Details section photo placeholder for External User is enabled")
    public void personalDetailsSectionPhotoPlaceholderIsEnabled() {
        assertThat(preferencesPage.isPhotoPlaceholderEnabled())
                .as("Photo placeholder input field is not enabled").isTrue();
    }

    @Then("System Setting Date Format for External User is disabled")
    public void systemSettingDateFormatIsDisabled() {
        assertThat(preferencesPage.isSystemSettingsDateFormatFieldEnabled())
                .as("System Setting Date Format is not disabled").isFalse();
    }

    @Then("System Setting Email Notification for External User is displayed")
    public void systemSettingEmailNotificationIsDisplayed() {
        assertThat(preferencesPage.isSystemSettingsEmailNotificationDisplayed())
                .as("System Setting Email Notification is not displayed").isTrue();
    }

    @Then("^My Preferences page Save button for External User is (disabled|enabled)$")
    public void myPreferencesPageSaveButtonIsDisabled(String buttonState) {
        if (buttonState.equals(DISABLED)) {
            assertThat(preferencesPage.isSaveButtonDisabled())
                    .as("My Preferences page Save button is not disabled").isTrue();
        } else {
            assertThat(preferencesPage.isSaveButtonDisabled())
                    .as("My Preferences page Save button is not enabled").isFalse();
        }
    }

    @Then("First Name Personal Details for External User contains expected value")
    public void firstNamePersonalDetailsContainsExpectedValue() {
        String expectedFirstName = (String) context.getScenarioContext().getContext(USER_EDITED_FIRST_NAME);
        assertThat(preferencesPage.getFirstName()).as("First Name Personal Details doesn't contain expected value")
                .isEqualTo(expectedFirstName);
    }

    @Then("Last Name Personal Details for External User contains expected value")
    public void lastNamePersonalDetailsContainsExpectedValue() {
        String expectedUserLastName = (String) context.getScenarioContext().getContext(USER_EDITED_LAST_NAME);
        assertThat(preferencesPage.getLastName()).as("Last Name Personal Details doesn't contain expected value")
                .isEqualTo(expectedUserLastName);
    }

    @Then("Position Personal Details for External User contains expected value")
    public void positionPersonalDetailsContainsExpectedValue() {
        String expectedPosition = (String) context.getScenarioContext().getContext(USER_EDITED_POSITION);
        assertThat(preferencesPage.getPosition()).as("Position Personal Details doesn't contain expected value")
                .isEqualTo(expectedPosition);
    }

    @SneakyThrows
    @Then("Personal Details section photo for External User is displayed")
    public void personalDetailsSectionPhotoIdDisplayed() {
        String expectedPhoto = (String) context.getScenarioContext().getContext(UPLOADED_FILE_NAME);
        context.getScenarioContext().setContext(USER_EDITED_PHOTO, preferencesPage.getAvatarImageUiPath());
        assertThat(preferencesPage.isAvatarMatchedWithExpectedImage(expectedPhoto))
                .as("Personal Details photo is not correct")
                .isTrue();
    }

    @Then("Email Notification for External User is clicked")
    public void emailNotificationIsClicked() {
        boolean expectedEmailNotificationPosition =
                (boolean) context.getScenarioContext().getContext(USER_SELECTED_EMAIL_NOTIFICATION);
        assertThat(preferencesPage.isEmailNotificationOnSelected()).as("Email Notification status is unexpected")
                .isEqualTo(expectedEmailNotificationPosition);
    }

    @Then("Personal Details Upload Photo link for External User is displayed")
    public void personalDetailsUploadPhotoLinkIsDisplayed() {
        assertThat(preferencesPage.isUploadPhotoLinkDisplayed())
                .as("Personal Details Upload Photo link is not displayed")
                .isTrue();
    }

    @Then("External User preferences Out of Office tab is not displayed")
    public void externalUserPreferencesOutOfOfficeTabIsNotDisplayed() {
        preferencesPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(preferencesPage.isOutOfOfficeTabDisplayed())
                .as("External User preferences Out of Office tab is displayed")
                .isFalse();
    }

}
