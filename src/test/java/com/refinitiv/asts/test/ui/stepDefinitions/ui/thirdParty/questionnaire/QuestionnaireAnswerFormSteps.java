package com.refinitiv.asts.test.ui.stepDefinitions.ui.thirdParty.questionnaire;

import com.refinitiv.asts.core.framework.cucumber.ScenarioCtxtWrapper;
import com.refinitiv.asts.test.ui.constants.Pages;
import com.refinitiv.asts.test.ui.dataproviders.JsonUiDataTransfer;
import com.refinitiv.asts.test.ui.pageActions.thirdParty.questionnaire.QuestionnaireAnswerFormPage;
import com.refinitiv.asts.test.ui.stepDefinitions.ui.BaseSteps;
import com.refinitiv.asts.test.ui.testdatatypes.GenericTestData;
import com.refinitiv.asts.test.ui.testdatatypes.setUp.UserData;
import com.refinitiv.asts.test.ui.testdatatypes.thirdParty.QuestionnaireAnswersData;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.assertj.core.api.SoftAssertions;
import org.testng.asserts.SoftAssert;

import java.util.List;

import static com.refinitiv.asts.test.ui.constants.ContextConstants.QUESTIONNAIRE_ID;
import static com.refinitiv.asts.test.ui.constants.ContextConstants.THIRD_PARTY_DATA_CONTEXT;
import static com.refinitiv.asts.test.ui.constants.PageElementNames.*;
import static com.refinitiv.asts.test.ui.constants.Pages.SLASH;
import static com.refinitiv.asts.test.ui.constants.Pages.THIRD_PARTY;
import static com.refinitiv.asts.test.ui.constants.TestConstants.CHECKED;
import static com.refinitiv.asts.test.ui.constants.TestConstants.*;
import static com.refinitiv.asts.test.ui.dataproviders.DataProvider.QUESTIONNAIRE_ANSWERS;
import static com.refinitiv.asts.test.ui.pageActions.BasePage.URL;
import static com.refinitiv.asts.test.ui.utils.DateUtil.*;
import static com.refinitiv.asts.test.utils.FileUtil.getFilePath;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class QuestionnaireAnswerFormSteps extends BaseSteps {

    private static final String CHECKBOX = "Checkbox";
    private static final String SINGLE_SELECT = "Single Select";
    private static final String MULTI_SELECT = "Multi Select";
    private static final String ENHANCED_TEXT_ENTRY_PLUS = "EnhancedTextEntryPlus";
    private static final String TEXT_ENTRY_PLUS = "TextEntryPlus";
    private static final String NUMBER = "Number";
    private static final String TEXT = "Text";
    private static final String DATE = "Date";
    private static final String ASSESSMENT = "assessment";
    private static final String COMMENT = "comment";
    private final QuestionnaireAnswerFormPage questionnaireAnswerFormPage;

    public QuestionnaireAnswerFormSteps(ScenarioCtxtWrapper context) {
        super(context);
        this.questionnaireAnswerFormPage = new QuestionnaireAnswerFormPage(driver, context, translator);
    }

    @When("User clicks on {string} button while giving an answer on Questionnaire form page")
    public void clickButtonOnQuestionnaireForm(String button) {
        button = questionnaireAnswerFormPage.getFromDictionaryIfExists(button);
        questionnaireAnswerFormPage.clickButton(button);
    }

    @When("User clicks Questionnaire Overall Assessment button {string}")
    public void clickQuestionnaireAssessmentButton(String button) {
        button = questionnaireAnswerFormPage.getFromDictionaryIfExists(button);
        questionnaireAnswerFormPage.waitWhilePreloadProgressbarIsDisappeared();
        questionnaireAnswerFormPage.clickQuestionnaireAnswerButton(button);
    }

    @When("User clicks Comment questionnaire button")
    public void clickCommentQuestionnaireButton() {
        questionnaireAnswerFormPage.clickCommentQuestionnaireButton();
        questionnaireAnswerFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Revision questionnaire button")
    public void clickRevisionButton() {
        questionnaireAnswerFormPage.clickRevisionButton();
        questionnaireAnswerFormPage.waitWhilePreloadProgressbarIsDisappeared();
    }

    @When("User clicks Cancel questionnaire form button")
    public void clickCancelButton() {
        questionnaireAnswerFormPage.clickCancelQuestionnaireFormButton();
    }

    @When("User clicks Questionnaire Details Cancel button")
    public void clickQuestionnaireDetailsCancelButton() {
        questionnaireAnswerFormPage.clickQuestionnaireDetailsCancelButton();
    }

    @When("User fills in Comment text {string}")
    public void fillInCommentText(String text) {
        questionnaireAnswerFormPage.fillInCommentQuestionnaire(text);
    }

    @When("User fills in Reply Comment text {string}")
    public void fillReplyCommentQuestionnaire(String text) {
        questionnaireAnswerFormPage.fillReplyCommentQuestionnaire(text);
    }

    @When("User selects reviewer {string} for Reviewer Flow for level {string}")
    public void fillReplyCommentQuestionnaire(String reviewer, String level) {
        if (context.getScenarioContext().isContains(reviewer)) {
            reviewer = ((UserData) context.getScenarioContext().getContext(reviewer)).getFirstName();
        }
        questionnaireAnswerFormPage.fillReviewerDropdown(level, reviewer);
    }

    @When("User clicks 'Change Reviewer' link")
    public void clickChangeReviewerLink() {
        questionnaireAnswerFormPage.clickChangeReviewerLink();
    }

    @When("User clicks Send comment button")
    public void clickSendCommentButton() {
        questionnaireAnswerFormPage.clickSendCommentQuestionnaireButton();
    }

    @When("User clicks Done comment button")
    public void clickDoneCommentButton() {
        questionnaireAnswerFormPage.clickDoneCommentQuestionnaireButton();
    }

    @When("User clicks Add comment button")
    public void clickAddCommentButton() {
        questionnaireAnswerFormPage.clickAddButton();
    }

    @When("^User clicks button (Cancel|Save) on Questionnaire tab for Reviewer Flow$")
    public void clickReviewerTableButton(String button) {
        questionnaireAnswerFormPage.clickReviewerTableButton(button);
    }

    @When("User selects {string} questionnaire answer option")
    public void selectQuestionnaireAnswerOption(String button) {
        questionnaireAnswerFormPage.clickQuestionnaireOptionButton(button);
    }

    @When("User answers Question {string} on tab {int} with {string} values")
    public void answerQuestion(String questionName, int tabIndex, String answersReference) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        GenericTestData<QuestionnaireAnswersData> answerTestData =
                new JsonUiDataTransfer<QuestionnaireAnswersData>(QUESTIONNAIRE_ANSWERS).getTestData()
                        .get(answersReference);
        switch (questionName) {
            case CURRENCY:
                questionnaireAnswerFormPage.selectDropDownAnswer(tabIndex, CURRENCY,
                                                                 answerTestData.getDataToEnter().getCurrency());
                questionnaireAnswerFormPage.fillInCurrencyAmount(tabIndex, CURRENCY,
                                                                 answerTestData.getDataToEnter().getCurrencyAmount());
                break;
            case CHECKBOX:
                questionnaireAnswerFormPage.checkCheckboxAnswer(tabIndex, CHECKBOX, answerTestData.getDataToEnter()
                        .getCheckboxDefaultName(), answerTestData.getDataToEnter().getChecked());
                break;
            case SINGLE_SELECT:
                questionnaireAnswerFormPage.selectDropDownAnswer(tabIndex, SINGLE_SELECT,
                                                                 answerTestData.getDataToEnter()
                                                                         .getSingleSelectValue());
                break;
            case MULTI_SELECT:
                questionnaireAnswerFormPage.selectDropDownAnswer(tabIndex, MULTI_SELECT,
                                                                 answerTestData.getDataToEnter().getMultiSelectValue());
                break;
            case ENHANCED_TEXT_ENTRY_PLUS:
                questionnaireAnswerFormPage.fillInTextField(tabIndex, ENHANCED_TEXT_ENTRY_PLUS,
                                                            answerTestData.getDataToEnter()
                                                                    .getEnhancedTextFirstNameField(),
                                                            answerTestData.getDataToEnter()
                                                                    .getEnhancedTextFirstNameValue());
                questionnaireAnswerFormPage.fillInTextField(tabIndex, ENHANCED_TEXT_ENTRY_PLUS,
                                                            answerTestData.getDataToEnter()
                                                                    .getEnhancedTextLastNameField(),
                                                            answerTestData.getDataToEnter()
                                                                    .getEnhancedTextLastNameValue());
                break;
            case TEXT_ENTRY_PLUS:
                questionnaireAnswerFormPage.fillInTextField(tabIndex, TEXT_ENTRY_PLUS,
                                                            answerTestData.getDataToEnter()
                                                                    .getTextEntryPlusTextField(),
                                                            answerTestData.getDataToEnter()
                                                                    .getTextEntryPlusTextValue());
                questionnaireAnswerFormPage.fillInTextField(tabIndex, TEXT_ENTRY_PLUS,
                                                            answerTestData.getDataToEnter()
                                                                    .getTextEntryPlusNumberField(),
                                                            answerTestData.getDataToEnter()
                                                                    .getTextEntryPlusNumberValue());
                break;
            case TEXT:
                questionnaireAnswerFormPage.fillInText(tabIndex, answerTestData.getDataToEnter()
                        .getTextValue());
                break;
            case NUMBER:
                questionnaireAnswerFormPage.fillInNumber(tabIndex, answerTestData.getDataToEnter()
                        .getNumberValue());
                break;
            case DATE:
                questionnaireAnswerFormPage.fillInDate(tabIndex, getTodayDate(REACT_FORMAT));
                break;
            default:
                throw new IllegalArgumentException("Incorrect Question type: " + questionName);
        }
    }

    @When("^User answers Question (Boolean|Multiple Choice) on tab (\\d+) with value \"((.*))\"$")
    public void answerQuestionWithValue(String questionName, int tabIndex, String answer) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        questionnaireAnswerFormPage.selectRadioTypeQuestionAnswer(tabIndex, questionName, answer);
    }

    @When("^User (checks|unchecks) Question Checkbox on tab (\\d+) with value \"((.*))\"$")
    public void answerCheckboxQuestion(String status, int tabIndex, String checkboxName) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        if (status.equals(CHECKS)) {
            status = CHECKED;
        } else {
            status = UNCHECKED;
        }
        questionnaireAnswerFormPage.checkCheckboxAnswer(tabIndex, CHECKBOX, checkboxName, status);
    }

    @When("^User answers Question Single Select on tab (\\d+) with value \"((.*))\"$")
    public void answerQuestionDropDownWithValue(int tabIndex, String answer) {
        questionnaireAnswerFormPage.selectDropDownAnswer(tabIndex, SINGLE_SELECT, answer);
    }

    @When("^User answers Question Multi Select on tab (\\d+) with values$")
    public void answerQuestionMultiSelectDropDownWithValues(int tabIndex, List<String> answers) {
        answers.forEach(answer -> questionnaireAnswerFormPage.clickDropDownInputAndSelectOption(tabIndex, MULTI_SELECT,
                                                                                                answer));
    }

    @When("^User searches and selects Question Multi Select on tab (\\d+) with values$")
    public void searchAndSelectQuestionMultiSelectDropDownWithValues(int tabIndex, List<String> answers) {
        answers.forEach(answer -> questionnaireAnswerFormPage.searchAndSelectOption(tabIndex, MULTI_SELECT, answer));
    }

    @When("User clicks '+' to add Assessment for Question {string} on tab {int}")
    public void clickToAddAssessment(String questionName, int tabIndex) {
        questionnaireAnswerFormPage.clickPlusIconForOption(tabIndex, questionName, ASSESSMENT);
        questionnaireAnswerFormPage.clickAddForAssessment();
    }

    @When("User clicks 'edit' icon for Assessment for Question {string} on tab {int}")
    public void clickToEditAssessment(String questionName, int tabIndex) {
        questionnaireAnswerFormPage.clickEditIconForAssessment(tabIndex, questionName, ASSESSMENT);
    }

    @When("User clicks to add Comment for Question {string} on tab {int}")
    public void clickToAddComment(String questionName, int tabIndex) {
        questionnaireAnswerFormPage.clickPlusIconForOption(tabIndex, questionName, COMMENT);
    }

    @When("User fills comment {string} for Question")
    public void fillQuestionComment(String value) {
        questionnaireAnswerFormPage.fillQuestionComment(value);
    }

    @When("User clicks Send Comment button for Question")
    public void clickSendComment() {
        questionnaireAnswerFormPage.clickSendComment();
    }

    @When("User adds comment {string} for Question Assessment")
    public void addCommentForAssessment(String comment) {
        questionnaireAnswerFormPage.addCommentForAssessment(comment);
    }

    @When("User toggles 'Tag as red flag' for Question Assessment")
    public void toggleTagAsRedFlag() {
        questionnaireAnswerFormPage.toggleTagAsRedFlag();
    }

    @When("User clicks Question Assessment Add button")
    public void clickAssessmentAddButton() {
        questionnaireAnswerFormPage.clickAssessmentAddButton();
    }

    @When("User adds Attachment {string} to Question {string} on tab {int}")
    public void addAttachment(String file, String questionName, int tabIndex) {
        questionnaireAnswerFormPage.clickAttachmentButton(tabIndex, questionName);
        String path = getFilePath(file);
        questionnaireAnswerFormPage.uploadAttachment(path);
        questionnaireAnswerFormPage.waitForUploadedAttachmentCrossButtonVisibility();
        questionnaireAnswerFormPage.clickAddAttachmentButton();
    }

    @When("User clicks Answer Questionnaire {string} tab")
    public void clickTab(String tabName) {
        questionnaireAnswerFormPage.clickTab(tabName);
    }

    @When("User clicks Questionnaire Answer Form tab {string}")
    public void clickAnswerFormTab(String tabName) {
        questionnaireAnswerFormPage.clickAnswerFormTab(tabName);
    }

    @When("User clicks Questionnaire Answer comment Reply button")
    public void clickQuestionnaireAnswerCommentReplyButton() {
        questionnaireAnswerFormPage.clickCommentReplyButton();
    }

    @When("^User fills in Currency Amount on tab (\\d+) value \"((.*))\"$")
    public void fillInCurrencyAmount(int tabIndex, String value) {
        questionnaireAnswerFormPage.fillInCurrencyAmount(tabIndex, CURRENCY, value);
    }

    @When("^User fills in Date on tab (\\d+) value \"((.*))\"$")
    public void fillInDate(int tabIndex, String value) {
        questionnaireAnswerFormPage.fillInDate(tabIndex, value);
    }

    @Then("^User (should|shouldn't) see Questionnaire Overall Assessment button \"((.*))\"$")
    public void questionnaireAssessmentButtonsShouldBeVisible(String condition, String button) {
        button = questionnaireAnswerFormPage.getFromDictionaryIfExists(button);
        if (condition.equals(SHOULD)) {
            assertTrue(button + " button is not visible", questionnaireAnswerFormPage.isButtonVisible(button));
        } else {
            assertFalse(button + " button is visible", questionnaireAnswerFormPage.isButtonVisible(button));
        }
    }

    @Then("Overall Assessment confirmation modal appears")
    public void isOverallAssessmentModalDisplayed() {
        String expectedModalHeaderName = "OVERALL ASSESSMENT";
        String expectedModalMessage = "Are you sure you want to approve this questionnaire? This cannot be undone.";
        SoftAssert softAssert = new SoftAssert();
        softAssert.assertTrue(questionnaireAnswerFormPage.isOverallAssessmentModalDisplayed(),
                              "Overall Assessment confirmation modal did not appear!");
        softAssert.assertEquals(questionnaireAnswerFormPage.getOverallAssessmentModalHeader(), expectedModalHeaderName,
                                "Overall Assessment confirmation modal header is incorrect!");
        softAssert.assertEquals(questionnaireAnswerFormPage.getOverallAssessmentModalMessage(), expectedModalMessage,
                                "Overall Assessment confirmation modal message is incorrect!");
        softAssert.assertAll();

    }

    @Then("'Due date' should be today +{int} day(s)")
    public void verifyDueDateIsCorrect(int days) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(questionnaireAnswerFormPage.getQuestionnaireDueDate())
                .as("Due date is not matched with expected one")
                .isEqualTo(getDateAfterTodayDate(REACT_FORMAT, days));
    }

    @Then("Questionnaire details page is displayed")
    public void questionnaireDetailsPageIsDisplayed() {
        assertThat(questionnaireAnswerFormPage.isQuestionnaireDetailsPageDisplayed())
                .as("Questionnaire details page is not displayed")
                .isTrue();
    }

    @Then("Questionnaire PDF is exported successfully")
    public void questionnairePDFIsExportedSuccessfully() {
        questionnaireAnswerFormPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(questionnaireAnswerFormPage.getWindowsHandler().getWindowsNumber())
                .as("PDF file is not exported")
                .isEqualTo(2);
    }

    @Then("Reviewer Flow table for Level {string} has reviewer {string}")
    public void getCurrentReviewer(String level, String reviewer) {
        questionnaireAnswerFormPage.waitWhilePreloadProgressbarIsDisappeared();
        assertThat(questionnaireAnswerFormPage.getCurrentReviewer(level))
                .as("Reviewer Flow table contains incorrect reviewer")
                .contains(reviewer);
    }

    @Then("^Questionnaire Overall Assessment button \"((.*))\" is (disabled|enabled)$")
    public void checkButtonIsDisabled(String button, String state) {
        questionnaireAnswerFormPage.waitWhilePreloadProgressbarIsDisappeared();
        if (state.equals(DISABLED)) {
            assertThat(questionnaireAnswerFormPage.isQuestionnaireButtonDisabled(button)).as(
                    "Questionnaire Answer button %s is not disabled").isTrue();
        } else {
            assertThat(questionnaireAnswerFormPage.isQuestionnaireButtonDisabled(button)).as(
                    "Questionnaire Answer button %s is not enabled").isFalse();
        }
    }

    @Then("Questionnaire Answer Form tab {string} is displayed")
    public void checkTabIsDisplayed(String tabName) {
        assertThat(questionnaireAnswerFormPage.isQuestionnaireAnswerFormTabDisplayed(tabName)).as(
                "%s tab is not displayed", tabName).isTrue();
    }

    @Then("Questionnaire details form contains expected URL")
    public void questionnaireDetailsFormContainsExpectedURL() {
        String thirdPartyId = (String) context.getScenarioContext().getContext(THIRD_PARTY_DATA_CONTEXT);
        String questionnaireId = (String) context.getScenarioContext().getContext(QUESTIONNAIRE_ID);
        String expectedUrl = URL + THIRD_PARTY + SLASH + thirdPartyId + Pages.QUESTIONNAIRE + SLASH + questionnaireId;
        assertThat(driver.getCurrentUrl().replaceAll(HTTPS, HTTP))
                .as("Questionnaire form activity URL is incorrect")
                .contains(expectedUrl);
    }

    @Then("^Questionnaire Change Reviewer link is (not displayed|displayed)$")
    public void questionnaireChangeReviewerLinkIsNotDisplayed(String state) {
        if (state.contains(NOT)) {
            assertThat(questionnaireAnswerFormPage.isChangeReviewerLinkDisplayed())
                    .as("Questionnaire Change Reviewer link is displayed").isFalse();
        } else {
            assertThat(questionnaireAnswerFormPage.isChangeReviewerLinkDisplayed())
                    .as("Questionnaire Change Reviewer link is not displayed").isTrue();
        }
    }

    @Then("Questionnaire answer form comment counter is displayed with value {string}")
    public void commentCounterIsDisplayedWithValue(String expectedValue) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(questionnaireAnswerFormPage.getCommentCounter())
                .as("Questionnaire answer form comment counter is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire answer form comment modal contains comment with text {string}")
    public void commentModalContainsCommentWithText(String expectedValue) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(questionnaireAnswerFormPage.isCommentTextDisplayed(expectedValue))
                .as("Questionnaire answer form comment modal doesn't contain comment text %s", expectedValue)
                .isTrue();
    }

    @Then("Questionnaire answer form comment input is displayed")
    public void commentInputIsDisplayed() {
        assertThat(questionnaireAnswerFormPage.isCommentInputDisplayed())
                .as("Questionnaire answer form comment input is not displayed")
                .isTrue();
    }

    @Then("^Questionnaire answer form comment Send button is (disabled|enabled)$")
    public void commentSendButtonIsDisabled(String state) {
        assertThat(questionnaireAnswerFormPage.isCommentSendButtonDisabled())
                .as("Questionnaire answer form comment Send button is not %s", state)
                .isEqualTo(state.equalsIgnoreCase(DISABLED));
    }

    @Then("Questionnaire answer form comment input max length is {string} symbols")
    public void commentInputMaxLengthIsSymbols(String expectedValue) {
        assertThat(questionnaireAnswerFormPage.getCommentInputMaxLength())
                .as("Questionnaire answer form comment max length is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire answer form Text question input max length is {string} symbols")
    public void textQuestionInputMaxLengthIsSymbols(String expectedValue) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(questionnaireAnswerFormPage.getTextInputMaxLength(0))
                .as("Questionnaire answer form Text question max length is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire answer form Number question input max length is {string} symbols")
    public void numberQuestionInputMaxLengthIsSymbols(String expectedValue) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(questionnaireAnswerFormPage.getNumberInputMaxLength(0))
                .as("Questionnaire answer form Number question max length is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("Questionnaire answer form comment modal is not displayed")
    public void commentModalIsNotDisplayed() {
        assertThat(questionnaireAnswerFormPage.isCommentModalDisplayed())
                .as("Questionnaire answer form comment modal is displayed")
                .isFalse();
    }

    @Then("Questionnaire answer form comment on position {int} contains data")
    public void commentOnPositionContainsData(int position, List<String> expectedData) {
        SoftAssertions softAssertions = new SoftAssertions();
        String commentData = questionnaireAnswerFormPage.getCommentContainerText(position);
        expectedData.forEach(text -> {
            if (text.equals(ACTIVITY_COMMENT_DATE_FORMAT_PDF)) {
                text = getCurrentCommentDateTime(ACTIVITY_COMMENT_DATE_FORMAT_PDF);
            }
            assertThat(commentData)
                    .as("Comment data %s  doesn't contain expected text %s", commentData, text)
                    .contains(text);
        });
        softAssertions.assertAll();
    }

    @Then("Questionnaire answer form comment on position {int} {string} button is enabled")
    public void commentOnPositionButtonIsEnabled(int position, String buttonName) {
        assertThat(questionnaireAnswerFormPage.isCommentButtonDisabled(position, buttonName))
                .as("Comment modal button %s on position %s is not enabled", buttonName, position)
                .isFalse();
    }

    @Then("^Question Checkbox on tab (\\d+) with value \"((.*))\" is (checked|unchecked)$")
    public void verifyCheckboxQuestionStatus(int tabIndex, String checkboxName, String status) {
        assertThat(questionnaireAnswerFormPage.isCheckboxSelected(tabIndex, CHECKBOX, checkboxName))
                .as("Question Checkbox %s is not %s", checkboxName, status)
                .isEqualTo(status.equalsIgnoreCase(CHECKED));
    }

    @Then("^Question (Single Select|Multi Select) answer on tab (\\d+) contains value \"((.*))\"$")
    public void verifyAnswerQuestionDropDownValue(String questionName, int tabIndex, String expectedResult) {
        assertThat(questionnaireAnswerFormPage.getSelectedDropDownValue(tabIndex, questionName))
                .as("Question Single Select selected value is unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("^Question Multi Select answer on tab (\\d+) contains values$")
    public void verifyAnswerQuestionDropDownValues(int tabIndex, List<String> expectedResult) {
        assertThat(questionnaireAnswerFormPage.getSelectedDropDownValues(tabIndex, MULTI_SELECT))
                .as("Question Multi Select selected values are unexpected")
                .isEqualTo(expectedResult);
    }

    @Then("^Question (Boolean|Multiple Choice) on tab (\\d+) with value \"((.*))\" is (checked|unchecked)$")
    public void verifyQuestionCheckboxState(String questionName, int tabIndex, String answer, String status) {
        questionnaireAnswerFormPage.waitWhileSeveralPreloadProgressBarsAreDisappeared();
        assertThat(questionnaireAnswerFormPage.isRadioSelected(tabIndex, questionName, answer))
                .as("Question radio button is not %s", answer)
                .isEqualTo(status.equalsIgnoreCase(CHECKED));
    }

    @Then("^Question Currency Amount on tab (\\d+) value is \"((.*))\"$")
    public void verifyCurrencyAmount(int tabIndex, String expectedValue) {
        assertThat(questionnaireAnswerFormPage.getCurrencyAmount(tabIndex, CURRENCY))
                .as("Question Currency Amount is unexpected")
                .isEqualTo(expectedValue);
    }

    @Then("^Question Date on tab (\\d+) value is \"((.*))\"$")
    public void verifyDate(int tabIndex, String expectedValue) {
        assertThat(questionnaireAnswerFormPage.getDate(tabIndex))
                .as("Question Date is unexpected")
                .isEqualTo(expectedValue);
    }

}