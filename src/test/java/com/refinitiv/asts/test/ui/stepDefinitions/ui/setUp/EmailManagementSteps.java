package com.refinitiv.asts.test.ui.stepDefinitions.ui.setUp;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.api.model.emailManagement.EmailTemplatesResponse;
import com.refinitiv.asts.test.ui.pageActions.setUp.EmailManagementPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.EmailTemplate;
import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang.RandomStringUtils;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.List;
import java.util.Map;

import static com.refinitiv.asts.test.ui.api.AppApi.getEmailTemplates;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.INITIAL_EMAIL_TEMPLATE;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.TestConstants.COMMA;
import static com.refinitiv.asts.test.ui.constants.TestConstants.VALUE_TO_REPLACE;
import static com.refinitiv.asts.test.ui.pageActions.setUp.EmailManagementPage.*;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.SPACE;
import static org.assertj.core.api.Assertions.assertThat;

public class EmailManagementSteps extends BaseSteps {

    private final EmailManagementPage emailNotification;

    public EmailManagementSteps(ScenarioCtxtWrapper context) {
        super(context);
        emailNotification = new EmailManagementPage(driver);
    }

    @DataTableType
    @SuppressWarnings("unused")
    public EmailTemplate templateEntry(Map<String, String> entry) {
        return EmailTemplate.builder()
                .templateName(entry.get(TEMPLATE_NAME))
                .category(entry.get(CATEGORY))
                .status(entry.get(STATUS))
                .build();
    }

    @When("User navigates to Email Management page")
    public void navigatesToEmailManagementPage() {
        emailNotification.navigatesToEmailManagementPage();
    }

    @When("User clicks Edit button for {string} template row")
    public void clickEditButtonForTemplateRow(String templateName) {
        emailNotification.clickEditButton(templateName);
    }

    @When("User saves initial {string} template data")
    public void savesInitialTemplateData(String templateName) {
        EmailTemplatesResponse.EmailTemplate initialEmailTemplate = getEmailTemplates().getRecords().stream()
                .filter(template -> template.getName().equals(templateName)).findFirst()
                .orElseThrow(() -> new RuntimeException(
                        "Email template with name '" + templateName + "' wasn't found"));
        context.getScenarioContext().setContext(INITIAL_EMAIL_TEMPLATE, initialEmailTemplate);
    }

    @When("User inputs into the email field {string} value {string}")
    public void inputIntoTheCC(String fieldName, String value) {
        if (value.equals(VALUE_TO_REPLACE)) {
            value = RandomStringUtils.randomAlphanumeric(10) + "@test.com";
        }
        value = emailNotification.getInputFieldValue(fieldName).equals(EMPTY) ? value :
                COMMA + value;
        emailNotification.inputFieldValue(fieldName, value);
    }

    @When("User updates Subject with value {string}")
    public void updateSubjectWithValue(String value) {
        emailNotification.inputFieldValue(SUBJECT, value);
    }

    @When("^User updates Email Body with (bold|italic|underline) style text \"((.*))\"$")
    public void updateEmailBodyWithStyleText(String textStyle, String text) {
        emailNotification.clickEmailBodyParagraph();
        emailNotification.moveToTheEndOfLine();
        emailNotification.inputEmailBodyValue(text);
        emailNotification.selectLastAddedText(text);
        emailNotification.clickTextStyleButton(textStyle);
        emailNotification.moveToTheEndOfLine();
        emailNotification.clickTextStyleButton(textStyle);
    }

    @When("^User align (Left|Center|Right) text \"((.*))\"$")
    public void alignText(String textStyle, String text) {
        emailNotification.clickEmailBodyParagraph();
        emailNotification.moveToTheEndOfLine();
        emailNotification.inputEmailBodyValue(text);
        emailNotification.selectLastAddedText(text);
        emailNotification.clickTextAlignButton(textStyle);
    }

    @When("User inserts table in Email Body")
    public void insertTableInEmailBody() {
        emailNotification.moveToTheEndOfLine();
        emailNotification.clickInsertTableButton();
        emailNotification.clickSelectTableButton();
    }

    @When("User inserts link {string} in Email Body")
    public void insertLinkInEmailBody(String link) {
        emailNotification.moveToTheEndOfText();
        emailNotification.clickInsertLinkButton();
        emailNotification.fillInUrl(link);
        emailNotification.clickOkInsertUrl();
    }

    @When("User updates Email Body with variable {string}")
    public void updateEmailBodyWithVariable(String variable) {
        emailNotification.moveToTheEndOfText();
        emailNotification.inputEmailBodyValue(variable);
    }

    @When("^User clicks (Save|Cancel) template button$")
    public void clickSaveTemplateButton(String buttonType) {
        switch (buttonType) {
            case SAVE:
                emailNotification.clickSaveButton();
                break;
            case CANCEL:
                emailNotification.clickCancelButton();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
    }

    @Then("^User makes sure that template Active checkbox is (checked|unchecked)$")
    public void checkActiveCheckboxState(String state) {
        if ((state.equals(CHECKED) && !emailNotification.isActiveCheckboxChecked()) ||
                (state.equals(UNCHECKED) && emailNotification.isActiveCheckboxChecked())) {
            emailNotification.clickActiveCheckbox();
        }
        checkActiveCheckBox(state);
    }

    @Then("Email Management page is opened")
    public void emailManagementPageIsOpened() {
        emailNotification.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(emailNotification.isPageLoaded())
                .as("Email Management page is not loaded")
                .isTrue();
    }

    @Then("Email Management table contains following template")
    public void emailManagementTableContainsFollowingTemplate(List<EmailTemplate> expectedTemplate) {
        emailNotification.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(emailNotification.getAllTemplateList())
                .as("Email Management table is unexpected").asList()
                .containsAll(expectedTemplate);
    }

    @Then("{string} email template page is displayed")
    public void templatePageIsDisplayed(String templateName) {
        assertThat(emailNotification.isPageDisplayed(templateName))
                .as("%s template page is not displayed", templateName)
                .isTrue();
    }

    @Then("There are the following fields displayed")
    public void thereAreTheFollowingFieldsDisplayed(List<String> expectedFieldNames) {
        assertThat(emailNotification.getAllFieldNames())
                .as("Unexpected form fields are displayed")
                .usingRecursiveComparison().ignoringCollectionOrder()
                .isEqualTo(expectedFieldNames);
    }

    @Then("^(Cancel|Save) template button is displayed$")
    public void templateButtonIsDisplayed(String buttonType) {
        boolean result;
        switch (buttonType) {
            case SAVE:
                result = emailNotification.isSaveButtonDisplayed();
                break;
            case CANCEL:
                result = emailNotification.isCancelButtonDisplayed();
                break;
            default:
                throw new IllegalArgumentException("Button type: " + buttonType + " is unexpected");
        }
        assertThat(result).as("%s button is not displayed", buttonType).isTrue();
    }

    @Then("Email Template Name field is not editable and contains value {string}")
    public void emailTemplateNameFieldIsNotEditableAndContainsValue(String expectedValue) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(emailNotification.isFieldReadOnly(EMAIL_TEMPLATE_NAME),
                              "Email Template Name field is editable");
        softAssert.assertEquals(emailNotification.getInputFieldValue(EMAIL_TEMPLATE_NAME), expectedValue,
                                "Email Template Name field doesn't contain expected value");
        softAssert.assertAll();
    }

    @Then("Category field is not editable and contains value {string}")
    public void categoryFieldIsNotEditableAndItIsBlank(String expectedText) {
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(emailNotification.isFieldReadOnly(CATEGORY), "Category field is editable");
        softAssert.assertEquals(emailNotification.getInputFieldValue(CATEGORY), expectedText,
                                "Category value is unexpected");
        softAssert.assertAll();
    }

    @Then("Subject contains text {string}")
    public void subjectContainsText(String expectedText) {
        assertThat(emailNotification.getInputFieldValue(SUBJECT).toUpperCase().replace(SPACE + SPACE, SPACE))
                .as("Subject doesn't contain text")
                .contains(expectedText.toUpperCase());
    }

    @Then("Body field contains text")
    public void bodyFieldContainsText(List<String> expectedText) {
        SoftAssertions softAssert = new SoftAssertions();
        String bodyText = emailNotification.getBodyText().toUpperCase();
        expectedText.forEach(text -> softAssert.assertThat(bodyText)
                .as("Email body doesn't contain text")
                .contains(text.toUpperCase()));
        softAssert.assertAll();
    }

    @Then("^Email Body contains (bold|italic|underline) text \"((.*))\"$")
    public void emailBodyContainsTextStyle(String textStyle, String text) {
        boolean result;
        switch (textStyle) {
            case "bold":
                result = emailNotification.isBoldTextDisplayed(text);
                break;
            case "italic":
                result = emailNotification.isItalicTextDisplayed(text);
                break;
            case "underline":
                result = emailNotification.isUnderlineTextDisplayed(text);
                break;
            default:
                throw new IllegalArgumentException("Text style: " + textStyle + " is unexpected");
        }
        assertThat(result).as("%s text style is not displayed for text %s", textStyle, text).isTrue();
    }

    @Then("^Email Body contains text \"((.*))\" align (left|center|right)$")
    public void emailBodyContainsTextAlign(String text, String textAlign) {
        assertThat(emailNotification.isTextAlignDisplayed(text, textAlign))
                .as("%s text align is not displayed for text", textAlign, text)
                .isTrue();
    }

    @Then("Email Body contains table")
    public void emailBodyContainsTable() {
        assertThat(emailNotification.isTableDisplayed())
                .as("Email Body doesn't contain table")
                .isTrue();
    }

    @Then("Email Body contains link {string}")
    public void emailBodyContainsLink(String linkText) {
        assertThat(emailNotification.isLinkDisplayed(linkText))
                .as("Email Body doesn't contain link")
                .isTrue();
    }

    @Then("Email Body contains variable {string}")
    public void emailBodyContainsVariable(String variable) {
        assertThat(emailNotification.isTextDisplayed(variable))
                .as("Email Body doesn't contain text")
                .isTrue();
    }

    @Then("Error message {string} is displayed near {string}")
    public void errorMessageIsDisplayedNear(String errorText, String fieldName) {
        assertThat(emailNotification.getErrorMessageText(fieldName))
                .as("Error message is not displayed")
                .isEqualTo(errorText);
    }

    @Then("^Email Template Active checkbox is (checked|unchecked)$")
    public void checkActiveCheckBox(String state) {
        if (state.equals(CHECKED)) {
            assertThat(emailNotification.isActiveCheckboxChecked())
                    .as("Active checkbox is not checked")
                    .isTrue();
        } else {
            assertThat(emailNotification.isActiveCheckboxChecked())
                    .as("Active checkbox is not unchecked")
                    .isFalse();
        }
    }

}
